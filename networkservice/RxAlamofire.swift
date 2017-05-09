//
//  RxAlamofire.swift
//  PlayKit
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//


import Foundation
import Alamofire
import RxSwift
import RxCocoa

// MARK: NSURLSession extensions

extension Reactive where Base: URLSession {
    
    func json(_ method: Alamofire.HTTPMethod,
                     _ url: URLConvertible,
                     parameters: [String: Any]? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil) -> Observable<Any> {
        do {
            let request = try RxAlamofire.urlRequest(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
            return json(request: request)
        } catch let error {
            return Observable.error(error)
        }
    }
    
    func response(method: Alamofire.HTTPMethod,
                         _ url: URLConvertible,
                         parameters: [String: Any]? = nil,
                         encoding: ParameterEncoding = URLEncoding.default,
                         headers: [String: String]? = nil) -> Observable<(HTTPURLResponse, Data)> {
        do {
            let request = try RxAlamofire.urlRequest(method,
                                                     url,
                                                     parameters: parameters,
                                                     encoding: encoding,
                                                     headers: headers)
            return response(request: request)
        } catch let error {
            return Observable.error(error)
        }
    }
    
    func data(_ method: Alamofire.HTTPMethod,
                     _ url: URLConvertible,
                     parameters: [String: AnyObject]? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil) -> Observable<Data> {
        do {
            let request = try RxAlamofire.urlRequest(method,
                                                     url,
                                                     parameters: parameters,
                                                     encoding: encoding,
                                                     headers: headers)
            return data(request: request)
        } catch let error {
            return Observable.error(error)
        }
    }
}


struct RxAlamofire {
    
    // MARK: Convenience functions
    
    static func urlRequest(_ method: Alamofire.HTTPMethod,
                                  _ url: URLConvertible,
                                  parameters: [String: Any]? = nil,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: [String: String]? = nil)
        throws -> Foundation.URLRequest {
            var mutableURLRequest = Foundation.URLRequest(url: try url.asURL())
            mutableURLRequest.httpMethod = method.rawValue
            
            if let headers = headers {
                for (headerField, headerValue) in headers {
                    mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
                }
            }
            
            if let parameters = parameters {
                mutableURLRequest = try encoding.encode(mutableURLRequest, with: parameters)
            }
            
            return mutableURLRequest
    }
    
    // MARK: Request
    
