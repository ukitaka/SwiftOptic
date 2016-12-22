//
//  Iso.swift
//  SwiftOptic
//
//  Created by ukitaka on 2016/12/22.
//  Copyright © 2016年 waft. All rights reserved.
//

import Swiftx

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
        return reverseGet • m • get
    }

    public var reverse: Iso<A, S> {
        return Iso<A, S>(
            get: reverseGet,
            reverseGet: get
        )
    }

    public func compose<B>(other: Iso<A, B>) -> Iso<S, B> {
        return Iso<S, B>(
            get: other.get • get,
            reverseGet: reverseGet • other.reverseGet
        )
    }
}
