//
//  Iso.swift
//  SwiftOptic
//
//  Created by ukitaka on 2016/12/22.
//  Copyright © 2016年 waft. All rights reserved.
//

import Foundation

public struct Iso<S, A> {
    public let get: (S) -> A
    public let reverseGet: (A) -> S

    public init(get: @escaping (S) -> A, reverseGet: @escaping (A) -> S) {
        self.get = get
        self.reverseGet = reverseGet
    }
}

public extension Iso {
    public func modify(_ m: @escaping (A) -> A) -> ((S) -> S) {
        get 
//        return { s in
//            return self.reverseGet(m(self.get(s)))
//        }
    }

    public var reverse: Iso<A, S> {
        return Iso<A, S>(
            get: self.reverseGet,
            reverseGet: self.get
        )
    }
}

public func compose<A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        return g(f(a))
    }
}