    static func request(_ method: Alamofire.HTTPMethod,
                               _ url: URLConvertible,
                               parameters: [String: Any]? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: [String: String]? = nil)
        -> Observable<DataRequest> {
            return Alamofire.SessionManager.default.rx.request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    // MARK: data
    
    static func requestData(_ method: Alamofire.HTTPMethod,
                                   _ url: URLConvertible,
                                   parameters: [String: Any]? = nil,
                                   encoding: ParameterEncoding = URLEncoding.default,
                                   headers: [String: String]? = nil)
        -> Observable<(HTTPURLResponse, Data)> {
            return Alamofire.SessionManager.default.rx.responseData(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    static func data(_ method: Alamofire.HTTPMethod,
                            _ url: URLConvertible,
                            parameters: [String: Any]? = nil,
                            encoding: ParameterEncoding = URLEncoding.default,
                            headers: [String: String]? = nil)
        -> Observable<Data> {
            return Alamofire.SessionManager.default.rx.data(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    // MARK: string
    
    static func requestString(_ method: Alamofire.HTTPMethod,
                                     _ url: URLConvertible,
                                     parameters: [String: Any]? = nil,
                                     encoding: ParameterEncoding = URLEncoding.default,
                                     headers: [String: String]? = nil)
        -> Observable<(HTTPURLResponse, String)> {
            return Alamofire.SessionManager.default.rx.responseString(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    
    static func string(_ method: Alamofire.HTTPMethod,
                              _ url: URLConvertible,
                              parameters: [String: Any]? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: [String: String]? = nil)
        -> Observable<String> {
            return Alamofire.SessionManager.default.rx.string(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    // MARK: JSON
    
    static func requestJSON(_ method: Alamofire.HTTPMethod,
                                   _ url: URLConvertible,
                                   parameters: [String: Any]? = nil,
                                   encoding: ParameterEncoding = URLEncoding.default,
                                   headers: [String: String]? = nil)
        -> Observable<(HTTPURLResponse, Any)> {
            return Alamofire.SessionManager.default.rx.responseJSON(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    static func json(_ method: Alamofire.HTTPMethod,
                            _ url: URLConvertible,
                            parameters: [String: Any]? = nil,
                            encoding: ParameterEncoding = URLEncoding.default,
                            headers: [String: String]? = nil)
        -> Observable<Any> {
            return Alamofire.SessionManager.default.rx.json(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    // MARK: Upload
    
    static func upload(_ file: URL, urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        return Alamofire.SessionManager.default.rx.upload(file, urlRequest: urlRequest)
    }
    
    
    static func upload(_ data: Data, urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        return Alamofire.SessionManager.default.rx.upload(data, urlRequest: urlRequest)
    }
    
    static func upload(_ stream: InputStream, urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        return Alamofire.SessionManager.default.rx.upload(stream, urlRequest: urlRequest)
    }
    
    // MARK: Download
    
    static func download(_ urlRequest: URLRequestConvertible,
                                to destination: @escaping DownloadRequest.DownloadFileDestination) -> Observable<DownloadRequest> {
        return Alamofire.SessionManager.default.rx.download(urlRequest, to: destination)
    }
    
    // MARK: Resume Data
    
    static func download(resumeData: Data,
                                to destination: @escaping DownloadRequest.DownloadFileDestination) -> Observable<DownloadRequest> {
        return Alamofire.SessionManager.default.rx.download(resumeData: resumeData, to: destination)
    }
    
}


// MARK: Manager - Extension of Manager

extension Alamofire.SessionManager: ReactiveCompatible {
}

protocol RxAlamofireRequest {
    
    func responseWith(completionHandler: @escaping (RxAlamofireResponse) -> Void)
    
    func resume()
    
    func cancel()
}

protocol RxAlamofireResponse {
    var error: Error? { get }
}

extension DefaultDataResponse: RxAlamofireResponse {
}

extension DefaultDownloadResponse: RxAlamofireResponse {
}

extension DataRequest: RxAlamofireRequest {
    func responseWith(completionHandler: @escaping (RxAlamofireResponse) -> Void) {
        response { (response) in
            completionHandler(response)
        }
    }
}

extension DownloadRequest: RxAlamofireRequest {
    func responseWith(completionHandler: @escaping (RxAlamofireResponse) -> Void) {
        response { (response) in
            completionHandler(response)
        }
    }
}


extension Reactive where Base: Alamofire.SessionManager {
    
    // MARK: Generic request convenience
    
    func request<R:RxAlamofireRequest>(_ createRequest: @escaping (Alamofire.SessionManager) throws -> R) -> Observable<R> {
        return Observable.create { observer -> Disposable in
            let request: R
            do {
                request = try createRequest(self.base)
                observer.on(.next(request))
                request.responseWith(completionHandler: { (response) in
                    if let error = response.error {
                        observer.onError(error)
                    } else {
                        observer.on(.completed)
                    }
                })
                
                if !self.base.startRequestsImmediately {
                    request.resume()
                }
                
                return Disposables.create {
                    request.cancel()
                }
            } catch let error {
                observer.on(.error(error))
                return Disposables.create()
            }
        }
    }
    
    func request(_ method: Alamofire.HTTPMethod,
                        _ url: URLConvertible,
                        parameters: [String: Any]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil
        )
        -> Observable<DataRequest> {
            return request { manager in
                return manager.request(url,
                                       method: method,
                                       parameters: parameters,
                                       encoding: encoding,
                                       headers: headers)
            }
    }
    
    
    func request(urlRequest: URLRequestConvertible)
        -> Observable<DataRequest> {
            return request { manager in
                return manager.request(urlRequest)
            }
    }
    
    // MARK: data
    
    func responseData(_ method: Alamofire.HTTPMethod,
                             _ url: URLConvertible,
                             parameters: [String: Any]? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: [String: String]? = nil
        )
        -> Observable<(HTTPURLResponse, Data)> {
            return request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
                ).flatMap {
                    $0.rx.responseData()
            }
    }
    
    func data(_ method: Alamofire.HTTPMethod,
                     _ url: URLConvertible,
                     parameters: [String: Any]? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil
        )
        -> Observable<Data> {
            return request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
                ).flatMap {
                    $0.rx.data()
            }
    }
    
    // MARK: string
    
    func responseString(_ method: Alamofire.HTTPMethod,
                               _ url: URLConvertible,
                               parameters: [String: Any]? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: [String: String]? = nil
        )
        -> Observable<(HTTPURLResponse, String)> {
            return request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
                ).flatMap {
                    $0.rx.responseString()
            }
    }
    
    func string(_ method: Alamofire.HTTPMethod,
                       _ url: URLConvertible,
                       parameters: [String: Any]? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: [String: String]? = nil
        )
        -> Observable<String> {
            return request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
                )
                .flatMap { (request) -> Observable<String> in
                    return request.rx.string()
            }
    }
    
    // MARK: JSON
    
    func responseJSON(_ method: Alamofire.HTTPMethod,
                             _ url: URLConvertible,
                             parameters: [String: Any]? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: [String: String]? = nil
        )
        -> Observable<(HTTPURLResponse, Any)> {
            return request(method,
                           url,
                           parameters: parameters,
                           encoding: encoding,
                           headers: headers
                ).flatMap {
                    $0.rx.responseJSON()
            }
    }
    
    
    func json(_ method: Alamofire.HTTPMethod,
                     _ url: URLConvertible,
                     parameters: [String: Any]? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil
        )
        -> Observable<Any> {
            return request(
                method,
                url,
                parameters: parameters,
                encoding: encoding,
                headers: headers
                ).flatMap {
                    $0.rx.json()
            }
    }
    
    // MARK: Upload
    
    func upload(_ file: URL, urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        
        return request { manager in
            return manager.upload(file, with: urlRequest)
        }
    }
    
    
    func upload(_ data: Data, urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        return request { manager in
            return manager.upload(data, with: urlRequest)
        }
    }
    
    func upload(_ stream: InputStream,
                       urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        return request { manager in
            return manager.upload(stream, with: urlRequest)
        }
    }
    
    // MARK: Download
    
    func download(_ urlRequest: URLRequestConvertible,
                         to destination: @escaping DownloadRequest.DownloadFileDestination) -> Observable<DownloadRequest> {
        return request { manager in
            return manager.download(urlRequest, to: destination)
        }
    }
    
    
    func download(resumeData: Data,
                         to destination: @escaping DownloadRequest.DownloadFileDestination) -> Observable<DownloadRequest> {
        return request { manager in
            return manager.download(resumingWith: resumeData, to: destination)
        }
    }
}

// MARK: Request - Common Response Handlers

extension Request: ReactiveCompatible {
}

extension Reactive where Base: DataRequest {
    
    // MARK: Defaults
    
    /// - returns: A validated request based on the status code
    func validateSuccessfulResponse() -> DataRequest {
        return self.base.validate(statusCode: 200..<300)
    }
    
    
    func responseResult<T:DataResponseSerializerProtocol>(queue: DispatchQueue? = nil,
                               responseSerializer: T)
        -> Observable<(HTTPURLResponse, T.SerializedObject)> {
            return Observable.create { observer in
                let dataRequest = self.base
                    .response(queue: queue, responseSerializer: responseSerializer) { (packedResponse) -> Void in
                        switch packedResponse.result {
                        case .success(let result):
                            if let httpResponse = packedResponse.response {
                                observer.on(.next(httpResponse, result))
                            } else {
                                observer.on(.error(NSBuildError(code: -1, message: "Unknown Error")))
                            }
                            observer.on(.completed)
                        case .failure(let error):
                            if let code = packedResponse.response?.statusCode,
                               let statusCode = HTTPStatusCode(rawValue: code),
                                !statusCode.isSuccess  {
                                observer.on(.error(NSBuildError(code: code, message: statusCode.localizedReasonPhrase)))
                            } else {
                                observer.on(.error(error as Error))
                            }
                        }
                }
                return Disposables.create {
                    dataRequest.cancel()
                }
            }
    }
    
    
    func result<T:DataResponseSerializerProtocol>(
        queue: DispatchQueue? = nil,
        responseSerializer: T)
        -> Observable<T.SerializedObject> {
            return Observable.create { observer in
                let dataRequest = self.validateSuccessfulResponse()
                    .response(queue: queue, responseSerializer: responseSerializer) { (packedResponse) -> Void in
                        switch packedResponse.result {
                        case .success(let result):
                            if let _ = packedResponse.response {
                                observer.on(.next(result))
                            } else {
                                observer.on(.error(NSBuildError(code: -1, message: "Unknown Error")))
                            }
                            observer.on(.completed)
                        case .failure(let error):
                            if let code = packedResponse.response?.statusCode,
                                let statusCode = HTTPStatusCode(rawValue: code),
                                !statusCode.isSuccess  {
                                observer.on(.error(NSBuildError(code: code, message: statusCode.localizedReasonPhrase)))
                            } else {
                                observer.on(.error(error as Error))
                            }
                        }
                }
                return Disposables.create {
                    dataRequest.cancel()
                }
            }
    }
    
    func responseData() -> Observable<(HTTPURLResponse, Data)> {
        return responseResult(responseSerializer: DataRequest.dataResponseSerializer())
    }
    
    func data() -> Observable<Data> {
        return result(responseSerializer: DataRequest.dataResponseSerializer())
    }
    
    func responseString(encoding: String.Encoding? = nil) -> Observable<(HTTPURLResponse, String)> {
        return responseResult(responseSerializer: Base.stringResponseSerializer(encoding: encoding))
    }
    
    func string(encoding: String.Encoding? = nil) -> Observable<String> {
        return result(responseSerializer: Base.stringResponseSerializer(encoding: encoding))
    }
    
    func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<(HTTPURLResponse, Any)> {
        return responseResult(responseSerializer: Base.jsonResponseSerializer(options: options))
    }
    
    
    func json(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<Any> {
        return result(responseSerializer: Base.jsonResponseSerializer(options: options))
    }
    
    
    func responsePropertyList(options: PropertyListSerialization.ReadOptions = PropertyListSerialization.ReadOptions()) -> Observable<(HTTPURLResponse, Any)> {
        return responseResult(responseSerializer: Base.propertyListResponseSerializer(options: options))
    }
    
    func propertyList(options: PropertyListSerialization.ReadOptions = PropertyListSerialization.ReadOptions()) -> Observable<Any> {
        return result(responseSerializer: Base.propertyListResponseSerializer(options: options))
    }
    
    // MARK: Request - Upload and download progress
    
    func progress() -> Observable<RxProgress> {
        return Observable.create { observer in
            self.base.downloadProgress { progress in
                let rxProgress = RxProgress(bytesWritten: progress.completedUnitCount,
                                            totalBytes: progress.totalUnitCount)
                observer.onNext(rxProgress)
                if rxProgress.bytesWritten >= rxProgress.totalBytes {
                    observer.onCompleted()
                }
            }
            return Disposables.create()
            }
            // warm up a bit :)
            .startWith(RxProgress(bytesWritten: 0, totalBytes: 0))
    }
}

extension Reactive where Base: DownloadRequest {
    
    func progress() -> Observable<RxProgress> {
        return Observable.create { observer in
            self.base.downloadProgress { progress in
                let rxProgress = RxProgress(bytesWritten: progress.completedUnitCount,
                                            totalBytes: progress.totalUnitCount)
                observer.onNext(rxProgress)
                if rxProgress.bytesWritten >= rxProgress.totalBytes {
                    observer.onCompleted()
                }
            }
            return Disposables.create()
            }
            // warm up a bit :)
            .startWith(RxProgress(bytesWritten: 0, totalBytes: 0))
    }
}

// MARK: RxProgress

struct RxProgress {
    let bytesWritten: Int64
    let totalBytes: Int64
    
    init(bytesWritten: Int64, totalBytes: Int64) {
        self.bytesWritten = bytesWritten
        self.totalBytes = totalBytes
    }
}

extension RxProgress {
    var bytesRemaining: Int64 {
        return totalBytes - bytesWritten
    }
    
    var completed: Float {
        if totalBytes > 0 {
            return Float(bytesWritten) / Float(totalBytes)
        } else {
            return 0
        }
    }
}

extension RxProgress: Equatable {}

func ==(lhs: RxProgress, rhs: RxProgress) -> Bool {
    return lhs.bytesWritten == rhs.bytesWritten &&
        lhs.totalBytes == rhs.totalBytes
}
