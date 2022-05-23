The `io.agora.fpa.proxy` Package includes the following classes and enums:

## `FpaProxyService` class

`FpaProxyService` includes the following methods:

### `getInstance` method

```java
public static synchronized FpaProxyService getInstance()
```

Gets the `FpaProxyService` object.

#### Returns

An `FpaProxyService` object.

### `start` method

```java
public int start(@NonNull FpaProxyServiceConfig config) throws Exception
```

Starts the FPA service.

#### Parameters

| Parameters   | Description                                    |
| ------ | --------------------------------------- |
| config | FPA service configuration. See [`FpaProxyServiceConfig`](#fpa-proxy-service-config). |

#### Returns

| Returns| Description                             |
| ------ | -------------------------------- |
| 0      | Successfully starts the FPA service.                   |
| &lt;0  | Fails to start the FPA service and throws an exception.|

#### Throws exceptions

- `RuntimeException("must have a config instance")`: The config parameter is null.
- `RuntimeException("appId and token not empty")`: The appId and token parameter in `FpaProxyServiceConfig` must not be empty.
- `RuntimeException("start service failed")`: Fails to start the FPA service.

### `stop` method

```java
public void stop()
```

Stops the FPA service.

#### Parameters

None.

#### Returns

None.

### `setListener` method

```java
public synchronized void setListener(IFpaServiceListener listener)
```

Registers an event listener for the FPA service,

#### Parameters

| Parameter     | Description                         |
| -------- | ---------------------------- |
| listener | [`IFpaServiceListener`](#ifpa-service-listener) object. |

#### Returns

None.

### `setOrUpdateHttpProxyChainConfig` method

```java
public int setOrUpdateHttpProxyChainConfig(@NonNull FpaHttpProxyChainConfig config)
```

Sets or updates a list of the acceleration IPs or domains and the corresponding chain IDs.

#### Parameters

| Parameters   | Description                                                                            |
| ------ | ------------------------------------------------------------------------------- |
| config | The mapping table between acceleration IPs or domains and the corresponding chain IDs. See [`FpaHttpProxyChainConfig`](#fpa-http-proxy-chain-config). |

#### Returns

| Returns | Description       |
| ------ | ---------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `setParameters` method

```java
public int setParameters(String param)
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
| < 0    | Failure. See [Error Codes](#error-code). |

### `getHttpProxyPort` method

```java
public int getHttpProxyPort()
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

```java
public int getTransparentProxyPort(FpaChainInfo info)
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

```java
public FpaProxyServiceDiagnosisInfo getDiagnosisInfo()
```

Gets diagnosis information.

#### Parameters

None.

#### Returns

[`FpaProxyServiceDiagnosisInfo`](#fpa-proxy-service-diagnosis-info) object.

### `getSdkVersion` method

```java
public static String getSdkVersion()
```

Gets the version of the SDK.

#### Parameters

None.

#### Returns

The version of the SDK.

### `getSdkBuildInfo` method

```java
public static String getSdkBuildInfo()
```

Gets the build information of the SDK.

#### Parameters

None.

#### Returns

The build information of the SDK.

<a id="fpa-proxy-service-config"></a>

## `FpaProxyServiceConfig` class

The `FpaProxyServiceConfig` class includes the following classes:

### `Builder` class

The `Builder` class includes the following methods:

#### `Builder` method

```java
public Builder(@NonNull String logFile)
```

Constructor of the `Builder` class.

##### Parameters

| Parameter          | Description                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| logFile       | The full path of the log file including the filename in string format. Make sure the path exists and is writable.                 |

##### Returns

A `Builder` object.

#### `build` method

Constructor of the `FpaProxyServiceConfig` class.

```java
public FpaProxyServiceConfig build()
```

##### Parameters

None.

##### Returns

An `FpaProxyServiceConfig` object.

#### `setAppId` method

```java
public Builder setAppId(String id)
```

Sets the App ID.

##### Parameters

| Parameter             | Description                                                                                                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id           | App ID to use Agora service. See [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).  |

##### Returns

A `Builder` object.

#### `setToken` method

```java
public Builder setToken(String token)
```

Sets the token.

##### Parameters

| Parameter             | Description                                                                                                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| token           |   Token generated from your app server for authentication. <ul><li>If your project uses **App ID** for authentication, you can assign the value of app ID to the `token` parameter. You can also assign `null` or `""` to this parameter or skip this parameter.</li><li> If your project uses **App ID + token** for authentication, you need to assign the token generated from your app server to this parameter.</li></ul>  |

##### Returns

A `Builder` object.

#### `setLogLevel` method

```java
public Builder setLogLevel(LogLevel level)
```

Sets the log level.

##### Parameters

| Parameter             | Description                                                                                                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| level           |   Log level. <ul><li>0: No logs.</li><li>1: Information.</li><li>2: Warning.</li><li>4: Error.</li><li>8: Fatal.</li></ul>  See [LogLevel](#loglevel). |

##### Returns

A `Builder` object.

#### `setLogFileSizeKb` method

```java
public Builder setLogFileSizeKb(int size)
```

Sets the size of the log file.

##### Parameters

| Parameter             | Description                                                                                                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| size           |   The maximum size of a single log file (KB). The default is 1024. If you set this parameter to 1024, the maximum size of the log files is 5 MB. If you set this parameter to a value less than 1024, the maximum size of a single log file is still 1024.

##### Returns

A `Builder` object.

<a id="fpa-http-proxy-chain-config"></a>

## `FpaHttpProxyChainConfig` class

The `FpaHttpProxyChainConfig` class includes the following classes:

### `Builder` class

The `Builder` class includes the following methods:

#### `Builder` method

```java
public Builder()
```

Constructor of the `Builder` class.

##### Parameters

None.

##### Returns

A `Builder` object.

#### `addChainInfo` method

```java
public Builder addChainInfo(int chainId, String address, int port, boolean enable)
```

Adds a mapping between the acceleration IP or domain and the chain ID.

##### Parameters

| Parameter          | Description                                                                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| chainId       | Chain ID of the acceleration chain.                                                                                                                                |
| address | IP of the source server for acceleration.                                                                                                                                    |
| port | Port of the source server for acceleration.                                                                                                                                        |
| enable   | Whether to fall back to local connection if FPA connection fails for this acceleration chain. <ul><li>`true`: Falls back to local connection.</li><li>`false`: Does not fall back to local connection.|

#### `fallbackWhenNoChainAvailable` method

```java
public Builder fallbackWhenNoChainAvailable(boolean can)
```

(For HTTP local proxy) Whether to fall back to local connection when the SDK cannot find the chain ID corresponding to the source server.

##### Parameters

| Parameter | Description                                                                                                        |
| ---- | ----------------------------------------------------------------------------------------------------------- |
| can  | <ul><li>`true`: Falls back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li><li>`false`: Does not fall back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li></ul> |

#### `build` method

```java
public FpaHttpProxyChainConfig build()
```

Consructor of the `FpaHttpProxyChainConfig` class.

##### Returns

An `FpaHttpProxyChainConfig` object.

<a id="fpa-chain-info"></a>

## `FpaChainInfo` class

Information of the acceleration chain.

### `FpaChainInfo` method

```java
public FpaChainInfo(int chain_id, String address, int port, boolean enable)
```

Constructor of the `FpaChainInfo` class.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| chainId        | Chain ID of the acceleration chain.                     |
| address | IP of the source server for acceleration.                                                                                                                                    |
| port | Port of the source server for acceleration.                                                                                                                                        |
| enable   | Whether to fall back to local connection if FPA connection fails for this acceleration chain. <ul><li>`true`: Falls back to local connection.</li><li>`false`: Does not fall back to local connection.|

#### Returns

An `FpaChainInfo` object.

<a id="fpa-proxy-connection-info"></a>

## `FpaProxyConnectionInfo` class

Information about the FPA proxy connection.

### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| dst_ip_or_domain  |  String  | IP or domain of the source server.     |
| proxy_type |  String  | Proxy type. <ul><li>`"http"`: HTTP proxy. </li><li>`"https"`: HTTPS proxy.</li><li>`"transport"`: TCP transparent proxy.</li></ul>    |
| connection_id |  String  | Connection ID. Each ID represents a connection from beginning to end between the SDK and the source server through the proxy.     |
| dest_port |  int  | Port of the source server.     |
| local_port |  int  | Port of the local proxy.   |

<a id="fpa-proxy-service-diagnosis-info"></a>

## `FpaProxyServiceDiagnosisInfo` class

The `FpaProxyServiceDiagnosisInfo` class includes the following parameters.

### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| installId  |  String  | The unique ID corresponding to the device that runs the app integrating the SDK. If you remove app cache, the SDK updates the installId.    |
| instanceId |  String  | The unique ID corresponding to the current `FpaProxyService` object.    |

<a id="ifpa-service-listener"></a>

## `IFpaServiceListener` interface

The `IFpaServiceListener` interface includes the following callbacks:

### `onConnected` callback

```java
default void onConnected(@Nullable FpaProxyConnectionInfo info) {
    }
```

Occurs when the SDK successfully connects to the FPA proxy.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).                        |

### `onAccelerationSuccess` callback

```java
default void onAccelerationSuccess(@Nullable FpaProxyConnectionInfo info) {
    }
```

Occurs when the acceleration succeeds.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |

### `onConnectionFailed` callback

```java
default void onConnectionFailed(@Nullable FpaProxyConnectionInfo info, FailedReason reason) {
    }
```

Occurs when the SDK fails to connect to the FPA proxy and the connection does not fall back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FailedReason](#failed-reason).                                                                                                     |

### `onDisconnectedAndFallback` callback

```java
default void onDisconnectedAndFallback(@Nullable FpaProxyConnectionInfo info, FailedReason reason) {
    }
```

Occurs when the SDK fails to connect to the FPA proxy and the connection falls back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FailedReason](#failed-reason).                                                                                                     |

<a id="error-code"></a>

## `ErrorCode` class

Synchronous error codes returned by the SDK.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FpaServiceErrorOK` |      0: No error.                                                                                                                     |
| `FpaServiceErrorInvalidArgument` |        -1: Invalid parameters. Check whether your parameters values are valid.               |
| `FpaServiceErrorNoMemory` |               -2: Cannot assign memory to the object.                                          |
| `FpaServiceErrorNotInitialized` |            -3：The FPA service is not initialized. Make sure you have initialized the SDK.                         |
| `FpaServiceErrorCoreInitializeFailed` |        -4: The FPA service fails to initialize.                                               |
| `FpaServiceErrorUnableBindSocketPort` |        -5: Cannot bind the internal socket port.                                      |

<a id="failed-reason"></a>

## `FailedReason` enum

Reasons of failure.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FPA_FAILED_REASON_DNS_QUERY` |      -101: DNS resolution error.                             |
| `FPA_FAILED_REASON_SOCKET_CREATE` |        -102: Failed to create an internal socket.                                   |
| `FPA_FAILED_REASON_SOCKET_CONNECT` |               -103: Failed to connect to the internal socket.                                                  |
| `FPA_FAILED_REASON_CONNECT_TIMEOUT` |            -104: Timeout when connecting to the remote server.                                                        |
| `FPA_FAILED_REASON_NO_CHAIN_ID_MATCH` |        -105: Cannot find the specified chain ID. Check whether you have configured the correct chain ID.                                              |
| `FPA_FAILED_REASON_DATA_READ` |        -106: Failed to read data.                                       |
| `FPA_FAILED_REASON_DATA_WRITE` |        -107: Failed to write data.                                      |
| `FPA_FAILED_REASON_TOO_FREQUENTLY` |        -108: The concurrent number of connections per each second exceeds 100.                             |
| `FPA_FAILED_REASON_TOO_MANY_CONNECTIONS` |        -109: The number of active connections exceeds 1,000.                                     |

<a id="loglevel"></a>

## `LogLevel` enum

Log level.

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `LOG_NO_LOG` |     0: No logs.                                                                                                                      |
| `LOG_INFO` |        1: Information.                                                                                               |
| `LOG_WARNING` |              2: Warning.                                                    |
| `LOG_ERROR` |           4: Error.                                                           |
| `LOG_FATAL` |        8: Fatal.                                              |
