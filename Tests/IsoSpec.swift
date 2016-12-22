//
//  IsoSpec.swift
//  SwiftOptic
//
//  Created by ukitaka on 2016/12/22.
//  Copyright © 2016年 waft. All rights reserved.
//

import SwiftOptic
import XCTest
import SwiftCheck

class IsoSpec : XCTestCase {
    func testIsoLaws() {
        property("One way") <- forAll { (x : Int, fs : IsoOf<Int, UInt>) in
            let iso = Iso(get: fs.getTo, reverseGet: fs.getFrom)
            return iso.reverseGet(iso.get(x)) == x
        }

        property("Other way") <- forAll { (x : UInt, fs : IsoOf<Int, UInt>) in
            let iso = Iso(get: fs.getTo, reverseGet: fs.getFrom)
            return iso.get(iso.reverseGet(x)) == x
        }
    }
}
