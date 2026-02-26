## Quality of Service levels and protocol flows{#quality-of-service-levels-and-protocol-flows}

MQTT-SN delivers Application Messages according to the Quality of Service (QoS) levels defined in the following sections. The delivery protocol is symmetric - in the description below the role of the sender can be taken by the Client with the Server being the receiver, or the role of the sender can be taken by the Server with the Client being the receiver. When the Server is delivering an Application Message to more than one Client, each Client is treated independently. The QoS level used to deliver an Application Message outbound to the Client could differ from that of the inbound Application Message.

### Publish without session{#publish-without-session}

No Session or Virtual Connection is required to send a message. The message is delivered according to the capabilities of the underlying network. No response is sent by the receiver and no retry is performed by the sender. The message arrives at the receiver either once or not at all.

<mark title="Ephemeral region marking">In the PUBWOS delivery protocol, the sender</mark>

- «<mark title="Requirement MQTT-SN-4.3.1-1"><a name="MQTT-SN-4.3.1-1"></a>MUST send a PUBWOS packet</mark>»\[MQTT‑SN‑4.3.1‑1].

<mark title="Ephemeral region marking">The receiver:</mark>

- MAY decide to accept ownership of the message when it receives a PUBWOS packet.

- «<mark title="Requirement MQTT-SN-4.3.1-2"><a name="MQTT-SN-4.3.1-2"></a>MUST treat any accepted messages as QoS 0</mark>»\[MQTT‑SN‑4.3.1‑2].

**Informative Comment:**

Each PUBWOS packet may be received and processed by more than one receiver.

### QoS 0: At most once delivery{#qos-0-at-most-once-delivery}

The message is delivered according to the capabilities of the underlying network. No response is sent by the receiver and no retry is performed by the sender. The message arrives at the receiver either once or not at all.

<mark title="Ephemeral region marking">In the QoS 0 delivery protocol, the sender</mark>

- «<mark title="Requirement MQTT-SN-4.3.2-1"><a name="MQTT-SN-4.3.2-1"></a>MUST send a PUBLISH packet with QoS 0</mark>»\[MQTT‑SN‑4.3.2‑1].

In the QoS 0 delivery protocol, the receiver

- Accepts ownership of the message when it receives the PUBLISH packet.

*Figure 4-3 -- QoS 0 protocol flow, informative example*

| Sender Action |    Control Packet    | Receiver action                                                |
|:--------------|:--------------------:|:---------------------------------------------------------------|
| PUBLISH QoS 0 |                      |                                                                |
|               | \-\-\-\-\-\-\-\-\--> |                                                                |
|               |                      | Deliver Application Message to appropriate onward recipient(s) |

Table: QoS 0 protocol flow, informative example

### QoS 1: At least once delivery{#qos-1-at-least-once-delivery}

This Quality of Service level ensures that the message arrives at the receiver at least once. A QoS 1 PUBLISH packet has a Packet Identifier in its Variable Header and is acknowledged by a PUBACK packet.

<mark title="Ephemeral region marking">In the QoS 1 delivery protocol, the sender</mark>

- «<mark title="Requirement MQTT-SN-4.3.3-1"><a name="MQTT-SN-4.3.3-1"></a>MUST assign an unused Packet Identifier each time it has a new Application Message to publish</mark>»\[MQTT‑SN‑4.3.3‑1].

- «<mark title="Requirement MQTT-SN-4.3.3-2"><a name="MQTT-SN-4.3.3-2"></a>MUST send a PUBLISH packet containing this Packet Identifier with QoS 1 and DUP flag set to 0</mark>»\[MQTT‑SN‑4.3.3‑2].

- «<mark title="Requirement MQTT-SN-4.3.3-3"><a name="MQTT-SN-4.3.3-3"></a>MUST treat the PUBLISH packet as "unacknowledged" until it has received the corresponding PUBACK packet from the receiver</mark>»\[MQTT‑SN‑4.3.3‑3].

The Packet Identifier becomes available for reuse once the sender has received the PUBACK packet.

