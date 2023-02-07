# 实现语音通话

$$ 3265bf10-5be5-11ec-af4b-2b38abdb1c68
{
  "feature": "语音通话",
  "product": "Agora 音频 SDK"
}
$$


## 技术原理
~4c205950-acd6-11ec-83d9-39fb20031be5~


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

- 获取麦克风权限
- 创建 RTC 客户端实例
- 定义事件处理逻辑
- 加入频道
- 构建 UI

```dart
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
    // 加入频道
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      info: '',
      uid: 0,
    );
  }
 
  // 构建 UI
  @override
    Widget build(BuildContext context) {
            return MaterialApp(
                title: 'Agora Voice Call',
                home: Scaffold(
                    appBar: AppBar(
                        title: Text('Agora Voice Call'),
                    ),
                    body: Center(
                        child: Text('Please chat!'),
                    ),
                ),
            );
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

1. 启动 app，你可以看到创建的用户界面。
2. 请一位朋友使用另一台设备，输入相同的 App ID 和频道名称。你的朋友加入频道后，你们可以听到彼此的声音。

## 相关信息

本节提供了额外的信息供参考。

### 示例项目

声网在 GitHub 上提供了一个开源的互动直播[示例项目](https://github.com/AgoraIO/Agora-Flutter-SDK/tree/main/example)供你参考。