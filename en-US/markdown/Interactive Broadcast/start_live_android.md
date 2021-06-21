# Start Interactive Live Video Streaming

The Agora Video SDK for Android makes it easy to embed interactive live streaming into Android apps. It enables you to develop reapidly to enhance your social, work, education and IoT apps with real-time engagement.

This page shows the minimum code you need to add interactive live streaming into your Android app by using the Agora Video SDK for Android.

## Understand the tech

The following figure shows the workflow of interactive live streaming implemented by the Agora SDK.

![](images/live_streaming_tech.png)


To start interactive live streaming, your app client has the following steps to take: 

**1. Set the client role**
An interactive live streaming session differs from a voice or video call in that users in a live streaming channel have different roles: host (`BROADCASTER`) and audience (`AUDIENCE`). 
Only app clients with the role of `BROADCASTER` can publish streams in the channel. Those with the role of `AUDIENCE` can only susbcribe to streams.

**2. Get a token**
The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.

**3. Join an Agora RTC channel**
The client joins an RTC (Real-time Communication) channel by calling the APIs provided by Agora. When that happens, Agora automatically creates an RTC channel. App clients that pass the same channel name join the same channel.

**4. Publish and subscribe to audio and video in the channel**
After joining a channel, only app clients with the role of `BROADCASTER` can publish audio and video. For an auidence memeber to send audio and video, you can call the API to switch the client role. 

For an app client to join an RTC channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: A credential for authenticating the identity of the user when your app client joins an RTC channel.
- The channel name: A string that identifies the RTC channel for the live stream.

## Prerequisites

Before proceeding, ensure that you have the following:

