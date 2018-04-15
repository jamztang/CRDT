//
//  CRDTLWWSet.swift
//  CRDT
//
//  Created by invision on 15/4/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Cocoa

class CRDTLWWSet<T : Comparable> : Equatable, CustomStringConvertible {

    private var addSet = [CRDTNode<T>]()

    init(_ t: T? = nil) {
        if let t = t {
            addSet.append(CRDTNode(t))
        }
    }

    private func add(_ node: CRDTNode<T>) {
        if let index = addSet.index(of: node) {
            // found a node's value which is there
            let originalNode = addSet[index]
            if node < originalNode {
                // node is older than local, ignore
            } else {
                addSet.remove(at: index)
                addSet.append(node)
            }
        } else {
            addSet.append(node)
        }
    }

    func merge(_ set: CRDTLWWSet<T>) {
        set.all().forEach { (node) in
            self.add(node)
        }

        addSet.sort { (a, b) -> Bool in
            return a < b
        }
    }

    fileprivate func all() -> [CRDTNode<T>] {
        return addSet
    }

    var description : String {
        return "\(self.all())"
    }

    subscript(index: Int) -> CRDTNode<T> {
        return addSet[index]
    }

}

// == Compare the elements in the set
func ==<T>(left: CRDTLWWSet<T>, right: CRDTLWWSet<T>) -> Bool {
    guard left.all().count == right.all().count else {
        return false
    }

    for i in 0..<left.all().count {
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

