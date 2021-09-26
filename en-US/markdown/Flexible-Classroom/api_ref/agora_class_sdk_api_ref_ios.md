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
| `config` | The SDK global configuration. See [`AgoraEduSDKConfig`](#agoraedusdkconfig). |

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
| `config` | The classroom launching configuration. See [`AgoraEduLaunchConfig`](#agoraedulaunchconfig). |
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
| `config` | The courseware pre-download configuration. See [`AgoraEduCourseware`](#agoraeducourseware). |

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
| `delegate` | The SDK reports events related to courseware preloading to the app through the AgoraEduCoursewarePreloadListener#agoraeducoursewarepreloadlistener class.[``]( |

### registerExtApps

```swift
+ (void)registerExtApps:(NSArray<AgoraExtAppConfiguration *> *)apps;
```

Register an extension application by using the ExtApp tool. ExtApp is a tool for embedding extension applications in Flexible Classroom. For details, see Customize Flexible Classroom with ExtApp./agora_class_ext_app_android?platform=Android.[](

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
| `event` | The classroom events. See [`AgoraEduEvent`](#agoraeduevent). |

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

The role of the user in the classroom. Set in [`AgoraEduLaunchConfig`](#agoraedulaunchconfig).

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

The classroom type. Set in [`AgoraEduLaunchConfig`](#agoraedulaunchconfig).

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

The SDK global configuration. Used in setConfig#setconfig.[``](

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID. See [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
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

The classroom launching configuration. Used in [`launch`](#launch).

| Attributes | Description |
| :--------------------------- | :----------------------------------------------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `roleType` | The user's role in the classroom. See `AgoraEduRoleType`. |
| `roomType` | The classroom type. See `AgoraEduRoomType`. |
| `token` | The RTM token used for authentication. For details, see [Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |
| `region` | The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. 可设为以下区域：<li>`CN`: （默认）中国大陆</li><li>`AP`: 亚太地区</li><li>`EU`: 欧洲</li><li>`NA`: 北美</li> |
| `mediaOptions` | 媒体流相关设置，包含媒体流加密，详见 `AgoraEduMediaOptions`。 |
| `userProperties` | User attributes customized by the developer. For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties) |
| `videoState` | Controls whether students automatically send audio or video streams after they go onto the "stage". See  StreamState#streamstate.`` |
| `audioState` | Controls whether students automatically send audio or video streams after they go onto the "stage". See  StreamState#streamstate.`` |
| `cameraEncoderConfiguration` | 摄像头采集视频流的编码参数配置，包含视频宽高、帧率、码率，详见 `AgoraEduVideoEncoderConfiguration`。 |
| `latencyLevel` | 观众端延时级别，详见 `AgoraEduLatencyLevel`。 |
| `boardFitMode` | 白板内容的显示模式，详见 `AgoraBoardFitMode`。 |

### AgoraBoardFitMode

```swift
@objc public enum AgoraBoardFitMode: Int {
    case auto, retain
}
```

After the student obtains the whiteboard authorization, the display mode of the student's whiteboard content when the teacher switches whiteboard and the courseware. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| AUTO`` | (Default) The PPT display mode is fit, which means uniformly scaling the PPT until one of its dimensions fits the boundary. |
| Retain`` | In this mode, if the student manually adjusts the PPT size, the client maintains this size no matter what class the student joins. |

### StreamState

```swift
@objc public enum AgoraEduContextAppType: Int {
    case off = 0, on, `default`
}
```

Controls whether students automatically send audio or video streams after they go onto the "stage". Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

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

The latency level of an audience member. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :--------- | :--------------------------------------------------------- |
| `low` | Low latency. Low latency: The latency from the sender to the receiver is 1500 ms to 2000 ms. |
| `ultraLow` | (Default) Ultra low latency. The latency from the sender to the receiver is 400 ms to 800 ms. |

### AgoraEduMediaOptions

```swift
@interface AgoraEduSDKConfig : NSObject
@property (nonatomic, strong) AgoraEduMediaEncryptionConfig *encryptionConfig;

- (instancetype)initWithConfig:(AgoraEduMediaEncryptionConfig *)encryptionConfig;
@end
```

Media options. Set in [AgoraEduLaunchConfig](#agoraedulaunchconfig).

| Parameter | Description |
| :----------------- | :----------------------------------------------------------- |
| `encryptionConfig` | The media stream encryption configuration. See AgoraEduMediaEncryptionConfig#agoraedumediaencryptionconfig for details.[]( |

### AgoraEduVideoEncoderConfiguration

```swift
@interface AgoraEduVideoEncoderConfiguration : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
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

The classroom launching configuration. See `AgoraEduLaunchConfig`.

> - 在小班课中，分辨率的默认值为 120p（160✖️120）。
> - 在一对一和大班课中，分辨率的默认值为 240p（320✖️240）。

| Parameter | Description |
| :----------- | :-------------------------------------------- |
| `width` | Width (pixel) of the video frame. |
| `height` | Height (pixel) of the video frame. |
| `frameRate` | The frame rate (fps) of the video. The default value is 15. |
| `bitrate` | The bitrate (Kbps) of the video. The default value is 200. |
| `mirrorMode` | 视频镜像模式，详见 `AgoraEduCoreMirrorMode`。 |

### AgoraEduMediaEncryptionConfig

```swift
@interface AgoraEduLaunchConfig : NSObject
@property (nonatomic, assign) AgoraEduMediaEncryptionMode mode;
@property (nonatomic, copy) NSString *token;

- (instancetype)initWithMode:(AgoraEduMediaEncryptionMode)mode key:(NSString *)key;
@end
```

The media stream encryption configuration. Used in [AgoraEduMediaOptions](#agoraedumediaoptions).

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `mode` | The media stream encryption configuration. See AgoraEduMediaEncryptionConfig#agoraedumediaencryptionconfig for details.[]( |
| `key` | The encryption key. |

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
| `AgoraEduMediaEncryptionModeAES128XTS` | 128-bit AES encryption, XTS mode. |
| `AgoraEduMediaEncryptionModeAES128ECB` | 128-bit AES encryption, ECB mode. |
| `AgoraEduMediaEncryptionModeAES256XTS` | 256-bit AES encryption, XTS mode. |
| `AgoraEduMediaEncryptionModeAES128GCM` | 128-bit AES encryption, GCM mode. |
| `AgoraEduMediaEncryptionModeAES256GCM` | 256-bit AES encryption, GCM mode. |

### AgoraEduCoreMirrorMode

```swift
@objc public enum AgoraEduContextChatType: Int {
    case auto = 0, enabled, disabled
}
```

Whether to enable mirror mode.

| Parameter | Description |
| :--------- | :--------------------- |
| AUTO`` | The SDK disables mirror mode by default. |
| enabled`` | Enable mirror mode. |
| DISABLED`` | Disable mirror mode. |

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

The courseware pre-download configuration. The courseware pre-download configuration. Used in configCoursewares#configcoursewares.[``](

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

The detailed information of a page. Set in [`AgoraEduCourseware`](#agoraeducourseware.

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

The detailed information of a converted page. Set in [`SceneInfo`](#sceneinfo).

| Attributes | Description |
| :----------- | :------------------------------------------ |
| `src` | The URL address of the converted page. |
| `width` | The width (pixel) of the page. |
| `height` | The height (pixel) of the page. |
| `previewURL` | The URL address of the preview image generated after the dynamic file conversion. |