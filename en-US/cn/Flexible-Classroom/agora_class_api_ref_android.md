## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### version

```
public static String version();
```

Gets the SDK version.

**Returns**

The SDK version.

### setConfig

```
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
```

Globally configures the SDK.

**Parameter**

| Parameter | Description |
| :------------------ | :--------------------------------------- |
| `agoraEduSDKConfig` | The SDK global configuration, see `AgoraEduSDKConfig`. |

### launch

```
public static AgoraEduClassRoom launch(@NotNull Context context, 
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

Launches a flexible classroom.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `config` | The classroom launching configuration, see `AgoraEduLaunchConfig`. |
| `callback` | The SDK reports events related to classroom launching to the app through the `AgoraEduLaunchCallback` class. |

**Returns**

`The AgoraEduClassRoom` class.

### configCoursewares

```
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
```

Configures downloading courseware before entering a classroom.

**Parameter**

| Parameter | Description |
| :------ | :------------------------------------------ |
| `wares` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### downCoursewares

```
public static void downloadCoursewares(@NotNull Context context, @Nullable AgoraEduCoursewarePreloadListener listener)
        throws Exception;
```

Pre-download the courseware.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `listener` | The SDK reports events related to courseware preloading to the app through the `AgoraEduCoursewarePreloadListener` class. |

## AgoraEduLaunchCallback

`The AgoraEduLaunchCallback` class reports events related to class launching to the app.

### onCallback

```
void onCallback(AgoraEduEvent state);
```

Reports classroom events.

| Parameter | Description |
| :------ | :------------------------------- |
| `state` | The classroom events. See `AgoraEduEven`. |

## AgoraEduCoursewarePreloadListener

`The AgoraEduCoursewarePreloadListener` class reports events related to courseware preloading to the app.

### onStartDownload

```
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

Start preloading the courseware.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### onProgress

```
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

Indicates the progress of courseware pre-downloading.

| Parameter | Description |
| :--------- | :------------------------------------------ |
| `ware` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |
| `progress` | The courseware pre-downloading progress. |

### onComplete

```
void onComplete(@NotNull AgoraEduCourseware ware);
```

The courseware pre-downloading completes.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### onFailed

```
void onFailed(@NotNull AgoraEduCourseware ware);
```

The courseware pre-downloading fails.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

## Type definition

### AgoraEduEvent

```
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
}
```

Classroom events. Reported in the `onCallback` callback.

| Attributes | Description |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed` | `0`: The user fails to enter the classroom. |
| `AgoraEduEventReady` | `1`: The classroom is ready. |
| `AgoraEduEventDestroyed` | `2`: The classroom has been destroyed. |
| `AgoraEduEventForbidden` | `3`: The user is forbidden by the Flexible Classroom cloud service and not allowed to enter the classroom. |

### AgoraEduRoleType

```
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

The role of the user in the classroom. You need to set the user role in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
}
```

The classroom type. You need to set the user role in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduSDKConfig

```
public class AgoraEduSDKConfig {
    @NotNull
    private String appId;
    private int eyeCare;
}
```

The SDK global configuration. Used when calling `AgoraEduSDK.config`.

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`0`: (Default) Disable eye care mode.</li><li>`1`: Enable eye care mode.</li> |

### AgoraEduLaunchConfig

```
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
}
```

The classroom launching configuration. Used when calling `launch`.

| Attributes | Description |
| :---------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The user's role in the classroom. See `AgoraEduRoleType`. |
| `roomType` | The classroom type. See `AgoraEduRoomType`. |
| `rtmToken` | The RTM token used for authentication, see [Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |

### AgoraEduCourseware

```
data class AgoraEduCourseware(
        val resourceName: String?,
        val scenePath: String?,
        val scenes: List<SceneInfo>?,
        val resourceUrl: String?
) {
}
```

The courseware pre-loaded configuration.  Used when calling `configCoursewares`.

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 文件名称。 |
| `scenePath` | 文件路径。 建议由 `resourceName` 和  `scenes` 中第一个 `SceneInfo` 对象的 `name` 拼接而成，例如 `resourceName + "/" + sceneInfos.get(0).name`。 |
| `scenes` | 完成转换的文件页面列表，由 `SceneInfo` 对象组成的数组。 灵动课堂客户端会对后缀名 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以在课堂内的白板上分页展示该文件。 每个 `SceneInfo` 对象对应一个页面。 |
| `resourceUrl` | 文件的 URL 下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`。 |

### SceneInfo

```
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String name;
}
```

单个文件页面的具体信息。 Set in `AgoraEduCourseware`.

| Attributes | Description |
| :--------------- | :------------------------------------------------ |
| `componentCount` | 页面数量。 |
| `ppt` | 完成转换后的一个页面的具体信息，详见 `Ppt` 对象。 |
| `name` | 页面名称。 |

### Ppt

```
public class Ppt {
    private String src;
    private double width;
    private double height;
}
```

一个白板页面上展示的一个幻灯片的具体信息。 Set in `SceneInfo`.

| Attributes | Description |
| :------- | :------------------------------ |
| `src` | 完成转换的页面的 URL 下载地址。 |
| `width` | 页面宽度（pixel）。 |
| `height` | 页面高度（pixel）。 |