<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.10 PUBWOS - Publish Without Session{#publish-without-session}

![PUBWOS Packet](images/packet/pubwos.png "PUBWOS Packet"){#fig:pubwos-packet}

This packet is used by both clients and gateways to publish data for a certain topic.

The PUBWOS packet does not have a corresponding feature in MQTT.
If forwarded to an MQTT connection, PUBWOS packets MUST have their MQTT Quality of Service level set to 0. \[MQTT-SN-3.1.10-1]

>**Informative comment**
>
>If the Transport Layer supports multicast, like UDP/IP, the PUBWOS packet is generally sent to a Multicast Address.

>**Informative comment**
>
>PUBWOS packets received by a Gateway are not associated with a MQTT-SN Client Session and
>can be optionally discarded by the Gateway without being processed for onward delivery.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.10.1 Length &amp; Packet Type{#publish-without-session--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Refer to [section 2.1](#structure-of-an-mqtt-sn-control-packet) for a detailed description.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.10.2 PUBWOS Flags{#publish-without-session--flags}

The PUBWOS Flags field is 1-byte located in the Byte 3 position of the PUBWOS control packet. 

The PUBWOS Flags includes the following flags:

* **Topic Type**. This is a 2-bit field in Bit 0 and 1 which determines the format of the topic data field.
  Refer to [Table 10](#topic-types) for the definition of the various topic types.
  **NOTE: only predefined topic alias, short topic or full topic types are allowed in PUBWOS packets.**  
* **Retain**: 1 bit field stored in Bit 4 and has the same meaning as with MQTT.
  The field signifies whether the existing Retained Message for this topic is replaced or kept.
  For a detailed description of Retained Messages see [section 4.26](#retained-messages).

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.10.3 Topic Data{#publish-without-session--topic-data}

Contains 2 bytes of topic length (if the topic type is Full Topic Name) or the topic alias (predefined),
or short topic name as indicated in the _Topic Type_ field in flags.
Determines the topic which this payload will be published to.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.10.4 Data{#publish-without-session--data}

In the case of Topic Alias Type b11 the data section will be prefixed with a "Full Topic Name" encoded with a UTF-8 encoded string value of
length determined by the previously defined length field.
Thereafter, the _Data_ field corresponds to the payload of an MQTT PUBLISH packet.
It has a variable length and contains the application data that is being published.

<!-- transformation-note: left upstream numbering of headings for verification - upstream is wrong "3.1.12.7 PUBWOS Actions" -->
#### 3.1.10.5 PUBWOS Actions** {#publish-without-session--actions}

The Client or Server uses a PUBWOS packet to send an Application Message to a Network Address, for possible receipt by a Server or another Client.

If received by a Client or Server, the PUBWOS packet MUST be treated as if its QoS were 0 \[MQTT-SN-3.1.12.7-1\] as described in [section 3.1.12.7](\#3.1.12.7-publish-actions).
