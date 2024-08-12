<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.9 Flow Control

The maximum number of unacknowledged MQTT-SN requests in one direction within a Virtual Connection for both Clients and Servers is 1. The packets
which need acknowledgement and are included in this constraint are:

- PUBLISH (QoS 1 and 2) and PUBREL
- REGISTER
- SUBSCRIBE
- UNSUBSCRIBE

\[If a Client or Server receives an MQTT-SN request and there is already a request outstanding within the same Virtual Connection then it MUST issue a
DISCONNECT with Reason Code 147 (Receive Maximum Exceeded) and delete the Virtual Connection] \[MQTT-SN-4.9-1].

Refer to section [3.1.12.7 "Publish Actions"](#publish-actions) for a description of how Clients and Servers react if they are sent more than one
unacknowledged packet.
