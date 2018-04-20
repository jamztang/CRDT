CRDT
---


Conflict-free replicated data type


## CRDT Charactistics

- Associativity (a+(b+c)=(a+b)+c), so that grouping doesn't matter.
- Commutativity (a+b=b+a), so that order of application doesn't matter.
- Idempotence (a+a=a), so that duplication doesn't matter.


## Types

- Operation-based CRDTs
- State-based CRDTs


## Known CRDT

- G-Counter (Grow-only Counter)
- Pn-Counter (Positive-Negative Counter)
- G-Set (Grow-only Set)
- 2P-Set (Two-Phase Set)
- LWW-Element-Set (Last-Write-Wins-Element-Set)
- OR-Set (Observed-Removed Set)oSequence CRDTs
- Sequence CRDTs

## Reference

- Live Demo of https://github.com/edvorg/lww-element-set
- https://github.com/cedricblondeau/go-lww-element-set

## Examples

```
let animals = CRDTLWWSet<String>()
animals.add(CRDTNode("dog", 1))  // add a dog with timestamp 1
animals.add(CRDTNode("cat", 1))  // add a cat with timestamp 1
animals.add(CRDTNode("bird", 1))  // add a bird with timestamp 1
animals.remove(CRDTNode("dog", 2)) // remove a dog with timestamp 2
animals.result() // returns (cat, 1), (bird, 1)
animals.query("cat") // returns (cat, 1)
animals.query("dog") // returns nil
animals.count() // returns 2
```


## Discussion

Implemnetaion Decision

- CRDTNode is a generic class that be reused in other areas
  as soon as it's `T` is hashable and comparable, CRDTTests has examples
on both "string" and "int"

- CRDTNode/CRDTLWWSet is self contained without third party dependances

- In swift we can implement comparable protocol with custom operands
  easily, examples are provided in set merging. e.g. + for merge, == for compare

- Set merging was demonstrated with the three main CRDT charactics
  (associtivity, commutativity, and idempotence) in CRDTMergeTests

Things to optimize:

- There's no frontend implmenetation for now due to time limitation
- CRDTLWWSet.result() is expensive and can be cached and optimized
- CRDTLWWSet might not contain full set of history because it's
  overridden by last timestamp
- Test cases can be more sophisticated
- If the timestamp are the same for multiple elements, the result order
  could be undermined because of using Dictionary. Consider building an
ordered dictionary in Swift if needed
