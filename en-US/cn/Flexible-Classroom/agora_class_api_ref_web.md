# Flexible Classroom Web API Reference

## AgoraEduSDK

`AgoraEduSDK` provides the main methods that can be invoked by your app.

### config

```
static config(params: AgoraEduSDKConfigParams):void
```

Configure the SDK.

#### Parameter

| Parameter | Description |
| :------- | :------------------------------------------- |
| `params` | The SDK global configuration, see [AgoraEduSDKConfigParams](#agoraedusdkconfigparams). |

### launch

```
static launch(dom: Element, option: LaunchOption):Promise<void>
```

Launch a classroom.

#### Parameter

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `dom` | See [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document). |
| `option` | The classroom launching configuration, see [LaunchOption](#launchoption). |

## Type definition

### AgoraEduSDKConfigParams

The SDK global configuration. Used when calling [AgoraEduSDK.config](#config).

```
export type AgoraEduSDKConfigParams = {
  appId: string
}
```

| Attributes | Description |
| :------ | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see Get the Agora App ID. |

### LaunchOption

The classroom launching configuration. Used when calling [AgoraEduSDK.launch](#launch).

```
export type LaunchOption = {
  userUuid: string,
  userName: string,
  roomUuid: string,
  roleType: EduRoleTypeEnum,
  roomType: EduRoomTypeEnum,
  roomName: string,
  listener: ListenerCallback,
  pretest: boolean,
  rtmUid: string,
  rtmToken: string,
  language: LanguageEnum,
  startTime: number,
  duration: number,
  courseWareList: CourseWareList,
  personalCourseWareList?: CourseWareList
}
```

| Parameter | Description |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken` | The RTM token used for authentication, see [Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roleType` | The role of the user in the classroom:<li>`1`: Teacher.</li><li>`2`: Student.</li> |
| `roomType` | The room type:<li>`0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student.</li><li>`4`: A small classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in the classroom is 500. During the class, the teacher can invite a student to "take the floor" and share ideas with others. |
| `listener` | The state of classroom launching. |
| `pretest` | Whether to enable the pre-class device test:<li>`true`: Enable the pre-class device test. After this function is enabled, end users can see a page for the device test before entering the classroom. They can check whether their camera, microphone, and speaker can work properly.</li><li>`false`: Disable the pre-class device test.</li> |
| `language` | The UI language:<li>`zh`: zh-CN.</li><li>`en`: en-US.</li> |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `courseWareList` | The configuration of courseware assigned by the educational institution, which cannot edited by the client. See [courseWareList](#coursewarelist). After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |
| `personalCourseWareList` | The configuration of courseware uploaded by a teacher. See [CourseWareList](#coursewarelist). After passing this object, the SDK downloads the courseware from the Agora cloud storage component to the local when launching the classroom. |

### CourseWareList

Courseware pre-download configuration. Used when calling [AgoraEduSDK.launch](#launch).

You can get all the public resources in a specific classroom by calling a RESTful API.

```
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
  taskUuid ?: string,
  taskToken?: string,
  taskProgress: NetlessTaskProgress
}
 
export type CourseWareList = CourseWareItem[]
```

| Parameter | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name for display in the classroom. The string length must be less than 64 bytes. |
| `resourceUuid,` | The file uuid. This is the unique identifier of a file. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `ext` | The file suffix. |
| `size` | The file size (bytes). |
| `updateTime` | The latest modified time of the file. |
| `conversion` | The file conversion configuration object. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom. The JSON object contains the following fields:<ul><li>`type`: The conversion type:</li><ul><li>`"static"`: Convert the file to a static picture.</li><li>`"dynamic"`: Convert the file to a dynamic HTML page.</li></ul><ul> |
| `url` | The download link of the file. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom. When the file suffix is not `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"`, you must set `url` and leave `scenes` empty. |
| `scenes` | The download configuration of the converted file. When the file suffix is `"ppt"`, `"pptx"`, `"doc"`, `"docx"` or `"pdf"`, you must set `scenes` for downloading the converted file. |
| `taskUuid` | The unique identifier of the file conversion task. |
| `taskToken` | The token used by the file conversion task. |
| `taskProgress` | The JSON object that indicates the progress of the file conversion task. |