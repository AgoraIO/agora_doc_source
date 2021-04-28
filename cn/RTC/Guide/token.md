# Authenticate Your Users with Tokens

To enhance communication security, Agora uses tokens to authenticate users before they access the Agora service, such as joining an RTC channel.

This article describes how to generate a token and use it for authentication in your client app when a user tries to access the Agora service.

## Understand the tech

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

### Deploy a simple token generator on your server

Before you start, make sure you have installed [Golang](https://golang.org/) and GO111MODULE is set to on.

> If you are using Go 1.16 or later, GO111MODULE is on by default. See [this blog](https://blog.golang.org/go116-module-changes) for details.

Take the following steps to build a simple RTC token server on your local machine in Golang:

> Warning: This is a sample server for demonstration purposes only. **DO NOT USE IT IN YOUR PRODUCTION ENVIRONMENT**.

1. Create a file, `server.go`, with the following content:
    - You need to replace `<Your App ID>` with your App ID.
    - You need to replace `<Your App Certificate>` with your App Certificate.

   ```golang
    package main

    import (
        rtctokenbuilder "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/RtcTokenBuilder"
        "fmt"
        "log"
        "net/http"
        "time"
        "encoding/json"
        "errors"
        "strconv"
    )

    type rtc_int_token_struct struct{
        Uid_rtc_int uint32 `json:"uid"`
        Channel_name string `json:"ChannelName"`
        Role uint32 `json:"role"`
    }

    var rtc_token string
    var int_uid uint32
    var channel_name string

    var role_num uint32
    var role rtctokenbuilder.Role

    // Use RtcTokenBuilder to generate an RTC token
    func generateRtcToken(int_uid uint32, channelName string, role rtctokenbuilder.Role){

        appID := "<Your App ID>"
        appCertificate := "<Your App Certificate>"
        // Number of seconds after which the token expires
        // For demonstration purposes, set it to 40 so that you can easily observe the automatic token renew actions of the client
        expireTimeInSeconds := uint32(40)
        // Get current timestamp
        currentTimestamp := uint32(time.Now().UTC().Unix())
        // Timestamp when the token expires
        expireTimestamp := currentTimestamp + expireTimeInSeconds

        result, err := rtctokenbuilder.BuildTokenWithUID(appID, appCertificate, channelName, int_uid, role, expireTimestamp)
        if err != nil {
            fmt.Println(err)
        } else {
            fmt.Printf("Token with uid: %s\n", result)
            fmt.Printf("uid is %d\n", int_uid )
            fmt.Printf("ChannelName is %s\n", channelName)
            fmt.Printf("Role is %d\n", role)
        }
        rtc_token = result
    }


    func rtcTokenHandler(w http.ResponseWriter, r *http.Request){
        w.Header().Set("Content-Type", "application/json; charset=UTF-8")
        w.Header().Set("Access-Control-Allow-Origin", "*")
        w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS");
        w.Header().Set("Access-Control-Allow-Headers", "*");

        if r.Method == "OPTIONS" {
            w.WriteHeader(http.StatusOK)
            return
        }

        if r.Method != "POST" && r.Method != "OPTIONS" {
            http.Error(w, "Unsupported method. Please check.", http.StatusNotFound)
            return
        }


        var t_int rtc_int_token_struct
        var unmarshalErr *json.UnmarshalTypeError
        int_decoder := json.NewDecoder(r.Body)
        int_err := int_decoder.Decode(&t_int)
        if (int_err == nil) {

                    int_uid = t_int.Uid_rtc_int
                    channel_name = t_int.Channel_name
                    role_num = t_int.Role
                    switch role_num {
                    case 0:
                        role = rtctokenbuilder.RoleAttendee
                    case 1:
                        role = rtctokenbuilder.RolePublisher
                    case 2:
                        role = rtctokenbuilder.RoleSubscriber
                    case 101:
                        role = rtctokenbuilder.RoleAdmin
                    }
        }
        if (int_err != nil) {

            if errors.As(int_err, &unmarshalErr){
                    errorResponse(w, "Bad request. Wrong type provided for field " + unmarshalErr.Value  + unmarshalErr.Field + unmarshalErr.Struct, http.StatusBadRequest)
                    } else {
                    errorResponse(w, "Bad request.", http.StatusBadRequest)
                }
            return
        }

        generateRtcToken(int_uid, channel_name, role)
        errorResponse(w, rtc_token, http.StatusOK)
        log.Println(w, r)
    }

    func errorResponse(w http.ResponseWriter, message string, httpStatusCode int){
        w.Header().Set("Content-Type", "application/json")
        w.Header().Set("Access-Control-Allow-Origin", "*")
        w.WriteHeader(httpStatusCode)
        resp := make(map[string]string)
        resp["token"] = message
        resp["code"] = strconv.Itoa(httpStatusCode)
        jsonResp, _ := json.Marshal(resp)
        w.Write(jsonResp)

    }

    func main(){
        // Handling routes
        // RTC token from RTC num uid
        http.HandleFunc("/fetch_rtc_token", rtcTokenHandler)
        fmt.Printf("Starting server at port 8082\n")

        if err := http.ListenAndServe(":8082", nil); err != nil {
            log.Fatal(err)
        }
    }
   ```

2. Run the following command to create a `go.mod` file.

   ```shell
   $ go mod init sampleServer
   ```

3. Run the following command to get dependencies:

   ```shell
   $ go get
   ```

4. Run the following command to start the server:

   ```shell
   $ go run server.go
   ```

## Use the token for client-side user authentication

Take the following steps to use the token for client-side user authentication. The code samples apply to Agora RTC Web SDK 4.x.

> Warning: This is a sample client for demonstration purposes only. **DO NOT USE IT IN YOUR PRODUCTION ENVIRONMENT**.

Before you start, make sure you have installed [npm](https://www.npmjs.com/get-npm) and a supported browser per [Compatibility](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=Web).

1. Create a folder with the following files:

    ```text
    |
    |-- index.html
    |-- client.js
    ```

2. Edit `index.html` to include the following content:

    ```html
    <html>
    <head>
        <title>Token demo</title>
    </head>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <body>
        <h1>Token demo</h1>

        <script src="https://download.agora.io/sdk/release/AgoraRTC_N.js"></script>
        <script src="./client.js"></script>

    </body>
    </html>
    ```

3. Edit `client.js` to include the following content:
    - You need to replace `<Your App ID>` with your App ID.
    - You need to replace `<Your Host URL and port>` with the host URL and port of the local Golang server you have just deployed, such as `10.53.3.234:8082`.

    ```js
    var rtc = {
        // For the local audio and video tracks.
        localAudioTrack: null,
        localVideoTrack: null,
    };

    var options = {
        // Pass your app ID here.
        appId: "<Your app ID>",
        // Set the channel name.
        channel: "ChannelA",
        // Set the user role in the channel.
        role: "host"
    };

    // Fetch a token from the Golang server
    function fetchToken(uid, channelName, tokenRole) {

        return new Promise(function (resolve) {
            axios.post('http://<Your Host URL and port>/fetch_rtc_token', {
                uid: uid,
                channelName: channelName,
                role: tokenRole
            }, {
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                }
            })
                .then(function (response) {
                    const token = response.data.token;
                    resolve(token);
                })
                .catch(function (error) {
                    console.log(error);
                });
        })
    }

    async function startBasicCall() {

        const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });
        client.setClientRole(options.role);
        const uid = 123456;

        // Fetch a token before calling join to join a channel
        let token = await fetchToken(uid, options.channel, 1);

        await client.join(options.appId, options.channel, token, uid);
        rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
        rtc.localVideoTrack = await AgoraRTC.createCameraVideoTrack();
        await client.publish([rtc.localAudioTrack, rtc.localVideoTrack]);
        const localPlayerContainer = document.createElement("div");
        localPlayerContainer.id = uid;
        localPlayerContainer.style.width = "640px";
        localPlayerContainer.style.height = "480px";
        document.body.append(localPlayerContainer);

        rtc.localVideoTrack.play(localPlayerContainer);

        console.log("publish success!");

        client.on("user-published", async (user, mediaType) => {
            await client.subscribe(user, mediaType);
            console.log("subscribe success");

            if (mediaType === "video") {
                const remoteVideoTrack = user.videoTrack;
                const remotePlayerContainer = document.createElement("div");
                remotePlayerContainer.textContent = "Remote user " + user.uid.toString();
                remotePlayerContainer.style.width = "640px";
                remotePlayerContainer.style.height = "480px";
                document.body.append(remotePlayerContainer);
                remoteVideoTrack.play(remotePlayerContainer);

            }

            if (mediaType === "audio") {
                const remoteAudioTrack = user.audioTrack;
                remoteAudioTrack.play();
            }

            client.on("user-unpublished", user => {
                const remotePlayerContainer = document.getElementById(user.uid);
                remotePlayerContainer.remove();
            });

        });

        // When token-privilege-will-expire occurs, fetch a new token from the server and call renewToken to renew the token
        client.on("token-privilege-will-expire", async function () {
            let token = await fetchToken(uid, options.channel, 1);
            await client.renewToken(token);
        });

        // When token-privilege-did-expire occurs, fetch a new token from the server and call join to rejoin the channel
        client.on("token-privilege-did-expire", async function () {
            console.log("Fetching the new Token")
            let token = await fetchToken(uid, options.channel, 1);
            console.log("Rejoining the channel with new Token")
            await rtc.client.join(options.appId, options.channel, token, uid);
        });

    }

    startBasicCall()
    ```

    In the code example above, we can see that token is related to the following code logic in the client:
    - Call `join` to join the channel with token, uid, and channel name. The uid and channel name must be the same as the ones used to generate the token.
    - The `token-privilege-will-expire` callback occurs 30 seconds before a token expires. When the `token-privilege-will-expire` callback is triggered，the client must fetch the token from the server and call `renewToken` to pass the new token to the SDK.
    - The `token-privilege-did-expire` callback occurs when a token expires. When the `token-privilege-did-expire` callback is triggered, the client must fetch the token from the server and call `join` to use the new token to join the channel.


4. Open `index.html` with a supported browser. You should be able to see the following actions performed by the client:
    - Successfully joining a channel.
    - Renewing a token every 10 seconds if you set `expireTimeInSeconds` to `40` in the Golang token server.


## Reference

### Token generator libraries

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.

| Language | Algorithm   | Core method                                                                                                                                         | Sample code                                                                                                                                                         |
| -------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C++      | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtcTokenBuilder.h)                              | [RtcTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtcTokenBuilderSample.cpp)                           |
| Go       | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/RtcTokenBuilder/RtcTokenBuilder.go)              | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/RtcTokenBuilder/sample.go)                                            |
| Java     | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media/RtcTokenBuilder.java) | [RtcTokenBuilderSample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtcTokenBuilderSample.java) |
| Node.js  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder.js)                          | [RtcTokenBuilderSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilderSample.js)                          |
| PHP      | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtcTokenBuilder.php)                            | [RtcTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtcTokenBuilderSample.php)                           |
| Python   | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtcTokenBuilder.py)                          | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtcTokenBuilderSample.py)                          |
| Python3  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtcTokenBuilder.py)                         | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtcTokenBuilderSample.py)                         |

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

