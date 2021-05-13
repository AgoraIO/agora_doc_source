本页提供 Agora Classroom SDK for Android 的 Kotlin API 参考。

## AgoraEduSDK

`AgoraEduSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### version

```java
public static String version();
```

查询 SDK 版本号。

**返回值**

SDK 版本号。

### setConfig 

```java
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
```

全局配置 SDK。

**示例代码**

```java
/** 进行全局配置 */
// Agora App ID
String appId = "XXX";
// 是否开启护眼模式
boolean eyeCare = false;
AgoraEduSDK.setConfig(new AgoraEduSDKConfig(appId, eyeCare));
```

**参数**

| 参数                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| `agoraEduSDKConfig` | 全局配置参数，详见 [`AgoraEduSDKConfig`](#agoraedusdkconfig)。 |

### launch

```java
public static AgoraEduClassRoom launch(@NotNull Context context, 
                                       @NotNull AgoraEduLaunchConfig config,
                                       @NotNull AgoraEduLaunchCallback callback);
```

启动灵动课堂。

**示例代码**

```java
/** 课堂启动配置 */
// 用户名
String userName = "XXX";
// 用户 ID，需要与你生成 RTM Token 时使用的用户 ID 一致
String userUuid = "XXX";
// 教室名称
String roomName = "XXX";
// 教室 ID
String roomUuid = "XXX";
// 用户角色
int roleType = AgoraEduRoleType.AgoraEduRoleTypeStudent.getValue();
// 课堂类型
int roomType = AgoraEduRoomType.AgoraEduRoomType1V1.getValue()/AgoraEduRoomType.AgoraEduRoomTypeSmall.getValue()/AgoraEduRoomType.AgoraEduRoomTypeBig.getValue();
// RTM Token
String rtmToken = "";
// 课堂开始时间，单位为毫秒，以第一个进入教室的用户传入的参数为准
long startTime = System.currentTimeMillis() + 100;
// 课堂持续时间，单位为秒，以第一个进入教室的用户传入的参数为准
long duration = 310L;
// 课堂所在区域，各客户端的区域必须一致，否则无法互通。
String region = AgoraEduRegionStr.cn;
AgoraEduLaunchConfig agoraEduLaunchConfig = new AgoraEduLaunchConfig(
        userName, userUuid, roomName, roomUuid, roleType, roomType, rtmToken, startTime, duration, region);
AgoraEduClassRoom classRoom = AgoraEduSDK.launch(getApplicationContext(), agoraEduLaunchConfig, (state) -> {
    Log.e(TAG, "launch-课堂状态:" + state.name());
});
```

**参数**

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `context`  | App 的上下文环境。                                           |
| `config`   | 课堂启动配置，详见 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig)。 |
| `callback` | SDK 通过 [`AgoraEduLaunchCallback  `](#agoraedulaunchcallback) 类向 App 报告课堂启动相关的事件。 |

**返回值**

`AgoraEduClassRoom` 类。

### configCoursewares

```java
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
```

配置课件预加载。

**示例代码**

```java
/** 构造、配置课件 */
// 构造课件
String taskUuid = "xxxxx";
// 课件下载地址
String resourceUrl = String.formate("https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip", taskUuid);
// 课件名称
String resourceName = "xxxxxxx"
// 课件页面列表
List<SceneInfo> sceneInfos = new ArrayList();
// 转换后的一页 PPT 链接
String src = "http://xxxxxxx";
Ppt ppt = new Ppt(src, 360, 640);
SceneInfo sceneInfo = new SceneInfo(1, ppt, "ppt-file-name");
List<SceneInfo> sceneInfos = new ArrayList();
sceneInfos.add(sceneInfo);
// 课件目录
String scenePath = resourceName + "/" + sceneInfos.get(0).name;
AgoraEduCourseware courseware = new AgoraEduCourseware(resourceName, scenePath, sceneInfos, resourceUrl);
List<AgoraEduCourseware> wares = new ArrayList();
wares.add(courseware);
// 配置课件预加载
configCoursewares(wares);
```

**参数**

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `wares` | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |

### downloadCoursewares

```java
public static void downloadCoursewares(@NotNull Context context, @Nullable AgoraEduCoursewarePreloadListener listener)
        throws Exception;
