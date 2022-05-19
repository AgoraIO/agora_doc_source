This document introduces how to get the source code of Agora Flexible Classroom (Web) from GitHub and run the project, so as to quickly launch a flexible classroom and experience the features.

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

<a name="prerequisites"></a>

## Prerequisites

- Enable the [Flexible Classroom service](/en/agora-class/agora_class_enable?platform=Web) in Agora console.
- Get the [Agora App ID](/en/Agora%20Platform/get_appid_token#Get-app-id) and [App Certificate](/en/Agora%20Platform/get_appid_token#Get-app-certificate) in Agora console.
- Agora recommends installing the latest stable version of [desktop Chrome](https://www.google.cn/chrome/).

<a name="dev-env"></a>

## Set up the development environment

Running the web client of Flexible Classroom depends on Git (for downloading the source code), Node.js (for building and running the Web project), Yarn (a package management tool), Lerna (a package management tool), and nvm (Node.js version management command-line tool).

To prepare your development environment, refer to the following steps:

1. To download Git, click this [link](https://git-scm.com/downloads).

2. To download Node.js, click this [link](https://nodejs.org/zh-cn/download/). Agora recommends using Node.js 14 or later.

3. Install Yarn:

   - If you have installed Node.js 16.10 or later, you can directly enable Yarn with the following command:

      ```bash
      corepack enable
      ```

   - If you have installed a Node.js version earlier than 16.10, you need to install Corepack first and then enable Yarn with the following command:

      ```bash
      npm i -g corepack enable
      ```

4. To install Lerna, run the following command:

   ```bash
   yarn add global lerna
   ```

5. (Optional) To install nvm, run the following command:

   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
   ```

## Get the source code

The source code of Flexible Classroom (Web) is in the [CloudClass-Desktop](https://github.com/AgoraIO-Community/CloudClass-Desktop) repository.  To download the source code to your local device, refer to the following steps:

1. To clone the repository, run the following command:

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-Desktop.git
   ```

2. To switch the branch, run the following command. Remember to replace {VERSION} with a specified version number:

   ```bash
   git checkout release/apaas/{VERSION}
   ```

   For example, if you want to switch to the branch of v2.1.2, just run the following command:

   ```bash
   git checkout release/apaas/2.1.2
   ```

   Agora recommends switching the branch of the latest release.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to install dependencies:

   ```bash
   yarn
   ```

2. Run the following command to install dependencies:

   ```bash
   yarn bootstrap
   ```

3. Move the `.env.example` file in the project's root directory to `packages/agora-classroom-sdk` and rename it as `.env`:

   ```bash
   mv .env.example packages/agora-classroom-sdk/.env
   ```

4. Fill in your App ID and App Certificate in `.env`:

   ```typescript
   REACT_APP_AGORA_APP_ID={your appid}
   REACT_APP_AGORA_APP_CERTIFICATE={your app certificate}
   ```

   To facilitate your testing, the CloudClass-Desktop project contains an RTM Token generator, which can generate a temporary RTM Token with the App ID and App Certificate you pass in. When your project goes live, to ensure security, you must deploy the RTM Token generator on your server.

5. Run the following command to launch the web client in development mode:

   ```bash
   yarn dev
   ```

6. Open the browser and visit `http://localhost:3000`. You can see the login page of Flexible Classroom. To join a classroom, pass in a room name and user name, select a room type, and click **Enter**.

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can [integrate Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_web?platform=Web).
