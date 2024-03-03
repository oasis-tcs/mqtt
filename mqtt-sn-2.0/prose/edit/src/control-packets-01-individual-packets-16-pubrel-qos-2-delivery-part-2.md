<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.16 PUBCOMP (QoS 2 delivery part 3)

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:--------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type   |    |    |    |    |    |    |    |
| Byte 3 | Packet Id MSB |    |    |    |    |    |    |    |
| Byte 4 | Packet Id LSB |    |    |    |    |    |    |    |
| Byte 5 | Reason Code   |    |    |    |    |    |    |    |

Table 35: PUBCOMP packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The PUBCOMP packet is the response to a PUBREL packet. It is the fourth and final packet of the QoS 2 protocol exchange.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.16.1 Length and Packet Type{#pubcomp-qos-2-delivery-part-3--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

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
