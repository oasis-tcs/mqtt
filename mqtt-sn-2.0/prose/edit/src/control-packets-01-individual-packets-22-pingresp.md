<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.22 PINGRESP

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7                             | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:------------------------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length                        |    |    |    |    |    |    |    |
| Byte 2 | Packet Type                   |    |    |    |    |    |    |    |
| Byte 3 | Messages Remaining (optional) |    |    |    |    |    |    |    |

Table 43: PINGRESP packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

As with MQTT, a PINGRESP packet is the response to a PINGREQ packet and means "yes I am alive".
Keep Alive packets flow in either direction, sent either by a connected client or the gateway.
It has only a header and no variable part.

Moreover, a PINGRESP packet is sent by a gateway to inform a sleeping client that it has no more buffered packets for that client.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.22.1 Length and Packet Type{#pingresp--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.22.2 Messages Remaining

The number of messages left when a client is sent back to sleep.
Optional – for use at the end of a client's awake period.
Values can be:

| Allowed Values  | Description                                                                    |
|:----------------|:-------------------------------------------------------------------------------|
| 0               | No messages remain in the queue                                                |
| 1 – 254 (incl.) | The number of messages remaining in the queue                                  |
| 255 (0xFF)      | An unspecified positive number of messages remain in the queue greater than 0. |

Table 44: Allowed PINGRESP continuation values
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->
