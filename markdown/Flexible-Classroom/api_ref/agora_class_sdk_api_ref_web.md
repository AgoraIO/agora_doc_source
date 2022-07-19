本页提供 Agora Classroom SDK for Web/Electron 的 TypeScript API 参考。

## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### config

```typescript
static config(params: ConfigParams):void
```

配置 SDK。

| 参数     | 描述                                               |
| :------- | :------------------------------------------------- |
| `params` | 全局配置参数，详见 [ConfigParams](#configparams)。 |

### launch

```typescript
static launch(dom: Element, option: LaunchOption):Promise<void>
```

启动课堂。

**参数**

| 参数     | 描述                                                                         |
| :------- | :--------------------------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [LaunchOption](#launchoption)。                           |

## 类型定义

### ConfigParams

SDK 全局配置。用于 [AgoraEduSDK.config](#config) 方法。

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

课堂启动配置。用于 [AgoraEduSDK.launch](#launch) 方法。

```typescript
export type LaunchOption = {
    userUuid: string;
    userName: string;
    roomUuid: string;
    roleType: EduRoleTypeEnum;
    roomType: EduRoomTypeEnum;
    roomSubtype?: EduRoomSubtypeEnum;
    roomName: string;
    listener: ListenerCallback;
    pretest: boolean;
    rtmToken: string;
    language: LanguageEnum;
    startTime?: number;
    duration: number;
    courseWareList: CourseWareList;
    personalCourseWareList?: CourseWareList;
    recordUrl?: string;
    extApps?: IAgoraExtApp[];
    region?: AgoraRegion;
    widgets?: {[key: string]: IAgoraWidget};
    userFlexProperties?: {[key: string]: any};
    mediaOptions?: MediaOptions;
    latencyLevel?: 1 | 2;
    platform?: Platform;
};
```

| 参数                     | 描述                                                                                                                                                                                                |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `rtmToken`               | （必填）用于鉴权的 RTM Token。                                                                                                                                                                      |
| `userUuid`               | （必填）用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~                                                   |
| `userName`               | （必填）用户名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                |
| `roomUuid`               | （必填）课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~                                                                                                 |
| `roomName`               | （必填）课堂名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                |
| `roleType`               | （必填）用户在课堂中的角色，详见 [EduRoleTypeEnum](#eduroletypeenum)。                                                                                                                              |
| `roomType`               | （必填）课堂类型，详见 [EduRoomTypeEnum](#eduroomtypeenum)。                                                                                                                                        |
| `roomSubtype`               | （选填）课堂子类型，详见 [EduRoomSubtypeEnum](#eduroomsubtypeenum)。默认值为 `EduRoomSubtypeEnum.Standard`。                                                                                                                                        |
| `listener`               | （必填）课堂启动状态：<li>`ready`: 课堂准备完毕。</li><li>`destroyed`: 课堂已销毁。</li>                                                                                                            |
| `pretest`                | （必填）是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。</li><li>`false`: 不开启课前设备检测。</li> |
| `language`               | （必填）课堂界面的语言，详见 [LanguageEnum](#languageenum)。                                                                                                                                        |
| `startTime`              | （选填）课堂开始时间（毫秒），以第一个进入课堂的用户传入的参数为准。                                                                                                                                |
| `duration`               | （必填）课堂持续时间（秒），以第一个进入课堂的用户传入的参数为准。最大值为 86,400 秒，建议根据课堂实际时长设置。                                                                                    |
| `recordUrl`              | （选填）待录制 URL 地址，开发者需传入自己部署的网页地址，用于页面录制，例如 `https://cn.bing.com/recordUrl`。                                                                                       |
| `courseWareList`         | （选填）教育机构指派的课件配置，客户端无法编辑。详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。                                       |
| `personalCourseWareList` | （选填）老师端自行上传的课件配置，详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。                                                     |
| `extApps`                | （选填）注册扩展应用 ExtApp。ExtApp 是灵动课堂 UIKit 的补充插件。详见[通过 ExtApp 自定义插件](/cn/agora-class/agora_class_ext_app_web?platform=Web)。                                               |
| `userFlexProperties`     | （选填）由开发者自定义的用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)                                                                                 |
| `mediaOptions`           | （选填）媒体流相关设置，包含媒体流加密、摄像头视频流编码参数配置和屏幕共享视频流编码参数配置，详见 `MediaOptions`。                                                                                 |
| `latencyLevel`           | （选填）观众端延时级别：<li>`1`: 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。</li><li>`2`:（默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。</li>                                     |
| `platform`               | （选填）适用平台，可设为 `'PC'` 和 `'H5'`。                                                                                                                                                         |

### MediaOptions

```typescript
export type MediaOptions = {
    cameraEncoderConfiguration?: EduVideoEncoderConfiguration;
    screenShareEncoderConfiguration?: EduVideoEncoderConfiguration;
    encryptionConfig?: MediaEncryptionConfig;
    channelProfile?: ChannelProfile;
};
```

媒体流相关设置。

| 参数                              | 描述                                                                                               |
| :-------------------------------- | :------------------------------------------------------------------------------------------------- |
| `cameraEncoderConfiguration`      | 摄像头采集视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `screenShareEncoderConfiguration` | 屏幕共享视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。   |
| `encryptionConfig`                | 媒体流加密配置，详见 [MediaEncryptionConfig](#mediaencryptionconfig)。                             |
| `channelProfile`                | 频道配置，详见 [ChannelProfile](#channelprofile)。                             |

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

> -   在小班课中，视频编码参数的默认值为 120p（160×120），200 Kbps，15 fps。
> -   在一对一和大班课中，视频编码参数的默认值为 240p（320×240），65 Kbps，15 fps。

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

媒体流加密配置，用于 [MediaOptions](#mediaoptions)。

| 参数   | 描述                                                                                                                     |
| :----- | :----------------------------------------------------------------------------------------------------------------------- |
| `mode` | 媒体流加密模式，详见 [MediaEncryptionMode](#mediaencryptionmode)。同一教室内所有老师和学生必须使用相同的加密模式和密钥。 |
| `key`  | 加密密钥。                                                                                                               |

### ChannelProfile

```typescript
export enum ChannelProfile {
  Communication = 0,
  LiveBroadcasting = 1,
  BlendCDN = 2,
  MixRTCCDN = 3,
}
```

频道配置，用于 [MediaOptions](#mediaoptions)。

| 参数   | 描述                                                                                                                     |
| :----- | :----------------------------------------------------------------------------------------------------------------------- |
| `Communication` | 通信模式，一般用于一对多或一对一的小班课。 |
| `LiveBroadcasting`  | 直播模式，相较于通信模式，更低费用，同时延迟相较于通信模式较大。 |
| `BlendCDN` | 融合 CDN 模式，一般用于直播课，无法进行音视频互动。|
| `MixRTCCDN` | 融合 CDN 和 RTC 的混合模式。|

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

### CourseWareList

课件预加载配置。用于 [AgoraEduSDK.launch](#launch) 方法。

```typescript
export type CloudDriveResourceConvertProgress = {
    totalPageSize: number;
    convertedPageSize: number;
    convertedPercentage: number;
    convertedFileList: {
        name: string;
        ppt: {
            width: number;
            height: number;
            preview?: string;
            src: string;
        };
    }[];
    currentStep: string;
};

export type CourseWareItem = {
    resourceName: string;
    resourceUuid: string;
    ext: string;
    url?: string;
    size: number;
    updateTime: number;
    taskUuid: string;
    conversion: {
        type: string;
        preview: boolean;
        scale: number;
        outputFormat: string;
    };
    taskProgress?: CloudDriveResourceConvertProgress;
};

export type CourseWareList = CourseWareItem[];
```

`CourseWareList` 为 `CourseWareItem` 对象组成的数组。

<details>
<summary><font color="#3ab7f8">示例代码一：没有白板转换文件</font></summary>
<pre class="json show"><code class="language-json">courseWareList:
[
    {
            resourceName: "机械能",
            resourceUuid: "c06fed32d06268431601b0e0a804e70a",
            ext: "mp4",
            url: "https://gymoo-project-cdn.oss-cn-shenzhen.aliyuncs.com/hld_education/upload/9f4d3c149e6b3acfef378aca012780b3.mp4",
            size: 4560284
    }
],
</code></pre>
</details>

<details>
<summary><font color="#3ab7f8">示例代码二：有白板转换文件</font></summary>
<pre class="json show"><code class="language-json">courseWareList:
[
    {
      resourceName: xxxxxxx,
      resourceUuid: xxxxxxxxx,
      ext: 'pptx',
      url: 'https://xxxxxxxxxxxxxx',
      size: 0,
      updateTime: xxxxxxxx
      taskUuid: 'xxxxxxxxx',
      conversion: {
            type: 'dynamic',
            preview: true,
            scale: 2,
            outputFormat: 'png',
            },
      taskProgress: {
        totalPageSize: 3,
        convertedPageSize: 3,
        convertedPercentage: 100,
        convertedFileList: [
            {
                name: '1',
                ppt: {
                    src: 'pptx://convertcdn.netless.link/dynamicConvert/3bxxxxxxx/1.slide',
                    width: 1280,
                    height: 720,
                    preview:'dddddddddddddddurl'
                },
            },
            ...
        ] as any,
        currentStep: '',
        },
    },
],
</code></pre>
</details>

`CourseWareItem` 包含以下参数：

| 参数           | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `resourceName` | 课件名称，用于显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `resourceUuid` | 课件 uuid。这是资源的唯一标识符。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `ext`          | 课件后缀。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `size`         | 课件大小，单位为字节。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `updateTime`   | 课件最后被修改的时间。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `taskUuid`     | 课件转换任务的 uuid。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `conversion`   | 包含以下字段：<ul><li>`type`: String 型，课件转换方式，可设为：<ul><li>`"static"`: 静态转换，是指将 PPT、PPTX、DOC、DOCX、PDF 格式的文件转换成 PNG、JPG/JPEG 或 WEBP 格式的静态图片。转换后的文件不保留源文件的动画效果。</li><li>`"dynamic"`: 动态转换，是指将用 Microsoft Office 编辑的 PPTX 格式的文件转换成 HTML 网页。转换后的文件会保留源文件里的动画效果。</li></ul></li><li>`preview`: Boolean 型，是否需要显示左侧预览。</li><li>`scale`: Number 型，转换缩放比例，取值范围为 [0, 3]。</li><li>`outputFormat`: String 型，课件转换后图片资源的输出格式，可设为 `"png"`。</li></ul>                                                                                                                                                                             |
| `url`          | 文件访问地址。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。如果后缀名非上述所列，必须设置 `url`。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `taskProgress` | 文件转换任务进度对象 `CloudDriveResourceConvertProgress`，包含以下字段：<ul><li>`totalPageSize`: 总页数。</li><li>`convertedPageSize`: 已转换的页数。</li><li>`convertedPercentage`: 转换进度（百分比）。</li><li>`convertedFileList`: 已转换的文档页列表，每页文档对应一条数据，每条数据包含以下字段：<ul><li>`name`: 文档页名称。</li><li>`ppt`: 文档页包含的一个幻灯片的具体信息，包含以下字段：<ul><li>`width`: 幻灯片页面宽度。</li><li>`height`: 幻灯片页面高度。</li><li>`src`: 完成转换的页面的 URL 下载地址。</li><li>`preview`: 缩略图 URL。</li></ul></li></ul></li><li>`currentStep`: 文档转换任务当前的步骤。可为 `extracting`（正在提取资源）、`generatingPreview`（正在生成预览图）、`mediaTranscode`（媒体文件转换）、`packaging`（打包中）。</li></ul> |

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
| `RoomBigClass`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。大班课中课堂人数上限为 5000。 |
| `RoomSmallClass` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。小班课中课堂人数上限为 200    |

### EduRoomSubtypeEnum

```typescript
export enum EduRoomSubtypeEnum {
    Standard = 0,
    Vocational = 1,
}
```

课堂子类型。在 [LaunchOption](#launchoption) 中设置。

| 参数             | 描述                                                                                             |
| :--------------- | :----------------------------------------------------------------------------------------------- |
| `Standard`   | `0`: 标准的灵动课堂。                                |
| `Vocational`   | `1`: 当 `roomType` 设为 `EduRoomTypeEnum.RoomBigClass` 时，再将 `roomSubtype` 设为 `EduRoomSubtypeEnum.Vocational`，则为职业教育大班课。 |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh";
```

界面语言。在 [LaunchOption](#launchoption) 中设置。

| 参数   | 描述   |
| :----- | :----- |
| `"en"` | 英文。 |
| `"zh"` | 中文。 |