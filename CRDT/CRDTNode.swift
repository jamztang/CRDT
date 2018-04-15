//
//  CRDTNode.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Cocoa

struct CRDTNode <T : Comparable> : Equatable, CustomStringConvertible {
    let t: T
    let timestamp : Date

    init(_ t: T, timestamp: Date = Date()) {
        self.t = t
        self.timestamp = timestamp
    }

    var description: String {
        return "\(t): (\(self.timestamp))"
    }

}

func ==<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> Bool {
    return left.t == right.t && left.timestamp == right.timestamp
}

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
