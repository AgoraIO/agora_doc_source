根据本文指导在你的 Web 项目中快速集成 Agora Classroom SDK 并调用 API 启动灵动课堂。

<div class="alert note"><li>开始前请确保满足接入灵动课堂的<a href="./agora_class_prep">前提条件</a>。<li>Web 端支持老师、学生和助教。</div>

## 示例项目

Agora 在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Community/CloudClass-Desktop)，演示了如何集成 Agora Classroom SDK 并调用 API 启动灵动课堂。你可以下载并查看源代码。

Agora 还提供一个 [CodePen 示例项目](https://codepen.io/agoratechwriter/pen/OJRrOxg)。你可以在该示例项目中设置参数并运行，即刻体验灵动课堂。

## 准备开发环境

- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。

## 集成 Agora Classroom SDK

选择如下任意一种方法获取 Agora Classroom SDK：

### 方法一：使用 npm 获取 SDK

使用该方法需要先安装 npm，详见 [npm 快速入门](https://www.npmjs.com.cn/getting-started/installing-node/)。

1. 运行安装命令：

   ```bash
   npm install agora-classroom-sdk
   ```

2. 在项目的 JavaScript 代码中引入 `AgoraEduSDK` 模块：

   ```javascript
   import {AgoraEduSDK} from 'agora-classroom-sdk'
   ```

### 方法二：使用 CDN 获取 SDK

你可以通过 CDN 获取 Agora Classroom SDK。在你的项目的 HTML 文件中，添加如下代码：
```
<script src="https://download.agora.io/edu-apaas/edu_sdk_1.1.0.js"></script>
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
| `roleType`               | EduRoleTypeEnum  | 用户在课堂中的角色，可设为：<li>`0`: 观众，仅用于页面录制。</li> <li>`1`: 老师</li><li>`2`: 学生</li><li>`3`: 助教。</li> |
| `roomType`               | EduRoomTypeEnum  | 课堂类型，可设为：<li>`0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。<li>`2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。<li>`4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可点名学生“上台”发言，与老师进行实时音视频互动。 |
| `listener`               | ListenerCallback | 课堂启动状态。                                               |
| `pretest`                | Boolean          | 是否开启课前设备检测：<li>`true`: 开启课前设备检测。开启后，在加入课堂前会弹出一个设备检测页面，测试终端用户的摄像头、麦克风和扬声器是否能正常工作。<li>`false`: 不开启课前设备检测。 |
| `language`               | LanguageEnum     | 界面语言：<li>`zh`: 中文<li>`en`: 英文                               |
| `startTime`              | Number           | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`               | Number           | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |
| `recordUrl` | String | （选填）待录制 URL 地址，开发者需传入自己部署的网页地址，用于页面录制，例如 `https://cn.bing.com/recordUrl`。 |
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

![](https://web-cdn.agora.io/docs-files/1620446413556)