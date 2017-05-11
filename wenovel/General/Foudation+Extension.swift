//
//  Foudation+Extension.swift
//  wenovel
//
//  Created by Tbxark on 08/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import WeNovelKit

extension Error {
    public var localizedDescription: String? {
        return (self as NSError).userInfo[NSLocalizedDescriptionKey] as? String
    }
}


extension NSError {
    public static func build(code: Int = -1, desc: String) -> NSError {
        return NSError.init(domain: "com.play.wenovel", code: code, userInfo: [NSLocalizedDescriptionKey: desc])
    }

}




extension Observable {
    
    
    public func mapToValue<R>(_ value: R) -> Observable<R> {
        return self.map({ _ in
            return value
        })
    }
    
    public func mapToValue<R>(_ value: R, valueOnError eValue: R) -> Observable<R> {
        return self.map({ _ in
            return value
        }).catchErrorJustReturn(eValue)
    }
    
    
    public func mapToResult(error: String) -> Observable<WNResult<Element>> {
        return self.map({ element -> WNResult<Element> in
                return WNResult<Element>.success(value: element)
            })
            .catchError({ e -> Observable<WNResult<Element>> in
                let res = WNResult<Element>.error(error: e)
                return Observable<WNResult<Element>>.just(res)
            })
    }
    
    
    public func mapToType<T>(success: T, error: T) -> Observable<WNResult<T>> {
        return self.map({ _ -> WNResult<T> in
                return WNResult<T>.success(value: success)
            })
            .catchError({ e -> Observable<WNResult<T>> in
                let res = WNResult<T>.error(error: e)
                return Observable<WNResult<T>>.just(res)
            })
    }
    
   
}

