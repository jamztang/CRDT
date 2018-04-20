//
//  CRDTMergeTests.swift
//  CRDTTests
//
//  Created by invision on 20/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import XCTest
@testable import CRDT

class CRDTMergeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMergeAssociativity() {
        let one = CRDTLWWSet(1)
        let two = CRDTLWWSet(2)
        let three = CRDTLWWSet(3)

        let setA = (one + two) + three
        let setB = one + (two + three)

        XCTAssert(setA == setB, "setA and setB should be equal")
    }

    func testMergeCommutativity() {
        let one = CRDTLWWSet(1)
        let two = CRDTLWWSet(2)

        XCTAssert(one + two == two + one, "order should not matter")
    }

    func testMergeIdempotence() {
        let one = CRDTLWWSet(1)
        XCTAssert(one == one + one, "duplication doesn't matter")
    }

    func testMergeLastWriteWins() {
        let oneA = CRDTLWWSet(1)
        let oneB = CRDTLWWSet(1)

        XCTAssert(oneA + oneB == oneB)
        XCTAssert(oneA + oneB != oneA)
    }

    func testMergeExample() {
        let home = CRDTLWWSet<String>()
        home.add(CRDTNode("cat", 1))
        home.add(CRDTNode("dog", 2))

        let office = CRDTLWWSet<String>()
        office.add(CRDTNode("parrot", 2))
        office.add(CRDTNode("dog", 2))

        let mum = CRDTLWWSet<String>()
        mum.remove(CRDTNode("parrot", 1))
        mum.remove(CRDTNode("dog", 3))
        mum.remove(CRDTNode("rubbish", 3))

        let merged = home + office + mum
        XCTAssertEqual(merged.count(), 2)
        XCTAssertNotNil(merged.query(element: "cat")) // cat 1 never been removed
        XCTAssertNotNil(merged.query(element: "parrot")) // parrot 2 can't be removed before it exists
        XCTAssertNil(merged.query(element: "dog")) // dog removed
        XCTAssertNil(merged.query(element: "rubbish")) // rubbish never exists

    }


}
