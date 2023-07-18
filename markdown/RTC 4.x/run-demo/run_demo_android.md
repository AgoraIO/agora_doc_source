声网在 GitHub 上提供开源示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main) 演示声网实时音视频 SDK 的 API 使用示例，以帮助开发者更好地理解和运用声网 SDK 的功能。

本文介绍如何快速跑通 Android 示例项目，体验基础的实时音视频功能。


## 前提条件

//TODO: 这部分需要和开发再确认一下，根据 demo 代码来看，Android 快速开始的前提条件似乎已经过时了。

- [Android Studio](https://developer.android.com/studio/) 4.2 及以上。
- Android API 级别 21 及以上。
- 两台运行 Android 5.0 及以上版本的移动设备。
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms) 创建有效的声网账户和声网项目，并从声网控制台获取以下信息：
    - App ID：声网随机生成的字符串，用于识别你的 app。
    - (可选) App 证书：声网提供的 App 证书，用于在服务器部署并生成 Token，或者使用控制台生成临时的 Token。


## 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO/API-Examples.git
```

2. 该仓库中包含声网实时音频 SDK 和视频 SDK 的 Native 平台示例项目，其中 Android 平台的示例项目如下：

| 路径                        | 描述                           |
|:---------------------------|:-------------------------------|
| `/Android/APIExample`      | 声网**视频** SDK 的 API 使用示例。 |
| `/Android/APIExample-Audio`| 声网**音频** SDK 的 API 使用示例。 |

//TODO: 虽然不写音频的步骤了，但是我们有纯音频的 demo 还是要提到一下。另外竞品的跑通文档有很细的目录结构，指明部分核心功能的实现去参考哪个路径下的文件，这个可以看下要不要，我们的 guide 也会提到就是了。详见 https://doc-zh.zego.im/article/3125。


## 配置示例项目

<div class="alert info">本文以视频示例项目为例。如需跑通音频示例项目，参考以下步骤在音频文件夹下操作即可。</div>

1. 集成 SDK 并安装依赖

`/APIExample/app/build.gradle` 文件中已添加集成 SDK 及安装依赖所需的代码，SDK 会在同步 Gradle 后自动完成集成，无需额外的集成操作。

2. 设置 App ID 和 App 证书

打开 `/APIExample/app/src/main/res/values/string-config.xml` 文件，在 `YOUR APP ID` 和 `YOUR APP CERTIFICATE` 中填入你从声网控制台获取的 App ID 和 App 证书。

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!--
    声网 App ID
    -->
    <string name="agora_app_id" translatable="false">YOUR APP ID</string>

    <!--
    声网 App 证书
    注意：如果项目没有开启证书鉴权，这个字段留空。
    -->
    <string name="agora_app_certificate" translatable="false">YOUR APP CERTIFICATE</string>

</resources>
```

//TODO: 获取的步骤我觉得可以不写，前提条件里说清楚就好了，must have的只有一个 app id 字段


## 运行示例项目

![](https://web-cdn.agora.io/docs-files/1689673656753)

1. 用 Android Studio 打开 `/API-Examples/Android/APIExample` 文件夹。

2. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑，并在 Android 设备选项中勾选你的 Android 设备。

3. 在 Android Studio 中，点击 <img src="https://web-cdn.agora.io/docs-files/1689672727614" width="25"/> 进行 Gradle 同步。

4. 待同步成功后，点击 <img src="https://web-cdn.agora.io/docs-files/1687670569781" width="25"/> 开始编译。

5. 编译成功后，你的 Android 设备上会出现 **Agora API Example** 应用。

6. 打开应用，体验声网视频 SDK 的基础和进阶功能。以 **视频互动直播** 为例。点击 **视频互动直播**，输入频道 ID 并加入频道，你可以在本地视图中看到自己。此时，邀请一位朋友使用另一台设备，输入相同的频道 ID 并加入频道。你们会看到彼此，并听到彼此的声音。

//TODO: 需要截图么？