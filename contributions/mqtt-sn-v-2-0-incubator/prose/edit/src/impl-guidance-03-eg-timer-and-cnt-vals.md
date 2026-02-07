## C.3 Example Timer and Counter Values{#c.3-example-timer-and-counter-values}

Figure C-6 gives some values for the timers and counters defined in this specification derived from implementation experience.

*Figure C-6 -- Best practice values for timers and counters*

To balance reaction speed with reliability, the tolerance of the sleep timers at the Server may depend on the values indicated by the clients. For example, the timer values may be 10% higher than the indicated values for periods larger than 1 minute, and 50% higher if less.
