This page introduces how to add Flexible Classroom to your Android app.

## Understand the tech

### Module introduction

The source code of Flexible Classroom contains the following packages:

- `app`: (Optional) This module contains code for the classroom login interface and a client-side token generator, showing how to call APIs to join a flexible classroom. This module is an open-source project available on GitHub and for reference only.

<div class="alert note"><li>Specifications defined for the login interface (such as the length requirement of the user name and the room name and character restrictions) do not apply to all apps. You need to define them according to your own business requirements.</li><li>The client-side token generator provided by Agora is only for rapid testing. When your app goes live, to ensure security, you must deploy a server-side token generator and generate tokens on your server. For details, see <a href="/en/Real-time-Messaging/token_server_rtm?platform=All%20Platforms">Authenticate Your Users with Tokens</a>.</li></div>

- `AgoraEduUIKit`: (Optional) This module contains code for the classroom UI, showing how to call APIs to aggregate and update UI data. This module is an open-source project available on GitHub. You can develop your own classroom UI based on this module.
- `AgoraClassSDK`: (Optional) This module provides methods for configuring the SDK, launching a flexible classroom, and registering ext apps, and provides the activity implementation of each teaching scenario. This module is an open-source project available on GitHub. Agora recommends integrating this module.
- `AgoraEduCore`: (Required) The core module of Flexible Classroom. Since v2.0.0, this module is closed-source, and you can import this module only by adding a remote dependency.
- `hyphenate`: (Optional) The UI and logic of the chat feature implemented with the Hyphenate IM SDK. If you implement the chat feature on your own, you do not need to import this module.

### Module relations

- `AgoraEduCore` is the required core module, and all the other modules depend on it.
- Both `AgoraEduUIKit` and `AgoraClassSDK` depend on `AgoraEduCore`, and there is no dependency between them.
- `AgoraEduUIKit` depends on `hyphenate`.
- `hyphenate` depends on `AgoraEduCore`.
- `app` depends on all other modules.

## Integrate Flexible Classroom through Maven

If you use the default UI of Flexible Classroom, take the following steps to add remote dependencies and integrate the whole Flexible Classroom through Maven:

1. Add the following library to your project's `build.gradle` file:

   ```
   repositories {
       maven { url 'https://jitpack.io' }
       google()
       mavenCentral()
       maven { url 'https://s01.oss.sonatype.org/content/repositories/snapshots/' }
   }
   ```

2. Add the following dependencies in the project's `build.gradle` file to import four modules: `AgoraEduUIKit`, `AgoraClassSDK`, `AgoraEduCore`, and `hyphenate`:

   ```
   dependencies {
         ...
         implementation "io.github.agoraio-community:hyphenate:{Version}"
         implementation "io.github.agoraio-community:AgoraEduCore:{Version}"
         implementation "io.github.agoraio-community:AgoraEduUIKit:{Version}"
         implementation "io.github.agoraio-community:AgoraClassSDK:{Version}"
   }
   ```

3. To launch a classroom, call [AgoraClassroomSDK.setConfig](/en/agora-class/agora_class_api_ref_android?platform=Android#setconfig) and [AgoraClassroomSDK.launch](/en/agora-class/agora_class_api_ref_android?platform=Android#launch). Sample code:

   ```kotlin
   fun startClassRoom() {
       val appId = "" // Pass your App ID
       val rtmToken = "" // Pass your RTM Token
       val streamState = AgoraEduStreamState(videoState = 1, audioState = 1)
     
       val config = AgoraEduLaunchConfig(
           "xiaoming", // The user name         
           "xiaoming2", // The user ID
           "agoraclass", // The room name         
           "agoraclass4", // The room ID
           2,  // The user role
           4,  // The room type
           rtmToken,
           System.currentTimeMillis(), // The class start time
           1800L, // The class duration
           AgoraEduRegion.na, // The region
           null,
           null,
           streamState, // Whether students automatically send audio or video streams after they "go onto the stage"
           AgoraEduLatencyLevel.AgoraEduLatencyLevelUltraLow, // The latency level
           null,
           null
       )
      
       config.appId = appId
       AgoraClassroomSDK.setConfig(AgoraClassSdkConfig(appId))
       AgoraClassroomSDK.launch(this, config, AgoraEduLaunchCallback { event ->
           Log.e(TAG, ":launch-Classroom State:" + event.name)
       }
   }
   ```

## See also

### Third-party libraries

No matter which method you choose, the third-party libraries used by Flexible Classroom may conflict with the third-party libraries on which your own project depends. You can use `exclude` to resolve this conflict or change the version that your project depends on.
