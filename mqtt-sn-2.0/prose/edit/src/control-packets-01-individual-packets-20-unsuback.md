<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.20 UNSUBACK

![UNSUBACK Packet](images/packet/unsuback.png "UNSUBACK Packet"){#fig:unsuback-packet}

An UNSUBACK packet is sent by a GW to acknowledge the receipt and processing of an UNSUBSCRIBE packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.1 Length &amp; Packet Type{#unsuback--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.2 Packet Identifier{#unsuback--packet-identifier}

Same value as the one contained in the corresponding UNSUBSCRIBE packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.3 Reason Code{#unsuback--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the UNSUBACK packet holds the Reason code in response to UNSUBSCRIBE packet.
The UNSUBACK Reason Codes are shown in Table 9: Reason Code Values.
The server sending the UNSUBACK packet MUST use one of the UNSUBACK Reason Codes.
