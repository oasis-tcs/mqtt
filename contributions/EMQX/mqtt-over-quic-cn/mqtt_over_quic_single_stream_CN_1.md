![OASIS](OASIS-Logo.png)

---

# MQTT Over QUIC — Single Stream Mode Version 1.0

## Committee Note Draft 04

## 24 September 2026

### This Version

- [link to authoritative version] (Authoritative)
- [links to other formats, e.g. PDF, HTML]

	### Previous Version

- [MQTT-QUIC-SS] "MQTT Over QUIC — Single Stream Mode Version 1.0", OASIS
  Committee Note Draft 03, 19 August 2026. [link to Draft 03]

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
  Committee Note Draft 04, [24 September 2026]. [link to latest version].

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
  - [3.3 Relationship to QUIC Specifications](#33-relationship-to-quic-specifications)
    - [3.3.1 ALPN](#331-alpn)
    - [3.3.2 Early Data](#332-early-data)
    - [3.3.3 Stream Operations](#333-stream-operations)
    - [3.3.4 Stream Credit](#334-stream-credit)
    - [3.3.5 Connection Termination](#335-connection-termination)
    - [3.3.6 Transport Keepalive](#336-transport-keepalive)
    - [3.3.7 Transport Security](#337-transport-security)
    - [3.3.8 Replay Exposure](#338-replay-exposure)
  - [3.4 Relationship to MQTT Specifications](#34-relationship-to-mqtt-specifications)
    - [3.4.1 Connection Establishment](#341-connection-establishment)
    - [3.4.2 Packet Framing](#342-packet-framing)
    - [3.4.3 MQTT 5.0 DISCONNECT](#343-mqtt-50-disconnect)
    - [3.4.4 MQTT 3.1.1 DISCONNECT](#344-mqtt-311-disconnect)
    - [3.4.5 DISCONNECT Effects](#345-disconnect-effects)
    - [3.4.6 Session Takeover](#346-session-takeover)
    - [3.4.7 MQTT 5.0 Session State](#347-mqtt-50-session-state)
    - [3.4.8 MQTT 3.1.1 Session State](#348-mqtt-311-session-state)
    - [3.4.9 MQTT Keepalive](#349-mqtt-keepalive)
    - [3.4.10 Protocol Errors](#3410-protocol-errors)
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
  - [6.3 Stream and Connection Termination](#63-stream-and-connection-termination)
    - [6.3.1 Graceful Shutdown](#631-graceful-shutdown)
    - [6.3.2 Abnormal Shutdown](#632-abnormal-shutdown)
    - [6.3.3 QUIC Error Code Semantics](#633-quic-error-code-semantics)
  - [6.4 Protocol Discovery](#64-protocol-discovery)
    - [6.4.1 DNS-Based Endpoint Resolution](#641-dns-based-endpoint-resolution)
    - [6.4.2 QUIC Capability Probe](#642-quic-capability-probe)
  - [6.5 Upgrade](#65-upgrade)
    - [6.5.1 Initial Transport Selection](#651-initial-transport-selection)
    - [6.5.2 Broker Session Handling](#652-broker-session-handling)
    - [6.5.3 Client Reconnection After Session Determination](#653-client-reconnection-after-session-determination)
  - [6.6 Fallback](#66-fallback)
    - [6.6.1 Fallback Categories](#661-fallback-categories)
    - [6.6.2 Fallback Behavior](#662-fallback-behavior)
    - [6.6.3 Post-Session Fallback](#663-post-session-fallback)
    - [6.6.4 Preventing Reconnection Livelock](#664-preventing-reconnection-livelock)
  - [6.7 Error Mapping and State Synchronization](#67-error-mapping-and-state-synchronization)
    - [6.7.1 Mapping QUIC Transport Errors to MQTT Session State](#671-mapping-quic-transport-errors-to-mqtt-session-state)
      - [6.7.1.1 Abnormal Transport Shutdown](#6711-abnormal-transport-shutdown)
    - [6.7.2 Mapping MQTT Protocol Errors to QUIC Transport State](#672-mapping-mqtt-protocol-errors-to-quic-transport-state)
      - [6.7.2.1 Protocol Violations and Malformed Packets (MQTT 5.0)](#6721-protocol-violations-and-malformed-packets-mqtt-50)
      - [6.7.2.2 Protocol Violations and Malformed Packets (MQTT 3.1.1)](#6722-protocol-violations-and-malformed-packets-mqtt-311)
      - [6.7.2.3 Error-Stream Completion and Cleanup](#6723-error-stream-completion-and-cleanup)
    - [6.7.3 Error Mapping Matrix](#673-error-mapping-matrix)
    - [6.7.4 State Synchronization Summary](#674-state-synchronization-summary)
  - [6.8 Keepalive Strategy](#68-keepalive-strategy)
    - [6.8.1 Connection Migration](#681-connection-migration)
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

This document applies to implementations of MQTT 3.1.1 [MQTT311] and MQTT 5.0
[MQTT5]. It covers connection establishment, keepalive, graceful and abnormal
connection termination, and protocol upgrade and fallback procedures specific
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
- **stream:** A QUIC stream as defined in [RFC9000] §2.
- **MQTT Network Connection:** The transport channel connecting an MQTT client
  and server, providing ordered, lossless byte delivery in both directions
  ("Network Connection" in [MQTT5] §1.2 and [MQTT311] §1.2). In Single Stream
  mode, this channel is one client-initiated bidirectional QUIC stream, not the
  enclosing QUIC connection. Closing or aborting the stream terminates that
  MQTT Network Connection; the QUIC connection may remain open for a new MQTT
  Network Connection on a replacement stream, subject to [Section 5.2](#52-stream-establishment). An MQTT
  Session can persist across successive MQTT Network Connections under the
  Session State retention rules in [Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state).
- **FIN:** A flag in a QUIC STREAM frame indicating the end of the sender's
  stream direction. FIN is not a separate frame or an MQTT packet. It does not
  close the opposite direction or the QUIC connection. [RFC9000] §19.8.
- **session:** An MQTT session as defined in [MQTT5] §4.1 or [MQTT311] §1.2;
  its lifetime follows the [MQTT requirements in Section 3.4](#34-relationship-to-mqtt-specifications).
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

## 3.3 Relationship to QUIC Specifications

Implementations MUST conform to [RFC9000] and [RFC9001]. This document defines
the MQTT-to-QUIC mapping and additional application requirements, not a new
QUIC transport. The inherited rules below are referenced internally throughout
this document rather than restated in individual procedures.

### 3.3.1 ALPN

ALPN offers and selection follow [RFC7301] §3, with negotiation failure
handled using `no_application_protocol` (`0x0178`) as specified in [RFC9001]
§8.1.

### 3.3.2 Early Data

ALPN/PSK binding, early-data acceptance and rejection, and resetting
stream-bound state after rejection follow [RFC8446] §4.2.10 and [RFC9001]
§§4.6.2–4.6.3.

### 3.3.3 Stream Operations

Stream operations, terminal-state restrictions, completion, and retransmission
follow [RFC9000] §§2.4, 3, 4.4, and 13.3.

### 3.3.4 Stream Credit

Stream-count credit is cumulative and cannot be revoked, as specified in
[RFC9000] §§4.6 and 19.11.

### 3.3.5 Connection Termination

QUIC connection termination, including handshake-dependent close-frame
restrictions, follows [RFC9000] §10.

### 3.3.6 Transport Keepalive

QUIC idle-timeout calculation, keepalive operation, and PING frames follow
[RFC9000] §§10.1 and 19.2.

### 3.3.7 Transport Security

TLS protection and peer authentication follow [RFC9001] §§4.4 and 5.

### 3.3.8 Replay Exposure

0-RTT data is vulnerable to replay, with transport-level protections and
limitations defined in [RFC8446] §8 and [RFC9001] §9.2.

## 3.4 Relationship to MQTT Specifications

Implementations MUST conform to the MQTT version used on the MQTT Network
Connection. The following inherited rules remain unchanged except for explicit
additional requirements of this profile; later sections link to these entries.

### 3.4.1 Connection Establishment

CONNECT sequencing, CONNACK timeout, and CONNACK processing follow [MQTT5]
§§3.1–3.2 or [MQTT311] §§3.1–3.2.

### 3.4.2 Packet Framing

MQTT packet encoding and Remaining Length framing follow [MQTT5] §2 or
[MQTT311] §2, independently of QUIC STREAM-frame boundaries ([RFC9000] §2.2).

### 3.4.3 MQTT 5.0 DISCONNECT

DISCONNECT eligibility, encoding, and sender-role restrictions follow [MQTT5]
§3.14, including the server's successful-CONNACK prerequisite.

### 3.4.4 MQTT 3.1.1 DISCONNECT

DISCONNECT is a client-to-server packet without a reason code or properties,
as defined in [MQTT311] §3.14.

### 3.4.5 DISCONNECT Effects

Sending DISCONNECT ends further MQTT transmission and requires Network
Connection closure, with receive-side and Will handling specified in [MQTT5]
or [MQTT311] §§3.1.2.5 and 3.14.4.

### 3.4.6 Session Takeover

Session takeover follows [MQTT5] §3.1.4 or [MQTT311] §3.1.4.

### 3.4.7 MQTT 5.0 Session State

Session retention and deletion follow Clean Start, Session Expiry Interval,
and stored-state rules in [MQTT5] §§3.1.2.4, 3.1.2.11.2, and 4.1.

### 3.4.8 MQTT 3.1.1 Session State

Session retention and deletion follow Clean Session ([MQTT311] §3.1.2.4) and
operational storage limits (§4.1), without a Session Expiry Interval property.

### 3.4.9 MQTT Keepalive

MQTT Keep Alive and PINGREQ/PINGRESP obligations follow [MQTT5] or [MQTT311]
§§3.1.2.10 and 3.12–3.13, including the MQTT 5.0 Server Keep Alive override in
[MQTT5] §3.2.2.3.14.

### 3.4.10 Protocol Errors

Protocol-error closure, MQTT notifications, and reason selection follow
[MQTT5] §4.13.1 (including more specific rules such as §4.12.1) or [MQTT311]
§4.8, subject to the DISCONNECT rules above.

---

# 4 Introduction

## 4.1 Motivation

Single Stream mode lets MQTT deployments use QUIC without changing MQTT
packet formats. It targets deployments that benefit from QUIC connection
establishment [RFC9000] §7, TLS-based security [RFC9001], and connection
migration [RFC9000] §9. The MQTT-specific conditions for 0-RTT and migration
are defined in Sections [5.5.3](#553-negotiating-among-multiple-operating-modes) and [6.8.1](#681-connection-migration), respectively.

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

At the time permitted by [Section 6.1](#61-establishing-a-connection), the
client MUST open one bidirectional (BIDI) QUIC stream for each MQTT Network Connection. The client
MUST NOT have more than one MQTT stream active on the QUIC connection at any
time. Each stream carries all MQTT packets for the lifetime of its MQTT Network
Connection. The server MUST NOT initiate a stream in Single Stream mode.

MQTT connection establishment follows the [inherited MQTT rules](#341-connection-establishment).

For MQTT reconnection, the client MUST open a new bidirectional QUIC stream.
The enclosing QUIC connection may remain open, and retained MQTT Session State
may be resumed. Applicable retry, backoff, stream-completion, and
single-active-stream requirements still apply. Rejected 0-RTT is handled under
[Section 5.5.3](#553-negotiating-among-multiple-operating-modes).

Sequential use of replacement streams can race with peer-side cleanup; see the
stream-credit coordination recommendation in [Section 6.7.2.3](#6723-error-stream-completion-and-cleanup).

ALPN negotiation follows [Section 5.5](#55-alpn-negotiation).

## 5.3 MQTT Packet Transport

All MQTT control packets — including `MQTT.CONNECT`, `MQTT.CONNACK`,
`MQTT.PUBLISH`, `MQTT.SUBSCRIBE`, `MQTT.PINGREQ`, `MQTT.DISCONNECT`, and all
associated acknowledgement packets — MUST be transmitted over the single
bidirectional stream in the order they are produced. No changes are made to the
MQTT packet binary format. This mode is fully compatible with MQTT 3.1.1
[MQTT311] and MQTT 5.0 [MQTT5].

Apply the [inherited packet-framing rules](#342-packet-framing) to this stream.
The broker MUST process incoming MQTT packets in stream order until an error
requires termination under [Section 6.7.2](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).

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
| MQTT 3.1.1 compatible             |      Yes      |         Yes         |          No          |
| MQTT 5.0 compatible               |      Yes      |    Yes (partial)    |          No          |
| TLS ALPN identifier               |    `mqtt`     |       `mqtt`        |     `mqtt-next`      |
| Transport keepalive               |      Yes      |         Yes         |         Yes          |
| 1-RTT / 0-RTT handshake           |      Yes      |         Yes         |         Yes          |
| Network address migration         |      Yes      |         Yes         |         Yes          |
| Unreliable delivery               |      No       |         No          |         Yes          |
| Co-existence with other protocols |      No       |         No          |         Yes          |
| Number of concurrent streams      |       1       |        1..n         |         1..n         |
| Broker-initiated stream           |      No       |         No          |         Yes          |
| QUIC per-stream flow control      |      Yes      |         Yes         |         Yes          |
| Per-stream prioritization         |      No       |         Yes         |         Yes          |
| Persistent sessions               |      Yes      | Control stream only |         Yes          |
| HOLB mitigation                   |      No       |         Yes         |         Yes          |
| Send/receive abort                |      Yes      |         Yes         |         Yes          |
| Trackable flows                   |      No       |         No          |         Yes          |

## 5.5 ALPN Negotiation

Single Stream mode is identified solely by the ALPN identifier `mqtt`
using the [inherited ALPN rules](#331-alpn). This section specifies the
profile's identifier and selection policy; MQTT exchange is subject to
[Section 5.5.3](#553-negotiating-among-multiple-operating-modes).

### 5.5.1 Client ALPN Offer

The client MUST include the ALPN identifier `mqtt` in the ALPN protocol list
it offers during the QUIC handshake when it intends to use Single Stream
mode. A client that supports multiple operating modes from the MQTT over QUIC
family of documents MAY offer several identifiers in a single handshake (e.g.,
`mqtt-next` and `mqtt`), using the [ALPN offer rules](#331-alpn).

### 5.5.2 Server ALPN Selection

When a client's offer includes `mqtt` and the server supports Single Stream
mode, the server SHOULD select it unless another mutually supported MQTT over
QUIC identifier is preferred under
[Section 5.5.3](#553-negotiating-among-multiple-operating-modes). Selecting `mqtt`
MUST cause the server to use Single Stream mode; unsuccessful negotiation
follows the [ALPN failure rules](#331-alpn).

MQTT stream establishment and the handshake follow
[Section 5.2](#52-stream-establishment) and
[Section 6.1](#61-establishing-a-connection).

### 5.5.3 Negotiating Among Multiple Operating Modes

A server MAY support multiple operating modes defined in the MQTT over QUIC
family of documents (e.g., `mqtt` for Single Stream and `mqtt-next` for
Advanced Multistream). When the client's offer contains more than one of
these identifiers, the server SHOULD select the identifier that appears
earliest in the client's preference order among those the server supports.

Except for 0-RTT early data permitted by this section, ALPN negotiation MUST be
completed before any MQTT packets are exchanged.

A client MAY send MQTT packets as 0-RTT early data when resuming a TLS session
for `mqtt`, subject to the [inherited early-data rules](#332-early-data), the
[client ALPN offer](#551-client-alpn-offer), and the
[MQTT replay-safety requirements](#7-security-considerations).

After early-data rejection and the state reset required by the
[inherited early-data rules](#332-early-data), the client MUST treat the early
MQTT packets as unprocessed and resubmit them only after the handshake
completes successfully with `mqtt` negotiated.

A server that has neither negotiated `mqtt` nor accepted 0-RTT under the rules
above MUST NOT accept MQTT packets over the connection.

---

# 6 Connection Management

## 6.1 Establishing a Connection

A QUIC connection MUST be established between the client and the server as
described in [RFC9000] before any MQTT packets are exchanged, except for 0-RTT
early data sent under the conditions in [Section 5.5.3](#553-negotiating-among-multiple-operating-modes). The client initiates the
QUIC connection.

Support for 0-RTT connection resumption is OPTIONAL. Implementations that
support 0-RTT MUST follow the ALPN-binding and rejection requirements in
[Section 5.5.3](#553-negotiating-among-multiple-operating-modes) and the replay-safety requirements in [Section 7](#7-security-considerations).

The MQTT handshake and its response timeout follow the
[inherited connection-establishment rules](#341-connection-establishment).

### 6.1.1 CONNACK Processing

Apply the [inherited CONNACK processing rules](#341-connection-establishment); this
profile adds no CONNACK fields or processing rules.

## 6.2 Connection Keepalive

Both endpoints SHOULD use native QUIC connection keepalive and send QUIC PING
frames during idle periods, using the [transport keepalive rules](#336-transport-keepalive).
The [MQTT keepalive requirements](#349-mqtt-keepalive) also apply and MUST NOT be
used as a substitute for this profile's QUIC keepalive. If a QUIC idle timeout
is configured, it SHOULD be greater than the effective MQTT Keep Alive interval.

## 6.3 Stream and Connection Termination

The following procedures select MQTT-specific actions using the inherited
[stream operations](#333-stream-operations) and
[connection-termination rules](#335-connection-termination).

Reconnection after either graceful or abnormal termination follows the
stream-establishment requirements in [Section 5.2](#52-stream-establishment).

### 6.3.1 Graceful Shutdown

In Single Stream mode, graceful shutdown closes the **stream** (not the entire
QUIC connection). The stream is the transport channel for MQTT — closing it
ends that MQTT Network Connection. The QUIC connection itself remains open so
the client can establish a new MQTT Network Connection on a replacement stream
under [Section 5.2](#52-stream-establishment).

Either endpoint can initiate graceful shutdown as described below. Both the
initiator and the peer MUST follow the shared completion requirements. These
requirements apply to graceful shutdown, not the protocol-error aborts in
[Section 6.7.2](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).

**Client-initiated graceful shutdown:**

1. The client MUST send `MQTT.DISCONNECT` over the stream, applying the
   [MQTT 5.0](#343-mqtt-50-disconnect) or [MQTT 3.1.1](#344-mqtt-311-disconnect)
   DISCONNECT rules as applicable.
2. The client and server MUST follow the shared completion requirements below.

**Server-initiated graceful shutdown:**

1. For MQTT 5.0, the server MUST send `MQTT.DISCONNECT` when eligible under
   the [MQTT 5.0 DISCONNECT rules](#343-mqtt-50-disconnect).
2. For MQTT 3.1.1, the broker MUST initiate graceful shutdown by half-closing
   its sending direction with FIN, applying the
   [MQTT 3.1.1 DISCONNECT rules](#344-mqtt-311-disconnect).
3. The server and client MUST follow the shared completion requirements below.

**Shared completion requirements (both endpoints):**

1. After sending `MQTT.DISCONNECT` on the graceful path, the sender MUST
   half-close its sending direction with FIN after the DISCONNECT bytes,
   applying the inherited [DISCONNECT effects](#345-disconnect-effects).
2. On receiving a valid peer `MQTT.DISCONNECT` or a normal receive-side
   end-of-stream (FIN), the receiver MUST promptly half-close its own sending
   direction with FIN if it has not already done so, subject to the failure
   cases below. It MUST NOT wait for another MQTT packet or an MQTT-level
   acknowledgement before doing so. A reply `MQTT.DISCONNECT` is not required;
   any notification remains subject to the [MQTT rules](#34-relationship-to-mqtt-specifications).
3. Each endpoint MUST await normal completion of both stream directions using
   the [inherited stream-state rules](#333-stream-operations), including
   receipt of the peer's FIN. Until completion, each endpoint MUST NOT abort
   the stream or close the QUIC connection as part of graceful shutdown,
   except for the timeout or failure
   cases below. In-flight MQTT packets MAY be processed as permitted by the
   [MQTT rules](#34-relationship-to-mqtt-specifications) and
   [stream-state rules](#333-stream-operations).
4. Each endpoint MUST enforce a finite, positive, configurable graceful
   shutdown timeout (RECOMMENDED: 10 seconds), starting when it first initiates
   graceful shutdown or receives the peer's valid DISCONNECT or normal
   end-of-stream, whichever occurs first. Sending blocked by flow control MUST
   NOT defer or restart this deadline. If normal stream closure has not
   completed at the deadline and the QUIC connection is still open, the
   endpoint MUST abort its sending direction using `RESET_STREAM` where
   permitted by QUIC stream state and immediately close the QUIC connection
   under the [connection-termination rules](#335-connection-termination),
   without waiting for a peer response.
5. After normal stream completion, the QUIC connection remains available for a
   replacement MQTT stream subject to [Section 5.2](#52-stream-establishment). Either endpoint MAY instead
   terminate the QUIC connection under the
   [connection-termination rules](#335-connection-termination).
   The replacement-stream race and stream-credit recommendation in
   [Section 6.7.2.3](#6723-error-stream-completion-and-cleanup) also apply here.

**Failure precedence:** A stream reset or QUIC connection failure or closure
before normal stream completion means graceful shutdown has failed. Peer
`STOP_SENDING` follows the [stream-operation rules](#333-stream-operations).
These events and errors requiring [Section 6.7.2](#672-mapping-mqtt-protocol-errors-to-quic-transport-state) take precedence over waiting
for FIN; the graceful procedure MUST NOT delay required abort actions.
In particular, sending an error
`MQTT.DISCONNECT` under [Section 6.7.2](#672-mapping-mqtt-protocol-errors-to-quic-transport-state) does not require waiting for peer FIN.

Transport completion alone does not establish receipt of `MQTT.DISCONNECT`;
apply the inherited [Will handling](#345-disconnect-effects) and
[Session State mapping](#671-mapping-quic-transport-errors-to-mqtt-session-state).

### 6.3.2 Abnormal Shutdown

Abnormal shutdown is termination that does not follow [Section 6.3.1](#631-graceful-shutdown), including
stream abort, connection timeout, immediate connection closure, or an
unrecoverable transport failure. Stopping MQTT processing and initiating
shutdown MUST NOT depend on a graceful close from the peer.

Either endpoint applies the following MQTT-to-QUIC mapping:

- **Peer's MQTT error:** For a Malformed Packet or Protocol Error, follow
  the [shared abort procedure](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).
- **Local cancellation:** Use `RESET_STREAM` to abort the local sending
  direction, for example on resource exhaustion. If both directions must be
  terminated, also abort receiving using `STOP_SENDING` where applicable
  under the [stream-operation rules](#333-stream-operations), with reason
  interpretation governed by [Section 6.3.3](#633-quic-error-code-semantics).

Error-code interpretation is defined in [Section 6.3.3](#633-quic-error-code-semantics); protocol-error cleanup
is defined in [Section 6.7.2.3](#6723-error-stream-completion-and-cleanup).

### 6.3.3 QUIC Error Code Semantics

In Single Stream mode, one QUIC stream carries each MQTT Network Connection.
When either endpoint terminates the MQTT Network Connection via an abortive
mechanism, it includes an application error code in the `RESET_STREAM` or
`STOP_SENDING` frame to indicate the reason for termination. The cleanup
fallback in [Section 6.7.2.3](#6723-error-stream-completion-and-cleanup) also uses this mapping for an application
`CONNECTION_CLOSE`. The shared rules below apply to both client and broker;
client reconnection policy is specified separately.
Error codes use the scheme `0x300 + MQTT reason code`, where `0x300` is the base
offset and the MQTT reason code is added to produce a unique QUIC error code:

| MQTT reason code | MQTT reason | QUIC error code | Reason originator |
|:----------------:|:-----------:|:---------------:|:------------------|
| `0x81` | Malformed Packet | `0x381` | Client or broker |
| `0x82` | Protocol Error | `0x382` | Client or broker |
| `0x8E` | Session Taken Over | `0x38E` | Broker only |

This is a direct 1:1 mapping — no lookup table is needed. The originating
endpoint adds `0x300` to the MQTT reason code to produce the QUIC error code.

An endpoint originating a mapped reason MUST respect the sender-role
restrictions of the corresponding [MQTT 5.0 DISCONNECT reason](#343-mqtt-50-disconnect)
or [CONNACK reason](#341-connection-establishment).

**STOP_SENDING:** The receiving endpoint SHOULD inspect the error code.
A peer-originated `0x381` or `0x382`
reports that the peer detected a Malformed Packet or Protocol Error in data
sent by the receiving endpoint. This applies equally to a broker reporting a
client error and a client reporting a broker error. A broker-originated
`0x38E` reports session takeover; it does not imply that the client sent an
invalid packet. The frame type alone does not assign fault.

**RESET_STREAM:** The receiving endpoint SHOULD inspect the error code and
the shutdown context. A
locally initiated reset reports a cancellation reason, including a detected
peer MQTT error under [Section 6.7.2](#672-mapping-mqtt-protocol-errors-to-quic-transport-state). A reset can instead be a response to an
earlier `STOP_SENDING`; receiving a reset does not by itself identify which
endpoint detected an MQTT error or caused it.

Responses to `STOP_SENDING` follow the [stream-operation rules](#333-stream-operations).
A copied code in a responding `RESET_STREAM` MUST NOT be interpreted as an
independent error report or a new session takeover. For
example, a client can echo a broker's `0x38E` without originating a takeover.

For MQTT 5.0, when a received `MQTT.DISCONNECT` and a peer-originated QUIC error
report refer to the same shutdown, either endpoint SHOULD use the DISCONNECT
Reason Code as the primary signal and the QUIC error code as a secondary
confirmation. When `MQTT.DISCONNECT` is unavailable, either endpoint
SHOULD use the available QUIC error code and shutdown context. A solicited
reset echo is not a new peer-originated report. For MQTT 3.1.1, the QUIC error
code supplies the reason within the inherited
[MQTT notification constraints](#344-mqtt-311-disconnect). An unrecognized code
alone establishes neither a network failure nor which endpoint is at fault.

**Client reconnection policy:** The following rules apply only to the client
and to broker-originated reports, not to reset responses echoing a client's
own error report:

- On a broker-originated Session Taken Over reason (`0x8E` in MQTT 5.0 or
  `0x38E` in a QUIC application error), the client MUST apply the backoff from
  [Section 6.6.4](#664-preventing-reconnection-livelock) before attempting to reconnect.
- For other recognized mapped reasons, the client SHOULD follow the applicable
  MQTT reason semantics. When no more specific recovery rule applies, the
  client MAY retry with standard backoff.

An otherwise usable QUIC connection remains available for permitted retries,
subject to [Section 5.2](#52-stream-establishment).

## 6.4 Protocol Discovery

Protocol discovery determines whether a broker supports MQTT over QUIC before
the client commits to a QUIC connection. Discovery consists of two phases:
endpoint resolution via DNS and capability probing via QUIC.

### 6.4.1 DNS-Based Endpoint Resolution

The client SHOULD use DNS to resolve the broker's hostname to an IP address and
port. DNS Service Discovery (SRV records [RFC2782]) MAY be used to locate MQTT
endpoints. For example, the client MAY look up `_mqtt._tcp.<domain>` to obtain
the host and port of the MQTT service.

DNS resolution does not indicate whether the endpoint supports QUIC. The port
returned by DNS is shared between TCP/TLS and QUIC, so the client cannot
determine QUIC support from DNS alone. DNS resolution provides the endpoint
address; actual QUIC support is determined through probing as described in
[Section 6.4.2](#642-quic-capability-probe).

DNS validation and broker authentication follow the
[security requirements in Section 7](#7-security-considerations).

### 6.4.2 QUIC Capability Probe

The client discovers whether the broker supports MQTT over QUIC by opening a
QUIC connection to the endpoint resolved via DNS and inspecting the ALPN
identifier negotiated during the handshake.

The client SHOULD attempt a QUIC connection to the same host and port obtained
via DNS resolution, offering `mqtt` as the ALPN identifier. The outcome of this
probe determines QUIC support:

1. **`mqtt` selected:** The broker supports Single Stream mode. The
   client MAY proceed with the QUIC connection as a primary transport or as an
   upgrade from TCP/TLS as described in [Section 6.5](#65-upgrade).
2. **Another offered identifier selected:** This outcome is only possible if
   the client offered more than one identifier ([Section 5.5.1](#551-client-alpn-offer)). The broker
   supports QUIC but selected a different operating mode. The client SHOULD
   proceed with the selected mode if it is an MQTT-compatible protocol, or
   fall back to TCP/TLS otherwise.
3. **ALPN negotiation fails:** After handling the
   [ALPN failure](#331-alpn), the client MUST follow the
   [ALPN-mismatch fallback procedure](#661-fallback-categories).
4. **QUIC connection fails (network error):** The client cannot establish a QUIC
   connection due to a network-level failure. See [Section 6.6](#66-fallback) for fallback
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

**Scope of this section.** The rules in this section apply only to the initial
connection attempt — the one-shot decision of which transport to use for the
first `MQTT.CONNECT`. They do not constrain reconnection attempts triggered
by the application or by the client library after the session is established.
For example, if a QUIC stream is aborted after the session is established, the
application MAY choose to reconnect on TCP/TLS; this is a normal reconnection
under [Section 6.6](#66-fallback), not an "upgrade," and the initial-selection
restrictions do not apply.

### 6.5.1 Initial Transport Selection

When selecting an initial transport, the client MUST follow this strategy:

1. The client opens a QUIC connection to the broker offering `mqtt` as the ALPN
   identifier and opens a bidirectional stream.
2. The client MUST NOT send `MQTT.CONNECT` on the TCP/TLS transport until the
   QUIC stream is established and the ALPN has been confirmed as `mqtt`.
3. The client sends `MQTT.CONNECT` only over the QUIC stream.
4. If the QUIC handshake does not complete within a configurable timeout
   (RECOMMENDED: 5 seconds), the client MUST fall back to the TCP/TLS transport
   and send `MQTT.CONNECT` over TCP/TLS. The stream open operation is typically
   in-memory state and does not require a separate timeout.

The client MUST NOT send `MQTT.CONNECT` on both transports simultaneously.
Maintaining both connections open without sending CONNECT on either is permitted
during the probe phase ([Section 6.4.2](#642-quic-capability-probe)), but once the client begins the MQTT
handshake, only one transport may carry the MQTT session.


### 6.5.2 Broker Session Handling

The broker MUST apply the [inherited session-takeover rules](#346-session-takeover)
without preferring one transport or distinguishing an upgrade attempt from an
ordinary reconnection.

**Validation prerequisite:** In this document, "last CONNECT wins" means a
CONNECT that has passed all applicable MQTT validation, including successful
completion of any required authentication (AUTH when used) and authorization
checks; receiving a later CONNECT alone is not sufficient to trigger takeover.

For a losing MQTT Network Connection carried over QUIC:

- **MQTT 5.0:** Use the takeover notification specified by the
  [inherited takeover rules](#346-session-takeover) and complete shutdown under
  [Section 6.3.1](#631-graceful-shutdown).
- **MQTT 3.1.1:** The broker MUST send `RESET_STREAM` with the Session Taken
  Over code defined in [Section 6.3.3](#633-quic-error-code-semantics).

For a losing TCP/TLS connection, the inherited MQTT rules apply to that
transport directly. Session State handling follows
[Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state).

### 6.5.3 Client Reconnection After Session Determination

During the initial transport-selection attempt ([Section 6.5](#65-upgrade)), once the client
determines which transport carries the MQTT session, it MUST NOT restart the
losing side of that attempt:

1. If the MQTT session over QUIC wins and the TCP/TLS transport is closed, the
   client MUST NOT re-open the TCP/TLS transport as part of that attempt. The
   client MUST use the QUIC transport exclusively for that attempt.
2. If the MQTT session over TCP/TLS wins and the QUIC transport is closed, the
   client MUST use TCP/TLS and MUST NOT re-attempt QUIC as part of that attempt.
3. On takeover signalled under [Section 6.5.2](#652-broker-session-handling),
   the client MUST complete local termination of the losing MQTT Network
   Connection; for QUIC, apply [Section 6.3](#63-stream-and-connection-termination).

Later reconnection follows Sections [6.6.3](#663-post-session-fallback) and [6.6.4](#664-preventing-reconnection-livelock). If the QUIC connection
remains usable, the client MAY reconnect on a replacement stream, subject to
Sections [5.2](#52-stream-establishment) and [6.3](#63-stream-and-connection-termination).

These rules prevent restarting the losing initial attempt; later retries use
the backoff in [Section 6.6.4](#664-preventing-reconnection-livelock).

## 6.6 Fallback

Protocol fallback is the process of falling back from a QUIC-based connection
to TCP/TLS when the QUIC connection cannot be established or is lost after the
MQTT session has been established on QUIC.

### 6.6.1 Fallback Categories

The client MUST distinguish between the following categories of QUIC failure
when determining the fallback behavior:

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
not yield `mqtt`: either negotiation fails under the [ALPN rules](#331-alpn),
or the server selects another client-offered identifier that is not an
MQTT-compatible protocol. This
indicates that the endpoint does not support Single Stream mode. The endpoint
may support other protocols (e.g., HTTP/3), so the client MUST NOT assume that
the endpoint is unavailable for MQTT.

On ALPN mismatch, the client MUST fall back to TCP/TLS and attempt to
establish a connection. The client MUST NOT apply backoff for ALPN mismatch, as
the endpoint is reachable and the failure is due to protocol incompatibility,
not a transient network condition.

### 6.6.2 Fallback Behavior

When falling back, the client SHOULD:

1. Close the failed QUIC connection (if still open).
2. Resolve the broker's hostname via DNS (as described in [Section 6.4.1](#641-dns-based-endpoint-resolution)),
   obtaining the host and port for TCP/TLS.
3. Establish a TCP/TLS connection to the broker.
4. Send `MQTT.CONNECT` over the TCP/TLS connection.
5. The client MUST NOT fall back to a plain-text TCP connection under any
   circumstances. TLS encryption is REQUIRED for the TCP/TLS fallback.

### 6.6.3 Post-Session Fallback

If only the MQTT stream has ended and the QUIC connection remains usable, the
client MAY establish a new MQTT Network Connection on a new stream, subject to
[Section 5.2](#52-stream-establishment) and the applicable retry and backoff rules.

If the MQTT session is already established on QUIC and the QUIC connection is
lost, the client MAY attempt to re-establish the session on QUIC. If QUIC
reconnection fails repeatedly (per the backoff rules in
[Section 6.6.1](#661-fallback-categories)), the client MAY fall back to TCP/TLS
as a last resort.

When Session State is expected to remain available under
[Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state), the
client SHOULD prefer reconnecting on QUIC before attempting TCP/TLS to avoid
unintended cross-transport takeovers.

### 6.6.4 Preventing Reconnection Livelock

Competing TCP/TLS and QUIC reconnection loops can repeatedly trigger the
takeover handling in [Section 6.5.2](#652-broker-session-handling).
The initial-selection restrictions in [Section 6.5](#65-upgrade) still apply;
this section specifies client-side backoff, not a different broker takeover
rule.

**Client-side backoff:** When the client detects that its MQTT Network
Connection was closed because it lost a competing connection attempt, it MUST
apply a fixed backoff before reconnecting on the other transport (RECOMMENDED:
5 seconds). Interpret takeover reports under
[Section 6.3.3](#633-quic-error-code-semantics).

This delay gives the winning attempt time to complete and limits rapid
automatic retries; it does not by itself guarantee that independent retry
loops will converge.

**After the race window ends:** Once the winning MQTT Network Connection is
established and the losing MQTT Network Connection is closed, the client MAY
reconnect on the other transport under
[Section 6.6.3](#663-post-session-fallback); broker handling remains governed
by [Section 6.5.2](#652-broker-session-handling).

---

## 6.7 Error Mapping and State Synchronization

To ensure robust communication and consistent state management, it is critical to define a clear mapping between the QUIC transport layer errors and the MQTT application layer errors. This chapter addresses the synchronization of state between the underlying QUIC connection and the MQTT session, specifically focusing on how transport-level failures translate into application-level outcomes and vice versa.

### 6.7.1 Mapping QUIC Transport Errors to MQTT Session State

For the [MQTT Network Connection mapped to a QUIC stream](#211-terms-defined-elsewhere),
the broker MUST apply the inherited [MQTT 5.0](#347-mqtt-50-session-state) or
[MQTT 3.1.1](#348-mqtt-311-session-state) Session State rules, as applicable.
Transport cleanup and session takeover do not introduce additional Session
State deletion conditions.

### 6.7.1.1 Abnormal Transport Shutdown

For an abnormal shutdown under [Section 6.3.2](#632-abnormal-shutdown),
interpret the available error reports using
[Section 6.3.3](#633-quic-error-code-semantics) and apply the
[Session State mapping above](#671-mapping-quic-transport-errors-to-mqtt-session-state).
Reconnection and fallback follow [Section 6.6](#66-fallback).

### 6.7.2 Mapping MQTT Protocol Errors to QUIC Transport State

On detecting a Malformed Packet or Protocol Error, either endpoint MUST
immediately stop processing incoming MQTT packets on the affected stream and
initiate a bidirectional abort to terminate the MQTT Network Connection.
It MUST NOT wait for peer FIN, peer reset, or a peer MQTT response before
doing so.
"The detecting endpoint" means the client or broker that detected the error
in its peer's MQTT traffic.

This profile requires closure by either endpoint, strengthening the MQTT 5.0
client closure recommendation in the [inherited error rules](#3410-protocol-errors).
The normal error path terminates the MQTT stream, not the entire QUIC
connection; completion and the bounded cleanup fallback are defined in
[Section 6.7.2.3](#6723-error-stream-completion-and-cleanup).

**Transport action (both MQTT versions, either detecting endpoint):**

1. **Send direction:** The detecting endpoint MUST abort its sending direction
   using `RESET_STREAM`, subject to the
   [inherited stream-state rules](#333-stream-operations); FIN is not a
   substitute for this abort.
2. **Receive direction:** The detecting endpoint MUST abort MQTT reads and send
   `STOP_SENDING` if its receiving direction has neither received all stream
   data nor been reset, under the [stream-operation rules](#333-stream-operations).

For both frames newly initiated for this error, the detecting endpoint MUST
use the same mapped error code from
[Section 6.3.3](#633-quic-error-code-semantics), based on a reason applicable to
its role and MQTT notification packet type under the
[inherited error rules](#3410-protocol-errors).

Any permitted MQTT notification under the version-specific sections below
precedes the send-side reset. An attempt to send it MUST NOT delay the
receive-side abort, await notification delivery or a peer reset, or extend the
[cleanup deadline](#6723-error-stream-completion-and-cleanup).
Notification delivery is best effort; the peer interprets the available
MQTT or QUIC report under [Section 6.3.3](#633-quic-error-code-semantics).

#### 6.7.2.1 Protocol Violations and Malformed Packets (MQTT 5.0)

Use the [inherited MQTT error notifications](#3410-protocol-errors), subject
to [MQTT 5.0 DISCONNECT eligibility](#343-mqtt-50-disconnect).
Where those rules recommend DISCONNECT, either endpoint MAY omit it when
transport failure or persistent flow-control blockage prevents prompt
transmission; this does not defer the
[shared abort procedure](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).

#### 6.7.2.2 Protocol Violations and Malformed Packets (MQTT 3.1.1)

Apply the [MQTT 3.1.1 notification constraints](#344-mqtt-311-disconnect) without
introducing an additional MQTT error-notification packet.
A client MAY send the ordinary DISCONNECT before its reset, with its
[normal MQTT effects](#345-disconnect-effects).
For MQTT 3.1.1, the detecting endpoint MUST select the Malformed Packet or
Protocol Error entry in the [error-code mapping](#633-quic-error-code-semantics).
Both endpoints use the [shared abort procedure](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).

#### 6.7.2.3 Error-Stream Completion and Cleanup

After initiating the [shared abort procedure](#672-mapping-mqtt-protocol-errors-to-quic-transport-state),
complete transport cleanup using the [inherited stream operations](#333-stream-operations).

The QUIC connection remains open after successful stream cleanup. A new MQTT
stream MUST NOT become active until the previous stream is fully closed under
those rules, consistent with [Section 5.2](#52-stream-establishment).

**Replacement-stream race:** Local stream closure does not confirm that the peer
has finished closing the previous stream and retiring its MQTT Network
Connection. A replacement stream opened solely on local completion can reach
the broker while it still considers the previous MQTT stream active, causing
the retry to be rejected.

**Recommended coordination:** For otherwise permitted retries on a new MQTT
Network Connection within the same QUIC connection, use QUIC stream-count flow
control (`initial_max_streams_bidi` and bidirectional `MAX_STREAMS`) under the
[stream-credit rules](#334-stream-credit) to avoid this race:

1. The server initially advertises `initial_max_streams_bidi = 1`.
2. The server proactively grants credit for one additional client-initiated
   bidirectional stream only after the previous stream is fully closed locally
   and its MQTT Network Connection has been retired.
3. The client waits for both local closure of the previous stream and sufficient
   server-advertised credit before opening the replacement stream.

This policy coordinates replacement after an abort detected by either endpoint
within the stream-initiation model of [Section 5.2](#52-stream-establishment).
It is a recommended MQTT admission policy, not an automatic consequence of
QUIC stream closure, and does not delay abort actions or extend the cleanup
deadline below.

**Bounded cleanup:** Either detecting endpoint MUST enforce a finite, positive,
configurable protocol-error cleanup timeout starting when it detects the error.
If the stream is not fully closed at the deadline and the QUIC connection is
still open, the endpoint MUST initiate an immediate QUIC connection close under
the [connection-termination rules](#335-connection-termination). Use an
application `CONNECTION_CLOSE` with the original MQTT error mapped by
[Section 6.3.3](#633-quic-error-code-semantics), subject to those rules'
handshake restrictions.
This is an exception to keeping the QUIC connection open. The endpoint MUST
NOT wait for peer FIN, peer reset, or acknowledgement of `MQTT.DISCONNECT` or
a failure `MQTT.CONNACK` before invoking this fallback.

The deadline applies even when sending is blocked. Session State handling
follows [Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state).

### 6.7.3 Error Mapping Matrix

This matrix links each event to its defining procedure; Session State handling
is specified once in
[Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state).

| Event | Applicable procedure |
|:------|:---------------------|
| QUIC stream reset, timeout, or connection loss | [Abnormal shutdown](#632-abnormal-shutdown) and [transport-to-MQTT handling](#6711-abnormal-transport-shutdown) |
| Malformed Packet or Protocol Error | [Bidirectional abort](#672-mapping-mqtt-protocol-errors-to-quic-transport-state), [mapped error codes](#633-quic-error-code-semantics), and [bounded cleanup](#6723-error-stream-completion-and-cleanup) |
| Graceful shutdown | [Graceful stream completion](#631-graceful-shutdown) |
| Session takeover | [Broker session handling](#652-broker-session-handling) |

### 6.7.4 State Synchronization Summary

Use the [Session State mapping](#671-mapping-quic-transport-errors-to-mqtt-session-state)
for transport-to-MQTT effects and the
[protocol-error procedure](#672-mapping-mqtt-protocol-errors-to-quic-transport-state)
for MQTT-to-QUIC teardown.


## 6.8 Keepalive Strategy

Apply the connection keepalive and MQTT timeout-coordination requirements in
[Section 6.2](#62-connection-keepalive). A transport failure detected by keepalive
is handled under [Section 6.3.2](#632-abnormal-shutdown) and
[Section 6.6](#66-fallback).

### 6.8.1 Connection Migration

Connection migration follows [RFC9000] §9, including server preferred-address
handling in §9.6. Successful migration preserves the MQTT Network Connection,
its stream, and its Session. Transport failure during migration follows the
normal failure handling in Sections [6.3.2](#632-abnormal-shutdown) and [6.6](#66-fallback).

# 7 Security Considerations

Apply the inherited [transport security](#337-transport-security) and
[replay-protection rules](#338-replay-exposure), together with the profile requirements below.

**Server-side authentication only.** Single Stream mode requires server-side
authentication only: the client MUST authenticate the broker's identity by
validating the broker's TLS certificate against its expected hostname.
Mutual TLS (mTLS) — where the broker requires a client certificate — is
**not required** by this specification and is OPTIONAL. Implementations that
wish to use client certificates for additional access control MAY enable mTLS
at the TLS layer, but such a requirement must not be treated as a mandatory
part of Single Stream mode conformance.

**Fallback security.** Apply the
[TLS-only fallback requirements](#662-fallback-behavior).

**MQTT early-data safety.** Early-data negotiation follows
[Section 5.5.3](#553-negotiating-among-multiple-operating-modes).
Implementations that support 0-RTT MUST ensure that any MQTT packets sent as
early data are safe to replay, i.e., are idempotent or are protected by a
server-verified session token. An `MQTT.CONNECT` packet sent in 0-RTT mode
SHOULD be treated with caution by the server until session state can be
verified. Rejected early data follows the state-reset and resubmission rules
in [Section 5.5.3](#553-negotiating-among-multiple-operating-modes).

When 0-RTT is used during an upgrade from TCP/TLS to QUIC, the replay risk is
amplified: an attacker who observes the client's upgrade attempt could replay
the early `MQTT.CONNECT` on a new QUIC connection, causing an additional MQTT
Network Connection for the same Client Identifier. Handle these competing
attempts under [Section 6.5.2](#652-broker-session-handling) and their Session
State under [Section 6.7.1](#671-mapping-quic-transport-errors-to-mqtt-session-state).

**DNS spoofing during protocol discovery.** When the client uses DNS to resolve
the broker's hostname before probing QUIC support, a malicious actor could
forge DNS responses to redirect the client to an untrusted endpoint. Clients
SHOULD validate DNS responses using DNSSEC [RFC4033] or an equivalent mechanism.
This does not replace the broker authentication required above, whether or
not DNSSEC is available.

---

# 8 Conformance

## 8.1 Conformance Targets

This document defines conformance requirements for two implementation targets:

- **MQTT Client:** An endpoint that initiates the QUIC connection and opens the
  single bidirectional stream.
- **MQTT Broker:** An endpoint that accepts the QUIC connection and receives
  MQTT packets over the bidirectional stream opened by the client.

## 8.2 MQTT Client Conformance

A conformant MQTT client implementing Single Stream mode MUST meet the
applicable requirements in:

1. [Inherited QUIC rules](#33-relationship-to-quic-specifications) and
   [inherited MQTT rules](#34-relationship-to-mqtt-specifications).
2. [Connection establishment](#61-establishing-a-connection) and
   [ALPN negotiation](#55-alpn-negotiation).
3. [Stream establishment and admission](#52-stream-establishment) and
   [MQTT packet transport](#53-mqtt-packet-transport).
4. [Graceful shutdown](#631-graceful-shutdown) and
   [abnormal shutdown](#632-abnormal-shutdown).
5. [Error-code interpretation](#633-quic-error-code-semantics) and
   [protocol-error handling](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).
6. [Keepalive](#62-connection-keepalive), [upgrade](#65-upgrade), and
   [fallback](#66-fallback), where applicable.
7. [Security considerations](#7-security-considerations).

## 8.3 MQTT Broker Conformance

A conformant MQTT broker implementing Single Stream mode MUST accept client
QUIC connections and meet the applicable requirements in:

1. [Inherited QUIC rules](#33-relationship-to-quic-specifications) and
   [inherited MQTT rules](#34-relationship-to-mqtt-specifications).
2. [ALPN selection](#552-server-alpn-selection),
   [stream establishment](#52-stream-establishment), and
   [MQTT packet transport](#53-mqtt-packet-transport).
3. [Graceful shutdown](#631-graceful-shutdown) and
   [abnormal shutdown](#632-abnormal-shutdown).
4. [Error-code interpretation](#633-quic-error-code-semantics) and
   [protocol-error handling](#672-mapping-mqtt-protocol-errors-to-quic-transport-state).
5. [Keepalive](#62-connection-keepalive),
   [session takeover](#652-broker-session-handling), and
   [Session State handling](#671-mapping-quic-transport-errors-to-mqtt-session-state).
6. [Security considerations](#7-security-considerations).

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

[MQTT5]: https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html
[MQTT311]: https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html
[RFC9000]: https://www.rfc-editor.org/rfc/rfc9000.html
[RFC9001]: https://www.rfc-editor.org/rfc/rfc9001.html
[RFC7301]: https://www.rfc-editor.org/rfc/rfc7301.html
[RFC8446]: https://www.rfc-editor.org/rfc/rfc8446.html

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

This is the fourth draft of this document.

## Changes From Draft 01

- mTLS is optional
- Distinguishes MQTT v3.1.1 and v5 handling in error scenarios.

## Changes From Draft 02

- §6.1.1 CONNACK Processing: Restructured the table to correctly distinguish
  MQTT 5.0 and MQTT 3.1.1
- §6.5.2 Broker Session Handling: Corrected the erroneous statements about MQTT 3.1.1
- §6.6: Renamed "Downgrade" to "Fallback" 

## Changes From Draft 03

- Clarified the MQTT Network Connection mapping, the one-active-stream limit,
  and reuse of the QUIC connection for replacement MQTT streams.
- Consolidated inherited MQTT and QUIC rules instead of repeating itself.
- Clarified ALPN negotiation and 0-RTT acceptance, rejection, and resubmission
- Made graceful shutdown explicit for both endpoints and distinguished it
  from bidirectional protocol-error aborts, with bounded cleanup and guidance
  on replacement-stream races.

## Revision History

- 2026-09-24, Draft 04
- 2026-08-19, Draft 03
- 2026-06-23, Draft 02
- 2026-05-20, Draft 01

---

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
