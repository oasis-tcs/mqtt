## Handling errors{#handling-errors}

### Malformed Packet and Protocol Errors{#malformed-packet-and-protocol-errors}

Definitions of Malformed Packet and Protocol Errors are contained in [[1.3 Terminology]](#terminology), some but not all of these error cases are noted throughout the specification. The rigor with which a Client or Server checks an MQTT-SN Control Packet it has received will be a compromise between:

- The size of the Client or Server implementation.

- The capabilities that the implementation supports.

- The degree to which the receiver trusts the sender to send correct Control Packets.

- The degree to which the receiver trusts the network to deliver Control Packets correctly.

- The consequences of continuing to process a packet that is incorrect.

If the sender is compliant with this specification it will not send Malformed Packets or cause Protocol Errors. The Reason Codes used for Malformed Packet and Protocol Errors include:

- 0x81 Malformed Packet

- 0x82 Protocol Error

- 0x93 Receive Maximum exceeded

- 0x95 Packet too large

<mark title="Ephemeral region marking">When a Client detects a Malformed Packet or Protocol Error associated with a Virtual Connection it SHOULD send a DISCONNECT packet containing an appropriate Reason Code and MUST delete the associated Virtual Connection</mark> \[MQTT-4.12.1-1\]. Use Reason Code 0x81 (Malformed Packet) or 0x82 (Protocol Error) unless a more specific Reason Code has been defined in [[2.3 Reason Code]](#reason-code).

<mark title="Ephemeral region marking">When a Server detects a Malformed Packet or Protocol Error for any packet except ADVERTISE, SEARCHGW, GWINFO, PUBWOS and CONNECT, the Server MAY send a DISCONNECT packet with an appropriate Reason Code and MUST delete the associated Virtual Connection if one exists</mark> \[MQTT-4.12.1-2\]. In the case of an error in a CONNECT packet it MAY send a CONNACK packet containing the Reason Code. Use Reason Code 0x81 (Malformed Packet) or 0x82 (Protocol Error) unless a more specific Reason Code has been defined in [[2.3 Reason Code]](#reason-code). There are no consequences for other Sessions.

If either the Server or Client omits to check some feature of a Control Packet, it might fail to detect an error, consequently it might allow data to be damaged.

### Other errors{#other-errors}

Errors other than Malformed Packet and Protocol Errors cannot be anticipated by the sender because the receiver might have constraints which it has not communicated to the sender. A receiving Client or Server might encounter a transient error, such as a shortage of memory, that prevents successful processing of an individual Control Packet.

Acknowledgment packets PUBACK, PUBREC, PUBREL, PUBCOMP, REGACK, SUBACK, UNSUBACK with a Reason Code of 0x80 or greater indicate that the received packet, identified by a Packet Identifier, was in error. There are no consequences for other Sessions or other Packets flowing on the same Session.

<mark title="Ephemeral region marking">The CONNACK and DISCONNECT packets allow a Reason Code of 0x80 or greater to indicate that the Virtual Connection will be deleted. If a Reason Code of 0x80 or greater is specified, then the Virtual Connection MUST be deleted whether or not the CONNACK or DISCONNECT is sent</mark> \[MQTT-4.12.2-1\]. Sending one of these Reason Codes has no consequences for any other Session.

If the Control Packet contains multiple errors the receiver of the Packet can validate the Packet in any order and take the appropriate action for any of the errors found.

Refer to [[5.4.9 Handling of Disallowed Unicode code points]](#handling-of-disallowed-unicode-code-points) for information about handling Disallowed Unicode code points.
