
# MQTT over QUIC — Single Stream Design Highlights

An informative overview of the current
[Single Stream draft](mqtt_over_quic_single_stream_CN_1.md). This file summarizes
the design; it does not introduce requirements or replace the specification.

Changelog:

-  [v1] - 2026-09-17

## 1. Change the transport, preserve MQTT

The profile carries MQTT 3.1.1 and MQTT 5.0 over QUIC without changing MQTT
packet formats. One client-initiated bidirectional QUIC stream provides the
ordered byte channel that would otherwise be supplied by TCP.

- All MQTT control packets use that stream, including CONNECT, PUBLISH,
  acknowledgements, keepalive packets, and DISCONNECT.
- MQTT packets are reconstructed using MQTT framing and Remaining Length, not
  QUIC packet or STREAM-frame boundaries.
- QUIC supplies encryption, reliability, congestion control, flow control, and
  migration. The profile defines the MQTT mapping, not a replacement QUIC
  state machine.

See [§3.3](mqtt_over_quic_single_stream_CN_1.md#33-relationship-to-quic-specifications)
and [§5](mqtt_over_quic_single_stream_CN_1.md#5-single-stream-mode).

## 2. Three distinct lifetimes

| Concept                 | Role in this design                                        | Lifetime                                                                            |
|:------------------------|:-----------------------------------------------------------|:------------------------------------------------------------------------------------|
| QUIC connection         | Encrypted transport containing the MQTT stream             | Can remain open across successive MQTT Network Connections.                         |
| MQTT Network Connection | One client-initiated bidirectional QUIC stream/ or TCP/TLS | Ends when that stream closes or is aborted.                                         |
| MQTT Session            | MQTT state associated with the Client Identifier           | May survive multiple Network Connections, according to MQTT session-lifetime rules. |

The limit is **at most one active MQTT stream per QUIC connection**, not one
stream for the entire lifetime of the QUIC connection. The server does not
initiate streams in this mode.

Closing a stream does not automatically close the QUIC connection or delete
persistent Session State. MQTT 5.0 uses Clean Start and Session Expiry rules;
MQTT 3.1.1 uses Clean Session and has no Session Expiry Interval property.

See [§2.1](mqtt_over_quic_single_stream_CN_1.md#21-definitions),
[§5.2](mqtt_over_quic_single_stream_CN_1.md#52-stream-establishment), and
[§6.7](mqtt_over_quic_single_stream_CN_1.md#67-error-mapping-and-state-synchronization).

## 3. CONNECT is scoped to the MQTT Network Connection

`MQTT.CONNECT` is the client's first MQTT packet and is sent only once on each
MQTT Network Connection. A second CONNECT on that connection is a protocol
error, not a new connection attempt or session takeover.

Reconnection uses a new MQTT Network Connection: in Single Stream mode, a new
QUIC stream. The previous stream cannot be restarted, even while closing.
The new stream may use the existing QUIC connection once completion and
admission requirements are satisfied. Retained MQTT Session State can still
be resumed.

This rule applies across graceful shutdown, errors, refusal, timeout, and
takeover. It does not impose a session-lifetime ban on reconnection or a blanket
ban on reusing the underlying QUIC connection.

See [§5.2](mqtt_over_quic_single_stream_CN_1.md#52-stream-establishment).

## 4. Explicit negotiation and protected early data

- ALPN `mqtt` identifies Single Stream mode.
- QUIC provides TLS-based transport protection. Broker certificate validation
  is required; mutual TLS is optional. Fallback is TCP/TLS, never plain TCP.
- Optional 0-RTT is tied to a resumed TLS PSK associated with `mqtt`. The server
  processes early MQTT data only if it accepts early data and selects that ALPN.
- Early MQTT operations must satisfy the draft's replay-safety requirements;
  encryption alone does not prevent replay.
- Rejected 0-RTT causes a local reset of stream and stream-bound application
  state. Resubmission waits for successful handshake completion with `mqtt`.
  It is not permission to append a second CONNECT to an existing MQTT exchange.

See [§5.5](mqtt_over_quic_single_stream_CN_1.md#55-alpn-negotiation) and
[§7](mqtt_over_quic_single_stream_CN_1.md#7-security-considerations).

## 5. Graceful completion and error abort are different paths

**Graceful shutdown:** Send DISCONNECT where permitted, finish the sending
direction with FIN, and await normal completion of both directions, including
peer FIN. Both initiating and responding endpoints enforce a finite timeout;
10 seconds is recommended. The peer finishes its sending direction without
requiring a reply MQTT DISCONNECT. MQTT 3.1.1 brokers use FIN without sending
DISCONNECT. Timeout triggers abort and QUIC connection closure; failure and
reset handling take precedence over waiting for FIN.

**Malformed Packet or Protocol Error:** Either detecting endpoint stops MQTT
processing and initiates a bidirectional abort: `RESET_STREAM` for its sending
direction and `STOP_SENDING` for its receiving direction, subject to QUIC
state. It does not wait for peer FIN. MQTT 5.0 error notifications are recommended
where permitted, but a reset can prevent their delivery. A finite cleanup
deadline provides a connection-close fallback if stream cleanup does not finish.

Mapped QUIC application errors use `0x300 + MQTT reason code`: `0x381` for
Malformed Packet, `0x382` for Protocol Error, and broker-originated `0x38E` for
Session Taken Over. A reset echo is not a new error report or takeover.

See [§6.3](mqtt_over_quic_single_stream_CN_1.md#63-stream-and-connection-termination)
and [§6.7.2](mqtt_over_quic_single_stream_CN_1.md#672-mapping-mqtt-protocol-errors-to-quic-transport-state).

## 6. Coordinate replacement streams with stream credit

Local closure does not prove the peer has finished cleanup. An immediate
replacement stream can therefore arrive while the broker still considers the
previous MQTT stream active.

The recommended coordination policy is:

1. The server initially grants one client-initiated bidirectional stream.
2. It grants one additional stream only after its previous stream is closed
   and the previous MQTT Network Connection is retired.
3. The client waits for both local closure and sufficient server-advertised
   stream credit before opening the replacement.

This uses `initial_max_streams_bidi` and cumulative `MAX_STREAMS` credit, not
byte-flow-control limits. Credit cannot be revoked, so granting it ahead of
broker readiness defeats this coordination policy. The mechanism works whether
the client or broker detected the error because MQTT streams are always
client-initiated.

See [§6.7.2.3](mqtt_over_quic_single_stream_CN_1.md#6723-error-stream-completion-and-cleanup).

## 7. Recovery preserves the layer boundaries

- Initial transport selection chooses one MQTT transport; probing does not
  authorize competing CONNECT exchanges on QUIC and TCP/TLS.
- Network failures allow bounded retries with backoff before encrypted
  fallback. ALPN mismatch follows a separate fallback policy.
- Session takeover concerns competing MQTT Network Connections for the same
  Client Identifier. Closing the losing connection and retaining or resetting
  Session State are separate decisions.
- Successful QUIC migration preserves the stream, MQTT Network Connection,
  and Session. It does not permit another CONNECT on that Network Connection.

See [§6.4–§6.6](mqtt_over_quic_single_stream_CN_1.md#64-protocol-discovery) and
[§6.8.1](mqtt_over_quic_single_stream_CN_1.md#681-connection-migration).

## 8. Tradeoffs and verification limits

The single-stream design simplifies MQTT transport integration but retains
head-of-line blocking within the MQTT byte stream. Concurrent MQTT streams,
server-initiated streams, and unreliable datagram delivery are outside this
profile.

The livelock discussion still needs alignment: §6.5 prohibits the competing
initial CONNECT attempts used in §6.6.4's example. Later independent retry loops
can nevertheless alternate takeovers using fresh MQTT Network Connections.
Backoff limits their rate; it does not establish livelock freedom.
