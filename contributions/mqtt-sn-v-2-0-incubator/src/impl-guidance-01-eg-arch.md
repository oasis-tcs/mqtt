## Example MQTT-SN Architectures{#c.1-example-mqtt-sn-architectures}

Among the kinds of MQTT-SN components, there are *Clients and Servers* (sub-divided into *Gateways, Brokers and Forwarders)*.

MQTT-SN Clients can:

1.  connect to a Server

2.  communicate with an MQTT Server through an MQTT-SN Gateway

3.  send and receive messages to and from other MQTT-SN Clients through a Server which is acting as an MQTT-SN Broker

4.  send and receive messages without connecting to a Server by using PUBWOS packets.

An MQTT-SN Server may or may not communicate with an MQTT Server. An MQTT-SN Gateway is a Server which connects to an MQTT Server back end. An MQTT-SN Gateway uses the MQTT protocol between itself and the MQTT Server. A Server which acts as an intermediary between MQTT-SN Clients is called a Broker. If a Server does not act as a Broker itself but is connected to an MQTT Server, the Gateway's main function is the translation between MQTT and MQTT-SN.

If the Gateway is not directly attached to the Clients' network, MQTT-SN Clients can communicate with a Gateway through an MQTT-SN Forwarder. The forwarder encapsulates (see [[3.18 Forwarder Encapsulation]](#forwarder-encapsulation)) the MQTT-SN frames it receives on the Client side and forwards them unchanged to the Gateway; in the opposite direction, it removes the encapsulation from the frames it receives from the Gateway and sends them unchanged to the Clients.

### Transparent Gateway{#c.1.1-transparent-gateway}

For each connected MQTT-SN Client a Transparent Gateway will set up and maintain an MQTT connection to the MQTT server. This MQTT connection is reserved exclusively for the end-to-end and almost transparent packet exchange between the Client and the MQTT Server. There will be as many MQTT connections between the Gateway and the MQTT Server as MQTT-SN clients connected to the Gateway. The Transparent Gateway will perform a translation between the two protocols. Since all packet exchanges are end-to-end between the MQTT-SN client and the MQTT Server, functions and features that are implemented by the MQTT Server can be offered to the MQTT-SN Client.

Although the implementation of the Transparent Gateway may be somewhat simpler than an Aggregating Gateway, it requires the MQTT Server to support a separate connection for each active Client. Some MQTT Server implementations might impose a limitation on the number of concurrent connections that they support.

*Figure C-1 -- Transparent Gateway*

> ![](media/image40.png)<!-- .width="3.994792213473316in", .height="2.6661472003499562in" -->

Because PUBWOS packets could be sent at any time by Clients with no Virtual Connection, a Transparent Gateway would need to maintain a dedicated MQTT connection with the MQTT Server to support those packets.

### Aggregating Gateway{#c.1.2-aggregating-gateway}

Instead of having one MQTT connection for each connected MQTT-SN Client, an aggregating Gateway has one MQTT connection to the MQTT Server. All packet exchanges between an MQTT-SN client and an aggregating Gateway end at the Gateway. The Gateway then decides which information will be given further to the MQTT Server. Although its implementation may be more complex than a transparent Gateway, an aggregating Gateway reduces the number of MQTT connections between the Gateway and MQTT Server.

*Figure C-2 -- Aggregating Gateway*

![](media/image10.png)<!-- .width="4.578125546806649in", .height="3.0552755905511813in" -->

To support PUBWOS packets from MQTT-SN clients without a Virtual Connection, an Aggregating may use any aggregating MQTT connection to forward those packets to an MQTT Server.

A hybrid Gateway may contain elements of both Aggregating and Transparent Gateways, using different approaches depending on the characteristics of the MQTT-SN Clients connecting to them.

### Forwarder{#c.1.3-forwarder}

An MQTT-SN Forwarder connects two networks which cannot transmit messages directly to and from each other. It serves as a bridge for MQTT-SN messages between the two networks, allowing MQTT-SN Clients in one to connect to an MQTT-SN Gateway in the other. The two networks could be Zigbee on one side and UDP on the other, for instance.

The following diagrams illustrate how a Forwarder may interact with an Aggregating or Transparent Gateway.

*Figure C-3 -- Forwarder with Transparent Gateway*

![](media/image22.png)<!-- .width="4.704773622047244in", .height="2.7964599737532807in" -->

*Figure C-4 -- Forwarder with Aggregating Gateway*

![](media/image29.png)<!-- .width="4.9003171478565175in", .height="2.8304625984251968in" -->

### MQTT-SN Broker{#c.1.4-mqtt-sn-broker}

An MQTT-SN Server may have no interaction with an MQTT Server, in which case, much like an MQTT Server, it will act as an intermediary between MQTT-SN Clients.

It will allow MQTT-SN Clients to set up subscriptions, and publish messages to other clients which have subscribed to the relevant topics. It may support the receipt and sending of PUBWOS packets - it is an implementation decision on how to handle them.

*Figure C-5 -- MQTT-SN Broker*

![](media/image37.png)<!-- .width="2.8596172353455818in", .height="2.983947944006999in" -->

An MQTT-SN Server may choose to incorporate elements of a Broker, Aggregating and Transparent Gateway together. Typically, an Aggregating Gateway will also act as an MQTT-SN Broker.
