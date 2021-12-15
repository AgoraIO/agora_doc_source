---
title: 跑通示例项目
platform: Windows
updatedAt: 2020-11-24 10:08:18
---

Agora 在 GitHub 上提供开源的视频通话示例项目。本文介绍如何快速跑通多人视频通话的两个示例项目 [OpenVideoCall-Windows-MFC](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows-MFC)（基于 MFC） 和 [OpenVideoCall-Windows](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows)（基于 Qt），体验 Agora 视频互动直播。

## 获取 App ID 和 Token

### 1. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### 2. 获取 Agora 项目的 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)

### 3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

   ![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时 Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

   ![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

## 跑通基于 Qt 的示例项目

### 前提条件

- 操作系统：Windows 7 或更高版本
- IDE：基于 Qt 5.6 或更高版本的 Qt Creator

### 集成 SDK

1. 将 [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) 仓库拉取到本地。进入 `Group-Video\OpenVideoCall-Windows` 目录。

2. 下载最新版本的[视频 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/downloads?platform=Windows)，解压后进行以下操作：

   1. 在 `OpenVideoCall-Windows` 下创建一个 文件夹 `sdk`，在 `sdk` 文件夹下创建两个文件夹：`include `和 `lib`。
   2. 把 `libs\include` 中的所有 `.h` 文件复制到 `OpenVideoCall-Windows\sdk\include` 目录下。
   3. 把 `libs\x86 `或 `libs\x86_64` 目录及所有文件复制到 `OpenVideoCall-Windows\sdk\lib` 目录下。

### 操作步骤

1. 在 `OpenVideoCall-Windows` 下，使用 Qt creator 打开 `OpenVideoCall-Windows` 下的 `OpenVideoCall.pro` 文件。
2. 点击 **Projects**，在 **Build&Run** 下选择构建工具。例如 x86-windows-msvc0217-pe-64bit 或 x86-windows-msvc0217-pe-32bit。
3. 点击 **Edit**，打开 `Headers/agoraobject.h`，将 `APP_ID` 和 `APP_TOKEN` 的值替换为你的 App ID 和 Token。
4. 选择 **Release** 作为构建选项，点击构建 ![](https://web-cdn.agora.io/docs-files/1605269964702) 按钮进行构建。
5. 构建完成后，点击运行 ![](https://web-cdn.agora.io/docs-files/1605269976951) 按钮运行项目。 在 OpenVideoCall 界面上输入频道名并选择角色，点击 **joinChannel** 即可加入频道。

<div class="alert note">频道名必须是生成 Token 时使用的频道名。</div>

![](https://web-cdn.agora.io/docs-files/1605272486881)

### 示例项目结构

下表列出示例项目在 Qt Creator 中的代码结构，你可以参考示例项目的代码，根据自己的需求进行调整。

| 文件夹/文件          | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| :------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `OpenVideoCall.pro`  | Qt 项目文件。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `Headers`, `Sources` | 项目的所有 `.h` 文件和 `.cpp` 文件 。<ul><li>`main.h/cpp`：定义主应用类 </li><li> `openvideocall.h/cpp`：应用主要逻辑，包括 UI 与底层逻辑的驱动关系。</li><li>`agoraobject.h/cpp`：包含 RTC SDK 实现的主要逻辑。</li><li>`agoraconfig.h/cpp`：读取在 `AgoraConfigOpenVideoCall.ini` 中的 SDK 参数设置</li><li>`avdevice.h/cpp`：选择音视频采集设备并设置音视频参数 </li><li>`nettesting.h/cpp`，`nettestresult.h/cpp`，`nettestdetail.h/cpp`：设备网络测试</li><li>`inroom.h/cpp enterroom.h/cpp`：用户进入频道时及进入后触发的 SDK 回调及 UI 相关变化</li></ul> |
| `Forms`              | 项目的所有 `.ui` 文件，定义用户界面                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `Resources`          | UI 资源文件。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `Other files`        | `openvideocall.rc`：指定应用图标文件                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

## 跑通基于 MFC 的示例项目

### 前提条件

- 操作系统：Windows 7 或更高版本
- IDE：Visual Studio 2017 或更高版本

### 集成 SDK

1. 将 [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) 仓库拉取到本地。在 `Group-Video\OpenVideoCall-Windows-MFC` 下创建一个 文件夹 `sdk`，在 `sdk` 文件夹下创建三个文件夹：`include`，`dll`，和 `lib`。

2. 下载最新版本的[视频 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/downloads?platform=Windows)，解压后进行以下操作：

   1. 把 `libs\include` 中的所有 `.h` 文件复制到 `OpenVideoCall-Windows-MFC\sdk\include` 目录下。
   2. 把 `libs\x86\agora_rtc_sdk.dll` 或 `libs\x86_64\agora_rtc_sdk.dll` 复制到 `OpenVideoCall-Windows-MFC\sdk\dll` 目录下。
   3. 把 `libs\x86\agora_rtc_sdk.lib` 或 `libs\x86_64\agora_rtc_sdk.lib` 复制到 `OpenVideoCall-Windows-MFC\sdk\lib` 目录下。

<div class="alert note">如果你选择了 <code>x86</code> 下的库文件，则运行时必须选择 Win32 平台；如果你选择了 <code>x86_64</code> 下的库文件，则运行时必须选择 x64 平台。</div>

### 操作步骤

1. 在 `OpenVideoCall-Windows-MFC` 目录下，使用 Visual Studio 中打开 `OpenVideoCall.sln`。
2. 在**解决方案资源管理器**中，选择 **OpenVideoCall** >> **AgoraObject** >> **AgoraObject.h**。将 `APP_ID_T` 和 `APP_TOKEN` 的值替换为你的 App ID 和 Token。
3. 在**解决方案资源管理器**中，鼠标右键点击解决方案名称，选择**生成解决方案**。
4. 编译完成后，按 &lt;F5&gt; 运行程序。在 OpenVideoCall 界面上输入频道名并选择角色，点击 **Join** 即可加入频道。

<div class="alert note">频道名必须是生成 Token 时使用的频道名。</div>

![](https://web-cdn.agora.io/docs-files/1605272498825)

### 示例项目结构

下表列出示例项目在 Visual Studio 解决方案管理器中的代码结构，你可以参考示例项目的代码，根据自己的需求进行调整。

| 文件夹        | 描述                                                                                                                                                                                                                                                                                                                                                                  |
| :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AgoraObject` | 应用的主要逻辑。包括：<ul><li>`AgoraObject.h/cpp`: 主逻辑，包含应用的基本功能</li><li>`AgoraAudInputManager.h/cpp`，`AgoraCameraManager.h/cpp`: 选择音视频采集设备并设置音视频参数</li><li>`AgoraPlayoutManager.h/cpp`: 选择音视频播放设备并设置播放参数</li><li>`AGEngineEventHandler.h/cpp`: 设置事件处理逻辑</li><li>`AGResourceVisitor.h/cpp`: 资源处理</li></ul> |
| `App`         | `OpenVideoCall` 主应用类                                                                                                                                                                                                                                                                                                                                              |
| `Headers`     | MFC 中需要 include 的标准头文件                                                                                                                                                                                                                                                                                                                                       |
| `Resources`   | 资源文件                                                                                                                                                                                                                                                                                                                                                              |
| `UI`          | 用户界面，包括对话框、窗口、控件的定义                                                                                                                                                                                                                                                                                                                                |
