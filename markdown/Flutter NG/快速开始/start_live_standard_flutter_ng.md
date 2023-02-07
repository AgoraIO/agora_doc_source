# 实现视频直播

声网极速直播让你在 app 里轻松实现音视频直播功能，用户可以实时进行深入交流，创造更多商业机会。

本文介绍如何通过最简单的代码来集成声网视频 SDK，在你的 Android app 里实现高质量的音视频直播功能。

## 技术原理

下图展示在 app 中实现声网极速直播的基本工作流程：

![](https://web-cdn.agora.io/docs-files/1642671754778)

参考以下步骤，在你的 app 中实现极速直播功能：

1. **设置用户角色**

   在极速直播中，用户角色可分为主播和观众，其中观众的用户级别为 `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY`。主播可在频道中发流，观众可接收频道中的音视频流。

2. **加入频道**

   调用 `joinChannel` 方法来创建并加入频道。在 App ID 一致的前提下，传入相同频道名的用户会进入同一个频道。

3. **在频道中发布并接收音视频流**

   加入频道后，主播可在频道中发流，并接收其他主播在频道中发布的音视频流。

4. **在频道中接收音视频流**

   观众只能接收主播在频道中发布的音视频流，你可以调用 `setClientRole` 将用户角色从观众切换为主播。
	 
~eb245b60-67b6-11ec-9efd-4ba4c822b48e~


## 获取 App ID 和 Token

### 1. 创建项目

~4c028930-19e2-11eb-b0e2-eb6c69fefbc6~

### 2. 获取项目的 App ID

~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

### 3. 生成临时 Token

~e6996180-a945-11e9-9e5e-256c0a74561a~


## 创建 Flutter 项目

本文使用 Visual Studio Code 创建 Flutter 项目。你需要在 Visual Studio Code 中安装 Flutter plugin。关于详细设置可以参考 [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode)。

1. 打开 Visual Studio Code，在 **View > Command** 菜单选择 **Flutter: New Project** 命令，按回车键，然后输入项目名称，按回车键。在弹出的窗口中选择项目的创建位置。
2. 选择完成后，Visual Studio Code 会自动生成一个简单的示例项目。

## 添加依赖项

在 `pubspec.yaml` 文件中添加以下依赖项：

1. 添加 `agora_rtc_engine` 依赖项，集成声网 Flutter SDK。关于 `agora_rtc_engine` 的最新版本可以查询 [https://pub.dev/packages/agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine)。
3. 添加 `permission_handler` 依赖项，安装权限处理插件。

```
environment:
  sdk: ">=2.12.0 <3.0.0"

# 依赖项
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  # 声网 Flutter SDK 依赖项，请使用最新版本的 agora_rtc_engine
  agora_rtc_engine: ^6.0.0
  #  权限处理插件依赖项
  permission_handler: ^8.3.0
```



## 基本流程

打开 `main.dart`，删除  `void main() => runApp(MyApp());` 语句下方的全部代码。并按照步骤增加以下代码：

<div class="alert note">如果你的第一行语句不是 <code>void main() => runApp(MyApp());</code>，你需要将其替换为 <code>void main() => runApp(MyApp());</code> 并删除下方的全部代码。</div>

### 1. 导入 package

导入以下 package：

```dart
import 'dart:async';
 
import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```

### 2. 定义 App ID 和 Token

输入你获得的 App ID 和临时 Token。

```dart
/// 定义 App ID 和 Token
const appId = "<-- Insert App Id -->";
const token = "<-- Insert Token -->";
const channel = "<-- Insert Channel Name -->";
```


### 3. 定义 Flutter 应用类

定义 MyApp 应用类：

```dart
// 应用类
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  _MyAppState createState() => _MyAppState();
}
```

### 4. 定义应用状态类

定义应用状态类，包含以下设置：

- 获取摄像头、麦克风、存储权限
- 创建 RTC 客户端实例
- 定义事件处理逻辑
- 开启视频
- 加入频道
- 构建 UI

```dart
// 应用状态类
class _MyAppState extends State<MyApp> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
 
  @override
  void initState() {
    super.initState();
    initAgora();
  }
 
  // 初始化应用
  Future<void> initAgora() async {
    // 获取权限
    await [Permission.microphone, Permission.camera].request();
 
    //创建 RtcEngine
    _engine = await createAgoraRtcEngine();
 
 
    // 初始化 RtcEngine
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
 
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    // 开启视频
    await _engine.setClientRole(ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
    // 加入频道
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      info: '',
      uid: 0,
    );
  }
 
  // 构建 UI，显示本地视图和远端视图
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Agora Video Call'),
          ),
          body: Stack(
            children: [
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _localUserJoined
                        ? AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }
  
  // 生成远端视频
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}

```

## 运行项目

1. 在项目根目录运行以下命令安装依赖项。

    ```bash
    flutter packages get
    ```

2. 在 Visual Studio Code 右下角状态栏选择需要运行项目的设备。运行以下命令启动示例项目。

    ```bash
    flutter run
    ```

## 测试你的 app

按照以下步骤测试你的 app：

1. App 启动成功之后，你可以在本地视图中看到自己。
3. 请一位朋友使用另一台设备，输入相同的 App ID 、Token 和频道名称加入通话。 你们会看到彼此，并听到彼此的声音。

## 相关信息

本节提供了额外的信息供参考。

### 示例项目

声网在 GitHub 上提供了一个开源的互动直播[示例项目](https://github.com/AgoraIO/Agora-Flutter-SDK/tree/main/example)供你参考。