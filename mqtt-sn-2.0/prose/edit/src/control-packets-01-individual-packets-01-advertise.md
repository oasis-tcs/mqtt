<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.1 ADVERTISE

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7            | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:-------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length       |    |    |    |    |    |    |    |
| Byte 2 | Packet Type  |    |    |    |    |    |    |    |
| Byte 3 | GwId         |    |    |    |    |    |    |    |
| Byte 4 | uration MSB  |    |    |    |    |    |    |    |
| Byte 5 | Duration LSB |    |    |    |    |    |    |    |

Table 11: ADVERTISE Packet

The ADVERTISE packet is sent periodically by the gateway to advertise its presence.
The time interval until the next transmission is indicated by the Duration field.

> Non-Normative Comment
> If the Transport Layer supports broadcast, like UDP/IP, the ADVERTISE packet is generally sent using the broadcast address as destination.

#### 3.1.1.1 Length & Packet Type

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 1.8.2 for a detailed description.
<!-- transformation-note: the section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

#### 3.1.1.2 GwId

The GwId field is at least 1-byte identifier and uniquely identifies a gateway which is advertising itself in the network.

The MQTT-SN protocol itself doesn’t guarantee the uniqueness of the GwId field.

> Non-Normative Comment
> If the Gateway has a MAC address, it can be used as GwId.

#### 3.1.1.3 Duration

The Duration field is a 2-byte integer.
It specifies the time interval in seconds until the next ADVERTISE packet is transmitted by this gateway period.

The maximum value that can be encoded is approximately 18 hours.
