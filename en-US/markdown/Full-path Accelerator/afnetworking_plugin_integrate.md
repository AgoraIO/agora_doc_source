This page describes how to implement SDK acceleration mode.

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

Refer to the following steps to integrate the FPA iOS SDK by using CocoaPods.

<div class="alert info">FPA iOS SDK supports iOS 9 or higher.</div>

1. Before you start, make sure you have installed CocoaPods. See [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) for more information.

2. In your terminal, navigate to the root folder of your iOS project and run `pod init` to generate a `Podfile` file in the same folder.

3. Open the `Podfile` file and edit the content as the following text. Make sure to update `Your App` with the name of your own app.

    ```pod
    # platform :ios, '9.0'
    target 'Your App' do
    pod 'AgoraFPA_iOS', '~> 1.0.0'
    end
    ```

4. Run `pod install` to install the SDK. If the installation is successful, the terminal displays `Pod installation complete!`.

5. Open the generated `xcworkspace` file.

If you need to integrate the SDK using offline files, see [Other integration methods](#other-integration).

<a id="init_sdk"></a>

## Initialize the SDK and start the FPA service

You must initialize the SDK and enable the FPA service before using the SDK for acceleration.

1. Make sure to import the following classes in your project:

    ```objective-c
    #import <AgoraFpaProxyService/FpaProxyService.h>
    ```

2. Create an `FpaProxyServiceConfig` object, and set the relevant parameters such as App ID, token, and log:

    ```objective-c
    FpaProxyServiceConfig *config = [[FpaProxyServiceConfig alloc] init];
    // Sets App ID
    config.appId = @"<Your App ID>";
    // Sets the token. If token authentication is not enabled, you do not need to set the token
    config.token = @"<Your token>";
    // Sets log level
    config.logLevel = FpaLogLevelInfo;
    // Sets log file location
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *logFile = [NSString stringWithFormat:@"%@/fpa.log",docDir];
    config.logFilePath = logFile;
    // Set log file size
    config.fileSize = 1024;
    ```

3. Set up the proxy callback listener, and start the FPA service:

    ```objective-c
    // Sets proxy event callback listener
    [[FpaProxyService sharedFpaProxyService] setupDelegate:(id<FpaProxyServiceDelegate>)self];
    // Start FPA service
    [[FpaProxyService sharedFpaProxyService] startWithConfig:config];
    ```
  
4. Get the FPA service status by using the following callbacks: `onAccelerationSuccess`, `onConnected`, `onDisconnectedAndFallback`, and `onConnectionFailed`.

    ```objective-c
    - (void)onAccelerationSuccess:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo {
            // Successfully connected to the FPA proxy
        }
    
    - (void)onConnected:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo {
        // FPA proxy acceleration success
        }
    
    - (void)onDisconnectedAndFallback:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo reason:(FpaFailedReason)reason {
        // The connection to the FPA proxy failed and did not fall back
        }
    
    - (void)onConnectionFailed:(FpaProxyServiceConnectionInfo * _Nonnull)connectionInfo reason:(FpaFailedReason)reason {
        // Failed to connect to FPA proxy. Fall back to local connection.
        }
    ```

## Implement a local HTTP proxy

This section takes the AFNetworking library as an example to process HTTP requests and responses through the SDK. You can also use other HTTP libraries that support modifying HTTP proxies.

### Prerequisites

- You have completed the SDK initialization and started the FPA service. For details, see <a href="#init_sdk">Initialize the SDK and start the FPA service</a>.
- You have integrated [AFNetworking](https://github.com/AFNetworking/AFNetworking) in your Android project.

### Implementation steps

1. Call the `setOrUpdateHttpProxyChainConfig` method to set the mapping table of the origin IP address or domain name to the chain ID.

    ```objective-c
    FpaHttpProxyChainConfig *httpConfig = [[FpaHttpProxyChainConfig alloc] init];
    NSMutableArray *array = [NSMutableArray array];

    // Sets the chain ID of the FPA service, such as 123
    // Sets the origin IP address or domain name
    // Sets the origin port, such as 80
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    FpaChainInfo *info = [FpaChainInfo fpaChainInfoWithChainId:201 address:@"<Your domain or IP>" port:30113 enableFallback:YES];
    [array addObject:info];
    httpConfig.chainArray = [array copy];
    // Sets whether to roll back to a local connection if the HTTP local agent cannot find the chain ID corresponding to the source site in the FPA SDK
    httpConfig.fallbackWhenNoChainAvailable = YES;
    // Calls setOrUpdateHttpProxyChainConfig to apply the configuration
    [[FpaProxyService sharedFpaProxyService] setOrUpdateHttpProxyChainConfig:httpConfig];
    ```

2. Create a `NSURLSessionConfiguration` object and set the `connectionProxyDictionary` property.

    ```objective-c
    // Create a NSURLSessionConfiguration object
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    // Configure the connectionProxyDictionary property and set the proxy of NSURLSessionConfiguration to the internal HTTP proxy provided by FpaProxyService 
    configuration.connectionProxyDictionary = @{
            // Binds the okHttpClient object to the internal HTTP proxy provided by FpaProxyService. In the production environment, Agora recommends that you add logic here to avoid FPA proxy when httpProxyPort<=0
            (id)kCFNetworkProxiesHTTPEnable:@YES,
            (id)kCFNetworkProxiesHTTPProxy:@"127.0.0.1",
            (id)kCFNetworkProxiesHTTPPort:@([[FpaProxyService sharedFpaProxyService] httpProxyPort]),
            // Binds the okHttpClient object to the internal HTTPS proxy provided by FpaProxyService. In the production environment, Agora recommends that you add logic here to avoid FPA proxy when httpProxyPort<=0
            @"HTTPSEnable":@YES,
            @"HTTPSProxy":@"127.0.0.1",
            @"HTTPSPort":@([[FpaProxyService sharedFpaProxyService] httpProxyPort]),
        };
    ```

3. Use the `NSURLSessionConfiguration` object created in the previous step to create and initialize the `AFHTTPSessionManager` object.

    ```objective-c
    // Create an AFHTTPSessionManager object. The session configuration uses the NSURLSessionConfiguration object created in the previous step.
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    ```

After getting the `AFHTTPSessionManager` object, you can create HTTP requests by using methods from the AFNetworking library. See [AFNetworking documentation](https://github.com/AFNetworking/AFNetworking) for more information.

## Implement TCP transparent proxy

This section uses the `CocoaAsyncSocket` library as an example to handle socket requests and responses through the SDK. You can also use other socket libraries to implement transparent proxy functionality.

### Prerequisites

- You have completed the SDK initialization and enabled the FPA service. For details, see [Initializing the SDK and starting the FPA service](#init_sdk).
- You have integrated the [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) library.

### Implementation steps

1. Call the `getTransparentProxyPortWithChainId` method to get the transparent proxy port.

    ```objective-c
    // Sets the chain ID of the FPA service, such as 123
    // Sets the origin site domain name or IP
    // Sets the origin port via the port parameter, such as 30103
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    FpaChainInfo *t_info = [FpaChainInfo fpaChainInfoWithChainId:123 address:@"<Your IP or domain>" port:30103 enableFallback:YES];
    // Calls getTransparentProxyPort to get the port of the transparent proxy
    // In the production environment, Agora recommends that you add logic here to avoid FPA proxy when t_port <= 0
    self.t_port = [[FpaProxyService sharedFpaProxyService] getTransparentProxyPortWithChainInfo:t_info];
    ```

2. Connect to the transparent proxy with the obtained port.

    ```objective-c
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    [self.clientSocket connectToHost:@"127.0.0.1" onPort:self.t_port viaInterface:nil withTimeout:-1 error:&error];
    ```

After a successful connection, socket data can be sent and received through the transparent proxy.

## References

### Other methods to integrate the SDK

#### Manually copy SDK files

1. In the [SDK Download](https://docs.agora.io/cn/global-accelerator/downloads) page, download the latest version of the Agora FPA SDK, and unzip it. Copy the `.framework` libraries from `./libs` to your project folder.

2. Open Xcode and navigate to the **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu. Click **+ > Add Other… > Add Files** to add the `.framework` libraries. Make sure the **Embed** properties of the libraries are set to **Embed & Sign**.

After the `.framework` libraries are added, the Xcode project automatically links the required system libraries.

### Considerations

- If the app is switched to the background, you need to keep it alive.
- You can set the SDK log file path using the `FpaProxyServiceConfig.logFilePath` (LogFile) method.

### API reference

See [iOS SDK API reference](./fpa_afn_api).

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
