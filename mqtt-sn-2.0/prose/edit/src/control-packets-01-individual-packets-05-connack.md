<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.5 CONNACK

<!-- transformation-note: very complex table with many optionals falsifying the byte counts skipped for now,
      hopefully we can migrate to a different bitfield visualization. -->

Table 16: CONNACK packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The CONNACK packet is sent by the Gateway in response to a Virtual Connection request from a client.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.1 Length and Packet Type{#connack--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 1.4.2 for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.2 Reason Code{#CONNACK--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 3 in the CONNACK header contains the Connect Reason Code.
The values for the Connect Reason Code field are shown in Table 9: Reason Code Values.
The Server sending the CONNACK packet MUST use one of the Connect Reason Code values.

If a Server sends a CONNACK packet containing a Reason code of 128 or greater it MUST then close the Virtual Connection.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.3 Connack Flags

The Connack Flags is 1 byte field located at byte 4 which contains parameters specifying the behavior of the MQTT-SN
Virtual Connection on the gateway.

The Connack Flags field includes the following flags:

- **Session Present**: Stored in Bit 0 and specifies whether an existing session was present on the gateway for the given client identifier.
  A value of 1 indicates a session was present, a value 0 indicates no session was present.
- **Auth**: Stored in Bit 1 and specifies whether the packet contain Auth material than should be considered

The Client MUST validate that the reserved flags in the CONNACK packet are set to 0.
If any of the reserved flags is not 0 it is a Malformed Packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.4 Session Expiry Interval{#connack--session-expiry-interval}

If the Session Expiry Interval is 0, the value of Session Expiry Interval in the CONNECT Packet is used.
The server uses this property to inform the Client that it is using a value other than that sent by the Client in the CONNECT.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.5 Authentication Method Length (optional, only with Auth flag set)

Single byte value (max 0-255 bytes), representing the length of field used to specify the authentication method.
Refer to LINKED TO AUTH for more information about extended authentication.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.6 Authentication Method (optional, only with Auth flag set)

A UTF-8 Encoded String containing the name of the authentication method.
Refer to LINKED TO AUTH for more information about extended authentication.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.7 Authentication Data Length (optional, only with Auth flag set)

Two byte value (max 0-65535 bytes), representing the length of field used to specify the authentication data.
Refer to LINKED TO AUTH for more information about extended authentication.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.8 Authentication Data (optional, only with Auth flag set)

Binary Data containing authentication data.
The contents of this data are defined by the authentication method and the state of already exchanged authentication data.
Refer to LINKED TO AUTH for more information about extended authentication.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.5.8 Assigned Client Identifier

The Client Identifier assigned by the gateway when the associated CONNECT packet contained no Client Identifier.
If the Client connects using a zero length Client Identifier, the Server MUST respond with a CONNACK containing an Assigned Client Identifier.
The Assigned Client Identifier MUST be a new Client Identifier not used by any other Session currently in the Gateway.

The Assigned Client Identifier MUST be a UTF-8 Encoded String.

> Informative comment
> Assigned Client Identifiers SHOULD be less than 247 bytes so they can be accommodated in a small packet version.
> This is also to cater for devices which may not support larger Client Identifiers.

> Informative comment
> Where a transparent gateway obtains an Assigned Client Identifier which is deemed too large for a device,
> it should maintain a registry to map shorter gateway generated Client Identifiers with their versions returned from the broker.
