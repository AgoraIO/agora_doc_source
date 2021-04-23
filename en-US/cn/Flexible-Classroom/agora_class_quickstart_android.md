Use this guide to integrate the Agora Classroom SDK into your Web project and call APIs to launch a flexible classroom.

<div class="alert note"><li>Before proceeding, ensure that you make the <a href="./agora_class_prep">preparations</a> required for using Flexible Classroom.<li>The Android client only supports students.</div>

## Sample project
Agora provides an open-source [sample project](https://github.com/AgoraIO-Community/CloudClass-Android) on GitHub, which demonstrates how to integrate the Agora Classroom SDK and call APIs to launch a flexible classroom. You can download and read the source code.

## Set up the development environment

- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html).
- Android Studio 2.0 or later.
- An Android device. A physical Android device.
- Android 4.4 or later.
- Physical media input devices, such as a built-in camera and a built-in microphone.

## Integrate the Agora Classroom SDK

Get the Agora Edu SDK through the Gradle, as follows:

1. Add the following library to your project's **build.gradle** file:
```java
	allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```

2. Add the following dependency to your project's **build.gradle** file:

```java
	dependencies {
      ...
		// Please check the release instructions for the latest version number
		 dependencies {
      ...
  // Get the latest version number through the release notes
  implementation 'com.github.AgoraIO-Community:CloudClass-Android:v1.0.0'
 }
	}
```


## Global configuration

First, create an `AgoraEduSDKConfig` instance for global configuration, and then call the `setConfig` method and pass in this instance. The` AgoraEduSDKConfig` instance includes the following parameters:

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`false`: (default) Disable eye care mode.<li>`true`: Enable eye care mode. |

```java
/**Global Configuration*/
 // Agora App ID
String appId = "XXX";
//Whether to enable eye care mode
boolean eyeCare = false;
AgoraEduSDK.setConfig(new AgoraEduSDKConfig(appId, eyeCare));
```

## Launch a classroom

After initialization, create an `AgoraEduLaunchConfig` instance for configuring the classroom startup configuration, and then call` the launch` method to pass in the instance. The` AgoraEduLaunchConfig` instance includes the following parameters:

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The role of the user in the classroom:<li>`AgoraEduRoleTypeStudent`: Student |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomType` | The room type:<li>`AgoraEduRoomType1V1`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student.<li>`AgoraEduRoomTypeSmall`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher.<li>`AgoraEduRoomTypeBig`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `rtmToken` | The RTM token used for authentication, see [Generate an RTM Token](./agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |

```java
/** Class start configuration */
//The user name
String userName = "XXX";
//The user ID. Must be the same as the UID that you use for generating an RTM token.
String userName = "XXX";
//The classroom name
String roomName = "XXX";
//The classroom ID
String roomUuid = "XXX";
user role
int roleType = AgoraEduRoleType.AgoraEduRoleTypeStudent.getValue();
// class type
int roomType = AgoraEduRoomType.AgoraEduRoomType1V1.getValue()/AgoraEduRoomType.AgoraEduRoomTypeSmall.getValue()/AgoraEduRoomType.AgoraEduRoomTypeBig.getValue();
//The RTM token
String rtmToken = "";
The start time (ms) of the class, determined by the first user joining the classroom.
long startTime = System.currentTimeMillis() + 100;
The duration (ms) of the class, determined by the first user joining the classroom.
long duration = 310L;
AgoraEduLaunchConfig agoraEduLaunchConfig = new AgoraEduLaunchConfig(
               userName, userUuid, roomName, roomUuid, roleType, roomType, rtmToken);
AgoraEduClassRoom classRoom = AgoraEduSDK.launch(getApplicationContext(), agoraEduLaunchConfig, (state) -> {
       Log.e(TAG, "launch-Classroom-Status:" + state.name());
});
```

After successfully launching a classroom, you can see the following page:

![](https://web-cdn.agora.io/docs-files/1619164553801)