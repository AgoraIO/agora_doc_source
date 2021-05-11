This page provides  Agora reference of Agora Classroom SDK for Android.

## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### version

```java
public static String version();
```

Gets the SDK version.

**Returns**

The SDK version.

### setConfig

```java
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
```

Globally configures the SDK.

**Sample code**

```java
/** Global Configuration */
// Agora App ID
String appId = "XXX";
// Whether to enable eye care mode
boolean eyeCare = false;
AgoraEduSDK.setConfig(new AgoraEduSDKConfig(appId, eyeCare));
```

**Parameter**

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `agoraEduSDKConfig` | The SDK global configuration, see [`AgoraEduSDKConfig`](#agoraedusdkconfig). |

### launch

```java
public static AgoraEduClassRoom launch(@NotNull Context context, 
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

Launches a flexible classroom.

**Sample code**

```java
/** Classroom launching configuration */
// The user name
String userName = "XXX";
// The user ID. Must be the same as the UID that you use for generating an RTM token.
String userUUid = "XXX";
// The classroom name
String roomName = "XXX";
// The classroom ID
String roomUuid = "XXX";
// The user role
int roleType = AgoraEduRoleType.AgoraEduRoleTypeStudent.getValue();
// The classroom type
int roomType = AgoraEduRoomType.AgoraEduRoomType1V1.getValue()/AgoraEduRoomType.AgoraEduRoomTypeSmall.getValue()/AgoraEduRoomType.AgoraEduRoomTypeBig.getValue();
// The RTM token
String rtmToken = "";
// The start time (ms) of the class, determined by the first user joining the classroom.
long startTime = System.currentTimeMillis() + 100;
// The duration (ms) of the class, determined by the first user joining the classroom.
long duration = 310L;
// The area where the classroom is located, the area of each client must be the same, otherwise it will not be able to communicate. 
String region = AgoraEduRegionStr.cn;
AgoraEduLaunchConfig agoraEduLaunchConfig = new AgoraEduLaunchConfig(
        userName, userUuid, roomName, roomUuid, roleType, roomType, rtmToken, startTime, duration);
AgoraEduClassRoom classRoom = AgoraEduSDK.launch(getApplicationContext(), agoraEduLaunchConfig, (state) -> {
    Log.e(TAG, "launch-classroom-state:" + state.name());
});
```

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `config` | The classroom launching configuration, see [`AgoraEduLaunchConfig`](#agoraedulaunchconfig). |
| `callback` | The SDK uses the[`  AgoraEduLaunchCallback`](#agoraedulaunchcallback) class to report events related to classroom launching to the app. |

**Returns**

The` AgoraEduClassRoom` class.

### configCoursewares

```java
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
```

Configures downloading courseware before entering a classroom.

**Sample code**

```java
/** Construct and configure courseware */
// Configure courseware
String taskUuid = "xxxxx";
// Courseware download address
String resourceUrl = String.formate ("https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip", taskUuid);
// Courseware name
String resourceName = "xxxxxxx"
// Courseware page list
List<SceneInfo> sceneInfos = new ArrayList();
// Converted page PPT link
String src = "http://xxxxxxx";
Ppt ppt = new Ppt(src, 360, 640);
SceneInfo sceneInfo = new SceneInfo(1, ppt, "ppt-file-name");
List<SceneInfo> sceneInfos = new ArrayList();
sceneInfos.push(sceneInfo)
// Courseware catalog
String scenePath = resourceName + "/" + sceneInfos.get(0).name;
AgoraEduCourseware courseware = new AgoraEduCourseware(resourceName, scenePath, sceneInfos, resourceUrl);
List<AgoraEduCourseware> wares = new ArrayList();
wares.add(courseware);
// Configure courseware preload
configCoursewares(wares);
```

**Parameter**

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `wares` | The courseware pre-downloading configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |

### downloadCoursewares

```java
public static void downloadCoursewares(@NotNull Context context, @Nullable AgoraEduCoursewarePreloadListener listener)
        throws Exception;
```

Pre-download the courseware.

**Sample code**

```java
// Download the configured courseware
downloadCoursewares(activityContext, new AgoraEduCoursewarePreloadListener() {
    @Override
    void onStartDownload(@NotNull AgoraEduCourseware ware);
    }
    @Override
    void onProgress(@NotNull AgoraEduCourseware ware, double progress);
    }
    @Override
    void onComplete(@NotNull AgoraEduCourseware ware);
    }
    @Override
    void onFailed(@NotNull AgoraEduCourseware ware);
    }
});
```

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `listener` | The SDK reports events related to [`courseware preloading`](#agoraeducoursewarepreloadlistener) to the app through the AgoraEduCoursewarePreloadListener class. |

### registerExtApps

```java
public static void registerExtApps(List<AgoraExtAppConfiguration> apps);
```

Register the extension application ExtApp. ExtApp is a supplementary plug-  Flexible Classroom UIKit of Smart Classroom. For details, see[ Customize Plug-ins via ExtApp](./agora_class_ext_app_android?platform=Android).

## AgoraEduLaunchCallback

The` AgoraEduLaunchCallback` class reports events related to class launching to the app.

### onCallback

```java
void onCallback(AgoraEduEvent state);
```

Reports classroom events.

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | The classroom events. See [`AgoraEduEven`](#agoraeduevent). |

## AgoraEduCoursewarePreloadListener

The` AgoraEduCoursewarePreloadListener` class reports events related to courseware preloading to the app.

### onStartDownload

```java
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

