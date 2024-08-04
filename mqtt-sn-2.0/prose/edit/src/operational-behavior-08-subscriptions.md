<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.8 Subscriptions

A Subscription is associated only with the Session that created it. Each Subscription includes a Topic Filter, indicating the topic(s) for which
messages are to be delivered on that Session, and Subscription Options. The Server is responsible for collecting messages that match the filter and
transmitting them on the Session\'s Virtual Connection if and when that Virtual Connection exists.

A Session cannot have more than one Subscription with the same Topic Filter, so the Topic Filter can be used as a key to identify the subscription
within that Session.

If there are multiple Clients, each with its own Subscription to the same Topic, each Client gets its own copy of the Application Messages that are
published on that Topic. This means that the Subscriptions cannot be used to load-balance Application Messages across multiple consuming Clients as in
such cases every message is delivered to every subscribing Client.
