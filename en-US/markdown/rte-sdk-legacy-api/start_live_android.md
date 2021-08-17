This page shows the minimum code you need to integrate high-quality, low-latency Interactive Live Streaming into your app using the Video SDK for Android.

## Understand the tech

The following figure shows the workflow you need to integrate into your app in order to achieve Interactive Live Streaming functionality.

![](https://web-cdn.agora.io/docs-files/1628835475394)

You start Interactive Live Streaming Premium when you call joinChannel from your RtcEngine instance.

The Interactive Live Streaming Premium workflow you integrate into your app is:

1. **Set the role**

   Users in an Interactive Live Streaming Premium channel are either a host or an audience member. The host publishes streams to the channel, and the audience subscribes to the streams. 

2. **Request token**

   Send a request to app server for a token.

3. **Return token**

   Generate a token and pass it to app client.

   <div>A token is the credential that authenticates a user when your app client joins a channel. <ul><li>In a test or production environment, use a token server to generate token is recommended to ensure communication security (as shown in the figure above), see <xref href="https://docs.agora.io/en/Interactive Broadcast/token_server?platform=All Platforms">Authenticate Your Users with Tokens</xref> for details.</li><li>The description on this page shows how to get a temporary token from the Agora Console as a quick testing example.</li></ul></div>

4. **Join a channel**

   Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

5. **Publish and subscribe to audio and video in the channel**

   After joining a channel, a host can publish audio and video and subscribe other hosts in the channel.

6.  Subscribe to audio and video in the channel

   The role of audience can only subscribe to all hosts in the channel, you can call `setClientRole` to switch the client role to host. 

For an app client to join a channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: In a test or production environment, your app client retrieves tokens from your server. For rapid testing, you can use a temporary token with a validity period of 24 hours.
- The channel name: A string that identifies the channel for live streaming. 

## Prerequisites

- Android Studio 4.1 or later.
- Android SDK API Level 16 or higher.
- Two mobile devices that run Android 4.1 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project, obtain the App ID of the project, and generate a temporary token. For details, please refer to [Start using the Agora platform](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms). 
- A computer that can access the Internet. Ensure that no firewall is deployed in your network environment, otherwise the project will fail.

## Project setup

In order to create the environment necessary to integrate Interactive Live Streaming into your app, do the following:

1. For new projects, in **Android Studio**, create a **Phone and Tablet** [Android project](https://developer.android.com/studio/projects/create-project) with an **Empty Activity**.

   <div class="alert note">After creating the project, **Android Studio** automatically starts gradle sync, wait until Android Studio completes the Gradle sync.</div>

2. Integrate the Video SDK into your project.

   1. Go to [SDK Downloads](https://docs.agora.io/en/Interactive Broadcast/downloads?platform=Android), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

   2. Copy the necessary files and folders from the unzipped SDK package to your project, as shown in the following table.

      | File or subfolder        | Path of your project     |
      | :----------------------- | :----------------------- |
      | `agora-rtc-sdk.jar` file | `/app/libs/`             |
      | `arm-v8a` folder         | `/app/src/main/jniLibs/` |
      | `armeabi-v7a` folder     | `/app/src/main/jniLibs/` |
      | `x86` folder             | `/app/src/main/jniLibs/` |
      | `x86_64` folder          | `/app/src/main/jniLibs/` |
      | `include` folder         | `/app/src/main/jniLibs/` |

      <div  class="alert note"><ul><li>If you use the armeabi architecture, copy files from the armeabi-v7a folder to the armeabi folder of your project. Contact <a href="mailto: support@agora.io">support@agora.io</a> if you encounter any incompability issue.</li><li>
          Not all libraries in the SDK package are necessary. Refer to <a href="https://docs.agora.io/en/Video/faq/reduce_app_size_rtc">How can I reduce the app size after integrating the RTC Native SDK</a> for details.</li></ul></div>

   3. In `/Gradle Scripts/build.gradle(Module: )`, add dependencies to local Jar packages as the code shown below.

      ```
      dependencies {
      implementation fileTree(dir: 'libs', include: [ '*.jar'])
      }
      ```

   4. Add permissions for network and device access.

      In `/app/Manifests/AndroidManifest.xml`, add the following permissions after `</application>`:

      ```
       <uses-permission android:name="android.permission.INTERNET" />
       <uses-permission android:name="android.permission.CAMERA" />
       <uses-permission android:name="android.permission.RECORD_AUDIO" />
       <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
       <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
       <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
       <uses-permission android:name="android.permission.BLUETOOTH" />
      ```

   5. To prevent obfuscating the code in the SDK, add the following line in `/Gradle Scripts/proguard-rules.pro` file:

      ```
       -keep class io.agora.**{*;}
      ```

## Implement a client for Interactive Live Streaming Premium

This section shows how to use the Agora Video SDK to implement Interactive Live Streaming Premium into your app step by step.

### Create the UI

In the interface, create one frame for local video and another for remote video. In `/app/res/layout/activity_main.xml`, replace the content with the following:

```java
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toTopOf="parent" />
    <FrameLayout
        android:id="@+id/local_video_view_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/white" />

    <FrameLayout
        android:id="@+id/remote_video_view_container"
        android:layout_width="160dp"
        android:layout_height="160dp"
        android:layout_alignParentEnd="true"
        android:layout_alignParentRight="true"
        android:layout_alignParentTop="true"
        android:layout_marginEnd="16dp"
        android:layout_marginRight="16dp"
        android:layout_marginTop="16dp"
        android:background="@android:color/darker_gray"
        tools:ignore="MissingConstraints" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### Handle the Android system logic

<div>Import necessary Android classes and handle the Android permissions, and check if the necessary permissions to insert live streaming functionality into the app are granted, refer to <a href="#referencecode">Reference code</a> for details.</div>

### Implement the Interactive Live Streaming Premium logic

The following figure and steps show the API call sequence of implementing Interactive Live Streaming Premium. 

![](https://web-cdn.agora.io/docs-files/1628753507039)

1. Import the Agora classes.

2. Define the variables that you use to create and join an Interactive Live Streaming Premium channel.

3. Initialize the app and join the channel.

   Call the core methods for joining a channel to the `MainActivity` class, pass in your App ID, channel name, and temp token.

   In the following reference code, the core methods are wrapped in the `initializeAndJoinChannel` function.

4. Add the remote interface when a remote host joins the channel.

5. Check that the app has the correct permissions. If permissions are granted, call `initializeAndJoinChannel` to join a live streaming channel.

6. When the user closes this app, use `onDestroy` to clean up all the resources you created in `initializeAndJoinChannel`.

### <a name="referencecode">Reference  code</a>

The code in `/app/java/com.example.<projectname>/MainActivity` of this scenario is listed below.

```java
package com.example.<projectname>;

import androidx.appcompat.app.AppCompatActivity;
// Import Android classes
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.view.SurfaceView;
import android.widget.FrameLayout;

import android.os.Bundle;
// Import the Agora classes
import io.agora.rtc2.Constants;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.RtcEngine;
import io.agora.rtc2.video.VideoCanvas;
import io.agora.rtc2.ChannelMediaOptions;


public class MainActivity extends AppCompatActivity {

    // Fill the App ID of your project generated on Agora Console.
    private String appId = "";
    // Fill the channel name.
    private String channelName = "";
    // Fill the temp token generated on Agora Console.
    private String token = "";

    private RtcEngine mRtcEngine;

    private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
        @Override
        // Listen for the remote host joining the channel to get the uid of the host.
        public void onUserJoined(int uid, int elapsed) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // Call setupRemoteVideo to set the remote video view after getting uid from the onUserJoined callback.
                    setupRemoteVideo(uid);
                }
            });
        }

    };
    //When your app launches, check if the permissions necessary to insert live streaming functionality into the app are granted. 
    //If the permissions are not granted, use the built-in Android functionality to request them; if they are, return true.
    private static final int PERMISSION_REQ_ID = 22;
    private static final String[] REQUESTED_PERMISSIONS = {
            Manifest.permission.RECORD_AUDIO,
            Manifest.permission.CAMERA
    };
    private boolean checkSelfPermission(String permission, int requestCode) {
        if (ContextCompat.checkSelfPermission(this, permission) !=
                PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
            return false;
        }
        return true;
    }
	// Initialize the app and join the channel.
    private void initializeAndJoinChannel() {
        try {
            mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
        } catch (Exception e) {
            throw new RuntimeException("Check the error.");
        }
        // For a live streaming scenario, set the channel profile as BROADCASTING.
        mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);
        // Set the client role as BROADCASTER or AUDIENCE according to the scenario.
        mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER);
        // By default, video is disabled, and you need to call enableVideo to start a video stream.
        mRtcEngine.enableVideo();
        // Start local preview
        mRtcEngine.startPreview();

        FrameLayout container = findViewById(R.id.local_video_view_container);
        // Call CreateRendererView to create a SurfaceView object and add it as a child to the FrameLayout.
        // SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
        SurfaceView surfaceView = new SurfaceView (getBaseContext());
        container.addView(surfaceView);
        // Pass the SurfaceView object to Agora so that it renders the local video.
        mRtcEngine.setupLocalVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, 0));
        ChannelMediaOptions options = new ChannelMediaOptions();
        // Join the channel.
        mRtcEngine.joinChannel(token, channelName, 0, options);
    }
    // Add the remote interface for a remote user.
    private void setupRemoteVideo(int uid) {
        FrameLayout container = findViewById(R.id.remote_video_view_container);
        SurfaceView surfaceView = new SurfaceView (getBaseContext());
        surfaceView.setZOrderMediaOverlay(true);
        container.addView(surfaceView);
        mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, uid));
    }
    @Override
    // Start your app
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // If all the permissions are granted, initialize the RtcEngine object and join a channel.
        if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
                checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
            initializeAndJoinChannel();
        }
    }
    // Stop your app
    protected void onDestroy() {
        super.onDestroy();
        mRtcEngine.stopPreview();
        mRtcEngine.leaveChannel();
        mRtcEngine.destroy();
    }

}
```

## Test your  app

1. Connect the Android devices to the computer.

2. Click `Run 'app'` on your Android Studio. A moment later you will see the project installed on your device

3. Grant microphone and camera access to your app.

4. When the app launches, you should be able to see yourself on the local view if you set the client role as `BROADCASTER`.

5. Ask a friend to use a second device to join the channel with the same App ID, token, and channel name.

   If the second equipment joins as a host, you should be able to see and hear each other; if as an audience member, you should only be able to see yourself while your friend can see and hear you.

   

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive Broadcast/token_server?platform=All Platforms) shows you how to start live streaming with a token that you retrieve from your server.

## See also

This section provides additional information for your reference.

### Sample project

Agora provides an open source interactive live broadcast example project [JoinChannelVideo](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/basic) on GitHub for your reference.

### Listening for audience events

The Agora Video SDK does not report events of an audience member in a live streaming channel. Refer to [How can I listen for an audience joining or leaving an interactive live streaming channel](https://docs.agora.io/en/Interactive%20Broadcast/faq/audience_event) if your scenario requires so.
