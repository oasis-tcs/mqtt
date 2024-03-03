<!--
---
toc:
  auto: false
  label: Security and Privacy Considerations
  enumerate: Appendix B.
  children:
  - label: Industry specific security profiles
    enumerate: B.1
---
-->
# Security and Privacy Considerations

<!--
Note: OASIS strongly recommends that Technical Committees consider issues that might affect safety, security, privacy,
and/or data protection in implementations of their work products and document these for implementers and adopters.
For some purposes, you may find it required, e.g. if you apply for IANA registration.

While it may not be immediately obvious how your work product might make systems vulnerable to attack, most work products,
because they involve communications between systems, message formats, or system settings, open potential channels for exploit.
For example, IETF [RFC3552] lists "eavesdropping, replay, message insertion, deletion, modification, and man-in-the-middle"
as well as potential denial of service attacks as threats that must be considered and, if appropriate, addressed in IETF RFCs.

In addition to considering and describing foreseeable risks, this section should include guidance on how implementers and
adopters can protect against these risks.

We encourage editors and TC members concerned with this subject to read Guidelines for Writing RFC Text on Security Considerations,
IETF [RFC3552], for more information.
-->
The MQTT SN protocol is optimized for implementation on low-cost,
battery-powered devices with limited processing and storage resources.
The capabilities are kept simple and the specification allows for partial implementations.
Device identities are typically created at manufacturing, eliminating the need for special configuration at deployment.
MQTT-SN can work in isolation from other networks or in conjunction with MQTT.

MQTT-SN Client and Gateway/Server implementations SHOULD offer Authentication and Authorization options.
Furthermore, the confidentiality and authenticity of the MQTT-SN messages can be provided by the underlying transport or
can be obtained by encapsulating the MQTT-SN messages into the PROTECTION packet.

Applications concerned with critical infrastructure, personally identifiable information,
or other personal or sensitive information are strongly advised to use these security capabilities.

## Industry specific security profiles

It is anticipated that the MQTT protocol will be designed into industry specific application profiles,
each defining a threat model and the specific security mechanisms to be used to address these threats.
Recommendations for specific security mechanisms will often be taken from existing works including:
<!-- transformation-note: listed below entries in informative references A.2 and moved code to the end of the list items. -->

- NIST Cyber Security Framework \[NISTCSF] 
- NISTIR 7628 Guidelines for Smart Grid Cyber Security \[NIST7628]
- Security Requirements for Cryptographic Modules (FIPS PUB 140-2) \[FIPS1402]
- PCI-DSS Payment Card Industry Data Security Standard \[PCIDSS]
- NSA Suite B Cryptography \[NSAB]
