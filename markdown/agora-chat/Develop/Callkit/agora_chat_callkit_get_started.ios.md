# 实现音视频通话

AgoraChatCallKit 是一套基于声网的实时通讯和信令服务开发的开源音视频 UI 库。利用该库可实现音视频通话功能，提升多种服务之间的同步。同时，用户在多个设备登录时能同步处理呼叫振铃，即当用户在一台设备上处理振铃后，其他设备自动停止振铃。

本文展示如何使用 AgoraChatCallKit 快速构建实时音视频场景。

## 实现原理

使用 AgoraChatCallKit 实现音视频通话的基本流程如下：

1. 调用 `init` 方法初始化 AgoraChatCallKit。
2. 主叫方调用 `startSingleCallWithUid` 或 `startInviteUsers` 方法发送一对一通话或多人通话的邀请。
3. 被叫方收到 `callDidReceive` 回调时，确认是否接受通话邀请。若被叫方接受邀请，则进入通话。
4. 结束通话时，SDK 触发 `callDidEnd` 回调。

## 前提条件

开始前，请确保你的开发环境中满足如下条件：
- Xcode 9.0 或以上版本；
- 一台运行 iOS 10.0 或以上版本的设备；
- 创建即时通讯 IM 项目集成了 Chat SDK 并实现了基本实时通讯功能的，包含用户登录登出和发送和接收消息等。

## 项目设置

参考如下步骤，将 AgoraChatCallKit 集成到你的项目中，并搭建开发环境。

### 添加 AgoraChatCallKit 框架

