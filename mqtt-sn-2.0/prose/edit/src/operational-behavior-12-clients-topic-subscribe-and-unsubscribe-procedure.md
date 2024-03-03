<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.12 Client’s Topic Subscribe/Unsubscribe Procedure

To subscribe to a topic name, a client sends a SUBSCRIBE packet to the gateway with the topic name included in that packet.
If the gateway is able accept the subscription, it assigns a topic alias to the received topic name and returns it within a SUBACK packet to the client.
If the subscription cannot be accepted, then a SUBACK packet is also returned to the client with the rejection cause encoded in the ReasonCode field.
If the rejection cause is "Congestion", the client should wait for the time TWAIT before resending the SUBSCRIBE packet to the gateway.

If the client subscribes to a topic name which contains a wildcard character, the returning SUBACK packet will contain the topic alias value 0x0000.
The gateway will use the registration procedure to inform the client about the to-be-used topic alias value when it has the first PUBLISH packet with
a matching topic name to be sent to the client.

Similar to the client’s PUBLISH procedure, topic alias’ may also be pre-defined for certain topic names.
Short topic names may be used as well. In those two cases the client still needs to subscribe to those pre-defined topic alias’ or short topic names.

To unsubscribe, a client sends an UNSUBSCRIBE packet to the gateway, which will then be answered by means of an UNSUBACK packet.

As for the REGISTER procedure, a client may have only one SUBSCRIBE or one UNSUBSCRIBE transaction open at a time.
