## C.7 Gateway Advertisement and Discovery{#c.7-gateway-advertisement-and-discovery}

Clients might have foreknowledge of how to reach a Gateway, but in dynamic networks they may not. MQTT-SN supports mechanisms to allow Clients to find available MQTT-SN Gateways. This support is optional - it may not be needed. In some implementations, the underlying network technology might be used for this purpose instead.

In MQTT-SN there are two principal ways for Clients and Gateways to find each other:

1.  The Gateway can periodically transmit, or broadcast, an ADVERTISE packet to its neighborhood.

2.  The Client can elicit a response from one or more Gateways, or Clients which know the network location of a Gateway, by broadcasting a SEARCHGW packet. The response, from either a Gateway or a Client on the Gateway's behalf, is a GWINFO packet.

A Gateway should only advertise its presence, or respond to SEARCHGW requests, if it is able to accept subscriptions and forward messages. For instance, a [[Transparent Gateway]](#c.1.1-transparent-gateway) which is not currently connected to an MQTT Server, should not advertise.

Multiple Gateways may be active at the same time in the same network, in which case they will have different identifiers. It is up to the Client to decide to which Gateway it wants to connect.

A Client can maintain a list of active Gateways together with their network addresses. This list is populated with the information from ADVERTISE and GWINFO packets received.

The time until the Gateway sends the next ADVERTISE packet is indicated in the *Duration* field of the ADVERTISE packet (*[Advertise Duration]*). A Client may use this information to monitor the availability of a Gateway. For example, if it does not receive ADVERTISE packets from a Gateway several times (*[Advertise Count]*) consecutively, it may assume that the Gateway is down and remove it from its list of active Gateways. Similarly, Gateways in stand-by mode can become active (and start sending ADVERTISE packets) if they fail to observe successive advertisements from a previously active Gateway.

If the ADVERTISE packets are broadcast into the whole wireless network, the time interval between two consecutive ADVERTISE packets sent by a gateway should be large enough (greater than 15 minutes for example) to avoid bandwidth congestion in the network.

A large interval between ADVERTISE packets can lead to a long waiting time for new Clients which are looking for a Gateway. To shorten this waiting time a client may send a SEARCHGW packet. To prevent network flooding when multiple clients start searching for a Gateway almost at the same time, the sending of the SEARCHGW packet can be delayed by a random time *[SEARCHGW Delay]*. A client can cancel its transmission of the SEARCHGW packet if it receives during this delay time a SEARCHGW packet sent by another client and identical to the one it wants to send, and behaves as if the SEARCHGW packet was sent by itself.

Upon receiving a SEARCHGW packet a Gateway replies with a GWINFO packet containing its identifier. Similarly, a Client can answer with a GWINFO packet if it has at least one item in its active Gateway list. If the Client has multiple Gateways in its list, it can select one Gateway out of its list and include that information in the GWINFO packet.

To give priority to Gateways a client delays its sending of the GWINFO packet for a random time *[GWINFO Delay]*. If during this delay the Client receives a GWINFO packet it cancels the sending of its own GWINFO packet.

If there is no response, the SEARCHGW packet may be retransmitted. In this case the time intervals between consecutive SEARCHGW packets should be increased by an exponential backoff algorithm such as that described in [[C.4 Exponential Backoff]](#c.4-exponential-backoff).
