## Topics{#topics}

### Topic Names and Topic Filters{#topic-names-and-topic-filters}

Topic Names are a label for a message, consisting of a series of topic levels, each level separated by the topic level separator.

Topic Filters can match several Topic Names by replacing the topic levels with wildcards.

#### Topic wildcards{#topic-wildcards}

The topic level separator is used to introduce structure into the Topic Name. If present, it divides the Topic Name into multiple "topic levels".

A subscription's Topic Filter can contain special wildcard characters, which allow a Client to subscribe to multiple topics at once.

«<mark title="Requirement MQTT-SN-4.7.1.1-1"><a name="MQTT-SN-4.7.1.1-1"></a>A Topic Name, the target of PUBWOS and PUBLISH packets, MUST NOT contain special wildcard characters.</mark>»\[MQTT‑SN‑4.7.1.1‑1].

##### Topic level separator{#topic-level-separator}

The forward slash ('/' U+002F) is used to separate each level within a topic tree and provide a hierarchical structure to the Topic Names. The use of the topic level separator is significant when either of the two wildcard characters is encountered in Topic Filters specified by subscribing Clients. Topic level separators can appear anywhere in a Topic Filter or Topic Name. Adjacent Topic level separators indicate a zero-length topic level.

##### Multi-level wildcard{#multi-level-wildcard}

The number sign ('#' U+0023) is a wildcard character that matches any number of levels within a topic. The multi-level wildcard represents the parent and any number of child levels. «<mark title="Requirement MQTT-SN-4.7.1.1.2-1"><a name="MQTT-SN-4.7.1.1.2-1"></a>The multi-level wildcard character MUST be specified either on its own or following a topic level separator. In either case it MUST be the last character specified in the Topic Filter</mark>»\[MQTT‑SN‑4.7.1.1.2‑1].

> **Informative comment**
>
> For example, if a Client subscribes to "sport/tennis/player1/#", it would receive Application Messages published using these Topic Names:

- "sport/tennis/player1"

- "sport/tennis/player1/ranking

- "sport/tennis/player1/score/wimbledon"

> **Informative comment**

- "sport/#" also matches the singular "sport", since \# includes the parent level.

- "#" is valid and will receive every Application Message

- "sport/tennis/#" is valid

- "sport/tennis#" is not valid

- "sport/tennis/#/ranking" is not valid

##### Single-level wildcard{#single-level-wildcard}

The plus sign ('+' U+002B) is a wildcard character that matches only one topic level.

«<mark title="Requirement MQTT-SN-4.7.1.1.3-1"><a name="MQTT-SN-4.7.1.1.3-1"></a>The single-level wildcard can be used at any level in the Topic Filter, including first and last levels. Where it is used, it MUST occupy an entire level of the filter</mark>»\[MQTT‑SN‑4.7.1.1.3‑1]. It can be used at more than one level in the Topic Filter and can be used in conjunction with the multi-level wildcard.

> **Informative comment**
>
> For example, "sport/tennis/+" matches "sport/tennis/player1" and "sport/tennis/player2", but not "sport/tennis/player1/ranking". Also, because the single-level wildcard matches only a single level, "sport/+" does not match "sport" but it does match "sport/".

- "+" is valid

- "+/tennis/#" is valid

- "sport+" is not valid

- "sport/+/player1" is valid

- "/finance" matches "+/+" and "/+", but not "+"

#### Topics beginning with \${#topics-beginning-with-dollar}

