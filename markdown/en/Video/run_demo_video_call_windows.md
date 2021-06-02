---
title: Run the Sample Project
platform: Windows
updatedAt: 2020-11-24 10:08:43
---
Agora provides two open-source sample projects: [OpenVideoCall-Windows](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows) (based on QT) and [OpenVideoCall-Windows-MFC](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows-MFC) (based on MFC). This article describes how to run the sample projects.

## Get App ID and Token

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



<div class="alert info">You must specify the App ID when running the project.</div>

### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://dashboard.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>


<div class="alert info">You must specify the Token when running the project.</div>

## Run the sample project based on Qt

### Prerequisites

- Operating system: Windows 7 or higher
- IDE: Based on Qt 5.6 or higher

### Integrate the SDK

1. Clone the [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) repository. Navigate to the `Group-Video\OpenVideoCall-Windows` folder.

2. Download the latest version of [Video SDK](/en/Interactive%20Broadcast/downloads?platform=Windows). Unzip the file and perform the following operations:

   1. Create a `sdk` folder in `OpenVideoCall-Windows`. In `sdk`, create two folders: `include` and `lib`.
   2. Copy all `.h` files from `libs\include` to `OpenVideoCall-Windows``\sdk\include`.
   3. Copy `libs\x86` or `libs\x86_64` to `OpenVideoCall-Windows\sdk\lib`.

### Precedure

1. Navigate to the `OpenVideoCall-Windows` folder and open `OpenVideoCall.pro` with Qt Creator.
2. Click Projects ![](https://web-cdn.agora.io/docs-files/1605271373165) and select the build tool in **Build&Run**.
3. Click Edit ![](https://web-cdn.agora.io/docs-files/1605271389610), open `Headers/agoraobject.h`, and replace `APP_ID` and `APP_TOKEN` with your App ID and Token.
4. Select Release ![](https://web-cdn.agora.io/docs-files/1605271405513) as the build option and click ![](https://web-cdn.agora.io/docs-files/1605271420748) to build the project.
5. When the build is successful, click ![](https://web-cdn.agora.io/docs-files/1605271430115) to run the project. Enter the channel name (must be the channel name used to generate the token) and select your role. Click **joinChannel** to join the channel.

![](https://web-cdn.agora.io/docs-files/1605271519866)

### Project structure

The following table shows the structure of the sample project. You can adjust the code per your requirements.

| Folder / file     | Description                                                  |
| :---------------- | :----------------------------------------------------------- |
| OpenVideoCall.pro | QT project file                                              |
| HeadersSources    | All `.h` files and `.cpp` files<ul><li>`main.h/cpp`：Main app class </li><li>`openvideocall.h/cpp`: Main app logic, including the connection between the UI and low-level logic</li><li>`agoraobject.h/cpp`: Main logic implemented by the RTC SDK</li><li>`agoraconfig.h/cpp`: Read and write the SDK settings in `AgoraConfigOpenVideoCall.ini` </li><li>`avdevice.h/cpp`：Select the capture device and configure video/audio settings.</li><li>`nettesting.h/cpp`，`nettestresult.h/cpp`，`nettestdetail.h/cpp`: Device network test</li><li>`inroom.h/cpp enterroom.h/cpp`：SDK callbacks and UI changes when and after the user joins the channel</li></ul> |
| Forms             | All `.ui` files of the project to define user interface      |
| Resources         | UI resource file                                             |
| Other files       | `openvideocall.rc`: App icon file                            |



## Run the project based on MFC

### Prerequisites

- Operating system: Windows 7 or higher
- IDE: Visual Studio 2017 or higher

### Integrate the SDK

1. Clone the [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) repository. Navigate to the `Group-Video\OpenVideoCall-Windows-MFC` folder.

2. Download the latest version of [Video SDK](/en/Interactive%20Broadcast/downloads?platform=Windows). Unzip the file and perform the following operations:

   1. Create a `sdk` folder in `OpenVideoCall-Windows-MFC`. In sdk, create three folders: `include`, `dll`, and `lib`.
   2. Copy all `.h` files from `libs\include` to `OpenVideoCall-Windows-MFC``\sdk\include`.
   3. Copy `libs\x86\agora_rtc_sdk.dll` or `libs\x86_64\agora_rtc_sdk.dll` to `OpenVideoCall-Windows-MFC\sdk\dll`.
   4. Copy `libs\x86\agora_rtc_sdk.lib` or `libs\x86_64\agora_rtc_sdk.lib` to `OpenVideoCall-Windows-MFC\sdk\lib`.

<div class="alert note">If you select files from the x86 folder, you must choose Win32 platform when running the project; If you select files from the x86_64 folder, you must choose x64 platform when running the project.</div>

### Procedure

1. Navigate to the `OpenVideoCall-Windows-MFC` folder and open `OpenVideoCall.sln` with Visual Studio.
2. In the solution manager, select **OpenVideoCall** >> **AgoraObject** >> **AgoraObject.h**.
3. In the solution manager, right-click the solution and select **generate solution**.
4. After compilation, press &lt;F5&gt; to run the project. Enter the channel name (must be the channel name used to generate the token) and select your role. Click **Join** to join the channel.

![](https://web-cdn.agora.io/docs-files/1605271654997)

### Project structure

The following table shows the structure of the sample project. You can adjust the code per your requirements.

| Folder      | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| AgoraObject | Main app logic, includes:<ul><li>`AgoraObject.h/cpp`: Main app logic with basic functions</li><li>`AgoraAudInputManager.h/cpp`，`AgoraCameraManager.h/cpp`: Select capture device and set parameters</li><li>`AgoraPlayoutManager.h/cpp:` Select playout device and set parameters</li><li>`AGEngineEventHandler.h/cpp`: Event handler logic</li><li>`AGResourceVisitor.h/cpp`: Resource management</li></ul> |
| App         | `OpenVideoCall` main app class                               |
| Headers     | Standard header files to include for MFC                     |
| Resources   | Resource file                                                |
| UI          | User interface, including definitions for dialogs, windows, and controls |