---
title: Start Interactive Live Audio Streaming
platform: Android
updatedAt: 2020-12-03 04:11:35
---
Use this guide to quickly start the interactive live audio streaming with the Agora Voice SDK for Android.

## Sample project

We provide an open-source [OpenLive-Voice-Only-Android](https://github.com/AgoraIO/Basic-Audio-Broadcasting/tree/master/OpenLive-Voice-Only-Android) demo project that implements the basic interactive live audio streaming on GitHub. 

## Prerequisites

* Android Studio 3.0 or later
* Android SDK API Level 16 or higher
* A mobile device running Android 4.1 or later
* A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an [App ID](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#getappid)

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

In this section, we will create an Android project, integrate the Agora Voice SDK into the project, and add the Android device permissions to prepare the development environment.

### Create an Android project

Skip to [Integrate the SDK](#integrate_sdk) if a project already exists.

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
	
### <a name="integrate_sdk"></a>Integrate the SDK

Choose either of the following methods to integrate the Agora Voice SDK into your project.

**Method 1: Automatically integrate the SDK with JCenter**

Add the following line in the **/app/build.gradle** file of your project:

```
...
dependencies {
    ...
    // For x.y.z, please fill in a specific SDK version number, such as 3.0.0.
    // Get the latest version number through the release notes.
    implementation 'io.agora.rtc:voice-sdk:x.y.z'
}
```

<div class="alert info">Click <a href = "https://docs.agora.io/en/Voice/release_android_audio?platform=Android">Release notes</a> to get the latest version number.</div>

**Method 2: Manually copy the SDK files**

1. Go to [SDK Downloads](/en/Voice/downloads?platform=Android), download the latest version of the Agora Voice SDK, and extract the files from the downloaded SDK package.
2. Copy the following files or subfolders from the libs folder of the downloaded SDK package to the path of your project.

| File or subfolder | Path of your project | 
| ---------------- | ---------------- | 
| **agora-rtc-sdk.jar** file      | **/app/libs/**     | 
| **arm64-v8a** folder      | **/app/src/main/jniLibs/**     | 
| **armeabi-v7a** folder      | **/app/src/main/jniLibs/**     | 
| **include** folder   | **/app/src/main/jniLibs/**     | 
| **x86** folder      | **/app/src/main/jniLibs/**     | 
| **x86_64** folder      | **/app/src/main/jniLibs/**     | 

<div class="alert note">
	<ul>
		<li>If your SDK version is earlier than 3.2.0 and your project does not use the encryption function, we recommend deleting the <code>libagora-crypto.so</code> file in the SDK package.</li>
		<li>If you use the armeabi architecture, copy files from the <b>armeabi-v7a</b> folder to the <b>armeabi</b> file of your project. Contact <a href="mailto: support@agora.io">support@agora.io</a> if you encouter any incompatibility issue.</li>
		<li>The libraries with the <code>extension</code> suffix are optional. Add the corresponding libraries according to your needs. For the feature of each extension library, see <a href = "https://docs.agora.io/en/Voice/release_android_audio?platform=Android">Release notes</a>.</li>
	</ul>
</div>

### Add project permissions

Add the following permissions in the **/app/src/main/AndroidManifest.xml** file for device access according to your needs:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
   package="io.agora.tutorials1v1acall">
 
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
 
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

This section introduces how to use the Agora Voice SDK to start the interactive live audio streaming. The following figure shows the API call sequence of the interactive live audio streaming.

![](https://web-cdn.agora.io/docs-files/1583134611348)

### 1. Create the UI

Create the user interface (UI) for the audio streaming in the layout file of your project. Skip to [Import Classes](#import_class) if you already have a UI in your project.

You can also refer to the xml files under the [layout](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android/app/src/main/res/layout) path in the OpenLive-Voice-Only-Android demo project.

<details>
	<summary><font color="#3ab7f8">Example for creating the UI</font></summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:keepScreenOn="true"
    tools:context=".ui.LiveRoomActivity">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <TextView
            android:id="@+id/room_name"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_alignParentTop="true"
            android:layout_centerHorizontal="true"
            android:layout_marginTop="6dp"
            android:textColor="@color/dark_black"
            android:textSize="16sp"
            android:textStyle="bold" />

        <io.agora.propeller.ui.AGLinearLayout
            android:id="@+id/bottom_container"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_alignParentBottom="true"
            android:layout_alignParentLeft="true"
            android:layout_alignParentStart="true"
            android:orientation="vertical">

            <ImageView
                android:id="@+id/bottom_action_end_call"
                android:layout_width="54dp"
                android:layout_height="54dp"
                android:layout_gravity="center_horizontal"
                android:onClick="onEndCallClicked"
                android:scaleType="center"
                android:src="@drawable/btn_endcall" />

            <RelativeLayout
                android:id="@+id/bottom_action_container"
                android:layout_width="match_parent"
                android:layout_height="54dp"
                android:gravity="center_vertical"
                android:orientation="horizontal">

                <ImageView
                    android:id="@id/switch_broadcasting_id"
                    android:layout_width="54dp"
                    android:layout_height="match_parent"
                    android:layout_alignParentLeft="true"
                    android:layout_alignParentStart="true"
                    android:scaleType="center"
                    android:src="@drawable/btn_request_broadcast" />

                <LinearLayout
                    android:layout_width="wrap_content"
                    android:layout_height="match_parent"
                    android:layout_centerInParent="true"
                    android:orientation="horizontal">

                    <ImageView
                        android:id="@id/switch_speaker_id"
                        android:layout_width="54dp"
                        android:layout_height="match_parent"
                        android:onClick="onSwitchSpeakerClicked"
                        android:scaleType="center"
                        android:src="@drawable/btn_speaker" />

                    <ImageView
                        android:id="@id/mute_local_speaker_id"
                        android:layout_width="54dp"
                        android:layout_height="match_parent"
                        android:onClick="onVoiceMuteClicked"
                        android:scaleType="center"
                        android:src="@drawable/btn_mute" />

                </LinearLayout>

            </RelativeLayout>
        </io.agora.propeller.ui.AGLinearLayout>

        <EditText
            android:id="@+id/msg_list"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_above="@id/bottom_container"
            android:layout_below="@id/room_name"
            android:layout_marginBottom="8dp"
            android:layout_marginTop="6dp"
            android:enabled="true"
            android:focusable="false"
            android:gravity="start|top"
            android:inputType="none"
            android:scrollbars="vertical" />

    </RelativeLayout>
</FrameLayout>
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
  
// Ask for Android device permissions at runtime.
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_voice_chat_view);

    // Initialize RtcEngine and join the channel after getting the permission.
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

Create and initialize the `RtcEngine` object before calling any other Agora APIs.

In the `string.xml` file, replace `agora_app_id` with your App ID. Call the `create` method and pass in the App ID to initialize the `RtcEngine` object.

You can also listen for callback events, such as when the local user joins the channel. Do not implement UI operations in these callbacks.

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

### 6. Set the user role

A live-streaming channel has two user roles: `BROADCASTER` and `AUDIENCE`, and the default role is `AUDIENCE`. After setting the channel profile to `LIVE_BROADCASTING`, your app may use the following steps to set the client role:

1. Allow the user to set the role as `BROADCASTER` or `AUDIENCE`. 
2. Call the `setClientRole` method and pass in the user role set by the user.

Note that in the live streaming, only the host can be heard. If you want to switch the user role after joining the channel, call the `setClientRole` method.

```java
public void onClickJoin(View view) {
    // Show a dialog box to choose a user role.
    AlertDialog.Builder builder = new AlertDialog.Builder(this);
    builder.setMessage(R.string.msg_choose_role);
    builder.setNegativeButton(R.string.label_audience, new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialog, int which) {
            MainActivity.this.forwardToLiveRoom(Constants.CLIENT_ROLE_AUDIENCE);
        }
    });
    builder.setPositiveButton(R.string.label_broadcaster, new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialog, int which) {
            MainActivity.this.forwardToLiveRoom(Constants.CLIENT_ROLE_BROADCASTER);
        }
    });
    AlertDialog dialog = builder.create();
 
    dialog.show();
}
 
// Get the user role and channel name specified by the user.
// The channel name is used when joining the channel.
public void forwardToLiveRoom(int cRole) {
    final EditText v_room = (EditText) findViewById(R.id.room_name);
    String room = v_room.getText().toString();
 
    Intent i = new Intent(MainActivity.this, LiveRoomActivity.class);
    i.putExtra("CRole", cRole);
    i.putExtra("CName", room);
 
    startActivity(i);
}
 
// Pass in the role set by the user.
private int mRole;
mRole = getIntent().getIntExtra("CRole", 0);
 
private void setClientRole() {
    mRtcEngine.setClientRole(mRole);
}
```

<a name="join_channel"></a>
### 7. Join a channel

After setting the user role, you can call the `joinChannel` method to join a channel. In this method, set the following parameters:

* `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
  * A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](token#get-a-temporary-token). When joining a channel, ensure that the channel name is the same with the one you use to generate the temporary token.
  * A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server). When joining a channel, ensure that the channel name and `uid` is the same with those you use to generate the token.
  
 <div class="alert note"><ul><li>If your project has enabled the app certificate, ensure that you provide a token.</li><li>Ensure that you do not set <code>token</code> as "".</li></div>

* `channelName`: Specify the channel name that you want to join.
* `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as 0,  the SDK assigns a user ID for the local user and returns it in the `onJoinChannelSuccess` callback.

For more details on the parameter settings, see [`joinChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c).

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

### 8. Leave the channel

Call the `leaveChannel` method to leave the current channel according to your scenario, for example, when the streaming ends, when you need to close the app, or when your app runs in the background.

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

You can find the complete code logic in the [OpenLive-Voice-Only-Android](https://github.com/AgoraIO/Basic-Audio-Broadcasting/tree/master/OpenLive-Voice-Only-Android) demo project.

## Run the project

Run the project on your Android device. When the audio streaming starts, all the audience can hear the host in the app.

## Reference

When integrating the Agora Voice SDK, you can also refer to the following articles: 

- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [How can I listen for an audience joining or leaving an interactive live streaming channel?](https://docs.agora.io/en/faq/audience_event)
- [Why is no audio or video captured on Android 9 devices?](https://docs.agora.io/en/faq/android_background)


