//
//  SendViewModel.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import WeNovelKit


protocol SendTempCache {
    func cacheNovel(title: String?, content: String?, id: String) -> Bool
    func readCache(id: String) -> (title: String?, content: String?)?
}


class SendStartViewModel {
    

    
    private let disposeBag = DisposeBag()
    let readCache: Observable<(title: String?, content: String?)>
    let sendNovel: Observable<WNResult<String>>
    let cacheNovel: Observable<WNResult<String>>
    
    init(input: (title: Observable<String>,
        content: Observable<String>,
        saveCache: Observable<Void>,
        readCache: Observable<Void>,
        send: Observable<Void>),
         dependency cache: SendTempCache) {
        
        readCache = input.readCache.flatMap({ _ -> Observable<(title: String?, content: String?)> in
            if let c = cache.readCache(id: "start") {
                return Observable.just(c)
            } else {
                return Observable.error(NSError.build(desc: "Cache not found"))
            }
        })
        
        cacheNovel = Observable.combineLatest(input.saveCache, input.title, input.content, resultSelector: { _, t, c in (t, c)})
            .map({ t,c in cache.cacheNovel(title: t, content: c, id: "start")})
            .map({ success in success ? WNResult.success(value: "Cache success") : WNResult.error(error: NSError.build(desc: "Cache error")) })
        
        sendNovel = Observable.combineLatest(input.send, input.title, input.content, resultSelector: { _, t, c in (t, c)})
            .map({ t, c in (WNNovelRequest(title: t, content: c), WNNovelOption())})
            .flatMap({ q, o in  WNNetworking.netDefaultRequest(WNRequest.Novel.newNovel(req: q, option: o)) })
            .mapToWNResult(success: "New story send success", error: "Error")
        
        
    }
    
}



