## Conformance clauses{#conformance-clauses}

### MQTT-SN Server conformance clause{#mqtt-sn-server-conformance-clause}

Refer to [[1.3 Terminology]](#terminology) for a definition of Server.

An MQTT-SN Server conforms to this specification only if it satisfies all the statements below:

1.  The format of all MQTT-SN Control Packets that the Server sends matches the format described in [[2 MQTT-SN Control Packet format]](#mqtt-sn-control-packet-format) and [[3 MQTT-SN Control Packets]](#mqtt-sn-control-packets).

2.  It follows the Topic matching rules described in [[4.7.1 Topic Names and Topic Filters]](#topic-names-and-topic-filters) and the Subscription rules in [[4.8 Subscriptions]](#subscriptions).

3.  It satisfies the MUST level requirements in the following chapters that are identified except for those that only apply to the Client:

    - [[1 Introduction]](#introduction)

    - [[2 MQTT-SN Control Packet format]](#mqtt-sn-control-packet-format)

    - [[3 MQTT-SN Control Packets]](#mqtt-sn-control-packets)

    - [[4 Operational behavior]](#operational-behavior)

4.  It does not require the use of any extensions defined outside of the specification in order to interoperate with any other conformant implementation.

### MQTT-SN Client conformance clause{#mqtt-sn-client-conformance-clause}

Refer to [[1.3 Terminology]](#terminology) for a definition of Client.

An MQTT-SN Client conforms to this specification only if it satisfies all the statements below:

1.  The format of all MQTT-SN Control Packets that the Client sends matches the format described in [[2 MQTT-SN Control Packet format]](#mqtt-sn-control-packet-format) and [[3 MQTT-SN Control Packets]](#mqtt-sn-control-packets).

2.  It follows the Topic matching rules described in [[4.7.1 Topic Names and Topic Filters]](#topic-names-and-topic-filters) and the Subscription rules in [[4.8 Subscriptions]](#subscriptions).

3.  It satisfies the MUST level requirements in the following chapters that are identified except for those that only apply to the Server:

    - [[1 Introduction]](#introduction)

    - [[2 MQTT-SN Control Packet format]](#mqtt-sn-control-packet-format)

    - [[3 MQTT-SN Control Packets]](#mqtt-sn-control-packets)

    - [[4 Operational behavior]](#operational-behavior)

4.  It does not require the use of any extensions defined outside of the specification in order to interoperate with any other conformant implementation.
