This page provides the Swift API reference of the Agora Classroom SDK for iOS.

## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### version

```swift
(NSString *)version;
```

Gets the SDK version.

**Returns**

The SDK version.

### setConfig

```swift
+ (void)setConfig:(AgoraEduSDKConfig *)config;
```

Globally configures the SDK.

**Sample code**

```swift
/** Global configuration **/
@interface AgoraEduSDKConfig : NSObject
// Agora App ID
@property (nonatomic, copy) NSString *appId;
// Whether to enable eye care mode
@property (nonatomic, assign) BOOL eyeCare;
@end
AgoraEduSDKConfig *defaultConfig = [[AgoraEduSDKConfig alloc] initWithAppId:appId eyeCare:eyeCare];
[AgoraEduSDK setConfig:defaultConfig];
```

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `config` | 全局配置参数，详见 [`AgoraEduSDKConfig`](#agoraedusdkconfig)。 |

### launch

```swift
+ (AgoraEduClassroom * _Nullable)launch:(AgoraEduLaunchConfig *)config
                               delegate:(id<AgoraEduClassroomDelegate> _Nullable)delegate;
```

Launches a flexible classroom.

**Sample code**

```swift
/** Classroom launching configuration */
// The user name
NSString *userName = @"XXX";
// The user ID. Must be the same as the user ID that you use for generating an RTM token.
NSString *userUUid = @"XXX";
// The classroom name
NSString *roomName = @"XXX";
// The classroom ID
NSString *roomUuid = @"XXX";
// The user role
AgoraEduRoleType roleType = AgoraEduRoleTypeStudent;
// The classroom type
AgoraEduRoomType roomType = AgoraEduRoomType1V1;
// The RTM token
NSString *rtmToken = "";
// The start time (ms) of the class, determined by the first user joining the classroom.
NSNumber *startTime = @(XXX);
// The duration (ms) of the class, determined by the first user joining the classroom.
NSNumber *duration = @(1800);

AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:roleType roomName:roomName roomUuid:roomUuid roomType:roomType token:rtmToken startTime:startTime duration:duration];
[AgoraEduSDK launch:config delegate:self];
```

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `config` | 课堂启动配置，详见 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig)。 |
| `delegate` | SDK 通过 [`AgoraEduClassroomDelegate`](#agoraeduclassroomdelegate) 类向 App 报告课堂启动相关的事件。 |

**Returns**

`AgoraEduClassroom`.

### configCoursewares

```swift
+ (void)configCoursewares:(NSArray<AgoraEduCourseware *> *)config;
```

Configures courseware downloading.

**Sample code**

```swift
/** Construct, configure, and download the courseware */
// The ID of the courseware conversion task
NSString *taskUuid = @"xxxx";
// The courseware download address
NSString *resourceUrl = [NSString stringWithFormat:@"https://convertcdn.netless.link/dynamicConvert/%@/.zip", taskUuid];
// The courseware name
NSString *resourceName = @"XXX";
// The list of courseware pages
NSArray<WhiteScene*> *convertedFileList = @[];
// The path for storing the courseware
// Agora recommends setting this parameter as the combination of resourceName and name of the first object in convertedFileList
NSString *scenePath = [NSString stringWithFormat:@"%@/%@", resourceName, [convertedFileList.firstObject name]];

AgoraEduCourseware *courseware = [[AgoraEduCourseware alloc] initWithResourceName:resourceName scenePath:scenePath scenes:convertedFileList resourceUrl:resourceUrl];
// Configure the courseware pre-downloading
[AgoraEduSDK configCoursewares:@[courseware]];
```

**Parameter**

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `config` | 课件预加载配置，详见 [`AgoraEduCourseware`](#agoraeducourseware)。 |

### downloadCoursewares

```
+ (void)downloadCoursewares:(id<AgoraEduCoursewareDelegate> _Nullable)delegate;
```

Pre-download the courseware.

**Sample code**

```swift
// Download the configured courseware
[AgoraEduSDK downloadCoursewares:self];
```

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `delegate` | SDK 通过 [`AgoraEduCoursewareDelegate`](#agoraeducoursewaredelegate) 类向 App 报告课件预加载相关的事件。 |

### registerExtApps

```swift
+ (void)registerExtApps:(NSArray<AgoraExtAppConfiguration *> *)apps;
```

Register an extension application by using the ExtApp tool. ExtApp is a tool for embedding extension applications in Flexible Classroom. 详见[通过 ExtApp 自定义插件](./agora_class_ext_app_ios?platform=iOS)。

## AgoraEduClassroom

### destroy

```swift
- (void)destroy;
```

Release the resources occupied by the` AgoraEduClassroom` object.

## AgoraEduClassroomDelegate

`AgoraEduLaunchCallback` reports events related to classroom launching to your app.

### didReceivedEvent

```swift
- (void)classroom:(AgoraEduClassroom *)classroom didReceivedEvent:(AgoraEduEvent)event;
```

Reports classroom events.

**Parameter**

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `event` | 课堂事件，详见 [`AgoraEduEvent`](#agoraeduevent)。 |

## AgoraEduCoursewareDelegate

`AgoraEduCoursewareDelegate` reports events related to courseware preloading to your app.

### didProcessChanged

```swift
- (void)courseware:(AgoraEduCourseware *)courseware didProcessChanged:(float)process;
```

Indicates the progress of courseware pre-downloading.

| Parameter | Description |
| :--------- | :--------------- |
| `progress` | Indicates the progress of courseware pre-downloading. |

### didCompleted

```swift
- (void)courseware:(AgoraEduCourseware *)courseware idCompleted:(NSError * _Nullable)error;
```

The courseware pre-downloading completes.

| Parameter | Description |
| :------ | :------- |
| `error` | The error code. |

## Type definition

### AgoraEduEvent

```swift
typedef NS_ENUM(NSInteger, AgoraEduEvent) {
    AgoraEduEventFailed = 0,
    AgoraEduEventReady = 1,
    AgoraEduEventDestroyed =2,
};
```

Classroom events. 在 [`didReceivedEvent`](#didreceivedevent) 回调中报告。

| Attributes | Description |
| :----------------------- | :------------------ |
| `AgoraEduEventFailed` | `0`: The user fails to enter the classroom. |
| `AgoraEduEventReady` | `1`: The classroom is ready. |
| `AgoraEduEventDestroyed` | `2`: The classroom has been destroyed. |

### AgoraEduRoleType

```swift
typedef NS_ENUM(NSInteger, AgoraEduRoleType) {
    AgoraEduRoleTypeStudent = 2,
};
```

The role of the user in the classroom. 在 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig) 中设置。

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```swift
typedef NS_ENUM(NSInteger, AgoraEduRoomType) {
    AgoraEduRoomType1V1 = 0,
    AgoraEduRoomTypeSmall = 4,
    AgoraEduRoomTypeBig = 2,
};
```

The classroom type. 在 [`AgoraEduLaunchConfig`](#agoraedulaunchconfig) 中设置。

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduSDKConfig

```swift
@interface AgoraEduSDKConfig : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) BOOL eyeCare;
- (instancetype)initWithAppId:(NSString *)appId;
- (instancetype)initWithAppId:(NSString *)appId
                      eyeCare:(BOOL)eyeCare;
@end
```

The SDK global configuration. 用于 [`setConfig`](#setConfig) 方法。

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | Agora App ID，详见[前提条件中获取 Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1)。 |
| `eyeCare` | Whether to enable eye care mode:<li>`false`: (Default) Disable eye care mode.</li><li>`true`: Enable eye care mode.</li> |

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
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong, nullable) NSNumber *duration;
@property (nonatomic, copy) NSString *appId;
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
                       startTime:(NSNumber *)startTime
                        duration:(NSNumber *)duration;
                  userProperties:(NSDictionary<NSString *, NSString *> * _Nullable)userProperties;
@end
```

The classroom launching configuration. 用于 [`launch`](#launch) 方法。

| Attributes | Description |
| :--------------------------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | The user ID. This is the globally unique identifier of a user.** Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The user's role in the classroom. See `AgoraEduRoleType`. |
| `roomType` | The classroom type. See `AgoraEduRoomType`. |
| `token` | 用于鉴权的 RTM Token，详见[前提条件中生成 RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5)。 |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `region` | The area where the classrooms is located. 所有客户端必须设置相同的区域，否则无法互通。 可设为以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li> |
| `mediaOptions` | 媒体流相关设置，包含媒体流加密，详见 `AgoraEduMediaOptions`。 |
| `userProperties` | 由开发者自定义的用户属性。 详见[如何设置自定义用户属性？ ](/cn/agora-class/faq/agora_class_custom_properties) |
| `videoState` | 用于控制学生上台后是否发视频流，详见 `AgoraEduStreamState`。 |
| `audioState` | 用于控制学生上台后是否发音频流，详见 `AgoraEduStreamState`。 |
| `cameraEncoderConfiguration` | 摄像头采集视频流的编码参数配置，包含视频宽高、帧率、码率，详见 `AgoraEduVideoEncoderConfiguration`。 |
| `latencyLevel` | 观众端延时级别，详见 `AgoraEduLatencyLevel`。 |
| `boardFitMode` | 白板内容的显示模式，详见 `AgoraBoardFitMode`。 |

### AgoraBoardFitMode

```swift
@objc public enum AgoraBoardFitMode: Int {
    case auto, retain
}
```

学生获取白板授权后，当老师切换白板和课件时学生白板内容的显示模式。 用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `auto` | （默认）以 fit 模式显示，等比缩放 PPT 以保证完整显示 PPT 的内容。 |
| `retain` | 以本地记录的上一次学生手动调整的大小为准。 |

### StreamState

```swift
@objc public enum AgoraEduContextAppType: Int {
    case off = 0, on, `default`
}
```

用于控制学生上台后是否发音视流。 用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| Parameter | Description |
| :---- | :--------------- |
| `off` | （默认）不发流。 |
| `on` | 发流。 |

### AgoraEduLatencyLevel

```java
@objc public enum AgoraEduContextUserRole: Int {
    case low = 0
    case ultraLow
}
```

观众端延时级别，只对台下学生有效。 用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| Parameter | Description |
| :--------- | :--------------------------------------------------------- |
| `low` | Low latency. Low latency: The latency from the sender to the receiver is 1500 ms - 2000 ms. |
| `ultraLow` | (Default) Ultra low latency. Ultra-low latency: The latency from the sender to the receiver is 400 ms - 800 ms. |

### AgoraEduMediaOptions

```swift
@interface AgoraEduSDKConfig : NSObject
@property (nonatomic, strong) AgoraEduMediaEncryptionConfig *encryptionConfig;

- (instancetype)initWithConfig:(AgoraEduMediaEncryptionConfig *)encryptionConfig;
@end
```

媒体流相关设置。 用于 [AgoraEduLaunchConfig](#agoraedulaunchconfig)。

| Parameter | Description |
| :----------------- | :----------------------------------------------------------- |
| See `EncryptionConfig`. | 媒体流加密配置，详见 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfig). |

### AgoraEduMediaEncryptionConfig

```swift
@interface AgoraEduLaunchConfig : NSObject
@property (nonatomic, assign) AgoraEduMediaEncryptionMode mode;
@property (nonatomic, copy) NSString *token;

- (instancetype)initWithMode:(AgoraEduMediaEncryptionMode)mode key:(NSString *)key;
@end
```

媒体流加密配置，用于 [AgoraEduMediaOptions](#agoraedumediaoptions)。

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `mode` | 加密模式，详见 [AgoraEduMediaEncryptionMode](#agoraedumediaencryptionmode)。 |
| `key` | 加密密钥。 |

### AgoraEduMediaEncryptionMode

```swift
typedef NS_ENUM(NSInteger, AgoraEduEvent) {
    AgoraEduMediaEncryptionModeAES128XTS = 1,
    AgoraEduMediaEncryptionModeAES128ECB = 2,
    AgoraEduMediaEncryptionModeAES256XTS = 3,
    AgoraEduMediaEncryptionModeAES128GCM = 5,
    AgoraEduMediaEncryptionModeAES256GCM = 6,
};
```

媒体流加密模式。 用于 [AgoraEduMediaEncryptionConfig](#agoraedumediaencryptionconfigs)。

| Parameter | Description |
| :------------------------------------- | :-------------------------- |
| `AgoraEduMediaEncryptionModeAES128XTS` | (Default) 128-bit AES encryption, XTS mode. |
| `AgoraEduMediaEncryptionModeAES128ECB` | 128-bit AES encryption, ECB mode. |
| `AgoraEduMediaEncryptionModeAES256XTS` | 256-bit AES encryption, XTS mode. |
| `AgoraEduMediaEncryptionModeAES128GCM` | 5: 128-bit AES encryption, GCM mode. |
| `AgoraEduMediaEncryptionModeAES256GCM` | 6: 256-bit AES encryption, GCM mode. |

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

The courseware pre-download configuration. 用于 [`configCoursewares`](#configcoursewares) 方法。

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name. |
| `scenePath` | The local path for storing the file. Agora recommends setting this parameter as the combination of` resourceName` and the `name` of the first `SceneInfo` object in `scenes`. |
| `resourceUrl` | The URL address of the file, such as `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip".` |
| `scenes` | A list of converted file pages, an array of `WhiteScene` objects. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom and then display the file on the whiteboard in pages. Each `WhiteScene` object represents one page. |

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

The detailed information of a page. 在 [`AgoraEduCourseware`](#agoraeducourseware) 中设置。

| Attributes | Description |
| :---------------- | :--------------------------------------------------------- |
| `componentsCount` | The number of pages. |
| `ppt` | The detailed information of a converted page. See `WhitePptPage`. |
| `name` | The page name. |

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

The detailed information of a converted page. 在 [`SceneInfo`](#sceneinfo) 中设置。

| Attributes | Description |
| :----------- | :------------------------------------------ |
| `src` | The URL address of the converted page. |
| `width` | The width (pixel) of the page. |
| `height` | The height (pixel) of the page. |
| `previewURL` | The URL address of the preview image generated after the dynamic file conversion. |