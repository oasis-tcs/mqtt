<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.8 Clean start

With MQTT-SN, when a client disconnects, its subscriptions are retained for no less than the session expiration time.
They are persistent and valid for new (non clean start) sessions, until either they are explicitly un-subscribed by the client,
or the client establishes a new session with the "clean start" flag set or their idle time exceeds the session expiry interval associated with the session.

In MQTT-SN the meaning of a "clean start" is extended to the Will feature, i.e. not only the subscriptions are persistent,
but also the Will topic and the Will packet. The two flags "CleanStart" and "Will" in the CONNECT have then the following meanings:

- CleanStart=true, Will=true: The gateway will delete all subscriptions and Will data, if present, related to the client and
  it will add the Will data with the content of the CONNECT Will optional fields.
- CleanStart=true, Will=false: The gateway will delete all subscriptions and Will data, if present, related to the client, and returns CONNACK.
- CleanStart=false, Will=true: The gateway keeps all stored client’s data and it will overwrite, if present,
  or add the Will data related to the client with the content of the CONNECT Will optional fields.
- CleanStart=false, Will=false: The gateway keeps all stored client’s data and returns CONNACK.

Note that if a client wants to delete only its Will data at Virtual Connection setup, it could send a CONNECT packet with "CleanStart=false" and "Will=false".
