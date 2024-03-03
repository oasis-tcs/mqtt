<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.9 Publish Variants

MQTT-SN is designed to be optimized for packet size.
For this reason, the PUBLISH packet has been split into 3 variants;
Variant 1 catering for PUBLISH WITHOUT SESSION where no GW session is required,
Variant 2 catering for Quality of Service 0 where no response ACK is required and thus no packet identifier is
required and Quality of Service 1 and 2 where a response is expected.
The table below breaks down the different versions of the PUBLISH packet and their respective type identifiers.

| Packet Type             | Type | Description                                                                       |
|:------------------------|:-----|:----------------------------------------------------------------------------------|
| Publish                 | 0x0C | A PUBLISH packet corresponding to Quality of Service (QoS) 0, 1 or 2              |
| Publish Without Session | 0x11 | A PUBLISH Packet sent by a Client and does not need not to have an active Session |

Table: Types of PUBLISH packets and their respective type identifiers.
<!-- transformation-note: added missing table caption. -->
<!-- transformation-note: above upstream table number will be inserted by auto-numbering later. -->
