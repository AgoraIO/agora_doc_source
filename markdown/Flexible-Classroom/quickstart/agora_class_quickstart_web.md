根据本文指导在你的 Web 项目中快速集成 Agora Classroom SDK 并调用 API 启动灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>
## 前提条件

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- 灵动课堂使用 RTM Token 进行鉴权。在测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你获取到的 App ID 和 App 证书，然后自行填入一个用户 ID，快速生成一个临时 RTM Token，有效期为 24 小时。
- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。
- 安装 [Node.js 和 npm](https://www.npmjs.com/)
- 安装 [yarn](https://yarnpkg.com/)

## 启动灵动课堂

参考以下步骤启动灵动课堂：

### 1. 创建 Web 项目

参考以下步骤创建 Web 项目：

1. 在本地创建一个名为 `agora_flexible_classroom` 的文件夹。
2. 在 `agora_flexible_classroom` 文件夹内创建一个 `index.html` 文件。

### 2. 实现 app 业务逻辑

在你的 Web 项目里启动灵动课堂，需进行以下步骤：

1. 通过 CDN 链接将 Agora Classroom SDK 集成到你的项目中。
2. 调用 [AgoraEduSDK.config](/cn/agora-class/agora_class_api_ref_web?platform=Web#config) 方法全局配置 SDK。
3. 调用 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 方法启动灵动课堂。

你可以将以下代码复制到 `index.html` 文件，实现以上 API 的调用逻辑。复制时需要将 `launch` 方法中传的 `appID`  和 `rtmToken  ` 分别替换为[你的 App ID 和临时 RTM Token](#prerequisites)，并确保 `userUuid` 和你在生成临时 RTM Token 时使用的用户 ID 保持一致。

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AgoraFlexibleClassroomDemo</title>
  <!-- 此处集成 Agora Classroom SDK -->
  <script src="https://download.agora.io/edu-apaas/release/edu_sdk_1.1.2.3.js"></script>
</head>

<body>
  <style>
    #root1 {
      width: 100%;
      height: 100%;
    }
  </style>
  <div id="root1"></div>
  <script type="text/javascript">
    AgoraEduSDK.config({
      // 此处替换成你的 App ID
      appId: "<your_app_id>",
    })
    AgoraEduSDK.launch(
      document.querySelector("#root1"), {
        // 此处替换成你的 RTM Token
        rtmToken: "<your_rtm_token>",
        // 请确保此次的用户 ID 和你在生成临时 RTM Token 时使用的用户 ID 保持一致
        userUuid: "<your_user_id>",
        userName: "teacher",
        roomUuid: "321",
        roomName: "demo-class",
        roleType: 1,
        roomType: 0,
        pretest: true,
        language: "en",
        startTime: new Date().getTime(),
        duration: 60 * 30,
        courseWareList: [],
        listener: (evt) => {
          console.log("evt", evt)
        }
      }
    )
  </script>
</body>
</html>
```

## 运行 Web 项目

在浏览器中打开 `index.html` 文件，你可以看到以下页面：

![](https://web-cdn.agora.io/docs-files/1621308595366)

## 后续步骤

如果 Agora Classroom SDK 中默认的用户界面无法满足你的需求，你可以参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_web?platform=Web)，获取 Agora Classroom SDK 的源码，自行开发、调试和编译。

## 更多信息

<a name="sdk"></a>
### 集成 Agora Classroom SDK

你可选择以下任意一种方法将 Agora Classroom SDK 集成到你自己的 Web 项目中：

- 使用 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 集成 SDK：

  1. 运行安装命令：

     ```
     npm install agora-classroom-sdk
     ```

  2. 在项目的 JavaScript 代码中引入 `AgoraEduSDK` 模块：

     ```
     import {AgoraEduSDK} from 'agora-classroom-sdk'
     ```

- 使用 CDN 获取 SDK。在你的项目的 HTML 文件中，添加以下代码：

  ```html
  <script src="https://download.agora.io/edu-apaas/release/edu_sdk_1.1.5.js"></script>
  ```