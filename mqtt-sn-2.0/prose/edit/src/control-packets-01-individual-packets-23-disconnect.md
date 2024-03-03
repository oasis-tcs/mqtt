<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.23 DISCONNECT

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway -->
<!-- transformation-note: bitfield display candidate could be clearer that X means variable bit values for DISCONNECT flags (bits). -->
| Bit          | 7                                      | 6        | 5        | 4        | 3                   | 2                               | 1                     | 0                    |
|:-------------|:---------------------------------------|:---------|:---------|:---------|:--------------------|:--------------------------------|:----------------------|:---------------------|
| Byte 1       | Length                                 |          |          |          |                     |                                 |                       |                      |
| Byte 2       | Packet Type                            |          |          |          |                     |                                 |                       |                      |
|              | DISCONNECT FLAGS                       |          |          |          |                     |                                 |                       |                      |
|              | Reserved                               | Reserved | Reserved | Reserved | Reason Code Present | Session Expiry Interval Present | Reason String Present | Retain Registrations |
| Byte 3       | 0                                      | 0        | 0        | 0        | X                   | X                               | X                     | X                    |
| Byte 4       | Reason Code (optional)                 |          |          |          |                     |                                 |                       |                      |
| Byte 5       | Session Expiry Interval MSB (optional) |          |          |          |                     |                                 |                       |                      |
| Byte 6       | TSession Expiry Interval (optional)    |          |          |          |                     |                                 |                       |                      |
| Byte 7       | Session Expiry Interval (optional)     |          |          |          |                     |                                 |                       |                      |
| Byte 7       | Session Expiry Interval LSB (optional) |          |          |          |                     |                                 |                       |                      |
| Byte 9 ... N | Reason String (optional)               |          |          |          |                     |                                 |                       |                      |

Table 45: DISCONNECT packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

As with MQTT, the DISCONNECT packet is sent by a client to indicate that it wants to close the Virtual connection.
The gateway will acknowledge the receipt of that packet by returning a DISCONNECT to the client.
A server or gateway may also send a DISCONNECT to a client, e.g. in case a gateway, due to an error, cannot map a received packet to a client.
Upon receiving such a DISCONNECT packet, a client should try to set up the Virtual Connection again by sending a CONNECT packet to the gateway or server.

A DISCONNECT packet with a Session Expiry Interval field is sent by a client when it wants to go to the "asleep" state.
The receipt of this packet is also acknowledged by the gateway by means of a DISCONNECT packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.23.1 Length and Packet Type{#disconnect--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.23.2 Disconnect Flags

The Disconnect Flags is 1 byte field located at byte 3 which contains parameters specifying the behavior of the MQTT-SN sleep on the gateway.

The Disconnect Flags field includes the following flags:

<!-- transformation-note: rewrote first three items as minimal band-aid - we should strive for a similar approach across list items and lists
     for describing flag semantics: Either pose as question (more engaging, but unusual) or describing what the value indicates. -->
- **Reason Code Present**: Stored in Bit 3.
  Does the reason code exist on the packet?
- **Session Expiry Interval Present**: Stored in Bit 2.
  Does the session expiry interval field exist?
- **Reason String Present**: Stored in Bit 1.
  Does the reason string field exist?
- **Retain Registrations**: Stored in Bit 0 and specifies whether registrations should be retained by the gateway during the sleep state.
  "0" indicates registrations should be removed during the sleeping period and renegotiated when AWAKE or ACTIVE.
  "1" indicates registrations should be retained during the SLEEP period, and therefore not renegotiated when AWAKE or ACTIVE.

The Gateway MUST validate that the reserved flags in the DISCONNECT packet are set to 0.
If any of the reserved flags is not 0 it is a Malformed Packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.23.3 Reason Code

The Reason Code for the DISCONNECT packet is optional.
If provided, Byte 3 in the DISCONNECT control packet holds the Reason Code of the disconnection. If not provided, 0x00 (Normal disconnection) is assumed.

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
The DISCONNECT Reason Codes are shown in Table 9: Reason Code Values.
The Client or Server sending the DISCONNECT packet MUST use one of the DISCONNECT Reason Code values.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.23.4 Session Expiry Interval

<!-- transformation-note: below section reference to 3.19 "UNSUBSCRIBE" requires verification before turning into a semantic reference. -->
The Session Expiry Interval is a four-byte integer time interval measured in seconds.
If the Session Expiry Interval is set to 0 or omitted, the Session is transitioned to the "disconnected" state.
When the value of this field is greater than zero, it is deemed to be sent by a client that wants to transition to the "asleep" state,
see Section 3.19 for further details.
At this point the keep alive timer becomes obsolete until the device issues a new CONNECT.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.23.5 Reason String

Fixed Length UTF-8 Encoded String representing a clear text description of disconnection.
