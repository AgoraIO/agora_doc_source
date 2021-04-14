
# Authenticate Your Users with Tokens  

To enhance communication security, Agora uses tokens to authenticate users before they access the Agora serivce, such as joining an RTC channel or logging onto the RTM system. 

This article describes how to generate a token and use it for authentication in your client app when a user tries to access the Agora service.

##  Understand the tech   

A token is a dynamic key generated on your server. Agora provides code samples on GitHub for you to generate tokens.

When your app users tries to access the Agora service, Agora validates their token and grant access according to the following information in the token:
- The App ID of your Agora project
- The app certificate of your Agora project
- The channel name
- The user ID of the user to be authenticated
- The privilege of the user
- The expiration time of the token

Tokens expire. A token is valid for 24 hours at most. You need to regularly generate new tokens to keep users connected.

Agora supports specifying the privilege of a user in the token. For example, a user with the privilege of subscriber can only subscribe to streams, but not publish streams. See [How do I use co-host token authentication?](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost) for details.

The following figure shows the steps in the authentication flow:

![token authentication flow](https://web-cdn.agora.io/docs-files/1618379347094)

## Prerequisites

In order to follow this procedure you must have:

1. A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
1. An Agora project with the [app certificate](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates) enabled.

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users

### Generate a token

Tokens are generated from your app server. To do that, you need to deploy a token generator on your server.

#### Deploy a sample token server

For users who want a quick deployable sample server to test with, Agora provides a repo of a [NodeJS implementation](https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs) where you can quickly deploy a token server at [Heroku](https://dashboard.heroku.com/).

**Warning**
- This repo aims at providing a testing environment for front-end developers and is not meant for production purposes.
- Heroku is an independent service provider and not affiliated with Agora. Therefore, Agora is not responsible got any charges you may incur with Heroku.


Follow the steps to deploy the token server and generate a token:

1. Go to [Heroku](https://dashboard.heroku.com/), follow the on-screen instructions to create an account, and log onto Heroku.
2. Go to [TokenServer-nodejs](https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs). On the **Create New App** page, fill the **App name**, **APP_CERTIFICATE**, and **APP_ID**. Click **Deploy app**.
3. Wait for Heroku to run a while, and when you see **Your app was succeessfully deployed**, click **Manage App**. You will get the URL of your app in the address bar.
4. Open the following URL, replace `<heroku url>` with the URL of your app. Heroku  generates a token and returns it to the endpoint.
    ```
    https://<heroku url>/access_token?channel=test&uid=1234
    ```

#### Deploy a token generator on your server

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.


| Language  | Algorithm  | Core method  | Sample code |
| ---- | ---- | ---- | ---- |
| C++  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtcTokenBuilder.h)  | [RtcTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtcTokenBuilderSample.cpp) |
| Go   | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/RtcTokenBuilder/RtcTokenBuilder.go) |[sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/RtcTokenBuilder/sample.go) |
| Java | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media/RtcTokenBuilder.java) | [RtcTokenBuilderSample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtcTokenBuilderSample.java) |
| Node.js | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder.js) | [RtcTokenBuilderSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilderSample.js) |
| PHP  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtcTokenBuilder.php) | [RtcTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtcTokenBuilderSample.php) |
| Python | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtcTokenBuilder.py) | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtcTokenBuilderSample.py) |
| Python3 | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtcTokenBuilder.py) | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtcTokenBuilderSample.py) |

**API Reference**

This section introduces the parameters and descroptions for the method to generate a token. Take C++ as an example:

```C++
static std::string buildTokenWithUid(
    const std::string& appId,
    const std::string& appCertificate,
    const std::string& channelName,
    uint32_t uid,
    UserRole role,
    uint32_t privilegeExpiredTs = 0);
```

| Parameter | Description |
| ---- | ---- |
| `appId` | The App ID of your project. |
| `appCertificate` | The App Certificate of your project. |
| `channelName` | The channel name. The string length must be less than 64 bytes. Supported character scopes are: <ul><li>All lowercase English letters: a to z.</li><li>All upper English letters: A to Z.</li><li>All numeric characters: 0 to 9.</li><li>The space charater.</li><li>Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",".</li></ul>|
| `uid` | The user ID. A 32-bit unsigned integer with a value range from 1 to (2³² - 1). It must be unique. Set `uid` as 0, if you do not want to authenticate the user ID, that is, any `uid` from the app client can join the channel. |
| `role` | The user privilege. This parameter determines whether a user can publish streams in the channel. <ul><li>`Role_Publisher(1)`: (Default) The user has the privilege of a publisher, that is, the user can publish streams in the channel.</li><li>`Role_Subscriber(2)`: The user has the privilege of a subscriber, that is, the user can only subscribe to streams, not publish them, in the channel. This value takes effect only if you have enabled co-host authentication. For details, see FAQ [How do I use co-host authentication](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost). |
| `privilegeExpiredTs` | The Unix timestamp when the token expires, represented by the sum of the current timstamp and the valid time of the token. For example, if you set `privilegeExpiredTs` as the current tomestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is still valid for 24 hours. |


### Grant user rights in your app base on token credentials

COMMENT: this title is probably using incorrect terminology for tokens. 

COMMENT: may need a couple of intro sentences here. 

To implement the client side of the authentication flow in your app:

1. Do something. 
1. Do something else.

## Test the authentication flow

COMMENT: Explain how to easily test the authentication server and client the user has just implemented.

1. Do this
1. Do that
1. You get the idea
1. Get the reader to login using incorrect credentials to show that users are kept out. 

Yay, it works. 


## Reference

#### Generate a token from Agora Console

To facilitate authentication at the test stage, [Agora Console](https://console.agora.io/) supports generating temporary for testing purposes. A temporary token is valid for 24 hours.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click the ![temp_token](images/temp_token.png) icon to open the **Token** page.
2. Enter a channel name, and click **Generate Temp Token** to generate a temporary token.
3. Use the generated token to join a real-time enagagement channel. Ensure that the channel name is the same with the one that you use to generate the temporary token.

Temporary tokens are for test purposes only. In the production environment, Agora recommends generating tokens from your server.

#### Channel Key

Token-based authentication has requirements on the SDK version: 
- For RTC Native SDKs and the On-premise Recording SDK, ensure that the SDK version is v2.1.0 or later.
- For RTC Web SDKs, ensure that the SDK version is v2.4.0 or later.

If you are using an earlier version, refer to [Channel Keys](https://docs.agora.io/en/Agora%20Platform/channel_key) to authenticate your users. 

#### Reference reading

You can also refer to the following documents according to your needs:

- [How to solve token-related errors?](https://docs.agora.io/en/faq/token_error)
- [What causes the 101 error on Cloud Recording SDK?](https://docs.agora.io/en/faq/101_error)
- [How to use co-host token authentication?](https://docs.agora.io/en/faq/token_cohost)


