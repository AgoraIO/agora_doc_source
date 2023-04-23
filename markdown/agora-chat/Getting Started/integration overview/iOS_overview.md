# SDK 集成概述

本页介绍用户注册、登录和登出即时通讯 IM、查看即时通讯 IM 与声网服务器之间的连接状态以及查看和获取日志。

## 注册用户

本节介绍三种用户注册方式。

### 控制台注册

登录[声网控制台](https://console.agora.io/)，选择**即时通讯** > **运营管理** > **用户**，创建即时通讯用户。

### RESTful API 注册

调用服务器端[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

### SDK 注册

可以使用如下代码创建账号：

```objectivec
// 异步方法 
[[AgoraChatClient sharedClient] registerWithUsername:@"username"
                                         password:@"your password"
                                       completion:^(NSString *aUsername, AgoraChatError *aError) {                             
                                   }];
```

以上为客户端注册，旨在方便测试，并不推荐在生产环境中使用。生产环境中应[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

## 用户登录

目前登录服务器支持手动和自动登录。手动登录有两种方式：

- 用户 ID + 密码
- 用户 ID + token

### 手动登录

登录时传入的用户 ID 必须为 String 类型，支持的字符集详见[调用 RESTful 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

手动登录后，收到 `connectionStateDidChange` 回调表明 SDK 与声网服务器连接成功。

**用户 ID + 密码** 是传统的登录方式。用户 ID 和密码均由你的终端用户自行决定，需要符合[设置要求](./agora_chat_restful_registration#开放注册单个用户)。

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
[AgoraChatClient.sharedClient loginWithUsername:@"username" agoraToken:@"token" completion:^(NSString * _Nonnull aUsername, AgoraChatError * _Nullable aError) {
        
}];
```

### 自动登录

在初始化时，可以设置是否自动登录。如果设置为自动登录，则登录成功之后，后续启动初始化时会自动登录。

自动登录完成后，触发 `AgoraChatClientDelegate` 中的以下回调：

```objectivec
- (void)autoLoginDidCompleteWithError:(AgoraChatError * _Nullable)aError
{
}
```

## 退出登录

- 主动退出登录

主动退出登录的代码如下：

```objectivec
// 异步方法 
[AgoraChatClient.sharedClient logout:YES completion:^(AgoraChatError * _Nullable aError) {
        
}];
```

- 被动退出登录

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

## 监听连接状态

你可以通过注册连接监听 `AgoraChatClientDelegate` 中的回调确认连接状态。

```objectivec
- viewDidLoad
{
    ...
    // 注册连接状态监听，在 SDK 初始化后调用。
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

// 用户 token 过期时会触发该回调。
- (void)tokenDidExpire:(AgoraChatErrorCode)aErrorCode
{
}

// 用户 token 即将过期时会触发该回调。
- (void)tokenWillExpire:(AgoraChatErrorCode)aErrorCode
{
}
```

## 断网自动重连

如果由于网络信号弱、切换网络等原因引起的连接中断，SDK 会自动尝试重连。重连成功或者失败会触发 `- (void)connectionStateDidChange:(AgoraChatConnectionState)aConnectionState` 回调 。

## 输出信息到日志文件

SDK 默认的日志输出级别为 `DEBUG`，开发阶段如果希望在声网控制台上输出 SDK 日志，可在 SDK 初始化时开启以下开关：

```objectivec
AgoraChatOptions* option = [AgoraChatOptions optionsWithAppkey:@"<#appkey#>"];
// 日志输出到声网控制台
option.enableConsoleLog = YES;
// 调整日志输出级别，默认为 `Debug`
option.logLevel = AgoraChatLogLevelDebug;
[AgoraChatClient.sharedClient initializeSDKWithOptions:option];
```

## 获取本地日志

SDK 会写入日志文件到本地。日志文件路径如下：沙箱Library/Application Support/HyphenateSDK/easemobLog/easemob.log。

以真机为例，获取本地日志过程如下：

- 打开 Xcode，连接设备，选择 **Xcode** > **Window** > **Devices and Simulators**。
- 进入 **Devices** 选项卡，在左侧选择目标设备，例如 AgoraChat，点击设置图标，然后选择 **Download Container**。

![](https://web-cdn.agora.io/docs-files/1681722865152)

![img](./agora_doc_source/markdown/agora-chat/images/integrationoverview/overview_fetchlogfile_ios.png)

日志文件 `easemob.log` 文件在下载包的 AppData/Library/Application Support/HyphenateSDK/easemobLog 目录下。
