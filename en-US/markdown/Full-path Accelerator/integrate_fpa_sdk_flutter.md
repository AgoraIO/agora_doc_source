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

## Integrate the SDK

### Development environment requirements

If your target platform is iOS, your development environment must meet the following requirements:

- Flutter 1.2.0 or higher
- Dart 2.12.0 or higher
- macOS operating system
- Xcode (Latest version recommended)

If your target platform is Android, your development environment must meet the following requirements:

- Flutter 1.2.0 or higher
- Dart 2.12.0 or higher
- macOS or Windows operating system
- Xcode (Latest version recommended)

### Deployment environment requirements

The FPA Flutter SDK only supports mobile devices.

- If your target platform is iOS, you need an iOS device or simulator.
- If your target platform is Android, you need an Android device or simulator.

<div class="alert note">Run <code>flutter doctor</code> to check the development and deployment environment.</div>

### Integrate the SDK

Add the following dependency in the `pubspec.yaml` file of the Flutter project.

Add the `agora_fpa_service` dependency to integrate the Agora Flutter SDK. See [pub.dev](https://pub.dev/packages/agora_fpa_service) for the latest version of `agora_fpa_service`.

```yaml
environment:
  sdk: ">=2.12.0 <3.0.0"

# Dependencies
dependencies:
  flutter:
    sdk: flutter

  #  FPA Flutter SDK dependency. Please use the latest version of agora_fpa_service.
  agora_fpa_service: ^1.0.0
```

<a id="init_sdk"></a>

## Initialize the SDK and start the FPA service

You must initialize the SDK and enable the FPA service before using the SDK for acceleration.

1. Make sure to import the following package in your Flutter project:

   ```dart
   import 'package:agora_fpa_service/agora_fpa_service.dart';
   ```

2. Create an `FpaProxyServiceConfig` object, and set the relevant parameters such as App ID, token, and log:

   ```dart
   // Sets the log file path by using getApplicationDocumentsDirectory
   late String _logFilePath;
   final externalStorage = await getApplicationDocumentsDirectory();
   _logFilePath = path.join(externalStorage.absolute.path, 'agora', 'fp_log_sdk.log');

   FpaProxyServiceConfig fpaConfig = FpaProxyServiceConfig(
     // Sets the App ID
     appId: '<Your App ID>',
     // Sets the token. If token authentication is not enabled, you do not need to set the token
     token: '<Your token>',
     // Set log file size in KB
     logFileSizeKb: 1024,
     // Sets log level
     logLevel: FpaProxyServiceLogLevel.error,
     // Sets log file location
     logFilePath: _logFilePath,
   );
   ```

3. Call `setObserver` to set up the proxy callback listener, and start the FPA service:

   ```dart
   // Sets proxy event callback listener
   FpaProxyService.instance.setObserver(this);

    try {
      FpaProxyService.instance.start(fpaConfig);
    } on FpaProxyServiceException catch (e) {
      _logSink.sink('start', 'with exception: ${e.toString()}');
      return;
    }
   ```

4. Get the FPA service status by using the following callbacks: `onAccelerationSuccess`, `onConnected`, `onDisconnectedAndFallback`, and `onConnectionFailed`.

    ```dart
    @override
    void onAccelerationSuccess(FpaProxyConnectionInfo info) {
        // Successfully connected to the FPA proxy. Implement your logic here.
        _logSink.sink('onAccelerationSuccess', 'info: ${info.toString()}');
    }

    @override
    void onConnected(FpaProxyConnectionInfo info) {
        // FPA proxy acceleration success. Implement your logic here.
        _logSink.sink('onConnected', 'info: ${info.toString()}');
    }

    @override
    void onConnectionFailed(
        FpaProxyConnectionInfo info, FpaProxyServiceReasonCode reason) {
        // The connection to the FPA proxy failed and did not fall back. Implement your logic here.
        _logSink.sink(
        'onConnectionFailed', 'info: ${info.toString()}, reason: $reason');
    }

    @override
    void onDisconnectedAndFallback(
        FpaProxyConnectionInfo info, FpaProxyServiceReasonCode reason) {
        // Failed to connect to FPA proxy. Fall back to local connection. Implement your logic here.
        _logSink.sink('onDisconnectedAndFallback',
            'info: ${info.toString()}, reason: $reason');
    }
    ```

## Implement a local HTTP proxy

This section takes the dio library as an example to process HTTP requests and responses through the SDK. You can also use other HTTP libraries that support modifying HTTP proxies.

### Prerequisites

- You have completed the SDK initialization and started the FPA service. For details, see <a href="#init_sdk">Initialize the SDK and start the FPA service</a>.
- You have integrated [dio](https://github.com/flutterchina/dio) in your Android project.

### Implementation steps

1. Call the `setOrUpdateHttpProxyChainConfig` method to set the mapping table of the origin IP address or domain name to the chain ID.

    ```dart
    FpaHttpProxyChainConfig chainConfig = FpaHttpProxyChainConfig(
    // Sets the mapping table of IP/domain to chain ID
    chainArray: [
        FpaChainInfo(
        // Sets the chain ID of the FPA service, such as 123
        chainId: 123,
        // Sets the origin site IP address or domain name
        address: '<Your domain or IP>',
        // Sets the origin site port, such as 80
        port: 80,
        // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
        enableFallback: true,
        ),
    ],
    // Sets whether to roll back to a local connection if the HTTP local agent cannot find the chain ID corresponding to the source site in the FPA SDK
    fallbackWhenNoChainAvailable: true,
    );

    // Call setOrUpdateHttpProxyChainConfig to implement the configurations
    FpaProxyService.instance.setOrUpdateHttpProxyChainConfig(chainConfig);
    ```

2. Configure the local proxy of HttpClient in the `onHttpClientCreate` callback. This configuration takes effect for the `_dio` instance.

    ```dart
    // Create a Dio object
    _dio = Dio();

    // Gets the port of the FPA SDK local proxy 
    _fpaPort = FpaProxyService.instance.getHttpProxyPort();

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
        // Returns "PROXY $kBaseHost:$port"
        // The value of kBaseHost is "127.0.0.1"
        // The value of port is the port of the FPA SDK local proxy 
        client.findProxy = (uri) {
            return 'PROXY ${FpaProxyService.kLocalHost}:$_fpaPort';
        };
        };
    ```

After configuration, you can use the `_dio` instance to send and receive HTTP requests.

## Implement TCP transparent proxy

This section uses the `Socket` class from the `dart:io` library as an example to handle socket requests and responses through the SDK. You can also use other socket libraries to implement transparent proxy functionality.

### Prerequisites

- You have completed the SDK initialization and enabled the FPA service. For details, see [Initializing the SDK and starting the FPA service](#init_sdk).

### Implementation steps

1. Call the `getTransparentProxyPort` method to get the transparent proxy port.

    ```dart
    FpaChainInfo chainInfo = FpaChainInfo(
        // Sets the chain ID of the FPA service, such as 123
        chainId: 123,
        // Sets the origin site domain name or IP
        address: '<Your domain or IP>',
        // Sets the origin port via the port parameter, such as 80
        port: 80,
        // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
        enableFallback: true,
        );

    // Calls getTransparentProxyPort to get the port of the transparent proxy
    // In the production environment, Agora recommends that you add logic here to avoid FPA proxy when _port <= 0
    int _port = FpaProxyService.instance.getTransparentProxyPort(chainInfo);
    ```

2. Connect to the transparent proxy with the obtained port.

    ```dart
    late final Socket socket;
    try {
    socket = await Socket.connect(FpaProxyService.kLocalHost, _port);
    } catch (e) {
    _logSink.sink(
        'TransparentProxy',
        'Error in connect socket: ${e.toString()}',
    );
    }
    ```

After a successful connection, socket data can be sent and received through the transparent proxy.

## References

### Considerations

- If the app is switched to the background, you need to keep it alive.
- For the iOS platform, the FPA Flutter SDK checks the connection status and resets proxy ports when acceleration is unavailable. For example, when you switch an app back to foreground after the iOS device remains locked for a while, the ports of the HTTP client and the TCP transparent client may change. Agora recommends that you call `httpProxyPort` or `getTransparentProxyPortWithChainInfo` to get the latest ports every time you start an HTTP or TCP connection request.
- You can set the SDK log file path using the `FpaProxyServiceConfig.logFilePath` method.

### API Reference

[Flutter SDK API reference](./fpa_flutter_api)

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
