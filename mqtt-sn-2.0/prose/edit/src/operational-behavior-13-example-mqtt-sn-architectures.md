<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.13 Example MQTT-SN Architecture(s){#example-mqtt-sn-architectures}

<!-- transformation-note: below figure reference will be replaced by semantic reference later. -->
The architecture of MQTT-SN is shown in figure 1.
There are three kinds of MQTT-SN components, MQTT-SN clients, MQTT-SN gateways, and MQTT-SN forwarders.
MQTT-SN clients connect themselves to an MQTT server/broker via an MQTT-SN Gateway using the MQTT-SN protocol.
An MQTT-SN Gateway may or may not be integrated with a MQTT server. Where an MQTT broker is involved,
the MQTT protocol is used between the MQTT broker and the MQTT-SN Gateway.
Its main function is the translation between MQTT and MQTT-SN.

MQTT-SN clients can also access a Gateway via a forwarder in case the Gateway is not directly attached to their network.
The forwarder simply encapsulates the MQTT-SN frames it receives on the wireless side and forwards them unchanged to the
Gateway; in the opposite direction, it decapsulates the frames it receives from the gateway and sends them to the
clients, unchanged too.

> Informative Comment
> The architectures described below are meant as examples and are not exhaustive.

![MQTT-SN Architecture](images/the-topology-diagram.svg "MQTT-SN Architecture")

Figure 1: MQTT-SN Architecture
<!-- transformation-note: above upstream figure number will be replaced by auto-numbering later. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.13.1 Transparent Gateway

For each connected MQTT-SN client a transparent Gateway will set up and maintain a MQTT connection to the MQTT server.
This MQTT connection is reserved exclusively for the end-to-end and almost transparent packet exchange between the client and the server.
There will be as many MQTT connections between the Gateway and the server as MQTT-SN clients connected to the Gateway.
The transparent Gateway will perform a "syntax" translation between the two protocols.
Since all packet exchanges are end-to-end between the MQTT-SN client and the MQTT Server,
all functions and features that are implemented by the server can be offered to the client.

Although the implementation of the transparent Gateway is simpler when compared to the one of an aggregating Gateway,
it requires the MQTT server to support a separate connection for each active client.
Some MQTT server implementations might impose a limitation on the number of concurrent connections that they support.

<!-- transformation-note: figure of transparent and aggregating gateways missing. -->

Figure 2: Transparent and Aggregating Gateways
<!-- transformation-note: above upstream figure number will be replaced by auto-numbering later. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.13.2 Aggregating Gateway

Instead of having a MQTT connection for each connected client,
an aggregating Gateway will have only one MQTT connection to the Server.
All packet exchanges between a MQTT-SN client and an aggregating Gateway end at the Gateway.
The Gateway then decides which information will be given further to the Server.
Although its implementation is more complex than the one of a transparent Gateway,
an aggregating Gateway may be helpful in case of WSNs with a very large number of SAs because
it reduces the number of MQTT connections that the Gateway must support concurrently.
