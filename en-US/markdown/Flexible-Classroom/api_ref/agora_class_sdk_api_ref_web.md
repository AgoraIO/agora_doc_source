This page provides the TypeScript API reference of the Agora Classroom SDK for Web/Electron.

## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### config

```typescript
static config(params: AgoraEduSDKConfigParams):void
```

Configure the SDK.

**Sample code**

```typescript
AgoraEduSDK.config({
  // Agora App ID
  appId: '<YOUR AGORA APPID>',
})
```

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `params` | 全局配置参数，详见 [`AgoraEduSDKConfigParams`](#agoraedusdkconfigparams)。 |

### launch

```typescript
static launch(dom: Element, option: LaunchOption):Promise<void>
```

Launch a classroom.

**Sample code**

```typescript
// Configure courseware
let resourceUuid = "xxxxx"
let resourceName = "my ppt slide"
let sceneInfos = []
let sceneInfo = {
    name: "1",
    ppt: {
        src: "pptx://....",
        width: 480,
        height: 360
    }
}
sceneInfos.push(sceneInfo)

let courseWareList = [{
    resourceUuid,
    resourceName,
    size: 10000,
    updateTime: new Date().getTime(),
    ext: "pptx",
    url:null,
    scenes: sceneInfos,
    taskUuid: "xxxx",
    taskToken: "xxx",
    taskProgress: NetlessTaskProgress
}]

// Launch a classroom
AgoraEduSDK.launch(document.querySelector(`#${this.elem.id}`), {
    rtmToken: "<your rtm token>",
    userUuid: "test",
    userName: "teacher",
    roomUuid: "4321",
    roleType: 1,
    roomType: 4,
    roomName: "demo-class",
    pretest: false,
    language: "en",
    startTime: new Date().getTime(),
    duration: 60 * 30,
    courseWareList: [],
    listener: (evt) => {
        console.log("evt", evt)
    }
})
```

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `dom` | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [`LaunchOption`](#launchoption)。 |

## Type definition

### AgoraEduSDKConfigParams

The SDK global configuration. Used when calling [`AgoraEduSDK.config`]()[](.

```typescript
export type AgoraEduSDKConfigParams = {
  appId: string
}
```

| Attributes | Description |
| :------ | :----------------------------------------------------------- |
| `appId` | The Agora App ID. See [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |

### LaunchOption

The classroom launching configuration. Used when calling [`AgoraEduSDK.launch`]()[](.

```typescript
export type LaunchOption = {
  userUuid: string,
  userName: string,
  roomUuid: string,
  roleType: EduRoleTypeEnum,
  roomType: EduRoomTypeEnum,
  roomName: string,
  listener: ListenerCallback,
  pretest: boolean,
  rtmToken: string,
  language: LanguageEnum,
  startTime: number,
  duration: number,
  courseWareList: CourseWareList,
  personalCourseWareList?: CourseWareList
  recordUrl?: string,
  extApps?: IAgoraExtApp[]
  region?: AgoraRegion;
  widgets?: { [key: string]: IAgoraWidget };
  userFlexProperties?: { [key: string]: any };
  mediaOptions?: MediaOptions;
  latencyLevel?: 1 | 2;
}
```

| Parameter | Description |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken` | The RTM token used for authentication. For details, see [Generate an RTM Token](https://docs.agora.io/en/agora-class/agora_class_prep#step5). |
| `userUuid` | The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roleType` | 用户在课堂中的角色，详见 [`EduRoleTypeEnum`](#eduroletypeenum)。 |
| `roomType` | 课堂类型，详见 [`EduRoomTypeEnum`](#eduroomtypeenum)。 |
| `listener` | The state of classroom launching.<li>`ready`: The classroom is` ready`.</li><li>`destroyed`: The classroom has been` destroyed`.</li> |
| `pretest` | Whether to enable the pre-class device test:<li>`true`: Enable the pre-class device test. After this function is enabled, end users can see a page for the device test before entering the classroom. They can check whether their camera, microphone, and speaker can work properly.</li><li>`false`: Disable the pre-class device test.</li> |
| `language` | 课堂界面的语言，详见 [`LanguageEnum`](#languageenum)。 |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `recordUrl` | The URL address to be recorded. Developers need to pass in the URL of the web page deployed by themselves for page recording, such as `https://cn.bing.com/recordUrl`. |
| `courseWareList` | The configuration of courseware assigned by the educational institution, which cannot be edited by the client. 详见 [`CourseWareList`](#coursewarelist)。 After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `personalCourseWareList` | 老师端自行上传的课件配置，详见 [`CourseWareList`](#coursewarelist)。 After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `extApps` | Register an extension application by using the ExtApp tool. ExtApp is a tool for embedding extension applications in Flexible Classroom. 详见[通过 ExtApp 自定义插件](./agora_class_ext_app_web?platform=Web)。 |
| `region` | The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. Flexible Classroom supports the following features:<li>`CN`: Mainland China</li><li>`AP`: Asia Pacific</li><li>`EU`: Europe</li><li>`NA`: North America</li> |
| `userFlexProperties` | User attributes customized by the developer. For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties) |
| `mediaOptions` | 媒体流相关设置，包含媒体流加密、摄像头视频流编码参数配置和屏幕共享视频流编码参数配置，详见 `MediaOptions`。 |
| `latencyLevel` | The latency level of an audience member in interactive live streaming.<li>`1`: Low latency. Low latency: The latency from the sender to the receiver is 1500 ms to 2000 ms.</li><li>(Default) Ultra low latency. The latency from the sender to the receiver is 400 ms to 800 ms.</li> |

### mediaOptions

```typescript
export type LaunchOption = {
  cameraEncoderConfiguration?: EduVideoEncoderConfiguration;
  screenShareEncoderConfiguration?: EduVideoEncoderConfiguration;
  encryptionConfig?: MediaEncryptionConfig;
};
```

Media options.

| Parameter | Description |
| :-------------------------------- | :----------------------------------------------------------- |
| `cameraEncoderConfiguration` | 摄像头采集视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `screenShareEncoderConfiguration` | 屏幕共享视频流编码参数配置，详见 [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration)。 |
| `encryptionConfig` | 媒体流加密配置，详见 [MediaEncryptionConfig](#mediaencryptionconfig)。 |

### EduVideoEncoderConfiguration

```typescript
export interface EduVideoEncoderConfiguration {
  width: number;
  height: number;
  frameRate: Number type field.
  bitrate: Number type field.
}
```

Video profile.

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

媒体流加密配置，用于 [MediaOptions](#mediaoptions)。

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `mode` | 媒体流加密模式，详见 [MediaEncryptionMode](#mediaencryptionmode)。 All users in the same channel must use the same encryption mode and encryption key. |
| `key` | The encryption key. |

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

| Parameter | Description |
| :------------ | :-------------------------- |
| `AES_128_XTS` | 128-bit AES encryption, XTS mode. |
| `AES_128_ECB` | 128-bit AES encryption, ECB mode. |
| `AES_256_XTS` | 256-bit AES encryption, XTS mode. |
| `AES_128_GCM` | 128-bit AES encryption, GCM mode. |
| `AES_256_GCM` | 256-bit AES encryption, GCM mode. |

### CourseWareList

The courseware pre-download configuration. Used when calling [`AgoraEduSDK.launch`]()[](.

```typescript
export type CourseWareItem = {
  resourceName: string,
  resourceUuid: string,
  ext: string,
  url: string,
  conversion: {
    type: string,
  },
  size: number,
  updateTime: number,
  scenes: SceneDefinition[],
  convert?: boolean,
  taskUuid?: string,
  taskToken?: string,
  taskProgress?: NetlessTaskProgress
}

export type CourseWareList = CourseWareItem[]
```

| Parameter | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name for display in the classroom. The string length must be less than 64 bytes. |
| `resourceUuid` | The file ID. This is the unique identifier of a file. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `ext` | 课件后缀。 |
| `size` | The file size (bytes). |
| `updateTime` | The latest modified time of the file. |
| `conversion` | The file conversion configuration object, which contains the following fields:<ul><li>`type`: The conversion` type`:</li><ul><li>`"dynamic"`: Convert the file to a static picture.</li><li>`"static"`: Convert the file to dynamic HTML.</li></ul></ul> |
| `url` | The address of the file. Flexible Classroom clients automatically convert files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in classrooms. If the suffix name is not listed above, you must set `url `and leave` scenes` empty. |
| `scenes` | The download configuration of the converted file. When the file suffix is `"ppt"`, `"pptx"`, `"doc"`, `"docx"` or `"pdf"`, you must set scenes for downloading the converted file``. |
| `taskUuid` | The unique identifier of the file conversion task. |
| `taskToken` | The token used by the file conversion task. |
| `taskProgress` | The JSON object indicates the progress of the file conversion task. |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
  audience = 0,
  teacher = 1,
  student = 2,
  assistant = 3
}
```

The role of the user in the classroom. 在 [`LaunchOption`](#launchoption) 中设置。

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

The classroom type. 在 [`LaunchOption`](#launchoption) 中设置。

| Parameter | Description |
| :--------------- | :----------------------------------------------------------- |
| `Room1v1Class` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `RoomBigClass` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `RoomSmallClass` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh"
```

The language of the user interface. 在 [`LaunchOption`](#launchoption) 中设置。

| Parameter | Description |
| :----- | :----- |
| `"en"` | English. |
| `"zh"` | Chinese. |
