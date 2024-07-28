<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.1 Session state

Sessions are maintained by both the Client and a Gateway.
Sessions typically include (but are not limited to):

- Client Identifier
- Last packet received timestamp
- Keep Alive value
- Session Expiry Interval value
- Outbound unconfirmed application messages
- Inbound unconfirmed application messages
- Buffered messages from the broker
- Registered topic alias dictionary (normal topic alias’s)
- Confirmed subscriptions with their granted QoS
- Network address of Gateway (in the case of clients).
- Network address of Client (in the case of gateways).
- Next outbound packet identifier
