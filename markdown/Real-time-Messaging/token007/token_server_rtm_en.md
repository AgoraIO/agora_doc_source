<div class="alert note">As of RTM v1.4.6 for Web and v1.5.0 for other platforms, Agora upgrades the authentication mechanism from AccessToken to AccessToken2.<li>If you are new to RTM, Agora recommends that you use the latest version of SDKs and deploy the App server and client for AccessToken2 step by step according to this page.<li>If you have already deployed AccessToken in previous versions, you can have a quick upgrade referring to <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm#upgrade">Upgrade to AccessToken2</a>.</div>

<div class="alert info">The latest version of SDKs support both AccessToken2 and AccessToken at the same time, and can be used in tandem with previous versions.</div>

Authentication is the act of validating the identity of each user before they access your system. Agora uses digital tokens to authenticate users and their privileges before they access an Agora service, such as joining an Agora call, or logging into the real-time messaging system.

This document shows you how to create an RTM token server and an RTM client app. The RTM client app retrieves an RTM token from the RTM token server. This token authenticates the current user when the user accesses the Agora RTM service.

## Understand the tech

The following figure shows the steps in the authentication flow:

![RTM token authentication flow](https://web-cdn.agora.io/docs-files/1624939517653)

An RTM token is a dynamic key generated on your app server. You can specify the validity period of a token based on your business requirements. The validity period can be a maximum of 24 hours. When your users log in to the RTM system from your app client, the RTM system validates the token and reads the user and project information stored in the token. An RTM token contains the following information:

- The App ID of your Agora project
- The App Certificate of your Agora project
- The RTM user ID of the user to be authenticated
- The Unix timestamp when the token expires

## Prerequisites

In order to follow this procedure you must have the following:

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- An Agora project with the [App Certificate](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates) enabled.
- [Golang](https://golang.org/) 1.14+ with GO111MODULE set to on.
    <div class="alert note"> If you are using Go 1.16+, GO111MODULE is on by default. See <a href="https://blog.golang.org/go116-module-changes">this blog</a> for details.</div>
- [npm](https://www.npmjs.com/get-npm) and a [supported browser](https://docs.agora.io/en/All/faq/browser_support).
- Use the Agora RTM SDK that supports AccessToken2:

| SDK | First SDK version to support AccessToken2 |
|:---|:---|
| RTM Android SDK | 1.5.0 |
| RTM iOS SDK | 1.5.0 |
| RTM macOS SDK | 1.5.0 |
| RTM Web SDK | 1.4.6 |
| RTM Windows SDK | 1.5.0 |
| RTM Linux SDK | 1.5.0 |

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users using the [source code](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) provided by Agora.

### Get the App ID and App Certificate

This section shows you how to get the security information needed to generate a token, including the App ID and App Certificate of your project.

#### 1. Get the App ID

~a57db1d0-2494-11eb-a6fc-dfd7ed4260bd~

#### 2. Get the App Certificate

~c3860180-4c40-11ec-8689-2164ade84c59~

### Deploy a token server

Token generators create the tokens requested by your client app to enable secure access to Agora Platform. To serve these tokens you deploy a generator in your security infrastructure.

In order to show the authentication workflow, this section shows how to build and run a token server written in Golang on your local machine.

<div class="alert warning">This sample server is for demonstration purposes only. Do not use it in a production environment.</div>

1. Create a file, `server.go`, with the following content. Then replace `<Your App ID>` and `<Your App Certificate>` with your App ID and App Certificate.

```golang
package main

import (
    rtmtokenbuilder "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/rtmtokenbuilder2"
    "fmt"
    "log"
    "net/http"
    "time"
    "encoding/json"
    "errors"
    "strconv"
)

type rtm_token_struct struct{
    Uid_rtm string `json:"uid"`
}

var rtm_token string
var rtm_uid string

func generateRtmToken(rtm_uid string){

    appID := "Your_App_ID"
    appCertificate := "Your_Certificate"
    expireTimeInSeconds := uint32(3600)
    currentTimestamp := uint32(time.Now().UTC().Unix())
    expireTimestamp := currentTimestamp + expireTimeInSeconds

    result, err := rtmtokenbuilder.BuildToken(appID, appCertificate, rtm_uid, expireTimestamp)
    if err != nil {
        fmt.Println(err)
    } else {
        fmt.Printf("Rtm Token: %s\n", result)

    rtm_token = result

    }
}

func rtmTokenHandler(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Content-Type", "application/json;charset=UTF-8")
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


        var t_rtm_str rtm_token_struct
        var unmarshalErr *json.UnmarshalTypeError
        str_decoder := json.NewDecoder(r.Body)
        rtm_err := str_decoder.Decode(&t_rtm_str)

        if (rtm_err == nil) {
            rtm_uid = t_rtm_str.Uid_rtm
        }

        if (rtm_err != nil) {
            if errors.As(rtm_err, &unmarshalErr){
            errorResponse(w, "Bad request. Please check your params.", http.StatusBadRequest)
            } else {
            errorResponse(w, "Bad request.", http.StatusBadRequest)
        }
        return
    }

        generateRtmToken(rtm_uid)
        errorResponse(w, rtm_token, http.StatusOK)
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
    // RTM token from RTM uid
    http.HandleFunc("/fetch_rtm_token", rtmTokenHandler)

    fmt.Printf("Starting server at port 8082\n")

    if err := http.ListenAndServe(":8082", nil); err != nil {
        log.Fatal(err)
    }
}
```


2. A `go.mod` file defines this module’s import path and dependency requirements. To create the `go.mod` for your token server, run the following command:

   ```shell
   $ go mod init sampleServer
   ```

3. Get dependencies by running the following command:

   ```shell
   $ go get
   ```

4. Start the server by running the following command:

   ```shell
   $ go run server.go
   ```

### Use tokens for user authentication

This section uses the Web client as an example to show how to use a token for client-side user authentication.

In order to show the authentication workflow, this section shows how to build and run a Web client on your local machine.

<div class="alert warning">This sample client is for demonstration purposes only. Do not use it in a production environment.</div>

1. Create the project structure of the Web client with a folder including the following files.
    - `index.html`: User interface
    - `client.js`: App logic with Agora RTM Web SDK

    ```text
    |
    |-- index.html
    |-- client.js
    ```

2. Download [Agora RTM SDK for Web](https://docs.agora.io/en/Real-time-Messaging/downloads?platform=Web). Save the JS file in `libs` to your project directory.

3. In `index.html`, add the following code to include the app logic in the UI:
    - You need to replace `<path to the JS file>` with the path of the JS file you saved in step 2.

   ```html
   <html>
   <head>
      <title>RTM Token demo</title>
   </head>
   <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
   <body>
      <h1>Token demo</h1>
      <script src="<path to the JS file>"></script>
    <script src="./client.js"></script>

   </body>
   </html>
   ```

4. Create the app logic by editing `client.js` with the following content. Then replace `<Your App ID>` with your App ID. The App ID must match the one in the server. You also need to replace `<Your Host URL and port>` with the host URL and port of the local Golang server you have just deployed, such as `10.53.3.234:8082`.

    ```js
    // Parameters for the login method
    let options = {
        token: "",
        uid: ""
    }

    // Whether to stop the token renew loop
    let stopped = false

    function sleep (time) {
        return new Promise((resolve) => setTimeout(resolve, time));
    }

    function fetchToken(uid) {

        return new Promise(function (resolve) {
            axios.post('http://<Your Host URL and port>/fetch_rtm_token', {
                uid: uid,
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

    async function loginRTM()
    {

        // Your app ID
        const appID = "<Your App ID>"

        // Initialize the client
        const client = AgoraRTM.createInstance(appID)

        // Display connection state changes
        client.on('ConnectionStateChanged', function (state, reason) {
            console.log("State changed To: " + state + " Reason: " + reason)
        })

        // Set RTM user ID
        options.uid = "1234"
        // Get Token
        options.token = await fetchToken(options.uid)
        // Log in to RTM
        await client.login(options)

        while (!stopped)
        {
            // Renew a token every 30 seconds for demonstration purposes.
            // Agora recommends that you renew a token regularly, such as every hour, in production.
            await sleep(30000)
            options.token = await fetchToken(options.uid)
            client.renewToken(options.token)

            let currentDate = new Date();
            let time = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();

            console.log("Renew RTM token at " + time)
        }

    }

    loginRTM()
    ```

    In the code example, you can see that token is related to the following code logic in the client:
    - Call `login` to log in to the RTM system with token and user ID. You must use the user ID that is used to generate the token.
    - Fetch a new Token from the app server and call `renewToken` to update the token of the SDK at a fixed interval. Agora recommends that you regularly (such as every hour) generate a token from the app server and call `renewToken` to update the token of the SDK to ensure that the token is always valid.

4. Open `index.html` with a supported browser to perform the following actions:
    - Successfully logging in to the RTM system.
    - Renewing a token every 30 seconds.


## Reference

This section introduces token generator libraries, version requirements, and related documents about tokens.

### Token generator libraries

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.

| Language | Algorithm   | Core method                                                                                                                                         | Sample code                                                                                                                                                         |
| -------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C++ | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtmTokenBuilder.h) | [RtmTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtmTokenBuilderSample.cpp) |
| Go | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/RtmTokenBuilder/RtmTokenBuilder.go) | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/RtmTokenBuilder/sample.go) |
| Java | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/rtm/RtmTokenBuilder.java) | [RtmTokenBuilderSample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtmTokenBuilderSample.java) |
| Node.js | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtmTokenBuilder.js) | [RtmTokenBuilderSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtmTokenBuilderSample.js) |
| PHP | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtmTokenBuilder.php) | [RtmTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtmTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py) |
| Python 3 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtmTokenBuilderSample.py) |

