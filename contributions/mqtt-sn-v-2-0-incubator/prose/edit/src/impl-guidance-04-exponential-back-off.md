## Exponential Backoff<a name="c.4-exponential-backoff"></a>

The *Retry Interval* for unacknowledged packets can be increased on each retry, to avoid overwhelming recipient network nodes while allowing efficient Virtual Connection reestablishment. The client periodically retries a failed packet with increasing delays between attempts, constrained by a Maximum Retry Interval, interleaved with a suitable seed of randomness.

**Algorithm:**

This algorithm retries requests at doubling intervals, increasing time between retries up to a *Maximum Retry Interval*. For example:

1.  Send initial packet sent. The initial *Retry Interval* is 1000 ms.

2.  Wait up to 1000 + (random number) ms - retry the operation if no response is received during that time.

3.  Wait up to 2000 + (random number) ms - retry the operation if no response is received during that time.

4.  Wait up to 4000 + (random number) ms - retry the operation if no response is received during that time.

5.  Continue increasing the *Retry Interval* each time, but no larger than *Max. Retry Interval.*

6.  Continue waiting and retrying up to *Max. Retry Count* number of retries, without increasing the *Retry Interval* further.

The wait time is (ran is a random number, max is *Max. Retry Interval*):

min(((2\^n \* sf) + ran), max)

with n incremented by 1 for each iteration (or operation) and the scaling factor (sf) being set to some reasonable value - for example 1000 as in the example above.

The random number helps to avoid cases where many clients are synchronized by some situation, and all retry at once. The value of the random number ran is recalculated after each retry. The random number should be no larger than the initial *Retry Interval*.
