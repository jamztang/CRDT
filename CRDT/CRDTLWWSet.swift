//
//  CRDTLWWSet.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Cocoa

class CRDTLWWSet<T : Hashable> : Equatable, CustomStringConvertible {

    internal var additions = [T: TimeInterval]()
    internal var removals = [T: TimeInterval]()

    init(_ value: T? = nil) {
        if let value = value {
            additions[value] = Date().timeIntervalSince1970
        }
    }

    func add(_ node: CRDTNode<T>) {
        if let old = additions[node.value] {
            if old < node.timestamp {
                additions[node.value] = node.timestamp
            }
        } else {
            additions[node.value] = node.timestamp
        }
    }

    func remove(_ node: CRDTNode<T>) {
        if let old = removals[node.value] {
            if old < node.timestamp {
                removals[node.value] = node.timestamp
            }
        } else {
            removals[node.value] = node.timestamp
        }
    }

    func result() -> [CRDTNode<T>] {
        var results = [CRDTNode<T>]()
        additions.forEach { (value, timestamp) in
            if let removed = removals[value], removed >= timestamp {
                // this value is removed
            } else {
                results.append(CRDTNode(value, timestamp))
            }
        }
        return results.sorted(by: { (a, b) -> Bool in
            return a < b
        })
    }

    func merge(_ set: CRDTLWWSet<T>) {
        set.additions.forEach { (value, timestamp) in
            self.add(CRDTNode(value, timestamp))
        }

        set.removals.forEach { (value, timestamp) in
            self.remove(CRDTNode(value, timestamp))
        }
    }

    var description : String {
        return "\(self.result())"
    }

    subscript(index: Int) -> CRDTNode<T> {
        return self.result()[index]
    }

    func query(element: T) -> CRDTNode<T>? {
        for node in self.result() {
            if node.value == element {
                return node
            }
        }
        return nil
    }

    func count() -> Int {
        return self.result().count;
    }

}

// == Compare the elements in the set
func ==<T>(left: CRDTLWWSet<T>, right: CRDTLWWSet<T>) -> Bool {
    guard left.count() == right.count() else {
        return false
    }

    for i in 0..<left.count() {
        if left[i] !== right[i] {
            return false
        }
    }

    return true
}

// + Merges two set
func +<T>(left: CRDTLWWSet<T>, right: CRDTLWWSet<T>) -> CRDTLWWSet<T> {
    let set = CRDTLWWSet<T>()
    set.merge(left)
    set.merge(right)
    return set
}

