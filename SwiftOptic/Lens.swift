//
//  Lens.swift
//  SwiftOptic
//
//  Created by Yuki Takahashi on 2016/12/23.
//  Copyright © 2016年 waft. All rights reserved.
//

import Foundation

struct Lens<S, A> {
    fileprivate let _get: (S) -> A
    fileprivate let _set: (S, A) -> S

    init(get: @escaping (S) -> A, set: @escaping (S, A) -> S) {
        self._get = get
        self._set = set
    }

    func get(_ s: S) -> A {
        return _get(s)
    }

    func set(_ s: S) -> (A) -> S {
        return curry(_set)(s)
    }

    func modify(_ s: S) -> ((A) -> A) -> S {
        return { f in
            self.set(s)(f(self.get(s)))
        }
    }
}
