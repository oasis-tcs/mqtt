<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.23 Keep Alive and PING Procedure

As with MQTT, the value of the Keep Alive timer is indicated in the CONNECT packet.
The client should send a PINGREQ packet within each Keep Alive time period, which the gateway acknowledges with a PINGRESP packet.

Similarly, a client shall answer with a PINGRESP packet when it receives a PINGREQ packet from the GW to which it is connected.
Otherwise, the received PINGREQ packet is ignored.

Clients should use this procedure to supervise the liveliness of the gateway to which they are connected.
If a client does not receive a PINGRESP from the gateway even after multiple retransmissions of the PINGREQ packet,
it should first try to connect to another gateway before trying to reconnect to this gateway.
Note that because the clients’ keep-alive timers are not synchronized with each other,
in case of a gateway failure there is practically no danger for a storm of CONNECT packets sent almost at the same time by all affected clients towards a new gateway.
