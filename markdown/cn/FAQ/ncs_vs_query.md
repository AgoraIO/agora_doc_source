---
title: 消息通知服务和 query 方法有什么区别？
platform: ["RESTful"]
updatedAt: 2020-09-01 18:47:07
Products: ["cloud-recording"]
---
你可以通过云端录制的 `query` 方法或消息通知服务来监视云端录制服务的状态，在状态异常时及时采取措施，以保证服务可用性。两种方法各有优劣：

## 云端录制 `query` 方法

你可以定时调用云端录制的 `query` 方法，查询云端录制的状态。详见[查询云端录制状态的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest#a-namequerya查询云端录制状态的-api)。

- 优点：录制服务状态为主动查询后获得，可靠性高。
- 缺点：
  - 提供的状态信息有限。
  - 需要主动查询，且有每秒请求数（QPS）限制，实时性不如消息通知服务。

如果你对状态查询的可靠性要求较高，Agora 强烈建议你使用 `query` 方法。

## 消息通知服务

Agora 消息通知服务用于辅助监听云端录制的事件。你需要配置一个 HTTP/HTTPS 服务器来接收事件通知。详见[云端录制 RESTful API 回调服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest)。

- 优点：实时性好。
- 缺点：
  - 服务器被动接收消息，可能会出现消息丢失的情况。
  - 因为消息投递的确认消息可能会丢失，导致消息重传，需要对消息进行去重。
  - 不保证消息有序到达。

<div class="alert note">消息通知服务只能作为辅助手段来监控录制状态。不建议你的核心业务逻辑依赖消息通知服务。如果你的业务对该服务强依赖，建议联系 <a href="mailto:sales@agora.io">sales@agora.io</a> 开通冗余消息功能，即接收双路消息通知，降低消息丢失的概率。冗余消息功能仍然不能保证 100% 的消息到达率。</div>