- Android Studio 3.0 or later
- Android SDK API Level 16 or higher
- A valid [Agora account](https://console.agora.io/)
- A valid Agora project with an App ID and a temporary token. For details, see [Get started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
- A mobile device that meets the following requirements:
  - Running Android 4.1 or later.
  - Having access to the internet. open the specified ports in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms) if your network has a firewall.

## Project setup

In this section, we will create an Android projet and add the Android device permission to set up the project.

### Create an Android project

Follow the steps to create an empty Android project. Skip to [integrate the SDK](#integrate) if a project already exists.

1. Open **Android Studio** and click **Start a new Android Studio project**.

2. On the **Select a Project Template** panel, choose **Phone and Tablet** > **Empty Activity**, and click **Next**.

3. On the **Configure Your Project** panel, fill in the following:

    - **Name**: The name of your project, for example, Live Streaming
    - **Package name**: The name of the project package, for example, io.agora.livestreaming
    - **Save location**: The path to save the project
    - **Language**: The programming language of the project, for example, Java
    - **Minimum API level**: The minimum API level of the project

Click **Finish**. Follow the on-screen instructions, if any, to install the plug-ins.

> The steps above take Android Studio 3.6.2 as an example. To create a project, you can also refer to the official Android user guide [Build your first app](https://developer.android.com/training/basics/firstapp).

### Add project permissions

Add the following permissions in the `/app/src/main/AndroidManifest.xml` file:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.livestreaming">

   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
...
</manifest>
```

### Prevent code obfuscation

Add the following line in the `/app/proguard-rules.pro` file to prevent obfuscating the code of the SDK:

```
-keep class io.agora.**{*;}
```

## Implement an interactive live streaming

This section shows how to use the Agora Video SDK to implement a live streaming. The following figure shows the API call sequence of a basic video live streaming.

![](images/sequence_live_android.png)

### 1. Integrate the SDK

In the `/build.gradle` file of your project, add the following line to add the JitPack dependency.

```xml
all projects {
  repositories {
    ...
    maven { url 'https://www.jitpack.io' }
  }
}
```

In the `/app/build.gradle` file of your project, add the following line to integrate the Agora Video SDK into your Android project.

```xml
...
dependencies {
  ...
  // For x.y.z, fill in a specific SDK version number. For example, 3.4.0
  implementation 'com.github.agorabuilder:native-full-sdk:x.y.z'
}
```

### 2. Create the UI

This UI is functional rather than beautiful. In the interface, you have one frame for local video and another for remote video. In the `/app/res/layout/activity_main.xml` file, replace the content with the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_video_chat_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">
 
    <FrameLayout
        android:id="@+id/remote_video_view_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/white" />
 
    <FrameLayout
        android:id="@+id/local_video_view_container"
        android:layout_width="160dp"
        android:layout_height="160dp"
        android:layout_alignParentEnd="true"
        android:layout_alignParentRight="true"
        android:layout_alignParentTop="true"
        android:layout_marginEnd="16dp"
        android:layout_marginRight="16dp"
        android:layout_marginTop="16dp"
        android:background="@android:color/darker_gray" />
 
</RelativeLayout>
```

### 3. Import the classes

In the activity file of your project, import the classes by adding the following lines:

```java
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.video.VideoCanvas;

import io.agora.rtc.video.VideoEncoderConfiguration;
```

### 4. Get the device permission

Use the built-in Android method `checkSelfPermission` to check if your app has camera and microphone permissions when launching the activity.

```java
private static final int PERMISSION_REQ_ID = 22;

// Ask for Android device permissions at runtime.
private static final String[] REQUESTED_PERMISSIONS = {
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA
};

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_video_chat_view);

    // If all the permissions are granted, initialize the RtcEngine object and join a channel.
    if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
        initializeAgoraEngine();
        setChannelProfile();
        setClientRole();
        setupLocalVideo();
        joinChannel();
    }
}

private boolean checkSelfPermission(String permission, int requestCode) {
    if (ContextCompat.checkSelfPermission(this, permission) !=
            PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
        return false;
    }

    return true;
}
```

### 5. Initialize RtcEngine

Call the `create` method and fill your App ID to initialize the `RtcEngine` object calling calling any other Agora APIs.

```java
private RtcEngine mRtcEngine;

private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    @Override
    // Listen for the remote host joining the channel to get the uid of the host
    public void onUserJoined(int uid, int elapsed) {
        runOnUniThread(new Runnable() {
            @Override
            public void run() {
                // Call setupRemoteVideo to set the remote video view after getting uid from the onUserJoined callback
                setupRemoteVideo(uid);
            }
        });
    }
};

private void initializeAgoraEngine() {
    try {
        mRtcEngine = RtcEnigne.create(getBaseContext(), "bf702ed04f9a44dfb80f84537122e619", mRtcEventHandler);
    } catch (Exception e) {
        throw new RuntimeException("Check the error.");
    }
}
```

### 6. Set the channel profile and user role

Call the `setChannelProfile` method and set the channel profile as `LIVE_BROADCASTING`. And then call `setClientRole` to set the user role as a host (`BROADCASTER`) or an audience member (`AUDIENCE`).

In an interactive live streaming channel, only the host can be seen and heard. You can call `setClientRole` to switch the user role after joining a channel.

```java
private void setChannelProfile() {
  mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);
}

private void setClientRole() {
  // Set the client role as BROADCASTER if the local user is a host. Otherwise, set it as CLIENT_ROLE_AUDIENCE
  mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER);
}
```

### 7. Set the local video

Set the local video view before joining a channel so that hosts can see the local video.

```java
private void setupLocalVideo() {

    // Enable Video.
    mRtcEngine.enableVideo();

    // Bind the local view with local_video_view_container.
    FrameLayout container = (FrameLayout) findViewById(R.id.local_video_view_container);
    SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
    surfaceView.setZOrderMediaOverlay(true);
    container.addView(surfaceView);

    // Call setupLocalVideo to configure the local view.
    mRtcEngine.setupLocalVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, 0));
}
```

### 8. Join the channel

Call `joinChannel` to join an RTC channel. In this method you need to fill the following:
- A token, for user authentication.
- A channel name. App clients that fill the same channel name join the same channel.
- User ID. You need to specify the user ID yourself, and make sure that this user ID is unique in the channel. If you do not specify a user ID, the Agora SDK automatically generates one for you.

```java
// Java
private void joinChannel() {
    mRtcEngine.joinChannel(<YOUR_TEMP_TOKEN>, "demoChannel1", "Extra Optional Data", 0); // if you do not specify the uid, we will generate the uid for you
}
```

### 9. Set the remote video

After a remote host joins the channel, the SDK gets the host's user ID and reports this user ID in the `onUserJoined` callback. Call the `setupRemoteVideo` method in the callback and pass the user ID to set the remote video.


```java
private void setupRemoteVideo(int uid) {
    FrameLayout container = (FrameLayout) findViewById(R.id.remote_video_view_container);
 
    SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
    container.addView(surfaceView);
    mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, uid));
 
}
```

### 10. Leave the channel

Call the `leaveChannel` method to leave the current live stream.

```java
protected void onDestroy() {
    super.onDestroy();

    mRtcEngine.leaveChannel();
    mRtcEngine.destroy();
    mRtcEngine = null;
}
```

## Test your app

Connect an Android device to your computer, and click `Run 'app'` on your Android Studio. A moment later you will see the project installed on your device. Take the following steps to test the live streaming app:

1. Grant microphone and camera access to your app.
2. When the app launches, you should be able to see yourself on the local view if you set the client role as `BROADCASTER`.
3. Ask a friend to join the live stream with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicLive/index.html). Enter the same App ID and channel name.
4. If your friend joins as host, you should be able to see and hear each other; If as audience, you should only be able to see yourself while your friend can see and hear you.

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens]() shows you how to start an interactive live streaming with a token that you retrieve your your server.

## See also

- Agora provides an open source sample project [OpenLive-Android](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android) on GitHub that implements interactive live video stream for your reference.
- In addition to integrating the Agora Video SDK for Android through JitPack, you can also import the SDK into your project manually by [downloading the SDK](https://docs.agora.io/en/Interactive%20Broadcast/downloads?platform=Android), extracting it, and copying the following files of the downloaded SDK package to the path of your project:

    | File or subfolder | Path of your project |
    |-------|----------|
    | `agora-rtc-sdk.jar` file | `/app/libs/` |
    | `arm-v8a` folder | `/app/src/main/jniLibs/` |
    | `armeabi-v7a` folder | `/app/src/main/jniLibs/` |
    | `x86` folder | `/app/src/main/jniLibs/` |
    | `x86_64` folder | `/app/src/main/jniLibs/` |
    | `include` folder | `/app/src/main/jniLibs/` |

    > - If you use the armeabi architecture, copy files from the `armeabi-v7a` folder to the `armeabi` file of your project. Contact support@agora.io if you encounter any incompability issue.
    > - Not all libraries in the SDK package are necessary. Refer to [How can I reduce the app size after integrating the RTC Native SDK](https://docs.agora.io/en/Video/faq/reduce_app_size_rtc) for details.
    
- The Agora Video SDK does not report events of an audience member in a live streaming channel. Refer to [How can I listen for an audience joining or leaving an interactive live streaming channel](https://docs.agora.io/en/Interactive%20Broadcast/faq/audience_event) if your scenario requires so.