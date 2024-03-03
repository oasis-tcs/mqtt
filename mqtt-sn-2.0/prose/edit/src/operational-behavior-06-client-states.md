<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.6 Client states

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

![Client’s state transition diagram](images/the-state-diagram.svg "Client’s state transition diagram")

Figure 4: Client’s state transition diagram

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.6.1 Gateway timers

The following timers must be managed by a Gateway per Client to handle the different Client states:

- "Keep Alive" timer based on the value defined in the CONNECT packet.
  If expired, a Client is moved from Active to Lost state or from Asleep to Lost state or from Awake to Lost state.
- "Session Expiry" timer based on the value defined in the CONNECT or the DISCONNECT packet.
  If expired, the session state associated with the Client can be removed.
