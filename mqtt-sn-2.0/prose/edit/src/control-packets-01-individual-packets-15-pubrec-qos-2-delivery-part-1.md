<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.15 PUBREL (QoS 2 delivery part 2)

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:--------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type   |    |    |    |    |    |    |    |
| Byte 3 | Packet Id MSB |    |    |    |    |    |    |    |
| Byte 4 | Packet Id LSB |    |    |    |    |    |    |    |
| Byte 5 | Reason Code   |    |    |    |    |    |    |    |

Table 34: PUBREL packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

A PUBREL packet is the response to a PUBREC packet. It is the third packet of the QoS 2 protocol exchange.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.1 Length and Packet Type{#pubrel-qos-2-delivery-part-2--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 2.1 is hard to validate, so the title was added. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.2 Packet Id{#pubrel-qos-2-delivery-part-2--packet-id}

Same value as the one contained in the corresponding PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.15.3 Reason Code{#pubrel-qos-2-delivery-part-2--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the PUBREL packet holds the Reason code in response to the PUBREC packet.
The PUBREL Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the PUBREL packet MUST use one of the PUBREL Reason Codes.
