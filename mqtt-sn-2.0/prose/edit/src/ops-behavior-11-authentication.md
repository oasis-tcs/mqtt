## Authentication{#authentication}

The MQTT-SN CONNECT and AUTH packets contain Authentication Method and Data fields for use in authentication.

Authentication in MQTT-SN is equivalent to Enhanced Authentication in MQTT 5.0. For an implementation of MQTT 3.1.1 Authentication or MQTT 5.0 Basic Authentication (User Name and Password), refer to [sec](#mqtt-user-name-and-password-support).

Alternatively, the Underlying Network may support authentication technology, such as DTLS in the case that the Underlying Network is UDP.

### CONNECT and AUTH packets{#connect-and-auth-packets}

The authentication information in MQTT-SN CONNECT and AUTH packets allows a range of options from username and password to challenge / response style authentication. It might involve the exchange of AUTH packets between the Client and the Server after the CONNECT and before the CONNACK packets.

To begin authentication, the Client sets the AUTH flag in the CONNECT packet and includes an Authentication Method and optionally Data, depending on the Authentication Method, used in the CONNECT packet. This specifies the authentication method to use and its parameters. «<mark title="Requirement MQTT-SN-4.11.1-1"><a name="MQTT-SN-4.11.1-1"></a>If the Server does not support the Authentication Method supplied by the Client, it MAY send a CONNACK with a Reason Code of 0x8C (Bad authentication method) or 0x87 (Not Authorized) as described in [sec](#reason-code) and MUST delete the Virtual Connection</mark>»\[MQTT‑SN‑4.11.1‑1].

The Authentication Method is an agreement between the Client and Server about the meaning of the data sent in the Authentication Data and optionally the Client Identifier, and the exchanges and processing needed by the Client and Server to complete the authentication.

> **Informative comment**
>
> The Authentication Method is commonly a [[SASL]](https://datatracker.ietf.org/doc/html/rfc4422) mechanism, and using such a registered name aids interchange. However, the Authentication Method is not constrained to using registered SASL mechanisms.

If the Authentication Method selected by the Client specifies that the Client sends data first, the Client SHOULD include the Authentication Data in the CONNECT packet. The contents of the Authentication Data are defined by the authentication method.

«<mark title="Requirement MQTT-SN-4.11.1-2"><a name="MQTT-SN-4.11.1-2"></a>If the Server requires additional information to complete the authentication, it can send an AUTH packet to the Client. This packet MUST contain a Reason Code of 0x18 (Continue authentication)</mark>»\[MQTT‑SN‑4.11.1‑2]. If the authentication method requires the Server to send authentication data to the Client, it is sent in the Authentication Data field of the AUTH packet.

«<mark title="Requirement MQTT-SN-4.11.1-3"><a name="MQTT-SN-4.11.1-3"></a>The Client responds to an AUTH packet from the Server by sending a further AUTH packet. This packet MUST contain a Reason Code of 0x18 (Continue authentication)</mark>»\[MQTT‑SN‑4.11.1‑3]. If the authentication method requires the Client to send authentication data for the Server, it is sent in the Authentication Data field of the AUTH packet.

The Client and Server exchange AUTH packets as needed until the Server accepts the authentication by sending a CONNACK with a Reason Code of 0x00. If the acceptance of the authentication requires data to be sent to the Client, it is sent in the Authentication Data field of the CONNACK packet.

The Client can terminate the Virtual Connection at any point in this process by sending a DISCONNECT packet. «<mark title="Requirement MQTT-SN-4.11.1-4"><a name="MQTT-SN-4.11.1-4"></a>The Server can reject the authentication at any point in this process. It MUST send a CONNACK with a Reason Code of 0x80 or above as described in [sec](#handling-errors)</mark>»\[MQTT‑SN‑4.11.1‑4].

«<mark title="Requirement MQTT-SN-4.11.1-5"><a name="MQTT-SN-4.11.1-5"></a>If the initial CONNECT packet included an Authentication Method then all AUTH packets, and any successful CONNACK packet MUST include an Authentication Method with the same value as in the CONNECT packet</mark>»\[MQTT‑SN‑4.11.1‑5].

«<mark title="Requirement MQTT-SN-4.11.1-7"><a name="MQTT-SN-4.11.1-7"></a>If the Client does not include an Authentication Method in the CONNECT, the Server MUST NOT send an AUTH packet, and it MUST NOT send an Authentication Method in the CONNACK packet]{.mark} \[MQTT-SN-4.11.1-6\]. [If the Client does not include an Authentication Method in the CONNECT, the Client MUST NOT send an AUTH packet to the Server</mark>»\[MQTT‑SN‑4.11.1‑7].

If the Client does not include an Authentication Method in the CONNECT packet, the Server SHOULD authenticate using some or all of the information in the CONNECT packet in conjunction with the underlying transport layer or alternatively use the Protection Encapsulation.

> **Informative example showing a SCRAM challenge**

- Client to Server: CONNECT Authentication Method=\"SCRAM-SHA-1\" Authentication Data=client-first-data

- Server to Client: AUTH rc=0x18 Authentication Method=\"SCRAM-SHA-1\" Authentication Data=server-first-data

- Client to Server AUTH rc=0x18 Authentication Method=\"SCRAM-SHA-1\" Authentication Data=client-final-data

- Server to Client CONNACK rc=0 Authentication Method=\"SCRAM-SHA-1\" Authentication Data=server-final-data

> **Informative example showing a Kerberos challenge**

- Client to Server CONNECT Authentication Method=\"GS2-KRB5\"

- Server to Client AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"

- Client to Server AUTH rc=0x18 Authentication Method=\"GS2-KRB5\" Authentication Data=initial context token

- Server to Client AUTH rc=0x18 Authentication Method=\"GS2-KRB5\" Authentication Data=reply context token

- Client to Server AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"

- Server to Client CONNACK rc=0 Authentication Method=\"GS2-KRB5\" Authentication Data=outcome of authentication

#### Re-authentication{#re-authentication}

«<mark title="Requirement MQTT-SN-4.11.1.1-1"><a name="MQTT-SN-4.11.1.1-1"></a>If the Client supplied an Authentication Method in the CONNECT packet, it can initiate a re-authentication at any time after receiving a CONNACK. It does this by sending an AUTH packet with a Reason Code of 0x19 (Re-authentication). The Client MUST set the Authentication Method to the same value as the Authentication Method originally used to authenticate the Virtual Connection</mark>»\[MQTT‑SN‑4.11.1.1‑1]. If the authentication method requires Client data first, this AUTH packet contains the first piece of authentication data in the Authentication Data field.

The Server responds to this re-authentication request by sending an AUTH packet to the Client with a Reason Code of 0x00 (Success) to indicate that the re-authentication is complete, or a Reason Code of 0x18 (Continue authentication) to indicate that more authentication data is needed. The Client can respond with additional authentication data by sending an AUTH packet with a Reason Code of 0x18 (Continue authentication). This flow continues as with the original authentication until the re-authentication is complete or the re-authentication fails.

«<mark title="Requirement MQTT-SN-4.11.1.1-2"><a name="MQTT-SN-4.11.1.1-2"></a>If the re-authentication fails, the Client or Server MUST send DISCONNECT with an appropriate Reason Code as described in [sec](#handling-errors), and MUST delete the Virtual Connection</mark>»\[MQTT‑SN‑4.11.1.1‑2].

During this re-authentication sequence, the flow of other packets between the Client and Server is paused, pending the new authentication outcome.

**Informative comment**

> The Server might limit the scope of the changes the Client can attempt in a re-authentication by rejecting the re-authentication. For instance, if the Server does not allow the User Name to be changed it can fail any re-authentication attempt which changes the User Name.

#### MQTT User Name and Password Support{#mqtt-user-name-and-password-support}

To support the equivalent of the MQTT User Name and Password fields in the CONNECT packet, do the following:

- Set the [sec](#authentication-method) field to MQTT-BASIC.

- Set the [sec](#authentication-data) field to to:

1.  MQTT User Name: a Two Byte Integer length followed by a UTF-8 Encoded String as defined in [sec](#utf-8-encoded-string).

2.  MQTT Password: a Two Byte Integer length followed by binary data.

The User Name string and Password binary data must have the same length as the values in their corresponding preceding length fields.

This is a one-way transfer of information - the response MUST be a CONNACK, not an AUTH packet.

> **Informative comment**
>
> The length field in front of the password is not strictly necessary as the Authentication Data field length is known, but including it makes the transfer to and from the MQTT Connect packet simpler.

*Figure 4-6 -- CONNECT with MQTT User Name and Password, informative example*

![CONNECT with MQTT User Name and Password, informative example](images/image20.png "CONNECT with MQTT User Name and Password, informative example")<!-- .width="6.5in", .height="7.430555555555555in" -->

To support the equivalent of the MQTT User Name and Password together with MQTT Enhanced Authentication, in the CONNECT packet do the following:

- Set the [sec](#authentication-method) field to MQTT-ENHANCED.

- Set the [sec](#authentication-data) field to:

  a.  MQTT User Name: a Two Byte Integer length followed by a UTF-8 Encoded String as defined in [sec](#utf-8-encoded-string).

  b.  MQTT Password: a Two Byte Integer length followed by binary data.

  c.  MQTT Authentication Method: a Two Byte Integer length followed by a UTF-8 Encoded String as defined in [sec](#utf-8-encoded-string) .

  d.  MQTT Authentication Data: a Two Byte Integer length followed by binary data.

In any subsequent AUTH and CONNACK packets of the authentication exchange:

1.  The MQTT User Name and MQTT Password fields MUST not be included.

2.  The Authentication Method MUST remain MQTT-ENHANCED throughout.
