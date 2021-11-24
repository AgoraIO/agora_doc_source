~55e346b0-2193-11ec-837a-476ce6215fac~

## 前提条件

### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本
- Dart 2.12.0 或更高版本
- macOS 操作系统
- 最新版本的 Xcode
- 最新版本的 Visual Studio Code

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本
- Dart 2.12.0 或更高版本
- macOS 或 Windows 操作系统
- 最新版本的 Android Studio
- 最新版本的 Visual Studio Code

### 运行环境要求

- 如果你的目标平台为 iOS，你需要有一台 iOS 的真机。
- 如果你的目标平台为 Android，你需要有一台 Android 真机或模拟器。

<div class="alert note">你需要运行 <code>flutter doctor</code> 命令检查开发环境和运行环境是否满足要求。</div>

## 搭建开发环境

本节介绍如何为你的视频通话项目搭建开发环境。

### 创建 Flutter 项目

本文使用 Visual Studio Code 创建 Flutter 项目。你需要在 Visual Studio Code 中安装 Flutter plugin。关于详细设置可以参考 [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode)。

1. 打开 Visual Studio Code，在 **View > Command** 菜单选择 **Flutter: New Project** 命令，按回车键，然后输入项目名称，按回车键。在弹出的窗口中选择项目的创建位置。
2. 选择完成后，Visual Studio Code 会自动生成一个简单的示例项目。

### 集成 SDK

在 `pubspec.yaml` 文件中添加以下依赖项：

