---
title: Start Live Interactive Video Streaming
platform: Android
updatedAt: 2021-03-26 06:44:40
---
Use this guide to quickly start the interactive live video streaming with the Agora Video SDK for Android.

## Prerequisites

* Android Studio 3.0 or later
* Android SDK API Level 16 or higher
* A mobile device running Android 4.1 or later
* A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an [App ID](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#getappid)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

In this section, we will create an Android project, integrate the Agora Video SDK into the project, and add the Android device permissions to prepare the development environment.

### Create an Android project

Now, let's build a project from scratch. Skip to [Integrate the SDK](#integrate_sdk) if a project already exists.

<details>
	<summary><font color="#3ab7f8">Create an Android project</font></summary>
	
1. Open <b>Android Studio</b> and click <b>Start a new Android Studio project</b>. 
2. On the <b>Select a Project Template</b> panel, choose <b>Phone and Tablet</b> > <b>Empty Activity</b>, and click <b>Next</b>. 
3. On the <b>Configure Your Project</b> panel, fill in the following contents:

	* <b>Name</b>: The name of your project, for example, HelloAgora
	* <b>Package name</b>: The name of the project package, for example, io.agora.helloagora
	* <b>Save location</b>: The path to save the project
	* <b>Language</b>: The programming language of the project, for example, Java
	* <b>Minimum API level</b>: The minimum API level of the project

Click <b>Finish</b>. Follow the on-screen instructions, if any, to install the plug-ins. 

<div class="alert info">The above steps take <b>Android Studio 3.6.2</b> as an example. To create a project, you can also refer to the official User Guide <a href="https://developer.android.com/training/basics/firstapp">Build your first app</a>.</div>
	
</details>
	
### Integrate the SDK

Choose either of the following methods to integrate the Agora Video SDK into your project.

**Method 1: Automatically integrate the SDK with JCenter**

Add the following line in the **/app/build.gradle** file of your project:

```
...
dependencies {
    ...
    // For x.y.z, please fill in a specific SDK version number, such as 3.0.0.
    // Get the latest version number through the release notes.
    implementation 'io.agora.rtc:full-sdk:x.y.z'
}
```

<div class="alert info">Click <a href = "https://docs.agora.io/en/Video/release_android_video?platform=Android">Release notes</a> to get the latest version number.</div>

**Method 2: Manually copy the SDK files**

1. Go to [SDK Downloads](./downloads?platform=Android), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.
2. Copy the following files or subfolders from the libs folder of the downloaded SDK package to the path of your project.

| File or subfolder | Path of your project | 
| ---------------- | ---------------- | 
| **agora-rtc-sdk.jar** file      | **/app/libs/**     | 
| **arm-v8a** folder      | **/app/src/main/jniLibs/**     | 
| **armeabi-v7a** folder      | **/app/src/main/jniLibs/**     | 
| **include** folder  | **/app/src/main/jniLibs/**     | 
| **x86** folder      | **/app/src/main/jniLibs/**     | 
| **x86_64** folder      | **/app/src/main/jniLibs/**     | 

<div class="alert note">
	<ul>
		<li>If your project does not use the encryption function, we recommend deleting the <code>libagora-crypto.so</code> file in the SDK package.</li>
		<li>If you use the armeabi architecture, copy files from the <b>armeabi-v7a</b> folder to the <b>armeabi</b> file of your project. Contact <a href="mailto: support@agora.io">support@agora.io</a> if you encouter any incompatibility issue.</li>
	</ul>
</div>


### Add project permissions

Add the following permissions in the **/app/src/main/AndroidManifest.xml** file for device access according to your needs:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.tutorials1v1acall">
 
   <uses-permission android:name="android.permission.READ_PHONE_STATE" />   
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   // Add the following permission if your scenario involves reading the external storage:
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   // For devices running Android 10.0 or later, you also need to add the following permission:
   <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" />
 
...
</manifest>
```

If your `targetSdkVersion` &ge; 29, add the following line in the `<application>` module in the **AndroidManifest.xml** file:
 
```xml
   <application
	    android:requestLegacyExternalStorage="true">
   </application>
```

### Prevent code obfuscation

Add the following line in the **app/proguard-rules.pro** file to prevent obfuscating the code of the Agora SDK:

```xml
-keep class io.agora.**{*;}
```

## Implement the basic interactive live streaming

This section introduces how to use the Agora Video SDK to start the interactive live video streaming. The following figure shows the API call sequence of the interactive live video streaming.

![](https://web-cdn.agora.io/docs-files/1568255623199)

### 1. Create the UI

Create the user interface (UI) for the interactive streaming in the layout file of your project. Skip to [Import Classes](#import_class) if you already have a UI in your project.

If you are implementing the video streaming, we recommend adding the following elements into the UI:

* The view of the host
* The exit button

You can also refer to the xml files under the [layout](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android/app/src/main/res/layout) path in the [OpenLive-Android](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android) demo project.

<details>
	<summary><font color="#3ab7f8">Example for creating the UI</font></summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_video_chat_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="io.agora.tutorials1v1vcall.VideoChatViewActivity">
 
    <RelativeLayout
        android:id="@+id/remote_video_view_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@color/remoteBackground">
        <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_above="@id/icon_padding">
            <ImageView
                android:layout_width="@dimen/remote_back_icon_size"
                android:layout_height="@dimen/remote_back_icon_size"
                android:layout_centerInParent="true"
                android:src="@drawable/icon_agora_largest"/>
        </RelativeLayout>
        <RelativeLayout
            android:id="@+id/icon_padding"
            android:layout_width="match_parent"
            android:layout_height="@dimen/remote_back_icon_margin_bottom"
            android:layout_alignParentBottom="true"/>
    </RelativeLayout>
 
    <FrameLayout
        android:id="@+id/local_video_view_container"
        android:layout_width="@dimen/local_preview_width"
        android:layout_height="@dimen/local_preview_height"
        android:layout_alignParentEnd="true"
        android:layout_alignParentRight="true"
        android:layout_alignParentTop="true"
        android:layout_marginEnd="@dimen/local_preview_margin_right"
        android:layout_marginRight="@dimen/local_preview_margin_right"
        android:layout_marginTop="@dimen/local_preview_margin_top"
        android:background="@color/localBackground">
 
        <ImageView
            android:layout_width="@dimen/local_back_icon_size"
            android:layout_height="@dimen/local_back_icon_size"
            android:layout_gravity="center"
            android:scaleType="centerCrop"
            android:src="@drawable/icon_agora_large" />
    </FrameLayout>
 
    <RelativeLayout
        android:id="@+id/control_panel"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_marginBottom="@dimen/control_bottom_margin">
 
        <ImageView
            android:id="@+id/btn_call"
            android:layout_width="@dimen/call_button_size"
            android:layout_height="@dimen/call_button_size"
            android:layout_centerInParent="true"
            android:onClick="onCallClicked"
            android:src="@drawable/btn_endcall"
            android:scaleType="centerCrop"/>
 
        <ImageView
            android:id="@+id/btn_switch_camera"
            android:layout_width="@dimen/other_button_size"
            android:layout_height="@dimen/other_button_size"
            android:layout_toRightOf="@id/btn_call"
            android:layout_toEndOf="@id/btn_call"
            android:layout_marginLeft="@dimen/control_bottom_horizontal_margin"
            android:layout_centerVertical="true"
            android:onClick="onSwitchCameraClicked"
            android:src="@drawable/btn_switch_camera"
            android:scaleType="centerCrop"/>
 
        <ImageView
            android:id="@+id/btn_mute"
            android:layout_width="@dimen/other_button_size"
            android:layout_height="@dimen/other_button_size"
            android:layout_toLeftOf="@id/btn_call"
            android:layout_toStartOf="@id/btn_call"
            android:layout_marginRight="@dimen/control_bottom_horizontal_margin"
            android:layout_centerVertical="true"
            android:onClick="onLocalAudioMuteClicked"
            android:src="@drawable/btn_unmute"
            android:scaleType="centerCrop"/>
    </RelativeLayout>
 
</RelativeLayout>
```
</details>

<a name="import_class"></a>
### 2. Import Classes

Import the following classes in the activity file of your project:

```java
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.video.VideoCanvas;
  
import io.agora.rtc.video.VideoEncoderConfiguration;
```

### 3. Get the device permission

Call the `checkSelfPermission` method to access the camera and the microphone of the Android device when launching the activity.

```java
private static final int PERMISSION_REQ_ID = 22;
 
// Ask for Android device permissions at runtime.
private static final String[] REQUESTED_PERMISSIONS = {
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA,
        Manifest.permission.WRITE_EXTERNAL_STORAGE
};
 
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_video_chat_view);
 
    // If all the permissions are granted, initialize the RtcEngine object and join a channel.
    if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID) &&
            checkSelfPermission(REQUESTED_PERMISSIONS[2], PERMISSION_REQ_ID)) {
        initEngineAndJoinChannel();
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

### 4. Initialize RtcEngine

Create and initialize the `RtcEngine` object before calling any other Agora APIs.

In the `string.xml` file, replace `agora_app_id` with your App ID. Call the `create` method and pass in the App ID to initialize the `RtcEngine` object.

You can also listen for callback events, such as when the local user joins the channel, and when the first video frame of a host is decoded. Do not implement UI operations in these callbacks.

```java
private RtcEngine mRtcEngine;
private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    @Override
    // Listen for the onJoinChannelSuccess callback.
    // This callback occurs when the local user successfully joins the channel.
    public void onJoinChannelSuccess(String channel, final int uid, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","Join channel success, uid: " + (uid & 0xFFFFFFFFL));
            }
        });
    }
 
    @Override
    // Listen for the onFirstRemoteVideoDecoded callback.
    // This callback occurs when the first video frame of the host is received and decoded after the host successfully joins the channel.
    // You can call the setupRemoteVideo method in this callback to set up the remote video view.
    public void onFirstRemoteVideoDecoded(final int uid, int width, int height, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","First remote video decoded, uid: " + (uid & 0xFFFFFFFFL));
                setupRemoteVideo(uid);
            }
        });
    }
 
    @Override
    // Listen for the onUserOffline callback.
    // This callback occurs when the host leaves the channel or drops offline.
    public void onUserOffline(final int uid, int reason) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","User offline, uid: " + (uid & 0xFFFFFFFFL));
                onRemoteUserLeft();
            }
        });
    }
};
  
