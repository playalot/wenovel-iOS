//
//  SendViewModel.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import WeNovelKit


protocol NovelSendTempCache {
    func cacheNovel(title: String?, content: String?, id: String) -> Bool
    func readCache(id: String) -> (title: String?, content: String?)?
}


class SendStartViewModel {
    
    let readCache: Observable<(title: String?, content: String?)>
    let sendNovel: Observable<WNResult<String>>
    let cacheNovel: Observable<WNResult<String>>
    
    init(input: (title: Observable<String>,
        content: Observable<String>,
        saveCache: Observable<Void>,
        readCache: Observable<Void>,
        send: Observable<Void>),
         dependency cache: NovelSendTempCache) {
        
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
            .flatMap({ q, o in
                return WNNetworking.netDefaultRequest(WNRequest.Novel.newNovel(req: q, option: o))
                .mapToType(success: "New story send success", error: "Error")
            })
        
    }
}

class SendNodeViewModel {

    let readCache: Observable<(title: String?, content: String?)>
    let sendNovel: Observable<WNResult<String>>
    let cacheNovel: Observable<WNResult<String>>
    
    
    init(input: (id: String,
        content: Observable<String>,
        saveCache: Observable<Void>,
        readCache: Observable<Void>,
        send: Observable<Void>),
         dependency cache: NovelSendTempCache) {
        
        readCache = input.readCache.flatMap({ _ -> Observable<(title: String?, content: String?)> in
            if let c = cache.readCache(id: "start") {
                return Observable.just(c)
            } else {
                return Observable.error(NSError.build(desc: "Cache not found"))
            }
        })
        
        cacheNovel = Observable.combineLatest(input.saveCache,input.content, resultSelector: { _, c in (input.id, c)})
            .map({ t,c in cache.cacheNovel(title: t, content: c, id: "Node")})
            .map({ success in success ? WNResult.success(value: "Cache success") : WNResult.error(error: NSError.build(desc: "Cache error")) })
        
        sendNovel = Observable.combineLatest(input.send, input.content, resultSelector: { _, c in (input.id, c)})
            .map({ i, c in (i, WNNovelRequest(title: nil, content: c))})
            .flatMap({ i, c in
                return WNNetworking.netDefaultRequest(WNRequest.Novel.continueNovel(id: i, req: c))
                .mapToType(success: "New story send success", error: "Error")
            })
        
    }

}


