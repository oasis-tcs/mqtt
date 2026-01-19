## AUTH - Authentication Exchange{#auth---authentication-exchange}

*Figure 3-4 -- AUTH Packet*

![](media/image8.png)<!-- .width="6.5in", .height="3.2222222222222223in" -->

<mark title="Ephemeral region marking">The authentication method and data is first sent by the Client as part of a CONNECT exchange. If the Server requires additional information to complete the authentication, it responds with an AUTH packet to signal that the Client generates and sends another AUTH packet with the required information and so on until the authentication is complete. The server then responds with a CONNACK message.</mark>

### AUTH Header{#auth-header}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [[2.1 Structure of an MQTT-SN Control Packet]](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

### Packet Identifier{#aae---packet-identifier}

Used to identify the corresponding CONNECT or AUTH packet. It should ideally be populated with a random Two Byte Integer value when sent from Client to Server. «<mark title="Requirement MQTT-SN-3.3.2-1"><a name="MQTT-SN-3.3.2-1"></a>When sent from Server to Client, it MUST contain the packet identifier of the CONNECT or AUTH packet being responded to</mark>»\[MQTT‑SN‑3.3.2‑1].

### Reason Code{#aae---reason-code}

«<mark title="Requirement MQTT-SN-3.3.3-1"><a name="MQTT-SN-3.3.3-1"></a>The values for the Authentication Reason Code field are shown in]{.mark} [[2.3 Reason Code]](#reason-code). [The sender of the AUTH Packet MUST use one of the Reason Codes shown as applicable to the AUTH packet</mark>»\[MQTT‑SN‑3.3.3‑1].

### Authentication Method Length{#aae---authentication-method-length}

The length of the Authentication Method string.

### Authentication Method{#aae-authentication-method}

<mark title="Ephemeral region marking">A UTF-8 Encoded String containing the name of the authentication method.</mark>

### Authentication Data{#aae---authentication-data}

<mark title="Ephemeral region marking">Binary Data containing authentication data. The contents of this data are defined by the authentication method.</mark>

### AUTH Actions{#auth-actions}

Refer to [[4.11 Authentication]](#authentication) for more information about authentication.
