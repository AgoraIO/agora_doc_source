本页提供 Agora Proctor SDK for iOS 的 Swift API 参考。

## 方法

### init

```swift
init(AgoraProctorLaunchConfig config,
     AgoraProctorSDKCallbackHandler handler)
```

初始化 Agora Proctor SDK 对象。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `config` | 全局配置参数，详见 [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig)。 |
| `handler` | AgoraProctorSDK 回调监听者，详见 [`AgoraProctorSDKCallbackHandler`](#回调)。 |


### launch

```swift
void launch(Callback<Void> success,
            Callback<Error> failure)
```

启动 Agora Proctor SDK。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `success` | 启动成功。 |
| `failure` | 启动失败，返回一个 Error//TODO 有错误码吗。 |


### version

```swift
String version()
```

获取 Agora Proctor SDK 的版本。

**返回值**

- SDK 版本号，String 型。

## 回调

`AgoraProctorSDKCallbackHandler` 包含了 Proctor SDK 中的回调事件接口。

### onProctorSDKExited

```swift
void onProctorSDKExited(AgoraProctorExitReason reason)
```

Agora Proctor SDK 退出回调，会在用户退出 SDK 或被踢出时触发。

**参数**

| 参数     | 描述                                                             |
| :------- | :--------------------------------------------------------------- |
| `reason` | 退出原因，详见 [AgoraProctorExitReason](#agoraproctorexitreason)。 |


## 类型定义

### AgoraProctorLaunchConfig

```swift
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

监考启动配置，用于 [launch](#launch) 方法。

| 属性             | 描述                |
| :--------------- | :--------------------- |
| `userName`       | 用户名。用于课堂内显示，长度在 64 字节以内。   |
| `userUuid`       | 用户 ID。这是用户的全局唯一标识，需要与你签发 Token 时使用的 UID 一致。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）: <ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字</li><li>0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","</li></ul> |
| `userRole`       | 用户在课堂中的角色，详见 [AgoraProctorUserRole](#agoraproctoruserrole)。   |
| `roomName`       | 课堂名。用于课堂内显示，长度在 64 字节以内。    |
| `roomUuid`       | 课堂 ID。这是课堂的全局唯一标识。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字</li><li>0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","</li></ul>  |
| `appId`          | Agora App ID。|
| `token`          | 用于鉴权的 Token。 详见[使用 RTM Token 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms)。  |
| `region`         | 区域。建议设置为靠近你的课件或录制文件对象存储服务所在的区域，因为跨区域传输较大的静态资源会造成比较大的延迟。举例来说，如果你的 S3 服务在北美，则建议将 `region` 也设为北美区域。所有灵动课堂客户端必须设置相同的区域，否则无法互通。支持的区域详见 [AgoraProctorRegion](#agoraproctorregion)。    |
| `mediaOptions`   | 媒体流相关设置，包含媒体流加密，详见 [AgoraProctorMediaOptions](#agoraproctormediaoptions)。     |
| `userProperties` | 由开发者自定义的用户属性，会传入 `AgoraProctorUserContext` 的 `userProperties`。//TODO 没找到 user context  |
| `widgets`        | 传入 Widget ID 和 Widget Config。     |


### AgoraProctorMediaOptions

```swift
@interface AgoraProctorMediaOptions : NSObject
@property (nonatomic, strong, nullable) AgoraProctorMediaEncryptionConfig *encryptionConfig;

@property (nonatomic, strong, nullable) AgoraProctorVideoEncoderConfig *videoEncoderConfig;

@property (nonatomic, assign) AgoraProctorLatencyLevel latencyLevel;

- (instancetype)initWithEncryptionConfig:(AgoraProctorMediaEncryptionConfig * _Nullable)encryptionConfig
                      videoEncoderConfig:(AgoraProctorVideoEncoderConfig * _Nullable)videoEncoderConfig
                            latencyLevel:(AgoraProctorLatencyLevel)latencyLevel;
```

媒体流相关设置，用于 [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig)。

| 属性                 | 描述                                                                                    |
| :------------------- | :-------------------------------------------------------------------------------------- |
| `encryptionConfig`   | 媒体流加密配置，详见 [AgoraProctorMediaEncryptionConfig](#agoraproctormediaencryptionconfig).   |
| `videoEncoderConfig` | 视频编码配置，详见 [AgoraProctorVideoEncoderConfig](#agoraproctorvideoencoderconfig).           |
| `latencyLevel`       | 观众端延时级别，详见 [AgoraProctorLatencyLevel](#agoraproctorlatencylevel)。                    |

### AgoraProctorMediaEncryptionConfig

```swift
@interface AgoraProctorMediaEncryptionConfig : NSObject
@property (nonatomic, assign) AgoraProctorMediaEncryptionMode mode;
@property (nonatomic, copy) NSString *key;

- (instancetype)initWithMode:(AgoraProctorMediaEncryptionMode)mode
                         key:(NSString *)key;
```

媒体流加密配置，用于 [AgoraProctorMediaOptions](#agoraproctormediaoptions)。

| 属性   | 描述                                                                         |
| :----- | :--------------------------------------------------------------------------- |
| `mode` | 加密模式，详见 [AgoraProctorMediaEncryptionMode](#agoraproctormediaencryptionmode)。 |
| `key`  | 加密密钥。                                                                   |


### AgoraProctorVideoEncoderConfig

```swift
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

视频编码参数配置类，用于 [AgoraProctorMediaOptions](#agoraproctormediaoptions)。

> -  在小班课中，分辨率的默认值为 120p（160 * 120）。
> -  在一对一和大班课中，分辨率的默认值为 240p（320 * 240）。

| 属性              | 描述                                                           |
| :---------------- | :------------------------------------------------------------- |
| `dimensionWidth`  | 视频帧宽度，单位为像素。                                   |
| `dimensionHeight` | 视频帧高度，单位为像素。                                   |
| `frameRate`       | 视频帧率，单位为 fps，默认值为 15。                      |
| `bitRate`         | 视频码率，单位为 Kbps，默认值为 200。                        |
| `mirrorMode`      | 视频镜像模式，详见 [`AgoraProctorMirrorMode`](#agoraproctormirrormode)。 |

### AgoraProctorMirrorMode

镜像模式，用于 [`AgoraProctorVideoEncoderConfig`](#agoraproctorvideoencoderconfig)。//TODO 指的是视频镜像？有无默认值？

| 参数       | 描述            |
| :--------- | :-------------- |
| `disabled` | `0`: 关闭镜像。 |
| `enabled`  | `1`: 开启镜像。 |

### AgoraProctorRegion

区域，用于 [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig)。//TODO 有无默认值？

| 属性 | 描述               |
| :--- | :----------------- |
| `CN` | `0`: （默认）中国大陆。 |
| `NA` | `1`: 北美。             |
| `EU` | `2`: 欧洲。             |
| `AP` | `3`: 东南亚。             |

### AgoraProctorExitReason

退出 Agora Proctor SDK 原因，用于 [`onProctorSDKExited`](#onproctorsdkexited) 回调。//TODO 确认有无默认值？

| 属性      | 描述       |
| :-------- | :--------- |
| `normal`  | 正常退出。 |
| `kickOut` | 被踢出。   |


### AgoraProctorLatencyLevel

观众端延时级别，只对台下学生有效。在 [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig) 中设置。//TODO 确认描述是否正确，有无默认值？

| 参数       | 描述                                                           |
| :--------- | :------------------------------------------------------------- |
| `low`      | `1`: 低延时。发流端与观众端的延时为 1500 ms - 2000 ms。        |
| `ultraLow` | `2`: （默认）超低延时。发流端与观众端的延时为 400 ms - 800 ms。 |

### AgoraProctorUserRole

用户在课堂中的角色。在 [`AgoraProctorLaunchConfig`](#agoraproctorlaunchconfig) 中设置。

| 属性      | 描述        |
| :-------- | :---------- |
| `invalid` | `0`: 录制机器人。 |
| `teacher` | `1`: 教师。 |
| `student` | `2`: 学生。 |
| `assistant` | `3`: 助教。 |
| `observer` | `4`: 观众。 |

### AgoraProctorMediaEncryptionMode

媒体流加密模式，用于 [AgoraProctorMediaEncryptionConfig](#agoraproctormediaencryptionconfig)。//TODO 确认描述是否适用，有无默认值？

| 参数         | 描述     |
| :----------- | :------------------------------------------------------- |
| `None`       | `0`: 不设置加密。 |
| `AES128XTS`  | `1`: 128 位 AES 加密，XTS 模式。      |
| `AES128ECB`  | `2`: 128 位 AES 加密，ECB 模式。      |
| `AES256XTS`  | `3`: 256 位 AES 加密，XTS 模式。     |
| `SM4128ECB`  | `4`: 128 位 SM4 加密，ECB 模式。      |
| `AES128GCM`  | `5`: 128 位 AES 加密，GCM 模式。     |
| `AES256GCM`  | `6`: 256 位 AES 加密，GCM 模式。    |
| `AES128GCM2` | `7`: 128 位 AES 加密，GCM 模式。相比于 `AES128GCM` 加密模式，`AES128GCM2` 加密模式安全性更高且需要设置盐。   |
| `AES256GCM2` | `8`: 256 位 AES 加密，GCM 模式。相比于 `AES_256_GCM` 加密模式，`AES256GCM2` 加密模式安全性更高且需要设置盐。 |
