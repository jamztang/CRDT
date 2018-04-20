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


## Implementation

I decided to use a dictionary for add/remove set in CRDTLWWSet because
that can help prevent duplication.

I played around with some Swift syntax to support operand operations for
set merging. e.g. + for merge, == for compare

Things to optimize:

- CRDTLWWSet.result() is expensive
- CRDTLWWSet might not contain full set of history because it's
  overridden by last timestamp
- Test cases can be more complicated
