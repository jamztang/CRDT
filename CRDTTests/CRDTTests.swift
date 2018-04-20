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

    func testEmptySet() {
        let animals = CRDTLWWSet<String>()
        let result = animals.result()
        XCTAssertEqual(result.count, 0)
    }

    func testAddNode() {
        let animals = CRDTLWWSet<String>()
        animals.add(CRDTNode("dog", 1))
        animals.add(CRDTNode("cat", 1))
        XCTAssertEqual(animals.count(), 2)
        XCTAssertNotNil(animals.query(element: "cat"))
        XCTAssertNotNil(animals.query(element: "dog"))
    }

    func testAddNodeOverridden() {
        let animals = CRDTLWWSet<String>()
        animals.add(CRDTNode("dog", 2))
        animals.add(CRDTNode("dog", 1))
        XCTAssertEqual(animals.count(), 1)
        XCTAssertEqual(animals.query(element: "dog")!.timestamp, 2)
    }

    func testRemoveNode() {
        let animals = CRDTLWWSet<String>()
        animals.add(CRDTNode("dog", 1))
        animals.remove(CRDTNode("dog", 2))

        let result = animals.result()
        XCTAssertEqual(result.count, 0)
    }

    func testRemoveNodeFailed() {
        let animals = CRDTLWWSet<String>()
        animals.add(CRDTNode("dog", 2))
        animals.remove(CRDTNode("dog", 1))     // cant remove dog 2
        let result1 = animals.result()
        XCTAssertEqual(result1.count, 1)
    }

    func testRemoveNothingNode() {
        let animals = CRDTLWWSet<String>()
        animals.remove(CRDTNode("dog"))
        let result = animals.result()
        XCTAssertEqual(result.count, 0)
    }

    func testSetOrder() {
        let animals = CRDTLWWSet<String>()
        animals.add(CRDTNode("dog", 2))
        animals.add(CRDTNode("cat", 1))
        animals.add(CRDTNode("dog", 1))

        let result = animals.result()
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], CRDTNode("cat", 1))
        XCTAssertEqual(result[1], CRDTNode("dog", 2))
    }

}
