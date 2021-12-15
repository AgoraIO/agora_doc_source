本页提供 Agora Classroom SDK for iOS 的 Swift API 参考。

## AgoraClassroomSDK

`AgoraClassroomSDK` 是 Agora Classroom SDK 的基础接口类，包含供 App 调用的主要接口。

### version

```swift
(NSString *)version;
```

查询 SDK 版本号。

**返回值**

SDK 版本号。

### setConfig

```swift
+ (BOOL)setConfig:(AgoraClassroomSDKConfig *)config;
```

全局配置 SDK。

**示例代码**

```swift
/** 全局配置 **/
@interface AgoraClassroomSDKConfig : NSObject
// Agora App ID
@property (nonatomic, copy) NSString *appId;
// 是否开启护眼模式
@property (nonatomic, assign) BOOL eyeCare;
@end
AgoraClassroomSDKConfig *defaultConfig = [[AgoraClassroomSDKConfig alloc] initWithAppId:appId eyeCare:eyeCare];
[AgoraClassroomSDK setConfig:defaultConfig];
```

**参数**

| 参数     | 描述                                                                     |
| :------- | :----------------------------------------------------------------------- |
| `config` | 全局配置参数，详见 [AgoraClassroomSDKConfig](#agoraclassroomsdkconfig)。 |

### launch

```swift
+ (AgoraEduClassroom * _Nullable)launch:(AgoraEduLaunchConfig *)config
                               delegate:(id<AgoraEduClassroomDelegate> _Nullable)delegate;
```

启动灵动课堂。

**示例代码**

```swift
/** 课堂启动配置 */
// 用户名
NSString *userName = @"XXX";
// 用户 ID，需要与你生成 RTM Token 时使用的用户 ID 一致
NSString *userUUid = @"XXX";
// 教室名称
NSString *roomName = @"XXX";
// 教室 ID
NSString *roomUuid = @"XXX";
// 用户角色
AgoraEduRoleType roleType = AgoraEduRoleTypeStudent;
// 课堂类型
AgoraEduRoomType roomType = AgoraEduRoomType1V1;
// RTM Token
NSString *rtmToken = "";
// 课堂开始时间，单位为毫秒，以第一个进入教室的用户传入的参数为准
NSNumber *startTime = @(XXX);
// 课堂持续时间，单位为秒，以第一个进入教室的用户传入的参数为准
NSNumber *duration = @(1800);

AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:roleType roomName:roomName roomUuid:roomUuid roomType:roomType token:rtmToken startTime:startTime duration:duration];
[AgoraClassroomSDK launch:config delegate:self];
```

**参数**

| 参数       | 描述                                                                                               |
| :--------- | :------------------------------------------------------------------------------------------------- |
| `config`   | 课堂启动配置，详见 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。                                 |
| `delegate` | SDK 通过 [AgoraEduClassroomDelegate](#agoraeduclassroomdelegate) 类向 App 报告课堂启动相关的事件。 |

**返回值**

`AgoraEduClassroom` 类。

### configCoursewares

```swift
+ (void)configCoursewares:(NSArray<AgoraEduCourseware *> *)config;
```

配置课件预加载。

**示例代码**

```swift
/** 构造、配置、下载课件 */
// 课件转换任务唯一 ID
NSString *taskUuid = @"xxxx";
// 课件下载地址
NSString *resourceUrl = [NSString stringWithFormat:@"https://convertcdn.netless.link/dynamicConvert/%@/.zip", taskUuid];
// 课件名称
NSString *resourceName = @"XXX";
// 课件页面列表，注意转成 WhiteScene
NSArray<WhiteScene*> *convertedFileList = @[];
// 课件目录
// 建议用 resourceName 和 convertedFileList 里面第一个对象的 name 拼接
NSString *scenePath = [NSString stringWithFormat:@"%@/%@", resourceName, [convertedFileList.firstObject name]];

AgoraEduCourseware *courseware = [[AgoraEduCourseware alloc] initWithResourceName:resourceName scenePath:scenePath scenes:convertedFileList resourceUrl:resourceUrl];
// 配置课件预加载
[AgoraClassroomSDK configCoursewares:@[courseware]];
```

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `config` | 课件预加载配置，详见 [AgoraEduCourseware](#agoraeducourseware)。 |

### downloadCoursewares

```
+ (void)downloadCoursewares:(id<AgoraEduCoursewareDelegate> _Nullable)delegate;
```

预加载课件。

**示例代码**

```swift
// 下载配置好的课件
[AgoraClassroomSDK downloadCoursewares:self];
```

**参数**

| 参数       | 描述                                                                                                   |
| :--------- | :----------------------------------------------------------------------------------------------------- |
| `delegate` | SDK 通过 [AgoraEduCoursewareDelegate](#agoraeducoursewaredelegate) 类向 App 报告课件预加载相关的事件。 |

### registerExtApps

```swift
+ (void)registerExtApps:(NSArray<AgoraExtAppConfiguration *> *)apps;
```

注册扩展应用 ExtApp。ExtApp 是灵动课堂 UIKit 的补充插件。详见[通过 ExtApp 自定义插件](./agora_class_ext_app_ios?platform=iOS)。

## AgoraEduClassroom

### destroy

```swift
- (void)destroy;
```

释放 `AgoraEduClassroom` 对象占用的资源。

## AgoraEduClassroomDelegate

`AgoraEduClassroomDelegate` 类用于 SDK 向 App 报告课堂启动相关的事件。

### didReceivedEvent

```swift
- (void)classroom:(AgoraEduClassroom *)classroom didReceivedEvent:(AgoraEduEvent)event;
```

课堂事件回调。

**参数**

| 参数    | 描述                                             |
| :------ | :----------------------------------------------- |
| `event` | 课堂事件，详见 [AgoraEduEvent](#agoraeduevent)。 |

## AgoraEduCoursewareDelegate

`AgoraEduCoursewareDelegate` 类用于 SDK 向 App 报告课件预加载相关的事件。

### didProcessChanged

```swift
- (void)courseware:(AgoraEduCourseware *)courseware didProcessChanged:(float)process;
```

课件预加载进度。

| 参数       | 描述             |
| :--------- | :--------------- |
| `progress` | 课件预加载进度。 |

### didCompleted

```swift
- (void)courseware:(AgoraEduCourseware *)courseware idCompleted:(NSError * _Nullable)error;
```

课件预加载完成。

| 参数    | 描述     |
| :------ | :------- |
| `error` | 错误码。 |

## 类型定义

### AgoraEduEvent

```swift
typedef NS_ENUM(NSInteger, AgoraEduEvent) {
    AgoraEduEventFailed = 0,
    AgoraEduEventReady = 1,
    AgoraEduEventDestroyed =2,
};
```

课堂事件。在 [didReceivedEvent](#didreceivedevent) 回调中报告。

| 属性                     | 描述                |
| :----------------------- | :------------------ |
| `AgoraEduEventFailed`    | `0`: 进入课堂失败。 |
| `AgoraEduEventReady`     | `1`: 课堂准备完成。 |
| `AgoraEduEventDestroyed` | `2`: 课堂已销毁。   |

### AgoraEduRoleType

```swift
typedef NS_ENUM(NSInteger, AgoraEduRoleType) {
    AgoraEduRoleTypeStudent = 2,
};
```

用户在课堂中的角色。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性                      | 描述        |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: 学生。 |

### AgoraEduRoomType

```swift
typedef NS_ENUM(NSInteger, AgoraEduRoomType) {
    AgoraEduRoomType1V1 = 0,
    AgoraEduRoomTypeSmall = 4,
    AgoraEduRoomTypeBig = 2,
};
```

课堂类型。在 [AgoraEduLaunchConfig](#agoraedulaunchconfig) 中设置。

| 属性                    | 描述                                                                                                                                                    |
| :---------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `AgoraEduRoomType1V1`   | `0`: 1 对 1 互动教学。1 位老师对 1 名学生进行专属在线辅导教学。                                                                                         |
| `AgoraEduRoomTypeBig`   | `2`: 互动直播大班课。1 位老师进行在线教学，多名学生实时观看和收听。学生人数无上限。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。         |
| `AgoraEduRoomTypeSmall` | `4`: 在线互动小班课。1 位老师进行在线教学，多名学生实时观看和收听。课堂人数上限为 500。上课过程中，老师可点名学生“上台”发言，与老师进行实时音视频互动。 |

### AgoraClassroomSDKConfig

```swift
@interface AgoraClassroomSDKConfig : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) BOOL eyeCare;
- (instancetype)initWithAppId:(NSString *)appId;
- (instancetype)initWithAppId:(NSString *)appId
                      eyeCare:(BOOL)eyeCare;
@end
```

SDK 全局配置。用于 [setConfig](#setConfig) 方法。

| 属性      | 描述                                                                                                           |
| :-------- | :------------------------------------------------------------------------------------------------------------- |
| `appId`   | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |
| `eyeCare` | 是否开启护眼模式：<li>`false`:（默认）关闭护眼模式。</li><li>`true`: 开启护眼模式。</li>                       |

### AgoraEduLaunchConfig

```swift
@interface AgoraEduLaunchConfig : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userUuid;
@property (nonatomic, assign) AgoraEduRoleType roleType;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *roomUuid;
@property (nonatomic, assign) AgoraEduRoomType roomType;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *startTime;
@property (nonatomic, copy, nullable) NSNumber *duration;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong, nullable) AgoraEduMediaOptions *mediaOptions;
@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSString *> * userProperties;
@property (nonatomic, assign) AgoraEduStreamState videoState;
@property (nonatomic, assign) AgoraEduStreamState audioState;
@property (nonatomic, strong, nullable) AgoraEduVideoEncoderConfiguration *cameraEncoderConfiguration;
@property (nonatomic, assign) AgoraEduLatencyLevel latencyLevel;
@property (nonatomic, assign) AgoraBoardFitMode boardFitMode;

- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        roleType:(AgoraEduRoleType)roleType
                        roomName:(NSString *)roomName
                        roomUuid:(NSString *)roomUuid
                        roomType:(AgoraEduRoomType)roomType
                           token:(NSString *)token
                       startTime:(NSNumber * _Nullable)startTime
                        duration:(NSNumber * _Nullable)duration
                  userProperties:(NSDictionary<NSString *, NSString *> * _Nullable)userProperties;
@end
```

课堂启动配置。用于 [launch](#launch) 方法。

| 属性                         | 描述                                                                                                                                                                                                                                                                                                                                                              |
| :--------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userName`                   | 用户名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                      |
| `userUuid`                   | 用户 ID。这是用户的全局唯一标识，**需要与你生成 RTM Token 时使用的 UID 一致**。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", "," |
| `roomName`                   | 课堂名，用于课堂内显示，长度在 64 字节以内。                                                                                                                                                                                                                                                                                                                      |
| `roomUuid`                   | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","                                                |
| `roleType`                   | 用户在课堂中的角色，详见 `AgoraEduRoleType`。                                                                                                                                                                                                                                                                                                                     |
| `roomType`                   | 课堂类型，详见 `AgoraEduRoomType`。                                                                                                                                                                                                                                                                                                                               |
| `token`                      | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。                                                                                                                                                                                                                                               |
| `startTime`                  | 课堂开始时间，单位为毫秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                  |
| `duration`                   | 课堂持续时间，单位为秒，以第一个进入课堂的用户传入的参数为准。                                                                                                                                                                                                                                                                                                    |
| `region`                     | 课堂所在区域。所有客户端必须设置相同的区域，否则无法互通。可设为以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li>                                                                                                                                                                                            |
| `mediaOptions`               | 媒体流相关设置，包含媒体流加密，详见 `AgoraEduMediaOptions`。                                                                                                                                                                                                                                                                                                     |
| `userProperties`             | 由开发者自定义的用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)                                                                                                                                                                                                                                                       |
| `videoState`                 | 用于控制学生上台后是否发视频流，详见 `AgoraEduStreamState`。                                                                                                                                                                                                                                                                                                      |
| `audioState`                 | 用于控制学生上台后是否发音频流，详见 `AgoraEduStreamState`。                                                                                                                                                                                                                                                                                                      |
| `cameraEncoderConfiguration` | 摄像头采集视频流的编码参数配置，包含视频宽高、帧率、码率，详见 `AgoraEduVideoEncoderConfiguration`。                                                                                                                                                                                                                                                              |
| `latencyLevel`               | 观众端延时级别，详见 `AgoraEduLatencyLevel`。                                                                                                                                                                                                                                                                                                                     |
| `boardFitMode`               | 白板内容的显示模式，详见 `AgoraBoardFitMode`。                                                                                                                                                                                                                                                                                                                    |

### AgoraBoardFitMode

```swift
@objc public enum AgoraBoardFitMode: Int {
    case auto, retain
}
```

学生获取白板授权后，当老师切换白板和课件时学生白板内容的显示模式。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数     | 描述                                                              |
| :------- | :---------------------------------------------------------------- |
| `auto`   | （默认）以 fit 模式显示，等比缩放 PPT 以保证完整显示 PPT 的内容。 |
| `retain` | 以本地记录的上一次学生手动调整的大小为准。                        |

### StreamState

```swift
@objc public enum AgoraEduStreamState: Int {
    case off = 0, on, `default`
}
```

用于控制学生上台后是否发音视流。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数  | 描述             |
| :---- | :--------------- |
| `off` | （默认）不发流。 |
| `on`  | 发流。           |

### AgoraEduLatencyLevel

```java
@objc public enum AgoraEduLatencyLevel: Int {
    case low = 0
    case ultraLow
}
```

观众端延时级别，只对台下学生有效。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数       | 描述                                                       |
| :--------- | :--------------------------------------------------------- |
| `low`      | 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。         |
| `ultraLow` | （默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。 |

### AgoraEduMediaOptions

```swift
@interface AgoraEduMediaOptions : NSObject
@property (nonatomic, strong) AgoraEduMediaEncryptionConfig *encryptionConfig;

- (instancetype)initWithConfig:(AgoraEduMediaEncryptionConfig *)encryptionConfig;
@end
```

媒体流相关设置。用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| 参数               | 描述                                                                                  |
| :----------------- | :------------------------------------------------------------------------------------ |
| `encryptionConfig` | 媒体流加密配置，详见 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig). |

### AgoraEduVideoEncoderConfiguration

```swift
@interface AgoraEduVideoEncoderConfiguration : NSObject
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, assign) NSUInteger frameRate;
@property (nonatomic, assign) NSUInteger bitrate;
@property (nonatomic, assign) AgoraEduCoreMirrorMode mirrorMode;

- (instancetype)initWithWidth:(NSUInteger)width
                       height:(NSUInteger)height
                    frameRate:(NSUInteger)frameRate
                      bitrate:(NSUInteger)bitrate
                   mirrorMode:(AgoraEduCoreMirrorMode)mirrorMode;
@end
```

视频编码参数配置类，用于 `AgoraEduLaunchConfig`。

> - 在小班课中，分辨率的默认值为 120p（160✖️120）。
> - 在一对一和大班课中，分辨率的默认值为 240p（320✖️240）。

| 参数         | 描述                                          |
| :----------- | :-------------------------------------------- |
| `width`      | 视频帧宽度 (pixel)。                          |
| `height`     | 视频帧高度 (pixel)。                          |
| `frameRate`  | 视频帧率 (fps)。默认值为 15。                 |
| `bitrate`    | 视频码率 (Kbps)。默认值为 200。               |
| `mirrorMode` | 视频镜像模式，详见 `AgoraEduCoreMirrorMode`。 |

### AgoraEduMediaEncryptionConfig

```swift
@interface AgoraEduMediaEncryptionConfig : NSObject
@property (nonatomic, assign) AgoraEduMediaEncryptionMode mode;
@property (nonatomic, copy) NSString *key;

- (instancetype)initWithMode:(AgoraEduMediaEncryptionMode)mode key:(NSString *)key;
@end
```

媒体流加密配置，用于 [AgoraEduMediaOptions](#agoraedumediaoptions)。

| 参数   | 描述                                                                         |
| :----- | :--------------------------------------------------------------------------- |
| `mode` | 加密模式，详见 [AgoraEduMediaEncryptionMode](#agoraedumediaencryptionmode)。 |
| `key`  | 加密密钥。                                                                   |

### AgoraEduMediaEncryptionMode

```swift
typedef NS_ENUM(NSInteger, AgoraEduMediaEncryptionMode) {
    AgoraEduMediaEncryptionModeAES128XTS = 1,
    AgoraEduMediaEncryptionModeAES128ECB = 2,
    AgoraEduMediaEncryptionModeAES256XTS = 3,
    AgoraEduMediaEncryptionModeAES128GCM = 5,
    AgoraEduMediaEncryptionModeAES256GCM = 6,
};
```

媒体流加密模式。用于 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfigs)。

| 参数                                   | 描述                        |
| :------------------------------------- | :-------------------------- |
| `AgoraEduMediaEncryptionModeAES128XTS` | 128 位 AES 加密，XTS 模式。 |
| `AgoraEduMediaEncryptionModeAES128ECB` | 128 位 AES 加密，ECB 模式。 |
| `AgoraEduMediaEncryptionModeAES256XTS` | 256 位 AES 加密，XTS 模式。 |
| `AgoraEduMediaEncryptionModeAES128GCM` | 128 位 AES 加密，GCM 模式。 |
| `AgoraEduMediaEncryptionModeAES256GCM` | 256 位 AES 加密，GCM 模式。 |

### AgoraEduCoreMirrorMode

```swift
@objc public enum AgoraEduCoreMirrorMode: Int {
    case auto = 0, enabled, disabled
}
```

是否开启镜像模式。

| 参数       | 描述                   |
| :--------- | :--------------------- |
| `auto`     | SDK 默认关闭镜像模式。 |
| `enabled`  | 开启镜像模式。         |
| `disabled` | 关闭镜像模式。         |

### AgoraEduCourseware

```swift
@interface AgoraEduCourseware : NSObject
@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, copy) NSString *scenePath;
@property (nonatomic, copy) NSString *resourceUrl;
@property (nonatomic, strong) NSArray<WhiteScene *> *scenes;
- (instancetype)initWithResourceName:(NSString *)resourceName
                           scenePath:(NSString *)scenePath
                              scenes:(NSArray<WhiteScene *> *)scenes
                         resourceUrl:(NSString *)resourceUrl;
@end
```

课件预加载配置。用于 [configCoursewares](#configcoursewares) 方法。

| 属性           | 描述                                                                                                                                                                                                                          |
| :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `resourceName` | 文件名称。                                                                                                                                                                                                                    |
| `scenePath`    | 文件的本地存储路径，建议由 `resourceName` 和 `scenes` 中第一个 `SceneInfo` 对象的 `name` 拼接而成。                                                                                                                           |
| `resourceUrl`  | 课件下载地址，例如 `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"`                                                                                                                                          |
| `scenes`       | 完成转换的文件页面列表，由 `WhiteScene` 对象组成的数组。灵动课堂客户端会对后缀名 `"ppt"`、`"pptx"`、`"doc"`、`"docx"`、`"pdf"` 的文件默认开启文件转换，以在课堂内的白板上分页展示该资源。每个 `WhiteScene` 对象对应一个页面。 |

### WhiteObject

```swift
@interface WhiteScene : WhiteObject

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name ppt:(nullable WhitePptPage *)ppt;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSInteger componentsCount;
@property (nonatomic, strong, readonly, nullable) WhitePptPage *ppt;
@end
```

一个文件页面的具体信息。在 [AgoraEduCourseware](#agoraeducourseware) 中设置。

| 属性              | 描述                                                       |
| :---------------- | :--------------------------------------------------------- |
| `componentsCount` | 页面数量。                                                 |
| `ppt`             | 一个完成转换后的页面的具体信息，详见 `WhitePptPage` 对象。 |
| `name`            | 页面名称。                                                 |

### WhitePptPage

```swift
@interface WhitePptPage : WhiteObject

- (instancetype)initWithSrc:(NSString *)src size:(CGSize)size;
- (instancetype)initWithSrc:(NSString *)src preview:(NSString *)url size:(CGSize)size;

@property (nonatomic, copy) NSString *src;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy, readonly) NSString *previewURL;

@end
```

一个完成转换后的页面的具体信息。在 [SceneInfo](#sceneinfo) 中设置。

| 属性         | 描述                                        |
| :----------- | :------------------------------------------ |
| `src`        | 完成转换的页面的 URL 下载地址。             |
| `width`      | 页面宽度（pixel）。                         |
| `height`     | 页面高度（pixel）。                         |
| `previewURL` | 动态文件转换时生成的预览图的 URL 下载地址。 |
