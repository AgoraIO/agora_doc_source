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

