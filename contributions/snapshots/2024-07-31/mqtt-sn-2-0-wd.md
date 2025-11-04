# **MQTT for Sensor Networks (MQTT-SN) Version 2.0**

## **Committee Specification Draft 01**

**01 August 2024** 

**This stage:**

**…**

**Previous stage:**

**N/A**

**Latest stage:**

**…**

**Technical Committee:**  
[OASIS Message Queuing Telemetry Transport (MQTT) TC](https://www.oasis-open.org/committees/mqtt/)

**Chairs:**  
Ian Craggs ([icraggs@gmail.com](mailto:icraggs@gmail.com)), Individual  
Simon Johnson (simon.johnson@hivemq.com), HiveMQ GmbH

**Editors:**  
Andrew Banks (andrewdjbanks@gmail.com), Individual  
Andy Stanford-Clark (andysc@uk.ibm.com), IBM  
Davide Lenzarini ([davide.lenzarini@u-blox.com](mailto:davide.lenzarini@u-blox.com)), u-blox AG  
Ian Craggs ([icraggs@gmail.com](mailto:icraggs@gmail.com)), Individual  
Rahul Gupta ([rahul.gupta@us.ibm.com](mailto:rahul.gupta@us.ibm.com)), [IBM](http://www.ibm.com)  
Simon Johnson ([simon](mailto:simon622@gmail.com).johnson@hivemq.com), HiveMQ GmbH  
Stefan Hagen ([stefan@hagen.link](mailto:stefan@hagen.link)), Individual  
Tara E. Walker ([tara.walker@microsoft.com](mailto:tara.walker@microsoft.com)), [Microsoft Corporation](http://www.microsoft.com/)

**Related work:**  
This specification is related to:

* *MQTT Version 5.0*. Edited by Andrew Banks, Ed Briggs, Ken Borgendale, and Rahul Gupta. OASIS Standard. Latest version: [https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html](https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html).  
* *MQTT Version 3.1.1*. Edited by Andrew Banks and Rahul Gupta. OASIS Standard. Latest version: [http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html](http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html).  
* *MQTT-SN Version 1.2* by Andy Stanford-Clark and Hong Linh Truong. Link: [https://www.oasis-open.org/committees/download.php/66091/MQTT-SN\_spec\_v1.2.pdf](https://www.oasis-open.org/committees/download.php/66091/MQTT-SN\_spec\_v1.2.pdf).

**Abstract:**  
This specification defines the MQTT for Sensor Networks protocol (MQTT-SN). It is closely related to the MQTT v3.1.1 and MQTT v5.0 standards. MQTT-SN is optimized for implementation on low-cost, battery-operated devices with limited processing and storage resources. It is designed so that it will work over a variety of networking technologies and bridge to an MQTT network.

**Status:**  
This document was last revised or approved by the OASIS Message Queuing Telemetry Transport (MQTT) TC on the above date. The level of approval is also listed above. Check the "Latest stage" location noted above for possible later revisions of this document. Any other numbered Versions and other technical work produced by the Technical Committee (TC) are listed at [https://www.oasis-open.org/committees/tc\_home.php?wg\_abbrev=mqtt\#technical](https://www.oasis-open.org/committees/tc\_home.php?wg\_abbrev=mqtt\#technical) .

TC members should send comments on this document to the TC's email list. Others should send comments to the TC's public comment list, after subscribing to it by following the instructions at the "[Send A Comment](https://www.oasis-open.org/committees/comments/index.php?wg\_abbrev=mqtt)" button on the TC's web page at [https://www.oasis-open.org/committees/mqtt/](https://www.oasis-open.org/committees/mqtt/).

This specification is provided under the [Non-Assertion](https://www.oasis-open.org/policies-guidelines/ipr\#Non-Assertion-Mode) Mode of the [OASIS IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr), the mode chosen when the Technical Committee was established. For information on whether any patents have been disclosed that may be essential to implementing this specification, and any offers of patent licensing terms, refer to the Intellectual Property Rights section of the TC’s web page ([https://www.oasis-open.org/committees/mqtt/ipr.php](https://www.oasis-open.org/committees/mqtt/ipr.php)).

Note that any machine-readable content ([Computer Language Definitions](https://www.oasis-open.org/policies-guidelines/tc-process\#wpComponentsCompLang)) declared Normative for this Work Product is provided in separate plain text files. In the event of a discrepancy between any such plain text file and display content in the Work Product's prose narrative document(s), the content in the separate plain text file prevails.

**Citation format:**  
When referencing this document, the following citation format should be used:

**\[MQTT-SN-v2.0\]**

*MQTT for Sensor Networks Version 2.0*. Edited by Andrew Banks, Davide Lenzarini, Ian Craggs, Rahul Gupta, Simon Johnson, Stefan Hagen, and Tara E. Walker. 01 August 2024\. OASIS Committee Specification Draft 01\. [https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.docx](https://docs.oasis-open.org/mqtt/mqtt-sn/v12.30/csd01/mqtt-sn-v12.30-csd01.docx). Latest stage: [https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.docx](https://docs.oasis-open.org/mqtt/mqtt-sn/v12.30/mqtt-sn-v12.30.docx)  
(**Note:** Publication URIs are managed by OASIS TC Administration; please don't modify. The [OASIS TC Process](https://www.oasis-open.org/policies-guidelines/tc-process\#wpComponentsGeneral) requires that Work Products at any level of approval must use the [OASIS file naming scheme](https://docs.oasis-open.org/specGuidelines/ndr/namingDirectives.html), and must include the OASIS copyright notice. The URIs above have been constructed according to the file naming scheme. Remove this note before submitting for publication.)

**Notices**

Copyright © OASIS Open 2024\. All Rights Reserved.

Distributed under the terms of the OASIS IPR Policy, \[[https://www.oasis-open.org/policies-guidelines/ipr/](https://www.oasis-open.org/policies-guidelines/ipr/)\]. For complete copyright information see the full Notices section in an Appendix below.

**Table of Contents**

[1 Introduction	10](\#1-introduction)

[1.0 Intellectual property rights policy	10](\#1.0-intellectual-property-rights-policy)

[1.1 Changes from earlier Versions	10](\#1.1-changes-from-earlier-versions)

[1.1.1 MQTT-SN v1.2	10](\#1.1.1-mqtt-sn-v1.2)

[1.2 Organization of the MQTT-SN specification	10](\#1.2-organization-of-the-mqtt-sn-specification)

[1.3 Terminology	10](\#1.3-terminology)

[1.4 Normative references	14](\#1.4-normative-references)

[1.5 Informative References	15](\#1.5-informative-references)

[1.6 MQTT For Sensor Networks (MQTT-SN)	15](\#1.6-mqtt-for-sensor-networks-(mqtt-sn))

[1.6.1 MQTT-SN and MQTT Differences	15](\#1.6.1-mqtt-sn-and-mqtt-differences)

[1.7 Data representation	16](\#1.7-data-representation)

[1.7.1 Bits (Byte)	16](\#1.7.1-bits-(byte))

[1.7.2 Two Byte Integer	16](\#1.7.2-two-byte-integer)

[1.7.3 Four Byte Integer	16](\#1.7.3-four-byte-integer)

[1.7.4 UTF-8 Encoded String	16](\#1.7.4-utf-8-encoded-string)

[2 MQTT-SN Control Packet format	18](\#2-mqtt-sn-control-packet-format)

[2.1 Structure of an MQTT-SN Control Packet	18](\#2.1-structure-of-an-mqtt-sn-control-packet)

[2.1.1 Packet Header	18](\#2.1.1-packet-header)

[2.1.2 Length	18](\#2.1.2-length)

[2.1.3 MQTT-SN Control Packet Type	19](\#2.1.3-mqtt-sn-control-packet-type)

[2.2 Packet Identifier	22](\#2.2-packet-identifier)

[2.3 MQTT-SN Packet Fields	24](\#2.3-mqtt-sn-packet-fields)

[2.3.1 Protocol Id	24](\#2.3.1-protocol-versionid)

[2.3.2 Radius	24](\#2.3.2-radius)

[2.3.3 Reason Code	24](\#2.3.3-reason-code)

[2.3.4 Topic Data	29](\#2.3.4-topic-data)

[2.3.5 Topic Name	29](\#2.3.5-topic-name)

[2.4 Topic Types	29](\#2.4-topic-types)

[3 MQTT-SN Control Packets	31](\#3-mqtt-sn-control-packets)

[3.1 Format of Individual Packets	31](\#3.1-format-of-individual-packets)

[3.1.1 ADVERTISE \- Gateway Advertisement	31](\#3.1.1-advertise---gateway-advertisement)

[3.1.1.1 Length & Packet Type	31](\#3.1.1.1-length-&-packet-type)

[3.1.1.2 GwId	31](\#3.1.1.2-gwid)

[3.1.1.3 Duration	31](\#3.1.1.3-duration)

[3.1.2 SEARCHGW \- Search for A Gateway	32](\#3.1.2-searchgw---search-for-a-gateway)

[3.1.2.1 Length & Packet Type	32](\#3.1.2.1-length-&-packet-type)

[3.1.2.2 Radius	32](\#3.1.2.2-radius)

[3.1.3 GWINFO \- Gateway Information	32](\#3.1.3-gwinfo---gateway-information)

[3.1.3.1 Length & Packet Type	33](\#3.1.3.1-length-&-packet-type)

[3.1.3.2 GwId	33](\#3.1.3.2-gwid)

[3.1.3.3 GwAdd	33](\#3.1.3.3-gwadd)

[3.1.4 CONNECT \- Connection Request	33](\#3.1.4-connect---connection-request)

[3.1.4.1 Length & Packet Type	34](\#3.1.4.1-length-&-packet-type)

[3.1.4.2 Connect Flags	34](\#3.1.4.2-connect-flags)

[3.1.4.3 Packet Identifier	35](\#3.1.4.3-packet-identifier)

[3.1.4.4 Protocol Version	35](\#3.1.4.4-protocol-version)

[3.1.4.5 Keep Alive Timer	35](\#3.1.4.5-keep-alive-timer)

[3.1.4.6 Session Expiry Interval	36](\#3.1.4.6-session-expiry-interval)

[3.1.4.7 Maximum Packet Size	36](\#3.1.4.7-maximum-packet-size)

[3.1.4.8 Client Identifier (ClientID)	36](\#3.1.4.8-client-identifier-(clientid))

[3.1.4.9 Connect Will Flags (optional, only with Will flag set)	37](\#3.1.4.9-connect-will-flags-(optional,-only-with-will-flag-set))

[3.1.4.10 Will Topic Short or Will Topic Length (optional, only with Will flag set)	37](\#3.1.4.10-will-topic-short-or-will-topic-length-(optional,-only-with-will-flag-set))

[3.1.4.11 Will Payload Length (optional, only with Will flag set)	37](\#3.1.4.11-will-payload-length-(optional,-only-with-will-flag-set))

[3.1.4.12 Will Payload (optional, only with Will flag set)	37](\#3.1.4.12-will-payload-(optional,-only-with-will-flag-set))

[3.1.4.13 Authentication Method Length (optional, only with Auth flag set)	38](\#3.1.4.13-authentication-method-length-(optional,-only-with-auth-flag-set))

[3.1.4.14 Authentication Method (optional, only with Auth flag set)	38](\#3.1.4.14-authentication-method-(optional,-only-with-auth-flag-set))

[3.1.4.15 Authentication Data Length (optional, only with Auth flag set)	38](\#3.1.4.15-authentication-data-length-(optional,-only-with-auth-flag-set))

[3.1.4.16 Authentication Data (optional, only with Auth flag set)	38](\#3.1.4.16-authentication-data-(optional,-only-with-auth-flag-set))

[3.1.4.17 CONNECT Actions	38](\#3.1.4.17-connect-actions)

[3.1.5 CONNACK \- Connect Acknowledgement	39](\#3.1.5-connack---connect-acknowledgement)

[3.1.5.1 Length & Packet Type	40](\#3.1.5.1-length-&-packet-type)

[3.1.5.2 Connack Flags	40](\#3.1.5.2-connack-flags)

[3.1.5.3 Packet Identifier	41](\#3.1.5.3-packet-identifier)

[3.1.5.4 Reason Code	41](\#3.1.5.4-reason-code)

[3.1.5.5 Session Expiry Interval	41](\#3.1.5.5-session-expiry-interval)

[3.1.5.6 Authentication Method Length (optional, only with Auth flag set)	41](\#3.1.5.6-authentication-method-length-(optional,-only-with-auth-flag-set))

[3.1.5.7 Authentication Method (optional, only with Auth flag set)	41](\#3.1.5.7-authentication-method-(optional,-only-with-auth-flag-set))

[3.1.5.8 Authentication Data Length (optional, only with Auth flag set)	41](\#3.1.5.8-authentication-data-length-(optional,-only-with-auth-flag-set))

[3.1.5.9 Authentication Data (optional, only with Auth flag set)	41](\#3.1.5.9-authentication-data-(optional,-only-with-auth-flag-set))

[3.1.5.10 Assigned Client Identifier	41](\#3.1.5.10-assigned-client-identifier)

[3.1.6 AUTH \- Authentication Exchange	42](\#3.1.6-auth---authentication-exchange)

[3.1.6.1 Length & Packet Type	42](\#3.1.6.1-length-&-packet-type)

[3.1.7.2 Packet Identifier	42](\#3.1.7.2-packet-identifier)

[3.1.6.2 Reason Code	42](\#3.1.6.2-reason-code)

[3.1.6.3 Auth Method Length	43](\#3.1.6.3-auth-method-length)

[3.1.6.4 Auth Method	43](\#3.1.6.4-auth-method)

[3.1.6.5 Auth Data	43](\#3.1.6.5-auth-data)

[3.1.6.6 Auth Actions	43](\#3.1.6.6-auth-actions)

[3.1.7 REGISTER \- Register Topic Alias Request	43](\#3.1.7-register---register-topic-alias-request)

[3.1.7.1 Length & Packet Type	43](\#3.1.7.1-length-&-packet-type)

[3.1.7.2 Packet Identifier	43](\#3.1.7.2-packet-identifier-1)

[3.1.7.3 Topic Alias	44](\#3.1.7.3-topic-alias)

[3.1.7.4 Topic Name	44](\#3.1.7.4-topic-name)

[3.1.7.5 Register Actions	44](\#3.1.7.5-register-actions)

[3.1.8 REGACK \- Register Topic Alias Response	44](\#3.1.8-regack---register-topic-alias-response)

[3.1.8.1 Length & Packet Type	44](\#3.1.8.1-length-&-packet-type)

[3.1.8.2 REGACK Flags	44](\#3.1.8.2-regack-flags)

[3.1.8.3 Packet Identifier	45](\#3.1.8.3-packet-identifier)

[3.1.8.4 Topic Alias	45](\#3.1.8.4-topic-alias)

[3.1.8.5 Reason Code	45](\#3.1.8.5-reason-code)

[3.1.9 Publish Variants	45](\#3.1.9-publish-variants)

[3.1.10 PUBWOS \- Publish Without Session	45](\#3.1.10-pubwos---publish-without-session)

[3.1.10.1 Length & Packet Type	46](\#3.1.10.1-length-&-packet-type)

[3.1.10.2 PUBWOS Flags	46](\#3.1.10.2-pubwos-flags)

[3.1.10.3 Topic Data	46](\#3.1.10.3-topic-data)

[3.1.10.4 Data	46](\#3.1.10.4-data)

[3.1.12.7 PUBWOS Actions	46](\#3.1.12.7-pubwos-actions)

[3.1.11 PUBLISH \- QoS 0	47](\#3.1.11-publish---qos-0)

[3.1.11.1 Length & Packet Type	47](\#3.1.11.1-length-&-packet-type)

[3.1.11.2 PUBLISH Flags	47](\#3.1.11.2-publish-flags)

[3.1.11.3 Topic Data	48](\#3.1.11.3-topic-data)

[3.1.11.4 Data	48](\#3.1.11.4-data)

[3.1.11.5 PUBLISH \- QoS 0 Actions	48](\#3.1.11.5-publish---qos-0-actions)

[3.1.12 PUBLISH \- QoS 1 and 2	48](\#3.1.12-publish---qos-1-and-2)

[3.1.12.1 Length & Packet Type	48](\#3.1.12.1-length-&-packet-type)

[3.1.12.2 PUBLISH Flags	49](\#3.1.12.2-publish-flags)

[3.1.12.4 Packet Identifier	49](\#3.1.12.4-packet-identifier)

[3.1.12.5 Topic Data	49](\#3.1.12.5-topic-data)

[3.1.12.6 Data	49](\#3.1.12.6-data)

[3.1.12.7 PUBLISH Actions	49](\#3.1.12.7-publish-actions)

[3.1.13 PUBACK – Publish Acknowledgement	50](\#3.1.13-puback-–-publish-acknowledgement)

[3.1.13.1 Length & Packet Type	51](\#3.1.13.1-length-&-packet-type)

[3.1.13.2 Packet Identifier	51](\#3.1.13.2-packet-identifier)

[3.1.13.3 Reason Code	51](\#3.1.13.3-reason-code)

[3.1.13.4 PUBACK Actions	51](\#3.1.13.4-puback-actions)

[3.1.14 PUBREC (QoS 2 delivery part 1\)	51](\#3.1.14-pubrec-(qos-2-delivery-part-1))

[3.1.14.1 Length & Packet Type	51](\#3.1.14.1-length-&-packet-type)

[3.1.14.2 Packet Identifier	52](\#3.1.14.2-packet-identifier)

[3.1.14.3 Reason Code	52](\#3.1.14.3-reason-code)

[3.1.14.4 PUBREC Actions	52](\#3.1.14.4-pubrec-actions)

[3.1.15 PUBREL (QoS 2 delivery part 2\)	52](\#3.1.15-pubrel-(qos-2-delivery-part-2))

[3.1.15.1 Length & Packet Type	52](\#3.1.15.1-length-&-packet-type)

[3.1.15.2 Packet Identifier	52](\#3.1.15.2-packet-identifier)

[3.1.15.3 Reason Code	52](\#3.1.15.3-reason-code)

[3.1.15.4 PUBREL Actions	52](\#3.1.15.4-pubrel-actions)

[3.1.16 PUBCOMP \- Publish Complete (QoS 2 delivery part 3\)	52](\#3.1.16-pubcomp---publish-complete-(qos-2-delivery-part-3))

[3.1.16.1 Length & Packet Type	53](\#3.1.16.1-length-&-packet-type)

[3.1.16.2 Packet Identifier	53](\#3.1.16.2-packet-identifier)

[3.1.16.3 Reason Code	53](\#3.1.16.3-reason-code)

[3.1.16.4 PUBCOMP Actions	53](\#3.1.16.4-pubcomp-actions)

[3.1.17 SUBSCRIBE \- Subscribe Request	53](\#3.1.17-subscribe---subscribe-request)

[3.1.17.1 Length & Packet Type	54](\#3.1.17.1-length-&-packet-type)

[3.1.17.2 SUBSCRIBE Flags	54](\#3.1.17.2-subscribe-flags)

[3.1.17.3 Packet Identifier	54](\#3.1.17.3-packet-identifier)

[3.1.17.4 Topic Data or Topic Filter	54](\#3.1.17.4-topic-data-or-topic-filter)

[3.1.17.5 SUBSCRIBE Actions	54](\#3.1.17.5-subscribe-actions)

[3.1.18 SUBACK \- Subscribe Acknowledgement	55](\#3.1.18-suback---subscribe-acknowledgement)

[3.1.18.1 Length & Packet Type	56](\#3.1.18.1-length-&-packet-type)

[3.1.18.2 Flags	56](\#3.1.18.2-flags)

[3.1.18.3 Topic Data	56](\#3.1.18.3-topic-data)

[3.1.18.4 Packet Identifier	56](\#3.1.18.4-packet-identifier)

[3.1.18.5 Reason Code	56](\#3.1.18.5-reason-code)

[3.1.19 UNSUBSCRIBE \- Unsubscribe Request	56](\#3.1.19-unsubscribe---unsubscribe-request)

[3.1.19.1 Length & Packet Type	57](\#3.1.19.1-length-&-packet-type)

[3.1.19.2 UNSUBSCRIBE Flags	57](\#3.1.19.2-unsubscribe-flags)

[3.1.19.3 Packet Identifier	57](\#3.1.19.3-packet-identifier)

[3.1.19.4 Topic Data or Topic Filter	57](\#3.1.19.4-topic-data-or-topic-filter)

[3.1.19.4 UNSUBSCRIBE Actions	57](\#3.1.19.4-unsubscribe-actions)

[3.1.20 UNSUBACK \- Unsubscribe Acknowledgement	58](\#3.1.20-unsuback---unsubscribe-acknowledgement)

[3.1.20.1 Length & Packet Type	58](\#3.1.20.1-length-&-packet-type)

[3.1.20.2 Packet Identifier	58](\#3.1.20.2-packet-identifier)

[3.1.20.3 Reason Code	58](\#3.1.20.3-reason-code)

[3.1.21 PINGREQ \- Ping Request	58](\#3.1.21-pingreq---ping-request)

[3.1.21.1 Length & Packet Type	59](\#3.1.21.1-length-&-packet-type)

[3.1.21.2 Packet Identifier	59](\#3.1.21.2-packet-identifier)

[3.1.21.3 Client Identifier (optional)	59](\#3.1.21.3-client-identifier-(optional))

[3.1.21.4 PINGREQ Actions	59](\#3.1.21.4-pingreq-actions)

[3.1.22 PINGRESP \- Ping Response	59](\#3.1.22-pingresp---ping-response)

[3.1.22.1 Length & Packet Type	60](\#3.1.22.1-length-&-packet-type)

[3.1.22.2 Packet Identifier	60](\#3.1.22.2-packet-identifier)

[3.1.22.3 Application Messages Remaining	60](\#3.1.22.3-application-messages-remaining)

[3.1.23 DISCONNECT \- Disconnect Notification	60](\#3.1.23-disconnect---disconnect-notification)

[3.1.23.1 Length & Packet Type	61](\#3.1.23.1-length-&-packet-type)

[3.1.23.2 Disconnect Flags	61](\#3.1.23.2-disconnect-flags)

[3.1.23.3 Reason Code	61](\#3.1.23.3-reason-code)

[3.1.23.4 Session Expiry Interval	61](\#3.1.23.4-session-expiry-interval)

[3.1.23.5 Reason String	62](\#3.1.23.5-reason-string)

[3.1.23.6 DISCONNECT Actions	62](\#3.1.23.6-disconnect-actions)

[3.1.24 Forwarder Encapsulation	62](\#3.1.25-forwarder-encapsulation)

[3.1.24.1 Length	63](\#3.1.25.1-length)

[3.1.24.2 Packet Type	63](\#3.1.25.2-packet-type)

[3.1.24.3 Ctrl	63](\#3.1.25.3-ctrl)

[3.1.24.4 Radius	63](\#3.1.25.4-radius)

[3.1.24.5 Wireless Node Id	63](\#3.1.25.5-wireless-node-id)

[3.1.24.6 MQTT SN Packet	63](\#3.1.25.6-mqtt-sn-packet)

[3.1.25 Protection Encapsulation	63](\#3.1.26-protection-encapsulation)

[3.1.25.1 Length	65](\#3.1.26.1-length)

[3.1.25.2 Packet Type	65](\#3.1.26.2-packet-type)

[3.1.25.3 Protection Flags	65](\#3.1.26.3-protection-flags)

[3.1.25.4 Protection Scheme	65](\#3.1.26.4-protection-scheme)

[3.1.25.5 Sender Identifier	67](\#3.1.26.5-sender-identifier)

[3.1.25.6 Random	67](\#3.1.26.6-random)

[3.1.25.7 Crypto Material	68](\#3.1.26.7-crypto-material)

[3.1.25.8 Monotonic Counter	68](\#3.1.26.8-monotonic-counter)

[3.1.25.9 Protected MQTT-SN Packet	68](\#3.1.26.9-protected-mqtt-sn-packet)

[3.1.25.10 Authentication Tag	68](\#3.1.26.10-authentication-tag)

[4 Operational behavior	69](\#4-operational-behavior)

[4.1 Session state	69](\#4.1-session-state)

[4.1.1 Storing Session State	69](\#4.1.1-storing-session-state)

[4.1.2 Session Establishment	70](\#4.1.2-session-establishment)

[4.2 Networks and Virtual Connections	71](\#4.2-networks-and-virtual-connections)

[4.3 Quality of Service levels and protocol flows	72](\#4.3-quality-of-service-levels-and-protocol-flows)

[4.3.1 Publish without session: Any number of deliveries	72](\#4.3.1-publish-without-session:-any-number-of-deliveries)

[4.3.2 QoS 0: At most once delivery	72](\#4.3.2-qos-0:-at-most-once-delivery)

[4.3.3 QoS 1: At least once delivery	73](\#4.3.3-qos-1:-at-least-once-delivery)

[4.3.4 QoS 2: Exactly once delivery	74](\#4.3.4-qos-2:-exactly-once-delivery)

[4.4 Packet delivery retry	74](\#4.4-packet-delivery-retry)

[4.4.1 Virtual Connection End	75](\#4.4.1-virtual-connection-end)

[4.4.1 Unacknowledged Packets	76](\#4.4.1-unacknowledged-packets)

[4.5 Application Message receipt	76](\#4.5-application-message-receipt)

[4.6 Application Message ordering	77](\#4.6-application-message-ordering)

[4.7 Topic Names and Topic Filters	77](\#4.7-topic-names-and-topic-filters)

[4.7.1 Topic wildcards	77](\#4.7.1-topic-wildcards)

[4.7.1.1 Topic level separator	77](\#4.7.1.1-topic-level-separator)

[4.7.1.2 Multi-level wildcard	78](\#4.7.1.2-multi-level-wildcard)

[4.7.1.3 Single-level wildcard	78](\#4.7.1.3-single-level-wildcard)

[4.7.2  Topics beginning with $	78](\#4.7.2-topics-beginning-with-$)

[4.7.3 Topic semantic and usage	79](\#4.7.3-topic-semantic-and-usage)

[4.8 Subscriptions	80](\#4.8-subscriptions)

[4.9 Flow Control	80](\#4.9-flow-control)

[4.10 Server redirection	80](\#4.10-server-redirection)

[4.11 Enhanced authentication	80](\#4.11-enhanced-authentication)

[4.11.1 Re-authentication	82](\#4.11.1-re-authentication)

[4.12 Handling errors	83](\#4.12-handling-errors)

[4.12.1 Malformed Packet and Protocol Errors	83](\#4.12.1-malformed-packet-and-protocol-errors)

[4.12.2 Other errors	83](\#4.12.2-other-errors)

[4.13 Example MQTT-SN Architectures	84](\#4.13-example-mqtt-sn-architectures)

[4.13.1 Transparent Gateway	85](\#4.13.1-transparent-gateway)

[4.13.2 Aggregating Gateway	86](\#4.13.2-aggregating-gateway)

[4.14 Gateway Advertisement and Discovery	89](\#4.14-gateway-advertisement-and-discovery)

[4.15 Client states	89](\#4.15-client-states)

[4.15.1 Gateway timers	91](\#4.15.1-gateway-timers)

[4.16 Clean start	92](\#4.16-clean-start)

[4.17 Topic Registration	92](\#4.17-topic-registration)

[4.18 Topic Mapping and Aliasing	93](\#4.18-topic-mapping-and-aliasing)

[4.19 Predefined topic aliases and short topic names	93](\#4.19-predefined-topic-aliases-and-short-topic-names)

[4.20 Client’s Topic Subscribe/Unsubscribe Procedure	93](\#4.20-client’s-topic-subscribe/unsubscribe-procedure)

[4.21 Client’s Publish Procedure	94](\#4.21-client-publish-procedure)

[4.22 Gateway’s Publish Procedure	94](\#4.22-gateway-publish-procedure)

[4.23 Keep Alive and PING Procedure	95](\#4.23-keep-alive-and-ping-procedure)

[4.24 Client’s Disconnect Procedure	95](\#4.24-client’s-disconnect-procedure)

[4.25 Sleeping clients	95](\#4.25-sleeping-clients)

[4.26 Retained Messages	97](\#4.26-retained-messages)

[4.27 Optional Features	98](\#4.27-optional-features)

[**5 Security (Informative)	99**](\#5-security-(informative))

[5.1 Introduction	100](\#5.1-introduction)

[6 Conformance	101](\#6-conformance)

[**Appendix A. References	102**](\#appendix-a.-references)

[A.1 Normative References	103](\#a.1-normative-references)

[A.2 Informative References	103](\#a.2-informative-references)

[**Appendix B. Backwards Compatibility	104**](\#appendix-b.-backwards-compatibility)

[B.1 PUBLISH QoS \-1 (Packet from MQTT-SN 1.2)	104](\#b.1-publish-qos--1-(packet-from-mqtt-sn-1.2))

[B.1.1 Length & Packet Type	104](\#b.1.1-length-&-packet-type)

[B.1.2 PUBLISH Flags	104](\#b.1.2-publish-flags)

[B.1.3 Topic Id	105](\#b.1.3-topic-id)

[B.1.4 Data	105](\#b.1.4-data)

[**Appendix C. Security and Privacy Considerations	106**](\#appendix-c.-security-and-privacy-considerations)

[**Appendix D. Acknowledgments	107**](\#appendix-d.-acknowledgments)

[D.1 Special Thanks	107](\#d.1-special-thanks)

[D.2 Participants	107](\#d.2-participants)

[**Appendix E. Revision History	108**](\#appendix-e.-revision-history)

[**Appendix F. Implementation Notes	113**](\#appendix-f.-implementation-notes)

[F.1 Support of PUBLISH WITHOUT SESSION	113](\#f.1-support-of-publish-without-session)

[F.2 “Best practice” values for timers and counters	113](\#f.2-“best-practice”-values-for-timers-and-counters)

[F.3 Mapping of Topic Alias to Topic Names and Topic Filters	113](\#f.3-mapping-of-topic-alias-to-topic-names-and-topic-filters)

[F.4 Exponential Backoff	113](\#f.4-exponential-backoff)

[**Appendix G. Notices	115**](\#appendix-g.-notices)

# **1 Introduction** {#1-introduction}

\[All text is normative unless otherwise labeled\]

## **1.0 Intellectual property rights policy** {#1.0-intellectual-property-rights-policy}

This specification is provided under the [Non-Assertion](https://www.oasis-open.org/policies-guidelines/ipr\#Non-Assertion-Mode) Mode of the [OASIS IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr), the mode chosen when the Technical Committee was established. For information on whether any patents have been disclosed that may be essential to implementing this specification, and any offers of patent licensing terms, refer to the Intellectual Property Rights section of the TC’s web page ([https://www.oasis-open.org/committees/mqtt/ipr.php](https://www.oasis-open.org/committees/mqtt/ipr.php)).

## **1.1 Changes from earlier Versions** {#1.1-changes-from-earlier-versions}

\[Optional section.\]

This section provides a description of significant differences from previously published, differently numbered Versions of this specification, if any. (Detailed revision history of this numbered Version should be tracked in an Appendix.)

### **1.1.1 MQTT-SN v1.2** {#1.1.1-mqtt-sn-v1.2}

Text describing the changes/differences

## **1.2 Organization of the MQTT-SN specification** {#1.2-organization-of-the-mqtt-sn-specification}

The specification is split into five chapters:

* [Chapter](\#heading=h.2bxgwvm) 1 – Introduction	   
* Chapter 2 – MQTT-SN Control Packet format  
* Chapter 3 – MQTT-SN Control Packets  
* Chapter 4 – Operational Behavior  
* Chapter 5 – Conformance

## **1.3 Terminology** {#1.3-terminology}

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this specification are to be interpreted as described in IETF RFC 2119 \[RFC2119\], except where they appear in text that is marked as non-normative.

**Datagram:**

An independent, self-contained sequence of bytes. If received, the contents of a datagram must be correct.

**Underlying Network:**

The underlying network which provides the means to send datagrams from one Network Address to another. 

The arrival of a datagram is not guaranteed, but the contents of any datagram which does arrive at its destination must be correct.

**Network Address:**

A unique label provided by the Underlying Network to identify a network endpoint.

To receive datagrams, an MQTT-SN Client or Server listens to the network for packets addressed to a specific Network Address.

**Unicast Address:**

A Network Address which represents one device on a network. For packets intended to reach one network endpoint.

**Multicast Address:**

A Network Address which represents all or groups of devices on a network. For packets intended for more than one network endpoint.

**Informative:**

Multicast Address as used in this specification also includes the concept of broadcast addresses, for brevity.

**Network Identity:**

The identity used to establish that a sequence of datagrams originates from the same network source. This could be, for example:

* A Network Address  
* A DTLS connection ID  
* An MQTT-SN Protection Packet sender ID

**Virtual Connection:**

An MQTT-SN construct corresponding to the network connection in MQTT. It associates a Network Identity with an MQTT-SN endpoint.

 **Application Message:**

The data carried by the MQTT-SN protocol across the network for the application. When an Application Message is transported by MQTT-SN it contains payload data, a Quality of Service (QoS), and a Topic Name.

 **Client:**

A program or device that uses MQTT-SN. A Client:

* creates a Virtual Connection to a Server.  
* publishes Application Messages that other Clients might be interested in.  
* subscribes to request Application Messages that it is interested in receiving.  
* unsubscribes to remove a request for Application Messages.  
* deletes the Virtual Connection to the Server.

and/or:

* publishes Application Messages to a Multicast Address.

and/or:

* accepts Application Messages from a Multicast Address.

**Server:**

A program or device that acts as an intermediary between Clients which publish Application Messages and Clients which have made Subscriptions. 

Also known as a **Gateway**.

A Server:

* accepts CONNECT requests from Clients.  
* accepts Application Messages published by Clients.  
* processes Subscribe and Unsubscribe requests from Clients.  
* forwards Application Messages that match Client Subscriptions.  
* accepts DISCONNECT requests from connected Clients.

and/or

* accepts packets from a Multicast Address.

and/or

* opens an MQTT Network Connection to an MQTT Server.  
* accepts Application Messages from the MQTT Server and forwards some or all to MQTT-SN Clients.  
* accepts Application Messages from MQTT-SN Clients and forwards some or all to the MQTT Server.

and/or

* opens an MQTT Network Connection to an MQTT Server for every MQTT-SN CONNECT request  
* forwards equivalent MQTT packets to the MQTT Server for each MQTT-SN packet received  
* forwards equivalent MQTT-SN packets to the MQTT-SN Client for each MQTT packet received  
* closes the MQTT Network Connection when the Virtual Connection is deleted

**MQTT Server:**

A program or device that acts as an intermediary between MQTT Clients which publish Application Messages and MQTT Clients which have made Subscriptions. 

Also known as a **Broker**.

An MQTT Server:

* accepts Network Connections from MQTT Clients.  
* accepts Application Messages published by MQTT Clients.  
* processes Subscribe and Unsubscribe requests from MQTT Clients.  
* forwards Application Messages that match MQTT Client Subscriptions.  
* closes the Network Connection from the MQTT Client.

**Session:**

A stateful interaction between a Client and a Gateway. Some Sessions last only as long as the Virtual Connection, others can span multiple consecutive Virtual Connections between a Client and a Gateway.

**Session State:**

The set of data that describes a Session. The Session State held by a Client is different to that held by a Server. See [section 4.1](\#4.1-session-state) for details.

**Subscription:**

A Subscription comprises a Topic Filter and a maximum QoS. A Subscription is associated with a single Session. A Session can contain more than one Subscription. Each Subscription within a Session has a different Topic Filter.

 **Wildcard Subscription:**

A Wildcard Subscription is a Subscription with a Topic Filter containing one or more wildcard characters. This allows the subscription to match more than one Topic Name. Refer to [section 4.7.1](\#4.7.1-topic-wildcards) for a description of wildcard characters in a Topic Filter.

**Topic Name:**

The label attached to an Application Message which is matched against the Subscriptions known to the Server.

**Topic Alias:**

A Topic Alias is an integer value that is used to identify the Topic instead of using the Topic Name, to reduce packet size.

**Topic Filter:**

An expression contained in a Subscription to indicate an interest in one or more topics. A Topic Filter can include wildcard characters.

**MQTT-SN Control Packet:**

A packet of information that is sent to a Network Address. 

**Malformed Packet:**

A Control Packet that cannot be parsed according to this specification. Refer to [section 4.12](\#4.12-handling-errors) for information about error handling.

**Protocol Error:**

An error that is detected after the packet has been parsed and found to contain data that is not allowed by the protocol or is inconsistent with the state of the Client or Server. Refer to [section 4.12](\#4.12-handling-errors) for information about error handling.

**Will Message:**

An Application Message which is published by the Server after the Virtual Connection is deleted in cases where the Virtual Connection is not deleted normally. Refer to [section 3.1.4.9](\#3.1.4.9-connect-will-flags-(optional,-only-with-will-flag-set)) for information about Will Messages.

**Retained Message:**

An Application Message which is stored by the Server for a topic on the receipt of a Publish Packet with the retained flag set. When a Client subscribes to a topic with a Retained Message set, the Server sends the Retained Message to the Client, depending on the setting of the Retain Handling Subscribe Flags. Refer to [section 3.1.17.2](\#3.1.17.2-subscribe-flags) and [section 4.26](\#4.26-retained-messages) for more information about Retained Messages.

**Disallowed Unicode code point:**

The set of Unicode Control Codes and Unicode Noncharacters which should not be included in a UTF-8 Encoded String. Refer to [section 1.7.4](\#1.7.4-utf-8-encoded-string) for more information about the Disallowed Unicode code points.

**Wireless Sensor Network:**

Spatially dispersed and dedicated sensors that monitor and record the physical conditions of the environment and forward the collected data to a central location.

Also known as **WSN**, for short.

## **1.4 Normative references** {#1.4-normative-references}

**\[RFC2119\]**

Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997,

[http://www.rfc-editor.org/info/rfc2119](http://www.rfc-editor.org/info/rfc2119)

**\[RFC3629\]**

Yergeau, F., "UTF-8, a transformation format of ISO 10646", STD 63, RFC 3629, DOI 10.17487/RFC3629, November 2003,

[http://www.rfc-editor.org/info/rfc3629](http://www.rfc-editor.org/info/rfc3629)

**\[RFC6455\]**

Fette, I. and A. Melnikov, "The WebSocket Protocol", RFC 6455, DOI 10.17487/RFC6455, December 2011,

[http://www.rfc-editor.org/info/rfc6455](http://www.rfc-editor.org/info/rfc6455)

**\[Unicode\]**

The Unicode Consortium. The Unicode Standard,

[http://www.unicode.org/versions/latest/](http://www.unicode.org/versions/latest/)

## **1.5 Informative References** {#1.5-informative-references}

## **1.6 MQTT For Sensor Networks (MQTT-SN)**  {#1.6-mqtt-for-sensor-networks-(mqtt-sn)}

Sensor Networks are simple, low cost and easy to deploy. They are typically used to provide event detection, monitoring, automation, process control and more. Sensor Networks often comprise many battery-powered sensors and actuators, each containing a limited amount of storage and processing capability. They usually communicate wirelessly.

Sensor Networks are typically self-forming, continually changing, and do not have any central control. The wireless network connections and processing nodes will fail, and the batteries will run out. The nodes will be replaced, added or removed in an unplanned way. The identities of the devices are usually created when they are manufactured, this avoids the need for specialist configuration when they are deployed. Applications running outside the Sensor Network do not need to know the details of the devices in it. The applications consume information from the sensors and send instructions to actuators based only on labels created by the application designers. The labels are called Topic Names in the MQTT and MQTT-SN protocols. The MQTT-SN implementation carries information between a set of applications and the correct set of devices based on its knowledge of the network and the applications designer’s choice of Topic Names. 

Consider an example of a medicine tracking application. The application needs to know the location and temperature of the medicine, but it does not want to concern itself with the network details of the devices providing the data. It may be that the number and types of the devices changes over time. There may also be other applications using the same sensor data for other purposes. The model is that the devices and applications produce and consume data addressed by the Topics rather than the other devices and applications.

This MQTT-SN specification is a variant of the MQTT version 5 specification. It is adapted to exploit low power and low bandwidth wireless networks. Low power wireless radio links typically have higher numbers of transmission errors compared to more powerful networks because they are more susceptible to interference and fading of the radio signals. They also have lower transmission rates. 

For example, wireless networks based on the IEEE 802.15.4 standard used by Zigbee have a maximum bandwidth of 250 kbit/s in the 2.4 GHz band. To reduce transmission errors the packets are kept short. The maximum packet length at the physical layer is 128 bytes and half of these may be used for Media Access Control and security.

The MQTT-SN protocol is optimized for implementation on low-cost, battery-operated devices with limited processing and storage resources. The capabilities are kept simple and the specification allows partial implementations.

### **1.6.1 MQTT-SN and MQTT Differences** {#1.6.1-mqtt-sn-and-mqtt-differences}

To facilitate interoperation the MQTT-SN specification is similar in many ways to MQTT, but the two  are independent of each other.

MQTT-SN can work isolated from other networks or in conjunction with MQTT. The main differences between MQTT-SN and MQTT are:

1. In addition to Topic Alias and long Topic Names MQTT-SN allows predefined and short two-byte Topic Names.

1. If the network supports Multicast, Gateway discovery can be implemented, otherwise the Gateway addresses must be configured in the nodes.

1. Support for sleeping clients allows battery operated devices to enter a low power mode. In this state, Application Messages for the Client are buffered by the Gateway and delivered when the client wakes.

1. A new Quality of Service level (WITHOUT SESSION) is introduced in MQTT-SN, allowing devices to publish without a session having been established.

1. MQTT-SN has fewer requirements on the underlying transport and it can use connectionless network transports such as User Datagram Protocol (UDP).

1. MQTT-SN introduces the PROTECTION packet for packet-based security based on symmetric-key cryptography. 

## **1.7 Data representation** {#1.7-data-representation}

### **1.7.1 Bits (Byte)** {#1.7.1-bits-(byte)}

Bits in a byte are labeled 7 to 0\. Bit number 7 is the most significant bit, the least significant bit is assigned bit number 0\.

### **1.7.2 Two Byte Integer** {#1.7.2-two-byte-integer}

Two Byte Integer data values are 16-bit unsigned integers in big-endian order: the high order byte precedes the lower order byte. This means that a 16-bit word is presented on the network as Most Significant Byte (MSB), followed by Least Significant Byte (LSB).

### **1.7.3 Four Byte Integer** {#1.7.3-four-byte-integer}

Four Byte Integer data values are 32-bit unsigned integers in big-endian order: the high order byte precedes the successively lower order bytes. This means that a 32-bit word is presented on the network as Most Significant Byte (MSB), followed by the next most Significant Byte (MSB), followed by the next most Significant Byte (MSB), followed by Least Significant Byte (LSB).

### **1.7.4 UTF-8 Encoded String** {#1.7.4-utf-8-encoded-string}

Text fields within the MQTT-SN Control Packets are encoded as fixed length UTF-8 strings. UTF-8 [\[RFC3629\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html\#RFC3629) is an efficient encoding of Unicode [\[Unicode\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html\#Unicode) characters that optimizes the encoding of ASCII characters in support of text-based communications.

Unless stated otherwise all variable length UTF-8 encoded strings can have any length in the range 0 to 65,535 bytes.

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| byte 1 …. | UTF-8 encoded character data, if length \> 0\. |  |  |  |  |  |  |  |

Table 1: Structure of UTF-8 Encoded Strings

The character data in a UTF-8 Encoded String MUST be well-formed UTF-8 as defined by the Unicode specification [\[Unicode\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html\#Unicode) and restated in RFC 3629 [\[RFC3629\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html\#RFC3629). In particular, the character data MUST NOT include encodings of code points between U+D800 and U+DFFF \[MQTT-SN-1.7.4-1\].

If the Client or Server receives an MQTT-SN Control Packet containing ill-formed UTF-8 it is a Malformed Packet. Refer to [section 4.12](\#4.12-handling-errors) for information about handling errors.

A UTF-8 Encoded String MUST NOT include an encoding of the null character U+0000  \[MQTT-SN-1.7.4-2\]. If a receiver (Server or Client) receives an Control Packet containing U+0000 in a UTF-8 Encoded String it is a Malformed Packet.

UTF-8 Encoded Strings SHOULD NOT include the Unicode \[Unicode\] code points listed below. If a receiver (Server or Client) receives an MQTT-SN Control Packet with UTF-8 Encoded Strings containing any of them it MAY treat it as a Malformed Packet. These are the Disallowed Unicode code points.

* U+0001..U+001F control characters  
* U+007F..U+009F control characters  
* Code points defined in the Unicode specification [\[Unicode\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html\#Unicode) to be non-characters (for example U+0FFFF)

A UTF-8 encoded sequence 0xEF 0xBB 0xBF is always interpreted as U+FEFF ("ZERO WIDTH NO-BREAK SPACE") wherever it appears in a string and MUST NOT be skipped over or stripped off by a packet receiver \[MQTT-SN-1.7.4-3\].

**Informative example**

For example, the string A𪛔 which is LATIN CAPITAL Letter A followed by the code point U+2A6D4 (which represents a CJK IDEOGRAPH EXTENSION B character) is encoded as follows: 

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| byte 1 | ‘A’ (0x41) |  |  |  |  |  |  |  |
|  | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| byte 2 | (0xF0) |  |  |  |  |  |  |  |
|  | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
| byte 3 | (0xAA) |  |  |  |  |  |  |  |
|  | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 |
| byte 4 | (0x9B) |  |  |  |  |  |  |  |
|  | 1 | 0 | 0 | 1 | 1 | 0 | 1 | 1 |
| byte 5 | (0x94) |  |  |  |  |  |  |  |
|  | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 |

Table 2: Fixed Length UTF-8 Encoded String informative example

# **2 MQTT-SN Control Packet format** {#2-mqtt-sn-control-packet-format}

## **2.1 Structure of an MQTT-SN Control Packet** {#2.1-structure-of-an-mqtt-sn-control-packet}

The MQTT-SN protocol operates by exchanging a series of MQTT-SN Control Packets in a defined way. This section describes the format of these packets. 

An MQTT-SN Control Packet consists of up to two parts, always in the following order as shown below. 

| Control Packet Header, present in all MQTT-SN Control Packets |
| :---: |
| Control Packet Variable Part, present in some MQTT-SN Control Packets |

Table 3: Structure of an MQTT-SN Control Packet

### **2.1.1 Packet Header** {#2.1.1-packet-header}

Each MQTT-SN Control Packet contains a Header of format 1 or format 2 as shown below.

| Byte | Use |
| :---: | :---: |
| 1 | Length |
| 2 | MQTT-SN Control Packet Type |

Table 4: Packet Header Format 1

| Byte | Use |
| :---: | :---: |
| 1 | Length 0x01 |
| 2 | Length MSB |
| 3 | Length LSB |
| 4 | MQTT-SN Control Packet Type |

Table 5: Packet Header Format 2

### **2.1.2 Length** {#2.1.2-length}

The *Length* field is either 1-byte or 3-byte integer and specifies the total number of bytes contained in the packet (including the *Length* field itself).

If the first byte of the *Length* field is coded “0x01” then the *Length* field is 3-bytes long; in this case, the two following bytes specify the total number of bytes of the packet (most-significant byte first). Otherwise, the *Length* field is only 1-byte long and specifies itself the total number of bytes contained in the packet.

The 3-byte format allows the encoding of packet lengths up to 65,535 bytes. It is more efficient to use the shorter 1-byte format for packets with lengths up to and including 255 bytes.

A client or gateway receiving MQTT-SN control packets MUST be able to process both 1-byte and 3-byte length formats.  \[MQTT-SN-2.1.2-1\]

**Informative comment**

MQTT-SN does not support packet fragmentation and reassembly, the maximum packet length that could be used in a network is governed by the maximum packet size that is supported by that network, and not by the maximum length that could be encoded by MQTT-SN.

### **2.1.3 MQTT-SN Control Packet Type** {#2.1.3-mqtt-sn-control-packet-type}

The MQTT-SN Control Packet Type field is 1-byte long and specifies the MQTT-SN Control Packet type which is one of the values shown below.

| Name | Value | Direction of flow | Description |
| :---: | :---: | :---: | ----- |
| Reserved | 0x00 | Forbidden | Reserved |
| **ADVERTISE** | 0x01 | Gateway Multicast | Advertise the gateway presence |
| **SEARCHGW** | 0x02 | Client Multicast | Client GWINFO request |
| **GWINFO** | 0x03 | Gateway to Client | Response to a SEARCHGW |
| **AUTH** | 0x04 | Client to Gateway or Gateway to Client | Authentication handshake |
| **CONNECT** | 0x05 | Client to Gateway | Virtual Connection request |
| **CONNACK** | 0x06 | Gateway to Client | Virtual Connection acknowledgement |
| **REGISTER** | 0x0A | Client to Gateway | Request topic alias |
| **REGACK** | 0x0B | Gateway to Client | Supply topic alias |
| **PUBLISH** | 0x0C | Client to Gateway or Gateway to Client | Publish packet |
| **PUBACK** | 0x0D | Client to Gateway or Gateway to Client | Publish acknowledgment (QoS 1\) or Publish error (Any QoS). |
| **PUBCOMP** | 0x0E | Client to Gateway or Gateway to Client | Publish complete (QoS 2 delivery part 3\) |
| **PUBREC** | 0x0F | Client to Gateway or Gateway to Client | Publish received (QoS 2 delivery part 1\) |
| **PUBREL** | 0x10 | Client to Gateway or Gateway to Client | Publish release (QoS 2 delivery part 2\) |
| **PUBLISH-WITHOUT-SESSION** | 0x11 | Client to Gateway | Publish packet for out of a session messages which have no session on the gateway or broker |
| **SUBSCRIBE** | 0x12 | Client to Gateway | Subscribe request |
| **SUBACK** | 0x13 | Gateway to Client | Subscribe acknowledgment |
| **UNSUBSCRIBE** | 0x14 | Client to Gateway | Unsubscribe request |
| **UNSUBACK** | 0x15 | Gateway to Client | Unsubscribe acknowledgment |
| **PINGREQ** | 0x16 | Client to Gateway | PING request |
| **PINGRESP** | 0x17 | Gateway to Client | PING response |
| **DISCONNECT** | 0x18 | Client to Gateway or Gateway to Client | Disconnect notification |
| **WAKEUP**  | 0x19 | Gateway to Client | Wake up request |
| **\- Reserved \-**  | 0x1A-0x1D | Forbidden | ReservedForbidden (Old Will Range) |
| **\- Reserved \-**  | 0x1E-0xFD | Forbidden | ReservedForbidden |
| **FORWARDER ENCAPSULATION** | 0xFE | Forwarder to Client or Forwarder to Gateway | Encapsulated MQTT-SN packet |
| **PROTECTION ENCAPSULATION** | 0xFF | Client to Gateway or Gateway to Client | A protection envelope that can encapsulate any MQTT-SN packet with the exception of Forwarder-Encapsulation packet (0xFE) |

Table 6: Packet type listing

| Name | Value | Direction of flow | Description |
| :---: | :---: | :---: | ----- |
| Reserved | 0x00 | Forbidden | Reserved |
| **CONNECT** | 0x01 |  |  |
| **CONNACK** | 0x02 |  |  |
| **PUBLISH** | 0x03 |  |  |
| **PUBACK** | 0x04 |  |  |
| **PUBREC** | 0x05 |  |  |
| **PUBREL** | 0x06 |  |  |
| **PUBCOMP** | 0x07 |  |  |
| **SUBSCRIBE** | 0x08 |  |  |
| **SUBACK** | 0x09 |  |  |
| **UNSUBSCRIBE** | 0x0A |  |  |
| **UNSUBACK** | 0x0B |  |  |
| **PINGREQ** | 0x0C |  |  |
| **PINGRESP** | 0x0D |  |  |
| **DISCONNECT** | 0x0E |  |  |
| **AUTH** | 0x0F |  |  |
| **Reserved** |  |  |  |
| **REGISTER** |  |  |  |
| **REGACK** |  |  |  |
| **PUBLISHWOS** |  |  |  |
| **ADVERTISE** |  |  |  |
| **SEARCHGW** |  |  |  |
| **GWINFO** |  |  |  |
| **FORWARDER ENCAPSULATION** |  |  |  |
| **PROTECTION ENCAPSULATION** |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## **2.2 Packet Identifier** {#2.2-packet-identifier}

The Variable Header component of many of the MQTT-SN Control Packet types includes a Two Byte Integer Packet Identifier field. MQTT-SN Control Packets that require a Packet Identifier are shown below:

| MQTT-SN Control Packet | Packet Identifier field |
| ----- | ----- |
| CONNECT | NO |
| CONNACK | NO |
| PUBLISH | YES (If QoS \> 0\) |
| PUBWOS | NO |
| PUBACK | YES |
| PUBREC | YES |
| PUBREL | YES |
| PUBCOMP | YES |
| SUBSCRIBE | YES |
| SUBACK | YES |
| UNSUBSCRIBE | YES |
| UNSUBACK | YES |
| PINGREQ | YES |
| PINGRESP | YES |
| DISCONNECT | NO |
| AUTH | NO |
| ADVERTISE | NO |
| SEARCHGW | NO |
| GWINFO | NO |
| REGISTER | YES |
| REGACK | YES |
| FORWARDER ENCAPSULATION | NO |
| PROTECTION ENCAPSULATION | NO |

Table 8 Packets with Packet Identifier

A PUBLISH packet MUST NOT contain a Packet Identifier if its QoS value is set to 0.

Each time a Client sends a new SUBSCRIBE, UNSUBSCRIBE, or PUBLISH (where QoS \> 0\) MQTT-SN Control Packet it MUST assign it a non-zero Packet Identifier that is currently unused.

Each time a Gateway sends a new PUBLISH (with QoS \> 0\) MQTT-SN Control Packet it MUST assign it a non zero Packet Identifier that is currently unused. 

The Packet Identifier becomes available for reuse after the sender has processed the corresponding acknowledgement packet, defined as follows. In the case of a QoS 1 PUBLISH, this is the corresponding PUBACK; in the case of QoS 2 PUBLISH it is PUBCOMP or a PUBREC with a Reason Code of 128 or greater. For SUBSCRIBE or UNSUBSCRIBE it is the corresponding SUBACK or UNSUBACK. 

Packet Identifiers used with PUBLISH, SUBSCRIBE and UNSUBSCRIBE packets form a single, unified set of identifiers separately for the Client and the Gateway in a Session. A Packet Identifier cannot be used by more than one command at any time.

A PUBACK, PUBREC , PUBREL, or PUBCOMP packet MUST contain the same Packet Identifier as the PUBLISH packet that was originally sent. A SUBACK and UNSUBACK MUST contain the Packet Identifier that was used in the corresponding SUBSCRIBE and UNSUBSCRIBE packet respectively.

The Client and Gateway assign Packet Identifiers independently of each other. As a result, Client-Server pairs can participate in concurrent Packet exchanges using the same Packet Identifiers. 

**Informative comment**

It is possible for a Client to send a PUBLISH packet with Packet Identifier 0x1234 and then receive a different PUBLISH packet with Packet Identifier 0x1234 from its Server before it receives a PUBACK for the PUBLISH packet that it sent.

![][image1]

## **2.3 MQTT-SN Packet Fields** {#2.3-mqtt-sn-packet-fields}

### **2.3.1 Protocol VersionId** {#2.3.1-protocol-versionid}

The *Protocol VersionId* is 1-byte long. It is only present in a CONNECT packet and corresponds to the MQTT ‘protocol name’ and ‘protocol version’.

It is coded 0x02. 0x01 was used for MQTT-SN 1.2.  All other values are reserved.

### **2.3.2 Radius** {#2.3.2-radius}

The *Radius* field is 1-byte long and indicates the value of the transmission radius. The value 0x00 means “send to all nodes in the network”.

### **2.3.3 Reason Code** {#2.3.3-reason-code}

A Reason Code is a one-byte unsigned value that indicates the result of an operation. Reason Codes share a common set of values across the various Control Packet types. Reason Code values of 0x80 or greater indicate failure.

Each value and meaning of each *Reason Code* field is shown below.

| Identifier |  | Name | Packets  | Description  |
| ----- | ----- | ----- | ----- | ----- |
| Dec | Hex |  |  |  |
| 0 | 0x00 | Success | CONNACK, SUBACK, UNSUBACK, REGACK, PUBACK, PUBREC, PUBREL, PUBCOMP,  AUTH (server only) | The operation was successful. |
| 0 | 0x00 | Normal disconnection | DISCONNECT | Delete the Virtual Connection normally. Do not send the Will Message. |
| 0 | 0x00 | Granted QoS 0 | SUBACK | The subscription is accepted and the maximum QoS sent will be QoS 0\. This might be a lower QoS than was requested. |
| 1 | 0x01 | Granted QoS 1 | SUBACK | The subscription is accepted and the maximum QoS sent will be QoS 1\. This might be a lower QoS than was requested. |
| 2 | 0x02 | Granted QoS 2 | SUBACK | The subscription is accepted and any received QoS will be sent to this subscription. |
| 4 | 0x04 | Disconnect with will message | DISCONNECT (client only) | The Client wishes to disconnect but requires that the Server also publishes its Will Message.  |
| 16 | 0x10 | No matching subscribers | PUBACK, PUBREC | The Application Message is accepted but there are no subscribers. If the Server knows that there are no matching subscribers, it MAY use this Reason Code instead of 0x00 (Success). |
| 17 | 0x11 | No subscription existed | UNSUBACK | No matching Topic Filter is being used by the Client. |
| 24 | 0x18 | Continue authentication | AUTH | Continue the authentication with another step. |
| 25 | 0x19 | Re-authenticate | AUTH (client only) | Initiate a re-authentication. |
| 128 | 0x80 | Unspecified error | CONNACK, PUBACK, PUBREC, SUBACK, UNSUBACK, DISCONNECT | The receiver does not accept the request but either does not want to reveal the reason, or it does not match one of the other values. |
| 129 | 0x81 | Malformed packet | CONNACK, DISCONNECT | The received packet does not conform to this specification. |
| 130 | 0x82 | Protocol error | CONNACK, DISCONNECT | An unexpected or out of order packet was received. |
| 131 | 0x83 | Implementation specific error | CONNACK, PUBACK, PUBREC, REGACK, SUBACK, UNSUBACK, DISCONNECT | The packet received is valid but cannot be processed by this implementation. |
| 132 | 0x84 | Unsupported Protocol Version | CONNACK | The Server does not support the version of the MQTT or MQTT-SN  protocol requested by the Client. |
| 133 | 0x85 | Client identifier not valid | CONNACK | The Client Identifier is a valid string but is not allowed by the Server. |
| 134 | 0x86 | Bad user name or password | CONNACK | The Server does not accept the User Name or Password specified by the Client  |
| 135 | 0x87 | Not authorized | CONNACK, PUBACK, PUBREC, REGACK, SUBACK, UNSUBACK, DISCONNECT (server only) | The request is not authorized. |
| 136 | 0x88 | Server unavailable | CONNACK | The MQTT Server is not available. |
| 137 | 0x89 | Server busy | CONNACK, DISCONNECT (server only) | The Server is busy and cannot continue processing requests from this Client. |
| 138 | 0x8A | Banned | CONNACK | This Client has been banned by administrative action. Contact the server administrator. |
| 139 | 0x8B | Server shutting down | DISCONNECT (server only) | The Server is shutting down.  |
| 140 | 0x8C | Bad authentication method | CONNACK, DISCONNECT | The authentication method is not supported or does not match the authentication method currently in use. |
| 141 | 0x8D | Keep alive timeout | DISCONNECT (server only) | The Connection is closed because no packet has been received for 1.5 times the Keepalive time. |
| 142 | 0x8E | Session taken over | DISCONNECT (server only) | Another Connection using the same ClientID has connected causing this Connection to be closed. |
| 143 | 0x8F | Topic filter invalid | SUBACK, UNSUBACK, DISCONNECT (server only) | The Topic Filter is correctly formed, but is not accepted by this Server. |
| 144 | 0x90 | Topic name invalid | CONNACK, PUBACK, PUBREC, DISCONNECT (server only) | The Topic Name is correctly formed, but is not accepted by this Client or Server. |
| 145 | 0x91 | Packet identifier in use | PUBACK, PUBREC, SUBACK, UNSUBACK | The specified Packet Identifier is already in use. |
| 146 | 0x92 | Packet identifier not found | PUBREL, PUBCOMP | The Packet Identifier is not known. This is not an error during recovery, but at other times indicates a mismatch between the Session State on the Client and Server.  |
| 147 | 0x93 | Receive maximum exceeded | DISCONNECT | The Client or Server has received more than Receive Maximum publication for which it has not sent PUBACK or PUBCOMP.  |
| 148 | 0x94 | Topic alias invalid | DISCONNECT (server only) | The Client or Server has received a PUBLISH packet containing a Topic Alias which is greater than the Maximum Topic Alias it sent in the CONNECT or CONNACK packet.  (Transparent gateway only) |
| 149 | 0x95 | Packet too large | CONNACK, DISCONNECT | The packet size is greater than Maximum Packet Size for this Client or Server. |
| 150 | 0x96 | Packet rate too high | DISCONNECT | The received data rate is too high. |
| 151 | 0x97 | Quota exceeded | REGACK, SUBACK, DISCONNECT | An implementation or administrative imposed limit has been exceeded. |
| 152 | 0x98 | Administrative action | DISCONNECT | The Virtual Connection is deleted due to an administrative action. |
| 153 | 0x99 | Payload format invalid | PUBACK, PUBREC, DISCONNECT (server only) | The MQTT payload format does not match the one specified by the Payload Format Indicator. (Transparent gateway only) |
| 154 | 0x9A | Retain not supported | CONNACK, DISCONNECT (server only) | The MQTT Server does not support retained messages. (Transparent gateway only) |
| 155 | 0x9B | QoS not supported | CONNACK, DISCONNECT (server only) | The Client specified a QoS greater than the QoS specified in a Maximum QoS in the MQTT CONNACK. (Transparent gateway only) |
| 156 | 0x9C | Use another server | CONNACK, DISCONNECT (server only) | The Client should temporarily change its Server. |
| 157 | 0x9D | Server moved | CONNACK, DISCONNECT (server only) | The Server is moved and the Client should permanently change its server location. |
| 158 | 0x9E | Shared subscription not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Shared Subscriptions. (Transparent gateway only) |
| 159 | 0x9F | Connection rate exceeded | CONNACK, DISCONNECT (server only) | This Virtual Connection is deleted because the connection rate is too high. |
| 160 | 0xAD | Maximum connect time | DISCONNECT (server only) | The maximum connection time authorized for this Virtual Connection has been exceeded. |
| 161 | 0xA1 | Subscription identifiers not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Subscription Identifiers; the subscription is not accepted. (Transparent gateway only) |
| 162 | 0xA2 | Wildcard subscription not supported | SUBACK, DISCONNECT (server only) | The MQTT Server does not support Wildcard Subscriptions; the subscription is not accepted. (Transparent gateway only) |
| 230 | 0xE6 | Only PROTECTION packet supported (Note 1\) | Any packet except PROTECTION and Forwarder Encapsulation | Specific to MQTT-SN |
| 231 | 0xE7 | Protection scheme invalid | DISCONNECT | Specific to MQTT-SN |
| 232 | 0xE8 | Unknown Sender Id | DISCONNECT | Specific to MQTT-SN |
| 240 | 0xF0 | Unknown Topic Alias | PUBACK, SUBACK | Specific to MQTT-SN |
| 241 | 0xF1 | Congestion | SUBACK, REGACK, CONNACK, PUBACK | Specific to MQTT-SN |
| 242 | 0xF2 | Protection packet not supported | DISCONNECT | Specific to MQTT-SN |
| 243 | 0xF3 | Forwarder Encapsulation not supported | DISCONNECT | Specific to MQTT-SN |
| 244 | 0xF4 | Unknown topic alias | SUBACK, UNSUBACK, PUBACK, REGACK | Specific to MQTT-SN |
| 245-255 | 0xF5-0xFF | Reserved for MQTT-SN |  | Specific to MQTT-SN |

Table 9: Reason Code Values

Note(s):

1. It is used by a receiver to indicate that it expected a packet to be protected and it wasn't.  
1. The MQTT-SN dedicated range of reason codes is from 0xE6 (230) to 0xFF(255).

### **2.3.4 Topic Data** {#2.3.4-topic-data}

The *Topic Data* field is 2-byte long and contains the value of the topic alias or the short topic name. The values “0x0000” and “0xFFFF” are reserved and therefore should not be used.

### **2.3.5 Topic Name** {#2.3.5-topic-name}

The *Topic Name* field has a variable length and contains an UTF8-encoded string that specifies the topic name.

## **2.4 Topic Types** {#2.4-topic-types}

Several packets will refer to a topic type in their flags. This is a 2-bit field which determines the format of the topic value. 

The allowable values are as follows:

|  | Topic Type Value | Name | Description |
| ----- | ----- | ----- | ----- |
| 0 | 0b00 | Session Topic Alias | A session topic alias is negotiated between the gateway and client within the scope of a gateway session. |
| 1 | 0b01 | Predefined Topic Alias | A predefined alias is known statically by both the gateway and the client outside the scope of a gateway session. No negotiation is required since both entities have knowledge of the topic alias mapping. |
| 2 | 0b10 | Short Topic Name | A 2-byte topic name which requires no negotiation. |
| 3 | 0b11 | Long Topic Name | A full topic, which requires no session negotiation. |

Table 10: Topic types and their description

Refer to [section 4](\#4-operational-behavior) for detailed descriptions of topic names and aliases.

# **3 MQTT-SN Control Packets** {#3-mqtt-sn-control-packets}

## **3.1 Format of Individual Packets** {#3.1-format-of-individual-packets}

This section specifies the format of the individual MQTT-SN packets.

### **3.1.1 ADVERTISE \- Gateway Advertisement** {#3.1.1-advertise---gateway-advertisement}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | GwId |  |  |  |  |  |  |  |
| Byte 4 | Duration MSB |  |  |  |  |  |  |  |
| Byte 5 | Duration LSB |  |  |  |  |  |  |  |

Table 11:  ADVERTISE Packet

The ADVERTISE packet is sent periodically by the gateway to advertise its presence. The time interval until the next transmission is indicated by the *Duration* field.

**Informative comment**

If the Transport Layer supports multicast, like UDP/IP, the ADVERTISE packet is generally sent using the Multicast Address as destination.

#### **3.1.1.1 Length & Packet Type** {#3.1.1.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.1.2 GwId** {#3.1.1.2-gwid}

The *GwId* field is at least 1-byte identifier and uniquely identifies a gateway which is advertising itself in the network.

The MQTT-SN protocol itself doesn’t guarantee the uniqueness of the *GwId* field.

**Informative comment**

If the Gateway has a MAC address, it can be used as *GwId*. 

#### **3.1.1.3 Duration** {#3.1.1.3-duration}

The *Duration* field is a 2-byte integer. It specifies the time interval in seconds until the next ADVERTISE packet is transmitted by this gateway period. 

The maximum value that can be encoded is approximately 18 hours.

### **3.1.2 SEARCHGW \- Search for A Gateway** {#3.1.2-searchgw---search-for-a-gateway}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Radius |  |  |  |  |  |  |  |

Table 12:  SEARCHGW packet

The SEARCHGW packet is sent by a client when it searches for a Gateway. The transmission radius of the SEARCHGW is limited and depends on the density of the clients deployment, e.g. only 1-hop transmission in case of a very dense network in which every MQTT-SN client is reachable from each other within 1-hop transmission.

**Informative comment**

If the Transport Layer supports multicast, like UDP/IP, the SEARCHGW packet is generally sent using the Multicast Address as destination..

#### **3.1.2.1 Length & Packet Type** {#3.1.2.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.2.2 Radius** {#3.1.2.2-radius}

The transmission radius is also indicated to the underlying network layer when MQTT-SN gives this packet for transmission.

A Client or a Gateway MUST NOT forward the SEARCHGW received if the Radius value is 0\.

If a Client or a Gateway forwards the SEARCHGW received, it MUST reduce the Radius value by 1\.

### **3.1.3 GWINFO \- Gateway Information** {#3.1.3-gwinfo---gateway-information}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | GwId |  |  |  |  |  |  |  |
| Byte 4 … N | GwAddress *(optional)* |  |  |  |  |  |  |  |

Table 13:  GWINFO packet

The GWINFO packet is sent as response to a SEARCHGW packet with the radius as indicated in the SEARCHGW packet. If sent by a Gateway, it contains only the id of the sending Gateway; otherwise, if sent by a client, it also includes the address of the Gateway.

**Informative comment**

If the Transport Layer supports multicast, like UDP/IP, the GWINFO packet is generally sent using the Multicast Address as destination.

#### **3.1.3.1 Length & Packet Type** {#3.1.3.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.3.2 GwId** {#3.1.3.2-gwid}

The *GwId* field is 1-byte long and uniquely identifies a Gateway in the network.

#### **3.1.3.3 GwAdd** {#3.1.3.3-gwadd}

The *GwAdd* field has a variable length and contains the address of a Gateway. Its length depends on the type of network over which MQTT-SN operates and is specified by the Length byte.  Optional, only included if the packet is sent by a client.

### **3.1.4 CONNECT \- Connection Request** {#3.1.4-connect---connection-request}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  | 2 | 1 |  | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***CONNECT FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  | Default Awake Messages |  |  |  |  |  | Auth |  | Will |  | Clean Start |
| Byte 3 | *0* |  | *X* | *X* | *X* |  |  | *X* | *X* |  | *X* |  | *X* |
|  | ***WILL FLAGS (OPTIONAL \- ONLY WHEN WILL FLAG SET)*** |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  |  |  |  | Will Retain | Will QoS |  |  |  | Will Topic Type |  |  |
| Byte (3 \+ 1\) | *0* | *0* | *0* |  | *X* |  | *X* |  | *X* |  | *X* |  | *X* |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Protocol Version |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | Keep Alive MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 8 | Keep Alive LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 9 | Session Expiry Interval MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 10 | Session Expiry Interval |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 11 | Session Expiry Interval |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 12 | Session Expiry Interval LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 13 | Max Packet Size MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 14 | Max Packet Size LSB |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***WILL DATA (OPTIONAL \- ONLY WHEN WILL FLAG SET)*** |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 1\) | Will Topic Data MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 2\) | Will Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 3\) | Will Payload Length MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 4\) | Will Payload Length LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ N) | Will Payload Or (Will Topic Name \+ Will Payload) |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***AUTH DATA (OPTIONAL \- ONLY WHEN AUTH FLAG SET)*** |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 1\) | Auth Method Length |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 2\) | Auth Method |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 3\) | Auth Data Length MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 4\) | Auth Data Length LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (14 \+ 5\) | Auth Data |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 15 … N | Client Identifier |  |  |  |  |  |  |  |  |  |  |  |  |

Table 14:  CONNECT packet

The CONNECT packet is sent from the Client to the Gateway to create a Virtual Connection able to create or continue a Session. 

#### **3.1.4.1 Length & Packet Type** {#3.1.4.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.4.2 Connect Flags** {#3.1.4.2-connect-flags}

The Connect Flags is 1 byte field which contains several parameters specifying the behavior of the MQTT-SN Virtual Connection. 

The Connect *Flags* field includes the following flags:

* **Clean Start:** Stored in Bit 0 and specifies whether the Virtual Connection starts a new Session or is a continuation of an existing Session  
* **Will**: Stored in Bit 1 and if set to 1 it indicates that the Will Flags and the Will Data sections are present   
* **Auth**: Stored in Bit 2 and indicates if the packet contains authentication data  
* **Default Awake Messages**: A value between 0-15 to indicate the maximum number of messages a client shall receive during an AWAKE session. Specifying 0 will mean it is up to the gateway to determine how many messages it will send, which may be unbounded.

The Gateway MUST validate that the reserved flags in the CONNECT packet are set to 0\. If any of the reserved flags is not 0 it is a Malformed Packet.

#### **3.1.4.3 Packet Identifier** {#3.1.4.3-packet-identifier}

Used to identify the corresponding CONNACK packet. It should ideally be populated with a random integer value.

#### **3.1.4.4 Protocol Version** {#3.1.4.4-protocol-version}

The one-byte unsigned value that represents the revision level of the protocol used by the Client. 

| Protocol Version | Value |
| ----- | :---: |
| Version 1.2 | 0x01 |
| **Version 2.0** | **0x02** |
| Reserved for future versions | 0x03 – 0xFF |

Table 15: Protocol version values

The value of the Protocol Version field for MQTT-SN version 2.0 MUST be 2 (0x02).

A Gateway which supports multiple versions of the MQTT-SN protocol uses the Protocol Version to determine which version of MQTT-SN the Client is using. If the Protocol Version is not 2 and the Gateway does not want to accept the CONNECT packet, the Server MAY send a CONNACK packet with Reason Code 0x84 (Unsupported Protocol Version).

#### **3.1.4.5 Keep Alive Timer** {#3.1.4.5-keep-alive-timer}

The Keep Alive is a Two Byte Integer greater than 0 (1 \- 65,535), which is a time interval measured in seconds. It is the maximum time interval that is permitted to elapse between the point at which the Client finishes transmitting one MQTT-SN Control Packet and the point it starts sending the next. It is the responsibility of the Client to ensure that the interval between MQTT-SN Control Packets being sent does not exceed the Keep Alive value. In the absence of sending any other MQTT-SN Control Packets, the Client MUST send a PINGREQ packet.

**Informative comment**

The Client can send PINGREQ at any time, irrespective of the Keep Alive value, and check for a corresponding PINGRESP to determine that the network and the Gateway are available.

If the Gateway does not receive an MQTT-SN Control Packet from the Client within one and a half times the Keep Alive time period, it MUST consider the session ‘LOST’ (see state description in table 3.6).

If a Client does not receive a PINGRESP packet within a *Tretry* amount of time after it has sent a PINGREQ, it SHOULD retry the transmission according to [section 4.24](\#4.4.1-unacknowledged-packets) up to the maximum number of attempts. If a PINGRESP is still not received it MUST close the Session to the Gateway by way of a DISCONNECT, with the understanding that the GW may no longer be reachable.

A Keep Alive must have a value greater than 0\. It is considered a protocol error If a Keep Alive value of 0 is set.

**Informative comment**  
The Gateway may have other reasons to disconnect the Client, for instance because it is shutting down. Setting Keep Alive does not guarantee that the Client will remain connected.

**Informative comment**

The actual value of the Keep Alive is application specific; typically, this is a few minutes. The maximum value of 65,535 is 18 hours 12 minutes and 15 seconds.

#### **3.1.4.6 Session Expiry Interval** {#3.1.4.6-session-expiry-interval}

The Session Expiry Interval is a four-byte integer time interval measured in seconds. If the Session Expiry Interval is set to 0, the Session ends (and state deleted) when a (non SLEEPING) DISCONNECT packet is sent from either the client or gateway. 

If the Session Expiry Interval is 0xFFFFFFFF (UINT\_MAX), the Session does not expire. 

The Client and Gateway MUST store the Session State after a DISCONNECT is issued if the Session Expiry Interval is greater than 0\.

**Informative comment**

The clock in the Client or Gateway may not be running for part of the time interval, for instance because the Client or Gateway are not running. This might cause the deletion of the state to be delayed.

**Informative comment**

The client and gateway between them should negotiate a reasonable and practical session expiry interval according to the network and infrastructure environment in which they are deployed. For example, it would not be practical to set a session – expiry – interval of many months on a gateway whose hardware is only capable of storing a few client sessions.

#### **3.1.4.7 Maximum Packet Size** {#3.1.4.7-maximum-packet-size}

A Two Byte (16-bit) Integer representing the Maximum Packet Size the Client is willing to accept. If the Maximum Packet Size is set to 0, no limit on the packet size is imposed beyond the limitations in the protocol as a result of the remaining length encoding and the protocol header sizes.

**Informative comment**

It is the responsibility of the application to select a suitable Maximum Packet Size value if it chooses to restrict the Maximum Packet Size.

The packet size is the total number of bytes in an MQTT-SN Control Packet, as defined in [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet). The Client uses the Maximum Packet Size to inform the Server that it will not process packets exceeding this limit.

 The Gateway MUST NOT send packets exceeding Maximum Packet Size to the Client. If a Client receives a packet whose size exceeds this limit, this is a Protocol Error, the Client uses DISCONNECT with Reason Code 0x95 (Packet too large).

Where a Packet is too large to send, the Gateway MUST discard it without sending it and then behave as if it had completed sending that Application Message.

**Informative comment**

Where a packet is discarded without being sent, the Gateway could take some diagnostic action including alerting the Server administrator. Such actions are outside the scope of this specification.

#### **3.1.4.8 Client Identifier (ClientID)** {#3.1.4.8-client-identifier-(clientid)}

The Client Identifier (ClientID) identifies the Client to the Gateway. Each Client connecting to the Gateway has a unique ClientID. The ClientID MUST be used by Clients and by Gateway to identify the state that they hold relating to this MQTT-SN Session between the Client and the Gateway. 

**Informative comment**

A Client Identifier can be between 0 \- 65,521 bytes. We advise for practicality, ClientID’s are restricted to a reasonable size (less than 243 bytes to fit within a small CONNECT packet).

When the clientID is present (greater than 0 bytes), the Gateway MUST allow values which are between 1 and 23 UTF-8 encoded bytes in length, and that contain only the characters "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ”. 

The Gateway may choose to allow more than 23 bytes.

The Client Identifier MUST be a UTF-8 Encoded String. 

#### **3.1.4.9 Connect Will Flags (optional, only with *Will* flag set)**  {#3.1.4.9-connect-will-flags-(optional,-only-with-will-flag-set)}

The Connect optional *Will Flags* is 1 byte field which contains several parameters specifying the handling of the Will Message. It is present only if the Will flag in the Connect *Flags* contains the value 1\.

The Connect optional *Will Flags* field includes the following flags:

* **Will Topic Type:** This is a 2-bit field in Bit 0 and 1 which determines the format of the topic value. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.

* **Will QoS**: Stored in Bit 2 and 3, these two bits specify the QoS level to be used. The value of Will QoS can be 0 (0x00), 1 (0x01), or 2 (0x02). A value of 3 (0x03) is a Malformed Packet.

* **Will Retain**: Stored in Bit 4, this bit specifies if the Will Message is to be retained when it is published.

If the Will Flag is set to 1 this indicates that a Will Message MUST be stored on the Server and associated with the Session \[MQTT-SN-3.1.4.9-1\]. The Will Message consists of the Will Topic, and Will Payload fields in the CONNECT Packet. The Will Message MUST be published after the Virtual Connection is deleted or the Session ends, unless the Will Message has been deleted by the Server on receipt of a DISCONNECT packet with Reason Code 0x00 (Normal disconnection) \[MQTT-SN--3.1.4.9-2\].

Situations in which the Will Message is published include, but are not limited to:

* An I/O error or network failure detected by the Server.  
* The Client fails to communicate within the Keep Alive time.  
* The Server deletes the Virtual Connection because of a protocol error.

If the Will Flag is set to 1, the Will Topic, and Will Payload fields MUST be present in the Packet \[MQTT-SN-3.1.4.9-3\]. The Will Message MUST be removed from the stored Session State in the Server once it has been published or the Server has received a DISCONNECT packet with a Reason Code of 0x00 (Normal disconnection) from the Client \[MQTT-SN-3.1.4.9-4\].

The Server SHOULD publish Will Messages promptly after the Virtual Connection is deleted or the Session ends, whichever occurs first. In the case of a Server shutdown or failure, the Server MAY defer publication of Will Messages until a subsequent restart. If this happens, there might be a delay between the time the Server experienced failure and when the Will Message is published.

#### **3.1.4.10 Will Topic Short or Will Topic Length (optional, only with *Will* flag set)** {#3.1.4.10-will-topic-short-or-will-topic-length-(optional,-only-with-will-flag-set)}

In the case of Will Topic Type being b11 this field will refer to the length of data assigned to the “Will Full Topic Name”, in all other cases, this will be the value used as the Will topic alias or Will short topic name.

#### **3.1.4.11 Will Payload Length (optional, only with *Will* flag set)** {#3.1.4.11-will-payload-length-(optional,-only-with-will-flag-set)}

Contains the length of the Will Payload field.

#### **3.1.4.12 Will Payload (optional, only with *Will* flag set)** {#3.1.4.12-will-payload-(optional,-only-with-will-flag-set)}

It contains the content of the Will Message which is published after the Virtual Connection is deleted.  

In the case of Topic Type b11 the payload section will be prefixed with a “Will Full Topic Name” encoded with a UTF-8 encoded string value of length determined by the previously defined length field. Thereafter, the *Will Payload* field corresponds to the MQTT Will Payload and so it defines the Application Message Payload that is to be published to the Will Topic and this field consists of Binary Data. It has a variable length defined by the Will Payload Length fields.

#### **3.1.4.13 Authentication Method Length (optional, only with *Auth* flag set)** {#3.1.4.13-authentication-method-length-(optional,-only-with-auth-flag-set)}

Single byte value (max 0-255 bytes), representing the length of field used to specify the authentication method. Refer to [section 4.10](\#4.11-enhanced-authentication) for more information about extended authentication.

#### **3.1.4.14 Authentication Method (optional, only with *Auth* flag set)** {#3.1.4.14-authentication-method-(optional,-only-with-auth-flag-set)}

A UTF-8 Encoded String containing the name of the authentication method. Refer to [section 4.10](\#4.11-enhanced-authentication) for more information about extended authentication.

#### **3.1.4.15 Authentication Data Length (optional, only with *Auth* flag set)** {#3.1.4.15-authentication-data-length-(optional,-only-with-auth-flag-set)}

Two byte value (max 0-65535 bytes), representing the length of field used to specify the authentication data. Refer to [section 4.10](\#4.11-enhanced-authentication) for more information about extended authentication.

#### **3.1.4.16 Authentication Data (optional, only with *Auth* flag set)** {#3.1.4.16-authentication-data-(optional,-only-with-auth-flag-set)}

Binary Data containing authentication data. The contents of this data are defined by the authentication method. Refer to [section 4.10](\#4.11-enhanced-authentication) for more information about extended authentication.

#### **3.1.4.17 CONNECT Actions** {#3.1.4.17-connect-actions}

Note that a Server MAY support multiple protocols on the same network endpoint. If the Server determines that the protocol is MQTT-SN 2.0 then it validates the connection attempt as follows.

1. The Server MUST validate that the CONNECT packet matches the format described in [section 3.1.4](\#3.1.4-connect---connection-request) and MUST NOT create a Virtual Connection for this CONNECT if it does not match. \[MQTT-SN-3.1.4.17-1\] The Server MAY send a CONNACK with a Reason Code of 0x80 or greater as described in [section 4.12](\#4.12-handling-errors).  
1. The Server MAY check that the contents of the CONNECT packet meet any further restrictions and SHOULD perform authentication and authorization checks. If any of these checks fail, it MUST NOT create a Virtual Connection for this CONNECT \[MQTT-SN-3.1.4.17-2\]. It MAY send an appropriate CONNACK response with a Reason Code of 0x80 or greater as described in [section 3.1.5](\#3.1.5-connack---connect-acknowledgement) and [section 4.12](\#4.12-handling-errors).

If validation is successful, the Server performs the following steps.

1. If the ClientID represents a Client already connected to the Server, the Server sends a DISCONNECT packet to the existing Client with Reason Code of 0x8E (Session taken over) as described in [section 4.12](\#4.12-handling-errors) and MUST delete the Virtual Connection of the existing Client \[MQTT-SN-3.1.4.17-3\]. If the existing Client has a Will Message, that Will Message is published as described in section 3.1.2.5.   
1. The Server MUST perform the processing of Clean Start that is described in [section 4.16](\#4.16-clean-start) \[MQTT-SN-3.1.4.17-4\].  
1. The Server MUST acknowledge the CONNECT packet with a CONNACK packet containing a 0x00 (Success) Reason Code \[MQTT-SN-3.1.4.17-5\].  
1. Start Application Message delivery and Keep Alive monitoring.

   **Informative comment**

   It is recommended that authentication and authorization checks be performed if the Server is being used to process any form of business critical data. If these checks succeed, the Server responds by sending CONNACK with a 0x00 (Success) Reason Code. If they fail, it is suggested that the Server does not send a CONNACK at all, as this could alert a potential attacker to the presence of the MQTT-SN Server and encourage such an attacker to launch a denial of service or password-guessing attack.

Clients are allowed to send further MQTT Control Packets immediately after sending a CONNECT packet; Clients need not wait for a CONNACK packet to arrive from the Server. If the Server rejects the CONNECT, it MUST NOT process any data sent by the Client after the CONNECT packet except AUTH packets \[MQTT-3.1.4-6\].

**Informative comment**

Clients typically wait for a CONNACK packet, However, if the Client exploits its freedom to send MQTT-SN Control Packets before it receives a CONNACK, it might simplify the Client implementation as it does not have to police the connected state. The Client accepts that any data that it sends before it receives a CONNACK packet from the Server will not be processed if the Server rejects the connection.

**Informative comment**

Clients that send MQTT-SN Control Packets before they receive CONNACK will be unaware of Server information including whether any existing Session is being used.

**Informative comment**

The Server can limit reading from the Network if the Client sends too much data before authentication is complete. This is suggested as a way of avoiding denial of service attacks.

### **3.1.5 CONNACK \- Connect Acknowledgement** {#3.1.5-connack---connect-acknowledgement}

| Bit | 7 | 6 |  | 5 |  | 4 |  | 3 |  | 2 |  | 1 |  | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***CONNACK FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  |  |  |  |  |  |  |  |  |  |  | Auth | Session Present |
| Byte 3 | 0 |  | 0 |  | 0 |  | 0 |  | 0 |  | 0 |  | X | X |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Reason Code |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | Session Expiry Interval MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 8 | Session Expiry Interval |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 9 | Session Expiry Interval |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 10 | Session Expiry Interval LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***AUTH DATA (OPTIONAL \- ONLY WHEN AUTH FLAG SET)*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (10+1) | Auth Method Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (10+2) | Auth Method |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (10+3) | Auth Data Length MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (10+4) | Auth Data Length LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (10+5) | Auth Data |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 11…N | Assigned Client Identifier (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 16: CONNACK packet

The CONNACK packet is sent by the Gateway in response to a CONNECT request from a client.

#### **3.1.5.1 Length & Packet Type** {#3.1.5.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.5.2 Connack Flags** {#3.1.5.2-connack-flags}

The CONNACK FLAGS is a 1 byte field located at byte 4 which contains flags specifying the behavior of the MQTT-SN Virtual Connection on the gateway. Bits 7-2 of the CONNACK FLAGS are reserved and MUST be set to 0.

The Connack *Flags* field includes the following flags:

* **Session Present:** Stored in Bit 0 and specifies whether an existing session was present on the gateway for the given client identifier. A value of 1 indicates a session was present, a value 0 indicates no session was present.

  If the Gateway accepts a CONNECT with Clean Start set to 1, the Gateway MUST set Session Present to 0 in the CONNACK Packet in addition to setting a 0x00 (Success) Reason Code in the CONNACK packet. 

  If the Gateway accepts a CONNECT with Clean Start set to 0 and the Gateway has Session State for the client identifier it MUST set Session Present to 1 in the CONNACK packet, otherwise it MUST set Session Present to 0 in the CONNACK packet. In both cases it MUST set a 0x00 (Success) Reason Code in the CONNACK packet. 

  If the value of Session Present received by the Client from the Gateway  is not as expected, the Client proceeds as follows:

  If the Client does not have Session State and receives Session Present set to 1 it MUST delete the Virtual Connection. If it wishes to restart with a new Session the Client can reconnect using Clean Start set to 1\.

  If the Client does have Session State and receives Session Present set to 0 it MUST discard its Session State if it continues with the Virtual Connection.

  If a Gateway sends a CONNACK packet containing a non-zero Reason Code it MUST set Session Present to 0\.

* **Auth:** Stored in Bit 1 and specifies whether the packet contains Auth material that should be considered.

The Client MUST validate that the reserved flags in the CONNACK packet are set to 0\. If any of the reserved flags is not 0 it is a Malformed Packet.

#### **3.1.5.3 Packet Identifier** {#3.1.5.3-packet-identifier}

The same value as the Packet Identifier in the CONNECT Packet being acknowledged.

#### **3.1.5.4 Reason Code** {#3.1.5.4-reason-code}

Byte 5 in the CONNACK header contains the Connect Reason Code. The values for the Connect Reason Code field are shown in Table 9: Reason Code Values. The Server sending the CONNACK packet MUST use one of the Connect Reason Code values.

If a Server sends a CONNACK packet containing a Reason code of 128 or greater it MUST then delete the Virtual Connection.

#### **3.1.5.5 Session Expiry Interval** {#3.1.5.5-session-expiry-interval}

If the Session Expiry Interval is 0, the value of Session Expiry Interval in the CONNECT Packet is used. *The server uses this property to inform the Client that it is using a value other than that sent by the Client in the CONNECT*. 

#### **3.1.5.6 Authentication Method Length (optional, only with *Auth* flag set)** {#3.1.5.6-authentication-method-length-(optional,-only-with-auth-flag-set)}

Single byte value (max 0-255 bytes), representing the length of field used to specify the authentication method. Refer to LINKED TO AUTH for more information about extended authentication.

#### **3.1.5.7 Authentication Method (optional, only with *Auth* flag set)** {#3.1.5.7-authentication-method-(optional,-only-with-auth-flag-set)}

A UTF-8 Encoded String containing the name of the authentication method. Refer to LINKED TO AUTH for more information about extended authentication.

#### **3.1.5.8 Authentication Data Length (optional, only with *Auth* flag set)** {#3.1.5.8-authentication-data-length-(optional,-only-with-auth-flag-set)}

Two byte value (max 0-65535 bytes), representing the length of field used to specify the authentication data. Refer to LINKED TO AUTH for more information about extended authentication.

#### **3.1.5.9 Authentication Data (optional, only with *Auth* flag set)** {#3.1.5.9-authentication-data-(optional,-only-with-auth-flag-set)}

Binary Data containing authentication data. The contents of this data are defined by the authentication method and the state of already exchanged authentication data. Refer to LINKED TO AUTH for more information about extended authentication.

#### **3.1.5.10 Assigned Client Identifier** {#3.1.5.10-assigned-client-identifier}

The Client Identifier assigned by the gateway when the associated CONNECT packet contained no Client Identifier. If the Client connects using a zero length Client Identifier, the Server MUST respond with a CONNACK containing an Assigned Client Identifier. The Assigned Client Identifier MUST be a new Client Identifier not used by any other Session currently in the Gateway.

The Assigned Client Identifier MUST be a UTF-8 Encoded String.

**Informative comment**

Assigned Client Identifiers SHOULD be less than 247 bytes so they can be accommodated in a small packet version. This is also to cater for devices which may not support larger Client Identifiers.

**Informative comment**

Where a transparent gateway obtains an Assigned Client Identifier which is deemed too large for a device, it should maintain a registry to map shorter gateway generated Client Identifiers with their versions returned from the broker.

### **3.1.6 AUTH \- Authentication Exchange** {#3.1.6-auth---authentication-exchange}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| byte 1 | Length |  |  |  |  |  |  |  |
| byte 2 | Packet Type |  |  |  |  |  |  |  |
| byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| byte 5 | Auth Reason Code |  |  |  |  |  |  |  |
| byte 6 | Auth Method Length (K) |  |  |  |  |  |  |  |
| byte 7:7+K | Auth Method |  |  |  |  |  |  |  |
| byte 8+K:N | Auth Data (N) |  |  |  |  |  |  |  |

Table 22: AUTH packet

The authentication method and data is first sent by the Client as part of a CONNECT exchange. If the Server requires additional information to complete the authentication, it responds with an AUTH packet to signal that the Client generates and sends another AUTH packet with the required information and so on until the authentication is complete. The server then responds with a CONNACK message.

#### **3.1.6.1 Length & Packet Type** {#3.1.6.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.7.2 Packet Identifier** {#3.1.7.2-packet-identifier}

Used to identify the corresponding CONNECT, AUTH or CONNACK packet. It should ideally be populated with a random integer value when sent from Client to Server. When sent from Server to Client, it MUST contain the packet identifier of the CONNECT or AUTH packet being responded to.

#### **3.1.6.2 Reason Code** {#3.1.6.2-reason-code}

Byte 3 in the Auth packet holds the Authentication Reason Code. The values for the Authentication Reason Code field are shown in Table 9: Reason Code Values. The sender of the AUTH Packet MUST use one of the Authenticate Reason Codes.

#### **3.1.6.3 Auth Method Length** {#3.1.6.3-auth-method-length}

The length of the auth method string.

#### **3.1.6.4 Auth Method** {#3.1.6.4-auth-method}

A UTF-8 Encoded String containing the name of the authentication method.

#### **3.1.6.5 Auth Data** {#3.1.6.5-auth-data}

Binary Data containing authentication data. The contents of this data are defined by the authentication method.

**Informative comment**

For a simple cleartext password analogous to MQTT username and password, the SASL PLAIN method can be used.

#### **3.1.6.6 Auth Actions** {#3.1.6.6-auth-actions}

Refer to [section 4.11](\#4.11-enhanced-authentication) for more information about extended authentication.

### **3.1.7 REGISTER \- Register Topic Alias Request** {#3.1.7-register---register-topic-alias-request}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Topic Alias MSB |  |  |  |  |  |  |  |
| Byte 6 | Topic Alias LSB |  |  |  |  |  |  |  |
| Byte 7…N | Topic Name |  |  |  |  |  |  |  |

Table 24: REGISTER packet

The REGISTER packet is sent by a client to a GW for requesting a topic alias value for the included topic name. It is also sent by a GW to inform a client about the topic alias value it has assigned to the included topic name.

#### **3.1.7.1 Length & Packet Type** {#3.1.7.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.7.2 Packet Identifier** {#3.1.7.2-packet-identifier-1}

Used to identify the corresponding REGACK packet. It should ideally be populated with a random integer value. 

#### **3.1.7.3 Topic Alias** {#3.1.7.3-topic-alias}

If sent by a client, it is coded 0x0000 and is not relevant; if sent by a GW, it contains the topic alias value assigned to the topic name included in the Topic Name field.

#### **3.1.7.4 Topic Name** {#3.1.7.4-topic-name}

Fixed Length UTF-8 Encoded String Contains the fully qualified topic name.

#### **3.1.7.5 Register Actions** {#3.1.7.5-register-actions}

As described in [section 4.17](\#4.17-topic-registration).

### **3.1.8 REGACK \- Register Topic Alias Response** {#3.1.8-regack---register-topic-alias-response}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 |  | 1 |  | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |
|  | ***REGACK FLAGS*** |  |  |  |  |  |  |  |  |  |
|  | Reserved | Reserved | Reserved | Reserved | Reserved |  | Reserved | Topic Type |  |  |
| Byte 3 | 0 | 0 | 0 | 0 | 0 |  | 0 | X | X |  |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |
| Byte 6 | Topic Alias MSB |  |  |  |  |  |  |  |  |  |
| Byte 7 | Topic Alias LSB |  |  |  |  |  |  |  |  |  |
| Byte 8 | Reason Code |  |  |  |  |  |  |  |  |  |

Table 25: REGACK packet

The REGACK packet is sent by a client or by a GW as an acknowledgment to the receipt and processing of a REGISTER packet.

#### **3.1.8.1 Length & Packet Type** {#3.1.8.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.8.2 REGACK Flags** {#3.1.8.2-regack-flags}

The REGACK Flags is 1 byte field in Byte position 3 of the REGACK packet.  

The REGACK Flags field includes the following flag:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic value. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.

#### **3.1.8.3 Packet Identifier** {#3.1.8.3-packet-identifier}

The same value as the Packet Identifier in the REGISTER packet being acknowledged.

#### **3.1.8.4 Topic Alias** {#3.1.8.4-topic-alias}

A Topic Alias is an integer value that is used to identify the Topic instead of the Topic Name. This numeric value is used as the Topic Alias.

#### **3.1.8.5 Reason Code** {#3.1.8.5-reason-code}

Byte 8 in the REGACK packet holds the Register Reason Code. The values for the Register Reason Code field are shown in Table 9: Reason Code Values. The sender of the REGACK Packet MUST use one of the Register Reason Codes.

### **3.1.9 Publish Variants** {#3.1.9-publish-variants}

MQTT-SN is designed to be optimized for packet size. For this reason, the PUBLISH packet has been split into 3 variants; Variant 1 catering for PUBLISH WITHOUT SESSION where no GW session is required, Variant 2 catering for Quality of Service 0 where no response ACK is required and thus no packet identifier is required and Quality of Service 1 and 2 where a response is expected. The table below breaks down the different versions of the PUBLISH packet and their respective type identifiers.

| Packet Type | Type | Description |
| :---- | :---- | ----- |
| **Publish** | 0x0C | A PUBLISH packet corresponding to Quality of Service (QoS)  0, 1 or 2 |
| **Publish Without Session** | 0x11 | A PUBLISH Packet sent by a Client and does not need not to have an active Session |

### **3.1.10 PUBWOS \- Publish Without Session** {#3.1.10-pubwos---publish-without-session}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  |  | 2 |  | 1 | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | ----- | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type (0x11) |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***PUBWOS FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  |  |  | *Retain* |  |  | *Reserved* |  |  | *Topic Type*  |  |  |  |
| Byte 3 | *0* |  | *0* | *0* | *X* |  |  | *0* |  | *0* | *X* |  |  | *X* |
| Byte 4 | Topic Data MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (6 \+ TL) .. N | Data Or (Full Topic Name \+ Data) |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 28: PUBWOS packet

This packet is used by both clients and gateways to publish data for a certain topic.

The PUBWOS packet does not have a corresponding feature in MQTT. If forwarded to an MQTT connection, PUBWOS packets MUST have their MQTT Quality of Service level set to 0\. \[MQTT-SN-3.1.10-1\]

**Informative comment**

If the Transport Layer supports multicast, like UDP/IP, the PUBWOS packet is generally sent to a Multicast Address.

**Informative comment**

PUBWOS packets received by a Gateway are not associated with a MQTT-SN Client Session and can be optionally discarded by the Gateway without being processed for onward delivery.

#### **3.1.10.1 Length & Packet Type** {#3.1.10.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.10.2 PUBWOS Flags** {#3.1.10.2-pubwos-flags}

The PUBWOS Flags field is 1-byte located in the Byte 3 position of the PUBWOS control packet. 

The PUBWOS Flags includes the following flags:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types. **NOTE: only predefined topic alias, short topic or full topic types are allowed in PUBWOS packets.**  
* **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT. The field signifies whether the existing Retained Message for this topic is replaced or kept. For a detailed description of Retained Messages see [section 4.26](\#4.26-retained-messages).

#### **3.1.10.3 Topic Data** {#3.1.10.3-topic-data}

Contains 2 bytes of topic length (if the topic type is Full Topic Name) or the topic alias (predefined), or short topic name as indicated in the *Topic Type* field in flags. Determines the topic which this payload will be published to.

#### **3.1.10.4 Data** {#3.1.10.4-data}

In the case of Topic Alias Type b11 the data section will be prefixed with a “Full Topic Name” encoded with a UTF-8 encoded string value of length determined by the previously defined length field. Thereafter, the *Data* field corresponds to the payload of an MQTT PUBLISH packet. It has a variable length and contains the application data that is being published.

#### **3.1.12.7 PUBWOS Actions** {#3.1.12.7-pubwos-actions}

The Client or Server uses a PUBWOS packet to send an Application Message to a Network Address, for possible receipt by a Server or another Client.

If received by a Client or Server, the PUBWOS packet MUST be treated as if its QoS were 0 \[MQTT-SN-3.1.12.7-1\] as described in [section 3.1.12.7](\#3.1.12.7-publish-actions).

### **3.1.11 PUBLISH \- QoS 0** {#3.1.11-publish---qos-0}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  |  | 2 |  | 1 | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | ----- | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type (0x0C) |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***PUBLISH QoS 0 FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved*  |  | *QoS*  |  | *Retain* |  |  | *Reserved* |  | *Reserved* | *Topic Type*  |  |  |  |
| Byte 3 | *0* |  | *0* | *0* | *X* |  |  | *0* |  | *0* | *X* |  |  | *X* |
| Byte 4 | Topic Data MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (6 \+ TL) .. N | Data Or (Full Topic Name \+ Data) |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 29: PUBLISH packet

This packet is used by both clients and gateways to publish data for a certain topic. PUBLISH QoS 0, 1 & 2 packets received by a Gateway MUST be associated with a valid Client Session \[MQTT-SN-3.1.11-1\].

#### **3.1.11.1 Length & Packet Type** {#3.1.11.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.11.2 PUBLISH Flags** {#3.1.11.2-publish-flags}

The PUBLISH Flags field is 1-byte located in Byte 3 position of the PUBLISH control packet. 

The PUBLISH Flags includes the following flags:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.  
* **QoS**: This is a 2-bit field stored in Bit 5 and 6\. QoS has the same meaning as with MQTT indicating the Quality of Service. This field is set to “0b00” for QoS 0\. For a detailed description of the various Quality Of Service levels refer to [section 4.3](\#4.3-quality-of-service-levels-and-protocol-flows).  
* **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT. The field signifies whether the existing Retained Message for this topic is replaced or kept. For a detailed description of Retained Messages see [section 4.26](\#4.26-retained-messages).

#### **3.1.11.3 Topic Data** {#3.1.11.3-topic-data}

Contains 2 bytes of topic length (if the topic type is Full Topic Name) or the topic alias (predefined or normal), or short topic name as indicated in the *Topic Type* field in flags. Determines the topic which this payload will be published to.

#### **3.1.11.4 Data** {#3.1.11.4-data}

In the case of Topic Type b11 the data section will be prefixed with a “Full Topic Name” encoded with a UTF-8 encoded string value of length determined by the previously defined length field. Thereafter, the *Data* field corresponds to the payload of an MQTT PUBLISH packet. It has a variable length and contains the application data that is being published.

#### **3.1.11.5 PUBLISH \- QoS 0 Actions** {#3.1.11.5-publish---qos-0-actions}

As described in [section 3.1.12.7](\#3.1.12.7-publish-actions).

### **3.1.12 PUBLISH \- QoS 1 and 2** {#3.1.12-publish---qos-1-and-2}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  |  | 2 |  | 1 | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | ----- | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type (0x0C) |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***PUBLISH QoS 1&2 FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *DUP*  |  | *QoS*  |  | *Retain* |  |  | *Reserved* |  | *Reserved* | *Topic Type*  |  |  |  |
| Byte 3 | *X* |  | *X* | *X* | *X* |  |  | *0* |  | *0* | *X* |  |  | *X* |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Topic Data MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte (8 \+ TL) .. N | Data Or (Full Topic Name \+ Data) |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 30: PUBLISH packet

This packet is used by both clients and gateways to publish data for a certain topic.

PUBLISH QoS 0, 1 & 2 packets received by a Gateway MUST be associated with a valid Client Session \[MQTT-SN-3.1.12-1\].

#### **3.1.12.1 Length & Packet Type** {#3.1.12.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.12.2 PUBLISH Flags** {#3.1.12.2-publish-flags}

The PUBLISH Flags field is 1-byte located in Byte 3 position of the PUBLISH control packet. 

The PUBLISH Flags includes the following flags:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.  
* **QoS**: This is a 2-bit field stored in Bit 5 and 6\. QoS has the same meaning as with MQTT indicating the Quality of Service. The QoS levels are shown below:

| QoS value | Bit 6 | bit 5 | Description |
| :---: | :---: | :---: | ----- |
| 0 | 0 | 0 | At most once delivery |
| 1 | 0 | 1 | At least once delivery |
| 2 | 1 | 0 | Exactly once delivery |
| \- | 1 | 1 | Reserved – must not be used |

  Table 3‑2 \- QoS definitions

For a detailed description of the various Quality Of Service levels refer to [section 4.3](\#4.3-quality-of-service-levels-and-protocol-flows).

* **DUP**: 1 bit field stored in Bit 7 and has the same meaning as with MQTT. It notes the duplicate delivery of packets. If the DUP flag is set to “0”, it signifies that the packet is sent for the first time. If the DUP flag is set to “1”, it signifies that the packet was retransmitted or retried.   
* **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT. The field signifies whether an existing Retained Message for this topic is replaced or kept. For a detailed description of Retained Messages see [section 4.26](\#4.26-retained-messages).

#### **3.1.12.4 Packet Identifier** {#3.1.12.4-packet-identifier}

Used to identify the corresponding PUBACK packet in the case of QoS 1\. Used to identify the corresponding PUBREC, PUBREL and PUBCOMP packets in the case of QoS 2\. It should ideally be populated with a random integer value.

#### **3.1.12.5 Topic Data** {#3.1.12.5-topic-data}

Contains 2 bytes of topic length (if the topic type is Full Topic Name) or the topic alias (predefined or normal), or short topic name as indicated in the *Topic Type* field in flags. Determines the topic which this payload will be published to.

#### **3.1.12.6 Data** {#3.1.12.6-data}

The *Data* field corresponds to the payload of an MQTT PUBLISH packet. It has a variable length and contains the application data that is being published.

#### **3.1.12.7 PUBLISH Actions** {#3.1.12.7-publish-actions}

The receiver of a PUBLISH Packet MUST respond with the packet as determined by the QoS in the PUBLISH Packet. \[MQTT-SN-3.1.12.7-1\].

 Table 3‑3 Expected PUBLISH packet response

| QoS Level | Expected Response |
| ----- | ----- |
| QoS 0 | None |
| QoS 1 | PUBACK packet |
| QoS 2 | PUBREC packet |

The Client uses a PUBLISH packet to send an Application Message to the Server, for distribution to Clients with matching subscriptions.

The Server uses a PUBLISH packet to send an Application Message to each Client which has a matching subscription. The PUBLISH packet includes the Subscription Identifier carried in the SUBSCRIBE packet, if there was one. 

When Clients make subscriptions with Topic Filters that include wildcards, it is possible for a Client’s subscriptions to overlap so that a published Application Message might match multiple filters. In this case the Server MUST deliver the Application Message to the Client respecting the maximum QoS of all the matching subscriptions \[MQTT-SN-3.1.12.7-2\]. In addition, the Server MAY deliver further copies of the Application Message, one for each additional matching subscription and respecting the subscription’s QoS in each case. 

The action of the recipient when it receives a PUBLISH packet depends on the QoS level as described in [section 4.3](\#4.3-quality-of-service-levels-and-protocol-flows).

**Informative Comment**

If the Server distributes Application Messages to Clients to different protocols and levels (such as MQTT V3.1.1) which do not support features provided by this specification, some information in the Application Message can be lost, and applications which depend on this information might not work correctly.

The Client MUST NOT send more than one QoS 1 or QoS 2 PUBLISH packet for which it has not received PUBACK, PUBCOMP, or PUBREC with a Reason Code of 128 or greater from the Server \[MQTT-3.3.4-7\]. If it receives more than one QoS 1 or QoS 2 PUBLISH packets where it has not sent a PUBACK or PUBCOMP in response, the Server uses a DISCONNECT packet with Reason Code 0x93 (Receive Maximum exceeded) as described in [section 4.12](\#4.12-handling-errors) Handling errors. Refer to [section 4.9](\#4.9-flow-control) for more information about flow control.

**Informative comment**

The Client might choose to suspend the sending of QoS 0 PUBLISH packets when it suspends the sending of QoS 1 and QoS 2 PUBLISH packets. 

The Server MUST NOT send more than one QoS 1 and QoS 2 PUBLISH packet for which it has not received PUBACK, PUBCOMP, or PUBREC with a Reason Code of 128 or greater from the Client \[MQTT-3.3.4-9\]. If it receives more than one QoS 1 and QoS 2 PUBLISH packets where it has not sent a PUBACK or PUBCOMP in response, the Client uses DISCONNECT with Reason Code 0x93 (Receive Maximum exceeded) as described in [section 4.12](\#4.12-handling-errors) Handling errors. Refer to [section 4.9](\#4.9-flow-control) for more information about flow control.

**Informative comment**

The Server might choose to suspend the sending of QoS 0 PUBLISH packets when it suspends the sending of QoS 1 and QoS 2 PUBLISH packets.

### **3.1.13 PUBACK – Publish Acknowledgement** {#3.1.13-puback-–-publish-acknowledgement}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Reason Code |  |  |  |  |  |  |  |

Table 31: PUBACK packet

A PUBACK packet is the response to a PUBLISH packet with QoS 1\. It can also be sent as response to a PUBLISH packet of any QoS (*with the exception of QoS \-1, or PUBWOS*) in case of an error; the error reason is then indicated in the *Reason Code* field.

#### **3.1.13.1 Length & Packet Type** {#3.1.13.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.13.2 Packet Identifier** {#3.1.13.2-packet-identifier}

The same value as the Packet Identifier in the PUBLISH Packet being acknowledged.

#### **3.1.13.3 Reason Code** {#3.1.13.3-reason-code}

Byte 5 in the PUBACK packet holds the Reason code in response to the PUBLISH packet. The PUBACK Reason Codes are shown in Table 9: Reason Code Values. The Client or Server sending the PUBACK packet MUST use one of the PUBACK Reason Codes.

#### **3.1.13.4 PUBACK Actions** {#3.1.13.4-puback-actions}

As described in [section 4.3.3](\#4.3.3-qos-1:-at-least-once-delivery).

### **3.1.14 PUBREC (QoS 2 delivery part 1\)** {#3.1.14-pubrec-(qos-2-delivery-part-1)}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Reason Code |  |  |  |  |  |  |  |

Table 33: PUBREC packet

A PUBREC packet is the response to a PUBLISH packet with QoS 2\. It is the second packet of the QoS 2 protocol exchange.

#### **3.1.14.1 Length & Packet Type** {#3.1.14.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.14.2 Packet Identifier** {#3.1.14.2-packet-identifier}

The same value as the Packet Identifier in the PUBLISH Packet being acknowledged.

#### **3.1.14.3 Reason Code** {#3.1.14.3-reason-code}

Byte 5 in the PUBREC packet holds the Reason code in response to the PUBLISH packet. The PUBREC Reason Codes are shown in Table 9: Reason Code Values. The Client or Server sending the PUBREC packet MUST use one of the PUBREC Reason Codes.

#### **3.1.14.4 PUBREC Actions** {#3.1.14.4-pubrec-actions}

As described in [section 4.3.4](\#4.3.4-qos-2:-exactly-once-delivery).

### **3.1.15 PUBREL (QoS 2 delivery part 2\)** {#3.1.15-pubrel-(qos-2-delivery-part-2)}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Reason Code |  |  |  |  |  |  |  |

Table 34: PUBREL packet

A PUBREL packet is the response to a PUBREC packet. It is the third packet of the QoS 2 protocol exchange.

#### **3.1.15.1 Length & Packet Type** {#3.1.15.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.15.2 Packet Identifier** {#3.1.15.2-packet-identifier}

The same value as the Packet Identifier in the PUBLISH Packet being acknowledged.

#### **3.1.15.3 Reason Code** {#3.1.15.3-reason-code}

Byte 5 in the PUBREL packet holds the Reason code in response to the PUBREC packet. The PUBREL Reason Codes are shown in Table 9: Reason Code Values. The Client or Server sending the PUBREL packet MUST use one of the PUBREL Reason Codes.

#### **3.1.15.4 PUBREL Actions** {#3.1.15.4-pubrel-actions}

As described in [section 4.3.4](\#4.3.4-qos-2:-exactly-once-delivery).

### **3.1.16 PUBCOMP \- Publish Complete (QoS 2 delivery part 3\)** {#3.1.16-pubcomp---publish-complete-(qos-2-delivery-part-3)}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Reason Code |  |  |  |  |  |  |  |

Table 35: PUBCOMP packet

The PUBCOMP packet is the response to a PUBREL packet. It is the fourth and final packet of the QoS 2 protocol exchange.

#### **3.1.16.1 Length & Packet Type** {#3.1.16.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.16.2 Packet Identifier** {#3.1.16.2-packet-identifier}

The same value as the Packet Identifier in the PUBLISH Packet being acknowledged.

#### **3.1.16.3 Reason Code** {#3.1.16.3-reason-code}

Byte 5 in the PUBCOMP packet holds the Reason code in response to the PUBREL packet. The PUBCOMP Reason Codes are shown in Table 9: Reason Code Values. The Client or Server sending the PUBCOMP packet MUST use one of the PUBCOMP Reason Codes.

#### **3.1.16.4 PUBCOMP Actions** {#3.1.16.4-pubcomp-actions}

As described in [section 4.3.4](\#4.3.4-qos-2:-exactly-once-delivery).

### **3.1.17 SUBSCRIBE \- Subscribe Request** {#3.1.17-subscribe---subscribe-request}

| Bit | 7 | 6 |  | 5 |  |  | 4 | 3 |  | 2 | 1 | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***SUBSCRIBE FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *No Local*  |  | *QoS*  |  |  | *Retain as published* |  | *Retain Handling* |  |  | *Topic Type*  |  |  |
| Byte 3 | *X* |  | *X* | *X* |  | *X* |  | *X* |  | *X* | *X* |  | *X* |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Topic Data MSB |  |  |  | **OR** |  |  |  | Topic Filter Byte 6 … N |  |  |  |  |
| Byte 7 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |

Table 36: SUBSCRIBE packet

The SUBSCRIBE packet is used by a client to subscribe to a certain topic name.

#### **3.1.17.1 Length & Packet Type** {#3.1.17.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.17.2 SUBSCRIBE Flags** {#3.1.17.2-subscribe-flags}

The SUBSCRIBE Flags field is 1-byte and contains the following flags:

* **QoS**: maximum QoS. This gives the maximum QoS level at which the Server can send Application Messages to the Client. It is a Protocol Error if the Maximum QoS field has the value 3\.  
* **No Local**: if the value is 1, Application Messages MUST NOT be forwarded to a Virtual Connection with a ClientID equal to the ClientID of the publishing Virtual Connection.  
* **Retain as published**: If 1, Application Messages forwarded using this subscription keep the RETAIN flag they were published with. If 0, Application Messages forwarded using this subscription have the RETAIN flag set to 0\. Retained messages sent when the subscription is established have the RETAIN flag set to 1\.  
* **Retain handling**: This option specifies whether retained messages are sent when the subscription is established. This does not affect the sending of retained messages at any point after the subscribe. If there are no retained messages matching the Topic Filter, all these values act the same. The values are:  
  * 0: Send retained messages at the time of the subscribe  
  * 1: Send retained messages at subscribe only if the subscription does not currently exist  
  * 2: Do not send retained messages at the time the new subscription is processed.

  It is a Protocol Error to send a Retain Handling value of 3\.

* **Topic Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.

#### **3.1.17.3 Packet Identifier** {#3.1.17.3-packet-identifier}

Used to identify the corresponding SUBACK packet. It should ideally be populated with a random integer value.

#### **3.1.17.4 Topic Data or Topic Filter** {#3.1.17.4-topic-data-or-topic-filter}

Contains Fixed Length UTF-8 Encoded String topic filter, topic alias (predefined or normal), or short topic name as indicated in the *Topic Type* field in flags. Determines the topic names which this subscription is interested in.

#### **3.1.17.5 SUBSCRIBE Actions** {#3.1.17.5-subscribe-actions}

When the Server receives a SUBSCRIBE packet from a Client, the Server MUST respond with a SUBACK packet \[MQTT-SN-3.1.17.5-1\]. The SUBACK packet MUST have the same Packet Identifier as the SUBSCRIBE packet that it is acknowledging \[MQTT-SN-3.1.17.5-2\].

The Server is permitted to start sending PUBLISH packets matching the Subscription before the Server sends the SUBACK packet.

If a Server receives a SUBSCRIBE packet containing a Topic Filter that is identical to a Subscription’s Topic Filter for the current Session, then it MUST replace that existing Subscription with a new Subscription \[MQTT-SN-3.1.17.5-3\]. The Topic Filter in the new Subscription will be identical to that in the previous Subscription, although its Subscription Options could be different. If the Retain Handling option is 0, any existing retained messages matching the Topic Filter MUST be re-sent, but Application Messages MUST NOT be lost due to replacing the Subscription \[MQTT-SN-3.1.17.5-4\].

If a Server receives a Topic Filter that is not identical to any Topic Filter for the current Session, a new Subscription is created. If the Retain Handling option is not 2, all matching retained messages are sent to the Client.

The SUBACK packet sent by the Server to the Client MUST contain a Reason Code \[MQTT-SN-3.1.17.5-5\]. This Reason Code MUST either show the maximum QoS that was granted for that Subscription or indicate that the subscription failed \[MQTT-SN-3.1.17.5-6\]. The Server might grant a lower Maximum QoS than the subscriber requested. The QoS of Application Messages sent in response to a Subscription MUST be the minimum of the QoS of the originally published Application message and the Maximum QoS granted by the Server \[MQTT-SN-3.1.17.5-7\]. The server is permitted to send duplicate copies of a Application message to a subscriber in the case where the original Application message was published with QoS 1 and the maximum QoS granted was QoS 0\.

**Informative comment**  
If a subscribing Client has been granted maximum QoS 1 for a particular Topic Filter, then a QoS 0 Application Message matching the filter is delivered to the Client at QoS 0\. This means that at most one copy of the Application Message is received by the Client. On the other hand, a QoS 2 Application Message published to the same topic is downgraded by the Server to QoS 1 for delivery to the Client, so that Client might receive duplicate copies of the Application Message. 

**Informative comment**

If the subscribing Client has been granted maximum QoS 0, then an Application Message originally published as QoS 2 might get lost on the hop to the Client, but the Server should never send a duplicate of that Application Message. A QoS 1 Application Message published to the same topic might either get lost or duplicated on its transmission to that Client.

**Informative comment**

Subscribing to a Topic Filter at QoS 2 is equivalent to saying "I would like to receive Application Messages matching this filter at the QoS with which they were published". This means a publisher is responsible for determining the maximum QoS an Application Message can be delivered at, but a subscriber is able to require that the Server downgrades the QoS to one more suitable for its usage.

### **3.1.18 SUBACK \- Subscribe Acknowledgement** {#3.1.18-suback---subscribe-acknowledgement}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  | 2 | 1 |  | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***SUBACK FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved*  |  | *Reserved*  |  | *Reserved* |  |  | *Reserved* | *Reserved* |  | *Topic Type*  |  |  |
| Byte 3 | *0* |  | *0* | *0* | *0* |  |  | *0* | *0* |  | *X* |  | *X* |
| Byte 4 | Topic Data MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 8 | Reason Code |  |  |  |  |  |  |  |  |  |  |  |  |

Table 37: SUBACK packet

The SUBACK packet is sent by a gateway to a client as an acknowledgment to the receipt and processing of a SUBSCRIBE packet.

#### **3.1.18.1 Length & Packet Type** {#3.1.18.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.18.2 Flags** {#3.1.18.2-flags}

The SUBACK Flags field is 1-byte located in Byte 3 position of the SUBACK control packet. The SUBACK Flags includes the following flags:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.

#### **3.1.18.3 Topic Data** {#3.1.18.3-topic-data}

In case of “accepted” the returned Topic Datavalue that will be used as topic alias by the gateway when sending PUBLISH packets to the client (not relevant, 0x0000, in case of subscriptions to a short topic name or to a topic name which contains wildcard characters)

#### **3.1.18.4 Packet Identifier** {#3.1.18.4-packet-identifier}

The same value as the Packet Identifier in the SUBSCRIBE Packet being acknowledged.

#### **3.1.18.5 Reason Code** {#3.1.18.5-reason-code}

Byte 8 in the SUBACK packet holds the Reason code in response to the SUBSCRIBE packet. The SUBACK Reason Codes are shown in Table 9: Reason Code Values.The Server sending the SUBACK packet MUST use one of the SUBACK Reason Codes.

### **3.1.19 UNSUBSCRIBE \- Unsubscribe Request** {#3.1.19-unsubscribe---unsubscribe-request}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  |  |  | 2 | 1 | 0 |  |
| ----- | ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***UNSUBSCRIBE FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  | *Reserved* |  | *Reserved* |  |  | *Reserved* |  |  | *Reserved* | *Topic Type*  |  |  |
| Byte 3 | *0* |  | *0* | *0* | *0* |  |  | *0* |  |  | *0* | *X* |  | *X* |
| Byte 4 | Packet Identifier MSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Packet Identifier LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Topic Data MSB |  |  |  |  |  |  |  | **OR** | Topic Filter Byte 6 … N |  |  |  |  |
| Byte 7 | Topic Data LSB |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 39: UNSUBSCRIBE packet

An UNSUBSCRIBE packet is sent by the client to the GW to unsubscribe from named topics.

#### **3.1.19.1 Length & Packet Type** {#3.1.19.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.19.2 UNSUBSCRIBE Flags** {#3.1.19.2-unsubscribe-flags}

For The UNSUBSCRIBE Flags is 1 byte field in Byte position 3 of the UNSUBSCRIBE packet.  

The UNSUBSCRIBE Flags field includes the following flag:

* **Topic Type.** This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value. Refer to [Table 10](\#2.4-topic-types) for the definition of the various topic types.

#### **3.1.19.3 Packet Identifier** {#3.1.19.3-packet-identifier}

Used to identify the corresponding UNSUBACK packet. It should ideally be populated with a random integer value.

#### **3.1.19.4 Topic Data or Topic Filter** {#3.1.19.4-topic-data-or-topic-filter}

Contains Fixed Length UTF-8 Encoded String topic filter, topic alias (predefined or normal), or short topic name as indicated in the *Topic Type* field in flags. Determines the topic names which this subscription is interested in.

#### **3.1.19.4 UNSUBSCRIBE Actions** {#3.1.19.4-unsubscribe-actions}

The Topic Filter (whether it contains wildcards or not) supplied in an UNSUBSCRIBE packet MUST be compared character-by-character with the current set of Topic Filters held by the Server for the Client. If any filter matches exactly then its owning Subscription MUST be deleted \[MQTT-SN-3.1.19.4-1\], otherwise no additional processing occurs. 

When a Server receives UNSUBSCRIBE :

* It MUST stop adding any new Application Messages which match the Topic Filters, for delivery to the Client \[MQTT-SN-3.1.19.4-2\].  
* It MUST complete the delivery of any QoS 1 or QoS 2 Application Messages which match the Topic Filters and it has started to send to the Client \[MQTT-SN-3.1.19.4-3\].  
* It MAY continue to deliver any existing Application Messages buffered for delivery to the Client.

The Server MUST respond to an UNSUBSCRIBE request by sending an UNSUBACK packet \[MQTT-3.1.19.4-4\]. The UNSUBACK packet MUST have the same Packet Identifier as the UNSUBSCRIBE packet. Even where no Topic Subscriptions are deleted, the Server MUST respond with an UNSUBACK \[MQTT-3.1.19.4-5\].

### **3.1.20 UNSUBACK \- Unsubscribe Acknowledgement** {#3.1.20-unsuback---unsubscribe-acknowledgement}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Reason Code |  |  |  |  |  |  |  |

Table 40: UNSUBACK packet

An UNSUBACK packet is sent by a GW to acknowledge the receipt and processing of an UNSUBSCRIBE packet.

#### **3.1.20.1 Length & Packet Type** {#3.1.20.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.20.2 Packet Identifier** {#3.1.20.2-packet-identifier}

The same value as the Packet Identifier in the UNSUBSCRIBE packet being acknowledged.

#### **3.1.20.3 Reason Code** {#3.1.20.3-reason-code}

Byte 5 in the UNSUBACK packet holds the Reason code in response to UNSUBSCRIBE packet. The UNSUBACK Reason Codes are shown in Table 9: Reason Code Values. The server sending the UNSUBACK packet MUST use one of the UNSUBACK Reason Codes.

### **3.1.21 PINGREQ \- Ping Request** {#3.1.21-pingreq---ping-request}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5…N | Client Identifier (optional) |  |  |  |  |  |  |  |

The PINGREQ packet is an ”are you alive” packet that is sent from or received by a connected client.

#### **3.1.21.1 Length & Packet Type** {#3.1.21.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.21.2 Packet Identifier** {#3.1.21.2-packet-identifier}

Used to identify the corresponding PINGRESP packet. It should ideally be set to a random integer value.

#### **3.1.21.3 Client Identifier (optional)** {#3.1.21.3-client-identifier-(optional)}

Contains the client identifier (ClientID); this field is optional and is included by a “sleeping” client when it goes to the “awake” state and is waiting for packets sent by the server/gateway.

The Client Identifier MUST be a Fixed Length UTF-8 Encoded String \[MQTT-SN-3.1.21.3-1\].

#### **3.1.21.4 PINGREQ Actions** {#3.1.21.4-pingreq-actions}

The Server MUST send a PINGRESP packet in response to a PINGREQ packet \[MQTT-SN-3.1.21.4-1\].

The Client MAY send a PINGRESP packet in response to a PINGREQ packet \[MQTT-SN-3.1.21.4-2\]. 

### **3.1.22 PINGRESP \- Ping Response** {#3.1.22-pingresp---ping-response}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Packet Identifier MSB |  |  |  |  |  |  |  |
| Byte 4 | Packet Identifier LSB |  |  |  |  |  |  |  |
| Byte 5 | Application Messages Remaining (optional) |  |  |  |  |  |  |  |

Table 43: PINGRESP packet

A PINGRESP packet is the response to a PINGREQ packet and means ”yes I am alive”. PINGREQ packets flow in either direction, sent either by a connected client or the gateway. it has only a header and no variable part.

A PINGRESP packet is also sent by a Gateway to inform a sleeping CLient that it has no more buffered packets for that Client.

#### **3.1.22.1 Length & Packet Type** {#3.1.22.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.22.2 Packet Identifier** {#3.1.22.2-packet-identifier}

The same value as the Packet Identifier in the PINGREQ Packet being acknowledged.

#### **3.1.22.3 Application Messages Remaining** {#3.1.22.3-application-messages-remaining}

The number of Application Messages still queued for delivery at the Server when a Client is sent back to sleep. Optional – for use at the end of a client's awake period.  Values can be:

| Allowed Values | Description |
| :---: | ----- |
| 0 | No Application Messages are waiting to be delivered |
| 1 – 254 (incl.) | The number of Application Messages waiting to be delivered |
| 255 (0xFF) | An unspecified positive number of Application Messages waiting to be delivered greater than 0\. |

Table 44:  Allowed PINGRESP continuation values

### **3.1.23 DISCONNECT \- Disconnect Notification** {#3.1.23-disconnect---disconnect-notification}

| Bit | 7 | 6 |  | 5 |  | 4 |  | 3 |  | 2 |  | 1 |  | 0 |  |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***DISCONNECT FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *Reserved* |  |  |  |  |  |  |  | *Reason Code Present* |  | *Session Expiry Interval Present* |  | *Reason String Present* |  |  | *Retain Registrations* |
| Byte 3 | 0 |  | 0 |  | 0 |  | 0 |  | X |  | X |  | X |  | X |  |
| Byte 4 | Reason Code (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Session Expiry Interval MSB (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | Session Expiry Interval (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | Session Expiry Interval (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 8 | Session Expiry Interval LSB (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Bytes 9..N | Reason String (optional) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

Table 45: DISCONNECT packet

As with MQTT, the DISCONNECT packet is sent by a client to indicate that it wants to delete the Virtual connection. The gateway will acknowledge the receipt of that packet by returning a DISCONNECT to the client. A server or gateway may also send a DISCONNECT to a client, e.g. in case a gateway, due to an error, cannot map a received packet to a client. Upon receiving such a DISCONNECT packet, a client should try to create another Virtual Connection by sending a CONNECT packet to the gateway or server.

A Server MUST NOT send a DISCONNECT until after it has sent a CONNACK with Reason Code of less than 0x80 \[MQTT-SN-3.1.23-1\].

A DISCONNECT packet with a *Session Expiry Interval* field is sent by a client when it wants to go to the “asleep” state. The receipt of this packet is also acknowledged by the gateway by means of a DISCONNECT packet.

#### **3.1.23.1 Length & Packet Type** {#3.1.23.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.23.2 Disconnect Flags** {#3.1.23.2-disconnect-flags}

The Disconnect Flags is 1 byte field located at byte 3 which contains parameters specifying the behavior of the MQTT-SN sleep on the gateway. 

The Disconnect *Flags* field includes the following flags:

* **Reason Code Present:** Stored in Bit 3 Does the reason code exist on the packet  
* **Session Expiry Interval Present:** Stored in Bit 2, Does the session expiry interval field exist.  
* **Reason String Present:** Stored in Bit 1, Does the reason string field exist  
* **Retain Registrations:** Stored in Bit 0 and specifies whether registrations should be retained by the gateway during the sleep state. “0” indicates registrations should be removed during the sleeping period and renegotiated when AWAKE or ACTIVE. “1” indicates registrations should be retained during the SLEEP period, and therefore not renegotiated when AWAKE or ACTIVE.


The Gateway MUST validate that the reserved flags in the DISCONNECT packet are set to 0\. If any of the reserved flags is not 0 it is a Malformed Packet.

#### **3.1.23.3 Reason Code** {#3.1.23.3-reason-code}

The Reason Code for the DISCONNECT packet is optional. If provided, Byte 3 in the DISCONNECT control packet holds the Reason Code of the disconnection. If not provided, 0x00 (Normal disconnection) is assumed. 

The DISCONNECT Reason Codes are shown in Table 9: Reason Code Values. The Client or Server sending the DISCONNECT packet MUST use one of the DISCONNECT Reason Code values \[MQTT-SN-3.1.23.3-1\].

#### **3.1.23.4 Session Expiry Interval** {#3.1.23.4-session-expiry-interval}

The Session Expiry Interval is a four-byte integer time interval measured in seconds. If the Session Expiry Interval is set to 0 or omitted, the Session is transitioned to the “***disconnected***” state. When the value of this field is greater than zero, it is deemed to be sent by a client that wants to transition to the “***asleep***” state, see Section 3.19 for further details. At this point the keep alive timer becomes obsolete until the device issues a new CONNECT.

The Session Expiry Interval MUST NOT be sent on a DISCONNECT by the Server \[MQTT–SN-3.1.23.4-1\].

#### **3.1.23.5 Reason String** {#3.1.23.5-reason-string}

Fixed Length UTF-8 Encoded String representing a clear text description of disconnection.

#### **3.1.23.6 DISCONNECT Actions** {#3.1.23.6-disconnect-actions}

After sending a DISCONNECT packet the sender:

* MUST NOT send any more MQTT-SN Control Packets on that Virtual Connection \[MQTT-SN-3.1.23.6-1\].

After sending a DISCONNECT packet the Server:

* MUST delete the Virtual Connection \[MQTT-SN-3.1.23.6-2\].

After sending a DISCONNECT packet the Client:

* SHOULD wait for a DISCONNECT packet in response from the Server.

On receipt of DISCONNECT with a Reason Code of 0x00 (Success) the Server:

* MUST discard any Will Message associated with the current Connection without publishing it \[MQTT-SN-3.1.23.6-3\], as described in [section 3.1.4.9](\#3.1.4.9-connect-will-flags-(optional,-only-with-will-flag-set)).  
* MUST send a DISCONNECT packet in response \[MQTT-SN-3.1.23.6-4\], and SHOULD delete the Virtual Connection.

On receipt of DISCONNECT, the Client:

* SHOULD delete the Virtual Connection.

### **3.1.24 WAKEUP \- Wake up request**

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |

Table ??: WAKEUP packet

The wakeup packet is a signal sent from the gateway to a client. It is an indication from the gateway that the client should wake up. The client is not obliged to honor this request, nor may it even receive the packet. It can choose to ignore the request, or undertake one of the sequences outlined in the [4.25 Sleeping clients](\#4.25-sleeping-clients) section. The client need not respond to this packet.

#### **3.1.24.1 Length & Packet Type**

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](https://docs.google.com/document/d/1Q\_l-TOttOqktQmnupRv7Un1Y8KzULIxc/edit?pli=1\#heading=h.23ckvvd) for a detailed description.

#### **3.1.24.2 WAKEUP Actions**

The Client MAY choose to follow the AWAKE procedure in response to receiving a WAKEUP packet \[MQTT-SN-3.1.21.4-2\]. 

### **3.1.25 Forwarder Encapsulation** {#3.1.25-forwarder-encapsulation}

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |
| Byte 3 | Ctrl |  |  |  |  |  |  |  |
| Byte 4 .. N | Wireless Node Id |  |  |  |  |  |  |  |
| Byte (N \+ 1 ,,, M) | MQTT SN packet |  |  |  |  |  |  |  |

Table 53: Format of an encapsulated MQTT-SN frame

As detailed in Section 4, MQTT-SN clients can also access a gateway via a forwarder in case the gateway is not directly attached to their WSNs. The forwarder simply encapsulates the MQTT-SN Packets it receives on the wireless side and forwards them unchanged to the gateway; in the opposite direction, it decapsulates the Packets it receives from the gateway and sends them to the clients, unchanged too.

#### **3.1.25.1 Length** {#3.1.25.1-length}

1-byte long, specifies the number of bytes up to the end of the “Wireless Node Id” field (incl. the Length byte itself)

#### **3.1.25.2 Packet Type** {#3.1.25.2-packet-type}

Coded “0xFE”, see Table 6

#### **3.1.25.3 Ctrl** {#3.1.25.3-ctrl}

The Ctrl byte contains control information exchanged between the GW and the forwarder. 

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  | Reserved |  |  |  |  |  | *Radius*  |  |
|  | 0 | 0 | 0 | 0 | 0 | 0 | X | X |

Table 54: Format of the ctrl byte

#### **3.1.25.4 Radius** {#3.1.25.4-radius}

Transmission radius (only relevant in direction gateway to forwarder)

#### **3.1.25.5 Wireless Node Id** {#3.1.25.5-wireless-node-id}

Identifies the wireless node which has sent or should receive the encapsulated MQTT-SN packet. The mapping between this Id and the address of the wireless node is implemented by the forwarder, if needed.

#### **3.1.25.6 MQTT SN Packet** {#3.1.25.6-mqtt-sn-packet}

The MQTT-SN packet, encoded according to the packet type.

### **3.1.26 Protection Encapsulation** {#3.1.26-protection-encapsulation}

### 

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  | 2 | 1 |  | 0 |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type |  |  |  |  |  |  |  |  |  |  |  |
|  | *PROTECTION FLAGS* |  |  |  |  |  |  |  |  |  |  |  |
|  | *Auth Tag Length* |  |  |  |  |  |  | *Crypto Material Length* |  |  | *Monotonic Counter Length* |  |
| Byte 3 | *X* |  | *X* | *X* | *X* |  |  | *X* | *X* |  | *X* | *X* |
| Byte 4 | Protection Scheme |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 \- 12 | Sender Id |  |  |  |  |  |  |  |  |  |  |  |
| Byte 13 \- 16 | Random |  |  |  |  |  |  |  |  |  |  |  |
| Byte 17 \- P | Crypto Material (Optional) |  |  |  |  |  |  |  |  |  |  |  |
| Byte Q \- R | Monotonic Counter (Optional) |  |  |  |  |  |  |  |  |  |  |  |
| Byte S \- T | Protected MQTT-SN Packet |  |  |  |  |  |  |  |  |  |  |  |
| Byte U \- N | Authentication Tag |  |  |  |  |  |  |  |  |  |  |  |

Table 53: Format of the protection encapsulated MQTT-SN packet

Protection encapsulation provides a secure envelope for any MQTT-SN packet (with the exception of the Forward Encapsulation packet). The fields provided by the Protection Encapsulation provide a means by which the sender is identified and the packet is protected, using a number of prescribed protection schemes. 

The sender is the originator of the “Protected MQTT-SN Packet” and responsible for its protection. This responsibility MUST NOT  be delegated to a third entity like a Forwarder. 

The sender identification is required as the sender and the receiver of the protected packet must have access to the same shared key to be used directly or after derivation. The authentication of the sender and the receiver, their authorizations and the provisioning of the shared keys used to protect integrity and optionally confidentiality of the protected packet content are out of scope.

A protected packet, like any other one, can be the payload of a Forwarder Encapsulated packet.

**//TODO \- Break out the conformance aspects of this paragraph from recommendations.**

When the PROTECTION packet is handled by a gateway, it is mandatory to use it to protect all MQTT-SN packets exchanged with a Client for which a shared key (indexed by its Sender Id) is available.

If the client is not enrolled to the gateway (so the gateway has no access to a key shared with it on the basis of its Sender Id) and the Client and gateway are not in a private network, it is recommended for the gateway to process only MQTT-SN packets received over a DTLS session initiated with mutual authentication by the client.

When the PROTECTION packet is handled by a Client, it is mandatory to use it to protect all MQTT-SN packets exchanged with a GW for which a shared key (indexed by its GwId) is available.

If the GW is not enrolled to the Client (so the Client has no access to a key shared with it on the basis of its GwId) and the Client and GW are not in a private network, it is recommended for the Client to open a DTLS session and process only MQTT-SN packets received over it.

#### **3.1.26.1 Length** {#3.1.26.1-length}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **3.1.26.2 Packet Type** {#3.1.26.2-packet-type}

Coded “0x1E”, see Table 63

#### **3.1.26.3 Protection Flags** {#3.1.26.3-protection-flags}

The PROTECTION Flags is 1 byte field in Byte position 3 of the packet, specifying the properties of the PROTECTION. 

The PROTECTION Flags field includes the following flags:

* **(Auth)entication tag length \-** (4 bits) should represent the number of 16 bits groups forming the authentication tag in big-endian order.

  * Only 14 of the 16 possible values are allowed:  
    * If 0x00, the authentication tag length is provider defined  
    * the values from 0x1 to 0x2 are Reserved;  
    * any other value 0xZ, so between 0x3 and 0xF, is allowed and the authentication tag length will be (0xZ+1)\*16 bits; for example  
      * if the value is 0xF, the Authentication tag length will be (0xF+1)\*16=256 bits;  
      * if the value is 0x3, the Authentication tag length will be (0x3+1)\*16=64 bits;  
  * If a truncation of the output of the authentication algorithm is required, it has to be taken in most significant bits first order (leftmost bits).  
  * If an extension of the output of the authentication algorithm is required, 0s are appended until the Authentication tag length is reached.  
  * Some values are not allowed for some protection schemes. For instance the values 0x03, 0x04, 0x05, 0x06 are not allowed for AES-CCM-128-128, AES-CCM-128-192, AES-CCM-128-256, AES-GCM-128-128, AES-GCM-128-192, AES-GCM-128-256 and ChaCha20/Poly1305 as for those protection schemes the 128-bit authentication tag can’t be truncated.

* **Crypto material length \-** (2 bits) should represent the number of 16 bits groups forming the crypto material in big-endian order. Below the meaning of each possible value:  
  * if 0x3, a crypto material field of 96 bits (12 bytes) is present  
  * if 0x2, a crypto material field of 32 bits (4 bytes) is present  
  * if 0x1, a crypto material field of 16 bits (2 bytes) is present  
  * if 0x0, the crypto material field is not present.

* **Monotonic counter length \-** (2 bits) should represent the number of bytes forming the monotonic counter in big-endian order. Only 3 of the 4 possible values are allowed:  
  * the value 0x3 is Reserved;  
  * if 0x2, a monotonic counter field of 32 bits (4 bytes) is present;  
  * if 0x1, a monotonic counter field of 16 bits (2 bytes) is present;  
  * if 0x0, the monotonic counter field is not present.

#### **3.1.26.4 Protection Scheme** {#3.1.26.4-protection-scheme}

A (1 byte) field located at byte 4 should contain one of the not Reserved indexes in the following table. In general two types of protection scheme are considered: **Authentication only** (like HMAC or CMAC) and **AEAD** (Authenticated Encryption with Associated Data, like GCM, CCM or ChaCha20/Poly1305).

| Index | Name | Auth Only | Key size | Tag size |
| :---- | :---- | :---- | :---- | :---- |
| 0x00 | HMAC-SHA256 (Note 1\) | Yes | Any size (Note 2\) | 256 bits |
| 0x01 | HMAC-SHA3\_256 (Note 1\) | Yes | Any size (Note 2\) | 256 bits |
| 0x02 | CMAC-128 (Note 3\) | Yes | 128 bits | 128 bits |
| 0x03 | CMAC-192 (Note 3\) | Yes | 192 bits | 128 bits |
| 0x04 | CMAC-256 (Note 3\) | Yes | 256 bits | 128 bits |
| 0x05-0x3B | RESERVED |   |  |  |
| 0x3C-0x3F | Provider defined | Yes | Provider defined | Provider defined |
| 0x40 | AES-CCM-64-128 (Notes 4,5) | No | 128 bits | 64 bits |
| 0x41 | AES-CCM-64-192 (Notes 4,5) | No | 192 bits | 64 bits |
| 0x42 | AES-CCM-64-256 (Notes 4,5) | No | 256 bits | 64 bits |
| 0x43 | AES-CCM-128-128 (Notes 4,5) | No | 128 bits | 128 bits |
| 0x44 | AES-CCM-128-192 (Notes 4,5) | No | 192 bits | 128 bits |
| 0x45 | AES-CCM-128-256 (Notes 4,5) | No | 256 bits | 128 bits |
| 0x46 | AES-GCM-128-128 (Notes 6,7) | No | 128 bits | 128 bits |
| 0x47 | AES-GCM-128-192 (Notes 6,7) | No | 192 bits | 128 bits |
| 0x48 | AES-GCM-128-256 (Notes 6,7) | No | 256 bits | 128 bits |
| 0x49 | ChaCha20/Poly1305 (Notes 8,9) | No | 256 bits | 128 bits |
| 0x4A-0xEF | RESERVED |   |  |  |
| 0xF0-0xFF | Provider defined | No | Provider defined | Provider defined |

**Note(s):**

1. Reference [https://www.rfc-editor.org/rfc/rfc2104](https://www.rfc-editor.org/rfc/rfc2104)  
1. Reference [https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.198-1.pdf](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.198-1.pdf)  
1. Reference [https://www.rfc-editor.org/rfc/rfc4493](https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.rfc-editor.org%2Frfc%2Frfc4493\&data=05%7C01%7Cdavide.lenzarini%40u-blox.com%7C4c9137c28d464ec349b908db260113dd%7C80c4ffa675114bba9f03e5872a660c9b%7C0%7C0%7C638145558306431211%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C\&sdata=xugq2R3JL90RCv%2BzdnQqW7rtztg1MF6xtBAYnqa1K8s%3D\&reserved=0) and [https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-38b.pdf](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-38b.pdf) and https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Standards-and-Guidelines/documents/examples/AES\_CMAC.pdf  
1. Reference [https://www.rfc-editor.org/rfc/rfc3610](https://www.rfc-editor.org/rfc/rfc3610) and security considerations on [https://www.rfc-editor.org/rfc/rfc8152\#section-10.2.1](https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.rfc-editor.org%2Frfc%2Frfc8152%23section-10.2.1\&data=05%7C01%7Cdavide.lenzarini%40u-blox.com%7C4c9137c28d464ec349b908db260113dd%7C80c4ffa675114bba9f03e5872a660c9b%7C0%7C0%7C638145558306431211%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C\&sdata=DTxkXC3J%2B8Wj2l7qn6U5cFUExdZVFXPv2Ss3M2%2B1VLY%3D\&reserved=0)  
1. AES CCM requires a 13 bytes nonce as indicated in https://www.rfc-editor.org/rfc/rfc8152\#section-10.2 and the nonce is obtained by performing SHA256, truncated to the leftmost 104 bits, of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)  
1. Reference https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf and security considerations on https://www.rfc-editor.org/rfc/rfc8152\#section-10.1.1  
1. AES GCM requires a 12 bytes IV as indicated in https://www.rfc-editor.org/rfc/rfc8152\#section-10.1 and the IV is obtained by performing SHA256, truncated to the leftmost 96 bits, of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)  
1. Reference: https://www.rfc-editor.org/rfc/rfc7539 and security considerations on https://www.rfc-editor.org/rfc/rfc8152\#section-10.3.1  
1. ChaCha20/Poly1305 requires a 12 bytes nonce as indicated in https://www.rfc-editor.org/rfc/rfc8152\#section-10.3 obtained by performing SHA256 truncated to 96 bit of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)

#### **3.1.26.5 Sender Identifier** {#3.1.26.5-sender-identifier}

Located at Bytes 5 \- 12 the Sender Id field (8 bytes) should contain:

If the message is originated by the ***Gateway***:

* The SHA256 of the GwId truncated to the leftmost 64 bits (8 bytes);   
    
  If the message is originated by the ***Client***:  
* **If a session is available**: the SHA256 of the \[Client Identifier\] truncated to the leftmost 64 bits (8 bytes);  
* **If a session is not available**: a unique value per sender over 8 bytes (like a MAC address, or other identifying characteristics). The methods to guarantee the uniqueness of the Sender Id in this case are out of scope for this technical proposal.

* **Informative comment**

  *8 bytes for the “Sender Id” field seems enough as it is calculated with a cryptographic hash, so the probability of collision is 1/2^64=5.42x10\-20.* 

  ***Client Behavior***

  *In order to create a whitelist of authorized senders, the Client should store a map of GwId* and SHA256(GwId) *truncated to the leftmost 64 bits. GwId can be obtained from pre-configuration, from an ADVERTISE packet or from a GWINFO packet*.


  ***Gateway Behavior***

  *In order to create a whitelist of authorized senders, the MQTT-SN Gateway should store a map of ClientID and SHA256(ClientID) truncated to the leftmost 64 bits (8 bytes for each registered ClientID) for the clients having an active session and store a list of authorized Sender Ids for the clients not capable to establish sessions.* 

#### **3.1.26.6 Random** {#3.1.26.6-random}

**Located at Byte 13 \- 16** , the “**Random**” field (4 bytes) should contain a random number (not guessable) generated at the PROTECTION packet creation .

* **Informative comment**

  *In case of CCM, in the worst case scenario where the “Crypto Material” and the “Monotonic Counter” optional fields are not present,  the recommended nonce on 13 bytes will be calculated as SHA256 truncated to 104 bits of the sequence Byte 1 to Byte 16 (all packet fields until Protected MQTT-SN Packet). So considering the same Sender Id, the same nonce can be generated with a probability of 1/2^32=2.33x10\-10. With a shorter Random field of 2 bytes, the same nonce would be calculated with a probability of only 1/2^16=1.53x10\-5. As CCM is a derivation of CTR (see [https://en.wikipedia.org/wiki/CCM\_mode](https://en.wikipedia.org/wiki/CCM\_mode)), the nonce should never be reused for the same key so the probability to generate two identical nonces should be kept as low as possible. Same for GCM and ChaCha20/Poly1305, the security depends on choosing a unique IV of 12 bytes for every encryption performed with the same key ([https://en.wikipedia.org/wiki/Galois/Counter\_Mode](https://en.wikipedia.org/wiki/Galois/Counter\_Mode)).*

#### **3.1.26.7 Crypto Material** {#3.1.26.7-crypto-material}

Located at Byte (17 \- P), the optional field “**Crypto Material**” contains 0, 2, 4 or 12 bytes of crypto material that when defined it can be used to derive, from a shared master secret, the same keys on the two endpoints and/or, when filled partially or totally with a random value, to further reduce the probability of IV/nonce reuse for CCM or GCM or ChaCha20/Poly1305. For instance when the Crypto material length is set to 0x03, the Crypto Material field can be partially filled with a random value of 9 bytes (the remaining 3 bytes can be set to 0 if not used) in order to reach the 13 bytes used only once recommended for the nonce used by CCM or it can be partially filled with a random value of 8 bytes in order to reach the 12 bytes used only once recommended for the IV/nonce used by GCM or ChaCha20/Poly1305 .

#### **3.1.26.8 Monotonic Counter** {#3.1.26.8-monotonic-counter}

Located at Byte Byte (Q \- R), the optional field “**Monotonic Counter**” contains 0, 2 or 4 byte number that when defined, is increased by the Client or GW for every packet sent. The counters should be considered independent of session or destination. E.g. The UE will keep a counter independently from the GW.

#### **3.1.26.9 Protected MQTT-SN Packet** {#3.1.26.9-protected-mqtt-sn-packet}

Located at Byte (S \- T), the field  “**Protected MQTT-SN Packet**” contains the MQTT-SN packet that is being secured, encoded as per its packet type.  
The “Protected MQTT-SN Packet” should not be a “Forwarder-Encapsulation packet” as the shared key used directly or after derivation for the protection must belong to the originator of the content and not to a Forwarder that, in general, is not able to securely identify the originator.

#### **3.1.26.10 Authentication Tag** {#3.1.26.10-authentication-tag}

Located at Byte (U \- N), the field “**Authentication tag**” field has a length depending on the “Authentication tag length” flag and it is calculated, on the basis of the “Protection scheme” selected in Byte 4, on ALL the preceding fields.

# **4 Operational behavior** {#4-operational-behavior}

An important design point of MQTT-SN is to be as close as possible to MQTT. Therefore, all protocol semantics should remain, as far as possible, the same as those defined by MQTT.

## **4.1 Session state** {#4.1-session-state}

In order to implement QoS 1 and QoS 2 protocol flows the Client and Server need to associate state with the Client Identifier, this is referred to as the Session State. The Server also stores the subscriptions as part of the Session State.

The Session can continue across a sequence of Virtual Connections. It lasts as long as the latest Virtual Connection plus the Session Expiry Interval.

The Session State in the Client consists of:

* QoS 1 and QoS 2 PUBLISH Packets which have been sent to the Server, but have not been completely acknowledged.  
* QoS 2 PUBLISH Packets which have been received from the Server, but have not been completely acknowledged.

The Session State in the Server consists of:

* The existence of a Session, even if the rest of the Session State is empty.  
* The Client’s subscriptions, including any Subscription Identifiers.  
* QoS 1 and QoS 2 PUBLISH Packets which have been sent to the Client, but have not been completely acknowledged.  
* QoS 1 and QoS 2 PUBLISH Packets pending transmission to the Client and OPTIONALLY QoS 0 PUBLISH Packets pending transmission to the Client.  
* QoS 2 PUBLISH Packets which have been received from the Client, but have not been completely acknowledged.  
* The Will Message and the Will Topic (Will data).  
* If the Session is currently not connected, the time at which the Session will end and Session State will be discarded.

Retained messages do not form part of the Session State in the Server, they are not deleted as a result of a Session ending.

### **4.1.1 Storing Session State** {#4.1.1-storing-session-state}

The Server MUST NOT discard the Session State while the Virtual Connection exists \[MQTT-SN-4.1.1-1\]. 

The Client MUST NOT discard the Session State while the Virtual Connection exists \[MQTT-SN-4.1.1-2\]. 

The Server MUST discard the Session State when the Virtual Connection is deleted and the Session Expiry Interval has passed \[MQTT-SN-4.1.1-3\].

 	**Informative comment**

The storage capabilities of Client and Server implementations will of course have limits in terms of capacity and may be subject to administrative policies. Stored Session State can be discarded as a result of an administrator action, including an automated response to defined conditions. This has the effect of terminating the Session. These actions might be prompted by resource constraints or for other operational reasons. It is possible that hardware or software failures may result in loss or corruption of Session State stored by the Client or Server. It is prudent to evaluate the storage capabilities of the Client and Server to ensure that they are sufficient.

### **4.1.2 Session Establishment** {#4.1.2-session-establishment}

As with MQTT, an MQTT-SN client needs to set up a session on the server, unless it is publishing ONLY using PUBLISH WITHOUT SESSION packets. The procedure for setting up a session with a server is illustrated in Fig. 3a and 3b. 

The CONNECT packet contains flags to communicate to the gateway that Auth interactions, or WILL interactions should take place.

![][image2]

Figure 3a: Connect procedure (without Auth flag not Will flag set or no further authentication data required)

![][image3]

Figure 3b: Connect procedure (with Auth flag set and additional authentication data required)

In case the gateway could not accept the CONNECT request (e.g. because of congestion or it does not support a feature indicated in the CONNECT packet), the gateway returns a CONNACK packet with the rejection reason.

In the case where the client provides no client identifier, the Server MUST respond with a CONNACK containing an Assigned Client Identifier. 

The Assigned Client Identifier MUST be a new Client Identifier not used by any other Session currently in the gateway.

## **4.2 Networks and Virtual Connections** {#4.2-networks-and-virtual-connections}

The MQTT-SN protocol requires an Underlying Network to create a Virtual Connection. This carries Packets from a Client to a Gateway and a Gateway to a Client. The Underlying Network may also multicast Packets from a Client to more than one Gateway, and from a Gateway to more than one Client.

MQTT-SN Packets which are received must be unaltered and complete.

* The underlying transport does not need to be reliable, it is expected that Packets will be lost or delivered out of order.  
* If the network might deliver a Packet more than once, then it is highly recommended that the PROTECTION ENCAPSULATION Monotonic Counter is used to eliminate the duplicates.  
* The MQTT-SN protocol will tolerate out of order Packets and it will retransmit lost Packets.  
* There is no packet error correction in MQTT-SN. If a corrupted or partial packet is received it will cause a protocol error.  
* The MQTT-SN implementation may use either the origin network address or the sender identifier in the PROTECTION ENCAPSULATION to determine the identity of the Virtual Connection.  
* The Underlying Network may be connectionless. Virtual Connections do not need to have an Underlying Network event that signals their creation or deletion.  
* The Underlying Network may be a radio network.

**Informative comment**

UDP as defined in \[RFC0768\] can be used for MQTT-SN if the Maximum Transmission Unit is configured to be more than the maximum MQTT-SN Packet size used and no Packet fragmentation occurs. Depending on the network configuration, UDP can duplicate Packets. If this can happen, the PROTECTION ENCAPSULATION monotonic counter should be used.

Examples of possible consequences of not removing duplicate Packets are:  
 – DISCONNECT Packet applied to the wrong Virtual Connection  
 – SUBSCRIBE and UNSUBSCRIBE Packets applied to the wrong Virtual Connection  
 – PUBLISH QOS=2 published more than once

The following transport protocols are also suitable but if not capable of multicast the implementation of the optional ADVERTISE, SEARCHGW, GWINFO packets may not be possible:

* DTLS v1.2 \[RFC6347\]  
* DTLS v1.3 \[RFC9147\]  
* QUIC \[RFC9000\]  
* Non-IP protocols

* TCP/IP \[RFC0793\]  
* TLS \[RFC5246\]  
* WebSocket \[RFC6455\].

**Informative comment**

Both TCP and UDP ports 1883 and 8883 are registered with IANA for MQTT and secure communication respectively.

A Virtual Connection, which associates a Network Address with a Session, is:

* created with a CONNECT packet  
* deleted by any of:  
  * a retry timeout  
  * DISCONNECT packet  
  * protocol error  
* required for any MQTT-SN packet to be sent between MQTT-SN clients and servers, except any of the following Packets, including if they are Protection or Forwarder Encapsulated:  
  * CONNECT, which creates a Virtual Connection  
  * PUBWOS  
  * ADVERTISE, SEARCHGW, GWINFO

## **4.3 Quality of Service levels and protocol flows** {#4.3-quality-of-service-levels-and-protocol-flows}

MQTT delivers Application Messages according to the Quality of Service (QoS) levels defined in the following sections. The delivery protocol is symmetric, in the description below the Client and Server & Gateway can each take the role of either sender or receiver. When the Gateway is delivering an Application Message to more than one Client, each Client is treated independently. The QoS level used to deliver an Application Message outbound to the Client could differ from that of the inbound Application Message.

### **4.3.1 Publish without session: Any number of deliveries** {#4.3.1-publish-without-session:-any-number-of-deliveries}

No session is required to send a message. The message is delivered according to the capabilities of the underlying network. No response is sent by the receiver and no retry is performed by the sender. The message arrives at the receiver any number of times, including not at all.

The sender:

* MUST send a PUBWOS packet.

The receiver:

* MAY decide to accept ownership of the message when it receives a PUBWOS packet.  
* MUST treat any accepted messages as QoS 0\.

**Informative:**

PUBWOS packets may be Multicast or Unicast.

### **4.3.2 QoS 0: At most once delivery** {#4.3.2-qos-0:-at-most-once-delivery}

The message is delivered according to the capabilities of the underlying network. No response is sent by the receiver and no retry is performed by the sender. The message arrives at the receiver either once or not at all. 

In the QoS 0 delivery protocol, the sender

* MUST send a PUBLISH packet with QoS 0 and DUP flag set to 0.

In the QoS 0 delivery protocol, the receiver

* Accepts ownership of the message when it receives the PUBLISH packet.


| Sender Action | Control Packet | Receiver Action |
| :---: | :---: | ----- |
| PUBLISH QoS 0, DUP=0 |  |  |
|  | \----------\> |  |
|  |  | Deliver Application Message to appropriate onward recipient(s)  |

### **4.3.3 QoS 1: At least once delivery** {#4.3.3-qos-1:-at-least-once-delivery}

This Quality of Service level ensures that the message arrives at the receiver at least once. A QoS 1 PUBLISH packet has a Packet Identifier in its Variable Header and is acknowledged by a PUBACK packet.

In the QoS 1 delivery protocol, the sender

* MUST assign an unused Packet Identifier each time it has a new Application Message to publish \[MQTT-SN-4.3.3-1\].

* MUST send a PUBLISH packet containing this Packet Identifier with QoS 1 and DUP flag set to 0 \[MQTT-SN-4.3.3-2\].

* The DUP flag must be set to 0 the first time the PUBLISH QoS 1 

* MUST treat the PUBLISH packet as “unacknowledged” until it has received the corresponding PUBACK packet from the receiver \[MQTT-SN-4.3.3-3\].

The Packet Identifier becomes available for reuse once the sender has received the PUBACK packet. 

**In a difference to MQTT 5, the sender is NOT permitted to send further PUBLISH packets with different Packet Identifiers while it is waiting to receive acknowledgements. At any given time a sender must ONLY have 1 outstanding application message in flight.**

In the QoS 1 delivery protocol, the receiver

* MUST respond with a PUBACK packet containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message 

* After it has sent a PUBACK packet the receiver MUST treat any incoming PUBLISH packet that contains the same Packet Identifier as being a new Application Message, irrespective of the setting of its DUP flag

  Figure 4.2 – QoS 1 protocol flow diagram, Informative example

| Sender Action | MQTT Control Packet | Receiver action |
| ----- | ----- | ----- |
| Store message |  |  |
| Send PUBLISH QoS 1, DUP=0, \<Packet Identifier\> | \----------\> |  |
|  |  | Initiate onward delivery of the Application Message (Note 1\) |
|  | \<---------- | Send PUBACK \<Packet Identifier\> |
| Discard message |  |  |

Note(s):

1. The receiver does not need to complete delivery of the Application Message before sending the PUBACK. When its original sender receives the PUBACK packet, ownership of the Application Message is transferred to the receiver.

### **4.3.4 QoS 2: Exactly once delivery** {#4.3.4-qos-2:-exactly-once-delivery}

This is the highest Quality of Service level, for use when neither loss nor duplication of Application Messages are acceptable. There is an increased overhead associated with QoS 2\.

In the QoS 2 delivery protocol, the sender:

* MUST assign an unused Packet Identifier when it has a new Application Message to publish 

* MUST send a PUBLISH packet containing this Packet Identifier with QoS 2 and DUP flag set to 0 

* MUST treat the PUBLISH packet as “unacknowledged” until it has received the corresponding PUBREC packet from the receiver 

* MUST send a PUBREL packet when it receives a PUBREC packet from the receiver with a Reason Code value less than 0x80. This PUBREL packet MUST contain the same Packet Identifier as the original PUBLISH packet

* MUST treat the PUBREL packet as “unacknowledged” until it has received the corresponding PUBCOMP packet from the receiver

* MUST NOT resend the PUBLISH once it has sent the corresponding PUBREL packet

The Packet Identifier becomes available for reuse once the sender has received the PUBCOMP packet or a PUBREC with a Reason Code of 0x80 or greater. 

In the QoS 2 delivery protocol, the receiver:

* MUST respond with a PUBREC containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message

* If it has sent a PUBREC with a Reason Code of 0x80 or greater, the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message 

* Until it has received the corresponding PUBREL packet, the receiver MUST acknowledge any subsequent PUBLISH packet with the same Packet Identifier by sending a PUBREC. It MUST NOT cause duplicate messages to be delivered to any onward recipients in this case 

* MUST respond to a PUBREL packet by sending a PUBCOMP packet containing the same Packet Identifier as the PUBREL

* After it has sent a PUBCOMP, the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message, irrespective of the setting of its DUP flag

## **4.4 Packet delivery retry** {#4.4-packet-delivery-retry}

There are two situations when packets that require acknowledgement are resent by the sender:

1. when a Virtual Connection is deleted before the acknowledgement is received by the requester (and clean start is false)  
1. when no acknowledgment is received by the by the requester within a configured timeout period during the existence of a Virtual Connection

These two situations are described in the following two sections.

### **4.4.1 Virtual Connection End** {#4.4.1-virtual-connection-end}

When a Client reconnects with Clean Start set to 0 and a session is present, both the Client and Server MUST resend any unacknowledged PUBLISH packets (where QoS \> 0\) and PUBREL packets using their original Packet Identifiers \[MQTT-SN-4.4-1\].

If PUBACK or PUBREC is received containing a Reason Code of 0x80 or greater the corresponding PUBLISH packet is treated as acknowledged, and MUST NOT be retransmitted \[MQTT-SN-4.4-2\]. 

The DUP flag MUST be set to 1 by the Client or Server when it attempts to re-deliver or retransmit a PUBLISH packet. The DUP flag must be set to 0 for all QoS 0 packets.  \[MQTT-SN-4.4-3\].

Figure 4.3 – QoS 2 protocol flow diagram, non-normative example

| Sender Action | MQTT Control Packet | Receiver Action |
| ----- | ----- | ----- |
| Store message |   |   |
| PUBLISH QoS 2, DUP=0  \<Packet Identifier\> |   |   |
|   | \----------\> |   |
|   |   | Store \<Packet Identifier\> then Initiate onward delivery of the Application Message1 |
|   |   | PUBREC \<Packet Identifier\>\<Reason Code\> |
|   | \<---------- |   |
| Discard message, Store PUBREC received \<Packet Identifier\> |   |   |
| PUBREL \<Packet Identifier\> |   |   |
|   | \----------\> |   |
|   |   | Discard \<Packet Identifier\> |
|   |   | Send PUBCOMP \<Packet Identifier\> |
|   | \<---------- |   |
| Discard stored state |   |   |

 

1 The receiver does not need to complete delivery of the Application Message before sending the PUBREC or PUBCOMP. When its original sender receives the PUBREC packet, ownership of the Application Message is transferred to the receiver. However, the receiver needs to perform all checks for conditions which might result in a forwarding failure (e.g. quota exceeded, authorization, etc.) before accepting ownership. The receiver indicates success or failure using the appropriate Reason Code in the PUBREC.

### **4.4.1 Unacknowledged Packets** {#4.4.1-unacknowledged-packets}

The Client or Gateway will start a retransmission retry timer, Tretry, when one of the following Packets is sent.

A Client MUST retransmit AUTH, REGISTER, PUBLISH Qos1, PUBLISH Qos2, PUBREL, SUBSCRIBE, UNSUBSCRIBE Packets, including a PROTECTION encapsulation if there is one, after Tretry has passed or the Virtual Connection deleted.

A Gateway MUST retransmit PUBLISH Qos1, PUBLISH Qos2, PUBREL Packets, including a PROTECTION encapsulation if there is one, after Tretry has passed or the Virtual Connection deleted.

The timer is canceled if the corresponding acknowledgement packet is received. The Client or Gateway MUST retransmit the Packet after Tretry has passed or delete the Virtual Connection.

If a Packet can be retransmitted it MUST be sent using a Unicast address.

If a Packet is retransmitted it MUST be identical to the previously transmitted Packet, the PROTECTION encapsulation need not be identical.

PUBLISH (used for QoS 0\) and PUBLISH WITHOUT SESSION Packets MUST NOT be retransmitted.

If the Virtual Connection is deleted, the protocol will restart when a new CONNECT packet flows from the Client.

**Informative comment**

The value of the retry interval Tretry is not specified by the protocol, however, to be useful it ought to be longer than the network round trip time. If it is excessively long, the time taken to detect and retransmit lost Packets will also be excessively long. Implementers need to take care not to use a retry interval that might cause the network to become congested with retried Packets.

The PINGREQ Packet described in \[[3.1.21 PINGREQ](\#3.1.21-pingreq---ping-request)\] can also be used to determine whether the Virtual Connection is alive.

An example of a retry algorithm is described in \[[Appendix E.F4](\#f.4-exponential-backoff)\]

## **4.5 Application Message receipt** {#4.5-application-message-receipt}

When a Server takes ownership of an incoming Application Message it MUST add it to the Session State for those Clients that have matching Subscriptions \[MQTT-SN-4.5-1\]. Matching rules are defined in [section 4.7](\#4.7-topic-names-and-topic-filters).

Under normal circumstances Clients receive Application Messages in response to Subscriptions they have created. A Client could also receive Application Messages that do not match any of its explicit Subscriptions. This can happen if the Server automatically assigned a subscription to the Client. A Client could also receive Application Messages while an UNSUBSCRIBE operation is in progress. The Client MUST acknowledge any Publish packet it receives according to the applicable QoS rules regardless of whether it elects to process the Application Message that it contains \[MQTT-SN-4.5-2\].

## **4.6 Application Message ordering** {#4.6-application-message-ordering}

An Ordered Topic is a Topic where the Client can be certain that the Application Messages in that Topic from the same Client and at the same QoS are received in the order they were published. When a Server processes a Application Message that has been published to an Ordered Topic, it MUST send PUBLISH packets to consumers (for the same Topic and QoS) in the order that they were received from any given Client  \[MQTT-SN-???\].

By default, a Server MUST treat every Topic as an Ordered Topic when it is forwarding Application Messages.  \[MQTT-SN-???\]. A Server MAY provide an administrative or other mechanism to allow one or more Topics to not be treated as an Ordered Topic.

**Informative comment**

When a stream of messages is published and subscribed to an Ordered Topic with QoS 1, the final copy of each message received by the subscribers will be in the order that they were published.

As no more than one message is “in-flight” at any one time, no QoS 1 message will be received after any later one even on re-connection. .For example a subscriber might receive them in the order 1,2,3,3,4 but not 1,2,3,2,3,4. 

## **4.7 Topic Names and Topic Filters** {#4.7-topic-names-and-topic-filters}

### **4.7.1 Topic wildcards** {#4.7.1-topic-wildcards}

The topic level separator is used to introduce structure into the Topic Name. If present, it divides the Topic Name into multiple “topic levels”.

A subscription’s Topic Filter can contain special wildcard characters, which allow a Client to subscribe to multiple topics at once.

The wildcard characters can be used in Topic Filters, but MUST NOT be used within a Topic Name \[MQTT-SN-4.7.1-1\]. 

#### **4.7.1.1 Topic level separator** {#4.7.1.1-topic-level-separator}

The forward slash (‘/’ U+002F) is used to separate each level within a topic tree and provide a hierarchical structure to the Topic Names. The use of the topic level separator is significant when either of the two wildcard characters is encountered in Topic Filters specified by subscribing Clients. Topic level separators can appear anywhere in a Topic Filter or Topic Name. Adjacent Topic level separators indicate a zero-length topic level.

#### **4.7.1.2 Multi-level wildcard** {#4.7.1.2-multi-level-wildcard}

The number sign (‘\#’ U+0023) is a wildcard character that matches any number of levels within a topic. The multi-level wildcard represents the parent and any number of child levels. The multi-level wildcard character MUST be specified either on its own or following a topic level separator. In either case it MUST be the last character specified in the Topic Filter \[MQTT-SN-4.7.1.2-1\].

**Informative comment**

For example, if a Client subscribes to “sport/tennis/player1/\#”, it would receive Application Messages published using these Topic Names:

* “sport/tennis/player1”  
* “sport/tennis/player1/ranking  
*  “sport/tennis/player1/score/wimbledon”

  **Informative comment**

* “sport/\#” also matches the singular “sport”, since \# includes the parent level.  
* “\#” is valid and will receive every Application Message  
* “sport/tennis/\#” is valid  
* “sport/tennis\#” is not valid  
* “sport/tennis/\#/ranking” is not valid

#### **4.7.1.3 Single-level wildcard** {#4.7.1.3-single-level-wildcard}

The plus sign (‘+’ U+002B) is a wildcard character that matches only one topic level. 

The single-level wildcard can be used at any level in the Topic Filter, including first and last levels. Where it is used, it MUST occupy an entire level of the filter \[MQTT-SN-4.7.1.3-1\]. It can be used at more than one level in the Topic Filter and can be used in conjunction with the multi-level wildcard.

**Informative comment**

For example, “sport/tennis/+” matches “sport/tennis/player1” and “sport/tennis/player2”, but not “sport/tennis/player1/ranking”. Also, because the single-level wildcard matches only a single level, “sport/+” does not match “sport” but it does match “sport/”.

* “+” is valid  
* “+/tennis/\#” is valid  
* “sport+” is not valid  
* “sport/+/player1” is valid  
* “/finance” matches “+/+” and “/+”, but not “+” 

### **4.7.2  Topics beginning with $** {#4.7.2-topics-beginning-with-$}

The Server MUST NOT match Topic Filters starting with a wildcard character (\# or \+) with Topic Names beginning with a $ character \[MQTT-SN-4.7.2-1\]. The Server SHOULD prevent Clients from using such Topic Names to exchange messages with other Clients. Server implementations MAY use Topic Names that start with a leading $ character for other purposes.

**Informative comment**

* $SYS/ has been widely adopted as a prefix to topics that contain Server-specific information or control APIs  
*  Applications cannot use a topic with a leading $ character for their own purposes

  **Informative comment**

* A subscription to “\#” will not receive any messages published to a topic beginning with a $  
* A subscription to “+/monitor/Clients” will not receive any messages published to “$SYS/monitor/Clients”  
* A subscription to “$SYS/\#” will receive messages published to topics beginning with “$SYS/”  
* A subscription to “$SYS/monitor/+” will receive messages published to “$SYS/monitor/Clients”  
* For a Client to receive messages from topics that begin with $SYS/ and from topics that don’t begin with a $, it has to subscribe to both “\#” and “$SYS/\#”

### **4.7.3 Topic semantic and usage** {#4.7.3-topic-semantic-and-usage}

The following rules apply to Topic Names and Topic Filters:

* All Topic Names and Topic Filters MUST be at least one character long \[MQTT-SN-4.7.3-1\]  
* Topic Names and Topic Filters are case sensitive  
* Topic Names and Topic Filters can include the space character  
* A leading or trailing ‘/’ creates a distinct Topic Name or Topic Filter  
* A Topic Name or Topic Filter consisting only of the ‘/’ character is valid  
* Topic Names and Topic Filters MUST NOT include the null character (Unicode U+0000) [\[Unicode\]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html\#Unicode) \[MQTT-SN-4.7.3-2\]  
* Topic Names and Topic Filters are UTF-8 Encoded Strings; they MUST NOT encode to more than 65,535 bytes \[MQTT-SN-4.7.3-4\]. Refer to [section 1.7.4](\#1.7.4-utf-8-encoded-string).

 There is no limit to the number of levels in a Topic Name or Topic Filter, other than that imposed by the overall length of a UTF-8 Encoded String.

When it performs subscription matching the Server MUST NOT perform any normalization of Topic Names or Topic Filters, or any modification or substitution of unrecognized characters \[MQTT-SN-4.7.3-4\]. Each non-wildcarded level in the Topic Filter has to match the corresponding level in the Topic Name character for character for the match to succeed.

 **Informative comment**

The UTF-8 encoding rules mean that the comparison of Topic Filter and Topic Name could be performed either by comparing the encoded UTF-8 bytes, or by comparing decoded Unicode characters.

 **Informative comment**

* “ACCOUNTS” and “Accounts” are two different Topic Names  
* “Accounts payable” is a valid Topic Name  
* “/finance” is different from “finance” 

An Application Message is sent to each Client Subscription whose Topic Filter matches the Topic Name attached to an Application Message. The topic resource MAY be either predefined in the Server by an administrator or it MAY be dynamically created by the Server when it receives the first subscription or an Application Message with that Topic Name. The Server MAY also use a security component to authorize particular actions on the topic resource for a given Client.

## **4.8 Subscriptions** {#4.8-subscriptions}

A Subscription is associated only with the Session that created it. Each Subscription includes a Topic Filter, indicating the topic(s) for which messages are to be delivered on that Session, and Subscription Options. The Server is responsible for collecting messages that match the filter and transmitting them on the Session's Virtual Connection if and when that Virtual Connection exists.

A Session cannot have more than one Subscription with the same Topic Filter, so the Topic Filter can be used as a key to identify the subscription within that Session.

If there are multiple Clients, each with its own Subscription to the same Topic, each Client gets its own copy of the Application Messages that are published on that Topic. This means that the Subscriptions cannot be used to load-balance Application Messages across multiple consuming Clients as in such cases every message is delivered to every subscribing Client.

## **4.9 Flow Control** {#4.9-flow-control}

The maximum number of unacknowledged MQTT-SN requests in one direction within a Virtual Connection for both Clients and Servers is 1\. The packets which need acknowledgement and are included in this constraint are:

* PUBLISH (QoS 1 and 2\) and PUBREL  
* REGISTER  
* SUBSCRIBE  
* UNSUBSCRIBE

If a Client or Server receives an MQTT-SN request and there is already a request outstanding within the same Virtual Connection then it MUST issue a DISCONNECT with Reason Code 147 (Receive Maximum Exceeded) and delete the Virtual Connection \[MQTT-SN-4.9-1\].

Refer to [section 3.1.12.7](\#3.1.12.7-publish-actions) for a description of how Clients and Servers react if they are sent more than one unacknowledged packet.

## **4.10 Server redirection** {#4.10-server-redirection}

A Server can request that the Client uses another Server by sending a CONNACK or DISCONNECT packet with Reason Codes 0x9C (Use another server), or 0x9D (Server moved) as described in [section 4.13](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html\#S4\_13\_Errors). 

The Reason Code 0x9C (Use another server) specifies that the Client SHOULD temporarily switch to using another Server. The other Server is already known to the Client.

The Reason Code 0x9D (Server moved) specifies that the Client SHOULD permanently switch to using another Server. The other Server is already known to the Client.

## **4.11 Enhanced authentication** {#4.11-enhanced-authentication}

The CONNECT packet supports basic authentication of a Virtual Connection using the User Name and Password fields. While these fields are named for a simple password authentication, they can be used to carry other forms of authentication such as passing a token as the Password.

Enhanced authentication extends this basic authentication to include challenge / response style authentication. It might involve the exchange of AUTH packets between the Client and the Server after the CONNECT and before the CONNACK packets.

To begin an enhanced authentication, the Client sets the AUTH flag in the CONNECT packet and includes an Authentication Method and optionally Data, depending on the Authentication Method, used in the CONNECT packet. This specifies the authentication method to use and its parameters. If the Server does not support the Authentication Method supplied by the Client, it MAY send a CONNACK with a Reason Code of 0x8C (Bad authentication method) or 0x87 (Not Authorized) as described in [section 2.3.3](\#2.3.3-reason-code) and MUST delete the Virtual Connection  \[MQTT-SN-4.10-1\].

The Authentication Method is an agreement between the Client and Server about the meaning of the data sent in the Authentication Data and any of the other fields in CONNECT, and the exchanges and processing needed by the Client and Server to complete the authentication.

**Informative comment**

The Authentication Method is commonly a SASL mechanism, and using such a registered name aids interchange. However, the Authentication Method is not constrained to using registered SASL mechanisms.

If the Authentication Method selected by the Client specifies that the Client sends data first, the Client SHOULD include an Authentication Data property in the CONNECT packet. This property can be used to provide data as specified by the Authentication Method. The contents of the Authentication Data are defined by the authentication method.

If the Server requires additional information to complete the authentication, it can send an AUTH packet to the Client. This packet MUST contain a Reason Code of 0x18 (Continue authentication)  \[MQTT-SN-4.10-2\]. If the authentication method requires the Server to send authentication data to the Client, it is sent in the Authentication Data.

The Client responds to an AUTH packet from the Server by sending a further AUTH packet. This packet MUST contain a Reason Code of 0x18 (Continue authentication)  \[MQTT-SN-4.10-3\]. If the authentication method requires the Client to send authentication data for the Server, it is sent in the Authentication Data.

The Client and Server exchange AUTH packets as needed until the Server accepts the authentication by sending a CONNACK with a Reason Code of 0\. If the acceptance of the authentication requires data to be sent to the Client, it is sent in the Authentication Data.

The Client can terminate the Virtual Connection at any point in this process by sending a DISCONNECT packet. The Server can reject the authentication at any point in this process. It MUST send a CONNACK with a Reason Code of 0x80 or above as described in [section 4.13](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html\#S4\_13\_Errors), \[MQTT-SN-4.10-4\].

If the initial CONNECT packet included an Authentication Method property then all AUTH packets, and any successful CONNACK packet MUST include an Authentication Method Property with the same value as in the CONNECT packet \[MQTT-SN-4.10-5\].

The implementation of enhanced authentication is OPTIONAL for both Clients and Servers. If the Client does not include an Authentication Method in the CONNECT, the Server MUST NOT send an AUTH packet, and it MUST NOT send an Authentication Method in the CONNACK packet \[MQTT-SN-4.10-6\]. If the Client does not include an Authentication Method in the CONNECT, the Client MUST NOT send an AUTH packet to the Server \[MQTT-SN-4.10-7\].

If the Client does not include an Authentication Method in the CONNECT packet, the Server SHOULD authenticate using some or all of the information in the CONNECT packet in conjunction with the underlying transport layer..

**Informative example showing a SCRAM challenge**

* Client to Server: CONNECT Authentication Method="SCRAM-SHA-1" Authentication Data=client-first-data  
* Server to Client: AUTH rc=0x18 Authentication Method="SCRAM-SHA-1" Authentication Data=server-first-data  
* Client to Server AUTH rc=0x18 Authentication Method="SCRAM-SHA-1" Authentication Data=client-final-data  
* Server to Client CONNACK rc=0 Authentication Method="SCRAM-SHA-1" Authentication Data=server-final-data

**Informative example showing a Kerberos challenge**

* Client to Server CONNECT Authentication Method="GS2-KRB5"  
* Server to Client AUTH rc=0x18 Authentication Method="GS2-KRB5"  
* Client to Server AUTH rc=0x18 Authentication Method="GS2-KRB5" Authentication Data=initial context token  
* Server to Client AUTH rc=0x18 Authentication Method="GS2-KRB5" Authentication Data=reply context token  
* Client to Server AUTH rc=0x18 Authentication Method="GS2-KRB5"  
* Server to Client CONNACK rc=0 Authentication Method="GS2-KRB5" Authentication Data=outcome of authentication

### **4.11.1 Re-authentication** {#4.11.1-re-authentication}

If the Client supplied an Authentication Method in the CONNECT packet it can initiate a re-authentication at any time after receiving a CONNACK. It does this by sending an AUTH packet with a Reason Code of 0x19 (Re-authentication). The Client MUST set the Authentication Method to the same value as the Authentication Method originally used to authenticate the Virtual Connection \[MQTT-SN-4.10.1-1\]. If the authentication method requires Client data first, this AUTH packet contains the first piece of authentication data as the Authentication Data.

The Server responds to this re-authentication request by sending an AUTH packet to the Client with a Reason Code of 0x00 (Success) to indicate that the re-authentication is complete, or a Reason Code of 0x18 (Continue authentication) to indicate that more authentication data is needed. The Client can respond with additional authentication data by sending an AUTH packet with a Reason Code of 0x18 (Continue authentication). This flow continues as with the original authentication until the re-authentication is complete or the re-authentication fails.

If the re-authentication fails, the Client or Server MUST send DISCONNECT with an appropriate Reason Code as described in [section 4.13](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html\#S4\_13\_Errors), and MUST delete the Virtual Connection \[MQTT-SN-4.10.1-2\].

During this re-authentication sequence, the flow of other packets between the Client and Server can continue using the previous authentication.

 	**Informative comment**

The Server might limit the scope of the changes the Client can attempt in a re-authentication by rejecting the re-authentication. For instance, if the Server does not allow the User Name to be changed it can fail any re-authentication attempt which changes the User Name.

## **4.12 Handling errors** {#4.12-handling-errors}

### **4.12.1 Malformed Packet and Protocol Errors** {#4.12.1-malformed-packet-and-protocol-errors}

Definitions of Malformed Packet and Protocol Errors are contained in [section 1.3](\#1.3-terminology), some but not all of these error cases are noted throughout the specification. The rigor with which a Client or Server checks an MQTT-SN Control Packet it has received will be a compromise between:

* The size of the Client or Server implementation.  
* The capabilities that the implementation supports.  
* The degree to which the receiver trusts the sender to send correct Control Packets.  
* The degree to which the receiver trusts the network to deliver Control Packets correctly.  
* The consequences of continuing to process a packet that is incorrect.

If the sender is compliant with this specification it will not send Malformed Packets or cause Protocol Errors. However, if a Client sends Control Packets before it receives CONNACK, it might cause a Protocol Error because it made an incorrect assumption about the Server capabilities. Refer [to section 3.1.4](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html\#\_CONNECT\_Actions) CONNECT Actions.

 The Reason Codes used for Malformed Packet and Protocol Errors are:

* 0x81       	Malformed Packet  
* 0x82       	Protocol Error  
* 0x93       	Receive Maximum exceeded  
* 0x95       	Packet too large  
* 0x9A       	Retain not supported  
* 0x9B       	QoS not supported  
* 0xA2       	Wildcard Subscriptions not supported

When a Client detects a Malformed Packet or Protocol Error associated with a Virtual Connection it SHOULD send a DISCONNECT packet containing an appropriate Reason Code and MUST delete the associated Virtual Connection. Use Reason Code 0x81 (Malformed Packet) or 0x82 (Protocol Error) unless a more specific Reason Code has been defined in [section 2.3.3](\#2.3.3-reason-code).

When a Server detects a Malformed Packet or Protocol Error for any packet except ADVERTISE, SEARCHGW, GWINFO, PUBWOS and CONNECT, the Server SHOULD send a DISCONNECT packet with an appropriate Reason Code and MUST delete the associated Virtual Connection if one exists. \[MQTT-4.13.1-1\] In the case of an error in a CONNECT packet it MAY send a CONNACK packet containing the Reason Code. Use Reason Code 0x81 (Malformed Packet) or 0x82 (Protocol Error) unless a more specific Reason Code has been defined in [section 2.3.3](\#2.3.3-reason-code). There are no consequences for other Sessions.

If either the Server or Client omits to check some feature of a Control Packet, it might fail to detect an error, consequently it might allow data to be damaged.

### **4.12.2 Other errors** {#4.12.2-other-errors}

Errors other than Malformed Packet and Protocol Errors cannot be anticipated by the sender because the receiver might have constraints which it has not communicated to the sender. A receiving Client or Server might encounter a transient error, such as a shortage of memory, that prevents successful processing of an individual Control Packet.

Acknowledgment packets PUBACK, PUBREC, PUBREL, PUBCOMP, REGACK, SUBACK, UNSUBACK with a Reason Code of 0x80 or greater indicate that the received packet, identified by a Packet Identifier, was in error. There are no consequences for other Sessions or other Packets flowing on the same Session.

The CONNACK and DISCONNECT packets allow a Reason Code of 0x80 or greater to indicate that the Virtual Connection will be deleted. If a Reason Code of 0x80 or greater is specified, then the Virtual Connection MUST be deleted whether or not the CONNACK or DISCONNECT is sent \[MQTT-4.13.2-1\]. Sending one of these Reason Codes has no consequences for any other Session.

If the Control Packet contains multiple errors the receiver of the Packet can validate the Packet in any order and take the appropriate action for any of the errors found.

Refer to section 5.4.9 for information about handling Disallowed Unicode code points.

## **4.13 Example MQTT-SN Architectures** {#4.13-example-mqtt-sn-architectures}

There are three kinds of MQTT-SN components, MQTT-SN *clients*, MQTT-SN *gateways*, and MQTT-SN *forwarders*. MQTT-SN clients connect themselves to an MQTT server/broker via an MQTT-SN Gateway using the MQTT-SN protocol. An MQTT-SN Gateway may or may not be integrated with a MQTT server. Where an MQTT broker is involved, the MQTT protocol is used between the MQTT broker and the MQTT-SN Gateway. Its main function is the translation between MQTT and MQTT-SN.

MQTT-SN clients can also access a Gateway via a forwarder in case the Gateway is not directly attached to their network. The forwarder simply encapsulates the MQTT-SN frames it receives on the wireless side and forwards them unchanged to the Gateway; in the opposite direction, it decapsulates the frames it receives from the gateway and sends them to the clients, unchanged too.

**Informative comment**

The architectures described below are meant as examples and are not exhaustive.

![][image4]

Figure 1: MQTT-SN Architecture

### **4.13.1 Transparent Gateway** {#4.13.1-transparent-gateway}

For each connected MQTT-SN client a transparent Gateway will set up and maintain a MQTT connection to the MQTT server. This MQTT connection is reserved exclusively for the end-to-end and almost transparent packet exchange between the client and the server. There will be as many MQTT connections between the Gateway and the MQTT Broker as MQTT-SN clients connected to the Gateway. The transparent Gateway will perform a “syntax” translation between the two protocols. Since all packet exchanges are end-to-end between the MQTT-SN client and the MQTT Server, all functions and features that are implemented by the server can be offered to the client.

Although the implementation of the transparent Gateway is simpler when compared to the one of an aggregating Gateway, it requires the MQTT server to support a separate connection for each active client. Some MQTT server implementations might impose a limitation on the number of concurrent connections that they support.

          ![A close up of a mapDescription automatically generated][image5]

![][image6]

Figure XX2: Transparent and Aggregating Gateway scenarios

### **4.13.2 Aggregating Gateway** {#4.13.2-aggregating-gateway}

Instead of having a MQTT connection for each connected client, an aggregating Gateway will have only one MQTT connection to the Server. All packet exchanges between a MQTT-SN client and an aggregating Gateway end at the Gateway. The Gateway then decides which information will be given further to the Server. Although its implementation is more complex than the one of a transparent Gateway, an aggregating Gateway may be helpful in case of WSNs with a very large number of SAs because it reduces the number of MQTT connections that the Gateway must support concurrently.

![][image7]

Figure XX: Aggregating Gateway scenario

### **4.11.3 Forwarder encapsulator**

![][image8]

Figure XX: Forwarder encapsulator with TransparentGateway scenario![][image9]

Figure XX: Forwarder encapsulator with Aggregating Gateway scenario

### **4.13.4 MQTT-SN broker**

![][image10]

Figure XX: MQTT-SN broker scenario

## **4.14 Gateway Advertisement and Discovery** {#4.14-gateway-advertisement-and-discovery}

A Gateway may announce its presence by periodically sending an ADVERTISE packet to some or all devices that are currently parts of the network. A gateway should only advertise its presence if it is connected to a server, or is itself a server.

Multiple Gateways may be active at the same time in the same network. In this case they will have different identifiers. It is up to the Client to decide to which Gateway it wants to connect. At any point in time a Client is allowed to be connected to only one Gateway on the same network.

A client should maintain a list of active gateways together with their network addresses. This list is populated by means of the ADVERTISE and GWINFO packets received.

The time duration *TADV* until the gateway sends the next ADVERTISE packet is indicated in the *Duration* field of the ADVERTISE packets. A client may use this information to monitor the availability of a gateway. For example, if it does not receive ADVERTISE packets from a gateway for *NADV* consecutive times, it may assume that the gateway is down and remove it from its list of active gateways. Similarly, gateways in stand-by mode will become active (i.e. start sending ADVERTISE packets) if they miss successively a couple of times advertisements from a certain gateway.

Since the ADVERTISE packets are transmitted into the whole wireless network, the time interval *TADV* between two ADVERTISE packets sent by a gateway should be large enough (e.g. greater than 15 min) to avoid bandwidth congestion in the network.

The large value of *TADV* will lead to a long waiting time for new clients which are looking for a gateway. To shorten this waiting time a client may send a SEARCHGW packet. To prevent network flooding when multiple clients start searching for gateway almost at the same time, the sending of the SEARCHGW packet is delayed by a random time between 0 and *TSEARCHGW*. A client will cancel its transmission of the SEARCHGW packet if it receives during this delay time a SEARCHGW packet sent by another client and identical to the one it wants to send, and behaves as if the SEARCHGW packet was sent by itself.

The transmission radius *Rb* of the SEARCHGW packet is limited, e.g. to a single hop in case of a dense deployment of MQTT-SN clients.

Upon receiving a SEARCHGW packet a gateway replies with a GWINFO packet containing its id. Similarly, a client answers with a GWINFO packet if it has at least one active gateway in its list of active gateways. If the client has multiple gateways in its list, it selects one gateway out of its list and includes that information into the GWINFO packet.

Like the SEARCHGW packet, the GWINFO packet is transmitted with the same radius *Rb*, which is indicated in the SEARCHGW packet. The radius *Rb* is also given to the underlying layer when these two packets are passed down for transmission.

To give priority to the gateways a client will delay its sending of the GWINFO packet for a random time *TGWINFO*. If during this delay time the client receives a GWINFO packet it will cancel the transmission of its GWINFO packet.

In case of no response the SEARCHGW packet may be retransmitted. In this case the time intervals between consecutive SEARCHGW packets should be increased by the exponential backoff algorithm described in the appendix.

## **4.15 Client states** {#4.15-client-states}

At any given point in time, a client may be in one of **5 different states**. Transition through these states is governed by a strictly coordinated sequence of packets between client and server/gateway and further mediated by timers resident on the gateway. A client is in the *active* state when the server/gateway receives a CONNECT packet from that client. This state is supervised by the server/gateway with the “keep alive” timer. If the server/gateway does not receive any packet from the client for a period longer than the keep alive duration (indicated in the CONNECT packet), the gateway will consider that client as *lost* and activate for example the Will feature for that client. A client goes to the *disconnected* state when the server/gateway receives a DISCONNECT without a *session expiry interval* field. This state is not time-supervised by the server/gateway. A client moves into the asleep state by issuing a DISCONNECT with a *session expiry interval* field. For more information on the sleep state, please refer to the “Sleeping clients” section.

| State | State Description | Possible Transitions |
| ----- | ----- | ----- |
| **DISCONNECTED** | The client is considered offline. The gateway may or may not have a previous session state for this client. From here a client may transition ONLY to the **ACTIVE** state. | **ACTIVE** |
| **ACTIVE** | The client is actively engaged in the session. It should be able to send and receive packets. Its state is supervised by the gateway with the associated “keep alive” timers. From here the client may transition to **ASLEEP** (by way of DISCONNECT with a session expiry interval \> 0), **DISCONNECTED** (by way of DISCONNECT with a session expiry of 0\) or **LOST** (by way of supervised gateway timers). | **ASLEEP DISCONNECTED LOST** |
| **ASLEEP** | The client is engaged in an ongoing session. It cannot receive packets; it can send packets. The gateway should not expect a response from the client in this state until further packets are received from the client. From here the client may transition to **AWAKE** (by way of PINGREQ), **ACTIVE** by way of CONNECT, **DISCONNECTED** (by way of DISCONNECT with a session expiry of 0\) or **LOST** (by way of supervised gateway timers). | **AWAKE ACTIVE DISCONNECTED LOST** |
| **AWAKE** | The client is partially engaged in an ongoing session; it is obliged to not send ANY packets other than those involved in the receipt of PUBLISH packets (PUBACK, PUBREC, PUBCOMP, REGACK) or a DISCONNECT to transition to **DISCONNECTED**. The client transitions back to the **ASLEEP** state on receipt of a PINGRESP packet or **LOST** (by way of supervised gateway timers). | **ASLEEP DISCONNECTED LOST** |
| **LOST** | The client is considered offline and not able to receive packets until it has re-established a session with the GW by way of a CONNECT. The gateway **must not** attempt to send packets to a client in the **LOST** state**.** Any packets received from a client whose state is **LOST** should not be processed and a DISCONNECT with error should be sent in response, unless the packets received are PUBLISH WITHOUT SESSION or PUBLISH \-1. Session state may exist on the GW for a client in the **LOST** state. | **ACTIVE** |

![][image11]

Figure 4:  The Server View of the Client State

### **4.15.1 Gateway timers** {#4.15.1-gateway-timers}

The following timers must be managed by a Gateway per Client to handle the different Client states:

* “Keep Alive” timer based on the value defined in the CONNECT packet. If expired, a Client is moved from Active to Lost state or from Asleep to Lost state or from Awake to Lost state.  
* “Session Expiry” timer based on the value defined in the CONNECT or the DISCONNECT packet. If expired, the session state associated with the Client can be removed.

## **4.16 Clean start** {#4.16-clean-start}

When a client disconnects, its subscriptions are retained for no less than the session expiration interval. They are persistent and valid for new (non clean start) sessions, until either they are explicitly un-subscribed by the client, or the client establishes a new session with the “clean start” flag set or their idle time exceeds the session expiry interval associated with the session.

The two flags “CleanStart” and “Will” in the CONNECT Packet have the following meanings:

* CleanStart=true, Will=true: The Gateway will delete all Session data related to the client, including Will data if present, and it will set the Will data in the Session state with the content of the CONNECT Will fields and will return CONNACK.

* CleanStart=true, Will=false: The gateway will delete all subscriptions and Will data, if present, related to the client and it will return CONNACK.

* CleanStart=false, Will=true: The gateway will keep all the client’s data and it will overwrite, if present, or add the Will data related to the client with the content of the CONNECT Will optional fields and it will return CONNACK.

* CleanStart=false, Will=false: The Gateway will keep all the client’s subscriptions and it will delete any Will data, if present, and it will return CONNACK.

Note that if a client wants to delete only its Will data at Virtual Connection creation, it could send a CONNECT packet with “CleanStart=false” and “Will=false”.

## **4.17 Topic Registration** {#4.17-topic-registration}

Because of the limited bandwidth and the small packet payload in wireless sensor networks, data is not published together with its topic name as in MQTT. A registration procedure is introduced which allows both a client and a gateway to inform its peer about the short topic alias and its corresponding topic name before it can start sending PUBLISH packets using the short topic alias.

A topic alias is a two-byte long replacement of the string-based topic name. A client needs to use the REGISTER procedure to inform the gateway about the topic name it wants to employ and gets the corresponding topic alias from the gateway. It then will use this topic alias in the PUBLISH packets it sends to the gateway. In the opposite direction, the PUBLISH packets also contain a 2-byte topic alias (instead of the string-based topic name). The client is informed about the relation between topic alias and topic name by means of either a former SUBSCRIBE procedure, or a REGISTER procedure started by the gateway.

To register a topic name a client sends a REGISTER packet to the Server. If the registration could be accepted, the gateway assigns a *topic alias* to the received topic name and returns it with a REGACK packet to the client. 

If the client initiates a REGISTER against a topic which is known by the Server to have a predefined topic alias associated with it, it is an error case, but one which should not be terminal to the session since gateway updates could lead to this scenario. The gateway will specify its topic alias type to be predefined and set the topic alias value to match that defined on the gateway in the REGACK, it will also set a reason code on the REGACK to indicate the issue. The client can then choose to update its registry of predefined topic aliases if it so wishes. 

If a Client sends a PUBLISH to a predefined topic alias, which is not defined on the Server, this is considered a protocol violation.  \[MQTT-SN-???\]

If there are no predefined topic aliases, the gateway will pass back a SESSION topic alias type. If the registration can not be accepted, a REGACK is also returned to the client with the failure reason encoded in the *ReasonCode* field.

After having received the REGACK packet with *ReasonCode \=“accepted”*, the client shall use the assigned *topicId* to publish data of the corresponding topic name. If, however, the REGACK contains a rejection code, the client may try to register later again. If the Reason Code was *“Congestion”*, the client should wait for a time *TWAIT* before restarting the registration procedure.

At any point in time a client may have only one REGISTER packet outstanding, i.e., it must wait for a REGACK packet before it can register another topic name.

A gateway sends a REGISTER packet to a client if it wants to inform that client about the topic name and the assigned topic alias that it will use later when sending PUBLISH packets of the corresponding topic name. This happens for example when no prior registrations exists, or when the client has DISCONNECTED with retain registration false, or the client re-connects without having set the “CleanStart” flag or the client has subscribed to topic names that contain wildcard characters such as \# or \+. 

**Informative comment**

The gateway should attempt to make the best effort to reuse the same topic alias mappings that existed during any initial associated ACTIVE states. 

## **4.18 Topic Mapping and Aliasing** {#4.18-topic-mapping-and-aliasing}

On the gateway the mapping table between registered topic ids and topic names MUST be implemented per client (and not by a single shared pool between all clients), to reduce the risk of an incorrect topic id from a client matching another client’s valid topic.

For performance and efficiency reasons the broker may choose to align topic aliases for registered normal topic aliases between multiple clients. The mapping table of predefined topic aliases is separate from normal registered aliases. It is global and shared between all clients and gateways and may overlap with registered aliases, since it is in a different pool.

## **4.19 Predefined topic aliases and short topic names** {#4.19-predefined-topic-aliases-and-short-topic-names}

A “predefined” topic alias is a topic alias whose mapping to a topic name is known in advance by both the client’ application and the gateway. This is indicated in the *Flags* field of the packet. When using pre-defined topic aliases, both sides can start immediately with the sending of PUBLISH packets; there is no need for the REGISTER procedure as in the case of ”normal” topic aliases. When receiving a PUBLISH packet with a predefined topic alias, of which the mapping to a topic name is unknown, the receiver should return a PUBACK with the *ReasonCode= “*Unknown Topic Alias*”*.

The presence of a pre-defined topic alias does not imply any other meaning onto the topic name / topic filter itself. All lifecycle operations, for example SUBSCRIBE / UNSUBSCRIBE may still be used in the use of these aliases except for REGISTER.

A “short” topic name is a topic name that has a fixed length of two bytes. It could be carried together with the data within a PUBLISH packet, thus no REGISTER procedure is needed for a short topic name. Otherwise, all rules that apply to normal topic names also apply to short topic names. Note however that it does not make sense to do wildcarding in subscriptions to short topic names, because it is not possible to define a meaningful name hierarchy with only two characters.

## **4.20 Client’s Topic Subscribe/Unsubscribe Procedure** {#4.20-client’s-topic-subscribe/unsubscribe-procedure}

To subscribe to a topic name, a client sends a SUBSCRIBE packet to the gateway with the topic name included in that packet. If the gateway is able accept the subscription, it assigns a topic alias to the received topic name and returns it within a SUBACK packet to the client. If the subscription cannot be accepted, then a SUBACK packet is also returned to the client with the rejection cause encoded in the *ReasonCode* field. If the rejection cause is *“Congestion”*, the client should wait for the time *TWAIT* before resending the SUBSCRIBE packet to the gateway.

If the client subscribes to a topic name which contains a wildcard character, the returning SUBACK packet will contain the topic alias value 0x0000. The gateway will use the registration procedure to inform the client about the to-be-used topic alias value when it has the first PUBLISH packet with a matching topic name to be sent to the client.

Similar to the client’s PUBLISH procedure, topic aliases may also be pre-defined for certain topic names. Short topic names may be used as well. In those two cases the client still needs to subscribe to those pre-defined topic aliases or short topic names.

To unsubscribe, a client sends an UNSUBSCRIBE packet to the gateway, which will then be answered by means of an UNSUBACK packet.

As for the REGISTER procedure, a client may have only one SUBSCRIBE or one UNSUBSCRIBE transaction open at a time.

## **4.21 Client Publish Procedure** {#4.21-client-publish-procedure}

After having registered successfully a topic name with the gateway, the client can start publishing data relating to the registered topic name by sending PUBLISH packets to the gateway. The PUBLISH packets contain the assigned topic alias.

All three QoS levels and their corresponding packet flows are supported as defined in MQTT. The only difference is the use of topic alias instead of topic names in the PUBLISH packets.

For QoS 1 or 2 PUBLISH packets the client may receive in response to its PUBLISH an error reason code:

* The *ReasonCode= “*Unknown Topic Alias*”*: in this case the client needs to register the topic name again before it can publish data related to that topic name; or

* The *ReasonCode= “Congestion”*: in this the client shall stop publishing toward the gateway for at least the time *TWAIT*.

A Client or Gateway processes a single outbound QoS 1 or QoS 2 message at a time.

This prevents retransmitted Qos 1 and Qos 2 messages from being received out of order.

A Client MUST NOT send a Qos 1 or Qos 2 PUBLISH packet with a new Application Message until it has received a PUBACK or PUBCOMP Packet with the Packet Identifier corresponding to the PUBLISH packet previously sent \[MQTT-SN-4.21-1\].

## **4.22 Gateway Publish Procedure** {#4.22-gateway-publish-procedure}

Like the client publish procedure described in [Section 4.21](\#4.21-client-publish-procedure), the gateway sends PUBLISH packets with the topic alias value that was returned in the SUBACK packet to the client.

Preceding the PUBLISH packet the gateway may send a REGISTER packet to inform the client about the topic name and its assigned topic alias value. This will happen for example when the client re-connects without clean start or has subscribed to topic names with wildcard characters. Upon receiving a REGISTER packet the client replies with a REGACK packet. The gateway will wait for the REGACK packet before it sends the PUBLISH packet to the client.

The client could reject the REGISTER packet with a REGACK packet indicating the rejection reason; this corresponds to an unsubscribe to the topic name indicated in the REGISTER packet. Note that unsubscribe to a topic name with wildcard characters can only be done with the unsubscribe procedure and not with the rejection of a REGISTER packet, since a REGISTER packet never contains a topic name with wildcard characters.

If the client receives a PUBLISH packet with an unknown topic alias value, it shall respond with a PUBACK packet with the *ReasonCode=“*Unknown Topic Alias*”*. This will trigger the gateway to delete or correct the wrong topic alias assignment.

Note that in case either the topic name or the data is too long to fit into a REGISTER or a PUBLISH packet, the gateway silently aborts the publish procedure, i.e. no warning is sent to the affected subscribers.

A Gateway MUST NOT send a Qos 1 or Qos 2 PUBLISH packet with a new Application Message until it has received a PUBACK or PUBCOMP Packet with the Packet Identifier corresponding to the PUBLISH packet previously sent.

## **4.23 Keep Alive and PING Procedure** {#4.23-keep-alive-and-ping-procedure}

As with MQTT, the value of the Keep Alive timer is indicated in the CONNECT packet. The client should send a PINGREQ packet within each Keep Alive time period, which the gateway acknowledges with a PINGRESP packet.

Similarly, a client shall answer with a PINGRESP packet when it receives a PINGREQ packet from the GW to which it is virtually connected. Otherwise, the received PINGREQ packet is ignored.

Clients should use this procedure to supervise the liveliness of the gateway to which they are connected. If a client does not receive a PINGRESP from the gateway even after multiple retransmissions of the PINGREQ packet, it should first try to connect to another gateway before trying to reconnect to this gateway. Note that because the clients’ keep-alive timers are not synchronized with each other, in case of a gateway failure there is practically no danger for a storm of CONNECT packets sent almost at the same time by all affected clients towards a new gateway.

## **4.24 Client’s Disconnect Procedure** {#4.24-client’s-disconnect-procedure}

A client sends a DISCONNECT packet to the gateway to indicate that it is about to delete its Virtual Connection. After this point, the client is then required to create a new Virtual Connection with the gateway before it can exchange information with that gateway again. Like MQTT, sending the DISCONNECT packet does not affect existing subscriptions and Will data. They are persistent until they are either expired or explicitly un-subscribed, or deleted, or modified by the client, or if the client creates a new Virtual Connection with the CleanStart flag set. The gateway acknowledges the receipt of the DISCONNECT packet by returning a DISCONNECT to the client.

A client may also receive an unsolicited DISCONNECT sent by the gateway. This may happen for example when the gateway, due to an error, cannot identify the client to which a received packet belongs. Upon receiving such a DISCONNECT packet a client should try to setup the Virtual Connection again by sending a CONNECT packet to the gateway.

## **4.25 Sleeping clients** {#4.25-sleeping-clients}

*Sleeping* clients are clients residing on (battery-operated) devices that want to save as much energy as possible. These devices need to enter a sleep mode whenever they are not active and will wake up whenever they have data to send or to receive. The server/gateway needs to be aware of the sleeping state of these clients and will buffer messages destined to them for later delivery when they wake up. 

If a client wants to sleep, it sends a DISCONNECT packet which contains a sleep session expiry interval. The server/gateway acknowledges that packet with a DISCONNECT packet and considers the client for being in *asleep* state. The *asleep* state is supervised by the server/gateway with the indicated sleep session expiry interval. If the server/gateway does not receive any packet from the client for a period longer than the sleep session expiry interval, the server/gateway will consider that client as *lost* and \- as with the keep alive procedure \- activates for example the Will feature. 

During the *asleep* state, packets that need to be sent to the client are buffered at the server/gateway. The gateway MUST buffer application messages of quality-of-service 1 & 2\. 

**Informative comment**

The gateway may *choose* to buffer messages of Quality-of-Service 0, whilst the client is sleeping and is within its session expiry interval.

The sleep timer is stopped when the server/gateway receives a PINGREQ from the client. Like the CONNECT packet, this PINGREQ packet contains the *Client Id*. The identified client is then in the *awake* state. If the server/gateway has buffered packets for the client, it will send these packets to the client, acknowledging the Default Awake Messages value sent in the CONNECT packet. If the number of messages buffered on the gateway waiting to be sent exceeds the value specified by the client in the Default Awake Messages field, the gateway shall send only the Default Awake Messages value number of messages, and cut short the AWAKE cycle, responding with a PINGRESP with a messages-left value of either the number of messages remaining in the gateway buffer or 0xFFFF (meaning undetermined number of messages greater than 0 remaining).

During the AWAKE state, for each packet the gateway sends to the client, the application messages’ quality of service shall be honored, and a full packet interaction shall take place including all normative phases of acknowledgement, including any associated retransmission logic. If, during the delivery of application messages from the gateway to the client, the gateway detects a timeout in the delivery, it should transition the client state to LOST and a DISCONNECT packet with error sent to the device.

The transfer of packets to the client is closed by the server/gateway by means of a PINGRESP packet, i.e. the server/gateway will consider the client as *asleep* and restart the sleep timer again after having sent the PINGRESP packet. If the server/gateway does not have any packets buffered for the client, it answers immediately with a PINGRESP packet, returns the client back to the *asleep* state, and restarts the sleep timer for that client. 

After having sent the PINGREQ to the server/gateway, the client uses the “retransmission procedure” of section 3.18 to supervise the arrival of packets sent by the server/gateway, i.e. it restarts timer Tretry when it receives a packet other than a PINGRESP, and stops it when it receives a PINGRESP. The PINGREQ packet is retransmitted, and timer Tretry restarted when timer Tretry times out. To avoid a flattening of its battery due to excessive retransmission of the PINGREQ packet (e.g. if it loses the gateway), the client should limit the retransmission of the PINGREQ packet (e.g. by a retry counter) and go back to sleep when the limit is reached and it still does not receive a PINGRESP packet. 

From the *asleep* state, a client can return either to the *active* state by sending a CONNECT packet or to the *disconnected* state by sending a normal DISCONNECT packet (i.e. without session expiry interval field). The client can also modify its sleep configuration by sending a DISCONNECT packet with a new value of the session expiry interval. 

Note that a sleeping client should go to the *awake* state only if it just wants to check whether the server/gateway has any messages buffered for it and return as soon as possible to the *asleep* state without sending any packets to the server/gateway. Otherwise, it should return to the *active* state by sending a CONNECT packet to the server/gateway. 

**//TODO SIMON – add some worlds around retain registration behavior**

Topic Alias mappings exist only while a client is active and last for the entire session expiry interval of the active state. Therefore, the gateway must re-register any topic aliases during the AWAKE state, which will last until the last PINGRESP is issued. 

**Informative comment**

The gateway should attempt to make the best effort to reuse the same topic alias mappings that existed during any initial associated ACTIVE states.

![][image12]

Figure 5: Awake ping packet flush

## **4.26 Retained Messages** {#4.26-retained-messages}

If the RETAIN flag is set to 1 in a PUBLISH or PUBWOS packet received by a Server, the Server MUST replace any existing Retained Message for this topic and store the Application Message \[MQTT-SN-4.26-1\], so that it can be delivered to future subscribers whose subscriptions match its Topic Name. If the Publish Data contains zero bytes it is processed normally by the Server but any retained message with the same topic name MUST be removed and any future subscribers for the topic will not receive a retained message \[MQTT-SN-4.26-2\]. A Retained Message with a Publish Data containing zero bytes MUST NOT be stored as a Retained Message on the Server \[MQTT-SN-4.26-3\].

If the RETAIN flag is 0 in a PUBLISH packet sent by a Client to a Server, the Server MUST NOT store the message as a Retained Message and MUST NOT remove or replace any existing Retained Message \[MQTT-SN-4.26-4\].

When a new Subscription is made, the last retained message, if any, on each matching topic name is sent to the Client as directed by the Retain Handling Subscribe Flag. These messages are sent with the RETAIN flag set to 1\. Which retained messages are sent is controlled by the Retain Handling Subscribe Flag. At the time of the Subscription:

* If Retain Handling is set to 0 the Server MUST send the retained messages matching the Topic Filter of the subscription to the Client \[MQTT-SN-4.26-5\].  
* If Retain Handling is set to 1 then if the subscription did not already exist, the Server MUST send all retained messages matching the Topic Filter of the subscription to the Client, and if the subscription did exist the Server MUST NOT send the retained messages. \[MQTT-SN-4.26-6\].  
*  If Retain Handling is set to 2, the Server MUST NOT send the retained messages \[MQTT-SN-4.26-7\].

Refer to [section 3.1.17.2](\#3.1.17.2-subscribe-flags) for a definition of the Subscription Flags.

If the Server receives a PUBLISH packet with the RETAIN flag set to 1, and QoS 0 it SHOULD store the new QoS 0 message as the new retained message for that topic, but MAY choose to discard it at any time. If this happens there will be no retained message for that topic.

The setting of the RETAIN flag in an Application Message forwarded by the Server from an established Virtual Connection is controlled by the Retain As Published subscription option. Refer to [section 3.1.17.2](\#3.1.17.2-subscribe-flags) for a definition of the Subscription Flags.

* If the value of Retain As Published subscription option is set to 0, the Server MUST set the RETAIN flag to 0 when forwarding an Application Message regardless of how the RETAIN flag was set in the received PUBLISH packet \[MQTT-SN-4.26-8\].  
* If the value of Retain As Published subscription option is set to 1, the Server MUST set the RETAIN flag equal to the RETAIN flag in the received PUBLISH packet \[MQTT-SN-4.26-9\].

  **Informative comment**

Retained messages are useful where publishers send state messages on an irregular basis. A new non-shared subscriber will receive the most recent state

## **4.27 Optional Features** {#4.27-optional-features}

Support for the ADVERTISE, SEARCHGW, GWINFO and PUBWOS packet types is optional. 

The Forwarder Encapsulation packet type support is optional. For instance, it is not required if the MQTT-SN Clients are able to directly reach a MQTT-SN Gateway.

The PROTECTION packet type support is optional. For instance, it is not required if the MQTT-SN Gateway and the MQTT-SN Clients interact over a secure communication channel, like DTLS or any communication channel assuring the authenticity and optionally the confidentiality protection. 

# **5 Security (Informative)** {#5-security-(informative)}

Like the MQTT security chapter but with a focus on MQTT-SN. In particular:

* securing communications with:  
  * username/password  
  * challenge/response \- AUTH  
  * DTLS  
  * Protection encapsulation

## **5.1 Introduction** {#5.1-introduction}

# **6 Conformance** {#6-conformance}

(**Note**: The [OASIS TC Process](https://www.oasis-open.org/policies-guidelines/tc-process\#wpComponentsConfClause) requires that a specification approved by the TC at the Committee Specification Public Review Draft, Committee Specification or OASIS Standard level must include a separate section, listing a set of numbered conformance clauses, to which any implementation of the specification must adhere in order to claim conformance to the specification (or any optional portion thereof). This is done by listing the conformance clauses here.

For the definition of "conformance clause," see [OASIS Defined Terms](https://www.oasis-open.org/policies-guidelines/oasis-defined-terms-2017-05-26\#dConformanceClause).

See "Guidelines to Writing Conformance Clauses":   
[https://docs.oasis-open.org/templates/TCHandbook/ConformanceGuidelines.html](https://docs.oasis-open.org/templates/TCHandbook/ConformanceGuidelines.html).

Remove this note before submitting for publication.)

# **Appendix A. References** {#appendix-a.-references}

\[Required section.\]

This appendix contains the normative and informative references that are used in this document.

While any hyperlinks included in this appendix were valid at the time of publication, OASIS cannot guarantee their long-term validity.

 

Note: Any normative work cited in the body of the text as needed to implement the work product must be listed in the Normative References section below. Each reference to a separate document or artifact in this work must be listed here and must be identified as either a Normative or an Informative Reference.

 

For all References – Normative and Informative:

Recommended approach: Set up **\[Reference\]** label elements as "Bookmarks", then create hyperlinks to them within the document at locations from which the references are cited. Citations in the body of the text should be hyperlinked to the appropriate Reference entry, not directly to targets which are not a part of this Work Product.

 

The proper format for citation of technical work produced by an OASIS TC (whether Standards Track or Non-Standards Track) is:

 

**\[Citation Label\]**

Work Product title (italicized). Edited by Albert Alston, Bob Ballston, and Calvin Carlson. Approval date (DD Month YYYY). OASIS Stage Identifier and Revision Number (e.g., OASIS Committee Specification Draft 01). Principal URI (stage-specific URI, e.g., with stage component: somespec-v1.0-csd01.html). Latest stage: (static URI, without stage identifiers, used as a symbolic link to most recently published stage of this Version).

 

For example:

 

**\[OpenDoc-1.2\]**

Open Document Format for Office Applications (OpenDocument) Version 1.2. Edited by Patrick Durusau and Michael Brauer. 19 January 2011\. OASIS Committee Specification Draft 07\. https://docs.oasis-open.org/office/v1.2/csd07/OpenDocument-v1.2-csd07.html. Latest stage: https://docs.oasis-open.org/office/v1.2/OpenDocument-v1.2.html.

 

Reference sources:

For references to IETF RFCs, use the approved citation formats at:

[https://docs.oasis-open.org/templates/ietf-rfc-list/ietf-rfc-list.html](https://docs.oasis-open.org/templates/ietf-rfc-list/ietf-rfc-list.html).

The most recent IETF RFC references are listed by the IETF at [https://www.rfc-editor.org/in-notes/rfc-ref.txt](https://www.rfc-editor.org/in-notes/rfc-ref.txt).

For references to W3C Recommendations, use the approved citation formats at:

[https://docs.oasis-open.org/templates/w3c-recommendations-list/w3c-recommendations-list.html](https://docs.oasis-open.org/templates/w3c-recommendations-list/w3c-recommendations-list.html).

Remove this note before submitting for publication.

 

## **A.1 Normative References** {#a.1-normative-references}

The following documents are referenced in such a way that some or all of their content constitutes requirements of this document.

 

\[RFC2119\]

Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997, \<[https://www.rfc-editor.org/info/rfc2119](https://www.rfc-editor.org/info/rfc2119)\>.

\[RFC8174\]

Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words", BCP 14, RFC 8174, DOI 10.17487/RFC8174, May 2017, \<[https://www.rfc-editor.org/info/rfc8174](https://www.rfc-editor.org/info/rfc8174)\>.

 

\[Reference\]

\[Full reference citation\]

**\[RFC2119\]**

Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997, 

[http://www.rfc-editor.org/info/rfc2119](http://www.rfc-editor.org/info/rfc2119)

**\[RFC3629\]**

Yergeau, F., "UTF-8, a transformation format of ISO 10646", STD 63, RFC 3629, DOI 10.17487/RFC3629, November 2003,

[http://www.rfc-editor.org/info/rfc3629](http://www.rfc-editor.org/info/rfc3629)

**\[RFC6455\]**

Fette, I. and A. Melnikov, "The WebSocket Protocol", RFC 6455, DOI 10.17487/RFC6455, December 2011,

[http://www.rfc-editor.org/info/rfc6455](http://www.rfc-editor.org/info/rfc6455)

**\[Unicode\]**

The Unicode Consortium. The Unicode Standard, 

[http://www.unicode.org/versions/latest/](http://www.unicode.org/versions/latest/) 

## **A.2 Informative References** {#a.2-informative-references}

The following referenced documents are not required for the application of this document but may assist the reader with regard to a particular subject area.

 

\[RFC3552\]

Rescorla, E. and B. Korver, "Guidelines for Writing RFC Text on Security Considerations", BCP 72, RFC 3552, DOI 10.17487/RFC3552, July 2003, \<[https://www.rfc-editor.org/info/rfc3552](https://www.rfc-editor.org/info/rfc3552)\>.

\[Reference\]

\[Full reference citation\]

# **Appendix B. Backwards Compatibility** {#appendix-b.-backwards-compatibility}

### **B.1 PUBLISH QoS \-1 (Packet from MQTT-SN 1.2)** {#b.1-publish-qos--1-(packet-from-mqtt-sn-1.2)}

| Bit | 7 | 6 |  | 5 |  | 4 | 3 |  | 2 |  | 1 | 0 |  |
| ----- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ----- | :---: | :---: | :---: |
| Byte 1 | Length |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 2 | Packet Type (0x0C) |  |  |  |  |  |  |  |  |  |  |  |  |
|  | ***PUBLISH-M1 FLAGS*** |  |  |  |  |  |  |  |  |  |  |  |  |
|  | *DUP*  |  | *QoS*  |  | *Retain* |  |  | *Reserved* | *Reserved* | *Topic Id Type*  |  |  |  |
| Byte 3 | *X* |  | *X* | *X* | *X* |  |  | *0* | *0* | *X* |  |  | *X* |
| Byte 4 | Topic Id MSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 5 | Topic Id LSB |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 6 | 0x00 – Fixed Field Value |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 7 | 0x00 – Fixed Field Value |  |  |  |  |  |  |  |  |  |  |  |  |
| Byte 8 .. N | Data Or (Full Topic Name \+ Data) |  |  |  |  |  |  |  |  |  |  |  |  |

Table 27: PUBLISH packet

This packet is used by both clients and gateways to publish data to a topic.

**Informative comment**

If the Transport Layer supports multicast, like UDP/IP, the PUBLISH MINUS \-1 packet is generally sent using the Multicast Address as destination.

#### **B.1.1 Length & Packet Type** {#b.1.1-length-&-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format. Refer to [section 2.1](\#2.1-structure-of-an-mqtt-sn-control-packet) for a detailed description.

#### **B.1.2 PUBLISH Flags** {#b.1.2-publish-flags}

The PUBLISH Flags field is 1-byte located in Byte 3 position of the PUBLISH control packet. 

The PUBLISH Flags includes the following flags:

* **Topic Id Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value.   
* **QoS**: This is a 2-bit field stored in Bit 5 and 6\. QoS has the same meaning as with MQTT indicating the Quality of Service. Set to “0b00” for QoS 0, “0b01” for QoS 1, “0b10” for QoS 2, and “0b11” for QoS \-1. For a detailed description of the various Quality Of Service levels refer to [section 4.3](\#4.3-quality-of-service-levels-and-protocol-flows).  
* **DUP**: 1 bit field stored in Bit 7 and has the same meaning as with MQTT. It notes the duplicate delivery of packets. If the DUP flag is set to “0”, it signifies that the packet is sent for the first time. If the DUP flag is set to “1”, it signifies that the packet was retransmitted.   
* **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT. The field signifies whether the existing retained message for this topic is replaced or kept.

#### **B.1.3 Topic Id** {#b.1.3-topic-id}

Contains the topic id value or the short topic name for which the data is published.

#### **B.1.4 Data** {#b.1.4-data}

The published data.

# **Appendix C. Security and Privacy Considerations** {#appendix-c.-security-and-privacy-considerations}

\[Optional section.\]

Note: OASIS strongly recommends that Technical Committees consider issues that might affect safety, security, privacy, and/or data protection in implementations of their work products and document these for implementers and adopters. For some purposes, you may find it required, e.g. if you apply for IANA registration.

While it may not be immediately obvious how your work product might make systems vulnerable to attack, most work products, because they involve communications between systems, message formats, or system settings, open potential channels for exploit. For example, IETF \[RFC3552\] lists “eavesdropping, replay, message insertion, deletion, modification, and man-in-the-middle” as well as potential denial of service attacks as threats that must be considered and, if appropriate, addressed in IETF RFCs.

In addition to considering and describing foreseeable risks, this section should include guidance on how implementers and adopters can protect against these risks.

We encourage editors and TC members concerned with this subject to read Guidelines for Writing RFC Text on Security Considerations, IETF \[RFC3552\], for more information.

The MQTT SN protocol is optimized for implementation on low-cost, battery-powered devices with limited processing and storage resources. The capabilities are kept simple and the specification allows for partial implementations. Device identities are typically created at manufacturing, eliminating the need for special configuration at deployment. MQTT-SN can work in isolation from other networks or in conjunction with MQTT.

MQTT-SN Client and Gateway/Server implementations SHOULD offer Authentication and Authorization options. Furthermore, the confidentiality and authenticity of the MQTT-SN messages can be provided by the underlying transport or can be obtained by encapsulating the MQTT-SN messages into the PROTECTION packet.

Applications concerned with critical infrastructure, personally identifiable information, or other personal or sensitive information are strongly advised to use these security capabilities.

**Industry specific security profiles**

It is anticipated that the MQTT protocol will be designed into industry specific application profiles, each defining a threat model and the specific security mechanisms to be used to address these threats. Recommendations for specific security mechanisms will often be taken from existing works including:

[\[NISTCSF\]](\#bookmark=id.2pcmsun) NIST Cyber Security Framework

[\[NIST7628\]](\#bookmark=id.14hx32g) NISTIR 7628 Guidelines for Smart Grid Cyber Security

[\[FIPS1402\]](\#bookmark=id.3ohklq9) Security Requirements for Cryptographic Modules (FIPS PUB 140-2)

[\[PCIDSS\]](\#bookmark=id.23muvy2) PCI-DSS Payment Card Industry Data Security Standard

[\[NSAB\]](\#bookmark=id.is565v) NSA Suite B Cryptography

 

# **Appendix D. Acknowledgments** {#appendix-d.-acknowledgments}

\[Required section.\]

Note: A Work Product approved by the TC must include a list of people who participated in the development of the Work Product. This is generally done by collecting the list of names in this appendix. This list shall be initially compiled by the Chair, and any Member of the TC may add or remove their names from the list by request.

Remove these yellow notes before submitting for publication.

 

## **D.1 Special Thanks** {#d.1-special-thanks}

Note: This is an optional subsection to call out contributions from TC members. If a TC wants to thank non-TC members then they should avoid using the term "contribution" and instead thank them for their "expertise" or "assistance". 

Substantial contributions to this document from the following individuals are gratefully acknowledged:

 

\[Participant Name, Affiliation | Individual Member\]

 

## **D.2 Participants** {#d.2-participants}

Note: A TC can determine who they list here, however, Observers must not be listed. It is common practice for TCs to list everyone that was part of the TC during the creation of the document, but this is ultimately a TC decision on who they want to list and not list. 

The following individuals were members of this Technical Committee during the creation of this document and their contributions are gratefully acknowledged:

 

\[Participant Name, Affiliation | Individual Member\]

# **Appendix E. Revision History** {#appendix-e.-revision-history}

\[Optional section.\]

Revisions made since the initial stage of this numbered Version of this document may be tracked here.

Note: If revision tracking is handled in another system like github, provide a link to it instead of using this table, if desired.  Remove this note before submitting for publication.

| Revision | Date | Editor | Changes Made |
| ----- | ----- | ----- | :---- |
| WD-01 | \[27th February 2020\] | \[Andrew Banks\] | \[Merge Initial Document and Input Specification\] |
| WD-02 | \[4th April 2020\] | \[Andrew Banks\] \[Rahul Gupta\] | \[Terminology, DataTypes, CONNECT packet\] \[Specification Diagrams\] |
| WD-05 | \[21st February 2021\] | \[Simon Johnson\] | \[Packet Diagrams, Bit Tables, Field Definitions\] |
| WD-06 | \[10th March 2021\] | \[Simon Johnson\] | \[Sleeping client operational behavior, Terminology changes, 13 JIRA resolutions added to specification, Section numbering changes\] |
| WD-07 | \[15th March 2021\] | \[Simon Johnson\] | \[Added 4 byte (32 bit) integer description\] |
| WD-08 | \[26th March 2021\] | \[Simon Johnson\] | \[Added max packet size to CONNECT, Added Session Expiry Interval to CONNACK, Removed ZigBee references, Removed capabilities flag from CONNECT, AUTH packet added along with Authentication operational behavior. Standardized page margins\] |
| WD-09 | \[05th May 2021\] | \[Simon Johnson\] | \[Added long topic type to topicIdTypes, updated PUBLISH to accommodate new topic type, added topic type matrix\] |
| WD-10 | \[October 2021\] | \[Simon Johnson\] | \[Document format aligned with core specification, removal of introduction, addition of packet ID table, adding error code\] |
| WD-11 | \[October 2021\] | \[Simon Johnson\] | \[MQTT-SN Architecture moved into operational behavior, removal of variable integer definition, addition of session state section, normative comments added to sleeping client operational behaviour\] |
| WD-12 | \[November 2021\] | \[Andrew Banks\] | Rework 1.5 Background |
| WD-13 | \[November 2021\] | \[Simon Johnson\] | \[Move Authentication and Retained messages into operational behavior, rationalized tables and figures, separated packet definitions of similar structures into distinct sections.\] |
| WD-14 | \[Decmeber 2021\] | \[Simon Johnson\] | \[First implementation attempt, Fixed table references, Fixed PingResp packet\] |
| WD-15 | \[December 2021\] | \[Simon Johnson\] | \[Tara added as editor, return code additions\] |
| WD-15 | \[February 2022\] | \[Tara Walker\] | Changed Return Code nomenclature to be more consistent w/5.0. Added Reason Codes to each control packet type |
| WD-16 | March 2022 | \[Tara Walker\] | Updated WILL\*Types to correct Packet Type. Added Global Flags Table to Section 2\. Updated each Control Packet Flags in Section 3 adding missing Flag Sections. Formatting: Auto update of Table numbering, Auto update of WD Revision numbering for footer. |
| WD-17 | April 2022 | \[Simon Johnson\] | Updated use of topic name and topic filter to be aligned with MQTT 5\. Topic alias becomes topic alias type. Added quality of service protocol flow as it differed to MQTT 5 (inflight). Conformance references removed as these will need to be wholly owned OR externally referenced. |
| WD-18  | June 2022 | \[Tara E. Walker\] | Updated items based upon the feedback from Alex Kritikos. |
| WD-19 | August 2022 | \[Simon Johnson\] | Remove change tracking as document was becoming unworkable. |
| WD-20 | September 2022 | \[Simon Johnson\] | Integrate feedback from committee meeting relating to the work by Miroslav Prymek. Added resolution of CONNACK session present per MQTT 585 |
| WD-21 | October 2022 | \[Simon Johnson\] | Client States section added to describe the 5 states. Updated the state transition diagram to accommodate new disconnect field and new transitions between Awake \-\> Lost and Asleep \-\> Disconnected. Security section added. Figure 2 – MQTT-SN Architecture diagram updated. Font updated to Arial from bespoke font. QoS \-1 – Section added to the QoS chapter (NOTE: updated text to allow for bi-directional \-1 PUBLISHING). Introduction of Exponential backoff algorithm. Applied issue issue 587 (max messages set in CONNECT flags). |
| WD-22 | November 2022 | \[Simon Johnson\] | Integrate MQTT 591 (sleep behavior) Replace instances of “return code” to “reason code” PINGREQ timeout aligned with Tretry (15 seconds) from the ill defined “reasonable amount of time” Exponential Algo fix (using the factor n assuming it was the product\!) Client Identifier size clarification. Publish variants added; distinguish variant based on QoS field to save 2 bytes for single flight PUBLISH packets. Incorporated B4. Into retry timer. |
| WD-23 | December 2022 | \[Simon Johnson\] | CONNECT Client Identifier Informative and Normative définition update. CONNACK Client Identifier Informative and Normative définition update. CONNACK reason codes updated. KeepAlive boundary specified removing 0 as an option per the committee call. Added Session Expiry “reasonable” setting statement. Added sequence diagrams for CONNECT, CONNECT with WILL, CONNECT with AUTH. Network Connection Section (IANA Omitted but we need to add this to agenda) |
| WD-24 | December 2022 | \[Simon Johnson, Davide Lenzarini, Ian Craggs\] | Removal of Network Connection references. Modified PUBLISH \-1 & 0 tables to remove topic length field Modified PUBLISH 1 & 2 tables to remove topic length field Changed Data field description on the above Updated sleeping device section Ensured the references to the Packet Length and type section was consistent in all packet types.  |
| WD-25 | January 2023 | \[Simon Johnson\] | Broken out PUBLISH \-1 into its own packet type Disconnect flags field moved and added existence flags for optional fields Introduction titles changed to better sign post where the information resides in the document |
| WD-26 | May 2023 | \[Simon Johnson, Davide Lenzarini\] | Backwards compatible PUBLISH \-1, new OOS Publish message to repace it. Removal of security section to allow to rewrite. |
| WD-27 | November 2023 | \[Simon Johnson, Davide Lenzarini\] | Network Transport Layer chapter updated to define the impact of lower layers features on the MQTT-SN protocol. Replaced the term MQTT-SN “connection” with the term “Virtual Connection”. |
| WD-28 | December 2023 | \[Davide Lenzarini, Stefan Hagen\] | Ensured document structure is intact and replaced table footnotes with simple text tags and a subsequent notes listing. |
|  | February 2024 | \[Ian Craggs, Simon Johnson\] | Issue 560 resolution \- full reason code table and add reason code fields to PUBREC, PUBREL and PUBCOMP. Duplicate reason code tables removed from packet descriptions. Will Data Sent in CONNECT Auth Data Sent in CONNECT & CONNACK Suback granted QoS 0,1,2 now reason codes not flags. Moved PUBLISH \-1 to new Backward compatibility appendix |
| WD-29 | March 2024 | \[Ian Craggs, Davide Lenzarini, Simon Johnson\] | Update Terminology section. Add Operational Behavior sections from MQTT 5.0. Workshop revisions to Operational Behavior responding to Davide’s review. |

# **Appendix F. Implementation Notes** {#appendix-f.-implementation-notes}

## **F.1 Support of PUBLISH WITHOUT SESSION** {#f.1-support-of-publish-without-session}

Because PUBLISH WITHOUT SESSION could be sent at any time by clients (even with no Virtual Connection setup) a transparent GW needs to maintain for those packets a dedicated MQTT connection with the server. An aggregating or hybrid GW may use any aggregating MQTT connection to forward those packets to the server. 

## **F.2 “Best practice” values for timers and counters** {#f.2-“best-practice”-values-for-timers-and-counters}

Table 30 shows the “best practice” values for the timers and counters defined in this specification.

| Timer/Counter | Recommended value |
| ----- | ----- |
| *TADV* | Greater than 15 minutes |
| *NADV* | 2 \-3 |
| *TSEARCHGW* | 5 seconds |
| *TGWINFO* | 5 seconds |
| *TWAIT* | Greater than 5 minutes |
| *TRETRY* | Implement [section F.4](\#f.4-exponential-backoff) with a starting value of 1 second after an initial wait period of 5 seconds. So the first retry will be \~6 seconds. |
| *NRETRY* | 3 – 5 |
| *MBACKOFF* | 60 seconds |

Table 30: “Best practice” values for timers and counters

The “tolerance” of the sleep and keep-alive timers at the server/gateway depends on the values indicated by the clients. For example, the timer values should be 10% higher than the indicated values for periods larger than 1 minute, and 50% higher if less.

## **F.3 Mapping of Topic Alias to Topic Names and Topic Filters** {#f.3-mapping-of-topic-alias-to-topic-names-and-topic-filters}

It is strongly recommended that in the gateway the mapping table between topic alias and topic names is implemented per client (and not by a single shared pool between all clients), to reduce the risk of an incorrect topic alias from a client matching another client’s valid topic, and thus causing a publication to the wrong topic, which could potentially have disastrous consequences.

## [**F.4 Exponential Backoff**](\#f.4-exponential-backoff) {#f.4-exponential-backoff}

The following error handling strategy should be used for networked devices to avoid overwhelming recipient network entities whilst providing for efficient reestablishment handling. The client shall periodically retry a failed packet with increasing delays between attempts, constrained by a max retry time and interleaved with a suitable seed of randomness.

**Algorithm:**

An exponential backoff algorithm retries requests exponentially, increasing the waiting time between retries up to a maximum backoff time. For example:

1. Initial packet sent.  
1. If the operation fails, wait 1000 \+ (random number) milliseconds (ran) and retry the operation.  
1. If the operation fails, wait 2000 \+ (random number) milliseconds (ran) and retry the operation.  
1. If the operation fails, wait 4000 \+ (random number) milliseconds (ran) and retry the operation.  
1. Continued, up to a maximum backoff *MBACKOFF*.  
1. Continue waiting and retrying up to some maximum number of retries, but do not increase the wait period between retries.

The wait time is min(((2^n \* sf) \+ ran), max) with n incremented by 1 for each iteration (or operation) and the scaling factor (sf) being set to some reasonable value (suggested 1000 as in the example above). 

The random number helps to avoid cases where many clients are synchronized by some situation, and all retry at once. The value of the random number ran is recalculated after each retry. The random number (ran) should be no larger than the scaling factor (sf).

# **Appendix G. Notices** {#appendix-g.-notices}

\[Required section. Do not change.\]

Copyright © OASIS Open 2024\. All Rights Reserved.

All capitalized terms in the following text have the meanings assigned to them in the OASIS Intellectual Property Rights Policy (the "OASIS IPR Policy"). The full [Policy](https://www.oasis-open.org/policies-guidelines/ipr/) may be found at the OASIS website: \[[https://www.oasis-open.org/policies-guidelines/ipr/](https://www.oasis-open.org/policies-guidelines/ipr/)\].

This document and translations of it may be copied and furnished to others, and derivative works that comment on or otherwise explain it or assist in its implementation may be prepared, copied, published, and distributed, in whole or in part, without restriction of any kind, provided that the above copyright notice and this section are included on all such copies and derivative works. However, this document itself may not be modified in any way, including by removing the copyright notice or references to OASIS, except as needed for the purpose of developing any document or deliverable produced by an OASIS Technical Committee (in which case the rules applicable to copyrights, as set forth in the OASIS IPR Policy, must be followed) or as required to translate it into languages other than English.

The limited permissions granted above are perpetual and will not be revoked by OASIS or its successors or assigns.

This document and the information contained herein is provided on an "AS IS" basis and OASIS DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE ANY OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. OASIS AND ITS MEMBERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THIS DOCUMENT OR ANY PART THEREOF.

As stated in the OASIS IPR Policy, the following three paragraphs in brackets apply to OASIS Standards Final Deliverable documents (Committee Specifications, OASIS Standards, or Approved Errata).

\[OASIS requests that any OASIS Party or any other party that believes it has patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable, to notify OASIS TC Administrator and provide an indication of its willingness to grant patent licenses to such patent claims in a manner consistent with the IPR Mode of the OASIS Technical Committee that produced this deliverable.\]

\[OASIS invites any party to contact the OASIS TC Administrator if it is aware of a claim of ownership of any patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable by a patent holder that is not willing to provide a license to such patent claims in a manner consistent with the IPR Mode of the OASIS Technical Committee that produced this OASIS Standards Final Deliverable. OASIS may include such claims on its website, but disclaims any obligation to do so.\]

\[OASIS takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this OASIS Standards Final Deliverable or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any effort to identify any such rights. Information on OASIS' procedures with respect to rights in any document or deliverable produced by an OASIS Technical Committee can be found on the OASIS website. Copies of claims of rights made available for publication and any assurances of licenses to be made available, or the result of an attempt made to obtain a general license or permission for the use of such proprietary rights by implementers or users of this OASIS Standards Final Deliverable, can be obtained from the OASIS TC Administrator. OASIS makes no representation that any information or list of intellectual property rights will at any time be complete, or that any claims in such list are, in fact, Essential Claims.\]

The name "OASIS" is a trademark of [OASIS](https://www.oasis-open.org/), the owner and developer of this document, and should be used only to refer to the organization and its official outputs. OASIS welcomes reference to, and implementation and use of, documents, while reserving the right to enforce its marks against misleading uses. See [https://www.oasis-open.org/policies-guidelines/trademark/](https://www.oasis-open.org/policies-guidelines/trademark/) for above guidance.

[image1]: <data:image/png;base64,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>

[image2]: <data:image/png;base64,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>

[image3]: <data:image/png;base64,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>

[image4]: <data:image/png;base64,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>

[image5]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAf4AAAC+CAYAAADUQG39AAAkWUlEQVR4Xu3dB/AU5fkHcJlYSJBIEgd1RFFIUEysI7EgShiJAaLIGDA6GAg6hDAUERMYVLAgRRSkSzU2QEJAqaOigN2oKKGOVJVqEBQViKDvf76v/2d977m9vne/Ld/PzM7tPru3d7f37j5b3n33CENERESJcYQOEBERUXwx8RMRESUIEz8REVGCMPETERElCBM/ERFRgjDxExERJQgTPxERUYIw8RMRESUIEz8REVGCMPETERElCBM/ERFRgjDxExERJQgTf8COOOKIUHZERETAjEBERJQgTPxEREQJwsRPRESUIEz8RERECcLET0RElCBM/ERERAnCxE9ERJQgoUj8me41R2zQoEHecM2aNVPuTW/WrFnKtIV0M2fO9N4Lr776ato0Qg9LjIiIKGpCkb0ksa5YscKLbd++3cYk8S9btswOf/XVV3Z43rx5drhRo0Z2GHF0Mo3u/v3vf6eM++abb7zPAoyrXbt2yvALL7zg9etEr4eJiIiiIBTZC0n0rLPOSkmm6O/du7eX+DF84MABbzz069cvLQHrYbFq1aqM4wDj9u3b5w2/++675qabbvLGffDBB2nfj4iIKGpCkb0kierE2r1795TE70fH9bDIJ/FLN3z48LRx8jps2LCUGBERUZSEIntJEsVp+1deecVs3rzZ1KtXr6yJ3030rvXr19vPRvz+++/3phXuTgARRVuDBg1spyE2adIkb1guPfptM2Qe+XbPPfdcyvtBzl6iQ30jgendukwSIypFKLKXTqwyrBP/t99+6033ySefmKFDh6athHpY6MSv+Y3zS/Ljx4/3XfmT7vDhw+bRRx9N2WgRhZ2sy6xfREkSihLkFmS3oLuJ/5FHHvGdbsCAAV5M4n7ySfyoZyAaN27sTa/f57cyxtHo0aPt79RHGPr3y3DHjh29Oy9w1sQdp7uJEyemxfR8icoN5Y31iyhpQlGCdKGWYTfxu+PcDonGlWmlyLXytWvXLm3eQr9v6dKlabE4ksSvf6uO6fEXX3xxWgzLt2vXrikxoaclqhSUvXXr1qWV5x49epTtMqMm69P777+vR3nvw+vXX3+dEiMqVllK0O233+4VZulOOukkPVkgxo0bp0MUECT+Tp06pWxoxowZY/r06ZOyQcLRu4b45MmTvWEmfgojtxzjcpX068uMfnRcDwud+HF0L52YM2dOyvZSLmvK+z777LOU70pUikBL0KFDh7IWyj/+8Y+mffv2OkwhhcSPU44PPvigPfUJeuPjbjBdt912mz3yF0z8FEZS9j7++GN79hDX7XG9P1fi37ZtW1pcDwud+N0ED4sXL/bGwaJFi9LWM+nH98r0OUT5CrQESWWXbHbt2sWCGxGS+EFviNzX1atXf/cGByorYYdBMPFTGOnEKsNu4kdZljorBw8eTEvcQg8Lnfg1jPviiy+8YeyE6PVM+H0uUaECK0GFFkZdYYzCRyd+JPJ7773XGwbE9MZzx44daeWBiZ/CSJddGWb9IoqzQErQ1KlTdSinSy+9VIc8qB0eJ3v37jVLlizR4bIIcqPgJn5cr8+0QZKNFTaUuJyjN17AxE+VwPpFRLkFssUtdsP99NNPpwwj4Rc7r0pDMsd3zZbQZZpK/ibc3iif+Y9//EOPLpsPP/zQ3HrrrWbu3Ll2GIl++fLlaiqi8mD9IqL8ZV5TCpBthcumefPm9hXJ091Djwr5vk2bNtWjbGM2Mr5u3bp6dFm5y/K0007To4liJ5/txtlnn51XPSSiuMu9tuQhn5XOj5ugpMNpufr165uGDRuac889166ol1xyibniiivsjkKrVq1MmzZt7BEl9uBxlqBz586mW7dutiZ53759Tf/+/e216CFDhpiHHnrInrKeMGGCTcZPPfWUPdOA22cWLFhgW8hCy1xvvPGGbWEL99KuWbPGbNiwwXz00Udm586dZvfu3fbWG1TscVsP7NChQ8p3x3dBkte/KajuyCOPNMcee6w5/vjjTZ06dczPf/5zu5zOP/98u4x+85vfmBYtWqS9D98TcH3w4YcfNtdee62pVauWN54oygopw2gSfPbs2TpMlCj5rzFZFLLiufxad0NCCjs0pIGmN+V+duncI3t3p6CSR914zoFO+ML9rtIRRZ1cXsoXyz0lXSBrQLErkr7GL0fLUeGX8DW55l4p+Kxs9Q70GYlNmzbpSYgio5h1C2fv8KwPLde6ExbYpkThe1J4Fb7W+Ai6Vj9O8YcdjqZx6SBfuLQQFu7RvrSrgNP/RFFTTOKHONcvIsolsJJe6ErD+/irlt//hceFIn7PPffoUUSh5FeO8+Eme+nKXb/oiSeeKGv9IqJ8FbfW+OjZs6fZunWrDvvCykVVC7caZnLDDTfYjQlu0SMKs2ITf40aNWxCd5Nnr169bNJF8kUSRjJ+/fXXbaXY559/3syfP99WDETyRhJHMkdSR3JHkh88eLDdab7rrrts/R/MDzsF2DlAYsbOAnYacHatZcuW5sorrzSXX365bdoaOxnY2cBOB7aPp5xyijnhhBPMz372M9tQ0DHHHGOqVauWtrOiO6J8BFpSLrvsMrtCZIPCidPLFH7yXHJuUCisii2bSMrCrfcSFW6yl0uOepgok8BLOo4SUfjwjOuVK1fa2PTp023slltuUVNTVCxcuND+hwMHDtSjiKqMXKsvxKRJk3TIQsJExbmwkzt3dIJ3dwbOO++8lHFErsATP8XfGWecYTcuOPUZBrhsgVOmstHDadT77rvPvPbaa2bPnj12mgMHDthTuLj1q0uXLuboo4+201avXr3g28EoXC666CIdygr/exy5iV86Ij8sGVQSbFywI1BpnTp1sp995pln2qReKuzEYH7HHXecHkUhx/pF35Hyy4RPubCEUCBwCQAbHFwSKCd8hjw4qFxQ2xqfk+mUMIUP6xd9fyZj0aJFagxRKiZ+ChSaEcYGKOiNz8iRIyt+JHPhhRfappEpGnD55uabb9ZhWzO/0mWnKrh36jRp0sQZQ5Qq/msDVRlsbFHJ00++laiwIa/qjTaO/Kv6O1D+cG88LgHhP2vdurUenQgsr5WFipannnqqXe75dO5dJVWBpYPKDvc2o7CjgSAhLaZlk2t8pZ144olmzJgxOkwUShMnTtQhCsgzzzzjJXE0xlQMNM4kbUnUrl1bjy6rcG1ZKfbQeAkKOtpKlxVHQ30BPGUwjORWKqKwYzkNFhI8lmm+ZysLtWrVKjt/tA5ZbiwZVCXQGpl76kvgkcOrV692pgwnfGdUAiQKKzQFHMQdL0kXx/pFlf01ROa7pKk7PI650itXqdBWwKBBg3SYKDSitk6FSZzrFwU/R6IilKNwVwIq9bA1Qwqrrl276hDlIWzbo6DrF4Xr11EihW0lK1TUvz/F2wMPPKBDlEVY12ecFS22IqEWzl9IiXH22WfrUCSFdWNBxLKZn7Vr15of//jHOhwqs2bNstf/S8USQVVm5syZge3BhgE3sBRG69atMzt27NBhcowaNcr06NFDh0Or1G1Nae8mKsHJJ5+sQ5GGWxSHDBmiw0RVrtREEWe4PW/y5Mk6HHql/KfFv5OoBKUU2jCL80NgKLruuOMOc+ONN+pw4mE7NHbsWB2OjGK3o8W9i6gEeBLeli1bdDg2il0ZicqJ5TJVkusXFf4OohIVU1CjBI8pnjBhgg4TVanHH39chxLthBNO0KFI2rhxoz2jU4h4b4EpdL799lszZ84cHY6duO/cUDSxXH4nbsvhD3/4gw5lFa9fT6EXtxUuGzTuQxQmzZs316HEwYNx4qiQbWv+UxKV6KabbjJ33nmnDsdWISsiUaW0bNlShxKlffv2OhQb+W5z8puKKAD5Fsq4mDFjhg4RVbmkrYeuJPz2fOoXxX8pUGgsXLhQh2LvvPPO0yGiKjd9+nQdij3WL/pe7imIAvDQQw/pUCLksxISVVoSy+Xpp5+uQ7H0r3/9S4fSJO/fpyqRxA0NXHzxxTpEVOXatm2rQ7H20ksvmZNOOkmHYyvX9jb7WKKA5CqIcbVnzx57ipEobC699FIdiq2kbX+uvvpqHUqRrKVBVWbEiBE6lBhdunTRIaIql6RkeMstt+hQ7N1999065EnOP09VJulPBkvSBpaiZfz48ToUO6xflC7zGKKADBo0SIcKtnz5cluQ3a7Qx2hmWxHKqao+lyiXSpbN0aNH+36erM+iZs2aaeu6njbfDo/+dt+fJNnqF5Vlidx+++1pf0CSKlZQqiBaypLEL/AI3EJX6EKnD0pVfS5RLm+//bb58ssvdbgsJPH379/fi+GMg+QIaNy4sU38LiQwvQ61a9fOdO3aNSUGq1atSptWDydFtvpFgS+Ro48+2tx88806bF5//fXE/gFJd+qpp+pQwXTiBxlG07iTJk3yhj///HNvY9KpU6e06aX/s88+s/1yhHHBBRekjB84cGDaZxYjiHkQlUvDhg11qCyQ+FHfRa+HvXv39mJ4PXDggDde6HWokMT/pz/9KWU4STJdygl0i6QXuB88CrFRo0Y6TDH2gx/8QIcKJom/adOmtvygv0GDBnbc1KlT7bDs3aJ/5cqVth9JXZoJdjcuUu8A/dhYgLvzgNcWLVrY/lLls14QVZXq1aubd999V4cDh8SPZrvd9QH93bt3T1nv/Oh4IYk/yXWMfvrTn+qQ5b+Ui6AXdjavvPKKmT17tg5TTAWZ+MU999xjh3GaEolfjuznz59vWrdu7U0H7kYFXceOHVPGYa9YulwboGIEOS+icqhEGZXEjx135IDNmzebevXqlTXxP/nkk87Y4qxbt84eZEg3dOhQPUlOcpBSaXq5Cf9oEebOnatDWWX6QlGwd+9eHaIsynWqHxsRJHkk/j59+tgY+hF3uRuV/fv3p8xHz1NkihcjyHlRbsuWLTNnnnmmXe56J5D8jR07VocCJ4kf8N/IeqETv3tdetSoUV7clW/iL/RxtX70tqdOnTpp3yeXQqcPSqbP9Y8WKNPMs9m3b5+toKVhXtgTDDt8zyVLluiwr1q1aulQ2eB74XR4LljGxfxvufjNsxwrHzZUGJYjfkn8gDgqtgBO9cvZJXk/zgpIP16/+uor2+9uNPx+R7GCnBdlxvpFpSn3Mson8T/yyCMp3wPbMgwPGDDAi0G+ib9cBx0yHNX6Rf7RAmWaeS7ybGgkUFlYxc6r0jp06OB930yJ9rTTTqv4b8LZiGzL0l3W+A1BO+6447z5y45REKfb/vOf/6T8rm7dutmdR3jsscdSHvf7xhtveNO1adPGi7vLA/3yvfyWl9+yK1aQ8yJ/+Sxj1i/KTm7/ymdZFmPcuHHeZTbUnznnnHNsf69evVI+c9GiRSnr5JQpU9K+Ex6t63c7L07Lu9MGeZkxTvWL/KMFyjTzXGrUqOHt0UlXjmRULu73dpcB9gLdOIaDcPjwYXuEu3v3brN161azYcMGs2bNGlswcVSD9qjxBDz9vaQFJx0vB73jgf83yZVroFzLmr7Ts2dPuz7ko379+jqUaO+9917KMJZPGMsrdhqKEcRvkcSv2xcAJP6zzjrL9q9evTrlVkScSZTp5P2ysyMxlzttUDLNyz9aoEwzzwWJH/d4uwsz6olfTqG73R133GHuu+8+M2zYMDNy5Ej7vGQcpT799NPm2WefNc8995y9LonkjUKGZL5p0yazfft2e8r6iy++MIcOHVKfnpn+/Exx7EDs3LnTbNu2zXz44Yf2M9evX2/Wrl1r91qxUXjnnXfMW2+9ZV577TXz8ssv252L559/3u5g4JT5M888Y2bNmmV/y1NPPWV/l/4c7AywyV4ql4suukiHsnLXCTL2NLpeZ+MiU632Qvid6sepeZypcC8zYjn269cvZTp5H16bNGmSMh+9zN1pg5JpXv7RAmWaeS5YcMLdAYgC/Wf5cU97V4p7CSITWdblqHvgLhe3EmS27xNn2RrRoNLJ5cJC4LSqH1yaisKBR6ZLi5no6+Oa3xlBP4V+biVhW+NX56ocjYcBhidPnpyS+HHWyZ1u8ODB3rV7iaNioJwh8JunX7wUmeblHy1QEle+QgoUdgAqdSdAId+rbt26OlQy/FY/mQpg3GVrNpNKV2y5cg863MuNUZArQYt8pgE54seBgN97orJ85Du6Oyjlai7cvcavKxa7nRt3+3HZFjsO7rQ4w6unLVWmeflHi8DTbZQNH5RB5VDs8o1r/SJdUTrX0b5wz04eddRRNpbpM8KK9YvSZfrf/KNFYAUbyoWPxqSgZdqw5ZKU+kW4qwVtGVxzzTX2Ge2tWrUyLVu2tLXGr7rqKvPb3/7WXHnllfaUtPs+d0dAOtQ1wm1ouHyF+kG4HVvqCH388cdePaGNGzfaukKoYY/6Sqi5vmLFCvP+++/bo2c8HwD1hnD3zauvvmrrDi1dutTWH1q8eLGt84Sa/QsWLDDz5s2z9aDmzJlj6xLhoTszZsww06ZNs3flPP7447byNGr+S814t2P9Iv/6RcWtNRlIAcyGt9QkVz7lI06wgaLyKrZMxeVWYr9Le+74fK/Lu8vAPUtQ7tt/g4QdHPmu7iXHX/7yl85UyYIdLD+Bl3Q2okGZoPEO9377uGN5L79ilnFSGg+THYBc5MyHJHy/98gOQJjpnRY3nkRu3QOtbEuEzWaSnySthEG130DZsbnw7PySoUvffRPF5ZNtRwiXM5Io2/+YeQxRGeDWNlyvi7tsKx0Fq5BlzQeE+dMV4+IG7Y4kzXnnnadDnvj9wxR6cdywuM444wzbSBNVTj5livWL/LkJv1q1ankty6iJ42/KJlf9omQtDQoNtLUdVzfccIMOUQWwflFpUMMeNfbjuKxYvyhV9rFEZeJXGzkOcq1wVH6sX1QcKbuomxKFSo6FStK6mat+UXKWBIXOySefrEORhpriQ4YM0WGiSMClEJGtslxUJeV+fjwTIBcmfqoyaIwDjXTERZKOKChe8JjrJEjCOorHwecS/6VAoeYeZURZEjYoFF9JKb94ouiWLVt0ODZQzyUfyfi3KdSivtGJ+venZEP5RdO7SRHX9RVN4ePR7/mI5xKgyMHKiKdVRU1cNyKUHJdddpkOxV7S6xdxq0VV4r333jPXXnutTZzo0Lb2qFGjTI8ePfSkocWkT1GH29ySKOn1iwqbmqhEqFkryd7tpNnQ448/3qxevVq9K3zwnV944QUdJoqUQhNGnMTltzdu3FiHcorHL6fIQfvhbuJ3DRw40D42NIzk0adEcTBmzBgdSpSor8uDBw8u6sxFtH81RRZWuLp162Zd8bKNqwonnnhi4jeUFB9HHXWUDiVS2LYz+UIjPThIKkY0fzFF1vDhw82vf/1r24+Cm2ulQxOsuaYpt0mTJlX5dyAKWoMGDXQosaK2ft93331m0KBBOpy3aP1aijSsXBs3btThvIwcObLiK+eFF15o6tSpo8NEkde7d28dSrwk1S+q7JaUEql79+7m+uuv1+Gi4HoWCn6uZ4wXa9WqVXb+bdq00aOIYqPSO9FRkZT6RcHMhSgDXBPP9lzoYnXq1MmuBHgYy4EDB/TogqFFL8wPtxUSxV3//v11iP5f27ZtTceOHXW4Sn366aeBJX0Ibk5ECgrq2rVrdThwuBXw8ssvt5+HrmXLlvYa2GuvvWYfMwrYOVizZo2ZO3eu6dKli23aEtNWr17dxoiSIm6N15QLtg933XWXDlccvse4ceN0uCRM/BQ4XD8Mcu+UiIJTq1YtHaIssC2bNWuWDpcdPrdcFTC5daZAobAePHhQh4koBIYOHapDlCds28rd0iEq7eFzcCdROTHxUyB27drFo3yikOM6Wro41C9iKaCSNWvWzNx77706TEQhsn//fvP222/rMJUgqvWLmPipJDyCIIoGrqskWBKoKNjT5YaEKBrQcBbXVxIsCVSw3/3ud+bOO+/UYSIKKSZ9crE0UEG4ASGKnj59+ugQJRi34pSXF1980RxzzDE6TEQhV69ePR2ihGPip5xq165tZs+ercNEFAE//OEPdYgSriyJ//bbb/dub5DupJNO0pNRyE2ePNneq0pE0fTwww/rEFHwiR/3KOIZ6trrr7/O68MR8sorr5hq1arpMBFFCLe55CfQUpFPITv77LNNo0aNdJhC5JRTTjEzZszQYSKKmD//+c86RBRc4s8n6QscTfKacTgV8j8SUXhdfPHFOkRkBbaVL7TpQSaYcMH/ccEFF+gwUeQsW7bM1k1BmW7durUenRjcxlImgZSMYgrYvn37zCeffKLDpmPHjqZDhw46TAHS/5ceJooi1i/63rRp03SIyBPI2lDsStW8eXP7Ks2/Shd2xTzPesmSJTpUFvl8jizjXr16meuuu06NJYqefLYbSapflM/yoOQKpHQUW8hq1Khhj/DdpF+3bl09WejgjEQhv7mYHYVi4Xs1bdpUhz1Yvpjm/vvvN7/61a/0aKLI6dmzp9m6dasO+6pfv74OxVKrVq10iMiTf/bKopAk6ELil0Qk3fXXX286d+5sfv/739trzieeeKJtMc6dJlt37LHHml/84hfmoosuMtdee63p2rWrGThwoJkyZYpZtGiRWbFihfnoo4/M4cOH9dcpiPuZOGPh57TTTvOmqZRsZ08effTRlHF33313yniiKMK6Xgi9XsSF/K5rrrlGjSFKFcgaUOyKhFPNIlOyKqedO3ea5cuXm/nz55tJkyaZBx54wNx6662mXbt2pkmTJvboAK1eud8tWyd0HDseeKgNGjbC0clf/vIXe9YAOzmofHTVVVeZK664wlxyySXm/PPPNw0bNjSnn366bfToJz/5id2ZOfLII9PmW0jn972k27x5s/fdiaJELhcWAut6JpU8Oxc0d51eunSp3bHH9oZICyTLBrny4QxAFBKRu5INGDAgZZxcCpAOR9qV5JfU8R3R5VMHgCgqUMaL4R50uGfCwi7T2UVw1/uq2O5QdARW0pN0ui3fjYR72r1S5POY4CkJil234li/yP0t2XYQiPxLUBFYwSYzrIT6rAARlS5TEswln/pFuNQWZP2iN99809YvOnTokP46BXE/003wEiPKJdBSctlll5knnnhCh1OgYO7atUuHiYgKVmyiq+r6RdgGvvfee2bBggVe/SJ8J+x8SP2iH/3oR2k7F5k6OPfcc9WnEPkLvKSzEQ0iqpRitil+jYfh0lgx86oKOulHoU4UhUvZSjqbzSSiSgiyufARI0boUKjgkiG+P4/uqRSZ1wAiogjIlsi1qD8gjLfnURDyX2OIiEIqn+SfpCZ7ibLJvbYQEUUA6xcR5YdrAxHFCusXEWXHxE9ERJQgTPxEREQJwsRPRESUIEz8RERECcLET0RElCBM/ERERAnCxE9ERJQgTPxEREQJwsRPRESUIEz8RERECcLET0RElCBM/ERERAnCxE9ERJQgTPxEREQJwsRPRBQDeAxxGDsKH/4rRERECcLET0RElCBM/AXQp7DiciorDr+BiIjyU/IWv1u3bilJ8KabbvLGSUIpNrFMnTpVh0KhXbt2pmvXrimxQ4cOmXXr1nnDe/fuNU8++aT59ttvvdjBgwft63PPPefF4PDhw2bixIlm06ZNKXF44oknzIEDB1Jib775pnnxxRdTYpgG32HlypVe7KWXXnKm+G4a2LJli9mzZ4/t//rrr+3/oz+DiIjiqbiM/P8mTJhgk8aiRYvs8IcffpiS5KX/4Ycf9mKFKHaHodx04v/ggw9Mq1atvO9br1493zMCbixTvEuXLmkxdJ9++qmN55p33759zVdffZUyzfbt271pOnfu7MXXr19vzjnnnLR5ERFRfJW0tUeyaN26dUrsuuuuM4MHD/bGu6/QqFEjO1yzZk0vhmHZaZBp582b5w2/8MIL9ghVhnfu3Om9tyr4JX73N7r999xzj7fjg7gcWeP3Y4dp0KBBdpmJCy64wJtW7N+/33dZot+dtxvv1atXyrC83njjjbZ/7dq1vvMkIqJ4K2mLnyth6MRSp04d07t3b9v/3//+N2U8jjxhw4YNae/L1l8V/BK/JGxAssd3lM4vOePIG6fxJS7du+++mzatO5zPvN3x0kkclwPc6dxXIgo3rKtyYBUmcll22LBh3J5EQEn/UK4/WCcWvI4fP97r9HjhF5cEJsmyKuVK/O73btu2rW9ylsT/9ttvezHw++2Z4uj3mzf6d+/e7Q0vW7bMi7v85kkUJbJd0GW4QYMGKa9xsGTJElO7du203xoGYfxOlFlJ/xb+7B49eqTEcA16zJgx3ni/V03HM02PinJIpDpeafkk/gEDBpiBAwfa/jZt2nhxIYn/2WeftfHPP//cTJkyJeW3Y1kuXLjQ9uNIX+LYWcAGLdO8Zdz7779vNxRyWUUvN/ezxo0blzKOKMySWL/IXV9dV111lY1JJ9sinGF143369LFxGca2BRV93Wn+97//2Wn+/ve/ezGZj/te6XTMPeLX086dOzdt3thWoSI0VVZJpfvqq6+2f97GjRvtMGqby58ObgGQV1yvB5xy1uOFG5dT037zDSvU3kcixbV5mD9/vpoi1bZt2+w1edwFIOQ3YkX6+OOPvTjmPWLECNuPZZNt3tjx2Lx5sw77wk4CUVRg/Uha/SL5fs2aNTNNmzZNi0s/Er9bL0jibuJ34y4ZduM4iPGLN2nSJO3SpE78bp0mv3mgn4m/8lL/9SJIbXbp5syZ443Tf7Rc15duyJAhKeOFDKNwox+3v7nv09PHURJ+I1GxsH7InS5+9LZn5syZtn/s2LHenTEyHh2OQuXIFjvLeB09erTd6Ub/XXfdlXJ5stIWL15sPxtnF1999VXve3z22WdpOzJI/Diax9lRN54p8Rdy+RUmTZpkKwkjlivxC7mbSMexzJn4K69qSjHlpFc8IvpervVDJxk9fSFx9CPxViV8h379+nkdhlFRGmcrcDnPnQ6Jf9q0aWltqmRK/H7cuNweLPG33nrL9uPArNTEj34m/srz/9eJiEIMCQO3pLr+9re/eaf/dZLBq+7c8SJTXCrV6Xil6M91K/nJKxoCQ7++JVjOtGZK/EjssGrVqrR5Sj+6HTt2pMWZ+KOpakoxEVEJJBnp2DfffOP1+72KQuKZ+ivlr3/9q72e7kJFZ/ku+/bts/2YBq/Nmze3cdS9wrBcjkWbIaB/A4alE1iOEsN1ehkn1+rxivoOEsfOBvpR/0hi7vxQGVqGZd64hRun+rHDQpVV+VIcc8uXL/ddkYgoWKxf9B33O6H/jTfe8I0X0iy3+14si6FDhzpjS6O/F1Uel3qA5NqbwLWwfAp2PtMQEfnp2LGjt1Miz+AA2XlBV+hRNXaM5L04Kg+SO28cKFHlMeMEyC+B4x5bubaGW2zk2px7b710Qobl1kf0r1ixwut39+hlPn5t7rv9qNXs1v4lIqJkSs9UVDS/xO9y93Lx+uijj9rGjtCPW4dkGuwc4H5kmR8a70GjQTIeOxPSj0aA5D5kzBfJHUcAMl6gHy1/ERFRsmXPVFQQN9GikQ1J9BJ3G/9AZRddA1n3oyastIwocXd+8vrll196DR099thjXhw7CGh8w52WiOILZwmzNepFBMwGAfJLrtIKGEjSxlF5//79MyZ+t8MOhMTRPOk///lP279mzRrvyF4aJ0GHMwB6ftgx8PtuRBQPqMmPdRwN68g1f3kSZzbcLiQT//UAYSXSe9uSkKVfIOlnSvwClXMmTpxo+90mLxs3bpzxPWibXI9Dx3tlieLLL4HrGJrlRot+Qm7Tcyv+4YBC2uuXafz60XS4WLdunX3miMDZx6+//tobLuRuAqqM9NJCJZFEK90777zjrYBu3L2GLzG4+eabU6YT0l44uPfVgvvQC2lKUx7eIw8KIqJ46tu3r2nRooUOp8A2AM8DkdsTAfWK0O9WFkaNe2kPQGLuPHQ/Dkjw2S+//LLveN1P4cB/JObw4B/9MBMiig8kVrSf7w5LJ0fmaMfAHa/7hw8f7l06dOMdOnQwkydPtncm4V5+dO7lRLfekt98v/jiCyb+EOI/EmO4TICVDq18EVE8tW/fPiVpCzfxu7f7+iVoOcrX02CHQTcP7D7qe/Xq1WnvkelwCzLuRnrwwQe9OIUDE3+MoSIgHvlLRPG1adOmlKQrJPHjaD3bY3wBlwtuu+02L75s2TKv303q0i9PRvSbF+Aav94ZoPDgv0JEFHGSZNFWvjwoB0flSPxyah63+kntf2kxD/1u42CoA+A+UMedt+6X4enTp5tOnTp573fHMfGHE/8VIqIYQMugd999t5k6daoeZSsZy/MJYOnSpfZ18+bNKbX4cXnQrfmfD1RUFjrxb9myxRum8GDiJyKiQGHngUf74cV/hoiIAjVlyhQdohBh4iciIkoQJn4iIqIEYeInIiJKECZ+IiKiBGHiJyIiShAmfiIiogRh4iciIkoQJn4iIqIEYeInIiJKECZ+IiKiBPk/UXeeCFSAWzIAAAAASUVORK5CYII=>

[image6]: <data:image/png;base64,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>

[image7]: <data:image/png;base64,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>

[image8]: <data:image/png;base64,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>

[image9]: <data:image/png;base64,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>

[image10]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAEeCAMAAACe6QFUAAADAFBMVEUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7DA2EAAAAyXRSTlMAAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiQlJygpKissLi8wMTIzNDY7PD0+P0BBQkNERUZKS0xOT1BRUlRVVlhZWlxdXl9kZ2hpbm9wcXN0dnd4eXx9fn+AgYOFh4iJjI6PkJGSk5SVlpeZm5ydnp+goaKjpKWmp6ipqqusrq+wsrO0tre4uru8vb6/wcLExcbJysvOz9DS09TV19jZ2tvc3d/g4eLj5OXn6Orr7O3u7/Dx8/T19vj5+vv8/f4GLVvuAAAKr0lEQVR4Xu2de1AV1x3Hf0RBEBRQmFYxETsyFTW1WK1OS6Y1MdUqCUk0+CCTJqNRq1VTRcmQmJmOwVSjaSrWRxsntZU2QApFbeqI1vjoJKRmEqcG2rE+xgZ8AAqC1SBId+/ei3fPbxe4eC7cs3w/f+y593fuLns/7NnnuedHBAAAAAAAAHACQa7p1IRrQrxzROeIERXp7ZqOTvhUiHeO0WJASQwn1z7eKcQ7xzwxoCT3iQEAJxbACQdOOHDCgRMOnHDghAMnHDjhwAkHTjhwwoETDpxw4IQDJxw44Rj3HkXmNudR6crj677z5fSmTcla4J0E13S7Ub3+m72zSuOXraCDk73ncgrWTujRvPDrRAPnRj7z25d6rT+3vSnINXXXXklvGkE0NuG0aR7HYNN2/jI/u5m+kV1Zvijk9q2W5ltNxtSoDIpLbPqIaEVOpHkmp2Dj5PDUWKI+N7XvHyZWEbWcW/rX+4muHvuhWOMMbJzUzkwnKtcayJk6sUojJ+2h32hF9iSxQs4Tke7GxomLhvRBI/aLQZ0Hw4aW6eWfxQpnYLOPNah9N1Q/3DB+Fnt9vl6WrBRrHMQ82wd4EWKgB9BW29FpEAM9gPac9ETghCPbSXCqGFGPNo87vpM2Z3CxGFMOmU6WPdlXDCmJPCcjZ6SIIUWR5mRjstE1jp4xx/1AteXJtTykOcnwbCe7hQr52J5gSkKaEyorq8P+hLH5D6kLxJiKyHRC1Tt3Bk8Tg+oh+5zttvqnJ9KdOAE44bTppLg0Si8WZ4oVzsbGyZRdRxcSLTHelB41V1LyHiHgLGyOO4k/uvu6IOrgh0TLJ4XMqqfFIwYtuDY8c2DBnt/f/YDTsHYS4boF7ebpxf20acILN3/8Bo3/ya303/1n/eqnveodh3Xb6V8rRiK3VzVMITp0ozlerPLCGb9VsXZSOdFVNFIvTySohmgy0U2iMKI77ss9xgQxoCTWTmjGY/2fIqqqGe8J1C77SlDrY7+q6DjPSydivT+hDbNW5xK1vLl02DYqjAwa9SxVbotqfcp3Om9HwS7vjzsR++c7viFpMe3g779i03Z6NHDCgRMOnHDghAMnHDjhwAkHTjhwwoETDpxw4IQDJxw44cAJB044cMKBE45xj7oiaZEQ7xzRYgB0EbhH3fXACQdOOHDCgRMOnHDghGPXkyRQSc0yymw/dqlTbTt53ygu+vOnGao5uW0UuY3msFRs+uQEEDu8hoU+fop+7fqZQwGRnCs0E0mnN+pF4DsRhoUuSg93dasj91gsMnFfSKnWduhqkTb5kxiVinJOKGcv7fXvkPHqOaGClkIxJBcFnfz7mHcvbz+goBNaJQYko6ITfwMnHDjhwAkHTjjGuX2GpFwzSQvFiIoYTpBrxhu0HQ6ccOCEAyccOOHACQdOOHDCgRMOnHDghAMnHDjhwAkHTjhwwoETDpxwrPtaKJVrZu7yN/NenT5hQMa33v/Ver6yw7b3PvtCfN4EmnTYe642sHaiVq6Zs4/uG32dVg58cV2dxcquTW8aoxU+rKxN22lMeLiZInIry6cRzzUzcG917UdE+wNlrOXqxoePNkd8P7e8YJrFyiZU1x7RSh9W1sZJ1uuziRLLiYZa5NipmZJ/7H6id/vOFmu6iazZWyixdzmdHyrWaCubmn9sg1b6sLI2baf2g0vzqTGMqMWcHCLn2/p4Yzk5QzKXEu1bY6rTKBUDEujAMmuL9HHTwiikxRwvpd05dCltyHLSV3arudIeGye0hebTmaQLdLbZFF7qLr9I0CYna1xDZHpxSngvg44s8z2iM01DLww6aw67h4v7Qu9AerJm3N9MlfbYOdFpmP6ada6Zwtjrz+vlEn/2UvWRhsdXbTzsNUplK5kp1z/RjzhLfOwEZzsWWco4MRLApBy4x7V1a2hrO9HYp1L+nX2X/yWGOkU7TtTKv/MPMdA5bI7FPRo44bTXdnwkbc5gqeOlllYVyekF4gtSncTIz4MQuyA8/5IY9DMynfgn/076zJK1Ysy/SHPiv1wzfVJS6LOu7BQmzUkrKp3RWCPNSYan7Uj9XY1+CfGlsm2H/JVrJlfpfSxV76yfM1gM3hvKH4uJ8vPFyL0h9WSno+A8lgMnnDadKJtrxu52UMew2Z9MmTssd4fn1lRpiFCbvPpxIdKtHO5b8/GWajHaeWy2k6zCx2pa33zyoVdNILJ2QaznRrEMrJ1EZBfXvdf6ztV2tsRGrCJ6J7zXs3c/FijcqW7UvsemcdSPXus3WM8M1H97hp6iPOLn2uv948i3EwRrJ4GUa6YDy1xxcID+i+MTVN9rUn2lnrn+rSsbKXJqVUOe9vroCaoUZmgb6/3J5VFiZMgrLdQU0WDkmrFlQkcePPhIB5a5teyJ143daqz2ffT/58XxcRVD6I9037wGqjB/uH2snTS/EnpkciFV1Ez0PK34/NxbV6Z6bs5eHhDn8x/yJ41VVe48OJcO9ev33CGil8PfnvP5gS1X4rVVvmP+cPtYO1Es18ya+jMvu1/+Ir+pRC9vrPvu3zfsirrS8SeiIrbPd3xE0mJM+GOZNrg1WO9jezZwwoETDpxw4IQDJxw44cAJB044cMKBEw6ccOCEAyccOOHACQdOOHDCgROOcY86+gE5vdD0H1Spj+HENQyzBHaLASVB2+HACQdOOHDCgROOik5kHSXtUNDJ15NHiiG5KOgkLWiGGJKLek6WpVDKMjEoFeWcDHhCmzwlRqVi0ycngBjjdSn22Sl6MpyM/mNyrtBMjLngKlTLXeUevmCT5H79JlRrO8FGkS52Y5aJak6mG8VX3X36gBt/93BTbTvpCuCEAyccOOHACQdOOHDCMa53piZcE+KdI9q/ifu6CMNJ3P/kPJnx99lU14C2w4ETDpxw4IQDJxw44cAJB044cMKBEw6ccOCEAyccOOHACQdOOHDCgRMOnHCsncx9m8JLkmnH4MTnKDj0ly+G9jam7uqVMVETKf6DBDpomsspWDtRK9eMbGyclHzvEaKvnSd6wKLzy9VFD+mDCR+YYpGHxgnYOCkKPe7u12XOq5JTWkrUsuJYVI6mJpMN7dqBvDAKYNfHL3ByzXQ9NtuJi4b0QSMss8k8GDa0TC/1EfMci+1YZAGZa8ZuZWVh13bcKJVrRhZttR0dpXLNSKI9Jz0ROOHIdhKcKkbUo519rG+4cs0Ui1HlkOnEP7lmuh55TkbOcMo1oTQnrfl3FpnjfuC8GJCMNCcZnu1Eaq6ZbkGaEyorq8P+hLF5s573TYyqh0wnGvlF08SQesg+Z7ut/umJdCdOAE44bTpRNv/OvWHj5Ehq5EyiJcabrevNlZS8Rwg4C5vjTlGxnmPcoCDqoCZl+aSQWfW0eMSgBdeGZw4s2KNndHE04v3YiB+4iiFebcc7/06P3E5utoiRUTGbKXpbw74blChWeTGPPfFREWsnzYmu5CSN1MsTqfjpxbvVd5Qb5cAnjC89lj41h2PWrOhzgm6cXxd9ggqThj9SdOv5lxY2/ZNGltPkQ/TfmFeDT5pnMBgrLEZlxP1JZ5G0mG7G5ljco4ETDpxw4IQDJxw44cAJB044cMKBEw6ccOCEAyccOOHACQdOOHDCgRMOnHCM+/bINeON4eRUsJx+9V7POwAAAAAAAACgm/k/z42T3X8cd9YAAAAASUVORK5CYII=>

[image11]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnAAAAKbCAMAAABCTkfQAAADAFBMVEUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAABOArQVAAAA/HRSTlMAAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2Nzg6Ozw9Pj9AQUJDREVGR0hJSktMTk9QUVJTVFVWV1hZWltcXV5fYGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6PkJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6yur7CxsrO0tba3uLm6u7y9vr/AwcLDxMXGx8jJysvMzc7P0NHS09TV1tfY2drb3N3e3+Dh4uPk5ebn6Onq6+zt7u/w8fLz9PX29/j5+vv8/f7Bp7LlAAAwSUlEQVR4Xu3dCVxU5foH8IdN2cSQXPAiaqZ41ZKu2982S7rXzExTS1NTLFJzSQMrlXuxuEpKtihcM3OBNLdU8KKS3qysrMBMyy0QNY1Q3EBAHGGQ/3nPzMDM6zDMDDPvnPe8z/fzac6cZ97D+NKP98yceeccAIQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCHEiBtdEElot8fgPF10nOC8M8fO0UXRiRu4LpFDfQ4XwkW67jgtyu4Ov56WeoKuC03UwHVO6Lnms6N01fHueWZC1gi6KDJBAzfnlYSPNXTRObwnub9P15Bg/P7Xmi45UdaaxnQJCcXvGw+65Ey+G77ExBm40wUBuG88UUXXnKl8dOGHdE1YTP/UFWJ2p+eq6ZpzZb7m/yNdQ6LYOp2uMBD/MV0RlHi71C69XPH/fvHAMLokJvF2qbN++oIuMXCz2X176ZqQxBvhnt5MV5jY/DRdEZNwgQv1OU6XmDgSEEKXhCRc4LodYvwOVa/6cFe6JCThAtfud7rCyOn2dEVIwgUuzFUH/Rt3pitC8qQLaneFLrCSTxfEJNwIh1wLA4eYwsAhpjBwiCkMHGIKA4eYwsAhpgQJ3FgvumLWCrpgp0SLP2gsXRCJIAd+UxauWHKNLhq0yys9tHAPubeefsg6Eavb0qW6+b3w/jq6JhBBAget4mZ8sugCXTXoPiTtKTJd7Wv6AYe7c8rUILomFFECB9B0+sTP5ufRVZ1zSd1e2wtDF+2bKK0Ernjo1LN/Avz9zc4L3oOgpf0rPpsF+7LubX/mcd3iuSL/+UO8d80sJU2uf/BexzUtc2BVIvgfkYvtf/7lTCX9DDptZ77gR9cEI07gABqPHd33IF3Uyx4BkJ4uv/SKDmjfXQPQK+35jKEAyb6dmuySqo8+ovmffjFx0fIWvW+sSXyZNAnsBycnrJbnjy+Xi/BJq557PjX+2QbdZo207qWkmukDN/wBJ57URTncs/afOU0XZSVN3Qzz5G4FdiJfsYramgZbwOPpiNLSZdLq5uuwX7/o0nRUj0uwaPfLpMmlLYYf0XTUWFJs1ffm/kxDzVjoIcNpDl4zqStO8P6tdMlx9IHr3438NgXW5FrNvMzFjdf9PLUMQn8gK809pb9E8scoveUg+0my8GkLG6rBXeuva2LQFo6RYivpbr6v8QO3CaQLytKjsfMDV1gYb1pXmdd1i1t9D8aZPmDQ50DN3dLZs49GfQDnOpCVS9rg0xBc85jOOYiQdwi6JtKPlYeucyDP6SWP3Fmub2ns3H2GXepc6hGFqeNX5BjivIa7ZuFdavGhhbsB9oUERZTcB1NmNk9JBpj0+A+dEt6tarN0awX9B18c+NaQoILVi0mT8g/eha+25Fd9lFAceIoUCzv8WHzDXODgaGQkvkvVi3Nqql1Pmx/XVHfPZT01PLHfdK3pA4rj1F+RICNc5KY6DlSwdz2piC6JRJDAKerYvqL+MawJ8lkqUgoMHGIKA4eYwsAhpjBwiCkMHGIKA4eYEuQ4XK2WdIEVlz2xsgg3wmld9SfmpZjPOlxKuMD9dpOuMFLxG10RknCBO+uq07TddYauCEm4wB25zzWXF3PrzuBSchwQLnB/fPoWXWJiQcqfdElIwgUOUif40CUGfMetpUtiEi9wx7PIdwFZm7If3zPIxAsczJ3dhi45XWhMLF0SlICBy03cYvlLVY7nuyWhjq9gC0fAwMH7x1fRJedyW/1rEl0TlYiBg8ktmQ5xvhvunErXhOWqD3pc6mb/mbNXLC6hy87h+3LlKLomMP3VBPvBPtO6yv248cklzS5fpMsO59b9lVVVCj+zw22cGgYhRzhJ/kthkZsCDp8vsXBOlWD5W/T2C9PcFV6c9hgeDzEmauAAcubMCen2jwANXa/VQz59jUUhli4wU5KbcczCw2ISN3CS/PzP6ZKxOIinS7R0pZ8nRHGEDlyD/fUJt274mbxNhDws4jBvuLvNomvIIgxcA7QZCTDShvNJIwxcgxzxAvA60pwuIwswcA3gT258X6bLyAIMnP30n49Nk3OHrIOBs1+UbtFsgmkZWYKBs5vXDP2dGJMysggDZ7dRhvenISZlZBEe+LXb2rVWfRiBTOAIh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKQwcYgoDh5jCwCGmMHCIKU+6oDrDYjsXpcY2+3CgZv0srTZzMAz6JKhdkryAvf0AznYAOEiabB9EmifOpX+AtdrllR5auAdg5wD5p7R/p/+x2G/I87dMjQXy/K217fLI8+/UL+SnJ8+v+ydq5Z9i//NzJS6OrqjFT0vIrb/m7wDRv4H246Uw6Aq00y1gr76NofF7hjsyK34pxk3aSYn56HPpzu5E6SZI21muGj3/b1IT8sSGBexNMGoi2Wn6/K5iRb/tp/Zdqn/3r8iio2cOQE6HRvDxyKZkXb8wtKm930DZvQz3rua+4w+mzy89vbnn1zcRhNp3qQFuV8jCD24AlLv5wsWdkXnSun4BhQCZkQFuJps0RElTt2rdver+r1/MnPmH8fNLT089//QXpeefq2siCLUHrlDbjCzKwQfAp7ocIHljNCnoFz1ASkKh7tWTIzS5ps8bwIXo95JWDjB+/uryO6jnT1kkPX+xrokg1L5LrTr8CFmc1HYCCDtVAfDz+cGkoF/k5+dfkdoYbdAwfQ4YreSvDDd5fvL0ps9fSp5f30QQag8cxEeNDmj/UumO2OAu0z4lhaTRcl238JZIbUgTo23s1WbamMUAXu4e3tKOIym87eRs+fmlny0/v/z0Js/vIT+/7p9o9HPUTO27VNgVNXtlUSpMXp5TsWEhKaQvblK7KAPyK9h1iDRpuCOHhn8h/eRHH52ROBcab/X+epb8/C2kn02eP1hulL64dhETI9146v+JQnHqO2FeWfFLsaIJf5zaKdXvUpGyYOAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xBQGDjGFgUNMYeAQUxg4xJQnXUDE2BR5EQcw/lPTR1DD4Ahn1qaz+jt/fGZSRw2FgTOr8gP9nXcrTOqooTBw5q26LC+uppiWUUNh4MwrXyYvksqoOmogDFwdkknUyj+ky6iBMHB1uLpaulmp27Eix+HmsMiw2M5FqbHQ7HfN+lnadnmeMOiToHZ5mYOlBeztB3C2g9zmg9jtg0jzxLn0D7DVe5MbwRK6iBqKm8D160Fu/Qu8IfpoZ4Clr8jVC7oHdfH6aT9pMwRgZ060rt4Q+T1+cTMcHEEOw8su1f8redFR+gPJ6dAIYGRTef1j3ULXpLuujaOc2LmDLqEGq3eEC+3W7u7zdNFxguF/x87RRTMCrsgLP+m/cjdfaRCLzCPrF3WL6S9CZmSAm66N9UK7PQYW+lYAr9El2v2WmgTnnbGqb0KxHLgukUN9Dp/y19B1xwmAqeHX01JP0HVaYS95US7951Ndfgckb9TtNafKi5RFcAMKtc1qmltB7lshWOjbNQikS7R8S00COj1hVd+EYilwnRN6rhl2lK463j3P7Mmam0tXTVU9sp0sTmoBwk5VAPx8frBc1y1K80mTw7o2VmHZtxF0UWQWAuf+VcJoC3//jnPkSMKkfYnv02VTUQd2BD32cemO4MBpKWQ9aY38oZNu4eEN0lAVv+nAjpEfG29UpzmvMOzbq/V0TSh1B85vQ48CuuYsmiXbtiy7SVdNRM1eWZQKMPl0xYaFZD19cZPaRUwM6ckuqY3hM1DL/Pqz7FvWvZMt901AcXFUwT3jIzeq5GQbyJFWJqS+0SXncmPXN0e4LQyOVNdhkTd8plTTNed6setMuuQkUt/oknNVs+ub4tURuM6vjKuia05W/szsELrmFGrum/LVEbgFCcxe49Q4t2IeXXIKNfdN+cwHrksv697sOdbigWF0yQnU3DcOmA/c+DVMjhlQSlLG0yVHGetVc1d1feOL+cA9vZmuMLH5abriKCln4gyfuqqub3wxG7hQn+N0iYkjAU57ad0q7vT7rcgdFfaNK2YP/D6ZxviQiF71tieX0zWHaTp9Otzqe1CVfeOI2cCFNaYrjLTqLn984DTuWfsvu2oSb+POdEVIZgPnqaUrjFT5Wph84RgerupbZe37FpGZDVwhXWDl+PF4uuQYr+sW0i7VmR/bWOSyX6qymA2cSt38bL48XRO5kDiBu/bJIv03IJALiRK4CyuWXKNryAUECVzkpkq6hFxCkMCtowvIRcx+0oCQs2DgEFMYOBslrqAryBYOeQ33iedouiSJWN2WLnGlyYXfu9auGXqT3qi2pn7t8qD00MI9sHMAyCfU2PKw57HYbwAOmpzoRT7Di5kTvRSF3H6iF4cETp0GXr6bLkm+pwsqF14yJO2pvUM9Mn6N1QJc6KLt6wbw1PsZzSMAlnUOzLi0AKCfrmk/3RzTd+dBtdQk9eWM5jDCA9Jy3zD+NNGRgQta2r/is9ibgSse8sh99s+Oa1rmwKpEuhE/hqd1J4u/v9n5emjHHT5Sb8Jg6KKgbRPh3v2tS+FvX7eG+UO8d80spTdUFe25pG6v7a2svFWlkf4PJ1+GTKkY1xOu5YH/0FEFyROlwG3SNd00dTdZkIZSk9Xr4BpUVoK8YS1HBi7Zt1OTXUULogPaV/TSwMkJq7meVe3z+Ejy3Ydeac9nBMLJsAi5N+npiXcA/Jo3ZB2M2l62rkXvG2sSX6a3VJvsmlMHXE1Z8mMZOW2QvFZzZiH9KYU+zpADJ/PvPr/mvgkHvmlo9cyrpQX/mg6Jh7Ivv8z/N3+X7/s8cRZAfGKa9hL92OAVLR4ZOwFGhXyd1W2YP/2o2tROIKwe/MUdabvhhu5bb+SLy/JjFw/I32G+OFBeNAkJCZKa1DHt0IEj3CVt8GkIPg+ls2e3yYz6AG4x/ia1Y3kN8r8OhxfDuQ66dZPe5H8/InyT9MokwsK5l9SjzwGjlfyVq6HqsHy35kQv+jO8wM+TyK3lE704ZoRz95ZUbX+9SespW2FAR7cb1dcACpr/hW7Hkf5NQv38eofAqhFDPYOA7s2n44atB9i8pKVbe5WfqsazzbQxi8HL293DWxqcwn3aTs6Whv3RAe1fgtIdwV2myddNSdIfpZAXHlIWpCZRUpvaH1PDMSPcCPJb95y29GTF1sXQIal52Za10u79w6yqjxLoprwY9tVF6U3Z0OTs4fNWlbfR9aYt7AsJdI8ouQ+2JZ2T/uwnvfV9UAFXZ3Gw3eGyQ8O/gPQB8OiMxLmwNbjoa+l1xq5DZk/0AldMT/RSVPeIY3o6CaeeXMISBk/M4CnMc9kT28yp/1LH7FIRshIGDjGFgUNMYeAQU0oNHH6nTqWUGTi/6Tl0CamDY47DOdadU6aSQ61IjZQXuLYzXyCX/0DqpLjApYzEl29qZjZwLekCKy1bpj+pv2vhkkINMuAPusKIy36pymI2cFpvusKI162au846q42nB11hxItctgmZDdxuV80pDFmy2/AarsHXO63DE67rG10RktnAHbnPrY7pc87l1v0owNlXFzjzXapL+4bMH4f747rR15UYuvfan2RxOf6uV8/RjzmKi/smPLMjHKQ/65I/x5Fp+jvXk5x3elJX901wZkc4SJ3gQ5cY8B23tua+88494/q+Cc184I5nTaRLDEzZ/xtdcgI1940D5gMHc2e3oUtOFxoTS5ecQs19U746ApebuMWXrjmZ75YENidEVXPflM/8mwaA95dlFj5HF53J978PWfouq+EkFeQkF4lzoxM9IXXMgL3681g0+3Dg6lnaOy4/+COcbXv76SxoUt+eZHkU1nf1nRb7JpS6Agc3B34Y6rRjE7cL3fqgxf8nIzzSct8ALQzdJZ/jIgf8+hSD4TwWy1p1/o6c40Lfkj6dxW1uDvzmGYZ92/fLeIt9E0odu1TJzRey4wPoopP4xmSvtfz/pFJzq0qj0QI5x4UUpvywITvJ17+l2k3wHzq/IPn52pakqcXAwc0NLPu2Nspy34RS5wgn6TnvxJrNR5x+XN7t3mfHf/fAKbps2ajecWMN9zt65ujOcWG9D7Yw7NsouioyS4HLfyksclPA4dOVTjyhQXBA6/DitMdsPmYwRnOQLKa/CJmRfnADyt1seyOg79v5kob1LRgsbB+mucuuvqmapcBJL5XmzAnp1q6nuQuMhgA5hYQt3GungtQKKPnsmK0/iMjIlRcpi0jYwAd8qsvlKS7mnsM8uW//CDDXNz0rutgD9tOlWiW5GXb1TdUsB06SX8evLN3m+RxvHk6nS/aL0S3kE6ec1HY6F3aq4la19IK0zKRVPfLzP6dLxqzoYhzE0yVkUb2Bq0PKk5ASSRfrsQUyxxXRRRvtjIiINjrk8frrUhdKQ5ZvS70HtGFLH6hw4CX7UgxzQZED6U9CZetfaptcL6i08TPJOf8GyHvmCF1WKtLFDmfpKsXW3xsXnNqpug+LWBTtZftXR8mxgbu/5ebsVqSLM+kiaij7AtdsArltTpctkw9G+W+0NacuInfxRRu7iOplX+CmyacZtXGytv7o524+vk0id9HXxi6ietkVON8p8kIXO6vpA/dwVm/TuiLZ10VUL7sCF3WnvNDtWK1m+HznGA/n/rWvi6he9gTOa4b+ToxNHyfpAxcxKMu0rkR2dhHVy57jcJXkxN62v3cuBdgfFxC3j64rkZ1dRPWyJ3B2urmfhK3eg/dI1RgG7gf5kkwJrvlaKFIIe17D2Un3uXqGPCEXiYph4PTm8fAmFTkL+8BpcYgTGfvAJeAQJzL2gcvAIU5k7AMHfWNxopm4XBA43KmKzBWBw52qwFwROBziBOaSwOEQJy6XBA6HOHG5JnA4xAnLNYHDIU5YLgpcRnw2XUJCcFHgpJ0qXUFCcFXgIAH3qUJyWeBwXpyYXBY4nBcnJtcFDo+MCMl1gcMjI0JyXeDw4K+QXBc4nBcnJBcGDneqInJl4HCnKiBXBg6HOAG5NHA4xInHpYHDIU48rg0cDnHCcW3gcIgTjosDh/PiROPiwOG8ONG4OnA4L04wLg8czosTi8sDh/PixOL6wOGREaG4PnB4ZEQorg8cHvwViusDh/PihKKAwOFOVSRKCBzuVAWihMDhECcQRQQOhzhxKCJwOMSJQxmBwyFOGMoIHB4aEYZCAiftVOkKUiWlBA7nxQlCKYHDeXGCUEzgcF6cGBQTOJwXJwblBA6PjAhBOYHDg79CUE7gMuKzMXHqp5zA4ccNQlBQ4HCnKgIlBQ6HOAEoKXA4xAlAUYHDIU79FBU4HOLUT1mBwyFO9ZQVOOgbS1eQuigscDhpRO2UFjicNKJySgscThpROcUFDt82qJviAodHRtRNcYHDIyPqprjA4RCnbsoLHM6LUzXlBQ53qqqmwMDhTlXNlBg4HOJUTImBwyFOxRQZOBzi1EuRgcMhTr2UGTgc4lRLmYHDeXGqpdDA4bw4tVJq4HBenEopNXA4L06lFBs4fNugTooNHB4ZUSfFBg6PjKiTYgOHQ5w6KTdwOC9OlZQbONypqpKCA4c7VTVScuBwiFMhJQcOhzgVUnTgcIhTH0UHDoc49VF24DLis+kS4puyA4cXGVQdhQcO58WpjdIDh/PiVEbpgcN5cSrjSReURjtoB13iQrs8+GbhHoCdAwAS50L7dx72HPoNwLDYzkUh0OzDgZr1M9vlZQ6GQZ/00C2C9vaTNjvbQW6SGrtdHtqlLVVG8YFLmLezmq7xIfzRtKf2wlCPjMHSO5/0b7touwM8lfpyRnOAZa06B2bMBOgXlkNa6hfvzgOQ+kqaRMAIj7TcN0B975kUv0vl9+CvNmndawCVmlsaLQR1Tb5cvA8gbvW6a3ngP3R+wbFkqcmmqXJL/aJKo9HcBCBNPiLbSevqC5ziRzjo+wPwuVMF+GKDm350vhLy+hOhYX+0Dn+VrIV7HgY4dAfAgrgZeVCzmP4iQGZk6y21P0CFlB84jneqTa7V/MMvREeHrBpQqG1GVsrBB8CnXEpc8sZoUtAtUhYB3IDCXoZtVEnxu1Sed6p9Dhiv5YdD1eFHyL2T2k4AYRXSvZ/PDyYF3aI0Pz//ClTJTVSLg8Dx+omq57QxiwG8vN29pd1IUrhP22yA+KjRAe2hdEdscJdpcqOk0bULD28JAGnyktHPURcOdqmQMZfLQyOHvx3+hfT2dACUJc6FxluDi3oC7IqavbLoLzB5eU7FBrlR+uImNYuYGCD/Q0iTVOMfpEZxcXSlPrZvYb/BB1wyxFnRRSua8MepneJhl8rxqzhE4yJwvL6KQ7fjI3A4L041+AgczotTDU4Cx8m8uG2j6MptElfQlXrYvIGy8XBYhMh40t4jI7rJF/L8jFlarW5iRrskeQFkgsbZDgAHHTM/49FOm+jSbdIb0ZV62LyBsvESOLD38y15fkaEbn7GpQXU/Azwl+dnPPW+bn4GLGrY/IxX1tT/b/yeLtTH5g2UjZvA2TsvLm71OriW5z90cEFB8sQFsGnqK6SqX4BG16an1AQqK6FKt26vAW+S28ATHrnP/gn+80fumlkKgSseOiWtSQuP8D9h6KKgbRMBgpb2r/hsFuzLurf9meeK9Fv7zx/iLW3hP2ol/KfNkOqs8oATU0pg6EqyAcD28l7eY8//0rawTV7Y7/oteMTLazh7j4z4d/+KLDp6SiNaTodG8PHIpmRdvzC0qb3fIF7HyG10+1YxUnCXd+kYkCitBbQna9KilbRID1tNmiT7d+r7mLR8dHiXRnKciOVdepMtyubfM+zxSGmoHNTTK17aQt6AbHP3X3NzskfBc/t+N2zBI24CZ+fB3wC3K2ThBzcAyt184eLOSLKuX0BhYWGK1KamecOUy/vjW52qf7wCTUe9VrboWWktsJO0RhbV8r+E8Hg6sbRgmXRn8/Wq/V0M1VGvXZK3iNn0n+eukp9WvWaE4THJfigtgDXjYGyKUZE/3OxS7ZwXV/DTsG+lxS/a7l9AeF4xwAv7fiN1/aKlro3RBg3h1f0X6XYetMlc+YEbXISfgqS1eXB05Qdk0Wb4B/QG1wAqfWrWLoK8xcPH7+6tO+zofdtfwpoH3/l+PV3kCjcjnL07VXl+xku6+RmfkoLx/AzQzc+Id9D8jN1kNwkD3G5UX4PizUvc2ksj1ICObtIaWdy4ZmhXtf31Jq2n1G6ns3lJS3mLiKjn3uwjrd/VdMY2ug2sGc355/r8jHB2ThqR52ek6uZnLCQF4/kZUAbkV7DrkGPmZyxJfk967dXhatmWtQCT3ioqkF5/dUhqnrJWXpS1B9gXEuge0QGmLT1ZsZXeetJb3wdJW3QbU1z86saeV2BHiz3/lLa4xz2i5L6aRt9d+8FoE37ZPkHA9i0ajPWkESu6SDXZ+pzJaoNk0QWd3XTB8azot/042qXa+76BoeG6SW5O9H8P0hXOcLRL5fnbDY7yXehMusQZrgJn36s4TpH3DbfhfXzja5dq7xtVpCB8BY6PeXG2zu/I+V17B127TQJd4BRfgeNjXly6yaHZiLPGa+aEWdpR+hZfeIss32lDP8InzgLHxby477+mKw2Q0G3g5EhpWTSJfoRPXL1pgIbMi2NGP79jX9aQM88Vddzh0zJnVaI8FaRTKcD2o3f1irq6v3Up/C23bMLM0CvpsTdNN5+QYzwhyW3MzPx141Kke0P+aVTmF2+Bs3teHDvp9+tekT3a5X8TF50Mi1gdJq0sb9H7xjsvS3eihu1vXZA3ZB2Meh20Lx1q/vlV6tVZ5hfuKesKDGutAqPOHx1L7v3V50ZtI37xtkvl6Dqqm41mgjQlU0GeJfd27IcCWP8cuI8EWJtdWbClR+0WsgvdxgdnZbTTr/nDyP4l/vLdwJomPONuhOPn4O81o5kgbWFDNWj9ywBOkdUNb7Xo4gXw8NwO7gG3f4SV+2t4Fz/9/TL4O0wgn/hKr+JqW3CMu8Bxd/D3Fnmbcw4izutW5bfZ+d+PCN8EPjsnbrr1Zi+ACvCobd9oXf/M+V8a/qguSDHrKs/r/E0Ve1T+AmfnvDiGqPkdX205+1FCceBbQ4LmL64pDv/zXBe4MSv2hWKSw4vDDgYum2N4TN7zGlS3Lb75UX/pTuBA4zL3bJ8gYPsWjsJs0ogVXbSiiYMwPPDr1E5x96aBh0kjztCAby8qCoeBw09UecZj4MQc4lSCx8DhEMcxLgOHQxy/uAycNMTRFcQJ/o7DERlguAAC4gyfIxxeZJBbnAYOLzLIKz53qfafTMmphj+g/8DUkYIh78yxc3SVW7wGTpGTRvp320+XGi4AOj0Rfj0t9QT9AJ94DZwiJ40UFsbTJQe555k9Ebl0kUu8voYT7ODvkbiO++QLEXKP1xEOMiC7t/J2qs6jCfbd0HIg9f0HDnE7won3cUP56MIP6Rp/+A2cYDtVSfWLXXk/swjXgRNuiIPyZ2aH0DXecBw48YY4OLeC+w+ReQ6ceEMcLB5IvuTKM54DJ+AQV5Iyni5xhuvACTjEbX6arnCG68BB31i6ona/nqYrnOE7cFycTMmxMHAuJd68uMZ0gTOcB068eXGVdIEzvAdOuLcNhXSBM7wHTrwjI5zjPXACHhnhG++BwyGOM9wHLiM+GxPHEe4DhztVvvAfONypckUFgcMhjicqCBwOcTxRQ+BwiOOIGgKHQxxHVBE4HOL4oYrAiTQvriVd4Iw6AifQvDgvusAZlQROnHlxFXSBMyoJnDjz4u6iC5xRS+BEedvg1p2ucEYtgRPlyMi91+gKZ9QSOFGOjIxMoyucUUvgBBnifMetpUucUU3ghJgXF3rqkd/oGmdUEzgRdqq+WxLy6Bpv1BM49e9U3Vb/mkTXuKOiwKl9iPPdcOdUusYfFQVO5UNc6L6yQfyf4ldVgVP1EOebvTZKBXnj9yzm5ijyaiGO4Hbvs+MfOEVXuaSqwCnsaiHvOeRCSMEBmrvCi9MeU0fe1BU46PuDkgJX/A5dQap6DQcizYvjlcoCJ868OF6pLHDizIvjldoCp+YjI6qgtsCp++CvCqgtcKo++KsGagsc9I19ki4hBVFd4HCnqmyKPfC7XbdrTOw+gNzOjdYuhdQxA/bu7QdwtgM0+12zfpb2jssP/vjCvLa6polzdRsq7OMGZEqxgRvhAWm5b4DWzSPj11gtwKilfn2Kpbo/QDXAss6BGZcWGDV9GrSGLVX7iaoqKHaXWqnR3KrSaLSVZCGFqTxsyM4qqa7RaG6C/9CCY8nPGzfVkDY6+L5ByRQbONr6UWPW16x0lAbmnA6NjB42hq/iFEyxu1TatmzNQbIsBMiM9JPulLv5Uk0M8FWcgnETuOKMXHnZA+AGlEt3fKrLvUnhlnErHXwVp1yKD5yXh7uHt1Z6gRajW79Mbn5ODw5Miq+o2D/xz3FfGrfWyYDsXnQNKYPiA5c+AB6dYTjkISkD8o+efLpiw0KACUt/2jmrtm2NjNr2SFmUHDj5zab+Hed75KYlQIRu9XKAvDht+FSBfl+a4Ib7VGXi5l2qbXBenFKpNHA4L06p1Bo4PPirUGoNHB78VSi1Bg4/31IotQYO58UplGoDhztVZVJv4HCnqkjqDRwOcYqk4sDhEKdEKg4cDnFKpObA4RCnQGoOnDTE0RXkakqeLdJgGYCTRpRG1SMcThpRHnUHDieNKI7KA4dvG5RG5YHDIyNKo/LA4ZERpVF54HCIUxq1Bw6HOIVRe+BwXpzCqD5wuFNVFvUHDneqiqL+wOEQpygCBA6HOCURIHA4xCmJCIHDIU5BVD09ySBhnjNOUDg2hdzGgblfYu1j4z81fUR0t/+uVMg58+LWBb6vuzPTtE7UPoZ5MyXCLtVZ8+JW6RZXU0yqOqvkEyeaf0xoYgTOOfPiyIlfJUnkHIm08mXywuxjQhMkcM552yCnqfxDuixLJg/W8ZjIBAmcc46MrCY3K3U7T9pV8mAdj4lMiDcN5KS/zjiT/nuTG0HlErqqJz1Y52Nm7e0HJb/Efi9fUidxbrs8Txj0SRC45wafTNjcKh/OffbPStJGvvLThwM1rWuuhMIVQQLnnDPp5296Hjaepat60oN1PmbeO/8KfCujXam/7lpPEJZDigtfPPjX+6TlA9XbShYAvDtPvvJTq86Bbxiu/MQXQXapTjr4m3ir+l26ViPRwmNmVWsvvde0E+iv9QRTSa3ZtH1lB1ZId6qyd/clC92Vn+YXHKu58hNfRBnhoO8PcNtONbTbY3CeLta6H16jS7SPYeDA2jVqg60Ptzl2zrhQj6njAwqGyZfbkfnPyAPo3wjeHgehADsDlkyTitNfhMzIcM/DAHc3vVa7aX3q6akpK/pNCc47Y21PhQncbTvVLpFDfQ4Xgsa4ZiofAukS7ZpJE2qDsk5PhF9PSz1hXLMk5e0S/ZEWWfLGaIACgLe/yZDe8Tz/0BPxpM0i+UI8PtJ4aPURl/p7asqKflMCrO+pOIEzfd/QOaHnmmFHa9ed5Z5n9mSNoIt1uH7BZPXn84MBTpRDSRFZu/qv/jH/BijNl+7najudgxxybUUrKKyn4gTOZIib80rCaKv/4hviyJGESa/qP+aykrf+Wk+QtKYCipb2PRymq8dvWn4JPLwBNGXbY48FrjXZqE5K66lAgTMa4vz69ygwecyJNEuy7p18k65aUGa41lP64iYA8/Ka50bJR0B2n5gTDTEx5P/ZlOW5Pj7UZuYptadxZGKDTWzfwuUGH9Af/fX7xsP0Eefy3fBlY7rWYKMeoCvmKK+nohwWIQyHRtw3nrDy9Y9jlI8udPxHXBt/oStmKLento9Xtm+hAD+Qm87nW9N1pwu9EEKXGFBiT0Ua4chFBqWbBQnMXtXUOLfCFedGVGJPxQocmRfXpdfHdJmBxQP17zUZUmRPxQocmRc3fg2TowSUkpTxdMk5xnrV3FVkTwULnPS24enNdJGJzU/TFedIORPXVH9XkT0VLHAJ89r6HKeLTBwJsPxi2mFaxZ1+vxW5E6rIngoWuAzthEOOn6ZkjerDXemSszSdfirlboBuiuypYIGDhMjf6RIjp9vTFedpPPZ4D2j3O11mxGJPBfpoS5YxtgVdYqR5VChdciL3rP1Ff9JFRtzvoStGRAscHKMLrBw/TqYXOd3rusWtvgdddmS+kC4YEy5wQrj52fw8uqYQGDj1ufbJItOZdUqCgVObCyuW2DD3nDkMnMpEbqqkS4qCgVOZdXRBYUQ7DodcDAOHmMJdqnVyGofcWUwX1SyuxxC65BA4wtWpyXWjg8RhD9beVx2TnjoZBq5OAy/fTZdUimVPcZdap+Fp3aXbwBUPeeTWfEPKf/4Q710zS/WLrKN3BZyYUmK0DZ/knp558Uvp7vYhE2aGXkmfRco+W66M0/eU2qABMHB18Xl8JPlGQHRA+4peNcXlLXrfWJP4sn4Bf3vgxsZ4M6f45Yuup9/1IYH7DrQvHWr+OSkHbD8+3dBhaosGwF1qXf7u/nVmB4BbgZ2qfzTUmo567VLZomf1C4CN5dVrrDi9gcLpevpdH/jvfClwa7MrC7ZI1cA9BVNv1fTUYXCEq8vwrzRHZi2GxY3XhfzXMEu/LWyoBnetfuEPVwCutnDGGdKZ0vV0/5u+LR9peRAentvBPSAe4P4tEX/509BTq0+cUy8MXB0GjGoD8PbG/PtXzQn6Slr/81LEVvh1s+f0i+166BdlEPvllUUf8Z43fU+PZp149p7stkF7u+Y2/1Yq7xzll71lnqGnDoOBq8Owry4CXBia3CGpeRnZw1RPWrq6KUx66/uggtWGBWzZ0WLPP+kteWPo6Xf/dyB/OVyZtu188R75getjvp1n6Kmj2f49etu3UAZH/ruzxtEVCxz5xFZh/oQGFp8Y3zQgpjBwiCl7X8N16pFPl8TThy6getkZuFmvfksOEyJkI/sCN3zC3yx+NQehOtj1Gu7JqV0xb/bym87nJWQcxK4R7vHtdAVZ6c4pU4PomlDsClzXTXQFWaXtzBf86Jpg7Apca6svaoKMdJs1svbkbaLSB65lB1uudtNmZAVd4saAP+gKIy1b/stwCU1bftf2c11P6YIxfeC+bGzT1W4C+Q2cJ9PzyBvxulVz16bftd1c11PjCzjR9IHbutW0bNmwj07SJW68/Fe6wkjFl/GGXSq56ofzua6nv9EVI3YdFjkvn2GRT2ctnbzMme46czSyc9J1uuw8LuwpXWmoJ3n+lCGnG11horvh/KfsjsO5uqdm2bWfPx2Xxe8nqW06k/mUzM04of8rrcw+/avpQ87i6p6aZdcuVTtrlcV3IoqWOsG6y6I5lu+42qv/rTOqO5Pre2qGXSMcnPBN6V1tzeVYFejSA82z6JrzzahaTpecTpE9tWuEA1j8qE9/usaLubPb0CWnC42JpUsMKLGn9o1wAFc6Xd9H1zhx5Vb8esbnUPPd9R/5q56MKbGndo5wXHv/+Cq65Fxuq39NomtMqKmnFr8pYZd22m6h068DeHn/711vT/gl+c47BvaDp0rHNr17EsC+1l1Px0ptwmDQFcMC9i7y9m4MpI3UxMvbO3OJt1UfDjfOCqVLTnRgZX1XrZXtfduz+bIrTUDXfUMXE/v595oIrbR9eufH1nSY/G766bdoQv8cE4rrqaJGOO25JOkdXKXmVpVGG9Q1+XJx5j6IW73uWt5H4D+/4Fjy81Kbqbqm+kWVRnMTSBupSaVG3rDmp1lwc0N2fABddBLfmLVR1l2Xu1p76b2mncDQC7mLzabtKzuwQrpTlb27L1mQDsu/G/KKhmzRyfhH3EZxPVVU4CTZhjtXc995zF9adtcdS+qYA5DToRHASN2ly/QLmb++jQ0+6Bl8Yv69hg/Tncet+4LcXkvpap3cx2pO16zIXezZyLDa4v6jhruG3w2QLWo3MEtpPbVqD8RQieHECdX9X08OzZz5h9sVedUvH6DczRdgZ6R8BQL9YvqLkBkZoG9ji/yXwiI3BRw+X+LEmVZhmrvCi9Mes/TJoomp4wMKRhfVrMpdlEant8eBtFvcGbDkLdB3WP7dhP2h2+LNmg3Ms72nwWB1Uz0beqq0wDWpOXHChejokKSVA7TN5LVyHwCf6vI7IHljNFnXL1IWwQ0o1LexTc6cOSHd/hHgxEuKluRmHLPlE5mUt0uM51nIXSyQAvdNhjRAPf/QE/GkDemw/LtZNeC2Lepga097wH66VA8beqq0wPVZbbSSv3I1HH5Ens9+ss85CDtVAfDz+cFkXb8oJd2s0rexWX6+5bfwjF03vZyH3MUT5VAiD3pX/9U/5t/6DhP54XDbFnWzqadxQKLtJIp6DefZZtoY8i7V3UN6m5YU7tN2cjbER40OaP8SlMYGd5n2KWmUNFpuq1t4eHt7A2kjNVELXfdB18WipX199Jf0jo9pbugw+d3UvNrli6JGuMNlh4YDpA+AR2ckzm28Nbjo61mwK2r2yqJUgCs5FRsWkkbpi+UDAbpFTAzpgtSmRarJT+JZmdx90HdxXl7z3Cj5rffuE3Oi9R0mv5ue1GZq5/jjcEghnPq/VlG7VKR+GDjEFAYOMYWBQ0xh4BBTGDjEFAYOMYWBQ0xh4BBTGDjEFAYOMYWBQ0xh4BBTGDjEFAYOMYWBQ0xh4BBTGDjEFAYOMYWBQ0xh4BBTGDjEFAYOMWX3F6GPDUygS0gdWmTSFYQQQgghhBBCCCGEEEKoLs4/gT9vtg8it4lzdw4gt9GJ0Ush9ZO9e/sB+Vim2YcDNetn+V9+8Ed4YV5b3UVI5NOjIivZ/dGWao3wgLSnQQtDPTJ+jQPIGbXUr88nAO/OIw8ua9U5MOPSf/RN/SEt9w2w6to3SA8/vKeRKyhpNFr5CkxSlvLLw4bsBPmaQxrwH2q4ApNMvtaSdRdbQnoYuPqsHzVmveF+R0/5CkzGDyPb4C61PtuyNQcj5GsOQUs/chmYcnzd2wAYuPoUZ+SSRcoi6aYc5Csw3ZIf0N0i22Dg6uLl4e7hSV6fxcir5Zelm5/TU0cHJsWX7J940nfclybNkXUwcHUhF8S5WXvEQ3cJmMnL5QviTFiaV7FzllFjhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEELc+n9js5GGHrs/AAAAAABJRU5ErkJggg==>

[image12]: <data:image/png;base64,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>