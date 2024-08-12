<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.26 Retained Messages

\[If the RETAIN flag is set to 1 in a PUBLISH or PUBWOS packet received by a Server,
the Server MUST replace any existing Retained Message for this topic and store the Application Message] \[MQTT-SN-4.26-1],
so that it can be delivered to future subscribers whose subscriptions match its Topic Name.
\[If the Publish Data contains zero bytes it is processed normally by the Server but any retained message with the same topic name MUST be
removed and any future subscribers for the topic will not receive a retained message] \[MQTT-SN-4.26-2].
\[A Retained Message with a Publish Data containing zero bytes MUST NOT be stored as a Retained Message on the Server] \[MQTT-SN-4.26-3].

\[If the RETAIN flag is 0 in a PUBLISH packet sent by a Client to a Server,
the Server MUST NOT store the message as a Retained Message and MUST NOT remove or replace any existing Retained Message] \[MQTT-SN-4.26-4].

When a new Subscription is made, the last retained message, if any,
on each matching topic name is sent to the Client as directed by the Retain Handling Subscribe Flag.
These messages are sent with the RETAIN flag set to 1.
Which retained messages are sent is controlled by the Retain Handling Subscribe Flag. At the time of the Subscription:

- \[If Retain Handling is set to 0 the Server MUST send the retained messages matching the Topic Filter of the subscription to
  the Client] \[MQTT-SN-4.26-5].
- \[If Retain Handling is set to 1 then if the subscription did not already exist,
  the Server MUST send all retained messages matching the Topic Filter of the subscription to the Client,
  and if the subscription did exist the Server MUST NOT send the retained messages] \[MQTT-SN-4.26-6].
- \[If Retain Handling is set to 2, the Server MUST NOT send the retained messages] \[MQTT-SN-4.26-7].

Refer to section [3.1.17.2 "SUBSCRIBE Flags"](#subscribe-flags) for a definition of the Subscription Flags.

If the Server receives a PUBLISH packet with the RETAIN flag set to 1,
and QoS 0 it SHOULD store the new QoS 0 message as the new retained message for that topic, but MAY choose to discard it at any time.
If this happens there will be no retained message for that topic.

The setting of the RETAIN flag in an Application Message forwarded by the Server from an established Virtual Connection is controlled by
the Retain As Published subscription option.
Refer to section [3.1.17.2 "SUBSCRIBE Flags"](#subscribe-flags) for a definition of the Subscription Flags.

- \[If the value of Retain As Published subscription option is set to 0, the Server MUST set the RETAIN flag to 0 when forwarding an Application
  Message regardless of how the RETAIN flag was set in the received PUBLISH packet] \[MQTT-SN-4.26-8].
- \[If the value of Retain As Published subscription option is set to 1, the Server MUST set the RETAIN flag equal to the RETAIN flag in the received
  PUBLISH packet] \[MQTT-SN-4.26-9].

> **Informative comment**
>
> Retained messages are useful where publishers send state messages on an irregular basis.
> A new non-shared subscriber will receive the most recent state.
