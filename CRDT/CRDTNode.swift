//
//  CRDTNode.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import Foundation

struct CRDTNode<T : Hashable> : Comparable, CustomStringConvertible {
    let value: T
    let timestamp: TimeInterval

    init(_ t: T, _ timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.value = t
        self.timestamp = timestamp
    }

    var description: String {
        return "\(value))"
    }

    static func ==(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.value == right.value
    }

    // === Strong compare the nodes also include timestamp difference
    static func ===(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.value == right.value && left.timestamp == right.timestamp
    }

    static func !==(left: CRDTNode, right: CRDTNode) -> Bool {
        return !(left === right)
    }

    // timestamp comparisons
    static func <(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.timestamp < right.timestamp
    }
}
