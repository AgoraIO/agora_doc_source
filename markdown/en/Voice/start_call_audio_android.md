---
title: Start a Voice Call
platform: Android
updatedAt: 2021-03-22 03:47:48
---
Use this guide to quickly start a basic voice call with the Agora Voice SDK for Android.

## Sample project

We provide an open-source [Agora-Android-Voice-Tutorial-1to1](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1) demo project that implements the basic voice call on GitHub. 

## Prerequisites

* Android Studio 3.0 or later
* Android SDK API Level 16 or higher
* A mobile device running Android 4.1 or later
* A valid Agora account ([Sign up](https://dashboard.agora.io/) for free)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

In this section, we will create an Android project, integrate the Agora Voice SDK into the project, and add the Android device permissions to prepare the development environment.

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

Choose either of the following methods to integrate the Agora Voice SDK into your project.

**Method 1: Automatically integrate the SDK with JCenter**

Add the following line in the **/app/build.gradle** file of your project:

```
...
dependencies {
    ...
    // 2.9.4 is the latest version of the Agora Voice SDK. You can set it to other versions.
    implementation 'io.agora.rtc:full-sdk:2.9.4'
}
```

**Method 2: Manually copy the SDK files**

1. Go to [SDK Downloads](https://docs.agora.io/en/Agora%20Platform/downloads), download the latest version of the Agora Voice SDK, and unzip the downloaded SDK package.
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

## Implement the basic voice call

This section introduces how to use the Agora Voice SDK to make a call. The following figure shows the API call sequence of a basic one-to-one voice call.

![](https://web-cdn.agora.io/docs-files/1582692359071)

### 1. Create the UI

Create the user interface (UI) for the one-to-one voice call in the layout file of your project. Skip to [Import Classes](#import_class) if you already have a UI in your project.

You can also refer to the [activity_voice_chat_view.xml](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1/app/src/main/res/layout/activity_voice_chat_view.xml) file in the Agora-Android-Voice-Tutorial-1to1 demo project.

<details>
 <summary><font color="#3ab7f8">Example for creating the UI</font></summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_voice_chat_view"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="io.agora.tutorials1v1acall.VoiceChatViewActivity">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_marginBottom="@dimen/activity_vertical_margin"
        android:orientation="vertical">

        <TextView
            android:id="@+id/quick_tips_when_use_agora_sdk"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:layout_marginLeft="@dimen/activity_horizontal_margin"
            android:layout_marginStart="@dimen/activity_horizontal_margin"
            android:gravity="center_vertical|start"
            android:text="1. Default channel name is voiceDemoChannel1\n2. Waiting for remote users\n3. This demo only supports 1v1 voice calling" />

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="50dp"
            android:orientation="horizontal">

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onLocalAudioMuteClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_mute" />

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onSwitchSpeakerphoneClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_speaker" />

            <ImageView
                android:layout_width="0dp"
                android:layout_height="match_parent"
                android:layout_weight="20"
                android:onClick="onEncCallClicked"
                android:scaleType="centerInside"
                android:src="@drawable/btn_end_call" />

        </LinearLayout>

    </LinearLayout>

</RelativeLayout>
```
</details>


<a name="import_class"></a>
### 2. Import Classes

Import the following classes in the activity file of your project:

```java
import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
```

### 3. Get the device permission

Call the `checkSelfPermission` method to access the microphone of the Android device when launching the activity.

```java
private static final int PERMISSION_REQ_ID_RECORD_AUDIO = 22;
  
// Check the microphone access when running the app.
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_voice_chat_view);

    // Initialize RtcEngine after getting the permission.
    if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO)) {
        initAgoraEngineAndJoinChannel();
    }
}
  
private void initAgoraEngineAndJoinChannel() {
    initializeAgoraEngine();
    joinChannel(); 
}

public boolean checkSelfPermission(String permission, int requestCode) {
    Log.i(LOG_TAG, "checkSelfPermission " + permission + " " + requestCode);
    if (ContextCompat.checkSelfPermission(this,
            permission)
            != PackageManager.PERMISSION_GRANTED) {

        ActivityCompat.requestPermissions(this,
                new String[]{permission},
                requestCode);
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
private RtcEngine mRtcEngine;
private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {  

    // Listen for the onUserOffline callback.
		// This callback occurs when the remote user leaves the channel or drops offline.
    @Override
    public void onUserOffline(final int uid, final int reason) { 
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                onRemoteUserLeft(uid, reason);
            }
        });
    }

    // Listen for the onUserMuterAudio callback.
		// This callback occurs when a remote user stops sending the audio stream.
    @Override
    public void onUserMuteAudio(final int uid, final boolean muted) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                onRemoteUserVoiceMuted(uid, muted);
            }
        });
    }
};
    
...
// Call the create method to initialize RtcEngine.
private void initializeAgoraEngine() {
    try {
        mRtcEngine = RtcEngine.create(getBaseContext(), getString(R.string.agora_app_id), mRtcEventHandler);
        mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_COMMUNICATION);
    } catch (Exception e) {
        Log.e(LOG_TAG, Log.getStackTraceString(e));

        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
}
```

<a name="join_channel"></a>
### 5. Join a channel

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
    String accessToken = getString(R.string.agora_access_token);
    if (TextUtils.equals(accessToken, "") || TextUtils.equals(accessToken, "#YOUR ACCESS TOKEN#")) {
        accessToken = null; // default, no token
    }

    mRtcEngine.joinChannel(accessToken, "voiceDemoChannel1", "Extra Optional Data", 0); // The uid is not specified. The SDK will assign one automatically.
}
```

### 6. Leave the channel

Call the `leaveChannel` method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.

```java
private void leaveChannel() {
    mRtcEngine.leaveChannel();
}
```

### Sample code

You can find the complete code logic in the [VoiceChatViewActivity.java](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1/app/src/main/java/io/agora/tutorials1v1acall/VoiceChatViewActivity.java) file in the Agora-Android-Voice-Tutorial-1to1 demo project.

## Run the project

Run the project on your Android device. You can hear the remote user when you successfully start a one-to-one voice call in the app.

## Relevant links

We provide an open-source [Group-Voice-Call](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-Android) demo project that implements the group video call on GitHub. For scenarios involving group voice calls, you can download the demo project as a code source reference.

	