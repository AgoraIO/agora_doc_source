This page introduces how to integrate Flexible Classroom into your own Web or Electron project.

## Understand the tech

The source code of Flexible Classroom contains the following packages:

- `agora-classroom-sdk`: The Agora Classroom SDK, which contains the following modules:
   - `/src/infra/stores`: The UI stores implement the business logic for the UI components.
   - `/src/ui-kit/capabilities`:
      - `/containers`: This folder contains all the business components. A business component is implemented by combining the UI components with the UI stores.
      - `/scenarios`: This folder contains the code for arranging the layout of business components in different scenarios.
- `agora-chat-widget`: The chat widget implemented by the Easemob IM SDK.
- `agora-plugin-gallery`: This package contains the code for plugins in Flexible Classroom, including the screen sharing plugin, Pop-up Quiz, Poll, and Countdown Timer.
- `agora-scenario-ui-kit`: This package contains all the UI function components.
- `agora-widget-gallery`: This package contains the chat widget implemented by the Easemob IM SDK and the chat widget implemented by the Agora RTM SDK

## Integration methods

There are three methods of integrating Flexible Classroom into your own Web or Electron project:

- Integrate Flexible Classroom through CDN.
- Integrate Flexible Classroom through [npm](https://www.npmjs.com/package/agora-classroom-sdk).
- Integrate Flexible Classroom by downloading the [source code](https://github.com/AgoraIO-Community/CloudClass-Desktop) on GitHub.

You can choose from these integration methods, depending on whether you need to change the classroom UI.

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

If you are satisfied with the default UI of Flexible Classroom and do not want to change any of it, integrate the whole Flexible Classroom through npm or CDN.

#### Through npm

1. To install the SDK, run the following command:

   ```bash
   npm install agora-classroom-sdk
   ```

2. To import the `AgoraEduSDK` module, add the following code in the Javascript code in your project.

   ```bash
   import {AgoraEduSDK} from 'agora-classroom-sdk'
   ```

#### Through CDN

1. Add the following code to the HTML file in your project.

   ```html
   <script src="https://download.agora.io/edu-apaas/release/edu_sdk@2.4.0.bundle.js"></script>
   ```

2. Add the following code to the `.js` file in your project.

   ```javascript
   window.AgoraEduSDK.config({
       appId: "<your_app_id>",
       region: "NA",
   });
   
   window.AgoraEduSDK.launch(dom, {
       ...launchOption,
       listener: (evt: AgoraEduClassroomEvent, type) => {},
   });
   ```

   Parameter description:

   - `config`: The SDK global configuration. For the supported parameters, see [ConfigParams](/en/agora-class/agora_class_api_ref_web?platform=Web#configparams).
   - `dom`: The rendering node of the browser.
   - `launchOption`: The launching options. For the supported parameters, see [LaunchOption](/en/agora-class/agora_class_api_ref_web?platform=Web#launchoption).

<a name="change_default_ui"></a>

### Customize the classroom UI

If you want to customize the classroom UI based on the default UI of Flexible Classroom, you need to integrate Flexible Classroom by downloading the source code on GitHub. Refer to the following steps:

<div class="alert info">Make sure you have <a href="/en/agora-class/agora_class_quickstart_web?platform=Web#dev-env">set up the development environment</a>.</div>

1. To clone the CloudClass-Desktop repository and check out the latest release branch, run the following commands:

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

1. After navigating to the project directory, switch to the latest release branch.

   ```bash
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with a version number. To get the latest version number, see the <a href="/en/agora-class/release_agora_class_web?platform=Web">release notes</a>.</div>

1. After pulling the code to your local device, you are free to edit the code according to your needs. You can refer to the [Customize the Classroom UI guide](/en/agora-class/agora_class_custom_ui_web?platform=Web).

1. After finishing the development, follow these steps to debug:

   1. To install dependencies, run the following command:

      ```bash
      yarn install
      ```

      ```bash
      yarn bootstrap
      ```

   2. To run the project in development mode, use the following commands:

      - To run the web project, use `yarn dev`.
      - To run the Electron project, use `yarn dev:electron`.

   3. After finishing the development, pack the SDK or app with the following commands:

      - To pack the Classroom SDK, use `yarn pack:classroom:sdk`.

         <div class="alert info">Find the output in <code>/packages/agora-classroom-sdk/lib/edu_sdk.bundle.js</code>. </div>

      - To pack the macOS client, use `yarn pack:electron:mac`.
      - To pack the Windows client, use `yarn pack:electron:win`.
