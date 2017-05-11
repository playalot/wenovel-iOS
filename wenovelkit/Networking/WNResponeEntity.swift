//
//  WNResponeEntity.swift
//  wenovel
//
//  Created by Tbxark on 05/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import ObjectMapper

public func  WNBuildError(code: Int, reson: String) -> Error {
    return NSError(domain: "com.play.wenovel", code: code, userInfo: [NSLocalizedDescriptionKey: reson])
}


public let IDNOTFOUND = "IDNOTFOUND"
extension String {
    public var isValidId: Bool {
        return self != "" && self != IDNOTFOUND
    }
}


class WNDateTransform: TransformType {
    
    typealias Object = Date
    typealias JSON = Double
    
    init() {}
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt/1000))
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970) * 1000
        }
        return nil
    }
}


public struct Transform {
    static let date = WNDateTransform()
    static let url = URLTransform()
}


public enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
    public var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }

}

// MARK: Respone
public struct WNAuthRespone: Mappable {
    public private(set) var expires: Date?
    public private(set) var accessToken: String?
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        expires <- (map["expires"], Transform.date)
        accessToken <- map["accessToken"]
    }
}


public struct WNNovelNode: Mappable {
    public private(set) var id: String?
    public private(set) var storyId: String?
    public private(set) var storyTitle: String?
    public private(set) var content: String?
    public private(set) var created: Date?
    public private(set) var counts: WNNovelCount?
    public private(set) var user: WNUser?
    
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        id <- map["id"]
        storyId <- map["storyId"]
        storyTitle <- map["storyTitle"]
        content <- map["content"]
        counts <- map["counts"]
        created <- map["created"]
        user <- map["user"]
    }
    
}


public struct WNNovelCount: Mappable {
    public private(set) var views = 0
    public private(set) var likes = 0
    public private(set) var nodes = 0
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        views <- map["views"]
        likes <- map["likes"]
        nodes <- map["nodes"]
    }
}





public struct WNUser: Mappable {
    
    public private(set) var id : String?
    public private(set) var nickname : String?
    public private(set) var avatar : URL?
    
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        avatar <- (map["avatar"], Transform.url)
        id <- map["id"]
        nickname <- map["nickname"]
    }
}







