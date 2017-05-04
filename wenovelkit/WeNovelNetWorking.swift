//
//  WeNovelNetWorking.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import NetworkService
import ObjectMapper
import RxSwift


public struct WNHTTPResponseModel: HTTPResponseModel {
    public var code: Int = -1
    public var message: String?
    public var data: Any?
    public var isSuccess: Bool { return code == 1 }
    
    public init?(map: Map) {}
    public mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

public enum WHAdminRequest: RequestParameters {
    case login(account: String, password: String)
    
    public func toRequestEntity() -> PLRequestEntity {
        switch self {
        case .login(let account, let password):
            return PLRequestEntity(POST: "login")
                .addDictBody(["account": account, "password": password])
        }
    }
}


public typealias WNNetRequestErrorHandle = (URLRequest, Error) -> Void
public final class WeNovelNetWorking: RequestManager {
    public static let `default` = WeNovelNetWorking()

    internal unowned let client: NetworkClient<WNHTTPResponseModel>
    private var authToken: String?
    public var noAuthErrorHandle: WNNetRequestErrorHandle?
    public var commonErrorHandle: WNNetRequestErrorHandle?
    
    private init() {
        let config = NetworkClientConfig(name: "WeNovelNetWorking", schema: "https://", host: "tbxark.site")
        client = NetworkClient<WNHTTPResponseModel>(config: config)
        _ = client.setRequestManager(self)
        
    }
    
    public func configure(request: URLRequest) -> URLRequest {
        var req = request
        req.setValue(authToken, forHTTPHeaderField: "X-Auth-Token")
        return req
    }
    
    public func errorHandle(request: URLRequest, error: Error?) {
        guard let e = error as NSError? else { return }
        switch e.code {
        case 401:
            noAuthErrorHandle?(request, e)
        default:
            commonErrorHandle?(request, e)
        }
    }
}


public extension WeNovelNetWorking {
    static func auth(account: String, password: String) -> Observable<WNAuthRespone> {
        return WeNovelNetWorking.default.client
            .modelNetRequest(WHAdminRequest.login(account: account, password: password))
    }
}

