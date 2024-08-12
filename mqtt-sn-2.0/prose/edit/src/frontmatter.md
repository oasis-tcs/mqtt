![OASIS Logo](https://docs.oasis-open.org/templates/OASISLogo-v3.0.png)

-------

# MQTT for Sensor Networks (MQTT-SN) Version 2.0

## Committee Specification Draft 01

## 01 August 2024

#### This stage:
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.md (Authoritative) \
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.html \
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.pdf

#### Previous stage:
N/A

#### Latest stage:
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.md (Authoritative) \
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.html \
https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.pdf

#### Technical Committee:
[OASIS Message Queuing Telemetry Transport (MQTT) TC](https://www.oasis-open.org/committees/mqtt/)


#### Chairs:
Ian Craggs (icraggs@gmail.com), Individual
Simon Johnson (simon.johnson@hivemq.com), HiveMQ GmbH

#### Editors:
Andrew Banks (andrewdjbanks@gmail.com), Individual
Andy Stanford-Clark (andysc@uk.ibm.com), [IBM](http://www.ibm.com)
Davide Lenzarini (davide.lenzarini@u-blox.com), u-blox AG
Ian Craggs (icraggs@gmail.com), Individual
Rahul Gupta (rahul.gupta@us.ibm.com), [IBM](http://www.ibm.com)
Simon Johnson (simon.johnson@hivemq.com), HiveMQ GmbH
Stefan Hagen (stefan@hagen.link), [Individual](https://stefan-hagen.website/)
Tara E. Walker (tara.walker@microsoft.com), [Microsoft Corporation](http://www.microsoft.com/)

#### Related work:
This specification is related to:

* _MQTT Version 5.0_. Edited by Andrew Banks, Ed Briggs, Ken Borgendale, and Rahul Gupta. OASIS Standard. Latest version:
  <https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html>.
* _MQTT Version 3.1.1_. Edited by Andrew Banks and Rahul Gupta. OASIS Standard. Latest version:
  <http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html>.
* _MQTT-SN Version 1.2_ by Andy Stanford-Clark and Hong Linh Truong. Link:
  <https://www.oasis-open.org/committees/download.php/66091/MQTT-SN_spec_v1.2.pdf>.

#### Abstract:
This specification defines the MQTT for Sensor Networks protocol (MQTT-SN).
It is closely related to the MQTT v3.1.1 and MQTT v5.0 standards.
MQTT-SN is optimized for implementation on low-cost, battery-operated devices with limited processing and storage resources.
It is designed so that it will work over a variety of networking technologies and bridge to an MQTT network.

#### Status:
This document was last revised or approved by the membership of OASIS on the above date. The level of approval is also listed above. Check the "Latest stage" location noted above for possible later revisions of this document. Any other numbered Versions and other technical work produced by the Technical Committee (TC) are listed at https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=mqtt#technical.

TC members should send comments on this specification to the TC's email list. Others should send comments to the TC's public comment list, after subscribing to it by following the instructions at the "Send A Comment" button on the TC's web page at https://www.oasis-open.org/committees/mqtt/.

This specification is provided under the [Non-Assertion](https://www.oasis-open.org/policies-guidelines/ipr/#Non-Assertion-Mode) Mode of the [OASIS IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr/), the mode chosen when the Technical Committee was established. For information on whether any patents have been disclosed that may be essential to implementing this specification, and any offers of patent licensing terms, please refer to the Intellectual Property Rights section of the TC's web page (https://www.oasis-open.org/committees/mqtt/ipr.php).

Note that any machine-readable content ([Computer Language Definitions](https://www.oasis-open.org/policies-guidelines/tc-process-2017-05-26/#wpComponentsCompLang)) declared Normative for this Work Product is provided in separate plain text files. In the event of a discrepancy between any such plain text file and display content in the Work Product's prose narrative document(s), the content in the separate plain text file prevails.

#### Citation format:
When referencing this specification the following citation format should be used:

**\[MQTT-SN-v2.0]**

_MQTT for Sensor Networks Version 2.0_. Edited by Andrew Banks, Andy Stanford-Clark, Davide Lenzarini, Ian Craggs, Rahul Gupta, Simon Johnson, Stefan Hagen,
 and Tara E. Walker. 01 August 2024. OASIS Committee Specification Draft 01. https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.md.
Latest stage: https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.md.

-------

## Notices

Copyright © OASIS Open 2024. All Rights Reserved.

Distributed under the terms of the OASIS IPR Policy,
[https://www.oasis-open.org/policies-guidelines/ipr/](https://www.oasis-open.org/policies-guidelines/ipr/). For complete copyright information see the full Notices section in an Appendix below.

