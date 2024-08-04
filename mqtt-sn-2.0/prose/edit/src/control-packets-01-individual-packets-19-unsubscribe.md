<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.19 UNSUBSCRIBE

![UNSUBSCRIBE Packet](images/packet/unsubscribe.png "UNSUBSCRIBE Packet"){#fig:unsubscribe-packet}

An UNSUBSCRIBE packet is sent by the client to the GW to unsubscribe from named topics.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.1 Length &amp; Packet Type{#unsubscribe--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.2 UNSUBSCRIBE Flags{#unsubscribe--unsubscribe-flags}

For The UNSUBSCRIBE Flags is 1 byte field in Byte position 3 of the UNSUBSCRIBE packet.  

The UNSUBSCRIBE Flags field includes the following flag:

<!-- transformation-note: the below table ref upstream 10 needs verification before transforming into a semantic ref later. -->
-   **Topic Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value.
    Refer to Table 10 for the definition of the various topic types.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.3 Packet Identifier{#unsubscribe--packet-identifier}

Should be coded such that it can be used to identify the corresponding SUBACK packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.19.4 Topic Data or Topic Filter{#unsubscribe--topic-data-and-topic-filter}

Contains Fixed Length UTF-8 Encoded String topic filter, topic alias (predefined or normal), or short topic name as indicated in the Topic Type field in flags.
Determines the topic names which this subscription is interested in.
