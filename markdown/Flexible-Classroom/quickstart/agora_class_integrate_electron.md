本文详细介绍如何将灵动课堂集成到你自己的 Electron 项目中。

## 集成方式

灵动课堂 Electron 端支持多种集成方式。根据是否需要修改课堂 UI，你可选择不同的集成方式：

- 如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 CDN 集成。
- 如果你想要基于灵动课堂的默认 UI 进行修改，则可选择通过 [GitHub 源码](https://github.com/AgoraIO-Community/flexible-classroom-desktop)集成。

<a name="default_ui"></a>

### 使用灵动课堂的默认 UI

如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 CDN 集成。这种方式需要你已有一个 Electron 项目，使用的 Electron 版本不低于 12.0.0。

1. 在 Electron 入口文件中添加以下代码：

   ```javascript
   // 引入 electron 模块
   const electron = require('electron');
   // 禁止复用渲染进程
   app.allowRendererProcessReuse = false;
   ```

2. 创建  `BrowserWindow`  对象时传入以下参数：

   ```javascript
   mainWindow = new BrowserWindow({
     ...
     webPreferences: {
       ...
       autoplayPolicy: "no-user-gesture-required",
       nodeIntegration: true,
       contextIsolation: false,
       webSecurity: false,
       webviewTag: true,
       enableRemoteModule: true,
       nativeWindowOpen: true,
       backgroundThrottling: false
     }
   });
   ```

3. 在 `package.json` 文件中增加以下依赖和配置：

   ```json
   "agora_electron": {
     "electron_version": "12.0.0",
     "prebuilt": true
   },
   "dependencies": {
     ...
     "agora-electron-sdk": "3.6.1-rc.9-build.817",
   }
   ```

4. 在 HTML 文件中引入声网 Classroom SDK 并启动灵动课堂：

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1" />
       <!-- 灵动课堂教育场景 -->
       <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.8.20.bundle.js"></script>
   </head>

   <body>
       <style>
           #root {
               width: 100%;
               height: 100%;
           }
       </style>
       <div id="root"></div>
       <script type="text/javascript">
           AgoraEduSDK.config({
                appId: 'Your App ID',
                region: 'NA'
           });
           AgoraEduSDK.launch(document.querySelector('#root'), {
               userUuid: 'user id',
               userName: 'user name',
               roomUuid: 'room id',
               roleType: 1, // 用户角色：1 为老师，2 为学生。
               roomType: 0, // 房间类型：0 为一对一，2 为大班课，4 为小班课。
               roomName: 'room name',
               pretest: true, // 是否开启课前设备检测。
               rtmToken: 'rtm token', // 测试环境下，你可以使用临时 RTM Token；生产或安全环境下，强烈建议你使用服务器生成的 RTM Token。
               language: 'zh', // 课堂界面的语言。如需界面为英文，设为 'en' 即可。
               duration: 60 * 30, // 课程时间，单位为秒。
               recordUrl: 'https://solutions-apaas.agora.io/apaas/record/dev/2.3.3/record_page.html',
               courseWareList: [],
               uiMode: 'light', // 设置课堂界面为明亮模式。如需界面为暗黑模式，设为 'dark' 即可。
               listener: (evt, args) => {
               },
           }).then(() => {
               console.log('start launch');
           }).catch((e) => {
               console.error('fail to launch', e);
           });
       </script>
   </body>
   </html>
   ```

   示例代码中需要传入 `rtmToken`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 RTM Token，如何获取测试用途的临时 RTM Token，如何从服务器生成 RTM Token。
   <div class="alert note">声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</div>

<a name="change_default_ui"></a>

### 修改灵动课堂的默认 UI

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的 GitHub 源码：

<div class="alert info">开始前请确保你的设备上已准备好<a href="/cn/agora-class/agora_class_quickstart_electron?platform=Electron#dev-env">开发环境</a>。</div>

~f38d4cd0-3fce-11ed-8dae-bf25bf08a626~

3. 执行以下命令复制一个环境变量配置文件：

    ```bash
    cp .env.example packages/agora-classroom-sdk/.env
    ```

4. 成功拉取代码后，根据你的实际需求，参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_web?platform=Electron)修改代码。

5. 修改完代码后，按照以下步骤进行调试：

    1. 执行以下命令安装依赖库：

        ```bash
        yarn install
        ```

        ```bash
        yarn bootstrap
        ```

    2. 通过以下命令以开发模式运行项目：

        ```bash
        yarn dev:electron
        ```

6. 完成开发后，通过以下命令打包 SDK 或应用：

   - 打包 Electron macOS 客户端：

     ```bash
     yarn build:demo
     yarn pack:electron:mac
     ```

   - 打包 Electron Windows 客户端：

     ```bash
     yarn build:demo
     yarn pack:electron:win
     ```

