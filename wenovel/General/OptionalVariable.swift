//
//  OptionalVariable.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import RxSwift



public final class OptionalVariable<Element> {
    
    public typealias E = Element
    
    private let _subject: BehaviorSubject<Element?>
    
    private var _lock = NSRecursiveLock()
    
    private var _value: E?
    
    public var value: E? {
        get {
            _lock.lock(); defer { _lock.unlock() }
            return _value
        }
        set(newValue) {
            _lock.lock()
            _value = newValue
            _lock.unlock()
            guard  let v = newValue else { return  }
            _subject.on(.next(v))
        }
    }
    
    public init(_ value: Element? = nil) {
        _value = value
        _subject = BehaviorSubject(value: value)
    }
    
    public func asObservable() -> Observable<E> {
        return _subject.filter({ $0 != nil }).map({ $0! })
    }
    
    deinit {
        _subject.on(.completed)
    }
}

