<!--
---
toc:
  auto: false
  label: Implementation Notes
  enumerate: Appendix F.
  children:
  - label: Support of PUBLISH WITHOUT SESSION
    enumerate: F.1
  - label: “Best practice” values for timers and counters
    enumerate: F.2
  - label: Mapping of Topic Alias to Topic Names and Topic Filters
    enumerate: F.3
  - label: Exponential Backoff
    enumerate: F.4
---
-->
# Implementation Notes

## Support of PUBLISH WITHOUT SESSION

Because PUBLISH WITHOUT SESSION could be sent at any time by clients (even with no Virtual Connection setup)
a transparent GW needs to maintain for those packets a dedicated MQTT connection with the server.
An aggregating or hybrid GW may use any aggregating MQTT connection to forward those packets to the server.

<!-- transformation-note: replaced typographic quotes in source as the renderes should create those. -->
## "Best practice" values for timers and counters

Table 30 shows the “best practice” values for the timers and counters defined in this specification.
<!-- transformation-note: above table reference will be replaced by auto-numbered reference later. -->

<!-- transformation-note: the mathematical symbols might profit from a functional display as they all indicate aspect(of) attributes
     like T\_ADV is just display, but meant is T(ADV) the Timer(ADV). -->
<!-- transformation-note: replaced tilde with the more speaking and easier to read "approx.". -->
| Timer/Counter | Recommended value                                                                                                                       |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------|
| T\_ADV        | Greater than 15 minutes                                                                                                                 |
| N\_ADV        | 2 - 3                                                                                                                                   |
| T\_SEARCHGW   | 5 seconds                                                                                                                               |
| T\_GWINFO     | 5 seconds                                                                                                                               |
| T\_WAIT       | Greater than 5 minutes                                                                                                                  |
| T\_RETRY      | Implement E4 with a starting value of 1 second after an initial wait period of 5 seconds. So the first retry will be approx. 6 seconds. |
| N\_RETRY      | 3 – 5 seconds                                                                                                                           |
| M\_BACKOFF    | 60 seconds                                                                                                                              |

Table 30: “Best practice” values for timers and counters
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The “tolerance” of the sleep and keep-alive timers at the server/gateway depends on the values indicated by the clients.
For example, the timer values should be 10% higher than the indicated values for periods larger than 1 minute, and 50% higher if less.

## Mapping of Topic Alias to Topic Names and Topic Filters

It is strongly recommended that in the gateway the mapping table between topic alias and topic names is implemented per client
(and not by a single shared pool between all clients), to reduce the risk of an incorrect topic alias from a client matching another client’s valid topic,
and thus causing a publication to the wrong topic, which could potentially have disastrous consequences.

## Exponential Backoff

The following error handling strategy should be used for networked devices to avoid overwhelming recipient network entities whilst providing for
efficient reestablishment handling.
The client shall periodically retry a failed packet with increasing delays between attempts,
constrained by a max retry time and interleaved with a suitable seed of randomness.

**Algorithm**:

An exponential backoff algorithm retries requests exponentially, increasing the waiting time between retries up to a maximum backoff time.
For example:

1. Initial packet sent.
1. If the operation fails, wait 1000 + (random number) milliseconds (ran) and retry the operation.
1. If the operation fails, wait 2000 + (random number) milliseconds (ran) and retry the operation.
1. If the operation fails, wait 4000 + (random number) milliseconds (ran) and retry the operation.
1. Continued, up to a maximum backoff M\_BACKOFF.
1. Continue waiting and retrying up to some maximum number of retries, but do not increase the wait period between retries.

The wait time is min(((2^n * sf) + ran), max) with n incremented by 1 for each iteration (or operation) and the scaling factor (sf)
being set to some reasonable value (suggested 1000 as in the example above).

The random number helps to avoid cases where many clients are synchronized by some situation, and all retry at once.
The value of the random number ran is recalculated after each retry.
The random number (ran) should be no larger than the scaling factor (sf).
