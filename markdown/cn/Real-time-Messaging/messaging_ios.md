---
title: 发送和接收点对点消息及频道消息
platform: iOS
updatedAt: 2021-03-02 02:30:44
---
本章介绍在正式使用 Agora RTM SDK for iOS 进行实时消息通讯前，需要准备的开发环境要求及 SDK 集成方法等内容。

## Demo 体验

你也可以到 GitHub 下载最新版的示例项目查看相关功能的具体实现。

- [Agora-RTM-Tutorial-iOS-Objective-C](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-iOS-Objective-C)
- [Agora-RTM-Tutorial-iOS-Swift](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-iOS)

## 开发环境要求

- Xcode 9.0+。
- iOS 8.0+ 真机（iPhone 或 iPad）。
- 一个有效的 Agora 开发者账号。


<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口并设置域名白名单。</div>

## 准备开发环境

本节介绍如何获取 App ID、创建项目，并将 Agora RTM SDK for iOS 集成至你的项目中。

### <a name="appid"></a> 获取 App ID


参考以下步骤获取一个 App ID。若已有App ID，可以直接查看[创建项目](#create)。
<details>
	<summary><font color="#3ab7f8">获取 App ID</font></summary>

1. 进入 [Agora Dashboard](https://dashboard.agora.io/) ，并按照屏幕提示注册账号并登录 Dashboard。详见[创建新账号](sign_in_and_sign_up)。
2. 点击**项目列表**处的**新手指引**。

	![](https://web-cdn.agora.io/docs-files/1563521764570)

3. 在弹出的窗口中输入你的第一个项目名称，然后点击**创建项目**。你可以参考屏幕提示，了解实现一个视频通话的基本步骤。

	![](https://web-cdn.agora.io/docs-files/1563521821078)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目。点击项目名后的**编辑**按钮，进入项目页。你也可以直接点击左边栏的**项目管理**图标，进入项目页面。

	![](https://web-cdn.agora.io/docs-files/1563522909895)

5. 在**项目管理**页，你可以查看你的 **App ID**。

	![](https://web-cdn.agora.io/docs-files/1563522556558)

</details>

### <a name="create"></a>创建项目

参考以下步骤创建一个 iOS 项目。若已有 iOS 项目，可以直接查看[集成 SDK](#IntegrateSDK)。
<details>
	<summary><font color="#3ab7f8">创建 iOS 项目</font></summary>

1. 打开 **Xcode** 并点击 **Create a new Xcode project**。
2. 选择 **Single View App** 模板并点击 **Next**。
3. 填入你的项目名称，公司名称等信息，选择开发团队与开发语言，点击 **Next**。

> 如果你没有添加过开发团队信息，会看到 **Add account…** 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的账户作为开发团队。

4. 选择你的项目的存储路径，点击 **Create**。
5. 如果你已经设置过开发者签名，可跳过该节。

将你的 iOS 设备连接至电脑。选中当前项目 **Target** ，在 **General** 标签页上找到 **Signing**，勾选 **Automatically manage signing**，在弹窗中点击 **Enable Automatic**。

![](https://web-cdn.agora.io/docs-files/1568803609379)
</details>

### <a name="IntegrateSDK"></a> 集成 SDK

#### 方法 1：通过 Cocoapods 导入 SDK

1. 请确保已在本机安装 Cocoapods。具体方法详见 [Getting Started with Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)。
2. 在你的电脑 Terminal 终端 cd 进入你的项目所在目录，利用 vim 创建 Podfile：
`vim Podfile`
3. 在 Podfile 文件中输入以下内容：
```
target '<YOUR APP>' do
    pod 'AgoraRtm_iOS'
end
```
> 请以你的项目名称替换 \<YOUR APP\> 。
4. 保存 Podfile 并退出：
`:wq`
6. 导入 Agora RTM SDK：
`pod install`
7. 在 Xcode 中打开生成的 **.xcworkspace** 文件。

#### 方法 2：手动添加 SDK 到项目中

1. 下载 [Agora RTM Objective-C SDK for iOS](/cn/Real-time-Messaging/downloads) ，解压后将 **libs** 文件夹内的 **AgoraRtmKit.framework** 文件复制到你的项目文件夹内。
2. 使用 Xcode 打开你的项目，然后选中当前 Target。
3. 打开 **Build Phases** 页面，展开 **Link Binary with Libraries** 项并添加如下库。点击 **+** 图标开始添加
   - **AgoraRtmKit.framework**
   - **libc++.tbd**
   - **libresolv.tbd**
   - **SystemConfiguration.framework**
   - **CoreTelephony.framework**

其中，**AgoraRtmKit.framework** 位于你的项目文件夹下。因此点击 **+** 后，还需要点击 **Add Other…** ，然后进入你的项目所在目录，选中这个文件并点击 **Open**。

### 访问库

根据你的项目使用的编程语言，在项目需要使用 Agora SDK 的文件里，填入下面的代码。

```objective-c
// Objective-C
 #import <AgoraRtmKit/AgoraRtmKit.h>
```

```swift
// Swift
import AgoraRtmKit
```

> 如果填入 import 代码后提示找不到文件，可以尝试在 **Build Settings** 页面 **Framework search paths** 设置中添加 `$(SRCROOT)`。

## 实现实时消息和基本频道操作

本节主要提供实现实时消息和基本频道操作的 API 调用时序图、示例代码，以及相关注意事项。

### API 调用时序图

#### 登录登出 Agora RTM 系统

![](https://web-cdn.agora.io/docs-files/1562566652476)

#### 收发点对点消息

![](https://web-cdn.agora.io/docs-files/1562566668046)

#### 加入离开频道

![](https://web-cdn.agora.io/docs-files/1562566699241)

#### 收发频道消息

![](https://web-cdn.agora.io/docs-files/1562566713620)

### <a name = "create"></a>初始化

调用 `initWithAppId` 方法创建一个实例。在该方法中:

- 填入获取到的 App ID。只有 App ID 相同的应用程序才能互通。
- 指定一个事件回调。SDK 通过回调通知应用程序 SDK 的状态变化和运行事件等，如: 连接状态发生变化，接收到点对点消息等。

```objective-c
@interface ViewController ()<AgoraRtmChannelDelegate, AgoraRtmDelegate>

@property(nonatomic, strong)AgoraRtmKit* kit;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个 AgoraRtmKit 实例
    _kit = [[AgoraRtmKit alloc] initWithAppId:YOUR_APP_ID delegate:self];

}
```


> `AgoraRtmKit` 支持多实例，每个实例独立工作互不干扰，多个实例创建时可以用相同的 `context`，但是事件回调 `AgoraRtmDelegate` 必须是不同的实例。

### <a name = "login"></a>登录

App 必须在登录 RTM 服务器之后，才可以使用 RTM 的点对点消息和群聊功能，在此之前，请确保你已完成初始化。

调用 `loginByToken` 方法[登录RTM服务器](#login)。在该方法中:

- 传入能标识用户角色和权限的 `token`。如果安全要求不高，也可以将值设为 `"nil"`。`token` 需要在应用程序的服务器端生成。详见：[校验用户权限](/cn/Real-time-Messaging/RTM_key)。
- 传入能标识每个用户 ID。`usedId` 为字符串，必须是可见字符（可以带空格），不能为空或者多于 64 个字符，也不能是字符串 `nil`。
- 传入结果回调，用于接收登录 RTM 服务器成功或者失败的结果回调。

```objective-c
[_kit loginByToken:nil user:@"testuser" completion:^(AgoraRtmLoginErrorCode errorCode) {
    if (errorCode != AgoraRtmLoginErrorOk) {
        NSLog(@"login failed %@", @(errorCode));
    } else {
        NSLog(@"login success");
    }
}];

#pragma AgoraRtmDelegate
...
- (void)rtmKit:(AgoraRtmKit *)kit connectionStateChanged:(AgoraRtmConnectionState)state reason:(AgoraRtmConnectionChangeReason)reason
{
    NSLog(@"Connection state changed to %@", @(reason));
}
```

如果需要退出登录，可以调用 `logoutWithCompletion` 方法。

```objective-c
[_kit logoutWithCompletion:^(AgoraRtmLogoutErrorCode errorCode) {
    if (errorCode != AgoraRtmLogoutErrorOk) {
        NSLog(@"logout failed %@", @(errorCode));
    } else {
        NSLog(@"logout success");
    }
}];
```

> 调用 `logoutWithCompletion` 方法之后可以调用 `loginByToken` 重新登录或者切换账号。

### <a name = "sendpeer"></a>点对点消息

App 在成功[登录 RTM 服务器](#login)之后，可以开始使用 RTM 的点对点消息功能。

#### 发送点对点消息

调用 `sendMessage` 方法发送点对点消息。在该方法中：

- 传入目标消息接收方的用户账号 ID。
- 传入 `AgoraRtmMessage` 对象实例。该消息对象由 `AgoraRtmMessage` 类的 `initWithText` 初始化方法创建和设置消息内容。
- 传入消息发送状态监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时，对方不可达等。

```objective-c
- (void)... {
    [_kit sendMessage:[[AgoraRtmMessage alloc] initWithText:@"testmsg"] toPeer:@"peer" completion:^(AgoraRtmSendPeerMessageState state) {
        if (state == AgoraRtmSendPeerMessageStateReceivedByPeer) {
            NSLog(@"Message successfully sent.");
        }
    }];
}

#pragma AgoraRtmDelegate

- (void)rtmKit:(AgoraRtmKit *)kit messageReceived:(AgoraRtmMessage *)message fromPeer:(NSString *)peerId
{
    NSLog(@"Message received from %@: %@", message.text, peerId);
}
```

#### 接收点对点消息

点对点消息的接收通过创建 `AgoraRtmMessage` 实例的时候传入的 `AgoraRtmDelegate` 回调接口进行监听。在该回调接口的 `MessageReceived` 回调方法中可以获取到消息文本内容和是消息发送方的用户 ID (`peerId`)。

```objective-c
- (void)rtmKit:(AgoraRtmKit *)kit messageReceived:(AgoraRtmMessage *)message fromPeer:(NSString *)peerId
{
    NSLog(@"Message received from %@: %@", message.text, peerId);
}
```


> 接收到的 `AgoraRtmMessage` 消息对象不能重复利用再用于发送。

### <a name = "sendchannel"></a>频道消息

App 在成功[登录 RTM 服务器](#login)之后，可以开始使用 RTM 的频道消息功能。

#### 创建并加入频道

1. 调用 `AgoraRtmChannel` 实例的 `createChannelWithId` 方法创建 `AgoraRtmChannel` 实例。在该方法中：
   - 传入能标识每个频道的 ID。`channelId` 为字符串，必须是可见字符（可以带空格），不能为空或者多于 64 个字符，也不能是字符串 `"nil"`。
   - 指定一个事件回调。SDK 通过回调通知应用程序频道的状态变化和运行事件等，如: 接收到频道消息、用户加入和退出频道等。
2. 用户只有在加入频道之后，才能收发频道消息和获取频道成员列表等。调用 `AgoraRtmChannel` 实例的 `joinWithCompletion` 方法加入频道。在该方法中，指定回调用于判断是否成功加入该频道。

```objective-c
@interface ViewController ()<AgoraRtmChannelDelegate, AgoraRtmDelegate>

...
@property(nonatomic, strong)AgoraRtmChannel* channel;

@implementation
- (void)... {
    _channel = [_kit createChannelWithId:@"testchannel" delegate:self];
    [_channel joinWithCompletion:^(AgoraRtmJoinChannelErrorCode state) {
        if(state == AgoraRtmJoinChannelErrorOk) {
            NSLog(@"join success");
        } else {
            NSLog(@"join failed: %@", @(state));
        }
    }];
}
#pragma AgoraRtmChannelDelegate
- (void)channel:(AgoraRtmChannel *)channel memberLeft:(AgoraRtmMember *)member
{
    NSLog(@"%@ left channel %@", member.userId, member.channelId);
}

- (void)channel:(AgoraRtmChannel *)channel memberJoined:(AgoraRtmMember *)member
{
    NSLog(@"%@ joined channel %@", member.userId, member.channelId);
}
```

#### 发送频道消息

在成功加入频道之后，用户可以开始向该频道发送消息。

调用 `AgoraRtmChannel` 实例的 `sendMessage` 方法向该频道发送消息。在该方法中：

- 传入 `AgoraRtmMessage` 对象实例。该消息对象由 `AgoraRtmMessage` 类的 `initWithText` 初始化方法创建和设置消息内容。
- 传入消息发送状态监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时等。

```objective-c
- (void)... {
    [_channel sendMessage:[[AgoraRtmMessage alloc] initWithText:@"channelmsg"] completion:^(AgoraRtmSendChannelMessageState state) {
        if(state == AgoraRtmSendChannelMessageStateReceivedByServer) {
            NSLog(@"sent success");
        }
    }];
}

#pragma AgoraRtmDelegate

- (void)channel:(AgoraRtmChannel *)channel messageReceived:(AgoraRtmMessage *)message fromMember:(AgoraRtmMember *)member
{
    NSLog(@"message received from %@ in channel %@: %@", message.text, member.channelId, member.userId);
}
```

#### 接收频道消息

频道消息的接收通过创建频道消息的时候传入的 `AgoraRtmChannelDelegate` 回调接口进行监听。在该回调接口的 `MessageReceived` 回调方法中可以获取到频道消息文本内容和频道消息的发送者的用户 ID。

```objective-c
- (void)channel:(AgoraRtmChannel *)channel messageReceived:(AgoraRtmMessage *)message fromMember:(AgoraRtmMember *)member
{
    NSLog(@"message received from %@ in channel %@: %@", message.text, member.channelId, member.userId);
}
```



#### 退出频道

调用 `AgoraRtmChannel` 实例的 `leaveWithCompletion` 方法可以退出该频道。

```objective-c
[_channel leaveWithCompletion:^(AgoraRtmLeaveChannelErrorCode state) {
    if(state == AgoraRtmLeaveChannelErrorOk) {
        NSLog(@"leave success");
    } else {
        NSLog(@"leave failed: %@", @(state));
    }
}];
```

### 注意事项

- 每个客户端都需要首先调用 `AgoraRtmKit` 的 `createChannelWithId` 方法创建频道实例才能使用群聊功能，该实例只是本地的一个 `AgoraRtmChannel` 类对象实例。
- RTM 支持同时创建最多 20 个不同的频道实例并加入到多个频道中，但是每个频道实例必须使用不同的频道 ID 以及不同的 `AgoraRtmChannelDelegate` 回调。
- 如果频道 ID 非法，或者具有相同 ID 的频道实例已经在本地创建，`createChannelWithId` 将返回 `"nil"`。
- 接收到的 `AgoraRtmMessage` 消息对象不能重复利用再用于发送。
- 当离开了频道且不再加入该频道时，可以调用 `AgoraRtmChannel` 实例的 `destroyChannelWithId` 方法及时释放频道实例所占用的资源。
- 所有回调如无特别说明，除了基本的参数合法性检查失败触发的回调，均为异步调用。


## 示例代码

- [Agora-RTM-Tutorial-iOS-Objective-C](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-iOS-Objective-C)
  - [MainViewController.m](https://github.com/AgoraIO/RTM/blob/master/Agora-RTM-Tutorial-iOS-Objective-C/Agora-RTM-Tutorial/MainViewController.m)
  - [ChatViewController.m](https://github.com/AgoraIO/RTM/blob/master/Agora-RTM-Tutorial-iOS-Objective-C/Agora-RTM-Tutorial/ChatViewController.m)

- [Agora-RTM-Tutorial-iOS-Swift](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-iOS)
