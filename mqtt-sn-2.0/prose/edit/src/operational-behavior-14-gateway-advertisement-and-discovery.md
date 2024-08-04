<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.14 Gateway Advertisement and Discovery

A Gateway may announce its presence by periodically sending an ADVERTISE packet to some or all devices that are currently parts of the network.
A gateway should only advertise its presence if it is connected to a server, or is itself a server.

Multiple Gateways may be active at the same time in the same network.
In this case they will have different identifiers.
It is up to the Client to decide to which Gateway it wants to connect.
\[At any point in time a Client is allowed to be connected to only one Gateway on the same network.]

A client should maintain a list of active gateways together with their network addresses.
This list is populated by means of the ADVERTISE and GWINFO packets received.

The time duration _T\_ADV_ until the gateway sends the next ADVERTISE packet is indicated in the _Duration_ field of the ADVERTISE packets.
A client may use this information to monitor the availability of a gateway.
For example, if it does not receive ADVERTISE packets from a gateway for _N\_ADV_ consecutive times,
it may assume that the gateway is down and remove it from its list of active gateways.
Similarly, gateways in stand-by mode will become active
(i.e. start sending ADVERTISE packets) if they miss successively a couple of times advertisements from a certain gateway.

Since the ADVERTISE packets are transmitted into the whole wireless network,
the time interval _T\_ADV_ between two ADVERTISE packets sent by a gateway should be large enough (e.g. greater than 15 min)
to avoid bandwidth congestion in the network.

The large value of _T\_ADV_ will lead to a long waiting time for new clients which are looking for a gateway.
To shorten this waiting time a client may send a SEARCHGW packet.
To prevent network flooding when multiple clients start searching for gateway almost at the same time,
the sending of the SEARCHGW packet is delayed by a random time between 0 and _T\_SEARCHGW_.
A client will cancel its transmission of the SEARCHGW packet if it receives during this delay time a SEARCHGW packet sent by another client and
identical to the one it wants to send, and behaves as if the SEARCHGW packet was sent by itself.

The transmission radius _R\_b_ of the SEARCHGW packet is limited, e.g. to a single hop in case of a dense deployment of MQTT-SN clients.

Upon receiving a SEARCHGW packet a gateway replies with a GWINFO packet containing its id.
Similarly, a client answers with a GWINFO packet if it has at least one active gateway in its list of active gateways.
If the client has multiple gateways in its list, it selects one gateway out of its list and includes that information into the GWINFO packet.

Like the SEARCHGW packet, the GWINFO packet is transmitted with the same radius _R\_b_, which is indicated in the SEARCHGW packet.
The radius _R\_b_ is also given to the underlying layer when these two packets are passed down for transmission.

To give priority to the gateways a client will delay its sending of the GWINFO packet for a random time _T\_GWINFO_.
If during this delay time the client receives a GWINFO packet it will cancel the transmission of its GWINFO packet.

In case of no response the SEARCHGW packet may be retransmitted.
In this case the time intervals between consecutive SEARCHGW packets should be increased by the exponential backoff algorithm described in the appendix.