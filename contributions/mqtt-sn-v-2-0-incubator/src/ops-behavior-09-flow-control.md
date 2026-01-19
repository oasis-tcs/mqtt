## Flow Control{#flow-control}

The maximum number of unacknowledged MQTT-SN requests in one direction within a Virtual Connection for both Clients and Servers is 1. The packets which need acknowledgement and are included in this constraint are:

- PUBLISH (QoS 1 and 2), PUBREC and PUBREL

- REGISTER

- SUBSCRIBE

- UNSUBSCRIBE

- PINGREQ

- SLEEPREQ

- AUTH

I«<mark title="Requirement MQTT-SN-4.9-1"><a name="MQTT-SN-4.9-1"></a>f a Client or Server receives an MQTT-SN request (from the above list) and there is already a request outstanding from the other party within the same Virtual Connection and a different Packet Identifier, then it MUST issue a DISCONNECT with Reason Code 147 (Receive Maximum Exceeded) and delete the Virtual Connection</mark>»\[MQTT‑SN‑4.9‑1].

«<mark title="Requirement MQTT-SN-4.9-2"><a name="MQTT-SN-4.9-2"></a>A Server or Client MUST NOT send a new Packet of a type from the above list, when it has an acknowledgement outstanding for another Packet for which it has not received an acknowledgement</mark>»\[MQTT‑SN‑4.9‑2].

A sender MAY retry a request (send the same Packet) when it is expecting an acknowledgement and none has been received. See [[4.4 Packet delivery retry]](#packet-delivery-retry) for more information on Packet retries.

> **Informative comment**
>
> The sender might choose to suspend the sending of QoS 0 PUBLISH packets when it suspends the sending of QoS 1 and QoS 2 PUBLISH packets because a request is outstanding.
>
> **Informative Comment**
>
> It is possible to publish PUBWOS packets in the middle of a QoS 1 or QoS 2 exchange.

Refer to [[3.6.3.7 PUBLISH Actions]](#publish-actions) for a description of how Clients and Servers react if they are sent more than one unacknowledged packet.
