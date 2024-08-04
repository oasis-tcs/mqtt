<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.24 Client’s Disconnect Procedure

A client sends a DISCONNECT packet to the gateway to indicate that it is about to delete its Virtual Connection.
After this point, the client is then required to create a new Virtual Connection with the gateway before it can exchange information with that gateway again.
\[Like MQTT, sending the DISCONNECT packet does not affect existing subscriptions and Will data.
They are persistent until they are either expired or explicitly un-subscribed, or deleted, or modified by the client,
or if the client creates a new Virtual Connection with the CleanStart flag set.]
The gateway acknowledges the receipt of the DISCONNECT packet by returning a DISCONNECT to the client.

A client may also receive an unsolicited DISCONNECT sent by the gateway.
This may happen for example when the gateway, due to an error, cannot identify the client to which a received packet belongs.
Upon receiving such a DISCONNECT packet a client should try to setup the Virtual Connection again by sending a CONNECT packet to the gateway.
