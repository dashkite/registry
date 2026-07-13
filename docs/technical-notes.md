# Technical Notes

### Registry Pattern and Expressiveness

DashKite emphasizes expressiveness and narrative clarity in code. By implementing a registry pattern, creators are greatly relieved from module ordering concerns and manual dependency graph management. A module can simply register itself and be pulled into a broader flow via a side-effects import. Because JavaScript modules guarantee idempotency, the language handles much of the underlying work natively, akin to iterators and the event loop.

### Singleton Guarantees and State Integrity

The registry attaches its underlying map to `globalThis["@dashkite/registry"]`, creating a registry-of-registries singleton pattern. Guaranteeing that all consumers share the exact same instance of a library enables safe same-instance equality checks. It also prevents race conditions for instances containing internal state by ensuring members are not split across two different versions of a library. Handling this meta-problem at an abstract level makes writing subsequent libraries much easier.

### Implicit State Machines

The registry serves as an implicit state machine rather than a simple promise cache. Code that requires a value calls upon the registry, which guarantees execution will halt until the condition is allowable. The act of registration in a separate module functions as a stateful event trigger, authorizing the dependent code path to proceed. This approach allows creators to build and manage sophisticated dependency graphs with non-deterministic timings with minimal effort.
