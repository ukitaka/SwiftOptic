//
//  Optional.swift
//  SwiftOptic
//
//  Created by Yuki Takahashi on 2016/12/23.
//  Copyright © 2016年 waft. All rights reserved.
//

import Foundation

extension Optional {
    func fold<B>(_ ifNone: @autoclosure () -> B, _ f: (Wrapped) -> B) -> B {
        switch self {
        case .none:
            return ifNone()
        case .some(let a):
            return f(a)
        }
    }
}

func >>->> <A, B, C>(lhs: @escaping (A) -> B?, rhs: @escaping (B) -> C?) -> (A) -> C? {
    return { a in
        lhs(a).flatMap(rhs)
    }
}
