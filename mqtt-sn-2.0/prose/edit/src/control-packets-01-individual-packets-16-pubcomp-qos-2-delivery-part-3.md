<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.16 PUBCOMP (QoS 2 delivery part 3){#pubcomp-qos-2-delivery-part-3}

![PUBCOMP Packet](images/packet/pubcomp.png "PUBCOMP Packet"){#fig:pubcomp-packet}

The PUBCOMP packet is the response to a PUBREL packet. It is the fourth and final packet of the QoS 2 protocol exchange.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.16.1 Length &amp; Packet Type{#pubcomp-qos-2-delivery-part-3--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.16.2 Packet Identifier{#pubcomp-qos-2-delivery-part-3--packet-identifier}
<!-- transformation-note: observation: in above section title the packet "Identifier" is named and not as usual the abbreviated form "Id". -->

Same value as the one contained in the corresponding PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.16.3 Reason Code{#pubcomp-qos-2-delivery-part-3--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the PUBCOMP packet holds the Reason code in response to the PUBREL packet.
The PUBCOMP Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the PUBCOMP packet MUST use one of the PUBCOMP Reason Codes.
