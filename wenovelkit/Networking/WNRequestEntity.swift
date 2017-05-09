//
//  WeNovelEntity.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import ObjectMapper



public struct WNCommentRequest: Mappable {
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        
    }
}


public struct WNNovelOption: Mappable {
    public init() {
    
    }
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        
    }
}

public struct WNNovelRequest: Mappable {
    public var title: String?
    public var content: String?
    public init(title: String?, content: String) {
        self.title = title
        self.content = content
    }
    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
}
