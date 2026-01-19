## Reason Code{#reason-code}

A Reason Code is a one byte unsigned value that indicates the result of an operation. Reason Codes less than 0x80 indicate successful completion of an operation. The normal Reason Code for success is 0x00. Reason Code values of 0x80 or greater indicate failure.

The Reason Codes share a common set of values as shown below.

*Figure 2-7 -- Reason Codes*

| Identifier |  | Name | Packets  | Description  |
| ----- | ----- | ----- | ----- | ----- |
| Dec | Hex |  |  |  |
| 0 | 0x00 | Success | CONNACK, SUBACK, UNSUBACK, REGACK, PUBACK, PUBREC, PUBREL, PUBCOMP, SLEEPRESP, AUTH (server only) | The operation was successful. |
| 0 | 0x00 | Normal disconnection | DISCONNECT | Delete the Virtual Connection normally. Do not send the Will Message. |
| 0 | 0x00 | Granted QoS 0 | SUBACK | The subscription is accepted and the maximum QoS sent will be QoS 0\. This might be a lower QoS than was requested. |
| 1 | 0x01 | Granted QoS 1 | SUBACK | The subscription is accepted and the maximum QoS sent will be QoS 1\. This might be a lower QoS than was requested. |
| 2 | 0x02 | Granted QoS 2 | SUBACK | The subscription is accepted and any received QoS will be sent to this subscription. |
| 4 | 0x04 | Disconnect with will message | DISCONNECT (client only) | The Client wishes to disconnect but requires that the Server also publishes its Will Message.  |
| 16 | 0x10 | No matching subscribers | PUBACK, PUBREC | The Application Message is accepted but there are no subscribers. If the Server knows that there are no matching subscribers, it MAY use this Reason Code instead of 0x00 (Success). |
| 17 | 0x11 | No subscription existed | UNSUBACK | No matching Topic Filter is being used by the Client. |
| 24 | 0x18 | Continue authentication | AUTH | Continue the authentication with another step. |
| 25 | 0x19 | Re-authenticate | AUTH (client only) | Initiate a re-authentication. |
| 26 | 0x1A | Topic Alias Exists | REGACK | A Session Topic Alias was requested, but a Session or Predefined Topic Alias already exists. (MQTT-SN only) |
| 128 | 0x80 | Unspecified error | CONNACK, PUBACK, PUBREC, SUBACK, UNSUBACK, DISCONNECT | The receiver does not accept the request but either does not want to reveal the reason, or it does not match one of the other values. |
| 129 | 0x81 | Malformed packet | CONNACK, DISCONNECT | The received packet does not conform to this specification. |
| 130 | 0x82 | Protocol error | CONNACK, DISCONNECT | An unexpected or out of order packet was received. |
| 131 | 0x83 | Implementation specific error | CONNACK, PUBACK, PUBREC, REGACK, SUBACK, UNSUBACK, DISCONNECT | The packet received is valid but cannot be processed by this implementation. |
| 132 | 0x84 | Unsupported Protocol Version | CONNACK | The Server does not support the version of the MQTT or MQTT-SN protocol requested by the Client. |
| 133 | 0x85 | Client identifier not valid | CONNACK | The Client Identifier is a valid string but is not allowed by the Server. |
| 134 | 0x86 | Bad user name or password | CONNACK | The Server does not accept the User Name or Password specified by the Client  |
| 135 | 0x87 | Not authorized | CONNACK, PUBACK, PUBREC, REGACK, SUBACK, UNSUBACK, DISCONNECT (server only) | The request is not authorized. |
| 136 | 0x88 | Server unavailable | CONNACK | The MQTT-SN Server is not available or, in the case of a Transparent gateway, the MQTT server is not available. |
| 137 | 0x89 | Server busy | CONNACK, DISCONNECT (server only) | The Server is busy and cannot continue processing requests from this Client. |
| 138 | 0x8A | Banned | CONNACK | This Client has been banned by administrative action. Contact the server administrator. |
| 139 | 0x8B | Server shutting down | DISCONNECT (server only) | The Server is shutting down.  |
| 140 | 0x8C | Bad authentication method | CONNACK, DISCONNECT | The authentication method is not supported or does not match the authentication method currently in use. |
| 141 | 0x8D | Keep alive timeout | DISCONNECT (server only) | The Connection is closed because no packet has been received for 1.5 times the Keepalive time. |
| 142 | 0x8E | Session taken over | DISCONNECT (server only) | Another Connection using the same Client Identifier has connected causing this Connection to be closed. |
| 143 | 0x8F | Topic filter invalid | SUBACK, UNSUBACK, DISCONNECT (server only) | The Topic Filter is correctly formed, but is not accepted by this Server. |
| 144 | 0x90 | Topic name invalid | CONNACK, PUBACK, PUBREC, DISCONNECT (server only) | The Topic Name is correctly formed, but is not accepted by this Client or Server. |
| 145 | 0x91 | Packet identifier in use | PUBACK, PUBREC, SUBACK, UNSUBACK, REGACK, PINGRESP, SLEEPRESP | The specified Packet Identifier is already in use. |
| 146 | 0x92 | Packet identifier not found | PUBREL, PUBCOMP | The Packet Identifier is not known. This is not an error during recovery, but at other times indicates a mismatch between the Session State on the Client and Server.  |
| 147 | 0x93 | Receive maximum exceeded | DISCONNECT | The Client or Server has received more than Receive Maximum publication for which it has not sent PUBACK or PUBCOMP.  |
| 148 | 0x94 | Topic alias invalid | DISCONNECT (server only) | The Client or Server has received a PUBLISH packet containing a Topic Alias which is greater than the Maximum Topic Alias it sent in the CONNECT or CONNACK packet.  (Transparent gateway only) |
| 149 | 0x95 | Packet too large | CONNACK, DISCONNECT | The packet size is greater than Maximum Packet Size for this Client or Server. |
| 150 | 0x96 | Packet rate too high | DISCONNECT | The received data rate is too high. |
| 151 | 0x97 | Quota exceeded | REGACK, SUBACK, DISCONNECT | An implementation or administrative imposed limit has been exceeded. |
| 152 | 0x98 | Administrative action | DISCONNECT | The Virtual Connection is deleted due to an administrative action. |
| 153 | 0x99 | Payload format invalid | PUBACK, PUBREC, DISCONNECT (server only) | The MQTT payload format does not match the one specified by the Payload Format Indicator. (Transparent gateway only) |
| 154 | 0x9A | Retain not supported | CONNACK, DISCONNECT (server only) | The MQTT Server does not support retained messages. (Transparent gateway only) |
| 155 | 0x9B | QoS not supported | CONNACK, DISCONNECT (server only) | The Client specified a QoS greater than the QoS specified in a Maximum QoS in the MQTT CONNACK. (Transparent gateway only) |
| 156 | 0x9C | Use another server | CONNACK, DISCONNECT (server only) | The Client should temporarily change its Server. |
| 157 | 0x9D | Server moved | CONNACK, DISCONNECT (server only) | The Server is moved and the Client should permanently change its server location. |
| 158 | 0x9E | Shared subscription not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Shared Subscriptions. (Transparent gateway only) |
| 159 | 0x9F | Connection rate exceeded | CONNACK, DISCONNECT (server only) | This Virtual Connection is deleted because the connection rate is too high. |
| 160 | 0xAD | Maximum connect time | DISCONNECT (server only) | The maximum connection time authorized for this Virtual Connection has been exceeded. |
| 161 | 0xA1 | Subscription identifiers not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Subscription Identifiers; the subscription is not accepted. (Transparent gateway only) |
| 162 | 0xA2 | Wildcard subscription not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Wildcard Subscriptions; the subscription is not accepted. (Transparent Gateway only) |
| 230 | 0xE6 | Only PROTECTION packet supported (Note 1\) | Any packet except PROTECTION and Forwarder Encapsulation | The Receiver was expecting a packet to be Protection Encapsulated.  (MQTT-SN only) |
| 231 | 0xE7 | Protection scheme invalid | DISCONNECT | Specific to MQTT-SN |
| 232 | 0xE8 | Unknown Sender Id | DISCONNECT | Specific to MQTT-SN |
| 240 | 0xF0 | Unknown Topic Alias | PUBACK, PUBREC, SUBACK, UNSUBACK, REGACK | Specific to MQTT-SN |
| 241 | 0xF1 | Congestion | SUBACK, REGACK, CONNACK, PUBACK, PUBREC | Try again later. See [C.3 Server Congestion](#c.2-server-congestion) (MQTT-SN only) |
| 242 | 0xF2 | Protection packet not supported | DISCONNECT | Specific to MQTT-SN |
| 243 | 0xF3 | Forwarder Encapsulation not supported | DISCONNECT | Specific to MQTT-SN |
| 244 | 0xF4 | No Virtual Connection exists | DISCONNECT | Specific to MQTT-SN |
| 245 \- 255 | 0xF5 \- 0xFF | Reserved for MQTT-SN |  | Specific to MQTT-SN |

Note(s):

1.  It is used by a receiver to indicate that it expected a packet to be protected and it wasn\'t.

2.  The MQTT-SN dedicated range of reason codes is from 0xE6 (230) to 0xFF(255).
