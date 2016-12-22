//
//  Prism.swift
//  SwiftOptic
//
//  Created by Yuki Takahashi on 2016/12/22.
//  Copyright © 2016年 waft. All rights reserved.
//

import Swiftx

public struct Prism<S, A> {
    public let getOption: (S) -> A?
    public let reverseGet: (A) -> S

    public init(getOption: @escaping (S) -> A?, reverseGet: @escaping (A) -> S) {
        self.getOption = getOption
        self.reverseGet = reverseGet
    }
}

public extension Prism {
    public func isMatching(_ s: S) -> Bool {
        return getOption(s).fold(false, const(true))
    }

    public func modify(f: @escaping (A) -> A) -> ((S) -> S) {
        return { s in
            self.getOption(s).fold(s, self.reverseGet • f)
        }
    }

    public func modifyOption(f: @escaping (A) -> A) -> ((S) -> S?) {
        return { s in
            self.getOption(s).fold(nil, self.reverseGet • f)
        }
    }

    public func compose<B>(other: Prism<A, B>) -> Prism<S, B> {
        return Prism<S, B>(
            getOption: getOption >>->> other.getOption,
            reverseGet: reverseGet • other.reverseGet
        )
    }
}
