<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.27 Optional Features

The ADVERTISE, SEARCHGW, GWINFO and PUBLISH WITHOUT SESSION packet type support is optional.
For instance, it is not required if the MQTT-SN Gateway is an Internet node reachable via a public IP address.

The Forwarder Encapsulation packet type support is optional.
For instance, it is not required if the MQTT-SN Clients are able to directly reach a MQTT-SN Gateway.

The PROTECTION packet type support is optional.
For instance, it is not required if the MQTT-SN Gateway and the MQTT-SN Clients interact over a secure communication channel,
like DTLS or any communication channel assuring the authenticity and optionally the confidentiality protection.
