本文详细介绍如何将灵动课堂集成到你自己的 Web/Electron 项目中。

## 技术原理

灵动课堂代码包含以下模块：

- `agora-classroom-sdk`: Agora Classroom SDK，包含以下模块：
   - `infra/stores`: UI Store 目录，负责为 UI 组件提供业务逻辑封装。
   - `ui-kit/capabilities`:
      - `containers`: 业务组件目录，UI 组件与 UI Store 结合成为业务组件。
      - `scenarios`: 各个班型场景目录。
- `agora-chat-widget`: 环信聊天组件。
- `agora-plugin-gallery`: ExtApp 插件库，包含屏幕共享、答题器、计时器、投票器等插件。
- `agora-scenario-ui-kit`: UI 组件库。
- `agora-widget-gallery`: Widget 插件库，包含通过 Agora RTM SDK 实现的聊天插件和通过环信 IM SDK 实现的聊天插件。

## 集成方式

根据你的实际需求选择以下任意一种集成方式。

<a name="default_ui"></a>

### 使用灵动课堂的默认 UI

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择以下任意一种方法将完整的灵动课堂集成到你自己的项目中：

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
  <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.0.1.bundle.js"></script>
  ```

<a name="change_default_ui"></a>

### 修改灵动课堂的默认 UI

如果你想要基于灵动课堂的默认 UI 进行修改，则参考以下步骤集成灵动课堂的源码：

1. 运行以下命令将 CloudClass-Desktop 克隆至本地，并切换至最新发版分支。

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

   ```
   git checkout release/apaas/x.y.z
	```

   <div class="alert info">x.y.z 请替换为版本号。你可在<a href="/cn/agora-class/release_agora_class_web?platform=Web">发版说明</a>中获取最新版本号。</div>

2. 成功拉取代码后，你可根据自己的需求修改课堂 UI，然后通过以下命令进行调试。

   - Web 项目：`yarn dev`
   - Electron 项目：`yarn dev:electron`

3. 完成开发后，可通过以下命令打包 SDK 或应用：

   - 打包 Classroom SDK：`yarn pack:classroom:sdk`
   - 打包 Electron Mac 客户端：`yarn pack:electron:mac`
   - 打包 Electron Windows 客户端：执行命令 `yarn pack:electron:win`