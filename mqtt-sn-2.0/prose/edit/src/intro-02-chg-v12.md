## Changes from earlier Versions{#changes-from-earlier-versions}

Here is a description of significant differences from previously published, differently numbered Versions of this specification.

### MQTT-SN 1.2{#mqtt-sn-1.2}

- Some terminology has been changed to match MQTT 5.0. For example:
  - Topic Id becomes Topic Alias
  - Message Id becomes Packet Identifier
  - Message Type becomes Packet Type

- The concept of Virtual Connection has been introduced, corresponding to the TCP connection of MQTT.

- The Will Message Packets are removed - setting the Will Message is now done in the CONNECT Packet, as in MQTT.

- The Enhanced Authentication of MQTT 5.0 is supported in CONNECT and CONNACK, and the introduction of the AUTH Packet.

- The *going to sleep* function of DISCONNECT is now the responsibility of a separate Packet - SLEEPREQ, and the response SLEEPRESP. As a result, DISCONNECT never has a response.

- The Short Topic Name has been removed - all publish packets now support full Topic Names as well as Topic Aliases.

- All responses allow a Reason Code to be returned. DISCONNECT also allows a Reason String for enhanced diagnostics. A set of Reason Codes and their use is included.

- Inspired by OSCORE, a Protection Encapsulation is introduced to provide lightweight authentication and encryption.

- Session Expiry, Maximum Packet Size, Assigned Client Identifier and Subscribe Options (No Local, Retain Handling, Retain as Published) have been adopted from MQTT.
