---
title: Start Interactive  Live Audio Streaming
platform: Electron
updatedAt: 2020-11-16 08:30:21
---
Use this guide to quickly start the interactive live audio streaming with the Agora SDK for Electron.

## Sample project

We provide an open-source sample project that implements [Agora Electron Quickstart](https://github.com/AgoraIO-Community/Agora-Electron-Quickstart) on GitHub. You can try the demo and view the source code.

## Prerequisites

* Node.js 6.9.1 or later
* Electron 1.8.3 or later

<div class="alert note">If you use Windows for development, ensure that you run <code>npm install -D --arch=ia32 electron</code> to install a 32-bit Electron. Otherwise you may receive the error: <code>Not a valid win32 application</code>.</div>
<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

In this section, we will create an Electron project, integrate the SDK into the project, and install the dependency to prepare the development environment.

### Create a project

Follow the steps in [Writing Your First Electron App](https://electronjs.org/docs/tutorial/first-app) to create an Electron project. Skip to [Integrate the SDK](#integrate_sdk) if a project already exists.

<a name="integrate_sdk"></a>
### Integrate the SDK

Choose either of the following methods to integrate the Agora SDK into your project.

**Method 1: Install the SDK through npm**

1. Go to the project path, and run the following command line to install the latest version of the Electron SDK:

	```javascript
    npm install agora-electron-sdk
    ```

2. Import the SDK into your project with the following code:

	```javascript
    import AgoraRtcEngine from 'agora-electron-sdk'
    ```


**Method 2: Download the SDK from the Developer Portal**

<div class="alert note">Ensure that you use Electron 3.0.6 if you want to get the SDK by downloading it from the Developer Portal.</div>

1. Go to [SDK Downloads](./downloads?platform=Electron) to download the Agora SDK for Electron.
2. Save the downloaded SDk package into the root directory of your project file.
3. Import the SDK into your project with the following code:

	```javascript
    import AgoraRtcEngine from './agora-electron-sdk/AgoraSdk.js'
    ```

### Switch the prebuild add-on version

By default, Agora uses Electron 1.8.3 to build the project. Switch the prebuilt add-on version in the .npmrc file according to your Electron version:

<div class="alert note">If your Electron version is different from the prebuilt add-on version, you may receive the error:<code>is compiled from Nodejs version 54, this version requires Nodejs version 64</code>.</div>

```javascript
// Downloads a prebuilt add-on with Electron 1.8.3
agora_electron_dependent = 1.8.3
// Downloads a prebuilt add-on with Electron 3.0.6
agora_electron_dependent = 3.0.6
// Downloads a prebuilt add-on With Electron 4.2.8
agora_electron_dependent = 4.2.8
// Downloads a prebuilt add-on With Electron 5.0.8
agora_electron_dependent = 5.0.8
```

### Install the dependency

Under the project path, run `npm install` to install the dependency and trigger the npm run download command. You can also install the dependency manually.

If you want to debug with Xcode or Visual Studio, run `npm run debug` to generate project files and SDK files for the debug environment.

You have now integrated the Agora SDK for Electron into your project.

## Implement the basic interactive live audio streaming

Refer to the [Agora Electron Quickstart](https://github.com/AgoraIO-Community/Agora-Electron-Quickstart) sample project to implement various interactive live streaming functions in your project.

## Open-source SDK

The [Agora SDK for Electron](https://www.npmjs.com/package/agora-electron-sdk) is open-source on GitHub. You can download it and refer to the source code. Agora welcomes contributions from developers to improve the usability of the Electron SDK.

## Reference

[How can I listen for an audience joining or leaving a interactive live streaming channel?](https://docs.agora.io/en/faq/audience_event)