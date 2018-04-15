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

    func add(_ node: CRDTNode<T>) {
        addSet.append(node)
    }

    func remove(_ node: CRDTNode<T>) {

    }

    func merge(_ set: CRDTLWWSet<T>) {
        set.all().forEach { (node) in
            self.add(node)
        }

        addSet.sort { (a, b) -> Bool in
            return a < b
        }
    }

    func all() -> [CRDTNode<T>] {
        return addSet
    }

    var description : String {
        return "\(self.all())"
    }

    subscript(index: Int) -> CRDTNode<T> {
        return addSet[index]
    }

}

func ==<T>(left: CRDTLWWSet<T>, right: CRDTLWWSet<T>) -> Bool {

    guard left.all().count == right.all().count else {
        return false
    }

    for i in 0..<left.all().count {
        if left[i] != right[i] {
            return false
        }
    }

    return true
}

func +<T>(left: CRDTLWWSet<T>, right: CRDTLWWSet<T>) -> CRDTLWWSet<T> {
    let set = CRDTLWWSet<T>()
    set.merge(left)
    set.merge(right)
    return set
}

//
//func +<T>(left: CRDTNode<T>, right: CRDTNode<T>) -> CRDTLWWSet<T> {
//    let set = CRDTLWWSet<T>()
//    set.add(left)
//    set.add(right)
//    return set
//}
//
//func +<T>(left: CRDTLWWSet<T>, right: CRDTNode<T>) -> CRDTLWWSet<T> {
//    left.add(right)
//    return left
//}
//
//func +<T>(left: CRDTNode<T>, right: CRDTLWWSet<T>) -> CRDTLWWSet<T> {
//    let set = CRDTLWWSet<T>()
//    set.add(left)
//    right.all().forEach { (node) in
//        set.add(node)
//    }
//    return set
//}
//
//func +=<T>( left: inout CRDTLWWSet<T>, right: CRDTNode<T>) {
//    left = left + right
//}
//