«<mark title="Requirement MQTT-SN-4.7.1.2-1"><a name="MQTT-SN-4.7.1.2-1"></a>The Server MUST NOT match Topic Filters starting with a wildcard character (# or +) with Topic Names beginning with a \$ character</mark>»\[MQTT‑SN‑4.7.1.2‑1]. The Server SHOULD prevent Clients from using such Topic Names to exchange messages with other Clients. Server implementations MAY use Topic Names that start with a leading \$ character for other purposes.

> **Informative comment**

- \$SYS/ has been widely adopted as a prefix to topics that contain Server-specific information or control APIs

- Applications cannot use a topic with a leading \$ character for their own purposes

> **Informative comment**

- A subscription to "#" will not receive any messages published to a topic beginning with a \$

- A subscription to "+/monitor/Clients" will not receive any messages published to "\$SYS/monitor/Clients"

- A subscription to "\$SYS/#" will receive messages published to topics beginning with "\$SYS/"

- A subscription to "\$SYS/monitor/+" will receive messages published to "\$SYS/monitor/Clients"

- For a Client to receive messages from topics that begin with \$SYS/ and from topics that don't begin with a \$, it has to subscribe to both "#" and "\$SYS/#"

#### Topic semantic and usage{#topic-semantic-and-usage}

The following rules apply to Topic Names and Topic Filters:

- «<mark title="Requirement MQTT-SN-4.7.1.3-1"><a name="MQTT-SN-4.7.1.3-1"></a>All Topic Names and Topic Filters MUST be at least one character long</mark>»\[MQTT‑SN‑4.7.1.3‑1]

- Topic Names and Topic Filters are case sensitive

- Topic Names and Topic Filters can include the space character

- A leading or trailing '/' creates a distinct Topic Name or Topic Filter

- A Topic Name or Topic Filter consisting only of the '/' character is valid

- <mark title="Ephemeral region marking">Topic Names and Topic Filters MUST NOT include the null character (Unicode U+0000)</mark> [[\[Unicode\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#Unicode) \[MQTT-SN-4.7.1.3-2\]

- «<mark title="Requirement MQTT-SN-4.7.1.3-3"><a name="MQTT-SN-4.7.1.3-3"></a>Topic Names and Topic Filters are UTF-8 Encoded Strings; they MUST NOT encode to more than 65,535 bytes</mark>»\[MQTT‑SN‑4.7.1.3‑3]. Refer to [[1.7.4 UTF-8 Encoded String]](#utf-8-encoded-string).

There is no limit to the number of levels in a Topic Name or Topic Filter, other than that imposed by the overall length of a UTF-8 Encoded String.

«<mark title="Requirement MQTT-SN-4.7.1.3-4"><a name="MQTT-SN-4.7.1.3-4"></a>When it performs subscription matching the Server MUST NOT perform any normalization of Topic Names or Topic Filters, or any modification or substitution of unrecognized characters</mark>»\[MQTT‑SN‑4.7.1.3‑4]. Each non-wildcarded level in the Topic Filter has to match the corresponding level in the Topic Name character for character for the match to succeed.

**Informative comment**

> The UTF-8 encoding rules mean that the comparison of Topic Filter and Topic Name could be performed either by comparing the encoded UTF-8 bytes, or by comparing decoded Unicode characters.

**Informative comment**

- "ACCOUNTS" and "Accounts" are two different Topic Names

- "Accounts payable" is a valid Topic Name

- "/finance" is different from "finance"

An Application Message is sent to each Client Subscription whose Topic Filter matches the Topic Name attached to an Application Message. The topic resource MAY be either predefined in the Server by an administrator or it MAY be dynamically created by the Server when it receives the first subscription or an Application Message with that Topic Name. The Server MAY also use a security component to authorize particular actions on the topic resource for a given Client.

### Topic Aliases{#topic-aliases}

A Topic Alias is a 2 byte integer value that is used to identify the Topic instead of using the Topic Name. Topic Aliases can reduce the bandwidth needed when Topic Names are long and the same Topic Names are used repetitively.

There are two types of Topic Alias: Predefined and Session. Predefined and Session Topic Aliases MUST occupy separate value spaces. That is, a Session Topic Alias MUST be able to have the same numerical value as a Predefined Topic Alias.

The only reason for the existence of Topic Aliases is to reduce packet size. Therefore, a Topic Alias is transformed to its mapped Topic Name when received by a Client or Server before any further processing.

A Subscription contains a Topic Filter, which is a Topic Name that is allowed to include wildcards - it does not contain any Topic Aliases.

«<mark title="Requirement MQTT-SN-4.7.2-1"><a name="MQTT-SN-4.7.2-1"></a>If a Topic Alias exists for a Topic Name, a Sender (Client or Server) MUST use that Topic Alias and not the Topic Name in any PUBLISH packet</mark>»\[MQTT‑SN‑4.7.2‑1].

#### Predefined Topic Aliases{#predefined-topic-aliases}

Predefined Topic Aliases are known to both sender and receivers before any communication takes place between them. The set of Predefined Topic Aliases in a Server is the same for all Clients that connect to it.

The definitions of Predefined Topic Aliases are not affected by the sending or receiving of any MQTT-SN Packets - their creation and upkeep is an administrative procedure outside the scope of this specification.

«<mark title="Requirement MQTT-SN-4.7.2.1-1"><a name="MQTT-SN-4.7.2.1-1"></a>Predefined Topic Aliases MUST NOT change for the duration of any MQTT-SN Session</mark>»\[MQTT‑SN‑4.7.2.1‑1].

«<mark title="Requirement MQTT-SN-4.7.2.1-2"><a name="MQTT-SN-4.7.2.1-2"></a>If a PUBLISH is sent to a Predefined Topic Alias which is not defined on the receiver it is a Protocol Error</mark>»\[MQTT‑SN‑4.7.2.1‑2].

#### Session Topic Aliases{#session-topic-aliases}

Session Topic Aliases are allocated and controlled by the Server, not the Client.

«<mark title="Requirement MQTT-SN-4.7.2.2-1"><a name="MQTT-SN-4.7.2.2-1"></a>Session Topic Aliases MUST be allocated on a per Session basis - they are not shared between Sessions either with the same Client or different Clients</mark>»\[MQTT‑SN‑4.7.2.2‑1].

Session Topic Aliases last for the duration of the Session, except after a SLEEPREQ with Retain Topic Aliases equal to 0.

There are several ways that a Session Topic Alias can be created:

- A Client subscribes to a Topic Filter without wildcards. The Session Topic Alias for that Topic Name is returned in the SUBACK packet.

- A Client sends a REGISTER packet to the Server. If the Server successfully creates a Session Topic Alias, its value is returned in the REGACK packet.

- As a result of a wildcard subscription, the Server needs to send a PUBLISH packet to a Client, and no Topic Alias, Predefined or Session, exists for the Topic Name. The Server creates a Session Topic Alias and informs the Client by sending it a REGISTER packet.

- The Server may need to re-register Topic Aliases in the Awake state, as a result of the Client using the Retain Topic Aliases flag set to 0 on the SLEEPREQ packet when going to sleep.

I«<mark title="Requirement MQTT-SN-4.7.2.2-2"><a name="MQTT-SN-4.7.2.2-2"></a>f a Client subscribes to a Topic Filter which does not include wildcard characters, a Predefined or Session Topic Alias MUST be returned in the SUBACK packet</mark>»\[MQTT‑SN‑4.7.2.2‑2].

I«<mark title="Requirement MQTT-SN-4.7.2.2-3"><a name="MQTT-SN-4.7.2.2-3"></a>f a Client subscribes to a Topic Filter which includes wildcard characters, a Topic Alias (Predefined or Session) MUST NOT be returned in the SUBACK packet</mark>»\[MQTT‑SN‑4.7.2.2‑3].

«<mark title="Requirement MQTT-SN-4.7.2.2-4"><a name="MQTT-SN-4.7.2.2-4"></a>A Session Topic Alias MUST NOT be allowed to map to the same Topic Name as a Predefined Topic Alias</mark>»\[MQTT‑SN‑4.7.2.2‑4].

«<mark title="Requirement MQTT-SN-4.7.2.2-5"><a name="MQTT-SN-4.7.2.2-5"></a>If a Client requests a Session Topic Alias for a Topic Name which already has a Predefined Topic Alias, the Server MUST return a REGACK with the Topic Type "Predefined Topic Alias", the Predefined Topic Alias, and the Reason Code "Topic Alias Exists"</mark>»\[MQTT‑SN‑4.7.2.2‑5].

«<mark title="Requirement MQTT-SN-4.7.2.2-6"><a name="MQTT-SN-4.7.2.2-6"></a>A Session Topic alias and a Predefined Topic Alias with the same numerical value MUST map to different Topic Names</mark>»\[MQTT‑SN‑4.7.2.2‑6].
