<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.16 Clean Start

When a client disconnects, its subscriptions are retained for no less than the session expiration interval.
They are persistent and valid for new (non clean start) sessions, until either they are explicitly un-subscribed by the client,
or the client establishes a new session with the "clean start" flag set or their idle time exceeds the session expiry interval associated with the session.

The two flags "CleanStart" and "Will" in the CONNECT Packet have the following meanings:

- CleanStart=true, Will=true: The Gateway will delete all Session data related to the client, including Will data if present,
  and it will set the Will data in the Session state with the content of the CONNECT Will fields and will return CONNACK.
- CleanStart=true, Will=false: The gateway will delete all subscriptions and Will data, if present, related to the client and it will return CONNACK.
- CleanStart=false, Will=true: The gateway will keep all the client's data and it will overwrite, if present,
  or add the Will data related to the client with the content of the CONNECT Will optional fields and it will return CONNACK.
- CleanStart=false, Will=false: The Gateway will keep all the client's subscriptions and it will delete any Will data, if present,
  and it will return CONNACK.

Note that if a client wants to delete only its Will data at Virtual Connection creation,
it could send a CONNECT packet with "CleanStart=false" and "Will=false".
