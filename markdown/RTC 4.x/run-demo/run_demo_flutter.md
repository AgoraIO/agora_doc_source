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

2. 声网实时音视频 Flutter SDK 的 API 使用示例位于 `/example` 路径下。

| 路径                        | 描述                           |
|:---------------------------|:-------------------------------|
| `/example/lib/examples/basic`      | 基础功能。 |
| `/example/lib/examples/advanced`   | 进阶功能。 |


### 配置示例项目

1. 集成 SDK 并安装依赖

在仓库的本地目录下，运行以下命令集成 SDK 并安装依赖项：

```shell
flutter pub get
```

2. 设置 App ID 和临时 Token

打开 `/example/lib/config/agora.config.dart` 文件，将 `<TEST_APP_ID>`、`<TEST_TOKEN>` 和 `<TEST_CHANNEL_ID>` 分别替换为你从控制台获取的 App ID、临时 Token 以及生成 Token 时使用的频道名。

```dart
String get appId {
  return const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<TEST_APP_ID>');
}

String get token {
  return const String.fromEnvironment('TEST_TOKEN',
      defaultValue: '<TEST_TOKEN>');
}

String get channelId {
  return const String.fromEnvironment(
    'TEST_CHANNEL_ID',
    defaultValue: '<TEST_CHANNEL_ID>',
  );
}
```


### 编译并运行示例项目

1. 将目标设备连接到电脑。

2. 打开终端，导航到 `/examples` 目录。

3. 运行以下命令在可用设备上运行 Flutter 示例项目。

```shell
flutter run
```

4. 以 macOS 为例，编译完成后，你的设备上会弹出以下应用。

![](https://web-cdn.agora.io/docs-files/1692001262062)

5. 你可以任意选择你想体验的场景。以 **Basic** 中的 **JoinChannelVideo** 为例，在 **Channel ID** 中输入生成临时 token 时指定的频道名，并点击 **Join channel** 加入频道。

6. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目，使用相同的 App ID、Token 和频道名加入频道，你们会看到并听到彼此。

![](https://web-cdn.agora.io/docs-files/1692001319323)