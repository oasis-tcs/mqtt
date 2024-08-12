<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.17 SUBSCRIBE

![SUBSCRIBE Packet](images/packet/subscribe.png "SUBSCRIBE Packet"){#fig:subscribe-packet}

The SUBSCRIBE packet is used by a client to subscribe to a certain topic name.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.17.1 Length &amp; Packet Type{#subscribe--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.
Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.17.2 SUBSCRIBE Flags{#subscribe--subscribe-flags}

The SUBSCRIBE Flags field is 1-byte and contains the following flags:

- **QoS**: maximum QoS.
  This gives the maximum QoS level at which the Server can send Application Messages to the Client.
  It is a Protocol Error if the Maximum QoS field has the value 3.
- **No Local**: if the value is 1, Application Messages MUST NOT be forwarded to a Virtual Connection with a ClientID equal to
  the ClientID of the publishing Virtual Connection.
- **Retain as published**: If 1, Application Messages forwarded using this subscription keep the RETAIN flag they were published with.
  If 0, Application Messages forwarded using this subscription have the RETAIN flag set to 0.
  Retained messages sent when the subscription is established have the RETAIN flag set to 1.
- **Retain handling**: This option specifies whether retained messages are sent when the subscription is established.
  This does not affect the sending of retained messages at any point after the subscribe.
  If there are no retained messages matching the Topic Filter, all these values act the same.
  The values are:
  - 0: Send retained messages at the time of the subscribe
  - 1: Send retained messages at subscribe only if the subscription does not currently exist
  - 2: Do not send retained messages at the time the new subscription is processed.
  - 3: It is a Protocol Error to send a Retain Handling value of 3.
- **Topic Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field.
  Refer to Table 10 for the definition of the various topic types.
<!-- transformation-note: the above table ref upstream 10 needs verification before transforming into a semantic ref later. -->
<!-- transformation-note: Either place the disallowed values as a list item (decision taken) when listing or place before spawning the sublist;
     found was a dangling higher level item part following a sub list - this is brittle as it relies on some graphical layout instead of
     using the structural elements introduced. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.17.3 Packet Id{#subscribe--packet-id}

Should be coded such that it can be used to identify the corresponding SUBACK packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.17.4 Topic Data or Topic Filter{#subscribe--topic-data-or-topic-filter}

Contains Fixed Length UTF-8 Encoded String topic filter, topic alias (predefined or normal), or short topic name as indicated in the Topic Type field in flags.
Determines the topic names which this subscription is interested in.
