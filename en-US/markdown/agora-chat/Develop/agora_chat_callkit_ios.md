AgoraChatCallKit is an open-source audio and video UI library developed based on Agora's real-time communications and signaling services. With this library, you can implement audio and video calling functionalities with enhanced synchronization between multiple devices. In scenarios where a user ID is logged in to multiple devices, once the user deals with an incoming call that is ringing on one device, all the other devices stop ringing simultaneously.

This page describes how to implement real-time audio and video communications using the AgoraChatCallKit.

## Understand the tech

The basic process for implementing real-time audio and video communications with AgoraChatCallKit is as follows:

1. Initialize AgoraChatCallKit by calling `init`.
2. Call `startSingleCallWithUid` or `startInviteUsers` on the caller's client to send a call invitation for one-to-one or group calls.
3. On the callee's client, accept or decline the call invitation after receiving `callDidReceive`. Once a user accepts the invitation, they enter the call.
4. When the call ends, the SDK triggers the `callDidEnd` callback.

## Prerequisites

Before proceeding, ensure that your development environment has the following:

- Xcode 9.0 or later.
- A device running iOS 10.0 or later.
- An Agora Chat project that has integrated the Chat SDK and implemented the [basic real-time chat functionalities](./agora_chat_get_started_ios?platform=iOS), including users logging in and out and sending and receiving messages.

## Project setup

Take the following steps to integrate the AgoraChatCallKit into your project and set up the development environment.

### Add the AgoraChatCallKit framework