### API Reference

This section introduces the method to generate an RTM token. Take Golang as an example:

```golang
func BuildToken(appId string, appCertificate string, userId string, expire uint32) (string, error) {
    token := accesstoken.NewAccessToken(appId, appCertificate, expire)
    serviceRtm := accesstoken.NewServiceRtm(userId)
    serviceRtm.AddPrivilege(accesstoken.PrivilegeLogin, expire)
    token.AddService(serviceRtm)
    return token.Build()
}
```

| Parameter          | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| `appId`              | The App ID of your Agora project.                            |
| `appCertificate`     | The App Certificate of your Agora project.                   |
| `userId`        | The user ID of the RTM system. You need specify the user ID yourself. See the [userId parameter of the login method](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b) for supported character sets.                               |
| `expire` | Number of seconds passed from the generation of AccessToken2 to the expiration of AccessToken2. For example, if you set it as 600, the AccessToken2 expires in 10 minutes after generation. An AccessToken2 is valid for 24 hours at most. If you set it to a period longer than 24 hours, the AccessToken2 is still valid for 24 hours. If you set it to 0, the AccessToken2 expires immediately. |


### Upgrade from AccessToken to AccessToken2<a name="upgrade"></a>

This section introduces how to upgrade from AccessToken to AccessToken2 by example.

