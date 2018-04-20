//
//  CRDTNode.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Cocoa

struct CRDTNode <T : Hashable> : Equatable, CustomStringConvertible {
    let value: T
    let timestamp : TimeInterval

    init(_ t: T, _ timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.value = t
        self.timestamp = timestamp
    }

    var description: String {
        return "\(value))"
    }

}

// == Compare the values within two nodes
func ==<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.value == right.value
}

func !=<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return !(left == right)
}

// === Strong compare the nodes also include timestamp difference
func ===<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.value == right.value && left.timestamp == right.timestamp
}

func !==<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return !(left === right)
}

// timestamp comparisons
func <<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.timestamp < right.timestamp
}

func ><T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.timestamp > right.timestamp
}

func <=<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.timestamp <= right.timestamp
}

func >=<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.timestamp >= right.timestamp
}

