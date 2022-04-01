本文详细介绍如何将灵动课堂集成到你自己的 Web/Electron 项目中。

## 技术原理

灵动课堂代码包含以下模块：

-   `agora-classroom-sdk`: Agora Classroom SDK，包含以下模块：
    -   `infra/stores`: UI Store 目录，负责为 UI 组件提供业务逻辑封装。
    -   `ui-kit/capabilities`:
        -   `containers`: 业务组件目录，UI 组件与 UI Store 结合成为业务组件。
        -   `scenarios`: 各个班型场景目录。
-   `agora-chat-widget`: 通过环信 IM SDK 实现的聊天组件。
-   `agora-plugin-gallery`: ExtApp 插件库，包含屏幕共享、答题器、计时器、投票器等插件。
-   `agora-scenario-ui-kit`: UI 组件库。
-   `agora-widget-gallery`: Widget 插件库，包含通过 Agora RTM SDK 实现的聊天插件和通过环信 IM SDK 实现的聊天插件。

## 集成方式

灵动课堂 Web/Electron 端支持以下三种集成方式：

-   通过 CDN 集成
-   通过 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 集成
-   通过下载 [GitHub 源码](https://github.com/AgoraIO-Community/CloudClass-Desktop)集成

根据是否需要修改课堂 UI，你可选择不同的集成方式。

<a name="default_ui"></a>

### 使用灵动课堂的默认 UI

如果你直接使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择 npm 或 CDN 集成：

#### 使用 npm 集成

1. 运行安装命令：

    ```
    npm install agora-classroom-sdk
    ```

2. 在项目的 JavaScript 代码中引入 `AgoraEduSDK` 模块：

    ```
    import {AgoraEduSDK} from 'agora-classroom-sdk'
    ```

#### 使用 CDN 集成

1. 在你的项目的 HTML 文件中添加以下代码：

    ```html
    <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.1.1.bundle.js"></script>
    ```

2. 在你的项目的 .js 文件中添加以下代码：

    ```javascript
    window.AgoraEduSDK.config({
        appId: "<your_app_id>",
        region: "CN",
    });

    window.AgoraEduSDK.launch(dom, {
        ...launchOption,
        listener: (evt: AgoraEduClassroomEvent, type) => {},
    });
    ```

    参数说明：

    - `config`: SDK 全局配置，支持的参数详见 [ConfigParams](/cn/agora-class/agora_class_api_ref_web?platform=Web#configparams)
    - `dom`: 待渲染的浏览器的根结点。
    - `launchOption` 为课堂启动配置，支持的参数详见 [LaunchOption](/cn/agora-class/agora_class_api_ref_web?platform=Web#launchoption)。

<a name="change_default_ui"></a>

### 修改灵动课堂的默认 UI

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的 GitHub 源码：

<div class="alert info">开始前请确保你的设备上已准备好<a href="/cn/agora-class/agora_class_quickstart_web?platform=Web#dev-env">开发环境</a>。</div>

1. 运行以下命令将 CloudClass-Desktop 克隆至本地。

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
    ```

1. 进入项目目录后，切换至最新发版分支。

    ```
    git checkout release/apaas/x.y.z
    ```

    <div class="alert info">x.y.z 请替换为版本号。你可在<a href="/cn/agora-class/release_agora_class_web?platform=Web">发版说明</a>中获取最新版本号。</div>

1. 成功拉取代码后，你可根据自己的需求修改课堂 UI，然后参考以下步骤进行调试：

    1. 执行以下命令安装依赖库：

        ```
        yarn install
        ```

        ```
        yarn bootstrap
        ```

    2. 通过以下命令以开发模式运行项目。

        - 启动 Web 开发模式：`yarn dev`
        - 启动 Electron 开发模式：`yarn dev:electron`

    3. 完成开发后，通过以下命令打包 SDK 或应用：

        - 打包 SDK JS 文件：`yarn pack:classroom:sdk`

            <div class="alert info">打包完成的 JS 文件会输出至 <code>packages/agora-classroom-sdk/lib/edu_sdk.bundle.js</code>。</div>

        - 打包 Electron macOS 客户端：`yarn pack:electron:mac`
        - 打包 Electron Windows 客户端：`yarn pack:electron:win`
