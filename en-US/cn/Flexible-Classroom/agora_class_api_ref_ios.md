## AgoraEduSDK

`AgoraEduSDK` is the basic interface of the Agora Classroom SDK and provides the main methods that can be invoked by your app.

### version

```
(NSString *)version;
```

Gets the SDK version.

**Returns**

The SDK version.

### setConfig

```
+ (void)setConfig:(AgoraEduSDKConfig *)config;
```

Globally configures the SDK.

**Parameter**

| Parameter | Description |
| :------- | :--------------------------------------- |
| `config` | The SDK global configuration, see `AgoraEduSDKConfig`. |

### launch

```
+ (AgoraEduClassroom * _Nullable)launch:(AgoraEduLaunchConfig *)config
                               delegate:(id<AgoraEduClassroomDelegate> _Nullable)delegate;
```

Launches a flexible classroom.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `config` | The classroom launching configuration, see `AgoraEduLaunchConfig`. |
| `delegate` | The SDK uses the `AgoraEduClassroomDelegate` class to report events related to classroom launching to the app. |

**Returns**

`The AgoraEduClassroom` class.

### configCoursewares

```
+ (void)configCoursewares:(NSArray<AgoraEduCourseware *> *)config;
```

Configures downloading courseware before entering a classroom.

**Parameter**

| Parameter | Description |
| :------- | :------------------------------------------ |
| `config` | The courseware pre-downloading configuration. See `AgoraEduCourseware`. |

### downloadCoursewares

```
+ (void)downloadCoursewares:(id<AgoraEduCoursewareDelegate> _Nullable)delegate;
```

Pre-download the courseware.

**Parameter**

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `delegate` | The SDK reports events related to courseware preloading to the app through the `AgoraEduCoursewareDelegate` class. |

## AgoraEduClassroom

### destroy

```
- (void)destroy;
```

Release the resources occupied by the `AgoraEduClassroom` object.

## AgoraEduClassroomDelegate

`The AgoraEduLaunchCallback` class reports events related to classroom launching to the app.

### didReceivedEvent

```
- (void)classroom:(AgoraEduClassroom *)classroom didReceivedEvent:(AgoraEduEvent)event;
```

Reports classroom events.

**Parameter**

| Parameter | Description |
| :------ | :------------------------------- |
| `event` | The classroom events. See `AgoraEduEven`. |

## AgoraEduCoursewareDelegate

`The AgoraEduCoursewareDelegate` class reports events related to courseware preloading to the app.

### didProcessChanged

```
- (void)courseware:(AgoraEduCourseware *)courseware didProcessChanged:(float)process;
```

Indicates the progress of courseware pre-downloading.

### didCompleted

```
- (void)courseware:(AgoraEduCourseware *)courseware idCompleted:(NSError * _Nullable)error;
```

The courseware pre-downloading completes.

## Type definition

### AgoraEduEvent

```
typedef NS_ENUM(NSInteger, AgoraEduEvent) {
    AgoraEduEventFailed = 0,
    AgoraEduEventReady = 1,
    AgoraEduEventDestroyed =2,
};
```

Classroom events. Reported in the `didReceivedEvent` callback.

| Attributes | Description |
| :----------------------- | :---------------- |
| `AgoraEduEventFailed` | 0: The user fails to enter the classroom. |
| `AgoraEduEventReady` | 1: The classroom is ready. |
| `AgoraEduEventDestroyed` | 2: The classroom has been destroyed. |

### AgoraEduRoleType

```
typedef NS_ENUM(NSInteger, AgoraEduRoleType) {
    AgoraEduRoleTypeStudent = 2,
};
```

The role of the user in the classroom. You need to set the user role in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```
typedef NS_ENUM(NSInteger, AgoraEduRoomType) {
    AgoraEduRoomType1V1 = 0,
    AgoraEduRoomTypeSmall = 4,
    AgoraEduRoomTypeBig = 2,
};
```

