---
title: Set up Authentication
platform: All_Platforms
updatedAt: 2021-02-07 10:16:54
---
## Introduction

The Agora RTM SDK provides different security mechanisms for authentication: 

- App ID
- RTM token

The following figure shows the environment where the security keys are used:

![](https://web-cdn.agora.io/docs-files/1555490456944)

<a name = "Get-an-App-ID"></a>

## Use an App ID for authentication

After signing up for a developer account in [Agora Console](https://console.agora.io/?_ga=2.18229183.782459552.1593311578-73063204.1585890674), you can create multiple projects. Each project has an App ID, which is the unique identity of the project. If others steal your App ID, they can use it in their own projects. Therefore, using an App ID for authentication is less secure. Agora recommends using an App ID for authentication only in a test environment, or if your project has low security requirements.

1.  Sign up for a new account at [https://sso.agora.io/en/login](https://sso.agora.io/en/login).
2.  Click the **Create** button on the **Overview** page in Console.
3.  Fill in the **Project Name** and click **Submit**.
4.  Find the App ID under the created project.

You need to set the `appId` parameter as the App ID when initializing the client.

## Use an RTM token for authentication

You need an RTM token to log in to the Agora RTM system. Complete the following steps to get and use an RTM token. 

### Step 1: Get an App ID

See [Get an App ID](#Get-an-App-ID).

### Step 2: Get an App Certificate

1.  Log in [Agora Console](https://dashboard.agora.io).
2.  Click **Project** in the left navigation menu to go to the **Projects** page in Console.
3.  Enable the App Certificate for the project.
	-   Click **Edit** under the created project.
	-   Click **Enable** to the right of the App Certificate. Read **About App Certificate** before confirming the operation.
	-  Click ![](https://web-cdn.agora.io/docs-files/1551778086037) to view the App Certificate. You can re-click this icon to hide the App Certificate.

<div class="alert note">The App Certificate takes about an hour to take effect after it is enabled. Once the App Certificate is enabled for a project, you can use only a token for authentication. You do not have to set <b>Signaling Token Debugging Switch</b> because it does not affect RTM projects.</div>

### Step 3: Create an RTM token generator 

We provide an open source [Agora Dynamic Key](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which covers developer languages such as C++, C#, Go, Java, Node.js, Perl, PHP, Python and Ruby. You can choose a language according to your development environment, and view the source code in the `src` folder or the sample code in the `sample` folder. The `./<language>/src` folder of each language holds source codes for generating different types of dynamic keys and tokens. You can use `RtmTokenBuilder` to generate an RTM Token. The `./<language>/sample` folder of each language holds token generator demos we create for demonstration purposes. `RtmTokenBuilderSample` is a demo for generating an RTM token.

<div class="alert note"></div>The token encoding uses the standard HMAC/SHA1 approach and the libraries are available on common server-side development platforms, such as Node.js, Java, PHP, Python, and C++. For more information, see [Authentication code](<a href="http://en.wikipedia.org/wiki/Hash-based_message_authentication_code">).</div>

Example code

```c++
  static std::string buildToken(const std::string& appId,
                                const std::string& appCertificate,
                                const std::string& userAccount,
                                RtmUserRole userRole,
                                uint32_t privilegeExpiredTs = 0);
```

| Parameter             | Description                                                       |
| :----------------- | :----------------------------------------------------------- |
| appId              | The App ID of your project.|
| appCertificate     | The App Certificate of your project.                                          |
| userAccount        | The user ID of the RTM system.                                   |
| userRole           | The user role. Agora supports only one user role. Set the value as the default value  `Rtm_User = 1`. |
| privilegeExpiredTs | This parameter is invalid for now. |


### Step 4: Deploy an RTM token generator

Agora's token scheme is based on a request-response model. Complete the following steps to deploy an RTM token generator:

1. Implement an RTM generator on the server.
2. The client sends a request to get an RTM token from the server.
3. The server receives the request, generates an RTM token, and sends the token to the client.

> An RTM token is valid for 24 hours. When the client receives a new RTM token, you need to call [`renewToken`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2c33be67bfec02d69041f1e8978f4559) to update your RTM token. 







