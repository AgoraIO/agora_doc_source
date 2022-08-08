本页提供 Agora Classroom SDK for iOS 的 Swift API 参考。

## AgoraClassroomSDK

`AgoraClassroomSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### version

```swift
String version()
```

SDK 版本号。

### launch

```swift
void launch(AgoraEduLaunchConfig config,
            Callback<Void> success,
            Callback<Error> failure)
```

启动灵动课堂。

**参数**

| 参数      | 描述                                                               |
| :-------- | :----------------------------------------------------------------- |
| `config`  | 课堂启动配置，详见 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。 |
| `success` | 调用成功。                                                         |
| `failure` | 调用失败。                                                         |

### vocationalLaunch

```swift
void vocationalLaunch(AgoraEduLaunchConfig config,
        AgoraEduServiceType serviceType,
        Callback<Void> success,
        Callback<Error> failure)
```

启动灵动课堂。
**注意**：该方法仅适用于职业教育大班课场景。

**参数**

| 参数      | 描述                                                               |
| :-------- | :----------------------------------------------------------------- |
| `config`  | 课堂启动配置，详见 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。 |
| `serviceType`  | 职业教育大班课使用的服务类型，详见 [AgoraEduServiceType](#agoraeduservicetype)。 |
| `success` | 调用成功。                                                         |
| `failure` | 调用失败。                                                         |

### setDelegate

```swift
void setDelegate(AgoraEduClassroomSDKDelegate delegate)
```

设置 Classroom SDK 的 Delegate。

**参数**

| 参数       | 描述                                                                 |
| :--------- | :------------------------------------------------------------------- |
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

| 参数        | 描述                     |
| :---------- | :----------------------- |
| `classroom` | AgoraClassroomSDK 对象。 |
| `reason`    | 退出原因。               |

## 类型定义

### AgoraEduRegion

区域。

| 属性 | 描述               |
| :--- | :----------------- |
| `CN` | （默认）中国大陆。 |
| `NA` | 北美。             |
| `EU` | 欧洲。             |
| `AP` | 亚太。             |

### AgoraEduReason

退出 Classroom SDK 原因。

| 属性      | 描述       |
| :-------- | :--------- |
| `normal`  | 正常退出。 |
| `kickOut` | 被踢出。   |

### AgoraEduUserRole

用户在课堂中的角色。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性      | 描述        |
| :-------- | :---------- |
| `student` | `2`: 学生。 |

### AgoraEduRoomType

课堂类型。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性       | 描述                                                                                                             |
| :--------- | :--------------------------------------------------------------------------------------------------------------- |
| `oneToOne` | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。                                                  |
| `small`    | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。小班课中课堂人数上限为 200。                  |
| `lecture`  | `2`:<ul><li>对于 `launch` 方法，该属性为互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。大班课中课堂人数上限为 5000。</li><li> 对于 `vocationalLaunch` 方法，该属性为职业教育大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。使用声网 RTC 服务时，课堂人数上限为 5000。使用灵动课堂 CDN 推拉流功能时，课堂人数无上限。</li> |
| `vocational`  | `100`: （仅对 `vocationalLaunch` 方法生效）职业教育大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。使用声网 RTC 服务时，课堂人数上限为 5000。使用灵动课堂 CDN 推拉流功能时，课堂人数无上限。|

### AgoraEduServiceType

职业教育大班课使用的服务类型，仅在 `AgoraEduRoomType` 为 `lecture` 或 `vocational` 时生效。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性       | 描述                                                                                                             |
| :--------- | :--------------------------------------------------------------------------------------------------------------- |
|`livePremium`  | 课堂使用 RTC 服务。频道为直播模式，延时为超低延时，约 400 毫秒。与互动直播大班课逻辑一致。   |
|`liveStandard`  |课堂使用 RTC 服务。频道为直播模式，延时为低延时，约 1 秒。又称极速直播模式。 |
|`CDN`  | 课堂使用 CDN 推拉流服务。老师的音视频流推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频。CDN 服务延时一般大于 4 秒。 |
|`fusion`  | 课堂使用 RTC 和 CDN 推拉流服务。老师的音视频流既发送到 RTC 频道内，又推到 CDN 上。学生既可以通过拉取 CDN 流实时观看老师的音视频流，又可以通过上台与老师实时互动。CDN 服务的延时比 RTC 服务延时高。  |
|`mixStreamCDN` | 课堂使用 CDN 推拉流服务。老师的音视频流和白板经由页面录制后实时推到 CDN 上，学生通过拉取 CDN 流实时观看老师的音视频和白板。CDN 服务延时一般大于 4 秒。  |
|`hostingScene`  | 老师的音视频流和白板的录像文件存放在 CDN 上。学生通过 CDN 地址观看教学。各端的课堂时间通过服务器时间对齐。 |

### AgoraEduMediaEncryptionMode

媒体流加密模式。用于 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig)。

| 参数         | 描述                                                                                                         |
| :----------- | :----------------------------------------------------------------------------------------------------------- |
| `None`       | `0`: 不加密。                                                                                                |
| `AES128XTS`  | `1`: 128 位 AES 加密，XTS 模式。                                                                             |
| `AES128ECB`  | `2`: 128 位 AES 加密，ECB 模式。                                                                             |
| `AES256XTS`  | `3`: 256 位 AES 加密，XTS 模式。                                                                             |
| `SM4128ECB`  | `4`: 128 位 SM4 加密，ECB 模式。                                                                             |
| `AES128GCM`  | `5`: 128 位 AES 加密，GCM 模式。                                                                             |
| `AES256GCM`  | `6`: 256 位 AES 加密，GCM 模式。                                                                             |
| `AES128GCM2` | `7`: 128 位 AES 加密，GCM 模式。相比于 `AES128GCM` 加密模式，`AES128GCM2` 加密模式安全性更高且需要设置盐。   |
| `AES256GCM2` | `8`: 256 位 AES 加密，GCM 模式。相比于 `AES_256_GCM` 加密模式，`AES256GCM2` 加密模式安全性更高且需要设置盐。 |

### AgoraEduMirrorMode

镜像模式。用于 [AgoraEduVideoEncoderConfig](#agoraeduvideoencoderconfig)。

| 参数       | 描述            |
| :--------- | :-------------- |
| `disabled` | `0`: 关闭镜像。 |
| `enabled`  | `1`: 开启镜像。 |

### AgoraEduMediaEncryptionConfig

媒体流加密配置，用于 [AgoraEduMediaOptions](#agoraedumediaoptions)。

| 参数   | 描述                                                                         |
| :----- | :--------------------------------------------------------------------------- |
| `mode` | 加密模式，详见 [AgoraEduMediaEncryptionMode](#agoraedumediaencryptionmode)。 |
| `key`  | 加密密钥。                                                                   |

### AgoraEduLaunchConfig

课堂启动配置。用于 [launch](#launch) 方法。

| 属性             | 描述                                                                                                                                                                                                                                                                                                                                                                         |
| :--------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userName`       | 用户名，String 型。用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                      |
| `userUuid`       | 用户 ID，String 型。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", "," |
| `userRole`       | 用户在课堂中的角色，详见 [AgoraEduRoleType](#agoraeduroletype)。                                                                                                                                                                                                                                                                                                             |
| `roomName`       | 课堂名，String 型。用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                      |
| `roomUuid`       | 课堂 ID，String 型。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","                                                |
| `roomType`       | 课堂类型，详见 [AgoraEduRoomType](#agoraeduroomtype)。                                                                                                                                                                                                                                                                                                                       |
| `AgoraEduServiceType`       | 职业教育大班课使用的服务类型。详见 [AgoraEduServiceType](#agoraeduservicetype)。                                                                                                                                                                                                                                                                                                                       |
| `token`          | 用于鉴权的 RTM Token，String 型。                                                                                                                                                                                                                                                                                                                                            |
| `appId`          | Agora App ID，String 型。                                                                                                                                                                                                                                                                                                                                                    |
| `startTime`      | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                             |
| `duration`       | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                               |
| `region`         | 区域。建议设置为靠近你的课件或录制文件对象存储服务所在的区域，因为跨区域传输较大的静态资源会造成比较大的延迟。举例来说，如果你的 S3 服务在北美，则建议将 `region` 也设为北美区域。所有灵动课堂客户端必须设置相同的区域，否则无法互通。支持的区域详见 [AgoraEduRegion](#agoraeduregion)。                                                                                     |
| `mediaOptions`   | 媒体流相关设置，包含媒体流加密，详见 [AgoraEduMediaOptions](#agoraedumediaoptions)。                                                                                                                                                                                                                                                                                         |
| `userProperties` | 由开发者自定义的用户属性，`Map<String, Any>`。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)                                                                                                                                                                                                                                              |
| `widgets`        | `Map<String, AgoraWidgetConfig>`，传入 Widget ID 和 Widget Config。                                                                                                                                                                                                                                                                                                          |
| `extApps`        | `Map<String, AgoraExtAppConfig>`，传入 ExtApp ID 和 ExtApp Config。                                                                                                                                                                                                                                                                                                          |

### AgoraEduStreamState

用于控制学生上讲台后是否默认有发视频流的权限。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数  | 描述                 |
| :---- | :------------------- |
| `off` | `0`:（默认）不发流。 |
| `on`  | `1`: 发流。          |

### AgoraEduLatencyLevel

观众端延时级别，只对台下学生有效。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数       | 描述                                                           |
| :--------- | :------------------------------------------------------------- |
| `low`      | `1`: 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。        |
| `ultraLow` | `2`:（默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。 |

### AgoraEduMediaOptions

媒体流相关设置。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数                 | 描述                                                                                    |
| :------------------- | :-------------------------------------------------------------------------------------- |
| `encryptionConfig`   | 媒体流加密配置，详见 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig).   |
| `videoEncoderConfig` | 视频编码配置，详见 [AgoraEduVideoEncoderConfig](#agoraeduvideoencoderconfig).           |
| `latencyLevel`       | 观众端延时级别，详见 [AgoraEduLatencyLevel](#agoraedulatencylevel)。                    |
| `videoState`         | 学生上讲台后是否默认有发视频流的权限，详见 [AgoraEduStreamState](#agoraedustreamstate). |
| `audioState`         | 学生上讲台后是否默认有发音频流的权限，详见 [AgoraEduStreamState](#agoraedustreamstate). |

### AgoraEduVideoEncoderConfig

视频编码参数配置类，用于 `AgoraEduLaunchConfig`。

> -   在小班课中，分辨率的默认值为 120p（160✖️120）。
> -   在一对一和大班课中，分辨率的默认值为 240p（320✖️240）。

| 参数              | 描述                                                           |
| :---------------- | :------------------------------------------------------------- |
| `dimensionWidth`  | 视频帧宽度 (pixel)，Int 型。                                   |
| `dimensionHeight` | 视频帧高度 (pixel)，Int 型。                                   |
| `frameRate`       | 视频帧率 (fps)，Int 型，默认值为 15，                          |
| `bitRate`         | 视频码率 (Kbps)，Int 型，默认值为 200。                        |
| `mirrorMode`      | 视频镜像模式，详见 [AgoraEduMirrorMode](#agoraedumirrormode)。 |