1. 添加 `agora_rtc_engine` 依赖项，集成 Agora Flutter SDK。关于 `agora_rtc_engine` 的最新版本可以查询 [https://pub.dev/packages/agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine)。
2. 添加 `permission_handler` 依赖项，安装权限处理插件。

```yaml
environment:
  sdk: ">=2.12.0 <3.0.0"

# 依赖项
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  # Agora Flutter SDK 依赖项，请使用最新版本的 agora_rtc_engine
  # TODO 目前暂时使用本地 build，等正式版本号确定再更新集成方式
  agora_rtc_engine:
    path: ../
  #  权限处理插件依赖项
  permission_handler: ^6.0.0
```

~c05361b0-bd52-11eb-8c2a-ebc670144d74~

## 在客户端实现视频通话

本节介绍如何使用 Agora 视频 SDK 在你的 app 里实现视频通话。

打开 `main.dart`，删除

```dart
void main() => runApp(MyApp());
```

语句下方的全部代码。并按照步骤增加以下代码：

### 1. 导入 package

导入以下 package：

```dart
import 'package:agora_rtc_flutter/agora_rtc_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```

### 2. 定义 Flutter 应用类

定义应用类 `MyApp`：

```dart
// 应用类
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
```

### 3. 定义应用状态类

1. 定义应用状态类 `_MyAppState`。后续步骤中的代码均在 `_MyAppState` 类中实现。

   ```dart
   class _MyAppState extends State<MyApp> with IRtcEngineEventHandler {

   }
   ```

2. 在 `_MyAppState` 类中定义全局变量。你需要将 `<Your App ID>` 和 `<Your Token>` 替换为你的 App ID 和 Token。

   ```dart
   // 定义 App ID 和 Token
   final appId = '<Your App ID>';
   final token = "<Your Token>";
   List<int> _remoteUids = [];
   final channelId = 'testChannel';
   final uid = 1234;
   ```

3. 创建客户端实例。

   ```dart
   IRtcEngine _engine = IRtcEngine.createAgoraRtcEngine();
   ```

4. 实现以下方法。

   ```dart
   _initialize() async {
       // 注册事件处理对象
       _engine.registerEventHandler(this);
       // 初始化客户端对象
       await _engine.initialize(RtcEngineContext(appId: appId, eventHandler: this));
       // 开启视频模块
       await _engine.enableVideo();
       // 开启视频预览
       await _engine.startPreview();
   }

   _joinChannel() async {
       // 对于 Android 平台，请求麦克风和摄像机权限
       if (defaultTargetPlatform == TargetPlatform.android) {
           await [Permission.microphone, Permission.camera].request();
       }

       ChannelMediaOptions options = ChannelMediaOptions(
         // 设置频道场景
         channelProfile: CHANNEL_PROFILE_TYPE.CHANNEL_PROFILE_COMMUNICATION,
         // 设置客户端角色为 CLIENT_ROLE_BROADCASTER
         clientRoleType: CLIENT_ROLE_TYPE.CLIENT_ROLE_BROADCASTER
       );

       // 加入频道
       await _engine.joinChannel2(token, channelId, uid, options);
   }

   _leaveChannel() async {
   // 离开频道
   await _engine.leaveChannel();
   }

   _reverseRenderer() {
   setState(() {
     _remoteUids = List.of(_remoteUids.reversed);
   });

   }
   ```

5. 重写以下回调。

   ```dart
   // 在 initState 回调中执行 _initialize() 和 _joinChannel 方法。
   @override
   void initState() {
   super.initState();
   _initialize();
   _joinChannel();
   }

   // 在 dispose 回调中执行 _leaveChannel()、 unregisterEventHandler() 和 release() 方法。
   @override
   void dispose() {
   super.dispose();
   _leaveChannel();
   _engine.unregisterEventHandler(this);
   _engine.release();
   }

   // 本地用户加入频道成功回调
   @override
   void onJoinChannelSuccess(RtcConnection connection, int elapsed) {
       print('onJoinChannelSuccess $connection $elapsed');
   }

   // 本地用户离开频道成功回调
   @override
   void onLeaveChannel(RtcConnection connection, RtcStats stats) {
       print('onLeaveChannel $connection $stats');
   }

   // 远端用户加入频道成功回调，在 _remoteUids 中插入新加入频道的 remoteUid
   @override
   void onUserJoined(RtcConnection connection, uid_t remoteUid, int elapsed) {
       print('onUserJoined $connection $remoteUid $elapsed');
       setState(() {
       _remoteUids.add(remoteUid);
       });
   }

   // 远端用户离开频道回调，在 _remoteUids 中删除离开频道的 remoteUid
   @override
   void onUserOffline(RtcConnection connection, uid_t remoteUid,
       USER_OFFLINE_REASON_TYPE reason) {
       print('onUserOffline $connection $remoteUid $reason');
       setState(() {
       _remoteUids.removeWhere((element) => element == remoteUid);
       });
   }
   ```

6. 构建界面 Widget。在界面上渲染本地和远端视频。

   ```dart
   @override
   Widget build(BuildContext context) {
       return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: const Text('Flutter example app'),
       ),
       body: Stack(children: [
         // 渲染本地视频
         RtcSurfaceView(canvas: VideoCanvas(uid: 0)),
       Align(
         alignment: Alignment.topLeft,
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             children: List.of(_remoteUids.map(
               // 根据 _remoteUids 中的 uid 列表渲染远端视频
               (e) => GestureDetector(
                 onTap: _reverseRenderer,
                 child: SizedBox(
                   width: 120,
                   height: 120,
                   child:
                       // 根据远端用户的 uid 渲染远端视频
                       RtcSurfaceView(canvas: VideoCanvas(uid: e)),
                 ),
               ),
               ),
             )),
           ),
         ),
       ]),
      ),
    );
   }
   ```

## 运行项目

1. 在项目根目录运行以下命令安装依赖项。

   ```bash
   flutter packages get
   ```

2. 运行项目。

   ```bash
   flutter run
   ```

## 后续步骤

在测试或生产环境中，为保证通信安全，Agora 推荐从服务器中获取 Token，详情请参考[使用 Token 鉴权](./token_server_android_ng?)。

## 相关信息

本节提供了额外的信息供参考。

<a id="othermethods"></a>

### 常见问题

如果运行环境为 Android，对于中国大陆用户，运行 `flutter run` 时可能会卡在 `Running Gradle task 'assembleDebug'...` 或出现以下错误：

```shell
Running Gradle task 'assembleDebug'...
Exception in thread "main" java.net.ConnectException: Connection timed out: connect
```

解决方案如下：

1. 在相应 Android 项目的 `build.gradle` 文件中，使用国内镜像源。下面的示例代码使用了阿里镜像源。

```java
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/public' }
    }

...

allprojects {
    repositories {
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/public' }
    }
}
```

2. 在相应 Android 项目的 `gradle-wrapper.properties` 文件中，将 `distributionUrl` 设为本地路径。以 gradle 5.6.4 为例，你可以将 `gradle-5.6.4-all.zip` 文件复制到 `gradle/wrapper` 目录，然后 `distributionUrl` 设置为：

```shell
distributionUrl=gradle-5.6.4-all.zip
```
