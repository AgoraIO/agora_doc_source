## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供应用程序调用的主要接口。

### config

```
static config(params: AgoraEduSDKConfigParams):void
```

配置 SDK。

#### 参数

| 参数     | 描述                                         |
| :------- | :------------------------------------------- |
| `params` | 全局配置参数，详见 [AgoraEduSDKConfigParams](#agoraedusdkconfigparams)。 |

### launch

```
static launch(dom: Element, option: LaunchOption):Promise<void>
```

启动课堂。

#### 参数

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `dom`    | 详见 [Document](https://developer.mozilla.org/en-US/docs/Web/API/Document)。 |
| `option` | 课堂启动配置，详见 [LaunchOption](#launchoption)。                            |

## 类型定义

### AgoraEduSDKConfigParams

SDK 全局配置。用于 [AgoraEduSDK.config](#config) 方法。

```
export type AgoraEduSDKConfigParams = {
  appId: string
}
```

| 属性    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `appId` | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |

### LaunchOption

课堂启动配置。用于 [AgoraEduSDK.launch](#launch) 方法。

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
  rtmUid: string
  rtmToken: string,
  language: LanguageEnum,
  startTime: number,
  duration: number,
  courseWareList: CourseWareList,
  personalCourseWareList?: CourseWareList
}
```

| 参数                     | 描述                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `rtmToken`               | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。 |
| `userUuid`               | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName`               | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid`               | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","|
| `roomName`               | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roleType`               | 用户在课堂中的角色，可设为：<li>`1`: 老师</li><li>`2`: 学生</li>               |
| `roomType`               | 课堂类型，可设为：<li>`0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。</li><li>`4`: 1 对 N 在线小班课。1 位教师对 N 名学生（2 ≤ N ≤ 16）进行在线辅导教学。 |
| `listener`               | 课堂启动状态。                                               |
| `pretest`                | 是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。</li><li>`false`: 不开启课前设备检测。</li> |
| `language`               | 界面语言：<li>`zh`: 中文</li><li>`en`: 英文</li>                               |
| `startTime`              | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`               | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |
| `courseWareList`         | 教育机构指派的课件配置，客户端无法编辑。详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |
| `personalCourseWareList` | 老师端自行上传的课件配置，详见 [CourseWareList](#coursewarelist)。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |

### CourseWareList

课件预加载配置。用于 [AgoraEduSDK.launch](#launch) 方法。

你可通过服务端获取公共资源接口来获取指定课堂内的所有公共资源。

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
| `conversion`   | 文件转换配置对象，包含以下字段：<ul><li>`type`: 转换类型：</li><ul><li>`"dynamic"`: 转换为静态图片。</li><li>`"static"`: 转换为动态 HTML。</li></ul><ul> |
| `url`          | 文件访问地址。灵动课堂客户端会对后缀名 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以用于课堂内白板展示。如果后缀名非上述所列，必须设置 `url`，`scenes` 可为空。 |
| `scenes`       | 转换后的文件下载配置。当后缀名为 `"ppt"`、`"pptx"`、`"doc"`、`"docx"` 或 `"pdf"` 时，必须设置 `scenes`。 |
| `taskUuid`     | 文件转换任务的 uuid。                                        |
| `taskToken`    | 文件转换任务使用的 Token。                                   |
| `taskProgress` | 文件转换任务进度对象。                                       |