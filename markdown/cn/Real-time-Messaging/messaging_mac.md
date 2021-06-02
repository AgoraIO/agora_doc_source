---
title: 发送和接收点对点消息及频道消息
platform: macOS
updatedAt: 2021-03-02 02:30:47
---
## 集成客户端

### 前提条件

- Xcode 9.0+。
- OS X 10.0+ 真机（MacBook）
- 一个有效的 Agora 开发者账号。
- 请确保你的项目已设置有效的开发者签名。

### 创建项目

1. 打开 Xcode，新建一个项目。

2. 选择 **Single View App** 模板，点击 **Next**。

3. 填入你的项目名称，公司名称等信息，选择开发团队与开发语言，点击 **Next**。

   如果你没有添加过开发团队信息，会看到 **Add account…** 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的账户作为开发团队。

4. 选择你的项目所要存放的位置，点击 **Create**。

#### 设置开发者签名

如果你已经设置过开发者签名，可跳过该节。

将你的 iOS 设备连接至电脑。选中当前项目 **Target** ，在 **General** 标签页上找到 **Signing**，勾选 **Automatically manage signing**，在弹窗中点击 **Enable Automatic**。

至此，你已经完成了项目的创建。接下来，让我们把 Agora SDK 包添加到这个项目中。

### 安装 SDK

#### 方法 1：通过 Cocoapods 导入 SDK

1. 请确保已在本机安装 Cocoapods。具体方法详见 [Getting Started with Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)。
2. 在你的电脑 Terminal 终端 cd 进入你的项目所在目录，利用 vim 创建 Podfile：
`vim Podfile`
3. 在 Podfile 文件中输入以下内容：
```
target '<YOUR APP>' do
    pod 'AgoraRtm_macOS'
end
```
> 请以你的项目名称替换 \<YOUR APP\> 。
4. 保存 Podfile 并退出：
`:wq`
6. 导入 Agora RTM SDK：
`pod install`
7. 在 Xcode 中打开生成的 **.xcworkspace** 文件。

### 方法 2：手动添加 SDK 到项目中

1. 下载 [Agora RTM Objective-C SDK for macOS](/cn/Real-time-Messaging/downloads) ，解压后将 **libs** 文件夹内的 **AgoraRtmKit.framework** 文件复制到你的项目文件夹内。
2. 使用 Xcode 打开你的项目，然后选中当前 Target。
3. 打开 **Build Phases** 页面，展开 **Link Binary with Libraries** 项并添加如下库。点击 **+** 图标开始添加
   - **AgoraRtmKit.framework**
   - **CoreWLAN.framework**
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

## <a name = "create"></a>初始化

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

### 注意事项

- `AgoraRtmKit` 支持多实例，每个实例独立工作互不干扰，多个实例创建时可以用相同的 `context`，但是事件回调 `AgoraRtmDelegate` 必须是不同的实例。

## <a name = "login"></a>登录

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
        NSLog(@"Logout fails %@", @(errorCode));
    } else {
        NSLog(@"Logout succeeds");
    }
}];
```

> 调用 `logoutWithCompletion` 方法之后可以调用 `loginByToken` 重新登录或者切换账号。

## <a name = "sendpeer"></a>点对点消息

App 在成功[登录 RTM 服务器](#login)之后，可以开始使用 RTM 的点对点消息功能。

### 发送点对点消息

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

### 接收点对点消息

点对点消息的接收通过创建 `AgoraRtmMessage` 实例的时候传入的 `AgoraRtmDelegate` 回调接口进行监听。在该回调接口的 `MessageReceived` 回调方法中可以获取到消息文本内容和是消息发送方的用户 ID (`peerId`)。

```objective-c
- (void)rtmKit:(AgoraRtmKit *)kit messageReceived:(AgoraRtmMessage *)message fromPeer:(NSString *)peerId
{
    NSLog(@"Message received from %@: %@", message.text, peerId);
}
```



### 注意事项

接收到的 `AgoraRtmMessage` 消息对象不能重复利用再用于发送。

## <a name = "sendchannel"></a>频道消息

App 在成功[登录 RTM 服务器](#login)之后，可以开始使用 RTM 的频道消息功能。

### 创建频道实例和加入频道

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
- (void)rtmKit:(AgoraRtmKit *)kit channel:(AgoraRtmChannel *)channel memberLeft:(AgoraRtmMember *)member
{
    NSLog(@"%@ left channel %@", member.userId, member.channelId);
}

- (void)rtmKit:(AgoraRtmKit *)kit channel:(AgoraRtmChannel *)channel memberJoined:(AgoraRtmMember *)member
{
    NSLog(@"%@ joined channel %@", member.userId, member.channelId);
}
```

### 发送频道消息

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

- (void)rtmKit:(AgoraRtmKit *)kit channel:(AgoraRtmChannel *)channel messageReceived:(AgoraRtmMessage *)message fromMember:(AgoraRtmMember *)member
{
    NSLog(@"message received from %@ in channel %@: %@", message.text, member.channelId, member.userId);
}
```

### 接收频道消息

频道消息的接收通过创建频道消息的时候传入的 `AgoraRtmChannelDelegate` 回调接口进行监听。在该回调接口的 `MessageReceived` 回调方法中可以获取到频道消息文本内容和频道消息的发送者的用户 ID。

```obje
- (void)rtmKit:(AgoraRtmKit *)kit channel:(AgoraRtmChannel *)channel messageReceived:(AgoraRtmMessage *)message fromMember:(AgoraRtmMember *)member
{
    NSLog(@"message received from %@ in channel %@: %@", message.text, member.channelId, member.userId);
}
```



### 获取频道成员列表

调用 `AgoraRtmChannel` 实例的 `getMembersWithCompletion` 方法可以获取到当前在该频道内的用户列表。 

### 退出频道

调用 `AgoraRtmChannel` 实例的 `leaveWithCompletion` 方法可以退出该频道。

```objective-c
[_channel leaveWithCompletion:^(AgoraRtmLeaveChannelErrorCode state) {
    if(state == AgoraRtmLeaveChannelErrorOk) {
        NSLog(@"Leave succeeds");
    } else {
        NSLog(@"Leave fails: %@", @(state));
    }
}];
```

退出频道之后可以调用 `joinWithCompletion` 方法再重新加入频道。

### 注意事项

- 每个客户端都需要首先调用 `AgoraRtmKit` 的 `createChannelWithId` 方法创建频道实例才能使用群聊功能，该实例只是本地的一个 `AgoraRtmChannel` 类对象实例。
- RTM 支持同时创建最多 20 个不同的频道实例并加入到多个频道中，但是每个频道实例必须使用不同的频道 ID 以及不同的 `AgoraRtmChannelDelegate` 回调。
- 如果频道 ID 非法，或者具有相同 ID 的频道实例已经在本地创建，`createChannelWithId` 将返回 `"nil"`。
- 接收到的 `AgoraRtmMessage` 消息对象不能重复利用再用于发送。
- 当离开了频道且不再加入该频道时，可以调用 `AgoraRtmChannel` 实例的 `destroyChannelWithId` 方法及时释放频道实例所占用的资源。
- 所有回调如无特别说明，除了基本的参数合法性检查失败触发的回调，均为异步调用。