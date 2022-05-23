The `agora_fpa_service` Package includes the following members:

## `FpaProxyService` class

`FpaProxyService` includes the following methods:

### `instance` method

```dart
static FpaProxyService get instance => FpaProxyServiceImpl.instance;
```

Gets the `FpaProxyService` object.

#### Returns

An `FpaProxyService` object.

### `start` method

```dart
void start(FpaProxyServiceConfig config);
```

Starts the FPA service.

#### Parameters

| Parameters   | Description                                    |
| ------ | --------------------------------------- |
| config | FPA service configuration. See [`FpaProxyServiceConfig`](#fpa-proxy-service-config). |

#### Returns

None.

### `stop` method

```dart
- (int)stop;
```

Stops the FPA service.

#### Parameters

None.

#### Returns

None.

### `setObserver` method

```dart
void setObserver(FpaProxyServiceObserver observer);
```

Registers an event listener for the FPA service,

#### Parameters

| Parameter     | Description                         |
| -------- | ---------------------------- |
| observer | [`FpaProxyServiceObserver`](#ifpa-service-listener) object. |

#### Returns

None.

### `setOrUpdateHttpProxyChainConfig` method

```dart
void setOrUpdateHttpProxyChainConfig(FpaHttpProxyChainConfig config);
```

Sets or updates a list of the acceleration IPs or domains and the corresponding chain IDs.

#### Parameters

| Parameters   | Description                                                                            |
| ------ | ------------------------------------------------------------------------------- |
| config | The mapping table between acceleration IPs or domains and the corresponding chain IDs. See [`FpaHttpProxyChainConfig`](#fpa-http-proxy-chain-config). |

#### Returns

None.

### `setParameters` method

```dart
void setParameters(String params);
```

Configures technical preview or custom features by using JSON strings.

JSON strings are not public by default.

#### Parameters

| Parameter  | Description                    |
| ----- | ----------------------- |
| params | Value in JSON string format. |

#### Returns

None.

### `getHttpProxyPort` method

```dart
int getHttpProxyPort();
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

```dart
int getTransparentProxyPort(FpaChainInfo info);
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

### `getDiagnosisInfo` method

```dart
FpaProxyServiceDiagnosisInfo getDiagnosisInfo();
```

Gets diagnosis information.

#### Parameters

None.

#### Returns

[`FpaProxyServiceDiagnosisInfo`](#fpa-proxy-service-diagnosis-info) object.

### `getSdkVersion` method

```dart
static String getSDKVersion()
```

Gets the version of the SDK.

#### Parameters

None.

#### Returns

The version of the SDK.

### `getBuildInfo` method

```dart
static String getBuildInfo()
```

Gets the build information of the SDK.

#### Parameters

None.

#### Returns

The build information of the SDK.

<a id="fpa-proxy-service-config"></a>

## `FpaProxyServiceConfig` class

The `FpaProxyServiceConfig` class includes the following members:

```dart
class FpaProxyServiceConfig {
  FpaProxyServiceConfig({
    required this.appId,
    required this.token,
    this.logLevel = FpaProxyServiceLogLevel.none,
    this.logFileSizeKb = 0,
    this.logFilePath = '',
  });

  final String appId;
  final String token;
  final FpaProxyServiceLogLevel logLevel;
  final int logFileSizeKb;
  final String logFilePath;
}
```

### `FpaProxyServiceConfig` method

Constructor of the `FpaProxyServiceConfig` class.

#### Parameters

| Parameter          | Description                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| appId           | App ID to use Agora service. See [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).  |
| token           |   Token generated from your app server for authentication. <ul><li>If your project uses **App ID** for authentication, you can assign the value of app ID to the `token` parameter. You can also assign `null` or `""` to this parameter or skip this parameter.</li><li> If your project uses **App ID + token** for authentication, you need to assign the token generated from your app server to this parameter.</li></ul>  |
| logLevel           |   Log level. <ul><li>0: No logs.</li><li>1: Information.</li><li>2: Warning.</li><li>4: Error.</li><li>8: Fatal.</li></ul>  See [FpaLogLevel](#loglevel). |
| logFileSizeKb           |   The maximum size of a single log file (KB). The default is 1024. If you set this parameter to 1024, the maximum size of the log files is 5 MB. If you set this parameter to a value less than 1024, the maximum size of a single log file is still 1024.|
| logFilePath       | The full path of the log file including the filename in string format. Make sure the path exists and is writable.                 |

#### Returns

An `FpaProxyServiceConfig` object.

<a id="fpa-http-proxy-chain-config"></a>

## `FpaHttpProxyChainConfig` class

The `FpaHttpProxyChainConfig` class includes the following members:

```dart
class FpaHttpProxyChainConfig {
  FpaHttpProxyChainConfig({
    this.chainArray,
    this.chainArraySize = 0,
    this.fallbackWhenNoChainAvailable = true,
  });

  final List<FpaChainInfo>? chainArray;
  final int chainArraySize;
  final bool fallbackWhenNoChainAvailable;
}
```

### `FpaHttpProxyChainConfig` method

Constructor of the `FpaHttpProxyChainConfig` class.

#### Parameters

| Parameter          | Description                                                                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| chainArray       | An array of `FpaChainInfo` objects. See [`FpaChainInfo`](#fpa-chain-info).                                        |
| chainArraySize       | Size of the array.                                        |
| fallbackWhenNoChainAvailable   | Whether to fall back to local connection when the SDK cannot find the chain ID corresponding to the source server. <ul><li>`true`: Falls back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li><li>`false`: Does not fall back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li></ul>|


#### Returns

An `FpaHttpProxyChainConfig` object.

<a id="fpa-chain-info"></a>

## `FpaChainInfo` class

This class includes the following members:

```dart
class FpaChainInfo {
  FpaChainInfo({
    required this.address,
    this.port = 0,
    this.chainId = 0,
    this.enableFallback = true,
  });

  final String address;
  final int port;
  final int chainId;
  final bool enableFallback;
}
```

### `FpaChainInfo` method

Constructor of the `FpaChainInfo` class.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| address | IP of the source server for acceleration.         |
| port | Port of the source server for acceleration.              |
| chainId        | Chain ID of the acceleration chain.                     |
| enableFallback   | Whether to fall back to local connection if FPA connection fails for this acceleration chain. <ul><li>`true`: Falls back to local connection.</li><li>`false`: Does not fall back to local connection.|

#### Returns

An `FpaChainInfo` object.

<a id="fpa-proxy-connection-info"></a>

## `FpaProxyConnectionInfo` class

Information about the FPA proxy connection.

```dart
class FpaProxyConnectionInfo {
  FpaProxyConnectionInfo({
    required this.dstIpOrDomain,
    required this.connectionId,
    required this.proxyType,
    this.dstPort = 0,
    this.localPort = 0,
  });

  final String dstIpOrDomain;
  final String connectionId;
  final String proxyType;
  final int dstPort;
  final int localPort;
}
```

### `FpaProxyConnectionInfo` method

Constructor of the `FpaProxyConnectionInfo` class.

#### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| dstIpOrDomain  |  String  | IP or domain of the source server.     |
| dstPort |  Integer  | Port of the source server.     |
| localPort |  Integer  | Port of the local proxy.   |
| connectionId |  String  | Connection ID. Each ID represents a connection from beginning to end between the SDK and the source server through the proxy.     |
| proxyType |  String  | Proxy type. <ul><li>`"http"`: HTTP proxy. </li><li>`"https"`: HTTPS proxy.</li><li>`"transport"`: TCP transparent proxy.</li></ul>    |

#### Returns

An `FpaProxyConnectionInfo` object.

<a id="fpa-proxy-service-diagnosis-info"></a>

## `FpaProxyServiceDiagnosisInfo` class

The `FpaProxyServiceDiagnosisInfo` class includes the following parameters.

```dart
class FpaProxyServiceDiagnosisInfo {
  FpaProxyServiceDiagnosisInfo({
    required this.installId,
    required this.instanceId,
  });

  final String installId;
  final String instanceId;
}
```

### FpaProxyServiceDiagnosisInfo method

Constructor of the `FpaProxyServiceDiagnosisInfo` class.

#### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| installId  |  String  | The unique ID corresponding to the device that runs the app integrating the SDK. If you remove the app cache, the SDK updates the installId.    |
| instanceId |  String  | The unique ID corresponding to the current `FpaProxyService` object.    |

#### Returns

An `FpaProxyConnectionInfo` object.

<a id="ifpa-service-listener"></a>

## `FpaProxyServiceObserver` class

The `FpaProxyServiceObserver` class includes the following callbacks:

```dart
abstract class FpaProxyServiceObserver
```

### `onConnected` callback

```dart
void onConnected(FpaProxyConnectionInfo info);
```

Occurs when the SDK successfully connects to the FPA proxy.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).                        |

### `onAccelerationSuccess` callback

```dart
void onAccelerationSuccess(FpaProxyConnectionInfo info);
```

Occurs when the acceleration succeeds.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| connectionInfo | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |

### `onConnectionFailed` callback

```dart
void onConnectionFailed(
      FpaProxyConnectionInfo info, FpaProxyServiceReasonCode reason);
```

Occurs when the SDK fails to connect to the FPA proxy and the connection does not fall back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| connectionInfo | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FpaFailedReason](#failed-reason).                                                                                                     |

### `onDisconnectedAndFallback` callback

```dart
void onDisconnectedAndFallback(
      FpaProxyConnectionInfo info, FpaProxyServiceReasonCode reason);
```

Occurs when the SDK fails to connect to the FPA proxy and the connection falls back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FailedReason](#failed-reason).                                                                                                     |

## `FpaProxyServiceException` class

```dart
class FpaProxyServiceException implements Exception {
  FpaProxyServiceException(this.errorCode);

  final int errorCode;

  @override
  String toString() {
    return '[FpaProxyServiceException] errorCode: $errorCode';
  }
}
```

Exception thrown by the SDK when a method call fails.

### `FpaProxyServiceException` method

Constructor of the `FpaProxyServiceException` class.

#### Parameters

| Parameter      | Description                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| errorCode | The error code. See [Error codes](#error-code).         |

#### Returns

An `FpaProxyServiceException` object.

<a id="error-code"></a>

## `FpaProxyServiceErrorCode` enum

Synchronous error codes returned by the SDK.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `none` |      0: No error.                                                                                                                     |
| `invalidArgument` |        -1: Invalid parameters. Check whether your parameters values are valid.               |
| `noMemory` |               -2: Cannot assign memory to the object.                                          |
| `notInitialized` |            -3：The FPA service is not initialized. Make sure you have initialized the SDK.                         |
| `coreInitializeFailed` |        -4: The FPA service fails to initialize.                                               |
| `unableBindSocketPort` |        -5: Cannot bind the internal socket port.                                      |

<a id="failed-reason"></a>

## `FpaProxyServiceReasonCode` enum

Reasons of failure.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaFailedReasonDnsQueryFpaFailedReasonDnsQuery` |      -101: DNS resolution error.                             |
| `FpaFailedReasonSocketCreateFailed` |        -102: Failed to create an internal socket.                                   |
| `FpaFailedReasonSocketConnect` |               -103: Failed to connect to the internal socket.                                                  |
| `FpaFailedReasonConnectTimeout` |            -104: Timeout when connecting to the remote server.                                                        |
| `FpaFailedReasonNoChainIdMatch` |        -105: Cannot find the specified chain ID. Check whether you have configured the correct chain ID.                                              |
| `FpaFailedReasonDataRead` |        -106: Failed to read data.                                       |
| `FpaFailedReasonDataWrite` |        -107: Failed to write data.                                      |
| `FpaFailedReasonTooFrequently` |        -108: The concurrent number of connections per each second exceeds 100.                             |
| `FpaFailedReasonTooManyConnections` |        -109: The number of active connections exceeds 1,000.                                     |

<a id="loglevel"></a>

## `FpaProxyServiceLogLevel` enum

Log level.

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaLogLevelNoLogOutput` |     0: No logs.                                                                                                                      |
| `FpaLogLevelInfo` |        1: Information.                                                                                               |
| `FpaLogLevelWarning` |              2: Warning.                                                    |
| `FpaLogLevelError` |           4: Error.                                                           |
| `FpaLogLevelFatal` |        8: Fatal.                                              |
