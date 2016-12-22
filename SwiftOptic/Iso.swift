//
//  Iso.swift
//  SwiftOptic
//
//  Created by ST20841 on 2016/12/22.
//  Copyright © 2016年 waft. All rights reserved.
//

import Foundation

public struct Iso<S, A> {
    public let f: (S) -> A
    public let g: (A) -> S
}