AgoraChatCallKit is developed upon `Agora_Chat_iOS`, `Masonry`, `AgoraRtcEngine_iOS/RtcBasic`, and `SDKWebImage`. Refer to the following steps to import AgoraChatCallKit into your project. If you prefer to add the framework manually, refer to [Manually import AgoraChatCallKit](#import).

1. Install CocoaPods if you have not. For details, see [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. If your project does not have a `Podfile` file, navigate to the project root directory, and run the `pod init` command to create a text file `Podfile` in the project folder.

3. Open the `Podfile` file, and add `use_frameworks` and the `AgoraChatCallKit` framework. Remember to replace `AppName` with the target name of your project.

   ```objective-c
    use_frameworks!
    // Replace AppName with the name of your project
    target 'AppName' do
        pod 'AgoraChatCallKit'
        // Other frameworks
    end
   ```

4. In the project root directory, run `pod install` to add the framework. When the SDK is installed successfully, you can see `Pod installation complete!` in the Terminal and an `xcworkspace` file in the project folder. 

5. Open the `xcworkspace` file in Xcode.

### Add permissions

Open the `info.plist` file, and add the following permissions:

| Key | Type | Value |
| --- | --- | --- |
| `Privacy - Microphone Usage Description` | String | The description for using the microphone. For example, to access the microphone. |
| `Privacy - Camera Usage Description` | String | The description for using the camera. For example, to access the camera. |


## Implement audio and video calling

This section introduces the core steps for implementing audio and video calls in your project.

### Initialize AgoraChatCallKit

Call `init` to initialize the AgoraChatCallKit.

```objective-c
AgoraChatCallConfig *config = [[AgoraChatCallConfig alloc] init];
config.agoraAppId = @"agoraAppId";
config.enableRTCTokenValidate = YES;
config.enableIosCallKit = YES;
[AgoraChatCallManager.sharedManager initWithConfig:config delegate:self];
```

In this method, you need to set the `AgoraChatCallConfig` interface. Some of the configurations include the following:

```objective-c
@interface AgoraChatCallConfig : NSObject
/**
 * The timeout duration for the call invitation, in seconds. The default value is 30.
 */
@property (nonatomic) UInt32 callTimeOut;
/**
 * The dictionary of the user information. The data format is key-value pairs, where key represents the user ID and value is EaseCallUser. 
 */
@property (nonatomic,strong) NSMutableDictionary<NSString*,AgoraChatCallUser*>* users;
/**
 * Specify the file URL of the ringtone. This field is valid only when enableIosCallKit is set to NO.
 */
@property (nonatomic,strong) NSURL* ringFileUrl;
/**
 * The App ID of the project, which you can obtain from Agora Console.
 */
@property (nonatomic,strong) NSString* agoraAppId;
/**
 *  Whether to enable token authentication when users join the Agora channel:
 *  - (Default) YES: Enable token authentication. Once you set it as YES, you must implement the callDidRequestRTCTokenForAPPId callback. After receiving this callback, you need to call setRTCToken to pass in the token to start or join a call.
 *  - NO: Do not enable token authentication.
 */
@property (nonatomic) BOOL enableRTCTokenValidate;
/**
 * Whether to use the iOS CallKit framework.
 */
@property (nonatomic, assign) BOOL enableIosCallKit;

@end
```

### Send a call invitation

From the caller's client, call `startSingleCallWithUId` or `startInviteUsers` to send a call invitation for a one-to-one call or group call. You need to specify the call type when calling the method.

- One-to-one audio call

    ```objective-c
    [AgoraChatCallManager.sharedManager startSingleCallWithUId:userId type:AgoraChatCallType1v1Audio ext:nil completion:^(NSString * callId, AgoraChatCallError * aError) {
    }];
    ```

- One-to-one video call

    ```objective-c
    [AgoraChatCallManager.sharedManager startSingleCallWithUId:userId type:AgoraChatCallType1v1Video ext:nil completion:^(NSString * callId, AgoraChatCallError * aError) {
    }];
    ```

- Group audio call

    ```objective-c
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

- Group video call

    ```objective-c
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

The following screenshot gives an example of the user interface after sending a call invitation for one-to-one audio call:

<img src="https://web-cdn.agora.io/docs-files/1655259327417" style="zoom:50%;" />

### Receive the invitation

Once a call invitaion is sent, the callee receives the invitation in the `callDidReceive` callback.

```objective-c
- (void)callDidReceive:(EaseCallType)aType inviter:(NSString*_Nonnull)user ext:(NSDictionary*)aExt
{

}
```

If the callee is online and available for a call, you can pop out a user interface that allows the callee to accept or decline the invitation. If you have enabled the iOS CallKit, the system call user interface is launched. Otherwise, you can refer to the following screenshot to implement the interface:

<img src="https://web-cdn.agora.io/docs-files/1655259340569" style="zoom:50%;" />


### Send a call invitation during a group call

In call sessions with multiple users, these users can also send call invitations to other users. After sending the invitation, the SDK triggers the `multiCallDidInvitingWithCurVC` callback in `AgoraChatCallDelegate` on the sender's client.

```objective-c
/**
 * Occurs when the local user sends a call invitation during a group call.
 * vc     The current UI view controller.
 * users  The user IDs that are already in the group call.
 * aExt   Extension information.
 */
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

### Listen for callback events

During the call, you can also listen for the following callback events:

- `callDidJoinChannel`, occurs when the local user successfully joins the call.

    ```objective-c
    - (void)callDidJoinChannel:(NSString*_Nonnull)aChannelName uid:(NSUInteger)aUid
    {
        [self _fetchUserMapsFromServer:aChannelName];
    }
    ```

- `remoteuserDidJoinChannel`, occurs when the remote user successfully joins the call.

    ```objective-c
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

### End the call

A one-to-one call ends as soon as one of the two users hangs up, while a group call ends only after the local user hangs up. When the call ends, the SDK triggers the `callDidEnd` callback.


```objective-c
- (void)callDidEnd:(NSString*_Nonnull)aChannelName reason:(AgoarChatCallEndReason)aReason time:(int)aTm type:(AgoraChatCallType)aType
{
    NSString *msg = @"";
    switch (aReason) {
        case AgoarChatCallEndReasonHandleOnOtherDevice:
            msg = NSLocalizedString(@"otherDevice", nil);
            break;
        case AgoarChatCallEndReasonBusy:
            msg = NSLocalizedString(@"remoteBusy", nil);
            break;
        case AgoarChatCallEndReasonRefuse:
            msg = NSLocalizedString(@"RemoreRefuseCall", nil);
            break;
        case AgoarChatCallEndReasonCancel:
            msg = NSLocalizedString(@"cancelCall", nil);
            break;
        case AgoarChatCallEndReasonNoResponse:
            msg = NSLocalizedString(@"remoteNoResponse", nil);
            break;
        case AgoarChatCallEndReasonHangup:
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

## Next steps

This section contains extra steps you can take for the audio and video call functionalities in your project.

### Call exceptions

If exceptions or errors occur during a call, the SDK triggers the `callDidOccurError` callback, which reports the detailed information of the exception in `AgoraChatCallError`. 

```objective-c
- (void)callDidOccurError:(AgoraChatCallError *_Nonnull)aError
{
}
```

### Update the user avator or nickname

After a user joins the call, you can call `setUser` to modify the avatar and nickname of the current user and the other users in the channel. 

```objective-c
AgoraChatCallUser *user = [AgoraChatCallUser userWithNickName:info.nickname image:[NSURL URLWithString:info.avatarUrl]];
[[AgoraChatCallManager.sharedManager getAgoraChatCallConfig] setUser:userId info:user];
```

### Authenticate users with the RTC token

To enhance communication security, Agora recommends that you authenticate app users with the RTC token before they join a call. To do this, you need to make sure that the [Primary Certificate of your project is enabled](https://docs.agora.io/en/All/faq/appid_to_token), and `enableRTCTokenValidate` in the AgoraChatCallKit is set to `YES`.

```objective-c
config.enableRTCTokenValidate = YES;  
[AgoraChatCallManager.sharedManager initWithConfig:config delegate:self];
```

Once you enable token authentication, ensure that you listen for the `callDidRequestRTCTokenForAppId` callback. When `callDidRequestRTCTokenForAppId` is triggered, you need to retrieve the token and call `setRTCToken` to pass the token to the CallKit. Tokens are generated on your app server using the token generator provided by Agora. For how to generate a token on the server and retrieve and renew the token on the client, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Video/token_server?platform=iOS).


```Objecitve-C
- (void)callDidRequestRTCTokenForAppId:(NSString *)aAppId channelName:(NSString *)aChannelName account:(NSString *)aUserAccount uid:(NSInteger)aAgoraUid
{
    [AgoraChatCallManager.sharedManager setRTCToken:rtcToken channelName:aChannelName uid: The Agora UID];
}
```

## Reference

This section provides other reference information that you can refer to when implementing real-time audio and video communications functionalities.

### API list

The `AgoraChatCallKit` framework contains the `AgoraChatCallManager` and `AgoraChatCallDelegate` classes.

The following table lists the core methods in `AgoraChatCallManager`:

| Method | Description |  
| ---- | ---- |
| initWithConfig:delegate | Initializes AgoraChatCallKit. |  
| startSingleCallWithUId:type:ext:completion | Starts a one-to-one call. | 
| startInviteUsers:groupId:callType:ext:completion:  | Starts a group call. |
| getAgoraChatCallConfig | Retrieves the configurations of AgoraChatCallKit. |
| setRTCToken:channelName:uid: | Sets the RTC Token. |
| setUsers:channelName: | Sets the mapping between Agora Chat user ID and Agora user ID (UID). |  

The following table lists the callbacks in `AgoraChatCallDelegate`:

| Event | Description |
| ---- | ---- |
| callDidEnd:reason:time:type: | Occurs when the call ends. |
| multiCallDidInvitingWithCurVC:callType:excludeUsers:ext: | Occurs when a member of the group call invites other users to the call. |
| callDidReceive:inviter:ext: | Occurs when the call invitation is received and the device rings. |
| callDidRequestRTCTokenForAppId:channelName:account:uid: | Requests the RTC token. |
| callDidOccurError: | Reports exceptions and errors during the call. |
| remoteUserDidJoinChannel:uid:username: | Occurs when a remote user joins the call. |
| callDidJoinChannel:uid: | Occurs when the current user joins the call. |

### Sample project

Agora provides an open-source [AgoraChat-ios](https://github.com/AgoraIO-Usecase/AgoraChat-ios) sample project on GitHub. You can download the sample to try it out or view the source code.

The sample project uses the Agora Chat user ID to join a channel, which enables displaying the user ID in the view of the call. If you use the methods of the Agora RTC SDK to start a call, you can also use the Integer UID to join a channel.


<a name="import"></a>

### Import AgoraChatCallKit manually

Refer to the following steps to manually add AgoraChatCallKit to your project:

1. [Download AgoraChatCallKit](https://github.com/AgoraIO-Usecase/AgoraChat-CallKit-ios), and extract the downloaded file.
2. Copy and paste `AgoraChatCallKit.framework` to the directory of your project.
3. In Xcode, go to **TARGETS** > **Project Name** > **General**. Drag `AgoraChatCallKit.framework` under **Frameworks, Libraries, and Embedded Content**, and set the **Embed** attribute of `AgoraChatCallKit.framework` as **Embed & Sign**.

### Other project settings

You can configure the following project settings according to your use case:

- To run the app in the background, go to `info.plist`, click `+`, and add `Required background modes`. Set `Type` as `Array`, and add `App plays audio or streams audio/video using AirPlay` as a value under `Required background modes`.
- To use the Apple `PushKit` and `CallKit`, go to **TARGETS** > **Project Name** > **Signing and Capabilities**. Under **Background Modes**, check `Voice over IP`.


