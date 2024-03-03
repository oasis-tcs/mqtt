<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.2 SEARCHGW

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7            | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-------|:-------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1 | Length       |    |    |    |    |    |    |    |
| Byte 2 | Packet Type  |    |    |    |    |    |    |    |
| Byte 3 | Radius.      |    |    |    |    |    |    |    |

Table 12: SEARCHGW packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The SEARCHGW packet is sent by a client when it searches for a Gateway.
The transmission radius of the SEARCHGW is limited and depends on the density of the clients deployment,
e.g. only 1-hop transmission in case of a very dense network in which every MQTT-SN client is reachable from each other within 1-hop transmission.

> **Informative Comment**:
> If the Transport Layer supports broadcast, like UDP/IP, the SEARCHGW packet is generally sent using the broadcast address as destination.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.2.1 Length and Packet Type{#searchgw--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Please refer to
section 1.4.2 for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.2.2 Radius

The transmission radius is also indicated to the underlying network layer when MQTT-SN gives this packet for transmission.

A Client or a Gateway MUST NOT forward the SEARCHGW received if the Radius value is 0.

If a Client or a Gateway forwards the SEARCHGW received, it MUST reduce the Radius value by 1.
