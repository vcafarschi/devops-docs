## Commit log

- These are append-only sequences of records order by time. More importantly, these logs are the source of truth for the state of data across the entire organization. And, because this state is centralized, it can then become the source of truth for a horizontally scaled, ever-evolving, multi-faceted application architecture.
- You can think of a log as acting as a kind of messaging system with durability guarantees and strong ordering semantics. In distributed systems, this model of communication sometimes goes by the (somewhat terrible) name of atomic broadcast. (Kindle, Location 295)

