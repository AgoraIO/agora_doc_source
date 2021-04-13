---
title: Start Voice Call
platform: Flutter
updatedAt: 2020-11-13 06:44:24
---
## Prerequisites

### Development environment

If your target platform is iOS, your development environment must meet the following requirements:

- Flutter 1.0.0 or later (Flutter 2.x is not supported)
- macOS
- Xcode (Latest version recommended)

If your target platform is Android, your development environment must meet the following requirements:

- Flutter 1.0.0 or later (Flutter 2.x is not supported)
- macOS or Windows 
- Android Studio (Latest version recommended)

### Deployment environment

- If your target platform is iOS, you need a real iOS device.
- If your target platform is Android, you need an Android simulator or a real Android device.

<div class="alert note">You need to run <code>flutter doctor</code> to check whether the development environment and the deployment environment are correct.</div>

### Other

A valid Agora [developer account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).

## Create a Flutter Project

This article uses Visual Studio Code to create a Flutter project. Before you begin, you need to install the Flutter plugin in Visual Studio Code. See [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode).

1. Launch Visual Studio Code. Select the **Flutter: New Project** command in **View > Command**. Enter the project name and press `<Enter>`. 
2. Select the location of the project in the pop-up window. Visual Studio Code automatically generates a simple project.

## Add dependencies

Add the following dependencies in `pubspec.yaml`:

1. Add the `agora_rtc_engine` dependency to integrate Agora Flutter SDK. See https://pub.dev/packages/agora_rtc_engine for the latest version of `agora_rtc_engine`.
2. Add the `permission_handler` dependency to add the permission handling function.

```
environment:
  sdk: ">=2.7.0 <3.0.0"
  
dependencies:
  flutter:
    sdk: flutter
  
  
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
	# Please use the latest version of agora_rtc_engine
  agora_rtc_engine: ^3.1.2
  permission_handler: ^3.0.0
```

## Implement voice call

Open `main.dart`, remove all code after

```
void main() => runApp(MyApp());
```

Use these steps to add the following code:


## Step 1: Import packages

```
import 'dart:async';
 
 
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```


## Step 2: Define App ID and Token

See [Set up Authentication](/en/Agora%20Platform/token?platform=All%20Platforms).


```
/// Define App ID and Token
const APP_ID = '<Your App ID>';
const Token = '<Your Token>';
```

## Step 3: Define MyApp Class


```
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
```

## Step 4: Define app states

```
// App state
class _MyAppState extends State<MyApp> {
  bool _joined = false;
  int _remoteUid = null;
  bool _switch = false;
 
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
 
  // Initialize the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    await PermissionHandler().requestPermissions(
      [PermissionGroup.microphone],
    );
     
    // Create RTC client instance
    var engine = await RtcEngine.create(APP_ID);
    // Define event handler
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
    // Join channel 123
    await engine.joinChannel(Token, '123', null, 0);
  }
 
  // Create a simple chat UI
	Widget build(BuildContext context) {
			return MaterialApp(
				title: 'Agora Audio quickstart',
				home: Scaffold(
					appBar: AppBar(
						title: Text('Agora Audio quickstart'),
					),
					body: Center(
						child: Text('Please chat!'),
					),
				),
			);
		}
}
```


## Run the project

1. Run the following command in the root folder to install dependencies.

```
flutter packages get
```

2. Run the project.

```
flutter run
```

## Common issues

If the deployment environment is Android, users in mainland China may get stuck in `Running Gradle task 'assembleDebug'...` or see the following error:

```
Running Gradle task 'assembleDebug'...
Exception in thread "main" java.net.ConnectException: Connection timed out: connect
```

Take the following steps to resolve this issue:

1. In the `build.gradle` file of the Android project, use mirrors in China for `google` and `jcenter.`

```
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

2. In the `gradle-wrapper.properties` file, set `distributionUrl` to a local file. For example, for gradle 5.6.4, you can copy `gradle-5.6.4-all.zip` to `gradle/wrapper` and set `distributionUrl` to:

```
distributionUrl=gradle-5.6.4-all.zip
```

