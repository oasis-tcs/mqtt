<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.21 Client Publish Procedure

After having registered successfully a topic name with the gateway,
the client can start publishing data relating to the registered topic name by sending PUBLISH packets to the gateway.
The PUBLISH packets contain the assigned topic alias.

All three QoS levels and their corresponding packet flows are supported as defined in MQTT.
The only difference is the use of topic alias instead of topic names in the PUBLISH packets.

For QoS 1 or 2 PUBLISH packets the client may receive in response to its PUBLISH an error reason code:

- The _ReasonCode="Unknown Topic Alias"_:
  in this case the client needs to register the topic name again before it can publish data related to that topic name; or
- The _ReasonCode="Congestion"_: in this the client shall stop publishing toward the gateway for at least the time _T\_WAIT_.

A Client or Gateway processes a single outbound QoS 1 or QoS 2 message at a time.

This prevents retransmitted Qos 1 and Qos 2 messages from being received out of order.

\[A Client MUST NOT send a Qos 1 or Qos 2 PUBLISH packet with a new Application Message until it has received a PUBACK or
PUBCOMP Packet with the Packet Identifier corresponding to the PUBLISH packet previously sent] \[MQTT-SN-4.21-1].
