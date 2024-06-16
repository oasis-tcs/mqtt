<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.21 PINGREQ

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit          | 7                            | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------------|:-----------------------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1       | Length                       |    |    |    |    |    |    |    |
| Byte 2       | Packet Type                  |    |    |    |    |    |    |    |
| Byte 3 ... N | Client Identifier (optional) |    |    |    |    |    |    |    |


Table 42: PINGREQ packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

As with MQTT, the PINGREQ packet is an "are you alive" packet that is sent from or received by a connected client.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.21.1 Length and Packet Type{#pingreq--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.21.2 Client Identifier (optional){#pingreq--client-identifier}

Contains the client identifier (client id);
this field is optional and is included by a "sleeping" client when it goes to the "awake" state and is waiting for packets sent by the server/gateway.

The Client Identifier MUST be a Fixed Length UTF-8 Encoded String.
