## Server redirection{#server-redirection}

A Server can request that the Client uses another Server by sending a CONNACK or DISCONNECT packet with Reason Codes 0x9C (Use another server), or 0x9D (Server moved) as described in [[4.12 Handling errors]](#handling-errors).

The Reason Code 0x9C (Use another server) specifies that the Client SHOULD temporarily switch to using another Server. The other Server is already known to the Client.

The Reason Code 0x9D (Server moved) specifies that the Client SHOULD permanently switch to using another Server. The other Server is already known to the Client.
