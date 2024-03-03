<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.20 UNSUBACK

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:--------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type   |    |    |    |    |    |    |    |
| Byte 3 | Packet Id MSB |    |    |    |    |    |    |    |
| Byte 4 | Packet Id LSB |    |    |    |    |    |    |    |
| Byte 5 | Reason Code   |    |    |    |    |    |    |    |

Table 40: UNSUBACK packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

An UNSUBACK packet is sent by a GW to acknowledge the receipt and processing of an UNSUBSCRIBE packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.1 Length and Packet Type{#unsuback--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.2 Packet Identifier{#unsuback--packet-identifier}

Same value as the one contained in the corresponding UNSUBSCRIBE packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.20.3 Reason Code{#unsuback--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the UNSUBACK packet holds the Reason code in response to UNSUBSCRIBE packet.
The UNSUBACK Reason Codes are shown in Table 9: Reason Code Values.
The server sending the UNSUBACK packet MUST use one of the UNSUBACK Reason Codes.
