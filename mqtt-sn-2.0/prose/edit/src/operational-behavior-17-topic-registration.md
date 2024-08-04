## 4.17 Topic Registration

Because of the limited bandwidth and the small packet payload in wireless sensor networks,
data is not published together with its topic name as in MQTT.
A registration procedure is introduced which allows both a client and a gateway to inform its peer about the short topic alias and
its corresponding topic name before it can start sending PUBLISH packets using the short topic alias.

A topic alias is a two-byte long replacement of the string-based topic name.
A client needs to use the REGISTER procedure to inform the gateway about the topic name it wants to employ and
gets the corresponding topic alias from the gateway.
It then will use this topic alias in the PUBLISH packets it sends to the gateway.
In the opposite direction, the PUBLISH packets also contain a 2-byte topic alias (instead of the string-based topic name).
The client is informed about the relation between topic alias and topic name by means of either a former SUBSCRIBE procedure,
or a REGISTER procedure started by the gateway.

To register a topic name a client sends a REGISTER packet to the Server.
If the registration could be accepted, the gateway assigns a _topic alias_ to the received topic name and returns it with a REGACK packet to the client.

If the client initiates a REGISTER against a topic which is known by the Server to have a predefined topic alias associated with it,
it is an error case, but one which should not be terminal to the session since gateway updates could lead to this scenario.
The gateway will specify its topic alias type to be predefined and set the topic alias value to match that defined on the gateway in the REGACK,
it will also set a reason code on the REGACK to indicate the issue.
The client can then choose to update its registry of predefined topic aliases if it so wishes.

\[If a Client sends a PUBLISH to a predefined topic alias, which is not defined on the Server, this is considered a protocol violation.] \[MQTT-SN-???].

If there are no predefined topic aliases, the gateway will pass back a SESSION topic alias type.
If the registration can not be accepted, a REGACK is also returned to the client with the failure reason encoded in the _ReasonCode_ field.

After having received the REGACK packet with _ReasonCode="accepted"_,
the client shall use the assigned _topicId_ to publish data of the corresponding topic name.
If, however, the REGACK contains a rejection code, the client may try to register later again.
If the Reason Code was _"Congestion"_, the client should wait for a time _T\_WAIT_ before restarting the registration procedure.

At any point in time a client may have only one REGISTER packet outstanding, i.e.,
it must wait for a REGACK packet before it can register another topic name.

A gateway sends a REGISTER packet to a client if it wants to inform that client about the topic name and
the assigned topic alias that it will use later when sending PUBLISH packets of the corresponding topic name.
This happens for example when no prior registrations exists, or when the client has DISCONNECTED with retain registration false,
or the client re-connects without having set the "CleanStart" flag or
the client has subscribed to topic names that contain wildcard characters such as \# or +.

> **Informative comment**
>
> The gateway should attempt to make the best effort to reuse the same topic alias mappings that existed during any initial associated ACTIVE states.

