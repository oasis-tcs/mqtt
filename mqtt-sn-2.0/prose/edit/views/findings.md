# Findings

What `make derive` noticed in the records and the prose without refusing to derive.

- MQTT-SN-3.6.2.3-1: BCP 14 keyword not in capitals: "MUST not"
- MQTT-SN-4.14-3: BCP 14 keyword not in capitals: "MUST not"
- packet type value range "0x19 -0xFB" is written unevenly
- CONNACK has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- PUBACK has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- PUBREC has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- PUBCOMP has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- SUBACK has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- UNSUBACK has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- PINGRESP has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- REGACK has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- SLEEPRESP has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier
- connect: "Maximum Number of Awake Messages" reads "(AM=F+1 or F) - only present when MAM flag is set" in the figure, the records give "(AM=1+F or F) - only present when MAM flag is set"
- connect: "Session Expiry Interval" reads "(S=AM+4 or AM) - only present when Sess Exp flag is set" in the figure, the records give "(S=4+AM or AM) - only present when Sess Exp flag is set"
- publish-qos-minus-1: "Topic Short Name" tests Topic Type ['Topic Short Name'], which tab-topic-types does not define
- regack: "Topic Alias" reads "- only present when Topic Alias flag is 1" in the figure, the records give "- only present when Topic Alias flag is set"
- register: "Packet Identifier" is labelled 3 in the figure, its layout puts it at 4
- register: "Topic Alias" reads "- only present when Topic Alias flag is 1" in the figure, the records give "- only present when Topic Alias flag is set"
- register: "Topic Alias" is labelled 5 in the figure, its layout puts it at 6
- register: "Topic Name" is labelled 5+T in the figure, its layout puts it at 6+T
- sleepresp: "Packet Identifier" is labelled 3 in the figure, its layout puts it at 4
- sleepresp: "Sleep Duration" is labelled 5 in the figure, its layout puts it at 6
- sleepresp: "Reason Code" is labelled 5+S in the figure, its layout puts it at 6+S
- subscribe-with-topic-filter: "Topic Filter" is labelled 6 ... N in the figure, its layout puts it at 6
- unsubscribe-with-topic-filter: "Topic Filter" is labelled 6 ... N in the figure, its layout puts it at 6
- server-view: the figure lets an Asleep Client send SLEEPREQ (Asleep, to change the Sleep Duration), MQTT-SN-4.14-2 allows only PINGREQ, CONNECT, DISCONNECT
- server-view: the figure has Keep Alive timing out from Awake to Disconnected; tab-session-timers has it in Active -> Disconnected
- figures fig-server-view-of-client-states-informative and fig-server-view-of-client-states-informative-2 share the caption "Server View of Client States - informative"
- kaitai protection-encapsulation: condition on 'Crypto Length', which is no flag of the packet
- kaitai protection-encapsulation: "Crypto Material" (C) has no length field before it and is not last
- kaitai publish-qos-minus-1: Topic Type value 'Topic Short Name' is not defined (tab-topic-types)
- 155 of 312 statements bind no role yet (no `binds`), e.g. MQTT-SN-3.1.2.2-2, MQTT-SN-3.1.2.2-3, MQTT-SN-3.1.2.2-4
