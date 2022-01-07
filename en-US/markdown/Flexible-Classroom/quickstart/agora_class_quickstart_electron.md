This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/cn/agora-class/agora_class_enable?platform=Electron" target="_blank">enable the Flexible Classroom service</a>.
- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- Physical media input devices, such as a built-in camera and a built-in microphone.
- 安装 [Node.js 和 npm](https://www.npmjs.com/)。
- 安装 [yarn](https://yarnpkg.com/)。

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the [CloudClass-Androidhttps](://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. 你可在 <a href="/cn/agora-class/release_agora_class_web?platform=Web">发版说明</a>中获取最新版本号。</div>

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

3. 参考以下步骤分别在 macOS 或 Windows 设备上运行项目：

   **macOS**

   1. Run the following command in the root folder to install dependencies.

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

      ![](https://web-cdn.agora.io/docs-files/1624525158077)

   **Windows**

   1. Run the following command in the root folder to install dependencies.

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

      ![](https://web-cdn.agora.io/docs-files/1624525158077)

## Next steps

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_web?platform=Electron)。