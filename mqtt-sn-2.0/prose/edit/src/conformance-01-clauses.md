## Conformance clauses{#conformance-clauses}

### MQTT-SN Server conformance clause{#mqtt-sn-server-conformance-clause}

Refer to [sec](#terminology) for a definition of Server.

An MQTT-SN Server conforms to this specification only if it satisfies all the statements below:

1.  The format of all MQTT-SN Control Packets that the Server sends matches the format described in [sec](#mqtt-sn-control-packet-format) and [sec](#mqtt-sn-control-packets).

2.  It follows the Topic matching rules described in [sec](#topic-names-and-topic-filters) and the Subscription rules in [sec](#subscriptions).

3.  It satisfies the MUST level requirements in the following chapters that are identified except for those that only apply to the Client:

    - [sec](#introduction)

    - [sec](#mqtt-sn-control-packet-format)

    - [sec](#mqtt-sn-control-packets)

    - [sec](#operational-behavior)

4.  It does not require the use of any extensions defined outside of the specification in order to interoperate with any other conformant implementation.

### MQTT-SN Client conformance clause{#mqtt-sn-client-conformance-clause}

Refer to [sec](#terminology) for a definition of Client.

An MQTT-SN Client conforms to this specification only if it satisfies all the statements below:

1.  The format of all MQTT-SN Control Packets that the Client sends matches the format described in [sec](#mqtt-sn-control-packet-format) and [sec](#mqtt-sn-control-packets).

2.  It follows the Topic matching rules described in [sec](#topic-names-and-topic-filters) and the Subscription rules in [sec](#subscriptions).

3.  It satisfies the MUST level requirements in the following chapters that are identified except for those that only apply to the Server:

    - [sec](#introduction)

    - [sec](#mqtt-sn-control-packet-format)

    - [sec](#mqtt-sn-control-packets)

    - [sec](#operational-behavior)

4.  It does not require the use of any extensions defined outside of the specification in order to interoperate with any other conformant implementation.
