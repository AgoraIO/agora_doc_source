Use this guide to integrate the Agora Classroom SDK into your iOS project and call APIs to launch a flexible classroom.

<div class="alert note"><li>Before proceeding, ensure that you make the <a href="./agora_class_prep">preparations</a> required for using Flexible Classroom.<li>The iOS client only supports students.</div>

## Sample project
Agora provides an open-source [sample project](https://github.com/AgoraIO-Community/CloudClass-iOS) on GitHub, which demonstrates how to integrate the Agora Classroom SDK and call APIs to launch a flexible classroom. You can download and read the source code.

## Set up the development environment

- Xcode 10.0 or later.
- CocoaPods. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).
- A physical iOS device (iPhone or iPad).
- iOS 10 or later.
- Physical media input devices, such as a built-in camera and a built-in microphone.

## Integrate the Agora Classroom SDK

Get the Agora Classroom SDK through CocoaPods, as follows:

1. In Terminal, run the `pod init` command to create a `Podfile` in the root directory of your project.

2. Open the `Podfile`, delete all contents and input the following contents. Remember to change `Your App` to the target name of your project.

```
# platform :ios, '10.0' use_frameworks!
target 'Your App' do
   pod 'AgoraEduSDK'
end
```

3. Run the `pod install` command to install the SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

4. Open the generated `xcworkspace` file in Xcode.

## Global configuration

First, create an `AgoraEduSDKConfig` instance for global configuration, and then call the `setConfig` method and pass in this instance. `The AgoraEduSDKConfig` instance includes the following parameters:

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>NO: (Default) Disable eye care mode.<li>YES: Enable eye care mode. |

Sample code:
```
/** Global configuration **/
@interface AgoraEduSDKConfig : NSObject
 // Agora App ID
@property (nonatomic, copy) NSString *appId;
// Whether to enable eye care mode
@property (nonatomic, assign) BOOL eyeCare;
@end
AgoraEduSDKConfig *defaultConfig = [[AgoraEduSDKConfig alloc] initWithAppId:appId eyeCare:eyeCare];
[AgoraEduSDK setConfig:defaultConfig];
```

## Launch a classroom

After initialization, create an `AgoraEduLaunchConfig` instance for the classroom launching configuration, and then call `launch` to pass in the instance. `The AgoraEduLaunchConfig` instance includes the following parameters:

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The role of the user in the classroom:<li>`AgoraEduRoleTypeStudent`: Student. |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomType` | The room type:<li>`AgoraEduRoomType1V1`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student.<li>`AgoraEduRoomTypeSmall`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.<li>`AgoraEduRoomTypeBig`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `rtmToken` | The RTM token used for authentication, see [Generate an RTM Token](./agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |

```swift
/** Classroom launching configuration */
// The user name
NSString *userName = @"XXX";
// The user ID. Must be the same as the UID that you use for generating an RTM token.
NSString *userUUid = @"XXX";
// The classroom name
NSString *roomName = @"XXX";
// The classroom ID
NSString *roomUuid = @"XXX";
// The user role
AgoraEduRoleType roleType = AgoraEduRoleTypeStudent;
// The classroom type
AgoraEduRoomType roomType = AgoraEduRoomType1V1;
// The RTM token
NSString *rtmToken = "";
The start time (ms) of the class, determined by the first user joining the classroom.
NSNumber *startTime = @(XXX);
// The duration (ms) of the class, determined by the first user joining the classroom.
NSNumber *duration = @(1800);
 
AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:roleType roomName:roomName roomUuid:roomUuid roomType:roomType token:rtmToken startTime:startTime duration:duration];
[AgoraEduSDK launch:config delegate:self];
```

After successfully launching a classroom, you can see the following page:![](https://web-cdn.agora.io/docs-files/1619164553801)
