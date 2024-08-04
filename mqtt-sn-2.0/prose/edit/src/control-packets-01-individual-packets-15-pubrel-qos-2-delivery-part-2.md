<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.15 PUBREL (QoS 2 delivery part 2){#pubrel-qos-2-delivery-part-2}

![PUBREL Packet](images/packet/pubrel.png "PUBREL Packet"){#fig:pubrel-packet}

A PUBREL packet is the response to a PUBREC packet. It is the third packet of the QoS 2 protocol exchange.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.1 Length &amp; Packet Type{#pubrel-qos-2-delivery-part-2--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.2 Packet Id{#pubrel-qos-2-delivery-part-2--packet-id}

Same value as the one contained in the corresponding PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.3 Reason Code{#pubrel-qos-2-delivery-part-2--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the PUBREL packet holds the Reason code in response to the PUBREC packet.
The PUBREL Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the PUBREL packet MUST use one of the PUBREL Reason Codes.
