本文详细介绍如何将灵动课堂集成到你自己的 Web 项目中。

## 技术原理

灵动课堂代码包含以下包：
```
├── packages
│   ├── agora-classroom-sdk  # 在线教育场景 SDK
│   │   ├── lib
│   │   │   └── externals  # 存放 RTC 相关插件如美颜/降噪
│   │   ├── src
│   │   │   ├── infra
│   │   │   │   ├── api  # SDK 入口
│   │   │   │   ├── capabilities  # UI 相关目录。
│   │   │   │   │   ├── containers  # UI 功能组件，与 UI Store 结合成为 UI 业务组件。
│   │   │   │   │   └── scenarios  # UI 场景。场景是由多个业务组件组合而成。
│   │   │   │   ├── configs  # 默认的颜色和主题配置
│   │   │   │   ├── stores  # UI Store 目录。UI Store 负责为 UI 组件提供业务逻辑封装。
│   │   │   └── ui-kit  # 通用 UI 组件
│   ├── agora-demo-app  # 灵动课堂demo app，提供在线课堂的课前、课中、课后等场景化代码示例
│   │   ├── electron  # electron 相关代码
│   │   ├── src
│   │   │   ├── api  # 和后台数据交互接口
│   │   │   ├── components  # 业务组件
│   │   │   ├── layout  # 业务布局
│   │   │   ├── pages  # 页面
│   │   │   ├── router  # 路由
│   │   │   ├── stores  # 公共数据
│   ├── agora-plugin-gallery  # 独立插件库，继承 AgoraWidgetBase 类并实现 AgoraWidgetLifecycle 接口，包含互动白板、IM 聊天、答题器、投票器、计时器等插件。
│   │   └── src
│   │       ├── common  # widget 公用逻辑，主要包含承载 widget 的 modal 组件
│   │       ├── components  # widget 通用 UI 组件
│   │       └── gallery
│   │           ├── answer  # 答题器 widget
│   │           ├── counter  # 计时器 widget
│   │           ├── hx-chat  # 聊天 widget
│   │           ├── im  # im通用能力的封装，为聊天 widget 提供统一接口
│   │           ├── stream-media  # 视频流播放器
│   │           ├── vote  # 投票 widget
│   │           ├── watermark  # 水印 widget
│   │           ├── webview  # webview widget，包含通用 webview 和 Youtube 同步播放器
│   │           └── whiteboard  # 白板 widget
│   ├── agora-proctor-sdk  # 在线监考场景 SDK
│   │   ├── src
│   │   │   ├── infra
│   │   │   │   ├── api  # SDK 入口
│   │   │   │   ├── capabilities
│   │   │   │   │   ├── components  # 通用 UI 组件
│   │   │   │   │   ├── containers  # UI 功能组件，与 UI Store 结合成为 UI 业务组件。
│   │   │   │   │   └── scenarios  # UI 场景。场景是由多个业务组件组合而成。
│   │   │   │   ├── stores  # UI Store 目录。UI Store 负责为 UI 组件提供业务逻辑封装。
│   ├── agora-common-libs  # 通用工具类库，包含 ThemeProvider、I18nProvider等 全局通用工具。
│   ├── agora-edu-core  # 提供灵动课堂中教育和监考场景的上行 API 调用和下行数据结构封装
│   ├── agora-rte-sdk  # 提供跨端 RTC 适配能力以及教室内事件回调与数据结构封装

```



## 集成教育场景下灵动课堂

灵动课堂 Web 端支持多种集成方式。根据是否需要自定义课堂 UI，你可选择不同的集成方式：

