<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.22 Gateway Publish Procedure

Like the client publish procedure described in section [4.21 "Client's Publish Procedure"](#client-publish-procedure),
the gateway sends PUBLISH packets with the topic alias value that was returned in the SUBACK packet to the client.

Preceding the PUBLISH packet the gateway may send a REGISTER packet to inform the client about the topic name and its assigned topic alias value.
This will happen for example when the client re-connects without clean start or has subscribed to topic names with wildcard characters.
Upon receiving a REGISTER packet the client replies with a REGACK packet.
The gateway will wait for the REGACK packet before it sends the PUBLISH packet to the client.

The client could reject the REGISTER packet with a REGACK packet indicating the rejection reason;
this corresponds to an unsubscribe to the topic name indicated in the REGISTER packet.
Note that unsubscribe to a topic name with wildcard characters can only be done with the unsubscribe procedure and not with the rejection of
a REGISTER packet, since a REGISTER packet never contains a topic name with wildcard characters.

If the client receives a PUBLISH packet with an unknown topic alias value,
it shall respond with a PUBACK packet with the _ReasonCode="Unknown Topic Alias"_.
This will trigger the gateway to delete or correct the wrong topic alias assignment.

Note that in case either the topic name or the data is too long to fit into a REGISTER or a PUBLISH packet,
the gateway silently aborts the publish procedure, i.e. no warning is sent to the affected subscribers.

\[A Gateway MUST NOT send a Qos 1 or Qos 2 PUBLISH packet with a new Application Message until it has received a PUBACK or PUBCOMP Packet with
the Packet Identifier corresponding to the PUBLISH packet previously sent.]
