This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an [Agora App ID](/en/Agora%20Platform/get_appid_token#get-the-app-id), [App Certificate](/en/Agora%20Platform/get_appid_token#get-the-app-certificate) and the aPaaS service configured. See [Configure Flexible Classroom](/en/agora-class/agora_class_prep?platform=Web).
- 安装最新稳定版桌面端 [Google Chrome 浏览器](https://www.google.cn/chrome/)。
- Physical media input devices, such as a built-in camera and a built-in microphone.
- 安装 [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- 安装 [yarn](https://yarnpkg.com/getting-started/install)

## Launch a flexible classroom

Follow the following steps to launch a flexible classroom:

1. 运行以下命令将 [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop) 项目克隆至本地，并切换至最新发版分支。

   ```
   https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">x.y.z 请替换为版本号。 你可在<a href="/cn/agora-class/release_agora_class_web?platform=Web">发版说明</a>中获取最新版本号。</div>

2. 将 `.env.example` 重命名为 `.env.dev` 并移动至 `packages/agora-classroom-sdk` 目录下，然后传入你自己的 `Agora App ID` 和 `Agora App Certificate`。

   ```
   REACT_APP_AGORA_APP_ID=
   REACT_APP_AGORA_APP_CERTIFICATE=
   ```

   为方便你快速测试，CloudClass-Desktop 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。 But in a formal environment, to ensure security, RTM Token must be generated on the server side.

3. 通过以下命令安装依赖：

   ```
   npm install
   ```

4. 通过以下命令在本地运行 Web 项目：

   ```
   npm run dev
   ```

5. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂。

## Next steps

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_web?platform=Web)。