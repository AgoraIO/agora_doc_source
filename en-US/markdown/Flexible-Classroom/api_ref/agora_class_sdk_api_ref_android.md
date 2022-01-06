This page provides the Kotlin API reference of the Agora Classroom SDK for Android.

## AgoraClassSdk

`AgoraClassSdk` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### setConfig

```java
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
```

Globally configures the SDK.

**Parameter**

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `config` | The SDK global configuration. See [AgoraClassSdkConfig](#agoraclasssdkconfig). |

### launch

```java
public static AgoraEduClassRoom launch(@NotNull Context context,
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

Launches a flexible classroom.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `config` | The classroom launching configuration. See [AgoraEduLaunchConfig](#agoraedulaunchconfig). |
| `callback` | The SDK uses the [AgoraEduLaunchCallback](#agoraedulaunchcallback) class to report events related to classroom launching to the app. |

**Returns**

The `AgoraEduClassRoom` class.

### replaceClassActivity

```java
public static void replaceClassActivity(int classRoomType, Class<extend BaseClassActivity> activity)
```
如果开发者高度自定义课堂 UI，可调用此方法替换课堂类型所对应的 Activity。

**Parameter**

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `classRoomType` | The classroom type. |
| </`activity`> | 课堂 Activity。 |

### registerExtensionApp

```java
public static void registerExtensionApp(List<AgoraExtAppConfiguration> apps);
```

在 EduCore 内注册开发者自行开发的 ExtApp。 ExtApp is a tool for embedding extension applications in Flexible Classroom. For details, see [Customize Flexible Classroom with ExtApp](./agora_class_ext_app_android?platform=Android).

## AgoraEduLaunchCallback

The `AgoraEduLaunchCallback` class reports events related to classroom launching to the app.

### onCallback

```java
void onCallback(AgoraEduEvent state);
```

Reports classroom events.

| Parameter | Description |
| :------ | :----------------------------------------------- |
| `state` | The classroom events. See [AgoraEduEvent](#agoraeduevent). |

## Type definition

### AgoraClassSdkConfig

```java
public class AgoraClassSdkConfig {
    @NotNull
    private String appId;
    }
```

The SDK global configuration. Used in [setConfig](#setconfig).

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | // Agora App ID
 |

### AgoraEduLaunchConfig

```kotlin
class AgoraEduLaunchConfig(val userName: String,
                           val userUuid: String,
                           val roomName: String,
                           val roomUuid: String,
                           val roleType: Int = AgoraEduRoleType.AgoraEduRoleTypeStudent.value,
                           val roomType: Int,
                           val rtmToken: String,
                           val startTime: Long?,
                           val duration: Long?,
                           val region: String,
                           var videoEncoderConfig: EduVideoEncoderConfig? = null,
                           val mediaOptions: AgoraEduMediaOptions?,
                           val streamState: StreamState?,
                           val latencyLevel: AgoraEduLatencyLevel? = AgoraEduLatencyLevel.AgoraEduLatencyLevelUltraLow,
                           val userProperties: MutableMap<String, String>? = null,
                           val widgetConfigs: MutableList<UiWidgetConfig>? = null) : Parcelable
```

The classroom launching configuration. Used in [launch](#launch).

| Attributes | Description |
| :------------------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The role of the user in the classroom. See  [AgoraEduRoleType](#agoraeduroletype). |
| `roomType` | The classroom type. See [AgoraEduRoomType](#agoraeduroomtype). |
| `rtmToken` | The RTM token used for authentication. For details, see [Generate an RTM Token](https://docs.agora.io/en/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `region` | The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. See [AgoraEduRegionStr](#agoraeduregionstr). |
| `videoEncoderConfig` | Video encoding configurations, including the width and height, frame rate, and bitrate. See [EduVideoEncoderConfig](#eduvideoencoderconfig) |
| `mediaOptions` | The media options, including media encryption configurations. See [AgoraEduMediaOptions](#agoraedumediaoptions). |
| `streamState` | Controls whether students automatically send audio or video streams after they go onto the "stage". See [StreamState](#streamstate). |
| `latencyLevel` | The latency level of an audience member. See [AgoraEduLatencyLevel](#agoraedulatencylevel). |
| `userProperties` | User properties customized by the developer. For details, see [How can I set user properties? ](/en/agora-class/faq/agora_class_custom_properties) |

### AgoraEduEvent

```java
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
    }
```

Classroom events. Reported in [onCallback](#oncallback).

| Attributes | Description |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed` | `0`: The user fails to enter the classroom. |
| `AgoraEduEventReady` | `1`: The classroom is ready. |
| `AgoraEduEventDestroyed` | `2`: The classroom has been destroyed. |
| `AgoraEduEventForbidden` | `3`: The user is forbidden by the Flexible Classroom cloud service and not allowed to enter the classroom. |

### AgoraEduRoleType

```java
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
    }
```

The role of the user in the classroom. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```java
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
    }
```

The classroom type. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduStreamState

```java
data class StreamState (
        var videoState:Int,
        var audioState:Int
)
```