...
 
// Initialize the RtcEngine object.
private void initializeEngine() {
    try {
        mRtcEngine = RtcEngine.create(getBaseContext(), getString(R.string.agora_app_id), mRtcEventHandler);
    } catch (Exception e) {
        Log.e(TAG, Log.getStackTraceString(e));
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
}
```

### 5. Set the channel profile

After initializing the `RtcEngine` object, call the `setChannelProfile` method to set the channel profile as `LIVE_BROADCASTING`.

One RtcEngine object uses one profile only. If you want to switch to another profile, release the current `RtcEngine` object with the `destroy` method and create a new one before calling the `setChannelProfile` method.

```java
private void setChannelProfile() {
    mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);
}
```

### 6. Set the user role and user level

In a live-streaming channel, you need to set the role and level of a user:

- The user role determines the permissions that the SDK grants to a user, such as permission to send local streams, receive remote streams, and push streams to a CDN address. A live-streaming channel has two user roles: host and audience. A host can both send and receive streams, but an audience member can only receive stream. The default role is audience.
- The user level determines the level of services that a user can enjoy within the permissions of the user's role. For example, an audience member can choose to receive remote streams with low latency or ultra low latency. **Levels affect prices.**

You may use the following steps to set the user role and level in your app:

1. Allow the end user to set the role as host or audience.

2. Call the [`setClientRole`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6571a364cfb42a3e552e6bfdf0eebb7c) method and set the `role` and `options` parameters according to the user's choice:
   - When you set `role` as `CLIENT_ROLE_BROADCASTER`, set `options` as `null`. The latency between two hosts is < 400 ms.
   - When you set `role` as `CLIENT_ROLE_AUDIENCE`, set the `audienceLatencyLevel` parameter in `options` as `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY`. The latency from the host's client to the audience's client is 1500 ms - 2000 ms.

<div class="alert note"><li>If you switch the audience level from <code>AUDIENCE_LATENCY_LEVEL_LOW_LATENCY</code> to <code>AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY</code>, in essence, you switch from Interactive Live Streaming Standard to Interactive Live Streaming Premium and the latency from the host's client to the audience's client changes to 400 ms - 800 ms.</li><li>If you switch the user role from <code>CLIENT_ROLE_AUDIENCE</code>  to <code>CLIENT_ROLE_BROADCASTER</code>, in essence, you switch from Interactive Live Streaming Standard to Interactive Live Streaming Premium and the latency between two hosts is < 400 ms.</li><li>If the role is audience and the user level is <code>AUDIENCE_LATENCY_LEVEL_TYPE</code>, the <code>jitterBufferDelay</code> property in <code>RemoteAudioStats</code> does not take effect.</div>

Host:
```java
engine.setClientRole(IRtcEngineEventHandler.ClientRole.CLIENT_ROLE_BROADCASTER);
```

Audience:
```java
ClientRoleOptions clientRoleOptions = new ClientRoleOptions();
clientRoleOptions.audienceLatencyLevel = isLowLatency ? Constants.AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY : Constants.AUDIENCE_LATENCY_LEVEL_LOW_LATENCY;
engine.setClientRole(IRtcEngineEventHandler.ClientRole.CLIENT_ROLE_AUDIENCE, clientRoleOptions);
```

### 7. Set the local video view

After setting the channel profile and user role, set the local video view before joining the channel so that the host can see the local video in the live streaming. Follow these steps to configure the local video view: 

1. Call the `enableVideo` method to enable the video module. 
2. Call the `createRendererView` method to create a SurfaceView object.
3. Call the `setupLocalVideo` method to configure the local video display settings. 

```java
private void setupLocalVideo() {
 
    // Enable the video module.
    mRtcEngine.enableVideo();
 
    // Create a SurfaceView object.
    private FrameLayout mLocalContainer;
    private SurfaceView mLocalView;
 
    mLocalView = RtcEngine.CreateRendererView(getBaseContext());
    mLocalView.setZOrderMediaOverlay(true);
    mLocalContainer.addView(mLocalView);
    // Set the local video view.
    VideoCanvas localVideoCanvas = new VideoCanvas(mLocalView, VideoCanvas.RENDER_MODE_HIDDEN, 0);
    mRtcEngine.setupLocalVideo(localVideoCanvas);
}
```

<a name="join_channel"></a>
### 8. Join a channel

After setting the user role and the local video view (for the video live streaming), you can call the `joinChannel` method to join a channel. In this method, set the following parameters:

* `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
  * `NULL`.
  * A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
  * A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server).
  
 <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