#### Prerequisites

- You have deployed a token server and a web client for AccessToken in previous versions.
- You have integrated an [SDK version](#sdk-version) that supports AccessToken2.

#### Update the token server

1. Replace the `rtmtokenbuilder` import statement:

```golang
// Replace "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/RtmTokenBuilder"
// with "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/rtmtokenbuilder2".
import (
    rtmtokenbuilder "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/rtmtokenbuilder2"
    "fmt"
    "log"
    "net/http"
    "time"
    "encoding/json"
    "errors"
    "strconv"
)
```

2. Update the `BuildToken` function:

```golang
// Previously, it is `result, err := rtmtokenbuilder.BuildToken(appID, appCertificate, rtm_uid, rtmtokenbuilder.RoleRtmUser, expireTimestamp)`.
// Now, remove `rtmtokenbuilder.RoleRtmUser`.
result, err := rtmtokenbuilder.BuildToken(appID, appCertificate, rtm_uid, expireTimestamp)
```

#### Test the AccessToken2 server

The client does not need any updates; however, the [expiration logic](#expiration) changes accordingly.


## Considerations

### User ID

The user ID that you use to generate the RTM token must be the same as the one you use to log in to the RTM system.

### App Certificate and RTM token

To use the RTM token for authentication, you need to enable the App Certificate for your project on Console. Once a project has enabled the App Certificate, you must use RTM tokens to authenticate its users.

### RTM Token expiration

AccessToken2 allows you to specify the validity period of an RTM token in seconds based on your business requirements. The validity period can be a maximum of 24 hours.

When a token is about to expire in 30 seconds, the RTM SDK triggers the `onTokenPrivilegeWillExpire` callback. Upon receiving this callback, you can generate a new RTM token on your app server, and call `renewToken` to pass the new RTM token to the SDK.

When an RTM token expires, the subsequent logic varies depending on the connection state of the SDK:

- If the RTM SDK is in the `CONNECTION_STATE_CONNECTED` state, users receive the `onTokenExpired` callback and the `onConnectionStateChanged` callback caused by `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`, notifying that the connection state of the SDK switches to `CONNECTION_STATE_ABORTED`. In this case, users need to log in again via the `login` method.
- If the RTM SDK is in the `CONNECTION_STATE_RECONNECTING` state, users will receive the `onTokenExpired` callback when the network reconnects. In this case, users need to renew the token via the `renewToken` method.

<div class="alert note">Although you can use the <code>onTokenPrivilegeWillExpire</code> and <code>onTokenExpired</code> callbacks to handle token expiration conditions, Agora recommends that you regularly renew the Token (such as every hour) to keep the token valid.</div>

<div class="alert info">The names of methods, callbacks, and enums mentioned in the above section only applies to C++. Refer to the API documentation for names in other platforms.</div>
