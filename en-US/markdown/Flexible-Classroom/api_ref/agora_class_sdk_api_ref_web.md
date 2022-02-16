This page provides the TypeScript API reference of the Agora Classroom SDK for Web/Electron.

## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### config

```typescript
static config(params: AgoraEduSDKConfigParams):void
```

Configures the SDK.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `params` | 全局配置参数，详见 [ConfigParams](#configparams)。 |

### launch

```typescript
static launch(dom: Element, option: LaunchOption):Promise<void>
```

Launches a classroom.

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `dom` | See [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document) for details. |
| `option` | The classroom launching configuration. See [LaunchOption](#launchoption). |

## Type definition

### ConfigParams

The SDK global configuration. Used when calling [AgoraEduSDK.config](#config).

```typescript
export type AgoraEduSDKConfigParams = {
  appId: string;
  region?: string;
};
```

| Properties | Description |
| :------- | :----------------------------------------------------------- |
| `appId` | (Required) Agora App ID.
 |
| `region` | （选填）课堂所在区域。 All clients must use the same region, otherwise, they may fail to communicate with each other. Flexible Classroom supports the following regions:<li>`CN`: Mainland China</li><li>`AP`: Asia Pacific</li><li>`EU`: Europe</li><li>`NA`: North America</li> |

### LaunchOption

The classroom launching configuration. Used when calling [AgoraEduSDK.launch](#launch).

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

| Parameter | Description |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken` | The RTM token used for authentication. |
| `userUuid` | (Required) The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | (Required) The classroom ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roleType` | The role of the user in the classroom. See [EduRoleTypeEnum](#eduroletypeenum). |
| `roomType` | The classroom type. See [EduRoomTypeEnum](#eduroomtypeenum). |
| `listener` | (Required) The classroom state:<li>`ready`: The classroom is ready.</li><li>`destroyed`: The classroom has been destroyed.</li> |
| `pretest` | Whether to enable the pre-class device test:<li>`true`: Enable the pre-class device test. After this function is enabled, end users can see a page for the device test before entering the classroom. They can check whether their camera, microphone, and speaker can work properly.</li><li>`false`: Disable the pre-class device test.</li> |
| `language` | The UI language. See [LanguageEnum](#languageenum). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. 最大值为 86,400 秒，建议根据课堂实际时长设置。 |
| `recordUrl` | (Optional) The URL address to be recorded. Developers need to pass in the URL of the web page deployed by themselves for page recording, such as `https://cn.bing.com/recordUrl`. |
| `courseWareList` | The configuration of courseware assigned by the educational institution, which cannot be edited by the client. See [CourseWareList](#coursewarelist) for details. After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `personalCourseWareList` | The configuration of courseware uploaded by a teacher. See [CourseWareList](#coursewarelist). After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `extApps` | Register an extension application by using the ExtApp tool. ExtApp is a tool for embedding extension applications in Flexible Classroom. For details, see [Customize Flexible Classroom with ExtApp](/en/agora-class/agora_class_ext_app_web?platform=Web). |
| `userFlexProperties` | User properties customized by the developer. For details, see [How can I set user properties? ](/en/agora-class/faq/agora_class_custom_properties) |
| `mediaOptions` | Media stream configurations, including the encryption configuration and the encoding configurations of the screen-sharing stream and the video stream captured by the camera. See MediaOptions for details``. |
| `latencyLevel` | （选填）观众端延时级别：<li>`1`: Low latency. The latency from the sender to the receiver is 1500 ms to 2000 ms.</li><li>`2`: (Default) Ultra low latency. The latency from the sender to the receiver is 400 ms to 800 ms.</li> |

### MediaOptions

```typescript
export type MediaOptions = {
  cameraEncoderConfiguration?: EduVideoEncoderConfiguration;
  screenShareEncoderConfiguration?: EduVideoEncoderConfiguration;
  encryptionConfig?: MediaEncryptionConfig;
};
```

Media options.

| Parameter | Description |
| :-------------------------------- | :----------------------------------------------------------- |
| `cameraEncoderConfiguration` | The encoding configuration of the video stream captured by the camera. See [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration). |
| `screenShareEncoderConfiguration` | The encoding configuration of the screen-sharing stream. See [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration). |
| `encryptionConfig` | The media stream encryption configuration. See [MediaEncryptionConfig](#mediaencryptionconfig). |

### EduVideoEncoderConfiguration

```typescript
export interface EduVideoEncoderConfiguration {
  width: number;
  height: number;
  frameRate: number;
  bitrate: number;
}
```

Video encoder configurations.

> - 在小班课中，视频编码参数的默认值为 120p（160×120），200 Kbps，15 fps。
> - 在一对一和大班课中，视频编码参数的默认值为 240p（320×240），65 Kbps，15 fps。

| Parameter | Description |
| :---------- | :------------------- |
| `width` | Width (pixel) of the video frame. |
| `height` | Height (pixel) of the video frame. |
| `frameRate` | The frame rate (fps) of the video. |
| `bitrate` | The bitrate (Kbps) of the video. |

### MediaEncryptionConfig

```typescript
export declare interface MediaEncryptionConfig {
  mode: MediaEncryptionMode,
  key: string
    }
```

The media stream encryption configuration. Used in [MediaOptions](#mediaoptions).

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `mode` | Encryption mode. See [MediaEncryptionMode](#mediaencryptionmode). All users in the same classroom must use the same encryption mode and encryption key. |
| `key` | The encryption key. |

### MediaEncryptionMode

```typescript
export enum MediaEncryptionMode {
  AES_128_XTS = 1,
  AES_128_ECB = 2,
  AES_256_XTS = 3,
  AES_128_GCM = 5,
  AES_256_GCM = 6
}
```

Encryption modes. Used in [MediaEncryptionConfig](#mediaencryptionconfig).

| Parameter | Description |
| :------------ | :-------------------------- |
| `AES_128_XTS` | 128-bit AES encryption, XTS mode. |
| `AES_128_ECB` | 128-bit AES encryption, ECB mode. |
| `AES_256_XTS` | 256-bit AES encryption, XTS mode. |
| `AES_128_GCM` | 128-bit AES encryption, GCM mode. |
| `AES_256_GCM` | 256-bit AES encryption, GCM mode. |

### CourseWareList

The courseware pre-download configuration. Used when calling [AgoraEduSDK.launch](#launch).

```typescript
export type CloudDriveResourceConvertProgress = {
  totalPageSize: number;
  convertedPageSize: number;
  convertedPercentage: Number, the progress (percentage) of the conversion task.
  "convertedFileList": [
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
  resourceName: string,
  resourceUuid: string,
  ext: string,
  url: string,
  size: number,
  updateTime: number,
    taskProgress?: CloudDriveResourceConvertProgress;
};

export type CourseWareList = CourseWareItem[]
```

`CourseWareList` 为 `CourseWareItem` 对象组成的数组。 `CourseWareItem` 包含以下参数：

| Parameter | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name for display in the classroom. The string length must be less than 64 bytes. |
| `resourceUuid` | The file ID. This is the unique identifier of a file. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `ext` | The file suffix. |
| `size` | The file size (bytes). |
| `updateTime` | The latest modified time of the file. |
| `url` | The address of the file. Flexible Classroom clients automatically convert files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in classrooms. 如果后缀名非上述所列，必须设置 `url` |
| `taskProgress` | 文件转换任务进度对象 `CloudDriveResourceConvertProgress`，包含以下字段：<ul><li>`totalPageSize`: 总页数。</li><li>`convertedPageSize`: 已转换的页数。</li><li>`convertedPercentage`: Number, the progress (percentage) of the conversion task.</li><li>`convertedFileList`: 已转换的文档页列表，每页文档对应一条数据，每条数据包含以下字段：<ul><li>`name`: 文档页名称。</li><li>`ppt`: 文档页包含的一个幻灯片的具体信息，包含以下字段：<ul><li>`width`: 幻灯片页面宽度。</li><li>`height`: 幻灯片页面高度。</li><li>``The URL address of the converted page.</li><li>`preview`: 缩略图 URL。</li></ul></li></ul></li><li>`currentStep`: 文档转换任务当前的步骤。 可为 `extracting`（正在提取资源）、`generatingPreview`（正在生成预览图）、`mediaTranscode`（媒体文件转换）、`packaging`（打包中）。</li></ul> |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
  audience = 0,
  teacher = 1,
  student = 2,
  assistant = 3
}
```

The role of the user in the classroom. Set in [LaunchOption](#launchoption).

| Parameter | Description |
| :---------- | :------------------------ |
| `audience` | `0`: Audience, only used for web page recording. |
| `teacher` | `1`: Teacher. |
| `student` | `2`: A student. |
| `assistant` | `3`: Teaching assistant. |

### EduRoomTypeEnum

```typescript
export enum EduRoomTypeEnum {
  Room1v1Class = 0,
  RoomBigClass = 2,
  RoomSmallClass = 4
}
```

The classroom type. Set in [LaunchOption](#launchoption).

| Parameter | Description |
| :--------------- | :----------------------------------------------------------- |
| `Room1v1Class` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `RoomBigClass` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `RoomSmallClass` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh"
```

The language of the user interface. Set in [LaunchOption](#launchoption).

| Parameter | Description |
| :----- | :----- |
| `"en"` | English. |
| `"zh"` | Chinese. |
