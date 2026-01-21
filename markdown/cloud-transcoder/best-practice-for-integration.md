本文介绍使用云端转码服务的最佳实践，包含保障高可用、检查服务状态并及时排查问题、避免服务频繁退出。通过采用这些措施，可以更好保障服务的可靠性和稳定性，从而为你提供更好的业务支持。
## 保障服务高可用

为保障 REST 服务的高可用，避免因区域网络故障造成的服务不可用，声网提供故障迁移、多路备份、切换域名的方案。

### 故障迁移

针对网络故障，以及非声网云服务，非声网软件，基础设施和不可抗力等因素可能导致的风险，声网云端转码服务为提升用户体验，提供高可用自动任务迁移服务。当故障确认后，该服务会在尽量短的时间（预计 90 秒内）完成迁移，在此期间会存在转码中断等风险。对于频道内观众较多或对高可用有极高要求的场景，你需要根据业务需求判断能否接受高可用迁移的影响，决定是否要采用更高的质量保障措施。例如，使用多个不同的 `uid`（在输出频道内）发起多路转码任务，或通过[周期性频道查询](#monitor)和消息通知服务了解转码任务状态，以便在发生故障时及时使用备用 `uid` 重新发起新的转码任务，从而确保关键任务顺利完成。


### 多路备份

如需比故障迁移更高的质量保障，你可以采用多路任务保障策略。每路转码任务单独计费。实现步骤如下：

1.  同时发起主任务和备份任务，订阅相同的主播源流，向同一频道或不同频道推送转码输出的流，观众端订阅主任务中的输出频道内的 `uid`。

2.  在客户端监听以下回调事件，可以及时通知观众端订阅备份任务中的输出频道内的 `uid`：

    - 主播掉线回调: [`onUserOffline`](hhttps://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#callback_irtcengineeventhandler_onuseroffline)
    - 主播音视频状态变化回调: [`onRemoteAudioStateChanged`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onremoteaudiostatechanged)/[`onRemoteVideoStateChanged`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#callback_irtcengineeventhandler_onremotevideostatechanged)


### 切换域名

~45f50180-d902-11ed-8efe-b91caddc8ecb~

## 检查服务状态

你可以通过云端转码 RESTful API 来获取转码服务状态。相比于云端转码 RESTful API，[消息通知服务](https://docs.agora.io/cn/cloud-transcoding/ncs_transcoding?platform=All%20Platforms)更适合作为辅助手段。

以下是所有的转码服务状态（`services.cloudTranscoder.status`）：

|服务状态  |描述|
|------|-----|
|`"serviceIdle"`	|服务未开始。|
|`"serviceStarted"`	|服务已开始。|
|`"serviceReady"`	|服务已就绪。|
|`"serviceInProgress"`	|服务正在进行中。|
|`"serviceCompleted"`	|服务已经停止，任务全部完成。|
|`"servicePartialCompleted"`	|服务已经停止，任务部分完成。|
|`"serviceValidationFailed"`	|服务参数验证失败。|
|`"serviceAbnormal"`	|服务异常退出。|
|`"serviceUnknown"`	|服务未知状态。|

### 检查 PCW 和 QPS

请检查你的 App ID 下使用云端转码服务的最大并发任务数（PCW）和每秒钟的请求数（QPS）没有超出声网限制：

- PCW：20。
- QPS：10。

请根据你的 PCW 和查询间隔，预估所需的 QPS。如果需要提升 QPS 和 PCW，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">联系技术支持</a>。

### 检查转码服务是否成功启动

建议你通过如下步骤检查转码服务是否已成功启动：

#### 1. 检查 Create 请求是否成功

如果 `Create` 请求响应的 HTTP 状态码为 `200`，则请求成功。如果 `Create` 请求响应的 HTTP 状态码非 `200`，则需要根据状态码采取相应措施：

- 如果返回的 HTTP 状态码为 `206`，则表示请求超时，建议使用退避策略，如第一次等待 3 秒后重试、第二次等待 6 秒后重试、第三次等待 9 秒后重试，以免超过 QPS 限制导致失败。如果三次重试均失败，建议更换 UID 再次调用 `Acquire`， 获得一个新的 `tokenName`，并用该 `tokenName` 再次调用 `Create` 方法。
- 如果返回的 HTTP 状态码为 `409`，则表示转码任务已成功启动并在进行中。
- 如果返回的 HTTP 状态码为 `40x`（`409` 除外），则表示请求参数错误，需要进行排查。
- 如果返回的 HTTP 状态码为 `50x`，可使用相同的参数重试多次，直到成功返回 `taskId` 为止。建议使用退避策略，如第一次等待 3 秒后重试、第二次等待 6 秒后重试、第三次等待 9 秒后重试，以免超过 QPS 限制导致失败。如果三次重试均失败，建议更换 UID 再次调用 `Acquire`， 获得一个新的 `tokenName`，并用该 `tokenName` 再次调用 `Create` 方法。
- 如果收到错误码 `65`，需要使用相同的参数再次调用 `Create`。建议使用退避策略重试两次，如第一次等待 3 秒后重试、第二次等待 6 秒后重试。

#### 2. 检查 cloud transcoder 是否成功启动

`Create` 请求成功后，你会获得 `taskId`。获得 `taskId` 之后的 5 秒后，使用退避策略调用 `Query` 方法，退避间隔建议小于 `Create` 请求中的 `idleTimeout` (最长空闲频道时间)。如果 `Query` 请求成功，且 `serverResponse` 中的 `status` 参数值为 `4` 或 `5`，则表示 cloud transcoder 已成功启动。如果在获得 `taskId` 之后的 90 秒后 `status` 仍非 `4` 或 `5`， 则可以认为 cloud transcoder 在创建后未成功启动，超时退出。

<div class="alert note">频道内用户 UID 不能冲突，因此建议你为 cloud transcoder 准备一个备用 UID，以便在重新发起新的转码任务时使用。主用 UID 和备用 UID 可以交替使用。</div>

### 监控转码任务状态

你可以通过周期性调用 `Query` 方法和消息通知服务监控转码任务的状态。相比于 `Query`，消息通知服务更适合作为辅助手段。详见[消息通知服务和 query 方法的对比](https://docs.agora.io/cn/faq/ncs_vs_query)。

<a name = "monitor"></a>
#### 周期性查询状态

你可以通过周期性调用 `Query` 方法来确认转码服务正在进行中且状态正常。如果你对状态查询的可靠性要求较高，声网强烈建议你使用 `Query` 方法周期性查询频道内的转码状态，例如每隔 2 分钟调用一次 `Query`，并根据返回的 HTTP 状态码采取相应措施。

-   如果返回的 HTTP 状态码一直为 `40x`，则表示请求参数错误，需要进行排查。
-   如果返回的 HTTP 状态码为 `404`，且已经确认请求参数无误，则表示 cloud transcoder 并未成功启动、或启动后中途退出。建议采用退避策略多次调用 `Query` （例如间隔 5 秒、10 秒、15 秒）进行确认。
-   如果返回的 HTTP 状态码为 `50x`，则表示 `Query` 请求失败，但尚不明确 cloud transcoder 是否已退出。出现 `50x` 错误的概率极小，建议使用退避策略 (例如间隔 5 秒，10 秒，15 秒，30 秒) 继续调用 `Query`。

#### 使用消息通知服务

消息通知服务可以辅助监听云端转码的状态。为了避免消息投递时丢失，建议你开通该服务的冗余消息通知功能。开通后，你需要基于 `taskId` 对消息进行去重。举例来说，如果你需要在 cloud transcoder 超时退出后再次开启，消息去重的逻辑为：

1.  你的服务器收到 `111` 事件，表示转码服务已正常退出。
2.  收到步骤 1 的 `111` 事件后，你调用 `Acquire` 重新开启转码服务。
3.  在重新开启转码期间，你的服务器又收到了 `111` 事件。如果该事件和步骤 1 收到的 `111` 事件对应的 `taskId` 一致，则可以将该事件通知当冗余通知，可忽略。

如果你需要完全确认转码服务已成功开启，则还需调用 `Query` 进行查询。

<div class="alert note">
<li>消息通知服务需<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">联系技术支持</a>开通。</li>
<li>冗余消息功能仍然不能保证 100% 的消息到达率。</li>
</div>

## 避免转码服务频繁退出

`Create` 方法中的 `idleTimeout` 参数默认值为 300 秒。对于要求 cloud transcoder 一直在频道中的场景，为避免 cloud transcoder 因主播频繁上下线而频繁启动和退出，你需要在设置 `idleTimeout` 取值时权衡实际场景，避免取值过小。合适的取值可以保证转码服务在短时间无发流端时也能稳定运行，避免转码服务频繁退出。
