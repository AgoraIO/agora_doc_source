声网在 GitHub 上提供开源示例项目 [API-Examples](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/main/example) 演示声网实时音视频 SDK 的 API 使用示例，以帮助开发者更好地理解和运用声网 SDK 的功能。

本文介绍如何快速跑通 Flutter 示例项目，体验实时音视频功能。


## 前提条件

- Flutter 2.10.5 或更高版本
- Dart 2.14.0 或更高版本
- 根据你的目标平台，准备对应的开发和运行环境：
    | 目标平台 | 环境要求 |
    |:-------|:------------|
    | iOS | <ul><li>macOS 10.15 或更高版本</li><li>最新版本的 Xcode</li><li>两台 iOS 设备</li></ul> |
    | Android | <ul><li>macOS 10.15 或更高版本</li><li>Windows 10 或更高版本</li><li>最新版本的 Android Studio</li><li>两台 Android 设备</li></ul> |
    | macOS | <ul><li>macOS 10.15 或更高版本</li><li>最新版本的 Xcode</li><li>两台 macOS 设备</li></ul> |
    | Windows | <ul><li>Windows 10 或更高版本</li><li>最新版本的 Visual Studio</li><li>两台 Windows 设备</li></ul> |
    <div class="alert info"><ul><li>更多环境要求细节，详见 <a href="https://docs.flutter.dev/get-started/install">Install Flutter</a>。</li><li>你可以运行 <code>flutter doctor</code> 命令检查开发和运行环境是否达到要求。</li></ul><div>
- 一个有效的[声网账号](https://docs.agora.io/cn/Agora Platform/sign_in_and_sign_up)以及声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora Platform/get_appid_token?platform=All Platforms)从声网控制台获得以下信息：
  - App ID：声网随机生成的字符串，用于识别你的项目。
  - 临时 token：token 也称为动态密钥，在客户端加入频道时对用户鉴权。临时 token 的有效期为 24 小时。
  - 频道名：用于标识频道的字符串。


## 操作步骤

### 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Extensions/Agora-Flutter-SDK.git
```

2. 其中基础功能和进阶功能的示例项目路径如下：

| 路径                        | 描述                           |
|:---------------------------|:-------------------------------|
| `/example/lib/examples/basic`      | 基础功能。 |
| `/example/lib/examples/advanced`   | 进阶功能。 |


### 配置示例项目

1. 集成 SDK 并安装依赖

在仓库的本地目录下，运行以下命令集成 SDK 并安装依赖项：

```dart
flutter pub get
```

2. 设置 App ID 和临时 Token

打开 `/example/lib/config/agora.config.dart` 文件，在 `<TEST_APP_ID>`、`<TEST_TOKEN>` 和 `<TEST_CHANNEL_ID>` 中分别填入你从控制台获取的 App ID、临时 Token 以及生成 Token 时使用的频道名。

```dart
/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<TEST_APP_ID>');
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('TEST_TOKEN',
      defaultValue: '<TEST_TOKEN>');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return const String.fromEnvironment(
    'TEST_CHANNEL_ID',
    defaultValue: '<TEST_CHANNEL_ID>',
  );
}
```


### 编译并运行示例项目

1. 用 Android Studio 打开 `/API-Examples/Android/APIExample` 文件夹。

2. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑，并在 Android 设备选项中勾选你的 Android 设备。
![](https://web-cdn.agora.io/docs-files/1690450282833)

3. 在 Android Studio 中，点击 <img src="https://web-cdn.agora.io/docs-files/1689672727614" width="25"/> 进行 Gradle 同步。

4. 待同步成功后，点击 <img src="https://web-cdn.agora.io/docs-files/1687670569781" width="25"/> 开始编译。

5. 编译成功后，你的 Android 设备上会出现 <img src="https://web-cdn.agora.io/docs-files/1690450345873" width="25"> 应用。

6. 打开 **Agora API Example** 应用后，你可以任意选择你想体验的场景。以 **视频互动直播** 为例，输入频道名（如 `test`），并点击**加入频道**。
![](https://web-cdn.agora.io/docs-files/1690450380432)

7. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目（需确保 App ID 不变）。以 **视频互动直播** 为例，你们输入相同的频道名并加入频道后，你们会看到彼此，并听到彼此的声音。
![](https://web-cdn.agora.io/docs-files/1690450398617)