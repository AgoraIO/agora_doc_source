Authentication is the act of validating the identity of each user before they access your system. Agora uses digital tokens to authenticate users and their privileges before they access an Agora service, such as joining an Agora call, or logging into the real-time messaging system.

This document shows you how to create a token server and a client app. The client app retrieves a token from the token server. This token authenticates the current user when the user accesses the Agora service.

## Understand the tech

The following figure shows the steps in the authentication flow:

![token authentication flow](https://web-cdn.agora.io/docs-files/1618395721208)

A token is a dynamic key generated on your app server that is valid for a maximum of 24 hours. When your users connect to an Agora channel from your app client, Agora Platform validates the token and reads the user and project information stored in the token. A token contains the following information:

- The App ID of your Agora project
- The App Certificate of your Agora project
- The channel name
- The user ID of the user to be authenticated
- The privilege of the user, either as a publisher or a subscriber
- The Unix timestamp when the token expires

## Prerequisites

In order to follow this procedure you must have the following:

- A project based on [Get Started with Interactive Live Streaming Premium](./start_live_ios).
- [Golang](https://golang.org/) 1.14+ with GO111MODULE set to on.
    <div class="alert note"> If you are using Go 1.16+, GO111MODULE is on by default. See <a href="https://blog.golang.org/go116-module-changes">this blog</a> for details.</div>

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users using the [source code](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) provided by Agora.

### Get the App ID and App Certificate

This section shows you how to get the security information needed to generate a token, including the App ID and App Certificate of your project.

1. Get the App ID.

    Agora automatically assigns each project an App ID as a unique identifier. To copy this App ID, find your project on the [Project Management](https://dashboard.agora.io/projects) page in Agora Console, and click the eye icon to the right of the App ID.

    ![Get App ID](https://web-cdn.agora.io/docs-files/1602646621028)

2. Get the App Certificate.

    Click **Edit** and enter the **Edit Project** page. Click the eye icon to copy the App certificate.

    ![Get App Cert](https://web-cdn.agora.io/docs-files/1592535534341)

### Deploy a token server

Token generators create the tokens requested by your client app to enable secure access to Agora Platform. To serve these tokens you deploy a generator in your security infrastructure.

In order to show the authentication workflow, this section shows how to build and run a token server written in Golang on your local machine.

<div class="alert warning">This sample server is for demonstration purposes only. Do not use it in a production environment.</div>

1. Create a file, `server.go`, with the following content. Then replace `<Your App ID>` and `<Your App Certificate>` with your App ID and App Certificate.

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

    // Use RtcTokenBuilder to generate an RTC token.
    func generateRtcToken(int_uid uint32, channelName string, role rtctokenbuilder.Role){

        appID := "<Your App ID>"
        appCertificate := "<Your App Certificate>"
        // Number of seconds after which the token expires.
        // For demonstration purposes the expiry time is set to 40 seconds. This shows you the automatic token renew actions of the client.
        expireTimeInSeconds := uint32(40)
        // Get current timestamp.
        currentTimestamp := uint32(time.Now().UTC().Unix())
        // Timestamp when the token expires.
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
                        // DEPRECATED. RoleAttendee has the same privileges as RolePublisher.
                        role = rtctokenbuilder.RoleAttendee
                    case 1:
                        role = rtctokenbuilder.RolePublisher
                    case 2:
                        role = rtctokenbuilder.RoleSubscriber
                    case 101:
                        // DEPRECATED. RoleAdmin has the same privileges as RolePublisher.
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

This section uses the iOS client as an example to show how to use a token for client-side user authentication.

In order to show the authentication workflow, this section shows how to build and run an iOS client on the simulator of your local machine.

<div class="alert warning">This sample client is for demonstration purposes only. Do not use it in a production environment.</div>

1. Based on the project you have created in [Get Started with Interactive Live Streaming Premium
](./start_live_ios), replace the content in `ViewController.swift` with the following code. Replace `Your App ID` with your App ID. The App ID must match the one in the server. You also need to replace &lt;Your Host URL and port&gt; with the host URL and port of the local Golang server you have just deployed, such as 10.53.3.234:8082.

In the code example, you can see that token is related to the following code logic in the client:

- Call `joinChannel` to join the channel with token, uid, and channel name. The uid and channel name must be the same as the ones used to generate the token.
- The `tokenPrivilegeWillExpire` callback occurs 30 seconds before a token expires. When the `tokenPrivilegeWillExpire` callback is triggered，the client must fetch the token from the server and call renewToken to pass the new token to the SDK.
- The `rtcEngineRequestToken` callback occurs when a token expires. When the `rtcEngineRequestToken` callback is triggered, the client must fetch the token from the server and call `joinChannel` to use the new token to join the channel.

    ```java
    //
    //  ViewController.swift
    //  RteQuickstart
    //
    //  Created by macoscatalina on 2021/8/12.
    //  Copyright © 2021 macoscatalina. All rights reserved.
    //

    import UIKit
    import AgoraRtcKit

    import Foundation

    public enum TokenError: Error{
        case noData
        case invalidData
    }

    class ViewController: UIViewController {
        var localView: UIView!
        var remoteView: UIView!

        var agoraKit: AgoraRtcEngineKit!

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            initView()
            initializeAgoraEngine()
            setClientRole()
            setupLocalVideo()
            fetchToken(channelName: "test", userId: 1234, role: 1){ result in
                switch result {
                case .success(let token):
                    print("token is: \(token)")
                    self.joinChannel(token: token)
                case .failure(let err):
                    print("Could not fetch token: \(err)")
                }
            }

        }

        override func viewDidLayoutSubviews(){
            super.viewDidLayoutSubviews()
            remoteView.frame = self.view.bounds
            localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
            }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)
            leaveChannel()
            destroy()

        }

        func initView(){
            remoteView = UIView()
            self.view.addSubview(remoteView)
            localView = UIView()
            self.view.addSubview(localView)
        }

        func initializeAgoraEngine(){
            let config = AgoraRtcEngineConfig()
            config.appId = "Your App ID"
            config.channelProfile = .liveBroadcasting
            agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
            if agoraKit != nil{
                print("Initialization successful")
            }
            else{
                print("Initialization failed")
            }
        }

        func setClientRole(){
            agoraKit.setClientRole(.broadcaster)
        }

        func setupLocalVideo(){
            agoraKit.enableVideo()
            agoraKit.startPreview()
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = 0
            videoCanvas.renderMode = .hidden
            videoCanvas.view = localView
            agoraKit.setupLocalVideo(videoCanvas)
        }

        func joinChannel(token:String){
            let option = AgoraRtcChannelMediaOptions()
            agoraKit.joinChannel(byToken: token, channelId: "test", uid: 123456, mediaOptions: option)
        }

        func leaveChannel(){
            agoraKit.stopPreview()
            agoraKit.leaveChannel(nil)
        }

        func destroy(){
            AgoraRtcEngineKit.destroy()
        }

        func fetchToken(channelName: String, userId: UInt, role: UInt,
            callback: @escaping (Result<String, Error>) -> Void
        ){
            let url = URL(string: "http://<Your Host URL and port>/fetch_rtc_token")
            let parameters = ["uid":userId,"channelName": channelName, "role": role] as [String : Any]

            print(parameters.self)


            var request = URLRequest(
                url: url!,
                timeoutInterval: 10
            )

            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
            catch let error {
                print(error.localizedDescription)
            }

            URLSession.shared.dataTask(with: request){data, _, err in
                guard let data = data else {
                    if let err = err {
                        callback(.failure(err))
                    }
                    else {
                        callback(.failure(TokenError.noData))
                    }

                return
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            if let responseDict = responseJSON as? [String: Any], let token = responseDict["token"] as? String {
                callback(.success(token))
            } else {
                callback(.failure(TokenError.invalidData))
            }

        }.resume()

    }
    }

    extension ViewController: AgoraRtcEngineDelegate{

        func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int){
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = uid
            videoCanvas.renderMode = .hidden
            videoCanvas.view = remoteView
            agoraKit.setupRemoteVideo(videoCanvas)
        }

        func rtcEngine(_ engine: AgoraRtcEngineKit, tokenPrivilegeWillExpire token: String) {
            self.fetchToken(channelName: "test", userId: 1234, role: 1){ result in
                switch result {
                case .success(let token):
                    print("token is: \(token)")
                    self.agoraKit.renewToken(token)
                    print("Renewed the token")
                case .failure(let err):
                    print("Could not fetch token: \(err)")
                }
            }
        }

        func rtcEngine(_ engine: AgoraRtcEngineKit, connectionStateChanged state: AgoraConnectionState, reason: AgoraConnectionChangedReason) {
            print("Connection state changed to")
            print(state.rawValue)
        }

        func rtcEngineRequestToken(_ engine: AgoraRtcEngineKit) {
            fetchToken(channelName: "test", userId: 1234, role: 1){ result in
                switch result {
                    case .success(let token):
                        print("token is: \(token)")
                        self.joinChannel(token: token)
                    case .failure(let err):
                        print("Could not fetch token: \(err)")
                    }
            }
        }

    }

    ```

### Test your implementation

Build and run the project in your iOS simulator in the local machine to perform the following actions:
- Join a channel.
- Renew a token every 10 seconds.

## Reference

This section introduces token generator libraries, version requirements, and related documents about tokens.

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

### API Reference

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
| `appId`              | The App ID of your Agora project.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `appCertificate`     | The App Certificate of your Agora project.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `channelName`        | The channel name. The string length must be less than 64 bytes. Supported character scopes are: <ul><li>All lowercase English letters: a to z.</li><li>All upper English letters: A to Z.</li><li>All numeric characters: 0 to 9.</li><li>The space character.</li><li>Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ",".</li></ul>                                                                                                                                    |
| `uid`                | The user ID of the user to be authenticated. A 32-bit unsigned integer with a value range from 1 to (2³² - 1). It must be unique. Set `uid` as 0, if you do not want to authenticate the user ID, that is, any `uid` from the app client can join the channel.                                                                                                                                                                                                                                                                                                                                                                                |
| `role`               | The privilege of the user, either as a publisher or a subscriber. This parameter determines whether a user can publish streams in the channel. <ul><li>`Role_Publisher(1)`: (Default) The user has the privilege of a publisher, that is, the user can publish streams in the channel.</li><li>`Role_Subscriber(2)`: The user has the privilege of a subscriber, that is, the user can only subscribe to streams, not publish them, in the channel. </li></ul>This value takes effect only if you have enabled co-host authentication. For details, see FAQ [How do I use co-host authentication](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost). |
| `privilegeExpiredTs` | The Unix timestamp (s) when the token expires, represented by the sum of the current timestamp and the valid time of the token. For example, if you set `privilegeExpiredTs` as the current timestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is still valid for 24 hours.                          |
