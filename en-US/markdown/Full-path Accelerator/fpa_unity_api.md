The `agora.fpa` namespace includes the following members:

## `IAgoraFpaProxyService` class

`IAgoraFpaProxyService` includes the following methods:

### `Dispose` method

```cs
public abstract void Dispose(bool sync = false);
```

Releases the `IAgoraFpaProxyService` object.

#### Returns

None.

### `Start` method

```cs
public abstract int Start(FpaProxyServiceConfig config);
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

### `Stop` method

```cs
public abstract int Stop();
```

Stops the FPA service.

#### Parameters

None.

#### Returns

| Returns| Description                             |
| ------ | -------------------------------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `InitEventHandler` method

```cs
public abstract void InitEventHandler(IAgoraFpaProxyServiceEventHandler serviceEventHandler);
```

Registers an event listener for the FPA service,

#### Parameters

| Parameter     | Description                         |
| -------- | ---------------------------- |
| serviceEventHandler | An [`IAgoraFpaProxyServiceEventHandler`](#ifpa-service-listener) object. |

#### Returns

None.

### `SetOrUpdateHttpProxyChainConfig` method

```cs
public abstract int SetOrUpdateHttpProxyChainConfig(FpaHttpProxyChainConfig config);
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
| < 0    | Failure. See [FpaError](#error-code). |

### `SetParameters` method

```cs
public abstract int SetParameters(string parameters);
```

Configures technical preview or custom features by using JSON strings.

JSON strings are not public by default.

#### Parameters

| Parameter  | Description                    |
| ----- | ----------------------- |
| parameters | Value in JSON string format. |

#### Returns

| Returns | Description       |
| ------ | ---------- |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `GetHttpProxyPort` method

```cs
public abstract int GetHttpProxyPort(ref ushort port);
```

Gets the port of the HTTP proxy.

#### Parameters

| Parameter  | Description                    |
| ----- | ----------------------- |
| port | The port of the HTTP proxy. |

#### Returns

| Returns | Description                           |
| ------ | ------------------------------ |
| > 0    | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `GetTransparentProxyPort` method

```cs
public abstract int GetTransparentProxyPort(ref ushort proxy_port, FpaChainInfo info);
```

Gets the port of the transparent proxy.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| proxy_port | The port of the TCP proxy. |
| info        | Information about the acceleration chain. See [`FpaChainInfo`](#fpa-chain-info).                  |

#### Returns

| Returns | Description                           |
| ------ | ------------------------------ |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |

### `GetDiagnosisInfo` method

```cs
public abstract int GetDiagnosisInfo(out FpaProxyServiceDiagnosisInfo info);
```

Gets diagnosis information.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| info | An [`FpaProxyServiceDiagnosisInfo`](#fpa-proxy-service-diagnosis-info) object. |


#### Returns

| Returns | Description                           |
| ------ | ------------------------------ |
| 0      | Success. |
| < 0    | Failure. See [Error codes](#error-code). |


### `GetAgoraFpaProxyServiceSdkVersion` method

```cs
public abstract string GetAgoraFpaProxyServiceSdkVersion();
```

Gets the version of the SDK.

#### Parameters

None.

#### Returns

The version of the SDK.

### `GetAgoraFpaProxyServiceSdkBuildInfo` method

```cs
public abstract string GetAgoraFpaProxyServiceSdkBuildInfo();
```

Gets the build information of the SDK.

#### Parameters

None.

#### Returns

The build information of the SDK.

<a id="fpa-proxy-service-config"></a>

## `FpaProxyServiceConfig` class

The `FpaProxyServiceConfig` class includes the following members:

### `FpaProxyServiceConfig` method

```cs
public FpaProxyServiceConfig(string app_id, string token, int log_level, int log_file_size_kb, string log_file_path)
```

Constructor of the `FpaProxyServiceConfig` class.

#### Parameters

| Parameter          | Description                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| app_id           | App ID to use Agora service. See [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).  |
| token           |   Token generated from your app server for authentication. <ul><li>If your project uses **App ID** for authentication, you can assign the value of app ID to this parameter. You can also assign `null` or `""` to this parameter or skip this parameter.</li><li> If your project uses **App ID + token** for authentication, you need to assign the token generated from your app server to this parameter.</li></ul>  |
| log_level           |   Log level. <ul><li>0: No logs.</li><li>1: Information.</li><li>2: Warning.</li><li>4: Error.</li><li>8: Fatal.</li></ul>  |
| log_file_size_kb           |   The maximum size of a single log file (KB). The default is 1024. If you set this parameter to 1024, the maximum size of the log files is 5 MB. If you set this parameter to a value less than 1024, the maximum size of a single log file is still 1024.|
| log_file_path       | The full path of the log file including the filename in string format. Make sure the path exists and is writable.                 |

#### Returns

An `FpaProxyServiceConfig` object.

<a id="fpa-http-proxy-chain-config"></a>

## `FpaHttpProxyChainConfig` class

The `FpaHttpProxyChainConfig` class includes the following members:

### `FpaHttpProxyChainConfig` method

```cs
public FpaHttpProxyChainConfig(FpaChainInfo[] chain_array, int chain_array_size, bool fallback_when_no_chain_available)
```

Constructor of the `FpaHttpProxyChainConfig` class.

#### Parameters

| Parameter          | Description                                                                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| chain_array       | An array of `FpaChainInfo` objects. See [`FpaChainInfo`](#fpa-chain-info).                                        |
| chain_array_size       | Size of the array.                                        |
| fallback_when_no_chain_available   | Whether to fall back to local connection when the SDK cannot find the chain ID corresponding to the source server. <ul><li>`true`: Falls back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li><li>`false`: Does not fall back to local connection when the SDK cannot find the chain ID corresponding to the source server.</li></ul>|


#### Returns

An `FpaHttpProxyChainConfig` object.

<a id="fpa-chain-info"></a>

## `FpaChainInfo` class

This class includes the following members:

### `FpaChainInfo` method

```cs
public FpaChainInfo(string address, int port, int chain_id, bool enable_fallback)
```

Constructor of the `FpaChainInfo` class.

#### Parameters

| Parameter           | Description                                      |
| -------------- | ----------------------------------------- |
| address | IP of the source server for acceleration.         |
| port | Port of the source server for acceleration.              |
| chain_id        | Chain ID of the acceleration chain.                     |
| enable_fallback   | Whether to fall back to local connection if FPA connection fails for this acceleration chain. <ul><li>`true`: Falls back to local connection.</li><li>`false`: Does not fall back to local connection.|

#### Returns

An `FpaChainInfo` object.

<a id="fpa-proxy-connection-info"></a>

## `FpaProxyConnectionInfo` class

Information about the FPA proxy connection.

### `FpaProxyConnectionInfo` method

```cs
public FpaProxyConnectionInfo(string dst_ip_or_domain, string connection_id, string proxy_type, int dst_port, int local_port)
```

Constructor of the `FpaProxyConnectionInfo` class.

#### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| dst_ip_or_domain  |  String  | IP or domain of the source server.     |
| connection_id |  String  | Connection ID. Each ID represents a connection from beginning to end between the SDK and the source server through the proxy.     |
| proxy_type |  String  | Proxy type. <ul><li>`"http"`: HTTP proxy. </li><li>`"https"`: HTTPS proxy.</li><li>`"transport"`: TCP transparent proxy.</li></ul>    |
| dst_port |  Integer  | Port of the source server.     |
| local_port |  Integer  | Port of the local proxy.   |

#### Returns

An `FpaProxyConnectionInfo` object.

<a id="fpa-proxy-service-diagnosis-info"></a>

## `FpaProxyServiceDiagnosisInfo` class

The `FpaProxyServiceDiagnosisInfo` class includes the following parameters.

```cs
public FpaProxyServiceDiagnosisInfo(string install_id, string instance_id)
```

### FpaProxyServiceDiagnosisInfo method

Constructor of the `FpaProxyServiceDiagnosisInfo` class.

#### Parameters

| Parameter       | Data type  | Description |
| ---------- | ---| ---- |
| install_id  |  String  | The unique ID corresponding to the device that runs the app integrating the SDK. If you remove the app cache, the SDK updates the installId.    |
| instance_id |  String  | The unique ID corresponding to the current `IFpaProxyService` object.    |

#### Returns

An `FpaProxyConnectionInfo` object.

<a id="ifpa-service-listener"></a>

## `IAgoraFpaProxyServiceEventHandler` class

The `IAgoraFpaProxyServiceEventHandler` class includes the following callbacks:

### `OnConnected` callback

```cs
public virtual void OnConnected(FpaProxyConnectionInfo info) { }
```

Occurs when the SDK successfully connects to the FPA proxy.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).                        |

### `OnAccelerationSuccess` callback

```cs
public virtual void OnAccelerationSuccess(FpaProxyConnectionInfo info) { }
```

Occurs when the acceleration succeeds.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |

### `OnConnectionFailed` callback

```cs
public virtual void OnConnectionFailed(FpaProxyConnectionInfo info, FPA_FAILED_REASON_CODE reason) { }
```

Occurs when the SDK fails to connect to the FPA proxy and the connection does not fall back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FPA_FAILED_REASON_CODE](#failed-reason).                                                                                                     |

### `OnDisconnectedAndFallback` callback

```cs
public virtual void OnDisconnectedAndFallback(FpaProxyConnectionInfo info, FPA_FAILED_REASON_CODE reason) { }
```

Occurs when the SDK fails to connect to the FPA proxy and the connection falls back to local connection.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| info | Connection information of the FPA proxy. See [`FpaProxyConnectionInfo`](#fpa-proxy-connection-info).            |
| reason | Reason of the failure. See [FPA_FAILED_REASON_CODE](#failed-reason).                                                                                                     |


<a id="error-code"></a>

## `FPA_ERROR_CODE` enum

Synchronous error codes returned by the SDK.

#### Parameters

| Parameter      | Description                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FPA_ERR_NONE` |      0: No error.                                                                                                                     |
| `FPA_ERR_INVALID_ARGUMENT` |        -1: Invalid parameters. Check whether your parameters values are valid.               |
| `FPA_ERR_NO_MEMORY` |               -2: Cannot assign memory to the object.                                          |
| `FPA_ERR_NOT_INITIALIZED` |            -3：The FPA service is not initialized. Make sure you have initialized the SDK.                         |
| `FPA_ERR_CORE_INITIALIZE_FAILED` |        -4: The FPA service fails to initialize.                                               |
| `FPA_ERR_UNABLE_BIND_SOCKET_PORT` |        -5: Cannot bind the internal socket port.                                      |

<a id="failed-reason"></a>

## `FpaProxyServiceReasonCode` enum

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