- 如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 或 CDN 集成。
- 如果你想要基于灵动课堂的默认 UI 进行修改，则可选择通过 [GitHub 源码](https://github.com/AgoraIO-Community/flexible-classroom-desktop)集成。

### 使用默认 UI 的方式集成

如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 npm 或 CDN 集成。

#### 使用 npm 集成

1. 在终端运行以下安装命令：

    ```
    npm install agora-classroom-sdk
    ```

2. 在项目的 JavaScript 代码中引入 `AgoraEduSDK` 模块：

    ```
    import {AgoraEduSDK} from 'agora-classroom-sdk'
    ```

3. 在项目的 JavaScript 代码中调用 [AgoraEduSDK.config](/cn/agora-class/agora_class_api_ref_web?platform=Web#config) 和 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 方法启动课堂。

<div class="alert note">灵动课堂依赖项 <code>agora-electron-sdk</code> 和 <code>agora-rdc-core</code> 包含原生 Node.js 模块，不建议使用 webpack 等构建工具二次编译，否则可能出现 Node.js 模块找不到的错误。建议在项目配置里将这两个库设置为外部依赖，例如添加 webpack 配置，参考以下示例：</div>

```
externals: {
'agora-electron-sdk': 'commonjs2 agora-electron-sdk',
'agora-rdc-core': 'commonjs2 agora-rdc-core',
}
```
#### 使用 CDN 集成

1. 在项目的 HTML 文件中添加以下代码：

    ```html
    <!-- 请把 X.Y.Z 替换为灵动课堂版本号，例如 2.8.20。
    你可以通过发版说明或 GitHub 仓库分支查看最新版本号。 -->
    <script src="https://download.agora.io/edu-apaas/release/edu_sdk@X.Y.Z.bundle.js"></script>
    ```

2. 在项目的 JavaScript 代码中调用 [AgoraEduSDK.config](/cn/agora-class/agora_class_api_ref_web?platform=Web#config) 和 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 方法启动课堂。


#### 示例代码

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- 2.8.20 为示例版本号，你可以通过发版说明或 GitHub 仓库分支查看最新版本号。 -->
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
        // 配置 SDK。
        // 把 Your App ID 替换为你的 App ID。
        AgoraEduSDK.config({
                appId: 'Your App ID',
                region: 'NA'
        });
        // 启动在线课堂。
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
            recordUrl: 'https://solutions-apaas.agora.io/apaas/record/dev/2.8.21/record_page.html',
            courseWareList: [],
            virtualBackgroundImages: [], // 虚拟背景图片资源列表
            webrtcExtensionBaseUrl: 'https://solutions-apaas.agora.io/static', // WebRTC 插件部署地址
            uiMode: 'light', // 设置课堂界面为明亮模式。如需界面为暗黑模式，设为 'dark' 即可。
            listener: (evt, args) => {
            },
        });
    </script>
</body>

</html>
```

示例代码中需要传入 `rtmToken`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 RTM Token，如何获取测试用途的临时 RTM Token，如何从服务器生成 RTM Token。
<div class="alert note">声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</div>

其他参数取值详见 [LaunchOption 说明](/cn/agora-class/agora_class_api_ref_web?platform=Web#launchoption)。

### 使用自定义 UI 的方式集成

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的 GitHub 源码：

<div class="alert info">开始前请确保你的设备上已准备好<a href="/cn/agora-class/agora_class_quickstart_web?platform=Web#dev-env">开发环境</a>。</div>

~f38d4cd0-3fce-11ed-8dae-bf25bf08a626~

3. 成功拉取代码后，根据你的实际需求，参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_web?platform=Web)修改代码。

4. 修改完代码后，按照以下步骤进行调试：

    1. 执行以下命令安装依赖库：

        ```bash
        yarn install
        ```

        ```bash
        yarn bootstrap
        ```

    2. 通过以下命令以开发模式运行项目。

       ```bash
       yarn dev
       ```

5. 完成开发后，通过以下命令打包 SDK JS 文件：

   ```bash
   yarn pack:classroom:sdk
   ```

<div class="alert info">打包完成的 JS 文件会输出至 <code>packages/agora-classroom-sdk/lib/edu_sdk.bundle.js</code>。</div>



## 集成监考场景下灵动课堂

灵动课堂 Web 端支持多种集成方式。根据是否需要修改课堂 UI，你可选择不同的集成方式：

- 如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 或 CDN 集成。
- 如果你想要基于灵动课堂的默认 UI 进行修改，则可选择通过 [GitHub 源码](https://github.com/AgoraIO-Community/flexible-classroom-desktop)集成。

### 使用默认 UI 的方式集成

如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 npm 或 CDN 集成。

#### 使用 npm 集成

1. 运行安装命令：

    ```
    npm install agora-proctor-sdk
    ```

2. 在项目的 JavaScript 代码中引入 `AgoraProctorSDK` 模块：

    ```
    import { AgoraProctorSDK } from 'agora-proctor-sdk'
    ```

3. 在项目的 JavaScript 代码中调用 [AgoraProctorSDK.config](/cn/agora-class/agora_class_proctor_api_web?platform=Web#config) 和 [AgoraProctorSDK.launch](/cn/agora-class/agora_class_proctor_api_web?platform=Web#launch) 方法启动课堂。

#### 使用 CDN 集成

1. 在项目的 HTML 文件中添加以下代码：

    ```html
    <!-- 请把 X.Y.Z 替换为灵动课堂版本号，例如 1.0.0。
    你可以通过发版说明或 GitHub 仓库分支查看最新版本号。 -->
    <script src="https://download.agora.io/edu-apaas/release/proctor_sdk@X.Y.Z.bundle.js"></script>
    ```

2. 在项目的 JavaScript 代码中调用 [AgoraProctorSDK.config](/cn/agora-class/agora_class_proctor_api_web?platform=Web#config) 和 [AgoraProctorSDK.launch](/cn/agora-class/agora_class_proctor_api_web?platform=Web#launch) 方法启动课堂。


#### 示例代码

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- 1.0.0 为示例版本号。
    你可以通过发版说明或 GitHub 仓库分支查看最新版本号。 -->
    <script src="https://download.agora.io/edu-apaas/release/proctor_sdk@1.0.0.bundle.js"></script>
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
        // 配置 SDK。
        // 把 Your App ID 替换为你的 App ID。
        AgoraProctorSDK.config({
                appId: 'Your App ID',
                region: 'NA'
        });
        // 启动在线监考。
        AgoraProctorSDK.launch(document.querySelector('#root'), {
            userUuid: 'user id',// 请参考下文描述填写 userUuid。
            userName: 'user name',
            roomUuid: 'room id',
            roleType: 1, // 用户角色：1 为老师，2 为学生。
            roomType: 6, // 房间类型：监考场景的房间类型固定为 6。
            roomName: 'room name',
            pretest: true, // 是否开启课前设备检测。
            rtmToken: 'rtm token', // 测试环境下，你可以使用临时 RTM Token；生产或安全环境下，强烈建议你使用服务器生成的 RTM Token。
            language: 'zh', // 课堂界面的语言。如需界面为英文，设为 'en' 即可。
            duration: 60 * 30, // 课程时间，单位为秒。
            courseWareList: [],
            listener: (evt, args) => {
            },
        });
    </script>
</body>

</html>
```

<a name="main-sub-device"></a>

示例代码中 `userUuid` 的填写方式：在线监考时，学生需要使用主、副设备接入考试。比如，主设备为 Web 端，用于采集学生视频，并分享学生答题时的屏幕画面；副设备为 Android 或 iOS 设备，用于拍摄学生答题的身姿。监考老师通过三种视角的视频观察学生答题，防止作弊。你需要在不同设备上以 `${用户id}-${设备类型（main/sub）}` 的规则填写 `userUuid`。比如，对学生小明，在 Web 端集成代码 `AgoraProctorSDK.launch` 方法的 `userUuid` 参数中传入 `'xiaoming-main'`，在 Android 或 iOS 端对应的 `userUuid` 参数中传入 `'xiaoming-sub'`。灵动课堂会将 `xiaoming-main` 和 `xiaoming-sub` 识别为用户小明的主、副设备，然后合并主、副设备的视频画面，最终将合并后的视频画面渲染在老师的监考视频窗口中。

示例代码中 `rtmToken` 的填写方式：你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 RTM Token，如何获取测试用途的临时 RTM Token，如何从服务器生成 RTM Token。
<div class="alert note">声网提供的客户端临时 Token 生成器仅适用于运行 app 模块快速测试。在正式环境中，为确保安全，你必须参考<a href="/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms">使用 Token 鉴权文档</a>，在服务端部署并生成 Token。生成的 token 传入的 <code>userId</code> 需要和 <code>launch</code> 方法中传入的参数 <code>userUuid</code> 保持一致，否则生成的 token 无效。</div>


### 使用自定义 UI 的方式集成

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的 GitHub 源码：

<div class="alert info">开始前请确保你的设备上已准备好<a href="/cn/agora-class/agora_class_quickstart_web?platform=Web#dev-env">开发环境</a>。</div>

~f38d4cd0-3fce-11ed-8dae-bf25bf08a626~

3. 成功拉取代码后，根据你的实际需求，参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_web?platform=Web)修改代码。

