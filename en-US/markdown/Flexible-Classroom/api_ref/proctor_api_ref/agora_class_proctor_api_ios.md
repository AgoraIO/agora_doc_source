This page provides the Objective-C API reference for the Agora Proctor SDK for iOS.

## AgoraProctorSDK

`AgoraProctorSDK` is the basic interface of the Agora Proctor SDK and provides the main methods for the flexible classroom in proctoring scenarios.

### init

```objective-c
- (instancetype)init:(AgoraProctorLaunchConfig *)config
            delegate:(id<AgoraProctorSDKDelegate> _Nullable)delegate;
```

Initializes the `AgoraProctorSDK` instance.

**Parameters**

| Parameters     |  Description                          |
| :------- | :--------------------------------------------------------------- |
| `config` | Configuration for flexible classroom, see [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig). |
| `delegate` | (Optional) The event handler for the Agora Proctor SDK, see [`AgoraProctorSDKDelegate`](#agoraproctorsdkdelegate). |


### launch

```objective-c
- (void)launch:(void (^)(void))success
       failure:(void (^)(NSError *))failure;
```

Launches a flexible classroom in a proctoring scenario.

**Parameters**

| Parameters     | Description                                                             |
| :------- | :--------------------------------------------------------------- |
| `success` | The callback triggered by a successful launch. |
| `failure` | The callback triggered by a failed launched, which returns an error. |


### version

```objective-c
- (NSString *)version;
```

Gets the SDK version.

**Returns**

- The SDK version (String).

## AgoraProctorSDKDelegate

`AgoraProctorSDKDelegate` reports events related to SDK status to your app.

### didExit

```objective-c
- (void)proctorSDK:(AgoraProctorSDK *)proctor
           didExit:(AgoraProctorExitReason)reason;
```

The user exits from the SDK. This callback is triggered when a user exits or is kicked from the room.

**Parameter**

| Parameters     | Description                                                             |
| :------- | :--------------------------------------------------------------- |
| `reason` | Reason for the exit, see [AgoraProctorExitReason](#agoraproctorexitreason). |


## Objects

### AgoraProctorLaunchConfig

```objective-c
@interface AgoraProctorLaunchConfig : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userUuid;

@property (nonatomic, assign) AgoraProctorUserRole userRole;

@property (nonatomic, copy) NSString *roomName;

@property (nonatomic, copy) NSString *roomUuid;

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) AgoraProctorRegion region;

@property (nonatomic, strong, nullable) AgoraProctorMediaOptions *mediaOptions;

@property (nonatomic, copy, nullable) NSDictionary<NSString *, id> *userProperties;

@property (nonatomic, strong) NSDictionary<NSString *, AgoraWidgetConfig *> *widgets;

- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        userRole:(AgoraProctorUserRole)userRole
                        roomName:(NSString *)roomName
                        roomUuid:(NSString *)roomUuid
                           appId:(NSString *)appId
                           token:(NSString *)token;

- (instancetype)initWithUserName:(NSString *)userName
                        userUuid:(NSString *)userUuid
                        userRole:(AgoraProctorUserRole)userRole
                        roomName:(NSString *)roomName
                        roomUuid:(NSString *)roomUuid
                           appId:(NSString *)appId
                           token:(NSString *)token
                          region:(AgoraProctorRegion)region
                    mediaOptions:(AgoraProctorMediaOptions * _Nullable)mediaOptions
                  userProperties:(NSDictionary * _Nullable)userProperties;
```

The classroom launching configuration used in [launch](#launch).

| Properties             | Description                |
| :--------------- | :--------------------- |
| `userName` | The user name for display in the classroom. The string length must be less than 64 bytes. |
| `userUuid` | The user ID. This is the globally unique identifier of a user. **Must be the same as the User ID that you use for generating an RTM token**. The string length must be less than 64 bytes. Supported character scopes are:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li></ul> |
| `userRole` | The user's role in the classroom. See [`agoraproctoruserrole`](#agoraproctoruserrole). |
| `roomName` | The room name for display in the classroom. The string length must be less than 64 bytes. |
| `roomUuid` | The room ID. This is the globally unique identifier of a classroom. The string length must be less than 64 bytes. Supported character scopes are:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li></ul> |
| `appId`          | The Agora App ID. See [Get the Agora App ID](https://docs.agora.io/en/flexible-classroom/reference/manage-agora-account?platform=ios#get-the-app-id). |
| `token` | The signaling token used for authentication. For details, see [Generate a signaling Token](https://docs.agora.io/en/signaling/develop/authentication-workflow). |
| `region` | The region where the classrooms is located. All clients must use the same region, otherwise, they may fail to communicate with each other. Supported regions are:<ul><li>`CN`: Mainland China</li><li>`AP`: Asia Pacific</li><li>`EU`: Europe</li><li>`NA`: North America</li></ul> |
| `mediaOptions` | Media options, including the media stream encryption configuration. See [`AgoraProctorMediaOptions`](#agoraproctormediaoptions) for details. |
| `userProperties` | User properties customized by the developer. For details, see [How can I set user properties? ](https://docs.agora.io/en/help/integration-issues/agora_class_custom_properties) |
| `widgets`        | Pass in `widgetId` and `AgoraWidgetConfig`.     |


### AgoraProctorMediaOptions

```objective-c
@interface AgoraProctorMediaOptions : NSObject
@property (nonatomic, strong, nullable) AgoraProctorMediaEncryptionConfig *encryptionConfig;

@property (nonatomic, strong, nullable) AgoraProctorVideoEncoderConfig *videoEncoderConfig;

@property (nonatomic, assign) AgoraProctorLatencyLevel latencyLevel;

- (instancetype)initWithEncryptionConfig:(AgoraProctorMediaEncryptionConfig * _Nullable)encryptionConfig
                      videoEncoderConfig:(AgoraProctorVideoEncoderConfig * _Nullable)videoEncoderConfig
                            latencyLevel:(AgoraProctorLatencyLevel)latencyLevel;
```

Media options. Set in [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig).
| Properties                | Description   |
| :------------------- | :------------------------------- |
| `encryptionConfig`   | (Optional) The media stream encryption configuration. See [AgoraProctorMediaEncryptionConfig](#agoraproctormediaencryptionconfig) for details.  |
| `videoEncoderConfig` | (Optional) The video encoder configuration. See [AgoraProctorVideoEncoderConfig](#agoraproctorvideoencoderconfig) for details.           |
| `latencyLevel`       | The latency level of an audience member. This property does not apply to co-hosting users. The default value is `low`, which means low latency. See [AgoraProctorLatencyLevel](#agoraproctorlatencylevel) for details.                   |

### AgoraProctorMediaEncryptionConfig

```objective-c
@interface AgoraProctorMediaEncryptionConfig : NSObject
@property (nonatomic, assign) AgoraProctorMediaEncryptionMode mode;
@property (nonatomic, copy) NSString *key;

- (instancetype)initWithMode:(AgoraProctorMediaEncryptionMode)mode
                         key:(NSString *)key;
```

The media stream encryption configuration used in [AgoraProctorMediaOptions](#agoraproctormediaoptions).

| Properties   | Description                                                                         |
| :----- | :--------------------------------------------------------------------------- |
| `mode` | Encryption mode. See [AgoraProctorMediaEncryptionMode](#agoraproctormediaencryptionmode). |
| `key`  | The encryption key.          |


### AgoraProctorVideoEncoderConfig

```objective-c
@interface AgoraProctorVideoEncoderConfig : NSObject
@property (nonatomic, assign) NSUInteger dimensionWidth;
@property (nonatomic, assign) NSUInteger dimensionHeight;
@property (nonatomic, assign) NSUInteger frameRate;
@property (nonatomic, assign) NSUInteger bitRate;
@property (nonatomic, assign) AgoraProctorMirrorMode mirrorMode;

- (instancetype)initWithDimensionWidth:(NSUInteger)dimensionWidth
                       dimensionHeight:(NSUInteger)dimensionHeight
                             frameRate:(NSUInteger)frameRate
                               bitRate:(NSUInteger)bitRate
                            mirrorMode:(AgoraProctorMirrorMode)mirrorMode;
```

The video encoder configuration used in [AgoraProctorMediaOptions](#agoraproctormediaoptions).


| Properties              | Description                                                           |
| :---------------- | :------------------------------------------------------------- |
| `dimensionWidth`  | Width (pixel) of the video frame. The default value is 320.  |
| `dimensionHeight` | Height (pixel) of the video frame. The default value is 240.     |
| `frameRate`       | The frame rate (FPS) of the video. The default value is 15.    |
| `bitRate`         | The bitrate (Kbps) of the video. The default value is 200.    |
| `mirrorMode`      | Video mirror modes. The default value is `AgoraProctorMirrorModeDisable`, which means to disable the mirror mode. See [`AgoraProctorMirrorMode`](#agoraproctormirrormode) for details. |

## Enum

### AgoraProctorMirrorMode

Whether to enable the mirror mode, used in [`AgoraProctorVideoEncoderConfig`](#agoraproctorvideoencoderconfig).

| Values       | Description            |
| :--------- | :-------------- |
| `disabled` | `0`: Enable the mirror mode. |
| `enabled`  | `1`: Disable the mirror mode. |

### AgoraProctorRegion

The region where the classrooms is located, used in [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig).

| Values  | Description               |
| :--- | :----------------- |
| `CN` | `0`: Mainland China |
| `NA` | `1`: North America.             |
| `EU` | `2`: Europe.             |
| `AP` | `3`: Asia Pacific.            |

### AgoraProctorExitReason

Reasons for exiting the Agora Proctor SDK, used in the [`didExit`](#didexit) callback.

| Values       | Description       |
| :-------- | :--------- |
| `normal`  | Exited the room normally. |
| `kickOut` | Got kicked out of the room. |


### AgoraProctorLatencyLevel

The latency level of an audience member, used in [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig).

| Values       | Description                                                           |
| :--------- | :------------------------------------------------------------- |
| `low`      | `1`: Low latency. The latency from the sender to the receiver is between 1500 ms and 2000 ms.       |
| `ultraLow` | `2`: Ultra-low latency. The latency from the sender to the receiver is between 400 ms and 800 ms. |

### AgoraProctorUserRole

User role in classrooms, used in [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig).

| Values      | Description        |
| :-------- | :---------- |
| `invalid` | `0`: Recording robot. |
| `teacher` | `1`: Teacher. |
| `student` | `2`: Student. |
| `assistant` | `3`: Assistant. |
| `observer` | `4`: Observer. |

### AgoraProctorMediaEncryptionMode

Media stream encryption mode, used in [AgoraProctorMediaEncryptionConfig](#agoraproctormediaencryptionconfig).

| Values         | Description     |
| :----------- | :------------------------------------------------------- |
| `None`       | `0`: No encryption. |
| `AES128XTS`  | `1`: 128-bit AES encryption, XTS mode.    |
| `AES128ECB`  | `2`: 128-bit AES encryption, ECB mode.      |
| `AES256XTS`  | `3`: 256-bit AES encryption, XTS mode.    |
| `SM4128ECB`  | `4`: 128-bit SM4 encryption, ECB mode.   |
| `AES128GCM`  | `5`: 128-bit AES encryption, GCM mode.    |
| `AES256GCM`  | `6`: 256-bit AES encryption, GCM mode.   |
| `AES128GCM2` | `7`: Enhanced 128-bit AES encryption, GCM mode. Compared with the `AES128GCM` encryption mode, this mode is more secured and requires setting salt.  |
| `AES256GCM2` | `8`: Enhanced 256-bit AES encryption, GCM mode. Compared with the `AES256GCM` encryption mode, this mode is more secured and requires setting salt.  |
