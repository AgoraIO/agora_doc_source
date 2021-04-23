## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

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

| 参数                | 描述                                     |
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

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `context`  | 应用程序的上下文环境。                                       |
| `config`   | 课堂启动配置，详见 `AgoraEduLaunchConfig`。                  |
| `callback` | SDK 通过 `AgoraEduLaunchCallback  `类向应用程序报告课堂启动相关的事件。 |

**返回值**

`AgoraEduClassRoom` 类。

### configCoursewares

```
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
```

配置课件预加载。

**参数**

| 参数    | 描述                                        |
| :------ | :------------------------------------------ |
| `wares` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### downCoursewares

```
public static void downloadCoursewares(@NotNull Context context, @Nullable AgoraEduCoursewarePreloadListener listener)
        throws Exception;
```

预加载课件。

**参数**

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `context`  | 应用程序的上下文环境。                                       |
| `listener` | SDK 通过 `AgoraEduCoursewarePreloadListener` 类向应用程序报告课件预加载相关的事件。 |

## AgoraEduLaunchCallback

`AgoraEduLaunchCallback` 类用于 SDK 向应用程序报告课堂启动相关的事件。

### onCallback

```
void onCallback(AgoraEduEvent state);
```

课堂事件回调。

| 参数    | 描述                             |
| :------ | :------------------------------- |
| `state` | 课堂事件，详见 `AgoraEduEvent`。 |

## AgoraEduCoursewarePreloadListener

`AgoraEduCoursewarePreloadListener` 类用于 SDK 向应用程序报告课件预加载相关的事件。

### onStartDownload

```
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

开始预加载课件。

| 参数   | 描述                                        |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### onProgress

```
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

课件预加载进度。

| 参数       | 描述                                        |
| :--------- | :------------------------------------------ |
| `ware`     | 课件预加载配置，详见 `AgoraEduCourseware`。 |
| `progress` | 进度。                                      |

### onComplete

```
void onComplete(@NotNull AgoraEduCourseware ware);
```

课件预加载完成。

| 参数   | 描述                                        |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

### onFailed

```
void onFailed(@NotNull AgoraEduCourseware ware);
```

课件预加载失败。

| 参数   | 描述                                        |
| :----- | :------------------------------------------ |
| `ware` | 课件预加载配置，详见 `AgoraEduCourseware`。 |

## 类型定义

### AgoraEduEvent

```
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
}
```

课堂事件。在 `onCallback` 回调中报告。

| 属性                     | 描述                      |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed`    | `0`: 进入课堂失败。       |
| `AgoraEduEventReady`     | `1`: 课堂准备完成。       |
| `AgoraEduEventDestroyed` | `2`: 课堂已销毁。         |
| `AgoraEduEventForbidden` | `3`: 用户被禁止进入课堂。 |

### AgoraEduRoleType

```
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

用户在课堂中的角色。在 `AgoraEduLaunchConfig` 中设置。

| 属性                      | 描述        |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: 学生。 |

### AgoraEduRoomType

```
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
}
```

课堂类型。在 `AgoraEduLaunchConfig` 中设置。

| 属性                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。 |
| `AgoraEduRoomTypeBig`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `AgoraEduRoomTypeSmall` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。 |

### AgoraEduSDKConfig

```
public class AgoraEduSDKConfig {
    @NotNull
    private String appId;
    private int eyeCare;
}
```

SDK 全局配置。用于 `setAgoraEduSDKConfig` 方法。

| 属性      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |
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

课堂启动配置。用于 `launch` 方法。

| 属性        | 描述                                                         |
| :---------- | :----------------------------------------------------------- |
| `userName`  | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `userUuid`  | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName`  | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid`  | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType`  | 用户在课堂中的角色，详见 `AgoraEduRoleType`。                |
| `roomType`  | 课堂类型，详见 `AgoraEduRoomType`。                          |
| `rtmToken`  | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。 |
| `startTime` | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`  | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |

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

| 属性           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 文件名称。                                                   |
| `scenePath`    | 文件的本地存储路径。建议由 `resourceName` 和  `scenes` 中第一个 `SceneInfo` 对象的 `name` 拼接而成，例如 `resourceName + "/" + sceneInfos.get(0).name`。 |
| `scenes`       | 完成转换的文件页面列表，由 `SceneInfo` 对象组成的数组。灵动课堂客户端会对后缀名 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以在课堂内的白板上分页展示该文件。每个 `SceneInfo` 对象对应一个页面。 |
| `resourceUrl`  | 文件的 URL 下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`。 |

### SceneInfo

```
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String name;
}
```

单个文件页面的具体信息。在 `AgoraEduCourseware` 中设置。

| 属性             | 描述                                              |
| :--------------- | :------------------------------------------------ |
| `componentCount` | 页面数量。                                        |
| `ppt`            | 完成转换后的一个页面的具体信息，详见 `Ppt` 对象。 |
| `name`           | 页面名称。                                        |

### Ppt

```
public class Ppt {
    private String src;
    private double width;
    private double height;
}
```

一个白板页面上展示的一个幻灯片的具体信息。在 `SceneInfo` 中设置。

| 属性     | 描述                            |
| :------- | :------------------------------ |
| `src`    | 完成转换的页面的 URL 下载地址。 |
| `width`  | 页面宽度（pixel）。             |
| `height` | 页面高度（pixel）。             |