4. 修改完代码后，按照以下步骤进行调试：

    1. 执行以下命令安装依赖库：

        ```bash
        yarn install
        ```

        ```bash
        yarn bootstrap
        ```

    2. 通过以下命令以开发模式运行项目。

       ```bash
       yarn dev
       ```

5. 完成开发后，通过以下命令打包 SDK JS 文件：

   ```bash
   yarn pack:proctor:sdk
   ```

<div class="alert info">打包完成的 JS 文件会输出至 <code>packages/agora-proctor-sdk/lib/proctor_sdk.bundle.js</code>。</div>

### 设置考卷链接

在线考试开始后，考生会在本地通过 `Widget` 创建的 Webview 窗口加载考卷。考卷的链接通过房间属性（`roomProperties`）中的 `examinationUrl` 字段设置。你可以参考如下方式设置考卷链接：

- 在创建考试房间时设置考卷：调用灵动课堂 RESTful API 的[创建课堂](/cn/agora-class/agora_class_restful_api?platform=Web#创建课堂)接口创建课堂，并在请求包体的 `roomProperties` 字段中设置 `examinationUrl` 字段。

    ```json
    {
        "roomName": "jasoncai61734",
        "roomType": 4,
        "roomProperties": {
            "schedule": {
                "startTime": 1655452800000,
                "duration": 600,
                "closeDelay": 0
            },
            // 设置本场考试的考卷链接
            "examinationUrl": "your examination url"
        }
    }
    ```
- 创建考试房间后设置考卷：创建房间后，调用灵动课堂 RESTful API 的[更新课堂属性](/cn/agora-class/agora_class_restful_api?platform=Web#更新课堂属性)接口，并在请求包体的 `roomProperties` 字段中设置 `examinationUrl` 字段。

    ```json
    {
        "properties": {
             // 设置本场考试的考卷链接
            "examinationUrl": "your examination url"
        },
        "cause": {}
    }
    ```