```

预加载课件。

**示例代码**

```java
// 下载配置好的课件
downloadCoursewares(activityContext, new AgoraEduCoursewarePreloadListener() {
    @Override
    public void onStartDownload(@NotNull AgoraEduCourseware ware) {
    }
    @Override
    public void onProgress(@NotNull AgoraEduCourseware ware, double progress) {
    }
    @Override
    public void onComplete(@NotNull AgoraEduCourseware ware) {
    }
    @Override
    public void onFailed(@NotNull AgoraEduCourseware ware) {
    }
});
```

**参数**

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `context`  | App 的上下文环境。                                           |
| `listener` | SDK 通过 [`AgoraEduCoursewarePreloadListener`](#agoraeducoursewarepreloadlistener) 类向 App 报告课件预加载相关的事件。 |

### registerExtApps

```java
public static void registerExtApps(List<AgoraExtAppConfiguration> apps);
```

注册扩展应用 ExtApp。ExtApp 是灵动课堂 UIKit 的补充插件。详见[通过 ExtApp 自定义插件](./agora_class_ext_app_android?platform=Android)。

## AgoraEduLaunchCallback

`AgoraEduLaunchCallback` 类用于 SDK 向 App 报告课堂启动相关的事件。

### onCallback

```java
void onCallback(AgoraEduEvent state);
```

课堂事件回调。

| 参数    | 描述                                               |
| :------ | :------------------------------------------------- |
| `state` | 课堂事件，详见 [`AgoraEduEvent`](#agoraeduevent)。 |

## AgoraEduCoursewarePreloadListener

`AgoraEduCoursewarePreloadListener` 类用于 SDK 向 App 报告课件预加载相关的事件。

### onStartDownload

```java
void onStartDownload(@NotNull AgoraEduCourseware ware);
```

开始预加载课件。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `ware` | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |

### onProgress

```java
void onProgress(@NotNull AgoraEduCourseware ware, double progress);
```

课件预加载进度。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `ware`     | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |
| `progress` | 课件预加载进度。                                             |

### onComplete

```java
void onComplete(@NotNull AgoraEduCourseware ware);
```

课件预加载完成。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `ware` | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |

### onFailed

```java
void onFailed(@NotNull AgoraEduCourseware ware);
```

课件预加载失败。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `ware` | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |

## 类型定义

### AgoraEduEvent

```java
public enum AgoraEduEvent {
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
    AgoraEduEventForbidden(3);
}
```

课堂事件。在 [`onCallback`](#oncallback) 回调中报告。

| 属性                     | 描述                      |
| :----------------------- | :------------------------ |
| `AgoraEduEventFailed`    | `0`: 进入课堂失败。       |
| `AgoraEduEventReady`     | `1`: 课堂准备完成。       |
| `AgoraEduEventDestroyed` | `2`: 课堂已销毁。         |
| `AgoraEduEventForbidden` | `3`: 用户被禁止进入课堂。 |

### AgoraEduRoleType

```java
public enum AgoraEduRoleType {
   AgoraEduRoleTypeStudent(2);
}
```

用户在课堂中的角色。在 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig) 中设置。

| 属性                      | 描述        |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: 学生。 |

### AgoraEduRoomType

```java
public enum AgoraEduRoomType {
   AgoraEduRoomType1V1(0),
   AgoraEduRoomTypeSmall(4),
   AgoraEduRoomTypeBig(2);
}
```

课堂类型。在 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig) 中设置。

| 属性                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。 |
| `AgoraEduRoomTypeBig`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。 |
| `AgoraEduRoomTypeSmall` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。 |

### AgoraEduSDKConfig

```java
public class AgoraEduSDKConfig {
    @NotNull
    private String appId;
    private int eyeCare;
}
```

SDK 全局配置。用于 [`setConfig`](#setconfig) 方法。

| 属性      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |
| `eyeCare` | 是否开启护眼模式：<li>`0`:（默认）关闭护眼模式。</li><li>`1`: 开启护眼模式。</li> |

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

课堂启动配置。用于 [`launch`](#launch) 方法。

| 属性          | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| `userName`    | 用户名，用于课堂内显示，长度在 64 字节以内。                 |
| `userUuid`    | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName`    | 课堂名，用于课堂内显示，长度在 64 字节以内。                 |
| `roomUuid`    | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType`    | 用户在课堂中的角色，详见 [`AgoraEduRoleType`](#agoraeduroletype)。 |
| `roomType`    | 课堂类型，详见 [`AgoraEduRoomType`](#agoraeduroomtype)。     |
| `rtmToken`    | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。 |
| `startTime`   | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。 |
| `duration`    | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。 |
| `boardRegion` | 课堂所在区域。各个客户端的区域必须一致，否则无法互通。详见 []()。 |

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

课件预加载配置，用于 [`configCoursewares`](#configcoursewares) 方法。

| 属性           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | 文件名称。                                                   |
| `scenePath`    | 文件的本地存储路径。建议由 `resourceName` 和  `scenes` 中第一个 `SceneInfo` 对象的 `name` 拼接而成，例如 `resourceName + "/" + sceneInfos.get(0).name`。 |
| `scenes`       | 完成转换的文件页面列表，由 `SceneInfo` 对象组成的数组。灵动课堂客户端会对后缀名 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以在课堂内的白板上分页展示该文件。每个 `SceneInfo` 对象对应一个页面。 |
| `resourceUrl`  | 文件的 URL 下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`。 |

### SceneInfo

```java
public class SceneInfo {
    private int componentCount;
    private Ppt ppt;
    private String name;
}
```

单个文件页面的具体信息。在 [`AgoraEduCourseware`](#agoraeducourseware) 中设置。

| 属性             | 描述                                                      |
| :--------------- | :-------------------------------------------------------- |
| `componentCount` | 页面数量。                                                |
| `ppt`            | 完成转换后的一个页面的具体信息，详见 [`Ppt`](#ppt) 对象。 |
| `name`           | 页面名称。                                                |

### Ppt

```java
public class Ppt {
    private String src;
    private double width;
    private double height;
}
```

一个白板页面上展示的一个幻灯片的具体信息。在 [`SceneInfo`](#sceneinfo) 中设置。

| 属性     | 描述                            |
| :------- | :------------------------------ |
| `src`    | 完成转换的页面的 URL 下载地址。 |
| `width`  | 页面宽度（pixel）。             |
| `height` | 页面高度（pixel）。             |

### AgoraEduRegionStr

```java
object AgoraEduRegionStr {
    val cn = "cn-hz"
    val na = "us-sv"
    val eu = "gb-lon"
    val ap = "sg"
}
```

课堂所在区域。

| 属性 | 描述       |
| :--- | :--------- |
| `cn` | 中国大陆。 |
| `na` | 北美。     |
| `eu` | 欧洲。     |
| `ap` | 亚太。     |