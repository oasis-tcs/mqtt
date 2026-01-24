## Introduction{#si---introduction}

MQTT-SN is a transport protocol specification for message transmission, allowing implementers a choice of network, privacy, authentication and authorization technologies. Since the exact security technologies chosen will be context specific, it is the implementer\'s responsibility to include the appropriate features as part of their design.

MQTT-SN solutions are likely to also include MQTT communications - this section should be read alongside the Security chapters in the MQTT standards: [[MQTT 3.1.1]](https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html) and [[MQTT 5.0]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html).

MQTT-SN implementations will likely need to keep pace with an evolving security landscape. This Chapter provides general implementation guidance so as not to restrict choices available. Examples of threats that solution providers should consider are:

- Devices could be compromised

- Data at rest in Clients and Servers might be accessible

- Protocol behaviors could have side effects - "timing attacks" for example

- Denial of Service (DoS) attacks

- Communications could be intercepted, altered, re-routed or disclosed

- Injection of spoofed MQTT-SN Control Packets

When MQTT-SN solutions are deployed in hostile communication environments, implementations will often need to provide mechanisms for:

- Authentication of users and devices

- Authorization of access to Server resources

- Integrity of MQTT-SN Control Packets and application data contained therein

- Privacy of MQTT-SN Control Packets and application data contained therein

In addition to technical security issues there could also be geographic (for example U.S.-EU Privacy Shield Framework [[\[USEUPRIVSH\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#USEUPRIVSH)), industry specific (for example PCI DSS [[\[PCIDSS\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#PCIDSS)) and regulatory considerations (for example Sarbanes-Oxley [[\[SARBANES\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#SARBANES)).
