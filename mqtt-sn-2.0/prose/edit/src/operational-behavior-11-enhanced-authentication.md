<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.11 Enhanced authentication

The CONNECT packet supports basic authentication of a Virtual Connection using the User Name and Password fields. While these fields are named for a
simple password authentication, they can be used to carry other forms of authentication such as passing a token as the Password.

Enhanced authentication extends this basic authentication to include challenge / response style authentication. It might involve the exchange of AUTH
packets between the Client and the Server after the CONNECT and before the CONNACK packets.

To begin an enhanced authentication, the Client sets the AUTH flag in the CONNECT packet and includes an Authentication Method and optionally Data,
depending on the Authentication Method, used in the CONNECT packet. This specifies the authentication method to use and its parameters. \[If the Server
does not support the Authentication Method supplied by the Client, it MAY send a CONNACK with a Reason Code of 0x8C (Bad authentication method) or
0x87 (Not Authorized) as described in section [2.3.3 "Reason Code"](#reason-code) and MUST delete the Virtual Connection] \[MQTT-SN-4.10-1].

The Authentication Method is an agreement between the Client and Server about the meaning of the data sent in the Authentication Data and any of the
other fields in CONNECT, and the exchanges and processing needed by the Client and Server to complete the authentication.

> **Informative comment**
>
> The Authentication Method is commonly a SASL mechanism, and using such a registered name aids interchange. However, the Authentication Method is not
> constrained to using registered SASL mechanisms.

If the Authentication Method selected by the Client specifies that the Client sends data first, the Client SHOULD include an Authentication Data
property in the CONNECT packet. This property can be used to provide data as specified by the Authentication Method. The contents of the
Authentication Data are defined by the authentication method.

\[If the Server requires additional information to complete the authentication, it can send an AUTH packet to the Client. This packet MUST contain a
Reason Code of 0x18 (Continue authentication)] \[MQTT-SN-4.10-2]. If the authentication method requires the Server to send authentication data
to the Client, it is sent in the Authentication Data.

\[The Client responds to an AUTH packet from the Server by sending a further AUTH packet. This packet MUST contain a Reason Code of 0x18 (Continue
authentication)]{.mark} \[MQTT-SN-4.10-3]. If the authentication method requires the Client to send authentication data for the Server, it is sent in
the Authentication Data.

The Client and Server exchange AUTH packets as needed until the Server accepts the authentication by sending a CONNACK with a Reason Code of 0. If the
acceptance of the authentication requires data to be sent to the Client, it is sent in the Authentication Data.

The Client can terminate the Virtual Connection at any point in this process by sending a DISCONNECT packet. \[The Server can reject the authentication
at any point in this process. It MUST send a CONNACK with a Reason Code of 0x80 or above as described in] section [4.13 "MQTT 5.0 specification ref?"](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#S4_13_Errors),] \[MQTT-SN-4.10-4].

\[If the initial CONNECT packet included an Authentication Method property then all AUTH packets, and any successful CONNACK packet MUST include an
Authentication Method Property with the same value as in the CONNECT packet] \[MQTT-SN-4.10-5].

The implementation of enhanced authentication is OPTIONAL for both Clients and Servers. \[If the Client does not include an Authentication Method in
the CONNECT, the Server MUST NOT send an AUTH packet, and it MUST NOT send an Authentication Method in the CONNACK packet] \[MQTT-SN-4.10-6].
\[If the Client does not include an Authentication Method in the CONNECT, the Client MUST NOT send an AUTH packet to the Server]
\[MQTT-SN-4.10-7].

If the Client does not include an Authentication Method in the CONNECT packet, the Server SHOULD authenticate using some or all of the information in
the CONNECT packet in conjunction with the underlying transport layer..

> **Informative example showing a SCRAM challenge**
>
>- Client to Server: CONNECT Authentication Method="SCRAM-SHA-1" Authentication Data=client-first-data
>- Server to Client: AUTH rc=0x18 Authentication Method="SCRAM-SHA-1" Authentication Data=server-first-data
>- Client to Server AUTH rc=0x18 Authentication Method="SCRAM-SHA-1" Authentication Data=client-final-data
>- Server to Client CONNACK rc=0 Authentication Method="SCRAM-SHA-1" Authentication Data=server-final-data

> **Informative example showing a Kerberos challenge**
>
>- Client to Server CONNECT Authentication Method="GS2-KRB5"
>- Server to Client AUTH rc=0x18 Authentication Method="GS2-KRB5"
>- Client to Server AUTH rc=0x18 Authentication Method="GS2-KRB5" Authentication Data=initial context token
>- Server to Client AUTH rc=0x18 Authentication Method="GS2-KRB5" Authentication Data=reply context token
>- Client to Server AUTH rc=0x18 Authentication Method="GS2-KRB5"
>- Server to Client CONNACK rc=0 Authentication Method="GS2-KRB5" Authentication Data=outcome of authentication

### 4.11.1 Re-authentication

\[If the Client supplied an Authentication Method in the CONNECT packet it can initiate a re-authentication at any time after receiving a CONNACK. It
does this by sending an AUTH packet with a Reason Code of 0x19 (Re-authentication). The Client MUST set the Authentication Method to the same value as
the Authentication Method originally used to authenticate the Virtual Connection] \[MQTT-SN-4.10.1-1]. If the authentication method requires
Client data first, this AUTH packet contains the first piece of authentication data as the Authentication Data.

The Server responds to this re-authentication request by sending an AUTH packet to the Client with a Reason Code of 0x00 (Success) to indicate that
the re-authentication is complete, or a Reason Code of 0x18 (Continue authentication) to indicate that more authentication data is needed. The Client
can respond with additional authentication data by sending an AUTH packet with a Reason Code of 0x18 (Continue authentication). This flow continues as
with the original authentication until the re-authentication is complete or the re-authentication fails.

\[If the re-authentication fails, the Client or Server MUST send DISCONNECT with an appropriate Reason Code as described in]
section [4.13 "MQTT-5-r"](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#S4_13_Errors), and MUST delete the Virtual Connection] \[MQTT-SN-4.10.1-2].

During this re-authentication sequence, the flow of other packets between the Client and Server can continue using the previous authentication.

>**Informative comment**
>
> The Server might limit the scope of the changes the Client can attempt in a re-authentication by rejecting the re-authentication. For instance, if
> the Server does not allow the User Name to be changed it can fail any re-authentication attempt which changes the User Name.

