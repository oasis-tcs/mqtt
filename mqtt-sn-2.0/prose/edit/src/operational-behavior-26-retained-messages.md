<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.26 Retained Messages

If the RETAIN flag is set to 1 in a PUBLISH packet sent by a Client to a Server,
the Server MUST replace any existing retained packet for this topic and store the Publish Data,
so that it can be delivered to future subscribers whose subscriptions match its Topic Name.
If the Publish Data contains zero bytes it is processed normally by the Server but any retained packet with the same topic name MUST be removed and
any future subscribers for the topic will not receive a retained packet.
A retained packet with Publish Data containing zero bytes MUST NOT be stored as a retained packet on the Server.
