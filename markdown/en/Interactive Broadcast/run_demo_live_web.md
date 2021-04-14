---
title: Run the Sample Project
platform: Web
updatedAt: 2020-12-23 13:02:21
---
## Introduction

Agora provides an open-source [Basic-Video-Broadcasting](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Web) sample project on GitHub. This document introduces how to run this project and experience a live video streaming implemented by the Agora SDK.

## Prerequisites

- A Windows or macOS computer with access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall) to access Agora's services. 
- Your computer is equipped with an Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent.
- A built-in camera or external USB camera.
- The latest stable version of [Chrome](https://www.google.com/chrome/).
- A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- [Node.js LTS](https://nodejs.org/en/download/)

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


<div class="alert info">The App ID is needed during the <a href="#join">Start a live video streaming</a> procedure.</div>

### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://dashboard.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>

<div class="alert info">The temporary token is needed during the <a href="#join">Start a live video streaming</a> procedure.</div>

### 4. Integrate the Agora SDK

Integrate the Agora SDK into the sample project, as follows:

1. Download the [Basic-Video-Broadcasting](https://github.com/AgoraIO/Basic-Video-Broadcasting) repository, and find the **OpenLive-Web** sample project.
2. Change the directory to OpenLive-Web with the `cd` command in the terminal.
3. Run `npm install` to install the dependencies and integrate the Agora Web SDK.

### <a name="join"></a>5. Start a live video streaming

Run the sample project to start a live video streaming, as follows:

1. Rename the extension of the `.env.example` file to `.env` in the sample project folder.
   <div class="alert note">The <code>.env.example</code> file is a hidden file, and you may need to change the system settings to show this file.</div>

2. Open the .`env` file, replace `<#YOUR Agora.io APP ID#>` with the App ID of your Agora project, and replace `<#YOUR Agora.io APP TOKEN#>` with the temporary token generated in Agora Console.
   <div class="alert note">Both the App ID and the temporary token should be in string format, as the following figure shows.
	<img src="https://web-cdn.agora.io/docs-files/1605177740288"></img>
</div>

3. Change the directory to OpenLive-Web with the `cd` command in the terminal, and then run `npm run dev` to run the sample app.

   The sample app opens in your default browser.
	 ![](https://web-cdn.agora.io/docs-files/1605178564539)

  <div class="alert info">If the sample app does not open automatically, you can visit <code>http://localhost:3000</code> in your browser to open it manually.</div>

4. Enter the channel name that you used to generate the temporary token, and then click **Start Live Streaming** to start the live video streaming as a host. You need to allow the browser to access your camera and microphone in the pop-up window. You should see a video stream of yourself on the page.

  <div class="alert info">If you start the live video streaming after choosing the audience icon, the browser will not request access to your camera and microphone, and you will not see the local video stream of yourself on the page.</div>

If the sample project does not work properly, open the browser console and check for errors. The following are the most likely errors:

- `INVALID_VENDOR_KEY`: Incorrect App ID or token. Ensure that you enter the correct App ID and token.
- `DYNAMIC_USE_STATIC_KEY`: Token missing. Because your Agora project enables App Certificate, you need a token to join the channel.
- `Media access:NotFoundError`: Camera/microphone error. Check that your camera and microphone are working properly.