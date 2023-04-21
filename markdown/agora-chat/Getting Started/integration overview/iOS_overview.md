# SDK 集成概述

本文介绍 iOS 集成相关内容。

## 集成环境

开始前，请注册有效的声网账号并创建开启了即时通讯 IM 的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 的声网项目。

详见[开发环境要求](./agora_chat_get_started_ios#前提条件)。

## SDK 初始化

初始化是使用 SDK 的必要步骤，需在执行所有接口方法调用前完成。

如果进行多次初始化操作，只有第一次初始化以及相关的参数生效。

初始化示例代码：

```Objective-C
// 将 appkey 替换成你的 App Key 
AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"<#appkey#>"];
[[AgoraChatClient sharedClient] initializeSDKWithOptions:options];
```

## 注册用户

可以使用如下代码创建账号：

```objectivec
// 异步方法 
[[AgoraChatClient sharedClient] registerWithUsername:@"username"
                                         password:@"your password"
                                       completion:^(NSString *aUsername, AgoraChatError *aError) {                             
                                   }];
```

以上注册模式为在客户端注册，旨在方便测试，并不推荐在生产环境中使用。生产环境应使用服务器端[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

## 用户登录

目前登录服务器支持手动和自动登录。手动登录有两种方式：

- 用户 ID + 密码
- 用户 ID + token

### 手动登录

登录时传入的用户 ID 必须为 String 类型，支持的字符集详见[用户注册的 RESTful 接口](./agora_chat_restful_registration#注册单个用户)。

手动登录后，收到 `connectionStateDidChange` 回调表明 SDK 与环信服务器连接成功。

**用户 ID + 密码** 是传统的登录方式。用户 ID 和密码均由你的终端用户自行决定，密码需要符合密码规则要求。

```objectivec
// 异步方法 
[[AgoraChatClient sharedClient] loginWithUsername:@"username"
                                     password:@"your password"
                                   completion:^(NSString *aUsername, AgoraChatError *aError) {
                                                                 
}];
```

**用户 ID + token** 是更加安全的登录方式。用户权限 token 可从你的 app server 获取，详见[实现 Token 鉴权](./agora_chat_token)。

<div class="alert note">使用 token 登录时需要处理 token 过期的问题，比如每次登录时更新 token 等机制。</div>

```objectivec
// 异步方法 
[AgoraChatClient.sharedClient loginWithUsername:@"username" token:@"token" completion:^(NSString * _Nonnull aUsername, AgoraChatError * _Nullable aError) {
        
}];
```

### 自动登录

在初始化的时候，可以设置是否自动登录。如果设置为自动登录，则登录成功之后，后续启动初始化的时候会自动登录。

自动登录完成后，触发 `AgoraChatClientDelegate` 中的以下回调：

```objectivec
- (void)autoLoginDidCompleteWithError:(AgoraChatError * _Nullable)aError
{
}
```

## 退出登录

```objectivec
// 异步方法 
[AgoraChatClient.sharedClient logout:YES completion:^(AgoraChatError * _Nullable aError) {
        
}];
```

## 连接状态相关

你可以通过注册连接监听 `AgoraChatClientDelegate` 中的回调确认连接状态。

```objectivec
- viewDidLoad
{
    ...
    // 注册连接状态监听，在 SDK 初始化之后调用。
    [AgoraChatClient.sharedClient addDelegate:self delegateQueue:nil];
    ...
}

// 连接状态变更时触发该回调。
- (void)connectionStateDidChange:(AgoraChatConnectionState)aConnectionState
{
    if(aConnectionState == AgoraChatConnectionConnected) {
        // 连接成功。
    }else {
        // 断开连接。
    }
}

// 用户 token 已过期时会触发该回调。
- (void)tokenDidExpire:(AgoraChatErrorCode)aErrorCode
{
}

// 用户 token 即将过期时会触发该回调。
- (void)tokenWillExpire:(AgoraChatErrorCode)aErrorCode
{
}
```

### 断网自动重连

如果由于网络信号弱、切换网络等原因引起的连接中断，SDK 会自动尝试重连。重连成功或者失败会触发 `- (void)connectionStateDidChange:(AgoraChatConnectionState)aConnectionState` 回调 。

### 被动退出登录

你可以通过监听 `AgoraChatClientDelegate` 中的以下回调，调用 `AgoraChatClient#logout:completion:` 退出登录，返回登录界面。

```objectivec
// 当前登录账号在其它设备登录时会触发回调
- (void)userAccountDidLoginFromOtherDevice
{
}

// 当前登录账号被强制退出时会收到该回调，如密码被修改、登录设备过多、服务被封禁、被强制下线等原因
- (void)userAccountDidForcedToLogout:(AgoraChatError *_Nullable)aError
{
}

// 当前登录账号已被从服务器端删除时会收到该回调
- (void)userAccountDidRemoveFromServer
{
}

// 当前用户账号被禁用时会收到该回调
- (void)userDidForbidByServer
{
}
```

## 输出信息到日志文件

SDK 默认的日志输出级别为 `DEBUG`，开发阶段如果希望在声网控制台上输出 SDK 日志，可在 SDK 初始化时开启以下开关：

```objectivec
AgoraChatOptions* option = [AgoraChatOptions optionsWithAppkey:@"<#appkey#>"];
// 日志输出到 Agora 控制台
option.enableConsoleLog = YES;
// 调整日志输出级别，默认为 `Debug`
option.logLevel = AgoraChatLogLevelDebug;
[AgoraChatClient.sharedClient initializeSDKWithOptions:option];
```

### 获取本地日志

SDK 会写入日志文件到本地。日志文件路径如下：沙箱Library/Application Support/HyphenateSDK/easemobLog/easemob.log。

以真机为例，获取本地日志过程如下：

- 打开 Xcode，连接设备，选择 **Xcode** > **Window** > **Devices and Simulators**。
- 进入 **Devices** 选项卡，在左侧选择目标设备，例如 AgoraChat，点击设置图标，然后选择 **Download Container**。

![img](./agora_doc_source/markdown/agora-chat/images/integrationoverview/overview_fetchlogfile_ios.png)

日志文件 `easemob.log` 文件在下载包的 AppData/Library/Application Support/HyphenateSDK/easemobLog 目录下。
