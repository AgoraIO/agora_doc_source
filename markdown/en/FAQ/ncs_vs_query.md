---
title: What are the differences between the Message Notification Service and the query Method?
platform: ["RESTful"]
updatedAt: 2020-09-01 18:46:33
Products: ["cloud-recording"]
---
You can monitor the status of the cloud recording service either through the `query` method or by the Message Notification Service, to take action when required. Both options have pros and cons.

## The query method

You can periodically call the `query` method to monitor the status of a cloud recording. See [Query the recording status](https://docs.agora.io/en/cloud-recording/restfulapi/#/云端录制/query).

- Pros: Reliable, as the status is queried proactively.
- Cons:
  - Provides limited status information.
  - Requires an active query. You cannot query too often because of the Queries Per Second (QPS) limit, and thus it is not as real-time as the Message Notification Service.

If the reliability of the status of a cloud recording is a high priority, Agora strongly recommends using the `query` method.

## Message Notification Service 

You can use the Message Notification Service as a complementary option to monitor the recording service status. You need to configure an HTTP/HTTPS server to receive event notifications. For details, see [Agora Cloud Recording RESTful API Callback Service](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest).

- Pros: Real-time
- Cons: 
  - The server passively receives messages, and the messages may get lost.
  - The confirmation message of the message delivery may get lost, causing the message to be resent. In such a case, you need to deduplicate the notifications.
  - The messages may not arrive in the correct order.

<div class="alert note">Agora recommends that core apps should not rely on the Message Notification Service. If your apps already rely heavily on the Message Notification Service, Agora recommends that you contact <a href="mailto:support@agora.io">support@agora.io</a> to enable the redundant message notification function, which doubles the received notifications and reduces the probability of message loss. Redundant message notification still cannot guarantee a 100% arrival rate.</div>