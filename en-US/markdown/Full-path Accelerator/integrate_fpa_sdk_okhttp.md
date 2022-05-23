This page describes how to implement the SDK acceleration mode.

In SDK acceleration mode, FPA automatically completes proximity scheduling from the client to the acceleration point IP address through the SDK.

## Usage flow

The basic usage flow of the FPA SDK is as follows:

![](https://web-cdn.agora.io/docs-files/1652695467904)

## Prerequisites

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

The FPA Android SDK supports Android 4.3 or later.

The following steps use Gradle as an example to implement JitPack integration.

1. Add the following code in the `/Gradle Scripts/build.gradle (Project:<projectname>)` file to add the JitPack dependency:

    ```gradle
    allprojects {
        repositories {
            ...
            maven { url 'https://www.jitpack.io' }
        }
    }
    ```

   If you set [dependencyResolutionManagement](https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration) in your Android project, the JitPack integration method may vary.

2. Integrate the SDK into your Android project by adding a dependency in the `/Gradle Scripts/build.gradle (Module: .app)` file:

    ```gradle
    dependencies {
    ...
    implementation 'com.github.agorabuilder:fpa:1.0.0'
    ...
    }
    ```

Use the latest version of the SDK. You can find the version number and JitPack integration method on other integration tools (maven, sbt, leiningen) in <https://jitpack.io/#agorabuilder/fpa>.

If you need to integrate using the offline SDK package, refer to [Other Integration Methods](#other-integration).

## Add network permissions

Add the following network permissions after `</application>` in the `/app/manifests/AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

<a id="init_sdk"></a>

## Initialize the SDK and start the FPA service

You must initialize the SDK and enable the FPA service before using the SDK for acceleration.

1. Make sure to import the following classes in your project:

    ```java
    import io.agora.fpa.proxy.FpaProxyConnectionInfo;
    import io.agora.fpa.proxy.FpaProxyService;
    import io.agora.fpa.proxy.FpaProxyServiceConfig;
    import io.agora.fpa.proxy.FpaHttpProxyChainConfig;
    import io.agora.fpa.proxy.FpaChainInfo;
    import io.agora.fpa.proxy.IFpaServiceListener;
    import io.agora.fpa.proxy.LogLevel;
    ```

2. Create an `FpaProxyServiceConfig` object, and set the relevant parameters such as App ID, token, and log:

    ```java
    private String workDir;
    private FpaProxyServiceConfig config;

    File workDirFile = new File(getCacheDir().getAbsoluteFile() + "/agora/fpa_log_sdk.log");
    workDir = workDirFile.getAbsolutePath();

    // Set the log file path in the Builder method
    // Refer to the value of the Builder method parameter to check the log file path
    FpaProxyServiceConfig.Builder builder = new FpaProxyServiceConfig.Builder(workDir);
    // Set App ID
        builder.setAppId("<Your App ID>")
        // Set the token. If token authentication is not enabled, you do not need to call setToken ()
        .setToken("<Your Token>")
        // Set log file size in KB
        .setLogFileSizeKb(1024)
        // Set the log level
        .setLogLevel(LogLevel.LOG_ERROR);
        config = builder.build();
    ```

3. Set up the proxy callback listener, and start the FPA service:

    ```java
    // Set proxy event callback listener
    FpaProxyService.getInstance().setListener(new IFpaServiceListener() {

                // Successfully connected to the FPA proxy
                @Override
                public void onConnected(@Nullable FpaProxyConnectionInfo info) {
                    Log.e(TAG, "[JAVA] onConnected. info=" + info);
                }

                // FPA proxy acceleration success
                @Override
                public void onAccelerationSuccess(@Nullable FpaProxyConnectionInfo info) {
                    Log.e(TAG, "[JAVA] onAccelerationSuccess. info=" + info);
                }

                // The connection to the FPA proxy failed and did not fall back.
                @Override
                public void onConnectionFailed(@Nullable FpaProxyConnectionInfo info, FailedReason reason) {
                    Log.e(TAG, "[JAVA] onConnectionFailed. info=" + info + " reason: " + reason.getDesc());
                }

                // Failed to connect to FPA proxy. Fall back to local connection.
                @Override
                public void onDisconnectedAndFallback(@Nullable FpaProxyConnectionInfo info, FailedReason reason) {
                    Log.e(TAG, "[JAVA] onDisconnectedAndFallback. info=" + info + " reason: " + reason.getDesc());
                }
            });

    // Start FPA service
    FpaProxyService.getInstance().start(config);
    ```

## Implement a local HTTP proxy

This section takes the OkHttp library as an example to process HTTP requests and responses through the SDK. You can also use other HTTP libraries that support modifying HTTP proxies.

### Prerequisites

- You have completed the SDK initialization and started the FPA service. For details, see <a href="#init_sdk">Initialize the SDK and start the FPA service</a>.
- You have integrated [OkHttp Library](https://square.github.io/okhttp/) in your Android project.

### Implementation steps

1. Call the `setOrUpdateHttpProxyChainConfig` method to set the mapping table of the origin IP address or domain name to the chain ID. Call the `setListener` method to set the proxy event callback listener:

    ```java
    FpaHttpProxyChainConfig.Builder builder = new FpaHttpProxyChainConfig.Builder();
    // Sets the chain ID of the FPA service, such as 123
    // Sets the origin site IP address or domain name
    // Sets the origin site port, such as 80
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    builder.addChainInfo(123, "<Your IP or domain>", 80, true)
        // Sets whether to roll back to a local connection if the HTTP local agent cannot find the chain ID corresponding to the source site in the FPA SDK
    .fallbackWhenNoChainAvailable(true);
    FpaProxyService.getInstance().setOrUpdateHttpProxyChainConfig(builder.build());
    ```

2. Create an `okHttpClient` object based on the `OkHttpClient` class, and use this object to register the internal HTTP proxy provided by the `FpaService` object.

    The life cycle of the `FpaProxyService` object and the `okhttpClient` object are bound. If you call `stop` to destroy the created `FpaProxyService` instance, the `FpaProxyService` bound to the `okHttpClient` cannot send HTTP requests to the FPA service.

    ```java
    // Creates an OkHttpClient object based on the OkHttpClient class
    okHttpClient = new OkHttpClient.Builder()
        .readTimeout(300,TimeUnit.SECONDS)
        .writeTimeout(300,TimeUnit.SECONDS)
        // Binds the okHttpClient object to the internal HTTP proxy provided by FpaProxyService. In the production environment, Agora recommends that you add logic here to avoid FPA proxy when getHttpProxyPort()<=0
        .proxy(new Proxy(HTTP, new InetSocketAddress("127.0.0.1", FpaProxyService.getInstance().getHttpProxyPort())))
        .build();
    ```

    If an `OkHttpClient` object has been created in your project (`oldOKHttpClient` in the sample code), you can update the proxy property of the object via the `newBuilder ()` method.

    ```java
    okHttpClient  = oldOkHttpClient.newBuilder()
                 // Registers the internal HTTP proxy provided by the FpaProxyService object
                 .proxy(new Proxy(HTTP, new InetSocketAddress("127.0.0.1", FpaProxyService.getInstance().getHttpProxyPort())))
                 .build();
    ```

3. Use the `OkHttpClient` object registered with the `FPAProxyService` agent to send HTTP requests and process HTTP responses.

    ```java
    okHttpClient.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(okhttp3.Call call, IOException e) {
        }

            @Override
            public void onResponse(okhttp3.Call call, Response response) throws IOException {

        }
    });
    ```

## Implement TCP transparent proxy

This section uses the `java.net.socket` library as an example to handle socket requests and responses through the SDK. You can also use other socket libraries to implement transparent proxy functionality.

### Prerequisites

You have completed the SDK initialization and enabled the FPA service. For details, see [Initializing the SDK and starting the FPA service](#init-start).

### Implementation steps

1. Call the `getTransparentProxyPort` method to get the transparent proxy port.

    ```java
    // Sets the chain ID of the FPA service, such as 123
    int chainId = 123;
    // Sets the origin site domain name or IP
    String address = "<Your domain or IP>";
    // Sets the origin port via the port parameter, such as 30103
    int port = 30103;
    // Sets whether to allow this acceleration channel to fall back to the local connection when the FPA proxy connection fails
    boolean enableFallback = true;
    FpaChainInfo chainInfo = new FpaChainInfo(chainId, address, port, enableFallback);
    // Calls getTransparentProxyPort to get the port of the transparent proxy
    // In the production environment, Agora recommends that you add logic here to avoid FPA proxy when t_port <= 0
    int t_port = FpaProxyService.getInstance().getTransparentProxyPort(chainInfo);
    ```

2. Connect to the transparent proxy with the obtained port.

    ```java
    socket = new Socket();
    socket.connect(new InetSocketAddress("127.0.0.1", t_port));
    ```

After a successful connection, socket data can be sent and received through the transparent proxy.

## References

### Other methods to integrate the SDK

#### Manually copy SDK files

The following steps use Gradle as an example to manually copying SDK files for integration.

1. In the [SDK Download](https://docs.agora.io/cn/global-accelerator/downloads) page, download the latest version of the Agora FPA SDK, and unzip it. Copy the following files and subfolders from the SDK package to your Android project path:

    | file or subfolder | project path |
    | --------- | ------------ |
    |`jar` file | `/app/libs/` |
    |`arm-v8a` folder | `/app/src/main/jniLibs/` |
    |`armeabi-v7a` folder | `/app/src/main/jnilibs/` |
    |`x86` folder | `/app/src/main/jnilibs/` |
    |`x86_64` folder | `/app/src/main/jnilibs/` |

2. Integrate the SDK into your Android project by adding a dependency in the `/Gradle Scripts/build.gradle (Module: .app)` file:

    ```gradle
    dependencies {
    ...
    implementation fileTree(dir: 'libs', include: [ '*.jar' ])
    ...
    }
    ```

### Considerations

- If the app is switched to the background, you need to keep it alive.
- You can set the SDK log file path using the `fpaProxyServiceConfig.builder` method.

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
