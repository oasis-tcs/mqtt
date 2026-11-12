## C.3 Example Timer and Counter Values{#c.3-example-timer-and-counter-values}

[tab](#tab-best-practice-values-for-timers-and-counters) gives some values for the timers and counters defined in this specification derived from implementation experience.

| Name                | Where Defined                                   | Example Value                                                                                                                                                  |
|:--------------------|:------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Advertise Duration  | [sec](#c.7-gateway-advertisement-and-discovery) | Greater than 15 minutes                                                                                                                                        |
| Advertise Count     | [sec](#c.7-gateway-advertisement-and-discovery) | 2 - 3                                                                                                                                                          |
| SEARCHGW Delay      | [sec](#c.7-gateway-advertisement-and-discovery) | 5 seconds                                                                                                                                                      |
| GWINFO Delay        | [sec](#c.7-gateway-advertisement-and-discovery) | 5 seconds                                                                                                                                                      |
| Congestion Delay    | [sec](#c.2-server-congestion)                   | Greater than 5 minutes                                                                                                                                         |
| Retry Interval      | [sec](#unacknowledged-packets)                  | Implement [sec](#c.4-exponential-backoff)  with a starting value of 1 second after an initial wait period of 5 seconds. So the first retry will be ~6 seconds. |
| Max. Retry Count    | [sec](#unacknowledged-packets)                  | 3 – 5                                                                                                                                                          |
| Max. Retry Interval | [sec](#c.4-exponential-backoff)                 | 60 seconds                                                                                                                                                     |

Table: Best practice values for timers and counters{#tab-best-practice-values-for-timers-and-counters}

