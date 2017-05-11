//
//  NovelListViewModel.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import WeNovelKit


protocol NovelListViewModel {
    var novelData: [WNNovelNode] { get }
    var novelSignal: Observable<[WNNovelNode]> { get }
    func loadNovel(forNew isNew: Bool) -> Observable<[WNNovelNode]>
}


protocol NovelRenderProtocol {
}


class NovelFeedViewModel: NovelListViewModel, ContainerViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let novelVariable = Variable<[WNNovelNode]>([])
    var page: Int = 0
    
    var novelData: [WNNovelNode] { return novelVariable.value }
    var novelSignal: Observable<[WNNovelNode]> { return novelVariable.asObservable()}
    
    init(input refresh:  Observable<Bool>, dependency render: NovelRenderProtocol) {
        refresh.flatMap({  isNew in
            return self.loadNovel(forNew: isNew)
                .mapToResult(error: "Load Error")
            })            
            .subscribe(onNext: {[weak self] (res: WNResult<[WNNovelNode]>) in
                switch res {
                case .success(let value):
                    self?.novelVariable.value = value
                case .error(let error):
                    print(error.localizedDescription ?? "")
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func loadNovel(forNew isNew: Bool) -> Observable<[WNNovelNode]> {
        return WNNetworking.modelArrayNetRequest(WNRequest.Novel.home(page: changePage(forNew: isNew)), key: "nodes")
            .map({ (data: [WNNovelNode]) -> [WNNovelNode] in
                var current = isNew ? [WNNovelNode]() : self.novelVariable.value
                current.append(contentsOf: data)
                return current
            })
            .do(onNext: { data in
                self.novelVariable.value = data
            }, onError: { error  in
                self.resetPageWhenError(forNew: isNew)
            })
    }

}



class NovelNodeFeedViewModel: NovelListViewModel, ContainerViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let currentNode: OptionalVariable<WNNovelNode>
    private let novelVariable = Variable<[WNNovelNode]>([])
    var page: Int = 0
    
    var nodeData: WNNovelNode? { return currentNode.value }
    var novelData: [WNNovelNode] { return novelVariable.value }
    var nodeChange: Observable<WNNovelNode> { return  currentNode.asObservable() }
    var novelSignal: Observable<[WNNovelNode]> { return novelVariable.asObservable()}
    
    init(input: (node: WNNovelNode?,
        refresh:  Observable<Bool>),
         dependency render: NovelRenderProtocol) {
        
        currentNode = OptionalVariable<WNNovelNode>(input.node)
        
        input.refresh.flatMap({ isNew in
            return self.loadNovel(forNew: isNew)
                .mapToResult(error: "Load error")
            })
            .subscribe(onNext: {[weak self] (res: WNResult<[WNNovelNode]>) in
                switch res {
                case .success(let value):
                    self?.novelVariable.value = value
                case .error(let error):
                    print(error.localizedDescription ?? "")
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func loadNovel(forNew isNew: Bool) -> Observable<[WNNovelNode]> {
        return WNNetworking.modelArrayNetRequest(WNRequest.Novel.home(page: changePage(forNew: isNew)), key: "nodes")
            .map({ (data: [WNNovelNode]) -> [WNNovelNode] in
                var current = isNew ? [WNNovelNode]() : self.novelVariable.value
                current.append(contentsOf: data)
                return current
            })
            .do(onNext: { data in
                self.novelVariable.value = data
            }, onError: { error  in
                self.resetPageWhenError(forNew: isNew)
            })
    }
}
