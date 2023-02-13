本文详细介绍如何将灵动课堂集成到你自己的 Web 项目中。

## 技术原理

灵动课堂代码包含以下包：

-   `agora-demo-app`: 灵动课堂 Demo App，支持 Web，H5，Electron 等平台，支持在线课堂、在线监考功能，提供在线课堂的课前、课中、课后等多个环节的代码示例。
-   `agora-classroom-sdk`: 灵动课堂教育场景 SDK，包含以下模块：
    -   `/src/infra/stores`: UI Store 目录。UI Store 负责为 UI 组件提供业务逻辑封装。
    -   `/src/infra/capabilities`:
        -   `/containers`: UI 业务组件目录。UI 功能组件与 UI Store 结合成为 UI 业务组件。
        -   `/scenarios`: 场景目录。场景是由多个业务组件组合而成。
-   `agora-proctor-sdk`: 灵动课堂监考场景 SDK，包含以下模块：
    -   `/src/infra/stores`: UI Store 目录。UI Store 负责为 UI 组件提供业务逻辑封装。
    -   `/src/infra/capabilities`:
        -   `/containers`: UI 业务组件目录。UI 功能组件与 UI Store 结合成为 UI 业务组件。
        -   `/scenarios`: 场景目录。场景是由多个业务组件组合而成。
-   `agora-plugin-gallery`: 灵动课堂独立插件库，继承 `AgoraWidgetBase` 类并实现 `AgoraWidgetLifecycle` 接口，包含互动白板、IM 聊天、答题器、投票器、计时器等插件。


## 集成灵动课堂教育场景

灵动课堂 Web 端支持多种集成方式。根据是否需要修改课堂 UI，你可选择不同的集成方式：

- 如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 或 CDN 集成。
- 如果你想要基于灵动课堂的默认 UI 进行修改，则可选择通过 [GitHub 源码](https://github.com/AgoraIO-Community/flexible-classroom-desktop)集成。

<a name="default_ui"></a>

### 使用默认 UI 的方式集成

如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 npm 或 CDN 集成。

#### 使用 npm 集成

1. 运行安装命令：

    ```
    npm install agora-classroom-sdk
    ```

2. 在项目的 JavaScript 代码中引入 `AgoraEduSDK` 模块：

    ```
    import {AgoraEduSDK} from 'agora-classroom-sdk'
    ```

3. 在项目的 JavaScript 代码中调用 [AgoraEduSDK.config](/cn/agora-class/agora_class_api_ref_web?platform=Web#config) 和 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 方法启动课堂。

#### 使用 CDN 集成

1. 在项目的 HTML 文件中添加以下代码：

    ```html
    <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.8.0.bundle.js"></script>
    ```

2. 在项目的 JavaScript 代码中调用 [AgoraEduSDK.config](/cn/agora-class/agora_class_api_ref_web?platform=Web#config) 和 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_web?platform=Web#launch) 方法启动课堂。


#### 示例代码

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.8.0.bundle.js"></script>
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
        // 填入你的 App ID。
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
            recordUrl: 'https://solutions-apaas.agora.io/apaas/record/dev/2.8.0/record_page.html',
            courseWareList: [],
            virtualBackgroundImages: [], // 虚拟背景图片资源列表。
            webrtcExtensionBaseUrl: 'https://solutions-apaas.agora.io/static', // WebRTC 插件部署地址。
            uiMode: FcrMultiThemeMode.light, // 设置课堂界面为明亮模式。如需界面为暗黑模式，设为 FcrMultiThemeMode.dark 即可。
            listener: (evt, args) => {
            },
        });
    </script>
</body>

</html>
```

示例代码中需要传入 `rtmToken`。你可以参考[获取 RTM Token](/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-rtm-token) 了解什么是 RTM Token，如何获取测试用途的临时 RTM Token，如何从服务器生成 RTM Token。

其他参数取值详见 [LaunchOption 说明](/cn/agora-class/agora_class_api_ref_web?platform=Web#launchoption)。


<a name="change_default_ui"></a>

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



## 集成灵动课堂监考场景

灵动课堂 Web 端支持多种集成方式。根据是否需要修改课堂 UI，你可选择不同的集成方式：

- 如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 或 CDN 集成。
- 如果你想要基于灵动课堂的默认 UI 进行修改，则可选择通过 [GitHub 源码](https://github.com/AgoraIO-Community/flexible-classroom-desktop)集成。


<a name="default_ui_proctor"></a>

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
    <script src="https://download.agora.io/edu-apaas/release/proctor_sdk@1.0.0.bundle.js"></script>
    ```

2. 在项目的 JavaScript 代码中调用 [AgoraProctorSDK.config](/cn/agora-class/agora_class_proctor_api_web?platform=Web#config) 和 [AgoraProctorSDK.launch](/cn/agora-class/agora_class_proctor_api_web?platform=Web#launch) 方法启动课堂。


#### 示例代码

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
        // 填入你的 App ID。
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


<a name="change_default_ui_proctor"></a>

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

- 在创建考试房间时设置考卷：调用灵动课堂云服务 RESTful API 的[创建房间](/cn/agora-class/agora_class_restful_api?platform=Web#创建房间)接口创建房间，并在请求包体的 `roomProperties` 字段中设置 `examinationUrl` 字段。

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
- 创建考试房间后设置考卷：创建房间后，调用灵动课堂云服务 RESTful API 的[更新课堂属性](/cn/agora-class/agora_class_restful_api?platform=Web#更新课堂属性)接口，并在请求包体的 `roomProperties` 字段中设置 `examinationUrl` 字段。

    ```json
    {
        "properties": {
             // 设置本场考试的考卷链接
            "examinationUrl": "your examination url"
        },
        "cause": {}
    }
    ```
