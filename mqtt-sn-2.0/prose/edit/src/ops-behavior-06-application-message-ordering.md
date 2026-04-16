## Application Message ordering{#application-message-ordering}

An Ordered Topic is a Topic where the Client can be certain that the Application Messages in that Topic from the same Client and at the same QoS are received in the order they were published. «<mark title="Requirement MQTT-SN-4.6-1"><a name="MQTT-SN-4.6-1"></a>When a Server processes an Application Message that has been published to an Ordered Topic, it MUST send PUBLISH packets to consumers (for the same Topic and QoS) in the order that they were received from any given Client</mark>»\[MQTT‑SN‑4.6‑1].

«<mark title="Requirement MQTT-SN-4.6-2"><a name="MQTT-SN-4.6-2"></a>By default, a Server MUST treat every Topic as an Ordered Topic when it is forwarding Application Messages</mark>»\[MQTT‑SN‑4.6‑2]. A Server MAY provide an administrative or other mechanism to allow one or more Topics to not be treated as an Ordered Topic.

> **Informative comment**
>
> When a stream of messages is published and subscribed to an Ordered Topic with QoS 1, the final copy of each message received by the subscribers will be in the order that they were published. As no more than one message is "in-flight" at any one time, no QoS 1 message will be received after any later one even on re-connection. For example a subscriber might receive them in the order 1,2,3,3,4 but not 1,2,3,2,3,4.
