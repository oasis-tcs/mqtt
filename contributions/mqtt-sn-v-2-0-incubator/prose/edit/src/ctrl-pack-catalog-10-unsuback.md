## UNSUBACK - Unsubscribe Acknowledgement{#unsuback---unsubscribe-acknowledgement}

*Figure 3-20 -- UNSUBACK Packet*

![UNSUBACK Packet](images/image9.png "UNSUBACK Packet")<!-- .width="6.5in", .height="1.2777777777777777in" -->

An UNSUBACK packet is sent by a Server to acknowledge the receipt and processing of an UNSUBSCRIBE packet.

### UNSUBACK Header{#unsuback-header}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [[2.1 Structure of an MQTT-SN Control Packet]](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

### Packet Identifier{#uua---packet-identifier}

The same value as the Packet Identifier in the UNSUBSCRIBE packet being acknowledged.

### Reason Code{#uua---reason-code}

The Reason Code for the UNSUBACK packet is optional - its existence is inferred from the Packet length. If not provided, 0x00 (Success) is assumed.

The UNSUBACK Reason Codes are shown in «<mark title="Requirement MQTT-SN-3.10.3-1"><a name="MQTT-SN-3.10.3-1"></a>[2.3 Reason Code]](#reason-code). [The Server sending the UNSUBACK Packet MUST use one of the UNSUBACK Reason Codes</mark>»\[MQTT‑SN‑3.10.3‑1].
