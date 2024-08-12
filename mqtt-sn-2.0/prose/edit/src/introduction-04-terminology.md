<!-- transformation-note: left upstream numbering of headings for verification -->
## 1.4 Terminology

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and
"OPTIONAL" in this specification are to be interpreted as described in IETF RFC 2119 \[RFC2119], except where they appear
in text that is marked as non-normative.

Datagram
:    An independent, self-contained sequence of bytes.
If received, the contents of a datagram must be correct.

Underlying Network
:    The underlying network which provides the means to send datagrams from one Network Address to another.
The arrival of a datagram is not guaranteed, but the contents of any datagram which does arrive at its destination must be correct.

Network Address
:    A unique label provided by the Underlying Network to identify a network endpoint.
To receive datagrams, an MQTT-SN Client or Server listens to the network for packets addressed to a specific Network Address.

Unicast Address
:    A Network Address which represents one device on a network.
For packets intended to reach one network endpoint.

Multicast Address
:    A Network Address which represents all or groups of devices on a network.
For packets intended for more than one network endpoint.
> **Informative:**
>
> Multicast Address as used in this specification also includes the concept of broadcast addresses, for brevity.

Network Identity
:    The identity used to establish that a sequence of datagrams originates from the same network source.
This could be, for example:
- A Network Address
- A DTLS connection ID
- An MQTT-SN Protection Packet sender ID

Virtual Connection
:    An MQTT-SN construct corresponding to the network connection in MQTT.
It associates a Network Identity with an MQTT-SN endpoint.

Aplication Message
:    The data carried by the MQTT-SN protocol across the network for the application.
When an Application Message is transported by MQTT-SN it contains payload data, a Quality of Service (QoS), and a Topic Name.

Client
:    A program or device that uses MQTT-SN.
A Client:
- opens a Virtual Connection to a Server.
- publishes Application Messages that other Clients might be interested in.
- subscribes to request Application Messages that it is interested in receiving.
- unsubscribes to remove a request for Application Messages.
- closes the Virtual Connection to the Server.
and/or:
- publishes Application Messages to a Multicast Address.
and/or:
- accepts Application Messages from a Multicast Address.

Server
:    A program or device that acts as an intermediary between Clients which publish Application Messages and Clients which have made Subscriptions.
Also known as a **Gateway**.
A Server:
- accepts CONNECT requests from Clients.
- accepts Application Messages published by Clients.
- processes Subscribe and Unsubscribe requests from Clients.
- forwards Application Messages that match Client Subscriptions.
- accepts DISCONNECT requests from connected Clients.
and/or
- accepts packets from a Multicast Address.
and/or
- opens an MQTT Network Connection to an MQTT Server.
- accepts Application Messages from the MQTT Server and forwards some or all to MQTT-SN Clients.
- accepts Application Messages from MQTT-SN Clients and forwards some or all to the MQTT Server.
and/or
- opens an MQTT Network Connection to an MQTT Server for every MQTT-SN CONNECT request
- forwards equivalent MQTT packets to the MQTT Server for each MQTT-SN packet received
- forwards equivalent MQTT-SN packets to the MQTT-SN Client for each MQTT packet received
- closes the MQTT Network Connection when the Virtual Connection is deleted

MQTT Server
:    A program or device that acts as an intermediary between MQTT Clients which publish Application Messages and MQTT Clients which have made Subscriptions.
Also known as a **Broker**.
An MQTT Server:
- accepts Network Connections from MQTT Clients.
- accepts Application Messages published by MQTT Clients.
- processes Subscribe and Unsubscribe requests from MQTT Clients.
- forwards Application Messages that match MQTT Client Subscriptions.
- closes the Network Connection from the MQTT Client.

Session
:    A stateful interaction between a Client and a Gateway.
Some Sessions last only as long as the Virtual Connection, others can span multiple consecutive Virtual Connections between a Client and a Gateway.

Session State
:    The set of data that describes a Session.
The Session State held by a Client is different to that held by a Server.
See section [4.1 "Session State"](#session-state) for details.

Subscription
:    A Subscription comprises a Topic Filter and a maximum QoS. A Subscription is associated with a single Session. A Session can contain more than one
Subscription. Each Subscription within a Session has a different Topic Filter.

Wildcard Subscription
:    A Wildcard Subscription is a Subscription with a Topic Filter containing one or more wildcard characters.
This allows the subscription to match more than one Topic Name.
Refer to section [4.7.1 "Topic Wildcards"](#topic-wildcards) for a description of wildcard characters in a Topic Filter.

Topic Name
:    The label attached to an Application Message which is matched against the Subscriptions known to the Server.

Topic Alias
:    A Topic Alias is an integer value that is used to identify the Topic instead of using the Topic Name, to reduce packet size.

Topic Filter
:    An expression contained in a Subscription to indicate an interest in one or more topics.
A Topic Filter can include wildcard characters.

MQTT-SN Control Packet
:    A packet of information that is sent to a Network Address.

Malformed Packet
:    A Control Packet that cannot be parsed according to this specification.
Refer to section [4.12 "Handling Errors"](#handling-errors) for information about error handling.

Protocol Error
:    An error that is detected after the packet has been parsed and found to contain data that is not allowed by the protocol or
is inconsistent with the state of the Client or Server.
Refer to section [4.12 "Handling Errors"](#handling-errors) for information about error handling.

Will Message
:    An Application Message which is published by the Server after the Virtual Connection is deleted in cases where
the Virtual Connection is not deleted normally.
Refer to section [3.1.4.9 "Connect Will Flags"](#connect-will-flags-optional-only-with-will-flag-set) for information about Will Messages.

Retained Message
:    An Application Message which is stored by the Server for a topic on the receipt of a Publish Packet with the retained flag set.
When a Client subscribes to a topic with a Retained Message set, the Server sends the Retained Message to the Client,
depending on the setting of the Retain Handling Subscribe Flags.
Refer to sections [3.1.17.2 "SUBSCRIBE Flags"](#subscribe-flags) and [4.26 "Retained Messages"](#retained-messages) for more information about Retained Messages.

Disallowed Unicode code point
:    The set of Unicode Control Codes and Unicode Noncharacters which should not be included in a UTF-8 Encoded String.
Refer to section [1.7.4 "UTF-8 Encoded String"](#utf-8-encoded-string) for more information about the Disallowed Unicode code points.

Wireless Sensor Network
:    Spatially dispersed and dedicated sensors that monitor and record the physical conditions of the environment and
forward the collected data to a central location.

Also known as **WSN**, for short.
