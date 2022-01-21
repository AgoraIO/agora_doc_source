# Implement a client for [product-name]

This section shows how to use the [sdk-name] to implement [product-name] into your app step by step.

## Create the UI

<p props="audio">Create the user interface (UI) for the <ph keyref="feature"/> in the layout file of your project.</p>
<p props="video live">In the interface, you have one frame for local video and another for remote video.</p>
In `/app/res/layout/activity_main.xml`, replace the content with the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<RelativeLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">
    <FrameLayout
        android:id="@+id/local_video_view_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/white"
    />

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
    />
</RelativeLayout>
```

## Handle the Android system logic

In this section, we import the necessary Android classes and handle the Android permissions.

1. Import Android classes

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `package com.example.<projectname>`:

    ```java
    import androidx.core.app.ActivityCompat;
    import androidx.core.content.ContextCompat;

    import android.Manifest;
    import android.content.pm.PackageManager;
    import android.view.SurfaceView;
    import android.widget.FrameLayout;
    ```

1. Handle the Android permissions

    When your app launches, check if the permissions necessary to insert video calling functionality into the app are granted. If the permissions are not granted, use the built-in Android functionality to request them; if they are, return `true`.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines before the `onCreate` function:

    ```java
    // Java
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

    ```kotlin
    // Kotlin
    private val PERMISSION_REQ_ID_RECORD_AUDIO = 22
    private val PERMISSION_REQ_ID_CAMERA = PERMISSION_REQ_ID_RECORD_AUDIO + 1

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

## Implement the [product-name] logic

When your app opens, you create an [IRtcEngine] instance, enable the video, join a channel, and publish the local video to the lower frame layout in the UI. When another user joins the channel, you app catches the join event and adds the remote video to the top frame layout in the UI.

The following figure shows the API call sequence of implementing [product-name].

![start-api-sequence-android]

To implement this logic, take the following steps:

1. Import the Agora classes.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `import android.os.Bundle;`:

    ```java
     import io.agora.rtc.IRtcEngineEventHandler;
     import io.agora.rtc.RtcEngine;
     import io.agora.rtc.video.VideoCanvas;
    ```

2. Create the variables that you use to create and join a video call channel.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `AppCompatActivity {`:

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
         @Override
         // Listen for the remote user joining the channel to get the uid of the user.
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
       // Listen for the remote user joining the channel to get the uid of the user.
       override fun onUserJoined(uid: Int, elapsed: Int) {
         runOnUiThread {
             // Call setupRemoteVideo to set the remote video view after getting uid from the onUserJoined callback.
             setupRemoteVideo(uid)
         }
       }
     }
    ```

3. Initialize the app and join the channel.

    Call the following core methods to join a channel in the `MainActivity` class. In the following sample code, the `initializeAndJoinChannel` function encapsulates these core methods.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the `onCreate` function:

    <p props="video" conref="../conref/get-started-sample-code-android.dita#get-started-sample-code/init-video"/>
    <p props="live" conref="../conref/get-started-sample-code-android.dita#get-started-sample-code/init-live"/>

4. Add the remote interface when a remote [host] joins the channel.

    In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the `initializeAndJoinChannel` function:

    ```java
     // Java
     private void setupRemoteVideo(int uid) {
         FrameLayout container = findViewById(R.id.remote_video_view_container);
         SurfaceView surfaceView = RtcEngine.CreateRendererView(getBaseContext());
         surfaceView.setZOrderMediaOverlay(true);
         container.addView(surfaceView);
         mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, uid));
     }
    ```

    ```kotlin
     // Kotlin
     private fun setupRemoteVideo(uid: Int) {
         val remoteContainer = findViewById(R.id.remote_video_view_container) as FrameLayout

         val remoteFrame = RtcEngine.CreateRendererView(baseContext)
         remoteFrame.setZOrderMediaOverlay(true)
         remoteContainer.addView(remoteFrame)
         mRtcEngine!!.setupRemoteVideo(VideoCanvas(remoteFrame, VideoCanvas.RENDER_MODE_FIT, uid))
     }
    ```

## Start and stop your app

Now you have created the [product-name] functionality, start and stop the app. In this implementation, a [feature] starts when the user opens your app. The [feature] ends when the user closes your app.

1. Check that the app has the correct permissions. If permissions are granted, call `initializeAndJoinChannel` to join a video call channel.

    In `/app/java/com.example.<projectname>/MainActivity`, replace `onCreate` with the following code in the `MainActivity` class.

    ```java
     // Java
     @Override
     protected void onCreate(Bundle savedInstanceState) {
         super.onCreate(savedInstanceState);
         setContentView(R.layout.activity_main);

         // If all the permissions are granted, initialize the RtcEngine object and join a channel.
         if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) undefined checkSelfPermission(Manifest.permission.CAMERA, PERMISSION_REQ_ID_CAMERA)) {
           initializeAndJoinChannel()
         }
     }
    ```

    ```kotlin
     // Kotlin
     override fun onCreate(savedInstanceState: Bundle?) {
         super.onCreate(savedInstanceState)
         setContentView(R.layout.activity_main)

         // If all the permissions are granted, initialize the RtcEngine object and join a channel.
         if (checkSelfPermission(Manifest.permission.RECORD_AUDIO, PERMISSION_REQ_ID_RECORD_AUDIO) && checkSelfPermission(Manifest.permission.CAMERA, PERMISSION_REQ_ID_CAMERA)) {
           initializeAndJoinChannel()
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
