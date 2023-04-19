本文介绍使用云端转码服务的最佳实践，包含保障高可用、检查服务状态并及时排查问题、避免服务频繁退出。通过采用这些措施，可以更好保障服务的可靠性和稳定性，从而为你提供更好的业务支持。

## 保障 REST 服务高可用


为保障 REST 服务的高可用，避免因区域网络故障造成的服务不可用，声网提供故障迁移、多路备份、切换域名的方案。

### 故障迁移

针对网络故障，以及非声网云服务，非声网软件，基础设施和不可抗力等因素可能导致的风险，声网云端转码服务为提升用户体验，提供高可用自动任务迁移服务。当故障确认后，该服务会在尽量短的时间（预计 90 秒内）完成，在此期间会存在合流中断等风险。

对于频道内观众较多或对高可用有极高要求的场景，你需要根据业务需求判断能否接受高可用迁移的影响，决定是否要采用更高的质量保障措施。例如，对关键任务进行多路合流，即，使用多个不同的 `uid`（在输出频道内）发起多路合流任务，或通过[周期性频道查询](#monitor)和消息通知服务了解合流任务状态，以便在发生故障时及时使用备用 `uid` 重新发起新的合流任务，从而确保关键任务顺利完成。//TODO 合流 -> 转码


### 多路备份

如需比故障迁移更高的质量保障，你可以采用多路任务保障策略。每路合流转码任务单独计费。实现步骤如下：

1.  同时发起主任务和备份任务，订阅相同的主播源流，向同一频道或不同频道推送合流转码流，观众端订阅主任务中的输出频道内的 `uid`。

2.  在客户端监听以下回调事件，可以及时通知观众端订阅备份任务中的输出频道内的 `uid`：

    - 主播掉线回调: [`onUserOffline`](hhttps://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#callback_irtcengineeventhandler_onuseroffline)
    - 主播音视频状态变化回调: [`onRemoteAudioStateChanged`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onremoteaudiostatechanged)/[`onRemoteVideoStateChanged`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#callback_irtcengineeventhandler_onremotevideostatechanged)



### 切换域名

~45f50180-d902-11ed-8efe-b91caddc8ecb~

## 获取服务状态

你可以通过云端转码 RESTful API 来获取合流服务状态。相比于云端转码 RESTful API，[消息通知服务](https://docs.agora.io/cn/cloud-transcoding/ncs_transcoding?platform=All%20Platforms)更适合作为辅助手段。

以下是所有的合流服务状态（`services.cloudTranscoder.status`）：

|status    |描述|
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

<div class="alert note">
<li>消息通知服务只能作为辅助手段来获取服务合流状态。不建议你的核心业务逻辑依赖消息通知服务。如果你的业务高度依赖消息通知服务，建议<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">联系技术支持</a>开通该服务的冗余消息功能，即接收双路消息通知，降低消息丢失的概率。开通冗余消息功能后，需要你基于 <code>taskId</code> 对消息进行去重。冗余消息功能仍然不能保证 100% 的消息到达率。</li>
<li>每个 App ID 每秒钟的请求数（QPS）限制默认为 10 次。请根据你的同时最大并发任务数（PCW）和查询间隔，预估所需的 QPS，并通过提交工单的方式申请调整 QPS 限制。</li>
<li>国内 PCW 限制为 100，其他地区 PCW 限制为 30。如需提升 PCW 限制，请联系技术支持。</li>
</div>

### 检查合流服务已经成功启动

建议你通过如下步骤确认合流服务已成功启动：

1.  确认 `Create` 请求成功，即成功获得 `taskId` (合流 ID)。如果 `Create` 请求返回 HTTP 状态码非 `200`，则需要根据状态码采取相应措施：
    -   如果返回的 HTTP 状态码为 `201`，则表示合流任务已成功启动并在进行中。
    -   如果返回的 HTTP 状态码为 `206`，则表示请求超时，建议使用退避策略，如第一次等待 3 秒后重试、第二次等待 6 秒后重试、第三次等待 9 秒后重试，以免超过 QPS 限制导致失败。如果三次重试均失败，建议更换 UID 再次调用 `Acquire`， 获得一个新的 `tokenName`，并用该 `tokenName` 再次调用 `Create` 方法。
    -   如果返回的 HTTP 状态码为 `40x`，则表示请求参数错误，需要进行排查。
    -   如果返回的 HTTP 状态码为 `50x`，可使用相同的参数重试多次，直到成功返回 `taskId` 为止。建议使用退避策略，如第一次等待 3 秒后重试、第二次等待 6 秒后重试、第三次等待 9 秒后重试，以免超过 QPS 限制导致失败。如果三次重试均失败，建议更换 UID 再次调用 `Acquire`， 获得一个新的 `tokenName`，并用该 `tokenName` 再次调用 `Create` 方法。
    -   如果收到错误码 `65`，需要使用相同的参数再次调用 `Create`。建议使用退避策略重试两次，如第一次等待 3 秒后重试、第二次等待 6 秒后重试。
2.  获得 taskId 之后的 5 秒后，使用退避策略调用 `Query` 方法，退避间隔建议小于 `Create` 请求中的 idleTimeout (最长空闲频道时间)。如果 `Query` 请求成功，且 `serverResponse` 中的 `status` 参数值为 `4` 或 `5`，则表示合流服务已成功启动。如果在获得 `taskId` 之后的 90 秒后 `status` 仍非 `4` 或 `5`， 则可以认为合流未启动或成功后超时退出。

<div class="alert note">建议你准备一个备份 UID，在重新启动合流时使用，以避免输出频道内两个相同 UID 互踢。主备 UID 可以交替使用。</div>

### 合流任务的状态监控

你可以通过周期性调用 `Query` 方法来确认合流服务正在进行中且状态正常。相比于 `Query`，消息通知服务更适合作为辅助手段。详见[消息通知服务和 query 方法的对比](https://docs.agora.io/cn/faq/ncs_vs_query)。


<a name = "monitor"></a>
#### 周期性频道查询

如果你对状态查询的可靠性要求较高，声网强烈建议你使用 `Query` 方法周期性查询频道内的合流状态，例如每隔 2 分钟调用一次 `Query`，并根据返回的 HTTP 状态码采取相应措施。

-   如果返回的 HTTP 状态码一直为 `40x`，则表示请求参数错误，需要进行排查。
-   如果返回的 HTTP 状态码为 `404`，且已经确认请求参数无误，则表示合流并未成功启动、或启动后中途退出。建议采用退避策略多次调用 `Query` （例如间隔 5 秒、10 秒、15 秒）进行确认。
-   如果返回的 HTTP 状态码为 `50x`，则表示 `Query` 请求失败，但尚不明确合流是否已退出。出现 `50x` 错误的概率极小，建议使用退避策略 (5 秒, 10 秒, 15 秒，30 秒) 继续调用 `Query`。

#### 冗余消息通知服务

开通冗余消息功能后，需要你基于 `taskId` 对消息进行去重。举例来说，如果你需要在合流超时退出后再次开启合流，流程为：

1.  你的服务器收到 `111` 事件，表示合流服务已正常退出。
2.  收到事件后，你的应用调用 `Acquire`，重新开启合流服务。
3.  在此期间你的服务器又收到了 `111` 事件。如果以上事件中的 `taskId` 与前一次的 `111` 事件一致，则可以作为冗余事件通知忽略。
4.  如果你需要完全确保成功开启了合流服务，则仍然需要调用 `Query` 进行查询。


## 避免合流服务频繁退出

`Create` 方法中的 `idleTimeout` 参数默认值为 300 秒。对于要求合流服务一直在频道中的场景，为避免合流服务因主播频繁上下线而频繁启动和退出，你需要在设置 `idleTimeout` 取值时权衡实际场景，避免取值过小。合适的取值可以保证合流服务在短时间无发流端时也能稳定运行，避免合流服务频繁退出。
