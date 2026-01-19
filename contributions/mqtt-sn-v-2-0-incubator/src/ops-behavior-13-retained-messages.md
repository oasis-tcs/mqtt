## Retained Messages{#retained-messages}

«<mark title="Requirement MQTT-SN-4.13-3"><a name="MQTT-SN-4.13-3"></a>If the RETAIN flag is set to 1 in a PUBLISH or PUBWOS packet received by a Server, the Server MUST replace any existing Retained Message for this topic and store the Application Message]{.mark} \<mark title="Ephemeral region marking">MQTT-SN-4.13-1\], so that it can be delivered to future subscribers whose subscriptions match its Topic Name. [If the Publish Data contains zero bytes it is processed normally by the Server but any retained message with the same topic name MUST be removed and any future subscribers for the topic will not receive a retained message</mark> \[MQTT-SN-4.13-2\]. [A Retained Message with a Publish Data containing zero bytes MUST NOT be stored as a Retained Message on the Server</mark>»\[MQTT‑SN‑4.13‑3].

«<mark title="Requirement MQTT-SN-4.13-4"><a name="MQTT-SN-4.13-4"></a>If the RETAIN flag is 0 in a PUBLISH packet sent by a Client to a Server, the Server MUST NOT store the message as a Retained Message and MUST NOT remove or replace any existing Retained Message</mark>»\[MQTT‑SN‑4.13‑4].

When a new Subscription is made, the last retained message, if any, on each matching topic name is sent to the Client as directed by the Retain Handling Subscribe Flag. These messages are sent with the RETAIN flag set to 1. Which retained messages are sent is controlled by the Retain Handling Subscribe Flag. At the time of the Subscription:

- «<mark title="Requirement MQTT-SN-4.13-5"><a name="MQTT-SN-4.13-5"></a>If Retain Handling is set to 0 the Server MUST send the retained messages matching the Topic Filter of the subscription to the Client</mark>»\[MQTT‑SN‑4.13‑5].

- «<mark title="Requirement MQTT-SN-4.13-6"><a name="MQTT-SN-4.13-6"></a>If Retain Handling is set to 1 then if the subscription did not already exist, the Server MUST send all retained messages matching the Topic Filter of the subscription to the Client, and if the subscription did exist the Server MUST NOT send the retained messages.</mark>»\[MQTT‑SN‑4.13‑6].

- «<mark title="Requirement MQTT-SN-4.13-7"><a name="MQTT-SN-4.13-7"></a>If Retain Handling is set to 2, the Server MUST NOT send the retained messages</mark>»\[MQTT‑SN‑4.13‑7].

Refer to [[3.7.2 SUBSCRIBE Flags]](#subscribe-flags) for a definition of the Subscription Flags.

If the Server receives a PUBLISH packet with the RETAIN flag set to 1, and QoS 0 it SHOULD store the new QoS 0 message as the new retained message for that topic, but MAY choose to discard it at any time. If this happens there will be no retained message for that topic.

The setting of the RETAIN flag in an Application Message forwarded by the Server from an established Virtual Connection is controlled by the Retain As Published subscription option. Refer to [[3.7.2 SUBSCRIBE Flags]](#subscribe-flags) for a definition of the Subscription Flags.

- «<mark title="Requirement MQTT-SN-4.13-8"><a name="MQTT-SN-4.13-8"></a>If the value of Retain As Published subscription option is set to 0, the Server MUST set the RETAIN flag to 0 when forwarding an Application Message regardless of how the RETAIN flag was set in the received PUBLISH packet</mark>»\[MQTT‑SN‑4.13‑8].

- «<mark title="Requirement MQTT-SN-4.13-9"><a name="MQTT-SN-4.13-9"></a>If the value of Retain As Published subscription option is set to 1, the Server MUST set the RETAIN flag equal to the RETAIN flag in the received PUBLISH packet</mark>»\[MQTT‑SN‑4.13‑9].

> **Informative comment**
>
> Retained messages are useful where publishers send state messages on an irregular basis. A new subscriber will receive the most recent state.
>
> **Informative comment**
>
> As in MQTT 3.1.1 there is no notion of message expiry in MQTT-SN, including expiry of Retained Messages. It is an administrative decision under what conditions to remove Retained Messages, if at all. They should be kept long enough to support the expectations of the applications that will use the Server, at a minimum.
