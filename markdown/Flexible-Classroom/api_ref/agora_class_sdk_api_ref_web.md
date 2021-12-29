本页提供 Agora Classroom SDK for Web/Electron 的 TypeScript API 参考。

## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### config

```typescript
static config(params: AgoraEduSDKConfigParams):void
```

配置 SDK。

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `params` | 全局配置参数，详见 [ConfigParams](#configparams)。 |

### launch

```typescript
static launch(dom: Element, option: LaunchOption):Promise<void>
```

启动课堂。

**参数**

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [LaunchOption](#launchoption)。         |

## 类型定义

### ConfigParams

SDK 全局配置。用于 [AgoraEduSDK.config](#config) 方法。

```typescript
export type ConfigParams = {
  appId: string;
  region?: string;
};
```

| 属性     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `appId`  | （必填）Agora App ID。                                       |
| `region` | （选填）课堂所在区域。所有客户端必须设置相同的区域，否则无法互通。灵动课堂支持以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li> |

### LaunchOption

课堂启动配置。用于 [AgoraEduSDK.launch](#launch) 方法。

```typescript
export type LaunchOption = {
  userUuid: string;
  userName: string;
  roomUuid: string;
  roleType: EduRoleTypeEnum;
  roomType: EduRoomTypeEnum;
  roomName: string;
  listener: ListenerCallback;
  pretest: boolean;
  rtmToken: string;
  language: LanguageEnum;
  startTime: number;
  duration: number;
  courseWareList: CourseWareList;
  personalCourseWareList?: CourseWareList;
  recordUrl?: string;
  extApps?: IAgoraExtApp[];
  region?: AgoraRegion;
  widgets?: { [key: string]: IAgoraWidget };
  userFlexProperties?: { [key: string]: any };
  mediaOptions?: MediaOptions;
  latencyLevel?: 1 | 2;
}
```

| 参数                     | 描述                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken`               | （必填）用于鉴权的 RTM Token。                               |
| `userUuid`               | （必填）用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userName`               | （必填）用户名，用于课堂内显示，长度在 64 字节以内。         |
| `roomUuid`               | （必填）课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `roomName`               | （必填）课堂名，用于课堂内显示，长度在 64 字节以内。         |
| `roleType`               | （必填）用户在课堂中的角色，详见 [EduRoleTypeEnum](#eduroletypeenum)。 |
| `roomType`               | （必填）课堂类型，详见 [EduRoomTypeEnum](#eduroomtypeenum)。 |
| `listener`               | （必填）课堂启动状态：<li>`ready`: 课堂准备完毕。</li><li>`destroyed`: 课堂已销毁。</li> |
| `pretest`                | （必填）是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。</li><li>`false`: 不开启课前设备检测。</li> |
| `language`               | （必填）课堂界面的语言，详见 [LanguageEnum](#languageenum)。 |
| `startTime`              | （必填）课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。 |
| `duration`               | （必填）课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。最大值为 86,400 秒，建议根据课堂实际时长设置。 |
| `recordUrl`              | （选填）待录制 URL 地址，开发者需传入自己部署的网页地址，用于页面录制，例如 `https://cn.bing.com/recordUrl`。 |
| `courseWareList`         | （选填）教育机构指派的课件配置，客户端无法编辑。详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |
| `personalCourseWareList` | （选填）老师端自行上传的课件配置，详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |
| `extApps`                | （选填）注册扩展应用 ExtApp。ExtApp 是灵动课堂 UIKit 的补充插件。详见[通过 ExtApp 自定义插件](/cn/agora-class/agora_class_ext_app_web?platform=Web)。 |
| `region`                 | （选填）课堂所在区域。所有客户端必须设置相同的区域，否则无法互通。灵动课堂支持以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li> |
| `userFlexProperties`     | （选填）由开发者自定义的用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties) |
| `mediaOptions`           | （选填）媒体流相关设置，包含媒体流加密、摄像头视频流编码参数配置和屏幕共享视频流编码参数配置，详见 `MediaOptions`。 |
| `latencyLevel`           | （选填）观众端延时级别：<li>`1`: 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。</li><li>`2`:（默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。</li> |

### MediaOptions

```typescript
export type MediaOptions = {
  cameraEncoderConfiguration?: EduVideoEncoderConfiguration;
  screenShareEncoderConfiguration?: EduVideoEncoderConfiguration;
  encryptionConfig?: MediaEncryptionConfig;
};
```

媒体流相关设置。

| 参数                              | 描述                                                         |
| :-------------------------------- | :----------------------------------------------------------- |
| `cameraEncoderConfiguration`      | 摄像头采集视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `screenShareEncoderConfiguration` | 屏幕共享视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `encryptionConfig`                | 媒体流加密配置，详见 [MediaEncryptionConfig](#mediaencryptionconfig)。 |

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

> - 在小班课中，视频编码参数的默认值为 120p（160×120），200 Kbps，15 fps。
> - 在一对一和大班课中，视频编码参数的默认值为 240p（320×240），65 Kbps，15 fps。

| 参数        | 描述                 |
| :---------- | :------------------- |
| `width`     | 视频帧宽度(pixel)。  |
| `height`    | 视频帧高度 (pixel)。 |
| `frameRate` | 视频帧率 (fps)。     |
| `bitrate`   | 视频码率 (Kbps)。    |

### MediaEncryptionConfig

```typescript
export declare interface MediaEncryptionConfig {
  mode: MediaEncryptionMode,
  key: string
}
```

媒体流加密配置，用于 [MediaOptions](#mediaoptions)。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `mode` | 媒体流加密模式，详见 [MediaEncryptionMode](#mediaencryptionmode)。同一教室内所有老师和学生必须使用相同的加密模式和密钥。 |
| `key`  | 加密密钥。                                                   |

### MediaEncryptionMode

```swift
export enum MediaEncryptionMode {
  AES_128_XTS = 1,
  AES_128_ECB = 2,
  AES_256_XTS = 3,
  AES_128_GCM = 5,
  AES_256_GCM = 6
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

### CourseWareList

课件预加载配置。用于 [AgoraEduSDK.launch](#launch) 方法。

```typescript
export type AgoraConvertedFile = {
  width: number;
  height: number;
  ppt: {
    width: number;
    src: string;
    height: number;
  };
  conversionFileUrl: string;
};

export type ConvertedFileList = AgoraConvertedFile[];

export type CourseWareItem = {
  resourceName: string;
  resourceUuid: string;
  ext: string;
  url: string;
  conversion: {
    type: string;
  };
  size: number;
  updateTime: number;
  scenes: SceneDefinition[];
  convert?: boolean;
  taskUuid?: string;
  taskToken?: string;
  taskProgress?: {
    totalPageSize?: number;
    convertedPageSize?: number;
    convertedPercentage?: number;
    convertedFileList: ConvertedFileList;
  };
  isActive?: boolean;
};

export type CourseWareList = CourseWareItem[];
```

`CourseWareList` 为 `CourseWareItem` 对象组成的数组。`CourseWareItem` 包含以下参数：

| 参数           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 课件名称，用于显示，长度在 64 字节以内。                     |
| `resourceUuid` | 课件 uuid。这是资源的唯一标识符。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `ext`          | 课件后缀。                                                   |
| `size`         | 课件大小，单位为字节。                                       |
| `updateTime`   | 课件最后被修改的时间。                                       |
| `conversion`   | 文件转换配置对象，包含以下字段：<ul><li>`type`: 转换类型：</li><ul><li>`"dynamic"`: 转换为静态图片。</li><li>`"static"`: 转换为动态 HTML。</li></ul></ul> |
| `url`          | 文件访问地址。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。如果后缀名非上述所列，必须设置 `url`，`scenes` 可为空。 |
| `scenes`       | 转换后的文件下载配置。当后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"` 或 `"pdf"` 时，必须设置 `scenes`。详见 Agora 互动白板 SDK 的 [SceneDefinition 对象](/cn/whiteboard/API%20Reference/whiteboard_web/globals.html#scenedefinition)。 |
| `convert`      | 是否进行文档转换。                                           |
| `taskUuid`     | 文件转换任务的 uuid。                                        |
| `taskToken`    | 文件转换任务使用的 Token。                                   |
| `taskProgress` | 文件转换任务进度对象，包含以下字段：<ul><li>`totalPageSize`: 总页数。</li><li>`convertedPageSize`: 已转换的页数。</li><li>`convertedPercentage`: 转换进度（百分比）。</li><li>`convertedFileList`: 已转换的文档页面列表，由 `AgoraConvertedFile` 组成的数组。`AgoraConvertedFile` 包含以下字段：<ul><li>`width`: 页面宽度。</li><li>`height`: 页面高度。</li><li>`ppt`: 页面上展示的一个幻灯片的具体信息，包含以下字段：<ul><li>`width`: 幻灯片页面宽度。</li><li>`height`: 幻灯片页面高度。</li><li>`src`: 完成转换的页面的 URL 下载地址。</li></ul></li></ul></li></ul> |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
  audience = 0,
  teacher = 1,
  student = 2,
  assistant = 3
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
  RoomSmallClass = 4
}
```

课堂类型。在 [LaunchOption](#launchoption) 中设置。

| 参数             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| `Room1v1Class`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。 |
| `RoomBigClass`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `RoomSmallClass` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可点名学生“上台”发言，与老师进行实时音视频互动。 |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh"
```

界面语言。在 [LaunchOption](#launchoption) 中设置。

| 参数   | 描述   |
| :----- | :----- |
| `"en"` | 英文。 |
| `"zh"` | 中文。 |