| Parameter            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `appId`              | The App ID of your project.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `appCertificate`     | The App Certificate of your project.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `channelName`        | The channel name. The string length must be less than 64 bytes. Supported character scopes are: <ul><li>All lowercase English letters: a to z.</li><li>All upper English letters: A to Z.</li><li>All numeric characters: 0 to 9.</li><li>The space character.</li><li>Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ",".</li></ul>                                                                                                                                    |
| `uid`                | The user ID. A 32-bit unsigned integer with a value range from 1 to (2³² - 1). It must be unique. Set `uid` as 0, if you do not want to authenticate the user ID, that is, any `uid` from the app client can join the channel.                                                                                                                                                                                                                                                                                                                                                                                |
| `role`               | The user privilege. This parameter determines whether a user can publish streams in the channel. <ul><li>`Role_Publisher(1)`: (Default) The user has the privilege of a publisher, that is, the user can publish streams in the channel.</li><li>`Role_Subscriber(2)`: The user has the privilege of a subscriber, that is, the user can only subscribe to streams, not publish them, in the channel. This value takes effect only if you have enabled co-host authentication. For details, see FAQ [How do I use co-host authentication](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost). |
| `privilegeExpiredTs` | The Unix timestamp when the token expires, represented by the sum of the current timestamp and the valid time of the token. For example, if you set `privilegeExpiredTs` as the current timestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is still valid for 24 hours.                                                                                                                                                                                                           |


