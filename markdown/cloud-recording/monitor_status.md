---
title: 录制过程中的服务状态监控
platform: All Platforms
updatedAt: 2020-09-07 15:24:45
---
你可以通过周期性调用 `query` 来确认录制服务正在进行中且状态正常。相比于 query，消息通知服务可以作为辅助手段。详见[消息通知服务和 query 方法的对比](https://docs.agora.io/cn/faq/ncs_vs_query)。

## 周期性频道查询

如果你对状态查询的可靠性要求较高，Agora 强烈建议你使用 `query` 方法周期性查询频道内的录制状态，例如每隔 1 分钟调用一次 `query`，并根据返回的 HTTP 状态码采取相应措施。

- 如果返回的 HTTP 状态码一直为 `40x`，则表示请求参数错误，需要进行排查。
- 如果返回的 HTTP 状态码为 `404`，且已经确认请求参数无误，则表示录制并未成功启动、或启动后中途退出。建议采用退避策略多次调用 `query` （例如间隔 5 秒、10 秒、15 秒）进行确认。
- 如果返回的 HTTP 状态码为 `50x`，则表示 `query` 请求失败，但尚不明确录制是否已退出。出现 `50x` 错误的概率极小，建议使用退避策略 (5 秒, 10 秒, 15 秒，30 秒) 继续调用 `query`。

## 冗余消息通知服务

如果你依赖消息通知服务来监测录制服务状态，建议联系 [sales@agora.io](mailto:sales@agora.io) 开通冗余消息功能，即接收双路消息通知，降低消息丢失的概率。冗余消息功能仍然不能保证 100% 的消息到达率。

开通冗余消息功能后，需要你基于 `sid` 对消息进行去重。举例来说，如果你需要在录制超时退出后再次开启录制，流程为：

1. 你的服务器收到 `31`、`32`、或 `11` 事件，表示录制服务已正常退出。
2. 收到事件后，你的应用调用 `acquire`，重新开启录制服务。
3. 在此期间你的服务器又收到了 `31`、`32`、或 `11` 事件。如果以上事件中的 `sid` 与前一次的 `31`、`32`、或 `11` 事件一致，则可以作为冗余事件通知忽略。
4. 如果你需要完全确保成功开启了录制服务，则仍然需要调用 `query` 进行查询。
