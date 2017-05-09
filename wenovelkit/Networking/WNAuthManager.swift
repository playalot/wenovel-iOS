//
//  WNAuthManager.swift
//  wenovel
//
//  Created by Tbxark on 05/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import NetworkService
import CacheService
import Simplicity
import ObjectMapper


public enum WNOAthType: String {
    case facebook  = "facebook"
}

public class WNAuthManager {
    static public let `default` = WNAuthManager()
    static var token: String? {
        return WNAuthManager.default.auth?.accessToken
    }
    private let keychainCache = KeychainCache(name: "com.play.wenovel.auth")
    private let userdefaultCache = UserDefaultsCache(name: "com.play.wenovel.auth")
    private var auth: WNAuthRespone? {
        didSet {
            authChangeSubject.on(.next(auth?.accessToken != nil))
        }
    }
    private let authChangeSubject = PublishSubject<Bool>()
    
    
    
    public var isAuth: Bool {
        return auth?.accessToken != nil
    }
    public var authChangeObservable: Observable<Bool> {
        return authChangeSubject.asObservable()
    }
    private init() {}
    
    public func logout() {
        auth = nil
        let k = keychainCache?.syncCache(value: CacheableValue.string(value: ""), forKey: "auth") ?? false
        let u = userdefaultCache?.syncCache(value: "", forKey: "auth") ?? false
        print("KeyChain Cache Result: \(k), UserDefault Cache Result: \(u)")
    }
    
    
    public func readCache() -> Bool {
        guard let s: String = keychainCache?.syncReadCache(forKey: "auth")?.stringValue() ?? userdefaultCache?.syncReadCache(forKey: "auth") as? String else { return false}
        guard let model = Mapper<WNAuthRespone>().map(JSONString: s) else { return false }
        guard let date = model.expires, date.timeIntervalSinceNow > 600 else { return  false}
        auth = model
        return true
    }
    
    public func mobile(country: String, phone: String, code: String) -> Observable<Void> {
        let signal: Observable<WNAuthRespone> =  WNNetworking.modelNetRequest(WNRequest.Admin.mobileLogin(country: country, phone: phone, code: code))
        return signal.do(onNext: { respone in
            guard let json = respone.toJSONString() else { return }
            self.keychainCache?.asnycCache(value: CacheableValue.string(value: json), forKey: "auth", complete: nil)
            self.userdefaultCache?.asnycCache(value: json, forKey: "auth", complete: nil)
        })
        .map({ _ in return () })

    }
    
    public func oAuth(type: WNOAthType) -> Observable<Void>  {
        func _oAuth(type: WNOAthType) -> Observable<(id: String, token: String)> {
            switch type {
            case .facebook:
                return Observable.create({
                    (observer: AnyObserver<(id: String, token: String)> ) -> Disposable in
                    Facebook().login({ (token: String?, error: NSError?) in
                        guard let t = token else {
                            observer.on(.error(error ?? WNBuildError(code: -1, reson: "Facebook login error")))
                            return
                        }
                        observer.on(.next("",t))
                    })
                    return Disposables.create()
                })
            }
        }
        return _oAuth(type: type)
            .flatMap { (id: String, token: String) -> Observable<WNAuthRespone> in
                return WNNetworking.modelNetRequest(WNRequest.Admin.oauthLogin(type: type.rawValue, uuid: id, token: token))
                    .do(onNext: { respone in
                        guard let json = respone.toJSONString() else { return }
                        let k = self.keychainCache?.syncCache(value: CacheableValue.string(value: json), forKey: "auth") ?? false
                        let u = self.userdefaultCache?.syncCache(value: json, forKey: "auth") ?? false
                        print("KeyChain Cache Result: \(k), UserDefault Cache Result: \(u)")
                        self.auth = respone
                    })
            }
            .map({ _ in return () })
    }
}



