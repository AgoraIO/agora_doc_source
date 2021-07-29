根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## 技术原理

下图展示了启动灵动课堂的基本流程。

![](https://web-cdn.agora.io/docs-files/1626925692656)

当你的 app 客户端请求加入灵动课堂时：

1. 你的 app 客户端向 app 服务端申请 RTM Token。
2. 你的 app 服务端使用 Agora App ID、App 证书和用户 ID 生成一个 RTM Token，返回给 app 客户端。详见[生成 RTM Token](/cn/Real-time-Messaging/token_server_rtm)。
3. 你的 app 客户端调用 API 并传入用户 ID、房间 ID 和 RTM Token 启动灵动课堂。灵动课堂云服务会根据你传入的房间 ID 为该课题自动创建一个房间。

<a name="prerequisites"></a>

## 前提条件

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- 灵动课堂使用 RTM Token 进行鉴权。在测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你获取到的 App ID 和 App 证书，然后自行填入一个用户 ID，快速生成一个临时 RTM Token，有效期为 24 小时。
- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。
- 安装 [Node.js 和 npm](https://www.npmjs.com/)
- 安装 [yarn](https://yarnpkg.com/)

## 启动灵动课堂

参照以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂项目 CloudClass-Desktop 克隆至本地：

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

2. 将 `packages/agora-electron-edu-demo/src/renderer/components/app/index.js` 文件中的 `<Your Agora App ID>` 和 `<YOUR RTM TOKEN>` 替换成[你的 App ID 和 RTM Token](#prerequisites)。

   ```javascript
   import { AgoraEduSDK } from 'agora-classroom-sdk'
   
   export default class App {
     constructor(elem) {
       if (!elem) return
       this.elem = elem
     }
   
     setupClassroom() {
       AgoraEduSDK.config({
         appId: "<YOUR APPID>",
       })
       AgoraEduSDK.launch(
         document.querySelector(`#${this.elem.id}`), {
           rtmToken: "<YOUR RTM TOKEN>",
           userUuid: "test",
           userName: "teacher",
           roomUuid: "4321",
           roleType: 1,
           roomType: 0,
           roomName: "demo-class",
           pretest: false,
           language: "en",
           startTime: new Date().getTime(),
           duration: 60 * 30,
           courseWareList: [],
           listener: (evt) => {
             console.log("evt", evt)
           }
         }
       )
     }
   }
   ```

    以上代码实现了以下 API 的调用逻辑：

   1. 调用 [AgoraEduSDK.config]() 方法全局配置 SDK。
   2. 调用 [AgoraEduSDK.launch]() 方法启动灵动课堂。

3. 参考以下步骤分别在 macOS 或 Windows 设备上运行项目：

   **macOS**

   1. 在项目根目录下运行以下命令安装项目依赖：

      ```bash
      # Install global dev dependencies
      yarn
      # Install all dependencies via lerna and yarn
      yarn bootstrap
      ```

   2. 在 `packages/agora-electron-edu-demo` 目录下运行以下命令编译项目：

      ```
      npm run dev
      ```

      编译成功后，你可以看到以下页面：

      ![](https://web-cdn.agora.io/docs-files/1623404345070)

   **Windows**

   1. 在项目根目录下运行以下命令安装项目依赖：

      ```bash
      # Install global dev dependencies
      yarn
      # Install all dependencies via lerna and yarn
      yarn bootstrap
      ```

   2. 将 `packages/agora-electron-edu-demo/package.json` 文件中的 `"agora_electron"` 对象替换成以下内容：

      ```json
      "agora_electron": {
        "electron_version": "7.1.2",
        "prebuilt": true,
        "platform": "win32",
        "arch": "ia32"
      },
      ```

   3. 运行以下命令安装 electron 7.1.14：

      ```bash
      npm install electron@7.1.14 --arch=ia32 --save-dev
      ```

   4. 在 `packages/agora-electron-edu-demo` 目录下运行以下命令编译项目：

      ```bash
      npm run dev
      ```

      编译成功后，你可以看到以下页面：

      ![](https://web-cdn.agora.io/docs-files/1623404345070)

## 后续步骤

如果 Agora Classroom SDK 中默认的用户界面无法满足你的需求，你可以参考[自定义课堂 UI 文档]()，获取 Agora Classroom SDK 的源码，自行开发、调试和编译。
