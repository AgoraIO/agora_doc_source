The `AgoraFpaProxyService` framework includes the following members:

## `FpaProxyService` class

`FpaProxyService` includes the following methods:

### `sharedFpaService` method

```objective-c
+ (FpaProxyService * _Nonnull)sharedFpaProxyService;
```

Gets the `FpaProxyService` object.

#### Returns

An `FpaProxyService` object.

### `startWithConfig` method

```objective-c
- (int)startWithConfig:(FpaProxyServiceConfig * _Nonnull)config;
```

Starts the FPA service.

#### Parameters

| Parameters   | Description                                    |
| ------ | --------------------------------------- |
| config | FPA service configuration. See [`FpaProxyServiceConfig`](#fpa-proxy-service-config). |

#### Returns

| Returns| Description                             |
| ------ | -------------------------------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `stop` method

```objective-c
- (int)stop;
```

Stops the FPA service.

#### Parameters

None.

#### Returns

None.

### `setupDelegate` method

```objective-c
- (int)setupDelegate:(id<FpaProxyServiceDelegate> _Nullable)delegate;
```

Registers an event listener for the FPA service,

#### Parameters

| Parameter     | Description                         |
| -------- | ---------------------------- |
| delegate | [`FpaProxyServiceDelegate`](#ifpa-service-listener) object. |

#### Returns

None.

### `setOrUpdateHttpProxyChainConfig` method

```objective-c
- (int)setOrUpdateHttpProxyChainConfig:(FpaHttpProxyChainConfig *_Nullable)chainConfig;
```

Sets or updates a list of the acceleration IPs or domains and the corresponding chain IDs.

#### Parameters

| Parameters   | Description                                                                            |
| ------ | ------------------------------------------------------------------------------- |
| chainConfig | The mapping table between acceleration IPs or domains and the corresponding chain IDs. See [`FpaHttpProxyChainConfig`](#fpa-http-proxy-chain-config). |

#### Returns

| Returns | Description       |
| ------ | ---------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `setParameters` method

```objective-c
- (int)setParameters:(NSString * _Nonnull)param;
```

Configures technical preview or custom features by using JSON strings.

JSON strings are not public by default.

#### Parameters

| Parameter  | Description                    |
| ----- | ----------------------- |
| param | Value in JSON string format. |

#### Returns

| Returns | Description       |
| ------ | ---------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `httpProxyPort` method

```objective-c
- (int)httpProxyPort;
```

Gets the port of the HTTP proxy.

#### Parameters

None.

#### Returns

| Returns | Description                           |
| ------ | ------------------------------ |
| > 0    | The port of the HTTP proxy. |
| < 0    | Failure. See [Error codes](#error-code). |

### `getTransparentProxyPort` method

```objective-c
- (int)getTransparentProxyPortWithChainInfo:(FpaChainInfo *_Nonnull)info;
```

Gets the port of the transparent proxy.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| info        | Information about the acceleration chain. See [`FpaChainInfo`](#fpa-chain-info).                  |

#### Returns

| Returns | Description                           |
| ------ | ------------------------------ |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `diagnosisInfo` method

```objective-c
- (FpaProxyServiceDiagnosisInfo* _Nullable)diagnosisInfo;
```

Gets diagnosis information.

#### Parameters

None.

#### Returns

[`FpaProxyServiceDiagnosisInfo`](#fpa-proxy-service-diagnosis-info) object.

### `getSdkVersion` method

```objective-c
+ (NSString * _Nonnull)getSdkVersion;
```

Gets the version of the SDK.

#### Parameters

None.

#### Returns

The version of the SDK.

### `getSdkBuildInfo` method

```objective-c
+ (NSString * _Nonnull)getSdkBuildInfo;
```

Gets the build information of the SDK.

#### Parameters

None.

#### Returns

The build information of the SDK.

<a id="fpa-proxy-service-config"></a>

## `FpaProxyServiceConfig` class

The `FpaProxyServiceConfig` class includes the following members:

```objective-c
__attribute__((visibility("default"))) @interface FpaProxyServiceConfig : NSObject
@property (nonatomic, copy) NSString * _Nonnull appId;
@property (nonatomic, copy) NSString * _Nonnull token;
@property (nonatomic, assign) FpaLogLevel logLevel;
@property (nonatomic, assign) NSInteger fileSize;
@property (nonatomic, copy) NSString * _Nonnull logFilePath;
@end
```

### Parameters

| Parameter          | Description                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| appId           | App ID to use Agora service. See [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).  |
| token           |   Token generated from your app server for authentication. <ul><li>If your project uses **App ID** for authentication, you can assign the value of app ID to the `token` parameter. You can also assign `null` or `""` to this parameter or skip this parameter.</li><li> If your project uses **App ID + token** for authentication, you need to assign the token generated from your app server to this parameter.</li></ul>  |
| logLevel           |   Log level. <ul><li>0: No logs.</li><li>1: Information.</li><li>2: Warning.</li><li>4: Error.</li><li>8: Fatal.</li></ul>  See [FpaLogLevel](#loglevel). |
| fileSize           |   The maximum size of a single log file (KB). The default is 1024. If you set this parameter to 1024, the maximum size of the log files is 5 MB. If you set this parameter to a value less than 1024, the maximum size of a single log file is still 1024.|
| logFilePath       | The full path of the log file including the filename in string format. Make sure the path exists and is writable.                 |


<a id="fpa-http-proxy-chain-config"></a>

## `FpaHttpProxyChainConfig` class

The `FpaHttpProxyChainConfig` class includes the following members:

```objective-c
__attribute__((visibility("default"))) @interface FpaHttpProxyChainConfig : NSObject
@property (nonatomic, strong) NSArray <FpaChainInfo *>* _Nonnull chainArray;
@property (nonatomic, assign) BOOL fallbackWhenNoChainAvailable;
@end
```

### Parameters

| Parameter          | Description                                                                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| chainArray       | An array of `FpaChainInfo` objects. See [`FpaChainInfo`](#fpa-chain-info).                                        |
| fallbackWhenNoChainAvailable   | Whether to fall back to local connection when the SDK cannot find the chain ID corresponding to the source server. <ul><li>`YES`: Falls back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li><li>`NO`: Does not fall back to local connection when the SDK cannot find the chain ID corresponding to the source server.|


<a id="fpa-chain-info"></a>

## `FpaChainInfo` class

This class includes the following members:

### `fpaChainInfoWithChainId` method

```objective-c
+ (FpaChainInfo *_Nonnull)fpaChainInfoWithChainId:(NSInteger)chainId
                                          address:(NSString *_Nonnull)address
                                             port:(NSInteger)port
                                   enableFallback:(BOOL)enableFallback;
```

Gets an `FpaChainInfo` object.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| chainId        | Chain ID of the acceleration chain.                     |
| address | IP of the source server for acceleration.                                                                                                                                    |
| port | Port of the source server for acceleration.                                                                                                                                        |
| enableFallback   | Whether to fall back to local connection if FPA connection fails for this acceleration chain. <ul><li>`YES`: Falls back to local connection.</li><li>`NO`: Does not fall back to local connection.|

#### Returns

An `FpaChainInfo` object.

<a id="fpa-proxy-connection-info"></a>

## `FpaProxyConnectionInfo` class

Information about the FPA proxy connection.

```objective-c
__attribute__((visibility("default"))) @interface FpaProxyServiceConnectionInfo : NSObject
@property (nonatomic, copy) NSString * _Nullable dstIpOrDomain;
@property (nonatomic, assign) NSInteger dstPort;
@property (nonatomic, assign) NSInteger localPort;
@property (nonatomic, copy) NSString * _Nullable connectionId;
@property (nonatomic, copy) NSString * _Nullable proxyType;
@end
```

### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| dstIpOrDomain  |  NSString  | IP or domain of the source server.     |
| dstPort |  NSInteger  | Port of the source server.     |
| localPort |  NSInteger  | Port of the local proxy.   |
| connectionId |  NSString  | Connection ID. Each ID represents a connection from beginning to end between the SDK and the source server through the proxy.     |
| proxyType |  NSString  | Proxy type. <ul><li>`"http"`: HTTP proxy. </li><li>`"https"`: HTTPS proxy.</li><li>`"transport"`: TCP transparent proxy.</li></ul>    |

<a id="fpa-proxy-service-diagnosis-info"></a>

## `FpaProxyServiceDiagnosisInfo` class

The `FpaProxyServiceDiagnosisInfo` class includes the following parameters.

```objective-c
__attribute__((visibility("default"))) @interface FpaProxyServiceDiagnosisInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull installId;
@property (nonatomic, copy) NSString * _Nonnull instanceId;
@end
```

### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| installId  |  NSString  | The unique ID corresponding to the device that runs the app integrating the SDK. If you remove the app cache, the SDK updates the installId.    |
| instanceId |  NSString  | The unique ID corresponding to the current `FpaProxyService` object.    |

<a id="ifpa-service-listener"></a>

## `FpaProxyServiceDelegate` protocol

The `FpaProxyServiceDelegate` protocol includes the following callbacks:

### `onConnected` callback

```objective-c
- (void)onConnected:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo;
```

Occurs when the SDK successfully connects to the FPA proxy.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).                        |

### `onAccelerationSuccess` callback

```objective-c
- (void)onAccelerationSuccess:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo;
```

Occurs when the acceleration succeeds.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| connectionInfo | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |

### `onConnectionFailed` callback

```objective-c
- (void)onConnectionFailed:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo reason:(FpaFailedReason)reason;
```

Occurs when the SDK fails to connect to the FPA proxy and the connection does not fall back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| connectionInfo | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FpaFailedReason](#failed-reason).                                                                                                     |

### `onDisconnectedAndFallback` callback

```objective-c
- (void)onDisconnectedAndFallback:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo reason:(FpaFailedReason)reason;
```

Occurs when the SDK fails to connect to the FPA proxy and the connection falls back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| connectionInfo | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FailedReason](#failed-reason).                                                                                                     |

<a id="error-code"></a>

## `FpaError` enum

Synchronous error codes returned by the SDK.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaErrorNone` |      0: No error.                                                                                                                     |
| `FpaServiceErrorInvalidArgument` |        -1: Invalid parameters. Check whether your parameters values are valid.               |
| `FpaServiceErrorNoMemory` |               -2: Cannot assign memory to the object.                                          |
| `FpaServiceErrorNotInitialized` |            -3：The FPA service is not initialized. Make sure you have initialized the SDK.                         |
| `FpaServiceErrorCoreInitializeFailed` |        -4: The FPA service fails to initialize.                                               |
| `FpaServiceErrorUnableBindSocketPort` |        -5: Cannot bind the internal socket port.                                      |

<a id="failed-reason"></a>

## `FpaFailedReason` enum

Reasons of failure.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaFailedReasonDnsQuery` |      -101: DNS resolution error.                             |
| `FpaFailedReasonSocketCreateFailed` |        -102: Failed to create an internal socket.                                   |
| `FpaFailedReasonSocketConnect` |               -103: Failed to connect to the internal socket.                                                  |
| `FpaFailedReasonConnectTimeout` |            -104: Timeout when connecting to the remote server.                                                        |
| `FpaFailedReasonNoChainIdMatch` |        -105: Cannot find the specified chain ID. Check whether you have configured the correct chain ID.                                              |
| `FpaFailedReasonDataRead` |        -106: Failed to read data.                                       |
| `FpaFailedReasonDataWrite` |        -107: Failed to write data.                                      |
| `FpaFailedReasonTooFrequently` |        -108: The concurrent number of connections per each second exceeds 100.                             |
| `FpaFailedReasonTooManyConnections` |        -109: The number of active connections exceeds 1,000.                                     |

<a id="loglevel"></a>

## `FpaLogLevel` enum

Log level.

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaLogLevelNoLogOutput` |     0: No logs.                                                                                                                      |
| `FpaLogLevelInfo` |        1: Information.                                                                                               |
| `FpaLogLevelWarning` |              2: Warning.                                                    |
| `FpaLogLevelError` |           4: Error.                                                           |
| `FpaLogLevelFatal` |        8: Fatal.                                              |
