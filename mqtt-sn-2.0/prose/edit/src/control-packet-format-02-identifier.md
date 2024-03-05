<!-- transformation-note: left upstream numbering of headings for verification -->
## 2.2 Packet Identifier

The Variable Header component of many of the MQTT-SN Control Packet types includes a Two Byte Integer Packet Identifier
field. MQTT-SN Control Packets that require a Packet Identifier are shown below[f]:

| MQTT-SN Control Packet | Packet Identifier field |
|:-----------------------|:------------------------|
| CONNECT                |  NO                     |
| CONNACK                |  NO                     |
| PUBLISH                |  YES (If QoS > 0)       |
| PUBLISHOOB             |  NO                     |
| PUBACK                 |  YES                    |
| PUBREC                 |  YES                    |
| PUBREL                 |  YES                    |
| PUBCOMP                |  YES                    |
| SUBSCRIBE              |  YES                    |
| SUBACK                 |  YES                    |
| UNSUBSCRIBE            |  YES                    |
| UNSUBACK               |  YES                    |
| PINGREQ                |  NO                     |
| PINGRESP               |  NO                     |
| DISCONNECT             |  NO                     |
| AUTH                   |  NO                     |
| ADVERTISE              |  NO                     |
| SEARCHGW               |  NO                     |
| GWINFO                 |  NO                     |
| REGISTER               |  YES                    |
| REGACK                 |  YES                    |
| Encapsulated Packet    |  NO                     |
| PROTECTION             |  NO                     |

Table 8: Packets with Packet Identifier

A PUBLISH packet MUST NOT contain a Packet Identifier if its QoS value is set to 0.

A PUBLISH packet MUST NOT contain a Packet Identifier if its QoS value is set to -1.

Each time a Client sends a new SUBSCRIBE, UNSUBSCRIBE, or PUBLISH (where QoS > 0 and it is not OUT OF BAND) MQTT Control Packet it
MUST assign it a non-zero Packet Identifier that is currently unused.

Each time a Gateway sends a new PUBLISH (with QoS > 0) MQTT-SN Control Packet it
MUST assign it a non zero Packet Identifier that is currently unused.

The Packet Identifier becomes available for reuse after the sender has processed the corresponding acknowledgement packet,
defined as follows.
In the case of a QoS 1 PUBLISH, this is the corresponding PUBACK;
in the case of QoS 2 PUBLISH it is PUBCOMP or a PUBREC with a Reason Code of 128 or greater.
For SUBSCRIBE or UNSUBSCRIBE it is the corresponding SUBACK or UNSUBACK.

Packet Identifiers used with PUBLISH, SUBSCRIBE and UNSUBSCRIBE packets form a single,
unified set of identifiers separately for the Client and the Gateway in a Session.
A Packet Identifier cannot be used by more than one command at any time.

A PUBACK, PUBREC , PUBREL, or PUBCOMP packet MUST contain the same Packet Identifier as the PUBLISH packet that was originally sent.
A SUBACK and UNSUBACK MUST contain the Packet Identifier that was used in the corresponding SUBSCRIBE and UNSUBSCRIBE packet respectively.

The Client and Gateway assign Packet Identifiers independently of each other.
As a result, Client-Server pairs can participate in concurrent message exchanges using the same Packet Identifiers.

> **Informative comment**:
> It is possible for a Client to send a PUBLISH packet with Packet Identifier 0x1234 and then receive a
> different PUBLISH packet with Packet Identifier 0x1234 from its Server before it receives a PUBACK for
> the PUBLISH packet that it sent.
<!-- transformation-note: sequence diagram missing in transform (present in upstream source) of informative comment -->
