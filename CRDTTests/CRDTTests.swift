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

    func testIdempotence() {
        let one = CRDTLWWSet(1)
        XCTAssert(one == one + one, "duplication doesn't matter")
    }

    func testLastWriteWins() {
        let oneA = CRDTLWWSet(1)
        let oneB = CRDTLWWSet(1)

        XCTAssert(oneA + oneB == oneB)
        XCTAssert(oneA + oneB != oneA)
    }

    func testTimeStampDiff() {
        let nodeA = CRDTNode(1)
        let nodeB = CRDTNode(1)

        XCTAssert(nodeA !== nodeB, "timeStamp difference")
        XCTAssert(nodeA < nodeB, "A.timestamp < B.timestamp")
    }

}
