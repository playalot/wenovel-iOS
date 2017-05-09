//
//  LoginViewModel.swift
//  wenovel
//
//  Created by Tbxark on 08/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift
import RxCocoa
import WeNovelKit


class OAuthLoginViewModel {
    
    let signedIn: Observable<WNResult<String>>
    
    init(input oauthLoginTap: Observable<WNOAthType>) {
        signedIn = oauthLoginTap.flatMap({ oauthType in
                return WNAuthManager.default.oAuth(type: oauthType)
            })
            .mapToValue(WNResult<String>.success(value: "Login success"))
            .catchError({ Observable.just(WNResult<String>.error(error: $0))})
    }
}


class MobileLoginViewModel {
    
    let validatedPhone: Observable<ValidationResult>
    let validatedVerification: Observable<ValidationResult>
    let signedIn: Observable<WNResult<String>>

    init(input: (
        country: Observable<String>,
        phone: Observable<String>,
        verification: Observable<String>,
        mobileLoginTap: Observable<Void>
        )) {
        
        let countryAndPhone = Observable.combineLatest(input.country, input.phone) { ($0, $1) }
        
        validatedPhone = countryAndPhone.flatMap({ p, c in ValidationService.validatePhone(p, country: c) })
        validatedVerification = input.verification.flatMap({ c in ValidationService.validateCode(c)})
        let mobileLoginDriver = Observable.combineLatest(input.country, input.phone, input.verification, resultSelector: { c, p, v in (c, p, v) })
            .flatMap({ c, p , v in WNAuthManager.default.mobile(country: c, phone: p, code: v)})
            .mapToWNResult(success: "Login success", error: "Login error")

        signedIn = mobileLoginDriver
    }
}
