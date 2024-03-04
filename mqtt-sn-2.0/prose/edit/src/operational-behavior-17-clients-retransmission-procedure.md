<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.17 Client’s Retransmission Procedure

All packets that are "unicasted" to the Gateway
(i.e. sent using the gateway’s unicast address) and for which a gateway’s reply is expected are supervised by a retry timer Tretry and a retry counter Nretry.
The retry timer Tretry is started by the client when the packet is sent and stopped when the expected gateways reply is received.
If Tretry times out and the expected gateway’s reply is not received, the client retransmits the packet.
After Nretry retransmissions, the client aborts the procedure and assumes that the MQTT-SN gateway is no longer available.
It should then attempt to establish a session on any other available gateway (where it may exist).
