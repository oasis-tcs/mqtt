<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.4 Session Establishment

As with MQTT, an MQTT-SN client needs to set up a session on the gateway, unless it is publishing ONLY using PUBLISH WITHOUT SESSION packets.
The procedure for setting up a session with a gateway is illustrated in Fig. 3a and 3b.

The CONNECT packet contains flags to communicate to the gateway that Auth interactions should take place.

```mermaid
sequenceDiagram
    participant Client
    participant Server
    Client->>Server: PUBLISH with Packed Id = 0x1234
    activate Client
    Server->>Client: PUBLISH with Packed Id = 0x1234
    activate Server
    Client->>Server: PUBACK with Packed Id = 0x1234
    deactivate Server
    Server->>Client: PUBACK with Packed Id = 0x1234
    deactivate Client
```

<!-- ![Connect procedure (without Auth flag set or no further authentication data required)](images/connect-sequence-diagram.svg "Connect procedure (without Auth flag set or no further authentication data required)") -->

Figure 3a: Connect procedure (without Auth flag set or no further authentication data required)

<!-- ![Connect procedure (with Auth flag set and additional authentication data required)](images/connect-with-auth-continuation-sequence-diagram.svg "Connect procedure (with Auth flag set and additional authentication data required)") -->

```mermaid
sequenceDiagram
    participant Client
    participant Gateway
    Client->>Gateway: CONNECT (auth method and data)
    activate Gateway
    loop All required auth data exchanged
        Gateway->>Client: AUTH (continuation)
        Client->>Gateway: AUTH (continuation)
    end
    Gateway->>Client: CONNACK
    deactivate Gateway
```

Figure 3b: Connect procedure (with Auth flag set and additional authentication data required)

In case the gateway could not accept the CONNECT request (e.g. because of congestion or it does not support a feature indicated in the CONNECT packet),
the gateway returns a CONNACK packet with the rejection reason.

In the case where the client provides no client identifier, the Server MUST respond with a CONNACK containing an Assigned Client Identifier.

The Assigned Client Identifier MUST be a new Client Identifier not used by any other Session currently in the gateway.