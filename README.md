CRDT
---


Conflict-free replicated data type


## CRDT Charactistics

Associativity (a+(b+c)=(a+b)+c), so that grouping doesn't matter.
Commutativity (a+b=b+a), so that order of application doesn't matter.
Idempotence (a+a=a), so that duplication doesn't matter.


## Types

Operation-based CRDTs
State-based CRDTs


## Known CRDT

G-Counter (Grow-only Counter)
Pn-Counter (Positive-Negative Counter)
G-Set (Grow-only Set)
2P-Set (Two-Phase Set)
LWW-Element-Set (Last-Write-Wins-Element-Set)
OR-Set (Observed-Removed Set)oSequence CRDTs
Sequence CRDTs
