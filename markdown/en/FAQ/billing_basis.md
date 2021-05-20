---
title: How does Agora calculate service minutes?
platform: ["All Platforms"]
updatedAt: 2021-02-03 05:51:31
Products: ["Voice","Video","Interactive Broadcast","Recording","cloud-recording"]
---
In Real-time Communication(RTC), service minutes are calculated either by the number of users or by the number of streams. Agora calculates service minutes **by the number of users**.

## Approach 1: calculate by the number of users

Suppose N users talk for M minutes in a channel, the total service minutes = N * M. 

- If two users talk for 10 minutes, the total service minutes are: 2 * 10 = 20.
- If five users talk for 10 minutes, the total service minutes are: 5 * 10 = 50.
- If 10 users talk for 10 minutes, the total service minutes are: 10 * 10 = 100.

In this approach, the service minutes purely depend on the number of the users in the channel, regardless of how many streams each user subscribes to.

## Approach 2: calculate by the number of streams

Suppose N users talk for M minutes in a channel, and each user subscribes to all remote streams in the channel, the total service minutes = N * (N-1) * M.

- If two users talk for 10 minutes, the total service minutes are: 2 * (2-1) * 10 = 20.
- If five users talk for 10 minutes, the total service minutes are: 5 * (5-1) * 10 = 200.
- If 10 users talk for 10 minutes, the total service minutes are: 10 * (10-1) * 10 = 900.

In this approach, if a user subscribes to multiple streams, every remote stream the user subscribes to is counted.

## Difference between the two approaches

See the table below for the difference between the two approaches:

| Scenario | Service minutes by the number of users | Service minutes by the number of streams |
| ------------ | ------------- | --------------- |
| Two users talk for 10 minutes. |	20 minutes | 20 minutes |
| Five users talk for 10 minutes. |	50 minutes |	200 minutes |
| 10 users talk for 10 minutes.	| 100 minutes	| 900 minutes |

The difference between the two approaches become greater when more people join the channel.

## Calculation approach by Agora

Agora calculates service minutes **by the number of users**, which is easier and more straightforward.

## Reference

[Billing for Real-time Communication](https://docs.agora.io/en/Interactive%20Broadcast/billing_rtc?platform=Android)