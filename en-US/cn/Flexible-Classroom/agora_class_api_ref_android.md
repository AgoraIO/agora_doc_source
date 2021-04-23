## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

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
| `callback` | SDK 通过 `AgoraEduLaunchCallback  `类向应用程序报告课堂启动相关的事件。 |

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

Preload the courseware.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `listener` | The SDK reports events related to `courseware preloading` to the application through the AgoraEduCoursewarePreloadListener class. |

## AgoraEduLaunchCallback

The` AgoraEduLaunchCallback` class is used by the SDK to report events related to class launching to the application.

### onCallback

```
void onCallback(AgoraEduEvent state);
```

Class event callback.

| Parameter | Description |
| :------ | :------------------------------- |
| `state` | For classroom events, see AgoraEduEvent for details``. |

## AgoraEduCoursewarePreloadListener

The` AgoraEduCoursewarePreloadListener` class is used by the SDK to report events related to courseware preloading to the application.

### onStartDownload

```
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

Start preloading the courseware.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `would` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### onProgress

```
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

Courseware pre-download configuration.

| Parameter | Description |
| :--------- | :------------------------------------------ |
| `would` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |
| `progress` | schedule. |

### onComplete

```
void onComplete(@NotNull AgoraEduCourseware ware);
```

Courseware pre-download configuration.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `would` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### onFailed

```
void onFailed(@NotNull AgoraEduCourseware ware);
```

Courseware pre-download configuration.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `would` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

## Type definition

### AgoraEduEvent

```
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden (3);
}
```

Class event. Reported in the `onCallback` callback.

| Attributes | Description |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed` | `0`: Failed to enter the classroom. |
| `AgoraEduEventReady` | `1`: Class preparation is complete. |
| `AgoraEduEventDestroyed` | `2`: The classroom has been destroyed. |
| `AgoraEduEventForbidden` | `3`: The user is prohibited from entering the classroom. |

### AgoraEduRoleType

```
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent: Student
}
```

The role of the user in the classroom. Set in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent`: Student | `2`: Student. |

### AgoraEduRoomType

```
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4);
}
```

Classroom type. Set in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. Students can "raise their hands" to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Online interactive small class. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in the classroom is 500. During the class, the teacher can invite students to speak "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduSDKConfig

```
public class AgoraEduSDKConfig {
    @NotNull
    private String appIdentifier;
    private int eyeCare;
}
```

The SDK global configuration. Used when calling `AgoraEduSDK.config`.

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`NO`: (Default) Disable eye care mode.</li><li>`YES`: Enable eye care modee.</li> |

### The AgoraEduLaunchConfig instance includes the following parameters:

```
public class AgoraEduLaunchConfig implements Parcelable {
    @NotNull
    private String userName;
    @NotNull
    private String userUuid;
    @NotNull
    private String scheme;
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

The classroom launching configuration. Used in the `launch` method.

| Attributes | Description |
| :---------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | For the user's role in the classroom, see AgoraEduRoleType for details``. |
| `roomType` | Classroom type, see AgoraEduRoomType for details``. |
| `rtmToken` | The RTM token used for authentication, see [Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |

### AgoraEduCourseware

```
data class AgoraEduCourseware(
        resourceName: string,
        val scenePath: String?,
        val scenes: List<SceneInfo>?,
        val resourceUrl: String?
) {
}
```

Courseware pre-loaded configuration, used in `configCoursewares` method.

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 资源名称，要以 `"/"` 开头。 |
| `scenePath` | 资源目录，建议设为 `resourceName` + "/" + `sceneInfos` 中第一个对象的name |
| `scenes` | 资源列表。 灵动课堂的云盘组件会分页展示资源，每个 `SceneInfo` 对象对应一个页面。 |
| `resourceUrl` | 资源的 URL 下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`。 |

### SceneInfo

```
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String scheme;
}
```

List of courseware pages. Set in `AgoraEduCourseware`.

| Attributes | Description |
| :--------------- | :----------------------------------------------------------- |
| `componentCount` | 课件数量。 |
| `ppt` | 当课件类型为 PPT 时，需要设置 `ppt` 指定 PPT 的具体信息，详见 `Ppt` 对象。 |
| `name` | 课件名称。 |

### Ppt

```
public class Ppt {
    private String scheme;
    private double width;
    private double height;
}
```

PPT information. Set in `SceneInfo`.

| Attributes | Description |
| :------- | :---------------------- |
| `src` | The converted PPT download address. |
| `width`, | PPT 宽度（pixel）。 |
| `height`, | PPT 高度（pixel）。 |