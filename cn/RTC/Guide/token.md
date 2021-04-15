
# Authenticate Your Users with Tokens

To enhance communication security, Agora uses tokens to authenticate users before they access the Agora serivce, such as joining an RTC channel.

This article describes how to generate a token and use it for authentication in your client app when a user tries to access the Agora service.

##  Understand the tech

A token is a time-bound dynamic key generated on your server. Agora provides code samples on [GitHub](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) for you to generate tokens.

When your app users try to join a channel, Agora validates their token and grants access according to the following information in the token:
- The App ID of your Agora project
- The app certificate of your Agora project
- The channel name
- The user ID of the user to be authenticated
- The privilege of the user
- The expiration time of the token

Tokens expire. A token is valid for 24 hours at most. You need to regularly generate new tokens to keep users connected.

When generating a token, you can specify whether a user has the privilege to publish streams in an RTC channel. See [How do I use co-host token authentication?](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost) for details.

The following figure shows the steps in the authentication flow:

![token authentication flow](https://web-cdn.agora.io/docs-files/1618395721208)

## Prerequisites

In order to follow this procedure you must have:

1. A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
1. An Agora project with the [app certificate](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates) enabled.

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users.

### Generate a token

Tokens are generated from your app server. To do that, you need to deploy a token generator on your server.

#### Deploy a sample token server

For users who want a deployable sample server to test with, Agora provides a repository of a [NodeJS implementation](https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs) where you can quickly deploy a token server at [Heroku](https://dashboard.heroku.com/).

**Warning**

- This repository is a sample only and contains fatal security flaws. **DO NOT USE IT IN YOUR PRODUCTION ENVIRONMENT**.
- This repository aims at providing a testing environment for front-end developers and is not meant for production purposes.
- Heroku is an independent service provider and not affiliated with Agora. Therefore, Agora is not responsible for any charges you may incur with Heroku.

Follow the steps to deploy the token server and generate a token:

1. Go to [Heroku](https://dashboard.heroku.com/), follow the on-screen instructions to create an account, and log onto Heroku.
2. Go to [TokenServer-nodejs](https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs). On the **Create New App** page, fill the **App name**, **APP_CERTIFICATE**, and **APP_ID**. Click **Deploy app**.
3. Wait for Heroku to run a while, and when you see **Your app was successfully deployed**, click **Manage App**. You will get the URL of your app in the address bar.
4. Open the following URL, replace `<heroku url>` with the URL of your app. Heroku generates a token and returns it to the endpoint.
    ```
    https://<heroku url>/access_token?channel=test&uid=1234
    ```

#### Deploy a token generator on your server

In the production environment, you need to deploy the token generator on your app server. Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.


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

This section introduces the parameters and descriptions for the method to generate a token. Take C++ as an example:

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
| `channelName` | The channel name. The string length must be less than 64 bytes. Supported character scopes are: <ul><li>All lowercase English letters: a to z.</li><li>All upper English letters: A to Z.</li><li>All numeric characters: 0 to 9.</li><li>The space character.</li><li>Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",".</li></ul>|
| `uid` | The user ID. A 32-bit unsigned integer with a value range from 1 to (2³² - 1). It must be unique. Set `uid` as 0, if you do not want to authenticate the user ID, that is, any `uid` from the app client can join the channel. |
| `role` | The user privilege. This parameter determines whether a user can publish streams in the channel. <ul><li>`Role_Publisher(1)`: (Default) The user has the privilege of a publisher, that is, the user can publish streams in the channel.</li><li>`Role_Subscriber(2)`: The user has the privilege of a subscriber, that is, the user can only subscribe to streams, not publish them, in the channel. This value takes effect only if you have enabled co-host authentication. For details, see FAQ [How do I use co-host authentication](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost). |
| `privilegeExpiredTs` | The Unix timestamp when the token expires, represented by the sum of the current timestamp and the valid time of the token. For example, if you set `privilegeExpiredTs` as the current timestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is still valid for 24 hours. |


## Use the token for client-side user authentication

Take the following steps to use the token for client-side user authentication. The code samples apply to Agora RTC Web SDK 4.x.

### Fetch the token with uid and channel name

Fetch the token with the uid to join the channel.

```JavaScript
// Assume the client sends
//
//  {
//    "uid": "123456",
//    "channelName": "channelA"
//  }
//
// the token server returns:
// {
//    "code":"200",
//    "token": "006970CA35de60c44645bbae8a215061b33IACtCBeHhqlszBWc9S8XyvSoz1fJm1YiL6OWFTbLNC7OMbdIfRCtk5C5IgB8zc0FZAN5YAQAAQD0v3dgAgD0v3dgAwD0v3dgBAD0v3dg"
// }
//
// You need to import axios
//
function fetchToken(uid, channelName) {

    let data = JSON.stringify({ "uid": uid, "channelName": channelName });

    let config = {
        method: 'get',
        url: 'https://<SERVER_URL>/fetch_rtc_token',
        headers: {
            'Content-Type': 'application/json'
        },
        data: data
    };

    return new Promise(function (resolve) {
        axios(config)
            .then(function (response) {
                const token = response.data.token;
                resolve(token);
            })
            .catch(function (error) {
                console.log(error);
            });
    })
}
```

### Join channel with the token, uid, and channel name

Call `join` to join the channel with the token and uid.

```JavaScript
import AgoraRTC from "agora-rtc-sdk-ng"

const client = AgoraRTC.createClient()

async function startCall() {
  let token = await fetchToken(123456, "ChannelA");
  // Join channel with token and uid
  await client.join("APPID", "ChannelA", token, 123456);
  ...
}
```

### Handle token expiration

Tokens expire, and when that happens, the user gets disconnected. To prevent that from happening, you also need to handle token expiration in your client logic.

**When the token is about to expire**

The `token-privilege-will-expire` callback occurs 30 seconds before a token expires.

When the `token-privilege-will-expire` callback is triggered，the client must fetch the token from the server and call `renewToken` to pass the new token to the SDK.

```JavaScript
client.on("token-privilege-will-expire", async function(){
  // After requesting a new token
  await client.renewToken(token);
});
```

**When the token has expired**

The `token-privilege-did-expire` callback occurs when the token expires.

When the `token-privilege-did-expire` callback is triggered，the client must fetch the token from the server and call `join` to use the new token to join the channel.

```JavaScript
client.on("token-privilege-did-expire", async function(){
  //After requesting a new token
  await rtc.client.join(options.appId, options.channel, options.token, 123456);
});
```

## Reference

#### Generate a token from Agora Console

To facilitate authentication at the test stage, [Agora Console](https://console.agora.io/) supports generating temporary for testing purposes. A temporary token is valid for 24 hours.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click the ![temp_token](Images/temp_token.png) icon to open the **Token** page.
2. Enter a channel name, and click **Generate Temp Token** to generate a temporary token.
3. Use the generated token to join a real-time engagement channel. Ensure that the channel name is the same with the one that you use to generate the temporary token.

Temporary tokens are for test purposes only. In the production environment, Agora recommends generating tokens from your server.

#### Channel Key

Token-based authentication has requirements on the SDK version:
- For RTC Native SDKs and the On-premise Recording SDK, ensure that the SDK version is v2.1.0 or later.
- For RTC Web SDKs, ensure that the SDK version is v2.4.0 or later.

If you are using an earlier version, refer to [Channel Keys](https://docs.agora.io/en/Agora%20Platform/channel_key) to authenticate your users.

#### Related documents

You can also refer to the following documents according to your needs:

- [How to solve token-related errors?](https://docs.agora.io/en/faq/token_error)
- [What causes the 101 error on Cloud Recording SDK?](https://docs.agora.io/en/faq/101_error)
- [How to use co-host token authentication?](https://docs.agora.io/en/faq/token_cohost)


