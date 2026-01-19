## 1.3 Terminology{#terminology}

The keywords \"MUST\", \"MUST NOT\", \"REQUIRED\", \"SHALL\", \"SHALL NOT\", \"SHOULD\", \"SHOULD NOT\", \"RECOMMENDED\", \"MAY\", and \"OPTIONAL\" in this specification are to be interpreted as described in IETF RFC 2119 \[RFC2119\], except where they appear in text that is marked as non-normative.

**Datagram:**

An independent, self-contained sequence of bytes. If received, the contents of a datagram must be correct.

**Underlying Network:**

The underlying network which provides the means to send datagrams from one network endpoint to another.

**Network Address:**

A unique label provided by the Underlying Network to identify a network endpoint.

To receive datagrams, an MQTT-SN Client or Server listens to the network for packets addressed to a specific Network Address.

**Network Identity:**

The identity used to establish that a sequence of datagrams originates from the same sender. This could be, for example:

- A Network Address

- A DTLS connection ID

- An MQTT-SN Protection Packet Sender Identifier

**Virtual Connection:**

An MQTT-SN construct corresponding to the network connection in MQTT. It associates a Network Identity with a Session, by means of the Client Identifier.

**Application Message:**

The data carried by the MQTT-SN (or MQTT) protocols across the network for the application. When an Application Message is transported by MQTT-SN (or MQTT) it contains payload data, a Quality of Service (QoS), and a Topic Name.

**Client:**

A program or device that uses MQTT-SN. An MQTT-SN Client does one or more of the following:

- creates a Virtual Connection to a Server, then:

  - publishes Application Messages that other Clients might be interested in.

  - subscribes to request Application Messages that it is interested in receiving.

  - unsubscribes to remove a request for Application Messages.

  - deletes the Virtual Connection to the Server.

- without using a Virtual Connection

  - publishes Application Messages to one or more recipients.

**Server:**

A program or device that acts as an intermediary between Clients which publish Application Messages and Clients which have made Subscriptions.

A Server does one or more of the following:

- accepts CONNECT requests from Clients and then:

  - accepts Application Messages published by Clients.

  - processes Subscribe and Unsubscribe requests from Clients.

  - forwards Application Messages that match Client Subscriptions.

  - accepts DISCONNECT requests from connected Clients.

- without using a Virtual Connection:

  - accepts Application Messages.

- opens an MQTT Network Connection to an MQTT Server, then:

  - accepts Application Messages from the MQTT Server and forwards some or all to MQTT-SN Clients.

  - accepts Application Messages from MQTT-SN Clients and forwards some or all to the MQTT Server.

- opens an MQTT Network Connection to an MQTT Server when an MQTT-SN CONNECT request is received, then:

  - forwards equivalent MQTT packets to the MQTT Server for each MQTT-SN packet received

  - forwards equivalent MQTT-SN packets to the MQTT-SN Client for each MQTT packet received

  - closes the MQTT Network Connection when the MQTT-SN Virtual Connection is deleted

<!-- -->

- 

- accepts Application Messages from MQTT-SN Clients and forwards some or all to the MQTT Server.

**Gateway:**

An MQTT-SN Server that uses one or more TCP connections to communicate with an MQTT Server.

**MQTT Client:**

A program or device that uses MQTT. An MQTT Client:

- opens the Network Connection to the MQTT Server.

- publishes Application Messages that other MQTT (or MQTT-SN) Clients might be interested in.

- subscribes to request Application Messages that it is interested in receiving.

- unsubscribes to remove a request for Application Messages.

- closes the Network Connection to the Server.

**MQTT Server:**

A program or device that acts as an intermediary between MQTT Clients which publish Application Messages and MQTT Clients which have made Subscriptions.

Also known informally as an MQTT **Broker**.

An MQTT Server:

- accepts Network Connections from MQTT Clients.

- accepts Application Messages published by MQTT Clients.

- processes Subscribe and Unsubscribe requests from MQTT Clients.

- forwards Application Messages that match MQTT Client Subscriptions.

- closes the Network Connection from the MQTT Client.

**Client Identifier:**

A UTF-8 encoded character string which uniquely identifies every Client connecting to a Server.

**Session:**

A stateful interaction between a Client and a Server which is associated with a Client Identifier. Some Sessions last only as long as the Virtual Connection, others can span multiple consecutive Virtual Connections between a Client and a Server.

**Session State:**

The set of data that describes a Session. The Session State held by a Client is different to that held by a Server. See [[4.1 Session state]](#session-state) for details.

**Subscription:**

A Subscription comprises a Topic Filter and a maximum QoS. A Subscription is associated with a single Session. A Session can contain more than one Subscription. Each Subscription within a Session has a different Topic Filter.

**Wildcard Subscription:**

A Wildcard Subscription is a Subscription with a Topic Filter containing one or more wildcard characters. This allows the subscription to match more than one Topic Name. Refer to [[4.7.1.1 Topic wildcards]](#topic-wildcards) for a description of wildcard characters in a Topic Filter.

**Topic Name:**

A label attached to an Application Message which is matched against the Subscriptions known to the Server.

**Topic Alias:**

A Topic Alias is a Two Byte Integer value that is used to identify the Topic instead of using the Topic Name. This reduces Packet sizes, and is useful when the Topic Names are long and the same Topic Names are used repetitively within a Virtual Connection.

**Topic Filter:**

An expression contained in a Subscription to indicate an interest in one or more topics. A Topic Filter can include wildcard characters and can match more than one Topic Name.

**MQTT-SN Control Packet:**

A packet of information that is sent to a Network Address.

**Malformed Packet:**

A Control Packet that cannot be parsed according to this specification. Refer to [[4.12 Handling errors]](#handling-errors) for information about error handling.

**Protocol Error:**

An error that is detected after the packet has been parsed and found to contain data that is not allowed by the protocol or is inconsistent with the state of the Client or Server. Refer to [[4.12 Handling errors]](#handling-errors) for information about error handling.

**Will Message:**

An Application Message which is published by the Server after the Virtual Connection is deleted in cases where the Virtual Connection is not deleted normally. Refer to [[3.1.3 Will Flags]](#will-flags) for information about Will Messages.

**Retained Message:**

An Application Message which is stored by the Server for a Topic Name. When a Client subscribes to a topic which has a Retained Message set, the Server sends the Retained Message to the Client, depending on the setting of the Retain Handling Subscribe Flags. Refer to [[3.7.2 SUBSCRIBE Flags]](#subscribe-flags) and [[4.13 Retained Messages]](#retained-messages) for more information about Retained Messages.

**Disallowed Unicode code point:**

The set of Unicode Control Codes and Unicode Noncharacters which should not be included in a UTF-8 Encoded String. Refer to [[1.7.4 UTF-8 Encoded String]](#utf-8-encoded-string) for more information about the Disallowed Unicode code points.
