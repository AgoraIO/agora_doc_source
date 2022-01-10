This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/en/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/en/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/en/agora-class/agora_class_enable?platform=Electron" target="_blank">enable the Flexible Classroom service</a>.
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

   <div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/en/agora-class/release_agora_class_web?platform=Web">release notes</a>.</div>

2. Replace `<Your Agora App ID>` and `<YOUR RTM TOKEN>` in `packages/agora-electron-edu-demo/src/renderer/components/app/index.js` with your [App ID and RTM Token](#prerequisites).

   ```javascript
   import { AgoraEduSDK } from 'agora-classroom-sdk'

   export default class App {
     constructor(elem) {
       if (!elem) return
       this.elem = elem
     }

     setupClassroom() {
       AgoraEduSDK.config({
         appId: "<YOUR APPID>",
       })
       AgoraEduSDK.launch(
         document.querySelector(`#${this.elem.id}`), {
           rtmToken: "<YOUR RTM TOKEN>",
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
     }
   }
   ```

3. Follow these steps to run the project on macOS or Windows:

   **macOS**

   1. To install dependencies, run the following command under the root directory of the CloudClass-Desktop project:

      ```bash
      # Install global dev dependencies
      yarn
      # Install all dependencies via lerna and yarn
      yarn bootstrap
      ```

   2. To build the project, run the following command in the `packages/agora-electron-edu-demo` directory:

      ```
      npm run dev
      ```

      You can see the following page:

      ![](https://web-cdn.agora.io/docs-files/1623404345070)

   **Windows**

   1. To install dependencies, run the following command under the root directory of the CloudClass-Desktop project:

      ```bash
      # Install global dev dependencies
      yarn
      # Install all dependencies via lerna and yarn
      yarn bootstrap
      ```

   2. Replace the `"agora_electron"` object in `packages/agora-electron-edu-demo/package.json` with the following code:

      ```json
      "agora_electron": {
        "electron_version": "7.1.2",
        "prebuilt": true,
        "platform": "win32",
        "arch": "ia32"
      },
      ```

   3. To install electron 7.1.14, run the following command:

      ```bash
      npm install electron@7.1.14 --arch=ia32 --save-dev
      ```

   4. To build the project, run the following command in the `packages/agora-electron-edu-demo` directory:

      ```bash
      npm run dev
      ```

      You can see the following page:

      ![](https://web-cdn.agora.io/docs-files/1623404345070)

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can integrate [Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_web?platform=Electron).