* `channelName`: Specify the channel name that you want to join.
* `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as 0, the SDK assigns a user ID for the local user and returns it in the `onJoinChannelSuccess` callback.
<div class="alert note">Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the <code>mute</code> methods accordingly.</div>

For more details on the parameter settings, see [`joinChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c).

If a live-streaming channel uses both the RTC Native SDK and the RTC Web SDK, ensure that you call the `enableWebSdkInteroperability` method before joining the channel.

```java
private void joinChannel() {
 
    // For SDKs earlier than v3.0.0, call this method to enable interoperability between the Native SDK and the Web SDK if the Web SDK is in the channel. As of v3.0.0, the Native SDK enables the interoperability with the Web SDK by default.
    rtcEngine.enableWebSdkInteroperability(true);
 
    // Join a channel with a token.
    private String mRoomName;
    mRoomName = getIntent().getStringExtra("CName");
    mRtcEngine.joinChannel(YOUR_TOKEN, mRoomName, "Extra Optional Data", 0);
}
```

### 9. Set the remote video view

In the video streaming you should also be able to see all the hosts, regardless of your role. This is achieved by calling the `setupRemoteVideo` method after joining the channel. The difference between setting the local and remote view is that you need to specify the ID of the remote user when setting up the remote view.

Shortly after a remote host joins the channel, the SDK gets the host's user ID in the `onFirstRemoteVideoDecoded` callback. Call the `setupRemoteVideo` method in the callback and pass in the uid to set the video view of the host.

