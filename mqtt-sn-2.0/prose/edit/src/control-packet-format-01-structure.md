<!-- transformation-note: left upstream numbering of headings for verification -->
## 2.1 Structure of an MQTT-SN Control Packet

The MQTT-SN protocol operates by exchanging a series of MQTT-SN Control Packets in a defined way. This section describes
the format of these packets.

An MQTT-SN Control Packet consists of up to two parts, always in the following order as shown below.

<!-- transformation-note: did use list in markdown instead of a blind table, but we should consider a common bitfield display strategy. -->
- Control Packet Header, present in all MQTT-SN Control Packets
- Control Packet Variable Part, present in some MQTT-SN Control Packets

<!-- transformation-note: caption of above block element to be revived is "Table 3: Structure of an MQTT-SN Control Packet" -->

<!-- transformation-note: left upstream numbering of headings for verification -->
### 2.1.1 Packet Header

Each MQTT-SN Control Packet contains a Header of format 1 or format 2 as shown below.

| Byte | Use                         |
|:-----|:----------------------------|
| 1    | Length                      |
| 2    | MQTT-SN Control Packet Type |

Table 4: Packet Header Format 1

| Byte | Use                         |
|:-----|:----------------------------|
| 1    | Length 0x01                 |
| 2    | Length MSB                  |
| 3    | Length LSB                  |
| 4    | MQTT-SN Control Packet Type |

Table 5: Packet Header Format 2

<!-- transformation-note: left upstream numbering of headings for verification -->
### 2.1.2 Length

The Length field is either 1-byte or 3-byte integer and specifies the total number of bytes contained in the packet
(including the Length field itself).

If the first byte of the Length field is coded “0x01” then the Length field is 3-bytes long; in this case, the two
following bytes specify the total number of bytes of the packet (most-significant byte first). Otherwise, the Length
field is only 1-byte long and specifies itself the total number of bytes contained in the packet.

The 3-byte format allows the encoding of packet lengths up to 65,535 bytes. Packets with lengths up to and including 255
bytes MUST use the shorter byte format.

Non-normative comment

MQTT-SN does not support packet fragmentation and reassembly, the maximum packet length that could be used in a network
is governed by the maximum packet size that is supported by that network, and not by the maximum length that could be
encoded by MQTT-SN.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 2.1.3 MQTT-SN Control Packet Type

The MQTT-SN Control Packet Type field is 1-byte long and specifies the MQTT-SN Control Packet type which is one of the
values shown below.

<!-- transformation-note: did ignore the gray color of the reserved entries in markdown,
     but we might focus on the content anyway (reserved entries should be clear enough from text and missing direction of flow cell value) --> 
| Name                   | Value or range | Direction of flow                           | Description                                                                                                               |
|:-----------------------|:---------------|:--------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------|
| ADVERTISE              | 0x00           | Gateway broadcast                           | Advertise the gateway presence                                                                                            |
| SEARCHGW               | 0x01           | Client broadcast                            | Client GWINFO request                                                                                                     |
| GWINFO                 | 0x02           | Gateway to Client                           | Response to a SEARCHGW                                                                                                    |
| AUTH                   | 0x03           | Client to Gateway or Gateway to Client      | Authentication handshake                                                                                                  |
| CONNECT                | 0x04           | Client to Gateway                           | Virtual Connection request                                                                                                |
| CONNACK                | 0x05           | Gateway to Client                           | Virtual Connection acknowledgement                                                                                        |
| -Reserved-             | 0x06-0x09      |                                             | Forbidden (Old Will Range)                                                                                                |
| REGISTER               | 0x0A           | Client to Gateway                           | Request topic alias                                                                                                       |
| REGACK                 | 0x0B           | Gateway to Client                           | Supply topic alias                                                                                                        |
| PUBLISH                | 0x0C           | Client to Gateway or Gateway to Client      | Publish packet                                                                                                            |
| PUBACK                 | 0x0D           | Client to Gateway or Gateway to Client      | Publish acknowledgment (QoS 1) or Publish error (Any QoS).                                                                |
| PUBCOMP                | 0x0E           | Client to Gateway or Gateway to Client      | Publish complete (QoS 2 delivery part 3)                                                                                  |
| PUBREC                 | 0x0F           | Client to Gateway or Gateway to Client      | Publish received (QoS 2 delivery part 1)                                                                                  |
| PUBREL                 | 0x10           | Client to Gateway or Gateway to Client      | Publish release (QoS 2 delivery part 2)                                                                                   |
| PUBLISH-OUT-OF BAND    | 0x11           | Client to Gateway                           | Publish packet for out of band messages which need have no session on the gateway or broker                               |
| SUBSCRIBE              | 0x12           | Client to Gateway                           | Subscribe request                                                                                                         |
| SUBACK                 | 0x13           | Gateway to Client                           | Subscribe acknowledgment                                                                                                  |
| UNSUBSCRIBE            | 0x14           | Client to Gateway                           | Unsubscribe request                                                                                                       |
| UNSUBACK               | 0x15           | Gateway to Client                           | Unsubscribe acknowledgment                                                                                                |
| PINGREQ                | 0x16           | Client to Gateway                           | PING request                                                                                                              |
| PINGRESP               | 0x17           | Gateway to Client                           | PING response                                                                                                             |
| DISCONNECT             | 0x18           | Client to Gateway or Gateway to Client      | Disconnect notification                                                                                                   |
| - Reserved -           | 0x19           |                                             | Forbidden                                                                                                                 |
| - Reserved -           | 0x1A-0x1D      |                                             | Forbidden (Old Will Range)                                                                                                |
| - Reserved -           | 0x1E-0xFD      |                                             | Forbidden                                                                                                                 |
| FORWARDERENCAPSULATION | 0xFE           | Forwarder to Client or Forwarder to Gateway | Encapsulated MQTT-SN packet                                                                                               |
| PROTECTION             | 0xFF           | Client to Gateway or Gateway to Client      | A protection envelope that can encapsulate any MQTT-SN packet with the exception of Forwarder-Encapsulation packet (0xFE) |

Table 6: Packet type listing