AgoraChatCallKit 基于 `Agora_Chat_iOS`、`Masonry`、`AgoraRtcEngine_iOS/RtcBasic` 和 `SDWebImage` 库开发。你可以参考以下步骤将AgoraChatCallKit 导入到项目。若需手动添加该框架，请参考 [手动导入 AgoraChatCallKit](#import)。

1. 安装 CocoaPods，详见 [CocoaPods 快速开始](https://guides.cocoapods.org/using/getting-started.html#getting-started)。
2. 若你的项目中没有 `Podfile` 文件，需打开项目的根目录，然后运行 `pod init` 命令在项目文件夹中创建 `Podfile` 文本文件。

3. 打开 `Podfile` 文件，添加 `use_frameworks` 和 `AgoraChatCallKit` 框架，将 `AppName` 替换为你的项目名称：

    ```Objective-C
    use_frameworks!
    // 将 AppName 替换为你的项目名称
    target 'AppName' do
        pod 'AgoraChatCallKit'
    end
    ```
4. 在项目的根目录中，运行 `pod install` 命令添加框架。
   SDK 安装成功后，终端会显示 `Pod installation complete!` 消息，项目文件夹中会生成 `xcworkspace` 文件。

5. 在 Xcode 中打开 `xcworkspace` 文件。

### 添加项目权限

打开 `info.plist` 文件中，添加以下权限：

| Key | Type | Value|  
| ---- | ---- | ---- |
| Privacy - Microphone Usage Description | String | 描述信息，如“需使用你的麦克风”。 |  
| Privacy - Camera Usage Description | String | 描述信息，如“需使用你的摄像头” 。 |  

## 实现音视频通话

参考如下步骤在项目中实现音视频通话。

### 初始化 AgoraChatCallKit

调用 `init` 进行 AgoraChatCallKit 初始化。

```Objective-C
AgoraChatCallConfig *config = [[AgoraChatCallConfig alloc] init];
config.agoraAppId = @"agoraAppId";
config.enableRTCTokenValidate = YES;
config.enableIosCallKit = YES;
[AgoraChatCallManager.sharedManager initWithConfig:config delegate:self];
```

你需要在该方法中设置 `AgoraChatCallConfig`。其中可设置的配置项包括以下内容：

```Objective-C
@interface AgoraChatCallConfig : NSObject
/**
 *  呼叫超时时间，即主叫发出通话邀请后等待被叫接听的最长时间。
 *  单位为秒。默认为 30 秒。
 */
@property (nonatomic) UInt32 callTimeOut;
/**
 *  用户信息字典。
 *  字典中的数据为 key-value 格式，key 为用户 ID，value 为 `EaseCallUser`。
 */
@property (nonatomic,strong) NSMutableDictionary<NSString*,AgoraChatCallUser*>* users;
/**
 * 振铃文件的 URL。该字段仅在 `enableIosCallKit` 设置为 `NO` 时有效。
 */
@property (nonatomic,strong) NSURL* ringFileUrl;
/**
 * 项目的 App ID，可从声网控制台获取。
 */
@property (nonatomic,strong) NSString* agoraAppId;
/**
 *  加入声网频道时是否开启声网 token 验证：
 *  - （默认） `YES`：开启。开启后必须实现 `callDidRequestRTCTokenForAPPId` 回调，收到回调后调用 `setRTCToken` 传声网 token 才能发起或加入通话。
 *  - `NO`：关闭。
 */
@property (nonatomic) BOOL enableRTCTokenValidate;
/**
 * 是否启用 iOS CallKit 框架。
 */
@property (nonatomic, assign) BOOL enableIosCallKit;

@end
```
### 发起通话邀请

调用 `startSingleCallWithUId` 或 `startInviteUsers` 方法，发起一对一或多人通话的邀请。你需要在该方法中指定通话类型。

- 一对一语音通话

    ```Objective-C
      [AgoraChatCallManager.sharedManager startSingleCallWithUId:userId type:AgoraChatCallType1v1Audio ext:nil completion:^(NSString * callId, AgoraChatCallError * aError) {
  }];
    ```

- 一对一视频通话

    ```Objective-C
      [AgoraChatCallManager.sharedManager startSingleCallWithUId:userId type:AgoraChatCallType1v1Video ext:nil completion:^(NSString * callId, AgoraChatCallError * aError) {
  }];
    ```

- 发起多人语音通话

    ```Objective-C
        ConfInviteUsersViewController *controller = [[ConfInviteUsersViewController alloc] initWithGroupId:groupId excludeUsers:@[AgoraChatClient.sharedClient.currentUsername]];
  controller.didSelectedUserList = ^(NSArray * _Nonnull aInviteUsers) {
      for (NSString *strId in aInviteUsers) {
          AgoraChatUserInfo *info = [UserInfoStore.sharedInstance getUserInfoById:strId];
          if (info && (info.avatarUrl.length > 0 || info.nickname > 0)) {
                  AgoraChatCallUser *user = [AgoraChatCallUser userWithNickName:info.nickname image:[NSURL URLWithString:info.avatarUrl]];
              [[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:strId info:user];
          }
      }
      [AgoraChatCallManager.sharedManager startInviteUsers:aInviteUsers groupId:groupId callType:AgoraChatCallTypeMultiAudio ext:@{
          @"groupId":groupId
      } completion:^(NSString * callId, AgoraChatCallError * aError) {

      }];
  };

  controller.modalPresentationStyle = UIModalPresentationPageSheet;
  [viewController presentViewController:controller animated:YES completion:nil];
    ```

- 发起多人视频通话

    ```Objective-C
      ConfInviteUsersViewController *controller = [[ConfInviteUsersViewController alloc] initWithGroupId:groupId excludeUsers:@[AgoraChatClient.sharedClient.currentUsername]];
  controller.didSelectedUserList = ^(NSArray * _Nonnull aInviteUsers) {
      for (NSString *strId in aInviteUsers) {
          AgoraChatUserInfo *info = [UserInfoStore.sharedInstance getUserInfoById:strId];
          if (info && (info.avatarUrl.length > 0 || info.nickname > 0)) {
                  AgoraChatCallUser *user = [AgoraChatCallUser userWithNickName:info.nickname image:[NSURL URLWithString:info.avatarUrl]];
              [[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:strId info:user];
          }
      }
      [AgoraChatCallManager.sharedManager startInviteUsers:aInviteUsers groupId:groupId callType:AgoraChatCallTypeMultiVideo ext:@{
          @"groupId":groupId
      } completion:^(NSString * callId, AgoraChatCallError * aError) {

      }];
  };

  controller.modalPresentationStyle = UIModalPresentationPageSheet;
  [viewController presentViewController:controller animated:YES completion:nil];
    ```

发起通话后的 UI 界面如下：
<img src="https://web-cdn.agora.io/docs-files/1655259327417" style="zoom:50%;" />

### 收到邀请

呼叫邀请发送后，被叫通过 `callDidReceive` 回调收到邀请。

```Objective-C
- (void)callDidReceive:(EaseCallType)aType inviter:(NSString*_Nonnull)user ext:(NSDictionary*)aExt
{

}
```

如果被叫方在线且并未处于通话过程中，将弹出通话页面，被叫用户可选择接听或者拒绝。如果启用了 iOS CallKit，将显示系统的通话页面。如果未启用，显示如下：
<img src="https://web-cdn.agora.io/docs-files/1655259340569" style="zoom:50%;" />


### 多人通话中间发起邀请

多人通话中，当前用户可以向其他用户发起邀请。这种情况下，SDK 会触发 `AgoraChatCallDelegate` 中的 `multiCallDidInvitingWithCurVC` 回调：

```Objective-C
// 多人音视频邀请按钮的回调。
// vc     当前 UI 视图控制器。
// users  发出邀请的通话成员及受邀的用户 ID。
// aExt   呼叫邀请中的扩展信息。
- (void)multiCallDidInvitingWithCurVC:(UIViewController*_Nonnull)vc excludeUsers:(NSArray<NSString*> *_Nullable)users ext:(NSDictionary *)aExt
  {
    NSString *groupId = nil;
    if (aExt) {
        groupId = [aExt objectForKey:@"groupId"];
    }
    if (!groupId || groupId.length <= 0) {
        return;
    }

    ConfInviteUsersViewController *confVC = [[ConfInviteUsersViewController alloc] initWithGroupId:groupId excludeUsers:users];
    confVC.didSelectedUserList = ^(NSArray * _Nonnull aInviteUsers) {
        for (NSString* strId in aInviteUsers) {
            AgoraChatUserInfo *info = [[UserInfoStore sharedInstance] getUserInfoById:strId];
            if (info && (info.avatarUrl.length > 0 || info.nickname.length > 0)) {
                AgoraChatCallUser *user = [AgoraChatCallUser userWithNickName:info.nickname image:[NSURL URLWithString:info.avatarUrl]];
                [[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:strId info:user];
            }
        }
        [AgoraChatCallManager.sharedManager startInviteUsers:aInviteUsers groupId:groupId callType:AgoraChatCallTypeMultiAudio ext:aExt completion:nil];
    };
    confVC.modalPresentationStyle = UIModalPresentationPopover;
    [vc presentViewController:confVC animated:YES completion:nil];
}
```
通话邀请界面的实现，可以参考 Demo 中的 `ConfInviteUsersViewController` 实现。

### 监听回调事件

通话期间，你可以监听以下回调事件：

- `callDidJoinChannel`： 当前用户成功加入会话的回调。

```Objective-C
- (void)callDidJoinChannel:(NSString*_Nonnull)aChannelName uid:(NSUInteger)aUid
{
    [self _fetchUserMapsFromServer:aChannelName];
}
```
- `remoteuserDidJoinChannel`：对方成功加入会话的回调。

```Objective-C
  -(void)remoteUserDidJoinChannel:( NSString*_Nonnull)aChannelName uid:(NSInteger)aUid username:(NSString*_Nullable)aUserName
  {
      if (aUserName.length > 0) {
          AgoraChatUserInfo* userInfo = [[UserInfoStore sharedInstance] getUserInfoById:aUserName];
          if (userInfo && (userInfo.avatarUrl.length > 0 || userInfo.nickname.length > 0)) {
              AgoraChatCallUser* user = [AgoraChatCallUser userWithNickName:userInfo.nickname image:[NSURL URLWithString:userInfo.avatarUrl]];
              [[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:aUserName info:user];
          }
      } else {
          [self _fetchUserMapsFromServer:aChannelName];
      }
  }
```
### 通话结束

在一对一音视频通话中，若其中一方挂断，双方的通话会自动结束，而多人音视频通话中需要主动挂断才能结束通话。通话结束后，会触发 `callDidEnd` 回调：

```Objective-C
- (void)callDidEnd:(NSString*_Nonnull)aChannelName reason:(AgoraChatCallEndReason)aReason time:(int)aTm type:(AgoraChatCallType)aType
{
    NSString *msg = @"";
    switch (aReason) {
        case AgoraChatCallEndReasonHandleOnOtherDevice:
            msg = NSLocalizedString(@"otherDevice", nil);
            break;
        case AgoraChatCallEndReasonBusy:
            msg = NSLocalizedString(@"remoteBusy", nil);
            break;
        case AgoraChatCallEndReasonRefuse:
            msg = NSLocalizedString(@"RemoteRefuseCall", nil);
            break;
        case AgoraChatCallEndReasonCancel:
            msg = NSLocalizedString(@"cancelCall", nil);
            break;
        case AgoraChatCallEndReasonNoResponse:
            msg = NSLocalizedString(@"remoteNoResponse", nil);
            break;
        case AgoraChatCallEndReasonHangup:
            msg = [NSString stringWithFormat:NSLocalizedString(@"callendPrompt", nil),aTm];
            break;
        default:
            break;
    }
    if (msg.length > 0) {
        [self showHint:msg];
    }
}
```

## 后续操作

本节介绍你的项目中涉及的音视频通话功能的其他操作。

### 通话异常回调

通话过程中如果有异常或者错误发生，SDK 会触发 `callDidOccurError` 回调，通过 `AgoraChatCallError` 上报异常的详细信息。

```Objective-C
- (void)callDidOccurError:(AgoraChatCallError *_Nonnull)aError
{
}
```

### 修改用户头像或昵称

用户加入通话后，你可以调用 `setUser` 修改自己和通话中其他用户的头像和昵称：

```Objective-C
AgoraChatCallUser *user = [AgoraChatCallUser userWithNickName:info.nickname image:[NSURL URLWithString:info.avatarUrl]];
[[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:userId info:user];
```

### 使用 RTC token 对用户进行身份验证

为提高通信安全性，声网建议你在应用用户加入通话前使用 RTC token 对其进行身份验证。为此，你需要确保[启用项目的主证书](https://docs.agora.io/cn/All/faq/appid_to_token)，并将 AgoraChatCallKit 中的 `enableRTCTokenValidate` 设置为 `YES`。

```Objective-C
config.enableRTCTokenValidate = YES;  
[AgoraChatCallManager.sharedManager initWithConfig:config delegate:self];
```

启用 token 身份验证后，请确保监听 `callDidRequestRTCTokenForAppId` 回调。当`callDidRequestRTCTokenForAppId` 被触发时，你需要获取 token 并调用 `setRTCToken` 将 token 传递给 CallKit。Token 由声网提供的 token 生成器在你的应用服务器上生成。关于如何在服务器上生成 token 并在客户端获得和更新令牌，请参阅 [基于 Token 的用户验证](https://docs.agora.io/cn/Video/token_server?platform=iOS)。

```Objective-C
- (void)callDidRequestRTCTokenForAppId:(NSString *)aAppId channelName:(NSString *)aChannelName account:(NSString *)aUserAccount uid:(NSInteger)aAgoraUid
{
    [AgoraChatCallManager.sharedManager setRTCToken:rtcToken channelName:aChannelName uid: The Agora UID];
}
```

## 参考

本节提供其他参考信息，供你在实现实时音视频通信功能时参考。

### API 列表

该 AgoraChatCallKit 框架包含 `AgoraChatCallManager` 和 `AgoraChatCallDelegate` 类。

下表列出了管理模块 `AgoraChatCallManager` 中的核心方法：

| 方法 | 说明 |  
| ---- | ---- |
| initWithConfig:delegate | 初始化 AgoraChatCallKit。 |  
| startSingleCallWithUId:type:ext:completion | 开始一对一通话。 | 
| startInviteUsers:groupId:callType:ext:completion:  | 邀请用户加入多人通话。 |
| getAgoraChatCallConfig | 获取 AgoraChatCallKit 的相关配置。 |
| setRTCToken:channelName:uid: | 设置 RTC Token。 |
| setUsers:channelName: | 设置即时通讯 IM 的用户 ID 和 Agora 用户 ID（UID）的映射关系。 |  

下表列出了回调模块 `AgoraChatCallDelegate` 中的核心方法：

| 方法 | 说明 |
| ---- | ---- |
| callDidEnd:reason:time:type: | 通话结束时触发该事件。 |
| multiCallDidInvitingWithCurVC:callType:excludeUsers:ext: | 多人通话中邀请其他用户加入通话时触发该事件。 |
| callDidReceive:inviter:ext: | 收到呼叫邀请且设备振铃时触发该事件。 |
| callDidRequestRTCTokenForAppId:channelName:account:uid: | 请求获取声网 token 的回调。 |
| callDidOccurError: | 通话过程中发生异常和错误时触发该事件。 |
| remoteUserDidJoinChannel:uid:username: | 对方加入通话时触发。 |
| callDidJoinChannel:uid: | 当前用户加入通话时触发。 |

### 示例项目

声网在 GitHub 上提供了一个开源的 [AgoraChat-ios](https://github.com/AgoraIO-Usecase/AgoraChat-ios/blob/main/README_CN.md) 示例项目。您可以下载示例进行试用或查看源代码。

示例项目使用即时通讯 IM 的 用户 ID 加入频道，可以在通话视图中显示用户 ID。如果使用 Agora RTC SDK 中的方法发起通话，也可以使用整型的 UID 加入频道。

### 手动导入 `AgoraChatCallKit` <a name="import"></a>

若要在项目中手动添加 AgoraChatCallKit，可参考以下步骤：

1. [下载 AgoraChatCallKit](https://github.com/AgoraIO-Usecase/AgoraChat-CallKit-ios/blob/main/README_CN.md)，并解压下载的文件。

2. 将 `AgoraChatCallKit.framework` 复制并粘贴 到你的项目目录中。

3. 打开 `Xcode`，选择 **TARGETS > Project Name > General**，将 `AgoraChatCallKit.framework` 拖拽到项目中，在 `Frameworks, Libraries, and Embedded Content` 中将 `AgoraChatCallKit.framework` 设置为 `Embed & Sign`。

### 其他项目设置

你可以根据你的用例进行以下项目设置：

1. 如果希望在后台运行，还需要添加后台运行音视频权限，在 `info.plist` 文件中，点击 `+` 图标并添加 `Required background modes`。将 `Type` 设置为 `Array`，在 `Required background modes` 下添加 `App plays audio or streams audio/video using AirPlay` 值。  
2. 如果要使用苹果的 `PushKit` 和 `CallKit` 服务，选择 `TARGETS > Project Name > Signing and Capabilities`，在 `Background Modes` 下勾选 `Voice over IP`。
