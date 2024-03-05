<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.7 REGISTER

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit          | 7               | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------------|:----------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1       | Length          |    |    |    |    |    |    |    |
| Byte 2       | Packet Type     |    |    |    |    |    |    |    |
| Byte 3       | Topic Alias MSB |    |    |    |    |    |    |    |
| Byte 4       | Topic Alias LSB |    |    |    |    |    |    |    |
| Byte 5       | Packet Id MSB   |    |    |    |    |    |    |    |
| Byte 6       | Packet Id LSB   |    |    |    |    |    |    |    |
| Byte 7 ... N | Topic Name      |    |    |    |    |    |    |    |

Table 24: REGISTER packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The REGISTER packet is sent by a client to a GW for requesting a topic alias value for the included topic name.
It is also sent by a GW to inform a client about the topic alias value it has assigned to the included topic name.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.7.1 Length and Packet Type{#register--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.7.2 Topic Alias{#register--topic-alias}

If sent by a client, it is coded 0x0000 and is not relevant;
if sent by a GW, it contains the topic alias value assigned to the topic name included in the Topic Name field.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.7.3 Packet Id{#register--packet-id}

Should be coded such that it can be used to identify the corresponding REGACK packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.7.4 Topic Name{#register--topic-name}

Fixed Length UTF-8 Encoded String Contains the fully qualified topic name.
