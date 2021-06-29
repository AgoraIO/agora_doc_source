根据本文指导在你的 Web 项目中快速集成 Agora Classroom SDK 并调用 API 启动灵动课堂。

## 技术原理

下图展示了加入一个 Agora 灵动课堂的基本流程。



当你的 app 客户端请求加入灵动课堂时：

1. 你的 app 客户端向 app 服务端申请 RTM Token。
2. 你的 app 服务端使用 Agora App ID、App 证书和用户 ID 生成一个 RTM Token，返回给 app 客户端。详见[生成 RTM Token](/cn/Real-time-Messaging/token_server_rtm)。
3. 你的 app 客户端调用 SDK 的方法并传入以下参数加入一个灵动课堂。
   - 用户 ID：
   - 课堂 ID：
   - RTM Token：

## 前提条件

- 在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- 灵动课堂使用 RTM Token 进行鉴权。在测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你获取到的 App ID 和 App 证书，然后自行填入一个用户 ID，快速生成一个临时 RTM Token，有效期为 24 小时。
- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- 物理音视频采集设备，如内置摄像头和麦克风。
- 安装 [Node.js 和 npm](https://www.npmjs.com/)
- 安装 [yarn](https://yarnpkg.com/)

## 启动灵动课堂

参考以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂 Web 项目克隆至本地：

   ```shell
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

2. 运行以下命令安装项目依赖：

   ```shell
   # Install global dev dependencies
   yarn
   # Install all dependencies via lerna and yarn
   yarn bootstrap
   ```

3. 在 `pacakges/agora-apaas-demo/src/components/app/index.js` 中填写你获取到的 Agora App ID 和临时 RTM Token。请确保你在 `launch` 方法中传的 `userUuid` 和你在生成临时 RTM Token 时使用的用户 ID 保持一致。

   ```js
   AgoraEduSDK.config({
       /** 填写你的 App ID */
       appId: "<YOUR APPID>",
       })
   AgoraEduSDK.launch(
       document.querySelector(`#${this.elem.id}`), {
           /** 填写你的 RTM Token */
           rtmToken: "<YOUR RTM TOKEN>",
           /** 确保此处的 userUuid 和你生成临时 RTM Token 时使用的用户 ID 一致。*/
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
   ```

   > 查看 API 参考：
   >
   > - [`AgoraEduSDK.config` ]()
   > - [`AgoraEduSDK.launch`]()

4. 运行以下命令编译灵动课堂：

   ```shell
   # start dev server
   yarn run:apaas
   ```

5. 编译完成后，在浏览器中打开 localhost:9000，即可进入灵动课堂，看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1620446413556)

## 更多信息

- 你可选择以下任意一种方法将 Agora Classroom SDK 集成到你自己的 Web 项目中：

  - 使用 npm 集成 SDK：

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
    <script src="https://download.agora.io/edu-apaas/edu_sdk_1.1.2.js"></script>
    ```