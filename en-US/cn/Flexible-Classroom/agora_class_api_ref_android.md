## AgoraEduSDK

`AgoraEduSDK` provides the main methods that can be invoked by your app.

### version

```
public static String version();
```

查询 SDK 版本号。

**返回值**

SDK 版本号。

### setConfig

```
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
```

全局配置 SDK。

**参数**

| Parameter | Description |
| :------------------ | :--------------------------------------- |
| `agoraEduSDKConfig` | 全局配置参数，详见 `AgoraEduSDKConfig`。 |

### launch

```
public static AgoraEduClassRoom launch(@NotNull Context context, 
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

启动灵动课堂。

**参数**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | 应用程序的上下文环境。 |
| `config` | 课堂启动配置，详见 `AgoraEduLaunchConfig`。 |
| `callback` | SDK 通过 `AgoraEduLaunchCallback `类向应用程序报告课堂启动相关的事件。 |

**返回值**

`AgoraEduClassRoom` 类。

### configCoursewares

```
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
```

配置课件预加载。

**参数**

| Parameter | Description |
| :------ | :------------------------------------------ |
| `wares` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### cacheCoursewares

```
public static void cacheCoursewares(@NotNull Context context, @Nullable AgoraEduCoursewarePreloadListener listener)
        throws Exception;
```

预加载课件。

**参数**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `context` | 应用程序的上下文环境。 |
| `listener` | SDK 通过 `AgoraEduCoursewarePreloadListener` 类向应用程序报告课件预加载相关的事件。 |

## AgoraEduLaunchCallback

`AgoraEduLaunchCallback` 类用于 SDK 向应用程序报告课堂启动相关的事件。

### onCallback

```
void onCallback(AgoraEduEvent state);
```

课堂事件回调。

| Parameter | Description |
| :------ | :------------------------------- |
| `state` | 课堂事件，详见 `AgoraEduEvent`。 |

## AgoraEduCoursewarePreloadListener

`AgoraEduCoursewarePreloadListener` 类用于 SDK 向应用程序报告课件预加载相关的事件。

### onStartDownload

```
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

开始预加载课件。

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### onProgress

```
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

课件预加载进度。

| Parameter | Description |
| :--------- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |
| `progress` | 进度。 |

### onComplete

```
void onComplete(@NotNull AgoraEduCourseware ware);
```

课件预加载完成。

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### onFailed

```
void onFailed(@NotNull AgoraEduCourseware ware);
```

课件预加载失败。

| Parameter | Description |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

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

课堂事件。 在 `onCallback` 回调中报告。

| Attributes | Description |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed` | `0`: 进入课堂失败。 |
| `AgoraEduEventReady` | `1`: 课堂准备完成。 |
| `AgoraEduEventDestroyed` | `2`: 课堂已销毁。 |
| `AgoraEduEventForbidden` | `3`: 用户被禁止进入课堂。 |

### AgoraEduRoleType

```
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

用户在课堂中的角色。 在 `AgoraEduLaunchConfig` 中设置。

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: 学生。 |

### AgoraEduRoomType

```
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4);
}
```

课堂类型。 在 `AgoraEduLaunchConfig` 中设置。

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: 互动直播大班课。 1 位老师进行在线教学，多名学生实时观看和收听。 学生人数无上限。 上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `AgoraEduRoomTypeSmall` | `4`: 在线互动小班课。 1 位老师进行在线教学，多名学生实时观看和收听。 课堂人数上限为 500。 上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。 |

### AgoraEduSDKConfig

```
public class AgoraEduSDKConfig {
    @NotNull
    private String appId;
    private int eyeCare;
}
```

The SDK global configuration. 用于 `setAgoraEduSDKConfig` 方法。

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | 是否开启护眼模式：<li>`0`:（默认）关闭护眼模式。</li><li>`1`: 开启护眼模式。</li> |

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

The classroom launching configuration. 用于 `launch` 方法。

| Attributes | Description |
| :---------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | User ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0 to 9.<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | 用户在课堂中的角色，详见 `AgoraEduRoleType`。 |
| `roomType` | 课堂类型，详见 `AgoraEduRoomType`。 |
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

课件预加载配置，用于 `configCoursewares` 方法。

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 资源名称，必须要 `"/"` 开头。 |
| `scenePath` | 课件目录，建议设为 `resourceName` + "/" + `sceneInfos` 中第一个对象的name |
| `scenes` | 课件页面列表，每个 `SceneInfo` 对象对应一个页面。 |
| `resourceUrl` | 课件下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`。 |

### SceneInfo

```
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String name;
}
```

课件页面列表。 在 `AgoraEduCourseware` 中设置。

| Attributes | Description |
| :--------------- | :-------------------------- |
| `componentCount` | PPT 数量。 |
| `ppt` | PPT 信息，详见 `Ppt` 对象。 |
| `name` | PPT 名称。 |

### Ppt

```
public class Ppt {
    private String src;
    private double width;
    private double height;
}
```

PPT 信息。 在 `SceneInfo` 中设置。

| Attributes | Description |
| :------- | :---------------------- |
| `src` | 转换后的 PPT 下载地址。 |
| `width` | PPT 宽度。 |
| `height` | PPT 高度。 |