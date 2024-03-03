<!--
---
toc:
  auto: false
  label: Backwards Compatibility
  enumerate: Appendix E.
  children:
  - label: PUBLISH QoS -1 (Packet from MQTT-SN 1.2)
    enumerate: E.1
  - label: Length amd Packet Type
    enumerate: E.2
  - label: PUBLISH Flags
    enumerate: E.3
  - label: Topic Id
    enumerate: E.4
  - label: Data
    enumerate: E.5
---
-->
# Backwards Compatibility

## PUBLISH QoS -1 (Packet from MQTT-SN 1.2)

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
<!-- transformation-note: bitfield display candidate could be clearer that x means variable bit values for PUBLISH-M1 flags (bits). -->
| Bit          | 7                                | 6   | 5   | 4      | 3        | 2        | 1             | 0             |
|:-------------|:---------------------------------|:----|:----|:-------|:---------|:---------|:--------------|:--------------|
| Byte 1       | Length                           |     |     |        |          |          |               |               |
| Byte 2       | Packet Type (0x0C)               |     |     |        |          |          |               |               |
|              | PUBLISH-M1 FLAGS                 |     |     |        |          |          |               |               |
|              | DUP                              | QoS | QoS | Retain | Reserved | Reserved | Topic Id Type | Topic Id Type |
| Byte 3       | x                                | x   | x   | x      | 0        | 0        | x             | x             |
| Byte 4       | Topic Id MSB                     |     |     |        |          |          |               |               |
| Byte 5       | Topic Id LSB                     |     |     |        |          |          |               |               |
| Byte 6       | 0x00 – Fixed Field Value         |     |     |        |          |          |               |               |
| Byte 7       | 0x00 – Fixed Field Value         |     |     |        |          |          |               |               |
| Byte 8 ... N | Data Or (Full Topic Name + Data) |     |     |        |          |          |               |               |

Table 27: PUBLISH packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

This packet is used by both clients and gateways to publish data to a topic.

> Informative Comment
> If the Transport Layer supports broadcast, like UDP/IP,
> the PUBLISH MINUS -1 packet is generally sent using the broadcast address as destination.

## Length amd Packet Type

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 1.4.2 for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

## PUBLISH Flags

The PUBLISH Flags field is 1-byte located in Byte 3 position of the PUBLISH control packet.

The PUBLISH Flags includes the following flags:

- **Topic Id Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value.
- **QoS**: This is a 2-bit field stored in Bit 5 and 6. QoS has the same meaning as with MQTT indicating the Quality of Service.
  Set to “0b00” for QoS 0, “0b01” for QoS 1, “0b10” for QoS 2, and “0b11” for QoS -1.
  For a detailed description of the various Quality Of Service levels please refer to the operational behavior section.
- **DUP**: 1 bit field stored in Bit 7 and has the same meaning as with MQTT.
  It notes the duplicate delivery of packets.
  If the DUP flag is set to “0”, it signifies that the packet is sent for the first time.
  If the DUP flag is set to “1”, it signifies that the packet was retransmitted.
- **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT.
  The field signifies whether the existing retained message for this topic is replaced or kept.

## Topic Id

Contains the topic id value or the short topic name for which the data is published.

## Data

The published data.
