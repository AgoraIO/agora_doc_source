声网在 GitHub 上提供开源示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main) 演示声网实时音视频 SDK 的 API 使用示例，以帮助开发者更好地理解和运用声网 SDK 的功能。

本文介绍如何快速跑通 Windows 示例项目，体验实时音视频功能。


## 前提条件

- [Microsoft Visual Studio](https://visualstudio.microsoft.com/) 2017 及以上。
    <div class="alert note">该示例项目基于 MFC。在运行项目前，请确保你的 Visual Studio 已安装<b>适用于最新 v142 生成工具的 C++ MFC (x86 和 x64)</b> 组件。</div>
- 两台运行 Windows 7 及以上版本的设备。
- 参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms) 创建有效的声网账户和声网项目，并从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的项目。
  - 临时 token：token 也称为动态密钥，在客户端加入频道时对用户鉴权。临时 token 的有效期为 24 小时。
  - 频道名：用于标识频道的字符串。


## 操作步骤

### 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO/API-Examples.git
```

2. 该仓库中包含声网实时音视频 SDK 所有 Native 平台的示例项目，其中 Windows 平台的 API 使用示例位于 `/windows` 路径下。


### 配置示例项目

1. 集成 SDK 并安装依赖

运行 `/APIExample/installThirdParty.bat` 即可自动集成 SDK、下载依赖并配置环境。

2. 设置 App ID 和 Token

打开 `/APIExample/APIExample/stdafx.h` 文件，在 `enter your app id` 和 `enter your temporary token` 中填入你从声网控制台获取的 App ID 和临时 token。

```cpp
#define APP_ID     "enter your app id"
#define APP_TOKEN  "enter your temporary token"   
```


### 编译并运行示例项目

1. 用 Visual Studio 打开 `/APIExample/APIExample.sln` 文件。

2. 点击 <img src="https://web-cdn.agora.io/docs-files/1690875789361" width="25"/> 开始编译。

3. 编译成功后，你的 Windows 设备上会弹出以下窗口：
![](https://web-cdn.agora.io/docs-files/1690875828817)

4. 你可以任意选择你想体验的场景。以 **Basic Scene** 中的 **LiveBroadcasting** 直播场景为例，在 **Channel Name** 中输入生成临时 token 时指定的频道名，并点击 **JoinChannel** 加入频道。

5. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目，使用相同的 App ID、Token 和频道名加入频道，你们会看到并听到彼此。
![](https://web-cdn.agora.io/docs-files/1690875862097)
