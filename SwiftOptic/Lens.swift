//
//  Lens.swift
//  SwiftOptic
//
//  Created by Yuki Takahashi on 2016/12/23.
//  Copyright © 2016年 waft. All rights reserved.
//

import Foundation

public struct Lens<S, A> {
    public let get: (S) -> A
    public let set: (A, S) -> S

    public init(get: @escaping (S) -> A, set: @escaping (A, S) -> S) {
        self.get = get
        self.set = set
    }

    public func modify(_ s: S) -> ((A) -> A) -> S {
        return { f in
            self.set(f(self.get(s)), s)
        }
    }
}
