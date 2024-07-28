<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.2 Networks and Virtual Connections
<!-- transformation-note: replaced ampersand with english word "and" in above section title. -->

The MQTT-SN protocol requires an underlying transport to create a Virtual Connection, this carries Packets from a Client to a Gateway and a Gateway to a Client.
The underlying transport may also broadcast Packets from a Client to all Gateways and from a Gateway to all Clients.
These MQTT-SN Packets which must be received unaltered and complete.

- The underlying transport does not need to be reliable, it is expected that Packets will be lost or delivered out of order.
- If the network might deliver a Packet more than once, then it is highly recommended that the PROTECTION packet Monotonic Counter is used to eliminate the duplicates.
- The MQTT-SN protocol will tolerate out of order Packets and it will retransmit lost Packets.
- The MQTT-SN does not perform error correction. If a corrupted or partial packet is received it will cause a protocol error.
- The MQTT-SN implementation may use either the origin network address or the sender identifier in the PROTECTION Packet determine the identity of the Virtual Connection.
- The networks may be connectionless, the Virtual Connections do not need to have an event that signals when they begin or end.
- The networks may be radio networks.

> Informative comment
> 
> UDP as defined in [RFC0768] can be used for MQTT-SN if the Maximum Transmission Unit is configured to be more than the MQTT-SN Packet size used and no Packet fragmentation occurs.
> Depending on the network configuration, UDP can duplicate Packets.
> If this can happen, the PROTECTION Packet monotonic counter should be used.
>
>Examples of possible consequences of not removing duplicate Packets are:
>
>– DISCONNECT Packet applied to the wrong Virtual Connection
>– SUBSCRIBE and UNSUBSCRIBE Packets applied to the wrong Virtual Connection
>– PUBLISH QOS=2 published more than once
>
>The following transport protocols are also suitable but if not capable of broadcast the implementation of the optional ADVERTISE, SEARCHGW,
>GWINFO packets may not be possible and also the broadcast of the PUBLISH MINUS -1 packets may not be possible:
>
>- DTLS v1.2 \[RFC6347]
>- DTLS v1.3 \[RFC9147]
>- QUIC \[RFC9000]
>- Non-IP protocolsTCP/IP \[RFC0793]
>- TLS \[RFC5246]
>- WebSocket \[RFC6455]
<!-- transformation-note: ensure all these references in above list are present (at least) in the informative references section. -->

> Informative comment
> 
> TCP ports 8883 and 1883 are registered with IANA for MQTT TLS and non-TLS communication respectively.
