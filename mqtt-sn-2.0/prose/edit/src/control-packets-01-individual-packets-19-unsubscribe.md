<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.19 UNSUBSCRIBE

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway -->
<!-- transformation-note: bitfield display candidate could be clearer that X means variable bit values for UNSUBSCRIBE flags (bits). -->
<!-- transformation-note: observation: the blind table indicates different widths for some reserved as well as topic type bits. -->
<!-- transformation-note: observation: alternate inhabitants of bytes 6 and 7 in the case of a topic filter are possibly more (or even less?) than 2 bytes. -->
| Bit    | 7                                   | 6        | 5        | 4        | 3        | 2        | 1          | 0          |
|:-------|:------------------------------------|:---------|:---------|:---------|:---------|:---------|:-----------|:-----------|
| Byte 1 | Length                              |          |          |          |          |          |            |            |
| Byte 2 | Packet Type                         |          |          |          |          |          |            |            |
|        | UNSUBSCRIBE FLAGS                   |          |          |          |          |          |            |            |
|        | Reserved                            | Reserved | Reserved | Reserved | Reserved | Reserved | Topic Type | Topic Type |
| Byte 3 | 0                                   | 0        | 0        | 0        | 0        | 0        | X          | X          |
| Byte 4 | Packet Identifier MSB               |          |          |          |          |          |            |            |
| Byte 5 | Packet Identifier LSB               |          |          |          |          |          |            |            |
| Byte 6 | Topic Data MSB  **OR** Topic Filter |          |          |          |          |          |            |            |
| Byte 7 | Topic Data LSB  **OR** Byte 6 ... N |          |          |          |          |          |            |            |

Table 39: UNSUBSCRIBE packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

An UNSUBSCRIBE packet is sent by the client to the GW to unsubscribe from named topics.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.1 Length and Packet Type{#unsubscribe--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.2 UNSUBSCRIBE Flags{#unsubscribe--unsubscribe-flags}

For The UNSUBSCRIBE Flags is 1 byte field in Byte position 3 of the UNSUBSCRIBE packet.  

The UNSUBSCRIBE Flags field includes the following flag:

<!-- transformation-note: the below table ref upstream 10 needs verification before transforming into a semantic ref later. -->
-   **Topic Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value.
    Refer to Table 10 for the definition of the various topic types.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.3 Packet Identifier{#unsubscribe--packet-identifier}

Should be coded such that it can be used to identify the corresponding SUBACK packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.4 Topic Data or Topic Filter{#unsubscribe--topic-data-and-topic-filter}

Contains Fixed Length UTF-8 Encoded String topic filter, topic alias (predefined or normal), or short topic name as indicated in the Topic Type field in flags.
Determines the topic names which this subscription is interested in.
