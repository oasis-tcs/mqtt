![OASIS](OASIS-Logo.png)

---

# MQTT Over QUIC — Single Stream Mode Version 1.0

## Committee Note Draft 01

## 7 April 2026

### This Version

- [link to authoritative version] (Authoritative)
- [links to other formats, e.g. PDF, HTML]

	### Previous Version

N/A — this is the initial version.

### Latest Version

- [link to authoritative version] (Authoritative)
- [links to other formats, e.g. PDF, HTML]

### Technical Committee

[OASIS Message Queuing Telemetry Transport (MQTT) TC](https://groups.oasis-open.org/communities/tc-community-home2?CommunityKey=99c86e3a-593c-4448-b7c5-018dc7d3f2f6)


### Chairs

- Richard Coppen (coppen@uk.ibm.com), IBM
- Simon Johnson (simon.johnson@hivemq.com), HiveMQ

### Secretaries

- Ian Craggs (icraggs@gmail.com), Personal

### Editors

- William Yang (william.yang@emqx.io), EMQ Sweden AB

### Abstract

This document defines the Single Stream operating mode of MQTT over QUIC, in
which the QUIC transport protocol replaces the TCP transport layer for MQTT
connections. In this mode, a single bidirectional QUIC stream carries all MQTT
control packets, requiring no changes to the MQTT packet format. This mode is
fully compatible with MQTT 3.1.1 and MQTT 5.0, and allows existing MQTT
implementations to benefit from QUIC connection-level features such as faster
handshakes, built-in TLS security, and network address migration.

### Citation Format

When referencing this document the following citation format should be used:

- [MQTT-QUIC-SS] "MQTT Over QUIC — Single Stream Mode Version 1.0", OASIS
  Committee Note Draft 01, [DD Month YYYY]. [link to latest version].

### Related Work

This document is related to:

- [MQTT5] "MQTT Version 5.0", OASIS Standard, March 2019.
  https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html
- [MQTT311] "MQTT Version 3.1.1", OASIS Standard, October 2014.
  https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html

## License, Document Status, and Notices

Copyright © OASIS Open 2026. All Rights Reserved. For license and copyright
information, and complete status, please see Annex A which contains the
License, Document Status and Notices.

---

## Table of Contents

- [1 Scope](#1-scope)
- [2 Definitions and Acronyms](#2-definitions-and-acronyms)
  - [2.1 Definitions](#21-definitions)
    - [2.1.1 Terms Defined Elsewhere](#211-terms-defined-elsewhere)
    - [2.1.2 Terms Defined in This Document](#212-terms-defined-in-this-document)
  - [2.2 Abbreviations and Acronyms](#22-abbreviations-and-acronyms)
- [3 Document Conventions](#3-document-conventions)
  - [3.1 Key Words](#31-key-words)
  - [3.2 Typographical Conventions](#32-typographical-conventions)
- [4 Introduction](#4-introduction)
  - [4.1 Motivation](#41-motivation)
  - [4.2 Changes From the Previous Version](#42-changes-from-the-previous-version)
- [5 Single Stream Mode](#5-single-stream-mode)
  - [5.1 Overview](#51-overview)
  - [5.2 Stream Establishment](#52-stream-establishment)
  - [5.3 MQTT Packet Transport](#53-mqtt-packet-transport)
  - [5.4 Feature Summary](#54-feature-summary)
  - [5.5 ALPN Negotiation](#55-alpn-negotiation)
    - [5.5.1 Client ALPN Offer](#551-client-alpn-offer)
    - [5.5.2 Server ALPN Selection](#552-server-alpn-selection)
    - [5.5.3 Negotiating Among Multiple Operating Modes](#553-negotiating-among-multiple-operating-modes)
- [6 Connection Management](#6-connection-management)
  - [6.1 Establishing a Connection](#61-establishing-a-connection)
  - [6.2 Connection Keepalive](#62-connection-keepalive)
  - [6.3 Connection Termination](#63-connection-termination)
    - [6.3.1 Graceful Shutdown](#631-graceful-shutdown)
    - [6.3.2 Abnormal Shutdown](#632-abnormal-shutdown)
  - [6.4 Protocol Discovery](#64-protocol-discovery)
    - [6.4.1 DNS-Based Endpoint Resolution](#641-dns-based-endpoint-resolution)
    - [6.4.2 QUIC Capability Probe](#642-quic-capability-probe)
  - [6.5 Upgrade](#65-upgrade)
    - [6.5.1 Client Upgrade Strategy](#651-client-upgrade-strategy)
    - [6.5.2 Broker Session Handling](#652-broker-session-handling)
    - [6.5.3 Client Reconnection After Session Determination](#653-client-reconnection-after-session-determination)
  - [6.6 Downgrade](#66-downgrade)
    - [6.6.1 Downgrade Categories](#661-downgrade-categories)
    - [6.6.2 Downgrade Behavior](#662-downgrade-behavior)
    - [6.6.3 Post-Session Downgrade](#663-post-session-downgrade)
    - [6.6.4 Preventing Reconnection Livelock](#664-preventing-reconnection-livelock)
  - [6.7 Error Mapping and State Synchronization](#67-error-mapping-and-state-synchronization)
  - [6.8 Keepalive Strategy](#68-keepalive-strategy)
- [7 Security Considerations](#7-security-considerations)
- [8 Conformance](#8-conformance)
  - [8.1 Conformance Targets](#81-conformance-targets)
  - [8.2 MQTT Client Conformance](#82-mqtt-client-conformance)
  - [8.3 MQTT Broker Conformance](#83-mqtt-broker-conformance)
- [Annex A License, Document Status and Notices](#annex-a-license-document-status-and-notices)
  - [A.1 Document Status](#a1-document-status)
  - [A.2 License and Notices](#a2-license-and-notices)
- [Annex B References](#annex-b-references)
  - [B.1 Normative References](#b1-normative-references)
- [Appendix 1 Acknowledgments](#appendix-1-acknowledgments)
- [Appendix 2 Changes From Previous Version](#appendix-2-changes-from-previous-version)

---

# 1 Scope

This document specifies the Single Stream operating mode for running MQTT over
the QUIC transport protocol [RFC9000]. In this mode, a single bidirectional
QUIC stream replaces the TCP connection that MQTT traditionally relies upon. All
MQTT control packets are transported over this one stream without modification
to the MQTT packet format.

This document applies to implementations of MQTT 3.1 [MQTT311] and MQTT 5.0
[MQTT5]. It covers connection establishment, keepalive, graceful and abnormal
connection termination, and protocol upgrade and downgrade procedures specific
to the Single Stream operating mode.

This document does not define multistream operation, server-initiated streams,
unreliable datagram delivery, or flow-level session persistence. Those features
are addressed in separate documents covering the Simple Multistream and Advanced
Multistream operating modes.

---

# 2 Definitions and Acronyms

## 2.1 Definitions

### 2.1.1 Terms Defined Elsewhere

This document uses the following terms as defined in external standards:

- **connection:** A transport-layer connection between two endpoints using QUIC
  as the transport protocol. [RFC9000]
- **stream:** A QUIC stream as defined in [RFC9000]. QUIC streams provide
  reliable, in-order delivery of bytes. Streams can be unidirectional or
  bidirectional, and can be initiated by either endpoint.
- **session:** An MQTT session as defined in [MQTT5] §4.1. For MQTT 3.1.1, the equivalent concept is the session defined in [MQTT311] §1.2 (Session), where session persistence is controlled by the Clean Session flag rather than a Session Expiry Interval.
- **MQTT packet:** An MQTT control packet as defined in [MQTT5] §2. For MQTT 3.1.1, the equivalent is an MQTT Control Packet as defined in [MQTT311] §3.

### 2.1.2 Terms Defined in This Document

This document defines the following terms:

- **bidi:** A QUIC stream direction; bidirectional, meaning both endpoints can
  send and receive data on the same stream.
- **endpoint:** An MQTT client or MQTT broker participating in a connection.
- **peer:** The remote endpoint in a connection.
- **sender:** The endpoint transmitting data over the stream.
- **receiver:** The endpoint receiving data over the stream.

## 2.2 Abbreviations and Acronyms

This document uses the following abbreviations and acronyms:

- **ALPN:** Application-Layer Protocol Negotiation
- **BIDI:** Bidirectional (QUIC stream direction)
- **HOLB:** Head-of-Line Blocking
- **MQTT:** Message Queuing Telemetry Transport
- **QoS:** Quality of Service
- **QUIC:** The QUIC transport protocol, as standardised by the IETF in [RFC9000]
- **RFC:** Request for Comments
- **RTT:** Round-Trip Time
- **TC:** Technical Committee
- **TLS:** Transport Layer Security

---

# 3 Document Conventions

## 3.1 Key Words

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in BCP 14 [RFC2119] [RFC8174] when,
and only when, they appear in all capitals, as shown here.

## 3.2 Typographical Conventions

MQTT packet type names are written in the form `MQTT.PACKETNAME`, for example
`MQTT.CONNECT` and `MQTT.DISCONNECT`, to clearly distinguish them from
surrounding prose.

QUIC frame type names are written in all capitals, for example
`CONNECTION_CLOSE` and `RESET_STREAM`, following the convention used in
[RFC9000].

---

# 4 Introduction

## 4.1 Motivation

QUIC is the transport protocol underlying HTTP/3, standardised by the IETF in
[RFC9000]. It was designed to address well-known limitations of TCP, making it
an attractive replacement transport for MQTT deployments in modern mobile and
constrained-network environments.

The Single Stream mode is the simplest way to bring these connection-level
benefits to MQTT. By replacing the TCP/TLS connection with a QUIC connection and
routing all MQTT traffic through one bidirectional stream, implementations gain
the following advantages with minimal changes to existing code.

**Faster connection establishment.** QUIC completes its cryptographic handshake
in one round trip (1-RTT), compared to the multiple round trips required by
TCP+TLS. After a prior connection, QUIC can resume in zero round trips (0-RTT),
allowing MQTT clients to send data before the server has responded — beneficial
for devices operating on high-latency networks.

**Robustness to network changes.** QUIC's connection migration feature allows
an endpoint to change its IP address or port without losing the connection. MQTT
clients that roam between Wi-Fi and cellular networks can remain connected
through the network change without disconnecting and reconnecting.

**Embedded security.** QUIC mandates TLS 1.3 for all connections by default.
There is no plain-text QUIC option. This eliminates the need for a separate TLS
negotiation step and ensures that all MQTT traffic is encrypted in transit.

**Pluggable congestion control.** QUIC's congestion control algorithm is
implemented in user space and can be tailored to the requirements of a specific
deployment, without changes to the kernel network stack.

## 4.2 Changes From the Previous Version

The list of changes from the previous version and any revision history can be
found in Appendix 2.

---

# 5 Single Stream Mode

## 5.1 Overview

Single Stream mode is the simplest operating mode for MQTT over QUIC. It
replaces the TCP transport with a QUIC connection while keeping the MQTT
protocol layer entirely unchanged. All MQTT control packets are carried over a
single bidirectional QUIC stream in exactly the same byte format as they would
be over TCP.

This mode is designed to be a minimal-effort migration path. Implementations
that already support MQTT over TCP can adopt this mode by substituting the
transport layer without modifying any MQTT packet handling logic.

## 5.2 Stream Establishment

After the QUIC connection handshake is complete, the client MUST open exactly
one bidirectional (BIDI) QUIC stream. This stream carries all MQTT packets for
the lifetime of the connection. The server MUST NOT initiate a stream in Single
Stream mode.

The ALPN identifier negotiated during the QUIC handshake for Single Stream mode
is `mqtt`.

## 5.3 MQTT Packet Transport

All MQTT control packets — including `MQTT.CONNECT`, `MQTT.CONNACK`,
`MQTT.PUBLISH`, `MQTT.SUBSCRIBE`, `MQTT.PINGREQ`, `MQTT.DISCONNECT`, and all
associated acknowledgement packets — MUST be transmitted over the single
bidirectional stream in the order they are produced. No changes are made to the
MQTT packet binary format. This mode is fully compatible with MQTT 3.1
[MQTT311] and MQTT 5.0 [MQTT5].

QUIC delivers data as an ordered byte stream and does not preserve packet
boundaries: a single MQTT packet may span multiple QUIC STREAM frames, or
multiple MQTT packets may arrive in a single STREAM frame [RFC9000]. Endpoints
MUST reassemble MQTT packets from the QUIC byte stream according to the MQTT
remaining length field [MQTT5] §2.1.4, exactly as they would when receiving
data over TCP.

Because there is only one stream, MQTT traffic in this mode retains the same
head-of-line blocking characteristics as TCP-based transport: a large PUBLISH
payload will delay all subsequent packets — including `MQTT.PINGREQ` keepalive
packets — until transmission is complete. Applications that require HOLB
mitigation should consider the Simple Multistream or Advanced Multistream
operating modes instead.

## 5.4 Feature Summary

Table I summarises the capabilities of Single Stream mode compared to the other
operating modes defined in the MQTT over QUIC family of documents.

Table I

**Table I:** Feature comparison across MQTT over QUIC operating modes.

| Feature                           | Single Stream | Simple Multistream  | Advanced Multistream |
| :-------------------------------- | :-----------: | :-----------------: | :------------------: |
| MQTT 3.1 compatible               |      Yes      |         Yes         |          No          |
| MQTT 5.0 compatible               |      Yes      |    Yes (partial)    |          No          |
| TLS ALPN identifier               |    `mqtt`     |       `mqtt`        |     `mqtt-next`      |
| Transport keepalive               |      Yes      |         Yes         |         Yes          |
| 1-RTT / 0-RTT handshake           |      Yes      |         Yes         |         Yes          |
| Network address migration         |      Yes      |         Yes         |         Yes          |
| Unreliable delivery               |      No       |         No          |         Yes          |
| Co-existence with other protocols |      No       |         No          |         Yes          |
| Number of concurrent streams      |       1       |        1..n         |         1..n         |
| Broker-initiated stream           |      No       |         No          |         Yes          |
| Per-stream flow control           |      No       |         Yes         |         Yes          |
| Per-stream prioritization         |      No       |         Yes         |         Yes          |
| Persistent sessions               |      Yes      | Control stream only |         Yes          |
| HOLB mitigation                   |      No       |         Yes         |         Yes          |
| Send/receive abort                |      No       |         Yes         |         Yes          |
| Trackable flows                   |      No       |         No          |         Yes          |

## 5.5 ALPN Negotiation

The Application-Layer Protocol Negotiation (ALPN) extension [RFC7301] is the
sole mechanism for identifying Single Stream mode during the QUIC handshake.
QUIC uses the ALPN extension as defined in [RFC9001] §8.1 to negotiate the
application-layer protocol before any application data is exchanged.

### 5.5.1 Client ALPN Offer

The client MUST include the ALPN identifier `mqtt` in the ALPN protocol list
it offers during the QUIC handshake when it intends to use Single Stream
mode. A client that supports multiple operating modes from the MQTT over QUIC
family of documents MAY offer several identifiers in a single handshake (e.g.,
`mqtt-next` and `mqtt`), listed in descending order of preference [RFC7301].

If the client does not include `mqtt` in its offer, the server cannot select
Single Stream mode for the connection.

### 5.5.2 Server ALPN Selection

In ALPN, the server selects exactly one protocol from the list offered by the
client, or fails the handshake; the server cannot select an identifier that
the client did not offer [RFC7301]. When a client's offer includes `mqtt`,
the server MUST respond as follows:

1. If the server supports Single Stream mode, the server SHOULD select the
   `mqtt` identifier, unless the client's offer contains another mutually
   supported MQTT over QUIC identifier that is preferred as described in
   Section 5.5.3. When the server selects `mqtt`, it MUST treat the
   connection as a Single Stream mode connection.
2. If the server supports none of the identifiers offered by the client, the
   server MUST terminate the QUIC handshake with a `no_application_protocol`
   TLS alert (QUIC error code 0x0178) [RFC9001] §8.1.

When the server selects `mqtt`, the client MUST open a bidirectional QUIC
stream as defined in Section 5.2 and proceed with the MQTT handshake.

### 5.5.3 Negotiating Among Multiple Operating Modes

A server MAY support multiple operating modes defined in the MQTT over QUIC
family of documents (e.g., `mqtt` for Single Stream and `mqtt-next` for
Advanced Multistream). When the client's offer contains more than one of
these identifiers, the server SHOULD select the identifier that appears
earliest in the client's preference order among those the server supports.

If the server selects an identifier that the client did not offer, the client
MUST treat this as a connection error of type 0x0178
(`no_application_protocol`) and close the connection [RFC9001] §8.1.

The ALPN negotiation MUST be completed before any MQTT packets are exchanged.
A server that has not negotiated the `mqtt` ALPN identifier MUST NOT accept
MQTT packets over the connection.

---

# 6 Connection Management

## 6.1 Establishing a Connection

A QUIC connection MUST be established between the client and the server as
described in [RFC9000] before any MQTT packets are exchanged. The client
initiates the QUIC connection.

Support for 0-RTT connection resumption is OPTIONAL. Implementations that
support 0-RTT SHOULD be aware of replay risks when sending early data; see
Section 7 for security considerations.

## 6.2 Connection Keepalive

Connection keepalive in Single Stream mode is performed at the QUIC transport
layer. QUIC does not define a dedicated keepalive frame; instead, implementations
MUST maintain the QUIC connection by setting the `max_idle_timeout` transport
parameter [RFC9000] §18.2. The effective idle timeout is the minimum of the
values advertised by both endpoints, with a minimum floor of 3× PTO per
[RFC9000] §10.1. During idle periods, implementations MAY send PADDING frames
or ACK frames to prevent the connection from timing out due to inactivity.

QUIC connection keepalive is end-to-end: the idle timeout is negotiated between the
two endpoints directly and cannot be intercepted or terminated by intermediaries
such as proxies, NAT gateways, or load balancers.

MQTT-level keepalive via `MQTT.PINGREQ` and `MQTT.PINGRESP` MAY still be used
alongside QUIC keepalive. However, if a QUIC connection is configured with an idle
timeout, that timeout SHOULD be set to a value greater than the MQTT keepalive
value to avoid conflict.

## 6.3 Connection Termination

### 6.3.1 Graceful Shutdown

QUIC does not define a protocol-level graceful shutdown mechanism. In Single
Stream mode, graceful disconnection is handled at the MQTT layer before the
QUIC connection is closed.

Graceful shutdown MAY be used by a broker to redirect the client to another
server or to prevent transmission of the client's Will message. A client MAY
use graceful shutdown to clear session state or to set a new session expiration
time. MQTT defines graceful shutdown with the stream shutdown reason code
`NO_ERROR`.

**Client-initiated graceful shutdown:**

1. For MQTT 5.0, the client MUST send `MQTT.DISCONNECT` over the stream, with
   the Disconnect Reason Code explicitly set. For MQTT 3.1.1, the client MUST
   send `MQTT.DISCONNECT` without a reason code or properties (the 3.1.1
   DISCONNECT packet has no variable header [MQTT311] §3.14.1).
2. The client MUST then wait for the stream's graceful shutdown to complete.
3. Any MQTT packets received from the broker before the stream is closed SHOULD
   be properly handled.
4. After the stream is closed, the client MAY initiate an immediate QUIC
   connection shutdown, informing the peer, or terminate the connection locally
   without notifying the peer.
5. The client MUST discard all MQTT packets received from the broker after
   sending `MQTT.DISCONNECT`.
6. If the client receives a QUIC `CONNECTION_CLOSE` frame before the stream
   shutdown completes, the graceful shutdown procedure has failed.
7. The client MAY time out while waiting for stream shutdown to complete. In
   that case, the client MAY initiate an immediate connection shutdown with
   error code `ERROR_DISCONNECT_TIMEOUT`, indicating that graceful shutdown has
   failed.

**Server-initiated graceful shutdown:**

For MQTT 5.0, the server MAY send `MQTT.DISCONNECT` with a Reason Code to
gracefully terminate the session before closing the QUIC connection. For
MQTT 3.1.1, the broker MUST NOT send `MQTT.DISCONNECT` — the 3.1.1
specification defines DISCONNECT as a client-to-server-only packet
[MQTT311] §3.14. In this case the broker MUST close the QUIC connection
immediately (With application error code in `QUIC.CONNECTION_CLOSE` frame, [RFC9000] §20.2).

For MQTT 5.0, 
1. the server MUST send `MQTT.DISCONNECT` over the stream, with
   the Disconnect Reason Code explicitly set.
2. The server MUST then wait for the stream's graceful shutdown to complete.
3. The server MUST NOT send any further MQTT packets after initiating shutdown.
4. After the stream is closed, the server MAY initiate an immediate QUIC
   connection termination or terminate the connection locally without notifying
   the peer.

### 6.3.2 Abnormal Shutdown

Abnormal shutdown is any connection termination that does not follow the
graceful shutdown procedure. It does not require cooperation from the peer. The
following conditions can trigger abnormal shutdown:

- The stream is aborted before the graceful shutdown procedure completes.
- An immediate connection shutdown is triggered locally by the application.
- An immediate connection shutdown is triggered remotely by the peer before the
  graceful shutdown procedure completes.
- The connection becomes idle and times out.
- An unrecoverable transport error occurs, such as a device failure, operating
  system failure, or an unhandled network change.

## 6.4 Protocol Discovery

Protocol discovery determines whether a broker supports MQTT over QUIC before
the client commits to a QUIC connection. Discovery consists of two phases:
endpoint resolution via DNS and capability probing via QUIC.

### 6.4.1 DNS-Based Endpoint Resolution

The client MUST use DNS to resolve the broker's hostname to an IP address and
port. DNS Service Discovery (SRV records [RFC2782]) MAY be used to locate MQTT
endpoints. For example, the client MAY look up `_mqtt._tcp.<domain>` to obtain
the host and port of the MQTT service.

DNS resolution does not indicate whether the endpoint supports QUIC. The port
returned by DNS is shared between TCP/TLS and QUIC, so the client cannot
determine QUIC support from DNS alone. DNS resolution provides the endpoint
address; actual QUIC support is determined through probing as described in
Section 6.4.2.

DNS responses SHOULD be validated using DNSSEC [RFC4033] or an equivalent
mechanism to prevent DNS spoofing attacks. When DNSSEC is not available, the
client SHOULD validate the TLS certificate during the TCP/TLS connection, which
provides transport-level authenticity.

### 6.4.2 QUIC Capability Probe

The client discovers whether the broker supports MQTT over QUIC by opening a
QUIC connection to the endpoint resolved via DNS and inspecting the ALPN
identifier negotiated during the handshake.

The client SHOULD attempt a QUIC connection to the same host and port obtained
via DNS resolution, offering `mqtt` as the ALPN identifier. The outcome of this
probe determines QUIC support:

1. **`mqtt` selected:** The broker supports Single Stream mode. The
   client MAY proceed with the QUIC connection as a primary transport or as an
   upgrade from TCP/TLS as described in Section 6.5.
2. **Another offered identifier selected:** This outcome is only possible if
   the client offered more than one identifier (Section 5.5.1). The broker
   supports QUIC but selected a different operating mode. The client SHOULD
   proceed with the selected mode if it is an MQTT-compatible protocol, or
   fall back to TCP/TLS otherwise.
3. **ALPN negotiation fails:** The QUIC handshake fails with a
   `no_application_protocol` alert (QUIC error code 0x0178) [RFC9001] §8.1,
   indicating the broker supports none of the offered identifiers. The client
   MUST fall back to TCP/TLS.
4. **QUIC connection fails (network error):** The client cannot establish a QUIC
   connection due to a network-level failure. See Section 6.6 for downgrade
   rules.

A QUIC probe that does not result in a successful `mqtt` ALPN negotiation is
not an MQTT session attempt. The client MUST NOT send any MQTT packets during
the probe phase.

The client SHOULD NOT maintain more than one QUIC probe connection to the same
endpoint simultaneously. If multiple probe connections are opened (e.g., for
redundancy), the client MUST close all non-winning probes once the outcome is
known.

## 6.5 Upgrade

The client MAY upgrade from a TCP/TLS-based MQTT connection to a QUIC-based
connection when the broker supports both transports. The upgrade process is
controlled entirely by the client, which determines which transport to use
without broker coordination during the initial connection phase.

### 6.5.1 Client Upgrade Strategy

When upgrading, the client MUST follow a single-stream upgrade strategy:

1. The client opens a QUIC connection to the broker offering `mqtt` as the ALPN
   identifier and opens a bidirectional stream.
2. The client MUST NOT send `MQTT.CONNECT` on the TCP/TLS transport until the
   QUIC stream is established and the ALPN has been confirmed as `mqtt`.
3. The client sends `MQTT.CONNECT` only over the QUIC stream.
4. If the QUIC connection is not established within a configurable timeout
   (RECOMMENDED: 5 seconds), the client MUST fall back to the TCP/TLS transport
   and send `MQTT.CONNECT` over TCP/TLS.

The client MUST NOT send `MQTT.CONNECT` on both transports simultaneously.
Maintaining both connections open without sending CONNECT on either is permitted
during the probe phase (Section 6.4.2), but once the client begins the MQTT
handshake, only one transport may carry the session.

**Scope of this section.** The rules in this section apply only to the initial
connection attempt — the one-shot decision of which transport to use for the
first `MQTT.CONNECT`. They do not constrain reconnection attempts triggered
by the application or by the client library after the session is established.
For example, if a QUIC connection drops after the session is established, the
application MAY choose to reconnect on TCP/TLS; this is a normal reconnection
following standard MQTT session takeover rules [MQTT5] §3.1.4 or
[MQTT311] §3.1.4, not an "upgrade," and the rules in this section do not apply.

### 6.5.2 Broker Session Handling

When multiple transports are active for the same client (e.g., both TCP/TLS and
QUIC connections exist), the broker MUST apply the standard session takeover
rules for the negotiated MQTT version.

For MQTT 5.0, the broker MUST follow [MQTT5] §3.1.4:

1. The broker MUST accept the **last** `MQTT.CONNECT` received and establish
   the MQTT session on that transport. If the Client Identifier in the new
   `MQTT.CONNECT` matches a client already connected on another transport, the
   broker MUST perform session takeover as defined in [MQTT5] §3.1.4.
2. The broker MUST send `MQTT.DISCONNECT` with Reason Code `0x8E` (Session
   taken over) to the **losing** transport and MUST close that transport
   [MQTT5] §3.1.4. This allows the client on the losing transport to handle
   any remaining session state cleanly.
3. The broker MUST send `MQTT.CONNACK` to the **winning** transport. The
   `Session Present` flag [MQTT5] §3.2.2.1 MUST reflect the result of
   Clean Start processing [MQTT5] §3.2.2.1.1: if Clean Start is 0 and a session
   exists, the flag MUST be set to 1; if Clean Start is 1, the flag MUST be
   set to 0.

For MQTT 3.1.1, the broker MUST follow [MQTT311] §3.1.4:

1. The broker MUST accept the **last** `MQTT.CONNECT` received and establish
   the MQTT session on that transport. If the Client Identifier in the new
   `MQTT.CONNECT` matches a client already connected on another transport, the
   broker MUST disconnect the existing client [MQTT-3.1.4-2].
2. The broker MUST close the **losing** transport immediately (without sending
   `MQTT.DISCONNECT`, which is not a server-to-client packet in MQTT 3.1.1).
   The 3.1.1 specification requires only that the existing client be
   disconnected — the mechanism is closing the network connection.
3. The broker MUST send `MQTT.CONNACK` with the `Session Present` flag set
   to 0 to the **winning** transport. In MQTT 3.1.1 the CONNACK does not
   carry a `Session Present` flag; the client determines session state from
   the `Clean Session` flag it sent in CONNECT [MQTT311] §3.1.2.4. The broker
   MUST set `Clean Session` according to the value received in the CONNECT.
   If `Clean Session` is 1, the broker discards any existing session state
   for this Client Identifier; if `Clean Session` is 0, the broker retains
   the session but has no flag to communicate its existence in CONNACK.

4. The broker MUST NOT distinguish between a CONNECT from an upgrade attempt
   and a CONNECT from a normal reconnection. For both MQTT 5.0 and MQTT 3.1.1,
   the broker always applies standard session takeover rules: the **last**
   `MQTT.CONNECT` received wins, regardless of which transport it arrived on.
   The "upgrade race window" is a client-side concept — the broker has no
   awareness of it and does not enforce any special rules.

The "last CONNECT wins" rule means the session outcome depends on connection
timing and which CONNECT packet reaches the broker first. The broker MUST NOT
prefer one transport type over the other; the decision is purely based on network packet
arrival order.

### 6.5.3 Client Reconnection After Session Determination

Once the client determines which transport carries the session, the client MUST
NOT attempt to re-establish the session on the other transport:

1. If the QUIC session wins and the TCP/TLS transport is closed, the client MUST
   NOT re-open the TCP/TLS transport for this session. The client MUST use the QUIC
   transport exclusively.
2. If the TCP/TLS session wins and the QUIC transport is closed, the client MUST
   fall back to TCP/TLS and MUST NOT re-attempt QUIC for this session unless
   explicitly reconfigured by the application or user.
3. If the client receives `MQTT.DISCONNECT` with Reason Code `0x8E` on a
   transport (MQTT 5.0 only), the client MUST close its local connection on
   that transport and MUST NOT send a new CONNECT on it for this session.
   For MQTT 3.1.1, the client learns of takeover when the broker closes the
   connection on the losing transport without sending `MQTT.DISCONNECT`; the
   client MUST then close its local connection on that transport and MUST NOT
   send a new CONNECT on it for this session.

These rules prevent livelock scenarios where the client and broker continuously
toggle the session between transports.

## 6.6 Downgrade

Protocol downgrade is the process of falling back from a QUIC-based connection
to TCP/TLS when the QUIC connection cannot be established or is lost after the
MQTT session has been established on QUIC.

### 6.6.1 Downgrade Categories

The client MUST distinguish between the following categories of QUIC failure
when determining the downgrade behavior:

**Network failure** — The QUIC connection cannot be established due to a
network-level error. This includes:

- Connection timeout (no response from the server).
- Destination unreachable (ICMP error messages).
- Port unreachable or connection refused by the operating system.
- MTU-related failures where the QUIC handshake packets exceed the path MTU and
  cannot be fragmented.

Network failures are potentially transient. The client SHOULD retry the QUIC
connection up to three times with exponential backoff before falling back to
TCP/TLS. The RECOMMENDED backoff values are: 1 second, 2 seconds, 4 seconds.
The maximum cumulative retry timeout SHOULD NOT exceed 10 seconds. If any retry
succeeds, the client uses QUIC and does not fall back.

**ALPN mismatch** — The QUIC endpoint is reachable, but ALPN negotiation does
not yield `mqtt`: either the handshake fails with a `no_application_protocol`
alert (QUIC error code 0x0178) [RFC9001] §8.1, or the server selects another
client-offered identifier that is not an MQTT-compatible protocol. This
indicates that the endpoint does not support Single Stream mode. The endpoint
may support other protocols (e.g., HTTP/3), so the client MUST NOT assume that
the endpoint is unavailable for MQTT.

On ALPN mismatch, the client MUST downgrade to TCP/TLS and attempt to
establish a connection. The client MUST NOT apply backoff for ALPN mismatch, as
the endpoint is reachable and the failure is due to protocol incompatibility,
not a transient network condition.

### 6.6.2 Downgrade Behavior

When downgrading, the client MUST:

1. Close the failed QUIC connection (if still open).
2. Resolve the broker's hostname via DNS (as described in Section 6.4.1),
   obtaining the host and port for TCP/TLS.
3. Establish a TCP/TLS connection to the broker.
4. Send `MQTT.CONNECT` over the TCP/TLS connection.
5. The client MUST NOT downgrade to a plain-text TCP connection under any
   circumstances. TLS encryption is REQUIRED for the TCP/TLS fallback.

### 6.6.3 Post-Session Downgrade

If the MQTT session is already established on QUIC and the QUIC connection is
lost, the client MAY attempt to re-establish the session on QUIC. If QUIC
reconnection fails repeatedly (per the backoff rules in Section 6.6.1), the
client MAY downgrade to TCP/TLS as a last resort.

If the client previously received a CONNACK with Session Expiry Interval greater
than zero (MQTT 5.0), indicating that the broker retains the session, the client
SHOULD prefer reconnecting on QUIC before attempting TCP/TLS. This helps avoid
unintended session takeovers where the client's TCP/TLS reconnection could
displace an existing QUIC session that the broker is still maintaining.

For MQTT 3.1.1, the CONNACK has no Session Expiry Interval. The client MUST
infer session persistence from the `Clean Session` flag it sent in CONNECT:
if `Clean Session` was 0, the broker retains the session across network
failures [MQTT311] §3.1.1; the client SHOULD prefer reconnecting on QUIC
before attempting TCP/TLS to avoid unintended session takeovers.

### 6.6.4 Preventing Reconnection Livelock

The livelock concern arises during the **upgrade race window** — the brief
period when both transports carry active connections for the same session
(Section 6.5.2). The broker does not enforce any special rules during this
window; it always applies standard MQTT session takeover (last CONNECT wins).
Livelock prevention is entirely the **client's** responsibility.

**How the livelock occurs.** Suppose the client sends `MQTT.CONNECT` on both
TCP/TLS and QUIC. If the TCP/TLS CONNECT arrives first, the broker accepts it
and closes QUIC. The client on the QUIC side detects the close, opens a new
QUIC connection, and sends another `MQTT.CONNECT`. If that new CONNECT arrives
before the TCP/TLS side has finished processing the first one, the broker
accepts the QUIC CONNECT and closes TCP/TLS. The TCP/TLS side then reconnects,
and the cycle repeats. The broker is not the problem — it always follows the
standard "last CONNECT wins" rule. The livelock is caused by the client
retrying before it has definitively determined which transport won.

**Client-side livelock prevention.** When the client detects that its
connection lost the upgrade race (via `MQTT.DISCONNECT` 0x8E, connection
close, or CONNACK timeout), the client MUST apply a backoff before attempting
to reconnect on the other transport. The RECOMMENDED backoff interval is
5 seconds.

For MQTT 5.0, the losing side receives `MQTT.DISCONNECT` with Reason Code
`0x8E` (Session taken over) [MQTT5] §3.1.4 or learns of the loss when the
broker closes the connection. For MQTT 3.1.1, the losing side learns of the
loss when the broker closes the connection (without sending `MQTT.DISCONNECT`,
which is client-to-server-only [MQTT311] §3.14).

The client MUST apply a fixed backoff (RECOMMENDED: 5 seconds) in both cases.
This backoff serves two purposes:

1. It gives the winning side time to complete the MQTT handshake (send
   CONNACK) before the losing side retries.
2. It prevents rapid flip-flopping if the client library automatically
   retries after a connection failure.

**After the race window ends.** Once the winning connection is established
and the losing connection is closed, the race window ends. The client MAY
reconnect on the other transport as normal. The broker applies standard
MQTT session takeover rules [MQTT5] §3.1.4 or [MQTT311] §3.1.4 to such
reconnections — it does not enforce any special livelock prevention beyond
the normal "last CONNECT wins" behavior.

---

## 6.7 Error Mapping and State Synchronization

To ensure robust communication and consistent state management, it is critical to define a clear mapping between the QUIC transport layer errors and the MQTT application layer errors. This chapter addresses the synchronization of state between the underlying QUIC connection and the MQTT session, specifically focusing on how transport-level failures translate into application-level outcomes and vice versa.

### 6.7.1 Mapping QUIC Transport Errors to MQTT Session State

In an MQTT over QUIC implementation, the MQTT session is decoupled from the underlying transport. Therefore, a failure at the QUIC layer does not automatically necessitate the immediate termination of the MQTT session.

### 6.7.1.1 Abnormal Transport Shutdown

An “Abnormal Shutdown” (as defined in Section 6.3.2) occurs when the QUIC connection or stream is terminated without a graceful MQTT.DISCONNECT handshake. This includes:

- QUIC stream resets.

- Connection timeouts or unrecoverable transport errors (e.g., device failure).

- Immediate connection termination by the peer.

Mapping Logic:

- Session Persistence: When a QUIC-level error triggers an abnormal shutdown, the MQTT session MUST NOT be immediately terminated. The session state remains active on the broker according to the established Session Expiry Interval (MQTT 5.0) or until the client sends a CONNECT with `Clean Session` set to 1 (MQTT 3.1.1 [MQTT311] §3.1.3).

- State Synchronization: The application layer distinguishes a network-level QUIC failure from a protocol violation by the absence of an MQTT.DISCONNECT packet. 
  If the QUIC connection is lost, the client may attempt to reconnect and resume the session using the same Client Identifier.

### 6.7.2 Mapping MQTT Protocol Errors to QUIC Connection State

Errors detected at the MQTT application layer may require the immediate termination of the underlying QUIC transport to prevent the processing of malformed or unauthorized data.

#### 6.7.2.1 Protocol Violations and Malformed Packets (MQTT 5.0)

In accordance with MQTT 5.0 specifications, if the Server detects a Malformed Packet or Protocol Error:

Notification: The server SHOULD send an `MQTT.DISCONNECT` packet containing the appropriate Reason Code (e.g., `0x81` for Malformed Packet or `0x82` for Protocol Error).
Transport Action: Immediately following the transmission of the `MQTT.DISCONNECT` (or if the error occurs during the CONNECT phase), the server MUST initiate a QUIC connection closure.

#### 6.7.2.2 Protocol Violations and Malformed Packets (MQTT 3.1.1)

For MQTT 3.1.1, the broker MUST NOT send `MQTT.DISCONNECT` (it is a client-to-server-only packet [MQTT311] §3.14). Upon detecting a Malformed Packet or Protocol Error:

Notification: The broker MUST NOT send any MQTT packet to the client.
Transport Action: The broker MUST immediately close the QUIC connection.

### 6.7.3 Error Mapping Matrix

The following table summarizes the mapping between the layers. The "MQTT Session Impact" column shows the behavior for MQTT 5.0; MQTT 3.1.1 behavior is noted below the table.

| EVENT SOURCE |       ERROR TYPE        |  ACTION/MAPPING   |        MQTT SESSION IMPACT        | QUIC CONNECTION IMPACT |
|:-------------|:-----------------------:|:-----------------:|:---------------------------------:|------------------------|
| QUIC Layer   | Stream Reset / Timeout  | Abnormal Shutdown |  Session persists (until Expiry)  | Connection Terminated  |
| QUIC Layer   |     Connection Loss     | Abnormal Shutdown |  Session persists (until Expiry)  | Connection Terminated  |
| MQTT Layer   | Malformed Packet (0x81) |  Protocol Error   |        Session Terminated         | Connection Closed      |
| MQTT Layer   |  Protocol Error (0x82)  |  Protocol Error   |        Session Terminated         | Connection Closed      |
| Application  |    Graceful Shutdown    |  MQTT.DISCONNECT  | Session Closed/Persisted per flag | Graceful Shutdown      |

**MQTT 3.1.1 notes:** For MQTT 3.1.1, the session lifetime is controlled by the `Clean Session` flag in CONNECT [MQTT311] §3.1.2.4 rather than a Session Expiry Interval. 
When `Clean Session` is 0, the session persists indefinitely until the client sends a CONNECT with `Clean Session` set to 1 or the broker closes the connection. 
Therefore, the "Session persists (until Expiry)" rows above should be read as "Session persists until `Clean Session`=1 or broker closes connection" for MQTT 3.1.1. 
The Malformed Packet and Protocol Error rows close the connection but the 3.1.1 session state is NOT terminated — it persists indefinitely if `Clean Session` was 0.

### 6.7.4 State Synchronization Summary
To prevent “zombie” sessions or inconsistent states, the following rules apply:

Transport-to-Application: QUIC-level errors trigger a transition to a “disconnected” state but maintain the “session” state until the expiry timer expires.
Application-to-Transport: MQTT-level protocol errors trigger an immediate and mandatory teardown of the QUIC transport layer to ensure security and data integrity.


### 6.8 Keepalive Strategy

The keepalive strategy leverages both QUIC's transport-level features and MQTT's application-level liveness mechanisms. 

QUIC transport layer keepalive is encouraged to be used as primary Mechanism because in traditional TCP-based MQTT, a large payload 
could block a PINGREQ from being sent, leading to false disconnections while this is mitigated in QUIC transport, QUIC PING frames are transport-level control frames 
rather than application data, meaning they do not belong to any specific stream. They bypass stream-level flow control and ordering constraints.

The strategy is defined as follows:

**Transport-Layer Keepalive**

- Primary Mechanism: 

Connection keepalive SHOULD be handled natively by the underlying QUIC transport layer, with both the client and server maintaining their own keepalive traffic.

- End-to-End Delivery: 

Because QUIC keepalive is end-to-end, the keepalive packets are delivered directly between the endpoints without the risk of being intercepted or terminated by intermediaries like proxies, NAT gateways, or load balancers.

- Simplified Implementation: 

Relying on QUIC for this traffic simplifies the timing implementation for both the MQTT client and server.

**Application-Layer (MQTT) Keepalive**

- MQTT PINGREQ/PINGRESP:

The traditional MQTT keepalive mechanism using PINGREQ and PINGRESP control packets SHOULD still be supported for application-level liveness detection but not encouraged.

- Timeout Coordination: 

If QUIC connection keepalive is enabled, the QUIC connection's idle timeout SHOULD be configured to be strictly greater than the MQTT keepalive interval. 
This prevents the QUIC connection from abruptly shutting down due to perceived idleness while the application is waiting to send an MQTT.PINGREQ packet.


---

# 7 Security Considerations

**Server-side authentication only.** Single Stream mode requires server-side
authentication only: the client MUST authenticate the broker's identity by
validating the broker's TLS certificate against its expected hostname.
Mutual TLS (mTLS) — where the broker requires a client certificate — is
**not required** by this specification and is OPTIONAL. Implementations that
wish to use client certificates for additional access control MAY enable mTLS
at the TLS layer, but such a requirement must not be treated as a mandatory
part of Single Stream mode conformance.

**Mandatory encryption.** QUIC mandates TLS 1.3 for all connections [RFC9000].
There is no unencrypted QUIC option. All MQTT traffic in Single Stream mode is
therefore encrypted in transit. Implementations MUST NOT downgrade to plain-text
TCP when falling back from a failed QUIC connection.

**0-RTT replay risk.** When 0-RTT connection resumption is used, early data
sent by the client before the server responds may be replayed by an attacker.
Implementations that support 0-RTT MUST ensure that any MQTT packets sent as
early data are safe to replay, i.e., are idempotent or are protected by a
server-verified session token. An `MQTT.CONNECT` packet sent in 0-RTT mode
SHOULD be treated with caution by the server until session state can be
verified.

When 0-RTT is used during an upgrade from TCP/TLS to QUIC, the replay risk is
amplified: an attacker who observes the client's upgrade attempt could replay
the early `MQTT.CONNECT` on a new QUIC connection, causing the server to
establish a duplicate session while the client's original session remains active.
The server MUST detect duplicate sessions (e.g., same Client Identifier active
on multiple transports) and close the earlier session, following the last-CONNECT
wins rule defined in Section 6.5.2.

**DNS spoofing during protocol discovery.** When the client uses DNS to resolve
the broker's hostname before probing QUIC support, a malicious actor could
forge DNS responses to redirect the client to an untrusted endpoint. Clients
SHOULD validate DNS responses using DNSSEC [RFC4033] or an equivalent mechanism.
When DNSSEC is not available, the client MUST validate the TLS certificate
during the TCP/TLS fallback connection; the certificate's subject name or
subject alternative names MUST match the intended broker hostname.

**Protocol downgrade.** Downgrade from QUIC to TCP/TLS is permitted when the
QUIC handshake fails or times out. Downgrade to plain-text TCP is prohibited.
Implementations MUST enforce this rule to preserve the security guarantees of
TLS in all fallback scenarios.

---

# 8 Conformance

## 8.1 Conformance Targets

This document defines conformance requirements for two implementation targets:

- **MQTT Client:** An endpoint that initiates the QUIC connection and opens the
  single bidirectional stream.
- **MQTT Broker:** An endpoint that accepts the QUIC connection and receives
  MQTT packets over the bidirectional stream opened by the client.

## 8.2 MQTT Client Conformance

A conformant MQTT client implementing Single Stream mode:

1. MUST establish a QUIC connection to the broker as specified in [RFC9000].
2. MUST negotiate the ALPN identifier `mqtt` during the QUIC handshake.
3. MUST open exactly one bidirectional QUIC stream after the handshake and use
   it to carry all MQTT packets.
4. MUST NOT modify the binary format of any MQTT packet.
5. MUST follow the client-initiated graceful shutdown procedure defined in
   Section 6.3.1 when disconnecting cleanly.
6. MUST NOT open additional streams in Single Stream mode.
7. MUST downgrade to a TCP/TLS connection if the QUIC handshake fails or times
   out.
8. MUST NOT downgrade to a plain-text TCP connection under any circumstances.

## 8.3 MQTT Broker Conformance

A conformant MQTT broker implementing Single Stream mode:

1. MUST accept QUIC connections from clients.
2. MUST recognise the ALPN identifier `mqtt` and handle the connection as a
   Single Stream mode connection.
3. MUST NOT initiate QUIC streams; the broker only accepts the stream opened by
   the client.
4. MUST process all MQTT packets received over the stream in the order they
   arrive.
5. For MQTT 5.0, MUST follow the server-initiated graceful shutdown procedure
   defined in Section 6.3.1 when disconnecting cleanly. For MQTT 3.1.1, the
   broker MUST NOT send `MQTT.DISCONNECT` (it is a client-to-server-only
   packet [MQTT311] §3.14); when disconnecting cleanly the broker MUST close
   the QUIC connection directly.

---

# Annex A License, Document Status and Notices

(This annex forms an integral part of this document.)

## A.1 Document Status

This document was last revised or approved by the [full TC name] on the above
date. The level of approval is also listed above. Check the "Latest version"
location noted above for possible later revisions of this document. Any other
numbered versions and other technical work produced by the Technical Committee
are listed at [TC publication page URL].

TC members should send comments on this document to the TC's email list. Others
should send comments to the TC's public comment list, after subscribing to it by
following the instructions at the TC's comments list web page at [URL].

## A.2 License and Notices

Copyright © OASIS Open 2026. All Rights Reserved.

All capitalized terms in the following text have the meanings assigned to them
in the OASIS Intellectual Property Rights Policy (the "OASIS IPR Policy"). The
full Policy may be found at: https://www.oasis-open.org/policies-guidelines/ipr/

This document and translations of it may be copied and furnished to others, and
derivative works that comment on or otherwise explain it or assist in its
implementation may be prepared, copied, published, and distributed, in whole or
in part, without restriction of any kind, provided that the above copyright
notice and this section are included on all such copies and derivative works.
However, this document itself may not be modified in any way, including by
removing the copyright notice or references to OASIS, except as needed for the
purpose of developing any document or deliverable produced by an OASIS Technical
Committee (in which case the rules applicable to copyrights, as set forth in the
OASIS IPR Policy, must be followed) or as required to translate it into
languages other than English.

The limited permissions granted above are perpetual and will not be revoked by
OASIS or its successors or assigns.

This document and the information contained herein is provided on an "AS IS"
basis and OASIS DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE
ANY OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR
A PARTICULAR PURPOSE.

The name "OASIS" is a trademark of OASIS, the owner and developer of this
document, and should be used only to refer to the organization and its official
outputs. Please see https://www.oasis-open.org/policies-guidelines/trademark/
for guidance.

---

# Annex B References

(This annex forms an integral part of this document.)

## B.1 Normative References

The following referenced documents are required for the application of this
document.

**[RFC9000]** J. Iyengar, M. Thomson, "QUIC: A UDP-Based Multiplexed and Secure
Transport", RFC 9000, IETF, May 2021. https://www.rfc-editor.org/rfc/rfc9000

**[RFC2119]** S. Bradner, "Key words for use in RFCs to Indicate Requirement
Levels", BCP 14, RFC 2119, IETF, March 1997.
https://www.rfc-editor.org/rfc/rfc2119

**[RFC8174]** B. Leiba, "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key
Words", BCP 14, RFC 8174, IETF, May 2017.
https://www.rfc-editor.org/rfc/rfc8174

**[MQTT5]** A. Banks, E. Briggs, K. Borgendale, R. Gupta, "MQTT Version 5.0",
OASIS Standard, March 2019.
https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html

**[MQTT311]** A. Banks, R. Gupta, "MQTT Version 3.1.1", OASIS Standard, October
2014.
https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html

**[RFC2782]** M. Gulko, K. Harrenstien, "A DNS RR for specifying the location of
services (DNS SRV)", RFC 2782, IETF, January 2000.
https://www.rfc-editor.org/rfc/rfc2782

**[RFC4033]** R. Arends, R. Austein, D. Massey, S. Rose, K. Moskovtsev, "DNS
Security Introduction and Requirements", RFC 4033, IETF, March 2005.
https://www.rfc-editor.org/rfc/rfc4033

**[RFC7301]** S. Friedl, A. Popov, A. Langley, E. Stephan, "Transport Layer
Security (TLS) Application-Layer Protocol Negotiation Extension", RFC 7301,
IETF, July 2014. https://www.rfc-editor.org/rfc/rfc7301

**[RFC8446]** E. Rescorla, "The Transport Layer Security (TLS) Protocol Version
1.3", RFC 8446, IETF, August 2018.
https://www.rfc-editor.org/rfc/rfc8446

**[RFC9001]** M. Thomson, S. Turner, "Using TLS to Secure QUIC", RFC 9001,
IETF, May 2021. https://www.rfc-editor.org/rfc/rfc9001

---

# Appendix 1 Acknowledgments

(This appendix does not form an integral part of this document and is
informational.)

## Leadership

The following individuals have had significant leadership positions during the
development of this document and are gratefully acknowledged:


## Special Thanks

- [First Name Last Name, Company]

## Participants

- [First Name Last Name, Company]

---

# Appendix 2 Changes From Previous Version

(This appendix does not form an integral part of this document and is
informational.)

This is the initial version of this document. There is no previous version.

## Revision History

- 2026-[MM-DD], Draft 01

---

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
