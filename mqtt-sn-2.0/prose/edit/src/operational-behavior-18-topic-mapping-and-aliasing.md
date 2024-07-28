# 4.18 Topic Mapping and Aliasing

\[On the gateway the mapping table between registered topic ids and topic names MUST be implemented per client
(and not by a single shared pool between all clients),
to reduce the risk of an incorrect topic id from a client matching another client's valid topic.]

For performance and efficiency reasons the broker may choose to align topic aliases for registered normal topic aliases between multiple clients.
The mapping table of predefined topic aliases is separate from normal registered aliases.
It is global and shared between all clients and gateways and may overlap with registered aliases, since it is in a different pool.
