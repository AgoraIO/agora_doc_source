本页提供灵动课堂 Web 和 Electron 端的 TyptScript API 参考。

## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### config

```typescript
static config(params: AgoraEduSDKConfigParams):void
```

配置 SDK。

**示例代码**

```typescript
AgoraEduSDK.config({
  // Agora App ID
  appId: '<YOUR AGORA APPID>',
})
```

**参数**

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `params` | 全局配置参数，详见 [`AgoraEduSDKConfigParams`](#agoraedusdkconfigparams)。 |

### launch

```typescript
static launch(dom: Element, option: LaunchOption):Promise<void>
```

启动课堂。

**示例代码**

```typescript
// 配置课件
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

// 启动课堂
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

**参数**

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [`LaunchOption`](#launchoption)。         |

## 类型定义

### AgoraEduSDKConfigParams

SDK 全局配置。用于 [`AgoraEduSDK.config`](#config) 方法。

```typescript
export type AgoraEduSDKConfigParams = {
  appId: string
}
```

| 属性    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `appId` | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |

### LaunchOption

课堂启动配置。用于 [`AgoraEduSDK.launch`](#launch) 方法。

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
  rtmUid: string
  rtmToken: string,
  language: LanguageEnum,
  startTime: number,
  duration: number,
  courseWareList: CourseWareList,
  personalCourseWareList?: CourseWareList,
  recordUrl?: string,
  extApps?: IAgoraExtApp[]
  region?: AgoraRegion
}
```

| 参数                     | 描述                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken`               | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。 |
| `userUuid`               | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName`               | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid`               | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName`               | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roleType`               | 用户在课堂中的角色，详见 [`EduRoleTypeEnum`](#eduroletypeenum)。 |
| `roomType`               | 课堂类型，详见 [`EduRoomTypeEnum`](#eduroomtypeenum)。       |
| `listener`               | 课堂启动状态：<li>`ready`: 课堂准备完毕。</li><li>`destroyed`: 课堂已销毁。</li> |
| `pretest`                | 是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。</li><li>`false`: 不开启课前设备检测。</li> |
| `language`               | 界面语言，详见 [`LanguageEnum`](#languageenum)。             |
| `startTime`              | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`               | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |
| `recordUrl`              | 待录制 URL 地址，开发者需传入自己部署的网页地址，用于页面录制，例如 `https://cn.bing.com/recordUrl`。 |
| `courseWareList`         | 教育机构指派的课件配置，客户端无法编辑。详见 [`CourseWareList`](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |
| `personalCourseWareList` | 老师端自行上传的课件配置，详见 [`CourseWareList`](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |

### CourseWareList

课件预加载配置。用于 [`AgoraEduSDK.launch`](#launch) 方法。

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

| 参数           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 课件名称，用于显示，长度在 64 字节以内。                     |
| `resourceUuid` | 课件 uuid。这是资源的唯一标识符。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `ext`          | 课件后缀，决定文件类型。                                     |
| `size`         | 课件大小，单位为字节。                                       |
| `updateTime`   | 课件最后被修改的时间。                                       |
| `conversion`   | 文件转换配置对象，包含以下字段：<ul><li>`type`: 转换类型：</li><ul><li>`"dynamic"`: 转换为静态图片。</li><li>`"static"`: 转换为动态 HTML。</li></ul></ul> |
| `url`          | 文件访问地址。灵动课堂客户端会对后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。如果后缀名非上述所列，必须设置 `url`，`scenes` 可为空。 |
| `scenes`       | 转换后的文件下载配置。当后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"` 或 `"pdf"` 时，必须设置 `scenes`。 |
| `taskUuid`     | 文件转换任务的 uuid。                                        |
| `taskToken`    | 文件转换任务使用的 Token。                                   |
| `taskProgress` | 文件转换任务进度对象。                                       |

### EduRoleTypeEnum

```typescript
export enum EduRoleTypeEnum {
  audience = 0,
  teacher = 1,
  student = 2,
  assistant = 3
}
```

用户在课堂中的角色。在 [`LaunchOption`](#launchoption) 中设置。

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

课堂类型。在 [`LaunchOption`](#launchoption) 中设置。

| 参数             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| `Room1v1Class`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。 |
| `RoomBigClass`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `RoomSmallClass` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可点名学生“上台”发言，与老师进行实时音视频互动。 |

### LanguageEnum

```typescript
export type LanguageEnum = "en" | "zh"
```

界面语言。在 [`LaunchOption`](#launchoption) 中设置。

| 参数   | 描述   |
| :----- | :----- |
| `"en"` | 英文。 |
| `"zh"` | 中文。 |