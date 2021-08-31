
# Get started with Interactive Live Streaming using UIKit


Agora’s Interactive Live Streaming makes it easy for you to build apps with audio and video streaming in order to host large-scale live audio and video streaming events with real-time interactivity.

Real-time video chatting immerses people in the sights and sounds of human connections. This keeps your users engaged for longer with your app. Agora Video SDK makes it easy for you to manage Interactive Live Streaming events in an app. UIKit is a library that combines Agora real-time engagement functionality into a customizable user interface. Have another coffee, we have done all the work for you. 

![](images/uikit-ui.png)

This page shows the minimum code you need to host an Interactive Live Streaming event from your app using UIKit.

## Understand the tech

The following figure shows the workflow UIKit integrates into your app in order to achieve Interactive Live Streaming functionality.

![](https://web-cdn.agora.io/docs-files/1629250175461)

To start a call using UIKit, you implement the following steps in your app:

1. **Join a channel**:

   The `join` command joins the channel, publishes the local audio and video streams to Agora and handles audio and video for anyone else who joins the call in a default UI. 


Yes, you read that right. After initializing an `AgoraVideoViewer` instance, you manage a call with one line of code. 


## Prerequisites

- Android Studio 4.1 or later.
- Android SDK API Level 16 or higher.
- A computer that can access the Internet. 

    Ensure that no firewall is deployed in your network environment, otherwise the project fails.

- A physical Android device to run your app on.  
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project.

## Project setup

In order to create the environment necessary to integrate Interactive Live Streaming into your app, do the following:

1. For new projects, in **Android Studio**, create a **Phone and Tablet** [Android project](https://developer.android.com/studio/projects/create-project) with an **Empty Activity** using Kotlin.

   After creating the project, Android Studio automatically starts gradle sync. Ensure that the sync succeeds before you continue.

1. Integrate UIKit into your project:

   1. In `Gradle Scripts/settings.gradle( Project Settings )`, add the jitpack repository. For example:
       ```
      repositories {
         google()
         mavenCentral()
         jcenter() // Warning: this repository is going to shut down soon
         maven { setUrl("https://jitpack.io") }
      }
       ```
   2. In `Gradle Scripts/build.gradle( Module: <projectname> )`: Add the UIKit dependency and set the minimum SDK version to 24. For example:  
       ```
        android {
        defaultConfig {
            ...
            minSdk 24
            ...
        }
        dependencies {
            ...
            implementation 'com.github.AgoraIO-Community:Android-UIKit:final:<version>'
            ...
        }
      ```

   3. Find the [Latest version of UIKit](https://jitpack.io/#com.github.AgoraIO-Community/Android-UIKit) and replace `version` with the one you want to use. For example: `2.0.6`. 
      ```json
       implementation 'com.github.AgoraIO-Community:Android-UIKit:final:2.0.6'
      ```
   5. Sync Gradle and import UIKit. 

   6. Add permissions for network and device access.

      In `/app/Manifests/AndroidManifest.xml`, add the following permissions after `</application>`:

      ```
       <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
       <uses-permission android:name="android.permission.INTERNET" />
       <uses-permission android:name="android.permission.RECORD_AUDIO" />
       <uses-permission android:name="android.permission.CAMERA" />
       <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
       <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   
       <!-- The Agora SDK requires Bluetooth permissions in case users are using Bluetooth devices.-->
       <uses-permission android:name="android.permission.BLUETOOTH" />
      ```
   
## Implement a client for Interactive Live Streaming

This section shows how to use UIKit to implement Interactive Live Streaming into your app step-by-step.

To integrate real-time video in a ready-made user interface:

1. Import the Agora classes.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `import android.os.Bundle;`:

   ```kotlin
   import android.widget.FrameLayout
   import io.agora.rtc.Constants
   import io.agora.agorauikit_android.*
   ```

2. Create the variables that you use to initiate and join a channel.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after `AppCompatActivity {`:

   ```kotlin
    // Fill the App ID of your project generated on Agora Console.
    private val appId = ""

    // Fill the temp token generated on Agora Console.
    private val token = ""

    // Fill the channel name.
    private val channelName = ""

    private var agView: AgoraVideoViewer? = null
   ```

3. Create a function that initializes an `AgoraVideoViewer` instance and joins a channel.

   In `/app/java/com.example.<projectname>/MainActivity`, add the following lines after the variables:

   ```kotlin
        private fun initializeAndJoinChannel(){
        // Create AgoraVideoViewer instance
        try {
            agView = AgoraVideoViewer(
                this, AgoraConnectionData(appId, appToken = token),
            )
        } catch (e: Exception) {
            print("Could not initialise AgoraVideoViewer. Check your App ID is valid.")
            print(e.message)
            return
        }
        // Fill the parent ViewGroup (MainActivity)
        this.addContentView(
            agView,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
        )
        // Join a channel by passing a channel name and a client role
        agView!!.join(channelName, role = Constants.CLIENT_ROLE_BROADCASTER)
    }
   ```

1. Start your app

   In `/app/java/com.example.<projectname>/MainActivity`, update `onCreate` to run  `initializeAndJoinChannel()` when the app starts. For example:

   ```kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initializeAndJoinChannel()
    }
   ```


## Test your app

To check that your code works, host an Interactive Live Streaming event from your app and connect to it as the audience from a web demo. to do this:

1. [Generate a temporary token](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All#generate-a-temporary-token) in Agora Console.

2. In your browser, navigate to https://agora-scalableui-android-test.netlify.app/ and update _App ID_, _Channel_ and _Token_ with the values for your temporary token, then click *JOIN*.

3. In Android Studio, in `/app/java/com.example.<projectname>/MainActivity`, update `appId`, `channelName` and `token` with the values for your temporary token.

4. Run your app.
   The app is now the host of the Interactive Live Streaming event.

5. In your browser on another machine, navigate to https://agora-scalableui-android-test.netlify.app/ and update _App ID_, _Channel_ and _Token_ with the values for your temporary token, then click *JOIN*.

   The user in the browser is a member of the audience in the event.
