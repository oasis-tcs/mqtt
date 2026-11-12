
// Passthrough conf: this template owns all layout; pandoc keyword args are accepted
// but ignored — the positional arg (doc body) is what we use.
#let conf(..args) = args.pos().first()


// ── Shared OASIS brand (typography, code, headings, tables, …) ────────────────

#import "../etc/oasis.typ": oasis-setup

// ── Page layout (per-spec) ────────────────────────────────────────────────────

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 1cm, right: 1cm),
  header: align(center, text(size: 10pt)[Standards Track Work Product]),
  footer: context grid(
    inset: (top: 0.4em),
    stroke: (top: 0.5pt),
    columns: (1fr, 2fr, 1fr),
    align: (left + horizon, center + horizon, right + horizon),
    text(size: 8pt)[mqtt-sn-v2.0-csd01],
    text(size: 8pt)[Copyright © OASIS Open 2026. All Rights Reserved.],
    text(size: 8pt)[14 August 2026 — Page #counter(page).display()
      of #counter(page).final().first()],
  ),
)

// Language (font and base size come from oasis-setup)
#set text(lang: "en")

// ── Apply OASIS brand + pandoc passthrough ────────────────────────────────────

#show: oasis-setup
#show: doc => conf(
  sectionnumbering: none,
  pagenumbering: none,
  cols: 1,
  doc,
)

#set heading(numbering: (..nums) => {
  let n = nums.pos()
  let base = numbering("1.1", ..n)
  if n.len() == 1 { base + "." } else { base }
})
#show raw: set text(size: 0.85em)
#box(image("images/OASISLogo-v3.0.png"))

#heading(level: 1, outlined: false, numbering: none)[MQTT for Sensor
Networks Version 2.0]
<mqtt-for-sensor-networks-version-2-0>
#heading(level: 2, outlined: false, numbering: none)[Committee
Specification Draft 01]
<committee-specification-draft-01>
#heading(level: 2, outlined: false, numbering: none)[29 October 2026]
<29-october-2026>
#heading(level: 4, outlined: false, numbering: none)[This stage]
<this-stage>
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.md")
(Authoritative) \
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.html")
\
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.pdf")

#heading(level: 4, outlined: false, numbering: none)[Previous stage]
<previous-stage>
N/A

#heading(level: 4, outlined: false, numbering: none)[Latest stage]
<latest-stage>
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.md")
(Authoritative) \
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.html")
\
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.pdf")

#heading(level: 4, outlined: false, numbering: none)[Technical
Committee]
<technical-committee>
#link("https://www.oasis-open.org/committees/mqtt/")[OASIS Message Queuing Telemetry Transport (MQTT) TC]

#heading(level: 4, outlined: false, numbering: none)[Chairs]
<chairs>
Richard Coppen (coppen\@uk.ibm.com), #link("https://www.ibm.com")[IBM] \
Simon Johnson (simon.johnson\@hivemq.com),
#link("https://www.hivemq.com")[HiveMQ GmbH]

#heading(level: 4, outlined: false, numbering: none)[Editors]
<editors>
Andrew Banks (andrewdjbanks\@gmail.com), Individual \ Andy
Stanford-Clark (andysc\@uk.ibm.com), #link("https://www.ibm.com")[IBM] \
Davide Lenzarini
(#link("mailto:davide.lenzarini@u-blox.com")[davide.lenzarini\@u-blox.com]),
#link("https://www.u-blox.com/")[u-blox AG] \ Ian Craggs
(icraggs\@gmail.com), Individual \ Rahul Gupta
(rahul.gupta\@us.ibm.com), #link("https://www.ibm.com")[IBM] \ Simon
Johnson (simon.johnson\@hivemq.com),
#link("https://www.hivemq.com")[HiveMQ GmbH] \ Stefan Hagen
(stefan\@hagen.link), #link("https://stefan-hagen.website/")[Individual]
\ Tara E. Walker (tara.walker\@microsoft.com),
#link("https://www.microsoft.com/")[Microsoft Corporation]

#heading(level: 4, outlined: false, numbering: none)[Related work]
<related-work>
This specification is related to:

- #emph[MQTT Version 5.0]. Edited by Andrew Banks, Ed Briggs, Ken
  Borgendale, and Rahul Gupta. 07 March 2019. OASIS Standard. Latest
  version:
  #link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html").

- #emph[MQTT Version 3.1.1]. Edited by Andrew Banks and Rahul Gupta. 10
  December 2015. OASIS Standard. Latest version:
  #link("http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html").

- #emph[MQTT For Sensor Networks (MQTT-SN) - Protocol Specification
  Version 1.2] by Andy Stanford-Clark and Hong Linh Truong. 14 November
  \2013. International Business Machines Corporation (IBM). Link:
  #link("https://groups.oasis-open.org/higherlogic/ws/public/download/66091/MQTT-SN_spec_v1.2.pdf").

#heading(level: 4, outlined: false, numbering: none)[Abstract]
<abstract>
This specification defines the MQTT for Sensor Networks protocol
(MQTT-SN). It is closely related to the MQTT v3.1.1 and MQTT v5.0
standards. MQTT-SN is optimized for implementation on low-cost,
battery-operated devices with limited processing and storage resources.
It is designed so that it will work over a variety of networking
technologies and bridge to an MQTT network.

#heading(level: 4, outlined: false, numbering: none)[Status]
<status>
This document was last revised or approved by the OASIS Message Queuing
Telemetry Transport (MQTT) TC on the above date. The level of approval
is also listed above. Check the \"Latest stage\" location noted above
for possible later revisions of this document. Any other numbered
Versions and other technical work produced by the Technical Committee
(TC) are listed at
#link("https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=mqtt#technical").

TC members should send comments on this document to the TC\'s email
list. Others should send comments to the TC\'s public comment list,
after subscribing to it by following the instructions at the
\"#link("https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=mqtt")[\[Send A Comment\]]\"
button on the TC\'s web page at
#link("https://www.oasis-open.org/committees/mqtt/")[\[https:/\/www.oasis-open.org/committees/mqtt/\]].

This specification is provided under the
#link("https://www.oasis-open.org/policies-guidelines/ipr#Non-Assertion-Mode")[Non-Assertion]
Mode of the
#link("https://www.oasis-open.org/policies-guidelines/ipr")[OASIS IPR Policy],
the mode chosen when the Technical Committee was established. For
information on whether any patents have been disclosed that may be
essential to implementing this specification, and any offers of patent
licensing terms, refer to the Intellectual Property Rights section of
the TC's web page
(#link("https://www.oasis-open.org/committees/mqtt/ipr.php")).

Note that any machine-readable content
(#link("https://www.oasis-open.org/policies-guidelines/tc-process#wpComponentsCompLang")[Computer Language Definitions])
declared Normative for this Work Product is provided in separate plain
text files. In the event of a discrepancy between any such plain text
file and display content in the Work Product\'s prose narrative
document(s), the content in the separate plain text file prevails.

#heading(level: 4, outlined: false, numbering: none)[Citation format:]
<citation-format>
When referencing this document, the following citation format should be
used:

#strong[\[MQTT-SN-v2.0\]]

#emph[MQTT for Sensor Networks Version 2.0]. Edited by Andrew Banks,
Andy Stanford-Clark, Davide Lenzarini, Ian Craggs, Rahul Gupta, Simon
Johnson, Stefan Hagen, and Tara E. Walker. 29 October 2026. OASIS
Committee Specification Draft 01.
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/csd01/mqtt-sn-v2.0-csd01.md").
Latest stage:
#link("https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/mqtt-sn-v2.0.md")

#heading(level: 2, outlined: false, numbering: none)[Notices]
<notices>
Copyright © OASIS Open 2026. All Rights Reserved.

All capitalized terms in the following text have the meanings assigned
to them in the OASIS Intellectual Property Rights Policy (the \"OASIS
IPR Policy\"). The full
\[#link("https://www.oasis-open.org/policies-guidelines/ipr/")[Policy]\]
may be found at the OASIS website:
\[#link("https://www.oasis-open.org/policies-guidelines/ipr/")\].

This document and translations of it may be copied and furnished to
others, and derivative works that comment on or otherwise explain it or
assist in its implementation may be prepared, copied, published, and
distributed, in whole or in part, without restriction of any kind,
provided that the above copyright notice and this section are included
on all such copies and derivative works. However, this document itself
may not be modified in any way, including by removing the copyright
notice or references to OASIS, except as needed for the purpose of
developing any document or deliverable produced by an OASIS Technical
Committee (in which case the rules applicable to copyrights, as set
forth in the OASIS IPR Policy, must be followed) or as required to
translate it into languages other than English.

The limited permissions granted above are perpetual and will not be
revoked by OASIS or its successors or assigns.

This document and the information contained herein is provided on an
\"AS IS\" basis and OASIS DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE
INFORMATION HEREIN WILL NOT INFRINGE ANY OWNERSHIP RIGHTS OR ANY IMPLIED
WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. OASIS
AND ITS MEMBERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR
CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THIS DOCUMENT OR ANY
PART THEREOF.

As stated in the OASIS IPR Policy, the following three paragraphs in
brackets apply to OASIS Standards Final Deliverable documents (Committee
Specifications, OASIS Standards, or Approved Errata).

\[OASIS requests that any OASIS Party or any other party that believes
it has patent claims that would necessarily be infringed by
implementations of this OASIS Standards Final Deliverable, to notify
OASIS TC Administrator and provide an indication of its willingness to
grant patent licenses to such patent claims in a manner consistent with
the IPR Mode of the OASIS Technical Committee that produced this
deliverable.\]

\[OASIS invites any party to contact the OASIS TC Administrator if it is
aware of a claim of ownership of any patent claims that would
necessarily be infringed by implementations of this OASIS Standards
Final Deliverable by a patent holder that is not willing to provide a
license to such patent claims in a manner consistent with the IPR Mode
of the OASIS Technical Committee that produced this OASIS Standards
Final Deliverable. OASIS may include such claims on its website, but
disclaims any obligation to do so.\]

\[OASIS takes no position regarding the validity or scope of any
intellectual property or other rights that might be claimed to pertain
to the implementation or use of the technology described in this OASIS
Standards Final Deliverable or the extent to which any license under
such rights might or might not be available; neither does it represent
that it has made any effort to identify any such rights. Information on
OASIS\' procedures with respect to rights in any document or deliverable
produced by an OASIS Technical Committee can be found on the OASIS
website. Copies of claims of rights made available for publication and
any assurances of licenses to be made available, or the result of an
attempt made to obtain a general license or permission for the use of
such proprietary rights by implementers or users of this OASIS Standards
Final Deliverable, can be obtained from the OASIS TC Administrator.
OASIS makes no representation that any information or list of
intellectual property rights will at any time be complete, or that any
claims in such list are, in fact, Essential Claims.\]

The name \"OASIS\" is a trademark of
#link("https://www.oasis-open.org/")[\[OASIS\]], the owner and developer
of this document, and should be used only to refer to the organization
and its official outputs. OASIS welcomes reference to, and
implementation and use of, documents, while reserving the right to
enforce its marks against misleading uses. See
#link("https://www.oasis-open.org/policies-guidelines/trademark/") for
above guidance.

#pagebreak(weak: true)
// set channels.typst.toc-dots: true in nide.yaml to add dot leaders
#show outline.entry: set outline.entry(fill: none)
#outline(title: "Table of Contents", depth: 2)
#pagebreak(weak: true)
= Introduction
<introduction>
\[All text is normative unless otherwise labeled\]

== Intellectual property rights policy
<intellectual-property-rights-policy>
This specification is provided under the
#link("https://www.oasis-open.org/policies-guidelines/ipr#Non-Assertion-Mode")[\[Non-Assertion\]]
Mode of the
#link("https://www.oasis-open.org/policies-guidelines/ipr")[\[OASIS IPR Policy\]],
the mode chosen when the Technical Committee was established. For
information on whether any patents have been disclosed that may be
essential to implementing this specification, and any offers of patent
licensing terms, refer to the Intellectual Property Rights section of
the TC's web page
(#link("https://www.oasis-open.org/committees/mqtt/ipr.php")[\[https:/\/www.oasis-open.org/committees/mqtt/ipr.php\]]).

== Changes from earlier Versions
<changes-from-earlier-versions>
Here is a description of significant differences from previously
published, differently numbered Versions of this specification.

=== MQTT-SN 1.2
<mqtt-sn-1.2>
- Some terminology has been changed to match MQTT 5.0. For example:

  - Topic Id becomes Topic Alias
  - Message Id becomes Packet Identifier
  - Message Type becomes Packet Type

- The concept of Virtual Connection has been introduced, corresponding
  to the TCP connection of MQTT.

- The Will Message Packets are removed - setting the Will Message is now
  done in the CONNECT Packet, as in MQTT.

- The Enhanced Authentication of MQTT 5.0 is supported in CONNECT and
  CONNACK, and the introduction of the AUTH Packet.

- The #emph[going to sleep] function of DISCONNECT is now the
  responsibility of a separate Packet - SLEEPREQ, and the response
  SLEEPRESP. As a result, DISCONNECT never has a response.

- The Short Topic Name has been removed - all publish packets now
  support full Topic Names as well as Topic Aliases.

- All responses allow a Reason Code to be returned. DISCONNECT also
  allows a Reason String for enhanced diagnostics. A set of Reason Codes
  and their use is included.

- Inspired by OSCORE, a Protection Encapsulation is introduced to
  provide lightweight authentication and encryption.

- Session Expiry, Maximum Packet Size, Assigned Client Identifier and
  Subscribe Options (No Local, Retain Handling, Retain as Published)
  have been adopted from MQTT.

== Organization of the MQTT-SN specification
<organization-of-the-mqtt-sn-specification>
The specification is split into six chapters:

- Chapter 1 -- Introduction
- Chapter 2 -- MQTT-SN Control Packet format
- Chapter 3 -- MQTT-SN Control Packets
- Chapter 4 -- Operational Behavior
- Chapter 5 -- Security
- Chapter 6 -- Conformance

== Terminology
<terminology>
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in BCP 14
\[#link(<RFC2119>)[RFC2119]\] and \[#link(<RFC8174>)[RFC8174]\] when,
and only when, they appear in all capitals, as shown here.

/ ​Datagram<def:datagram>: An independent, self-contained sequence of
    bytes. If received, the contents of a datagram must be correct.
/ ​Underlying Network<def:underlying-network>: The underlying network
    which provides the means to send datagrams from one network endpoint
    to another.
/ ​Network Address<def:network-address>: A unique label provided by the
    Underlying Network to identify a network endpoint. To receive
    datagrams, an MQTT-SN Client or Server listens to the network for
    packets addressed to a specific Network Address.
/ ​Network Identity<def:network-identity>: The identity used to establish
    that a sequence of datagrams originates from the same sender. This
    could be, for example:

- A Network Address
- A DTLS connection ID
- An MQTT-SN Protection Packet Sender Identifier

/ ​Virtual Connection<def:virtual-connection>: An MQTT-SN construct
    corresponding to the network connection in MQTT. It associates a
    Network Identity with a Session, by means of the Client Identifier.
/ ​Application Message<def:application-message>: The data carried by the
    MQTT-SN (or MQTT) protocols across the network for the application.
    When an Application Message is transported by MQTT-SN (or MQTT) it
    contains payload data, a Quality of Service (QoS), and a Topic Name.
/ ​MQTT-SN Client<def:mqtt-sn-client>: A program or device that uses the
    MQTT-SN protocol. This is referred to as Client in the body of this
    specification. An MQTT-SN Client does one or more of the following:

- creates a Virtual Connection to a Server, then:
  - publishes Application Messages that other Clients might be
    interested in.
  - subscribes to request Application Messages that it is interested in
    receiving.
  - unsubscribes to remove a request for Application Messages.
  - deletes the Virtual Connection to the Server.
- without using a Virtual Connection
  - publishes Application Messages to one or more recipients.

/ ​MQTT-SN Server<def:mqtt-sn-server>: A program or device that acts as
    an intermediary between MQTT-SN Clients which publish Application
    Messages and MQTT-SN Clients which have made Subscriptions. This is
    referred to as Server in the body of this specification. An MQTT-SN
    Server does one or more of the following:

- accepts CONNECT requests from Clients and then:
  - accepts Application Messages published by Clients.
  - processes Subscribe and Unsubscribe requests from Clients.
  - forwards Application Messages that match Client Subscriptions.
  - accepts DISCONNECT requests from connected Clients.
- without using a Virtual Connection:
  - accepts Application Messages.
- opens an MQTT Network Connection to an MQTT Server, then:
  - accepts Application Messages from the MQTT Server and forwards some
    or all to MQTT-SN Clients.
  - accepts Application Messages from MQTT-SN Clients and forwards some
    or all to the MQTT Server.
- opens an MQTT Network Connection to an MQTT Server when an MQTT-SN
  CONNECT request is received, then:
  - forwards equivalent MQTT packets to the MQTT Server for each MQTT-SN
    packet received
  - forwards equivalent MQTT-SN packets to the MQTT-SN Client for each
    MQTT packet received
  - closes the MQTT Network Connection when the MQTT-SN Virtual
    Connection is deleted
- accepts Application Messages from MQTT-SN Clients and forwards some or
  all to the MQTT Server.

/ ​Gateway<def:gateway>: An MQTT-SN Server that also uses the MQTT
    protocol to communicate with an MQTT Server.
/ ​Forwarder<def:forwarder>: A program or device that is an intermediary
    between MQTT-SN Clients and Servers which reside on different
    Underlying Networks that cannot communicate directly with each
    other.
/ ​MQTT Client<def:mqtt-client>: A program or device that uses MQTT. An
    MQTT Client:

- opens the Network Connection to the MQTT Server.
- publishes Application Messages that other MQTT (or MQTT-SN) Clients
  might be interested in.
- subscribes to request Application Messages that it is interested in
  receiving.
- unsubscribes to remove a request for Application Messages.
- closes the Network Connection to the Server.

/ ​MQTT Server<def:mqtt-server>: A program or device that acts as an
    intermediary between MQTT Clients which publish Application Messages
    and MQTT Clients which have made Subscriptions. Also known
    informally as an MQTT #strong[Broker]. An MQTT Server:

- accepts Network Connections from MQTT Clients.
- accepts Application Messages published by MQTT Clients.
- processes Subscribe and Unsubscribe requests from MQTT Clients.
- forwards Application Messages that match MQTT Client Subscriptions.
- closes the Network Connection from the MQTT Client.

/ ​Client Identifier<def:client-identifier>: A UTF-8 encoded character
    string which uniquely identifies every Client connecting to a
    Server.
/ ​Session<def:session>: A stateful interaction between a Client and a
    Server which is associated with a Client Identifier. Some Sessions
    last only as long as the Virtual Connection, others can span
    multiple consecutive Virtual Connections between a Client and a
    Server.
/ ​Session State<def:session-state>: The set of data that describes a
    Session. The Session State held by a Client is different to that
    held by a Server. See #link(<session-state>)[4.1 "Session state"]
    for details.
/ ​Subscription<def:subscription>: A Subscription comprises a Topic
    Filter and a maximum QoS. A Subscription is associated with a single
    Session. A Session can contain more than one Subscription. Each
    Subscription within a Session has a different Topic Filter.
/ ​Wildcard Subscription<def:wildcard-subscription>: A Wildcard
    Subscription is a Subscription with a Topic Filter containing one or
    more wildcard characters. This allows the subscription to match more
    than one Topic Name. Refer to
    #link(<topic-wildcards>)[4.7.1.1 "Topic wildcards"] for a
    description of wildcard characters in a Topic Filter.
/ ​Topic Name<def:topic-name>: A label attached to an Application Message
    which is matched against the Subscriptions known to the Server.
/ ​Topic Alias<def:topic-alias>: A Topic Alias is a Two Byte Integer
    value that is used to identify the Topic instead of using the Topic
    Name. This reduces Packet sizes, and is useful when the Topic Names
    are long and the same Topic Names are used repetitively within a
    Virtual Connection.
/ ​Topic Filter<def:topic-filter>: An expression contained in a
    Subscription to indicate an interest in one or more topics. A Topic
    Filter can include wildcard characters and can match more than one
    Topic Name.
/ ​MQTT-SN Control Packet<def:mqtt-sn-control-packet>: A well-formed,
    self-contained, sequence of fields as defined in this specification,
    that is sent over an Underlying Network. Sometimes shortened to
    Packet.
/ ​Malformed Packet<def:malformed-packet>: A Control Packet that cannot
    be parsed according to this specification. Refer to
    #link(<handling-errors>)[4.12 "Handling errors"] for information
    about error handling.
/ ​Protocol Error<def:protocol-error>: An error that is detected after a
    Packet has been parsed and found to contain data that is not allowed
    by the protocol or is inconsistent with the state of the Client or
    Server. Refer to #link(<handling-errors>)[4.12 "Handling errors"]
    for information about error handling.
/ ​Will Message<def:will-message>: An Application Message which is
    published by the Server after the Virtual Connection is deleted in
    cases where the Virtual Connection is not deleted normally. Refer to
    #link(<will-flag>)[3.1.2.2 "Will Flag"] for information about Will
    Messages.
/ ​Retained Message<def:retained-message>: An Application Message which
    is stored by the Server for a Topic Name. When a Client subscribes
    to a topic which has a Retained Message set, the Server sends the
    Retained Message to the Client, depending on the setting of the
    Retain Handling Subscribe Flags. Refer to
    #link(<subscribe-flags>)[3.7.2 "SUBSCRIBE Flags"] and
    #link(<retained-messages>)[4.13 "Retained Messages"] for more
    information about Retained Messages.
/ ​Disallowed Unicode code point<def:disallowed-unicode-code-point>: The
    set of Unicode Control Codes and Unicode Noncharacters which should
    not be included in a UTF-8 Encoded String. Refer to
    #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"] for more
    information about the Disallowed Unicode code points.

== Normative References
<normative-references>
#strong[\[]<RFC2119>#strong[RFC2119\]] Bradner, S., "Key words for use
in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI
10.17487/RFC2119, March 1997,
#link("http://www.rfc-editor.org/info/rfc2119")

#strong[\[]<RFC8174>#strong[RFC8174\]] Leiba, B., "Ambiguity of
Uppercase vs Lowercase in RFC 2119 Key Words", BCP 14, RFC 8174, DOI
10.17487/RFC8174, May 2017,
#link("https://www.rfc-editor.org/info/rfc8174")

#strong[\[]<RFC3629>#strong[RFC3629\]] Yergeau, F., "UTF-8, a
transformation format of ISO 10646", STD 63, RFC 3629, DOI
10.17487/RFC3629, November 2003,
#link("https://www.rfc-editor.org/info/rfc3629")

#strong[\[]<RFC6455>#strong[RFC6455\]] Fette, I. and A. Melnikov, "The
WebSocket Protocol", RFC 6455, DOI 10.17487/RFC6455, December 2011,
#link("http://www.rfc-editor.org/info/rfc6455")

#strong[\[]<Unicode>#strong[Unicode\]] The Unicode Consortium. The
Unicode Standard, #link("http://www.unicode.org/versions/latest/")

== Informative References
<informative-references>
#strong[\[]<RFC3552>#strong[RFC3552\]] Rescorla, E. and B. Korver,
"Guidelines for Writing RFC Text on Security Considerations", BCP 72,
RFC 3552, DOI 10.17487/RFC3552, July 2003,
#link("https://www.rfc-editor.org/info/rfc3552")

== MQTT For Sensor Networks (MQTT-SN)
<mqtt-for-sensor-networks-mqtt-sn>
Sensor Networks are simple, low cost and easy to deploy. They are
typically used to provide event detection, monitoring, automation,
process control and more. Sensor Networks often comprise many
battery-powered sensors and actuators, each containing a limited amount
of storage and processing capability. They usually communicate
wirelessly.

Sensor Networks are typically self-forming, continually changing, and do
not have any central control. The wireless network connections and
processing nodes will fail, and the batteries will run out. The nodes
will be replaced, added or removed in an unplanned way. The identities
of the devices are usually created when they are manufactured, this
avoids the need for specialist configuration when they are deployed.
Applications running outside the Sensor Network do not need to know the
details of the devices in it. The applications consume information from
the sensors and send instructions to actuators based only on labels
created by the application designers. The labels are called Topic Names
in the MQTT and MQTT-SN protocols. The MQTT-SN implementation carries
information between a set of applications and the correct set of devices
based on its knowledge of the network and the applications designer's
choice of Topic Names.

Consider an example of a medicine tracking application. The application
needs to know the location and temperature of the medicine, but it does
not want to concern itself with the network details of the devices
providing the data. It may be that the number and types of the devices
changes over time. There may also be other applications using the same
sensor data for other purposes. The model is that the devices and
applications produce and consume data addressed by the Topics rather
than the other devices and applications.

This MQTT-SN specification is a variant of the MQTT version 5
specification. It is adapted to exploit low power and low bandwidth
wireless networks. Low power wireless radio links typically have higher
numbers of transmission errors compared to more powerful networks
because they are more susceptible to interference and fading of the
radio signals. They also have lower transmission rates.

For example, wireless networks based on the IEEE 802.15.4 standard used
by Zigbee have a maximum bandwidth of 250 kbit/s in the 2.4 GHz band. To
reduce transmission errors the packets are kept short. The maximum
packet length at the physical layer is 128 bytes and half of these may
be used for Media Access Control and security.

The MQTT-SN protocol is optimized for implementation on low-cost,
battery-operated devices with limited processing and storage resources.
The capabilities are kept simple and the specification allows partial
implementations.

=== Differences Between MQTT-SN and MQTT
<differences-between-mqtt-sn-and-mqtt>
To facilitate interoperation MQTT-SN is similar in many ways to MQTT,
but the two are independent of each other.

MQTT-SN can work isolated from other networks or in conjunction with
MQTT. The main differences between MQTT-SN and MQTT are:

+ In addition to Topic Alias and long Topic Names MQTT-SN allows
  Predefined Topic Aliases.

+ Support for sleeping clients allows battery operated devices to enter
  a low power mode. In this state, Application Messages for the Client
  are buffered by the Server and delivered when the client wakes.

+ A new Quality of Service level (WITHOUT SESSION) is introduced in
  MQTT-SN, allowing devices to publish without a session having been
  established.

+ MQTT-SN has fewer requirements on the underlying transport and it can
  use connectionless network transports such as User Datagram Protocol
  (UDP).

+ MQTT-SN introduces the PROTECTION packet for packet-based security
  based on symmetric-key cryptography.

+ If the network supports sending messages to more than one recipient at
  once, Gateway Advertisement and Discovery can be implemented.

=== Interoperation with MQTT
<interoperation-with-mqtt>
MQTT-SN 2.0 was developed from MQTT-SN 1.2 adopting some of the concepts
and solutions introduced in MQTT 5.0. This means that an MQTT-SN 2.0
gateway can interoperate with MQTT 5.0 more easily than MQTT 3.1.1.
Interoperation with MQTT 3.1.1 is still feasible, but the translation
between the two protocols takes more effort, similar to the translation
between MQTT 3.1.1 and 5.0.

== Data representation
<data-representation>
=== Bits (Byte)
<bits-byte>
Bits in a byte are labeled 7 to 0. Bit number 7 is the most significant
bit, the least significant bit is assigned bit number 0.

=== Two Byte Integer
<two-byte-integer>
Two Byte Integer data values are 16-bit unsigned integers in big-endian
order: the high order byte precedes the lower order byte. This means
that a 16-bit word is presented on the network as Most Significant Byte
(MSB), followed by Least Significant Byte (LSB).

=== Four Byte Integer
<four-byte-integer>
Four Byte Integer data values are 32-bit unsigned integers in big-endian
order: the high order byte precedes the successively lower order bytes.
This means that a 32-bit word is presented on the network as Most
Significant Byte (MSB), followed by the next most Significant Byte
(MSB), followed by the next most Significant Byte (MSB), followed by
Least Significant Byte (LSB).

=== UTF-8 Encoded String
<utf-8-encoded-string>
Text fields within the MQTT-SN Control Packets are encoded as fixed
length UTF-8 strings. UTF-8 \[#link(<RFC3629>)[RFC3629]\] is an
efficient encoding of Unicode \[#link(<Unicode>)[Unicode]\] characters
that optimizes the encoding of ASCII characters in support of text-based
communications.

Unless stated otherwise all variable length UTF-8 encoded strings can
have any length in the range 0 to 65,535 bytes.

#figure(image("images/image14.png", alt: "Structure of UTF-8 Encoded Strings"),
  caption: [
    Structure of UTF-8 Encoded Strings
  ]
)
<fig-structure-of-utf-8-encoded-strings>

«#box()<MQTT-SN-1.8.4-1>The character data in a UTF-8 Encoded String
MUST be well-formed UTF-8 as defined by the Unicode specification
\[#link(<Unicode>)[Unicode]\] and restated in RFC 3629
\[#link(<RFC3629>)[RFC3629]\]. In particular, the character data MUST
NOT include encodings of code points between U+D800 and
U+DFFF»#link(<tab-MQTT-SN-1.8.4-1>)[MQTT‑SN‑1.8.4‑1].

If the Client or Server receives an MQTT-SN Control Packet containing
ill-formed UTF-8 it is a Malformed Packet. Refer to
#link(<handling-errors>)[4.12 "Handling errors"] for information about
handling errors.

«#box()<MQTT-SN-1.8.4-2>A UTF-8 Encoded String MUST NOT include an
encoding of the null character
U+0000»#link(<tab-MQTT-SN-1.8.4-2>)[MQTT‑SN‑1.8.4‑2]. If a receiver
(Server or Client) receives an Control Packet containing U+0000 in a
UTF-8 Encoded String it is a Malformed Packet.

UTF-8 Encoded Strings SHOULD NOT include the Unicode \[Unicode\] code
points listed below. If a receiver (Server or Client) receives an
MQTT-SN Control Packet with UTF-8 Encoded Strings containing any of them
it MAY treat it as a Malformed Packet. These are the Disallowed Unicode
code points.

- U+0001..U+001F control characters

- U+007F..U+009F control characters

- Code points defined in the Unicode specification
  \[#link(<Unicode>)[Unicode]\] to be non-characters (for example
  U+0FFFF)

«#box()<MQTT-SN-1.8.4-3>A UTF-8 encoded sequence 0xEF 0xBB 0xBF is
always interpreted as U+FEFF (\"ZERO WIDTH NO-BREAK SPACE\") wherever it
appears in a string and MUST NOT be skipped over or stripped off by a
packet receiver»#link(<tab-MQTT-SN-1.8.4-3>)[MQTT‑SN‑1.8.4‑3].

#quote(block: true)[
#strong[Informative example]

For example, the string A𪛔 which is LATIN CAPITAL Letter A followed by
the code point U+2A6D4 (which represents a CJK IDEOGRAPH EXTENSION B
character) is encoded as follows:

#figure(image("images/image31.png", alt: "Fixed Length UTF-8 Encoded String informative example"),
  caption: [
    Fixed Length UTF-8 Encoded String informative example
  ]
)
<fig-fixed-length-utf-8-encoded-string-informative-example>
]

== Typographical Conventions
<typographical-conventions>
Keywords defined by this specification use this `monospaced` font.

```
    Normative source code uses this paragraph style.
```

Text following the special symbol («) -- an opening Guillemet (or French
quotation mark) -- within this specification identifies automatically
testable requirements to aid assertion tools. Every such statement is
separated from the following text with the special end symbol (») -- a
closing Guillemet and has been assigned a reference that follows that
end symbol as the pattern `[MQTT-SN-section#-local#]`.

These normative requirements are tabulated in
#link(<appendix-b.-mandatory-normative-statements-informative>)[Appendix B "Mandatory normative statements (informative)"].

All examples in this document are informative only.

All other text is normative unless otherwise labeled e.g.~like the
following informative comment:

#quote(block: true)[
This is a pure informative comment that may be present, because the
information conveyed is deemed useful advice or common pitfalls learned
from implementer or operator experience and often given including the
rationale.
]

This document adheres to the Modern Language Association (MLA) style
guidelines for formatting titles and terms.

#pagebreak(weak: true)
= MQTT-SN Control Packet format
<mqtt-sn-control-packet-format>
== Structure of an MQTT-SN Control Packet
<structure-of-an-mqtt-sn-control-packet>
The MQTT-SN protocol operates by exchanging a series of MQTT-SN Control
Packets in a defined way. This section describes the format of these
packets.

An MQTT-SN Control Packet consists of up to two parts, always in the
following order as shown below.

#figure(image("images/structure-packet-diagram.png", alt: "Packet Structure"),
  caption: [
    Packet Structure
  ]
)
<fig-packet-structure>

=== Packet Header
<packet-header>
Each MQTT-SN Control Packet contains a Header of format 1 or format 2 as
shown below.

#figure(image("images/image12.png", alt: "Packet Header Format 1"),
  caption: [
    Packet Header Format 1
  ]
)
<fig-packet-header-format-1>

#figure(image("images/image16.png", alt: "Packet Header Format 2"),
  caption: [
    Packet Header Format 2
  ]
)
<fig-packet-header-format-2>

=== Length
<length>
The #emph[Length] field is either 1-byte or 3-byte integer and specifies
the total number of bytes contained in the packet (including the
#emph[Length] field itself).

If the first byte of the #emph[Length] field is coded "0x01" then the
#emph[Length] field is 3-bytes long; in this case, the two following
bytes specify the total number of bytes of the packet (most-significant
byte first). Otherwise, the #emph[Length] field is only 1-byte long and
specifies itself the total number of bytes contained in the packet.

The 3-byte format allows the encoding of packet lengths up to 65,535
bytes. It is more efficient to use the shorter 1-byte format for packets
with lengths up to and including 255 bytes.

«#box()<MQTT-SN-2.1.2-1>A Client or Server receiving MQTT-SN Control
Packets MUST be able to process both 1-byte and 3-byte length
formats»#link(<tab-MQTT-SN-2.1.2-1>)[MQTT‑SN‑2.1.2‑1].

#quote(block: true)[
#strong[Informative comment]

MQTT-SN does not support packet fragmentation and reassembly, the
maximum packet length that could be used in a network is governed by the
maximum packet size that is supported by that network, and not by the
maximum length that could be encoded by MQTT-SN.
]

=== MQTT-SN Control Packet Type
<mqtt-sn-control-packet-type>
The MQTT-SN Control Packet Type field is a 1-byte unsigned value, the
values are shown below.

#figure(
  align(center)[#table(
    columns: (14.42%, 5.29%, 21.15%, 59.13%),
    align: (center,center,center,auto,),
    table.header([Name], [Value], [Direction of flow], [Description],),
    table.hline(),
    [#strong[Reserved]], [0x00], [Forbidden], [Reserved],
    [#strong[CONNECT]], [0x01], [Client to Server], [Virtual Connection
    request],
    [#strong[CONNACK]], [0x02], [Server to Client], [Virtual Connection
    acknowledgement],
    [#strong[PUBLISH]], [0x03], [Client to Server or Server to
    Client], [Publish message],
    [#strong[PUBACK]], [0x04], [Client to Server or Server to
    Client], [Publish acknowledgment (QoS 1) or Publish error (Any
    QoS).],
    [#strong[PUBREC]], [0x05], [Client to Server or Server to
    Client], [Publish received (QoS 2 delivery part 1)],
    [#strong[PUBREL]], [0x06], [Client to Server or Server to
    Client], [Publish release (QoS 2 delivery part 2)],
    [#strong[PUBCOMP]], [0x07], [Client to Server or Server to
    Client], [Publish complete (QoS 2 delivery part 3)],
    [#strong[SUBSCRIBE]], [0x08], [Client to Server], [Subscribe
    request],
    [#strong[SUBACK]], [0x09], [Server to Client], [Subscribe
    acknowledgment],
    [#strong[UNSUBSCRIBE]], [0x0A], [Client to Server], [Unsubscribe
    request],
    [#strong[UNSUBACK]], [0x0B], [Server to Client], [Unsubscribe
    acknowledgment],
    [#strong[PINGREQ]], [0x0C], [Client to Server], [PING request],
    [#strong[PINGRESP]], [0x0D], [Server to Client], [PING response],
    [#strong[DISCONNECT]], [0x0E], [Client to Server or Server to
    Client], [Disconnect notification],
    [#strong[AUTH]], [0x0F], [Client to Server or Server to
    Client], [Authentication handshake],
    [#strong[REGISTER]], [0x10], [Client to Server], [Request topic
    alias],
    [#strong[REGACK]], [0x11], [Server to Client], [Supply topic alias],
    [#strong[PUBWOS]], [0x12], [Client to Server or Server to
    Client], [Publish packet for out of session messages which have no
    session on the receiver],
    [#strong[SLEEPREQ]], [0x13], [Client to Server], [Sleep request],
    [#strong[SLEEPRESP]], [0x14], [Server to Client], [Sleep response],
    [#strong[WAKEUP]], [0x15], [Server to Client], [Wake up request],
    [#strong[ADVERTISE]], [0x16], [Server to Clients], [Advertise the
    Server presence],
    [#strong[SEARCHGW]], [0x17], [Client to Servers], [Client GWINFO
    request],
    [#strong[GWINFO]], [0x18], [Server to Client], [Response to a
    SEARCHGW],
    [#strong[Reserved]], [0x19 -0xFB], [Forbidden], [Reserved],
    [#strong[Forwarder Encapsulation]], [0xFC], [Forwarder to Client or
    Forwarder to Server], [MQTT-SN packet envelope to add addressing
    information for Forwarders],
    [#strong[Reserved]], [0xFD], [Forbidden], [Reserved to avoid clash
    with MQTT-SN 1.2 Encapsulation],
    [#strong[Connection Encapsulation]], [0xFE], [Client to
    Server], [MQTT-SN packet envelope to add Connection identification],
    [#strong[Protection Encapsulation]], [0xFF], [Client to Server or
    Server to Client], [A protection envelope that can encapsulate any
    MQTT-SN packet other than the Forwarder Encapsulation (0xFC)],
  )]
  , caption: [MQTT-SN Control Packet Types]
  , kind: table
  )
<tab-mqtt-sn-control-packet-types>

== Packet Identifier
<packet-identifier>
The Variable Header component of many of the MQTT-SN Control Packet
types includes a Two Byte Integer Packet Identifier field. MQTT-SN
Control Packets that require a Packet Identifier, along with the
corresponding response Packet which all also require a Packet
Identifier, are shown in
#link(<tab-packets-with-packet-identifier>)[Table 2].

#figure(
  align(center)[#table(
    columns: 3,
    align: (left,left,left,),
    table.header([MQTT-SN Control Packet], [Packet
      Identifier?], [Response Packet],),
    table.hline(),
    [ADVERTISE], [NO], [],
    [AUTH], [YES], [AUTH, CONNACK],
    [CONNECT], [YES], [AUTH, CONNACK],
    [DISCONNECT], [OPTIONAL], [],
    [FORWARDER ENCAPSULATION], [NO], [],
    [GWINFO], [NO], [],
    [PINGREQ], [YES], [PINGRESP],
    [PROTECTION ENCAPSULATION], [NO], [],
    [PUBLISH - QoS 0], [NO], [],
    [PUBLISH - QoS 1], [YES], [PUBACK],
    [PUBLISH - QoS 2], [YES], [PUBREC],
    [PUBREL], [YES], [PUBCOMP],
    [PUBWOS], [NO], [],
    [REGISTER], [YES], [REGACK],
    [SEARCHGW], [NO], [],
    [SLEEPREQ], [YES], [SLEEPRESP],
    [SUBSCRIBE], [YES], [SUBACK],
    [UNSUBSCRIBE], [YES], [UNSUBACK],
    [WAKEUP], [NO], [],
  )]
  , caption: [Packets with Packet Identifier]
  , kind: table
  )
<tab-packets-with-packet-identifier>

«#box()<MQTT-SN-2.2-1>Each time a Client sends a new MQTT-SN Control
Packet which is identified in
#link(<tab-packets-with-packet-identifier>)[Table 2] as requiring a
Packet Identifier, it MUST assign it a non-zero Packet Identifier that
is currently unused»#link(<tab-MQTT-SN-2.2-1>)[MQTT‑SN‑2.2‑1].

«#box()<MQTT-SN-2.2-2>A PUBLISH packet MUST NOT contain a Packet
Identifier if its QoS value is set to
0»#link(<tab-MQTT-SN-2.2-2>)[MQTT‑SN‑2.2‑2].

«#box()<MQTT-SN-2.2-3>Each time a Server sends a new PUBLISH (with QoS
greater than 0) MQTT-SN Control Packet it MUST assign it a non zero
Packet Identifier that is currently
unused»#link(<tab-MQTT-SN-2.2-3>)[MQTT‑SN‑2.2‑3].

Packet Identifiers in all packets which require one (as shown in
#link(<tab-packets-with-packet-identifier>)[Table 2]), including
response packets, form a single, unified set of identifiers separately
for the Client and the Server in a Session.

The Packet Identifier becomes available for reuse after the sender has
processed the corresponding response packet, as shown in
#link(<tab-packets-with-packet-identifier>)[Table 2], except for the
case of PUBLISH QoS 2, where it is either a PUBCOMP or a PUBREC with a
Reason Code of 0x80 or greater.

«#box()<MQTT-SN-2.2-4>A response packet MUST contain the same Packet
Identifier as the Packet that it is responding
to»#link(<tab-MQTT-SN-2.2-4>)[MQTT‑SN‑2.2‑4].

The Client and Server assign Packet Identifiers independently of each
other. As a result, Client-Server pairs can participate in concurrent
Packet exchanges using the same Packet Identifiers.

#quote(block: true)[
#strong[Informative comment]

It is possible for a Client to send a PUBLISH packet with Packet
Identifier 0x1234 and then receive a different PUBLISH packet with
Packet Identifier 0x1234 from its Server before it receives a PUBACK for
the PUBLISH packet that it sent.
]

#figure(image("images/image13.png", alt: "Publishes with the same Packet Identifier"),
  caption: [
    Publishes with the same Packet Identifier
  ]
)
<fig-publishes-with-the-same-packet-identifier>

== Reason Code
<reason-code>
A Reason Code is a one byte unsigned value that indicates the result of
an operation. Reason Codes less than 0x80 indicate successful completion
of an operation. The normal Reason Code for success is 0x00. Reason Code
values of 0x80 or greater indicate failure.

The Reason Codes share a common set of values as shown below.

#figure(
  align(center)[#table(
    columns: (9%, 9%, 11%, 24%, 47%),
    align: (left,left,left,left,left,),
    table.header([ID(Dec)], [ID(Hex)], [Name], [Packets], [Description],),
    table.hline(),
    [0], [0x00], [Success], [CONNACK, SUBACK, UNSUBACK, REGACK, PUBACK,
    PUBREC, PUBREL, PUBCOMP, SLEEPRESP, AUTH (server only)], [The
    operation was successful.],
    [0], [0x00], [Normal disconnection], [DISCONNECT], [Delete the
    (Virtual) Connection normally. Do not send the Will Message.],
    [0], [0x00], [Granted QoS 0], [SUBACK], [The subscription is
    accepted and the maximum QoS sent will be QoS 0. This might be a
    lower QoS than was requested.],
    [1], [0x01], [Granted QoS 1], [SUBACK], [The subscription is
    accepted and the maximum QoS sent will be QoS 1. This might be a
    lower QoS than was requested.],
    [2], [0x02], [Granted QoS 2], [SUBACK], [The subscription is
    accepted and any received QoS will be sent to this subscription.],
    [4], [0x04], [Disconnect with will message], [DISCONNECT (client
    only)], [The Client wishes to disconnect but requires that the
    Server also publishes its Will Message.],
    [16], [0x10], [No matching subscribers], [PUBACK, PUBREC], [The
    Application Message is accepted but there are no subscribers. If the
    Server knows that there are no matching subscribers, it MAY use this
    Reason Code instead of 0x00 (Success).],
    [17], [0x11], [No subscription existed], [UNSUBACK], [No matching
    Topic Filter is being used by the Client.],
    [24], [0x18], [Continue authentication], [AUTH], [Continue the
    authentication with another step.],
    [25], [0x19], [Re-authenticate], [AUTH (client only)], [Initiate a
    re-authentication.],
    [26], [0x1A], [Topic Alias Exists], [REGACK], [A Session Topic Alias
    was requested, but a Session or Predefined Topic Alias already
    exists. (MQTT-SN only)],
    [128], [0x80], [Unspecified error], [CONNACK, PUBACK, PUBREC,
    SUBACK, UNSUBACK, DISCONNECT], [The receiver does not accept the
    request but either does not want to reveal the reason, or it does
    not match one of the other values.],
    [129], [0x81], [Malformed packet], [CONNACK, DISCONNECT], [The
    received packet does not conform to this specification.],
    [130], [0x82], [Protocol error], [CONNACK, DISCONNECT], [An
    unexpected or out of order packet was received.],
    [131], [0x83], [Implementation specific error], [CONNACK, PUBACK,
    PUBREC, REGACK, SUBACK, UNSUBACK, DISCONNECT], [The packet received
    is valid but cannot be processed by this implementation.],
    [132], [0x84], [Unsupported Protocol Version], [CONNACK], [The
    Server does not support the version of the MQTT or MQTT-SN protocol
    requested by the Client.],
    [133], [0x85], [Client identifier not valid], [CONNACK], [The Client
    Identifier is a valid string but is not allowed by the Server.],
    [134], [0x86], [Bad user name or password], [CONNACK], [The Server
    does not accept the User Name or Password specified by the Client],
    [135], [0x87], [Not authorized], [CONNACK, PUBACK, PUBREC, REGACK,
    SUBACK, UNSUBACK, DISCONNECT (server only)], [The request is not
    authorized.],
    [136], [0x88], [Server unavailable], [CONNACK], [The MQTT-SN Server
    is not available or, in the case of a Transparent gateway, the MQTT
    server is not available.],
    [137], [0x89], [Server busy], [CONNACK, DISCONNECT (server
    only)], [The Server is busy and cannot continue processing requests
    from this Client.],
    [138], [0x8A], [Banned], [CONNACK], [This Client has been banned by
    administrative action. Contact the server administrator.],
    [139], [0x8B], [Server shutting down], [DISCONNECT (server
    only)], [The Server is shutting down.],
    [140], [0x8C], [Bad authentication method], [CONNACK,
    DISCONNECT], [The authentication method is not supported or does not
    match the authentication method currently in use.],
    [141], [0x8D], [Keep Alive timeout], [DISCONNECT (server
    only)], [The (Virtual) Connection is closed because no packet has
    been received for 1.5 times the Keep Alive time.],
    [142], [0x8E], [Session taken over], [DISCONNECT (server
    only)], [Another (Virtual) Connection using the same Client
    Identifier has connected causing this (Virtual) Connection to be
    closed.],
    [143], [0x8F], [Topic filter invalid], [SUBACK, UNSUBACK, DISCONNECT
    (server only)], [The Topic Filter is correctly formed, but is not
    accepted by this Server.],
    [144], [0x90], [Topic name invalid], [CONNACK, PUBACK, PUBREC,
    DISCONNECT (server only)], [The Topic Name is correctly formed, but
    is not accepted by this Client or Server.],
    [145], [0x91], [Packet identifier in use], [PUBACK, PUBREC, SUBACK,
    UNSUBACK, REGACK, PINGRESP, SLEEPRESP], [The specified Packet
    Identifier is already in use.],
    [146], [0x92], [Packet identifier not found], [PUBREL,
    PUBCOMP], [The Packet Identifier is not known. This is not an error
    during recovery, but at other times indicates a mismatch between the
    Session State on the Client and Server.],
    [147], [0x93], [Receive maximum exceeded], [DISCONNECT], [The Client
    or Server has received more than Receive Maximum publication for
    which it has not sent PUBACK or PUBCOMP.],
    [148], [0x94], [Topic alias invalid], [DISCONNECT (server
    only)], [The Client or Server has received a PUBLISH packet
    containing a Topic Alias which is greater than the Maximum Topic
    Alias it sent in the CONNECT or CONNACK packet. (Transparent gateway
    only)],
    [149], [0x95], [Packet too large], [CONNACK, DISCONNECT], [The
    packet size is greater than Maximum Packet Size for this Client or
    Server.],
    [150], [0x96], [Packet rate too high], [DISCONNECT], [The received
    data rate is too high.],
    [151], [0x97], [Quota exceeded], [REGACK, SUBACK, DISCONNECT], [An
    implementation or administrative imposed limit has been exceeded.],
    [152], [0x98], [Administrative action], [DISCONNECT], [The Virtual
    Connection is deleted due to an administrative action.],
    [153], [0x99], [Payload format invalid], [PUBACK, PUBREC, DISCONNECT
    (server only)], [The MQTT payload format does not match the one
    specified by the Payload Format Indicator. (Transparent gateway
    only)],
    [154], [0x9A], [Retain not supported], [CONNACK, DISCONNECT (server
    only)], [The MQTT Server does not support retained messages.
    (Transparent gateway only)],
    [155], [0x9B], [QoS not supported], [CONNACK, DISCONNECT (server
    only)], [The Client specified a QoS greater than the QoS specified
    in a Maximum QoS in the MQTT CONNACK. (Transparent gateway only)],
    [156], [0x9C], [Use another server], [CONNACK, DISCONNECT (server
    only)], [The Client should temporarily change its Server.],
    [157], [0x9D], [Server moved], [CONNACK, DISCONNECT (server
    only)], [The Server is moved and the Client should permanently
    change its server location.],
    [158], [0x9E], [Shared subscription not supported], [SUBACK,
    DISCONNECT (server only)], [The MQTT Server does not support Shared
    Subscriptions. (Transparent gateway only)],
    [159], [0x9F], [Connection rate exceeded], [CONNACK, DISCONNECT
    (server only)], [This (Virtual) Connection is deleted because the
    connection rate is too high.],
    [160], [0xA0], [Maximum connect time], [DISCONNECT (server
    only)], [The maximum connection time authorized for this (Virtual)
    Connection has been exceeded.],
    [161], [0xA1], [Subscription identifiers not supported], [SUBACK,
    DISCONNECT (server only)], [The MQTT Server does not support
    Subscription Identifiers; the subscription is not accepted.
    (Transparent gateway only)],
    [162], [0xA2], [Wildcard subscription not supported], [SUBACK,
    DISCONNECT (server only)], [The MQTT Server does not support
    Wildcard Subscriptions; the subscription is not accepted.
    (Transparent Gateway only)],
    [230], [0xE6], [Only PROTECTION packet supported (Note 1)], [Any
    packet except PROTECTION and Forwarder Encapsulation], [The Receiver
    was expecting a packet to be Protection Encapsulated. (MQTT-SN
    only)],
    [231], [0xE7], [Protection scheme invalid], [DISCONNECT], [Specific
    to MQTT-SN],
    [232], [0xE8], [Unknown Sender Id], [DISCONNECT], [Specific to
    MQTT-SN],
    [240], [0xF0], [Unknown Topic Alias], [PUBACK, PUBREC, SUBACK,
    UNSUBACK, REGACK], [Specific to MQTT-SN],
    [241], [0xF1], [Congestion], [SUBACK, REGACK, CONNACK, PUBACK,
    PUBREC], [Try again later. See
    #link(<c.2-server-congestion>)[C.3 Server Congestion] (MQTT-SN
    only)],
    [242], [0xF2], [Protection packet not
    supported], [DISCONNECT], [Specific to MQTT-SN],
    [243], [0xF3], [Forwarder Encapsulation not
    supported], [DISCONNECT], [Specific to MQTT-SN],
    [244], [0xF4], [No Virtual Connection
    exists], [DISCONNECT], [Specific to MQTT-SN],
    [245 - 255], [0xF5 - 0xFF], [Reserved for MQTT-SN], [], [Specific to
    MQTT-SN],
  )]
  , caption: [Reason Codes]
  , kind: table
  )
<tab-reason-codes>

Note(s):

+ Used by a receiver to indicate that it expected a packet to be
  protected and it was not.

+ The MQTT-SN dedicated range of reason codes is from 0xE6 (230) to
  0xFF(255).

+ \(Virtual) Connection means this can apply to either an MQTT
  Connection or an MQTT-SN Virtual Connection.

== Topic Types
<topic-types>
Several packets refer to a Topic Type in their flags. This is a 2-bit
field which determines the format of the topic value. The allowable
values are as follows:

#figure(
  align(center)[#table(
    columns: (5%, 10%, 16%, 69%),
    align: (left,left,left,left,),
    table.header([], [Topic Type Value], [Name], [Description],),
    table.hline(),
    [0], [0b00], [Session Topic Alias], [A session Topic Alias is
    negotiated between the Server and Client within the scope of a
    session.],
    [1], [0b01], [Predefined Topic Alias], [A predefined Topic Alias is
    known statically by both the Server and the Client outside the scope
    of a session. No negotiation is required since both entities have
    knowledge of the topic alias mapping.],
    [2], [0b10], [], [Reserved],
    [3], [0b11], [Topic Name or Filter], [A Topic Name or Topic Filter,
    which requires no session negotiation.],
  )]
  , caption: [Topic Types]
  , kind: table
  )
<tab-topic-types>

Predefined and Session Topic Aliases are assigned from different pools
so there is no danger of collision.

Refer to #link(<topics>)[4.7 "Topics"] for detailed descriptions of
Topic Names and Topic Aliases.

#pagebreak(weak: true)
= MQTT-SN Control Packets
<mqtt-sn-control-packets>
== CONNECT - Connection Request
<connect---connection-request>
#figure(image("images/connect-packet-diagram.png", alt: "CONNECT Packet"),
  caption: [
    CONNECT Packet
  ]
)
<fig-connect-packet>

The CONNECT packet is sent from the Client to the Server to request the
creation of or continuation of a Session.

=== CONNECT Header
<connect-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format.Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Connect Flags
<connect-flags>
The Connect Flags is 1 byte field which contains several parameters
specifying the behavior of the MQTT-SN Virtual Connection. It also
indicates the presence or absence of fields in the Packet.
«#box()<MQTT-SN-3.1.2-1>Bit 7 of the CONNECT Flags is reserved and MUST
be set to 0»#link(<tab-MQTT-SN-3.1.2-1>)[MQTT‑SN‑3.1.2‑1].

«#box()<MQTT-SN-3.1.2-2>The Server MUST validate that the reserved flags
in the CONNECT packet are set to
0»#link(<tab-MQTT-SN-3.1.2-2>)[MQTT‑SN‑3.1.2‑2]. If any of the reserved
flags is not 0 it is a Malformed Packet. Refer to
#link(<handling-errors>)[4.12 "Handling errors"] for information about
handling errors.

==== Clean Start Flag
<clean-start-flag>
#strong[Position:] bit 0 of the Connect Flags byte.

This flag specifies whether the Virtual Connection starts a new Session
or is a continuation of an existing Session. Refer to
#link(<session-state>)[4.1 "Session state"] for a definition of the
Session State.

«#box()<MQTT-SN-3.1.2.1-1>If a CONNECT packet is received with Clean
Start is set to 1, the Client and Server MUST discard any existing
Session and start a new
Session»#link(<tab-MQTT-SN-3.1.2.1-1>)[MQTT‑SN‑3.1.2.1‑1]. Consequently,
the Session Present flag in CONNACK is always set to 0 if Clean Start is
set to 1.

«#box()<MQTT-SN-3.1.2.1-2>If a CONNECT packet is received with Clean
Start set to 0 and there is a Session associated with the Client
Identifier, the Server MUST resume communications with the Client based
on state from the existing
Session»#link(<tab-MQTT-SN-3.1.2.1-2>)[MQTT‑SN‑3.1.2.1‑2].

«#box()<MQTT-SN-3.1.2.1-3>If a CONNECT packet is received with Clean
Start set to 0 and there is no Session associated with the Client
Identifier, the Server MUST create a new
Session»#link(<tab-MQTT-SN-3.1.2.1-3>)[MQTT‑SN‑3.1.2.1‑3].

==== Will Flag
<will-flag>
#strong[Position:] bit 1 of the Connect Flags byte.

«#box()<MQTT-SN-3.1.2.2-1>If the Will Flag is set to 1, the Will Flags,
Will Topic, and Will Payload fields MUST be present in the
Packet»#link(<tab-MQTT-SN-3.1.2.2-1>)[MQTT‑SN‑3.1.2.2‑1].

«#box()<MQTT-SN-3.1.2.2-2>If the Will Flag is set to 1 this indicates
that a Will Message MUST be stored on the Server and associated with the
Session»#link(<tab-MQTT-SN-3.1.2.2-2>)[MQTT‑SN‑3.1.2.2‑2]. The Will
Message consists of the Will Topic, and Will Payload fields in the
CONNECT Packet.

«#box()<MQTT-SN-3.1.2.2-3>The Will Message MUST be published after the
Virtual Connection is deleted or the Session ends, unless the Will
Message has been deleted by the Server on receipt of a DISCONNECT packet
with Reason Code 0x00 (Normal
disconnection)»#link(<tab-MQTT-SN-3.1.2.2-3>)[MQTT‑SN‑3.1.2.2‑3].

Situations in which the Will Message is published include, but are not
limited to:

- The Server deletes the Virtual Connection as a result of an I/O error
  or network failure it has detected.

- The Client fails to communicate within the Keep Alive time.

- The Server deletes the Virtual Connection because of a protocol error.

- The Server deletes the Virtual Connection because of a Retry timeout.

«#box()<MQTT-SN-3.1.2.2-4>The Will Message MUST be removed from the
stored Session State in the Server once it has been published or the
Server has received a DISCONNECT packet with a Reason Code of 0x00
(Normal disconnection) from the
Client»#link(<tab-MQTT-SN-3.1.2.2-4>)[MQTT‑SN‑3.1.2.2‑4].

The Server SHOULD publish Will Messages promptly after the Virtual
Connection is deleted or the Session ends, whichever occurs first. In
the case of a Server shutdown or failure, the Server MAY defer
publication of Will Messages until a subsequent restart. If this
happens, there might be a delay between the time the Server experienced
failure and when the Will Message is published.

==== Authentication Flag
<authentication-flag>
#strong[Position:] bit 2 of the Connect Flags byte. Labelled #emph[Auth]
in #link(<fig-connect-packet>)[Figure 7].

«#box()<MQTT-SN-3.1.2.3-1>If the Authentication Flag is set to 1, the
Authentication Method and Authentication Data fields MUST be present in
the Packet»#link(<tab-MQTT-SN-3.1.2.3-1>)[MQTT‑SN‑3.1.2.3‑1].

«#box()<MQTT-SN-3.1.2.3-2>If the Authentication Flag is set to 0, the
Authentication Method and Authentication Data fields MUST NOT be present
in the Packet»#link(<tab-MQTT-SN-3.1.2.3-2>)[MQTT‑SN‑3.1.2.3‑2].

==== Session Expiry Flag
<session-expiry-flag>
#strong[Position:] bit 3 of the Connect Flags byte. Labelled #emph[Sess
Exp] in #link(<fig-connect-packet>)[Figure 7].

«#box()<MQTT-SN-3.1.2.4-1>If the Session Expiry Flag is set to 1, the
Session Expiry Interval field MUST be present in the
Packet»#link(<tab-MQTT-SN-3.1.2.4-1>)[MQTT‑SN‑3.1.2.4‑1].

«#box()<MQTT-SN-3.1.2.4-2>If the Session Expiry Flag is set to 0, the
Session Expiry Interval field MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.1.2.4-2>)[MQTT‑SN‑3.1.2.4‑2].

==== Maximum Number of Awake Messages Flag
<max-awake-messages-flag>
#strong[Position:] bit 4 of the Connect Flags byte. Labelled #emph[MAM]
in #link(<fig-connect-packet>)[Figure 7].

«#box()<MQTT-SN-3.1.2.5-1>If the Maximum Number of Awake Messages Flag
is set to 1, the Maximum Number of Awake Messages field MUST be present
in the Packet»#link(<tab-MQTT-SN-3.1.2.5-1>)[MQTT‑SN‑3.1.2.5‑1].

«#box()<MQTT-SN-3.1.2.5-2>If the Maximum Number of Awake Messages Flag
is set to 0, the Maximum Number of Awake Messages field MUST NOT be
present in the Packet»#link(<tab-MQTT-SN-3.1.2.5-2>)[MQTT‑SN‑3.1.2.5‑2].

==== Allow Network Address Changes Flag
<allow-network-address-changes-flag>
#strong[Position:] bit 5 of the Connect Flags byte. Labelled #emph[Net
Addr] in #link(<fig-connect-packet>)[Figure 7].

This flag only has an effect In implementations which use a Network
Address to associate incoming packets with a Virtual Connection,
otherwise it should be 0.

Setting this flag to 1 means that the Client authorizes the server to
update the Network Address associated with a Virtual Connection. The
Client does this by sending a Connection Encapsulated Packet with the
Client Identifier. If its Network Address has changed, the Server can
update the Virtual Connection.

«#box()<MQTT-SN-3.1.2.6-1>If this flag is set to 0 and a Packet is
wrapped by the Connection Encapsulation, it is a protocol error. The
Server must send a DISCONNECT and delete the Virtual
Connection»#link(<tab-MQTT-SN-3.1.2.6-1>)[MQTT‑SN‑3.1.2.6‑1].

This flag affects the use of the Connection Encapsulation only, it does
not affect other methods of identifying the sender such as the
Protection Encapsulation.

==== Allow Server Suggested Values Flag
<allow-server-suggested-values-flag>
#strong[Position:] bit 6 of the Connect Flags byte. Labelled #emph[Srv
Sugg] in #link(<fig-connect-packet>)[Figure 7].

If this flag is set to 1, the Client allows the Server to return
modified values for all of:

- Keep Alive, in the CONNACK Packet

- Session Expiry, in the CONNACK Packet

- Sleep Duration in the SLEEPRESP Packet

for the Virtual Connection.

«#box()<MQTT-SN-3.1.2.7-1>If this flag is set to 0, the Server MUST NOT
include a Server Keep Alive field in the CONNACK Packet
response»#link(<tab-MQTT-SN-3.1.2.7-1>)[MQTT‑SN‑3.1.2.7‑1].

«#box()<MQTT-SN-3.1.2.7-2>If this flag is set to 0, the Server MUST NOT
include a Session Expiry field in the CONNACK Packet
response»#link(<tab-MQTT-SN-3.1.2.7-2>)[MQTT‑SN‑3.1.2.7‑2].

«#box()<MQTT-SN-3.1.2.7-3>If this flag is set to 0 for the current
Virtual Connection, the Server MUST NOT include a Sleep Duration in the
SLEEPRESP Packet»#link(<tab-MQTT-SN-3.1.2.7-3>)[MQTT‑SN‑3.1.2.7‑3].

=== Will Flags
<will-flags>
«#box()<MQTT-SN-3.1.3-1>If the Will Flag is set to 0, the Will Flags
MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.1.3-1>)[MQTT‑SN‑3.1.3‑1].

«#box()<MQTT-SN-3.1.3-2>If the Will Flag is set to 1, the Will Flags
MUST be present in the
Packet»#link(<tab-MQTT-SN-3.1.3-2>)[MQTT‑SN‑3.1.3‑2].

The #emph[Will Flags] is 1 byte field which contains several parameters
specifying the handling of the Will Message.
«#box()<MQTT-SN-3.1.3-3>Bits 7-5 of the Will Flags are reserved and MUST
be set to 0»#link(<tab-MQTT-SN-3.1.3-3>)[MQTT‑SN‑3.1.3‑3].

==== Will Topic Type
<will-topic-type>
#strong[Position:] bits 1 and 0 of the Will Flags byte.

This is a 2-bit field which determines the format of the topic value.
Refer to #link(<topic-types>)[2.4 "Topic Types"] for the definition of
the various topic types.

==== Will QoS
<will-qos>
#strong[Position:] bits 3 and 2 of the Will Flags byte.

These two bits specify the QoS level to be used. The value of Will QoS
can be 0 (0x00), 1 (0x01), or 2 (0x02). A value of 3 (0x03) is a
Malformed Packet.

==== Will Retain
<will-retain>
#strong[Position:] bit 4 of the Will Flags byte.

This specifies if the Will Message is to be retained when it is
published. See #link(<retained-messages>)[4.13 "Retained Messages"] for
more information about Retained Messages.

«#box()<MQTT-SN-3.1.3.3-1>If the Will Flag is set to 1 and Will Retain
is set to 0, the Server MUST publish the Will Message as a non-retained
message»#link(<tab-MQTT-SN-3.1.3.3-1>)[MQTT‑SN‑3.1.3.3‑1].

«#box()<MQTT-SN-3.1.3.3-2>If the Will Flag is set to 1 and Will Retain
is set to 1, the Server MUST publish the Will Message as a retained
message»#link(<tab-MQTT-SN-3.1.3.3-2>)[MQTT‑SN‑3.1.3.3‑2].

=== Packet Identifier
<cp---packet-identifier>
Used to identify the corresponding CONNACK or AUTH packet. It should
ideally be populated with a random Two Byte Integer value.

=== Protocol Version
<protocol-version>
The one-byte unsigned value that represents the revision level of the
protocol used by the Client.

#figure(
  align(center)[#table(
    columns: 2,
    align: (left,center,),
    table.header([Protocol Version], [Value],),
    table.hline(),
    [Version 1.2], [0x01],
    [#strong[Version 2.0]], [#strong[0x02]],
    [Reserved for future use], [0x03 -- 0xFF],
  )]
  , caption: [Protocol Versions]
  , kind: table
  )
<tab-protocol-versions>

«#box()<MQTT-SN-3.1.5-1>The value of the Protocol Version field for
MQTT-SN version 2.0 MUST be 2
(0x02)»#link(<tab-MQTT-SN-3.1.5-1>)[MQTT‑SN‑3.1.5‑1].

A Server which supports multiple versions of the MQTT-SN protocol uses
the Protocol Version to determine which version of MQTT-SN the Client is
using. «#box()<MQTT-SN-3.1.5-2>If the Protocol Version is not 2 and the
Server does not want to accept the CONNECT packet, the Server MAY send a
CONNACK packet with Reason Code 0x84 (Unsupported Protocol
Version)»#link(<tab-MQTT-SN-3.1.5-2>)[MQTT‑SN‑3.1.5‑2].

=== Keep Alive
<keep-alive>
The Keep Alive is a Two Byte Integer greater than 0 (1 - 65,535), which
is a time interval measured in seconds. It is the maximum time interval
that is permitted to elapse between the point at which the Client
finishes transmitting one MQTT-SN Control Packet and the point it starts
sending the next. It is the responsibility of the Client to ensure that
the interval between MQTT-SN Control Packets being sent does not exceed
the Keep Alive value. «#box()<MQTT-SN-3.1.6-1>In the absence of sending
any other MQTT-SN Control Packets, the Client MUST send a PINGREQ
packet»#link(<tab-MQTT-SN-3.1.6-1>)[MQTT‑SN‑3.1.6‑1].

#quote(block: true)[
#strong[Informative comment]

The Client can send PINGREQ at any time, irrespective of the Keep Alive
value, and check for a corresponding PINGRESP to determine that the
network and the Server are available.
]

«#box()<MQTT-SN-3.1.6-2>If the Server does not receive an MQTT-SN
Control Packet from the Client within one and a half times the Keep
Alive time period, it MUST delete the Virtual Connection and move the
Client to the Disconnected state (see
#link(<client-states>)[4.14 "Client states"])»#link(<tab-MQTT-SN-3.1.6-2>)[MQTT‑SN‑3.1.6‑2].

«#box()<MQTT-SN-3.1.6-3>If a Client does not receive a PINGRESP packet
within a #emph[\[Retry Interval\]] amount of time after it has sent a
PINGREQ, it SHOULD retry the transmission according to
#link(<unacknowledged-packets>)[4.4.2 "Unacknowledged Packets"] up to
the maximum number of attempts. If a PINGRESP is still not received it
MUST delete the Virtual Connection to the Server by way of a DISCONNECT,
with the understanding that the Server may no longer be
reachable»#link(<tab-MQTT-SN-3.1.6-3>)[MQTT‑SN‑3.1.6‑3].

#quote(block: true)[
#strong[Informative Comment]

Unlike MQTT, the MQTT-SN Keep Alive timeout can not be turned off (by
setting a value of 0). This is because there is no other indication in
MQTT-SN of a connection failure, as there is in MQTT with the underlying
TCP/IP connection.
]

«#box()<MQTT-SN-3.1.6-4>The Keep Alive must have a value greater than 0.
It is a protocol error if a Keep Alive value of 0 or below is
set»#link(<tab-MQTT-SN-3.1.6-4>)[MQTT‑SN‑3.1.6‑4].

#quote(block: true)[
#strong[Informative comment] \ The Server may have other reasons to
disconnect the Client, for instance because it is shutting down. Setting
Keep Alive does not guarantee that the Client will remain connected.

#strong[Informative comment]

The actual value of the Keep Alive is application specific; typically,
this is a few minutes. The maximum value of 65,535 is 18 hours 12
minutes and 15 seconds.

#strong[Informative Comment]

Clients can use the Keep Alive procedure to supervise the liveliness of
the Server to which they are connected. If a Client does not receive a
PINGRESP from the Server even after multiple retransmissions of the
PINGREQ packet and deletes the Virtual Connection, it might try to
connect to another Server before trying to reconnect to this Server.
]

=== Maximum Packet Size
<maximum-packet-size>
A Two Byte (16-bit) Integer representing the Maximum Packet Size the
Client is willing to accept. If the Maximum Packet Size is set to 0, no
limit on the packet size is imposed beyond the limitations in the
protocol as a result of the remaining length encoding and the protocol
header sizes.

#quote(block: true)[
#strong[Informative comment]

It is the responsibility of the application to select a suitable Maximum
Packet Size value if it chooses to restrict the Maximum Packet Size.
]

The packet size is the total number of bytes in an MQTT-SN Control
Packet, as defined in
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"].
The Client uses the Maximum Packet Size to inform the Server that it
will not process packets exceeding this limit.

«#box()<MQTT-SN-3.1.7-1>The Maximum Packet Size value MUST be 0
(unbounded), or 10 or
greater»#link(<tab-MQTT-SN-3.1.7-1>)[MQTT-SN-3.1.7-1], as 10 is the
minimum size that the CONNECT Packet can be.

«#box()<MQTT-SN-3.1.7-2>The Server MUST NOT send packets exceeding
Maximum Packet Size to the Client. If a Client receives a packet whose
size exceeds this limit, this is a Protocol Error, the Client uses
DISCONNECT with Reason Code 0x95 (Packet too
large)»#link(<tab-MQTT-SN-3.1.7-2>)[MQTT‑SN‑3.1.7‑2].

«#box()<MQTT-SN-3.1.7-3>Where a Packet is too large to send, the Server
MUST discard it without sending it and then behave as if it had
completed sending that Application
Message»#link(<tab-MQTT-SN-3.1.7-3>)[MQTT‑SN‑3.1.7‑3].

#quote(block: true)[
#strong[Informative comment]

Where a packet is discarded without being sent, the Server could take
some diagnostic action including alerting the Server administrator. Such
actions are outside the scope of this specification.
]

=== Maximum Number of Awake Messages
<max-awake-messages>
An optional single byte value to indicate the maximum number of messages
a Client shall receive during an AWAKE session. If this field is 0, or
is absent, it is up to the Server to determine how many messages it will
send, which may be unbounded.

=== Session Expiry Interval
<session-expiry-interval>
The Session Expiry Interval is a four-byte integer time interval
measured in seconds. If the Session Expiry Interval is absent the value
0 is used. If the Session Expiry Interval is set to 0, or is absent, the
Session ends when the Virtual Connection is deleted by the Client or
Server.

If the Session Expiry Interval is 0xFFFFFFFF (UINT\_MAX), the Session
does not expire.

«#box()<MQTT-SN-3.1.9-1>The Client and Server MUST store the Session
State after the Virtual Connection is deleted if the Session Expiry
Interval is greater than
0»#link(<tab-MQTT-SN-3.1.9-1>)[MQTT‑SN‑3.1.9‑1].

#quote(block: true)[
#strong[Informative comment]

The clock in the Client or Server may not be running for part of the
time interval, for instance because the Client or Server are not
running. This might cause the deletion of the state to be delayed.

#strong[Informative comment]

The client and Server between them should negotiate a reasonable and
practical session expiry interval according to the network and
infrastructure environment in which they are deployed. For example, it
would not be practical to set a session expiry interval of many months
on a Server whose hardware is only capable of storing a few client
sessions.

#strong[Informative comment]

A Client that only wants to process messages while connected will set
Clean Start to 1 and set the Session Expiry Interval to 0. It will not
receive Application Messages published before it is connected and has to
subscribe afresh to any topics that it is interested in each time it
connects.

#strong[Informative comment]

The Client should always use the Session Present flag in the CONNACK to
determine whether the Server has a Session State for this Client.
]

=== Will Topic Alias or Will Topic Name Length
<will-topic-alias-or-will-topic-name-length>
If the Will Flag is set to 1, the Will Topic Alias or Will Topic Name
Length is the next field in the Packet. In both cases, this is two
bytes.

In the case of Will Topic Type being Topic Name, this field will refer
to the length of the Will Topic Name field. In the other cases, this
will be the value used as the Will Topic Alias.

=== Will Topic Name
<will-topic-name>
If the Will Flag is set to 1 and the Will Topic Type is set to Topic
Name (0b11), the Will Topic Name is the next field in the Packet.
«#box()<MQTT-SN-3.1.11-1>The Will Topic Name MUST be a UTF-8 Encoded
String as defined in
#link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"]»#link(<tab-MQTT-SN-3.1.11-1>)[MQTT‑SN‑3.1.11‑1].

=== Will Payload Length
<will-payload-length>
If the Will Flag is set to 1, the Will Payload Length is the next field
in the Packet. It contains the length of the Will Payload field.

=== Will Payload
<will-payload>
If the Will Flag is set to 1, the Will Payload is the next field in the
Packet. The Will Payload defines the Application Message Payload that is
to be published to the Will Topic as described in
#link(<will-flag>)[3.1.2.2 "Will Flag"]. This field consists of Binary
Data.

=== Authentication Method Length
<authentication-method-length>
If the Auth Flag is set to 1, the Authentication Method Length is the
next field in the Packet. It is a single byte value (max 0-255 bytes),
representing the length of the field used to specify the authentication
method. Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

=== Authentication Method
<authentication-method>
If the Auth Flag is set to 1, the Authentication Method is the next
field in the Packet. It is a UTF-8 Encoded String containing the name of
the Authentication Method.

To support the equivalent of the MQTT User Name and Password fields in
the CONNECT packet, see
#link(<mqtt-user-name-and-password-support>)[4.11.1.2 "MQTT User Name and Password Support"].

Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

=== Authentication Data Length
<authentication-data-length>
If the Auth Flag is set to 1, the Authentication Data Length is the next
field in the Packet. It is a two byte value (max 0-65535 bytes),
representing the length of the field used to specify the authentication
data. Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

=== Authentication Data
<authentication-data>
If the Auth Flag is set to 1, the Authentication Data is the next field
in the Packet.

Binary Data containing authentication data. The contents of this data
are defined by the authentication method.

To support the equivalent of the MQTT User Name and Password CONNECT
packet fields, see
#link(<mqtt-user-name-and-password-support>)[4.11.1.2 "MQTT User Name and Password Support"].

Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

=== Client Identifier
<client-identifier>
«#box()<MQTT-SN-3.1.18-1>The Client Identifier MUST be a UTF-8 Encoded
String»#link(<tab-MQTT-SN-3.1.18-1>)[MQTT‑SN‑3.1.18‑1]. This field is
optional - its existence or absence is inferred from the Packet length.

The Client Identifier identifies the Client to the Server. Each Client
connecting to the Server has a unique Client Identifier.
«#box()<MQTT-SN-3.1.18-2>The Client Identifier MUST be used by Clients
and by Server to identify the state that they hold relating to this
MQTT-SN Session between the Client and the
Server»#link(<tab-MQTT-SN-3.1.18-2>)[MQTT‑SN‑3.1.18‑2].

#quote(block: true)[
#strong[Informative comment]

A Client Identifier can be between 0 - 65,521 bytes. It is recommended
for practicality, Client Identifiers are restricted to a reasonable size
(less than 243 bytes to fit within a small CONNECT packet).
]

«#box()<MQTT-SN-3.1.18-3>When the Client Identifier is present (greater
than 0 bytes), the Server MUST allow values which are between 1 and 23
UTF-8 encoded bytes in length, and that contain only the characters
\"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ”»#link(<tab-MQTT-SN-3.1.18-3>)[MQTT‑SN‑3.1.18‑3].

«#box()<MQTT-SN-3.1.18-4>The Server MAY choose to allow more than 23
bytes»#link(<tab-MQTT-SN-3.1.18-4>)[MQTT‑SN‑3.1.18‑4].

#quote(block: true)[
#strong[Informative comment]

The minimum supported length of between 1 and 23 bytes for the Client
Identifier in the Server is for compatibility with MQTT. A longer length
might be necessary to be supported if a UUID is used as an Assigned
Client Identifier as suggested in
#link(<assigned-client-identifier>)[3.2.11 "Assigned Client Identifier"].
]

=== CONNECT Actions
<connect-actions>
Note that a Server MAY support multiple protocols on the same network
endpoint. If the Server determines that the protocol is MQTT-SN 2.0 then
it validates the connection attempt as follows.

+ «#box()<MQTT-SN-3.1.19-1>The Server MUST validate that the CONNECT
  packet matches the format described in
  #link(<connect---connection-request>)[3.1 "CONNECT - Connection Request"]
  and MUST NOT create a Virtual Connection for this CONNECT if it does
  not match»#link(<tab-MQTT-SN-3.1.19-1>)[MQTT‑SN‑3.1.19‑1]. The Server
  MAY send a CONNACK with a Reason Code of 0x80 or greater as described
  in #link(<handling-errors>)[4.12 "Handling errors"].

+ «#box()<MQTT-SN-3.1.19-2>The Server MAY check that the contents of the
  CONNECT packet meet any further restrictions and SHOULD perform
  authentication and authorization checks. If any of these checks fail,
  it MUST NOT create a Virtual Connection for this
  CONNECT»#link(<tab-MQTT-SN-3.1.19-2>)[MQTT‑SN‑3.1.19‑2]. It MAY send
  an appropriate CONNACK response with a Reason Code of 0x80 or greater
  as described in
  #link(<connack---connect-acknowledgement>)[3.2 "CONNACK - Connect Acknowledgement"]
  and #link(<handling-errors>)[4.12 "Handling errors"].

If validation is successful, the Server performs the following steps.

+ «#box()<MQTT-SN-3.1.19-3>If the Client Identifier represents a Client
  already connected to the Server, the Server sends a DISCONNECT packet
  to the existing Client with Reason Code of 0x8E (Session taken over)
  as described in #link(<handling-errors>)[4.12 "Handling errors"] and
  MUST delete the Virtual Connection of the existing
  Client»#link(<tab-MQTT-SN-3.1.19-3>)[MQTT‑SN‑3.1.19‑3]. If the
  existing Client has a Will Message, that Will Message is published as
  described in #link(<will-flag>)[3.1.2.2 "Will Flag"].

+ «#box()<MQTT-SN-3.1.19-4>The Server MUST perform the processing of
  Clean Start that is described in
  #link(<clean-start-flag>)[3.1.2.1 "Clean Start Flag"]»#link(<tab-MQTT-SN-3.1.19-4>)[MQTT‑SN‑3.1.19‑4].

+ «#box()<MQTT-SN-3.1.19-5>The Server MUST acknowledge the CONNECT
  packet with a CONNACK packet containing a 0x00 (Success) Reason
  Code»#link(<tab-MQTT-SN-3.1.19-5>)[MQTT‑SN‑3.1.19‑5].

+ Start Application Message delivery and Keep Alive monitoring.

#quote(block: true)[
#strong[Informative comment]

It is recommended that authentication and authorization checks be
performed if the Server is being used to process any form of business
critical data. If these checks succeed, the Server responds by sending
CONNACK with a 0x00 (Success) Reason Code. If they fail, it is suggested
that the Server does not send a CONNACK at all, as this could alert a
potential attacker to the presence of the MQTT-SN Server and encourage
such an attacker to launch a denial of service or password-guessing
attack.
]

«#box()<MQTT-SN-3.1.19-6>A Client MUST wait for a CONNACK packet with a
0x00 (Success) Reason Code before sending any packet that needs a
Virtual Connection, AUTH
excepted»#link(<tab-MQTT-SN-3.1.19-6>)[MQTT‑SN‑3.1.19‑6].

The Packets that required a Virtual Connection are listed in
#link(<virtual-connections>)[4.2.1 "Virtual Connections"].

«#box()<MQTT-SN-3.1.19-7>The Server MUST interpret any Packet received
from the Client (other than AUTH) that requires a Virtual Connection,
after the CONNECT packet is received and before the CONNACK response is
sent, as a Protocol
Error»#link(<tab-MQTT-SN-3.1.19-7>)[MQTT‑SN‑3.1.19‑7].

== CONNACK - Connect Acknowledgement
<connack---connect-acknowledgement>
#figure(image("images/connack-packet-diagram.png", alt: "CONNACK Packet"),
  caption: [
    CONNACK Packet
  ]
)
<fig-connack-packet>

The CONNACK packet is sent by the Server in response to a CONNECT
request from a client.

=== CONNACK Header
<connack-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== CONNACK Flags
<connack-flags>
The CONNACK Flags is a 1 byte field which contains flags specifying the
behavior of the MQTT-SN Virtual Connection on the Server.
«#box()<MQTT-SN-3.2.2-1>Bits 7-4 of the CONNACK Flags are reserved and
MUST be set to 0»#link(<tab-MQTT-SN-3.2.2-1>)[MQTT‑SN‑3.2.2‑1].

«#box()<MQTT-SN-3.2.2-2>The Client MUST validate that the reserved flags
in the CONNACK packet are set to 0. If any of the reserved flags is not
0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.2.2-2>)[MQTT‑SN‑3.2.2‑2].

==== Session Present
<session-present>
#strong[Position]: bit 0 of the CONNACK Flags. Labelled #emph[Sess Pres]
in #link(<fig-connack-packet>)[Figure 8].

Specifies whether an existing session was present on the Server for the
given client identifier. A value of 1 indicates a session was present, a
value 0 indicates no session was present.

«#box()<MQTT-SN-3.2.2.1-1>If the Server accepts a CONNECT with Clean
Start set to 1, the Server MUST set Session Present to 0 in the CONNACK
Packet in addition to setting a 0x00 (Success) Reason Code in the
CONNACK packet»#link(<tab-MQTT-SN-3.2.2.1-1>)[MQTT‑SN‑3.2.2.1‑1].

«#box()<MQTT-SN-3.2.2.1-2>If the Server accepts a CONNECT with Clean
Start set to 0 and the Server has Session State for the client
identifier it MUST set Session Present to 1 in the CONNACK packet,
otherwise it MUST set Session Present to 0 in the CONNACK packet. In
both cases it MUST set a 0x00 (Success) Reason Code in the CONNACK
packet»#link(<tab-MQTT-SN-3.2.2.1-2>)[MQTT‑SN‑3.2.2.1‑2].

If the value of Session Present received by the Client from the Server
is not as expected, the Client proceeds as follows:

«#box()<MQTT-SN-3.2.2.1-3>If the Client does not have Session State and
receives Session Present set to 1 it MUST delete the Virtual Connection.
If it wishes to restart with a new Session the Client can reconnect
using Clean Start set to
1»#link(<tab-MQTT-SN-3.2.2.1-3>)[MQTT‑SN‑3.2.2.1‑3].

«#box()<MQTT-SN-3.2.2.1-4>If the Client does have Session State and
receives Session Present set to 0 it MUST discard its Session State if
it continues with the Virtual
Connection»#link(<tab-MQTT-SN-3.2.2.1-4>)[MQTT‑SN‑3.2.2.1‑4].

«#box()<MQTT-SN-3.2.2.1-5>If a Server sends a CONNACK packet containing
a non-zero Reason Code it MUST set Session Present to
0»#link(<tab-MQTT-SN-3.2.2.1-5>)[MQTT‑SN‑3.2.2.1‑5].

==== Session Expiry Interval Flag
<session-expiry-interval-flag>
#strong[Position]: bit 1 of the CONNACK Flags. Labelled #emph[Sess Exp]
in #link(<fig-connack-packet>)[Figure 8].

​​«#box()<MQTT-SN-3.2.2.2-1>If the Session Expiry Interval Flag is set to
0, a Session Expiry Interval MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.2-1>)[MQTT‑SN‑3.2.2.2‑1].

«#box()<MQTT-SN-3.2.2.2-2>If the Session Expiry Interval Flag is set to
1, a Session Expiry Interval MUST be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.2-2>)[MQTT‑SN‑3.2.2.2‑2].

==== Server Keep Alive Flag
<server-keep-alive-flag>
#strong[Position]: bit 2 of the CONNACK Flags. Labelled #emph[Server KA]
in #link(<fig-connack-packet>)[Figure 8].

Indicates whether the packet includes a Server Keep Alive or not.

​​«#box()<MQTT-SN-3.2.2.3-1>If the Server Keep Alive Flag is set to 0, a
Server Keep Alive field MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.3-1>)[MQTT‑SN‑3.2.2.3‑1].

«#box()<MQTT-SN-3.2.2.3-2>If the Server Keep Alive Flag is set to 1, a
Server Keep Alive field MUST be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.3-2>)[MQTT‑SN‑3.2.2.3‑2].

==== Authentication Flag
<cca---authentication-flag>
#strong[Position]: bit 3 of the CONNACK Flags. Labelled #emph[Auth] in
#link(<fig-connack-packet>)[Figure 8].

Specifies whether the packet contains authentication material to be
considered.

«#box()<MQTT-SN-3.2.2.4-1>If the Authentication Flag is set to 0,
Authentication Method and Data MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.4-1>)[MQTT‑SN‑3.2.2.4‑1].

«#box()<MQTT-SN-3.2.2.4-2>If the Authentication Flag is set to 1,
Authentication Method and Data MUST be present in the
Packet»#link(<tab-MQTT-SN-3.2.2.4-2>)[MQTT-SN-3.2.2.4-2].

=== Packet Identifier
<cca---packet-identifier>
The same value as the Packet Identifier in the CONNECT or AUTH Packet
being acknowledged.

=== Reason Code
<cca---reason-code>
The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.2.4-1>The
Server sending the CONNACK Packet MUST use one of the Reason Codes
applicable to CONNACK»#link(<tab-MQTT-SN-3.2.4-1>)[MQTT‑SN‑3.2.4‑1].

«#box()<MQTT-SN-3.2.4-2>If a Server sends a CONNACK packet containing a
Reason code of 0x80 or greater it MUST then delete the Virtual
Connection»#link(<tab-MQTT-SN-3.2.4-2>)[MQTT‑SN‑3.2.4‑2].

#quote(block: true)[
#strong[Informative comment]

Reason Code 0x80 (Unspecified error) may be used where the Server knows
the reason for the failure but does not wish to reveal it to the Client,
or when none of the other Reason Code values applies.
]

=== Session Expiry Interval
<cca---session-expiry-interval>
If the Session Expiry Interval is absent the value of Session Expiry
Interval in the CONNECT Packet is used. The Server uses this field to
inform the Client that it is using a value other than that sent by the
Client in the CONNECT.

Refer to
#link(<session-expiry-interval>)[3.1.9 "Session Expiry Interval"] for a
description of the use of Session Expiry Interval.

=== Server Keep Alive
<server-keep-alive>
The Server uses this field to inform the Client that it is using a value
other than that sent by the Client in the CONNECT.

«#box()<MQTT-SN-3.2.6-1>If the Server sends a Server Keep Alive on the
CONNACK packet, the Client MUST use this value instead of the Keep Alive
value the Client sent on
CONNECT»#link(<tab-MQTT-SN-3.2.6-1>)[MQTT‑SN‑3.2.6‑1].

«#box()<MQTT-SN-3.2.6-2>If the Server does not send the Server Keep
Alive, the Server MUST use the Keep Alive value set by the Client on
CONNECT»#link(<tab-MQTT-SN-3.2.6-2>)[MQTT‑SN‑3.2.6‑2].

Refer to #link(<keep-alive>)[3.1.6 "Keep Alive"] for a description of
the use of Keep Alive Interval.

#quote(block: true)[
#strong[Informative comment]

The primary use of the Server Keep Alive is for the Server to inform the
Client that it will disconnect the Client for inactivity sooner than the
Keep Alive specified by the Client.
]

=== Authentication Method Length
<cca---authentication-method-length>
Single byte value (max 0-255 bytes), representing the length of field
used to specify the authentication method. Refer to
#link(<authentication>)[4.11 "Authentication"] for more information
about authentication.

=== Authentication Method
<cca---authentication-method>
A UTF-8 Encoded String containing the name of the authentication method.
Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

=== Authentication Data Length
<cca---authentication-data-length>
Two byte value (max 0-65535 bytes), representing the length of field
used to specify the authentication data. Refer to
#link(<authentication>)[4.11 "Authentication"] for more information
about authentication.

=== Authentication Data
<cca---authentication-data>
Binary Data containing authentication data. The contents of this data
are defined by the authentication method and the state of already
exchanged authentication data. Refer to
#link(<authentication>)[4.11 "Authentication"] for more information
about authentication.

=== Assigned Client Identifier
<assigned-client-identifier>
«#box()<MQTT-SN-3.2.11-1>The Assigned Client Identifier MUST be a UTF-8
Encoded String»#link(<tab-MQTT-SN-3.2.11-1>)[MQTT‑SN‑3.2.11‑1]. This
field is optional - its existence or absence is inferred from the Packet
length.

The Assigned Client Identifier is the Client Identifier assigned by the
Server when the associated CONNECT packet contained no Client
Identifier. «#box()<MQTT-SN-3.2.11-2>If the Client connects using a zero
length Client Identifier, the Server MUST respond with a CONNACK
containing an Assigned Client
Identifier»#link(<tab-MQTT-SN-3.2.11-2>)[MQTT‑SN‑3.2.11‑2].

«#box()<MQTT-SN-3.2.11-3>The Assigned Client Identifier MUST be a new
Client Identifier not used by any other Session currently in the
Server»#link(<tab-MQTT-SN-3.2.11-3>)[MQTT‑SN‑3.2.11‑3].

It is suggested that the 36 character Universally Unique IDentifier
(UUID) format described in RFC9562 is used for MQTT-SN Assigned Client
Identifiers. In any case they should be no longer than 36 characters.

\(RFC9562 describes UUIDs that are 128 bits in size, 16 bytes or 32
hexadecimal digits. These UUIDs are commonly expressed in 36 characters,
including 4 dashes as separators such as the following:
#emph[f81d4fae-7dec-11d0-a765-00a0c91e6bf6]\.)

#quote(block: true)[
#strong[Informative comment]

The length of Assigned Client Identifiers should take into account the
maximum packet size allowed by the MQTT-SN implementation.

#strong[Informative comment]

Where a Transparent Gateway receives an Assigned Client Identifier from
an MQTT Server which is deemed too long for a device, it should map
shorter Gateway generated Client Identifiers with their versions
returned from the MQTT Server.
]

== AUTH - Authentication Exchange
<auth---authentication-exchange>
#figure(image("images/auth-packet-diagram.png", alt: "AUTH Packet"),
  caption: [
    AUTH Packet
  ]
)
<fig-auth-packet>

The authentication method and data is first sent by the Client as part
of a CONNECT exchange. If the Server requires additional information to
complete the authentication, it responds with an AUTH packet to signal
that the Client generates and sends another AUTH packet with the
required information and so on until the authentication is complete. The
server then responds with a CONNACK message.

=== AUTH Header
<auth-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Packet Identifier
<aae---packet-identifier>
Used to identify the corresponding CONNECT or AUTH packet. It should
ideally be populated with a random Two Byte Integer value when sent from
Client to Server. «#box()<MQTT-SN-3.3.2-1>When sent from Server to
Client, it MUST contain the packet identifier of the CONNECT or AUTH
packet being responded to»#link(<tab-MQTT-SN-3.3.2-1>)[MQTT‑SN‑3.3.2‑1].

=== Reason Code
<aae---reason-code>
The values for the Authentication Reason Code field are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.3.3-1>The
sender of the AUTH Packet MUST use one of the Reason Codes shown as
applicable to the AUTH
packet»#link(<tab-MQTT-SN-3.3.3-1>)[MQTT‑SN‑3.3.3‑1].

=== Authentication Method Length
<aae---authentication-method-length>
The length of the Authentication Method string.

=== Authentication Method
<aae-authentication-method>
A UTF-8 Encoded String containing the name of the authentication method.

=== Authentication Data
<aae---authentication-data>
Binary Data containing authentication data. The contents of this data
are defined by the authentication method.

=== AUTH Actions
<auth-actions>
Refer to #link(<authentication>)[4.11 "Authentication"] for more
information about authentication.

== REGISTER - Register Topic Alias Request
<register---register-topic-alias-request>
#figure(image("images/register-packet-diagram.png", alt: "REGISTER Packet"),
  caption: [
    REGISTER Packet
  ]
)
<fig-register-packet>

A REGISTER packet is sent by a Client or Server to create a Session
Topic Alias, before sending a PUBLISH with that Session Topic Alias.

The REGISTER packet is sent by a Client to a Server to request a Session
Topic Alias for the included Topic Name.

It is sent by a Server to inform a Client about the Session Topic Alias
it has assigned to the included Topic Name.

Topic Aliases are always assigned and managed by the Server, not the
Client. For more information see
#link(<topic-aliases>)[4.7.2 "Topic Aliases"].

A REGISTER packet may be sent by the Server when the Client is in the
Awake state if the Retain Topic Aliases flag on the SLEEPREQ was set to
0, to reinform the Client of a Session Topic Alias.

«#box()<MQTT-SN-3.4-1>If the REGISTER packet is sent by a Client, it
MUST NOT contain a Topic
Alias»#link(<tab-MQTT-SN-3.4-1>)[MQTT‑SN‑3.4‑1].

«#box()<MQTT-SN-3.4-2>If the REGISTER packet is sent by a Server, it
MUST contain a Topic Alias»#link(<tab-MQTT-SN-3.4-2>)[MQTT‑SN‑3.4‑2].

=== REGISTER Header
<register-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== REGISTER Flags
<register-flags>
The REGISTER Flags is a 1 byte field which contains flags specifying the
contents of the REGISTER packet. «#box()<MQTT-SN-3.4.2-1>Bits 7-1 of the
REGISTER Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.4.2-1>)[MQTT‑SN‑3.4.2‑1].

«#box()<MQTT-SN-3.4.2-2>The receiver MUST validate that the reserved
flags in the REGISTER packet are set to 0. If any of the reserved flags
is not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.4.2-2>)[MQTT‑SN‑3.4.2‑2].

==== Topic Alias Flag
<rrtar-topic-alias-flag>
#strong[Position]: bit 0 of the REGISTER Flags.

Determines the presence of the Topic Alias field.

«#box()<MQTT-SN-3.4.2.1-1>If the Topic Alias Flag is set to 0, a Topic
Alias MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.4.2.1-1>)[MQTT‑SN‑3.4.2.1‑1].

«#box()<MQTT-SN-3.4.2.1-2>If the Topic Alias Flag is set to 1, a Topic
Alias MUST be present in the
Packet»#link(<tab-MQTT-SN-3.4.2.1-2>)[MQTT‑SN‑3.4.2.1‑2].

=== Packet Identifier
<rrtar---packet-identifier>
Used to identify the corresponding REGACK packet. It should ideally be
populated with a random Two Byte Integer value.

=== Topic Alias
<rrtar---topic-alias>
Contains the Topic Alias value assigned to the Topic Name included in
the Topic Name field.

=== Topic Name
<rrtar---topic-name>
Fixed Length UTF-8 Encoded String Contains the fully qualified topic
name.

=== REGISTER Actions
<register-actions>
As described in #link(<topic-aliases>)[4.7.2 "Topic Aliases"].

== REGACK - Register Topic Alias Acknowledgement
<regack---register-topic-alias-acknowledgement>
#figure(image("images/regack-packet-diagram.png", alt: "REGACK Packet"),
  caption: [
    REGACK Packet
  ]
)
<fig-regack-packet>

The REGACK packet is sent by a Client or by a Server as an
acknowledgment to the receipt and processing of a REGISTER packet.

=== REGACK Header
<regack-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== REGACK Flags
<regack-flags>
The REGACK Flags is a 1 byte field which contains flags specifying the
contents of the REGACK packet. «#box()<MQTT-SN-3.5.2-1>Bits 7-3 of the
REGACK Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.5.2-1>)[MQTT‑SN‑3.5.2‑1].

«#box()<MQTT-SN-3.5.2-2>The receiver MUST validate that the reserved
flags in the REGACK packet are set to 0. If any of the reserved flags is
not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.5.2-2>)[MQTT‑SN‑3.5.2‑2].

==== Topic Type
<rrtaa---topic-type>
#strong[Position]: bits 0 and 1 of the REGACK Flags.

Determines the format of the topic value. Refer to
#link(<topic-types>)[2.4 "Topic Types"] for the definition of the
various topic types.

«#box()<MQTT-SN-3.5.2.1-1>The Topic Type in the REGACK packet MUST be
Predefined Topic Alias or Session Topic
Alias»#link(<tab-MQTT-SN-3.5.2.1-1>)[MQTT‑SN‑3.5.2.1‑1]. Any other value
is a Protocol Error.

#quote(block: true)[
#strong[Informative Comment]

A Predefined Topic Alias can be returned in the REGACK Packet if a
Client tries to register a Session Topic Alias for a Topic Name which
the Server already knows is a Predefined Topic Alias. See
#link(<session-topic-aliases>)[4.7.2.2 "Session Topic Aliases"] for
details.
]

==== Topic Alias Flag
<rrtaa---topic-alias-flag>
#strong[Position]: bit 2 of the REGACK Flags.

Determines the presence of the Topic Alias field.

«#box()<MQTT-SN-3.5.2.2-1>If the Topic Alias Flag is set to 0, a Topic
Alias MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.5.2.2-1>)[MQTT‑SN‑3.5.2.2‑1].

«#box()<MQTT-SN-3.5.2.2-2>If the Topic Alias Flag is set to 1, a Topic
Alias MUST be present in the
Packet»#link(<tab-MQTT-SN-3.5.2.2-2>)[MQTT‑SN‑3.5.2.2‑2].

=== Packet Identifier
<rrtaa---packet-identifier>
The same value as the Packet Identifier in the REGISTER packet being
acknowledged.

=== Topic Alias
<rrtaa---topic-alias>
A Topic Alias is a Two Byte Integer value that is used to identify the
Topic instead of the Topic Name. This numeric value is used as the Topic
Alias.

If the REGACK is sent by a Server in response to a REGISTER request from
a Client, the Topic Alias is that which has been assigned by the Server,
and which the Client should use during the rest of the Session to refer
to the Topic Name identified in the REGISTER packet.

If the REGACK is sent by a Client, it is in response to a REGISTER
packet from a Server informing the Client which Topic Alias it should
use. «#box()<MQTT-SN-3.5.4-1>When sent by a Client the REGACK MUST NOT
contain a Topic Alias»#link(<tab-MQTT-SN-3.5.4-1>)[MQTT‑SN‑3.5.4‑1].

=== Reason Code
<rrtaa---reason-code>
The Reason Code for the REGACK packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.5.5-1>The
sender of the REGACK Packet MUST use one of the Reason Codes applicable
to REGACK»#link(<tab-MQTT-SN-3.5.5-1>)[MQTT‑SN‑3.5.5‑1].

== Publish Requests and Responses
<publish-requests-and-responses>
Publish requests have two packet types covering three variants:

+ PUBWOS, Publish Without Session, where no session is required

+ PUBLISH Quality of Service 0 where no response is required and thus no
  packet identifier

+ PUBLISH Quality of Service 1 and 2 where a response is expected.

Variants 2 and 3 above are the same as in MQTT. The table below shows
the two packet types.

#figure(
  align(center)[#table(
    columns: (24.79%, 5.13%, 70.09%),
    align: (left,left,auto,),
    table.header([Packet Name], [Type], [Description],),
    table.hline(),
    [#strong[Publish]], [0x03], [A PUBLISH packet corresponding to
    Quality of Service (QoS) 0, 1 or 2],
    [#strong[Publish Without Session]], [0x12], [A PUBWOS Packet sent by
    a Client and does not need not to have an active Session],
  )]
  , caption: [Publish Packet Types]
  , kind: table
  )
<tab-publish-packet-types>

=== PUBWOS - Publish Without Session
<pubwos---publish-without-session>
#figure(image("images/pubwos-packet-diagram.png", alt: "PUBWOS Packet"),
  caption: [
    PUBWOS Packet
  ]
)
<fig-pubwos-packet>

This packet is used by both Clients and Servers to publish data for a
certain topic.

The PUBWOS packet has no corresponding feature in MQTT.
«#box()<MQTT-SN-3.6-1>If forwarded to an MQTT connection, PUBWOS packets
MUST have their MQTT Quality of Service level set to
0»#link(<tab-MQTT-SN-3.6-1>)[MQTT‑SN‑3.6‑1].

#quote(block: true)[
#strong[Informative comment]

PUBWOS packets received by a Server are not associated with a MQTT-SN
Client Session and can be optionally discarded by the Server without
being processed for onward delivery.

#strong[Informative comment]

If the Transport Layer supports multicast, like UDP/IP, the PUBWOS
packet can be sent using a multicast address as the destination.
]

==== PUBWOS Header
<pubwos-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== PUBWOS Flags
<pubwos-flags>
The PUBWOS Flags is a 1 byte field which contains flags specifying the
content of the packet and the Server behavior on receipt.
«#box()<MQTT-SN-3.6.1.2-1>Bits 7-5 and 3-2 of the PUBWOS FLAGS are
reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.6.1.2-1>)[MQTT‑SN‑3.6.1.2‑1].

«#box()<MQTT-SN-3.6.1.2-2>The receiver MUST validate that the reserved
flags in the PUBWOS packet are set to 0. If any of the reserved flags is
not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.6.1.2-2>)[MQTT‑SN‑3.6.1.2‑2].

===== Topic Type
<ppws---topic-type>
#strong[Position]: bits 0 and 1 of the PUBWOS Flags.

This determines the format of the topic data field. Refer to
#link(<topic-types>)[2.4 "Topic Types"] for the definition of the topic
types. «#box()<MQTT-SN-3.6.1.2.1-1>The Topic Type in the PUBWOS packet
MUST be Predefined Topic Alias or Topic
Name»#link(<tab-MQTT-SN-3.6.1.2.1-1>)[MQTT‑SN‑3.6.1.2.1‑1].

===== Retain
<ppws---retain>
#strong[Position]: bit 4 of the PUBWOS Flags.

This field signifies whether the existing Retained Message for this
topic is replaced or kept. For a detailed description of Retained
Messages see #link(<retained-messages>)[4.13 "Retained Messages"].

==== Topic Alias or Topic Name Length
<ppws--topic-alias-or-topic-name-length>
This field is 2 bytes. It contains the Topic Name length if the Topic
Type is Topic Name, or a predefined Topic Alias if the Topic Type is
Predefined Topic Alias. Determines the topic which this payload will be
published to.

==== Topic Name
<ppws---topic-name>
«#box()<MQTT-SN-3.6.1.4-1>If the Topic Type is Topic Name, the Topic
Name field MUST be present in the PUBWOS
packet»#link(<tab-MQTT-SN-3.6.1.4-1>)[MQTT‑SN‑3.6.1.4‑1].

«#box()<MQTT-SN-3.6.1.4-2>If the Topic Type is Predefined Topic Alias,
the Topic Name field MUST NOT be present in the PUBWOS
packet»#link(<tab-MQTT-SN-3.6.1.4-2>)[MQTT‑SN‑3.6.1.4‑2].

If the Topic Type is Topic Name this field will be a UTF-8 encoded
string value of length determined by the Topic Name Length field.

==== Payload
<ppws---payload>
The Payload contains the payload data of the Application Message that is
being published. This field consists of Binary Data. The content and
format of the data is application specific. It is valid for a PUBWOS
packet to contain a zero length Payload.

==== PUBWOS Actions
<pubwos-actions>
The Client or Server uses a PUBWOS packet to send an Application Message
to a Network Address, for possible receipt by a Server or another
Client.

«#box()<MQTT-SN-3.6.1.6-1>If received by a Client or Server, the PUBWOS
packet MUST be treated as if its QoS were
0»#link(<tab-MQTT-SN-3.6.1.6-1>)[MQTT‑SN‑3.6.1.6‑1] as described in
#link(<publish-actions>)[3.6.2.7 "PUBLISH Actions"].

=== PUBLISH - Publish Request
<publish---publish-request>
#figure(image("images/publish-packet-diagram.png", alt: "PUBLISH Packet"),
  caption: [
    PUBLISH Packet
  ]
)
<fig-publish-packet>

A PUBLISH packet is sent from a Client to a Server or from a Server to a
Client to transport an Application Message.

«#box()<MQTT-SN-3.6.2-1>PUBLISH packets received by a Client or Server
MUST be associated with a
Session»#link(<tab-MQTT-SN-3.6.2-1>)[MQTT‑SN‑3.6.2‑1].

==== PUBLISH Header
<publish-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== PUBLISH Flags
<publish-flags>
The PUBLISH Flags is a 1 byte field which contains flags specifying the
content of the packet and the Server behavior.
«#box()<MQTT-SN-3.6.2.2-1>Bits 3-2 of the PUBLISH Flags are reserved and
MUST be set to 0»#link(<tab-MQTT-SN-3.6.2.2-1>)[MQTT‑SN‑3.6.2.2‑1].

«#box()<MQTT-SN-3.6.2.2-2>The receiver MUST validate that the reserved
flags in the PUBLISH packet are set to 0. If any of the reserved flags
is not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.6.2.2-2>)[MQTT‑SN‑3.6.2.2‑2].

===== Topic Type
<pub---topic-type>
#strong[Position]: bits 0 and 1 of the PUBLISH Flags.

This determines the format of the Topic Data field. Refer to
#link(<topic-types>)[2.4 "Topic Types"] for the definition of Topic
Types.

«#box()<MQTT-SN-3.6.2.2.1-1>The Topic Type MUST be Topic Name,
Predefined Topic Alias or Session Topic
Alias»#link(<tab-MQTT-SN-3.6.2.2.1-1>)[MQTT‑SN‑3.6.2.2.1‑1].

===== QoS
<pub---qos>
#strong[Position]: bits 5 and 6 of the PUBLISH Flags.

Quality of Service - as in MQTT. The QoS levels are:

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,auto,),
    table.header([QoS value], [Bit 6], [bit 5], [Description],),
    table.hline(),
    [0], [0], [0], [At most once delivery],
    [1], [0], [1], [At least once delivery],
    [2], [1], [0], [Exactly once delivery],
    [-], [1], [1], [Reserved -- must not be used],
  )]
  , caption: [QoS Definitions]
  , kind: table
  )
<tab-qos-definitions>

For a detailed description of the various Quality Of Service levels
refer to
#link(<quality-of-service-levels-and-protocol-flows>)[4.3 "Quality of Service levels and protocol flows"].

===== DUP
<dup>
#strong[Position]: bit 7 of the PUBLISH Flags.

The DUP flag indicates the duplicate delivery of QoS 2 PUBLISH packets.
If the DUP flag is set to 0, it signifies that the packet is sent for
the first time. If the DUP flag is set to 1, it signifies that the
packet is retransmitted.

«#box()<MQTT-SN-3.6.2.2.3-1>If the QoS field is set to 0 or 1, the DUP
flag MUST be set to
\0.»#link(<tab-MQTT-SN-3.6.2.2.3-1>)[MQTT‑SN‑3.6.2.2.3‑1].

===== Retain
<pub---retain>
#strong[Position]: bit 4 of the PUBLISH Flags.

This flag signifies whether the message is published as a retained
message or not. See #link(<retained-messages>)[4.13 "Retained Messages"]
for more information about Retained Messages.

==== Packet Identifier
<pub---packet-identifier>
Used to identify the corresponding PUBACK packet in the case of QoS 1.
Used to identify the corresponding PUBREC, PUBREL and PUBCOMP packets in
the case of QoS 2. It should ideally be populated with a random Two Byte
Integer value.

«#box()<MQTT-SN-3.6.2.3-1>If the QoS field is set to 0, the Packet
Identifier field MUST not be present in the PUBLISH
packet.»#link(<tab-MQTT-SN-3.6.2.2.3-1>)[MQTT‑SN‑3.6.2.3‑1].

«#box()<MQTT-SN-3.6.2.3-2>If the QoS field is set to 1 or 2, the Packet
Identifier field MUST be present in the PUBLISH
packet.»#link(<tab-MQTT-SN-3.6.2.2.3-1>)[MQTT‑SN‑3.6.2.3‑2].

==== Topic Alias or Topic Name Length
<pub---topic-alias-or-topic-name-length>
Contains 2 bytes of Topic Name Length if the Topic Type is Topic Name,
or the Predefined or Session Topic Alias if the Topic Type is Predefined
Topic Alias or Session Topic Alias respectively.

==== Topic Name
<pub---topic-name>
«#box()<MQTT-SN-3.6.2.5-1>If the Topic Type is Topic Name (0b11), the
Topic Name field MUST be present in the PUBLISH
packet»#link(<tab-MQTT-SN-3.6.2.5-1>)[MQTT‑SN‑3.6.2.5‑1].

«#box()<MQTT-SN-3.6.2.5-2>If the Topic Type is Predefined Topic Alias or
Session Topic Alias, then the Topic Name field MUST NOT be present in
the PUBLISH packet»#link(<tab-MQTT-SN-3.6.2.5-2>)[MQTT‑SN‑3.6.2.5‑2].

Topic Name is a UTF-8 encoded string of length Topic Length.

==== Payload
<pub---payload>
The Payload contains the payload data of the Application Message that is
being published. This field consists of Binary Data. The content and
format of the data is application specific. It is valid for a PUBLISH
packet to contain a zero length Payload.

==== PUBLISH Actions
<publish-actions>
«#box()<MQTT-SN-3.6.2.7-1>The receiver of a PUBLISH packet MUST respond
with the packet as determined by the QoS in the PUBLISH
Packet.»#link(<tab-MQTT-SN-3.6.2.7-1>)[MQTT‑SN‑3.6.2.7‑1].

#figure(
  align(center)[#table(
    columns: 2,
    align: (left,left,),
    table.header([QoS Level], [Expected Response],),
    table.hline(),
    [QoS 0], [None],
    [QoS 1], [PUBACK packet],
    [QoS 2], [PUBREC packet],
  )]
  , caption: [Expected PUBLISH packet responses]
  , kind: table
  )
<tab-expected-publish-packet-responses>

The Client uses a PUBLISH packet to send an Application Message to the
Server, for distribution to Clients with matching subscriptions.

The Server uses a PUBLISH packet to send an Application Message to each
Client which has a matching subscription.

«#box()<MQTT-SN-3.6.2.7-2>When Clients make subscriptions with Topic
Filters that include wildcards, it is possible for a Client's
subscriptions to overlap so that a published Application Message might
match multiple filters. In this case the Server MUST deliver the
Application Message to the Client respecting the maximum QoS of all the
matching
subscriptions»#link(<tab-MQTT-SN-3.6.2.7-2>)[MQTT‑SN‑3.6.2.7‑2]. In
addition, the Server MAY deliver further copies of the Application
Message, one for each additional matching subscription and respecting
the subscription's QoS in each case.

The action of the recipient when it receives a PUBLISH packet depends on
the QoS level as described in
#link(<quality-of-service-levels-and-protocol-flows>)[4.3 "Quality of Service levels and protocol flows"].

#quote(block: true)[
#strong[Informative Comment]

If the Server distributes Application Messages to Clients to different
protocols and levels (such as MQTT V3.1.1) which do not support features
provided by this specification, some information in the Application
Message can be lost, and applications which depend on this information
might not work correctly.
]

No more than one QoS 1 or 2 PUBLISH requests MUST be outstanding for a
Sender at any one time. Other packets are included in this constraint -
refer to #link(<flow-control>)[4.9 "Flow Control"] for more information
about Flow Control.

#quote(block: true)[
#strong[Informative comment]

The Sender might choose to suspend the sending of QoS 0 PUBLISH packets
when it suspends the sending of QoS 1 and QoS 2 PUBLISH packets for Flow
Control reasons.
]

=== PUBACK -- Publish Acknowledgement (QoS 1 delivery)
<puback-publish-acknowledgement-qos-1-delivery>
#figure(image("images/puback-packet-diagram.png", alt: "PUBACK Packet"),
  caption: [
    PUBACK Packet
  ]
)
<fig-puback-packet>

A PUBACK packet is the response to a PUBLISH packet with QoS 1.

==== PUBACK Header
<puback-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Packet Identifier
<ppaq1d---packet-identifier>
The same value as the Packet Identifier in the PUBLISH Packet being
acknowledged.

==== Reason Code
<ppaq1d---reason-code>
The Reason Code for the PUBACK packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.6.3.3-1>The
sender of the PUBACK Packet MUST use one of the Reason Codes applicable
to PUBACK»#link(<tab-MQTT-SN-3.6.3.3-1>)[MQTT‑SN‑3.6.3.3‑1].

==== PUBACK Actions
<puback-actions>
As described in
#link(<qos-1-at-least-once-delivery>)[4.3.3 "QoS 1: At least once delivery"].

=== PUBREC - Publish Received (QoS 2 delivery part 1)
<pubrec-publish-received-qos-2-delivery-part-1>
#figure(image("images/pubrec-packet-diagram.png", alt: "PUBREC Packet"),
  caption: [
    PUBREC Packet
  ]
)
<fig-pubrec-packet>

A PUBREC packet is the response to a PUBLISH packet with QoS 2. It is
the second packet of the QoS 2 protocol exchange.

==== PUBREC Header
<pubrec-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Packet Identifier
<pprq2dp1---packet-identifier>
The same value as the Packet Identifier in the PUBLISH Packet being
acknowledged.

==== Reason Code
<pprq2dp1---reason-code>
The Reason Code for the PUBREC packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.6.4.3-1>The
sender of the PUBREC Packet MUST use one of the Reason Codes applicable
to PUBREC»#link(<tab-MQTT-SN-3.6.4.3-1>)[MQTT‑SN‑3.6.4.3‑1].

==== PUBREC Actions
<pubrec-actions>
As described in
#link(<qos-2-exactly-once-delivery>)[4.3.4 "QoS 2: Exactly once delivery"].

=== PUBREL - Publish Release (QoS 2 delivery part 2)
<pubrel---publish-release-qos-2-delivery-part-2>
#figure(image("images/pubrel-packet-diagram.png", alt: "PUBREL Packet"),
  caption: [
    PUBREL Packet
  ]
)
<fig-pubrel-packet>

A PUBREL packet is the response to a PUBREC packet. It is the third
packet of the QoS 2 protocol exchange.

==== PUBREL Header
<pubrel-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Packet Identifier
<pprq2dp2---packet-identifier>
The same value as the Packet Identifier in the PUBLISH Packet being
acknowledged.

==== Reason Code
<pprq2dp2---reason-code>
The Reason Code for the PUBREL packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.6.5.3-1>The
sender of the PUBREL Packet MUST use one of the Reason Codes applicable
to PUBREL»#link(<tab-MQTT-SN-3.6.5.3-1>)[MQTT‑SN‑3.6.5.3‑1].

==== PUBREL Actions
<pubrel-actions>
As described in
#link(<qos-2-exactly-once-delivery>)[4.3.4 "QoS 2: Exactly once delivery"].

=== PUBCOMP - Publish Complete (QoS 2 delivery part 3)
<pubcomp---publish-complete-qos-2-delivery-part-3>
#figure(image("images/pubcomp-packet-diagram.png", alt: "PUBCOMP Packet"),
  caption: [
    PUBCOMP Packet
  ]
)
<fig-pubcomp-packet>

The PUBCOMP packet is the response to a PUBREL packet. It is the fourth
and final packet of the QoS 2 protocol exchange.

==== PUBCOMP Header
<pubcomp-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Packet Identifier
<ppcq2dp3---packet-identifier>
The same value as the Packet Identifier in the PUBLISH Packet being
acknowledged.

==== Reason Code
<ppcq2dp3---reason-code>
The Reason Code for the PUBCOMP packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.6.6.3-1>The
sender of the PUBCOMP Packet MUST use one of the Reason Codes applicable
to PUBCOMP»#link(<tab-MQTT-SN-3.6.6.3-1>)[MQTT‑SN‑3.6.6.3‑1].

==== PUBCOMP Actions
<pubcomp-actions>
As described in
#link(<qos-2-exactly-once-delivery>)[4.3.4 "QoS 2: Exactly once delivery"].

== SUBSCRIBE - Subscribe Request
<subscribe---subscribe-request>
#figure(image("images/subscribe-packet-diagram.png", alt: "SUBSCRIBE Packet"),
  caption: [
    SUBSCRIBE Packet
  ]
)
<fig-subscribe-packet>

The SUBSCRIBE packet is sent from the Client to the Server to create one
or more Subscriptions. A Subscription registers a Client's interest in
one or more Topics. The Server sends PUBLISH packets to the Client to
forward Application Messages that were published to Topics that match
the Subscription. The SUBSCRIBE packet also specifies the maximum QoS
with which the Server can send Application Messages to the Client.

=== SUBSCRIBE Header
<subscribe-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== SUBSCRIBE Flags
<subscribe-flags>
The SUBSCRIBE Flags field is 1 byte and governs the behavior of
subscriptions.

==== Topic Type
<ssr---topic-type>
#strong[Position]: bits 0 and 1 of the SUBSCRIBE Flags.

This field determines the content of the Topic Alias and Topic Filter
fields. Refer to #link(<topic-types>)[2.4 "Topic Types"] for the
definition of the various topic types.

«#box()<MQTT-SN-3.7.2.1-1>The Topic Type MUST be Topic Filter,
Predefined Topic Alias or Session Topic
Alias»#link(<tab-MQTT-SN-3.7.2.1-1>)[MQTT‑SN‑3.7.2.1‑1].

==== Retain handling
<retain-handling>
#strong[Position]: bits 2 and 3 of the SUBSCRIBE Flags.

This option specifies whether retained messages are sent when the
subscription is established. This does not affect the sending of
retained messages at any point after the subscribe. If there are no
retained messages matching the Topic Filter, all these values act the
same. The values are:

#quote(block: true)[
0: Send retained messages at the time of the subscribe

1: Send retained messages at subscribe only if the subscription does not
currently exist

2: Do not send retained messages at the time of the subscribe
]

It is a Protocol Error to send a Retain Handling value of 3. See
#link(<retained-messages>)[4.13 "Retained Messages"] for more
information about the operation of the Retain Handling field.

==== Retain as Published
<retain-as-published>
#strong[Position]: bit 4 of the SUBSCRIBE Flags. Labelled #emph[RaP] in
#link(<fig-subscribe-packet>)[Figure 18].

If 1, Application Messages forwarded using this subscription keep the
RETAIN flag they were published with.

If 0, Application Messages forwarded using this subscription have the
RETAIN flag set to 0. Retained messages sent when the subscription is
established have the RETAIN flag set to 1.

See #link(<retained-messages>)[4.13 "Retained Messages"] for more
information about the operation of the Retain as Published flag.

==== QoS
<ssr---qos>
#strong[Position]: bits 5 and 6 of the SUBSCRIBE Flags.

The maximum QoS. This gives the maximum QoS level at which the Server
can send Application Messages to the Client. It is a Protocol Error if
the Maximum QoS field has the value 3.

==== No Local
<no-local>
#strong[Position]: bit 7 of the SUBSCRIBE Flags.

«#box()<MQTT-SN-3.7.2.5-1>if the value is 1, Application Messages MUST
NOT be forwarded to a Virtual Connection with a Client Identifier equal
to the Client Identifier of the publishing Virtual
Connection»#link(<tab-MQTT-SN-3.7.2.5-1>)[MQTT‑SN‑3.7.2.5‑1].

#quote(block: true)[
#strong[Informative Comment]

A Session is associated with a Client Identifier. A Virtual Connection
is a link between Network Identity and a Session by means of the Client
Identifier. So a Virtual Connection can be matched to a Client
Identifier.
]

=== Packet Identifier
<ssr---packet-identifier>
Used to identify the corresponding SUBACK packet. It should ideally be
populated with a random Two Byte Integer value.

=== Topic Alias
<ssr---topic-alias>
«#box()<MQTT-SN-3.7.4-1>If the Topic Type is Predefined Topic Alias or
Session Topic Alias, then the Topic Alias field MUST be present in the
SUBSCRIBE packet»#link(<tab-MQTT-SN-3.7.4-1>)[MQTT‑SN‑3.7.4‑1].

«#box()<MQTT-SN-3.7.4-2>If the Topic Type is Topic Filter the Topic
Alias field MUST NOT be present in the SUBSCRIBE
packet»#link(<tab-MQTT-SN-3.7.4-2>)[MQTT‑SN‑3.7.4‑2].

Contains Fixed Length UTF-8 Encoded String topic filter or Topic Alias
(Predefined or Session) as indicated in the #emph[Topic Type] field in
flags. Determines the topic names which this subscription is interested
in.

=== Topic Filter
<ssr---topic-filter>
«#box()<MQTT-SN-3.7.5-1>If the Topic Type is Topic Filter the Topic
Filter field MUST be present in the SUBSCRIBE
packet»#link(<tab-MQTT-SN-3.7.5-1>)[MQTT‑SN‑3.7.5‑1].

«#box()<MQTT-SN-3.7.5-2>If the Topic Type is Predefined Topic Alias or
Session Topic Alias, then the Topic Filter field MUST NOT be present in
the SUBSCRIBE packet»#link(<tab-MQTT-SN-3.7.5-2>)[MQTT‑SN‑3.7.5‑2].

The Topic Filter is a UTF-8 encoded string, which may contain wildcards.
A SUBSCRIBE packet with a zero length Topic Filter is a Protocol Error.
Refer to #link(<handling-errors>)[4.12 "Handling errors"] for
information about handling errors.

This existence or absence of this field is inferred from the Packet
length.

=== SUBSCRIBE Actions
<subscribe-actions>
«#box()<MQTT-SN-3.7.6-1>When the Server receives a SUBSCRIBE packet from
a Client, the Server MUST respond with a SUBACK
packet»#link(<tab-MQTT-SN-3.7.6-1>)[MQTT‑SN‑3.7.6‑1].

«#box()<MQTT-SN-3.7.6-2>The SUBACK packet MUST have the same Packet
Identifier as the SUBSCRIBE packet that it is
acknowledging»#link(<tab-MQTT-SN-3.7.6-2>)[MQTT‑SN‑3.7.6‑2].

«#box()<MQTT-SN-3.7.6-3>If a Server receives a SUBSCRIBE packet
containing a Topic Filter that is identical to a Subscription's Topic
Filter for the current Session, then it MUST replace that existing
Subscription with a new
Subscription»#link(<tab-MQTT-SN-3.7.6-3>)[MQTT‑SN‑3.7.6‑3]. The Topic
Filter in the new Subscription will be identical to that in the previous
Subscription, although its Subscription Options could be different.

«#box()<MQTT-SN-3.7.6-4>If the Retain Handling option is 0, any existing
retained messages matching the Topic Filter MUST be re-sent, but
Application Messages MUST NOT be lost due to replacing the
Subscription»#link(<tab-MQTT-SN-3.7.6-4>)[MQTT‑SN‑3.7.6‑4].

If a Server receives a Topic Filter that is not identical to any Topic
Filter for the current Session, a new Subscription is created. If the
Retain Handling option is not 2, all matching retained messages are sent
to the Client.

«#box()<MQTT-SN-3.7.6-5>The SUBACK packet sent by the Server to the
Client MUST contain a Reason
Code»#link(<tab-MQTT-SN-3.7.6-5>)[MQTT‑SN‑3.7.6‑5].

«#box()<MQTT-SN-3.7.6-6>This Reason Code MUST either show the maximum
QoS that was granted for that Subscription or indicate that the
subscription failed»#link(<tab-MQTT-SN-3.7.6-6>)[MQTT‑SN‑3.7.6‑6]. The
Server might grant a lower Maximum QoS than the subscriber requested.

«#box()<MQTT-SN-3.7.6-7>The QoS of Application Messages sent in response
to a Subscription MUST be the minimum of the QoS of the originally
published Application message and the Maximum QoS granted by the
Server»#link(<tab-MQTT-SN-3.7.6-7>)[MQTT‑SN‑3.7.6‑7]. The server is
permitted to send duplicate copies of an Application message to a
subscriber in the case where the original Application message was
published with QoS 1 and the maximum QoS granted was QoS 0.

#quote(block: true)[
#strong[Informative comment]

If a subscribing Client has been granted maximum QoS 1 for a particular
Topic Filter, then a QoS 0 Application Message matching the filter is
delivered to the Client at QoS 0. This means that at most one copy of
the Application Message is received by the Client. On the other hand, a
QoS 2 Application Message published to the same topic is downgraded by
the Server to QoS 1 for delivery to the Client, so that Client might
receive duplicate copies of the Application Message.

#strong[Informative comment]

If the subscribing Client has been granted maximum QoS 0, then an
Application Message originally published as QoS 2 might get lost on the
hop to the Client, but the Server should never send a duplicate of that
Application Message. A QoS 1 Application Message published to the same
topic might either get lost or duplicated on its transmission to that
Client.

#strong[Informative comment]

Subscribing to a Topic Filter at QoS 2 is equivalent to saying \"I would
like to receive Application Messages matching this filter at the QoS
with which they were published\". This means a publisher is responsible
for determining the maximum QoS an Application Message can be delivered
at, but a subscriber is able to require that the Server downgrades the
QoS to one more suitable for its usage.
]

== SUBACK - Subscribe Acknowledgement
<suback---subscribe-acknowledgement>
#figure(image("images/suback-packet-diagram.png", alt: "SUBACK Packet"),
  caption: [
    SUBACK Packet
  ]
)
<fig-suback-packet>

The SUBACK packet is sent by a Server to a client as an acknowledgment
to the receipt and processing of a SUBSCRIBE packet.

=== SUBACK Header
<suback-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== SUBACK Flags
<suback-flags>
The SUBACK Flags is a 1 byte field which contains flags specifying the
contents of the SUBACK packet. «#box()<MQTT-SN-3.8.2-1>Bits 7-3 of the
SUBACK Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.8.2-1>)[MQTT‑SN‑3.8.2‑1].

«#box()<MQTT-SN-3.8.2-2>The Client MUST validate that the reserved flags
in the SUBACK packet are set to 0. If any of the reserved flags is not 0
it is a Malformed Packet»#link(<tab-MQTT-SN-3.8.2-2>)[MQTT‑SN‑3.8.2‑2].

==== Topic Type
<ssa---topic-type>
#strong[Position]: bits 0 and 1 of the SUBACK Flags.

Determines the format of the topic value. Refer to
#link(<topic-types>)[2.4 "Topic Types"] for the definition of the
various topic types.

«#box()<MQTT-SN-3.8.2.1-1>The Topic Type in the SUBACK packet MUST be
either Predefined Topic Alias or Session Topic
Alias»#link(<tab-MQTT-SN-3.8.2.1-1>)[MQTT‑SN‑3.8.2.1‑1].

«#box()<MQTT-SN-3.8.2.1-2>If there is no Topic Alias returned the Topic
Type MUST be Predefined Topic
Alias»#link(<tab-MQTT-SN-3.8.2.1-2>)[MQTT‑SN‑3.8.2.1‑2].

==== Topic Alias Flag
<ssa--topic-alias-flag>
#strong[Position]: bit 2 of the SUBACK Flags.

«#box()<MQTT-SN-3.8.2.2-1>If the Topic Alias Flag is set to 0, a Topic
Alias MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.8.2.2-1>)[MQTT‑SN‑3.8.2.2‑1].

«#box()<MQTT-SN-3.8.2.2-2>If the Topic Alias Flag is set to 1, a Topic
Alias MUST be present in the
Packet»#link(<tab-MQTT-SN-3.8.2.2-2>)[MQTT‑SN‑3.8.2.2‑2].

=== Packet Identifier
<ssa---packet-identifier>
The same value as the Packet Identifier in the SUBSCRIBE Packet being
acknowledged.

=== Topic Alias
<ssa---topic-alias>
«#box()<MQTT-SN-3.8.4-1>If a Topic Alias is returned, it MUST be used
instead of the Topic Name by the Server when sending PUBLISH packets to
the client»#link(<tab-MQTT-SN-3.8.4-1>)[MQTT‑SN‑3.8.4‑1].

«#box()<MQTT-SN-3.8.4-2>If no Topic Alias is returned, the Topic Alias
Flag MUST be 0»#link(<tab-MQTT-SN-3.8.4-2>)[MQTT‑SN‑3.8.4‑2]. This will
be the case when subscribing to a Topic Filter containing wildcards, as
Topic Aliases can only be applied to Topic Names.

«#box()<MQTT-SN-3.8.4-3>If a Predefined Topic Alias was subscribed to, a
Topic Alias MUST NOT be present in the
SUBACK»#link(<tab-MQTT-SN-3.8.4-3>)[MQTT‑SN‑3.8.4‑3].

=== Reason Code
<ssa---reason-code>
The Reason Code for the SUBACK packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values of Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.8.5-1>The
sender of the SUBACK Packet MUST use one of the Reason Codes applicable
to SUBACK»#link(<tab-MQTT-SN-3.8.5-1>)[MQTT‑SN‑3.8.5‑1].

== UNSUBSCRIBE - Unsubscribe Request
<unsubscribe---unsubscribe-request>
#figure(image("images/unsubscribe-packet-diagram.png", alt: "UNSUBSCRIBE Packet"),
  caption: [
    UNSUBSCRIBE Packet
  ]
)
<fig-unsubscribe-packet>

An UNSUBSCRIBE packet is sent by the Client to the Server to remove
subscriptions to topics.

=== UNSUBSCRIBE Header
<unsubscribe-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== UNSUBSCRIBE Flags
<unsubscribe-flags>
The UNSUBSCRIBE Flags is a 1 byte field which contains flags specifying
the contents of the UNSUBSCRIBE packet. «#box()<MQTT-SN-3.9.2-1>Bits 7-2
of the UNSUBSCRIBE Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.9.2-1>)[MQTT‑SN‑3.9.2‑1].

«#box()<MQTT-SN-3.9.2-2>The Server MUST validate that the reserved flags
in the UNSUBSCRIBE packet are set to 0. If any of the reserved flags is
not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.9.2-2>)[MQTT‑SN‑3.9.2‑2].

==== Topic Type
<uur---topic-type>
#strong[Position]: bits 0 and 1 of the UNSUBSCRIBE Flags.

Determines the existence of the Topic Alias or Topic Filter. Refer to
#link(<topic-types>)[2.4 "Topic Types"] for the definition of the
various topic types.

=== Packet Identifier
<uur---packet-identifier>
Used to identify the corresponding UNSUBACK packet. It should ideally be
populated with a random Two Byte Integer value.

=== Topic Alias
<uur---topic-alias>
«#box()<MQTT-SN-3.9.4-1>A Topic Alias MUST be present in the UNSUBSCRIBE
packet if the Topic Type is Predefined or Session Topic
Alias»#link(<tab-MQTT-SN-3.9.4-1>)[MQTT‑SN‑3.9.4‑1].

«#box()<MQTT-SN-3.9.4-2>A Topic Alias MUST NOT be present in the
UNSUBSCRIBE packet if the Topic Type is Topic
Filter»#link(<tab-MQTT-SN-3.9.4-2>)[MQTT‑SN‑3.9.4‑2].

Predefined or Session Topic Alias as indicated by the #emph[Topic Type].
Determines the topic names which this subscription is interested in.

=== Topic Filter
<uur---topic-filter>
«#box()<MQTT-SN-3.9.5-1>A Topic Filter MUST be present in the
UNSUBSCRIBE packet if the Topic Type is Topic
Name»#link(<tab-MQTT-SN-3.9.5-1>)[MQTT‑SN‑3.9.5‑1].

«#box()<MQTT-SN-3.9.5-2>A Topic Filter MUST NOT be present in the
UNSUBSCRIBE packet if the Topic Type is Predefined or Session Topic
Alias»#link(<tab-MQTT-SN-3.9.5-2>)[MQTT‑SN‑3.9.5‑2].

The Topic Filter is an UTF-8 Encoded String. The existence or absence of
this field is inferred from the Packet length.

=== UNSUBSCRIBE Actions
<unsubscribe-actions>
«#box()<MQTT-SN-3.9.6-1>If a Topic Alias is used in an UNSUBSCRIBE
request, it MUST be translated to its equivalent Topic Name before any
other action takes place»#link(<tab-MQTT-SN-3.9.6-1>)[MQTT‑SN‑3.9.6‑1].

«#box()<MQTT-SN-3.9.6-2>The Topic Filter (whether it contains wildcards
or not) supplied in an UNSUBSCRIBE packet MUST be compared
character-by-character with the current set of Topic Filters held by the
Server for the Client. If any filter matches exactly then its owning
Subscription MUST be
deleted»#link(<tab-MQTT-SN-3.9.6-2>)[MQTT‑SN‑3.9.6‑2], otherwise no
additional processing occurs.

When a Server receives UNSUBSCRIBE :

- «#box()<MQTT-SN-3.9.6-3>It MUST stop adding any new Application
  Messages which match the Topic Filters, for delivery to the
  Client»#link(<tab-MQTT-SN-3.9.6-3>)[MQTT‑SN‑3.9.6‑3].

- «#box()<MQTT-SN-3.9.6-4>It MUST complete the delivery of any QoS 1 or
  QoS 2 Application Messages which match the Topic Filters and it has
  started to send to the
  Client»#link(<tab-MQTT-SN-3.9.6-4>)[MQTT‑SN‑3.9.6‑4].

- It MAY continue to deliver any existing Application Messages which
  match the Topic Filters buffered for delivery to the Client.

«#box()<MQTT-SN-3.9.6-5>The Server MUST respond to an UNSUBSCRIBE
request by sending an UNSUBACK
packet»#link(<tab-MQTT-SN-3.9.6-5>)[MQTT‑SN‑3.9.6‑5].

«#box()<MQTT-SN-3.9.6-6>The UNSUBACK packet MUST have the same Packet
Identifier as the UNSUBSCRIBE packet. Even where no Topic Subscriptions
are deleted, the Server MUST respond with an
UNSUBACK»#link(<tab-MQTT-SN-3.9.6-6>)[MQTT‑SN‑3.9.6‑6].

== UNSUBACK - Unsubscribe Acknowledgement
<unsuback---unsubscribe-acknowledgement>
#figure(image("images/unsuback-packet-diagram.png", alt: "UNSUBACK Packet"),
  caption: [
    UNSUBACK Packet
  ]
)
<fig-unsuback-packet>

An UNSUBACK packet is sent by a Server to acknowledge the receipt and
processing of an UNSUBSCRIBE packet.

=== UNSUBACK Header
<unsuback-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Packet Identifier
<uua---packet-identifier>
The same value as the Packet Identifier in the UNSUBSCRIBE packet being
acknowledged.

=== Reason Code
<uua---reason-code>
The Reason Code for the UNSUBACK packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The UNSUBACK Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.10.3-1>The
Server sending the UNSUBACK Packet MUST use one of the UNSUBACK Reason
Codes»#link(<tab-MQTT-SN-3.10.3-1>)[MQTT‑SN‑3.10.3‑1].

== PINGREQ - Ping Request
<pingreq---ping-request>
#figure(image("images/pingreq-packet-diagram.png", alt: "PINGREQ Packet"),
  caption: [
    PINGREQ Packet
  ]
)
<fig-pingreq-packet>

The PINGREQ packet is sent from a Client to the Server. It can be used
to:

- Indicate to the Server that the Client is alive in the absence of any
  other MQTT-SN Control Packets being sent from the Client to the
  Server. For more information refer to
  #link(<keep-alive>)[3.1.6 "Keep Alive"].

- Request that the Server responds to confirm that it is alive and that
  it has a Virtual Connection for the Client.

- Exercise the network to determine whether communications are working.

- Inform the Server that the Client has awoken from being Asleep and is
  now waiting for any queued up Application Messages at the Server to be
  sent to it. For more information refer to
  #link(<sleeping-clients>)[4.14.2 "Sleeping Clients"].

=== PINGREQ Header
<pingreq-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Packet Identifier
<ppreq---packet-identifier>
Used to identify the corresponding PINGRESP packet. It should ideally be
set to a random Two Byte Integer value.

=== PINGREQ Actions
<pingreq-actions>
«#box()<MQTT-SN-3.11.3-1>The Server MUST send a PINGRESP packet in
response to a PINGREQ packet after sending any buffered Application
Messages, if it has a Virtual Connection for the sending
Client»#link(<tab-MQTT-SN-3.11.3-1>)[MQTT‑SN‑3.11.3‑1].

«#box()<MQTT-SN-3.11.3-2>The Server MAY send a DISCONNECT packet in
response to a PINGREQ packet if it does not have a Virtual Connection
for the sending Client»#link(<tab-MQTT-SN-3.11.3-2>)[MQTT‑SN‑3.11.3‑2].

«#box()<MQTT-SN-3.11.3-3>If the Server sends a DISCONNECT packet in
response to a PINGREQ packet because it does not have a Virtual
Connection for the sending Client, it MUST use Reason Code 244 - No
Virtual Connection
Exists»#link(<tab-MQTT-SN-3.11.3-3>)[MQTT‑SN‑3.11.3‑3].

«#box()<MQTT-SN-3.11.3-4>If the state of the Client associated with the
Virtual Connection is Asleep on receipt of the PINGREQ, the Server MUST
move the Client to the Awake state, stop the Sleep Duration processing,
and start the Retry Timer
processing»#link(<tab-MQTT-SN-3.11.3-4>)[MQTT‑SN‑3.11.3‑4].

== PINGRESP - Ping Response
<pingresp---ping-response>
#figure(image("images/pingresp-packet-diagram.png", alt: "PINGRESP Packet"),
  caption: [
    PINGRESP Packet
  ]
)
<fig-pingresp-packet>

A PINGRESP Packet is sent by the Server to the Client in response to a
PINGREQ packet. It indicates that the Server is alive.

This Packet is used in Keep Alive processing. Refer to
#link(<keep-alive>)[3.1.6 "Keep Alive"] for more details.

A PINGRESP packet is also sent by the Server to inform a Client in the
Awake state that it has no more buffered packets for that Client. See
#link(<sleeping-clients>)[4.14.2 "Sleeping Clients"] for more
information about sleeping Clients.

=== PINGRESP Header
<pingresp-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Packet Identifier
<ppres-packet-identifier>
The same value as the Packet Identifier in the PINGREQ Packet being
acknowledged.

=== Application Messages Remaining
<application-messages-remaining>
The number of Application Messages still queued for delivery at the
Server when the PINGRESP is sent to send the Client back to sleep.

It is optional, intended as useful information for the Client - its
existence is inferred from the Packet length. This field can be present
in the Active state as well as the Awake state.

Values can be:

#figure(
  align(center)[#table(
    columns: (14.91%, 85.09%),
    align: (center,auto,),
    table.header([Allowed Values], [Description],),
    table.hline(),
    [0], [No Application Messages are waiting to be delivered],
    [1 -- 254 (incl.)], [The number of Application Messages waiting to
    be delivered],
    [255 (0xFF)], [An unspecified positive number of Application
    Messages waiting to be delivered greater than 0.],
  )]
  , caption: [PINGRESP continuation values]
  , kind: table
  )
<tab-pingresp-continuation-values>

== DISCONNECT - Disconnect Notification
<disconnect---disconnect-notification>
#figure(image("images/disconnect-packet-diagram.png", alt: "DISCONNECT Packet"),
  caption: [
    DISCONNECT Packet
  ]
)
<fig-disconnect-packet>

The DISCONNECT packet is sent by a Client to indicate that it is going
to delete the Virtual connection and go to the Disconnected state.

DISCONNECT may be sent by a Server to indicate that it cannot continue
with the Virtual Connection and is deleting it. For example, if the
Server is shutting down it could send DISCONNECT with Reason Code 0x8B -
Server shutting down.

A Client may receive an unsolicited DISCONNECT from a Server whether or
not it has a Virtual Connection to that Server. This may happen for
example when the Server, due to an error, cannot identify the Client to
which a received packet belongs.

If a Client or Server receives a packet which requires a Virtual
Connection (all packets except CONNECT, ADVERTISE, GWINFO, SEARCHGW and
PUBWOS), and no Virtual Connection exists, it MAY send a DISCONNECT in
response to the originator with Reason Code 0xF4 - No Virtual Connection
exists.

=== DISCONNECT Header
<disconnect-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== DISCONNECT Flags
<disconnect-flags>
The DISCONNECT Flags is a 1 byte field which contains flags specifying
the contents of the DISCONNECT packet. «#box()<MQTT-SN-3.13.2-1>Bits 7-3
of the DISCONNECT Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.13.2-1>)[MQTT‑SN‑3.13.2‑1].

«#box()<MQTT-SN-3.13.2-2>The receiver MUST validate that the reserved
flags in the DISCONNECT packet are set to 0. If any of the reserved
flags is not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.13.2-2>)[MQTT‑SN‑3.13.2‑2].

==== Packet Identifier Flag
<packet-identifier-flag>
#strong[Position:] bit 0 of the DISCONNECT Flags. Labelled
#emph[PacketId] in #link(<fig-disconnect-packet>)[Figure 24].

​​«#box()<MQTT-SN-3.13.2.1-1>If the Packet Identifier Flag is set to 0, a
Packet Identifier MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.1-1>)[MQTT‑SN‑3.13.2.1‑1].

«#box()<MQTT-SN-3.13.2.1-2>If the Packet Identifier Flag is set to 1, a
Packet Identifier MUST be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.1-2>)[MQTT‑SN‑3.13.2.1‑2].

==== Session Expiry Interval Flag
<ddn---session-expiry-interval-flag>
#strong[Position:] bit 1 of the DISCONNECT Flags. Labelled #emph[Sess
Exp] in #link(<fig-disconnect-packet>)[Figure 24].

​​«#box()<MQTT-SN-3.13.2.2-1>If the Session Expiry Interval Flag is set to
0, a Session Expiry Interval MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.2-1>)[MQTT‑SN‑3.13.2.2‑1].

«#box()<MQTT-SN-3.13.2.2-2>If the Session Expiry Interval Flag is set to
1, a Session Expiry Interval MUST be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.2-2>)[MQTT‑SN‑3.13.2.2‑2].

==== Reason Code Flag
<reason-code-flag>
#strong[Position:] bit 2 of the DISCONNECT Flags. Labelled #emph[Reason
C] in #link(<fig-disconnect-packet>)[Figure 24].

​​«#box()<MQTT-SN-3.13.2.3-1>If the Reason Code Flag is set to 0, a Reason
Code MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.3-1>)[MQTT‑SN‑3.13.2.3‑1].

«#box()<MQTT-SN-3.13.2.3-2>If the Reason Code Flag is set to 1, a Reason
Code MUST be present in the
Packet»#link(<tab-MQTT-SN-3.13.2.3-2>)[MQTT‑SN‑3.13.2.3‑2].

=== Packet Identifier
<ddn---packet-identifier>
This field is optional. It can be used by a Server when responding to a
Client packet for which there is no current Virtual Connection. In this
case, the DISCONNECT packet can be sent by the Server, setting the
Reason Code to 0xF4 (No Virtual Connection Exists) and including the
Packet Identifier of the erroneous packet, to help with problem
diagnosis.

=== Reason Code
<ddn---reason-code>
The Reason Code for the DISCONNECT packet is optional. If not provided,
0x00 (Normal disconnection) is assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.13.4-1>The
sender of the DISCONNECT packet MUST use one of the Reason Code values
applicable to
DISCONNECT»#link(<tab-MQTT-SN-3.13.4-1>)[MQTT‑SN‑3.13.4‑1].

=== Session Expiry Interval
<ddn---session-expiry-interval>
The Session Expiry Interval is a four-byte integer time interval
measured in seconds. If the Session Expiry Interval is absent, the
Session Expiry Interval in the CONNECT packet is used.

«#box()<MQTT-SN-3.13.5-1>The Session Expiry Interval MUST NOT be sent on
a DISCONNECT by the
Server»#link(<tab-MQTT-SN-3.13.5-1>)[MQTT-SN-3.13.5-1].

If the Session Expiry Interval in the CONNECT packet was zero, then it
is a Protocol Error to set a non-zero Session Expiry Interval in the
DISCONNECT packet sent by the Client. If such a non-zero Session Expiry
Interval is received by the Server, it does not treat it as a valid
DISCONNECT packet. The Server uses DISCONNECT with Reason Code 0x82
(Protocol Error) as described in
#link(<handling-errors>)[4.12 "Handling errors"].

=== Reason String
<reason-string>
Fixed Length UTF-8 Encoded String representing a clear text description
of the reason for the disconnection.

This field is optional - its existence or absence is inferred from the
Packet length.

=== DISCONNECT Actions
<disconnect-actions>
After sending a DISCONNECT packet the sender:

- «#box()<MQTT-SN-3.13.7-1>MUST NOT send any more MQTT-SN Control
  Packets on that Virtual
  Connection»#link(<tab-MQTT-SN-3.13.7-1>)[MQTT‑SN‑3.13.7‑1].

- «#box()<MQTT-SN-3.13.7-2>MUST delete the Virtual
  Connection»#link(<tab-MQTT-SN-3.13.7-2>)[MQTT‑SN‑3.13.7‑2].

On receipt of DISCONNECT with a Reason Code of 0x00 (Success) the
Server:

- «#box()<MQTT-SN-3.13.7-3>MUST discard any Will Message associated with
  the current Connection without publishing
  it»#link(<tab-MQTT-SN-3.13.7-3>)[MQTT‑SN‑3.13.7‑3], as described in
  #link(<will-flags>)[3.1.3 "Will Flags"].

On receipt of DISCONNECT, the receiver:

- «#box()<MQTT-SN-3.13.7-4>MUST NOT send any more MQTT-SN Control
  Packets on the Virtual Connection, if one
  exists»#link(<tab-MQTT-SN-3.13.7-4>)[MQTT‑SN‑3.13.7‑4].

- SHOULD delete any existing Virtual Connection.

After receiving a DISCONNECT, a Client can make a new Virtual Connection
by sending a CONNECT Packet to the Server.

== WAKEUP - Wake up request
<wakeup---wake-up-request>
#figure(image("images/wakeup-packet-diagram.png", alt: "WAKEUP Packet"),
  caption: [
    WAKEUP Packet
  ]
)
<fig-wakeup-packet>

The WAKEUP Packet is sent from the Server to the Client to request that
it transition to the Awake state. The client is not obliged to honor
this request - it might not even receive the packet. It can choose to
ignore the request, or undertake one of the sequences outlined in
#link(<sleeping-clients>)[4.14.2 "Sleeping Clients"]. The client need
not respond to this packet.

=== WAKEUP Header
<wakeup-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== WAKEUP Actions
<wakeup-actions>
«#box()<MQTT-SN-3.14.2-1>The Client MUST transition to the Awake state
or remain in the Asleep
state»#link(<tab-MQTT-SN-3.14.2-1>)[MQTT‑SN‑3.14.2‑1].

== SLEEPREQ - Sleep request
<sleepreq---sleep-request>
#figure(image("images/sleepreq-packet-diagram.png", alt: "SLEEPREQ Packet"),
  caption: [
    SLEEPREQ Packet
  ]
)
<fig-sleepreq-packet>

The SLEEPREQ packet is sent from the Client to the Server to indicate
that it is going to sleep (moving to the Asleep state).

=== SLEEPREQ Header
<sleepreq-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== SLEEPREQ Flags
<sleepreq-flags>
The SLEEPREQ Flags is a 1 byte field which contains flags specifying the
contents of the SLEEPREQ packet. «#box()<MQTT-SN-3.15.2-1>Bits 7-1 of
the SLEEPREQ Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.15.2-1>)[MQTT‑SN‑3.15.2‑1].

«#box()<MQTT-SN-3.15.2-2>The Server MUST validate that the reserved
flags in the SLEEPREQ packet are set to 0. If any of the reserved flags
is not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.15.2-2>)[MQTT‑SN‑3.15.2‑2].

==== Retain Topic Aliases
<retain-topic-aliases>
#strong[Position:] bit 0 of the SLEEPREQ Flags. Labelled #emph[Retain T]
in #link(<fig-sleepreq-packet>)[Figure 26].

Specifies whether Session Topic Aliases should be retained by the Server
during the Asleep state. "0" indicates Topic Aliases should be removed
during the sleeping period and renegotiated when Awake or Active. "1"
indicates Topic Aliases should be retained during the Asleep period, and
therefore not negotiated when Awake or Active.

«#box()<MQTT-SN-3.15.2.1-1>Predefined Topic aliases MUST NOT be removed
by the setting of the Retain Topic Aliases flag to
0»#link(<tab-MQTT-SN-3.15.2.1-1>)[MQTT‑SN‑3.15.2.1‑1].

=== Packet Identifier
<ssreq---packet-identifier>
Used to identify the corresponding SLEEPRESP packet. It should ideally
be set to a random Two Byte Integer value.

=== Sleep Duration
<sleep-duration>
The Sleep Duration is a four-byte integer time interval measured in
seconds. It is the maximum amount of time that a Client may stay asleep
without being disconnected by the Server. For more information on
sleeping Clients, and the purpose of Sleep Duration, see
#link(<sleeping-clients>)[4.14.2 "Sleeping Clients"].

«#box()<MQTT-SN-3.15.4-1>The Sleep Duration MUST be greater than
0»#link(<tab-MQTT-SN-3.15.4-1>)[MQTT‑SN‑3.15.4‑1].

#quote(block: true)[
#strong[Informative Comment]

The Sleep Duration should likely be substantially less than the Session
Expiry for the session. If anything goes wrong in the Asleep to Awake
transition, the Virtual Connection might be deleted by the Server, and
the Session data might also be deleted if the Session Expiry interval
passes before the Client reconnects.
]

=== SLEEPREQ Actions
<sleepreq-actions>
«#box()<MQTT-SN-3.15.5-1>A SLEEPREQ packet sent by a Server is a
Protocol Error»#link(<tab-MQTT-SN-3.15.5-1>)[MQTT‑SN‑3.15.5‑1].

«#box()<MQTT-SN-3.15.5-2>If there is a Virtual Connection for the
Client, the Server MUST send a SLEEPRESP packet in response to a
SLEEPREQ packet»#link(<tab-MQTT-SN-3.15.5-2>)[MQTT‑SN‑3.15.5‑2].

«#box()<MQTT-SN-3.15.5-3>If there is no Virtual Connection associated
with the SLEEPREQ, the Server MAY send a DISCONNECT with Reason Code
0xF4 (No Virtual Connection Exists) in
response»#link(<tab-MQTT-SN-3.15.5-3>)[MQTT‑SN‑3.15.5‑3].

«#box()<MQTT-SN-3.15.5-4>If the SLEEPREQ request is granted, the Server
MUST suspend Keep Alive processing for the Virtual
Connection»#link(<tab-MQTT-SN-3.15.5-4>)[MQTT‑SN‑3.15.5‑4].

«#box()<MQTT-SN-3.15.5-5>If the SLEEPREQ request is granted, the Server
MUST start Sleep Duration processing for the Virtual
Connection»#link(<tab-MQTT-SN-3.15.5-5>)[MQTT‑SN‑3.15.5‑5].

«#box()<MQTT-SN-3.15.5-6>If the SLEEPREQ request is successful, the
Virtual Connection MUST NOT be
deleted»#link(<tab-MQTT-SN-3.15.5-6>)[MQTT‑SN‑3.15.5‑6].

«#box()<MQTT-SN-3.15.5-7>If the Client is already in the Asleep state
when a SLEEPREQ is received by the Server, the Server MUST stop the
Sleep Duration Timer, and start a new sleep cycle using the updated
Sleep Duration»#link(<tab-MQTT-SN-3.15.5-7>)[MQTT‑SN‑3.15.5‑7].

After sending a SLEEPREQ packet the Client can wait for a SLEEPRESP
packet in response from the Server.

#quote(block: true)[
#strong[Informative Comment]

A Client will wait for a response if it wishes to ascertain that the
Server has received and processed its sleep request. By doing so it will
avoid the possibility of having to reestablish a Virtual Connection on
wakening if the Server did not receive the SLEEPREQ and the Virtual
Connection has been deleted by the Server because of a Keep Alive
timeout.

A Client might not wait, or might stop waiting, if it is concerned that
it will use excess power to determine that the Server has received the
SLEEPREQ.
]

== SLEEPRESP - Sleep response
<sleepresp---sleep-response>
#figure(image("images/sleepresp-packet-diagram.png", alt: "SLEEPRESP Packet"),
  caption: [
    SLEEPRESP Packet
  ]
)
<fig-sleepresp-packet>

The SLEEPRESP Packet is sent from the Server to the Client in response
to a SLEEPREQ from the Client.

=== SLEEPRESP Header
<sleepresp-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== SLEEPRESP Flags
<sleepresp-flags>
The SLEEPRESP Flags is a 1 byte field which contains flags specifying
the contents of the SLEEPRESP packet. «#box()<MQTT-SN-3.16.2-1>Bits 7-1
of the SLEEPRESP Flags are reserved and MUST be set to
0»#link(<tab-MQTT-SN-3.16.2-1>)[MQTT‑SN‑3.16.2‑1].

«#box()<MQTT-SN-3.16.2-2>The Client MUST validate that the reserved
flags in the SLEEPRESP packet are set to 0. If any of the reserved flags
is not 0 it is a Malformed
Packet»#link(<tab-MQTT-SN-3.16.2-2>)[MQTT‑SN‑3.16.2‑2].

==== Sleep Duration Flag
<sleep-duration-flag>
#strong[Position:] bit 0 of the SLEEPRESP Flags. Labelled #emph[Sleep
Dur] in #link(<fig-sleepresp-packet>)[Figure 27].

​​«#box()<MQTT-SN-3.16.2.1-1>If the Sleep Duration Flag is set to 0, Sleep
Duration MUST NOT be present in the
Packet»#link(<tab-MQTT-SN-3.16.2.1-1>)[MQTT‑SN‑3.16.2.1‑1].

​​«#box()<MQTT-SN-3.16.2.1-2>If the Sleep Duration Flag is set to 1, Sleep
Duration MUST be present in the
Packet»#link(<tab-MQTT-SN-3.16.2.1-2>)[MQTT‑SN‑3.16.2.1‑2].

«#box()<MQTT-SN-3.16.2.1-3>If the Allow Server Suggested Values Flag in
the CONNECT Packet that created the current Virtual Connection was 0,
the Server MUST set the Sleep Duration Flag in the SLEEPRESP Packet to
0»#link(<tab-MQTT-SN-3.16.2.1-3>)[MQTT‑SN‑3.16.2.1‑3].

=== Packet Identifier
<ssres---packet-identifier>
The same value as the Packet Identifier in the SLEEPREQ Packet being
acknowledged.

=== Sleep Duration
<ssres---sleep-duration>
The Server uses this field to inform the Client that it is using a value
other than that sent by the Client in the SLEEPREQ.

«#box()<MQTT-SN-3.16.4-1>If the Server sends a Sleep Duration on the
SLEEPRESP packet, the Client MUST use this value instead of the Sleep
Duration value the Client sent in the SLEEPREQ
packet»#link(<tab-MQTT-SN-3.16.4-1>)[MQTT‑SN‑3.16.4‑1].

«#box()<MQTT-SN-3.16.4-2>If the Server does not send the Sleep Duration,
the Server MUST use the Sleep Duration value set by the Client in the
SLEEPREQ packet»#link(<tab-MQTT-SN-3.16.4-2>)[MQTT‑SN‑3.16.4‑2].

Refer to #link(<sleeping-clients>)[4.14.2 "Sleeping Clients"] for more
information on Sleeping Clients.

=== Reason Code
<ssres---reason-code>
The Reason Code for the SLEEPRESP packet is optional - its existence is
inferred from the Packet length. If not provided, 0x00 (Success) is
assumed.

The values for Reason Codes are shown in
#link(<reason-code>)[2.3 "Reason Code"]. «#box()<MQTT-SN-3.16.5-1>The
sender of the SLEEPRESP packet MUST use one of the Reason Code values
applicable to SLEEPRESP»#link(<tab-MQTT-SN-3.16.5-1>)[MQTT‑SN‑3.16.5‑1].

== Protection Encapsulation
<protection-encapsulation>
#figure(image("images/protection-encapsulation-packet-diagram.png", alt: "Format of an Protection Encapsulated MQTT-SN Packet"),
  caption: [
    Format of an Protection Encapsulated MQTT-SN Packet
  ]
)
<fig-format-of-an-protection-encapsulated-mqtt-sn-packet>

Protection encapsulation provides a secure envelope for any MQTT-SN
packet (with the exception of the Forward Encapsulation packet). The
fields provided by the Protection Encapsulation provide a means by which
the sender is identified and the packet is protected, using a number of
prescribed protection schemes. Where the phrase "protected Packet" is
used in this document, it means an MQTT-SN Packet surrounded by the
Protection Encapsulation.

«#box()<MQTT-SN-3.17-1>The sender identified by Sender Identifier is the
originator of the protected MQTT-SN Packet and responsible for its
protection. This responsibility MUST NOT be delegated to a third party
like a Forwarder»#link(<tab-MQTT-SN-3.17-1>)[MQTT‑SN‑3.17‑1].

The sender identification is required as the sender and the receiver of
the protected packet must have access to the same shared key to be used
directly or after derivation. The Sender Identifier may not be related
to the Network Address of the sender. The authentication of the sender
and the receiver, their authorizations and the provisioning of the
shared keys used to protect integrity and optionally confidentiality of
the protected packet content are out of scope.

A protected packet, like any other one, can be the payload of a
Forwarder Encapsulated packet.

A Session that is created using a Protected CONNECT Packet is known as a
protected Session. A Session that is created using a CONNECT Packet
without Protection Encapsulation is known as an unprotected Session.

«#box()<MQTT-SN-3.17-2>All Packets in all Virtual Connections associated
with a protected Session MUST use the Protection
Encapsulation»#link(<tab-MQTT-SN-3.17-2>)[MQTT‑SN‑3.17‑2].

«#box()<MQTT-SN-3.17-3>A protected Packet that has the same Client
Identifier but a different Sender Identifier as an existing protected
Session MUST refer to a different
Session»#link(<tab-MQTT-SN-3.17-3>)[MQTT‑SN‑3.17‑3].

«#box()<MQTT-SN-3.17-4>A protected Packet that has the same Sender
Identifier but a different Client Identifier as an existing protected
Session MUST refer to a different
Session»#link(<tab-MQTT-SN-3.17-4>)[MQTT‑SN‑3.17‑4].

«#box()<MQTT-SN-3.17-5>An unprotected Packet that has the same Client
Identifier as an existing protected Session MUST refer to a different
Session»#link(<tab-MQTT-SN-3.17-5>)[MQTT‑SN‑3.17‑5].

#quote(block: true)[
#strong[Informative Comment]

A way to satisfy these constraints is to index the Session by Sender
Identifier and Client Identifier combined, instead of just Client
Identifier.

#strong[Informative Comment]

If the Client and Server cannot communicate using protected Packets and
the Client and Server are not in a private network, it is recommended
that the Server processes only MQTT-SN packets received over a secured
Network Connection (DTLS for example) initiated with mutual
authentication by the Client.

#strong[Informative Comment]

If the Client and Server cannot communicate using protected Packets and
the Client and Server are not in a private network, it is recommended
that the Client create a secured Network Connection (DTLS for example)
and process only MQTT-SN packets received over it.
]

=== Protection Encapsulation Header
<protection-encapsulation-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to section
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

=== Protection Flags
<protection-flags>
The Protection Flags is a one byte field specifying the properties of
the Protection Encapsulation.

==== Monotonic Counter Length
<monotonic-counter-length>
#strong[Position:] bits 0 and 1 of the Protection Flags. Labelled
#emph[Counter Length] in
#link(<fig-format-of-an-protection-encapsulated-mqtt-sn-packet>)[Figure 28].

Specifies the number of bytes forming the monotonic counter in
big-endian order. Only three of the four possible values are allowed.

- «#box()<MQTT-SN-3.17.2.1-1>The Monotonic Counter Length MUST NOT be
  set to 0x3 - the value is
  reserved»#link(<tab-MQTT-SN-3.17.2.1-1>)[MQTT‑SN‑3.17.2.1‑1].

- «#box()<MQTT-SN-3.17.2.1-2>If the Monotonic Counter Length is set to
  0x2, a Monotonic Counter of 32 bits (4 bytes) in length MUST be
  present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.1-2>)[MQTT‑SN‑3.17.2.1‑2].

- «#box()<MQTT-SN-3.17.2.1-3>If the Monotonic Counter Length is set to
  0x1, a Monotonic Counter of 16 bits (2 bytes) in length MUST be
  present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.1-3>)[MQTT‑SN‑3.17.2.1‑3].

- «#box()<MQTT-SN-3.17.2.1-4>If the Monotonic Counter Length is set to
  0x0, a Monotonic Counter MUST NOT be present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.1-4>)[MQTT‑SN‑3.17.2.1‑4].

==== Cryptographic Material Length
<cryptographic-material-length>
#strong[Position:] bits 2 and 3 of the Protection Flags. Labelled
#emph[Crypto Length] in
#link(<fig-format-of-an-protection-encapsulated-mqtt-sn-packet>)[Figure 28].

Specifies the number of sixteen bit groups forming the cryptographic
material in big-endian order. The meaning of each possible value is
defined as follows.

- «#box()<MQTT-SN-3.17.2.2-1>If the Cryptographic Material Length is set
  to 0x3, a Cryptographic Material field of 96 bits (12 bytes) in length
  MUST be present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.2-1>)[MQTT‑SN‑3.17.2.2‑1].

- «#box()<MQTT-SN-3.17.2.2-2>If the Cryptographic Material Length is set
  to 0x2, a Cryptographic Material field of 32 bits (4 bytes) in length
  MUST be present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.2-2>)[MQTT‑SN‑3.17.2.2‑2].

- «#box()<MQTT-SN-3.17.2.2-3>If the Cryptographic Material Length is set
  to 0x1, a Cryptographic Material field of 16 bits (2 bytes) in length
  MUST be present in the Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.2-3>)[MQTT‑SN‑3.17.2.2‑3].

- «#box()<MQTT-SN-3.17.2.2-4>If the Cryptographic Material Length is set
  to 0x0, a Cryptographic Material field MUST NOT be present in the
  Protection
  Encapsulation»#link(<tab-MQTT-SN-3.17.2.2-4>)[MQTT‑SN‑3.17.2.2‑4].

==== Authentication Tag Length
<authentication-tag-length>
#strong[Position:] bits 4 through 7 of the Protection Flags.

The Authentication Tag Length defines the size of the Authentication
Tag. Only fourteen of the sixteen possible values are allowed.

- If the Authentication Tag Length is set to 0x0, the length of the
  Authentication Tag is provider defined.

#quote(block: true)[
#strong[Informative Comment]

For instance a provider can decide that the length of the Authentication
Tag field is 40 bits whenever the Authentication Tag Length field is
0x0. This will work only for devices running code which implements the
same provider scheme as the Gateway.
]

- «#box()<MQTT-SN-3.17.2.3-1>If the Protection Scheme is not
  "Authentication Only" the Authentication Tag Length MUST be set to
  0x1»#link(<tab-MQTT-SN-3.17.2.3-1>)[MQTT‑SN‑3.17.2.3‑1].

- «#box()<MQTT-SN-3.17.2.3-2>If the Authentication Tag Length is set to
  0x1, the length of the Authentication Tag MUST be equal to the
  Protection Scheme nominal tag
  size»#link(<tab-MQTT-SN-3.17.2.3-2>)[MQTT‑SN‑3.17.2.3‑2].

- «#box()<MQTT-SN-3.17.2.3-3>The Authentication Tag Length MUST NOT be
  set to 0x2 or 0x3 - these values are
  reserved»#link(<tab-MQTT-SN-3.17.2.3-3>)[MQTT‑SN‑3.17.2.3‑3].

- «#box()<MQTT-SN-3.17.2.3-4>If the Authentication Tag Length is set to
  any value between 0x4 and 0xF inclusive, the Protection Scheme MUST be
  "Authentication
  Only"»#link(<tab-MQTT-SN-3.17.2.3-4>)[MQTT‑SN‑3.17.2.3‑4].

- «#box()<MQTT-SN-3.17.2.3-5>Authentication Tag Length values between
  0x4 and 0xF inclusive MUST only be used for the truncation of
  "Authentication Only" protection
  schemes»#link(<tab-MQTT-SN-3.17.2.3-5>)[MQTT‑SN‑3.17.2.3‑5].
  «#box()<MQTT-SN-3.17.2.3-6>In these cases the length of the
  Authentication Tag MUST be sixteen times the Authentication Tag
  Length»#link(<tab-MQTT-SN-3.17.2.3-6>)[MQTT‑SN‑3.17.2.3‑6]. For
  example:

  - if the value is 0xF, the length of the Authentication Tag will be
    (0xF)\*16=240 bits;

  - if the value is 0x4, the length of the Authentication Tag will be
    (0x4)\*16=64 bits.

«#box()<MQTT-SN-3.17.2.3-7>If truncation of the output of the
authentication algorithm is required, it MUST be taken in most
significant bits first order (leftmost
bits)»#link(<tab-MQTT-SN-3.17.2.3-7>)[MQTT‑SN‑3.17.2.3‑7].

«#box()<MQTT-SN-3.17.2.3-8>Authentication Tag Length values for some
Authentication Only protection schemes MUST NOT be used if they define a
tag size bigger than the nominal tag
size»#link(<tab-MQTT-SN-3.17.2.3-8>)[MQTT-SN-3.17.2.3-8]. For example,
values from 0x09 (144 bits) to 0x0F (240 bits) are not allowed for
"Authentication Only" protection schemes with a nominal tag size less
than 144 bits, such as CMAC-128, CMAC-192, CMAC-256.

=== Protection Scheme
<protection-scheme>
«#box()<MQTT-SN-3.17.3-1>The Protection Scheme is a one byte field which
MUST contain one of the indexes in table 10 which is not
reserved»#link(<tab-MQTT-SN-3.17.3-1>)[MQTT‑SN‑3.17.3‑1].

In general two types of protection scheme are considered:
#strong[Authentication only] (such as HMAC or CMAC) and #strong[AEAD]
(Authenticated Encryption with Associated Data, such as GCM, CCM or
ChaCha20/Poly1305).

«#box()<MQTT-SN-3.17.3-2>The thirteen byte nonce recommended for AES CCM
must be obtained by performing SHA256, truncated to the leftmost 104
bits, of the sequence Byte 1 to Byte 17+C+M (all packet fields up to the
Protected MQTT-SN
Packet)»#link(<tab-MQTT-SN-3.17.3-2>)[MQTT‑SN‑3.17.3‑2].

«#box()<MQTT-SN-3.17.3-3>The twelve byte initialization vector (IV)
recommended for AES GCM must be obtained by performing SHA256, truncated
to the leftmost 96 bits, of the sequence Byte 1 to Byte 17+C+M (all
packet fields up to the Protected MQTT-SN
Packet)»#link(<tab-MQTT-SN-3.17.3-3>)[MQTT‑SN‑3.17.3‑3].

«#box()<MQTT-SN-3.17.3-4>The twelve byte nonce recommended for
ChaCha20/Poly1305 must be obtained by performing SHA256 truncated to 96
bit of the sequence Byte 1 to Byte 17+C+M (all packet fields up to the
Protected MQTT-SN
Packet)»#link(<tab-MQTT-SN-3.17.3-4>)[MQTT‑SN‑3.17.3‑4].

#figure(
  align(center)[#table(
    columns: (10.89%, 30.69%, 20.79%, 19.8%, 17.82%),
    align: (left,left,center,left,left,),
    table.header([Index], [Name], [Authentication Only], [Key
      Size], [Nominal Tag Size],),
    table.hline(),
    [0x00], [HMAC-SHA256 (Note 1)], [Yes], [Any size (Note 2)], [256
    bits],
    [0x01], [HMAC-SHA3\_256 (Note 1)], [Yes], [Any size (Note 2)], [256
    bits],
    [0x02], [CMAC-128 (Note 3)], [Yes], [128 bits], [128 bits],
    [0x03], [CMAC-192 (Note 3)], [Yes], [192 bits], [128 bits],
    [0x04], [CMAC-256 (Note 3)], [Yes], [256 bits], [128 bits],
    [0x05-0x3B], [RESERVED], [], [], [],
    [0x3C-0x3F], [Provider defined], [Yes], [Provider
    defined], [Provider defined],
    [0x40], [AES-CCM-64-128 (Notes 4,5)], [No], [128 bits], [64 bits],
    [0x41], [AES-CCM-64-192 (Notes 4,5)], [No], [192 bits], [64 bits],
    [0x42], [AES-CCM-64-256 (Notes 4,5)], [No], [256 bits], [64 bits],
    [0x43], [AES-CCM-128-128 (Notes 4,5)], [No], [128 bits], [128 bits],
    [0x44], [AES-CCM-128-192 (Notes 4,5)], [No], [192 bits], [128 bits],
    [0x45], [AES-CCM-128-256 (Notes 4,5)], [No], [256 bits], [128 bits],
    [0x46], [AES-GCM-128-128 (Notes 6,7)], [No], [128 bits], [128 bits],
    [0x47], [AES-GCM-128-192 (Notes 6,7)], [No], [192 bits], [128 bits],
    [0x48], [AES-GCM-128-256 (Notes 6,7)], [No], [256 bits], [128 bits],
    [0x49], [ChaCha20/Poly1305 (Notes 8,9)], [No], [256 bits], [128
    bits],
    [0x4A-0xEF], [RESERVED], [], [], [],
    [0xF0-0xFF], [Provider defined], [No], [Provider defined], [Provider
    defined],
  )]
  , caption: [Protection Schemes]
  , kind: table
  )
<tab-protection-schemes>

#strong[Note(s):]

+ Reference #link("https://www.rfc-editor.org/rfc/rfc2104")

+ Reference
  #link("https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.198-1.pdf")

+ Reference #link("https://www.rfc-editor.org/rfc/rfc4493") and
  #link("https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-38b.pdf")
  and
  #link("https://csrc.nist.gov/CSRC/images/Projects/Cryptographic-Standards-and-Guidelines/documents/examples/AES_CMAC.pdf")

+ Reference #link("https://www.rfc-editor.org/rfc/rfc3610") and security
  considerations on
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.2.1")

+ AES CCM requires a 13 bytes nonce as indicated in
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.2")

+ Reference
  #link("https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf")
  and security considerations on
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.1.1")

+ AES GCM requires a 12 bytes IV as indicated in
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.1")

+ Reference #link("https://www.rfc-editor.org/rfc/rfc7539") and security
  considerations on
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.3.1")

+ ChaCha20/Poly1305 requires a 12 bytes nonce as indicated in
  #link("https://www.rfc-editor.org/rfc/rfc8152#section-10.3")

=== Sender Identifier
<sender-identifier>
«#box()<MQTT-SN-3.17.4-1>The eight byte Sender Identifier field MUST
contain a unique value per sender over 8 bytes (such as a MAC address,
or other identifying
characteristics)»#link(<tab-MQTT-SN-3.17.4-1>)[MQTT‑SN‑3.17.4‑1]. The
methods to guarantee the uniqueness of the Sender Identifier are out of
scope.

#quote(block: true)[
#strong[Informative comment]

In order to create a whitelist of authorized senders, the Client can
store a map of authorized Servers. The Sender Identifiers of the
authorized Servers can be obtained from pre-configuration, for example.

#strong[Informative comment]

In order to create a whitelist of authorized senders, the MQTT-SN Server
can store a map of authorized Clients. The Sender Identifiers of the
authorized Clients can be obtained from pre-configuration, for example.
]

=== Random
<random>
The four byte Random field should contain a random number which is not
guessable, generated at the time of Protection Encapsulation packet
creation.

#quote(block: true)[
#strong[Informative comment]

In the case of CCM, in the worst case scenario where the "Cryptographic
Material" and the "Monotonic Counter" optional fields are not present,
the recommended nonce on 13 bytes has to be calculated as SHA256
truncated to 104 bits of the sequence Byte 1 to Byte 16 (all packet
fields up to the Protected MQTT-SN Packet). So considering the same
Sender Identifier, the same nonce can be generated with a probability of
1/2^32=2.33x10#super[\-10]. With a shorter Random field of 2 bytes, the
same nonce would be calculated with a probability of only
1/2^16=1.53x10#super[\-5]. As CCM is a derivation of CTR (see
#link("https://en.wikipedia.org/wiki/CCM_mode")), the nonce should never
be reused for the same key so the probability of generating two
identical nonces should be kept as low as possible. The same applies to
GCM and ChaCha20/Poly1305, the security depends on choosing a unique IV
of 12 bytes for every encryption performed with the same key
(#link("https://en.wikipedia.org/wiki/Galois/Counter_Mode")).
]

=== Cryptographic Material
<cryptographic-material>
The optional Cryptographic Material field contains two, four or twelve
bytes of cryptographic material that when defined it can be used to
derive, from a shared master secret, the same keys on the two endpoints
and/or, when filled partially or totally with a random value, to provide
enough entropy to further reduce the probability of IV or nonce reuse
for CCM or GCM or ChaCha20/Poly1305. For instance, when the
Cryptographic Material Length is set to 0x03, the Cryptographic Material
field can be partially filled with a random value of nine bytes (the
remaining three bytes can be set to 0 if not used) in order to reach, in
conjunction with the four bytes of the Random field, the thirteen bytes
of entropy recommended for the determination of the nonce used by CCM or
it can be partially filled with a random value of eight bytes in order
to reach the twelve bytes of entropy recommended for the IV or nonce
used by GCM or ChaCha20/Poly1305.

=== Monotonic Counter
<monotonic-counter>
The optional Monotonic Counter field contains a two or four byte number
that when defined, is increased by the Client or Server for every packet
sent. «#box()<MQTT-SN-3.17.7-1>The counters must be considered
independent of session or
destination»#link(<tab-MQTT-SN-3.17.7-1>)[MQTT‑SN‑3.17.7‑1]. For
example, the Client will keep a counter independently from the Server.

=== Protected MQTT-SN Packet
<protected-mqtt-sn-packet>
The field Protected MQTT-SN Packet contains the MQTT-SN packet that is
being secured, encoded according to its packet type.

«#box()<MQTT-SN-3.17.8-1>The Protected MQTT-SN Packet MUST NOT be a
Forwarder Encapsulated
Packet»#link(<tab-MQTT-SN-3.17.8-1>)[MQTT-SN-3.17.8-1] as the shared key
used directly or after derivation for the protection must belong to the
originator of the content and not to a Forwarder that, in general, is
not able to securely identify the originator.

=== Authentication Tag
<authentication-tag>
The Authentication Tag field has a length that depends on the
Authentication Tag Length. Its content authenticates ALL the preceding
fields and is obtained on the basis of the protection scheme selected in
the Protection Scheme field.

== Connection Encapsulation
<connection-encapsulation>
#figure(image("images/connection-encapsulation-packet-diagram.png", alt: "Format of a Connection Encapsulated MQTT-SN Packet"),
  caption: [
    Format of a Connection Encapsulated MQTT-SN Packet
  ]
)
<fig-format-of-a-connection-encapsulated-mqtt-sn-packet>

This envelope wraps an MQTT-SN Packet to allow it to be associated with
an existing Virtual Connection where other methods are not sufficient.
Only Clients can use the Connection Encapsulation because it is assumed
that the Network Address for the Server is static for the duration of
the Virtual Connection. If the Server Network Address is not static,
then another method of identifying the Packet sender must be used, such
as the Protection Encapsulation or DTLS.

«#box()<MQTT-SN-3.18-1>If the Allow Network Address Changes flag in the
CONNECT for the Virtual Connection is 0, it is a protocol error to use
the Connection
Encapsulation»#link(<tab-MQTT-SN-3.18-1>)[MQTT‑SN‑3.18‑1].

«#box()<MQTT-SN-3.18-2>It is a protocol error to use the Connection
Encapsulation on Packets sent by a
Server»#link(<tab-MQTT-SN-3.18-2>)[MQTT-SN-3.18-2].

«#box()<MQTT-SN-3.18-3>It is a protocol error to use the Connection
Encapsulation on Packets other than PUBLISH, SUBSCRIBE, UNSUBSCRIBE,
REGISTER, DISCONNECT, SLEEPREQ and PINGREQ sent by a
Client»#link(<tab-MQTT-SN-3.18-3>)[MQTT-SN-3.18-3].

«#box()<MQTT-SN-3.18-4>The encapsulated MQTT-SN packet MUST be treated
by the receiver in exactly the same fashion as the same Packet
unencapsulated, once the associated Virtual Connection is
identified»#link(<tab-MQTT-SN-3.18-4>)[MQTT-SN-3.18-4].

#quote(block: true)[
#strong[Informative Comment]

If the Server receives a Connection Encapsulated Packet from a Network
Address corresponding to an existing Virtual Connection, but the
Connection Information does not match, this would normally be an error,
but it is up to the implementation to decide.

#strong[Informative Comment]

The Protection Encapsulation is a secure method of identifying the
Sender but requires the prior distribution of shared secrets. The
Connection Encapsulation is inherently insecure and should not be used
to bypass the security of the connection process -- other environmental
or network characteristics should be used in addition.
]

=== Connection Encapsulation Header
<connection-encapsulation-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

The Length field specifies the number of bytes in the whole packet,
including the encapsulated MQTT-SN Packet.

=== Client Identifier Length
<ce---client-identifier-length>
The two byte integer length of the Client Identifier field.

=== Client Identifier
<ce---client-identifier>
This is a variable length UTF-8 field that contains the Client
Identifier which was used to create the Virtual Connection.

=== MQTT-SN Packet
<mqtt-sn-packet>
The MQTT-SN packet, encoded according to the packet type, follows
immediately after the Client Identifier field.

== Forwarder Encapsulation
<forwarder-encapsulation>
#figure(image("images/forwarder-encapsulation-packet-diagram.png", alt: "Format of an Forwarder Encapsulated MQTT-SN Packet"),
  caption: [
    Format of an Forwarder Encapsulated MQTT-SN Packet
  ]
)
<fig-format-of-an-forwarder-encapsulated-mqtt-sn-packet>

An MQTT-SN Client can access a Server through a Forwarder in case the
Server is not directly attached to the same Underlying Network as the
Client. The Forwarder encapsulates the MQTT-SN Packets it receives from
the Client and sends them unchanged to the Server. In the opposite
direction, it decapsulates the Packets it receives from the Server and
sends them unchanged to the Clients.

The Forwarder Encapsulation contains the addressing information needed
by the Forwarder to allow MQTT-SN Packets reach their intended
destination(s). Refer to #link(<c.1.3-forwarder>)[C.1.3 "Forwarder"] for
examples.

=== Forwarder Encapsulation Header
<forwarder-encapsulation-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

The Length field specifies the number of bytes in the whole packet,
including the encapsulated MQTT-SN Packet.

=== Client Addressing Information Length
<client-addressing-information-length>
The one-byte length of the Client Addressing Information field.

=== Client Addressing Information
<client-addressing-information>
Identifies the MQTT-SN Client which has sent or should receive the
encapsulated MQTT-SN packet. The receiving Gateway can pass this
information back to the Forwarder in the MQTT-SN response packet
encapsulation, to allow the Forwarder to send packets to the appropriate
destination.

The mapping between this information and the address of the sending or
receiving Client node is implemented by the Forwarder, if needed. It can
contain any other information needed to allow the packets to reach the
correct destination.

#quote(block: true)[
#strong[Informative Comment]

For example, in MQTT-SN 1.2 this field contained a wireless node
identifier, which mapped to the Network Address, and a broadcast radius
for use in ZigBee networks.
]

=== MQTT-SN Packet
<fe---mqtt-sn-packet>
The MQTT-SN packet, encoded according to the packet type.

== Gateway Discovery Packets
<gateway-discovery-packets>
The Packets in this section are optional. A description of how this
functionality works can be found in
#link(<c.7-gateway-advertisement-and-discovery>)[C.7 "Gateway Advertisement and Discovery"].

=== ADVERTISE - Gateway Advertisement
<advertise---gateway-advertisement>
#figure(image("images/advertise-packet-diagram.png", alt: "ADVERTISE Packet"),
  caption: [
    ADVERTISE Packet
  ]
)
<fig-advertise-packet>

The ADVERTISE packet is sent periodically by a Gateway to advertise its
presence. The time interval until the next transmission is indicated by
the #emph[Duration] field.

#quote(block: true)[
#strong[Informative comment]

If the Transport Layer supports multicast, like UDP/IP, the ADVERTISE
packet can be sent using a multicast address as the destination.
]

==== ADVERTISE Header
<advertise-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Gateway Identifier
<gateway-identifier>
The #emph[Gateway Identifier] field is 1 byte and uniquely identifies a
Gateway which is advertising its presence on the network.

The MQTT-SN protocol itself does not guarantee the uniqueness of the
#emph[Gateway Identifier].

==== Duration
<duration>
The #emph[Duration] field is a 2-byte integer. It specifies the time
interval in seconds until the next ADVERTISE packet is transmitted by
this Gateway.

The maximum value that can be encoded is approximately 18 hours.

=== SEARCHGW - Search for A Gateway
<searchgw---search-for-a-gateway>
#figure(image("images/searchgw-packet-diagram.png", alt: "SEARCHGW Packet"),
  caption: [
    SEARCHGW Packet
  ]
)
<fig-searchgw-packet>

The SEARCHGW packet is sent by a Client to find a Gateway to send
Application Messages to, and receive Application Messages from.

#quote(block: true)[
#strong[Informative comment]

If the Transport Layer supports multicast, like UDP/IP, the SEARCHGW
packet can be sent using the multicast address as the destination.

To prevent flooding the network, the transmission radius of the SEARCHGW
packet may be limited, if the underlying Transport Layer supports the
concept.
]

==== SEARCHGW Header
<searchgw-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Additional Network Information
<additional-network-information>
Any extra information that the underlying network needs to control the
search process can be included in this variable length field. It will be
available to the receiver of this packet and could be used to affect the
transmission of the GWINFO response packet.

This field is optional - its existence or absence is inferred from the
Packet length.

#quote(block: true)[
#strong[Informative Comment]

In ZigBee mesh networks, this field could contain the ZigBee 1-byte
broadcast radius, for instance.
]

=== GWINFO - Gateway Information
<gwinfo---gateway-information>
#figure(image("images/gwinfo-packet-diagram.png", alt: "GWINFO Packet"),
  caption: [
    GWINFO Packet
  ]
)
<fig-gwinfo-packet>

The GWINFO packet is sent as response to a SEARCHGW packet. If sent by a
Gateway, it contains only the identifier of the sending Gateway;
otherwise, if sent by a client, it also includes the Network Address of
the Gateway.

#quote(block: true)[
#strong[Informative comment]

If the Transport Layer supports multicast, like UDP/IP, the GWINFO
packet can be sent using a multicast address as destination.
]

==== GWINFO Header
<gwinfo-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

==== Gateway Identifier
<gwinfo---gateway-identifier>
The #emph[Gateway Identifier] field is 1-byte long and uniquely
identifies a Gateway in the network.

==== Gateway Address
<gateway-address>
The #emph[Gateway Address] field has a variable length and contains the
Network Address of a Gateway. Its length depends on the type of network
over which MQTT-SN operates and is specified by the Length byte.

This field is optional - its existence or absence is inferred from the
Packet length. It is only included if the Packet is sent by a Client.

#pagebreak(weak: true)
= Operational behavior
<operational-behavior>
An important design point of MQTT-SN is to be as close as possible to
MQTT. Therefore, all protocol semantics should remain, as far as
possible, the same as those defined by MQTT.

== Session state
<session-state>
In order to implement QoS 1 and QoS 2 protocol flows the Client and
Server need to associate state with the Client Identifier, this is
referred to as the Session State. The Server also stores the
subscriptions as part of the Session State.

The Session can continue across a sequence of Virtual Connections. It
lasts as long as the latest Virtual Connection plus the Session Expiry
Interval.

The Session State in the Client consists of:

- QoS 1 and QoS 2 PUBLISH Packets which have been sent to the Server,
  but have not been completely acknowledged.

- QoS 2 PUBLISH Packets which have been received from the Server, but
  have not been completely acknowledged.

- Session Topic Alias mappings.

The Session State in the Server consists of:

- The existence of a Session, even if the rest of the Session State is
  empty.

- The Client's subscriptions.

- QoS 1 and QoS 2 PUBLISH Packets which have been sent to the Client,
  but have not been completely acknowledged.

- QoS 1 and QoS 2 PUBLISH Packets pending transmission to the Client and
  OPTIONALLY QoS 0 PUBLISH Packets pending transmission to the Client.

- QoS 2 PUBLISH Packets which have been received from the Client, but
  have not been completely acknowledged.

- The Will Message and associated Will data.

- If the Session is currently not connected, the time at which the
  Session will end and Session State will be discarded.

- Session Topic Alias mappings.

Retained messages do not form part of the Session State in the Server,
they are not deleted as a result of a Session ending.

=== Storing Session State
<storing-session-state>
«#box()<MQTT-SN-4.1.1-1>The Server MUST NOT discard the Session State
while the Virtual Connection
exists»#link(<tab-MQTT-SN-4.1.1-1>)[MQTT‑SN‑4.1.1‑1].

«#box()<MQTT-SN-4.1.1-2>The Client MUST NOT discard the Session State
while the Virtual Connection
exists»#link(<tab-MQTT-SN-4.1.1-2>)[MQTT‑SN‑4.1.1‑2].

«#box()<MQTT-SN-4.1.1-3>The Server MUST discard the Session State when
the Virtual Connection is deleted and the Session Expiry Interval has
passed»#link(<tab-MQTT-SN-4.1.1-3>)[MQTT‑SN‑4.1.1‑3]. A Session Expiry
Interval of 0xFFFFFFFF is an infinite amount of time, so never passes.

#quote(block: true)[
#strong[Informative comment]

The storage capabilities of Client and Server implementations will of
course have limits in terms of capacity and may be subject to
administrative policies. Stored Session State can be discarded as a
result of an administrator action, including an automated response to
defined conditions. This has the effect of terminating the Session.
These actions might be prompted by resource constraints or for other
operational reasons. It is possible that hardware or software failures
may result in loss or corruption of Session State stored by the Client
or Server. It is prudent to evaluate the storage capabilities of the
Client and Server to ensure that they are sufficient.
]

=== Session Establishment
<session-establishment>
An MQTT-SN Client needs to create a session on the server, unless it is
only publishing using PUBWOS packets. The procedure for setting up a
session with a server is illustrated in figures 4-1 and 4-2.

The CONNECT packet contains flags to communicate to the Server that
authentication interactions, with the AUTH packet, should take place.

#figure(image("images/image15.png", alt: "Connect Procedure (without Auth flag set, or no further authentication data required)"),
  caption: [
    Connect Procedure (without Auth flag set, or no further
    authentication data required)
  ]
)
<fig-connect-procedure-without-auth-flag-set-or-no-further-authentication-data-required>

#figure(image("images/image33.png", alt: "Connect Procedure (with Auth flag set and further authentication data required)"),
  caption: [
    Connect Procedure (with Auth flag set and further authentication
    data required)
  ]
)
<fig-connect-procedure-with-auth-flag-set-and-further-authentication-data-required>

If the Server can not accept the CONNECT request the Server returns a
CONNACK packet with the rejection Reason Code.

«#box()<MQTT-SN-4.1.2-1>If the Client provides no client identifier, the
Server MUST respond with a CONNACK containing an Assigned Client
Identifier»#link(<tab-MQTT-SN-4.1.2-1>)[MQTT‑SN‑4.1.2‑1].

«#box()<MQTT-SN-4.1.2-2>An Assigned Client Identifier MUST be a new
Client Identifier not used by any other Session currently in the
Server»#link(<tab-MQTT-SN-4.1.2-2>)[MQTT‑SN‑4.1.2‑2].

== Networks and Virtual Connections
<networks-and-virtual-connections>
The MQTT-SN protocol requires an Underlying Network to carry Packets
from a Client to a Server and from a Server to a Client.

The Underlying Network may also be able to send Packets from a sender to
more than one receiver at once -- UDP/IP multicast, for example.

The relationship between MQTT-SN and the Underlying Network is described
in the following points:

- MQTT-SN Packets which are received must be unaltered and complete.
  There is no packet error correction in MQTT-SN. If a corrupted or
  partial packet is received it will cause a protocol error.

- The Underlying Network does not need to be reliable, it is expected
  that Packets can be lost or delivered out of order. The MQTT-SN
  protocol will tolerate out of order Packets and it will retransmit
  lost Packets in the case that an expected acknowledgement has not been
  received.

- «#box()<MQTT-SN-4.2-1>If the Underlying Network might deliver a Packet
  more than once, for connection-oriented communications (CONNECT,
  DISCONNECT and other packets in between) the PROTECTION ENCAPSULATION
  Monotonic Counter MUST be used to eliminate
  duplicates»#link(<tab-MQTT-SN-4.2-1>)[MQTT‑SN‑4.2‑1]. (In the case
  that a protected packet is duplicated, the Monotonic Counter will be
  the same on all the duplicates of a packet).

- The Underlying Network may be connectionless. Virtual Connections do
  not need to have an Underlying Network event that signals their
  creation or deletion.

- The Underlying Network may be a radio network.

#quote(block: true)[
#strong[Informative comment]

UDP as defined in \[RFC0768\] can be used for MQTT-SN if the Maximum
Transmission Unit is configured to be more than the maximum MQTT-SN
Packet size used and no Packet fragmentation occurs. Depending on the
network configuration, UDP can duplicate Packets. If this can happen,
the PROTECTION ENCAPSULATION monotonic counter must be used.

Examples of possible consequences of allowing duplicate Packets are: \
-- DISCONNECT Packet applied to the wrong Virtual Connection \ --
SUBSCRIBE and UNSUBSCRIBE Packets applied to the wrong Virtual
Connection \ -- PUBLISH QOS=2 published more than once

The following transport protocols are also suitable but if not capable
of multicast the implementation of the optional ADVERTISE, SEARCHGW,
GWINFO packets may not be possible:

- DTLS v1.2 \[RFC6347\]

- DTLS v1.3 \[RFC9147\]

- QUIC \[RFC9000\]

- Non-IP protocols

- TCP/IP \[RFC0793\]

- TLS \[RFC5246\]

- WebSocket \[RFC6455\].
]

#quote(block: true)[
#strong[Informative comment]

Both TCP and UDP ports 1883 and 8883 are registered with IANA for MQTT
and secure communication respectively.
]

=== Virtual Connections
<virtual-connections>
A Virtual Connection is:

- created with a CONNECT packet

- deleted by any of:

  - Keep Alive timeout

  - Retry timeout

  - DISCONNECT packet

  - protocol error

- required for any MQTT-SN Packet to be sent between an MQTT-SN Client
  and Server, except any of the following Packets:

  - CONNECT, which creates a Virtual Connection

  - PUBWOS (and PUBLISH QoS -1 if implemented)

  - ADVERTISE, SEARCHGW, GWINFO

«#box()<MQTT-SN-4.2.1-1>All incoming Packets except CONNECT, PUBWOS and
Gateway search (ADVERTISE, SEARCHGW and GWINFO) MUST be associated with
an existing Virtual
Connection»#link(<tab-MQTT-SN-4.2.1-1>)[MQTT‑SN‑4.2.1‑1].

Virtual Connections link a Network Identity with a Session. For those
Packets other than CONNECT, PUBWOS and Gateway search, the receiver
needs to be able to identify the sender to associate the Packet with a
Virtual Connection. The Sender may be identified in various ways, for
example:

- Network Address

- Protection Encapsulation - Sender Identifier

- Connection Encapsulation - Connection Information

- DTLS Connection ID

#quote(block: true)[
#strong[Informative Comment]

The Network Address was the usual method of identifying the Sender in
MQTT-SN 1.2, but may not be secure, or work in environments where the
Network Address of a Client device may change during the lifetime of a
Virtual Connection.
]

== Quality of Service levels and protocol flows
<quality-of-service-levels-and-protocol-flows>
MQTT-SN delivers Application Messages according to the Quality of
Service (QoS) levels defined in the following sections. The delivery
protocol is symmetric - in the description below the role of the sender
can be taken by the Client with the Server being the receiver, or the
role of the sender can be taken by the Server with the Client being the
receiver. When the Server is delivering an Application Message to more
than one Client, each Client is treated independently. The QoS level
used to deliver an Application Message outbound to the Client could
differ from that of the inbound Application Message.

=== Publish without session
<publish-without-session>
No Session or Virtual Connection is required to send a message. The
message is delivered according to the capabilities of the underlying
network. No response is sent by the receiver and no retry is performed
by the sender. The message arrives at the receiver either once or not at
all.

In the PUBWOS delivery protocol, the sender:

- «#box()<MQTT-SN-4.3.1-1>MUST send a PUBWOS
  packet»#link(<tab-MQTT-SN-4.3.1-1>)[MQTT‑SN‑4.3.1‑1].

The receiver:

- May accept or reject the message in a PUBWOS packet for any reason.

- «#box()<MQTT-SN-4.3.1-2>MUST treat any accepted messages as QoS
  0»#link(<tab-MQTT-SN-4.3.1-2>)[MQTT‑SN‑4.3.1‑2].

#quote(block: true)[
#strong[Informative Comment:]

Each PUBWOS packet may be received and processed by more than one
receiver.
]

=== QoS 0: At most once delivery
<qos-0-at-most-once-delivery>
The message is delivered according to the capabilities of the underlying
network. No response is sent by the receiver and no retry is performed
by the sender. The message arrives at the receiver either once or not at
all.

In the QoS 0 delivery protocol, the sender:

- «#box()<MQTT-SN-4.3.2-1>MUST send a PUBLISH packet with QoS
  0»#link(<tab-MQTT-SN-4.3.2-1>)[MQTT‑SN‑4.3.2‑1].

In the QoS 0 delivery protocol, the receiver:

- Accepts ownership of the message when it receives the PUBLISH packet.

#figure(
  align(center)[#table(
    columns: (14.85%, 21.78%, 63.37%),
    align: (left,center,left,),
    table.header([Sender Action], [Control Packet], [Receiver action],),
    table.hline(),
    [PUBLISH QoS 0], [], [],
    [], [-\-\-\-\-\-\-\-\-\-\>], [],
    [], [], [Deliver Application Message to appropriate onward
    recipient(s)],
  )]
  , caption: [QoS 0 protocol flow, informative example]
  , kind: table
  )
<tab-qos-0-protocol-flow-informative-example>

=== QoS 1: At least once delivery
<qos-1-at-least-once-delivery>
This Quality of Service level ensures that the message arrives at the
receiver at least once. A QoS 1 PUBLISH packet has a Packet Identifier
in its Variable Header and is acknowledged by a PUBACK packet.

In the QoS 1 delivery protocol, the sender:

- «#box()<MQTT-SN-4.3.3-1>MUST assign an unused Packet Identifier each
  time it has a new Application Message to
  publish»#link(<tab-MQTT-SN-4.3.3-1>)[MQTT‑SN‑4.3.3‑1].

- «#box()<MQTT-SN-4.3.3-2>MUST send a PUBLISH packet containing this
  Packet Identifier with QoS 1 and DUP flag set to
  0»#link(<tab-MQTT-SN-4.3.3-2>)[MQTT‑SN‑4.3.3‑2].

- «#box()<MQTT-SN-4.3.3-3>MUST treat the PUBLISH packet as
  "unacknowledged" until it has received the corresponding PUBACK packet
  from the receiver»#link(<tab-MQTT-SN-4.3.3-3>)[MQTT‑SN‑4.3.3‑3].

The Packet Identifier becomes available for reuse once the sender has
received the PUBACK packet.

The sender is NOT permitted to send further packets with different
Packet Identifiers while it is waiting to receive acknowledgements.
«#box()<MQTT-SN-4.3.3-4>At all times a Sender MUST have a maximum of one
unacknowledged packet»#link(<tab-MQTT-SN-4.3.3-4>)[MQTT‑SN‑4.3.3‑4].

In the QoS 1 delivery protocol, the receiver:

- «#box()<MQTT-SN-4.3.3-5>MUST respond with a PUBACK packet containing
  the Packet Identifier from the incoming PUBLISH packet, having
  accepted ownership of the Application
  Message»#link(<tab-MQTT-SN-4.3.3-5>)[MQTT‑SN‑4.3.3‑5].

- «#box()<MQTT-SN-4.3.3-6>after it has sent a PUBACK packet, MUST treat
  any incoming PUBLISH packet that contains the same Packet Identifier
  as being a new Application
  Message»#link(<tab-MQTT-SN-4.3.3-6>)[MQTT‑SN‑4.3.3‑6].

#figure(
  align(center)[#table(
    columns: (38.35%, 18.8%, 42.86%),
    align: (left,center,left,),
    table.header([Sender Action], [MQTT-SN Control Packet], [Receiver
      action],),
    table.hline(),
    [Store message], [], [],
    [Send PUBLISH QoS 1, DUP=0, \<Packet
    Identifier\>], [-\-\-\-\-\-\-\-\-\-\>], [],
    [], [], [Initiate onward delivery of the Application Message (1)],
    [], [\<-\-\-\-\-\-\-\-\-\-], [Send PUBACK \<Packet Identifier\>],
    [Discard message], [], [],
  )]
  , caption: [QoS 1 protocol flow, informative example]
  , kind: table
  )
<tab-qos-1-protocol-flow-informative-example>

#quote(block: true)[
#super[1]The receiver does not need to complete delivery of the
Application Message before sending the PUBACK. When its original sender
receives the PUBACK packet, ownership of the Application Message is
transferred to the receiver.
]

=== QoS 2: Exactly once delivery
<qos-2-exactly-once-delivery>
This is the highest Quality of Service level, for use when neither loss
nor duplication of Application Messages are acceptable. There is an
increased overhead associated with QoS 2.

In the QoS 2 delivery protocol, the sender:

- «#box()<MQTT-SN-4.3.4-1>MUST assign an unused Packet Identifier when
  it has a new Application Message to
  publish»#link(<tab-MQTT-SN-4.3.4-1>)[MQTT‑SN‑4.3.4‑1]

- «#box()<MQTT-SN-4.3.4-2>MUST send a PUBLISH packet containing this
  Packet Identifier with QoS equal to
  2»#link(<tab-MQTT-SN-4.3.4-2>)[MQTT‑SN‑4.3.4‑2]

- «#box()<MQTT-SN-4.3.4-3>MUST set the DUP flag to 0 when it attempts to
  send a PUBLISH packet for the first
  time»#link(<tab-MQTT-SN-4.3.4-3>)[MQTT‑SN‑4.3.4‑3]

- «#box()<MQTT-SN-4.3.4-4>MUST set the DUP flag to 1 when it attempts to
  resend a PUBLISH packet»#link(<tab-MQTT-SN-4.3.4-4>)[MQTT‑SN‑4.3.4‑4]

- «#box()<MQTT-SN-4.3.4-5>MUST treat the PUBLISH packet as
  "unacknowledged" until it has received the corresponding PUBREC packet
  from the receiver»#link(<tab-MQTT-SN-4.3.4-5>)[MQTT‑SN‑4.3.4‑5]

- «#box()<MQTT-SN-4.3.4-6>MUST send a PUBREL packet when it receives a
  PUBREC packet from the receiver with a Reason Code value less than
  0x80. This PUBREL packet MUST contain the same Packet Identifier as
  the original PUBLISH
  packet»#link(<tab-MQTT-SN-4.3.4-6>)[MQTT‑SN‑4.3.4‑6]

- «#box()<MQTT-SN-4.3.4-7>MUST treat the PUBREL packet as
  "unacknowledged" until it has received the corresponding PUBCOMP
  packet from the receiver»#link(<tab-MQTT-SN-4.3.4-7>)[MQTT‑SN‑4.3.4‑7]

- «#box()<MQTT-SN-4.3.4-8>MUST NOT resend the PUBLISH once it has sent
  the corresponding PUBREL
  packet»#link(<tab-MQTT-SN-4.3.4-8>)[MQTT-SN-4.3.4-8]

The Packet Identifier becomes available for reuse once the sender has
received the PUBCOMP packet or a PUBREC with a Reason Code of 0x80 or
greater.

In the QoS 2 delivery protocol, the receiver:

- «#box()<MQTT-SN-4.3.4-9>MUST respond with a PUBREC containing the
  Packet Identifier from the incoming PUBLISH packet, having accepted
  ownership of the Application
  Message»#link(<tab-MQTT-SN-4.3.4-9>)[MQTT‑SN‑4.3.4‑9]

- «#box()<MQTT-SN-4.3.4-10>If it has sent a PUBREC with a Reason Code of
  0x80 or greater, the receiver MUST treat any subsequent PUBLISH packet
  that contains that Packet Identifier as being a new Application
  Message»#link(<tab-MQTT-SN-4.3.4-10>)[MQTT‑SN‑4.3.4‑10]

- «#box()<MQTT-SN-4.3.4-11>Until it has received the corresponding
  PUBREL packet, the receiver MUST acknowledge any subsequent PUBLISH
  packet with the same Packet Identifier by sending a PUBREC. It MUST
  NOT cause duplicate messages to be delivered to any onward recipients
  in this case»#link(<tab-MQTT-SN-4.3.4-11>)[MQTT‑SN‑4.3.4‑11]

- «#box()<MQTT-SN-4.3.4-12>MUST respond to a PUBREL packet by sending a
  PUBCOMP packet containing the same Packet Identifier as the
  PUBREL»#link(<tab-MQTT-SN-4.3.4-12>)[MQTT‑SN‑4.3.4‑12]

- «#box()<MQTT-SN-4.3.4-13>After it has sent a PUBCOMP, the receiver
  MUST treat any subsequent PUBLISH packet that contains that Packet
  Identifier as being a new Application Message, irrespective of the
  setting of its DUP
  flag»#link(<tab-MQTT-SN-4.3.4-13>)[MQTT‑SN‑4.3.4‑13]

#figure(
  align(center)[#table(
    columns: (30.14%, 13.4%, 56.46%),
    align: (left,center,left,),
    table.header([#strong[Sender Action]], [#strong[MQTT-SN Control
      Packet]], [#strong[Receiver Action]],),
    table.hline(),
    [Store message], [], [],
    [PUBLISH QoS 2, DUP=0\<Packet Identifier\>], [], [],
    [], [-\-\-\-\-\-\-\-\-\-\>], [],
    [], [], [Store \<Packet Identifier\> and message],
    [], [], [PUBREC \<Packet Identifier\>\<Reason Code\>],
    [], [\<-\-\-\-\-\-\-\-\-\-], [],
    [Discard message, Store PUBREC received \<Packet
    Identifier\>], [], [],
    [PUBREL \<Packet Identifier\>], [], [],
    [], [-\-\-\-\-\-\-\-\-\-\>], [],
    [], [], [Initiate onward delivery of the Application Message (1)
    then discard the message and \<Packet Identifier\>],
    [], [], [Send PUBCOMP \<Packet Identifier\>],
    [], [\<-\-\-\-\-\-\-\-\-\-], [],
    [Discard stored state], [], [],
  )]
  , caption: [QoS 2 protocol flow, informative example]
  , kind: table
  )
<tab-qos-2-protocol-flow-informative-example>

#quote(block: true)[
#super[1] The receiver does not need to complete delivery of the
Application Message before sending the PUBREC or PUBCOMP. When its
original sender receives the PUBREC packet, ownership of the Application
Message is transferred to the receiver. However, the receiver needs to
perform all checks for conditions which might result in a forwarding
failure (for example, quota exceeded or authorization) before accepting
ownership. The receiver indicates success or failure using the
appropriate Reason Code in the PUBREC.
]

== Packet delivery retry
<packet-delivery-retry>
There are two situations when packets that require acknowledgement are
resent by the sender:

+ when a Virtual Connection is deleted before the acknowledgement is
  received by the requester, and Clean Start is 0

+ when no acknowledgment is received by the requester within a
  configured timeout period during the existence of a Virtual Connection

These situations are described in the following sections.

=== Virtual Connection End
<virtual-connection-end>
«#box()<MQTT-SN-4.4.1-1>When a Client reconnects with Clean Start set to
0 and a Session is present, both the Client and Server MUST resend any
unacknowledged PUBLISH with QoS 1 and 2 packets (not QoS 0) and PUBREL
packets using their original Packet
Identifiers»#link(<tab-MQTT-SN-4.4.1-1>)[MQTT‑SN‑4.4.1‑1].

«#box()<MQTT-SN-4.4.1-2>If PUBACK or PUBREC is received containing a
Reason Code of 0x80 or greater, the corresponding PUBLISH packet is
treated as acknowledged, and MUST NOT be
retransmitted»#link(<tab-MQTT-SN-4.4.1-2>)[MQTT‑SN‑4.4.1‑2].

«#box()<MQTT-SN-4.4.1-3>The DUP flag MUST be set to 1 by the Client or
Server when it attempts to resend a PUBLISH QoS 2
packet»#link(<tab-MQTT-SN-4.4.1-3>)[MQTT‑SN‑4.4.1‑3].

=== Unacknowledged Packets
<unacknowledged-packets>
In MQTT-SN, any packet may not be delivered by the underlying Network.
If a packet is lost, the response to a request will not arrive. In
addition to the Keep Alive timer, MQTT-SN Clients and Servers may also
resend any packets for which a response is expected, but not received.

The Control Packets that expect a response and must be retried if there
is none, are:

- Sent by both Clients and Servers:

  - REGISTER

  - PUBLISH QoS 1 and 2

  - PUBREL

- Sent by Clients only:

  - SUBSCRIBE

  - UNSUBSCRIBE

  - SLEEPREQ

  - PINGREQ

The Control Packets in the above list, along with CONNECT and AUTH, are
referred to as request Packets.

«#box()<MQTT-SN-4.4.2-1>CONNECT and AUTH Packets expect a response but
MUST NOT be retried»#link(<tab-MQTT-SN-4.4.2-1>)[MQTT‑SN‑4.4.2‑1].

«#box()<MQTT-SN-4.4.2-2>The connection sequence CONNECT, zero or more
AUTH Packets then CONNACK MUST be completed without
retries»#link(<tab-MQTT-SN-4.4.2-2>)[MQTT‑SN‑4.4.2‑2].

If a connection attempt fails, the Client may send a new CONNECT packet
to try again.

«#box()<MQTT-SN-4.4.2-3>A Server MUST respond promptly to a valid
request Packet»#link(<tab-MQTT-SN-4.4.2-3>)[MQTT‑SN‑4.4.2‑3].

«#box()<MQTT-SN-4.4.2-4>A Client in the Awake and Active states MUST
respond promptly to a valid request
Packet»#link(<tab-MQTT-SN-4.4.2-4>)[MQTT‑SN‑4.4.2‑4].

An MQTT-SN Sender may be configured with two parameters to govern its
resending of unacknowledged packets:

+ Retry Interval

+ Maximum Retry Count

on the basis of the expected characteristics of the Underlying Network.
Example values for these are suggested in
#link(<c.3-example-timer-and-counter-values>)[C.3 "Example Timer and Counter Values"].
See also #link(<c.4-exponential-backoff>)[C.4 "Exponential Backoff"] for
guidance on varying the #emph[Retry Interval] to reduce potential
network congestion.

If a response to one of the above request Packets is not received in the
#emph[Retry Interval], the Sender resends the request Packet. The
request is repeated at #emph[Retry Interval] intervals, until a response
is received or the #emph[Maximum Retry Count] is reached. After the
#emph[Maximum Retry Count] is reached and a further #emph[Retry
Interval] has passed without a response, the Virtual Connection is
deleted.

«#box()<MQTT-SN-4.4.2-5>In the absence of a response to a Packet which
expects one, the Sender MUST delete the Virtual Connection if one
exists»#link(<tab-MQTT-SN-4.4.2-5>)[MQTT-SN-4.4.2-5]. If the Sender is a
Server and a Will Message is defined for the Virtual Connection, the
Will Message is be published as described in
#link(<will-flag>)[3.1.2.2 "Will Flag"]. A new Virtual Connection will
have to be established to continue.

«#box()<MQTT-SN-4.4.2-6>If a Packet is retransmitted, it MUST have
Protection Encapsulation if the previously transmitted Packet had
Protection Encapsulation»#link(<tab-MQTT-SN-4.4.2-6>)[MQTT‑SN‑4.4.2‑6].

«#box()<MQTT-SN-4.4.2-7>If a Packet is retransmitted it MUST be
identical to the previously transmitted Packet, the DUP flag excepted.
The Protection Encapsulation need not be
identical»#link(<tab-MQTT-SN-4.4.2-7>)[MQTT‑SN‑4.4.2‑7].

#quote(block: true)[
#strong[Informative comment]

The value of the #emph[Retry Interval] is not specified by MQTT-SN,
however, to be useful it ought to be longer than the network round trip
time. If it is excessively long, the time taken to detect and retransmit
lost Packets will also be excessively long. Implementers need to take
care not to use a retry interval that might cause the network to become
congested with retried Packets.

#strong[Informative comment]

To be useful, and depending on the reliability characteristics of the
Underlying Network, the retry cycle should be shorter than the Keep
Alive interval. If it is not, then a Keep Alive timeout may occur during
the retry cycle, causing the Virtual Connection to be deleted, and the
rest of the retry cycle to be ineffective.
]

== Application Message receipt
<application-message-receipt>
«#box()<MQTT-SN-4.5-1>When a Server takes ownership of an incoming
Application Message it MUST add it to the Session State for those
Clients that have matching
Subscriptions»#link(<tab-MQTT-SN-4.5-1>)[MQTT‑SN‑4.5‑1]. Matching rules
are defined in
#link(<topic-names-and-topic-filters>)[4.7.1 "Topic Names and Topic Filters"].

Under normal circumstances Clients receive Application Messages in
response to Subscriptions they have created. A Client could also receive
Application Messages that do not match any of its explicit
Subscriptions. This can happen if the Server automatically assigned a
subscription to the Client. A Client could also receive Application
Messages while an UNSUBSCRIBE operation is in progress.
«#box()<MQTT-SN-4.5-2>The Client MUST acknowledge any PUBLISH packet it
receives according to the applicable QoS rules regardless of whether it
elects to process the Application Message that it
contains»#link(<tab-MQTT-SN-4.5-2>)[MQTT‑SN‑4.5‑2].

== Application Message ordering
<application-message-ordering>
An Ordered Topic is a Topic where the Client can be certain that the
Application Messages in that Topic from the same Client and at the same
QoS are received in the order they were published.
«#box()<MQTT-SN-4.6-1>When a Server processes an Application Message
that has been published to an Ordered Topic, it MUST send PUBLISH
packets to consumers (for the same Topic and QoS) in the order that they
were received from any given
Client»#link(<tab-MQTT-SN-4.6-1>)[MQTT‑SN‑4.6‑1].

«#box()<MQTT-SN-4.6-2>By default, a Server MUST treat every Topic as an
Ordered Topic when it is forwarding Application
Messages»#link(<tab-MQTT-SN-4.6-2>)[MQTT‑SN‑4.6‑2]. A Server MAY provide
an administrative or other mechanism to allow one or more Topics to not
be treated as an Ordered Topic.

#quote(block: true)[
#strong[Informative comment]

When a stream of messages is published and subscribed to an Ordered
Topic with QoS 1, the final copy of each message received by the
subscribers will be in the order that they were published. As no more
than one message is "in-flight" at any one time, no QoS 1 message will
be received after any later one even on re-connection. For example a
subscriber might receive them in the order 1,2,3,3,4 but not
1,2,3,2,3,4.
]

== Topics
<topics>
=== Topic Names and Topic Filters
<topic-names-and-topic-filters>
Topic Names are a label for a message, consisting of a series of topic
levels, each level separated by the topic level separator.

Topic Filters can match several Topic Names by replacing the topic
levels with wildcards.

==== Topic wildcards
<topic-wildcards>
The topic level separator is used to introduce structure into the Topic
Name. If present, it divides the Topic Name into multiple "topic
levels".

A subscription's Topic Filter can contain special wildcard characters,
which allow a Client to subscribe to multiple topics at once.

«#box()<MQTT-SN-4.7.1.1-1>A Topic Name, the target of PUBWOS and PUBLISH
packets, MUST NOT contain special wildcard
characters.»#link(<tab-MQTT-SN-4.7.1.1-1>)[MQTT‑SN‑4.7.1.1‑1].

===== Topic level separator
<topic-level-separator>
The forward slash ('/' U+002F) is used to separate each level within a
topic tree and provide a hierarchical structure to the Topic Names. The
use of the topic level separator is significant when either of the two
wildcard characters is encountered in Topic Filters specified by
subscribing Clients. Topic level separators can appear anywhere in a
Topic Filter or Topic Name. Adjacent Topic level separators indicate a
zero-length topic level.

===== Multi-level wildcard
<multi-level-wildcard>
The number sign ('\#' U+0023) is a wildcard character that matches any
number of levels within a topic. The multi-level wildcard represents the
parent and any number of child levels. «#box()<MQTT-SN-4.7.1.1.2-1>The
multi-level wildcard character MUST be specified either on its own or
following a topic level separator. In either case it MUST be the last
character specified in the Topic
Filter»#link(<tab-MQTT-SN-4.7.1.1.2-1>)[MQTT‑SN‑4.7.1.1.2‑1].

#quote(block: true)[
#strong[Informative comment]

For example, if a Client subscribes to "sport/tennis/player1/\#", it
would receive Application Messages published using these Topic Names:

- "sport/tennis/player1"

- “sport/tennis/player1/ranking

- "sport/tennis/player1/score/wimbledon"
]

#quote(block: true)[
#strong[Informative comment]

- "sport/\#" also matches the singular "sport", since \# includes the
  parent level.

- "\#" is valid and will receive every Application Message

- "sport/tennis/\#" is valid

- "sport/tennis\#" is not valid

- "sport/tennis/\#/ranking" is not valid
]

===== Single-level wildcard
<single-level-wildcard>
The plus sign ('+' U+002B) is a wildcard character that matches only one
topic level.

«#box()<MQTT-SN-4.7.1.1.3-1>The single-level wildcard can be used at any
level in the Topic Filter, including first and last levels. Where it is
used, it MUST occupy an entire level of the
filter»#link(<tab-MQTT-SN-4.7.1.1.3-1>)[MQTT‑SN‑4.7.1.1.3‑1]. It can be
used at more than one level in the Topic Filter and can be used in
conjunction with the multi-level wildcard.

#quote(block: true)[
#strong[Informative comment]

For example, "sport/tennis/+" matches "sport/tennis/player1" and
"sport/tennis/player2", but not "sport/tennis/player1/ranking". Also,
because the single-level wildcard matches only a single level, "sport/+"
does not match "sport" but it does match "sport/".

- "+" is valid

- "+/tennis/\#" is valid

- "sport+" is not valid

- "sport/+/player1" is valid

- "/finance" matches "+/+" and "/+", but not "+"
]

==== Topics beginning with \$
<topics-beginning-with-dollar>
«#box()<MQTT-SN-4.7.1.2-1>The Server MUST NOT match Topic Filters
starting with a wildcard character (\# or +) with Topic Names beginning
with a \$ character»#link(<tab-MQTT-SN-4.7.1.2-1>)[MQTT‑SN‑4.7.1.2‑1].
The Server SHOULD prevent Clients from using such Topic Names to
exchange messages with other Clients. Server implementations MAY use
Topic Names that start with a leading \$ character for other purposes.

#quote(block: true)[
#strong[Informative comment]

- \$SYS/ has been widely adopted as a prefix to topics that contain
  Server-specific information or control APIs

- Applications cannot use a topic with a leading \$ character for their
  own purposes
]

#quote(block: true)[
#strong[Informative comment]

- A subscription to "\#" will not receive any messages published to a
  topic beginning with a \$

- A subscription to "+/monitor/Clients" will not receive any messages
  published to "\$SYS/monitor/Clients"

- A subscription to "\$SYS/\#" will receive messages published to topics
  beginning with "\$SYS/"

- A subscription to "\$SYS/monitor/+" will receive messages published to
  "\$SYS/monitor/Clients"

- For a Client to receive messages from topics that begin with \$SYS/
  and from topics that don't begin with a \$, it has to subscribe to
  both "\#" and "\$SYS/\#"
]

==== Topic semantic and usage
<topic-semantic-and-usage>
The following rules apply to Topic Names and Topic Filters:

- «#box()<MQTT-SN-4.7.1.3-1>All Topic Names and Topic Filters MUST be at
  least one character
  long»#link(<tab-MQTT-SN-4.7.1.3-1>)[MQTT‑SN‑4.7.1.3‑1]

- Topic Names and Topic Filters are case sensitive

- Topic Names and Topic Filters can include the space character

- A leading or trailing '/' creates a distinct Topic Name or Topic
  Filter

- A Topic Name or Topic Filter consisting only of the '/' character is
  valid

- «#box()<MQTT-SN-4.7.1.3-2>Topic Names and Topic Filters MUST NOT
  include the null character (Unicode U+0000)
  #link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#Unicode")[\[Unicode\]]»#link(<tab-MQTT-SN-4.7.1.3-2>)[MQTT-SN-4.7.1.3-2]

- «#box()<MQTT-SN-4.7.1.3-3>Topic Names and Topic Filters are UTF-8
  Encoded Strings; they MUST NOT encode to more than 65,535
  bytes»#link(<tab-MQTT-SN-4.7.1.3-3>)[MQTT‑SN‑4.7.1.3‑3]. Refer to
  #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"].

There is no limit to the number of levels in a Topic Name or Topic
Filter, other than that imposed by the overall length of a UTF-8 Encoded
String.

«#box()<MQTT-SN-4.7.1.3-4>When it performs subscription matching the
Server MUST NOT perform any normalization of Topic Names or Topic
Filters, or any modification or substitution of unrecognized
characters»#link(<tab-MQTT-SN-4.7.1.3-4>)[MQTT‑SN‑4.7.1.3‑4]. Each
non-wildcarded level in the Topic Filter has to match the corresponding
level in the Topic Name character for character for the match to
succeed.

#quote(block: true)[
#strong[Informative comment]

The UTF-8 encoding rules mean that the comparison of Topic Filter and
Topic Name could be performed either by comparing the encoded UTF-8
bytes, or by comparing decoded Unicode characters.
]

#quote(block: true)[
#strong[Informative comment]

- "ACCOUNTS" and "Accounts" are two different Topic Names

- "Accounts payable" is a valid Topic Name

- "/finance" is different from "finance"
]

An Application Message is sent to each Client Subscription whose Topic
Filter matches the Topic Name attached to an Application Message. The
topic resource MAY be either predefined in the Server by an
administrator or it MAY be dynamically created by the Server when it
receives the first subscription or an Application Message with that
Topic Name. The Server MAY also use a security component to authorize
particular actions on the topic resource for a given Client.

=== Topic Aliases
<topic-aliases>
A Topic Alias is a 2 byte integer value that is used to identify the
Topic instead of using the Topic Name. Topic Aliases can reduce the
bandwidth needed when Topic Names are long and the same Topic Names are
used repetitively.

There are two types of Topic Alias: Predefined and Session. Predefined
and Session Topic Aliases occupy separate value spaces. That is, a
Session Topic Alias MUST be able to have the same numerical value as a
Predefined Topic Alias.

The only reason for the existence of Topic Aliases is to reduce packet
size. Therefore, a Topic Alias is transformed to its mapped Topic Name
when received by a Client or Server before any further processing.

A Subscription contains a Topic Filter, which is a Topic Name that is
allowed to include wildcards - it does not contain any Topic Aliases.

«#box()<MQTT-SN-4.7.2-1>If a Topic Alias exists for a Topic Name, a
Sender (Client or Server) MUST use that Topic Alias and not the Topic
Name in any PUBLISH
packet»#link(<tab-MQTT-SN-4.7.2-1>)[MQTT‑SN‑4.7.2‑1].

A Predefined or Session Topic Alias of 0 is not permitted.
«#box()<MQTT-SN-4.7.2-2>A sender MUST NOT send any Control Packet
containing a Predefined or Session Topic Alias which has the value
0»#link(<tab-MQTT-SN-4.7.2-2>)[MQTT‑SN‑4.7.2‑2].

==== Predefined Topic Aliases
<predefined-topic-aliases>
Predefined Topic Aliases are known to both sender and receivers before
any communication takes place between them. The set of Predefined Topic
Aliases in a Server is the same for all Clients that connect to it.

The definitions of Predefined Topic Aliases are not affected by the
sending or receiving of any MQTT-SN Packets - their creation and upkeep
is an administrative procedure outside the scope of this specification.

«#box()<MQTT-SN-4.7.2.1-1>Predefined Topic Aliases MUST NOT change for
the duration of any MQTT-SN
Session»#link(<tab-MQTT-SN-4.7.2.1-1>)[MQTT‑SN‑4.7.2.1‑1].

«#box()<MQTT-SN-4.7.2.1-2>If a PUBLISH is sent to a Predefined Topic
Alias which is not defined on the receiver it is a Protocol
Error»#link(<tab-MQTT-SN-4.7.2.1-2>)[MQTT‑SN‑4.7.2.1‑2].

==== Session Topic Aliases
<session-topic-aliases>
Session Topic Aliases are allocated and controlled by the Server, not
the Client.

«#box()<MQTT-SN-4.7.2.2-1>Session Topic Aliases MUST be allocated on a
per Session basis - they are not shared between Sessions either with the
same Client or different
Clients»#link(<tab-MQTT-SN-4.7.2.2-1>)[MQTT‑SN‑4.7.2.2‑1].

Session Topic Aliases last for the duration of the Session, except after
a SLEEPREQ with Retain Topic Aliases equal to 0.

There are several ways that a Session Topic Alias can be created:

- A Client subscribes to a Topic Filter without wildcards. The Session
  Topic Alias for that Topic Name is returned in the SUBACK packet.

- A Client sends a REGISTER packet to the Server. If the Server
  successfully creates a Session Topic Alias, its value is returned in
  the REGACK packet.

- As a result of a wildcard subscription, the Server needs to send a
  PUBLISH packet to a Client, and no Topic Alias, Predefined or Session,
  exists for the Topic Name. The Server creates a Session Topic Alias
  and informs the Client by sending it a REGISTER packet.

- The Server may need to re-register Topic Aliases in the Awake state,
  as a result of the Client using the Retain Topic Aliases flag set to 0
  on the SLEEPREQ packet when going to sleep.

«#box()<MQTT-SN-4.7.2.2-2>If a Client subscribes to a Topic Filter which
does not include wildcard characters, a Predefined or Session Topic
Alias MUST be returned in the SUBACK
packet»#link(<tab-MQTT-SN-4.7.2.2-2>)[MQTT‑SN‑4.7.2.2‑2].

«#box()<MQTT-SN-4.7.2.2-3>If a Client subscribes to a Topic Filter which
includes wildcard characters, a Topic Alias (Predefined or Session) MUST
NOT be returned in the SUBACK
packet»#link(<tab-MQTT-SN-4.7.2.2-3>)[MQTT‑SN‑4.7.2.2‑3].

«#box()<MQTT-SN-4.7.2.2-4>A Session Topic Alias MUST NOT be allowed to
map to the same Topic Name as a Predefined Topic
Alias»#link(<tab-MQTT-SN-4.7.2.2-4>)[MQTT‑SN‑4.7.2.2‑4].

«#box()<MQTT-SN-4.7.2.2-5>If a Client requests a Session Topic Alias for
a Topic Name which already has a Predefined Topic Alias, the Server MUST
return a REGACK with the Topic Type "Predefined Topic Alias", the
Predefined Topic Alias, and the Reason Code "Topic Alias
Exists"»#link(<tab-MQTT-SN-4.7.2.2-5>)[MQTT‑SN‑4.7.2.2‑5].

«#box()<MQTT-SN-4.7.2.2-6>A Session Topic alias and a Predefined Topic
Alias with the same numerical value MUST map to different Topic
Names»#link(<tab-MQTT-SN-4.7.2.2-6>)[MQTT‑SN‑4.7.2.2‑6].

== Subscriptions
<subscriptions>
A Subscription is associated only with the Session that created it. Each
Subscription includes a Topic Filter, indicating the topic(s) for which
messages are to be delivered on that Session, and Subscription Options.
The Server is responsible for collecting messages that match the
subscription and transmitting them on the Session\'s Virtual Connection
if and when that Virtual Connection exists.

A Session cannot have more than one Subscription with the same Topic
Filter, so the Topic Filter can be used as a key to identify the
subscription within that Session.

If there are multiple Clients, each with its own Subscription to the
same Topic, each Client gets its own copy of the Application Messages
that are published on that Topic. This means that the Subscriptions
cannot be used to load-balance Application Messages across multiple
consuming Clients as in such cases every message is delivered to every
subscribing Client.

== Flow Control
<flow-control>
The maximum number of unacknowledged MQTT-SN requests in one direction
within a Virtual Connection for both Clients and Servers is 1. The
packets which need acknowledgement and are included in this constraint
are:

- PUBLISH (QoS 1 and 2) and PUBREL

- REGISTER

- SUBSCRIBE

- UNSUBSCRIBE

- PINGREQ

- SLEEPREQ

- AUTH

«#box()<MQTT-SN-4.9-1>If a Client or Server receives an MQTT-SN request
(from the above list) and there is already a request outstanding from
the other party within the same Virtual Connection and a different
Packet Identifier, then it MUST issue a DISCONNECT with Reason Code 147
(Receive Maximum Exceeded) and delete the Virtual
Connection»#link(<tab-MQTT-SN-4.9-1>)[MQTT‑SN‑4.9‑1].

«#box()<MQTT-SN-4.9-2>A Server or Client MUST NOT send a new Packet of a
type from the above list, when it has an acknowledgement outstanding for
another Packet for which it has not received an
acknowledgement»#link(<tab-MQTT-SN-4.9-2>)[MQTT‑SN‑4.9‑2].

A sender MAY retry a request (send the same Packet) when it is expecting
an acknowledgement and none has been received. See
#link(<packet-delivery-retry>)[4.4 "Packet delivery retry"] for more
information on Packet retries.

#quote(block: true)[
#strong[Informative comment]

The sender might choose to suspend the sending of QoS 0 PUBLISH packets
when it suspends the sending of QoS 1 and QoS 2 PUBLISH packets because
a request is outstanding.

#strong[Informative Comment]

It is possible to publish PUBWOS packets in the middle of a QoS 1 or QoS
2 exchange.
]

Refer to #link(<publish-actions>)[3.6.2.7 "PUBLISH Actions"] for a
description of how Clients and Servers react if they are sent more than
one unacknowledged packet.

== Server redirection
<server-redirection>
A Server can request that the Client uses another Server by sending a
CONNACK or DISCONNECT packet with Reason Codes 0x9C (Use another
server), or 0x9D (Server moved) as described in
#link(<handling-errors>)[4.12 "Handling errors"].

The Reason Code 0x9C (Use another server) specifies that the Client
SHOULD temporarily switch to using another Server. The other Server is
already known to the Client.

The Reason Code 0x9D (Server moved) specifies that the Client SHOULD
permanently switch to using another Server. The other Server is already
known to the Client.

== Authentication
<authentication>
The MQTT-SN CONNECT and AUTH packets contain Authentication Method and
Data fields for use in authentication.

Authentication in MQTT-SN is equivalent to Enhanced Authentication in
MQTT 5.0. For an implementation of MQTT 3.1.1 Authentication or MQTT 5.0
Basic Authentication (User Name and Password), refer to
#link(<mqtt-user-name-and-password-support>)[4.11.1.2 "MQTT User Name and Password Support"].

Alternatively, the Underlying Network may support authentication
technology, such as DTLS in the case that the Underlying Network is UDP.

=== CONNECT and AUTH packets
<connect-and-auth-packets>
The authentication information in MQTT-SN CONNECT and AUTH packets
allows a range of options from username and password to challenge /
response style authentication. It might involve the exchange of AUTH
packets between the Client and the Server after the CONNECT and before
the CONNACK packets.

To begin authentication, the Client sets the AUTH flag in the CONNECT
packet and includes an Authentication Method and optionally Data,
depending on the Authentication Method, used in the CONNECT packet. This
specifies the authentication method to use and its parameters.
«#box()<MQTT-SN-4.11.1-1>If the Server does not support the
Authentication Method supplied by the Client, it MAY send a CONNACK with
a Reason Code of 0x8C (Bad authentication method) or 0x87 (Not
Authorized) as described in #link(<reason-code>)[2.3 "Reason Code"] and
MUST delete the Virtual
Connection»#link(<tab-MQTT-SN-4.11.1-1>)[MQTT‑SN‑4.11.1‑1].

The Authentication Method is an agreement between the Client and Server
about the meaning of the data sent in the Authentication Data and
optionally the Client Identifier, and the exchanges and processing
needed by the Client and Server to complete the authentication.

#quote(block: true)[
#strong[Informative comment]

The Authentication Method is commonly a
#link("https://datatracker.ietf.org/doc/html/rfc4422")[\[SASL\]]
mechanism, and using such a registered name aids interchange. However,
the Authentication Method is not constrained to using registered SASL
mechanisms.
]

If the Authentication Method selected by the Client specifies that the
Client sends data first, the Client SHOULD include the Authentication
Data in the CONNECT packet. The contents of the Authentication Data are
defined by the authentication method.

«#box()<MQTT-SN-4.11.1-2>If the Server requires additional information
to complete the authentication, it can send an AUTH packet to the
Client. This packet MUST contain a Reason Code of 0x18 (Continue
authentication)»#link(<tab-MQTT-SN-4.11.1-2>)[MQTT‑SN‑4.11.1‑2]. If the
authentication method requires the Server to send authentication data to
the Client, it is sent in the Authentication Data field of the AUTH
packet.

«#box()<MQTT-SN-4.11.1-3>The Client responds to an AUTH packet from the
Server by sending a further AUTH packet. This packet MUST contain a
Reason Code of 0x18 (Continue
authentication)»#link(<tab-MQTT-SN-4.11.1-3>)[MQTT‑SN‑4.11.1‑3]. If the
authentication method requires the Client to send authentication data
for the Server, it is sent in the Authentication Data field of the AUTH
packet.

The Client and Server exchange AUTH packets as needed until the Server
accepts the authentication by sending a CONNACK with a Reason Code of
0x00. If the acceptance of the authentication requires data to be sent
to the Client, it is sent in the Authentication Data field of the
CONNACK packet.

The Client can terminate the Virtual Connection at any point in this
process by sending a DISCONNECT packet. «#box()<MQTT-SN-4.11.1-4>The
Server can reject the authentication at any point in this process. It
MUST send a CONNACK with a Reason Code of 0x80 or above as described in
#link(<handling-errors>)[4.12 "Handling errors"]»#link(<tab-MQTT-SN-4.11.1-4>)[MQTT‑SN‑4.11.1‑4].

«#box()<MQTT-SN-4.11.1-5>If the initial CONNECT packet included an
Authentication Method then all AUTH packets, and any successful CONNACK
packet MUST include an Authentication Method with the same value as in
the CONNECT packet»#link(<tab-MQTT-SN-4.11.1-5>)[MQTT‑SN‑4.11.1‑5].

«#box()<MQTT-SN-4.11.1-6>If the Client does not include an
Authentication Method in the CONNECT, the Server MUST NOT send an AUTH
packet, and it MUST NOT send an Authentication Method in the CONNACK
packet»#link(<tab-MQTT-SN-4.11.1-6>)[MQTT‑SN‑4.11.1‑6].

«#box()<MQTT-SN-4.11.1-7>If the Client does not include an
Authentication Method in the CONNECT, the Client MUST NOT send an AUTH
packet to the Server»#link(<tab-MQTT-SN-4.11.1-7>)[MQTT‑SN‑4.11.1‑7].

If the Client does not include an Authentication Method in the CONNECT
packet, the Server SHOULD authenticate using some or all of the
information in the CONNECT packet in conjunction with the underlying
transport layer or alternatively use the Protection Encapsulation.

#quote(block: true)[
#strong[Informative example showing a SCRAM challenge]

- Client to Server: CONNECT Authentication Method=\"SCRAM-SHA-1\"
  Authentication Data=client-first-data

- Server to Client: AUTH rc=0x18 Authentication Method=\"SCRAM-SHA-1\"
  Authentication Data=server-first-data

- Client to Server AUTH rc=0x18 Authentication Method=\"SCRAM-SHA-1\"
  Authentication Data=client-final-data

- Server to Client CONNACK rc=0 Authentication Method=\"SCRAM-SHA-1\"
  Authentication Data=server-final-data
]

#quote(block: true)[
#strong[Informative example showing a Kerberos challenge]

- Client to Server CONNECT Authentication Method=\"GS2-KRB5\"

- Server to Client AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"

- Client to Server AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"
  Authentication Data=initial context token

- Server to Client AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"
  Authentication Data=reply context token

- Client to Server AUTH rc=0x18 Authentication Method=\"GS2-KRB5\"

- Server to Client CONNACK rc=0 Authentication Method=\"GS2-KRB5\"
  Authentication Data=outcome of authentication
]

==== Re-authentication
<re-authentication>
«#box()<MQTT-SN-4.11.1.1-1>If the Client supplied an Authentication
Method in the CONNECT packet, it can initiate a re-authentication at any
time after receiving a CONNACK. It does this by sending an AUTH packet
with a Reason Code of 0x19 (Re-authentication). The Client MUST set the
Authentication Method to the same value as the Authentication Method
originally used to authenticate the Virtual
Connection»#link(<tab-MQTT-SN-4.11.1.1-1>)[MQTT‑SN‑4.11.1.1‑1]. If the
authentication method requires Client data first, this AUTH packet
contains the first piece of authentication data in the Authentication
Data field.

The Server responds to this re-authentication request by sending an AUTH
packet to the Client with a Reason Code of 0x00 (Success) to indicate
that the re-authentication is complete, or a Reason Code of 0x18
(Continue authentication) to indicate that more authentication data is
needed. The Client can respond with additional authentication data by
sending an AUTH packet with a Reason Code of 0x18 (Continue
authentication). This flow continues as with the original authentication
until the re-authentication is complete or the re-authentication fails.

«#box()<MQTT-SN-4.11.1.1-2>If the re-authentication fails, the Client or
Server MUST send DISCONNECT with an appropriate Reason Code as described
in #link(<handling-errors>)[4.12 "Handling errors"], and MUST delete the
Virtual Connection»#link(<tab-MQTT-SN-4.11.1.1-2>)[MQTT‑SN‑4.11.1.1‑2].

During this re-authentication sequence, the flow of other packets
between the Client and Server is paused, pending the new authentication
outcome.

#quote(block: true)[
#strong[Informative comment]

The Server might limit the scope of the changes the Client can attempt
in a re-authentication by rejecting the re-authentication. For instance,
if the Server does not allow the User Name to be changed it can fail any
re-authentication attempt which changes the User Name.
]

==== MQTT User Name and Password Support
<mqtt-user-name-and-password-support>
To support the equivalent of the MQTT User Name and Password fields in
the CONNECT packet, do the following:

- Set the #link(<authentication-method>)[3.1.15 "Authentication Method"]
  field to MQTT-BASIC.

- Set the #link(<authentication-data>)[3.1.17 "Authentication Data"]
  field to to:

+ MQTT User Name: a Two Byte Integer length followed by a UTF-8 Encoded
  String as defined in
  #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"].

+ MQTT Password: a Two Byte Integer length followed by binary data.

The User Name string and Password binary data must have the same length
as the values in their corresponding preceding length fields.

This is a one-way transfer of information - the response MUST be a
CONNACK, not an AUTH packet.

#quote(block: true)[
#strong[Informative comment]

The length field in front of the password is not strictly necessary as
the Authentication Data field length is known, but including it makes
the transfer to and from the MQTT Connect packet simpler.
]

#figure(image("images/image20.png", alt: "CONNECT with MQTT User Name and Password, informative example"),
  caption: [
    CONNECT with MQTT User Name and Password, informative example
  ]
)
<fig-connect-with-mqtt-user-name-and-password-informative-example>

To support the equivalent of the MQTT User Name and Password together
with MQTT Enhanced Authentication, in the CONNECT packet do the
following:

- Set the #link(<authentication-method>)[3.1.15 "Authentication Method"]
  field to MQTT-ENHANCED.

- Set the #link(<authentication-data>)[3.1.17 "Authentication Data"]
  field to:

  #block[
  #set enum(numbering: "a.", start: 1)
  + MQTT User Name: a Two Byte Integer length followed by a UTF-8
    Encoded String as defined in
    #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"].

  + MQTT Password: a Two Byte Integer length followed by binary data.

  + MQTT Authentication Method: a Two Byte Integer length followed by a
    UTF-8 Encoded String as defined in
    #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"] .

  + MQTT Authentication Data: a Two Byte Integer length followed by
    binary data.
  ]

In any subsequent AUTH and CONNACK packets of the authentication
exchange:

+ The MQTT User Name and MQTT Password fields MUST not be included.

+ The Authentication Method MUST remain MQTT-ENHANCED throughout.

== Handling errors
<handling-errors>
=== Malformed Packet and Protocol Errors
<malformed-packet-and-protocol-errors>
Definitions of Malformed Packet and Protocol Errors are contained in
#link(<terminology>)[1.4 "Terminology"], some but not all of these error
cases are noted throughout the specification. The rigor with which a
Client or Server checks an MQTT-SN Control Packet it has received will
be a compromise between:

- The size of the Client or Server implementation.

- The capabilities that the implementation supports.

- The degree to which the receiver trusts the sender to send correct
  Control Packets.

- The degree to which the receiver trusts the network to deliver Control
  Packets correctly.

- The consequences of continuing to process a packet that is incorrect.

If the sender is compliant with this specification it will not send
Malformed Packets or cause Protocol Errors. The Reason Codes used for
Malformed Packet and Protocol Errors include:

- 0x81 Malformed Packet

- 0x82 Protocol Error

- 0x93 Receive Maximum exceeded

- 0x95 Packet too large

«#box()<MQTT-SN-4.12.1-1>When a Client detects a Malformed Packet or
Protocol Error associated with a Virtual Connection it SHOULD send a
DISCONNECT packet containing an appropriate Reason Code and MUST delete
the associated Virtual
Connection»#link(<tab-MQTT-SN-4.12.1-1>)[MQTT-SN-4.12.1-1]. Use Reason
Code 0x81 (Malformed Packet) or 0x82 (Protocol Error) unless a more
specific Reason Code has been defined in
#link(<reason-code>)[2.3 "Reason Code"].

«#box()<MQTT-SN-4.12.1-2>When a Server detects a Malformed Packet or
Protocol Error for any packet except ADVERTISE, SEARCHGW, GWINFO, PUBWOS
and CONNECT, the Server MAY send a DISCONNECT packet with an appropriate
Reason Code and MUST delete the associated Virtual Connection if one
exists»#link(<tab-MQTT-SN-4.12.1-2>)[MQTT-SN-4.12.1-2]. In the case of
an error in a CONNECT packet it MAY send a CONNACK packet containing the
Reason Code. Use Reason Code 0x81 (Malformed Packet) or 0x82 (Protocol
Error) unless a more specific Reason Code has been defined in
#link(<reason-code>)[2.3 "Reason Code"]. There are no consequences for
other Sessions.

If either the Server or Client omits to check some feature of a Control
Packet, it might fail to detect an error, consequently it might allow
data to be damaged.

=== Other errors
<other-errors>
Errors other than Malformed Packet and Protocol Errors cannot be
anticipated by the sender because the receiver might have constraints
which it has not communicated to the sender. A receiving Client or
Server might encounter a transient error, such as a shortage of memory,
that prevents successful processing of an individual Control Packet.

Acknowledgment packets PUBACK, PUBREC, PUBREL, PUBCOMP, REGACK, SUBACK,
UNSUBACK with a Reason Code of 0x80 or greater indicate that the
received packet, identified by a Packet Identifier, was in error. There
are no consequences for other Sessions or other Packets flowing on the
same Session.

«#box()<MQTT-SN-4.12.2-1>The CONNACK and DISCONNECT packets allow a
Reason Code of 0x80 or greater to indicate that the Virtual Connection
will be deleted. If a Reason Code of 0x80 or greater is specified, then
the Virtual Connection MUST be deleted whether or not the CONNACK or
DISCONNECT is sent»#link(<tab-MQTT-SN-4.12.2-1>)[MQTT-SN-4.12.2-1].
Sending one of these Reason Codes has no consequences for any other
Session.

If the Control Packet contains multiple errors the receiver of the
Packet can validate the Packet in any order and take the appropriate
action for any of the errors found.

Refer to
#link(<handling-of-disallowed-unicode-code-points>)[5.4.9 "Handling of Disallowed Unicode code points"]
for information about handling Disallowed Unicode code points.

== Retained Messages
<retained-messages>
«#box()<MQTT-SN-4.13-1>If the RETAIN flag is set to 1 in a PUBLISH or
PUBWOS packet received by a Server, the Server MUST replace any existing
Retained Message for this topic and store the Application
Message»#link(<tab-MQTT-SN-4.13-1>)[MQTT‑SN‑4.13‑1], so that it can be
delivered to future subscribers whose subscriptions match its Topic
Name.

«#box()<MQTT-SN-4.13-2>If the Publish Data contains zero bytes it is
processed normally by the Server but any retained message with the same
topic name MUST be removed and any future subscribers for the topic will
not receive a retained
message»#link(<tab-MQTT-SN-4.13-2>)[MQTT‑SN‑4.13‑2].

«#box()<MQTT-SN-4.13-3>A Retained Message with a Publish Data containing
zero bytes MUST NOT be stored as a Retained Message on the
Server»#link(<tab-MQTT-SN-4.13-3>)[MQTT‑SN‑4.13‑3].

«#box()<MQTT-SN-4.13-4>If the RETAIN flag is 0 in a PUBLISH packet sent
by a Client to a Server, the Server MUST NOT store the message as a
Retained Message and MUST NOT remove or replace any existing Retained
Message»#link(<tab-MQTT-SN-4.13-4>)[MQTT‑SN‑4.13‑4].

When a new Subscription is made, the last retained message, if any, on
each matching topic name is sent to the Client as directed by the Retain
Handling Subscribe Flag. These messages are sent with the RETAIN flag
set to 1. Which retained messages are sent is controlled by the Retain
Handling Subscribe Flag. At the time of the Subscription:

- «#box()<MQTT-SN-4.13-5>If Retain Handling is set to 0 the Server MUST
  send the retained messages matching the Topic Filter of the
  subscription to the
  Client»#link(<tab-MQTT-SN-4.13-5>)[MQTT‑SN‑4.13‑5].

- «#box()<MQTT-SN-4.13-6>If Retain Handling is set to 1 then if the
  subscription did not already exist, the Server MUST send all retained
  messages matching the Topic Filter of the subscription to the Client,
  and if the subscription did exist the Server MUST NOT send the
  retained messages.»#link(<tab-MQTT-SN-4.13-6>)[MQTT‑SN‑4.13‑6].

- «#box()<MQTT-SN-4.13-7>If Retain Handling is set to 2, the Server MUST
  NOT send the retained
  messages»#link(<tab-MQTT-SN-4.13-7>)[MQTT‑SN‑4.13‑7].

Refer to #link(<subscribe-flags>)[3.7.2 "SUBSCRIBE Flags"] for a
definition of the Subscription Flags.

If the Server receives a PUBLISH packet with the RETAIN flag set to 1,
and QoS 0 it SHOULD store the new QoS 0 message as the new retained
message for that topic, but MAY choose to discard it at any time. If
this happens there will be no retained message for that topic.

The setting of the RETAIN flag in an Application Message forwarded by
the Server from an established Virtual Connection is controlled by the
Retain As Published subscription option. Refer to
#link(<subscribe-flags>)[3.7.2 "SUBSCRIBE Flags"] for a definition of
the Subscription Flags.

- «#box()<MQTT-SN-4.13-8>If the value of Retain As Published
  subscription option is set to 0, the Server MUST set the RETAIN flag
  to 0 when forwarding an Application Message regardless of how the
  RETAIN flag was set in the received PUBLISH
  packet»#link(<tab-MQTT-SN-4.13-8>)[MQTT‑SN‑4.13‑8].

- «#box()<MQTT-SN-4.13-9>If the value of Retain As Published
  subscription option is set to 1, the Server MUST set the RETAIN flag
  equal to the RETAIN flag in the received PUBLISH
  packet»#link(<tab-MQTT-SN-4.13-9>)[MQTT‑SN‑4.13‑9].

#quote(block: true)[
#strong[Informative comment]

Retained messages are useful where publishers send state messages on an
irregular basis. A new subscriber will receive the most recent state.

#strong[Informative comment]

As in MQTT 3.1.1 there is no notion of message expiry in MQTT-SN,
including expiry of Retained Messages. It is an administrative decision
under what conditions to remove Retained Messages, if at all. They
should be kept long enough to support the expectations of the
applications that will use the Server, at a minimum.
]

== Client states
<client-states>
At any time, a Client will be in one of the following states from the
perspective of the Server:

#figure(
  align(center)[#table(
    columns: (2.73%, 89.07%, 8.19%),
    align: (left,left,left,),
    table.header([State], [State Description], [Possible Transitions],),
    table.hline(),
    [#strong[None]], [The Client is unknown to the Server. There is no
    Session State nor Virtual Connection.A Client may transition from
    here to #strong[Active] with a CONNECT.], [#strong[Active]],
    [#strong[Disconnected]], [The Client is considered offline and not
    able to receive packets until it has re-established a session with
    the Server by way of a CONNECT. The Server has Session state for
    this Client, but there is no Virtual Connection. A Client may
    transition from here to #strong[Active] with a CONNECT, or to
    #strong[None] on Session expiry.], [#strong[Active]#strong[None]],
    [#strong[Active]], [The Client is actively engaged in the Session. A
    Virtual Connection exists. It should be able to send and receive
    packets. Its state is supervised by the Server with the associated
    Keep Alive timer. A Client may transition from here to
    #strong[Asleep] by way of a SLEEPREQ or #strong[Disconnected] by way
    of a DISCONNECT, Keep Alive timeout or Retry
    timeout.], [#strong[Asleep]#strong[Disconnected]],
    [#strong[Asleep]], [The Client has Session State, and a Virtual
    Connection. The Client cannot receive Packets (except possibly the
    WAKEUP hint); it can send Packets. The Server should not expect a
    response from the client in this state. A Client may transition from
    here to #strong[Awake] (by way of PINGREQ), #strong[Active] by way
    of CONNECT, #strong[Disconnected] (by way of DISCONNECT, Sleep
    timeout or Retry timeout). The Server may send a WAKEUP packet to
    the Client, as an indication that messages are waiting - it is up to
    the Client to act, if it is even able to notice
    it.], [#strong[Awake]#strong[Active]#strong[Disconnected]],
    [#strong[Awake]], [The Client is partially engaged in an ongoing
    session and a Virtual Connection exists. The Client transitions back
    to the #strong[Asleep] state on receipt of a PINGRESP packet or
    #strong[Disconnected] (by way of DISCONNECT, or on Retry timeout for
    the possible PINGRESP, PUBACK, PUBREL, PUBREC, PUBCOMP or REGACK
    packets to be received by the Client). The Client may also move to
    the #strong[Active] state by way of
    CONNECT.], [#strong[Asleep]#strong[Active]#strong[Disconnected]],
  )]
  , caption: [Client States]
  , kind: table
  )
<tab-client-states>

#quote(block: true)[
#strong[Informative Comment]

A Server cannot send any Packet other than PUBWOS to a Client in None or
Disconnected states because it will not have a Virtual Connection.
]

«#box()<MQTT-SN-4.14-1>A Server MUST treat any Packet other than PUBWOS
or CONNECT that it receives from a Client in None or Disconnected states
as a protocol error»#link(<tab-MQTT-SN-4.14-1>)[MQTT‑SN‑4.14‑1].

«#box()<MQTT-SN-4.14-2>In the Asleep state, a Client MUST only send
PINGREQ, CONNECT or DISCONNECT packets to the
Server»#link(<tab-MQTT-SN-4.14-2>)[MQTT‑SN‑4.14‑2].

«#box()<MQTT-SN-4.14-3>In the Awake state, a Client MUST not send ANY
packets other than those involved in the receipt of PUBLISH packets
(PUBACK, PUBREC, PUBCOMP, REGACK) or CONNECT or
DISCONNECT»#link(<tab-MQTT-SN-4.14-3>)[MQTT‑SN‑4.14‑3].

«#box()<MQTT-SN-4.14-4>Whenever a CONNECT is received by a Server, any
existing Virtual Connection for that Client MUST be deleted and a new
one created with all CONNECT Packet processing, regardless of the state
of the Client»#link(<tab-MQTT-SN-4.14-4>)[MQTT‑SN‑4.14‑4].

Transition through these states is governed by a sequence of packets
between Client and Server and mediated by
#link(<session-timers>)[4.14.1 "Session Timers"] resident on the Server.
A Client is in the Active state when the Server receives a CONNECT
packet from that Client. This state is supervised by the Server with the
#link(<keep-alive>)[3.1.6 "Keep Alive"] timer. If the Server does not
receive any packet from the Client in a defined period, the Server will
consider that client as Disconnected and delete the Virtual Connection.
The Disconnected state is governed by the Session Expiry timer - on
expiry the Server is free to remove the Client session. A Client moves
into the Asleep state by issuing a SLEEPREQ packet. To be certain that
the Server has also recorded the Client as being asleep, the Client
needs to wait for a positive SLEEPRESP response. For more information on
the Asleep state, refer to
#link(<sleeping-clients>)[4.14.2 "Sleeping Clients"].

See #link(<c.5-client-state-diagrams>)[C.5 "Client State Diagrams"] for
informative state diagrams to help illustrate these transitions.

#quote(block: true)[
#strong[Informative Comment]

In MQTT-SN 1.2 there existed a Lost state, which was identical to the
Disconnected state, except that it was reached by a timer expiry on the
Server rather than an explicit Disconnect request from the Client. As
the Lost state was not really different from Disconnected except for the
history of Client events, similar information may be kept by the Server,
in for instance its administrative logs.
]

=== Session Timers
<session-timers>
The following timers are used by Servers, on a per Client basis, to
handle Client states, and by Clients to direct their actions. In
general, Clients are able to infer the Server's view of their state by
observing the Server's response.

#figure(
  align(center)[#table(
    columns: (11.94%, 17.16%, 11.19%, 16.42%, 43.28%),
    align: (left,left,left,left,left,),
    table.header([Timer Name], [State(s)], [Timeout State], [Defined
      in], [Information],),
    table.hline(),
    [Keep
    Alive], [Active], [Disconnected], [CONNECT], [#link(<keep-alive>)[3.1.6 "Keep Alive"]],
    [Sleep
    Duration], [Asleep], [Disconnected], [SLEEPREQ], [#link(<sleeping-clients>)[4.14.2 "Sleeping Clients"]],
    [Session Expiry], [Disconnected], [None], [CONNECT,
    DISCONNECT], [#link(<storing-session-state>)[4.1.1 "Storing Session State"]],
    [Retry], [Active, Awake, Asleep], [Disconnected], [Sender
    configuration], [#link(<packet-delivery-retry>)[4.4 "Packet delivery retry"]],
  )]
  , caption: [Session Timers]
  , kind: table
  )
<tab-session-timers>

For example values of these timers, see
#link(<c.3-example-timer-and-counter-values>)[C.3 "Example Timer and Counter Values"].

=== Sleeping Clients
<sleeping-clients>
The Asleep state is intended to allow Clients, which may be running on
battery powered devices, to save as much energy as possible. These
Clients enter a low-power mode when they are not active, and will wake
when they have data to send or receive. The Server needs to be aware of
the sleeping state of these Clients and buffer messages destined for
them, so that they may be delivered when the Clients wake up.

To go to sleep, a Client sends a SLEEPREQ packet containing a Sleep
Duration in seconds. The Server acknowledges that packet with a
SLEEPRESP Packet including a successful Reason Code, and considers the
Client to be Asleep.

«#box()<MQTT-SN-4.14.2-1>If the Server does not receive an MQTT-SN
Control Packet from an Asleep Client within the Sleep Duration plus a
suitable grace period, it MUST delete the Virtual Connection to the
Client»#link(<tab-MQTT-SN-4.14.2-1>)[MQTT‑SN‑4.14.2‑1]. The Client will
then be considered to be Disconnected.

#quote(block: true)[
#strong[Informative Comment]

The Server can decide when to disconnect a sleeping Client it has not
heard from. If packet loss can occur, allowing 1.5 times the Sleep
Duration before disconnecting the Client, similar to the Keep Alive
processing, in many cases might be too short. Waiting 2.5 times the
Sleep Duration before disconnecting the Client will allow one missed
waking period, for example.

To balance reaction speed with reliability, the tolerance of the sleep
timer at the Server could depend on length of the Sleep Duration
indicated by the Client. For example, the grace period could be 1.5
times the Sleep Duration for periods greater than 1 minute, and 2.5
times if the Sleep Duration is less than a minute.
]

«#box()<MQTT-SN-4.14.2-2>During the Asleep state, packets that need to
be sent to the client are buffered at the Server. The Server MUST buffer
Application Messages of QoS 1 and
2»#link(<tab-MQTT-SN-4.14.2-2>)[MQTT‑SN‑4.14.2‑2].

#quote(block: true)[
#strong[Informative Comment]

The Server may #emph[choose] to buffer messages of QoS 0 while the
Client is in the Asleep state.
]

The Client wakes by sending a PINGREQ. If the Server has buffered
packets for the Client, it will send them to the Client, acknowledging
the Maximum Number of Awake Messages sent in the CONNECT packet.
«#box()<MQTT-SN-4.14.2-3>If the Maximum Number of Awake Messages (N) set
by the client is greater than 0, the server MUST NOT send more than N
application messages in any one awake period for that
client.»#link(<tab-MQTT-SN-4.14.2-3>)[MQTT‑SN‑4.14.2‑3].

«#box()<MQTT-SN-4.14.2-4>After sending the Maximum Number of Awake
Messages Application Messages, the Server cuts short the AWAKE cycle,
and MUST respond with a PINGRESP with a messages-left value of either
the number of Application Messages remaining in the Server buffer or
0xFF (meaning undetermined number of Application Messages greater than 0
remaining)»#link(<tab-MQTT-SN-4.14.2-4>)[MQTT‑SN‑4.14.2‑4].

«#box()<MQTT-SN-4.14.2-5>During the Awake state, for each Application
Message the Server sends to the Client, the application messages'
quality of service MUST be honored - a full packet interaction MUST take
place including all normative phases of acknowledgement, including any
associated retransmission
logic»#link(<tab-MQTT-SN-4.14.2-5>)[MQTT‑SN‑4.14.2‑5].

«#box()<MQTT-SN-4.14.2-6>If, during the delivery of Application Messages
from the Server to the Client, and applying the retry logic of
#link(<unacknowledged-packets>)[4.4.2 "Unacknowledged Packets"], the
Server gets no response, it MUST consider the Client disconnected and
delete the Virtual
Connection»#link(<tab-MQTT-SN-4.14.2-6>)[MQTT‑SN‑4.14.2‑6]. It may send
a DISCONNECT packet with an appropriate Reason Code.

The transfer of packets to the Client is closed by the Server by means
of a PINGRESP packet. That is, the Server will consider the Client as
Asleep and restart the Sleep Duration timer after having sent the
PINGRESP packet. «#box()<MQTT-SN-4.14.2-7>If the Server does not have
any packets buffered for the client, it MUST respond immediately with a
PINGRESP packet»#link(<tab-MQTT-SN-4.14.2-7>)[MQTT‑SN‑4.14.2‑7],
returning the Client back to the Asleep state, and restarting the Sleep
Duration timer for that Client.

After having sent the PINGREQ to the Server, the Client uses the
retransmission procedure of
#link(<packet-delivery-retry>)[4.4 "Packet delivery retry"] to supervise
the arrival of packets sent by the Server. To avoid draining its battery
due to excessive retransmission of the PINGREQ packet, the Client should
limit the retransmission with a Maximum Retry Count, and go back to
sleep when the limit is reached.

At some point after several Awake periods without any response from the
Server, a Client might decide that it needs to try to connect to a
different Server. The Client might send a DISCONNECT Packet to try to
notify the original Server, or just delete its Virtual Connection.

From the #emph[Asleep] state, a client can move to the #emph[Active]
state by sending a CONNECT packet or to the #emph[Disconnected] state by
sending a DISCONNECT packet. The Client can also modify its sleep
configuration by sending a SLEEPREQ Packet with a new value of Sleep
Duration.

Note that a sleeping Client should go to the #emph[Awake] state only if
it wants to check whether the Server has any Application Messages
buffered for it and return as soon as possible to the #emph[Asleep]
state without sending any packets to the Server (other than PUBACK,
PUBREC, PUBCOMP or REGACK). If it wants to do more than this, it needs
to create a new Virtual Connection by sending a CONNECT packet to the
Server.

Session Topic Aliases last for the duration of a Session which exists
throughout the sleep cycle. However, if the Client wants to save storage
by removing the Session Topic Aliases while Asleep, it can set the
Retain Topic Aliases flag on the SLEEPREQ packet to 0. The disadvantage
being that during the Awake state, Session Topic Aliases will have to be
recreated, or Topic Names used instead, increasing network data usage.

#figure(image("images/image2.png", alt: "Awake PINGRESP Packet flush"),
  caption: [
    Awake PINGRESP Packet flush
  ]
)
<fig-awake-pingresp-packet-flush>

== Optional Features
<optional-features>
Support for the ADVERTISE, SEARCHGW, GWINFO and PUBWOS packet types is
optional.

The Forwarder Encapsulation packet type support is optional. For
instance, it is not required if the MQTT-SN Clients are able to directly
reach an MQTT-SN Server.

The Protection Encapsulation packet type support is optional. For
instance, it is not required if the MQTT-SN Server and the MQTT-SN
Clients interact over a secure communication channel, such as DTLS, or
any communication channel assuring the authenticity and optionally the
confidentiality of MQTT-SN data.

#pagebreak(weak: true)
= Security (Informative)
<security-informative>
== Introduction
<si---introduction>
MQTT-SN is a transport protocol specification for message transmission,
allowing implementers a choice of network, privacy, authentication and
authorization technologies. Since the exact security technologies chosen
will be context specific, it is the implementer\'s responsibility to
include the appropriate features as part of their design.

MQTT-SN solutions are likely to also include MQTT communications - this
section should be read alongside the Security chapters in the MQTT
standards:
#link("https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html")[\[MQTT 3.1.1\]]
and
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html")[\[MQTT 5.0\]].

MQTT-SN implementations will likely need to keep pace with an evolving
security landscape. This Chapter provides general implementation
guidance so as not to restrict choices available. Examples of threats
that solution providers should consider are:

- Devices could be compromised

- Data at rest in Clients and Servers might be accessible

- Protocol behaviors could have side effects - "timing attacks" for
  example

- Denial of Service (DoS) attacks

- Communications could be intercepted, altered, re-routed or disclosed

- Injection of spoofed MQTT-SN Control Packets

When MQTT-SN solutions are deployed in hostile communication
environments, implementations will often need to provide mechanisms for:

- Authentication of users and devices

- Authorization of access to Server resources

- Integrity of MQTT-SN Control Packets and application data contained
  therein

- Privacy of MQTT-SN Control Packets and application data contained
  therein

In addition to technical security issues there could also be geographic
(for example U.S.-EU Privacy Shield Framework
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#USEUPRIVSH")[\[\[USEUPRIVSH\]\]]),
industry specific (for example PCI DSS
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#PCIDSS")[\[\[PCIDSS\]\]])
and regulatory considerations (for example Sarbanes-Oxley
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#SARBANES")[\[\[SARBANES\]\]]).

== MQTT-SN solutions: security and certification
<mqtt-sn-solutions-security-and-certification>
An implementation might want to provide conformance with specific
industry security standards such as NIST Cyber Security Framework
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#NISTCSF")[\[\[NISTCSF\]\]],
PCI-DSS
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#PCIDSS")[\[\[PCIDSS\]\]]),
FIPS-140-3
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#FIPS1402")[\[\[FIPS1403\]\]]
and Commercial National Security Algorithm Suite (CNSA) 2.0
#link("https://media.defense.gov/2022/Sep/07/2003071834/-1/-1/0/CSA_CNSA_2.0_ALGORITHMS_.PDF")[\[\[CNSA20\]\]].
The use of industry proven, independently verified and certified
technologies will help meet compliance requirements.

== Lightweight cryptography and constrained devices
<lightweight-cryptography-and-constrained-devices>
MQTT-SN is targeted at the most power saving and constrained devices. In
contrast to MQTT where there is principally one underlying network
technology - TCP/IP - MQTT-SN is intended to be agnostic to the
underlying network as long as it conforms to the requirements outlined
in
#link(<networks-and-virtual-connections>)[4.2 "Networks and Virtual Connections"].

Previous versions of MQTT-SN did not include specific security and
integrity features, preferring to leave that to the underlying network.
That approach is still supported, but to aid interoperability the
Protection Encapsulation is introduced, in
#link(<protection-encapsulation>)[3.17 "Protection Encapsulation"]. In
order to disassociate the security model from the rest of the MQTT-SN
specification, the Protection Encapsulation allows all the packet types,
including CONNECT, to be wrapped in a security envelope. Furthermore the
security material is self-contained in each Protection Encapsulation
envelope, so it is completely decoupled from the Virtual Connection.

The schemes defined by the Protection Encapsulation are especially
suited for implementation by constrained devices:

- HMAC and AES CMAC are widely adopted authentication only standard
  schemes.

- The Advanced Encryption Standard
  #link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#AES")[\[\[AES\]\]]
  is the most widely adopted encryption algorithm. There is hardware
  support for AES in many processors, but not commonly for embedded
  processors.

- The encryption algorithm ChaCha20
  \[#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#CHACHA20")[\[CHACHA20\]]\]
  encrypts and decrypts much faster in software, but is not as widely
  available as AES.

The Protection Encapsulation approach is informed by the OSCORE \[RFC
8613\] standard and CBOR Initial Algorithms \[RFC 9053\] informational
document. The ISO 29192
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#ISO29192")[\[\[ISO29192\]\]]
standard makes recommendations for cryptographic primitives specifically
tuned to perform on constrained, low end, devices.

The MQTT-SN Protection Encapsulation also allows for user defined
protection schemes, although these will of necessity have lower
interoperability compared to the built-in schemes, as implementations of
both Client and Server will have to be aware of them.

== Implementation notes
<implementation-notes>
When the underlying network layer for MQTT-SN is UDP, DTLS \[RFC9147\]
can be used to secure MQTT-SN communications instead of or in
conjunction with the Protection Encapsulation. It is recommended that
Server implementations that offer DTLS use UDP port 8883 (IANA service
name: secure-mqtt).

For other underlying network technologies, a security solution
particular to that technology must be found, which could involve using
the MQTT-SN
#link(<protection-encapsulation>)[3.17 "Protection Encapsulation"]
and/or #link(<authentication>)[4.11 "Authentication"].

There are many security concerns to consider when implementing or using
MQTT-SN. The following section should not be considered a comprehensive
checklist.

An implementation might want to achieve some, or all, of the following:

=== Authentication of Clients by the Server
<authentication-of-clients-by-the-server>
The CONNECT packet contains an Authentication Data field which can
contain a user name and password if the Authentication Method is SASL
PLAIN (see
#link(<mqtt-user-name-and-password-support>)[4.11.1.2 "MQTT User Name and Password Support"]).
Implementations can choose how to make use of the content of these
fields. They may provide their own authentication mechanism, use an
external authentication system such as LDAP
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC4511")[\[\[RFC4511\]\]]
or OAuth
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6749")[\[\[RFC6749\]\]]
tokens, or leverage operating system authentication mechanisms.

MQTT-SN provides an Authentication mechanism as described in
#link(<authentication>)[4.11 "Authentication"]. Using this requires
support for it in both the Client and Server.

Implementations passing authentication data in clear text, obfuscating
such data elements or requiring no authentication data should be aware
this can give rise to Man-in-the-Middle and replay attacks.
#link(<privacy-of-application-messages-and-mqtt-sn-control-packets>)[5.4.5 "Privacy of Application Messages and MQTT-SN Control Packets"]
introduces approaches to ensure data privacy.

A Virtual Private Network (VPN) between the Clients and Servers can
provide confidence that data is only being received from authorized
Clients.

Where DTLS
#link("https://datatracker.ietf.org/doc/rfc9147/")[\[\[RFC9147\]\]] is
used, X.509 Certificates sent from the Client can be used by the Server
to authenticate the Client to achieve mutual authentication.

=== Authorization of Clients by the Server
<authorization-of-clients-by-the-server>
If a Client has been successfully authenticated, a Server implementation
should check that it is authorized before accepting its connection.

Authorization may be based on information provided by the Client such as
User Name, the hostname/network address of the Client, or the outcome of
authentication mechanisms.

In particular, the implementation should check that the Client is
authorized to use the Client Identifier as this gives access to the
MQTT-SN Session State (described in
#link(<session-state>)[4.1 "Session state"]). This authorization check
is to protect against the case where one Client, accidentally or
maliciously, provides a Client Identifier that is already being used by
some other Client.

An implementation should provide access controls that take place after
CONNECT to restrict the Client\'s ability to publish to particular
Topics or to subscribe using particular Topic Filters. An implementation
should consider limiting access to Topic Filters that have broad scope,
such as the \# Topic Filter.

=== Authentication of the Server by the Client
<authentication-of-the-server-by-the-client>
The MQTT-SN protocol is not trust symmetrical. When using basic Username
and Password authentication, there is no mechanism for the Client to
authenticate the Server. Some forms of authentication do allow for
mutual authentication.

Where DTLS is used, X.509 Certificates sent from the Server can be used
by the Client to authenticate the Server.

MQTT-SN provides an Authentication mechanism as described in
#link(<authentication>)[4.11 "Authentication"], which can be used to
authenticate the Server to the Client. Using this requires support for
it in both the Client and Server.

A VPN between Clients and Servers can provide confidence that Clients
are connecting to the intended Server.

=== Integrity of Application Messages and MQTT-SN Control Packets
<integrity-of-application-messages-and-mqtt-sn-control-packets>
Applications can independently include hash values in their Application
Messages. This can provide integrity of the contents of Publish packets
across the network and at rest.

DTLS and the Protection Encapsulation provide hash algorithms to verify
the integrity of data sent over the network.

The use of VPNs to connect Clients and Servers can provide integrity of
data across the section of the network covered by a VPN.

=== Privacy of Application Messages and MQTT-SN Control Packets
<privacy-of-application-messages-and-mqtt-sn-control-packets>
DTLS #link("https://datatracker.ietf.org/doc/rfc9147/")[\[\[RFC9147\]\]]
can provide encryption of data sent over the network. There are valid
DTLS cipher suites that include a NULL encryption algorithm that does
not encrypt data. To ensure privacy Clients and Servers should avoid
these cipher suites.

An application might independently encrypt the contents of its
Application Messages. This could provide privacy of the Application
Message both over the network and at rest. This would not provide
privacy for other Properties of the Application Message such as Topic
Name.

Client and Server implementations can provide encrypted storage for data
at rest such as Application Messages stored as part of a Session.

The use of VPNs to connect Clients and Servers can provide privacy of
data across the section of the network covered by a VPN.

=== Non-repudiation of message transmission
<non-repudiation-of-message-transmission>
Application designers might need to consider appropriate strategies to
achieve end to end non-repudiation.

=== Detecting compromise of Clients and Servers
<detecting-compromise-of-clients-and-servers>
Client and Server implementations using DTLS should provide capabilities
to ensure that any X.509 certificates provided when initiating a DTLS
session are associated with the hostname of the Client connecting or
Server being connected to.

Client and Server implementations using DTLS can choose to provide
capabilities to check Certificate Revocation Lists (CRLs
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC5280")[\[\[RFC5280\]\]])
and Online Certificate Status Protocol (OSCP)
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6960")[\[\[RFC6960\]\]]
to prevent revoked certificates from being used.

Physical deployments might combine tamper-proof hardware with the
transmission of specific data in Application Messages. For example, a
meter might have an embedded GPS to ensure it is not used in an
unauthorized location.
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#IEEE8021AR")[\[\[IEEE8021AR\]\]]
is a standard for implementing mechanisms to authenticate a device's
identity using a cryptographically bound identifier.

=== Detecting abnormal behaviors
<detecting-abnormal-behaviors>
Server implementations might monitor Client behavior to detect potential
security incidents. For example:

- Repeated connection attempts

- Repeated authentication attempts

- Abnormal termination of connections

- Topic scanning (attempts to send or subscribe to many topics)

- Sending undeliverable messages (no subscribers to the topics)

- Clients that connect but do not send data

Server implementations might delete the Virtual Connection of Clients
that breach its security rules.

Server implementations detecting unwelcome behavior might implement a
dynamic block list based on identifiers such as IP address or Client
Identifier.

Deployments might use network-level controls (where available) to
implement rate limiting or blocking based on IP address or other
information.

=== Handling of Disallowed Unicode code points
<handling-of-disallowed-unicode-code-points>
#link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"] describes
the Disallowed Unicode code points, which should not be included in a
UTF-8 Encoded String. A Client or Server implementation can choose
whether to validate that these code points are not used in UTF-8 Encoded
Strings such as the Topic Name or Properties.

If the Server does not validate the code points in a UTF-8 Encoded
String but a subscribing Client does, then a second Client might be able
to cause the subscribing Client to delete the Virtual Connection by
publishing on a Topic Name or using Properties that contain a Disallowed
Unicode code point. This section recommends some steps that can be taken
to prevent this problem.

A similar problem can occur when the Client validates that the payload
matches the Payload Format Indicator and the Server does not. The
considerations and remedies for this are similar to those for handling
Disallowed Unicode code points.

==== Considerations for the use of Disallowed Unicode code points
<considerations-for-the-use-of-disallowed-unicode-code-points>
An implementation would normally choose to validate UTF-8 Encoded
strings, checking that the Disallowed Unicode code points are not used.
This avoids implementation difficulties such as the use of libraries
that are sensitive to these code points, it also protects applications
from having to process them.

Validating that these code points are not used removes some security
exposures. There are possible security exploits which use control
characters in log files to mask entries in the logs or confuse the tools
which process log files. The Unicode Noncharacters are commonly used as
special markers and allowing them into UTF-8 Encoded Strings could
permit such exploits.

==== Interactions between Publishers and Subscribers
<interactions-between-publishers-and-subscribers>
The publisher of an Application Message normally expects that the
Servers will forward the message to subscribers, and that these
subscribers are capable of processing the messages.

These are some conditions under which a publishing Client can cause the
subscribing Client to delete the Virtual Connection. Consider a
situation where:

- A Client publishes an Application Message using a Topic Name
  containing one of the Disallowed Unicode code points.

- The publishing Client library allows the Disallowed Unicode code point
  to be used in a Topic Name rather than rejecting it.

- The publishing Client is authorized to send the publication.

- A subscribing Client is authorized to use a Topic Filter which matches
  the Topic Name. Note that the Disallowed Unicode code point might
  occur in a part of the Topic Name matching a wildcard character in the
  Topic Filter.

- The Server forwards the message to the matching subscriber rather than
  disconnecting the publisher.

- In this case the subscribing Client might:

  - Delete the Virtual Connection because it does not allow the use of
    Disallowed Unicode code points, possibly sending a DISCONNECT before
    doing so. For QoS 1 and QoS 2 messages this might cause the Server
    to send the message again, causing the Client to delete the Virtual
    Connection again.

  - Reject the Application Message by sending a Reason Code greater than
    or equal to 0x80 in a PUBACK (QoS 1) or PUBREC (QoS 2).

  - Accept the Application Message but fail to process it because it
    contains one of the Disallowed Unicode code points.

  - Successfully process the Application Message.

The potential for the Client to delete the Virtual Connection might go
unnoticed until a publisher uses one of the Disallowed Unicode code
points.

==== Remedies
<remedies>
If there is a possibility that a Disallowed Unicode code point could be
included in a Topic Name or other Properties delivered to a Client, the
solution owner can adopt one of the following suggestions:

+ Change the Server implementation to one that rejects UTF-8 Encoded
  Strings containing a Disallowed Unicode code point either by sending a
  Reason Code greater than or equal to 0x80 or deleting the Virtual
  Connection.

+ Change the Client library used by the subscribers to one that
  tolerates the use of Disallowed Code points. The client can either
  process or discard messages with UTF-8 Encoded Strings that contain
  Disallowed Unicode code points so long as it continues the protocol.

=== Other security considerations
<other-security-considerations>
If Client or Server X.509 certificates are lost or it is considered that
they might be compromised they should be revoked (using CRLs
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC5280")[\[\[RFC5280\]\]]
and/or OSCP
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC6960")[\[\[RFC6960\]\]]).

Client or Server authentication credentials, such as User Name and
Password, that are lost or considered compromised should be revoked
and/or reissued.

In the case of long lasting connections:

- Where applicable, Client and Server implementations should allow for
  session renegotiation to establish new cryptographic parameters
  (replace session keys, change cipher suites, change authentication
  credentials).

- Servers may close the Virtual Connection of Clients and require them
  to re-authenticate with new credentials.

- Servers may require their Client to reauthenticate periodically using
  the mechanism described in
  #link(<re-authentication>)[4.11.1.1 "Re-authentication"].

Clients connected to a Server have a transitive trust relationship with
other Clients connected to the same Server and who have authority to
publish data on the same topics.

=== Use of SOCKS
<use-of-socks>
Implementations of Clients should be aware that some environments will
require the use of SOCKSv5
#link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#RFC1928")[\[\[RFC1928\]\]]
proxies to transmit data. Some MQTT-SN implementations could make use of
alternative secured tunnels through the use of SOCKS. Where
implementations choose to use SOCKS, they should support both anonymous
and User Name, Password authenticating SOCKS proxies. In the latter
case, implementations should be aware that SOCKS authentication might
occur in plain-text and so should avoid using the same credentials for
connection to an MQTT-SN Server.

=== Security profiles
<security-profiles>
Implementers and solution designers might wish to consider security as a
set of profiles which can be applied to the MQTT-SN protocol. An example
of a layered security hierarchy is presented below.

==== Clear communication profile
<clear-communication-profile>
When using the clear communication profile, the MQTT-SN protocol runs
over an open network with no additional secure communication mechanisms
in place.

==== Secured network communication profile
<secured-network-communication-profile>
When using the secured network communication profile, the MQTT-SN
protocol runs over a physical or virtual network which has security
controls, VPNs or physically secure networks for example.

==== Secured transport profile
<secured-transport-profile>
When using the secured transport profile, the MQTT-SN protocol runs over
a physical or virtual network and uses MQTT-SN Authentication,
Protection Encapsulation, DTLS and/or other technologies to provide
authentication, integrity and privacy.

DTLS Client authentication can be used in addition to -- or in place of
-- MQTT-SN Client authentication as provided by the Authentication
Method and Data fields.

==== Industry specific security profiles
<industry-specific-security-profiles>
It is anticipated that the MQTT-SN (and MQTT) protocols will be designed
into industry specific application profiles, each defining a threat
model and the specific security mechanisms to be used to address these
threats. Recommendations for specific security mechanisms will often be
taken from existing works including:

- \[NISTCSF\] NIST Cyber Security Framework
- \[NIST7628\] NISTIR 7628 Guidelines for Smart Grid Cyber Security
- \[FIPS1403\] Security Requirements for Cryptographic Modules (FIPS PUB
  140-3)
- \[PCIDSS\] PCI-DSS Payment Card Industry Data Security Standard
- #link("https://media.defense.gov/2022/Sep/07/2003071834/-1/-1/0/CSA_CNSA_2.0_ALGORITHMS_.PDF")[CNSA20]
  Commercial National Security Algorithm Suite (CNSA) 2.0
- #link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#NSAB")[NSAB]
  NSA Suite B Cryptography

#pagebreak(weak: true)
= Conformance
<conformance>
The MQTT specification defines conformance for MQTT Client
implementations and MQTT Server implementations. An MQTT implementation
can conform as both an MQTT Client and an MQTT Server.

== Conformance clauses
<conformance-clauses>
=== MQTT-SN Server conformance clause
<mqtt-sn-server-conformance-clause>
Refer to #link(<terminology>)[1.4 "Terminology"] for a definition of
Server.

An MQTT-SN Server conforms to this specification only if it satisfies
all the statements below:

+ The format of all MQTT-SN Control Packets that the Server sends
  matches the format described in
  #link(<mqtt-sn-control-packet-format>)[2 "MQTT-SN Control Packet format"]
  and #link(<mqtt-sn-control-packets>)[3 "MQTT-SN Control Packets"].

+ It follows the Topic matching rules described in
  #link(<topic-names-and-topic-filters>)[4.7.1 "Topic Names and Topic Filters"]
  and the Subscription rules in
  #link(<subscriptions>)[4.8 "Subscriptions"].

+ It satisfies the MUST level requirements in the following chapters
  that are identified except for those that only apply to the Client:

  - #link(<introduction>)[1 "Introduction"]

  - #link(<mqtt-sn-control-packet-format>)[2 "MQTT-SN Control Packet format"]

  - #link(<mqtt-sn-control-packets>)[3 "MQTT-SN Control Packets"]

  - #link(<operational-behavior>)[4 "Operational behavior"]

+ It does not require the use of any extensions defined outside of the
  specification in order to interoperate with any other conformant
  implementation.

=== MQTT-SN Client conformance clause
<mqtt-sn-client-conformance-clause>
Refer to #link(<terminology>)[1.4 "Terminology"] for a definition of
Client.

An MQTT-SN Client conforms to this specification only if it satisfies
all the statements below:

+ The format of all MQTT-SN Control Packets that the Client sends
  matches the format described in
  #link(<mqtt-sn-control-packet-format>)[2 "MQTT-SN Control Packet format"]
  and #link(<mqtt-sn-control-packets>)[3 "MQTT-SN Control Packets"].

+ It follows the Topic matching rules described in
  #link(<topic-names-and-topic-filters>)[4.7.1 "Topic Names and Topic Filters"]
  and the Subscription rules in
  #link(<subscriptions>)[4.8 "Subscriptions"].

+ It satisfies the MUST level requirements in the following chapters
  that are identified except for those that only apply to the Server:

  - #link(<introduction>)[1 "Introduction"]

  - #link(<mqtt-sn-control-packet-format>)[2 "MQTT-SN Control Packet format"]

  - #link(<mqtt-sn-control-packets>)[3 "MQTT-SN Control Packets"]

  - #link(<operational-behavior>)[4 "Operational behavior"]

+ It does not require the use of any extensions defined outside of the
  specification in order to interoperate with any other conformant
  implementation.

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Appendix A. Acknowledgments]
<appendix-a.-acknowledgments>
\[Required section.\]

Note: A Work Product approved by the TC must include a list of people
who participated in the development of the Work Product. This is
generally done by collecting the list of names in this appendix. This
list shall be initially compiled by the Chair, and any Member of the TC
may add or remove their names from the list by request.

Remove these yellow notes before submitting for publication.

#heading(level: 2, numbering: none)[A.1 Special Thanks]
<a.1-special-thanks>
Note: This is an optional subsection to call out contributions from TC
members. If a TC wants to thank non-TC members then they should avoid
using the term \"contribution\" and instead thank them for their
\"expertise\" or \"assistance\".

Substantial contributions to this document from the following
individuals are gratefully acknowledged:

\[Participant Name, Affiliation | Individual Member\]

#heading(level: 2, numbering: none)[A.2 Participants]
<a.2-participants>
Note: A TC can determine who they list here, however, Observers must not
be listed. It is common practice for TCs to list everyone that was part
of the TC during the creation of the document, but this is ultimately a
TC decision on who they want to list and not list.

The following individuals were members of this Technical Committee
during the creation of this document and their contributions are
gratefully acknowledged:

\[Participant Name, Affiliation | Individual Member\]

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Appendix B. Mandatory normative
statements (informative)]
<appendix-b.-mandatory-normative-statements-informative>
This Appendix is non-normative and is provided as a convenient summary
of the numbered conformance statements found in the main body of this
document. Refer to #link(<conformance>)[6 "Conformance"] for a
definitive list of conformance requirements.

#figure(
  align(center)[#table(
    columns: (18%, 82%),
    align: (left,left,),
    table.header([Reference Identifier], [Normative Statement],),
    table.hline(),
    [#box()<tab-MQTT-SN-1.8.4-1>\[#link(<MQTT-SN-1.8.4-1>)[MQTT‑SN‑1.8.4‑1]\]], [The
    character data in a UTF-8 Encoded String MUST be well-formed UTF-8
    as defined by the Unicode specification
    \[#link(<Unicode>)[Unicode]\] and restated in RFC 3629
    \[#link(<RFC3629>)[RFC3629]\]. In particular, the character data
    MUST NOT include encodings of code points between U+D800 and
    U+DFFF.],
    [#box()<tab-MQTT-SN-1.8.4-2>\[#link(<MQTT-SN-1.8.4-2>)[MQTT‑SN‑1.8.4‑2]\]], [A
    UTF-8 Encoded String MUST NOT include an encoding of the null
    character U+0000.],
    [#box()<tab-MQTT-SN-1.8.4-3>\[#link(<MQTT-SN-1.8.4-3>)[MQTT‑SN‑1.8.4‑3]\]], [A
    UTF-8 encoded sequence 0xEF 0xBB 0xBF is always interpreted as
    U+FEFF (\"ZERO WIDTH NO-BREAK SPACE\") wherever it appears in a
    string and MUST NOT be skipped over or stripped off by a packet
    receiver.],
    [#box()<tab-MQTT-SN-2.1.2-1>\[#link(<MQTT-SN-2.1.2-1>)[MQTT‑SN‑2.1.2‑1]\]], [A
    Client or Server receiving MQTT-SN Control Packets MUST be able to
    process both 1-byte and 3-byte length formats.],
    [#box()<tab-MQTT-SN-2.2-1>\[#link(<MQTT-SN-2.2-1>)[MQTT‑SN‑2.2‑1]\]], [Each
    time a Client sends a new MQTT-SN Control Packet which is identified
    in #link(<tab-packets-with-packet-identifier>)[Table 2] as requiring
    a Packet Identifier, it MUST assign it a non-zero Packet Identifier
    that is currently unused.],
    [#box()<tab-MQTT-SN-2.2-2>\[#link(<MQTT-SN-2.2-2>)[MQTT‑SN‑2.2‑2]\]], [A
    PUBLISH packet MUST NOT contain a Packet Identifier if its QoS value
    is set to 0.],
    [#box()<tab-MQTT-SN-2.2-3>\[#link(<MQTT-SN-2.2-3>)[MQTT‑SN‑2.2‑3]\]], [Each
    time a Server sends a new PUBLISH (with QoS greater than 0) MQTT-SN
    Control Packet it MUST assign it a non zero Packet Identifier that
    is currently unused.],
    [#box()<tab-MQTT-SN-2.2-4>\[#link(<MQTT-SN-2.2-4>)[MQTT‑SN‑2.2‑4]\]], [A
    response packet MUST contain the same Packet Identifier as the
    Packet it is responding to.],
    [#box()<tab-MQTT-SN-3.1.2-1>\[#link(<MQTT-SN-3.1.2-1>)[MQTT‑SN‑3.1.2‑1]\]], [Bit
    7 of the CONNECT Flags is reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.1.2-2>\[#link(<MQTT-SN-3.1.2-2>)[MQTT‑SN‑3.1.2‑2]\]], [The
    Server MUST validate that the reserved flags in the CONNECT packet
    are set to 0.],
    [#box()<tab-MQTT-SN-3.1.2.1-1>\[#link(<MQTT-SN-3.1.2.1-1>)[MQTT‑SN‑3.1.2.1‑1]\]], [If
    a CONNECT packet is received with Clean Start is set to 1, the
    Client and Server MUST discard any existing Session and start a new
    Session.],
    [#box()<tab-MQTT-SN-3.1.2.1-2>\[#link(<MQTT-SN-3.1.2.1-2>)[MQTT‑SN‑3.1.2.1‑2]\]], [If
    a CONNECT packet is received with Clean Start set to 0 and there is
    a Session associated with the Client Identifier, the Server MUST
    resume communications with the Client based on state from the
    existing Session.],
    [#box()<tab-MQTT-SN-3.1.2.1-3>\[#link(<MQTT-SN-3.1.2.1-3>)[MQTT‑SN‑3.1.2.1‑3]\]], [If
    a CONNECT packet is received with Clean Start set to 0 and there is
    no Session associated with the Client Identifier, the Server MUST
    create a new Session.],
    [#box()<tab-MQTT-SN-3.1.2.2-1>\[#link(<MQTT-SN-3.1.2.2-1>)[MQTT‑SN‑3.1.2.2‑1]\]], [If
    the Will Flag is set to 1, the Will Flags, Will Topic, and Will
    Payload fields MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.2-2>\[#link(<MQTT-SN-3.1.2.2-2>)[MQTT‑SN‑3.1.2.2‑2]\]], [If
    the Will Flag is set to 1 this indicates that a Will Message MUST be
    stored on the Server and associated with the Session.],
    [#box()<tab-MQTT-SN-3.1.2.2-3>\[#link(<MQTT-SN-3.1.2.2-3>)[MQTT‑SN‑3.1.2.2‑3]\]], [The
    Will Message MUST be published after the Virtual Connection is
    deleted or the Session ends, unless the Will Message has been
    deleted by the Server on receipt of a DISCONNECT packet with Reason
    Code 0x00 (Normal disconnection).],
    [#box()<tab-MQTT-SN-3.1.2.2-4>\[#link(<MQTT-SN-3.1.2.2-4>)[MQTT‑SN‑3.1.2.2‑4]\]], [The
    Will Message MUST be removed from the stored Session State in the
    Server once it has been published or the Server has received a
    DISCONNECT packet with a Reason Code of 0x00 (Normal disconnection)
    from the Client.],
    [#box()<tab-MQTT-SN-3.1.2.3-1>\[#link(<MQTT-SN-3.1.2.3-1>)[MQTT‑SN‑3.1.2.3‑1]\]], [If
    the Authentication Flag is set to 1, the Authentication Method and
    Authentication Data fields MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.3-2>\[#link(<MQTT-SN-3.1.2.3-2>)[MQTT‑SN‑3.1.2.3‑2]\]], [If
    the Authentication Flag is set to 0, the Authentication Method and
    Authentication Data fields MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.4-1>\[#link(<MQTT-SN-3.1.2.4-1>)[MQTT‑SN‑3.1.2.4‑1]\]], [If
    the Session Expiry Flag is set to 1, the Session Expiry Interval
    field MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.4-2>\[#link(<MQTT-SN-3.1.2.4-2>)[MQTT‑SN‑3.1.2.4‑2]\]], [If
    the Session Expiry Flag is set to 0, the Session Expiry Interval
    field MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.5-1>\[#link(<MQTT-SN-3.1.2.5-1>)[MQTT‑SN‑3.1.2.5‑1]\]], [If
    the Maximum Number of Awake Messages Flag is set to 1, the Maximum
    Number of Awake Messages field MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.5-2>\[#link(<MQTT-SN-3.1.2.5-2>)[MQTT‑SN‑3.1.2.5‑2]\]], [If
    the Maximum Number of Awake Messages Flag is set to 0, the Maximum
    Number of Awake Messages field MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.1.2.6-1>\[#link(<MQTT-SN-3.1.2.6-1>)[MQTT‑SN‑3.1.2.6‑1]\]], [If
    this flag is set to 0 and a Packet is wrapped by the Connection
    Encapsulation, it is a protocol error. The Server must send a
    DISCONNECT and delete the Virtual Connection.],
    [#box()<tab-MQTT-SN-3.1.2.7-1>\[#link(<MQTT-SN-3.1.2.7-1>)[MQTT‑SN‑3.1.2.7‑1]\]], [If
    this flag is set to 0, the Server MUST NOT include a Server Keep
    Alive field in the CONNACK Packet response.],
    [#box()<tab-MQTT-SN-3.1.2.7-2>\[#link(<MQTT-SN-3.1.2.7-2>)[MQTT‑SN‑3.1.2.7‑2]\]], [If
    this flag is set to 0, the Server MUST NOT include a Session Expiry
    field in the CONNACK Packet response.],
    [#box()<tab-MQTT-SN-3.1.2.7-3>\[#link(<MQTT-SN-3.1.2.7-3>)[MQTT‑SN‑3.1.2.7‑3]\]], [If
    this flag is set to 0 for the current Virtual Connection, the Server
    MUST NOT include a Sleep Duration in the SLEEPRESP Packet.],
    [#box()<tab-MQTT-SN-3.1.3-1>\[#link(<MQTT-SN-3.1.3-1>)[MQTT‑SN‑3.1.3‑1]\]], [If
    the Will Flag is set to 0, the Will Flags MUST NOT be present in the
    Packet.],
    [#box()<tab-MQTT-SN-3.1.3-2>\[#link(<MQTT-SN-3.1.3-2>)[MQTT‑SN‑3.1.3‑2]\]], [If
    the Will Flag is set to 1, the Will Flags MUST be present in the
    Packet.],
    [#box()<tab-MQTT-SN-3.1.3-3>\[#link(<MQTT-SN-3.1.3-3>)[MQTT‑SN‑3.1.3‑3]\]], [Bits
    7-5 of the Will Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.1.3.3-1>\[#link(<MQTT-SN-3.1.3.3-1>)[MQTT‑SN‑3.1.3.3‑1]\]], [If
    the Will Flag is set to 1 and Will Retain is set to 0, the Server
    MUST publish the Will Message as a non-retained message.],
    [#box()<tab-MQTT-SN-3.1.3.3-2>\[#link(<MQTT-SN-3.1.3.3-2>)[MQTT‑SN‑3.1.3.3‑2]\]], [If
    the Will Flag is set to 1 and Will Retain is set to 1, the Server
    MUST publish the Will Message as a retained message.],
    [#box()<tab-MQTT-SN-3.1.5-1>\[#link(<MQTT-SN-3.1.5-1>)[MQTT‑SN‑3.1.5‑1]\]], [The
    value of the Protocol Version field for MQTT-SN version 2.0 MUST be
    2 (0x02).],
    [#box()<tab-MQTT-SN-3.1.5-2>\[#link(<MQTT-SN-3.1.5-2>)[MQTT‑SN‑3.1.5‑2]\]], [If
    the Protocol Version is not 2 and the Server does not want to accept
    the CONNECT packet, the Server MAY send a CONNACK packet with Reason
    Code 0x84 (Unsupported Protocol Version).],
    [#box()<tab-MQTT-SN-3.1.6-1>\[#link(<MQTT-SN-3.1.6-1>)[MQTT‑SN‑3.1.6‑1]\]], [In
    the absence of sending any other MQTT-SN Control Packets, the Client
    MUST send a PINGREQ packet.],
    [#box()<tab-MQTT-SN-3.1.6-2>\[#link(<MQTT-SN-3.1.6-2>)[MQTT‑SN‑3.1.6‑2]\]], [If
    the Server does not receive an MQTT-SN Control Packet from the
    Client within one and a half times the Keep Alive time period, it
    MUST delete the Virtual Connection and move the Client to the
    Disconnected state (see
    #link(<client-states>)[4.14 "Client states"]).],
    [#box()<tab-MQTT-SN-3.1.6-3>\[#link(<MQTT-SN-3.1.6-3>)[MQTT‑SN‑3.1.6‑3]\]], [If
    a Client does not receive a PINGRESP packet within a #emph[\[Retry
    Interval\]] amount of time after it has sent a PINGREQ, it SHOULD
    retry the transmission according to
    #link(<unacknowledged-packets>)[4.4.2 "Unacknowledged Packets"] up
    to the maximum number of attempts. If a PINGRESP is still not
    received it MUST delete the Virtual Connection to the Server by way
    of a DISCONNECT, with the understanding that the Server may no
    longer be reachable.],
    [#box()<tab-MQTT-SN-3.1.6-4>\[#link(<MQTT-SN-3.1.6-4>)[MQTT‑SN‑3.1.6‑4]\]], [The
    Keep Alive must have a value greater than 0. It is a protocol error
    if a Keep Alive value of 0 or below is set.],
    [#box()<tab-MQTT-SN-3.1.7-1>\[#link(<MQTT-SN-3.1.7-1>)[MQTT‑SN‑3.1.7‑1]\]], [The
    Maximum Packet Size value MUST be 0 (unbounded), or 10 or greater.],
    [#box()<tab-MQTT-SN-3.1.7-2>\[#link(<MQTT-SN-3.1.7-2>)[MQTT‑SN‑3.1.7‑2]\]], [The
    Server MUST NOT send packets exceeding Maximum Packet Size to the
    Client. If a Client receives a packet whose size exceeds this limit,
    this is a Protocol Error, the Client uses DISCONNECT with Reason
    Code 0x95 (Packet too large).],
    [#box()<tab-MQTT-SN-3.1.7-3>\[#link(<MQTT-SN-3.1.7-3>)[MQTT‑SN‑3.1.7‑3]\]], [Where
    a Packet is too large to send, the Server MUST discard it without
    sending it and then behave as if it had completed sending that
    Application Message.],
    [#box()<tab-MQTT-SN-3.1.9-1>\[#link(<MQTT-SN-3.1.9-1>)[MQTT‑SN‑3.1.9‑1]\]], [The
    Client and Server MUST store the Session State after the Virtual
    Connection is deleted if the Session Expiry Interval is greater than
    \0.],
    [#box()<tab-MQTT-SN-3.1.11-1>\[#link(<MQTT-SN-3.1.11-1>)[MQTT‑SN‑3.1.11‑1]\]], [The
    Will Topic Name MUST be a UTF-8 Encoded String as defined in
    #link(<utf-8-encoded-string>)[1.8.4 "UTF-8 Encoded String"].],
    [#box()<tab-MQTT-SN-3.1.18-1>\[#link(<MQTT-SN-3.1.18-1>)[MQTT‑SN‑3.1.18‑1]\]], [The
    Client Identifier MUST be a UTF-8 Encoded String.],
    [#box()<tab-MQTT-SN-3.1.18-2>\[#link(<MQTT-SN-3.1.18-2>)[MQTT‑SN‑3.1.18‑2]\]], [The
    Client Identifier MUST be used by Clients and by Server to identify
    the state that they hold relating to this MQTT-SN Session between
    the Client and the Server.],
    [#box()<tab-MQTT-SN-3.1.18-3>\[#link(<MQTT-SN-3.1.18-3>)[MQTT‑SN‑3.1.18‑3]\]], [When
    the Client Identifier is present (greater than 0 bytes), the Server
    MUST allow values which are between 1 and 23 UTF-8 encoded bytes in
    length, and that contain only the characters
    \"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ”.],
    [#box()<tab-MQTT-SN-3.1.18-4>\[#link(<MQTT-SN-3.1.18-4>)[MQTT‑SN‑3.1.18‑4]\]], [The
    Server MAY choose to allow more than 23 bytes.],
    [#box()<tab-MQTT-SN-3.1.19-1>\[#link(<MQTT-SN-3.1.19-1>)[MQTT‑SN‑3.1.19‑1]\]], [The
    Server MUST validate that the CONNECT packet matches the format
    described in
    #link(<connect---connection-request>)[3.1 "CONNECT - Connection Request"]
    and MUST NOT create a Virtual Connection for this CONNECT if it does
    not match.],
    [#box()<tab-MQTT-SN-3.1.19-2>\[#link(<MQTT-SN-3.1.19-2>)[MQTT‑SN‑3.1.19‑2]\]], [The
    Server MAY check that the contents of the CONNECT packet meet any
    further restrictions and SHOULD perform authentication and
    authorization checks. If any of these checks fail, it MUST NOT
    create a Virtual Connection for this CONNECT.],
    [#box()<tab-MQTT-SN-3.1.19-3>\[#link(<MQTT-SN-3.1.19-3>)[MQTT‑SN‑3.1.19‑3]\]], [If
    the Client Identifier represents a Client already connected to the
    Server, the Server sends a DISCONNECT packet to the existing Client
    with Reason Code of 0x8E (Session taken over) as described in
    #link(<handling-errors>)[4.12 "Handling errors"] and MUST delete the
    Virtual Connection of the existing Client.],
    [#box()<tab-MQTT-SN-3.1.19-4>\[#link(<MQTT-SN-3.1.19-4>)[MQTT‑SN‑3.1.19‑4]\]], [The
    Server MUST perform the processing of Clean Start that is described
    in #link(<clean-start-flag>)[3.1.2.1 "Clean Start Flag"].],
    [#box()<tab-MQTT-SN-3.1.19-5>\[#link(<MQTT-SN-3.1.19-5>)[MQTT‑SN‑3.1.19‑5]\]], [The
    Server MUST acknowledge the CONNECT packet with a CONNACK packet
    containing a 0x00 (Success) Reason Code.],
    [#box()<tab-MQTT-SN-3.1.19-6>\[#link(<MQTT-SN-3.1.19-6>)[MQTT‑SN‑3.1.19‑6]\]], [A
    Client MUST wait for a CONNACK packet with a 0x00 (Success) Reason
    Code before sending any packet that needs a Virtual Connection, AUTH
    excepted.],
    [#box()<tab-MQTT-SN-3.1.19-7>\[#link(<MQTT-SN-3.1.19-7>)[MQTT‑SN‑3.1.19‑7]\]], [The
    Server MUST interpret any Packet received from the Client (other
    than AUTH) that requires a Virtual Connection, after the CONNECT
    packet is received and before the CONNACK response is sent, as a
    Protocol Error.],
    [#box()<tab-MQTT-SN-3.2.2-1>\[#link(<MQTT-SN-3.2.2-1>)[MQTT‑SN‑3.2.2‑1]\]], [Bits
    7-4 of the CONNACK Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.2.2-2>\[#link(<MQTT-SN-3.2.2-2>)[MQTT‑SN‑3.2.2‑2]\]], [The
    Client MUST validate that the reserved flags in the CONNACK packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.2.2.1-1>\[#link(<MQTT-SN-3.2.2.1-1>)[MQTT‑SN‑3.2.2.1‑1]\]], [If
    the Server accepts a CONNECT with Clean Start set to 1, the Server
    MUST set Session Present to 0 in the CONNACK Packet in addition to
    setting a 0x00 (Success) Reason Code in the CONNACK packet.],
    [#box()<tab-MQTT-SN-3.2.2.1-2>\[#link(<MQTT-SN-3.2.2.1-2>)[MQTT‑SN‑3.2.2.1‑2]\]], [If
    the Server accepts a CONNECT with Clean Start set to 0 and the
    Server has Session State for the client identifier it MUST set
    Session Present to 1 in the CONNACK packet, otherwise it MUST set
    Session Present to 0 in the CONNACK packet. In both cases it MUST
    set a 0x00 (Success) Reason Code in the CONNACK packet.],
    [#box()<tab-MQTT-SN-3.2.2.1-3>\[#link(<MQTT-SN-3.2.2.1-3>)[MQTT‑SN‑3.2.2.1‑3]\]], [If
    the Client does not have Session State and receives Session Present
    set to 1 it MUST delete the Virtual Connection. If it wishes to
    restart with a new Session the Client can reconnect using Clean
    Start set to 1.],
    [#box()<tab-MQTT-SN-3.2.2.1-4>\[#link(<MQTT-SN-3.2.2.1-4>)[MQTT‑SN‑3.2.2.1‑4]\]], [If
    the Client does have Session State and receives Session Present set
    to 0 it MUST discard its Session State if it continues with the
    Virtual Connection.],
    [#box()<tab-MQTT-SN-3.2.2.1-5>\[#link(<MQTT-SN-3.2.2.1-5>)[MQTT‑SN‑3.2.2.1‑5]\]], [If
    a Server sends a CONNACK packet containing a non-zero Reason Code it
    MUST set Session Present to 0.],
    [#box()<tab-MQTT-SN-3.2.2.2-1>\[#link(<MQTT-SN-3.2.2.2-1>)[MQTT‑SN‑3.2.2.2‑1]\]], [​​If
    the Session Expiry Interval Flag is set to 0, a Session Expiry
    Interval MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.2.2-2>\[#link(<MQTT-SN-3.2.2.2-2>)[MQTT‑SN‑3.2.2.2‑2]\]], [If
    the Session Expiry Interval Flag is set to 1, a Session Expiry
    Interval MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.2.3-1>\[#link(<MQTT-SN-3.2.2.3-1>)[MQTT‑SN‑3.2.2.3‑1]\]], [​​If
    the Server Keep Alive Flag is set to 0, a Server Keep Alive field
    MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.2.3-2>\[#link(<MQTT-SN-3.2.2.3-2>)[MQTT‑SN‑3.2.2.3‑2]\]], [If
    the Server Keep Alive Flag is set to 1, a Server Keep Alive field
    MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.2.4-1>\[#link(<MQTT-SN-3.2.2.4-1>)[MQTT‑SN‑3.2.2.4‑1]\]], [​​If
    the Authentication Flag is set to 0, Authentication Method and Data
    MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.2.4-2>\[#link(<MQTT-SN-3.2.2.4-2>)[MQTT‑SN‑3.2.2.4‑2]\]], [If
    the Authentication Flag is set to 1, Authentication Method and Data
    MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.2.4-1>\[#link(<MQTT-SN-3.2.4-1>)[MQTT‑SN‑3.2.4‑1]\]], [The
    Server sending the CONNACK Packet MUST use one of the Reason Codes
    applicable to CONNACK.],
    [#box()<tab-MQTT-SN-3.2.4-2>\[#link(<MQTT-SN-3.2.4-2>)[MQTT‑SN‑3.2.4‑2]\]], [If
    a Server sends a CONNACK packet containing a Reason code of 0x80 or
    greater it MUST then delete the Virtual Connection.],
    [#box()<tab-MQTT-SN-3.2.6-1>\[#link(<MQTT-SN-3.2.6-1>)[MQTT‑SN‑3.2.6‑1]\]], [If
    the Server sends a Server Keep Alive on the CONNACK packet, the
    Client MUST use this value instead of the Keep Alive value the
    Client sent on CONNECT.],
    [#box()<tab-MQTT-SN-3.2.6-2>\[#link(<MQTT-SN-3.2.6-2>)[MQTT‑SN‑3.2.6‑2]\]], [If
    the Server does not send the Server Keep Alive, the Server MUST use
    the Keep Alive value set by the Client on CONNECT.],
    [#box()<tab-MQTT-SN-3.2.11-1>\[#link(<MQTT-SN-3.2.11-1>)[MQTT‑SN‑3.2.11‑1]\]], [The
    Assigned Client Identifier MUST be a UTF-8 Encoded String.],
    [#box()<tab-MQTT-SN-3.2.11-2>\[#link(<MQTT-SN-3.2.11-2>)[MQTT‑SN‑3.2.11‑2]\]], [If
    the Client connects using a zero length Client Identifier, the
    Server MUST respond with a CONNACK containing an Assigned Client
    Identifier.],
    [#box()<tab-MQTT-SN-3.2.11-3>\[#link(<MQTT-SN-3.2.11-3>)[MQTT‑SN‑3.2.11‑3]\]], [The
    Assigned Client Identifier MUST be a new Client Identifier not used
    by any other Session currently in the Server.],
    [#box()<tab-MQTT-SN-3.3.2-1>\[#link(<MQTT-SN-3.3.2-1>)[MQTT‑SN‑3.3.2‑1]\]], [When
    sent from Server to Client, it MUST contain the packet identifier of
    the CONNECT or AUTH packet being responded to.],
    [#box()<tab-MQTT-SN-3.3.3-1>\[#link(<MQTT-SN-3.3.3-1>)[MQTT‑SN‑3.3.3‑1]\]], [The
    sender of the AUTH Packet MUST use one of the Reason Codes shown as
    applicable to the AUTH packet.],
    [#box()<tab-MQTT-SN-3.4-1>\[#link(<MQTT-SN-3.4-1>)[MQTT‑SN‑3.4‑1]\]], [If
    the REGISTER packet is sent by a Client, it MUST NOT contain a Topic
    Alias.],
    [#box()<tab-MQTT-SN-3.4-2>\[#link(<MQTT-SN-3.4-2>)[MQTT‑SN‑3.4‑2]\]], [If
    the REGISTER packet is sent by a Server, it MUST contain a Topic
    Alias.],
    [#box()<tab-MQTT-SN-3.4.2-1>\[#link(<MQTT-SN-3.4.2-1>)[MQTT‑SN‑3.4.2‑1]\]], [Bits
    7-1 of the REGISTER Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.4.2-2>\[#link(<MQTT-SN-3.4.2-2>)[MQTT‑SN‑3.4.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the REGISTER
    packet are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.4.2.1-1>\[#link(<MQTT-SN-3.4.2.1-1>)[MQTT‑SN‑3.4.2.1‑1]\]], [If
    the Topic Alias Flag is set to 0, a Topic Alias MUST NOT be present
    in the Packet.],
    [#box()<tab-MQTT-SN-3.4.2.1-2>\[#link(<MQTT-SN-3.4.2.1-2>)[MQTT‑SN‑3.4.2.1‑2]\]], [If
    the Topic Alias Flag is set to 1, a Topic Alias MUST be present in
    the Packet.],
    [#box()<tab-MQTT-SN-3.5.2-1>\[#link(<MQTT-SN-3.5.2-1>)[MQTT‑SN‑3.5.2‑1]\]], [Bits
    7-3 of the REGACK Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.5.2-2>\[#link(<MQTT-SN-3.5.2-2>)[MQTT‑SN‑3.5.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the REGACK packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.5.2.1-1>\[#link(<MQTT-SN-3.5.2.1-1>)[MQTT‑SN‑3.5.2.1‑1]\]], [The
    Topic Type in the REGACK packet MUST be Predefined Topic Alias or
    Session Topic Alias.],
    [#box()<tab-MQTT-SN-3.5.2.2-1>\[#link(<MQTT-SN-3.5.2.2-1>)[MQTT‑SN‑3.5.2.2‑1]\]], [If
    the Topic Alias Flag is set to 0, a Topic Alias MUST NOT be present
    in the Packet.],
    [#box()<tab-MQTT-SN-3.5.2.2-2>\[#link(<MQTT-SN-3.5.2.2-2>)[MQTT‑SN‑3.5.2.2‑2]\]], [If
    the Topic Alias Flag is set to 1, a Topic Alias MUST be present in
    the Packet.],
    [#box()<tab-MQTT-SN-3.5.4-1>\[#link(<MQTT-SN-3.5.4-1>)[MQTT‑SN‑3.5.4‑1]\]], [When
    sent by a Client the REGACK MUST NOT contain a Topic Alias.],
    [#box()<tab-MQTT-SN-3.5.5-1>\[#link(<MQTT-SN-3.5.5-1>)[MQTT‑SN‑3.5.5‑1]\]], [The
    sender of the REGACK Packet MUST use one of the Reason Codes
    applicable to REGACK.],
    [#box()<tab-MQTT-SN-3.6-1>\[#link(<MQTT-SN-3.6-1>)[MQTT‑SN‑3.6‑1]\]], [If
    forwarded to an MQTT connection, PUBWOS packets MUST have their MQTT
    Quality of Service level set to 0\].],
    [#box()<tab-MQTT-SN-3.6.1.2-1>\[#link(<MQTT-SN-3.6.1.2-1>)[MQTT‑SN‑3.6.1.2‑1]\]], [Bits
    7-5 and 3-2 of the PUBWOS FLAGS are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.6.1.2-2>\[#link(<MQTT-SN-3.6.1.2-2>)[MQTT‑SN‑3.6.1.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the PUBWOS packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.6.1.2.1-1>\[#link(<MQTT-SN-3.6.1.2.1-1>)[MQTT‑SN‑3.6.1.2.1‑1]\]], [The
    Topic Type in the PUBWOS packet MUST be Predefined Topic Alias or
    Topic Name.],
    [#box()<tab-MQTT-SN-3.6.1.4-1>\[#link(<MQTT-SN-3.6.1.4-1>)[MQTT‑SN‑3.6.1.4‑1]\]], [If
    the Topic Type is Toic Name, the Topic Name field MUST be present in
    the PUBWOS packet.],
    [#box()<tab-MQTT-SN-3.6.1.4-2>\[#link(<MQTT-SN-3.6.1.4-2>)[MQTT‑SN‑3.6.1.4‑2]\]], [If
    the Topic Type is Predefined Topic Alias, the Topic Name field MUST
    NOT be present in the PUBWOS packet.],
    [#box()<tab-MQTT-SN-3.6.1.6-1>\[#link(<MQTT-SN-3.6.1.6-1>)[MQTT‑SN‑3.6.1.6‑1]\]], [If
    received by a Client or Server, the PUBWOS packet MUST be treated as
    if its QoS were 0],
    [#box()<tab-MQTT-SN-3.6.2-1>\[#link(<MQTT-SN-3.6.2-1>)[MQTT‑SN‑3.6.2‑1]\]], [PUBLISH
    packets received by a Client or Server MUST be associated with a
    Session.],
    [#box()<tab-MQTT-SN-3.6.2.2-1>\[#link(<MQTT-SN-3.6.2.2-1>)[MQTT‑SN‑3.6.2.2‑1]\]], [Bits
    3-2 of the PUBLISH Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.6.2.2-2>\[#link(<MQTT-SN-3.6.2.2-2>)[MQTT‑SN‑3.6.2.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the PUBLISH packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.6.2.2.1-1>\[#link(<MQTT-SN-3.6.2.2.1-1>)[MQTT‑SN‑3.6.2.2.1‑1]\]], [The
    Topic Type MUST be Topic Name, Predefined Topic Alias or Session
    Topic Alias.],
    [#box()<tab-MQTT-SN-3.6.2.2.3-1>\[#link(<MQTT-SN-3.6.2.2.3-1>)[MQTT‑SN‑3.6.2.2.3‑1]\]], [If
    the QoS field is set to 0 or 1, the DUP flag MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.6.2.3-1>\[#link(<MQTT-SN-3.6.2.3-1>)[MQTT‑SN‑3.6.2.3‑1]\]], [If
    the QoS field is set to 0, the Packet Identifier field MUST not be
    present in the PUBLISH packet.],
    [#box()<tab-MQTT-SN-3.6.2.3-2>\[#link(<MQTT-SN-3.6.2.3-2>)[MQTT‑SN‑3.6.2.3‑2]\]], [If
    the QoS field is set to 1 or 2, the Packet Identifier field MUST be
    present in the PUBLISH packet.],
    [#box()<tab-MQTT-SN-3.6.2.5-1>\[#link(<MQTT-SN-3.6.2.5-1>)[MQTT‑SN‑3.6.2.5‑1]\]], [If
    the Topic Type is Topic Name (0b11), the Topic Name field MUST be
    present in the PUBLISH packet.],
    [#box()<tab-MQTT-SN-3.6.2.5-2>\[#link(<MQTT-SN-3.6.2.5-2>)[MQTT‑SN‑3.6.2.5‑2]\]], [If
    the Topic Type is Predefined Topic Alias or Session Topic Alias,
    then the Topic Name field MUST NOT be present in the PUBLISH
    packet.],
    [#box()<tab-MQTT-SN-3.6.2.7-1>\[#link(<MQTT-SN-3.6.2.7-1>)[MQTT‑SN‑3.6.2.7‑1]\]], [The
    receiver of a PUBLISH packet MUST respond with the packet as
    determined by the QoS in the PUBLISH Packet.],
    [#box()<tab-MQTT-SN-3.6.2.7-2>\[#link(<MQTT-SN-3.6.2.7-2>)[MQTT‑SN‑3.6.2.7‑2]\]], [When
    Clients make subscriptions with Topic Filters that include
    wildcards, it is possible for a Client's subscriptions to overlap so
    that a published Application Message might match multiple filters.
    In this case the Server MUST deliver the Application Message to the
    Client respecting the maximum QoS of all the matching
    subscriptions.],
    [#box()<tab-MQTT-SN-3.6.3.3-1>\[#link(<MQTT-SN-3.6.3.3-1>)[MQTT‑SN‑3.6.3.3‑1]\]], [The
    sender of the PUBACK Packet MUST use one of the Reason Codes
    applicable to PUBACK.],
    [#box()<tab-MQTT-SN-3.6.4.3-1>\[#link(<MQTT-SN-3.6.4.3-1>)[MQTT‑SN‑3.6.4.3‑1]\]], [The
    sender of the PUBREC Packet MUST use one of the Reason Codes
    applicable to PUBREC.],
    [#box()<tab-MQTT-SN-3.6.5.3-1>\[#link(<MQTT-SN-3.6.5.3-1>)[MQTT‑SN‑3.6.5.3‑1]\]], [The
    sender of the PUBREL Packet MUST use one of the Reason Codes
    applicable to PUBREL.],
    [#box()<tab-MQTT-SN-3.6.6.3-1>\[#link(<MQTT-SN-3.6.6.3-1>)[MQTT‑SN‑3.6.6.3‑1]\]], [The
    sender of the PUBCOMP Packet MUST use one of the Reason Codes
    applicable to PUBCOMP.],
    [#box()<tab-MQTT-SN-3.7.2.1-1>\[#link(<MQTT-SN-3.7.2.1-1>)[MQTT‑SN‑3.7.2.1‑1]\]], [The
    Topic Type MUST be Topic Filter, Predefined Topic Alias or Session
    Topic Alias.],
    [#box()<tab-MQTT-SN-3.7.2.5-1>\[#link(<MQTT-SN-3.7.2.5-1>)[MQTT‑SN‑3.7.2.5‑1]\]], [if
    the value is 1, Application Messages MUST NOT be forwarded to a
    Virtual Connection with a Client Identifier equal to the Client
    Identifier of the publishing Virtual Connection.],
    [#box()<tab-MQTT-SN-3.7.4-1>\[#link(<MQTT-SN-3.7.4-1>)[MQTT‑SN‑3.7.4‑1]\]], [If
    the Topic Type is Predefined Topic Alias or Session Topic Alias,
    then the Topic Alias field MUST be present in the SUBSCRIBE
    packet.],
    [#box()<tab-MQTT-SN-3.7.4-2>\[#link(<MQTT-SN-3.7.4-2>)[MQTT‑SN‑3.7.4‑2]\]], [If
    the Topic Type is Topic Filter the Topic Alias field MUST NOT be
    present in the SUBSCRIBE packet.],
    [#box()<tab-MQTT-SN-3.7.5-1>\[#link(<MQTT-SN-3.7.5-1>)[MQTT‑SN‑3.7.5‑1]\]], [If
    the Topic Type is Topic Filter the Topic Filter field MUST be
    present in the SUBSCRIBE packet.],
    [#box()<tab-MQTT-SN-3.7.5-2>\[#link(<MQTT-SN-3.7.5-2>)[MQTT‑SN‑3.7.5‑2]\]], [If
    the Topic Type is Predefined Topic Alias or Session Topic Alias,
    then the Topic Filter field MUST NOT be present in the SUBSCRIBE
    packet.],
    [#box()<tab-MQTT-SN-3.7.6-1>\[#link(<MQTT-SN-3.7.6-1>)[MQTT‑SN‑3.7.6‑1]\]], [When
    the Server receives a SUBSCRIBE packet from a Client, the Server
    MUST respond with a SUBACK packet.],
    [#box()<tab-MQTT-SN-3.7.6-2>\[#link(<MQTT-SN-3.7.6-2>)[MQTT‑SN‑3.7.6‑2]\]], [The
    SUBACK packet MUST have the same Packet Identifier as the SUBSCRIBE
    packet that it is acknowledging.],
    [#box()<tab-MQTT-SN-3.7.6-3>\[#link(<MQTT-SN-3.7.6-3>)[MQTT‑SN‑3.7.6‑3]\]], [If
    a Server receives a SUBSCRIBE packet containing a Topic Filter that
    is identical to a Subscription's Topic Filter for the current
    Session, then it MUST replace that existing Subscription with a new
    Subscription.],
    [#box()<tab-MQTT-SN-3.7.6-4>\[#link(<MQTT-SN-3.7.6-4>)[MQTT‑SN‑3.7.6‑4]\]], [If
    the Retain Handling option is 0, any existing retained messages
    matching the Topic Filter MUST be re-sent, but Application Messages
    MUST NOT be lost due to replacing the Subscription.],
    [#box()<tab-MQTT-SN-3.7.6-5>\[#link(<MQTT-SN-3.7.6-5>)[MQTT‑SN‑3.7.6‑5]\]], [The
    SUBACK packet sent by the Server to the Client MUST contain a Reason
    Code.],
    [#box()<tab-MQTT-SN-3.7.6-6>\[#link(<MQTT-SN-3.7.6-6>)[MQTT‑SN‑3.7.6‑6]\]], [This
    Reason Code MUST either show the maximum QoS that was granted for
    that Subscription or indicate that the subscription failed.],
    [#box()<tab-MQTT-SN-3.7.6-7>\[#link(<MQTT-SN-3.7.6-7>)[MQTT‑SN‑3.7.6‑7]\]], [The
    QoS of Application Messages sent in response to a Subscription MUST
    be the minimum of the QoS of the originally published Application
    message and the Maximum QoS granted by the Server.],
    [#box()<tab-MQTT-SN-3.8.2-1>\[#link(<MQTT-SN-3.8.2-1>)[MQTT‑SN‑3.8.2‑1]\]], [Bits
    7-3 of the SUBACK Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.8.2-2>\[#link(<MQTT-SN-3.8.2-2>)[MQTT‑SN‑3.8.2‑2]\]], [The
    Client MUST validate that the reserved flags in the SUBACK packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.8.2.1-1>\[#link(<MQTT-SN-3.8.2.1-1>)[MQTT‑SN‑3.8.2.1‑1]\]], [The
    Topic Type in the SUBACK packet MUST be either Predefined Topic
    Alias or Session Topic Alias.],
    [#box()<tab-MQTT-SN-3.8.2.1-2>\[#link(<MQTT-SN-3.8.2.1-2>)[MQTT‑SN‑3.8.2.1‑2]\]], [If
    there is no Topic Alias returned the Topic Type MUST be Predefined
    Topic Alias.],
    [#box()<tab-MQTT-SN-3.8.2.2-1>\[#link(<MQTT-SN-3.8.2.2-1>)[MQTT‑SN‑3.8.2.2‑1]\]], [If
    the Topic Alias Flag is set to 0, a Topic Alias MUST NOT be present
    in the Packet.],
    [#box()<tab-MQTT-SN-3.8.2.2-2>\[#link(<MQTT-SN-3.8.2.2-2>)[MQTT‑SN‑3.8.2.2‑2]\]], [If
    the Topic Alias Flag is set to 1, a Topic Alias MUST be present in
    the Packet.],
    [#box()<tab-MQTT-SN-3.8.4-1>\[#link(<MQTT-SN-3.8.4-1>)[MQTT‑SN‑3.8.4‑1]\]], [If
    a Topic Alias is returned, it MUST be used instead of the Topic Name
    by the Server when sending PUBLISH packets to the client.],
    [#box()<tab-MQTT-SN-3.8.4-2>\[#link(<MQTT-SN-3.8.4-2>)[MQTT‑SN‑3.8.4‑2]\]], [If
    no Topic Alias is returned, the Topic Alias Flag MUST be 0.],
    [#box()<tab-MQTT-SN-3.8.4-3>\[#link(<MQTT-SN-3.8.4-3>)[MQTT‑SN‑3.8.4‑3]\]], [If
    a Predefined Topic Alias was subscribed to, a Topic Alias MUST NOT
    be present in the SUBACK.],
    [#box()<tab-MQTT-SN-3.8.5-1>\[#link(<MQTT-SN-3.8.5-1>)[MQTT‑SN‑3.8.5‑1]\]], [The
    sender of the SUBACK Packet MUST use one of the Reason Codes
    applicable to SUBACK.],
    [#box()<tab-MQTT-SN-3.9.2-1>\[#link(<MQTT-SN-3.9.2-1>)[MQTT‑SN‑3.9.2‑1]\]], [Bits
    7-2 of the UNSUBSCRIBE Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.9.2-2>\[#link(<MQTT-SN-3.9.2-2>)[MQTT‑SN‑3.9.2‑2]\]], [The
    Server MUST validate that the reserved flags in the UNSUBSCRIBE
    packet are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.9.4-1>\[#link(<MQTT-SN-3.9.4-1>)[MQTT‑SN‑3.9.4‑1]\]], [A
    Topic Alias MUST be present in the UNSUBSCRIBE packet if the Topic
    Type is Predefined or Session Topic Alias.],
    [#box()<tab-MQTT-SN-3.9.4-2>\[#link(<MQTT-SN-3.9.4-2>)[MQTT‑SN‑3.9.4‑2]\]], [A
    Topic Alias MUST NOT be present in the UNSUBSCRIBE packet if the
    Topic Type is Topic Filter.],
    [#box()<tab-MQTT-SN-3.9.5-1>\[#link(<MQTT-SN-3.9.5-1>)[MQTT‑SN‑3.9.5‑1]\]], [A
    Topic Filter MUST be present in the UNSUBSCRIBE packet if the Topic
    Type is Topic Name.],
    [#box()<tab-MQTT-SN-3.9.5-2>\[#link(<MQTT-SN-3.9.5-2>)[MQTT‑SN‑3.9.5‑2]\]], [A
    Topic Filter MUST NOT be present in the UNSUBSCRIBE packet if the
    Topic Type is Predefined or Session Topic Alias.],
    [#box()<tab-MQTT-SN-3.9.6-1>\[#link(<MQTT-SN-3.9.6-1>)[MQTT‑SN‑3.9.6‑1]\]], [If
    a Topic Alias is used in an UNSUBSCRIBE request, it MUST be
    translated to its equivalent Topic Name before any other action
    takes place.],
    [#box()<tab-MQTT-SN-3.9.6-2>\[#link(<MQTT-SN-3.9.6-2>)[MQTT‑SN‑3.9.6‑2]\]], [The
    Topic Filter (whether it contains wildcards or not) supplied in an
    UNSUBSCRIBE packet MUST be compared character-by-character with the
    current set of Topic Filters held by the Server for the Client. If
    any filter matches exactly then its owning Subscription MUST be
    deleted.],
    [#box()<tab-MQTT-SN-3.9.6-3>\[#link(<MQTT-SN-3.9.6-3>)[MQTT‑SN‑3.9.6‑3]\]], [When
    a Server receives UNSUBSCRIBE it MUST stop adding any new
    Application Messages which match the Topic Filters, for delivery to
    the Client.],
    [#box()<tab-MQTT-SN-3.9.6-4>\[#link(<MQTT-SN-3.9.6-4>)[MQTT‑SN‑3.9.6‑4]\]], [When
    a Server receives UNSUBSCRIBE it MUST complete the delivery of any
    QoS 1 or QoS 2 Application Messages which match the Topic Filters
    and it has started to send to the Client.],
    [#box()<tab-MQTT-SN-3.9.6-5>\[#link(<MQTT-SN-3.9.6-5>)[MQTT‑SN‑3.9.6‑5]\]], [The
    Server MUST respond to an UNSUBSCRIBE request by sending an UNSUBACK
    packet.],
    [#box()<tab-MQTT-SN-3.9.6-6>\[#link(<MQTT-SN-3.9.6-6>)[MQTT‑SN‑3.9.6‑6]\]], [The
    UNSUBACK packet MUST have the same Packet Identifier as the
    UNSUBSCRIBE packet. Even where no Topic Subscriptions are deleted,
    the Server MUST respond with an UNSUBACK.],
    [#box()<tab-MQTT-SN-3.10.3-1>\[#link(<MQTT-SN-3.10.3-1>)[MQTT‑SN‑3.10.3‑1]\]], [The
    Server sending the UNSUBACK Packet MUST use one of the UNSUBACK
    Reason Codes.],
    [#box()<tab-MQTT-SN-3.11.3-1>\[#link(<MQTT-SN-3.11.3-1>)[MQTT‑SN‑3.11.3‑1]\]], [The
    Server MUST send a PINGRESP packet in response to a PINGREQ packet
    after sending any buffered Application Messages, if it has a Virtual
    Connection for the sending Client.],
    [#box()<tab-MQTT-SN-3.11.3-2>\[#link(<MQTT-SN-3.11.3-2>)[MQTT‑SN‑3.11.3‑2]\]], [The
    Server MAY send a DISCONNECT packet in response to a PINGREQ packet
    if it does not have a Virtual Connection for the sending Client.],
    [#box()<tab-MQTT-SN-3.11.3-3>\[#link(<MQTT-SN-3.11.3-3>)[MQTT‑SN‑3.11.3‑3]\]], [If
    the Server sends a DISCONNECT packet in response to a PINGREQ packet
    because it does not have a Virtual Connection for the sending
    Client, it MUST use Reason Code 244 - No Virtual Connection
    Exists.],
    [#box()<tab-MQTT-SN-3.11.3-4>\[#link(<MQTT-SN-3.11.3-4>)[MQTT‑SN‑3.11.3‑4]\]], [If
    the state of the Client associated with the Virtual Connection is
    Asleep on receipt of the PINGREQ, the Server MUST move the Client to
    the Awake state, stop the Sleep Duration processing, and start the
    Retry Timer processing.],
    [#box()<tab-MQTT-SN-3.13.2-1>\[#link(<MQTT-SN-3.13.2-1>)[MQTT‑SN‑3.13.2‑1]\]], [Bits
    7-3 of the DISCONNECT Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.13.2-2>\[#link(<MQTT-SN-3.13.2-2>)[MQTT‑SN‑3.13.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the DISCONNECT
    packet are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.13.2.1-1>\[#link(<MQTT-SN-3.13.2.1-1>)[MQTT‑SN‑3.13.2.1‑1]\]], [If
    the Packet Identifier Flag is set to 0, a Packet Identifier MUST NOT
    be present in the Packet.],
    [#box()<tab-MQTT-SN-3.13.2.1-2>\[#link(<MQTT-SN-3.13.2.1-2>)[MQTT‑SN‑3.13.2.1‑2]\]], [If
    the Packet Identifier Flag is set to 1, a Packet Identifier MUST be
    present in the Packet.],
    [#box()<tab-MQTT-SN-3.13.2.2-1>\[#link(<MQTT-SN-3.13.2.2-1>)[MQTT‑SN‑3.13.2.2‑1]\]], [If
    the Session Expiry Interval Flag is set to 0, a Session Expiry
    Interval MUST NOT be present in the Packet.],
    [#box()<tab-MQTT-SN-3.13.2.2-2>\[#link(<MQTT-SN-3.13.2.2-2>)[MQTT‑SN‑3.13.2.2‑2]\]], [If
    the Session Expiry Interval Flag is set to 1, a Session Expiry
    Interval MUST be present in the Packet.],
    [#box()<tab-MQTT-SN-3.13.2.3-1>\[#link(<MQTT-SN-3.13.2.3-1>)[MQTT‑SN‑3.13.2.3‑1]\]], [If
    the Reason Code Flag is set to 0, a Reason Code MUST NOT be present
    in the Packet.],
    [#box()<tab-MQTT-SN-3.13.2.3-2>\[#link(<MQTT-SN-3.13.2.3-2>)[MQTT‑SN‑3.13.2.3‑2]\]], [If
    the Reason Code Flag is set to 1, a Reason Code MUST be present in
    the Packet.],
    [#box()<tab-MQTT-SN-3.13.4-1>\[#link(<MQTT-SN-3.13.4-1>)[MQTT‑SN‑3.13.4‑1]\]], [The
    sender of the DISCONNECT packet MUST use one of the Reason Code
    values applicable to DISCONNECT.],
    [#box()<tab-MQTT-SN-3.13.5-1>\[#link(<MQTT-SN-3.13.5-1>)[MQTT-SN-3.13.5-1]\]], [The
    Session Expiry Interval MUST NOT be sent on a DISCONNECT by the
    Server.],
    [#box()<tab-MQTT-SN-3.13.7-1>\[#link(<MQTT-SN-3.13.7-1>)[MQTT‑SN‑3.13.7‑1]\]], [After
    sending a DISCONNECT packet the sender MUST NOT send any more
    MQTT-SN Control Packets on that Virtual Connection.],
    [#box()<tab-MQTT-SN-3.13.7-2>\[#link(<MQTT-SN-3.13.7-2>)[MQTT‑SN‑3.13.7‑2]\]], [After
    sending a DISCONNECT packet the sender MUST delete the Virtual
    Connection.],
    [#box()<tab-MQTT-SN-3.13.7-3>\[#link(<MQTT-SN-3.13.7-3>)[MQTT‑SN‑3.13.7‑3]\]], [On
    receipt of DISCONNECT with a Reason Code of 0x00 (Success) the
    Server MUST discard any Will Message associated with the current
    Connection without publishing it.],
    [#box()<tab-MQTT-SN-3.13.7-4>\[#link(<MQTT-SN-3.13.7-4>)[MQTT‑SN‑3.13.7‑4]\]], [On
    receipt of DISCONNECT, the receiver MUST NOT send any more MQTT-SN
    Control Packets on the Virtual Connection, if one exists.],
    [#box()<tab-MQTT-SN-3.14.2-1>\[#link(<MQTT-SN-3.14.2-1>)[MQTT‑SN‑3.14.2‑1]\]], [The
    Client MUST transition to the Awake state or remain in the Asleep
    state.],
    [#box()<tab-MQTT-SN-3.15.2-1>\[#link(<MQTT-SN-3.15.2-1>)[MQTT‑SN‑3.15.2‑1]\]], [Bits
    7-1 of the SLEEPREQ Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.15.2-2>\[#link(<MQTT-SN-3.15.2-2>)[MQTT‑SN‑3.15.2‑2]\]], [The
    Server MUST validate that the reserved flags in the SLEEPREQ packet
    are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.15.2.1-1>\[#link(<MQTT-SN-3.15.2.1-1>)[MQTT‑SN‑3.15.2.1‑1]\]], [Predefined
    Topic aliases MUST NOT be removed by the setting of the Retain Topic
    Aliases flag to 0.],
    [#box()<tab-MQTT-SN-3.15.4-1>\[#link(<MQTT-SN-3.15.4-1>)[MQTT‑SN‑3.15.4‑1]\]], [The
    Sleep Duration MUST be greater than 0.],
    [#box()<tab-MQTT-SN-3.15.5-1>\[#link(<MQTT-SN-3.15.5-1>)[MQTT‑SN‑3.15.5‑1]\]], [A
    SLEEPREQ packet sent by a Server is a Protocol Error.],
    [#box()<tab-MQTT-SN-3.15.5-2>\[#link(<MQTT-SN-3.15.5-2>)[MQTT‑SN‑3.15.5‑2]\]], [If
    there is a Virtual Connection for the Client, the Server MUST send a
    SLEEPRESP packet in response to a SLEEPREQ packet.],
    [#box()<tab-MQTT-SN-3.15.5-3>\[#link(<MQTT-SN-3.15.5-3>)[MQTT‑SN‑3.15.5‑3]\]], [If
    there is no Virtual Connection associated with the SLEEPREQ, the
    Server MAY send a DISCONNECT with Reason Code 0xF4 (No Virtual
    Connection Exists) in response.],
    [#box()<tab-MQTT-SN-3.15.5-4>\[#link(<MQTT-SN-3.15.5-4>)[MQTT‑SN‑3.15.5‑4]\]], [If
    the SLEEPREQ request is granted, the Server MUST suspend Keep Alive
    processing for the Virtual Connection.],
    [#box()<tab-MQTT-SN-3.15.5-5>\[#link(<MQTT-SN-3.15.5-5>)[MQTT‑SN‑3.15.5‑5]\]], [If
    the SLEEPREQ request is granted, the Server MUST start Sleep
    Duration processing for the Virtual Connection.],
    [#box()<tab-MQTT-SN-3.15.5-6>\[#link(<MQTT-SN-3.15.5-6>)[MQTT‑SN‑3.15.5‑6]\]], [If
    the SLEEPREQ request is successful, the Virtual Connection MUST NOT
    be deleted.],
    [#box()<tab-MQTT-SN-3.15.5-7>\[#link(<MQTT-SN-3.15.5-7>)[MQTT‑SN‑3.15.5‑7]\]], [If
    the Client is already in the Asleep state when a SLEEPREQ is
    received by the Server, the Server MUST stop the Sleep Duration
    Timer, and start a new sleep cycle using the updated Sleep
    Duration.],
    [#box()<tab-MQTT-SN-3.16.2-1>\[#link(<MQTT-SN-3.16.2-1>)[MQTT‑SN‑3.16.2‑1]\]], [Bits
    7-1 of the SLEEPRESP Flags are reserved and MUST be set to 0.],
    [#box()<tab-MQTT-SN-3.16.2-2>\[#link(<MQTT-SN-3.16.2-2>)[MQTT‑SN‑3.16.2‑2]\]], [The
    receiver MUST validate that the reserved flags in the SLEEPRESP
    packet are set to 0. If any of the reserved flags is not 0 it is a
    Malformed Packet.],
    [#box()<tab-MQTT-SN-3.16.2.1-1>\[#link(<MQTT-SN-3.16.2.1-1>)[MQTT‑SN‑3.16.2.1‑1]\]], [If
    the Sleep Duration Flag is set to 0, Sleep Duration MUST NOT be
    present in the Packet.],
    [#box()<tab-MQTT-SN-3.16.2.1-2>\[#link(<MQTT-SN-3.16.2.1-2>)[MQTT‑SN‑3.16.2.1‑2]\]], [If
    the Sleep Duration Flag is set to 1, Sleep Duration MUST be present
    in the Packet.],
    [#box()<tab-MQTT-SN-3.16.2.1-3>\[#link(<MQTT-SN-3.16.2.1-3>)[MQTT‑SN‑3.16.2.1‑3]\]], [If
    the Allow Server Suggested Values Flag in the CONNECT Packet that
    created the current Virtual Connection was 0, the Server MUST set
    the Sleep Duration Flag in the SLEEPRESP Packet to 0.],
    [#box()<tab-MQTT-SN-3.16.4-1>\[#link(<MQTT-SN-3.16.4-1>)[MQTT‑SN‑3.16.4‑1]\]], [If
    the Server sends a Sleep Duration on the SLEEPRESP packet, the
    Client MUST use this value instead of the Sleep Duration value the
    Client sent in the SLEEPREQ packet.],
    [#box()<tab-MQTT-SN-3.16.4-2>\[#link(<MQTT-SN-3.16.4-2>)[MQTT‑SN‑3.16.4‑2]\]], [If
    the Server does not send the Sleep Duration, the Server MUST use the
    Sleep Duration value set by the Client in the SLEEPREQ packet.],
    [#box()<tab-MQTT-SN-3.16.5-1>\[#link(<MQTT-SN-3.16.5-1>)[MQTT‑SN‑3.16.5‑1]\]], [The
    sender of the SLEEPRESP packet MUST use one of the Reason Code
    values applicable to SLEEPRESP.],
    [#box()<tab-MQTT-SN-3.17-1>\[#link(<MQTT-SN-3.17-1>)[MQTT‑SN‑3.17‑1]\]], [The
    sender identified by Sender Identifier is the originator of the
    protected MQTT-SN Packet and responsible for its protection. This
    responsibility MUST NOT be delegated to a third party like a
    Forwarder.],
    [#box()<tab-MQTT-SN-3.17-2>\[#link(<MQTT-SN-3.17-2>)[MQTT‑SN‑3.17‑2]\]], [All
    Packets in all Virtual Connections associated with a protected
    Session MUST use the Protection Encapsulation.],
    [#box()<tab-MQTT-SN-3.17-3>\[#link(<MQTT-SN-3.17-3>)[MQTT‑SN‑3.17‑3]\]], [A
    protected Packet that has the same Client Identifier but a different
    Sender Identifier as an existing protected Session MUST refer to a
    different Session.],
    [#box()<tab-MQTT-SN-3.17-4>\[#link(<MQTT-SN-3.17-4>)[MQTT‑SN‑3.17‑4]\]], [A
    protected Packet that has the same Sender Identifier but a different
    Client Identifier as an existing protected Session MUST refer to a
    different Session.],
    [#box()<tab-MQTT-SN-3.17-5>\[#link(<MQTT-SN-3.17-5>)[MQTT‑SN‑3.17‑5]\]], [An
    unprotected Packet that has the same Client Identifier as an
    existing Protected Session MUST refer to a different Session.],
    [#box()<tab-MQTT-SN-3.17.2.1-1>\[#link(<MQTT-SN-3.17.2.1-1>)[MQTT‑SN‑3.17.2.1‑1]\]], [The
    Monotonic Counter Length MUST NOT be set to 0x3 - the value is
    reserved.],
    [#box()<tab-MQTT-SN-3.17.2.1-2>\[#link(<MQTT-SN-3.17.2.1-2>)[MQTT‑SN‑3.17.2.1‑2]\]], [If
    the Monotonic Counter Length is set to 0x2, a Monotonic Counter of
    32 bits (4 bytes) in length MUST be present in the Protection
    Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.1-3>\[#link(<MQTT-SN-3.17.2.1-3>)[MQTT‑SN‑3.17.2.1‑3]\]], [If
    the Monotonic Counter Length is set to 0x1, a Monotonic Counter of
    16 bits (2 bytes) in length MUST be present in the Protection
    Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.1-4>\[#link(<MQTT-SN-3.17.2.1-4>)[MQTT‑SN‑3.17.2.1‑4]\]], [If
    the Monotonic Counter Length is set to 0x0, a Monotonic Counter MUST
    NOT be present in the Protection Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.2-1>\[#link(<MQTT-SN-3.17.2.2-1>)[MQTT‑SN‑3.17.2.2‑1]\]], [If
    the Cryptographic Material Length is set to 0x3, a Cryptographic
    Material field of 96 bits (12 bytes) in length MUST be present in
    the Protection Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.2-2>\[#link(<MQTT-SN-3.17.2.2-2>)[MQTT‑SN‑3.17.2.2‑2]\]], [If
    the Cryptographic Material Length is set to 0x2, a Cryptographic
    Material field of 32 bits (4 bytes) in length MUST be present in the
    Protection Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.2-3>\[#link(<MQTT-SN-3.17.2.2-3>)[MQTT‑SN‑3.17.2.2‑3]\]], [If
    the Cryptographic Material Length is set to 0x1, a Cryptographic
    Material field of 16 bits (2 bytes) in length MUST be present in the
    Protection Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.2-4>\[#link(<MQTT-SN-3.17.2.2-4>)[MQTT‑SN‑3.17.2.2‑4]\]], [If
    the Cryptographic Material Length is set to 0x0, a Cryptographic
    Material field MUST NOT be present in the Protection
    Encapsulation.],
    [#box()<tab-MQTT-SN-3.17.2.3-1>\[#link(<MQTT-SN-3.17.2.3-1>)[MQTT‑SN‑3.17.2.3‑1]\]], [If
    the Protection Scheme is not "Authentication Only" the
    Authentication Tag Length MUST be set to 0x1.],
    [#box()<tab-MQTT-SN-3.17.2.3-2>\[#link(<MQTT-SN-3.17.2.3-2>)[MQTT‑SN‑3.17.2.3‑2]\]], [If
    the Authentication Tag Length is set to 0x1, the length of the
    Authentication Tag MUST be equal to the Protection Scheme nominal
    tag size.],
    [#box()<tab-MQTT-SN-3.17.2.3-3>\[#link(<MQTT-SN-3.17.2.3-3>)[MQTT‑SN‑3.17.2.3‑3]\]], [The
    Authentication Tag Length MUST NOT be set to 0x2 or 0x3 - these
    values are reserved.],
    [#box()<tab-MQTT-SN-3.17.2.3-4>\[#link(<MQTT-SN-3.17.2.3-4>)[MQTT‑SN‑3.17.2.3‑4]\]], [If
    the Authentication Tag Length is set to any value between 0x4 and
    0xF inclusive, the Protection Scheme MUST be "Authentication
    Only".],
    [#box()<tab-MQTT-SN-3.17.2.3-5>\[#link(<MQTT-SN-3.17.2.3-5>)[MQTT‑SN‑3.17.2.3‑5]\]], [Authentication
    Tag Length values between 0x4 and 0xF inclusive MUST only be used
    for the truncation of "Authentication Only" protection schemes.],
    [#box()<tab-MQTT-SN-3.17.2.3-6>\[#link(<MQTT-SN-3.17.2.3-6>)[MQTT‑SN‑3.17.2.3‑6]\]], [In
    these cases the length of the Authentication Tag MUST be sixteen
    times the Authentication Tag Length.],
    [#box()<tab-MQTT-SN-3.17.2.3-7>\[#link(<MQTT-SN-3.17.2.3-7>)[MQTT‑SN‑3.17.2.3‑7]\]], [If
    truncation of the output of the authentication algorithm is
    required, it MUST be taken in most significant bits first order
    (leftmost bits).],
    [#box()<tab-MQTT-SN-3.17.2.3-8>\[#link(<MQTT-SN-3.17.2.3-8>)[MQTT‑SN‑3.17.2.3‑8]\]], [Authentication
    Tag Length values for some Authentication Only protection schemes
    MUST NOT be used if they define a tag size bigger than the nominal
    tag size.],
    [#box()<tab-MQTT-SN-3.17.3-1>\[#link(<MQTT-SN-3.17.3-1>)[MQTT‑SN‑3.17.3‑1]\]], [The
    Protection Scheme is a one byte field which MUST contain one of the
    indexes in table 3-39 which is not reserved.],
    [#box()<tab-MQTT-SN-3.17.3-2>\[#link(<MQTT-SN-3.17.3-2>)[MQTT‑SN‑3.17.3‑2]\]], [The
    thirteen byte nonce recommended for AES CCM must be obtained by
    performing SHA256, truncated to the leftmost 104 bits, of the
    sequence Byte 1 to Byte 17+C+M (all packet fields up to the
    Protected MQTT-SN Packet).],
    [#box()<tab-MQTT-SN-3.17.3-3>\[#link(<MQTT-SN-3.17.3-3>)[MQTT‑SN‑3.17.3‑3]\]], [The
    twelve byte initialization vector (IV) recommended for AES GCM must
    be obtained by performing SHA256, truncated to the leftmost 96 bits,
    of the sequence Byte 1 to Byte 17+C+M (all packet fields up to the
    Protected MQTT-SN Packet).],
    [#box()<tab-MQTT-SN-3.17.3-4>\[#link(<MQTT-SN-3.17.3-4>)[MQTT‑SN‑3.17.3‑4]\]], [The
    twelve byte nonce recommended for ChaCha20/Poly1305 must be obtained
    by performing SHA256 truncated to 96 bit of the sequence Byte 1 to
    Byte 17+C+M (all packet fields up to the Protected MQTT-SN
    Packet).],
    [#box()<tab-MQTT-SN-3.17.4-1>\[#link(<MQTT-SN-3.17.4-1>)[MQTT‑SN‑3.17.4‑1]\]], [The
    eight byte Sender Identifier field MUST contain a unique value per
    sender over 8 bytes (such as a MAC address, or other identifying
    characteristics).],
    [#box()<tab-MQTT-SN-3.17.7-1>\[#link(<MQTT-SN-3.17.7-1>)[MQTT‑SN‑3.17.7‑1]\]], [The
    counters must be considered independent of session or destination.],
    [#box()<tab-MQTT-SN-3.17.8-1>\[#link(<MQTT-SN-3.17.8-1>)[MQTT‑SN‑3.17.8‑1]\]], [The
    Protected MQTT-SN Packet MUST NOT be a Forwarder Encapsulated
    Packet.],
    [#box()<tab-MQTT-SN-3.18-1>\[#link(<MQTT-SN-3.18-1>)[MQTT‑SN‑3.18‑1]\]], [If
    the Allow Network Address Changes flag in the CONNECT for the
    Virtual Connection is 0, it is a protocol error to use the
    Connection Encapsulation.],
    [#box()<tab-MQTT-SN-3.18-2>\[#link(<MQTT-SN-3.18-2>)[MQTT‑SN‑3.18‑2]\]], [It
    is a protocol error to use the Connection Encapsulation on Packets
    sent by a Server.],
    [#box()<tab-MQTT-SN-3.18-3>\[#link(<MQTT-SN-3.18-3>)[MQTT‑SN‑3.18‑3]\]], [It
    is a protocol error to use the Connection Encapsulation on Packets
    other than PUBLISH, SUBSCRIBE, UNSUBSCRIBE, REGISTER, DISCONNECT,
    SLEEPREQ and PINGREQ sent by a Client.],
    [#box()<tab-MQTT-SN-3.18-4>\[#link(<MQTT-SN-3.18-4>)[MQTT‑SN‑3.18‑4]\]], [The
    encapsulated MQTT-SN packet MUST be treated by the receiver in
    exactly the same fashion as the same Packet unencapsulated, once the
    associated Virtual Connection is identified.],
    [#box()<tab-MQTT-SN-4.1.1-1>\[#link(<MQTT-SN-4.1.1-1>)[MQTT‑SN‑4.1.1‑1]\]], [The
    Server MUST NOT discard the Session State while the Virtual
    Connection exists.],
    [#box()<tab-MQTT-SN-4.1.1-2>\[#link(<MQTT-SN-4.1.1-2>)[MQTT‑SN‑4.1.1‑2]\]], [The
    Client MUST NOT discard the Session State while the Virtual
    Connection exists.],
    [#box()<tab-MQTT-SN-4.1.1-3>\[#link(<MQTT-SN-4.1.1-3>)[MQTT‑SN‑4.1.1‑3]\]], [The
    Server MUST discard the Session State when the Virtual Connection is
    deleted and the Session Expiry Interval has passed.],
    [#box()<tab-MQTT-SN-4.1.2-1>\[#link(<MQTT-SN-4.1.2-1>)[MQTT‑SN‑4.1.2‑1]\]], [If
    the Client provides no client identifier, the Server MUST respond
    with a CONNACK containing an Assigned Client Identifier.],
    [#box()<tab-MQTT-SN-4.1.2-2>\[#link(<MQTT-SN-4.1.2-2>)[MQTT‑SN‑4.1.2‑2]\]], [An
    Assigned Client Identifier MUST be a new Client Identifier not used
    by any other Session currently in the Server.],
    [#box()<tab-MQTT-SN-4.2-1>\[#link(<MQTT-SN-4.2-1>)[MQTT‑SN‑4.2‑1]\]], [If
    the Underlying Network might deliver a Packet more than once, for
    connection-oriented communications (CONNECT, DISCONNECT and other
    packets in between) the PROTECTION ENCAPSULATION Monotonic Counter
    MUST be used to eliminate duplicates.],
    [#box()<tab-MQTT-SN-4.2.1-1>\[#link(<MQTT-SN-4.2.1-1>)[MQTT‑SN‑4.2.1‑1]\]], [All
    incoming Packets except CONNECT, PUBWOS and Gateway search
    (ADVERTISE, SEARCHGW and GWINFO) MUST be associated with an existing
    Virtual Connection.],
    [#box()<tab-MQTT-SN-4.3.1-1>\[#link(<MQTT-SN-4.3.1-1>)[MQTT‑SN‑4.3.1‑1]\]], [In
    the PUBWOS delivery protocol the sender MUST send a PUBWOS packet.],
    [#box()<tab-MQTT-SN-4.3.1-2>\[#link(<MQTT-SN-4.3.1-2>)[MQTT‑SN‑4.3.1‑2]\]], [In
    the PUBWOS delivery protocol the receiver MUST treat any accepted
    messages as QoS 0.],
    [#box()<tab-MQTT-SN-4.3.2-1>\[#link(<MQTT-SN-4.3.2-1>)[MQTT‑SN‑4.3.2‑1]\]], [In
    the QoS 0 delivery protocol the sender MUST send a PUBLISH packet
    with QoS 0.],
    [#box()<tab-MQTT-SN-4.3.3-1>\[#link(<MQTT-SN-4.3.3-1>)[MQTT‑SN‑4.3.3‑1]\]], [In
    the QoS 1 delivery protocol, the sender MUST assign an unused Packet
    Identifier each time it has a new Application Message to publish.],
    [#box()<tab-MQTT-SN-4.3.3-2>\[#link(<MQTT-SN-4.3.3-2>)[MQTT‑SN‑4.3.3‑2]\]], [In
    the QoS 1 delivery protocol, the sender MUST send a PUBLISH packet
    containing this Packet Identifier with QoS 1 and DUP flag set to
    \0.],
    [#box()<tab-MQTT-SN-4.3.3-3>\[#link(<MQTT-SN-4.3.3-3>)[MQTT‑SN‑4.3.3‑3]\]], [In
    the QoS 1 delivery protocol, the sender MUST treat the PUBLISH
    packet as "unacknowledged" until it has received the corresponding
    PUBACK packet from the receiver.],
    [#box()<tab-MQTT-SN-4.3.3-4>\[#link(<MQTT-SN-4.3.3-4>)[MQTT‑SN‑4.3.3‑4]\]], [At
    all times a Sender MUST have a maximum of one unacknowledged
    packet.],
    [#box()<tab-MQTT-SN-4.3.3-5>\[#link(<MQTT-SN-4.3.3-5>)[MQTT‑SN‑4.3.3‑5]\]], [In
    the QoS 1 delivery protocol, the receiver MUST respond with a PUBACK
    packet containing the Packet Identifier from the incoming PUBLISH
    packet, having accepted ownership of the Application Message.],
    [#box()<tab-MQTT-SN-4.3.3-6>\[#link(<MQTT-SN-4.3.3-6>)[MQTT‑SN‑4.3.3‑6]\]], [In
    the QoS 1 delivery protocol, the receiver, after it has sent a
    PUBACK packet, MUST treat any incoming PUBLISH packet that contains
    the same Packet Identifier as being a new Application Message.],
    [#box()<tab-MQTT-SN-4.3.4-1>\[#link(<MQTT-SN-4.3.4-1>)[MQTT‑SN‑4.3.4‑1]\]], [In
    the QoS 2 delivery protocol, the sender MUST assign an unused Packet
    Identifier when it has a new Application Message to publish.],
    [#box()<tab-MQTT-SN-4.3.4-2>\[#link(<MQTT-SN-4.3.4-2>)[MQTT‑SN‑4.3.4‑2]\]], [In
    the QoS 2 delivery protocol, the sender MUST send a PUBLISH packet
    containing this Packet Identifier with QoS equal to 2.],
    [#box()<tab-MQTT-SN-4.3.4-3>\[#link(<MQTT-SN-4.3.4-3>)[MQTT‑SN‑4.3.4‑3]\]], [In
    the QoS 2 delivery protocol, the sender MUST set the DUP flag to 0
    when it attempts to send a PUBLISH packet for the first time.],
    [#box()<tab-MQTT-SN-4.3.4-4>\[#link(<MQTT-SN-4.3.4-4>)[MQTT‑SN‑4.3.4‑4]\]], [In
    the QoS 2 delivery protocol, the sender MUST set the DUP flag to 1
    when it attempts to resend a PUBLISH packet.],
    [#box()<tab-MQTT-SN-4.3.4-5>\[#link(<MQTT-SN-4.3.4-5>)[MQTT‑SN‑4.3.4‑5]\]], [In
    the QoS 2 delivery protocol, the sender MUST treat the PUBLISH
    packet as "unacknowledged" until it has received the corresponding
    PUBREC packet from the receiver.],
    [#box()<tab-MQTT-SN-4.3.4-6>\[#link(<MQTT-SN-4.3.4-6>)[MQTT‑SN‑4.3.4‑6]\]], [In
    the QoS 2 delivery protocol, the sender MUST send a PUBREL packet
    when it receives a PUBREC packet from the receiver with a Reason
    Code value less than 0x80. This PUBREL packet MUST contain the same
    Packet Identifier as the original PUBLISH packet.],
    [#box()<tab-MQTT-SN-4.3.4-7>\[#link(<MQTT-SN-4.3.4-7>)[MQTT‑SN‑4.3.4‑7]\]], [In
    the QoS 2 delivery protocol, the sender MUST treat the PUBREL packet
    as "unacknowledged" until it has received the corresponding PUBCOMP
    packet from the receiver.],
    [#box()<tab-MQTT-SN-4.3.4-8>\[#link(<MQTT-SN-4.3.4-8>)[MQTT‑SN‑4.3.4‑8]\]], [In
    the QoS 2 delivery protocol, the sender MUST NOT resend the PUBLISH
    once it has sent the corresponding PUBREL packet.],
    [#box()<tab-MQTT-SN-4.3.4-9>\[#link(<MQTT-SN-4.3.4-9>)[MQTT‑SN‑4.3.4‑9]\]], [In
    the QoS 2 delivery protocol, the receiver MUST respond with a PUBREC
    containing the Packet Identifier from the incoming PUBLISH packet,
    having accepted ownership of the Application Message.],
    [#box()<tab-MQTT-SN-4.3.4-10>\[#link(<MQTT-SN-4.3.4-10>)[MQTT‑SN‑4.3.4‑10]\]], [In
    the QoS 2 delivery protocol, the receiver, if it has sent a PUBREC
    with a Reason Code of 0x80 or greater, MUST treat any subsequent
    PUBLISH packet that contains that Packet Identifier as being a new
    Application Message.],
    [#box()<tab-MQTT-SN-4.3.4-11>\[#link(<MQTT-SN-4.3.4-11>)[MQTT‑SN‑4.3.4‑11]\]], [In
    the QoS 2 delivery protocol, the receiver, until it has received the
    corresponding PUBREL packet, MUST acknowledge any subsequent PUBLISH
    packet with the same Packet Identifier by sending a PUBREC. It MUST
    NOT cause duplicate messages to be delivered to any onward
    recipients in this case.],
    [#box()<tab-MQTT-SN-4.3.4-12>\[#link(<MQTT-SN-4.3.4-12>)[MQTT‑SN‑4.3.4‑12]\]], [In
    the QoS 2 delivery protocol, the receiver MUST respond to a PUBREL
    packet by sending a PUBCOMP packet containing the same Packet
    Identifier as the PUBREL.],
    [#box()<tab-MQTT-SN-4.3.4-13>\[#link(<MQTT-SN-4.3.4-13>)[MQTT‑SN‑4.3.4‑13]\]], [In
    the QoS 2 delivery protocol, the receiver, after it has sent a
    PUBCOMP, MUST treat any subsequent PUBLISH packet that contains that
    Packet Identifier as being a new Application Message, irrespective
    of the setting of its DUP flag.],
    [#box()<tab-MQTT-SN-4.4.1-1>\[#link(<MQTT-SN-4.4.1-1>)[MQTT‑SN‑4.4.1‑1]\]], [When
    a Client reconnects with Clean Start set to 0 and a Session is
    present, both the Client and Server MUST resend any unacknowledged
    PUBLISH with QoS 1 and 2 packets (not QoS 0) and PUBREL packets
    using their original Packet Identifiers.],
    [#box()<tab-MQTT-SN-4.4.1-2>\[#link(<MQTT-SN-4.4.1-2>)[MQTT‑SN‑4.4.1‑2]\]], [If
    PUBACK or PUBREC is received containing a Reason Code of 0x80 or
    greater, the corresponding PUBLISH packet is treated as
    acknowledged, and MUST NOT be retransmitted.],
    [#box()<tab-MQTT-SN-4.4.1-3>\[#link(<MQTT-SN-4.4.1-3>)[MQTT‑SN‑4.4.1‑3]\]], [The
    DUP flag MUST be set to 1 by the Client or Server when it attempts
    to resend a PUBLISH QoS 2 packet.],
    [#box()<tab-MQTT-SN-4.4.2-1>\[#link(<MQTT-SN-4.4.2-1>)[MQTT‑SN‑4.4.2‑1]\]], [CONNECT
    and AUTH Packets expect a response but MUST NOT be retried.],
    [#box()<tab-MQTT-SN-4.4.2-2>\[#link(<MQTT-SN-4.4.2-2>)[MQTT‑SN‑4.4.2‑2]\]], [The
    connection sequence CONNECT, zero or more AUTH Packets then CONNACK
    MUST be completed without retries.],
    [#box()<tab-MQTT-SN-4.4.2-3>\[#link(<MQTT-SN-4.4.2-3>)[MQTT‑SN‑4.4.2‑3]\]], [A
    Server MUST respond promptly to a valid request Packet.],
    [#box()<tab-MQTT-SN-4.4.2-4>\[#link(<MQTT-SN-4.4.2-4>)[MQTT‑SN‑4.4.2‑4]\]], [A
    Client in the Awake and Active states MUST respond promptly to a
    valid request Packet.],
    [#box()<tab-MQTT-SN-4.4.2-5>\[#link(<MQTT-SN-4.4.2-5>)[MQTT‑SN‑4.4.2‑5]\]], [In
    the absence of a response to a Packet which expects one, the Sender
    MUST delete the Virtual Connection if one exists.],
    [#box()<tab-MQTT-SN-4.4.2-6>\[#link(<MQTT-SN-4.4.2-6>)[MQTT‑SN‑4.4.2‑6]\]], [If
    a Packet is retransmitted, it MUST have Protection Encapsulation if
    the previously transmitted Packet had Protection Encapsulation.],
    [#box()<tab-MQTT-SN-4.4.2-7>\[#link(<MQTT-SN-4.4.2-7>)[MQTT‑SN‑4.4.2‑7]\]], [If
    a Packet is retransmitted it MUST be identical to the previously
    transmitted Packet, the DUP flag excepted. The Protection
    Encapsulation need not be identical.],
    [#box()<tab-MQTT-SN-4.5-1>\[#link(<MQTT-SN-4.5-1>)[MQTT‑SN‑4.5‑1]\]], [When
    a Server takes ownership of an incoming Application Message it MUST
    add it to the Session State for those Clients that have matching
    Subscriptions.],
    [#box()<tab-MQTT-SN-4.5-2>\[#link(<MQTT-SN-4.5-2>)[MQTT‑SN‑4.5‑2]\]], [The
    Client MUST acknowledge any PUBLISH packet it receives according to
    the applicable QoS rules regardless of whether it elects to process
    the Application Message that it contains.],
    [#box()<tab-MQTT-SN-4.6-1>\[#link(<MQTT-SN-4.6-1>)[MQTT‑SN‑4.6‑1]\]], [When
    a Server processes an Application Message that has been published to
    an Ordered Topic, it MUST send PUBLISH packets to consumers (for the
    same Topic and QoS) in the order that they were received from any
    given Client.],
    [#box()<tab-MQTT-SN-4.6-2>\[#link(<MQTT-SN-4.6-2>)[MQTT‑SN‑4.6‑2]\]], [By
    default, a Server MUST treat every Topic as an Ordered Topic when it
    is forwarding Application Messages.],
    [#box()<tab-MQTT-SN-4.7.1.1-1>\[#link(<MQTT-SN-4.7.1.1-1>)[MQTT‑SN‑4.7.1.1‑1]\]], [A
    Topic Name, the target of PUBWOS and PUBLISH packets, MUST NOT
    contain special wildcard characters.],
    [#box()<tab-MQTT-SN-4.7.1.1.2-1>\[#link(<MQTT-SN-4.7.1.1.2-1>)[MQTT‑SN‑4.7.1.1.2‑1]\]], [The
    multi-level wildcard character MUST be specified either on its own
    or following a topic level separator. In either case it MUST be the
    last character specified in the Topic Filter.],
    [#box()<tab-MQTT-SN-4.7.1.1.3-1>\[#link(<MQTT-SN-4.7.1.1.3-1>)[MQTT‑SN‑4.7.1.1.3‑1]\]], [The
    single-level wildcard can be used at any level in the Topic Filter,
    including first and last levels. Where it is used, it MUST occupy an
    entire level of the filter.],
    [#box()<tab-MQTT-SN-4.7.1.2-1>\[#link(<MQTT-SN-4.7.1.2-1>)[MQTT‑SN‑4.7.1.2‑1]\]], [The
    Server MUST NOT match Topic Filters starting with a wildcard
    character (\# or +) with Topic Names beginning with a \$
    character.],
    [#box()<tab-MQTT-SN-4.7.1.3-1>\[#link(<MQTT-SN-4.7.1.3-1>)[MQTT‑SN‑4.7.1.3‑1]\]], [All
    Topic Names and Topic Filters MUST be at least one character long.],
    [#box()<tab-MQTT-SN-4.7.1.3-2>\[#link(<MQTT-SN-4.7.1.3-2>)[MQTT‑SN‑4.7.1.3‑2]\]], [Topic
    Names and Topic Filters MUST NOT include the null character (Unicode
    U+0000)
    #link("https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#Unicode")[\[\[Unicode\]\]].],
    [#box()<tab-MQTT-SN-4.7.1.3-3>\[#link(<MQTT-SN-4.7.1.3-3>)[MQTT‑SN‑4.7.1.3‑3]\]], [Topic
    Names and Topic Filters are UTF-8 Encoded Strings; they MUST NOT
    encode to more than 65,535 bytes.],
    [#box()<tab-MQTT-SN-4.7.1.3-4>\[#link(<MQTT-SN-4.7.1.3-4>)[MQTT‑SN‑4.7.1.3‑4]\]], [When
    it performs subscription matching the Server MUST NOT perform any
    normalization of Topic Names or Topic Filters, or any modification
    or substitution of unrecognized characters.],
    [#box()<tab-MQTT-SN-4.7.2-1>\[#link(<MQTT-SN-4.7.2-1>)[MQTT‑SN‑4.7.2‑1]\]], [If
    a Topic Alias exists for a Topic Name, a Sender (Client or Server)
    MUST use that Topic Alias and not the Topic Name in any PUBLISH
    packet.],
    [#box()<tab-MQTT-SN-4.7.2-2>\[#link(<MQTT-SN-4.7.2-2>)[MQTT‑SN‑4.7.2‑2]\]], [A
    sender MUST NOT send any Control Packet containing a Predefined or
    Session Topic Alias which has the value 0.],
    [#box()<tab-MQTT-SN-4.7.2.1-1>\[#link(<MQTT-SN-4.7.2.1-1>)[MQTT‑SN‑4.7.2.1‑1]\]], [Predefined
    Topic Aliases MUST NOT change for the duration of any MQTT-SN
    Session.],
    [#box()<tab-MQTT-SN-4.7.2.1-2>\[#link(<MQTT-SN-4.7.2.1-2>)[MQTT‑SN‑4.7.2.1‑2]\]], [If
    a PUBLISH is sent to a Predefined Topic Alias which is not defined
    on the receiver it is a Protocol Error.],
    [#box()<tab-MQTT-SN-4.7.2.2-1>\[#link(<MQTT-SN-4.7.2.2-1>)[MQTT‑SN‑4.7.2.2‑1]\]], [Session
    Topic Aliases MUST be allocated on a per Session basis - they are
    not shared between Sessions either with the same Client or different
    Clients.],
    [#box()<tab-MQTT-SN-4.7.2.2-2>\[#link(<MQTT-SN-4.7.2.2-2>)[MQTT‑SN‑4.7.2.2‑2]\]], [If
    a Client subscribes to a Topic Filter which does not include
    wildcard characters, a Predefined or Session Topic Alias MUST be
    returned in the SUBACK packet.],
    [#box()<tab-MQTT-SN-4.7.2.2-3>\[#link(<MQTT-SN-4.7.2.2-3>)[MQTT‑SN‑4.7.2.2‑3]\]], [If
    a Client subscribes to a Topic Filter which includes wildcard
    characters, a Topic Alias (Predefined or Session) MUST NOT be
    returned in the SUBACK packet.],
    [#box()<tab-MQTT-SN-4.7.2.2-4>\[#link(<MQTT-SN-4.7.2.2-4>)[MQTT‑SN‑4.7.2.2‑4]\]], [A
    Session Topic Alias MUST NOT be allowed to map to the same Topic
    Name as a Predefined Topic Alias.],
    [#box()<tab-MQTT-SN-4.7.2.2-5>\[#link(<MQTT-SN-4.7.2.2-5>)[MQTT‑SN‑4.7.2.2‑5]\]], [If
    a Client requests a Session Topic Alias for a Topic Name which
    already has a Predefined Topic Alias, the Server MUST return a
    REGACK with the Topic Type "Predefined Topic Alias", the Predefined
    Topic Alias, and the Reason Code "Topic Alias Exists".],
    [#box()<tab-MQTT-SN-4.7.2.2-6>\[#link(<MQTT-SN-4.7.2.2-6>)[MQTT‑SN‑4.7.2.2‑6]\]], [A
    Session Topic alias and a Predefined Topic Alias with the same
    numerical value MUST map to different Topic Names.],
    [#box()<tab-MQTT-SN-4.9-1>\[#link(<MQTT-SN-4.9-1>)[MQTT‑SN‑4.9‑1]\]], [If
    a Client or Server receives an MQTT-SN request (from the above list)
    and there is already a request outstanding from the other party
    within the same Virtual Connection and a different Packet
    Identifier, then it MUST issue a DISCONNECT with Reason Code 147
    (Receive Maximum Exceeded) and delete the Virtual Connection.],
    [#box()<tab-MQTT-SN-4.9-2>\[#link(<MQTT-SN-4.9-2>)[MQTT‑SN‑4.9‑2]\]], [A
    Server or Client MUST NOT send a new Packet of a type from the above
    list, when it has an acknowledgement outstanding for another Packet
    for which it has not received an acknowledgement.],
    [#box()<tab-MQTT-SN-4.11.1-1>\[#link(<MQTT-SN-4.11.1-1>)[MQTT‑SN‑4.11.1‑1]\]], [If
    the Server does not support the Authentication Method supplied by
    the Client, it MAY send a CONNACK with a Reason Code of 0x8C (Bad
    authentication method) or 0x87 (Not Authorized) as described in
    #link(<reason-code>)[2.3 "Reason Code"] and MUST delete the Virtual
    Connection.],
    [#box()<tab-MQTT-SN-4.11.1-2>\[#link(<MQTT-SN-4.11.1-2>)[MQTT‑SN‑4.11.1‑2]\]], [If
    the Server requires additional information to complete the
    authentication, it can send an AUTH packet to the Client. This
    packet MUST contain a Reason Code of 0x18 (Continue
    authentication).],
    [#box()<tab-MQTT-SN-4.11.1-3>\[#link(<MQTT-SN-4.11.1-3>)[MQTT‑SN‑4.11.1‑3]\]], [The
    Client responds to an AUTH packet from the Server by sending a
    further AUTH packet. This packet MUST contain a Reason Code of 0x18
    (Continue authentication).],
    [#box()<tab-MQTT-SN-4.11.1-4>\[#link(<MQTT-SN-4.11.1-4>)[MQTT‑SN‑4.11.1‑4]\]], [The
    Server can reject the authentication at any point in this process.
    It MUST send a CONNACK with a Reason Code of 0x80 or above as
    described in #link(<handling-errors>)[4.12 "Handling errors"].],
    [#box()<tab-MQTT-SN-4.11.1-5>\[#link(<MQTT-SN-4.11.1-5>)[MQTT‑SN‑4.11.1‑5]\]], [If
    the initial CONNECT packet included an Authentication Method then
    all AUTH packets, and any successful CONNACK packet MUST include an
    Authentication Method with the same value as in the CONNECT
    packet.],
    [#box()<tab-MQTT-SN-4.11.1-6>\[#link(<MQTT-SN-4.11.1-6>)[MQTT‑SN‑4.11.1‑6]\]], [If
    the Client does not include an Authentication Method in the CONNECT,
    the Server MUST NOT send an AUTH packet, and it MUST NOT send an
    Authentication Method in the CONNACK packet.],
    [#box()<tab-MQTT-SN-4.11.1-7>\[#link(<MQTT-SN-4.11.1-7>)[MQTT‑SN‑4.11.1‑7]\]], [f
    the Client does not include an Authentication Method in the CONNECT,
    the Client MUST NOT send an AUTH packet to the Server.],
    [#box()<tab-MQTT-SN-4.11.1.1-1>\[#link(<MQTT-SN-4.11.1.1-1>)[MQTT‑SN‑4.11.1.1‑1]\]], [If
    the Client supplied an Authentication Method in the CONNECT packet,
    it can initiate a re-authentication at any time after receiving a
    CONNACK. It does this by sending an AUTH packet with a Reason Code
    of 0x19 (Re-authentication). The Client MUST set the Authentication
    Method to the same value as the Authentication Method originally
    used to authenticate the Virtual Connection.],
    [#box()<tab-MQTT-SN-4.11.1.1-2>\[#link(<MQTT-SN-4.11.1.1-2>)[MQTT‑SN‑4.11.1.1‑2]\]], [If
    the re-authentication fails, the Client or Server MUST send
    DISCONNECT with an appropriate Reason Code as described in
    #link(<handling-errors>)[4.12 "Handling errors"], and MUST delete
    the Virtual Connection.],
    [#box()<tab-MQTT-SN-4.12.1-1>\[#link(<MQTT-SN-4.12.1-1>)[MQTT-SN-4.12.1-1]\]], [When
    a Client detects a Malformed Packet or Protocol Error associated
    with a Virtual Connection it SHOULD send a DISCONNECT packet
    containing an appropriate Reason Code and MUST delete the associated
    Virtual Connection.],
    [#box()<tab-MQTT-SN-4.12.1-2>\[#link(<MQTT-SN-4.12.1-2>)[MQTT‑SN‑4.12.1‑2]\]], [When
    a Server detects a Malformed Packet or Protocol Error for any packet
    except ADVERTISE, SEARCHGW, GWINFO, PUBWOS and CONNECT, the Server
    MAY send a DISCONNECT packet with an appropriate Reason Code and
    MUST delete the associated Virtual Connection if one exists.],
    [#box()<tab-MQTT-SN-4.12.2-1>\[#link(<MQTT-SN-4.12.2-1>)[MQTT-SN-4.12.2-1]\]], [The
    CONNACK and DISCONNECT packets allow a Reason Code of 0x80 or
    greater to indicate that the Virtual Connection will be deleted. If
    a Reason Code of 0x80 or greater is specified, then the Virtual
    Connection MUST be deleted whether or not the CONNACK or DISCONNECT
    is sent.],
    [#box()<tab-MQTT-SN-4.13-1>\[#link(<MQTT-SN-4.13-1>)[MQTT‑SN‑4.13‑1]\]], [If
    the RETAIN flag is set to 1 in a PUBLISH or PUBWOS packet received
    by a Server, the Server MUST replace any existing Retained Message
    for this topic and store the Application Message.],
    [#box()<tab-MQTT-SN-4.13-2>\[#link(<MQTT-SN-4.13-2>)[MQTT‑SN‑4.13‑2]\]], [If
    the Publish Data contains zero bytes it is processed normally by the
    Server but any retained message with the same topic name MUST be
    removed and any future subscribers for the topic will not receive a
    retained message.],
    [#box()<tab-MQTT-SN-4.13-3>\[#link(<MQTT-SN-4.13-3>)[MQTT‑SN‑4.13‑3]\]], [A
    Retained Message with a Publish Data containing zero bytes MUST NOT
    be stored as a Retained Message on the Server.],
    [#box()<tab-MQTT-SN-4.13-4>\[#link(<MQTT-SN-4.13-4>)[MQTT‑SN‑4.13‑4]\]], [If
    the RETAIN flag is 0 in a PUBLISH packet sent by a Client to a
    Server, the Server MUST NOT store the message as a Retained Message
    and MUST NOT remove or replace any existing Retained Message.],
    [#box()<tab-MQTT-SN-4.13-5>\[#link(<MQTT-SN-4.13-5>)[MQTT‑SN‑4.13‑5]\]], [If
    Retain Handling is set to 0 the Server MUST send the retained
    messages matching the Topic Filter of the subscription to the
    Client.],
    [#box()<tab-MQTT-SN-4.13-6>\[#link(<MQTT-SN-4.13-6>)[MQTT‑SN‑4.13‑6]\]], [If
    Retain Handling is set to 1 then if the subscription did not already
    exist, the Server MUST send all retained messages matching the Topic
    Filter of the subscription to the Client, and if the subscription
    did exist the Server MUST NOT send the retained messages.],
    [#box()<tab-MQTT-SN-4.13-7>\[#link(<MQTT-SN-4.13-7>)[MQTT‑SN‑4.13‑7]\]], [If
    Retain Handling is set to 2, the Server MUST NOT send the retained
    messages.],
    [#box()<tab-MQTT-SN-4.13-8>\[#link(<MQTT-SN-4.13-8>)[MQTT‑SN‑4.13‑8]\]], [If
    the value of Retain As Published subscription option is set to 0,
    the Server MUST set the RETAIN flag to 0 when forwarding an
    Application Message regardless of how the RETAIN flag was set in the
    received PUBLISH packet.],
    [#box()<tab-MQTT-SN-4.13-9>\[#link(<MQTT-SN-4.13-9>)[MQTT‑SN‑4.13‑9]\]], [If
    the value of Retain As Published subscription option is set to 1,
    the Server MUST set the RETAIN flag equal to the RETAIN flag in the
    received PUBLISH packet.],
    [#box()<tab-MQTT-SN-4.14-1>\[#link(<MQTT-SN-4.14-1>)[MQTT‑SN‑4.14‑1]\]], [A
    Server MUST treat any Packet other than PUBWOS or CONNECT that it
    receives from a Client in None or Disconnected states as a protocol
    error.],
    [#box()<tab-MQTT-SN-4.14-2>\[#link(<MQTT-SN-4.14-2>)[MQTT‑SN‑4.14‑2]\]], [In
    the Asleep state, a Client MUST only send PINGREQ, CONNECT or
    DISCONNECT packets to the Server.],
    [#box()<tab-MQTT-SN-4.14-3>\[#link(<MQTT-SN-4.14-3>)[MQTT‑SN‑4.14‑3]\]], [In
    the Awake state, a Client MUST not send ANY packets other than those
    involved in the receipt of PUBLISH packets (PUBACK, PUBREC, PUBCOMP,
    REGACK) or CONNECT or DISCONNECT.],
    [#box()<tab-MQTT-SN-4.14-4>\[#link(<MQTT-SN-4.14-4>)[MQTT‑SN‑4.14‑4]\]], [Whenever
    a CONNECT is received by a Server, any existing Virtual Connection
    for that Client MUST be deleted and a new one created with all
    CONNECT Packet processing, regardless of the state of the Client.],
    [#box()<tab-MQTT-SN-4.14.2-1>\[#link(<MQTT-SN-4.14.2-1>)[MQTT‑SN‑4.14.2‑1]\]], [If
    the Server does not receive an MQTT-SN Control Packet from an Asleep
    Client within the Sleep Duration plus a suitable grace period, it
    MUST delete the Virtual Connection to the Client.],
    [#box()<tab-MQTT-SN-4.14.2-2>\[#link(<MQTT-SN-4.14.2-2>)[MQTT‑SN‑4.14.2‑2]\]], [During
    the Asleep state, packets that need to be sent to the client are
    buffered at the Server. The Server MUST buffer Application Messages
    of QoS 1 and 2.],
    [#box()<tab-MQTT-SN-4.14.2-3>\[#link(<MQTT-SN-4.14.2-3>)[MQTT‑SN‑4.14.2‑3]\]], [If
    the Maximum Number of Awake Messages (N) set by the client is
    greater than 0, the server MUST NOT send more than N application
    messages in any one awake period for that client.],
    [#box()<tab-MQTT-SN-4.14.2-4>\[#link(<MQTT-SN-4.14.2-4>)[MQTT‑SN‑4.14.2‑4]\]], [After
    sending the Maximum Number of Awake Messages Application Messages,
    the Server cuts short the AWAKE cycle, and MUST respond with a
    PINGRESP with a messages-left value of either the number of
    Application Messages remaining in the Server buffer or 0xFF (meaning
    undetermined number of Application Messages greater than 0
    remaining).],
    [#box()<tab-MQTT-SN-4.14.2-5>\[#link(<MQTT-SN-4.14.2-5>)[MQTT‑SN‑4.14.2‑5]\]], [During
    the Awake state, for each Application Message the Server sends to
    the Client, the application messages' quality of service MUST be
    honored - a full packet interaction MUST take place including all
    normative phases of acknowledgement, including any associated
    retransmission logic.],
    [#box()<tab-MQTT-SN-4.14.2-6>\[#link(<MQTT-SN-4.14.2-6>)[MQTT‑SN‑4.14.2‑6]\]], [If,
    during the delivery of Application Messages from the Server to the
    Client, and applying the
    #link(<unacknowledged-packets>)[retry logic], the Server gets no
    response, it MUST consider the Client disconnected and delete the
    Virtual Connection.],
    [#box()<tab-MQTT-SN-4.14.2-7>\[#link(<MQTT-SN-4.14.2-7>)[MQTT‑SN‑4.14.2‑7]\]], [If
    the Server does not have any packets buffered for the client, it
    MUST respond immediately with a PINGRESP packet.],
  )]
  , caption: [Numbered conformance statements]
  , kind: table
  )
<tab-numbered-conformance-statements>

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Appendix C. Implementation Guidance
(Informative)]
<appendix-c.-implementation-guidance-informative>
#heading(level: 2, numbering: none)[C.1 Example MQTT-SN Architectures]
<c.1-example-mqtt-sn-architectures>
Among the kinds of MQTT-SN components, there are #emph[Clients and
Servers] (sub-divided into #emph[Gateways, Brokers and Forwarders)].

MQTT-SN Clients can:

+ connect to a Server

+ communicate with an MQTT Server through an MQTT-SN Gateway

+ send and receive messages to and from other MQTT-SN Clients through a
  Server which is acting as an MQTT-SN Broker

+ send and receive messages without connecting to a Server by using
  PUBWOS packets.

An MQTT-SN Server may or may not communicate with an MQTT Server. An
MQTT-SN Gateway is a Server which connects to an MQTT Server back end.
An MQTT-SN Gateway uses the MQTT protocol between itself and the MQTT
Server. A Server which acts as an intermediary between MQTT-SN Clients
is called a Broker. If a Server does not act as a Broker itself but is
connected to an MQTT Server, the Gateway's main function is the
translation between MQTT and MQTT-SN.

If the Gateway is not directly attached to the Clients' network, MQTT-SN
Clients can communicate with a Gateway through an MQTT-SN Forwarder. The
forwarder encapsulates (see
#link(<forwarder-encapsulation>)[3.19 "Forwarder Encapsulation"]) the
MQTT-SN frames it receives on the Client side and forwards them
unchanged to the Gateway; in the opposite direction, it removes the
encapsulation from the frames it receives from the Gateway and sends
them unchanged to the Clients.

#heading(level: 3, numbering: none)[C.1.1 Transparent Gateway]
<c.1.1-transparent-gateway>
For each connected MQTT-SN Client a Transparent Gateway will set up and
maintain an MQTT connection to the MQTT server. This MQTT connection is
reserved exclusively for the end-to-end and almost transparent packet
exchange between the Client and the MQTT Server. There will be as many
MQTT connections between the Gateway and the MQTT Server as MQTT-SN
clients connected to the Gateway. The Transparent Gateway will perform a
translation between the two protocols. Since all packet exchanges are
end-to-end between the MQTT-SN client and the MQTT Server, functions and
features that are implemented by the MQTT Server can be offered to the
MQTT-SN Client.

Although the implementation of the Transparent Gateway may be somewhat
simpler than an Aggregating Gateway, it requires the MQTT Server to
support a separate connection for each active Client. Some MQTT Server
implementations might impose a limitation on the number of concurrent
connections that they support.

\[figure below is part of informative example\]
#box(image("images/image40.png", alt: "Transparent Gateway"))

Because PUBWOS packets could be sent at any time by Clients with no
Virtual Connection, a Transparent Gateway would need to maintain a
dedicated MQTT connection with the MQTT Server to support those packets.

#heading(level: 3, numbering: none)[C.1.2 Aggregating Gateway]
<c.1.2-aggregating-gateway>
Instead of having one MQTT connection for each connected MQTT-SN Client,
an aggregating Gateway has one MQTT connection to the MQTT Server. All
packet exchanges between an MQTT-SN client and an aggregating Gateway
end at the Gateway. The Gateway then decides which information will be
given further to the MQTT Server. Although its implementation may be
more complex than a transparent Gateway, an aggregating Gateway reduces
the number of MQTT connections between the Gateway and MQTT Server.

#figure(image("images/image10.png", alt: "Aggregating Gateway"),
  caption: [
    Aggregating Gateway
  ]
)
<fig-aggregating-gateway>

To support PUBWOS packets from MQTT-SN clients without a Virtual
Connection, an Aggregating may use any aggregating MQTT connection to
forward those packets to an MQTT Server.

A hybrid Gateway may contain elements of both Aggregating and
Transparent Gateways, using different approaches depending on the
characteristics of the MQTT-SN Clients connecting to them.

#heading(level: 3, numbering: none)[C.1.3 Forwarder]
<c.1.3-forwarder>
An MQTT-SN Forwarder connects two networks which cannot transmit
messages directly to and from each other. It serves as a bridge for
MQTT-SN messages between the two networks, allowing MQTT-SN Clients in
one to connect to an MQTT-SN Gateway in the other. The two networks
could be Zigbee on one side and UDP on the other, for instance.

The following diagrams illustrate how a Forwarder may interact with an
Aggregating or Transparent Gateway.

#figure(image("images/image22.png", alt: "Forwarder with Transparent Gateway"),
  caption: [
    Forwarder with Transparent Gateway
  ]
)
<fig-forwarder-with-transparent-gateway>

#figure(image("images/image29.png", alt: "Forwarder with Aggregating Gateway"),
  caption: [
    Forwarder with Aggregating Gateway
  ]
)
<fig-forwarder-with-aggregating-gateway>

#heading(level: 3, numbering: none)[C.1.4 MQTT-SN Broker]
<c.1.4-mqtt-sn-broker>
An MQTT-SN Server may have no interaction with an MQTT Server, in which
case, much like an MQTT Server, it will act as an intermediary between
MQTT-SN Clients.

It will allow MQTT-SN Clients to set up subscriptions, and publish
messages to other clients which have subscribed to the relevant topics.
It may support the receipt and sending of PUBWOS packets - it is an
implementation decision on how to handle them.

#figure(image("images/image37.png", alt: "MQTT-SN Broker"),
  caption: [
    MQTT-SN Broker
  ]
)
<fig-mqtt-sn-broker>

An MQTT-SN Server may choose to incorporate elements of a Broker,
Aggregating and Transparent Gateway together. Typically, an Aggregating
Gateway will also act as an MQTT-SN Broker.

#heading(level: 2, numbering: none)[C.2 Server Congestion]
<c.2-server-congestion>
For CONNECT, PUBLISH, SUBSCRIBE and REGISTER requests, the Server may
return the Reason Code #emph[Congestion], meaning #emph[try again
later].

The requester should wait a reasonable amount of time
(#emph[\[Congestion Delay)\]] before sending a new request to the
Server. What constitutes #emph[a reasonable amount of time] depends on
the implementation characteristics - it should be configured in the
client application based on those. See
#link(<c.3-example-timer-and-counter-values>)[C.3 "Example Timer and Counter Values"]
for an example value.

#heading(level: 2, numbering: none)[C.3 Example Timer and Counter
Values]
<c.3-example-timer-and-counter-values>
#link(<tab-best-practice-values-for-timers-and-counters>)[Table 17]
gives some values for the timers and counters defined in this
specification derived from implementation experience.

#figure(
  align(center)[#table(
    columns: (9.13%, 21.3%, 69.57%),
    align: (left,left,left,),
    table.header([Name], [Where Defined], [Example Value],),
    table.hline(),
    [Advertise
    Duration], [#link(<c.7-gateway-advertisement-and-discovery>)[C.7 "Gateway Advertisement and Discovery"]], [Greater
    than 15 minutes],
    [Advertise
    Count], [#link(<c.7-gateway-advertisement-and-discovery>)[C.7 "Gateway Advertisement and Discovery"]], [2
    \- 3],
    [SEARCHGW
    Delay], [#link(<c.7-gateway-advertisement-and-discovery>)[C.7 "Gateway Advertisement and Discovery"]], [5
    seconds],
    [GWINFO
    Delay], [#link(<c.7-gateway-advertisement-and-discovery>)[C.7 "Gateway Advertisement and Discovery"]], [5
    seconds],
    [Congestion
    Delay], [#link(<c.2-server-congestion>)[C.2 "Server Congestion"]], [Greater
    than 5 minutes],
    [Retry
    Interval], [#link(<unacknowledged-packets>)[4.4.2 "Unacknowledged Packets"]], [Implement
    #link(<c.4-exponential-backoff>)[C.4 "Exponential Backoff"] with a
    starting value of 1 second after an initial wait period of 5
    seconds. So the first retry will be \~6 seconds.],
    [Max. Retry
    Count], [#link(<unacknowledged-packets>)[4.4.2 "Unacknowledged Packets"]], [3
    -- 5],
    [Max. Retry
    Interval], [#link(<c.4-exponential-backoff>)[C.4 "Exponential Backoff"]], [60
    seconds],
  )]
  , caption: [Best practice values for timers and counters]
  , kind: table
  )
<tab-best-practice-values-for-timers-and-counters>

#heading(level: 2, numbering: none)[C.4 Exponential Backoff]
<c.4-exponential-backoff>
The #emph[Retry Interval] for unacknowledged packets can be increased on
each retry, to avoid overwhelming recipient network nodes while allowing
efficient Virtual Connection reestablishment. The client periodically
retries a failed packet with increasing delays between attempts,
constrained by a Maximum Retry Interval, interleaved with a suitable
seed of randomness.

#strong[Algorithm:]

This algorithm retries requests at doubling intervals, increasing time
between retries up to a #emph[Maximum Retry Interval]. For example:

+ Send initial packet sent. The initial #emph[Retry Interval] is 1000
  ms.

+ Wait up to 1000 + (random number) ms - retry the operation if no
  response is received during that time.

+ Wait up to 2000 + (random number) ms - retry the operation if no
  response is received during that time.

+ Wait up to 4000 + (random number) ms - retry the operation if no
  response is received during that time.

+ Continue increasing the #emph[Retry Interval] each time, but no larger
  than #emph[Max. Retry Interval.]

+ Continue waiting and retrying up to #emph[Max. Retry Count] number of
  retries, without increasing the #emph[Retry Interval] further.

The wait time is (ran is a random number, max is #emph[Max. Retry
Interval]):

min(((2^n \* sf) + ran), max)

with n incremented by 1 for each iteration (or operation) and the
scaling factor (sf) being set to some reasonable value - for example
1000 as in the example above.

The random number helps to avoid cases where many clients are
synchronized by some situation, and all retry at once. The value of the
random number ran is recalculated after each retry. The random number
should be no larger than the initial #emph[Retry Interval].

#heading(level: 2, numbering: none)[C.5 Client State Diagrams]
<c.5-client-state-diagrams>
The following diagrams are illustrative, graphical views of the states
and transitions. They are not comprehensive but included for guidance.

#figure(image("images/ClientState.png", alt: "Server View of Client States - informative"),
  caption: [
    Server View of Client States - informative
  ]
)
<fig-server-view-of-client-states-informative>

#figure(image("images/ServerState.png", alt: "Server View of Client States - informative"),
  caption: [
    Server View of Client States - informative
  ]
)
<fig-server-view-of-client-states-informative-2>

#heading(level: 2, numbering: none)[C.6 PUBLISH with QoS -1]
<c.6-publish-with-qos--1>
#figure(image("images/publish-qos-minus-1-packet-diagram.png", alt: "PUBLISH Packet for QoS -1"),
  caption: [
    PUBLISH Packet for QoS -1
  ]
)
<fig-publish-packet-for-qos-1>

This packet is the MQTT-SN 1.2 equivalent of PUBWOS. It could be
supported by a Server if there are existing MQTT-SN 1.2 transmitters
that the Server wants to listen to, or receivers it wants to send to.
Implementation of this packet is optional.

This packet can be used by both Clients and Servers to publish data to a
topic without establishing a Virtual Connection or Session.

#heading(level: 3, numbering: none)[C.6.1 PUBLISH Header]
<c.6.1-publish-header>
The first 2 or 4 bytes of the packet are encoded according to the
variable length packet header format. Refer to
#link(<structure-of-an-mqtt-sn-control-packet>)[2.1 "Structure of an MQTT-SN Control Packet"]
for a detailed description.

However, the Packet Types in MQTT-SN 1.2 are different. The 1.2 Packet
Type for PUBLISH is 0x0C.

#heading(level: 3, numbering: none)[C.6.2 PUBLISH Flags]
<c.6.2-publish-flags>
The PUBLISH Flags is a 1 byte field which contains flags specifying the
content of the packet and the Server behavior. Bits 3-2 of the PUBLISH
Flags are reserved and are set to 0.

The Client validates that the reserved flags in the PUBLISH packet are
set to 0. If any of the reserved flags is not 0 it is a Malformed
Packet.

#heading(level: 4, numbering: none)[C.6.2.1 Topic Type]
<c.6.2.1-topic-type>
#strong[Position]: bits 0 and 1 of the PUBLISH Flags.

This determines the format of the Topic Data field.

The Topic Type in MQTT-SN 1.2 is different to that in MQTT-SN 2.0. The
values applicable to PUBLISH QoS -1 are:

- 0b00 - Topic Name. Its length is defined in the Topic Name Length
  field.

- 0b01 - Predefined Topic Alias.

- 0b10 - Short Topic Name. A two byte Topic Name, with the same syntax
  as Topic Name. However, some 1.2 implementations treated this as a
  binary field.

#heading(level: 4, numbering: none)[C.6.2.2 QoS]
<c.6.2.2-qos>
#strong[Position]: bits 5 and 6 of the PUBLISH Flags.

Set this field to "0b11" for QoS -1.

#heading(level: 4, numbering: none)[C.6.2.3 DUP]
<c.6.2.3-dup>
#strong[Position]: bit 7 of the PUBLISH Flags.

Set to 0.

#heading(level: 4, numbering: none)[C.6.2.4 Retain]
<c.6.2.4-retain>
#strong[Position]: bit 4 of the PUBLISH Flags.

This flag signifies whether the message is published as a retained
message or not. See #link(<retained-messages>)[4.13 "Retained Messages"]
for more information.

#heading(level: 3, numbering: none)[C.6.3 Topic Alias]
<c.6.3-topic-alias>
Only present if the Topic Type is Predefined Topic Alias. Contain a
Topic Alias which is preconfigured to be known to both the sender and
receiver.

#heading(level: 3, numbering: none)[C.6.4 Topic Short Name]
<c.6.4-topic-short-name>
Only present if the Topic Type is Short Topic Name.

This is a two byte Topic Name. This Topic Type does not exist in later
versions of MQTT-SN. It existed because the original MQTT-SN 1.2 did not
allow a Long Topic Name, so the only other option for this packet was a
Predefined Topic Alias.

#heading(level: 3, numbering: none)[C.6.5 Topic Name Length]
<c.6.5-topic-name-length>
Only present if the Topic Type is Topic Name.

The length of the Topic Name field.

#heading(level: 3, numbering: none)[C.6.6 Topic Name]
<c.6.6-topic-name>
Only present if the Topic Type is Topic Name.

Topic Name is a UTF-8 encoded string of length Topic Name Length.

#heading(level: 3, numbering: none)[C.6.7 Payload]
<c.6.7-payload>
The Payload contains the payload data of the Application Message that is
being published. The content and format of the data is application
specific. It is valid for a PUBLISH packet to contain a zero length
Payload.

#heading(level: 3, numbering: none)[C.6.8 PUBLISH with QoS -1 Actions]
<c.6.8-publish-with-qos--1-actions>
The Client or Server uses a PUBLISH QoS -1 packet to send an Application
Message to a Network Address, for possible receipt by a Server or
another Client.

If received by a Client or Server, the PUBLISH QoS -1 packet is treated
as if its QoS were 0 as described in
#link(<publish-actions>)[3.6.2.7 "PUBLISH Actions"].

#heading(level: 2, numbering: none)[C.7 Gateway Advertisement and
Discovery]
<c.7-gateway-advertisement-and-discovery>
Clients might have foreknowledge of how to reach a Gateway, but in
dynamic networks they may not. MQTT-SN supports mechanisms to allow
Clients to find available MQTT-SN Gateways. This support is optional -
it may not be needed. In some implementations, the underlying network
technology might be used for this purpose instead.

In MQTT-SN there are two principal ways for Clients and Gateways to find
each other:

+ The Gateway can periodically transmit, or broadcast, an ADVERTISE
  packet to its neighborhood.

+ The Client can elicit a response from one or more Gateways, or Clients
  which know the network location of a Gateway, by broadcasting a
  SEARCHGW packet. The response, from either a Gateway or a Client on
  the Gateway's behalf, is a GWINFO packet.

A Gateway should only advertise its presence, or respond to SEARCHGW
requests, if it is able to accept subscriptions and forward messages.
For instance, a
#link(<c.1.1-transparent-gateway>)[C.1.1 "Transparent Gateway"] which is
not currently connected to an MQTT Server, should not advertise.

Multiple Gateways may be active at the same time in the same network, in
which case they will have different identifiers. It is up to the Client
to decide to which Gateway it wants to connect.

A Client can maintain a list of active Gateways together with their
network addresses. This list is populated with the information from
ADVERTISE and GWINFO packets received.

The time until the Gateway sends the next ADVERTISE packet is indicated
in the #emph[Duration] field of the ADVERTISE packet (#emph[\[Advertise
Duration\]]). A Client may use this information to monitor the
availability of a Gateway. For example, if it does not receive ADVERTISE
packets from a Gateway several times (#emph[\[Advertise Count\]])
consecutively, it may assume that the Gateway is down and remove it from
its list of active Gateways. Similarly, Gateways in stand-by mode can
become active (and start sending ADVERTISE packets) if they fail to
observe successive advertisements from a previously active Gateway.

If the ADVERTISE packets are broadcast into the whole wireless network,
the time interval between two consecutive ADVERTISE packets sent by a
gateway should be large enough (greater than 15 minutes for example) to
avoid bandwidth congestion in the network.

A large interval between ADVERTISE packets can lead to a long waiting
time for new Clients which are looking for a Gateway. To shorten this
waiting time a client may send a SEARCHGW packet. To prevent network
flooding when multiple clients start searching for a Gateway almost at
the same time, the sending of the SEARCHGW packet can be delayed by a
random time #emph[\[SEARCHGW Delay\]]. A client can cancel its
transmission of the SEARCHGW packet if it receives during this delay
time a SEARCHGW packet sent by another client and identical to the one
it wants to send, and behaves as if the SEARCHGW packet was sent by
itself.

Upon receiving a SEARCHGW packet a Gateway replies with a GWINFO packet
containing its identifier. Similarly, a Client can answer with a GWINFO
packet if it has at least one item in its active Gateway list. If the
Client has multiple Gateways in its list, it can select one Gateway out
of its list and include that information in the GWINFO packet.

To give priority to Gateways a client delays its sending of the GWINFO
packet for a random time #emph[\[GWINFO Delay\]]. If during this delay
the Client receives a GWINFO packet it cancels the sending of its own
GWINFO packet.

If there is no response, the SEARCHGW packet may be retransmitted. In
this case the time intervals between consecutive SEARCHGW packets should
be increased by an exponential backoff algorithm such as that described
in #link(<c.4-exponential-backoff>)[C.4 "Exponential Backoff"].

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Appendix D. Revision History
(informative)]
<revision-history-informative>
Revision tracking is publicly available in the version control system at
#link("https://github.com/oasis-tcs/mqtt/commits/main").
