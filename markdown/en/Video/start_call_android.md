---
title: Start a Video Call
platform: Android
updatedAt: 2021-03-26 06:42:03
---
Use this guide to quickly start a basic video call with the Agora Video SDK for Android.

## Sample project

We provide an open-source [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1) demo project that implements the basic one-to-one video call on GitHub. 

## Prerequisites

* Android Studio 3.0 or later
* Android SDK API Level 16 or higher
* A mobile device running Android 4.1 or later
* A valid Agora account ([Sign up](https://dashboard.agora.io/) for free)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

In this section, we will create an Android project, integrate the Agora Video SDK into the project, and add the Android device permissions to prepare the development environment.

### Create an Android project

Now, let's build a project from scratch. Skip to [Integrate the SDK](#integrate_sdk) if a project already exists.

<details>
	<summary><font color="#3ab7f8">Create an Android project</font></summary>
	
1. Open <b>Android Studio</b> and click <b>Start a new Android Studio project</b>. 
2. On the <b>Choose your project</b> panel, choose <b>Phone and Tablet</b> > <b>Empty Activity</b>, and click <b>Next</b>. 
3. On the <b>Configure your project</b> panel, fill in the following contents:

	* <b>Name</b>: The name of your project, for example, HelloAgora
	* <b>Package name</b>: The name of the project package, for example, io.agora.helloagora
	* <b>Project location</b>: The path to save the project
	* <b>Language</b>: The programming language of the project, for example, Java
	* <b>Minimum API level</b>: The minimum API level of the project

Click <b>Finish</b>. Follow the on-screen instructions, if any, to install the plug-ins. 
</details>
	
### Integrate the SDK

Choose either of the following methods to integrate the Agora Video SDK into your project.

**Method 1: Automatically integrate the SDK with JCenter**

Add the following line in the **/app/build.gradle** file of your project:

```
...
dependencies {
    ...
    // 2.9.4 is the latest version of the Agora Video SDK. You can set it to other versions.
    implementation 'io.agora.rtc:full-sdk:2.9.4'
}
```

**Method 2: Manually copy the SDK files**

1. Go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the Agora Video SDK, and unzip the downloaded SDK package.
2. Copy the following files or subfolders from the libs folder of the downloaded SDK package to the path of your project.

| File or subfolder | Path of your project | 
| ---------------- | ---------------- | 
| **agora-rtc-sdk.jar** file      | **/app/libs/**     | 
| **arm-v8a** folder      | **/app/src/main/jniLibs/**     | 
| **armeabi-v7a** folder      | **/app/src/main/jniLibs/**     | 
| **x86** folder      | **/app/src/main/jniLibs/**     | 
| **x86_64** folder      | **/app/src/main/jniLibs/**     | 

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

Add the following line in the **app/proguard-rules.pro** file to prevent code obfuscation:

```xml
-keep class io.agora.**{*;}
```

## Implement the basic video call

This section introduces how to use the Agora Video SDK to make a call. The following figure shows the API call sequence of a basic one-to-one video call.

![](https://web-cdn.agora.io/docs-files/1568254575010)

### 1. Create the UI

Create the user interface (UI) for the one-to-one call in the layout file of your project. Skip to [Import Classes](#import_class) if you already have a UI in your project.

If you are implementing a video call, we recommend adding the following elements into the UI:

* The local video view
* The remote video view
* The end-call button

You can also refer to the [activity_video_chat_view.xml](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Android-Tutorial-1to1/app/src/main/res/layout/activity_video_chat_view.xml) file in the [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1) demo project.

<details>
	<summary><font color="#3ab7f8">Example for creating the UI</font></summary>

```java
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

Create and initialize the RtcEngine object before calling any other Agora APIs.

In this step, you need to use the App ID of your project. Follow these steps to [create an Agora project](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms) in Console and get an [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id ).

1. Go to [Console](https://dashboard.agora.io/) and click the **[Project Management](https://dashboard.agora.io/projects)** icon ![](https://web-cdn.agora.io/docs-files/1551254998344) on the left navigation panel. 
2. Click **Create** and follow the on-screen instructions to set the project name, choose an authentication mechanism, and Click **Submit**. 
3. On the **Project Management** page, find the **App ID** of your project. 

Call the `create` method and pass in the App ID to initialize the RtcEngine object.

You can also listen for callback events, such as when the local user joins the channel, and when the first video frame of a remote user is decoded. Do not implement UI operations in these callbacks.

```java
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
    // This callback occurs when the first video frame of a remote user is received and decoded after the remote user successfully joins the channel.
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
    // This callback occurs when the remote user leaves the channel or drops offline.
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

### 5. Set the local video view

After initializing the RtcEngine object, set the local video view before joining the channel so that you can see yourself in the call. Follow these steps to configure the local video view: 

* Call the `enableVideo` method to enable the video module. 
* Call the `createRendererView` method to create a SurfaceView object.
* Call the `setupLocalVideo` method to configure the local video display settings. 

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
### 6. Join a channel

After initializing the RtcEngine object and setting the local video view (for a video call), you can call the `joinChannel` method to join a channel. In this method, set the following parameters:

* token: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
  * `NULL`.
  * A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
  * A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server).
  
 <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

* channelName: Specify the channel name that you want to join. Users that input the same channel name join the same channel.
* uid: ID of the local user that is an integer and should be unique. If you set uid as 0,  the SDK assigns a user ID for the local user and returns it in the `onJoinChannelSuccess` callback.

For more details on the parameter settings, see [`joinChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c).

```java
private void joinChannel() {
 
    // Join a channel with a token.
    mRtcEngine.joinChannel(YOUR_TOKEN, "demoChannel1", "Extra Optional Data", 0);
}
```

### 7. Set the remote video view

In a video call, you should be able to see other users too. This is achieved by calling the `setupRemoteVideo` method after joining the channel.

Shortly after a remote user joins the channel, the SDK gets the remote user's ID in the `onFirstRemoteVideoDecoded` callback. Call the `setupRemoteVideo` method in the callback, and pass in the uid to set the video view of the remote user.

```java
    @Override
    // Listen for the onFirstRemoteVideoDecoded callback.
    // This callback occurs when the first video frame of a remote user is received and decoded after the remote user successfully joins the channel.
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

### 8. Additional steps

You can implement more advanced features and functionalities in a call. 

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
	
Call the `switchCamera` method to switch the direction  of the camera.
	
```java
public void onSwitchCameraClicked(View view) {
    mRtcEngine.switchCamera();
}
```
</details>

### 9. Leave the channel

Call the `leaveChannel` method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.

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

You can find the complete code logic in the [VideoChatViewActivity.java](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Android-Tutorial-1to1/app/src/main/java/io/agora/tutorials1v1vcall/VideoChatViewActivity.java) file in the Agora-Android-Tutorial-1to1 demo project.

## Run the project

Run the project on your Android device. You can see both the local and remote video views when you successfully start a one-to-one video call in the app.

## Relevant links

We provide an open-source [Group-Video-Call](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Android) demo project that implements the group video call on GitHub. For scenarios involving group video calls, you can download the demo project as a code source reference.

	