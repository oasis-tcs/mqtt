<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.21 Client’s Publish Procedure

After having registered successfully a topic name with the gateway,
the client can start publishing data relating to the registered topic name by sending PUBLISH packets to the gateway.
The PUBLISH packets contain the assigned topic alias.

All three QoS levels and their corresponding packet flows are supported as defined in MQTT.
The only difference is the use of topic alias’ instead of topic names in the PUBLISH packets.

Regardless of the requested QoS level the client may receive in response to its PUBLISH a PUBACK packet which contains either:

- The ReasonCode="Unknown Topic Alias": in this case the client needs to register the topic name again before it can publish data related to that topic name; or
- The ReasonCode="Congestion": in this the client shall stop publishing toward the gateway for at least the time TWAIT.

At any point in time a client may have only one QoS level 1 or 2 PUBLISH packet outstanding in each direction;
i.e. it has to wait for the termination of this PUBLISH packet exchange before it could start a new level 1 or 2 transaction
