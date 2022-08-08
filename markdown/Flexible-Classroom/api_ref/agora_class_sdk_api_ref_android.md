本页提供 Agora Classroom SDK for Android 的 Kotlin API 参考。

## AgoraClassSDK

`AgoraClassSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### setConfig

```java
public static void setConfig(AgoraClassSdkConfig config);
```

全局配置 SDK。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `config` | 全局配置参数，详见 [AgoraClassSdkConfig](#agoraclasssdkconfig)。 |

### launch

```java
public static AgoraEduClassRoom launch(@NotNull Context context,
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

启动灵动课堂。

**参数**

| 参数       | 描述                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------- |
| `context`  | App 的上下文环境。                                                                           |
| `config`   | 课堂启动配置，详见 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。                           |
| `callback` | SDK 通过 [AgoraEduLaunchCallback](#agoraedulaunchcallback) 类向 App 报告课堂启动相关的事件。 |

**返回值**

`AgoraEduClassRoom` 类。

### replaceClassActivity

```java
public static void replaceClassActivity(int classRoomType, Class<extend BaseClassActivity> activity)
```

如果开发者高度自定义课堂 UI，可调用此方法替换课堂类型所对应的 Activity。

**参数**

| 参数            | 描述            |
| :-------------- | :-------------- |
| `classRoomType` | 课堂类型。      |
| `activity`      | 课堂 Activity。 |

### registerExtensionApp

```java
public static void registerExtensionApp(List<AgoraExtAppConfiguration> apps);
```

在 EduCore 内注册开发者自行开发的 ExtApp。ExtApp 是灵动课堂 UIKit 的补充插件。详见[通过 ExtApp 自定义插件](./agora_class_ext_app_android?platform=Android)。

## AgoraEduLaunchCallback

`AgoraEduLaunchCallback` 类用于 SDK 向 App 报告课堂启动相关的事件。

### onCallback

```java
void onCallback(AgoraEduEvent state);
```

课堂事件回调。

| 参数    | 描述                                             |
| :------ | :----------------------------------------------- |
| `state` | 课堂事件，详见 [AgoraEduEvent](#agoraeduevent)。 |

## 类型定义

### AgoraClassSdkConfig

```java
public class AgoraClassSdkConfig {
    @NotNull
    private String appId;
}
```

SDK 全局配置。用于 [setConfig](#setconfig) 方法。

| 属性    | 描述           |
| :------ | :------------- |
| `appId` | Agora App ID。 |


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
                           var videoEncoderConfig: EduContextVideoEncoderConfig? = null,
                           val mediaOptions: AgoraEduMediaOptions?,
                           val streamState: AgoraEduStreamState?,
                           val latencyLevel: AgoraEduLatencyLevel? = AgoraEduLatencyLevel.AgoraEduLatencyLevelUltraLow,
                           val userProperties: MutableMap<String, String>? = null,
                           val widgetConfigs: MutableList<AgoraWidgetConfig>? = null) : Parcelable,
                           val serviceType: AgoraServiceType = AgoraServiceType.LivePremium
```

课堂启动配置。用于 [launch](#launch) 方法。

| 属性                 | 描述                                                                                                                                                                                                                                                                                                                                                             |
| :------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userName`           | 用户名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                     |
| `userUuid`           | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", "," |
| `roomName`           | 课堂名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                     |
| `roomUuid`           | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","                                               |
| `roleType`           | 用户在课堂中的角色，详见 [AgoraEduRoleType](#agoraeduroletype)。                                                                                                                                                                                                                                                                                                 |
| `roomType`           | 课堂类型，详见 [AgoraEduRoomType](#agoraeduroomtype)。                                                                                                                                                                                                                                                                                                           |
| `rtmToken`           | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。                                                                                                                                                                                                                                              |
| `startTime`          | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                 |
| `duration`           | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                   |
| `region`             | 区域。建议设置为靠近你的课件或录制文件对象存储服务所在的区域，因为跨区域传输较大的静态资源会造成比较大的延迟。举例来说，如果你的 S3 服务在北美，则建议将 `region` 也设为北美区域。所有灵动课堂客户端必须设置相同的区域，否则无法互通。支持的区域详见 [AgoraEduRegion](#agoraeduregion)。                                                                         |
| `videoEncoderConfig` | 视频编码参数配置，包含视频宽高、帧率、码率，详见 [EduVideoEncoderConfig](#eduvideoencoderconfig)                                                                                                                                                                                                                                                                 |
| `mediaOptions`       | 媒体流相关设置，包含媒体流加密，详见 [AgoraEduMediaOptions](#agoraedumediaoptions)。                                                                                                                                                                                                                                                                             |
| `streamState`        | 用于控制学生上台后是否发音视频流，详见 [AgoraEduStreamState](#agoraedustreamstate)。                                                                                                                                                                                                                                                                             |
| `latencyLevel`       | 观众端延时级别，详见 [AgoraEduLatencyLevel](#agoraedulatencylevel)。                                                                                                                                                                                                                                                                                             |
| `userProperties`     | 由开发者自定义的用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)                                                                                                                                                                                                                                                      |
| `serviceType`     | （非必填）职业教育大班课使用的服务类型。详见 [AgoraServiceType](#agoraservicetype)。                                                                                                                                                                                                                                                     |


### AgoraEduEvent

```java
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
}
```

课堂事件。在 [onCallback](#oncallback) 回调中报告。

| 属性                     | 描述                      |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed`    | `0`: 进入课堂失败。       |
| `AgoraEduEventReady`     | `1`: 课堂准备完成。       |
| `AgoraEduEventDestroyed` | `2`: 课堂已销毁。         |
| `AgoraEduEventForbidden` | `3`: 用户被禁止进入课堂。 |

### AgoraEduRoleType

```java
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

用户在课堂中的角色。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性                      | 描述        |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: 学生。 |

### AgoraEduRoomType

```java
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
}
```

课堂类型。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性                    | 描述                                                                                             |
| :---------------------- | :----------------------------------------------------------------------------------------------- |
| `AgoraEduRoomType1V1`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。                                  |
| `AgoraEduRoomTypeBig`   | `2`: 大班课。1 位老师进行在线教学，多名学生实时观看和收听：<li>当 `serviceType` 为空时，`RoomBigClass` 代表互动直播大班课。老师和学生均使用声网 RTC 服务，课堂人数上限为 5000。</li><li>当 `serviceType` 不为空时，`RoomBigClass` 代表职业教育大班课。除去声网 RTC 服务外，老师和学生还使用灵动课堂 CDN 推拉流功能，课堂人数无上限。</li>  |
| `AgoraEduRoomTypeSmall` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。小班课中课堂人数上限为 200。  |

### AgoraServiceType

```kotlin
enum class AgoraServiceType(var value: Int) {
    Unknown(-1),

    LivePremium(0),

    LiveStandard(1),

    CDN(2),

    Fusion(3);

}
```

职业教育大班课使用的服务类型，仅在 `AgoraEduRoomType` 为 `AgoraEduRoomTypeBig` 时有效。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性       | 描述                                                                                                             |
| :--------- | :--------------------------------------------------------------------------------------------------------------- |
| `LivePremium` | 课堂使用 RTC 服务。频道为直播模式，延时为超低延时，约 400 毫秒。与互动直播大班课逻辑一致。                                                  |
| `LiveStandard`    | 课堂使用 RTC 服务。频道为直播模式，延时为低延时，约 1 秒。又称极速直播模式。                  |
| `CDN`  | 课堂使用 CDN 推拉流服务。老师的音视频流推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频。CDN 服务延时一般大于 4 秒。 |
| `Fusion`  | 课堂使用 RTC 和 CDN 推拉流服务。老师的音视频流既发送到 RTC 频道内，又推到 CDN 上。学生既可以通过拉取 CDN 流实时观看老师的音视频流，又可以通过上台与老师实时互动。CDN 服务的延时比 RTC 服务延时高。  |


### AgoraEduStreamState

```java
data class AgoraEduStreamState (
        var videoState:Int,
        var audioState:Int
)
```

用于控制学生上讲台后是否默认有发音视频流的权限。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数         | 描述                                                                             |
| :----------- | :------------------------------------------------------------------------------- |
| `videoState` | 是否有发视频流的权限：<li>`0`: （默认）不发视频流。</li><li>`1`: 发视频流。</li> |
| `audioState` | 是否有发音频流的权限：<li>`0`: （默认）不发音频流。</li><li>`1`: 发音频流。</li> |

### AgoraEduLatencyLevel

```java
enum class AgoraEduLatencyLevel(val value: Int) {
    AgoraEduLatencyLevelLow(1),
    AgoraEduLatencyLevelUltraLow(2);
}
```

观众端延时级别。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数                           | 描述                                                       |
| :----------------------------- | :--------------------------------------------------------- |
| `AgoraEduLatencyLevelLow`      | 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。         |
| `AgoraEduLatencyLevelUltraLow` | （默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。 |

### AgoraEduMediaOptions

```kotlin
class AgoraEduMediaOptions(val encryptionConfigs: AgoraEduMediaEncryptionConfigs?)
```

媒体流相关设置。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数               | 描述                                                                                   |
| :----------------- | :------------------------------------------------------------------------------------- |
| `encryptionConfig` | 媒体流加密配置，详见 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig)。 |

### AgoraEduMediaEncryptionConfig

```kotlin
data class AgoraEduMediaEncryptionConfigs(
        val encryptionKey: String?,
        val encryptionMode: Int
)
```

媒体流加密配置，用于 [AgoraEduMediaOptions](#agoraedumediaoptions)。

| 参数   | 描述                                   |
| :----- | :------------------------------------- |
| `mode` | 加密模式，详见 `AgoraEduEncryptMode`。 |
| `key`  | 加密密钥。                             |

### AgoraEduEncryptMode

```kotlin
enum class AgoraEduEncryptMode(val value: Int) {
    NONE(0),
    AES_128_XTS(1),
    AES_128_ECB(2),
    AES_256_XTS(3),
    SM4_128_ECB(4),
    AES_128_GCM(5),
    AES_256_GCM(6),
    AES_128_GCM2(7),
    AES_256_GCM2(8);
}
```

加密模式，用于 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig)。

| 参数           | 描述                                                                                                                                 |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| `NONE`         | 不加密。                                                                                                                             |
| `AES_128_XTS`  | 128 位 AES 加密，XTS 模式。                                                                                                          |
| `AES_128_ECB`  | 128 位 AES 加密，ECB 模式。                                                                                                          |
| `AES_256_XTS`  | 256 位 AES 加密，XTS 模式。                                                                                                          |
| `SM4_128_ECB`  | 128 位 ECB 加密，SM4 模式。                                                                                                          |
| `AES_128_GCM`  | 128 位 AES 加密，GCM 模式。                                                                                                          |
| `AES_256_GCM`  | 256 位 AES 加密，GCM 模式。                                                                                                          |
| `AES_128_GCM2` | 128 位 AES 加密，GCM 模式。相比于 `AES_128_GCM` 加密模式，`AES_128_GCM2` 加密模式安全性更高且需要设置盐。                            |
| `AES_256_GCM2` | 256 位 AES 加密，GCM 模式。256 位 AES 加密，GCM 模式。相比于 `AES_256_GCM` 加密模式，`AES_256_GCM2` 加密模式安全性更高且需要设置盐。 |

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

区域。

| 属性 | 描述               |
| :--- | :----------------- |
| `CN` | （默认）中国大陆。 |
| `NA` | 北美。             |
| `EU` | 欧洲。             |
| `AP` | 亚太。             |

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

视频编码参数配置类，用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

> -   在小班课中，分辨率的默认值为 120p（160\*120）。
> -   在一对一和大班课中，分辨率的默认值为 240p（320\*240）。

| 参数         | 描述                                 |
| :----------- | :----------------------------------- |
| `width`      | 视频帧宽度 (pixel)。                 |
| `height`     | 视频帧高度 (pixel)。                 |
| `frameRate`  | 视频帧率 (fps)。默认值为 15。        |
| `bitrate`    | 视频码率 (Kbps)。默认值为 200。      |
| `mirrorMode` | 视频镜像模式，详见 `EduMirrorMode`。 |

### EduMirrorMode

```kotlin
enum class EduMirrorMode(val value: Int) {
    AUTO(0),
    ENABLED(1),
    DISABLED(2)
}
```

是否开启镜像模式。用于 [EduVideoEncoderConfig](#eduvideoencoderconfig)。

| 参数       | 描述                   |
| :--------- | :--------------------- |
| `AUTO`     | SDK 默认关闭镜像模式。 |
| `ENABLED`  | 开启镜像模式。         |
| `DISABLED` | 关闭镜像模式。         |
