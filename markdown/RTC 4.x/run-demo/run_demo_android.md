声网在 GitHub 上提供开源示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main) 演示声网实时音视频 SDK 的 API 使用示例，以帮助开发者更好地理解和运用声网 SDK 的功能。

本文介绍如何快速跑通 Android 示例项目，体验实时音视频功能。


## 前提条件

- [Android Studio](https://developer.android.com/studio/) 4.2 及以上。
- Android API 级别 21 及以上。
- 两台运行 Android 5.0 及以上版本的移动设备。
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms) 创建有效的声网账户和声网项目，并从声网控制台获取以下信息：
    - App ID：声网随机生成的字符串，用于识别你的 app。
    - (可选) App 证书：声网提供的 App 证书，用于在服务器部署并生成 Token，或者使用控制台生成临时的 Token。


## 操作步骤

### 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO/API-Examples.git
```

2. 该仓库中包含声网实时音视频 SDK 所有 Native 平台的示例项目，其中 Android 平台的 API 使用示例位于 `/Android` 路径下。

| 路径                        | 描述                           |
|:---------------------------|:-------------------------------|
| `/Android/APIExample`      | 声网**视频** SDK 的 API 使用示例。 |
| `/Android/APIExample-Audio`| 声网**音频** SDK 的 API 使用示例。 |


### 配置示例项目

<div class="alert info">本文以视频示例项目为例。如需跑通音频示例项目，参考以下步骤在音频文件夹下操作即可。</div>

1. 集成 SDK 并安装依赖

`/APIExample/app/build.gradle` 文件中已添加集成 SDK 及安装依赖所需的代码，SDK 会在同步 Gradle 后自动完成集成。

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


### 编译并运行示例项目

1. 用 Android Studio 打开 `/API-Examples/Android/APIExample` 文件夹。

2. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑，并在 Android 设备选项中勾选你的 Android 设备。
![](https://web-cdn.agora.io/docs-files/1690450282833)

3. 在 Android Studio 中，点击 <img src="https://web-cdn.agora.io/docs-files/1689672727614" width="25"/> 进行 Gradle 同步。

4. 待同步成功后，点击 <img src="https://web-cdn.agora.io/docs-files/1687670569781" width="25"/> 开始编译。

5. 编译成功后，你的 Android 设备上会出现 <img src="https://web-cdn.agora.io/docs-files/1690450345873" width="25"/> 应用。

6. 打开 **Agora API Example** 应用后，你可以任意选择你想体验的场景。以 **视频互动直播** 为例，输入频道名（如 `test`），并点击**加入频道**。
![](https://web-cdn.agora.io/docs-files/1690450380432)

7. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目（需确保 App ID 不变）。以 **视频互动直播** 为例，你们输入相同的频道名并加入频道后，你们会看到彼此，并听到彼此的声音。
![](https://web-cdn.agora.io/docs-files/1690450398617)