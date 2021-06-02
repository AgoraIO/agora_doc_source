---
title: Monitor Service Status During Recording
platform: All Platforms
updatedAt: 2020-08-31 15:57:11
---
You can periodically call `query` to ensure that the recording service is in progress and in a normal state. Apart from `query`, you can use the Message Notification Service as a complementary method to monitor the service status. See [Comparison Between the Message Notification Service and the `query` Method](https://docs.agora.io/en/faq/ncs_vs_query) for detailed comparison between the two methods.

### Periodically query service status

If the reliability of the status of a cloud recording is a high priority, Agora strongly recommends using the `query` method to periodically query the recording service status. The interval between two calls can be around one minute. Take the corresponding measure based on the received HTTP status code:

- If the returned HTTP status code is always `40x`, check the parameter values in your request.
- If the returned HTTP status code is `404`, and the request parameters are confirmed to be correct, the recording has either not started successfully, or the recording quit after starting. Agora recommends that you use a backoff strategy, for example, retry after 5, 10, and 15 seconds successively.
- If the returned HTTP status code is `50x`, the `query` request failed, but it is not clear whether the recording has quit. The `50x` error is rare. You can continue to use the backoff strategy (waiting for 5 seconds, 10 seconds, 15 seconds, or 30 seconds) to call `query`.

### Redundant message notifications

If you rely on the Message Notification Service to monitor the status of the recording service, Agora recommends that you contact [support@agora.io](mailto:support@agora.io) to enable the redundant message notification function, which doubles the received notifications and reduces the probability of message loss. Redundant message notification still cannot guarantee a 100% arrival rate.

After enabling the redundant message notification function, you need to deduplicate messages based on `sid`. For example, if you need to start recording again after a recording session times out and quits, the process is:

1. Your server receives the notifications of event `31`, `32`, or `11`, which means that the recording service quits normally.
2. After receiving the notifications, your application calls `acquire` to restart the recording service.
3. During this period, your server receives notifications of event `31`, `32`, or `11` again. If `sid` contained in the above notifications is identical to the previous ones, you can ignore them as redundant notifications.
4. Call `query` if you need to fully ensure that the recording service successfully starts.