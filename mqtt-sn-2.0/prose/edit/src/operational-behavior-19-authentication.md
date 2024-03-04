<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.19 Authentication

Authentication involves the exchange of AUTH packets between the Client and the Server after the CONNECT and before the CONNACK packets.

To begin an authentication exchange, the Client sets the AUTH flag in the CONNECT packet.
It then sends an AUTH packet with an Authentication Method.
This specifies the authentication method to use.
If the Server does not support the Authentication Method supplied by the Client,
it MAY send a CONNACK with a Reason Code of 0x8C (Bad authentication method) or 0x87 (Not Authorized) and MUST close the Connection.

The Authentication Method is an agreement between the Client and Server about the meaning of the data sent in the Authentication Data and any of the other fields in CONNECT, and the exchanges and processing needed by the Client and Server to complete the authentication.

> Informative comment
>
> The Authentication Method is commonly a SASL mechanism, using such a registered name aids interchange.
> However, the Authentication Method is not constrained to using registered SASL mechanisms.
>
> If the Authentication Method selected by the Client specifies that the Client sends data first,
> the Client SHOULD include an Authentication Data property in the AUTH packet.
> This property can be used to provide data as specified by the Authentication Method.
> The contents of the Authentication Data are defined by the authentication method.
>
> If the Gateway requires additional information to complete the authentication, it can send an AUTH packet to the Client.
> This packet MUST contain a Reason Code of 0x18 (Continue authentication).
> If the authentication method requires the Gateway to send authentication data to the Client, it is sent in the Authentication Data.
> 
> The Client responds to an AUTH packet from the Gateway by sending a further AUTH packet.
> This packet MUST contain a Reason Code of 0x18 (Continue authentication).
> If the authentication method requires the Client to send authentication data for the Gateway, it is sent in the Authentication Data.
> 
> The Client and Server exchange AUTH packets as needed until the Gateway accepts the authentication by sending a CONNACK with a Reason Code of 0.
> If the acceptance of the authentication requires data to be sent to the Client, it is sent in the Authentication Data.
> 
> The Client can close the Virtual Connection at any point in this process by sending a DISCONNECT packet.
> The Server can reject the authentication at any point in this process by sending a CONNACK with a Reason Code of 0x80 or above as described in section 4.13.
> <!-- transformation-note: the above section ref to 4.13 should be 4.12 as the 4.9 section upstream was a ghost - needs verification. -->
> 
> The implementation of authentication is OPTIONAL for both Clients and Gateways.
> If the Client does not include an Authentication Method in the CONNECT, the Gateway MUST NOT send an AUTH packet.
> If the Client does not set the Authentication Flag in the CONNECT, the Client MUST NOT send an AUTH packet to the Server.
> 
> If the Client does not set the Authentication Flag in the CONNECT packet, the Server SHOULD authenticate using some or
> all of the information in the CONNECT packet in conjunction with the underlying transport layer.

> Informative example showing a user name and password authentication:
>
> - Client to Gateway: CONNECT Authentication Flag=1 Authentication Data=client-first-data
> - Client to Gateway: AUTH rc=0x01 Authentication Method="PLAIN" Authentication Data=client-first-data
> - Gateway to Gateway CONNACK rc=0

Where client-first-data is the content of the SASL PLAIN message as described in RFC 4616:

The mechanism consists of a single message, a string of \[UTF-8] encoded \[Unicode] characters, from the client to the server.
The \[UTF-8] client presents the authorization identity (identity to act as), followed by a NUL (U+0000) character,
followed by the authentication identity (identity whose password will be used), followed by a NUL (U+0000) character, followed by the clear-text password.
As with other SASL mechanisms, the client does not provide an authorization identity when it wishes the server to derive an identity from
the credentials and use that as the authorization identity.
