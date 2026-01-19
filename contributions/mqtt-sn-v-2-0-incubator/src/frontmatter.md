**19 October 2025**

**This stage:**

**...**

**Previous stage:**

**N/A**

**Latest stage:**

**...**

**Technical Committee:**

[OASIS Message Queuing Telemetry Transport (MQTT) TC](https://www.oasis-open.org/committees/mqtt/)

**Chairs:**

> <mark title="Ephemeral region marking">Ian Craggs (<icraggs@gmail.com>), Individual</mark>
>
> Simon Johnson (simon.johnson@hivemq.com), HiveMQ GmbH

**Editors:**

> Andrew Banks (andrewdjbanks@gmail.com), Individual
>
> Ian Craggs (<icraggs@gmail.com>), Individual
>
> Rahul Gupta (<rahul.gupta@us.ibm.com>), [IBM](http://www.ibm.com)
>
> Stefan Hagen (<stefan@hagen.link>), Individual
>
> Simon Johnson ([simon](mailto:simon622@gmail.com).johnson@hivemq.com), HiveMQ GmbH
>
> Davide Lenzarini (<davide.lenzarini@u-blox.com>), u-blox AG
>
> Andy Stanford-Clark (andysc@uk.ibm.com), IBM
>
> Tara E. Walker (<tara.walker@microsoft.com>), [Microsoft Corporation](http://www.microsoft.com/)

**Related work:**

> This specification is related to:

- *MQTT Version 5.0*. Edited by Andrew Banks, Ed Briggs, Ken Borgendale, and Rahul Gupta. OASIS Standard. Latest version: <https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html>.

- *MQTT Version 3.1.1*. Edited by Andrew Banks and Rahul Gupta. OASIS Standard. Latest version: <http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html>.

- *MQTT-SN Version 1.2* by Andy Stanford-Clark and Hong Linh Truong. Link: <https://www.oasis-open.org/committees/download.php/66091/MQTT-SN_spec_v1.2.pdf>.

**Abstract:**

> This specification defines the MQTT for Sensor Networks protocol (MQTT-SN). It is closely related to the MQTT v3.1.1 and MQTT v5.0 standards. MQTT-SN is optimized for implementation on low-cost, battery-operated devices with limited processing and storage resources. It is designed so that it will work over a variety of networking technologies and bridge to an MQTT network.

**Status:**

> This document was last revised or approved by the OASIS Message Queuing Telemetry Transport (MQTT) TC on the above date. The level of approval is also listed above. Check the \"Latest stage\" location noted above for possible later revisions of this document. Any other numbered Versions and other technical work produced by the Technical Committee (TC) are listed at [[https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=mqtt#technical]](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=mqtt#technical) .
>
> TC members should send comments on this document to the TC\'s email list. Others should send comments to the TC\'s public comment list, after subscribing to it by following the instructions at the \"[[Send A Comment]](https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=mqtt)\" button on the TC\'s web page at [[https://www.oasis-open.org/committees/mqtt/]](https://www.oasis-open.org/committees/mqtt/).
>
> This specification is provided under the [Non-Assertion](https://www.oasis-open.org/policies-guidelines/ipr#Non-Assertion-Mode) Mode of the [OASIS IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr), the mode chosen when the Technical Committee was established. For information on whether any patents have been disclosed that may be essential to implementing this specification, and any offers of patent licensing terms, refer to the Intellectual Property Rights section of the TC's web page (<https://www.oasis-open.org/committees/mqtt/ipr.php>).
>
> Note that any machine-readable content ([Computer Language Definitions](https://www.oasis-open.org/policies-guidelines/tc-process#wpComponentsCompLang)) declared Normative for this Work Product is provided in separate plain text files. In the event of a discrepancy between any such plain text file and display content in the Work Product\'s prose narrative document(s), the content in the separate plain text file prevails.

**Citation format:**

> When referencing this document, the following citation format should be used:
>
> **\[MQTT-SN-v2.0\]**
>
> *MQTT for Sensor Networks Version 2.0*. Edited by Andrew Banks, Davide Lenzarini, Ian Craggs, Rahul Gupta, Simon Johnson, Stefan Hagen, and Tara E. Walker. 01 May 2025. OASIS Committee Specification Draft 01. [[https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.docx]](https://docs.oasis-open.org/mqtt/mqtt-sn/v12.30/csd01/mqtt-sn-v12.30-csd01.docx). Latest stage: [[https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.docx]](https://docs.oasis-open.org/mqtt/mqtt-sn/v12.30/mqtt-sn-v12.30.docx)
>
> <mark title="Ephemeral region marking">(**Note:** Publication URIs are managed by OASIS TC Administration; please don\'t modify. The [OASIS TC Process](https://www.oasis-open.org/policies-guidelines/tc-process#wpComponentsGeneral) requires that Work Products at any level of approval must use the [OASIS file naming scheme](https://docs.oasis-open.org/specGuidelines/ndr/namingDirectives.html), and must include the OASIS copyright notice. The URIs above have been constructed according to the file naming scheme. Remove this note before submitting for publication.)</mark>

**Notices**

Copyright © OASIS Open 2025. All Rights Reserved.

All capitalized terms in the following text have the meanings assigned to them in the OASIS Intellectual Property Rights Policy (the \"OASIS IPR Policy\"). The full [[Policy]](https://www.oasis-open.org/policies-guidelines/ipr/) may be found at the OASIS website: \[[[https://www.oasis-open.org/policies-guidelines/ipr/]](https://www.oasis-open.org/policies-guidelines/ipr/)\].

This document and translations of it may be copied and furnished to others, and derivative works that comment on or otherwise explain it or assist in its implementation may be prepared, copied, published, and distributed, in whole or in part, without restriction of any kind, provided that the above copyright notice and this section are included on all such copies and derivative works. However, this document itself may not be modified in any way, including by removing the copyright notice or references to OASIS, except as needed for the purpose of developing any document or deliverable produced by an OASIS Technical Committee (in which case the rules applicable to copyrights, as set forth in the OASIS IPR Policy, must be followed) or as required to translate it into languages other than English.

The limited permissions granted above are perpetual and will not be revoked by OASIS or its successors or assigns.

This document and the information contained herein is provided on an \"AS IS\" basis and OASIS DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE ANY OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. OASIS AND ITS MEMBERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THIS DOCUMENT OR ANY PART THEREOF.

As stated in the OASIS IPR Policy, the following three paragraphs in brackets apply to OASIS Standards Final Deliverable documents (Committee Specifications, OASIS Standards, or Approved Errata).

\[OASIS requests that any OASIS Party or any other party that believes it has patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable, to notify OASIS TC Administrator and provide an indication of its willingness to grant patent licenses to such patent claims in a manner consistent with the IPR Mode of the OASIS Technical Committee that produced this deliverable.\]

\[OASIS invites any party to contact the OASIS TC Administrator if it is aware of a claim of ownership of any patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable by a patent holder that is not willing to provide a license to such patent claims in a manner consistent with the IPR Mode of the OASIS Technical Committee that produced this OASIS Standards Final Deliverable. OASIS may include such claims on its website, but disclaims any obligation to do so.\]

\[OASIS takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this OASIS Standards Final Deliverable or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any effort to identify any such rights. Information on OASIS\' procedures with respect to rights in any document or deliverable produced by an OASIS Technical Committee can be found on the OASIS website. Copies of claims of rights made available for publication and any assurances of licenses to be made available, or the result of an attempt made to obtain a general license or permission for the use of such proprietary rights by implementers or users of this OASIS Standards Final Deliverable, can be obtained from the OASIS TC Administrator. OASIS makes no representation that any information or list of intellectual property rights will at any time be complete, or that any claims in such list are, in fact, Essential Claims.\]

The name \"OASIS\" is a trademark of [[OASIS]](https://www.oasis-open.org/), the owner and developer of this document, and should be used only to refer to the organization and its official outputs. OASIS welcomes reference to, and implementation and use of, documents, while reserving the right to enforce its marks against misleading uses. See [[https://www.oasis-open.org/policies-guidelines/trademark/]](https://www.oasis-open.org/policies-guidelines/trademark/) for above guidance.
