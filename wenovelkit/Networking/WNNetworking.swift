//
//  WNNetworking.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import NetworkService
import ObjectMapper
import RxSwift



public enum WNResult<T> {
    case success(value: T)
    case error(error: Error)
    public func isSuccess() -> Bool {
        switch self {
        case .success(_): return true
        default: return false
        }
    }
}

public struct WNHTTPResponseModel: HTTPResponseModel {
    public var code: Int?
    public var message: String?
    public var data: Any?
    public var isSuccess: Bool { return true }
    
    public init?(map: Map) {}
    public mutating func mapping(map: Map) {
        code <- map["error.code"]
        message <- map["error.message"]
        data <- map["data"]
    }
}

public struct WNRequest {
    
    public enum Admin: RequestParameters {
        
        /// 刷新 Token
        case refreshToken
        /// 七牛 Token
        case uploadToken
        /// 手机登录
        case mobileLogin(country: String, phone: String, code: String)
        /// 第三方登录
        case oauthLogin(type: String, uuid: String, token: String)
        
        public func toRequestEntity() -> RequestEntity {
            switch self {
            case .refreshToken:
                return RequestEntity(POST: "auth/refreshToken")
            case .uploadToken:
                return RequestEntity(GET: "auth/uploadToken")
            case .mobileLogin(let country, let phone, let code):
                return RequestEntity(POST: "authenticate/mobile")
                    .addDictBody(["country": country,
                                  "phone": phone,
                                  "code": code])
            case .oauthLogin(let type, let uuid, let token):
                return RequestEntity(POST: "authenticate/\(type)")
                    .addDictBody(["uid": uuid,
                                  "accessToken": token])
            }
        }
    }
    
    
    public enum Novel: RequestParameters {
        /// 首页
        case home(page: Int)
        
        /// 点赞
        case like(id: String)
        /// 取消点赞
        case dislike(id: String)
        
        
        /// 发送评论
        case sendComment(id: String, comment: WNCommentRequest)
        /// 评论列表
        case comments(id: String, page: String)
        /// 删除评论
        case deleteComment(id: String, commentId: String)
        
        /// 发送新开头
        case newNovel(req: WNNovelRequest, option: WNNovelOption)
        /// 续写文章
        case continueNovel(id: String, req: WNNovelRequest)
        
        
        public func toRequestEntity() -> RequestEntity {
            switch self {
            case .home(let page):
                return RequestEntity(GET: "novel/home")
                .addQuery("page", value: page)
                
            case .like(let id):
                return RequestEntity(POST: "novel/like")
                .addDictBody(["id": id])
            case .dislike(let id):
                return RequestEntity(DELETE: "novel/like")
                    .addDictBody(["id": id])
            
            case .sendComment(let id, let comment):
                return RequestEntity(POST: "novel/\(id)/comment")
                    .addMapBody(comment)
            case .comments(let id, let page):
                return RequestEntity(GET: "novel/\(id)/comments")
                    .addQuery("page", value: page)
            case .deleteComment(let id, let commentId):
                return RequestEntity(DELETE: "story/\(id)/comment/\(commentId)")
                
            case .newNovel(let req, let option):
                return RequestEntity(POST: "story")
                    .addMapBody(req)
                    .addMapBody(option, forKey: "option")
            case .continueNovel(let id, let req):
                return RequestEntity(POST: "story/\(id)/continue")
                    .addMapBody(req)
            }
        }
    }
    
    
    public enum User: RequestParameters {
        /// 用户信息
        case info(id: String)
        
        public func toRequestEntity() -> RequestEntity {
            switch self {
            case .info(let id):
                return RequestEntity(GET: "user/\(id)")
            }
        }
    }
}


public typealias WNNetRequestErrorHandle = (URLRequest, Error) -> Void
public final class WNNetworking: RequestManager {
    public static let `default` = WNNetworking()

    fileprivate let client: NetworkClient<WNHTTPResponseModel>
    public var noAuthErrorHandle: WNNetRequestErrorHandle?
    public var commonErrorHandle: WNNetRequestErrorHandle?
    
    private init() {
        let config = NetworkClientConfig(name: "WeNovelNetWorking", schema: "http", host: "52.197.229.254", port: 4400)
        client = NetworkClient<WNHTTPResponseModel>(config: config)
        _ = client.setRequestManager(self)
        
    }
    
    public func configure(request: URLRequest) -> URLRequest {
        var req = request
        req.setValue(WNAuthManager.token, forHTTPHeaderField: "X-Auth-Token")
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


public extension WNNetworking {
    public static func modelNetRequest<T:Mappable>(_ type: RequestParameters, key: String? = nil) -> Observable<T> {
        return WNNetworking.default.client.modelNetRequest(type, key: key)
    }
    
    public static func modelArrayNetRequest<T:Mappable>(_ type: RequestParameters, key: String? = nil) -> Observable<[T]> {
        return WNNetworking.default.client.modelArrayNetRequest(type, key: key)
    }
    
    public static func netRequest<T>(_ type: RequestParameters, transform: @escaping ((Any) -> (T?))) -> Observable<(T)> {
        return WNNetworking.default.client.netRequest(type, transform: transform)
    }
    
    public static func netDefaultRequest(_ type: RequestParameters) -> Observable<Any> {
        return WNNetworking.default.client.netDefaultRequest(type)
    }
}

