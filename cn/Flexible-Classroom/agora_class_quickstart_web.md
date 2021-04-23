根据本文指导在你的 Web 项目中快速集成 Agora Classroom SDK 并调用 API 启动灵动课堂。

<div class="alert note"><li>开始前请确保满足接入灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>Web 既支持老师也支持学生。</div>

## <div class="alert note"><li>开始前请确保满足接入灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>Android 仅支持学生。</div>

Agora 在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Community/CloudClass-Desktop)，演示了如何集成 Agora Classroom SDK 并调用 API 启动灵动课堂。你可以下载并查看源代码。

Agora 还提供一个 [CodePen 示例项目](https://codepen.io/agoratechwriter/pen/OJRrOxg)。在完成[前提条件](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web)的基础上，你只需在示例项目中传入 [Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#1-创建-agora-项目并获取-app-id-和-app-证书)、[RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#5-生成-rtm-token) 和用户 ID（需要与你生成 RTM Token 时使用的 UID 一致），即可运行示例项目体验灵动课堂。

## 准备开发环境

- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。

## 集成 Agora Classroom SDK

你可以通过 CDN 获取 Agora Classroom SDK。在你的项目的 HTML 文件中，添加如下代码：

```html
<script src="https://download.agora.io/edu-apaas/edu_sdk_1.0.js"></script>
```

## 进行全局配置

调用 `AgoraEduSDK.config` 方法进行 SDK 全局配置。你需要在该方法中传入以下参数：

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `appId` | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#1-创建-agora-项目并获取-app-id-和-app-证书)。 |

```js
AgoraEduSDK.config({
  // Agora App ID
  appId: '<YOUR AGORA APPID>',
})
```

## 启动课堂

你需要创建一个课堂实例，将该实例挂载在 Dom 元素上后调用 `launch` 方法即可进入教室。调用 `launch` 方法时，你需要传入一个 JSON 配置，包含以下参数：

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `rtmToken` | String  | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep?platform=Web#5-生成-rtm-token)。 |
| `userUuid` | String  | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `userName` | String  | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid` | String  | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | String  | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roleType`               | EduRoleTypeEnum  | 用户在课堂中的角色，可设为：<li>`1`: 老师<li>`2`: 学生               |
| `roomType`               | EduRoomTypeEnum  | 课堂类型，可设为：<li>`0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`4`: 互动直播小班课。一名老师进行教学，多名学生实时观看和收听。课堂人数上限为 500 人。上课过程中，老师可邀请学生“上台”发言。 |
| `listener`               | ListenerCallback | 课堂启动状态。                                               |
| `pretest`                | Boolean          | 是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出一个设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。<li>`false`: 不开启课前设备检测。 |
| `language`               | LanguageEnum     | 界面语言：<li>`zh`: 中文<li>`en`: 英文                               |
| `startTime`              | Number           | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`               | Number           | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |
| `courseWareList`         | CourseWareList   | （选填）课件配置对象，用于预加载教育机构指派的课件，客户端进入课堂后无法进行新增或删除操作。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |
| `personalCourseWareList` | CourseWareList   | （选填）课件配置对象，用于预加载教师端上传的课件。配置后，SDK 会在启动课堂时将相应的课件从 Agora 云盘组件中下载至本地。 |

以下示例代码演示了如何以老师角色进入一个互动直播小班课。

```js
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

成功运行后，你可以看到如下界面：

![](https://web-cdn.agora.io/docs-files/1611126476035)