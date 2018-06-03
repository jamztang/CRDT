//
//  CRDTNode.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import Foundation

public struct CRDTNode<T : Hashable> : Comparable, CustomStringConvertible {
    public let value: T
    public let timestamp: TimeInterval

    public init(_ t: T, _ timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.value = t
        self.timestamp = timestamp
    }

    public var description: String {
        return "\(value))"
    }

    public static func ==(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.value == right.value
    }

    // === Strong compare the nodes also include timestamp difference
    public static func ===(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.value == right.value && left.timestamp == right.timestamp
    }

    public static func !==(left: CRDTNode, right: CRDTNode) -> Bool {
        return !(left === right)
    }

    // timestamp comparisons
    public static func <(left: CRDTNode, right: CRDTNode) -> Bool {
        return left.timestamp < right.timestamp
    }
}
