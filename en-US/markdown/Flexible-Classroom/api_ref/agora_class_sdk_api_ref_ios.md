This page provides the Swift API reference of the Agora Classroom SDK for iOS.

## AgoraClassroomSDK

`AgoraClassroomSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### version

```swift
String version()
```

The SDK version.

### launch

```swift
@NotNull AgoraEduLaunchConfig config,
            Callback<Void> success,
            Callback<Error> failure)
```

Launches a flexible classroom.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `config` | The classroom launching configuration. See [AgoraEduLaunchConfig](#agoraedulaunchconfig). |
| `success` | The method call succeeds. |
| `                         Failure` | 调用失败。 |

### setDelegate

```swift
void setDelegate(AgoraEduClassroomSDKDelegate delegate)
```

设置 Classroom SDK 的 Delegate。

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `delegate` | 详见 [AgoraEduClassroomSDKDelegate](#agoraeduclassroomsdkdelegate)。 |

### exit

```swift
void exit()
```

退出 Classroom SDK。

## AgoraEduClassroomSDKDelegate

### didExit

```swift
void classroomSDK:(AgoraClassroomSDK *)classroom
          didExit:(AgoraEduExitReason)reason
```

Classroom SDK 退出回调。

| Parameter | Description |
| :------ | :------- |
| `classroom` | AgoraClassroomSDK |
| `reason` | 退出原因。 |

## Type definition

### AgoraEduRegion

Regions.

| Properties | Description |
| :--- | :----------------- |
| `CN` | Mainland China. |
| `NA` | North America. |
| `EU` | Europe. |
| `AP` | Asia Pacific. |

### AgoraEduReason

退出 Classroom SDK 原因。

| Properties | Description |
| :--- | :----------------- |
| `                         Normal` | 正常退出。 |
| `                    kickOut` | The connection is aborted. |

### AgoraEduUserRole

The role of the user in the classroom. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Properties | Description |
| :------------------------ | :---------- |
| `student` | `2`: A student. |

### AgoraEduRoomType

The classroom type. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Properties | Description |
| :---------------------- | :----------------------------------------------------------- |
| `oneToOne` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `small` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `lecture` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduMediaEncryptionMode

Media stream encryption mode. The media stream encryption configuration. See [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig )for details.

| Parameter | Description |
| :------------------------------------- | :-------------------------- |
| `NONE` | `0`: Not prohibited. |
| `                         AES128XTS` | ``128-bit AES encryption, XTS mode. |
| `                         AES128ECB` | `2`: 128-bit AES encryption, ECB mode. |
| `                         AES256XTS` | `3`: 256-bit AES encryption, XTS mode. |
| `                         SM4128ECB` | `4`: 128-bit SM4 encryption, ECB mode. |
| `                         AES128GCM` | `5`: 128-bit AES encryption, GCM mode. |
| `                         AES256GCM` | `6`: 256-bit AES encryption, GCM mode. |
| `                         AES128GCM2` | `7`: 128-bit AES encryption, GCM mode. 相比于 `AES128GCM` 加密模式，`AES128GCM2` 加密模式安全性更高且需要设置盐。 |
| `                         AES256GCM2` | `8`: 256-bit AES encryption, GCM mode. 相比于 `AES_256_GCM` 加密模式，`AES256GCM2` 加密模式安全性更高且需要设置盐。 |

### AgoraEduMirrorMode

Mirror mode 用于 [AgoraEduVideoEncoderConfig](#agoraeduvideoencoderconfig)。

| Parameter | Description |
| :------------------------------------- | :-------------------------- |
| `disabled` | `0`: Closed. |
| `enabled` | ``: Enable mirror mode. |

### AgoraEduMediaEncryptionConfig

The media stream encryption configuration. Used in [AgoraEduMediaOptions](#agoraedumediaoptions).

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `mode` | Encryption mode. See [AgoraEduMediaEncryptionMode](#agoraedumediaencryptionmode). |
| `key` | The encryption key. |


### AgoraEduLaunchConfig

The classroom launching configuration. Used in [launch](#launch).

| Properties | Description |
| :--------------------------- | :----------------------------------------------------------- |
| `userName` | 用户名，String 型。 The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | 用户 ID，String 型。 This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userRole` | The user's role in the classroom. See `AgoraEduRoleType`. |
| `roomName` | 课堂名，String 型。 The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | 课堂 ID，String 型。 This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomType` | The classroom type. See `AgoraEduRoomType`. |
| `token` | 用于鉴权的 RTM Token，String 型。 |
| `appId` | Agora App ID，String 型。 |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `region` | The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. `AgoraEduRegion` |
| `mediaOptions` | Media options, including the media stream encryption configuration. See `AgoraEduMediaOptions` for details. |
| `userProperties` | 由开发者自定义的用户属性，`Map<String, Any>`。 For details, see `How can I set user properties? `/en/agora-class/faq/agora_class_custom_properties) |
| `widgets` | `Map<String, AgoraWidgetConfig>`，传入 Widget ID 和 Widget Config。 |
| `extApps` | `Map<String, AgoraExtAppConfig>`，传入 ExtApp ID 和 ExtApp Config。 |

### AgoraEduStreamState

用于控制学生上讲台后是否默认有发视频流的权限。 Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :---- | :--------------- |
| `off` | ``(Default) Students do not automatically send audio and video streams after they go onto the "stage". |
| `on` | `1`: Send the video stream. |

### AgoraEduLatencyLevel

The latency level of an audience member. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :--------- | :--------------------------------------------------------- |
| `low` | `1`: Low latency. The latency from the sender to the receiver is 1500 ms to 2000 ms. |
| `ultraLow` | `2`: (Default) Ultra low latency. The latency from the sender to the receiver is 400 ms to 800 ms. |

### AgoraEduMediaOptions

Media options. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :----------------- | :----------------------------------------------------------- |
| `encryptionConfig` | The media stream encryption configuration. See [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig) for details. |
| `videoEncoderConfig` | 视频编码配置，详见 [AgoraEduVideoEncoderConfig](#agoraeduvideoencoderconfig). |
| `latencyLevel` | The latency level of an audience member. See [AgoraEduLatencyLevel](#agoraedulatencylevel). |
| `videoState` | 学生上讲台后是否默认有发视频流的权限，详见 [AgoraEduStreamState](#agoraedustreamstate). |
| `audioState` | 学生上讲台后是否默认有发音频流的权限，详见 [AgoraEduStreamState](#agoraedustreamstate). |

### AgoraEduVideoEncoderConfig

The classroom launching configuration. See `AgoraEduLaunchConfig`.

> - In the Small Classroom scenario, the default resolution is 120p (160*120).
> - In the One-to-one Classroom and Lecture Hall scenarios, the default resolution is 240p (320*240).

| Parameter | Description |
| :----------- | :-------------------------------------------- |
| `dimensionWidth` | 视频帧宽度 (pixel)，Int 型。 |
| `dimensionHeight` | 视频帧高度 (pixel)，Int 型。 |
| `frameRate` | 视频帧率 (fps)，Int 型，默认值为 15， |
| `bitrate` | 视频码率 (Kbps)，Int 型，默认值为 200。 |
| `mirrorMode` | Video mirror modes. See `EduMirrorMode`. |