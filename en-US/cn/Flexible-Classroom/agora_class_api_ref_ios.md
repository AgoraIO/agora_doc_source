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
public static void setConfig(AgoraEduSDKConfig agoraEduSDKConfig);
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
| `delegate` | The SDK uses the  `AgoraEduLaunchCallback` class to report events related to classroom launching to the app. |

**Returns**

The` AgoraEduClassRoom` class.

### configCoursewares

```
public static void configCoursewares(@NotNull List<AgoraEduCourseware> wares);
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
| `delegate` | The SDK reports events related to `courseware` preloading to the app through the AgoraEduCoursewarePreloadListener class. |

## The AgoraEduClassRoom class.

### destroy

```
- (void)destroy;
```

Release` the resources occupied by the AgoraEduClassroom` object.

## AgoraEduClassroomDelegate

The` AgoraEduLaunchCallback` class reports events related to class launching to the app.

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

`The AgoraEduCoursewarePreloadListener` class reports events related to courseware preloading to the app.

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
    AgoraEduEventFailed(0),
    AgoraEduEventReady(1),
    AgoraEduEventDestroyed(2),
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
public enum AgoraEduRoleType {
    AgoraEduRoleTypeStudent: Student
};
```

The role of the user in the classroom. You need to set the user role in `AgoraEduLaunchConfig`.

| Attributes | Description |
| :------------------------ | :---------- |
| `AgoraEduRoleTypeStudent` | `2`: A student. |

### AgoraEduRoomType

```
public enum AgoraEduRoomType {
    AgoraEduRoomType1V1(0),
    AgoraEduRoomTypeSmall(4);
    AgoraEduRoomTypeBig
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
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteSDK *sdk;
- (instancetype)initWithAppId:(NSString *)appId;
- (instancetype)initWithAppId:(NSString *)appId
                      eyeCare:(BOOL)eyeCare;
 
@end
```

The SDK global configuration. Used when `calling AgoraEduSDK.config`.

| Attributes | Description |
| :-------- | :----------------------------------------------------------- |
| `appId` | The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `eyeCare` | Whether to enable eye care mode:<li>`false`: (default) Disable eye care mode.</li><li>`true`: Enable eye care mode.</li> |

### AgoraEduLaunchConfig

```
@NotNull AgoraEduLaunchConfig config,
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteBoardView *boardView;
@property (nonatomic, strong) WhiteBoardView *boardView;
 
- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        roleType: EduRoleTypeEnum,
                        roomName: string,
                        roomUuid:(NSString *)roomUuid
                        roomType: EduRoomTypeEnum,
                           token:(NSString *)token;
 
- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        roleType: EduRoleTypeEnum,
                        roomName: string,
                        roomUuid:(NSString *)roomUuid
                        roomType: EduRoomTypeEnum,
                           token:(NSString *)token
                       startTime: number,
                        duration: number,
 
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
data class AgoraEduCourseware(
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteSDK *sdk;
- (instancetype)initWithResourceName:(NSString *)resourceName
                           scenePath:(NSString *)scenePath
                              scenes:(NSArray<WhiteScene *> *)scenes
                         resourceUrl:(NSString *)resourceUrl;
 
@end
```

Courseware pre-download configuration. The courseware `pre-loaded` configuration.  Used when calling configCoursewares.

| Attributes | Description |
| :------------- | :----------------------------------------------------------- |
| `resourceName` | file name. |
| `scenePath` | The local storage path of the file is suggested to be formed by concatenating `resourceName` and` the name of the first `SceneInfo` object in ``scenes`, for example,` resourceName + "/" + sceneInfos.get(0).name`. |
| `resourceUrl` | Courseware download address, such as `"https://convertcdn.netless.link/dynamicConvert/{taskUuid}.zip"` |
| `scenes` | A list of converted file pages, an array of `WhiteScene` objects. Flexible Classroom automatically converts files with the suffixes of `"ppt"`, `"pptx"`, `"doc"`, `"docx"`, and `"pdf"` to formats that can be displayed on the whiteboard in the classroom. Each `WhiteScene` object corresponds to a page. |

### WhiteObject

```
@interface WhiteScene : WhiteObject

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name ppt:(nullable WhitePptPage *)ppt;

@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteSDK *sdk;
 
@end
```

Specific information on a file page. Set in `AgoraEduCourseware`.

| Attributes | Description |
| :---------------- | :--------------------------------------------------------- |
| `componentsCount` | Number of pages. |
| `ppt` | For the specific information of a converted page, see the `WhitePptPage` object for details. |
| `name` | The name of the page. |

### WhitePptPage

```
@interface WhitePptPage : WhiteObject

- (instancetype)initWithSrc:(NSString *)src size:(CGSize)size;
- (instancetype)initWithSrc:(NSString *)src preview:(NSString *)url size:(CGSize)size;

@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteRoom *room;

 
@end
```

The specific information of a converted page. Set in `SceneInfo`.

| Attributes | Description |
| :----------- | :------------------------------------------ |
| `src` | The URL of the custom video thumbnail. |
| `width` | The width of the screen (pixel). |
| `height` | The height of the screen (pixel). |
| `previewURL` | URL download URL of the preview image generated during dynamic file conversion. |