<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.14 PUBREC (QoS 2 delivery part 1){#pubrec-qos-2-delivery-part-1}

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:--------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type   |    |    |    |    |    |    |    |
| Byte 3 | Packet Id MSB |    |    |    |    |    |    |    |
| Byte 4 | Packet Id LSB |    |    |    |    |    |    |    |
| Byte 5 | Reason Code   |    |    |    |    |    |    |    |

Table 33: PUBREC packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

A PUBREC packet is the response to a PUBLISH packet with QoS 2. It is the second packet of the QoS 2 protocol exchange.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.14.1 Length and Packet Type{#pubrec-qos-2-delivery-part-1--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 2.1 is hard to validate, so the title was added. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.14.2 Packet Id{#pubrec-qos-2-delivery-part-1--packet-id}

Same value as the one contained in the corresponding PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.14.3 Reason Code{#pubrec-qos-2-delivery-part-1--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the PUBREC packet holds the Reason code in response to the PUBLISH packet.
The PUBREC Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the PUBREC packet MUST use one of the PUBREC Reason Codes.
