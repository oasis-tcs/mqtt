<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.13 PUBACK – Publish Acknowledgement

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:--------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type   |    |    |    |    |    |    |    |
| Byte 3 | Packet Id MSB |    |    |    |    |    |    |    |
| Byte 4 | Packet Id LSB |    |    |    |    |    |    |    |
| Byte 5 | Reason Code   |    |    |    |    |    |    |    |

Table 31: PUBACK packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

A PUBACK packet is the response to a PUBLISH packet with QoS 1.
It can also be sent as response to a PUBLISH packet of any QoS (with the exception of QoS -1, or PUBLISH WITHOUT SESSION) in case of an error;
the error reason is then indicated in the Reason Code field.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.13.1 Length and Packet Type{#puback-publish-acknowledgement--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.13.2 Packet Id{#puback-publish-acknowledgement--packet-id}

Same value as the one contained in the corresponding PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.13.3 Reason Code{#puback-publish-acknowledgement--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 5 in the PUBACK packet holds the Reason code in response to the PUBLISH packet.
The PUBACK Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the PUBACK packet MUST use one of the PUBACK Reason Codes.