The sender is NOT permitted to send further packets with different Packet Identifiers while it is waiting to receive acknowledgements. «<mark title="Requirement MQTT-SN-4.3.3-4"><a name="MQTT-SN-4.3.3-4"></a>At all times a Sender MUST have a maximum of one unacknowledged packet</mark>»\[MQTT‑SN‑4.3.3‑4].

<mark title="Ephemeral region marking">In the QoS 1 delivery protocol, the receiver</mark>

- «<mark title="Requirement MQTT-SN-4.3.3-5"><a name="MQTT-SN-4.3.3-5"></a>MUST respond with a PUBACK packet containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message</mark>»\[MQTT‑SN‑4.3.3‑5].

- «<mark title="Requirement MQTT-SN-4.3.3-6"><a name="MQTT-SN-4.3.3-6"></a>after it has sent a PUBACK packet, MUST treat any incoming PUBLISH packet that contains the same Packet Identifier as being a new Application Message</mark>»\[MQTT‑SN‑4.3.3‑6].

*Figure 4-4 -- QoS 1 protocol flow, informative example*

| Sender Action                                     | MQTT-SN Control Packet  | Receiver action                                         |
|:--------------------------------------------------|:-----------------------:|:--------------------------------------------------------|
| Store message                                     |                         |                                                         |
| Send PUBLISH QoS 1, DUP=0, &lt;Packet Identifier> |  \-\-\-\-\-\-\-\-\-->   |                                                         |
|                                                   |                         | Initiate onward delivery of the Application Message (1) |
|                                                   | &lt;\-\-\-\-\-\-\-\-\-- | Send PUBACK &lt;Packet Identifier>                      |
| Discard message                                   |                         |                                                         |

Table: QoS 1 protocol flow, informative example

> ^1^The receiver does not need to complete delivery of the Application Message before sending the PUBACK. When its original sender receives the PUBACK packet, ownership of the Application Message is transferred to the receiver.

### QoS 2: Exactly once delivery{#qos-2-exactly-once-delivery}

This is the highest Quality of Service level, for use when neither loss nor duplication of Application Messages are acceptable. There is an increased overhead associated with QoS 2.

<mark title="Ephemeral region marking">In the QoS 2 delivery protocol, the sender</mark>:

- «<mark title="Requirement MQTT-SN-4.3.4-1"><a name="MQTT-SN-4.3.4-1"></a>MUST assign an unused Packet Identifier when it has a new Application Message to publish</mark>»\[MQTT‑SN‑4.3.4‑1]

- «<mark title="Requirement MQTT-SN-4.3.4-2"><a name="MQTT-SN-4.3.4-2"></a>MUST send a PUBLISH packet containing this Packet Identifier with QoS equal to 2</mark>»\[MQTT‑SN‑4.3.4‑2]

- «<mark title="Requirement MQTT-SN-4.3.4-3"><a name="MQTT-SN-4.3.4-3"></a>MUST set the DUP flag to 0 when it attempts to send a PUBLISH packet for the first time</mark>»\[MQTT‑SN‑4.3.4‑3]

- «<mark title="Requirement MQTT-SN-4.3.4-4"><a name="MQTT-SN-4.3.4-4"></a>MUST set the DUP flag to 1 when it attempts to resend a PUBLISH packet</mark>»\[MQTT‑SN‑4.3.4‑4]

- «<mark title="Requirement MQTT-SN-4.3.4-5"><a name="MQTT-SN-4.3.4-5"></a>MUST treat the PUBLISH packet as "unacknowledged" until it has received the corresponding PUBREC packet from the receiver</mark>»\[MQTT‑SN‑4.3.4‑5]

- «<mark title="Requirement MQTT-SN-4.3.4-6"><a name="MQTT-SN-4.3.4-6"></a>MUST send a PUBREL packet when it receives a PUBREC packet from the receiver with a Reason Code value less than 0x80. This PUBREL packet MUST contain the same Packet Identifier as the original PUBLISH packet</mark>»\[MQTT‑SN‑4.3.4‑6]

- «<mark title="Requirement MQTT-SN-4.3.4-7"><a name="MQTT-SN-4.3.4-7"></a>MUST treat the PUBREL packet as "unacknowledged" until it has received the corresponding PUBCOMP packet from the receiver</mark>»\[MQTT‑SN‑4.3.4‑7]

