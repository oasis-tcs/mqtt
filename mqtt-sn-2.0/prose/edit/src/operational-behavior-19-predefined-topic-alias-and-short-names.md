<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.19 Predefined Topic Alias’ and Short Topic Names{#predefined-topic-alias-and-short-topic-names}

A "predefined" topic alias is a topic alias whose mapping to a topic name is known in advance by both the client' application and the gateway.
This is indicated in the _Flags_ field of the packet.
When using pre-defined topic aliases, both sides can start immediately with the sending of PUBLISH packets;
there is no need for the REGISTER procedure as in the case of "normal" topic aliases. When receiving a PUBLISH packet with a predefined topic alias,
of which the mapping to a topic name is unknown, the receiver should return a PUBACK with the _ReasonCode="Unknown Topic Alias"_.

\[The presence of a pre-defined topic alias does not imply any other meaning onto the topic name / topic filter itself.
All lifecycle operations, for example SUBSCRIBE / UNSUBSCRIBE may still be used in the use of these aliases except for REGISTER.]

A "short" topic name is a topic name that has a fixed length of two bytes.
It could be carried together with the data within a PUBLISH packet, thus no REGISTER procedure is needed for a short topic name.
Otherwise, all rules that apply to normal topic names also apply to short topic names.
Note however that it does not make sense to do wildcarding in subscriptions to short topic names,
because it is not possible to define a meaningful name hierarchy with only two characters.
