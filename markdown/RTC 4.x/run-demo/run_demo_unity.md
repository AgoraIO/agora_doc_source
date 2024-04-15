声网在 GitHub 上提供了开源的 SDK 示例项目 [API-Examples](https://github.com/AgoraIO-Extensions/Agora-Unity-Quickstart/tree/main/API-Example-Unity)，展示了各种基础和进阶的场景。本文以跑通视频通话示例项目为例，帮助你快速体验声网视频通话效果。


## 前提条件

- [Unity Hub](https://unity.com/download)

- Unity 2017.4.35 或以上版本

- 一个 Unity 项目，你可以参考 [Unity 官方文档](https://docs.unity3d.com/2018.2/Documentation/Manual/GettingStarted.html)来创建一个项目。

- 操作系统与编译器要求：

  | 开发平台 | 操作系统版本       | 编译器版本                          |
  | :------- | :----------------- | :---------------------------------- |
  | Android  | Android 4.1 或以上 | Android Studio 3.0 或以上           |
  | iOS      | iOS 9.0 或以上     | Xcode 9.0 或以上                    |
  | macOS    | macOS 10.10 或以上 | Xcode 9.0 或以上                    |
  | Windows  | Windows 7 或以上   | Microsoft Visual Studio 2017 或以上 |

- 计算机可以访问互联网。请确保你的网络环境未部署防火墙，否则可能无法正常使用声网服务。

- 一个有效的[声网账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)以及声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora Platform/get_appid_token?platform=All Platforms)从声网控制台获得以下信息：

  - App ID：声网随机生成的字符串，用于识别你的项目。
  - 临时 token：token 也称为动态密钥，在客户端加入频道时对用户鉴权。临时 token 的有效期为 24 小时。
  - 频道名：用于标识频道的字符串。

## 操作步骤

### 获取示例项目

1. 前往 [SDK 下载页面](./downloads?platform=Unity)，下载最新版的 Unity 视频 SDK，下载完成后你会看到一个 `.unitypackage` 文件。

2. 点击 `.unitypackage` 文件，会弹出一个 **Import Unity Package** 窗口，点击右下角的 **Import** 按钮把 Unity SDK 导入到你的 Unity 项目中。导入完成后，你可以在 **Project** 面板看到 `Agora-RTC-PLUGIN` 文件夹。

   ![](https://web-cdn.agora.io/docs-files/1691052920319)


### 配置示例项目

打开 `Agora-RTC-PLUGIN/API-Example/AppIdInput.cs` 文件，填入你从声网控制台获取到的 App ID、临时 Token 和频道名。

```csharp
public class AppIdInput : ScriptableObject
    {
        [FormerlySerializedAs("APP_ID")]
        [SerializeField]
        public string appID = "填入你的 App ID";

        [FormerlySerializedAs("TOKEN")]
        [SerializeField]
        public string token = "填入临时 Token";

        [FormerlySerializedAs("CHANNEL_NAME")]
        [SerializeField]
        public string channelName = "填入频道名";
    }
```


### 编译并运行示例项目

1.  `API-Example` 文件夹下包含 `Basic` 和 `Advanced` 两个文件，分别包含了声网 Unity SDK 的基础和进阶场景的使用示例（如下图所示）。选择一个你想要尝试的场景，点击 ![](https://web-cdn.agora.io/docs-files/1690958627881) 进行编译。

​      <img src="https://web-cdn.agora.io/docs-files/1691054049527" style="zoom:50%;" />

2. 以视频通话为例，编译成功后你可以看到自己本地的视频预览。

   ![](https://web-cdn.agora.io/docs-files/1690958780301)

3. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目（需确保 App ID、临时 Token 和频道名与你配置示例项目时填入的一致）。当你们输入相同的频道名加入频道后，即可在同一频道中体验各种互动场景。

   ![](https://web-cdn.agora.io/docs-files/1690958810176)