```java
    @Override
    // Listen for the onFirstRemoteVideoDecoded callback.
    // This callback occurs when the first video frame of the host is received and decoded after the host successfully joins the channel.
    public void onFirstRemoteVideoDecoded(final int uid, int width, int height, int elapsed) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Log.i("agora","First remote video decoded, uid: " + (uid & 0xFFFFFFFFL));
                setupRemoteVideo(uid);
            }
        });
    }
   
private void setupRemoteVideo(int uid) {
  
    // Create a SurfaceView object.
    private RelativeLayout mRemoteContainer;
    private SurfaceView mRemoteView;
  
    mRemoteView = RtcEngine.CreateRendererView(getBaseContext());
    mRemoteContainer.addView(mRemoteView);
    // Set the remote video view.
    mRtcEngine.setupRemoteVideo(new VideoCanvas(mRemoteView, VideoCanvas.RENDER_MODE_HIDDEN, uid));
  
}
```

### 10. Additional steps

You can implement more advanced features and functionalities in the interactive live streaming. 

<details>
	<summary><font color="#3ab7f8">Mute the local audio</font></summary>

Call the `muteLocalAudioStream` method to stop or resume sending the local audio stream to mute or unmute the local user.
	
```java
public void onLocalAudioMuteClicked(View view) {
    mMuted = !mMuted;
    mRtcEngine.muteLocalAudioStream(mMuted);
}
```
</details>

