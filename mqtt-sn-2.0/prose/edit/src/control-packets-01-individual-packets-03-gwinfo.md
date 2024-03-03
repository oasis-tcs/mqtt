<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.3 GWINFO

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit          | 7                    | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------------|:---------------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1       | Length               |    |    |    |    |    |    |    |
| Byte 2       | Packet Type          |    |    |    |    |    |    |    |
| Byte 3       | GwId                 |    |    |    |    |    |    |    |
| Byte 4 ... N | GwAddress (optional) |    |    |    |    |    |    |    |

Table 13: GWINFO packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The GWINFO packet is sent as response to a SEARCHGW packet with the radius as indicated in the SEARCHGW packet.
If sent by a Gateway, it contains only the id of the sending Gateway;
otherwise, if sent by a client, it also includes the address of the Gateway.

> Informative Comment
> If the Transport Layer supports broadcast, like UDP/IP, the GWINFO packet is generally sent using the broadcast address as destination.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.3.1 Length and Packet Type{#gwinfo--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 1.4.2 for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.3.2 GwId{#gwinfo--gwid}

The GwId field is 1-byte long and uniquely identifies a Gateway in the network.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.3.3 GwAdd

The GwAdd field has a variable length and contains the address of a Gateway.
Its length depends on the type of network over which MQTT-SN operates and is specified by the Length byte.
Optional, only included if the packet is sent by a client.
