This page introduces how to add Flexible Classroom into your iOS app.

## Understand the tech

灵动课堂代码包含以下模块：

- `agora-classroom-sdk`: Agora Classroom SDK，包含以下模块：
   - `infra/stores`: UI Store 目录，负责为 UI 组件提供业务逻辑封装。
   - `ui-kit/capabilities`:
      - `containers`: 业务组件目录，UI 组件与 UI Store 结合成为业务组件。
      - `scenarios`: 各个班型场景目录。
- `agora-chat-widget`: 环信聊天组件。
- `agora-plugin-gallery`: ExtApp 插件库，包含屏幕共享、答题器、计时器、投票器等插件。
- `agora-scenario-ui-kit`: UI 组件库。
- `agora-widget-gallery`: Widget 插件库，包含 RTM 聊天和环信聊天两部分。

## 集成方式

根据你的实际需求选择以下任意一种集成方式。

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

如果你使用灵动课堂的默认 UI，无需修改灵动课堂的代码，则可选择以下任意一种方法将完整的 Agora Classroom SDK 集成到你自己的项目中：

- 使用 [npm](https://www.npmjs.com/package/agora-classroom-sdk) 集成 SDK：

   1. Run the following command to install the SDK.

      ```
      npm install agora-classroom-sdk
      ```

   2. To import the AgoraEduSDK module, add the following code to the Javascript`` code in your project.

      ```
      import {AgoraEduSDK} from 'agora-classroom-sdk'
      ```

- 使用 CDN 获取 SDK。 Add the following code to the line before <style> in your project.

   ```html
   <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.0.1.bundle.js"></script>
   ```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. 运行以下命令将 CloudClass-Desktop 克隆至本地，并切换至最新发版分支。

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">x.y.z 请替换为版本号。 你可在<a href="/cn/agora-class/release_agora_class_web?platform=Web">发版说明</a>中获取最新版本号。</div>

2. 成功拉取代码后，你可根据自己的需求修改课堂 UI，然后通过以下命令进行调试。

   - Web 环境运行 `yarn dev` 命令
   - Electron 环境运行 `yarn dev:electron` 命令

3. 完成开发后，可通过以下命令打包 SDK 或应用：

   - 打包 Classroom SDK：`yarn pack:classroom:sdk`
   - 打包 Electron Mac 客户端：`yarn pack:electron:mac`
   - 打包 Electron Windows 客户端：执行命令 `yarn pack:electron:win`