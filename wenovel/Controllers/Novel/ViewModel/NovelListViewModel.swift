//
//  NovelListViewModel.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import WeNovelKit


typealias NovelListElement = NovelRenderModel
typealias NovelListRefreshResult = (Bool, WNResult<[NovelListElement]>)
typealias RequestBuilder = (Int) -> (WNRequestType)


protocol NovelListViewModel {
    var novelData: [NovelListElement] { get }
    var novelSignal: Observable<[NovelListElement]> { get }
    var reloadNovel: Observable<WNResult<Int>> { get }
}

class NovelBaseContainer: NovelListViewModel, ContainerViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let novelVariable = Variable<[NovelListElement]>([])
    private let reloadNovelSubject = PublishSubject<WNResult<Int>>()

    var page: Int = 0
    
    var reloadNovel: Observable<WNResult<Int>>  { return reloadNovelSubject.asObservable() }
    var novelData: [NovelListElement] { return novelVariable.value }
    var novelSignal: Observable<[NovelListElement]> { return novelVariable.asObservable()}
    
    init(input: (refresh:  Observable<Bool>, like: Observable<(Bool, WNNovelNode)>),
         dependency: (render: NovelRenderProtocol, request: RequestBuilder)) {
        
        
        input.like
            .flatMap {[weak self] (isLike: Bool, node: WNNovelNode) -> Observable<WNResult<Int>> in
                guard let `self` = self, let id = node.id else {
                    return Observable.just(WNResult<Int>.error(error: NSError.build(desc: "Missing Id")))
                }
                let index = self.novelData.index(where: { (render: NovelRenderModel) -> Bool in
                    return render.data == node
                })
                guard let i = index else {
                    return Observable.just(WNResult<Int>.error(error: NSError.build(desc: "Data not found")))
                }
                var data = self.novelVariable.value[i].data
                data.changLikeState(like: isLike)
                self.novelVariable.value[i].forceChangeData(data: data)
                let req = isLike ? WNRequest.Novel.like(id: id) : WNRequest.Novel.dislike(id: id)
                return WNNetworking.netDefaultRequest(req)
                    .mapToValue(WNResult<Int>.success(value: i),
                                valueOnError: WNResult<Int>.success(value: i))
            }.subscribe {[weak self] event in
                self?.reloadNovelSubject.on(event)
            }
            .addDisposableTo(disposeBag)
        
        
        
        input.refresh.flatMap({[weak self]  isNew -> Observable<NovelListRefreshResult> in
            let req = dependency.request(self?.changePage(forNew: isNew) ?? 0)
            let netReq: Observable<[WNNovelNode]> = WNNetworking.modelArrayNetRequest(req, key: "nodes")
            return netReq.map(dependency.render.render)
                .mapToResult(error: "Load fail")
                .map({ (isNew, $0) })
            })
            .subscribe(onNext: {[weak self] (isNew, res) in
                guard let `self` = self else { return }
                switch res {
                case .success(let value):
                    var data = isNew ? [NovelListElement]() : self.novelVariable.value
                    data.append(contentsOf: value)
                    self.novelVariable.value = data
                case .error(let error):
                    self.resetPageWhenError(forNew: isNew)
                    print(error.localizedDescription ?? "")
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    
}


class NovelFeedViewModel: NovelBaseContainer {

    init(input: (refresh:  Observable<Bool>, like: Observable<(Bool, WNNovelNode)>),
         dependency render: NovelRenderProtocol) {
        super.init(input: input, dependency: (render: render, request: { WNRequest.Novel.home(page: $0) }))
    }
}



class NovelNodeFeedViewModel: NovelBaseContainer {

    private let currentNode: OptionalVariable<WNNovelNode>
    var nodeData: WNNovelNode? { return currentNode.value }
    var nodeChange: Observable<WNNovelNode> { return  currentNode.asObservable() }
    
    init(input: (node: WNNovelNode?, refresh:  Observable<Bool>, like: Observable<(Bool, WNNovelNode)>),
         dependency render: NovelRenderProtocol) {
        currentNode = OptionalVariable<WNNovelNode>(input.node)
        super.init(input: (input.refresh ,input.like),
                   dependency: (render: render, request: { WNRequest.Novel.home(page: $0) }))
    }
    
}
