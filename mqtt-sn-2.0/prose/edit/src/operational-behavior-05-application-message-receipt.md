<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.5 Application Message Receipt

\[When a Server takes ownership of an incoming Application Message it MUST add it to the Session State for those Clients that have matching
Subscriptions] \[MQTT-SN-4.5-1]. Matching rules are defined in section [4.7 "Topic Names and Topic Filters"](#topic-names-and-topic-filters).

Under normal circumstances Clients receive Application Messages in response to Subscriptions they have created. A Client could also receive
Application Messages that do not match any of its explicit Subscriptions. This can happen if the Server automatically assigned a subscription
to the Client. A Client could also receive Application Messages while an UNSUBSCRIBE operation is in progress. \[The Client MUST acknowledge
any Publish packet it receives according to the applicable QoS rules regardless of whether it elects to process the Application Message that it
contains] \[MQTT-SN-4.5-2].