### Generate a token from Agora Console

To facilitate authentication at the test stage, [Agora Console](https://console.agora.io/) supports generating temporary for testing purposes. A temporary token is valid for 24 hours.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click the ![temp_token](Images/temp_token.png) icon to open the **Token** page.
2. Enter a channel name, and click **Generate Temp Token** to generate a temporary token.
3. Use the generated token to join a real-time engagement channel. Ensure that the channel name is the same with the one that you use to generate the temporary token.

Temporary tokens are for test purposes only. In the production environment, Agora recommends generating tokens from your server.

### Channel Key

Token-based authentication has requirements on the SDK version:

- For RTC Native SDKs and the On-premise Recording SDK, ensure that the SDK version is v2.1.0 or later.
- For RTC Web SDKs, ensure that the SDK version is v2.4.0 or later.

If you are using an earlier version, refer to [Channel Keys](https://docs.agora.io/en/Agora%20Platform/channel_key) to authenticate your users.

### Related documents

You can also refer to the following documents according to your needs:

- [How to solve token-related errors?](https://docs.agora.io/en/faq/token_error)
- [What causes the 101 error on Cloud Recording SDK?](https://docs.agora.io/en/faq/101_error)
- [How to use co-host token authentication?](https://docs.agora.io/en/faq/token_cohost)
