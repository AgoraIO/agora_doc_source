# Start a Video Call

~0ff6a410-5cb9-11ec-af4b-2b38abdb1c68~

## Get App ID and token

### 1. Create an Agora project

~360159b0-2494-11eb-a6fc-dfd7ed4260bd~

### 2. Get an App ID

~a57db1d0-2494-11eb-a6fc-dfd7ed4260bd~

### 3. Generate a temporary token

~7883e950-2495-11eb-a6fc-dfd7ed4260bd~

## Create a Flutter Project

This article uses Visual Studio Code to create a Flutter project. Before you begin, you need to install the Flutter plugin in Visual Studio Code. See [Set up an editor](https://flutter.dev/docs/get-started/editor?tab=vscode).

1. Launch Visual Studio Code. Select the **Flutter: New Project** command in **View > Command**. Enter the project name and press `<Enter>`.
2. Select the location of the project in the pop-up window. Visual Studio Code automatically generates a simple project.

## Add dependencies

Add the following dependencies in `pubspec.yaml`:

1. Add the `agora_rtc_engine` dependency to integrate Agora Flutter SDK. See [https://pub.dev/packages/agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine) for the latest version of `agora_rtc_engine`.
2. Add the `permission_handler` dependency to add the permission handling function.

```
environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  # Please use the latest version of agora_rtc_engine
  agora_rtc_engine: ^6.0.0
  permission_handler: ^8.3.0
```

## Implement video call

Open `main.dart`, remove all code after `void main() => runApp(MyApp());`.

<div class="alert note">If your first line is not <code>void main() => runApp(MyApp());</code>, replace it with <code>void main() => runApp(MyApp());</code> and remove all code after it.</div>

Refer to the following steps to add code to the file:

### 1. Import packages

```dart
import 'dart:async';
 
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
```


### 2. Define App ID and Token

See [Set up Authentication](/en/Agora%20Platform/token_server?platform=All%20Platforms).


```dart
const appId = "<-- Insert App Id -->";
const token = "<-- Insert Token -->";
const channel = "<-- Insert Channel Name -->";
```

### 3. Define MyApp Class

```dart
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  _MyAppState createState() => _MyAppState();
}
```

### 4. Define app states

Define the application state class with the following settings:

- Get camera, microphone, storage permissions
- Create RTC client instance
- Define event handling logic
- open video
- Join channel
- Create UI

```dart
// App state class
class _MyAppState extends State<MyApp> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
 
  @override
  void initState() {
    super.initState();
    initAgora();
  }
 
  // Init the app
  Future<void> initAgora() async {
    // Get permission
    await [Permission.microphone, Permission.camera].request();
 
    // Create RtcEngine
    _engine = await createAgoraRtcEngine();
 
 
    // Initialize RtcEngine
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
    // Enable video
    await _engine.setClientRole(ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
    // Join channel with channel name as channel
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      info: '',
      uid: 0,
    );
  }
 
  // Build UI
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
 
  
  // Remote video rendering
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


## Run the project

1. Run the following command in the root folder to install dependencies.

	```shell
	flutter packages get
	```

2. Select the device to run your project on from the status bar of Visual Studio Code and run the project.

	```shell
	flutter run
	```
	
## See also

This section provides additional information for your reference.

### Sample project

Agora provides an open source video call [sample project](https://github.com/AgoraIO/Agora-Flutter-SDK/tree/main/example) on GitHub for your reference.

