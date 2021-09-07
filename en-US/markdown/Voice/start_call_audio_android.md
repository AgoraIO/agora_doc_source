# Get Started with Voice Call

People engage longer when they see, hear, and interact with each other. The Agora SDK enables you to embed real-time voice and video interaction in any app, on any device, anywhere.

This page shows the minimum code you need to add voice call into your app by using the Agora Voice SDK for Android.

## Understand the tech

The following figure shows the workflow of a voice call implemented by the Agora SDK.

![](/images/voice_call_tech.png)

As shown in the figure, the workflow for adding Voice Call in your project is as follows:

1. Retrieve a token

   A token is the credential that authenticates a user when your app client joins a channel. In a test or production environment, your app client retrieves tokens from a server in your security infrastructure.

2. Join a channel

   Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

3. Publish and subscribe to audio in the channel

   After joining a channel, the app client automatically publishes and subscribes to audio in the channel.

For an app client to join a channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io/).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: In a test or production environment, your app client retrieves tokens from your server. For this page, you use a temporary token with a validity period of 24 hours that you retrieve from Agora Console.
- The channel name: A string that identifies the channel for the voice call.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Android Studio 3.0 or later.
- Android SDK API Level 16 or higher.
- A valid [Agora account](https://console.agora.io/).
- An active Agora project with an App ID and a temporary token. For details, see [Get Started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
- A computer with access to the internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).
- A mobile device that runs Android 4.1 or later.

## Project setup

Follow the steps to create the environment necessary to add voice call into your app.

1. For new projects, in **Android Studio**, create a **Phone and Tablet** [Android project](https://developer.android.com/studio/projects/create-project) with an **Empty Activity**. 
   > After creating the project, **Android Studio** automatically starts gradle sync. Ensure that the sync succeeds before you continue.

2. Integrate the Voice SDK into your project. For Agora SDK v3.5.0 or later, you can intergrate the SDK with mavenCentral with the following steps. For how to integrate SDKs earlier than v3.5.0, see [Other approches to intergrate the SDK](#integrate).

   a. In `/Gradle Scripts/build.gradle(Project: <projectname>)`, add the following lines to add the JitPack dependency.

   ```xml
   buildscript {
       repositories {
           ...
           mavenCentral()
       }
       ...
   }

   allprojects {
       repositories {
           ...
           mavenCentral()
       }
   }
   ```

   b. In `/Gradle Scripts/build.gradle(Module: <projectname>.app)`, add the following lines to integrate the Agora Voice SDK into your Android project.

   ```xml
   ...
   dependencies {
       // For x.y.z, fill in a specific SDK version number. For example, 3.5.0.
       // Get the latest version number through the release notes.
       implementation 'io.agora.rtc:voice-sdk:x.y.z'
   }
   ```

3. Add permissions for network and device access.

   In `/app/Manifests/AndroidManifest.xml`, add the following permissons after `</application>`:

    ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    ```

4. Prevent code obfuscation.

   In `/Gradle Scripts/proguard-rules.pro`, add the following line:

    ```xml
    -keep class io.agora.**{*;}
    ```

## Implement a client for Voice Call

This section shows how to use the Agora Voice SDK to implement Voice Call into your app step by step.

### Create the UI

In `/app/res/layout/activity_main.xml`, replace the content with the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">


    <FrameLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/darker_gray">

        <TextView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:layout_marginLeft="16dp"
            android:layout_marginStart="16dp"
            android:layout_gravity="center_vertical|start"
            android:text="Welcome to the Agora Voice Call channel."/>

    </FrameLayout>
</RelativeLayout>
```

### Handle the Android system logic

Refer to the following steps to import the necessary Android classes and handle the Android permissions.

1. Import Android classes

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `package com.example.<projectname>`:

    ```java
    // Java
    import androidx.core.app.ActivityCompat;
    import androidx.core.content.ContextCompat;

    import android.Manifest;
    import android.content.pm.PackageManager;
    ```

    ```kotlin
    // Kotlin
    import android.content.pm.PackageManager
    import androidx.core.app.ActivityCompat
    import androidx.core.content.ContextCompat
    import android.Manifest
    import java.lang.Exception
    ```

2. Handle the Android permissions

    When your app launches, check if the permission necessary to insert voice calling functionality into the app are granted. If the permissions are not granted, use the built-in Android functionality to request them; if they are, return `true`.

    In `/app/java/com.example.<projectname>/MainActivity>`, add the following lines after the `onCreate` function:

    ```java
    // Java
    private static final int PERMISSION_REQ_ID = 22;

    private static final String[] REQUESTED_PERMISSIONS = {
                Manifest.permission.RECORD_AUDIO
    };

    private boolean checkSelfPermission(String permission, int requestCode) {
        if (ContextCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
            return false;
        }
        return true;
    }
    ```

    ```kotlin
    // Kotlin
    private val PERMISSION_REQ_ID_RECORD_AUDIO = 22

    private fun checkSelfPermission(permission: String, requestCode: Int): Boolean {
        if (ContextCompat.checkSelfPermission(this, permission) !=
                PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
            arrayOf(permission),
            requestCode)
            return false
        }
        return true
    }
    ```

### Implement the Voice Call logic

When your app opens, you create an `RtEngine` instance, join a channel, and publish the local audio to the channel. When another user joins the channel, your apps catches the join event and receive the audio from the remote user.

The following figure shows the API call sequence of implementing Voice Call.

![](/images/sequence_voice_android.png)

To implement this logic, take the following steps:

1. Import the Agora classes

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `import android.os.Bundle;`

    ```java
    import io.agora.rtc.RtcEngine;
    import io.agora.rtc.IRtcEngineEventHandler;
    ```

2. Create the variables that you use to create and join a voice call channel.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the `AppCompatActivity {`:

    ```java
    // Java
    // Fill the App ID of your project generated on Agora Console.
    private String appId = "";
    // Fill the channel name.
    private String channelName = "";
    // Fill the temp token generated on Agora Console.
    private String token = "";
    private RtcEngine mRtcEngine;
    private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    };
    ```

    ```kotlin
    // Kotlin
    // Fill the App ID of your project generated on Agora Console.
    private val APP_ID = ""
    // Fill the channel name.
    private val CHANNEL = ""
    // Fill the temp token generated on Agora Console.
    private val TOKEN = ""
    private var mRtcEngine: RtcEngine ?= null
    private val mRtcEventHandler = object : IRtcEngineEventHandler() {
    }
    ```

3. Initialize the app and join the channel.

    Call the following core methods to join a channel in the `MainActicity` class. In the following sample code, the `initializeAndJoinChannel` function encapsulates these core methods.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the `onCreate` function:

    ```java
    // Java
    private void initializeAndJoinChannel() {
        try {
            mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
        } catch (Exception e) {
            throw new RuntimeException("Check the error");
        }

        mRtcEngine.joinChannel(token, channelName, "", 0);
    }
    ```

    ```kotlin
    // Kotlin
    private fun initializeAndJoinChannel() {
        try {
            mRtcEngine = RtcEngine.create(baseContext, APP_ID, mRtcEventHandler)
        } catch (e: Exception) {

        }

        mRtcEngine!!.joinChannel(TOKEN, CHANNEL, "", 0)
    }
    ```

### Start and stop your app

Now you have created the Voice Call functionality, start and stop the app. In this implementation, a voice call starts when the user opens your app. The call ends when the user closes your app.

1. Check that the app has the corrent permissions. If permissions are granted, call `initializeAndJoinChannel` to join a voice call channel.

    In `/app/java/com.example.<projectname>/MainActivity`, replace `onCreate` with the following code.

    ```java
    // Java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID)) {
            initializeAndJoinChannel();
        }
    }
    ```

    ```kotlin
    // Kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO)) {
            initializeAndJoinChannel();
        }
    }
    ```

2. When the user closes this app, clean up all the resources you created in `initializeAndJoinChannel`. 

    In `/app/java/com.example.<projectname>/MainActivity`, add `onDestroy` after the `onCreate` function.

    ```java
    // Java
    protected void onDestroy() {
        super.onDestroy();

        mRtcEngine.leaveChannel();
        mRtcEngine.destroy();
    }
    ```

    ```kotlin
    // Kotlin
    override fun onDestroy() {
        super.onDestroy()

        mRtcEngine?.leaveChannel()
        RtcEngine.destroy()
    }
    ```

## Test your app

To test your app, follow the steps:

1. Fill in the `appId` and `token` parameters with the App ID and temporary token that you retrieve from Agora Console. Fill `channelName` with the channel name that you use to generate the temporary token.
2. Connect an Android device to your computer, and click `Run 'app'` on your **Android Studio**. A moment later you will see the project installed on your device. 
3. When the app lauches, you should be able to see the user interface.
4. Ask a friend to join the voice call with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicVideoCall/index.html). Enter the same App ID and channel name.
After your friend joins the channel, you should be able to hear each other.

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](https://docs.agora.io/en/Voice/token_server?platform=All%20Platforms) shows you how to start video calling with a token that you retrieve from your server.