The classroom type. You need to set the user role in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :---------------------- | :----------------------------------------------------------- |
| `AgoraEduRoomType1V1` | `0`: One-to-one Classroom. An online teacher gives an exclusive lesson to only one student. |
| `AgoraEduRoomTypeBig` | `2`: Lecture Hall. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. There is no upper limit on the number of students. During the class, students can "raise their hands" to apply for speaking up. Once the teacher approves, the student can send their audio and video to interact with the teacher. |
| `AgoraEduRoomTypeSmall` | `4`: Small Classroom. A teacher gives an online lesson to multiple students. Students do not send their audio and video by default. The maximum number of users in a classroom is 500. During the class, the teacher can invite students to speak up "on stage" and have real-time audio and video interactions with the teacher. |

### AgoraEduSDKConfig

```
@interface AgoraEduSDKConfig : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) BOOL eyeCare;
- (instancetype)initWithAppId:(NSString *)appId;
- (instancetype)initWithAppId:(NSString *)appId
                      eyeCare:(BOOL)eyeCare;
@end
```

The SDK global configuration. Used when calling `setConfig`.

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`false`: (Default) Disable eye care mode.</li><li>`true`: Enable eye care mode.</li> |

### AgoraEduLaunchConfig

```
@interface AgoraEduLaunchConfig : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userUuid;
@property (nonatomic, assign) AgoraEduRoleType roleType;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *roomUuid;
@property (nonatomic, assign) AgoraEduRoomType roomType;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong, nullable) NSNumber *startTime;
@property (nonatomic, strong, nullable) NSNumber *duration;
 
- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        roleType:(AgoraEduRoleType)roleType
                        roomName:(NSString *)roomName
                        roomUuid:(NSString *)roomUuid
                        roomType:(AgoraEduRoomType)roomType
                           token:(NSString *)token;
 
- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        roleType:(AgoraEduRoleType)roleType
                        roomName:(NSString *)roomName
                        roomUuid:(NSString *)roomUuid
                        roomType:(AgoraEduRoomType)roomType
                           token:(NSString *)token
                       startTime:(NSNumber *)startTime
                        duration:(NSNumber *)duration;
@end
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
| `token` | The RTM token used for authentication, see [Generate an RTM Token](https://docs.agora.io/cn/agora-class/agora_class_prep#step5). |
| `startTime` | The start time (ms) of the class, determined by the first user joining the classroom. |
| `duration` | The duration (ms) of the class, determined by the first user joining the classroom. |

### AgoraEduCourseware

```
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

Courseware pre-download configuration. The courseware pre-loading configuration.  Used when calling `configCoursewares`.

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | The file name. |
| `scenePath` | The local path for storing the file. Agora recommends setting this parameter as the combination of `resourceName` and the `name` of the first `SceneInfo` object in `scenes```. |
| `resourceUrl` | The URL address of the file, such as `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip".` |
| `scenes` | A list of converted file pages, an array of `WhiteScene` objects. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom and then display the file on the whiteboard in pages. Each `WhiteScene` object represents one page. |

### WhiteObject

```
@interface WhiteScene : WhiteObject

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name ppt:(nullable WhitePptPage *)ppt;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSInteger componentsCount;
@property (nonatomic, strong, readonly, nullable) WhitePptPage *ppt;
@end
```

The detailed information of a page. Set in `AgoraEduCourseware`.

| Attributes | Description |
| :---------------- | :--------------------------------------------------------- |
| `componentsCount` | The number of pages. |
| `ppt` | The detailed information of a converted page. See `WhitePptPage`. |
| `name` | The page name. |

### WhitePptPage

```
@interface WhitePptPage : WhiteObject

- (instancetype)initWithSrc:(NSString *)src size:(CGSize)size;
- (instancetype)initWithSrc:(NSString *)src preview:(NSString *)url size:(CGSize)size;

@property (nonatomic, copy) NSString *src;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy, readonly) NSString *previewURL;

@end
```

The detailed information of a page. Set in `SceneInfo`.

| Attributes | Description |
| :----------- | :------------------------------------------ |
| `src` | The URL address of the converted page. |
| `width` | The width (pixel) of the page. |
| `height` | The height (pixel) of the page. |
| `previewURL` | The URL address of the preview image generated after the dynamic file conversion. |