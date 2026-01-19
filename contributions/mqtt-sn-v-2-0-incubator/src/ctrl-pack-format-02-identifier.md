## Packet Identifier{#packet-identifier}

The Variable Header component of many of the MQTT-SN Control Packet types includes a Two Byte Integer Packet Identifier field. MQTT-SN Control Packets that require a Packet Identifier are shown in Figure 2-5.

*Figure 2-5 -- Packets with Packet Identifier*

| MQTT-SN Control Packet | Packet Identifier field |
| ----- | ----- |
| ADVERTISE | NO |
| AUTH | YES |
| CONNACK | YES |
| CONNECT | YES |
| DISCONNECT | OPTIONAL |
| FORWARDER ENCAPSULATION | NO |
| GWINFO | NO |
| PINGREQ | YES |
| PINGRESP | YES |
| PROTECTION ENCAPSULATION | NO |
| PUBACK | YES |
| PUBCOMP | YES |
| PUBLISH | YES (If QoS \> 0\) |
| PUBREC | YES |
| PUBREL | YES |
| PUBWOS | NO |
| REGACK | YES |
| REGISTER | YES |
| SEARCHGW | NO |
| SLEEPREQ | YES |
| SLEEPRESP | YES |
| SUBACK | YES |
| SUBSCRIBE | YES |
| UNSUBACK | YES |
| UNSUBSCRIBE | YES |
| WAKEUP | NO |

«<mark title="Requirement MQTT-SN-2.2-1"><a name="MQTT-SN-2.2-1"></a>Each time a Client sends a new MQTT-SN Control Packet which is identified in Figure 2-5 as requiring a Packet Identifier, it MUST assign it a non-zero Packet Identifier that is currently unused</mark>»\[MQTT‑SN‑2.2‑1].

«<mark title="Requirement MQTT-SN-2.2-2"><a name="MQTT-SN-2.2-2"></a>A PUBLISH packet MUST NOT contain a Packet Identifier if its QoS value is set to 0</mark>»\[MQTT‑SN‑2.2‑2],

«<mark title="Requirement MQTT-SN-2.2-3"><a name="MQTT-SN-2.2-3"></a>Each time a Server sends a new PUBLISH (with QoS greater than 0) MQTT-SN Control Packet it MUST assign it a non zero Packet Identifier that is currently unused</mark>»\[MQTT‑SN‑2.2‑3].

Packet Identifiers used with PUBLISH, SUBSCRIBE and UNSUBSCRIBE packets form a single, unified set of identifiers separately for the Client and the Server in a Session. A Packet Identifier cannot be used by more than one Packet at any time.

The Packet Identifier becomes available for reuse after the sender has processed the corresponding acknowledgement packet, defined as follows. In the case of a QoS 1 PUBLISH, this is the corresponding PUBACK; in the case of QoS 2 PUBLISH it is PUBCOMP or a PUBREC with a Reason Code of 0x80 or greater. For SUBSCRIBE or UNSUBSCRIBE it is the corresponding SUBACK or UNSUBACK.

«<mark title="Requirement MQTT-SN-2.2-4"><a name="MQTT-SN-2.2-4"></a>A PUBACK, PUBREC , PUBREL, or PUBCOMP packet MUST contain the same Packet Identifier as the PUBLISH packet that was originally sent. A SUBACK and UNSUBACK MUST contain the Packet Identifier that was used in the corresponding SUBSCRIBE and UNSUBSCRIBE packet respectively</mark>»\[MQTT‑SN‑2.2‑4].

The Client and Server assign Packet Identifiers independently of each other. As a result, Client-Server pairs can participate in concurrent Packet exchanges using the same Packet Identifiers.

> **Informative comment**
>
> It is possible for a Client to send a PUBLISH packet with Packet Identifier 0x1234 and then receive a different PUBLISH packet with Packet Identifier 0x1234 from its Server before it receives a PUBACK for the PUBLISH packet that it sent.

*Figure 2-6 - Publishes with the same Packet Identifier*![](media/image13.png)<!-- .width="5.2in", .height="3.2303029308836395in" -->
