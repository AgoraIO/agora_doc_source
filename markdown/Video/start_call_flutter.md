---
title: 实现视频通话
platform: Flutter
updatedAt: 2020-12-14 02:00:34
---

Agora 在 GitHub 上提供一个开源的[一对一视频通话示例项目](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart)。本文分以下两个部分：

- [快速跑通示例项目](#快速跑通示例项目)介绍如何快速跑通该示例项目，体验 Agora 视频直播效果。
- [实现音频通话](#实现音频通话)详细介绍如何建立一个简单的项目并使用 Agora Flutter SDK 实现音频通话。

## 快速跑通示例项目

### 前提条件

#### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本（暂不支持 Flutter 2.x）
- macOS 操作系统
- 最新版本的 Xcode

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- Flutter 1.0.0 或更高版本（暂不支持 Flutter 2.x）
- macOS 或 Windows 操作系统
- 最新版本的 Android Studio

#### 运行环境要求

- 如果你的目标平台为 iOS，你需要有一台 iOS 的真机。
- 如果你的目标平台为 Android，你需要有一台 Android 真机或模拟器。

<div class="alert note">你需要运行 <code>flutter doctor</code> 命令检查开发环境和运行环境是否满足要求。</div>

#### 其他要求

一个有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

### 操作步骤

#### 步骤一：创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 Agora [控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://dashboard.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

   [![img](https://web-cdn.agora.io/docs-files/1594287028966)](https://dashboard.agora.io/projects)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID**。

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

#### 步骤二：获取 App ID

在控制台的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

#### 步骤三：生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

在控制台的项目管理页面，点击已创建项目的![](https://web-cdn.agora.io/docs-files/1602840930382)图标，打开 Token 页面。

1. 输入一个频道名，例如 test，然后点击生成临时 Token。临时 Token 的有效期为 24 小时。![](https://web-cdn.agora.io/docs-files/1602840948519)
2. 临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见[生成 Token](/cn/Video/token_server?platform=CPP)。![](https://web-cdn.agora.io/docs-files/1602840954561)

#### 步骤四：运行示例项目

1.  下载 [Agora-Flutter-Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) 仓库。打开 `settings.dart` (`lib/src/utils/settings.dart`)文件并添加 App ID 和 Token。

        ```

    const APP_ID = Your_App_ID;
    const Token = Your_Token;

    ```

    ```

2.  在仓库根目录运行以下命令安装依赖项。

    ```bash
    flutter packages get
    ```

3.  启动示例项目。

    ```bash
    flutter run
    ```

## 实现视频通话

### 创建 Flutter 项目

本文使用 Visual Studio Code 创建 Flutter 项目。你需要在 Visual Studio Code 中安装 Flutter plugin。关于详细设置可以参考 [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode)。

1. 打开 Visual Studio Code，在 **View > Command** 菜单选择 **Flutter: New Project** 命令，按回车键，然后输入项目名称，按回车键。在弹出的窗口中选择项目的创建位置。
2. 选择完成后，Visual Studio Code 会自动生成一个简单的示例项目。

### 添加依赖项

在 `pubspec.yaml` 文件中添加以下依赖项：

1. 添加 `agora_rtc_engine` 依赖项，集成 Agora Flutter SDK。关于 `agora_rtc_engine` 的最新版本可以查询 https://pub.dev/packages/agora_rtc_engine。
2. 添加 `permission_handler` 依赖项，安装权限处理插件。

```
environment:
  sdk: ">=2.7.0 <3.0.0"

// 依赖项
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  //  Agora Flutter SDK 依赖项
  agora_rtc_engine: ^3.0.1-dev.7
  //  权限处理插件依赖项
  permission_handler: ^3.0.0
```

### 基本流程

打开 `main.dart`，删除

```
void main() => runApp(MyApp());
```

语句下方的全部代码。并按照步骤增加以下代码：

#### 步骤一：导入 package

导入以下 package：

```
import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```

#### 步骤二：定义 App ID 和 Token

定义 App ID 和 Token：

```
/// 定义 App ID 和 Token
const APP_ID = '<Your App ID>';
const Token = '<Your Token>';
```

#### 步骤三：定义 Flutter 应用类

定义 MyApp 应用类：

```
// 应用类
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
```

#### 步骤四：定义应用状态类

定义应用状态类，包含以下设置：

- 获取摄像头、麦克风、存储权限
- 创建 RTC 客户端实例
- 定义事件处理逻辑
- 开启视频
- 加入频道
- 构建 UI

```
// 应用状态类
class _MyAppState extends State<MyApp> {
  bool _joined = false;
  int _remoteUid = null;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // 初始化应用
  Future<void> initPlatformState() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );

    // 创建 RTC 客户端实例
    var engine = await RtcEngine.create(APP_ID);
    // 定义事件处理逻辑
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = null;
      });
    }));
    // 开启视频
    await engine.enableVideo();
    // 加入频道,频道名为 123
    await engine.joinChannel(Token, '123', null, 0);
  }


  // 构建 UI，显示本地视图和远端视图
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter example app'),
        ),
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                    _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 生成本地预览
  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // 生成远端预览
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
```

### 运行项目

1. 在项目根目录运行以下命令安装依赖项。

   ```bash
    flutter packages get
   ```

2. 运行项目。

   ```bash
   flutter run
   ```

### 常见问题

如果运行环境为 Android，对于中国大陆用户，运行 `flutter run` 时可能会卡在 `Running Gradle task 'assembleDebug'...` 或出现以下错误：

```dart
Running Gradle task 'assembleDebug'...
Exception in thread "main" java.net.ConnectException: Connection timed out: connect
```

解决方案如下：

1. 在相应 Android 项目的 `build.gradle` 文件中，对于 `google` 和 `jcenter` 使用国内镜像源。下面的示例代码使用了阿里镜像源。

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

```
distributionUrl=gradle-5.6.4-all.zip
```
