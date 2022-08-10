本文详细介绍如何将灵动课堂集成到你自己的 Electron 项目中。

## 集成方式

灵动课堂 Electron 端支持以下三种集成方式：

-   通过 CDN 集成
-   通过下载 [GitHub 源码](https://github.com/AgoraIO-Community/CloudClass-Desktop)集成

根据是否需要修改课堂 UI，你可选择不同的集成方式。

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
     "agora-electron-sdk": "3.5.1-build.1116",
   }
   ```

4. 在 HTML 文件中引入 Agora Classroom SDK 并启动灵动课堂：

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1" />
       <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.6.1.bundle.js"></script>
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
           AgoraEduSDK.config({ appId: 'Your App ID' });
           AgoraEduSDK.launch(document.querySelector('#root'), {
               userUuid: 'user id',
               userName: 'user name',
               roomUuid: 'room id',
               roleType: 1, // 用户角色：1 为老师，2 为学生。
               roomType: 0, // 房间类型：0 为一对一，2 为大班课，4 为小班课。
               roomName: 'room name',
               pretest: true, // 是否开启课前设备检测。
               rtmToken: 'rtm token',
               language: 'zh', // 界面语言。
               duration: 60 * 30, // 课程时间，单位为秒。
               recordUrl: 'https://solutions-apaas.agora.io/apaas/record/dev/2.3.3/record_page.html',
               courseWareList: [],
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

<a name="change_default_ui"></a>

### 修改灵动课堂的默认 UI

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的 GitHub 源码：

<div class="alert info">开始前请确保你的设备上已准备好<a href="/cn/agora-class/agora_class_quickstart_electron?platform=Electron#dev-env">开发环境</a>。</div>

1. 运行以下命令将 CloudClass-Desktop 克隆至本地。

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
    ```

    ```bash
    cd CloudClass-Desktop
    ```

2. 运行以下命令切换分支至指定版本，将 {VERSION} 替换为要切换的版本号：

    ```bash
    git checkout release/{VERSION}
    ```

    例如要切换到 2.6.0 版本分支，执行以下命令：

    ```bash
    git checkout release/2.6.0
    ```

    声网建议你切换到最新发版分支。参考下图在 GitHub 仓库中查看最新发版分支：

    ![](https://web-cdn.agora.io/docs-files/1658916187924)

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

     