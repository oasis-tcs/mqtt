## Packet delivery retry{#packet-delivery-retry}

There are two situations when packets that require acknowledgement are resent by the sender:

1.  when a Virtual Connection is deleted before the acknowledgement is received by the requester, and Clean Start is 0

2.  when no acknowledgment is received by the requester within a configured timeout period during the existence of a Virtual Connection

These situations are described in the following sections.

### Virtual Connection End{#virtual-connection-end}

«<mark title="Requirement MQTT-SN-4.4.1-1"><a name="MQTT-SN-4.4.1-1"></a>When a Client reconnects with Clean Start set to 0 and a Session is present, both the Client and Server MUST resend any unacknowledged PUBLISH with QoS 1 and 2 packets (not QoS 0) and PUBREL packets using their original Packet Identifiers</mark>»[MQTT‑SN‑4.4.1‑1](#tab-MQTT-SN-4.4.1-1).

«<mark title="Requirement MQTT-SN-4.4.1-2"><a name="MQTT-SN-4.4.1-2"></a>If PUBACK or PUBREC is received containing a Reason Code of 0x80 or greater, the corresponding PUBLISH packet is treated as acknowledged, and MUST NOT be retransmitted</mark>»[MQTT‑SN‑4.4.1‑2](#tab-MQTT-SN-4.4.1-2).

«<mark title="Requirement MQTT-SN-4.4.1-3"><a name="MQTT-SN-4.4.1-3"></a>The DUP flag MUST be set to 1 by the Client or Server when it attempts to resend a PUBLISH QoS 2 packet</mark>»[MQTT‑SN‑4.4.1‑3](#tab-MQTT-SN-4.4.1-3).

### Unacknowledged Packets{#unacknowledged-packets}

In MQTT-SN, any packet may not be delivered by the underlying Network. If a packet is lost, the response to a request will not arrive. In addition to the Keep Alive timer, MQTT-SN Clients and Servers may also resend any packets for which a response is expected, but not received.

The Control Packets that expect a response and must be retried if there is none, are:

- Sent by both Clients and Servers:

  - REGISTER

  - PUBLISH QoS 1 and 2

  - PUBREL

- Sent by Clients only:

  - SUBSCRIBE

  - UNSUBSCRIBE

  - SLEEPREQ

  - PINGREQ

The Control Packets in the above list, along with CONNECT and AUTH, are referred to as request Packets.

«<mark title="Requirement MQTT-SN-4.4.2-1"><a name="MQTT-SN-4.4.2-1"></a>CONNECT and AUTH Packets expect a response but MUST NOT be retried</mark>»[MQTT‑SN‑4.4.2‑1](#tab-MQTT-SN-4.4.2-1).

«<mark title="Requirement MQTT-SN-4.4.2-2"><a name="MQTT-SN-4.4.2-2"></a>The connection sequence CONNECT, zero or more AUTH Packets then CONNACK MUST be completed without retries</mark>»[MQTT‑SN‑4.4.2‑2](#tab-MQTT-SN-4.4.2-2).

«<mark title="Requirement MQTT-SN-4.4.2-3"><a name="MQTT-SN-4.4.2-3"></a>A Server MUST respond promptly to a valid
request Packet</mark>»[MQTT‑SN‑4.4.2‑3](#tab-MQTT-SN-4.4.2-3).

«<mark title="Requirement MQTT-SN-4.4.2-4"><a name="MQTT-SN-4.4.2-4"></a>A Client in the Awake and Active states MUST respond promptly to a valid request Packet</mark>»[MQTT‑SN‑4.4.2‑4](#tab-MQTT-SN-4.4.2-4).

An MQTT-SN Sender may be configured with two parameters to govern its resending of unacknowledged packets:

1.  Retry Interval

2.  Maximum Retry Count

on the basis of the expected characteristics of the Underlying Network. Example values for these are suggested in [sec](#c.3-example-timer-and-counter-values). See also [sec](#c.4-exponential-backoff) for guidance on varying the *Retry Interval* to reduce potential network congestion.

If a response to one of the above request Packets is not received in the *Retry Interval*, the Sender resends the request Packet. The request is repeated at *Retry Interval* intervals, until a response is received or the *Maximum Retry Count* is reached. After the *Maximum Retry Count* is reached and a further *Retry Interval* has passed without a response, the Virtual Connection is deleted.

«<mark title="Requirement MQTT-SN-4.4.2-5"><a name="MQTT-SN-4.4.2-5"></a>In the absence of a response to a Packet which expects one, the Sender MUST delete the Virtual Connection</mark>»[MQTT-SN-4.4.2-5](#tab-MQTT-SN-4.4.2-5). If the Sender is a Server and a Will Message is defined for the Virtual Connection, the Will Message is be published as described in [sec](#will-flag). A new Virtual Connection will have to be established to continue.

«<mark title="Requirement MQTT-SN-4.4.2-6"><a name="MQTT-SN-4.4.2-6"></a>If a Packet is retransmitted, it MUST have Protection Encapsulation if the previously transmitted Packet had Protection Encapsulation</mark>»[MQTT‑SN‑4.4.2‑6](#tab-MQTT-SN-4.4.2-6).

«<mark title="Requirement MQTT-SN-4.4.2-7"><a name="MQTT-SN-4.4.2-7"></a>If a Packet is retransmitted it MUST be identical to the previously transmitted Packet. The Protection Encapsulation need not be identical</mark>»[MQTT‑SN‑4.4.2‑7](#tab-MQTT-SN-4.4.2-7).

> **Informative comment**
>
> The value of the *Retry Interval* is not specified by MQTT-SN, however, to be useful it ought to be longer than the network round trip time. If it is excessively long, the time taken to detect and retransmit lost Packets will also be excessively long. Implementers need to take care not to use a retry interval that might cause the network to become congested with retried Packets.
>
> **Informative comment**
>
> To be useful, and depending on the reliability characteristics of the Underlying Network, the retry cycle should be shorter than the Keep Alive interval. If it is not, then a Keep Alive timeout may occur during the retry cycle, causing the Virtual Connection to be deleted, and the rest of the retry cycle to be ineffective.
