//
//  CRDTTests.swift
//  CRDTTests
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import XCTest
@testable import CRDT

class CRDTTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAssociativity() {
        let one = CRDTLWWSet(1)
        let two = CRDTLWWSet(2)
        let three = CRDTLWWSet(3)

        let setA = (one + two) + three
        let setB = one + (two + three)

        XCTAssert(setA == setB, "setA and setB should be equal")
    }

    func testCommutativity() {
        let one = CRDTLWWSet(1)
        let two = CRDTLWWSet(2)

        XCTAssert(one + two == two + one, "order should not matter")
    }
}
