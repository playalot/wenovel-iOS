//
//  CacheClient.swift
//  PlayKit
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import Foundation
import KeychainAccess
import YYCache

public protocol CacheContainer {
    associatedtype CacheValue
    associatedtype CacheKey
    init?(name: String?)
    func syncCache(value: CacheValue?, forKey key: CacheKey) -> Bool
    func syncReadCache(forKey key: CacheKey) -> CacheValue?
    func cleanCache()
}

public extension CacheContainer {
    func asnycCache(value: CacheValue?, forKey key: CacheKey, complete: ((Bool) -> Void)?) {
        complete?(syncCache(value: value, forKey: key))
    }
    
    func asyncReadCache(forKay key: CacheKey, complete: (CacheValue?) -> Void ) {
        complete(syncReadCache(forKey: key))
    }
}

public enum CacheableValue {
    case data(value: Data?)
    case string(value: String?)
    public func stringValue() -> String? {
        switch self {
        case .string(let value):
            return value
        default:
            return nil
        }
    }
    public func dataValue() -> Data? {
        switch self {
        case .data(let value):
            return value
        default:
            return nil
        }
    }
}


// MARK: - UserDefault
public class UserDefaultsCache: CacheContainer {

    private let userDefault: UserDefaults
    public required init?(name: String?) {
        guard let d = UserDefaults(suiteName: name) else { return nil }
        userDefault = d
    }
    
    public func syncCache(value: Any?, forKey key: String)  -> Bool {
        userDefault.set(value, forKey: key)
        return true
    }
    
    public func syncReadCache(forKey key: String) -> Any? {
        return userDefault.object(forKey: key)
    }
    
    public func cleanCache() {
        for (k, _) in userDefault.dictionaryRepresentation() {
            userDefault.removeObject(forKey: k)
        }
        userDefault.synchronize()
    }
}


// MARK: Keyhain
public class KeychainCache: CacheContainer {

    private let keychain: Keychain
    public required init?(name: String?) {
        guard let n = name else { return nil }
        keychain = Keychain(service: n)
    }
    
    public func syncCache(value: CacheableValue?, forKey key: String) -> Bool {
        do {
            guard let v = value else {
                do {
                    try keychain.remove(key)
                    return true
                } catch _ {
                    return false
                }
            }
            switch v {
            case .data(let data):
                if let d = data {
                    try keychain.set(d, key: key)
                } else {
                    try keychain.remove(key)
                }
            case .string(let str):
                if let s = str {
                    try keychain.set(s, key: key)
                } else {
                    try keychain.remove(key)
                }
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    public func syncReadCache(forKey key: String) -> CacheableValue? {
        if let s = (try? keychain.get(key))?.flatMap({ CacheableValue.string(value: $0)}) {
            return s
        } else if let d = (try? keychain.getData(key))?.flatMap({ CacheableValue.data(value: $0)}) {
            return d
        } else {
            return nil
        }
    }
    
    public func cleanCache() {
        try? keychain.removeAll()
    }
}


// MARK: SQLite
public class SQLiteCache: CacheContainer {
    private let cache: YYCache
    
    public required init?(name: String?) {
        guard let n = name, let c = YYCache(name: n) else { return nil }
        cache = c
    }
    
    public func syncReadCache(forKey key: String) -> NSCoding? {
        return cache.object(forKey: key)
    }
    
    public func syncCache(value: NSCoding?, forKey key: String) -> Bool {
        cache.setObject(value, forKey: key)
        return true
    }
    
    public func asyncReadCache(forKay key: String, complete: @escaping (NSCoding?) -> Void) {
        cache.object(forKey: key) { (k: String?, v: NSCoding?) in
            complete(v)
        }
    }
    
    public func asnycCache(value: NSCoding?, forKey key: String, complete: ((Bool) -> Void)?) {
        cache.setObject(value, forKey: key) { 
            complete?(true)
        }
    }
    
    public func cleanCache() {
        cache.removeAllObjects()
    }
}


// TODO: 
// MARK: FileCache
//public class FileCache: CacheContainer {
//
//}



