//
//  ValidationService.swift
//  wenovel
//
//  Created by Tbxark on 08/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import WeNovelKit

class ValidationService {
    
    static func validatePhone(_ phone: String, country: String) -> Observable<ValidationResult> {
        return Observable.just(ValidationResult.ok(message: "有效手机"))
    }
    
    static func validateCode(_ code: String) -> Observable<ValidationResult> {
        return Observable.just(ValidationResult.ok(message: "有效验证码"))
    }

}
