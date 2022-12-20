This page provides the TypeScript API reference for the Agora Proctor SDK for Web and Electron.

## AgoraProctorSDK

`AgoraProctorSDK` is the basic interface of the Agora Proctor SDK and provides the main methods for the flexible classroom in proctoring scenarios.

### config

```typescript
static config(config: ConfigParams) {}
```

Configure the Agora Proctor SDK.

**Parameters**

| Parameters     | Description                                               |
| :------- | :------------------------------------------------- |
| `config` | Configuration for flexible classroom, see [ConfigParams](#configparams) for details. |

### launch

```typescript
static launch(dom: HTMLElement, option: LaunchOption) {}
```

Launches a flexible classroom in a proctoring scenario.

**Parameters**

| Parameters     | Description                                                             |
| :------- | :--------------------------------------------------------------- |
| `dom`    | Document Object Model (DOM). See [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document) for details. |
| `option` | The classroom launching configuration, see [LaunchOption](#launchoption) for details.          |


## Type Definitions

### ConfigParams

Global SDK configuration, used in [AgoraProctorSDK.config](#config).

```typescript
export type ConfigParams = {
    appId: string;
    region?: string;
};
```

| Properties     | Description                                   |
| :------- | :-------------------------------------------------------- |
| `appId`  | The Agora App ID. See [Get the Agora App ID](https://docs.agora.io/en/flexible-classroom/reference/manage-agora-account?platform=ios#get-the-app-id).   |
| `region` | (Optional)The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. Supported regions are:<ul><li>`CN`: Mainland China</li><li>`AP`: Asia Pacific</li><li>`EU`: Europe</li><li>`NA`: North America</li></ul> |

### LaunchOption

The classroom launching configuration used in [AgoraProctorSDK.launch](#launch).

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
  startTime?: number;
  duration: number;
  widgets?: { [key: string]: typeof AgoraWidgetBase };
  userFlexProperties?: { [key: string]: any };
  mediaOptions?: LaunchMediaOptions;
  latencyLevel?: 1 | 2;
  uiMode?: FcrMultiThemeMode;
  checkStudentScreenShareState?: boolean;
};
```

| Properties               | Description       |
| :----------------------- | :----------------- |
| `userUuid`               | The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. Refer to the relevant instructions in [Integrate Flexible Classroom](https://docs.agora.io/en/flexible-classroom/develop/integrate-flexible-classroom?platform=web). The string length must be less than 64 bytes. Supported character scopes are:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li></ul>  |
| `userName`               | The user name for display in the classroom. The string length must be less than 64 bytes.  |
| `roomUuid`               | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li></ul>  |
| `roleType`               | The user's role in the classroom. See [EduRoleTypeEnum](#eduroletypeenum) for details.    |
| `roomType`               | The classroom type. See [EduRoomTypeEnum](#eduroomtypeenum) for details.  |
| `roomName`               | The room name for display in the classroom. The string length must be less than 64 bytes.  |
| `listener`               | The state of classroom launching.<ul><li>`ready`: The classroom is ready.</li><li>`destroyed`: The classroom has been technically destroyed.</li></ul>  |
| `pretest`                | Whether to enable the pre-class device test:<ul><li>`true`: Enable the pre-class device test. After this function is enabled, end users can see a page for the device test before entering the classroom. They can check whether their camera, microphone, and speaker can work properly.</li><li>`false`: Disable the pre-class device test.</li></ul> |
| `rtmToken`               | The signaling token used for authentication. For details, see [Generate a signaling Token](https://docs.agora.io/en/signaling/develop/authentication-workflow). |
| `language`               | The language on the classroom UI. See [LanguageEnum](#languageenum) for details.       |
| `startTime`              | (Optional) The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration`               | The duration (second) of the class, determined by the first user joining the classroom. The maximum value is 86,400. Agora recommends that you set this value as actual class duration. |
| `widgets`| (Optional) Extensive widgets that  extend the classroom capabilities. See [Embed a custom plugin](https://docs.agora.io/en/flexible-classroom/develop/embed-custom-plugin?platform=webEmbed) for details.|
| `userFlexProperties`     | (Optional) User properties customized by the developer. See [How can I set user properties and classroom properties](https://docs.agora.io/en/help/integration-issues/agora_class_custom_properties) for details.    |
| `mediaOptions`           | (Optional) Media options, including the media encryption configuration, camera video encoder configuration, and screen sharing video encoder configuration. See [LaunchMediaOptions](#launchmediaoptions) for details.  |
| `latencyLevel`           | (Optional) The latency level of an audience member.  This property does not apply to co-hosting users.<ul><li>`1`: Low latency. The latency from the sender to the receiver is between 1500 ms and 2000 ms.</li><li>`2`: (default value) Ultra-low latency. The latency from the sender to the receiver is between 400 ms and 800 ms.</li></ul> |
| `uiMode` | (Optional) The UI theme mode of the classroom. The default value is `light`, which means light theme. See [FcrMultiThemeMode](#fcrmultithememode) for details.   |
|`checkStudentScreenShareState`       | (Optional) Whether to kicks out students from the classroom immediately when they stop screen sharing:<ul><li>`true`: Kicks out the students.</li><li>`false`: Do not kick out the students.</li></ul> |


### LaunchMediaOptions

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

Media options, including the media encryption configuration, camera video encoder configuration, and screen sharing video encoder configuration. Set in [LaunchOption](#launchoption).

| Properties   | Description       |
| :-------------------------------- | :-------------------------------- |
| `cameraEncoderConfiguration`      | (Optional) The encoding configuration of the video stream captured by the camera. See [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration) for details. |
| `screenShareEncoderConfiguration` | (Optional) The encoding configuration of the screen-sharing stream. See [EduVideoEncoderConfiguration](#eduvideoencoderconfiguration) for details.  |
| `encryptionConfig`                | (Optional) The media stream encryption configuration. See [MediaEncryptionConfig](#mediaencryptionconfig) for details.      |
| `channelProfile`                | Channel profile configuration. See [ChannelProfile](#channelprofile) for details.     |
| `web`   | Web configuration for browser codec format and channel mode.<ul><li>`codec`: browser codec format. Available values are as follows:<ul><li>`"vp8"`: VP8</li><li>`"h264"`: H.264</li></li></ul><li>`mode`: channel mode. Available values are as follows:<ul><li>`"rtc"`: communication mode, commonly used for one-to-one or one-to-many classrooms.</li><li>`"live"`: live-streaming mode. It costs less and has a higher latency than the communication mode.</li></ul></li></ul>|

### EduVideoEncoderConfiguration

```typescript
export interface EduVideoEncoderConfiguration {
    width: number;
    height: number;
    frameRate: number;
    bitrate: number;
}
```

The video encoder configuration.


| Properties  | Description                 |
| :---------- | :------------------- |
| `dimensionWidth`  | Width (pixel) of the video frame. The default value is 320.  |
| `dimensionHeight` | Height (pixel) of the video frame. The default value is 240.     |
| `frameRate`       | The frame rate (FPS) of the video. The default value is 15.    |
| `bitRate`         | The bitrate (Kbps) of the video. The default value is 200.    |

### MediaEncryptionConfig

```typescript
export declare interface MediaEncryptionConfig {
    mode: MediaEncryptionMode;
    key: string;
}
```

The media stream encryption configuration used in [LaunchMediaOptions](#launchmediaoptions).

| Properties  | Description            |
| :----- | :--------------------------------- |
| `mode` | Encryption mode. See [MediaEncryptionMode](#mediaencryptionmode). The teachers and students in one classroom need use the same mode and key. |
| `key`  | The encryption key.          |


### ChannelProfile

```typescript
export enum ChannelProfile {
  Communication = 0,
  LiveBroadcasting = 1,
}
```

Channel profiles, used in [LaunchMediaOptions](#launchmediaoptions).

| Values  | Description            |
| :----- | :-------------------------- |
| `Communication` | communication mode, commonly used for one-to-one or one-to-many classrooms. |
| `LiveBroadcasting`  | live-streaming mode. It costs less and has a higher latency than the communication mode. |

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

Media stream encryption mode, used in [MediaEncryptionConfig](#mediaencryptionconfig).

| Values   | Description                        |
| :------------ | :-------------------------- |
| `AES_128_XTS`  | 128-bit AES encryption, XTS mode.    |
| `AES_128_ECB`  | 128-bit AES encryption, ECB mode.      |
| `AES_256_XTS`  | 256-bit AES encryption, XTS mode.    |
| `AES_128_GCM`  | 128-bit AES encryption, GCM mode.    |
| `AES_256_GCM`  | 256-bit AES encryption, GCM mode.   |


### FcrMultiThemeMode

```typescript
export enum FcrMultiThemeMode {
  light = 'light',
  dark = 'dark',
}
```

The UI theme mode of classrooms, used in [LaunchOption](#launchoption).

| Values     | Description                      |
| :---------- | :------------------------ |
| `light`  | Light theme. |
| `dark`   | Dark theme. |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
    teacher = 1,
    student = 2,
}
```

The role of the user in the classroom, used in [LaunchOption](#launchoption).

| Values    | Description                      |
| :---------- | :------------------------ |
| `teacher`   | `1`: Teacher/Proctor             |
| `student`   | `2`: Students/Exam takers             |

### EduRoomTypeEnum

```typescript
export enum EduRoomTypeEnum {
    RoomProctor = 6,
}
```

The classroom type, used in [LaunchOption](#launchoption).

| Values     | Description         |
| :--------------- | :---------- |
| `RoomProctor`   | `6`: Proctored exam room. In proctoring scenarios, `roomType` can only set as this value.  |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh";
```

The language on the UI, used in [LaunchOption](#launchoption).

| Values   | Description   |
| :----- | :----- |
| `"en"` | English |
| `"zh"` | Chinese |

### DeviceTypeEnum

```typescript
export enum DeviceTypeEnum {
  Main = 'main',
  Sub = 'sub',
}
```

Device types.

For more about main devices and supportive devices, see the relevant instructions in [Integrate Flexible Classroom](https://docs.agora.io/en/flexible-classroom/develop/integrate-flexible-classroom?platform=web).

| Values   | Description   |
| :----- | :----- |
| `Main` | Main device |
| `Sub` | Supportive device |