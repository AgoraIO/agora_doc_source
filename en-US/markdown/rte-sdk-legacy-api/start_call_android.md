Real-time video chatting immerses people in the sights and sounds of human connections, keeping them engaged in your app longer.

This page shows the minimum code you need to integrate high-quality, low-latency Video Call function into your app using the Video SDK for Android.

## Understand the tech

The following figure shows the workflow you need to integrate into your app in order to achieve Video Call functionality.

![](https://web-cdn.agora.io/docs-files/1629250175461)

To start Video Call, implement the following steps in your app:

1. **Set the role**

   Set both app clients as the host.

2. **Join a channel**

   Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

3. **Publish and subscribe to audio and video in the channel**

   After joining a channel, both hosts can publish video and audio stream to the channel and subscribe to each other.

## Prerequisites

- Android Studio 4.1 or later.
- Android SDK API Level 16 or higher.
- Two mobile devices that run Android 4.1 or later.
- A computer that can access the Internet. Ensure that no firewall is deployed in your network environment, otherwise the project will fail.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project, please refer to [Start using the Agora platform](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms) and get the following information from Agora Console:
  - The App ID: A randomly generated string provided by Agora for identifying your app.
  - A temporary token: A token is the credential that authenticates a user when your app client joins a channel. A temporary token is valid for 24 hours.
  - The channel name: A string that identifies the channel.

## Project setup

In order to create the environment necessary to integrate Video Call into your app, do the following:

1. For new projects, in **Android Studio**, create a **Phone and Tablet** [Android project](https://developer.android.com/studio/projects/create-project) with an **Empty Activity**.

   <div class="alert note">After creating the project, <b>Android Studio</b> automatically starts gradle sync. Ensure that the sync succeeds before you continue.</div>

2. Integrate the Video SDK into your project.

   1. Go to [SDK Downloads](https://docs.agora.io/en/Interactive%20Broadcast/downloads?platform=Android), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

   2. Copy the necessary files and folders from the unzipped SDK package to your project, as shown in the following table.

      | File or subfolder                    | Path of your project     |
      | :----------------------------------- | :----------------------- |
      | `agora-rtc-sdk.jar` file             | `/app/libs/`             |
      | `arm-v8a` folder                     | `/app/src/main/jniLibs/` |
      | `armeabi-v7a` folder                 | `/app/src/main/jniLibs/` |
      | `x86` folder                         | `/app/src/main/jniLibs/` |
      | `x86_64` folder                      | `/app/src/main/jniLibs/` |
      | `include` folder in `high_level_api` | `/app/src/main/jniLibs/` |

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

## Implement a client for Video Call

This section shows how to use the Agora Video SDK to implement Video Call into your app step by step.

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

Import the necessary Android classes and handle the Android permissions.

1. Import Android classes

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `package com.example.<projectname>`:

   ```java
   import androidx.appcompat.app.AppCompatActivity;
   import androidx.core.app.ActivityCompat;
   import androidx.core.content.ContextCompat;

   import android.Manifest;
   import android.content.pm.PackageManager;
   import android.view.SurfaceView;
   import android.widget.FrameLayout;
   ```

2. Handle the Android permissions

   When your app launches, check if the permissions necessary to insert Video Call functionality into the app are granted. If the permissions are not granted, use the built-in Android functionality to request them; if they are, return `true`.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines before the `onCreate` function:

   ```java
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
   ```

### Implement the Video Call logic

The following figure and steps show the API call sequence of implementing Video Call.

![](https://web-cdn.agora.io/docs-files/1629344983794)

To implement this logic, take the following steps:

1. Import the Agora classes.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `import android.os.Bundle;`:

   ```java
   import io.agora.rtc2.Constants;
   import io.agora.rtc2.IRtcEngineEventHandler;
   import io.agora.rtc2.RtcEngine;
   import io.agora.rtc2.RtcEngineConfig;
   import io.agora.rtc2.video.VideoCanvas;
   import io.agora.rtc2.ChannelMediaOptions;
   ```

2. Create the variables that you use to create and join channel.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `AppCompatActivity {`:

   ```java
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
   ```

3. Initialize the app and join the channel.

   Call the core methods for joining a channel to the `MainActivity` class, pass in your App ID, channel name, and temp token.

   In the following reference code, the core methods are included in the `initializeAndJoinChannel` function.

   ```java
     private void initializeAndJoinChannel() {
           try {
               RtcEngineConfig config = new RtcEngineConfig();
               config.mContext = getBaseContext();
               config.mAppId = appId;
               config.mEventHandler = mRtcEventHandler;
               mRtcEngine = RtcEngine.create(config);
           } catch (Exception e) {
               throw new RuntimeException("Check the error.");
           }
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
           // Set both clients as the BROADCASTER.
           option.clientRoleType = CLIENT_ROLE_BROADCASTER;
           // For a video call scenario, set the channel profile as BROADCASTING.
           option.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;

         // Join the channel with a temp token.
           // You need to specify the user ID yourself, and ensure that it is unique in the channel.
           mRtcEngine.joinChannel(token, channelName, 0, options);
       }
   ```

4. Add the remote interface when a remote host joins the channel.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the `initializeAndJoinChannel` function:

   ```java
       private void setupRemoteVideo(int uid) {
           FrameLayout container = findViewById(R.id.remote_video_view_container);
           SurfaceView surfaceView = new SurfaceView (getBaseContext());
           surfaceView.setZOrderMediaOverlay(true);
           container.addView(surfaceView);
           mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, uid));
       }
   ```

### Start and stop your app

Now you have created the Interactive Live Streaming Premium functionality, start and stop the app. In this implementation, a live stream starts when the user opens your app. The live stream ends when the user closes your app.

1. Check that the app has the correct permissions. If permissions are granted, call `initializeAndJoinChannel` to join a live streaming channel.

   In `/app/java/com.example.<projectname>/MainActivity`, replace `onCreate` with the following code in the `MainActivity` class.

   ```java
       @Override
       protected void onCreate(Bundle savedInstanceState) {
           super.onCreate(savedInstanceState);
           setContentView(R.layout.activity_main);

           // If all the permissions are granted, initialize the RtcEngine object and join a channel.
           if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
                   checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
               initializeAndJoinChannel();
           }
       }

   ```

2. When the user closes this app, use `onDestroy` to clean up all the resources you created in `initializeAndJoinChannel`.

   In `/app/java/com.example.<projectname>/MainActivity`, add `onDestroy` after the `onCreate` function.

   ```java
       protected void onDestroy() {
           super.onDestroy();
           mRtcEngine.stopPreview();
           mRtcEngine.leaveChannel();
           RtcEngine.destroy();
       }
   ```

## Test your app

Please follow the test procedure as shown in the example.

1. Connect the Android devices to the computer.

2. Click `Run 'app'` on your Android Studio. A moment later you will see the project installed on your device.

3. Grant microphone and camera access to your app.

4. When the app launches, you can see yourself on the local view if you set the client role as `BROADCASTER`.

5. Ask a friend to use a second device to join the channel with the same App ID, token, and channel name.

   You will see and hear each other.

## Next steps

In a test or production environment, use a token server to generate token is recommended to ensure communication security, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms) for details.

## See also

Agora provides an open source Video Call example project [JoinChannelVideo](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/basic) on GitHub for your reference.
