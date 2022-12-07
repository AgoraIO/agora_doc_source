本页提供 Agora Proctor SDK for Web/Electron 的 TypeScript API 参考。

## AgoraProctorSDK

`AgoraProctorSDK` 是 Agora Proctor SDK 的基础接口类，提供在线监考场景下灵动课堂的核心方法。

### config

```typescript
static config(config: ConfigParams) {}
```

配置 Proctor SDK。

| 参数     | 描述                                               |
| :------- | :------------------------------------------------- |
| `params` | 全局配置参数，详见 [ConfigParams](#configparams)。 |

### launch

```typescript
static launch(dom: HTMLElement, option: LaunchOption) {}
```

启动在线监考场景下的灵动课堂。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [LaunchOption](#launchoption)。                           |


### launchWindow

```typescript
static launchWindow(dom: HTMLElement, option: LaunchWindowOption) {
```

启动 xxx //TODO

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [LaunchWindowOption](#launchwindowoption)。                           |



## 类型定义

### ConfigParams

SDK 全局配置。用于 [AgoraProctorSDK.config](#config) 方法。

```typescript
export type ConfigParams = {
    appId: string;
    region?: string;
};
```

| 属性     | 描述                                                                                                                                                                                                                                                                                                                                                     |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `appId`  | （必填）Agora App ID。                                                                                                                                                                                                                                                                                                                                   |
| `region` | （选填）区域。建议设置为靠近你的课件或录制文件对象存储服务所在的区域，因为跨区域传输较大的静态资源会造成比较大的延迟。举例来说，如果你的 S3 服务在北美，则建议将 `region` 也设为北美区域。所有灵动课堂客户端必须设置相同的区域，否则无法互通。支持以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li> |

### LaunchOption

课堂启动配置。用于 [AgoraProctorSDK.launch](#launch) 方法。

```typescript
export type LaunchOption = {
  userUuid: string;
  userName: string;
  roomUuid: string;
  roleType: EduRoleTypeEnum;
  roomType: EduRoomTypeEnum;
  roomServiceType?: EduRoomServiceTypeEnum;
  roomName: string;
  listener: ListenerCallback;
  pretest: boolean;
  rtmToken: string;
  language: LanguageEnum;
  startTime?: number;
  duration: number;
  widgets?: { [key: string]: typeof AgoraWidgetBase };
  userFlexProperties?: { [key: string]: any };
  mediaOptions?: LaunchMediaOptions;
  latencyLevel?: 1 | 2;
  platform?: Platform;
  uiMode?: FcrMultiThemeMode;
  shareUrl?: string;
  checkStudentScreenShareState?: boolean;
};
```

| 参数                     | 描述                                                                                                                                                                                                |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userUuid`               | （必填）用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。填写方式见[集成文档](/cn/agora-class/agora_class_integrate_web?platform=Web#main-sub-device)。同时需满足长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~                                                   |
| `userName`               | （必填）用户名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                |
| `roomUuid`               | （必填）课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~                                                                                                 |
| `roleType`               | （必填）用户在课堂中的角色，详见 [EduRoleTypeEnum](#eduroletypeenum)。                                                                                                                              |
| `roomType`               | （必填）课堂类型，详见 [EduRoomTypeEnum](#eduroomtypeenum)。                                                                                                                                        |
| `roomName`               | （必填）课堂名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                |
| `roomServiceType`  |（选填）职业教育大班课使用的服务类型。详见 [EduRoomServiceTypeEnum](#eduroomservicetypeenum)。  |
| `listener`               | （必填）课堂启动状态：<li>`ready`: 课堂准备完毕。</li><li>`destroyed`: 课堂已销毁。</li>                                                                                                            |
| `pretest`                | （必填）是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。</li><li>`false`: 不开启课前设备检测。</li> |
| `rtmToken`               | （必填）用于鉴权的 RTM Token。详见[使用 RTM Token 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms)。                                                                                                                                                                      |
| `language`               | （必填）课堂界面的语言，详见 [LanguageEnum](#languageenum)。                                                                                                                                        |
| `startTime`              | （选填）课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。                                                                                                                                |
| `duration`               | （必填）课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。最大值为 86,400 秒，建议根据课堂实际时长设置。                                                                                    |
| `widgets`|（选填）插件。详见[AgoraWidgetBase](#agorawidgetbase)。|
| `userFlexProperties`     | （选填）由开发者自定义的用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)                                                                                 |
| `mediaOptions`           | （选填）媒体流相关设置，包含媒体流加密、摄像头视频流编码参数配置和屏幕共享视频流编码参数配置，详见 [LaunchMediaOptions](#launchmediaoptions)。                                                                                 |
| `latencyLevel`           | （选填）观众端延时级别：<li>`1`: 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。</li><li>`2`:（默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。</li>                                     |
| `platform`               | （选填）适用平台，可设为 `'PC'` 和 `'H5'` //TODO 研发确认。                                                                                                                                                         |
| `uiMode` |（选填）课堂界面模式，详见 [FcrMultiThemeMode](#fcrmultithememode)。 |
|`shareUrl`       | （选填）//TODO 研发确认     |
|`checkStudentScreenShareState`       | （选填）是否检查学生屏幕共享状态：<li>`true`: </li><li>`false`: </li> //TODO 研发确认 true 的含义，是否有默认值      |


### LaunchMediaOptions //TODO 这一节研发确认，不知道 MediaOptions 里有什么字段，这里抄的 Classroom SDK

```typescript
export type LaunchMediaOptions = {
    cameraEncoderConfiguration?: EduVideoEncoderConfiguration;
    screenShareEncoderConfiguration?: EduVideoEncoderConfiguration;
    encryptionConfig?: MediaEncryptionConfig;
    channelProfile?: ChannelProfile;
    web?: {
        codec: SDK_CODEC;
        mode: SDK_MODE;
    };
};
```

媒体流相关设置。

| 参数                              | 描述                                                                                               |
| :-------------------------------- | :------------------------------------------------------------------------------------------------- |
| `cameraEncoderConfiguration`      | 摄像头采集视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `screenShareEncoderConfiguration` | 屏幕共享视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。   |
| `encryptionConfig`                | 媒体流加密配置，详见 [MediaEncryptionConfig](#mediaencryptionconfig)。                             |
| `channelProfile`                | 频道配置，详见 [ChannelProfile](#channelprofile)。                             |
| `web`   | 用于配置浏览器编码格式和频道场景：<ul><li>`codec`: 浏览器编码格式，可以为如下：<ul><li>`"vp8"`: VP8 编码。</li><li>`"h264"`: H.264 编码。</li></li></ul><li>`mode`: 频道场景，可以为如下：<ul><li>`"rtc"`: 通信模式，一般用于一对多或一对一的小班课。</li><li>`"live"`: 直播模式，相较于通信模式，更低费用，同时延迟相较于通信模式较大。</li></ul></li></ul>|

### EduVideoEncoderConfiguration

```typescript
export interface EduVideoEncoderConfiguration {
    width: number;
    height: number;
    frameRate: number;
    bitrate: number;
}
```

视频编码参数配置。

> -  在小班课中，分辨率的默认值为 120p（160 * 120）。
> -  在一对一和大班课中，分辨率的默认值为 240p（320 * 240）。

| 参数        | 描述                 |
| :---------- | :------------------- |
| `width`     | 视频帧宽度(pixel)。  |
| `height`    | 视频帧高度 (pixel)。 |
| `frameRate` | 视频帧率 (fps)。     |
| `bitrate`   | 视频码率 (Kbps)。    |

### MediaEncryptionConfig

```typescript
export declare interface MediaEncryptionConfig {
    mode: MediaEncryptionMode;
    key: string;
}
```

媒体流加密配置，用于 [LaunchMediaOptions](#launchmediaoptions)。

| 参数   | 描述                                                                                                                     |
| :----- | :----------------------------------------------------------------------------------------------------------------------- |
| `mode` | 媒体流加密模式，详见 [MediaEncryptionMode](#mediaencryptionmode)。同一教室内所有老师和学生必须使用相同的加密模式和密钥。 |
| `key`  | 加密密钥。                                                                                                               |


### ChannelProfile

```typescript
export enum ChannelProfile {
  Communication = 0,
  LiveBroadcasting = 1,
}
```

频道配置，用于 [LaunchMediaOptions](#launchmediaoptions)。

| 参数   | 描述                                                                                                                     |
| :----- | :----------------------------------------------------------------------------------------------------------------------- |
| `Communication` | 通信模式，一般用于一对多或一对一的小班课。 |
| `LiveBroadcasting`  | 直播模式，相较于通信模式，更低费用，同时延迟相较于通信模式较大。 |

### MediaEncryptionMode

```typescript
export enum MediaEncryptionMode {
    AES_128_XTS = 1,
    AES_128_ECB = 2,
    AES_256_XTS = 3,
    AES_128_GCM = 5,
    AES_256_GCM = 6,
}
```

媒体流加密模式，用于 [MediaEncryptionConfig](#mediaencryptionconfig)。

| 参数          | 描述                        |
| :------------ | :-------------------------- |
| `AES_128_XTS` | 128 位 AES 加密，XTS 模式。 |
| `AES_128_ECB` | 128 位 AES 加密，ECB 模式。 |
| `AES_256_XTS` | 256 位 AES 加密，XTS 模式。 |
| `AES_128_GCM` | 128 位 AES 加密，GCM 模式。 |
| `AES_256_GCM` | 256 位 AES 加密，GCM 模式。 |


### FcrMultiThemeMode

```typescript
export enum FcrMultiThemeMode {
  light = 'light',
  dark = 'dark',
}
```

课堂界面显示模式。在 [LaunchOption](#launchoption) 中设置。

| 参数        | 描述                      |
| :---------- | :------------------------ |
| `light`  | （默认）明亮模式。 |
| `dark`   | 暗黑模式。 |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
    audience = 0,
    teacher = 1,
    student = 2,
    assistant = 3,
}
```

用户在课堂中的角色。在 [LaunchOption](#launchoption) 中设置。

| 参数        | 描述                      |
| :---------- | :------------------------ |
| `audience`  | `0`: 观众，用于页面录制。 |
| `teacher`   | `1`: 老师。               |
| `student`   | `2`: 学生。               |
| `assistant` | `3`: 助教。               |

### EduRoomTypeEnum

```typescript
export enum EduRoomTypeEnum {
    Room1v1Class = 0,
    RoomBigClass = 2,
    RoomSmallClass = 4,
}
```

课堂类型。在 [LaunchOption](#launchoption) 中设置。

| 参数             | 描述                                                                                             |
| :--------------- | :----------------------------------------------------------------------------------------------- |
| `Room1v1Class`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。                                  |
| `RoomBigClass`   | `2`: 大班课。1 位老师进行在线教学，多名学生实时观看和收听。大班课课堂人数上限为 5000。|
| `RoomSmallClass` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。小班课中课堂人数上限为 200    |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh";
```

界面语言。在 [LaunchOption](#launchoption) 中设置。

| 参数   | 描述   |
| :----- | :----- |
| `"en"` | 英文。 |
| `"zh"` | 中文。 |

### DeviceTypeEnum

```typescript
export enum DeviceTypeEnum {
  Main = 'main',
  Sub = 'sub',
}
```

设备类型。在 //TODO 中设置。

主副设备介绍详见[集成文档](/cn/agora-class/agora_class_integrate_web?platform=Web#main-sub-device)。

| 参数   | 描述   |
| :----- | :----- |
| `Main` | 主设备。 |
| `Sub` | 副设备。 |