<details>
	<summary><font color="#3ab7f8">Switch the camera direction</font></summary>
	
Call the `switchCamera` method to switch the direction of the camera.
	
```java
public void onSwitchCameraClicked(View view) {
    mRtcEngine.switchCamera();
}
```
</details>

### 11. Leave the channel

Call the `leaveChannel` method to leave the current channel according to your scenario, for example, when the interactive live streaming ends, when you need to close the app, or when your app runs in the background.

```java
@Override
protected void onDestroy() {
    super.onDestroy();
    if (!mCallEnd) {
        leaveChannel();
    }
    RtcEngine.destroy();
}
 
private void leaveChannel() {
    // Leave the current channel.
    mRtcEngine.leaveChannel();
}
```

### Sample code

You can find the complete code logic in the [LiveStreaming](https://github.com/AgoraIO/API-Examples/blob/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/LiveStreaming.java) demo project.

## Run the project

Run the project on your Android device. When you set the role as the host and successfully start the interactive live streaming, you can see the video view of yourself in the app. When you set the role as the audience and successfully join the interactive live streaming, you can see the video view of the host in the app.

## Reference

- [How can I listen for an audience joining or leaving a live streaming channel?](./faq/audience_event)
- [How can I set the log file?](./faq/logfile)
- [How can I solve black screen issues?](./faq/video_blank)
- [Why is no audio or video captured on Android 9 devices?](./faq/android_background)
- [How can a host change the role of a remote user?](./faq/host_set_role)