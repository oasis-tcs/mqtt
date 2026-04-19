## Implementation notes{#implementation-notes}

When the underlying network layer for MQTT-SN is UDP, DTLS \[RFC9147\] can be used to secure MQTT-SN communications instead of or in conjunction with the Protection Encapsulation.
It is recommended that Server implementations that offer DTLS use UDP port 8883 (IANA service name: secure-mqtt).

For other underlying network technologies, a security solution particular to that technology must be found, which could involve using the MQTT-SN [sec](#protection-encapsulation) and/or [sec](#authentication).

There are many security concerns to consider when implementing or using MQTT-SN. The following section should not be considered a comprehensive checklist.

An implementation might want to achieve some, or all, of the following:

### Authentication of Clients by the Server{#authentication-of-clients-by-the-server}

The CONNECT packet contains an Authentication Data field which can contain a user name and password if the Authentication Method is SASL PLAIN (see [sec](#mqtt-user-name-and-password-support)). Implementations can choose how to make use of the content of these fields.
They may provide their own authentication mechanism, use an external authentication system such as LDAP [[\[RFC4511\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC4511) or OAuth [[\[RFC6749\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6749) tokens,
or leverage operating system authentication mechanisms.

MQTT-SN provides an Authentication mechanism as described in [sec](#authentication). Using this requires support for it in both the Client and Server.

Implementations passing authentication data in clear text, obfuscating such data elements or requiring no authentication data should be aware this can give rise to Man-in-the-Middle and replay attacks. [sec](#privacy-of-application-messages-and-mqtt-sn-control-packets) introduces approaches to ensure data privacy.

A Virtual Private Network (VPN) between the Clients and Servers can provide confidence that data is only being received from authorized Clients.

Where DTLS [[\[RFC9147\]]](https://datatracker.ietf.org/doc/rfc9147/) is used, X.509 Certificates sent from the Client can be used by the Server to authenticate the Client to achieve mutual authentication.

### Authorization of Clients by the Server{#authorization-of-clients-by-the-server}

If a Client has been successfully authenticated, a Server implementation should check that it is authorized before accepting its connection.

Authorization may be based on information provided by the Client such as User Name, the hostname/network address of the Client, or the outcome of authentication mechanisms.

In particular, the implementation should check that the Client is authorized to use the Client Identifier as this gives access to the MQTT-SN Session State (described in [sec](#session-state)). This authorization check is to protect against the case where one Client, accidentally or maliciously, provides a Client Identifier that is already being used by some other Client.

An implementation should provide access controls that take place after CONNECT to restrict the Client\'s ability to publish to particular Topics or to subscribe using particular Topic Filters. An implementation should consider limiting access to Topic Filters that have broad scope, such as the \# Topic Filter.

### Authentication of the Server by the Client{#authentication-of-the-server-by-the-client}

The MQTT-SN protocol is not trust symmetrical. When using basic Username and Password authentication, there is no mechanism for the Client to authenticate the Server. Some forms of authentication do allow for mutual authentication.

Where DTLS is used, X.509 Certificates sent from the Server can be used by the Client to authenticate the Server.

MQTT-SN provides an Authentication mechanism as described in [sec](#authentication), which can be used to authenticate the Server to the Client. Using this requires support for it in both the Client and Server.

A VPN between Clients and Servers can provide confidence that Clients are connecting to the intended Server.

### Integrity of Application Messages and MQTT-SN Control Packets{#integrity-of-application-messages-and-mqtt-sn-control-packets}

Applications can independently include hash values in their Application Messages. This can provide integrity of the contents of Publish packets across the network and at rest.

DTLS and the Protection Encapsulation provide hash algorithms to verify the integrity of data sent over the network.

The use of VPNs to connect Clients and Servers can provide integrity of data across the section of the network covered by a VPN.

### Privacy of Application Messages and MQTT-SN Control Packets{#privacy-of-application-messages-and-mqtt-sn-control-packets}

DTLS [[\[RFC9147\]]](https://datatracker.ietf.org/doc/rfc9147/) can provide encryption of data sent over the network. There are valid DTLS cipher suites that include a NULL encryption algorithm that does not encrypt data. To ensure privacy Clients and Servers should avoid these cipher suites.

An application might independently encrypt the contents of its Application Messages. This could provide privacy of the Application Message both over the network and at rest. This would not provide privacy for other Properties of the Application Message such as Topic Name.

Client and Server implementations can provide encrypted storage for data at rest such as Application Messages stored as part of a Session.

The use of VPNs to connect Clients and Servers can provide privacy of data across the section of the network covered by a VPN.

### Non-repudiation of message transmission{#non-repudiation-of-message-transmission}

Application designers might need to consider appropriate strategies to achieve end to end non-repudiation.

### Detecting compromise of Clients and Servers{#detecting-compromise-of-clients-and-servers}

Client and Server implementations using DTLS should provide capabilities to ensure that any X.509 certificates provided when initiating a DTLS session are associated with the hostname of the Client connecting or Server being connected to.

Client and Server implementations using DTLS can choose to provide capabilities to check Certificate Revocation Lists (CRLs [[\[RFC5280\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC5280)) and Online Certificate Status Protocol (OSCP) [[\[RFC6960\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6960) to prevent revoked certificates from being used.

Physical deployments might combine tamper-proof hardware with the transmission of specific data in Application Messages.
For example, a meter might have an embedded GPS to ensure it is not used in an unauthorized location. [[\[IEEE8021AR\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#IEEE8021AR) is a standard for implementing mechanisms to authenticate a device's identity using a cryptographically bound identifier.

### Detecting abnormal behaviors{#detecting-abnormal-behaviors}

Server implementations might monitor Client behavior to detect potential security incidents. For example:

- Repeated connection attempts

- Repeated authentication attempts

- Abnormal termination of connections

- Topic scanning (attempts to send or subscribe to many topics)

- Sending undeliverable messages (no subscribers to the topics)

- Clients that connect but do not send data

Server implementations might delete the Virtual Connection of Clients that breach its security rules.

Server implementations detecting unwelcome behavior might implement a dynamic block list based on identifiers such as IP address or Client Identifier.

Deployments might use network-level controls (where available) to implement rate limiting or blocking based on IP address or other information.

### Handling of Disallowed Unicode code points{#handling-of-disallowed-unicode-code-points}

[sec](#utf-8-encoded-string) describes the Disallowed Unicode code points, which should not be included in a UTF-8 Encoded String. A Client or Server implementation can choose whether to validate that these code points are not used in UTF-8 Encoded Strings such as the Topic Name or Properties.

If the Server does not validate the code points in a UTF-8 Encoded String but a subscribing Client does, then a second Client might be able to cause the subscribing Client to delete the Virtual Connection by publishing on a Topic Name or using Properties that contain a Disallowed Unicode code point.
This section recommends some steps that can be taken to prevent this problem.

A similar problem can occur when the Client validates that the payload matches the Payload Format Indicator and the Server does not. The considerations and remedies for this are similar to those for handling Disallowed Unicode code points.

#### Considerations for the use of Disallowed Unicode code points{#considerations-for-the-use-of-disallowed-unicode-code-points}

An implementation would normally choose to validate UTF-8 Encoded strings, checking that the Disallowed Unicode code points are not used. This avoids implementation difficulties such as the use of libraries that are sensitive to these code points, it also protects applications from having to process them.

Validating that these code points are not used removes some security exposures. There are possible security exploits which use control characters in log files to mask entries in the logs or confuse the tools which process log files.
The Unicode Noncharacters are commonly used as special markers and allowing them into UTF-8 Encoded Strings could permit such exploits.

#### Interactions between Publishers and Subscribers{#interactions-between-publishers-and-subscribers}

The publisher of an Application Message normally expects that the Servers will forward the message to subscribers, and that these subscribers are capable of processing the messages.

These are some conditions under which a publishing Client can cause the subscribing Client to delete the Virtual Connection. Consider a situation where:

- A Client publishes an Application Message using a Topic Name containing one of the Disallowed Unicode code points.

- The publishing Client library allows the Disallowed Unicode code point to be used in a Topic Name rather than rejecting it.

- The publishing Client is authorized to send the publication.

- A subscribing Client is authorized to use a Topic Filter which matches the Topic Name. Note that the Disallowed Unicode code point might occur in a part of the Topic Name matching a wildcard character in the Topic Filter.

- The Server forwards the message to the matching subscriber rather than disconnecting the publisher.

- In this case the subscribing Client might:

  - Delete the Virtual Connection because it does not allow the use of Disallowed Unicode code points, possibly sending a DISCONNECT before doing so. For QoS 1 and QoS 2 messages this might cause the Server to send the message again, causing the Client to delete the Virtual Connection again.

  - Reject the Application Message by sending a Reason Code greater than or equal to 0x80 in a PUBACK (QoS 1) or PUBREC (QoS 2).

  - Accept the Application Message but fail to process it because it contains one of the Disallowed Unicode code points.

  - Successfully process the Application Message.

The potential for the Client to delete the Virtual Connection might go unnoticed until a publisher uses one of the Disallowed Unicode code points.

#### Remedies{#remedies}

If there is a possibility that a Disallowed Unicode code point could be included in a Topic Name or other Properties delivered to a Client, the solution owner can adopt one of the following suggestions:

1.  Change the Server implementation to one that rejects UTF-8 Encoded Strings containing a Disallowed Unicode code point either by sending a Reason Code greater than or equal to 0x80 or deleting the Virtual Connection.

2.  Change the Client library used by the subscribers to one that tolerates the use of Disallowed Code points. The client can either process or discard messages with UTF-8 Encoded Strings that contain Disallowed Unicode code points so long as it continues the protocol.

### Other security considerations{#other-security-considerations}

If Client or Server X.509 certificates are lost or it is considered that they might be compromised they should be revoked (using CRLs [[\[RFC5280\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC5280) and/or OSCP [[\[RFC6960\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6960)).

Client or Server authentication credentials, such as User Name and Password, that are lost or considered compromised should be revoked and/or reissued.

In the case of long lasting connections:

- Where applicable, Client and Server implementations should allow for session renegotiation to establish new cryptographic parameters (replace session keys, change cipher suites, change authentication credentials).

- Servers may close the Virtual Connection of Clients and require them to re-authenticate with new credentials.

- Servers may require their Client to reauthenticate periodically using the mechanism described in [sec](#re-authentication).

Clients connected to a Server have a transitive trust relationship with other Clients connected to the same Server and who have authority to publish data on the same topics.

### Use of SOCKS{#use-of-socks}

Implementations of Clients should be aware that some environments will require the use of SOCKSv5 [[\[RFC1928\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC1928) proxies to transmit data.
Some MQTT-SN implementations could make use of alternative secured tunnels through the use of SOCKS.
Where implementations choose to use SOCKS, they should support both anonymous and User Name, Password authenticating SOCKS proxies. In the latter case, implementations should be aware that SOCKS authentication might occur in plain-text and so should avoid using the same credentials for connection to an MQTT-SN Server.

### Security profiles{#security-profiles}

Implementers and solution designers might wish to consider security as a set of profiles which can be applied to the MQTT-SN protocol. An example of a layered security hierarchy is presented below.

#### Clear communication profile{#clear-communication-profile}

When using the clear communication profile, the MQTT-SN protocol runs over an open network with no additional secure communication mechanisms in place.

#### Secured network communication profile{#secured-network-communication-profile}

When using the secured network communication profile, the MQTT-SN protocol runs over a physical or virtual network which has security controls, VPNs or physically secure networks for example.

#### Secured transport profile{#secured-transport-profile}

When using the secured transport profile, the MQTT-SN protocol runs over a physical or virtual network and uses MQTT-SN Authentication, Protection Encapsulation, DTLS and/or other technologies to provide authentication, integrity and privacy.

DTLS Client authentication can be used in addition to -- or in place of -- MQTT-SN Client authentication as provided by the Authentication Method and Data fields.

#### Industry specific security profiles{#industry-specific-security-profiles}

It is anticipated that the MQTT-SN (and MQTT) protocols will be designed into industry specific application profiles, each defining a threat model and the specific security mechanisms to be used to address these threats.
Recommendations for specific security mechanisms will often be taken from existing works including:

- \[NISTCSF\] NIST Cyber Security Framework
- \[NIST7628\] NISTIR 7628 Guidelines for Smart Grid Cyber Security
- \[FIPS1403\] Security Requirements for Cryptographic Modules (FIPS PUB 140-3)
- \[PCIDSS\] PCI-DSS Payment Card Industry Data Security Standard
- [CNSA20](https://media.defense.gov/2022/Sep/07/2003071834/-1/-1/0/CSA_CNSA_2.0_ALGORITHMS_.PDF) Commercial National Security Algorithm Suite (CNSA) 2.0 
- [NSAB](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#NSAB) NSA Suite B Cryptography
