<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.15 Client states

At any given point in time, a client may be in one of 5 different states.
Transition through these states is governed by a strictly coordinated sequence of packets between client and server/gateway and
further mediated by timers resident on the gateway.
A client is in the active state when the server/gateway receives a CONNECT packet from that client.
This state is supervised by the server/gateway with the "keep alive" timer.
If the server/gateway does not receive any packet from the client for a period longer than the keep alive duration
(indicated in the CONNECT packet), the gateway will consider that client as lost and activate for example the Will feature for that client.
A client goes to the disconnected state when the server/gateway receives a DISCONNECT without a session expiry interval field.
This state is not time-supervised by the server/gateway.
A client moves into the asleep state by issuing a DISCONNECT with a session expiry interval field.
For more information on the sleep state, please refer to the "Sleeping clients" section.

| State        | State Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Possible Transitions              |
|:-------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------|
| DISCONNECTED | The client is considered offline. The gateway may or may not have a previous session state for this client. From here a client may transition ONLY to the ACTIVE state.                                                                                                                                                                                                                                                                                                                             | ACTIVE                            |
| ACTIVE       | The client is actively engaged in the session. It should be able to send and receive packets. Its state is supervised by the gateway with the associated "keep alive" timers. From here the client may transition to ASLEEP (by way of DISCONNECT with a session expiry interval > 0), DISCONNECTED (by way of DISCONNECT with a session expiry of 0) or LOST (by way of supervised gateway timers).                                                                                                | ASLEEP,  DISCONNECTED, LOST       |
| ASLEEP       | The client is engaged in an ongoing session. It cannot receive packets; it can send packets. The gateway should not expect a response from the client in this state until further packets are received from the client. From here the client may transition to AWAKE (by way of PINGREQ), ACTIVE by way of CONNECT, DISCONNECTED (by way of DISCONNECT with a session expiry of 0) or LOST (by way of supervised gateway timers).                                                                   | AWAKE, ACTIVE, DISCONNECTED, LOST |
| AWAKE        | The client is partially engaged in an ongoing session; it is obliged to not send ANY packets other than those involved in the receipt of PUBLISH packets (PUBACK, PUBREC, PUBCOMP, REGACK) or a DISCONNECT to transition to DISCONNECTED. The client transitions back to the ASLEEP state on receipt of a PINGRESP packet or LOST (by way of supervised gateway timers).                                                                                                                            | ASLEEP, DISCONNECTED, LOST        |
| LOST         | The client is considered offline and not able to receive packets until it has re-established a session with the GW by way of a CONNECT. The gateway must not attempt to send packets to a client in the LOST state. Any packets received from a client whose state is LOST should not be processed and a DISCONNECT with error should be sent in response, unless the packets received are PUBLISH WITHOUT SESSION or PUBLISH -1. Session state may exist on the GW for a client in the LOST state. | ACTIVE                            |

Table: States and Transitions.
<!-- transformation-note: table caption injected. -->

![Client’s state transition diagram](images/the-state-diagram.svg "Client’s state transition diagram")

Figure 4: Client’s state transition diagram

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.15.1 Gateway timers

The following timers must be managed by a Gateway per Client to handle the different Client states:

- "Keep Alive" timer based on the value defined in the CONNECT packet.
  If expired, a Client is moved from Active to Lost state or from Asleep to Lost state or from Awake to Lost state.
- "Session Expiry" timer based on the value defined in the CONNECT or the DISCONNECT packet.
  If expired, the session state associated with the Client can be removed.
