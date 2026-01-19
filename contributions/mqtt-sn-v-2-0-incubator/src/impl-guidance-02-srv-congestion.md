## Server Congestion{#c.2-server-congestion}

For CONNECT, PUBLISH, SUBSCRIBE and REGISTER requests, the Server may return the Reason Code *Congestion*, meaning *try again later*.

The requester should wait a reasonable amount of time (*[Congestion Delay)]* before sending a new request to the Server. What constitutes *a reasonable amount of time* depends on the implementation characteristics - it should be configured in the client application based on those. See [[C.4 Timer and Counter Values]](#c.3-example-timer-and-counter-values) for an example value.
