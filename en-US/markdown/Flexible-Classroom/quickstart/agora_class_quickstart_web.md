This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/cn/agora-class/agora_class_enable?platform=Web" target="_blank">enable the Flexible Classroom service</a>.
- The latest stable version of [Google Chrome](https://www.google.cn/chrome/) on the desktop.
- Physical media input devices, such as a built-in camera and a built-in microphone.
- Install [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm).
- Install [yarn](https://yarnpkg.com/getting-started/install).

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the  [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop) project and check out the latest release branch.

   ```
   https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_web?platform=Web">release notes</a>.</div>

2. Rename `.env.example` as `.env.dev` and move it to the `packages/Agora-classroom-sdk` folder. Pass in your own `Agora App ID` and `Agora App Certificate` in this file.

   ```
   REACT_APP_AGORA_APP_ID=
   REACT_APP_AGORA_APP_CERTIFICATE=
   ```

   To facilitate your testing, the CloudClass-Desktop project contains an RTM Token generator, which can generate a temporary RTM Token with the App ID and App Certificate you pass in. When your project goes live, to ensure security, you must deploy the RTM Token generator on your server.

3. To install dependencies, run the following command:

   ```
   npm install
   ```

4. Run the web project with the following command:

   ```
   npm run dev
   ```

5. To join a classroom, pass in a room name and user name, select a room type, and click **Enter**.

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can [integrate Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_web?platform=Web).