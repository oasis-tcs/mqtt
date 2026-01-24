## Networks and Virtual Connections{#networks-and-virtual-connections}

The MQTT-SN protocol requires an Underlying Network to carry Packets from a Client to a Server and from a Server to a Client.

The Underlying Network may also be able to send Packets from a sender to more than one receiver at once -- UDP/IP multicast, for example.

The relationship between MQTT-SN and the Underlying Network is described in the following points:

- MQTT-SN Packets which are received must be unaltered and complete. There is no packet error correction in MQTT-SN. If a corrupted or partial packet is received it will cause a protocol error.

- The Underlying Network does not need to be reliable, it is expected that Packets can be lost or delivered out of order. The MQTT-SN protocol will tolerate out of order Packets and it will retransmit lost Packets in the case that an expected acknowledgement has not been received.

- If the Underlying Network might deliver a Packet more than once, for connection-oriented communications (CONNECT, DISCONNECT and other packets in between) the PROTECTION ENCAPSULATION Monotonic Counter MUST be used to eliminate duplicates. (In the case that a protected packet is duplicated, the Monotonic Counter will be the same on all the duplicates of a packet).

- The Underlying Network may be connectionless. Virtual Connections do not need to have an Underlying Network event that signals their creation or deletion.

- The Underlying Network may be a radio network.

> **Informative comment**
>
> UDP as defined in \[RFC0768\] can be used for MQTT-SN if the Maximum Transmission Unit is configured to be more than the maximum MQTT-SN Packet size used and no Packet fragmentation occurs. Depending on the network configuration, UDP can duplicate Packets. If this can happen, the PROTECTION ENCAPSULATION monotonic counter should be used.
>
> Examples of possible consequences of allowing duplicate Packets are:\
> -- DISCONNECT Packet applied to the wrong Virtual Connection\
> -- SUBSCRIBE and UNSUBSCRIBE Packets applied to the wrong Virtual Connection\
> -- PUBLISH QOS=2 published more than once
>
> The following transport protocols are also suitable but if not capable of multicast the implementation of the optional ADVERTISE, SEARCHGW, GWINFO packets may not be possible:

- DTLS v1.2 \[RFC6347\]

- DTLS v1.3 \[RFC9147\]

- QUIC \[RFC9000\]

- Non-IP protocols

- TCP/IP \[RFC0793\]

- TLS \[RFC5246\]

- WebSocket \[RFC6455\].

> **Informative comment**
>
> Both TCP and UDP ports 1883 and 8883 are registered with IANA for MQTT and secure communication respectively.

### Virtual Connections{#virtual-connections}

A Virtual Connection is:

- created with a CONNECT packet

- deleted by any of:

  - Keep Alive timeout

  - Retry timeout

  - DISCONNECT packet

  - protocol error

- required for any MQTT-SN Packet to be sent between an MQTT-SN Client and Server, except any of the following Packets:

  - CONNECT, which creates a Virtual Connection

  - PUBWOS (and PUBLISH QoS -1 if implemented)

  - ADVERTISE, SEARCHGW, GWINFO

«<mark title="Requirement MQTT-SN-4.2.1-1"><a name="MQTT-SN-4.2.1-1"></a>All incoming Packets except CONNECT, PUBWOS and Gateway search (ADVERTISE, SEARCHGW and GWINFO) MUST be associated with an existing Virtual Connection</mark>»\[MQTT‑SN‑4.2.1‑1].

Virtual Connections link a Network Identity with a Session. For those Packets other than CONNECT, PUBWOS and Gateway search, the receiver needs to be able to identify the sender to associate the Packet with a Virtual Connection. The Sender may be identified in various ways, for example:

- Network Address

- Protection Encapsulation - Sender Identifier

- Connection Encapsulation - Connection Information

- DTLS Connection ID

> **Informative Comment**
>
> The Network Address was the usual method of identifying the Sender in MQTT-SN 1.2, but may not be secure, or work in environments where the Network Address of a Client device may change during the lifetime of a Virtual Connection.
