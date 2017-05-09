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
    
    
    public func mapToWNResult(success: String, error: String) -> Observable<WNResult<String>> {
        return self.map({ _ -> WNResult<String> in
                return WNResult<String>.success(value: success)
            })
            .catchError({ e -> Observable<WNResult<String>> in
                let res = WNResult<String>.error(error: e)
                return Observable<WNResult<String>>.just(res)
            })
    }
    
   
}