Start preloading the courseware.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `ware` | The courseware pre-downloading configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |

### onProgress

```java
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

Indicates the progress of courseware pre-downloading.

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `ware` | The courseware pre-downloading configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |
| `progress` | Indicates the progress of courseware pre-downloading. |

### onComplete

```java
void onComplete(@NotNull AgoraEduCourseware ware);
```

The courseware pre-downloading completes.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `ware` | The courseware pre-downloading configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |

### onFailed

```java
void onFailed(@NotNull AgoraEduCourseware ware);
```

The courseware pre-downloading fails.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `ware` | The courseware pre-downloading configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |

## Type definition

### AgoraEduEvent

```java
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
}
```

Classroom events. Reported in the [`onCallback`](#oncallback) callback.

| Attributes | Description |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed` | `0`: The user fails to enter the classroom. |
| `AgoraEduEventReady` | `1`: The classroom is ready. |
| `AgoraEduEventDestroyed` | `2`: The classroom has been destroyed. |
| `AgoraEduEventForbidden` | `3`: The user is forbidden by the Flexible Classroom cloud service and not allowed to enter the classroom. |

### AgoraEduRoleType

```java
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

The role of the user in the classroom. You need to set the[` user role in AgoraEduLaunchConfig`](#agoraedulaunchconfig).

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```java
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
}
```

The classroom type. You need to set the[` user role in AgoraEduLaunchConfig`](#agoraedulaunchconfig).

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduSDKConfig

```java
public class AgoraEduSDKConfig {
    @NotNull
    private String appId;
    private int eyeCare;
}
```

The SDK global configuration. Used when calling [`setConfig`](#setconfig).

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`0`: (Default) Disable eye care mode.</li><li>`1`: Enable eye care mode.</li> |

### AgoraEduLaunchConfig

```java
public class AgoraEduLaunchConfig implements Parcelable {
    @NotNull
    private String userName;
    @NotNull
    private String userUuid;
    @NotNull
    private String roomName;
    @NotNull
    private String roomUuid;
    private int roleType = EduUserRole.STUDENT.getValue();
    private int roomType;
    @NotNull
    private String rtmToken;
    @Nullable
    private Long startTime;
    @Nullable
    private Long duration;
    @Nullable
    private String boardRegion;
}
```

The classroom launching configuration. Used when calling [`launch`](#launch).

| Attributes | Description |
| :------------ | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user.** Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The user's role in the classroom. See [`AgoraEduRoleType`](#agoraeduroletype). |
| `roomType` | The classroom type. See [`AgoraEduRoomType`](#agoraeduroomtype). |
| `rtmToken` | The RTM token used for authentication, see[ Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `boardRegion` | The area where the classroom is located. The area of each client must be the same, otherwise they cannot communicate with each other. See [](). |

### AgoraEduCourseware

```java
data class AgoraEduCourseware(
        val resourceName: String?,
        val scenePath: String?,
        val scenes: List<SceneInfo>?,
        val resourceUrl: String?
) {
}
```

The courseware pre-loaded configuration.  Used when calling [`configCoursewares`](#configcoursewares).

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name. |
| `scenePath` | The local path for storing the file. Agora recommends setting this parameter as the combination of `resourceName` and` the name of` the first `SceneInfo` object in `scenes`, such as,` resourceName + "/" + sceneInfos.get(0).name`. |
| `scenes` | A list of converted file pages, an array of `SceneInfo` objects. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom and then display the file on the whiteboard in pages. Each `SceneInfo` object represents one page. |
| `resourceUrl` | The URL address of the file, such as `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`. |

### SceneInfo

```java
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String name;
}
```

The detailed information of a page. Set in [`AgoraEduCourseware`](#agoraeducourseware).

| Attributes | Description |
| :--------------- | :-------------------------------------------------------- |
| `componentCount` | The number of pages. |
| `ppt` | The detailed information of a converted page. See [`Ppt`](#ppt). |
| `name` | The page name. |

### Ppt

```java
public class Ppt {
    private String src;
    private double width;
    private double height;
}
```

The detailed information of a page displayed on the whiteboard. Set in [`SceneInfo`](#sceneinfo).

| Attributes | Description |
| :------- | :------------------------------ |
| `src` | The URL address of the converted page. |
| `width` | The width (pixel) of the page. |
| `height` | The height (pixel) of the page. |

### AgoraEduRegionStr

```java
object AgoraEduRegionStr {
    Val cn = "CN-HZ"
    val na = "us-sv"
    val eu = "gb-lon"
    val ap = "sg"
}
```

The area where the classroom is located.

| Attributes | Description |
| :--- | :--------- |
| `cn` | Mainland China. |
| `on` | Kitami. |
| `me` | Europe. |
| `ap` | Asia Pacific. |