<!-- transformation-note: left upstream numbering of headings for verification -->
## 1.4 Terminology

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and
"OPTIONAL" in this specification are to be interpreted as described in IETF RFC 2119 \[RFC2119], except where they appear
in text that is marked as non-normative.

Application Message
:    The data carried by the MQTT-SN protocol across the network for the application.
When an Application Message is transported by MQTT-SN it contains payload data, a Quality of Service (QoS) and a Topic Name.

Client
:    A program or device that uses MQTT-SN. A Client:
- Optionally Connects to the Gateway
- publishes Application Messages to topics.
- subscribes to request Application Messages that it is interested in receiving.
- unsubscribes to remove a request for Application Messages.
- Issues a DISCONNECT to the Gateway.

Gateway (abbrev. GW)
:    A program or device accepting MQTT-SN protocol packets from Clients. A Gateway:
- accepts CONNECT packets from Clients and initializes Sessions.
- accepts Application Messages published by Clients and sends them to the Server.
- processes Subscribe and Unsubscribe requests from Clients.
- forwards Application Messages from the Server to Clients.
- maintains a Gateway "Session" for each Client on the GW.
- maintains a dictionary of topic alias’s for each Client.

Server or Broker
:    A program or device accepting MQTT protocol connections from the Gateways. A Server or Broker:
- accepts Network Connections from Gateways.
- Ultimately accepts Application Messages published by Clients.
- processes Subscribe and Unsubscribe requests from Clients.
- forwards Application Messages that match Client Subscriptions to the Gateways.
- closes the Network Connection from the Gateway.

Session
:    A session is the shared state between client and gateway.

Unicast
:    A one-to-one transmission from a Client to a Gateway or from a Gateway to a Client.

Broadcast
:    A one-to-many transmission from a Client or from a Gateway that is not destined respectively for a specific Gateway or Client.
In case the IP protocol stack is used, this definition includes both the broadcast addressing and the multicast addressing schemes.

Transport Layer
:    The transmission protocol used to send and receive the MQTT-SN packets, for example UDP/IP.

<!-- transformation-note: changed name of section reference from the fashionable ampersand to an english and -->
Virtual Connection
:    Carries the MQTT-SN data between a Client and a Gateway.
Refer to section [3.2 Networks and Transport Layers](#networks-and-transport-layers) for informative examples.

Subscription
:    A Subscription comprises a Topic Filter and a maximum QoS.
A Subscription is associated with a single Session.
A Session can contain more than one Subscription. Each Subscription within a Session has a different Topic Filter.

Topic Alias
:    A topic alias is a 16-bit unsigned integer assigned by the Gateway during a session or pre-assigned by the application
which represents and replaces a topic name or topic filter in the protocol packets.

Topic Name
:    The label attached to an Application Message which is matched against the Subscriptions known to the Gateway / Server.

Topic Filter
:    An expression contained in a Subscription to indicate an interest in one or more topics.
A Topic Filter can include wildcard characters.

Wildcard Subscription
:    A Wildcard Subscription is a Subscription with a Topic Filter containing one or more wildcard characters.
This allows the subscription to match more than one Topic Name.

<!-- transformation-note: out of order in upstream document and counting is weird as 31 is not 29 -->
Control Packet
:    A packet of information that is sent across the Virtual Connection.
The MQTT-SN specification defines 31 (twenty nine) different types of MQTT-SN Control Packet,
for example the PUBLISH packet is used to convey Application Messages.

Wireless Sensor Networks (abbrev. WSN)
:    Networks of spatially dispersed and dedicated sensors that monitor and record the physical conditions of the environment
and forward the collected data to a central location.
