<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.25 Sleeping Clients
<!-- transformation-note: fixed title case in above heading by replacing "clients" with "Clients". -->

_Sleeping_ clients are clients residing on (battery-operated) devices that want to save as much energy as possible.
These devices need to enter a sleep mode whenever they are not active and will wake up whenever they have data to send or to receive.
The server/gateway needs to be aware of the sleeping state of these clients and will buffer messages destined to them for later delivery when they wake up.

If a client wants to sleep, it sends a DISCONNECT packet which contains a sleep session expiry interval.
The server/gateway acknowledges that packet with a DISCONNECT packet and considers the client for being in _asleep_ state.
The _asleep_ state is supervised by the server/gateway with the indicated sleep session expiry interval.
If the server/gateway does not receive any packet from the client for a period longer than the sleep session expiry interval,
the server/gateway will consider that client as _lost_ and - as with the keep alive procedure - activates for example the Will feature.

\[During the *asleep* state, packets that need to be sent to the client are buffered at the server/gateway.
The gateway MUST buffer application messages of quality-of-service 1 &amp; 2.]

> **Informative comment**
>
> The gateway may *choose* to buffer messages of Quality-of-Service 0, whilst the client is sleeping and is within its session expiry interval.

The sleep timer is stopped when the server/gateway receives a PINGREQ from the client.
Like the CONNECT packet, this PINGREQ packet contains the _Client Id_.
The identified client is then in the _awake_ state.
If the server/gateway has buffered packets for the client, it will send these packets to the client,
acknowledging the Default Awake Messages value sent in the CONNECT packet.
If the number of messages buffered on the gateway waiting to be sent exceeds the value specified by the client in the Default Awake Messages field,
the gateway shall send only the Default Awake Messages value number of messages, and cut short the AWAKE cycle,
responding with a PINGRESP with a messages-left value of either the number of messages remaining in the gateway buffer or 0xFFFF
(meaning undetermined number of messages greater than 0 remaining).

\[During the AWAKE state, for each packet the gateway sends to the client, the application messages' quality of service shall be honored,
and a full packet interaction shall take place including all normative phases of acknowledgement, including any associated retransmission logic.]
If, during the delivery of application messages from the gateway to the client, the gateway detects a timeout in the delivery,
it should transition the client state to LOST and a DISCONNECT packet with error sent to the device.

The transfer of packets to the client is closed by the server/gateway by means of a PINGRESP packet,
i.e. the server/gateway will consider the client as _asleep_ and restart the sleep timer again after having sent the PINGRESP packet.
If the server/gateway does not have any packets buffered for the client, it answers immediately with a PINGRESP packet,
returns the client back to the _asleep_ state, and restarts the sleep timer for that client.

After having sent the PINGREQ to the server/gateway, the client uses the "retransmission procedure" of section 3.18 to supervise the arrival of
packets sent by the server/gateway, i.e. it restarts timer T~retry~ when it receives a packet other than a PINGRESP, and stops it when it receives a
PINGRESP.
The PINGREQ packet is retransmitted, and timer T~retry~ restarted when timer T~retry~ times out.
To avoid a flattening of its battery due to excessive retransmission of the PINGREQ packet (e.g. if it loses the gateway),
the client should limit the retransmission of the PINGREQ packet (e.g. by a retry counter) and go back to sleep when the limit is reached and
it still does not receive a PINGRESP packet.

From the _asleep_ state, a client can return either to the _active_ state by sending a CONNECT packet or to the _disconnected_ state by sending a
normal DISCONNECT packet (i.e. without session expiry interval field).
The client can also modify its sleep configuration by sending a DISCONNECT packet with a new value of the session expiry interval.

Note that a sleeping client should go to the _awake_ state only if it just wants to check whether the server/gateway has any messages buffered for it
and return as soon as possible to the _asleep_ state without sending any packets to the server/gateway.
Otherwise, it should return to the _active_ state by sending a CONNECT packet to the server/gateway.

<!-- **//TODO SIMON -- add some worlds around retain registration behavior** -->

[Topic Alias mappings exist only while a client is active] [and last for the entire session expiry interval of the active state.]
[Therefore, the gateway must re-register any topic aliases during the AWAKE state, which will last until the last PINGRESP is issued.]

<!-- ![Awake ping packet flush](images/asleep-awake-transition-sequence-diagram.txt "Awake ping packet flush") -->

```mermaid
sequenceDiagram
    participant Client
    participant Gateway
    Client->>Gateway: CONNECT (with DefaultAwakeMessages>0)
    Gateway->>Client: CONNACK
    Note over Client,Gateway: Session established
    Client->>Gateway: DISCONNECT (with SessionExpiryInterval>0)
    Gateway->>Client: DISCONNECT
    Note over Client: Client in Asleep state
    Client->>Gateway: PINGREQ
    Note over Client: Client in Awake state
    alt BufferedMessages=0
        Gateway->>Client: PINGRESP
    else BufferedMessages>0
        loop Until max(BufferedMessages,DefaultAwakeMessages)
            alt QoS=0
                Gateway->>Client: PUBLISH
            else QoS=1
                Gateway->>Client: PUBLISH
                Client->>Gateway: PUBACK
            else QoS=2
                Gateway->>Client: PUBLISH
                Client->>Gateway: PUBREC
                Gateway->>Client: PUBREL
                Client->>Gateway: PUBCOMP
            end
        end
    Gateway->>Client: PINGRESP (with MessagesRemaining=0 or BufferedMessages-DefaultAwakeMessages)
    Note over Client: Client in Asleep state
    end
```

Figure 5: Awake ping packet flush
<!-- transformation-note: above figure number will be replaced by auto-numbering later. -->
