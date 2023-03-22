IRtmClient ~03f2af90-60ca-11ed-8dae-bf25bf08a626~
## 方法

### Initialize
#### 接口描述

```csharp
public abstract int Initialize(RtmConfig config);
```

初始化 IRtmClient 实例。

> 注意：
> 创建并初始化实例必须在你使用 RTM 其他功能之前完成，以建立正确的账号级别的凭据（例如 APP ID）。

| 参数 | 描述                    |
| --------- | ------------------------------ |
| `config` | 该 `IRtmClient` 实例的配置信息，详见 [`RtmConfig`](#rtmconfig)。 |

#### 基本用法

#### 初始化 RTM 实例
```csharp
// 初始化一个 RtmConfig 实例。
Rtmconfig rtmConfig = new Rtmconfig();
// 从声网控制台上获取 APP ID 并填入 "my_appId"。  
rtmConfig.appId = "my_appId";
// 为用户或设备设置唯一标识符 userId 并填入 "my_userId"。
rtmConfig.userId = "my_userId";
// 设置事件监听程序。
rtmConfig.eventHandler = new rtmEventHandler();
// 设置日志存储功能。
rtmConfig.logConfig = new logConfig();
// 创建一个 RTM 客户端实例。
IRtmClient rtmClient = RtmClient.CreateAgoraRtmClient();
// 初始化 RTM 客户端实例。
rtmClient.Initialize(rtmConfig);
```

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### Release
#### 接口描述
```csharp
public abstract int Release();
```

销毁一个 `IRtmClient` 类型实例以释放资源。

#### 基本用法
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### CreateStreamChannel
#### 接口描述

```csharp
public abstract IStreamChannel CreateStreamChannel(string channelName);
```

创建一个 `IStreamChannel` 类型实例。

> 注意：
> 请在调用 `IStreamChannel` 中的方法前创建 `IStreamChannel` 类型实例。

| 参数     | 描述                  |
| ------------- | ---------------------------- |
| `channelName` | 频道名称，命名规范参照[频道名称](feature-description#频道名称)。同一个 VID 下相同的频道名称属于同一个频道。 |

#### 基本用法

##### 创建一个 `IStreamChannel` 类型实例
```csharp
Rtmconfig rtmConfig = new Rtmconfig();
// 将 my_appId 替换为 Agora Console 获取的 App ID。
rtmConfig.appId = "my_appId";
// 创建一个 RTM 客户端实例。
IRtmClient rtmClient = RtmClient.CreateAgoraRtmClient();
// 初始化一个 RTM 客户端实例。
rtmClient.Initialize(rtmConfig);
//创建一个频道名为 Location 的 IStreamChannel 实例。
Loc_stChannel = rtmClient.CreateStreamChannel("Location");
```

#### 返回值
一个 `IStreamChannel` 类型实例。


## 回调

### IRtmEventHandler

通过添加事件监听处理程序以获得接口调用结果以及事件通知，包括连接状态，消息到达，Presence 状态等事件通知以及监控接口回调结果。在调用这些函数前必须先添加事件监听处理程序。

#### 添加事件监听程序

```csharp
// 初始化一个 RtmConfig 实例。
Rtmconfig rtmConfig = new Rtmconfig();
// 从声网控制台上获取 APP ID 并填入 "my_appId"。  
rtmConfig.appId = "my_appId";
// 为用户或设备设置唯一标识符 userId 并填入 "my_userId"。
rtmConfig.userId = "my_userId";
// 设置事件监听程序。
rtmConfig.eventHandler = new rtmEventHandler();
// 创建一个 RTM 客户端实例。
IRtmClient rtmClient = RtmClient.CreateAgoraRtmClient();
// 初始化 RTM 客户端实例。
rtmClient.Initialize(rtmConfig);
// 添加事件监听处理程序。
internal class rtmEventHandler: IRtmEventHandler
{
    // 消息事件监听程序，消息到达会触发该事件。
    public override void OnMessageEvent (MessageEvent @event) 
    { 
    }
    // Presence 事件监听程序，频道 presence 变更会触发该事件。
    public override void OnPresenceEvent (PresenceEvent @event)
    { 
    }
    // 加入频道事件回调。
    public override void OnJoinResult(string channelName, string userId, STREAM_CHANNEL_ERROR_CODE errorCode)
    {
    }
    // 离开频道事件回调。
    public override void OnLeaveResult(string channelName, string userId, STREAM_CHANNEL_ERROR_CODE errorCode)
    {
    }
    // 加入 Topic 事件回调。
    public override void OnJoinTopicResult(string channelName, string userId, string topic, string meta, STREAM_CHANNEL_ERROR_CODE errorCode) 
    {
    }
    // 离开 Topic 事件回调。
    public override void OnLeaveTopicResult(string channelName, string userId, string topic, string meta, STREAM_CHANNEL_ERROR_CODE errorCode) 
    {
    }
    // 订阅 Topic 或订阅消息发布者事件回调。
    public override void OnTopicSubscribed(string channelName, string userId, string topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) 
    {
    }
    // 取消订阅 Topic 或取消订阅消息发布者事件回调。
    public override void OnTopicUnsubscribed(string channelName, string userId, string topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) 
    {
    }
    // SDK 连接状态变更事件回调。
    public override void OnConnectionStateChange(string channelName, RTM_CONNECTION_STATE state, RTM_CONNECTION_CHANGE_REASON reason) 
    {
    }

}
```

#### 处理断连

你可以使用如下代码，通过 `OnConnectionStateChange` 回调， `RTM_CONNECTION_STATE` 和 `RTM_CONNECTION_CHANGE_REASON` 枚举搜集 SDK 断连原因。

```csharp
internal class rtmEventHandler: IRtmEventHandler
{
    public override void OnConnectionStateChange(string channelName, RTM_CONNECTION_STATE state, RTM_CONNECTION_CHANGE_REASON reason) 
    {
        RTM_CONNECTION_STATE e = state as RTM_CONNECTION_STATE;
        RTM_CONNECTION_CHANGE_REASON r = reason as RTM_CONNECTION_CHANGE_REASON;
        if(e != null){
            switch(e){
                case RTM_CONNECTION_STATE_DISCONNECTED: Debug.Log("RTM has disconnected,because of " + r);
                case RTM_CONNECTION_STATE_CONNECTING:Debug.Log("RTM is connecting,because of " + r);
                case RTM_CONNECTION_STATE_CONNECTED:Debug.Log("RTM has connected successfully,because of " + r);
                case RTM_CONNECTION_STATE_RECONNECTING:Debug.Log("RTM is reconnecting,because of " + r);
                case RTM_CONNECTION_STATE_FAILED:Debug.Log("RTM connect to sever failed ,because of " + r);
                }
            }
    }

}
```

### OnMessageEvent
#### 接口描述

```csharp
public virtual void OnMessageEvent(MessageEvent @event) {}
```

当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。

| 参数   |描述      | 
| ------------ | --------- |
| `event`  | 消息事件类型，详见 [`MessageEvent`](#messageevent)。  | 


### OnPresenceEvent
#### 接口描述

```csharp
public virtual void OnPresenceEvent(PresenceEvent @event) {}
```

当频道中有用户的 Presence 状态发生变更时会触发该回调。比如，远端用户加入或离开频道，同一频道内远端用户加入或离开 Topic，本地用户加入频道。

| 参数   | 描述      | 
| ------------ |  --------- |
| `event`  | 消息事件类型，详见 [`PresenceEvent`](#presenceeevent)。  | 


### OnJoinResult
#### 接口描述

```csharp
public virtual void OnJoinResult(string channelName, string userId, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```

加入频道时会触发该回调。

| 参数      | 描述                              |
| -------------  | ---------------------------------------- |
| `channelName`  | 发生事件所属频道。 |
| `userId`       | 加入频道的用户 ID。  |
| `errorCode`    | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。       |

### OnLeaveResult
#### 接口描述

```csharp
public virtual void OnLeaveResult(string channelName, string userId, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```

离开频道后时触发该回调。

| 参数      | 描述                              |
| ------------- | ---------------------------------------- |
| `channelName` | 发生事件所属频道。 |
| `userId`      | 离开频道的用户 ID。  |
| `errorCode`   | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。       |

### OnJoinTopicResult
#### 接口描述

```csharp
public virtual void OnJoinTopicResult(string channelName, string userId, string topic, string meta, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```
加入 Topic 时会触发该回调。

| 参数      | 描述                              |
| -------------  | ---------------------------------------- |
| `channelName` | 发生事件所属频道。 |
| `userId`      | 加入 Topic 的用户 ID。  |
| `topic`       | Topic 名称。       |
| `meta`        | 创建 Topic 的辅助信息。  |
| `errorCode`   | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。       |

### OnLeaveTopicResult
#### 接口描述

```csharp
public virtual void OnLeaveTopicResult(string channelName, string userId, string topic, string meta, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```

离开 Topic 时会触发该回调。

| 参数     | 描述                              |
| ------------- | ---------------------------------------- |
| `channelName`  | 发生事件所属频道。 |
| `userId`        | 离开 Topic 的用户 ID。  |
| `topic`            | Topic 名称。       |
| `meta`              | 创建 Topic 的辅助信息。  |
| `errorCode`   | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。       |

### OnTopicSubscribed
#### 接口描述

```csharp
public virtual void OnTopicSubscribed(string channelName, string userId, string topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```

订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。

| 参数        | 描述                                |
| -------------- | ------------------------------------------ |
| `channelName`   | 发生事件所属频道。 |
| `userId`      | 订阅 Topic 的用户 ID。  |
| `topic`        | 发生事件所属 Topic。 |
| `succeedUsers`   | 本次操作订阅成功的消息发布者列表，详见 [`UserList`](api-message-unity#userlist)。                       |
| `failedUsers`   | 本次操作订阅失败的消息发布者列表，详见 [`UserList`](api-message-unity#userlist)。                       |
| `errorCode`    | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。 

### OnTopicUnsubscribed
#### 接口描述

```csharp
public virtual void OnTopicUnsubscribed(string channelName, string userId, string topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) {}
```

取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。

| 参数      | 描述                                |
| -------------- | ------------------------------------------ |
| `channelName`  | 发生事件所属频道。 |
| `userId`      | 取消订阅 Topic 的用户 ID。  |
| `topic`        | 发生事件所属 Topic。 |
| `succeedUsers`  | 本次操作订阅成功的消息发布者列表，详见 [`UserList`](api-message-unity#userlist)。                       |
| `failedUsers`   | 本次操作订阅失败的消息发布者列表，详见 [`UserList`](api-message-unity#userlist)。                       |
| `errorCode`     | 频道错误码，详见[`STREAM_CHANNEL_ERROR_CODE`](api-channel-unity#stream_channel_error_code)。 

### OnConnectionStateChange
#### 接口描述

```csharp
public virtual void OnConnectionStateChange(string channelName, RTM_CONNECTION_STATE state, RTM_CONNECTION_CHANGE_REASON reason) {}
```

SDK 连接状态发生改变时会触发该回调。

| 参数   | 描述      | 
| ------------ | --------- |
| `channelName` | 发生事件所属频道。 |
| `state`  | SDK 连接状态，详见 [`RTM_CONNECTION_STATE`](#rtm_connection_state)。  | 
| `reason`   | SDK 连接状态改变原因，详见 [`RTM_CONNECTION_CHANGE_REASON`](#rtm_connection_change_reason)。  | 

## Class

### RtmConfig

```csharp
    public class Agora.Rtm.RtmConfig
    {
        public string appId { set; get; }

        public string userId { set; get; }

        public IRtmEventHandler eventHandler { set; get; }

        public LogConfig logConfig { set; get; }
    };

```

RTM 客户端配置信息。


| 参数   | 描述           |
| ------------ | ----------------------------------- |
| appId        | 从声网控制台上获取的 APP ID。                                                        |
| userId       | 用户 ID，用户或设备设置唯一的标识符。你需要维护 userId 和用户之间的映射关系，并在整个服务周期内不能改变。如果不设置该参数，将无法连接到 RTM 服务。                               |
| eventHandler | 事件监听函数句柄，用以监听消息通知，Presence 通知，状态变更通知等事件通知。详见 [`IRtmEventHandler`](#irtmeventhandler)。                               |
| logConfig    | （选填）日志存储功能。Agora 建议你在调试和定位问题时候开启该功能，日志将会保存在你设置的位置，Agora 技术人员将根据日志详情帮助你分析定位问题。应用正式上线后建议取消设置该功能。详见 [`LogConfig`](#logconfig)。   |

#### 基本用法

```csharp
// 初始化一个 RtmConfig 实例。
Rtmconfig rtmConfig = new Rtmconfig();
// 从声网控制台上获取 APP ID 并填入 "my_appId"。  
rtmConfig.appId = "my_appId";
// 为用户或设备设置唯一标识符 userId 并填入 "my_userId"。
rtmConfig.userId = "my_userId";
// 设置事件监听程序。
rtmConfig.eventHandler = new rtmEvnetHandler();
// 设置日志存储功能。
rtmConfig.logConfig = new logConfig();
// 创建一个 RTM 客户端实例。
IRtmClient rtmClient = RtmClient.CreateAgoraRtmClient();
// 初始化 RTM 客户端实例。
rtmClient.Initialize(rtmConfig);
```

### LogConfig 

#### 接口描述

```csharp
    public class Agora.Rtm.LogConfig
    {
        public string filePath { set; get; }

        public uint fileSizeInKB { set; get; }

        public LOG_LEVEL level { set; get; }
    };
```

开启日志功能，并设置日志保存路径、日志大小及日志记录等级等，为后续的问题调查收集必要的运行数据。


| 参数    | 描述                             |
| ------------ | -------------------------- |
| `filePath`     | （选填）日志保存路径及日志文件名。请确保对配置的文件路径具备读写权限。默认值如下：<ul><li>Android 平台：<code>/storage/emulated/0/Android/data/{packagename}/files/agorasdk.log</code></li><li>iOS 平台：<code>App Sandbox/Library/caches/agorasdk.log</code></li><li>macOS 平台：<ul><li>如果你启用了 App Sandbox：<code>App/Library/Logs/agorasdk.log</code>，例如 <code>/Users/{username}/Library/Containers/{AppBundleIdentifier}/Data/Library/Logs/agorasdk.log</code></li><li>如果你未启用 App Sandbox：<code>/Library/Logs/agorasdk.log</code></li></ul></li><li>Windows 平台：<code>C:\Users\{user_name}\AppData\Local\Agora\{process_name}\agorasdk.log</code></li></ul>                              |
| `fileSizeInKB` | （选填）日志文件大小，单位为 KB，取值范围为 [128,1024]，默认值为 1024。如果你将该参数设为小于 128 的值，则使用 128；如果你将该参数设为大于 1024 的值，则使用 1024。                                |
| `level`        |（选填）日志错误等级，默认值为 `LOG_LEVEL.LOG_LEVEL_INFO`。详见 [`LOG_LEVEL`](#log_level)。 |


#### 基本用法

##### 初始化 RTM 客户端并开启日志功能
```csharp
// 创建一个 logConfig 实例。
LogConfig logConfig = new LogConfig();
// 在 "my_filePath" 中填入日志文件路径。
logConfig.filePath = "my_filePath";
// 将日志文件大小设为 512 KB。
logConfig.fileSizeInKB = 512;
// 设置生成 ERROR 及以上等级的日志。
logConfig.level = LOG_LEVEL_ERROR;
// 初始化一个 RtmConfig 实例。
Rtmconfig rtmConfig = new Rtmconfig();
// 从声网控制台上获取 APP ID 并填入 "my_appId"。  
rtmConfig.appId = "my_appId";
// 为用户或设备设置唯一标识符 userId 并填入 "my_userId"。
rtmConfig.userId = "my_userId";
// 设置 logConfig 参数。
rtmConfig.logConfig = logConfig;
// 创建一个 RTM 客户端实例。
IRtmClient rtmClient = RtmClient.CreateAgoraRtmClient();
// 初始化 RTM 客户端实例。
rtmClient.Initialize(rtmConfig);
```

### MessageEvent

```csharp
public class MessageEvent
{
    public RTM_CHANNEL_TYPE channelType { set; get; }

    public string channelName { set; get; }

    public string channelTopic { set; get; }

    public string message { set; get; }

    public uint messageLength { set; get; }

    public string publisher { set; get; }
};
```

消息回调事件。

| 参数   | 描述      | 
| ------------ |  --------- |
| `channelType`  | 频道类型，详见 [`RTM_CHANNEL_TYPE`](#rtm_channel_type)。  | 
| `channelName`   | 频道名称。  | 
| `channelTopic`  | Topic 名称。  | 
| `message`   | 消息负载。  | 
| `messageLength`  | 消息负载长度。  | 
| `publisher`   | 发布消息的用户 ID。  | 

### PresenceEvent

```csharp
public class PresenceEvent
{
    public RTM_CHANNEL_TYPE channelType { set; get; }

    public RTM_PRESENCE_TYPE type { set; get; }

    public string channelName { set; get; }

    public TopicInfo[] topicInfos { set; get; }

    public uint topicInfoNumber { set; get; }

    public string userId { set; get; }
};
```

Presence 回调事件。

| 参数    | 描述      | 
| ------------ | --------- |
| `channelType`     | 频道类型，详见 [`RTM_CHANNEL_TYPE`](#rtm_channel_type)。  | 
| `type`     | Presence 类型，详见 [`RTM_PRESENCE_TYPE`](#rtm_presence_type)。  | 
| `channelName`     | 频道名称。  | 
| `topicInfos`    | Topic 信息，详见 [TopicInfo](#api-topic-unity#topicinfo)。  | 
| `topicInfoNumber`    | Topic 信息数量。  | 
| `userId`    | Presence 所属用户 ID。  | 

## Enum

### RTM_CHANNEL_TYPE

```csharp
public enum RTM_CHANNEL_TYPE
{
    RTM_CHANNEL_TYPE_MESSAGE = 0,

    RTM_CHANNEL_TYPE_STREAM = 1,
};
```
RTM 频道类型。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `RTM_CHANNEL_TYPE_MESSAGE`     | 0: Message Channel。  | 
| `RTM_CHANNEL_TYPE_STREAM`     | 1: Stream Channel。  | 



### RTM_CONNECTION_STATE

```csharp
public enum RTM_CONNECTION_STATE
{

    RTM_CONNECTION_STATE_DISCONNECTED = 1,

    RTM_CONNECTION_STATE_CONNECTING = 2,

    RTM_CONNECTION_STATE_CONNECTED = 3,

    RTM_CONNECTION_STATE_RECONNECTING = 4,

    RTM_CONNECTION_STATE_FAILED = 5,
};
```

SDK 连接状态。

| 枚举值  | 描述   |
| ----------------------------------- | ---------------------------------------------- |
| `RTM_CONNECTION_STATE_DISCONNECTED` | 1: SDK 已和服务器断开连接。                                                                      |
| `RTM_CONNECTION_STATE_CONNECTING`   | 2: SDK 正在连接服务器。                                                                    |
| `RTM_CONNECTION_STATE_CONNECTED`    | 3: SDK 已连上服务器。                                                                           |
| `RTM_CONNECTION_STATE_RECONNECTING` | 4: SDK 和服务器断开连接，正在重新连接服务器。 |
| `RTM_CONNECTION_STATE_FAILED`       | 5: SDK 无法连接服务器。                                                                      |

### RTM_CONNECTION_CHANGE_REASON

```csharp
public enum RTM_CONNECTION_CHANGE_REASON
{

    RTM_CONNECTION_CHANGE_CONNECTING = 0,

    RTM_CONNECTION_CHANGE_JOIN_SUCCESS = 1,

    RTM_CONNECTION_CHANGE_INTERRUPTED = 2,

    RTM_CONNECTION_CHANGE_BANNED_BY_SERVER = 3,

    RTM_CONNECTION_CHANGE_JOIN_FAILED = 4,

    RTM_CONNECTION_CHANGE_LEAVE_CHANNEL = 5,

    RTM_CONNECTION_CHANGE_INVALID_APP_ID = 6,

    RTM_CONNECTION_CHANGE_INVALID_CHANNEL_NAME = 7,

    RTM_CONNECTION_CHANGE_INVALID_TOKEN = 8,

    RTM_CONNECTION_CHANGE_TOKEN_EXPIRED = 9,

    RTM_CONNECTION_CHANGE_REJECTED_BY_SERVER = 10,

    RTM_CONNECTION_CHANGE_SETTING_PROXY_SERVER = 11,

    RTM_CONNECTION_CHANGE_RENEW_TOKEN = 12,

    RTM_CONNECTION_CHANGE_CLIENT_IP_ADDRESS_CHANGED = 13,

    RTM_CONNECTION_CHANGE_KEEP_ALIVE_TIMEOUT = 14,

    RTM_CONNECTION_CHANGE_REJOIN_SUCCESS = 15,

    RTM_CONNECTION_CHANGE_LOST = 16,

    RTM_CONNECTION_CHANGE_ECHO_TEST = 17,

    RTM_CONNECTION_CHANGE_CLIENT_IP_ADDRESS_CHANGED_BY_USER = 18,

    RTM_CONNECTION_CHANGE_SAME_UID_LOGIN = 19,

    RTM_CONNECTION_CHANGE_TOO_MANY_BROADCASTERS = 20,
};
```

SDK 连接状态改变原因。

| 枚举值                             | 描述                          |
| ------------------------------------ | ------------------------------------ |
|  `RTM_CONNECTION_CHANGE_CONNECTING`   | 0: 建立网络连接中。 |
|  `RTM_CONNECTION_CHANGE_JOIN_SUCCESS` | 1: 成功加入频道。  |
|  `RTM_CONNECTION_CHANGE_INTERRUPTED`   | 2: 网络连接中断。  |
|  `RTM_CONNECTION_CHANGE_BANNED_BY_SERVER`  | 3: 网络连接被服务器禁止。   |
|  `RTM_CONNECTION_CHANGE_JOIN_FAILED`  |  4: SDK 连续 20 分钟无法加入频道，停止重连频道。  |
|  `RTM_CONNECTION_CHANGE_LEAVE_CHANNEL`  |  5: 离开频道。                            |
|  `RTM_CONNECTION_CHANGE_INVALID_APP_ID` |  6: 不是有效的 APP ID，无法加入频道。    |
|  `RTM_CONNECTION_CHANGE_INVALID_CHANNEL_NAME` |  7: 不是有效的频道名，无法加入频道。     |
|  `RTM_CONNECTION_CHANGE_INVALID_TOKEN`  |   8: Token 无效，无法加入频道。   |
|  `RTM_CONNECTION_CHANGE_TOKEN_EXPIRED` |  9: Token 过期D，无法加入频道。     |
|  `RTM_CONNECTION_CHANGE_REJECTED_BY_SERVER`  |  10: 被服务器禁止连接。    |
|  `RTM_CONNECTION_CHANGE_SETTING_PROXY_SERVER` |  11: 由于设置了代理服务器，SDK 尝试重连。   |
|  `RTM_CONNECTION_CHANGE_RENEW_TOKEN`  |   12: 更新 Token 引起网络连接状态改变。    |
|  `RTM_CONNECTION_CHANGE_CLIENT_IP_ADDRESS_CHANGED` |  13: 由于网络类型，或网络运营商的 IP 或端口发生改变，客户端 IP 地址变更，SDK 尝试重连。     |
|  `RTM_CONNECTION_CHANGE_KEEP_ALIVE_TIMEOUT`  | 14: SDK 和服务器连接保活超时，进入自动重连状态。   |
|  `RTM_CONNECTION_CHANGE_REJOIN_SUCCESS`  |  15: SDK 重连成功。    |
|  `RTM_CONNECTION_CHANGE_LOST`  |    16: SDK 丢失与服务器的连接。    |
|  `RTM_CONNECTION_CHANGE_ECHO_TEST`  |   17: 通话回声测试引起连接状态改变。     |
|  `RTM_CONNECTION_CHANGE_CLIENT_IP_ADDRESS_CHANGED_BY_USER`|  18: 用户变更客户端 IP 地址，SDK 尝试重连。  |
|  `RTM_CONNECTION_CHANGE_SAME_UID_LOGIN`  |  19: 使用相同的 UID 从不同的设备加入同一频道。   |
|  `RTM_CONNECTION_CHANGE_TOO_MANY_BROADCASTERS`  |  20: 频道内主播人数已达上限。   |

### RTM_PRESENCE_TYPE

```csharp
public enum RTM_PRESENCE_TYPE
{
    RTM_PRESENCE_TYPE_REMOTE_JOIN_CHANNEL = 0,
    RTM_PRESENCE_TYPE_REMOTE_LEAVE_CHANNEL = 1,
    RTM_PRESENCE_TYPE_REMOTE_CONNECTION_TIMEOUT = 2,
    RTM_PRESENCE_TYPE_REMOTE_JOIN_TOPIC = 3,
    RTM_PRESENCE_TYPE_REMOTE_LEAVE_TOPIC = 4,
    RTM_PRESENCE_TYPE_SELF_JOIN_CHANNEL = 5,
};
```

Presence 类型。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `RTM_PRESENCE_TYPE_REMOTE_JOIN_CHANNEL`     | 0: 远端用户加入频道。  | 
| `RTM_PRESENCE_TYPE_REMOTE_LEAVE_CHANNEL`     | 1: 远端用户离开频道。  | 
| `RTM_PRESENCE_TYPE_REMOTE_CONNECTION_TIMEOUT`     | 2: 远端用户连接超时。  | 
| `RTM_PRESENCE_TYPE_REMOTE_JOIN_TOPIC`     | 3: 远端用户加入 Topic。  | 
| `RTM_PRESENCE_TYPE_REMOTE_LEAVE_TOPIC`     | 4: 远端用户离开 Topic。  | 
| `RTM_PRESENCE_TYPE_SELF_JOIN_CHANNEL`     | 5: 本地用户加入频道。  | 

### LOG_LEVEL

```csharp
    public enum Agora.Rtm.LOG_LEVEL
    {

        LOG_LEVEL_NONE = 0x0000,

        LOG_LEVEL_INFO = 0x0001,

        LOG_LEVEL_WARN = 0x0002,

        LOG_LEVEL_ERROR = 0x0004,

        LOG_LEVEL_FATAL = 0x0008,
    };
```

日志错误等级。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `LOG_LEVEL_NONE`     | 0x0000: 不生成任何日志。  | 
| `LOG_LEVEL_INFO`     | 0x0001: 生成 INFO（信息）等级及以上的日志，即包含 FATAL（严重错误），ERROR（错误），WARN（警告），INFO 四个等级的日志。Agora 推荐你设置为该等级。  | 
| `LOG_LEVEL_WARN`     | 0x0002: 生成 WARN 等级及以上的日志，即包含 FATAL，ERROR），WARN 三个等级的日志。  | 
| `LOG_LEVEL_ERROR`    | 0x0004: 生成 ERROR 等级及以上的日志，即包含 FATAL 和 ERROR 两个等级的日志。  | 
| `LOG_LEVEL_FATAL`    | 0x0008: 只生成 FATAL 等级的日志。  | 