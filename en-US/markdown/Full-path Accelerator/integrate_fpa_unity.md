This page describes how to implement the SDK acceleration mode.

In SDK acceleration mode, FPA automatically completes proximity scheduling from the client to the acceleration point IP address through the SDK.

## Usage flow

The basic usage flow of the FPA SDK is as follows:

![](https://web-cdn.agora.io/docs-files/1652695467904)

### Prerequisites

- Create an FPA service, and get the chain ID, domain/IP of the origin site, and port of the FPA service. For details, see [Enable FPA Service](enable_fpa). Ensure that the FPA service you have created is in SDK acceleration mode.
- Get the App ID. For details, see [Get the App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id).
- (Optional) Get an app certificate. For details, see [Get the App Certificate](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-certificate). If you do not enable token authentication for your project, you do not need to get an app certificate.
- (Optional) Generate a token on the app server. For details, see [Generate a token on the app server](#generate-token).

## SDK Workflow

The SDK supports acceleration through local HTTP proxies and local TCP transparent proxies.

The SDK does not validate proxy-bound domain names. You need to guarantee that the domain name is valid.

### Local HTTP proxy

The SDK converts the HTTP request sent by the app through the HTTP library and the HTTP response returned by the origin server into a private protocol connection between the FPA SDK and the Agora server by means of a local HTTP proxy, so as to realize the acceleration based on the HTTP protocol.

![](https://web-cdn.agora.io/docs-files/1652695486454)

The HTTP library needs to support settings to modify the HTTP proxy to send requests.

### TCP transparent proxy

The SDK uses a local TCP transparent proxy to convert the TCP connection established by the app through the socket library into a private protocol connection between the FPA SDK and the Agora server, thus achieving TCP protocol-based acceleration.

![](https://web-cdn.agora.io/docs-files/1652695492642)

<a name="Integrate"></a>

### Integrate the SDK

Your Unity version needs to be 2017 or higher. The FPA Unity SDK only supports mobile devices.

1. Download the latest [Agora FPA Unity SDK resource package](https://github.com/AgoraIO-Community/Agora-Unity-FPA-SDK/releases).
2. In the Unity Editor, select **Assets** > **Import Package** > **Custom Package**.
3. Select the downloaded resource package and click **Open**.
4. Deselect plugins that you do not need and click **Import**. All plugins included in the SDK are selected by default.

<a id="init_sdk"></a>

## Initialize the SDK and start the FPA service

You must initialize the SDK and enable the FPA service before using the SDK for acceleration. The Agora FPA Unity SDK provides C# API for you to integrate by using Unity Script.

1. Make sure to import the following namespaces in your project:

   ```csharp
   using agora.fpa;
   using agora.util;
   ```

2. Create an `FpaProxyServiceConfig` object, and set the relevant parameters such as App ID, token, and log:

   ```csharp
   FpaProxyServiceConfig config = new FpaProxyServiceConfig();
   // Sets App ID
   config.app_id = “<Your App ID>”;
   // Sets the token. If token authentication is not enabled, you do not need to call setToken ()
   config.token = “<Your Token>”;
   ```

3. Call `InitEventHandler` to set up the proxy callback listener, and call `Start` to start the FPA service:

   ```csharp
   internal IAgoraFpaProxyService _mFpaProxyService = null;

   _mFpaProxyService = AgoraFpaProxyService.CreateAgoraFpaProxyService();

   // Set proxy event callback listener
   _mFpaProxyService.InitEventHandler(new UserEventHandler(this));

   //  Start FPA service
   var ret = _mFpaProxyService.Start(config);
   ```

4. Get the FPA service status by using the following callbacks: `OnAccelerationSuccess`, `OnConnected`, `OnDisconnectedAndFallback`, and `OnConnectionFailed`.

   ```csharp
   internal class UserEventHandler : IAgoraFpaProxyServiceEventHandler
      {
         private readonly FpaServiceSample _serviceSample;

         internal UserEventHandler(FpaServiceSample serviceSample)
         {
               _serviceSample = serviceSample;
         }

               public override void OnAccelerationSuccess(FpaProxyConnectionInfo info)
         {
               // FPA proxy acceleration success. Implement your logic here.
               _serviceSample.Logger.UpdateLog(string.Format("OnAccelerationSuccess FpaProxyConnectionInfo connection_id: {0}, dst_ip_or_domain: {1}, dst_port: {2}, local_port: {3}, proxy_type: {4}",
               connection_info.connection_id, connection_info.dst_ip_or_domain, connection_info.dst_port, connection_info.local_port, connection_info.proxy_type));
         }

               public override void OnConnected(FpaProxyConnectionInfo info)
         {
               // Successfully connected to the FPA proxy. Implement your logic here.
               _serviceSample.Logger.UpdateLog(string.Format("OnConnected FpaProxyConnectionInfo connection_id: {0}, dst_ip_or_domain: {1}, dst_port: {2}, local_port: {3}, proxy_type: {4}",
               connection_info.connection_id, connection_info.dst_ip_or_domain, connection_info.dst_port, connection_info.local_port, connection_info.proxy_type));
         }

               public override void OnDisconnectedAndFallback(FpaProxyConnectionInfo info, FPA_FAILED_REASON_CODE reason)
         {
               // Failed to connect to FPA proxy. Fall back to local connection. Implement your logic here.
               _serviceSample.Logger.UpdateLog(string.Format("OnDisconnectedAndFallback FpaProxyConnectionInfo connection_id: {0}, dst_ip_or_domain: {1}, dst_port: {2}, local_port: {3}, proxy_type: {4} FPA_FAILED_REASON_CODE: {5}",
               connection_info.connection_id, connection_info.dst_ip_or_domain, connection_info.dst_port, connection_info.local_port, connection_info.proxy_type, FPA_FAILED_REASON_CODE));
         }

               public override void OnConnectionFailed(FpaProxyConnectionInfo info, FPA_FAILED_REASON_CODE reason)
         {
               // The connection to the FPA proxy failed and did not fall back. Implement your logic here.
               _serviceSample.Logger.UpdateLog(string.Format("OnConnectionFailed FpaProxyConnectionInfo connection_id: {0}, dst_ip_or_domain: {1}, dst_port: {2}, local_port: {3}, proxy_type: {4} FPA_FAILED_REASON_CODE: {5}",
               connection_info.connection_id, connection_info.dst_ip_or_domain, connection_info.dst_port, connection_info.local_port, connection_info.proxy_type, FPA_FAILED_REASON_CODE));
         }
      }
   ```

## Implement a local HTTP proxy

This section takes the `HttpWebRequest` class and `WebProxy` class from the `System.Net` namespace as an example to process HTTP requests and responses through the SDK. You can also use other HTTP libraries that support modifying HTTP proxies.

<div class="alert warning">You must use an HTTP library that supports configuring proxies, such as <code>System.Net</code>. The native network library, <code>UnityWebRequest</code>, does not support proxies and cannot be used with the FPA Unity SDK.</div>

### Prerequisites

- You have completed the SDK initialization and started the FPA service. For details, see <a href="#init_sdk">Initialize the SDK and start the FPA service</a>.

### Implementation steps

1. Call the `SetOrUpdateHttpProxyChainConfig` method to set the mapping table of the origin IP address or domain name to the chain ID.

    ```csharp
    // Sets the chain ID of the FPA service, such as 123
    // Sets the origin site IP address or domain name
    // Sets the origin site port, such as 80
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    private FpaChainInfo _fpaChainInfo = new FpaChainInfo("<Your IP or domain>", 80, 123, true);

    FpaHttpProxyChainConfig http_config = new FpaHttpProxyChainConfig();
    http_config.chain_array = new FpaChainInfo[1]{_fpaChainInfo};
    http_config.chain_array_size = 1;
    // Sets whether to roll back to a local connection if the HTTP local agent cannot find the chain ID corresponding to the source site in the FPA SDK
    http_config.fallback_when_no_chain_available = true;

    ret = _mFpaProxyService.SetOrUpdateHttpProxyChainConfig(http_config);
    ```

2. Call the `GetHttpProxyPort` method to get HTTP proxy ports.

    ```csharp
    // Initializes the http_proxy_port variable.
    ushort http_proxy_port = 0;
    // Calls GetHttpProxyPort to assign the value of the port to the http_proxy_port variable by reference.
    _mFpaProxyService.GetHttpProxyPort(ref http_proxy_port);
    ```

3. Create a `WebProxy` object and set the port to the value of the `http_proxy_port` variable.

    ```csharp
    int32_http_proxy_port = Convert.ToInt32(http_proxy_port);
    WebProxy proxyObject = new WebProxy("127.0.0.1", int32_http_proxy_port);
    HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;

    request.Proxy = proxyObject;
    ```

## Implement TCP transparent proxy

This section uses the `TcpClient` class from the `System.Net.Sockets` namespace as an example to handle socket requests and responses through the SDK. You can also use other socket libraries to implement transparent proxy functionality.

### Prerequisites

- You have completed the SDK initialization and enabled the FPA service. For details, see [Initializing the SDK and starting the FPA service](#init_sdk).

### Implementation steps

1. Call the `GetTransparentProxyPort` method to get the port of the transparent proxy.

    ```csharp
    // Initializes the tcp_proxy_port variable.
    ushort tcp_proxy_port = 0;

    // Sets the chain ID of the FPA service, such as 123
    // Sets the origin site domain name or IP
    // Sets the origin port via the port parameter, such as 80
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    private FpaChainInfo _fpaChainInfo = new FpaChainInfo("<Your IP or domain>", 80, 123, true);

    // Calls GetTransparentProxyPort to get the port of the transparent proxy
    // In the production environment, Agora recommends that you add logic here to avoid FPA proxy when tcp_proxy_port <= 0
    var ret = _mFpaProxyService.GetTransparentProxyPort(ref tcp_proxy_port, _fpaChainInfo);
    ```

2. Connect to the transparent proxy with the obtained port.

   ```csharp
   int32_tcp_proxy_port = Convert.ToInt32(tcp_proxy_port);
   TcpClient client = new TcpClient("127.0.0.1", int32_tcp_proxy_port);
   ```

After a successful connection, socket data can be sent and received through the transparent proxy.

## References

### Considerations

- If the app is switched to the background, you need to keep it alive.
- For the iOS platform, the FPA Flutter SDK checks the connection status and resets proxy ports when acceleration is unavailable. For example, when you switch an app back to foreground after the iOS device remains locked for a while, the ports of the HTTP client and the TCP transparent client may change. Agora recommends that you call `GetHttpProxyPort` or `GetTransparentProxyPort` to get the latest ports every time you start an HTTP or TCP connection request.
- You can set the SDK log file path using the `FpaProxyServiceConfig.logFilePath` method.

### API Reference

[Unity SDK API reference](./fpa_unity_api)

<a id="generate-token"></a>

### Generate a token on the app server

You need to deploy the token generator on the app server yourself.

If your Agora project is in secure mode: **APP ID+Token**, you must use token authentication. If it is in **debug mode: APP ID**, you cannot use token authentication.

The following figure shows the basic logic of Token authentication:

![](https://web-cdn.agora.io/docs-files/1652695515901)

1. The client sends a request to the app server to request a token.
2. The token generator in the app server generates and returns the token.
3. The client SDK initializes the SDK with the App ID and token.
4. The FPA server verifies the app ID and token. After the verification is successful, the FPA server connects to the App client.

If you do not enable token authentication for your project, you do not need to generate a token on the app server.

### Token generator code

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey) repository on GitHub:

| Language | Encryption Algorithms | Core Classes | Generating Examples |
| --------- | ------------ | --------- | ------------ |
| C++ | HMAC-SHA256 | [FpaTokenBuilder](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/FpaTokenBuilder.h) | [FpaTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/sample/FpaTokenBuilderSample.cpp) |
| Python | HMAC-SHA256 | [FpaTokenBuilder](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python3/src/fpa_token_builder.py) | [fpa_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python3/sample/fpa_token_builder_sample.py) |

### API Reference

This section describes the API parameters and descriptions for generating tokens. Take C++ as an example:

```c++
static std::string BuildToken(
       const std::string& app_id,
       const std::string& app_certificate);
```

| Parameter | Description |
| --------- | ------------ |
| `app_id` | The app ID you generated when you created the project in Agora console. |
|`app_certificate` | App certificate for your project. |

You must use the token for link acceleration within 24 hours of its generation; otherwise it expires. After the token expires, you cannot use this token for acceleration. You need to request the token server to generate a new token and use the new token for acceleration.

Once you have successfully used the token for acceleration, the FPA service based on this token continues to be available until the SDK is destroyed. Agora recommends that you obtain a new token from the token server for acceleration before each SDK initialization to avoid service unavailability due to token expiration.

### Build Example

The following C++ sample code shows how to generate an FPA token using the `FpaTokenBuilder` class.

```c++
#include <iostream>

#include "../src/FpaTokenBuilder.h"

using namespace agora::tools;

int main(int argc, char const *argv[]) {
 (void)argc;
 (void)argv;
  // Your app ID
  std::string app_id = "970CA35de60c44645bbae8a215061b33";
  // Your app certificate
  std::string app_certificate = "5CFd2fd1755d40ecb72977518be15d3b";

  std::string result;
  // Generate FPA token
  result = FpaTokenBuilder::BuildToken(app_id, app_certificate);
  std::cout << "Token with FPA service:" << result << std::endl;

}
```