- «<mark title="Requirement MQTT-SN-4.3.4-8"><a name="MQTT-SN-4.3.4-8"></a>MUST NOT resend the PUBLISH once it has sent the corresponding PUBREL packet</mark>»\[MQTT-SN-4.3.4-8\]

The Packet Identifier becomes available for reuse once the sender has received the PUBCOMP packet or a PUBREC with a Reason Code of 0x80 or greater.

<mark title="Ephemeral region marking">In the QoS 2 delivery protocol, the receiver</mark>:

- «<mark title="Requirement MQTT-SN-4.3.4-9"><a name="MQTT-SN-4.3.4-9"></a>MUST respond with a PUBREC containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message</mark>»\[MQTT‑SN‑4.3.4‑9]

- «<mark title="Requirement MQTT-SN-4.3.4-10"><a name="MQTT-SN-4.3.4-10"></a>If it has sent a PUBREC with a Reason Code of 0x80 or greater, the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message</mark>»\[MQTT‑SN‑4.3.4‑10]

- «<mark title="Requirement MQTT-SN-4.3.4-11"><a name="MQTT-SN-4.3.4-11"></a>Until it has received the corresponding PUBREL packet, the receiver MUST acknowledge any subsequent PUBLISH packet with the same Packet Identifier by sending a PUBREC. It MUST NOT cause duplicate messages to be delivered to any onward recipients in this case</mark>»\[MQTT‑SN‑4.3.4‑11]

- «<mark title="Requirement MQTT-SN-4.3.4-12"><a name="MQTT-SN-4.3.4-12"></a>MUST respond to a PUBREL packet by sending a PUBCOMP packet containing the same Packet Identifier as the PUBREL</mark>»\[MQTT‑SN‑4.3.4‑12]

- «<mark title="Requirement MQTT-SN-4.3.4-13"><a name="MQTT-SN-4.3.4-13"></a>After it has sent a PUBCOMP, the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message, irrespective of the setting of its DUP flag</mark>»\[MQTT‑SN‑4.3.4‑13]

*Figure 4-5 -- QoS 2 protocol flow, informative example*

| **Sender Action**                                             | **MQTT-SN Control Packet** | **Receiver Action**                                                                                                  |
|:--------------------------------------------------------------|:--------------------------:|:---------------------------------------------------------------------------------------------------------------------|
| Store message                                                 |                            |                                                                                                                      |
| PUBLISH QoS 2, DUP=0&lt;Packet Identifier>                    |                            |                                                                                                                      |
|                                                               |   \-\-\-\-\-\-\-\-\--\>    |                                                                                                                      |
|                                                               |                            | Store &lt;Packet Identifier> and message                                                                             |
|                                                               |                            | PUBREC &lt;Packet Identifier>&lt;Reason Code>                                                                        |
|                                                               |  &lt;\-\-\-\-\-\-\-\-\--   |                                                                                                                      |
| Discard message, Store PUBREC received &lt;Packet Identifier> |                            |                                                                                                                      |
| PUBREL &lt;Packet Identifier>                                 |                            |                                                                                                                      |
|                                                               |   \-\-\-\-\-\-\-\-\--\>    |                                                                                                                      |
|                                                               |                            | Initiate onward delivery of the Application Message (1) <br><br> then discard the message and &lt;Packet Identifier> |
|                                                               |                            | Send PUBCOMP &lt;Packet Identifier>                                                                                  |
|                                                               |  &lt;\-\-\-\-\-\-\-\-\--   |                                                                                                                      |
| Discard stored state                                          |                            |                                                                                                                      |

Table: QoS 2 protocol flow, informative example

> ^1^ The receiver does not need to complete delivery of the Application Message before sending the PUBREC or PUBCOMP. When its original sender receives the PUBREC packet, ownership of the Application Message is transferred to the receiver. However, the receiver needs to perform all checks for conditions which might result in a forwarding failure (for example, quota exceeded or authorization) before accepting ownership. The receiver indicates success or failure using the appropriate Reason Code in the PUBREC.
