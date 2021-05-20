---
title: Run the Sample Project
platform: Web
updatedAt: 2020-12-23 11:44:45
---
## Introduction

Agora provides an open-source [One-to-One-Video](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1) sample project on GitHub. This document introduces how to run this project and experience a video call implemented by the Agora SDK.

## Prerequisites

- A Windows or macOS computer with access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall) to access Agora's services. 
- Your computer is equipped with an Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent.
- A built-in camera or external USB camera.
- The latest stable version of [Chrome](https://www.google.com/chrome/).
- A valid Agora [account](https://docs.agora.io/en/Agora Platform/sign_in_and_sign_up).

## Procedure

### 1. Create an Agora project

Create a project in [Agora Console](https://console.agora.io/), as follows:

1. Log in to Console, and click ![img](https://web-cdn.agora.io/docs-files/1594283671161) in the left navigation menu to enter the [Project Management](https://dashboard.agora.io/projects) page.

2. Click **Create**.

   [![create button](https://web-cdn.agora.io/docs-files/1594949127367)](https://dashboard.agora.io/projects)

3. Enter your project name, and select **Secure mode: APP ID + Token** for the authentication mechanism in the pop-up window.

4. Click **Submit**. You can see the created project on the **Project Management** page.

### 2. Get an App ID

Agora automatically assigns each project an App ID as a unique identifier.

To copy this App ID, find your project on the [Project Management](https://dashboard.agora.io/projects) page in Agora Console, and click the eye icon to the right of the App ID.

![get app id](https://web-cdn.agora.io/docs-files/1602646621028)


<div class="alert info">The App ID is needed during the <a href="#join">Join a video call</a> procedure.</div>

### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://dashboard.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>

<div class="alert info">The temporary token is needed during the <a href="#join">Join a video call</a> procedure.</div>

### 4. Integrate the Agora SDK

Integrate the Agora SDK into the sample project, as follows:

1. Download the [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) repository, and find the **Agora-Web-Tutorial-1to1** sample project in the **Basic-Video-Call/One-to-One-Video** directory.
2. Download the latest [Web Video SDK](https://docs.agora.io/en/Agora%20Platform/downloads), and extract the files.
3. Copy the `.js` file starting with `AgoraRTCSDK` to the `assets` folder in the Agora-Web-Tutorial-1to1 project, and rename the file to `AgoraRTCSDK.js`.

### <a name="join"></a>5. Join a video call

Run the sample project to join a video call, as follows:

1. Open the `index.html` file in Chrome. You will see the **Basic Communication** page:
   ![basic communication index](https://web-cdn.agora.io/docs-files/1605176227661)
2. Enter the App ID and temporary token, as well as the channel name that you use to generate the temporary token.
2. Click **JOIN**, and allow the browser to access your camera and microphone in the pop-up window.

   You should see a video stream of yourself on the page.

3. To try a one-to-one video call, duplicate the browser tab, enter the same App ID, channel name, and temporary token, and then click **JOIN**.

   You should see two video streams in each browser window.

If the sample project does not work properly, open the browser console and check for errors. The following are the most likely errors:

- `INVALID_VENDOR_KEY`: Incorrect App ID or token. Ensure that you enter the correct App ID and token.
- `DYNAMIC_USE_STATIC_KEY`: Token missing. Because your Agora project enables App Certificate, you need a token to join the channel.
- `Media access:NotFoundError`: Camera/microphone error. Check that your camera and microphone are working properly.

## Sample project structure

The following table lists the code structure of the sample project for your reference:

| File/Folder         | Description                                               |
| :------------------ | :-------------------------------------------------------- |
| `index.html`        | The code of the web page and the main functions.          |
| `assets/common.css` | The code for the front-end style.                         |
| `vendor`            | Third-party libraries for the front-end style and layout. |

## Relevant links

Agora provides the following additional video call sample projects on GitHub:

- [Agora-Web-Tutorial-1to1-Webpack](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-Webpack)
- [Agora-Web-Tutorial-1to1-Vue](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-Vue)
- [Agora-Web-Tutorial-1to1-React](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-React)
- [OpenVideoCall](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Web)