用于控制学生上讲台后是否默认有发音视频流的权限。 Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `videoState` | 是否有发视频流的权限：<li>`0`: (Default) Do not send the video stream.</li><li>`1`: Send the video stream.</li> |
| `audioState` | 是否有发音频流的权限：<li>`0`: (Default) Do not send the audio stream.</li><li>`1`: Send the audio stream.</li> |

### AgoraEduLatencyLevel

```java
enum class AgoraEduLatencyLevel(val value: Int) {
    AgoraEduLatencyLevelLow(1),
    AgoraEduLatencyLevelUltraLow(2);
}
```

The latency level of an audience member. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :----------------------------- | :--------------------------------------------------------- |
| `AgoraEduLatencyLevelLow` | Low latency. The latency from the sender to the receiver is 1500 ms to 2000 ms. |
| `AgoraEduLatencyLevelUltraLow` | (Default) Ultra-low latency. The latency from the sender to the receiver is 400 ms to 800 ms. |

### AgoraEduMediaOptions

```kotlin
class AgoraEduMediaOptions(val encryptionConfigs: AgoraEduMediaEncryptionConfigs?)
```

Media options. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :----------------- | :----------------------------------------------------------- |
| `encryptionConfig` | The media stream encryption configuration. See [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig) for details. |

### AgoraEduMediaEncryptionConfig

```kotlin
data class AgoraEduMediaEncryptionConfigs(
        val encryptionKey: String?,
        val encryptionMode: Int
)
```

The media stream encryption configuration. Used in [AgoraEduMediaOptions](#agoraedumediaoptions).

| Parameter | Description |
| :----- | :------------------------------------- |
| `mode` | The encryption mode. See `AgoraEduEncryptMode`. |
| `key` | The encryption key. |

### AgoraEduEncryptMode

```kotlin
enum class AgoraEduEncryptMode(val value: Int) {
    NONE(0),
    AES_128_XTS(1),
    AES_128_ECB(2),
    AES_256_XTS(3),
    SM4_128_ECB(4),
    AES_128_GCM(5),
    AES_256_GCM(6);
                    AES_128_GCM2

                    AES_256_GCM2

}
```

The media stream encryption configuration. See [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig) for details.

| Parameter | Description |
| :------------ | :-------------------------- |
| `NONE` | No encryption. |
| `AES_128_XTS` | 128-bit AES encryption, XTS mode. |
| `AES_128_ECB` | 128-bit AES encryption, ECB mode. |
| `AES_256_XTS` | 256-bit AES encryption, XTS mode. |
| `SM4_128_ECB` | 128-bit ECB encryption, SM4 mode. |
| `AES_128_GCM` | 128-bit AES encryption, GCM mode. |
| `AES_256_GCM` | 256-bit AES encryption, GCM mode. |
| `                    AES_128_GCM2` | 128-bit AES encryption, GCM mode. 相比于 `AES_128_GCM` 加密模式，`AES_128_GCM2` 加密模式安全性更高且需要设置盐。 |
| `                    AES_256_GCM2` | 256-bit AES encryption, GCM mode. 256-bit AES encryption, GCM mode. 相比于 `AES_256_GCM` 加密模式，`AES_256_GCM2` 加密模式安全性更高且需要设置盐。 |

### AgoraEduRegion

```java
object AgoraEduRegion {
    const val default = "CN"
    const val cn = "CN"
    const val na = "NA"
    const val eu = "EU"
    const val ap = "AP"
}
```

Regions.

| Attributes | Description |
| :--- | :----------------- |
| `CN` | Mainland China. |
| `NA` | North America. |
| `EU` | Europe. |
| `AP` | Asia Pacific. |

### EduVideoEncoderConfig

```java
data class EduVideoEncoderConfig(
        var videoDimensionWidth: Int = 320,
        var videoDimensionHeight: Int = 240,
        var frameRate: Int = 15,
        var bitrate: Int = 200,
        var mirrorMode: Int = EduMirrorMode.AUTO.value
)
```

The video encoder configuration. Used in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

> - In the Small Classroom scenario, the default resolution is 120p (160*120).
> - In the One-to-one Classroom and Lecture Hall scenarios, the default resolution is 240p (320*240).

| Parameter | Description |
| :----------- | :----------------------------------- |
| `width` | Width (pixel) of the video frame. |
| `height` | Height (pixel) of the video frame. |
| `frameRate` | The frame rate (fps) of the video. The default value is 15. |
| `bitrate` | The bitrate (Kbps) of the video. The default value is 200. |
| `mirrorMode` | Video mirror modes. See `EduMirrorMode`. |

### EduMirrorMode

```kotlin
enum class EduMirrorMode(val value: Int) {
    AUTO(0),
    ENABLED(1),
    DISABLED(2)
}
```

Whether to enable mirror mode. Used in [EduVideoEncoderConfig](#eduvideoencoderconfig).

| Parameter | Description |
| :--------- | :--------------------- |
| `AUTO` | The SDK disables mirror mode by default. |
| `ENABLED` | Enable mirror mode. |
| `DISABLED` | Disable mirror mode. |