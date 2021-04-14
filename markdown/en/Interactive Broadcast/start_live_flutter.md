---
title: Start Interactive Live Video Streaming
platform: Flutter
updatedAt: 2020-11-16 09:25:40
---
This page includes the following sections:

- [Run the sample project](#Run-the-sample-project): Agora provides an [open-source sample project] on GitHub that implements Agora Flutter Quickstart. Learn how to run the sample project.
- [Implement live video streaming](#Implement-live-video-streaming): Learn how to create a simple project and implement live video streaming using the Agora Flutter SDK.

## Run the sample project

### Prerequisites

#### Development environment

If your target platform is iOS, your development environment must meet the following requirements:

- Flutter 2.0.0 or later
- macOS
- Xcode (Latest version recommended)

If your target platform is Android, your development environment must meet the following requirements:

- Flutter 2.0.0 or later
- macOS or Windows 
- Android Studio (Latest version recommended)

#### Deployment environment

- If your target platform is iOS, you need a real iOS device.
- If your target platform is Android, you need an Android simulator or a real Android device.

<div class="alert note">You need to run <code>flutter doctor</code> to check whether the development environment and the deployment environment are correct.</div>

#### Other

A valid Agora [developer account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).

### Steps to run

**Step 1. Create an Agora project**

Take the following steps to create an Agora project in Agora Console.

1. Log in to Agora [Console](https://console.agora.io/) and click ![img](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

2. Click **Create**.

   ![img](https://web-cdn.agora.io/docs-files/1574924327108)

3. Enter your project name, set the App ID authentication mechanism as **APP ID + Token** in the dialog box, and click **Submit**.

4. When the project is created successfully, you can see the newly created project in the project list. Agora assigns an App ID to each project as the only identifier.

**Step 2. Get App ID**

Click ![img](https://web-cdn.agora.io/docs-files/1592488399929) to view and copy the App ID.

![img](https://web-cdn.agora.io/docs-files/1574924570426)

**Step 3. Generate a temporary token**

To facilitate authentication at the test stage, Agora Console provides temporary tokens. Take the following steps to generate a temporary token:

1. On the Project Management page, find the project for which you want to generate a temporary token, and click ![img](https://web-cdn.agora.io/docs-files/1574923151660).

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. On the Token page, enter the name of the channel that you want to join, and click Generate Temp Token to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)

  <div class="alert note">When in a production environment, Agora recommends generating a token at your server by calling <code>buildTokenWithUid</code>. See <a href="https://docs.agora.io/en/Audio%20Broadcast/token_server">Generate a token</a>.</div>


**Step 4. Run the project**

1. Download the [Agora-Flutter-Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) repository. Open `settings.dart` (`lib/src/utils/settings.dart`). Add App ID and Token.

	```
  const APP_ID ="";
  const Token ="";
	```

2. Run the following command to install dependencies.

	 ```bash
   flutter packages get
	 ```

3. Run the project.

   ```bash
   flutter run
   ```

## Create a Flutter Project

This article uses Visual Studio Code to create a Flutter project. Before you begin, you need to install the Flutter plugin in Visual Studio Code. See [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode).

1. Launch Visual Studio Code. Select the **Flutter: New Project** command in **View > Command**. Enter the project name and press /<Enter/>. 
2. Select the location of the project in the pop-up window. Visual Studio Code automatically generates a simple project.

### Add dependencies

Add the following dependencies in `pubspec.yaml`:

1. Add the `agora_rtc_engine` dependency to integrate Agora Flutter SDK. See https://pub.dev/packages/agora_rtc_engine for the latest version of agora_rtc_engine.
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
  agora_rtc_engine: ^3.0.1-dev.7
  permission_handler: ^3.0.0
```

### Implement live interactive video streaming

Open `main.dart`, remove all code after

```
void main() => runApp(MyApp());
```

Use these steps to add the following code:

### Step 1: Define App ID and Token

```
/// Define App ID and Token
const APP_ID = '<Your App ID>';
const Token = '<Your Token>';
```

### Step 2: Define MyApp Class


```
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
```

###  Step 3: Define UI and code logic of the login page

1. Ensure that you have imported the following packages in the file header:

```
import 'dart:async';
  
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```

2. Define `IndexPage` class for the login page and the `IndexState` class for the state of the login page:

```
class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}
 
class IndexState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole _role = ClientRole.Broadcaster;
  
  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }
```

3. Set the UI layout of the login page:

```
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Agora Flutter QuickStart'),
    ),
    body: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    errorText:
                        _validateError ? 'Channel name is mandatory' : null,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    hintText: 'Channel name',
                  ),
                ))
              ],
            ),
            Column(
              children: [
                ListTile(
                  title: Text(ClientRole.Broadcaster.toString()),
                  leading: Radio(
                    value: ClientRole.Broadcaster,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(ClientRole.Audience.toString()),
                  leading: Radio(
                    value: ClientRole.Audience,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: onJoin,
                      child: Text('Join'),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
```

4. Define the code logic to join a channel and handle device permissions.

```
  /// The button to join channel
  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // Wait for the permission for camera and microphone
      await _handleCameraAndMic();
      // Enter the page for live streaming and join channel using the channel name and role specified in the login page
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }
  
  // Ask for the permission for camera and microphone
  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
```

### Step 4: Define UI and code logic of the live streaming page

1. Ensure you have imported the following packages in the file header (in addition to the packages previously specified):

```
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
```

2. Define the CallPage class for the live streaming page.

```
class CallPage extends StatefulWidget {
  final String channelName;
  final ClientRole role;
  const CallPage({Key key, this.channelName, this.role}) : super(key: key);
  
  @override
  _CallPageState createState() => _CallPageState();
}
```

3. Define the CallPageState class for the state of the live streaming page.

```
class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine _engine;
  
  
  
  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    initialize();
  }
  
  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
  
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    await _engine.joinChannel(Token, widget.channelName, null, 0);
  }
```

4. Define the RTC client instance, channel profile, and user role:

```
Future<void> _initAgoraRtcEngine() async {
  _engine = await RtcEngine.create(APP_ID);
  await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  await _engine.setClientRole(widget.role);
}
```

5. Define event handlers:

```
void _addAgoraEventHandlers() {
  _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
    setState(() {
      final info = 'onError: $code';
      _infoStrings.add(info);
    });
  }, joinChannelSuccess: (channel, uid, elapsed) {
    setState(() {
      final info = 'onJoinChannel: $channel, uid: $uid';
      _infoStrings.add(info);
    });
  }, leaveChannel: (stats) {
    setState(() {
      _infoStrings.add('onLeaveChannel');
      _users.clear();
    });
  }, userJoined: (uid, elapsed) {
    setState(() {
      final info = 'userJoined: $uid';
      _infoStrings.add(info);
      _users.add(uid);
    });
  }, userOffline: (uid, elapsed) {
    setState(() {
      final info = 'userOffline: $uid';
      _infoStrings.add(info);
      _users.remove(uid);
    });
  }));
}
```

6. Define the UI of the live streaming page:

```
  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }
  
  
 // Information panel to display logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
/// Stop live streaming
void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }
  
  /// Mute
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _panel(),
            _toolbar(),
          ],
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

