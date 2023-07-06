鉴权是指在用户访问你的系统前，对其进行身份校验。用户在使用声网服务，如加入音视频通话或登录信令系统时，声网使用 Token 对其鉴权。

为提供更好的鉴权体验和安全性保障，声网自 2022 年 8 月 18 日推出新版 Token：AccessToken2。如需从 AccessToken 升级至 AccessToken2，请参考 <a href="./token_upgrade">AccessToken 升级指南</a>。

本文展示如何为 AccessToken2 在服务端部署一个 Token 生成器，以及如何搭建一个使用 Token 鉴权的客户端。

## 鉴权原理

~e4d86b10-072b-11ed-a46a-e58831549a58~

## 前提条件

~fc679b70-072b-11ed-a46a-e58831549a58~

## 实现鉴权流程

本节介绍如何使用声网提供的[代码](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey)生成并提供 Token，对用户及其权限进行校验。

### 获取 App ID 及 App 证书

本节介绍如何获取生成 Token 所需的安全信息，如你的项目的 App ID 及 App 证书。

#### 获取 App ID

~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

#### 获取 App 证书

~7fa0dcd0-4c0c-11ec-8689-2164ade84c59~

### 为 AccessToken2 部署 Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token Generator 会生成相应的 Token，再发送给客户端。

本节展示如何使用 Golang 在你的本地设备上搭建并运行一个 Token 服务器。

此示例服务器使用 `BuildTokenWithUid`[1/2]。

<div class="alert warning">此示例服务器仅用于演示，请勿用于生产环境中。</div>

1. 创建一个 `server.go` 文件，然后贴入如下代码。将其中的 `<Your App ID>`和 `<Your App Certificate>` 替换为你的 App ID 和 App 证书。

```golang
package main

import (
    rtctokenbuilder "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/rtctokenbuilder2"
    "fmt"
    "log"
    "net/http"
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

// 使用 RtcTokenBuilder 来生成 RTC Token
func generateRtcToken(int_uid uint32, channelName string, role rtctokenbuilder.Role){

    appID := "<Your App ID>"
    appCertificate := "<Your App Certificate>"
    // AccessToken2 过期的时间，单位为秒
    // 当 AccessToken2 过期但权限未过期时，用户仍在频道里并且可以发流，不会触发 SDK 回调。
    // 但一旦用户和频道断开连接，用户将无法使用该 Token 加入同一频道。请确保 AccessToken2 的过期时间晚于权限过期时间。
    tokenExpireTimeInSeconds := uint32(40)
    // 权限过期的时间，单位为秒。
    // 权限过期30秒前会触发 token-privilege-will-expire 回调。
    // 权限过期时会触发 token-privilege-did-expire 回调。
    // 为作演示，在此将过期时间设为 40 秒。你可以看到客户端自动更新 Token 的过程
    privilegeExpireTimeInSeconds := uint32(40)

    result, err := rtctokenbuilder.BuildTokenWithUid(appID, appCertificate, channelName, int_uid, role, tokenExpireTimeInSeconds, privilegeExpireTimeInSeconds)
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
                    case 1:
                        role = rtctokenbuilder.RolePublisher
                    case 2:
                        role = rtctokenbuilder.RoleSubscriber
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
    // 使用 int 型 uid 生成 RTC Token
    http.HandleFunc("/fetch_rtc_token", rtcTokenHandler)
    fmt.Printf("Starting server at port 8082\n")

    if err := http.ListenAndServe(":8082", nil); err != nil {
        log.Fatal(err)
    }
}
```

2. `go.mod` 文件定义导入路径及依赖项。运行如下命令行来为你的 Token 服务器创建 `go.mod` 文件：

   ```shell
   $ go mod init sampleServer
   ```

3. 运行如下命令行安装依赖。你可以使用 Go 镜像进行加速，例如 https://goproxy.cn/ 。

   ```shell
   $ go get
   ```

4. 运行如下命令行启动服务器：

   ```shell
   $ go run server.go
   ```

### 使用 AccessToken2 对用户鉴权

本节以 Web 客户端为例，展示如何使用 Token 对客户端的用户进行鉴权。

<div class="alert warning">此示例仅用于演示，请勿用于生产环境中。</div>

1. 创建一个项目文件夹，其中包含如下文件：
   - `index.html`：用户界面
   - `client.js`：使用声网 RTC Web SDK 4.x（必须为 4.8.0 或更高版本）的 app 逻辑
   ```text
   |
   |-- index.html
   |-- client.js
   ```

2. 在 `index.html` 中加入以下代码，创建用户界面：

   ```html
   <html>
   <head>
      <title>Token demo</title>
   </head>
   <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
   <body>
      <h1>Token demo</h1>
      <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.8.0.js"></script>
    <script src="./client.js"></script>

   </body>
   </html>
   ```

3. 将如下代码贴入 `client.js` 文件中，实现客户端鉴权逻辑。
    - 将 `<Your App ID>` 替换为你的 App ID。该 App ID 必须与 Token 生成代码中的 App ID 一致。
    - 将 `<Your Host URL and port>` 替换为你部署好的本地 Golang 服务器的主机 URL 和端口，如 `10.53.3.234:8082` 。

```js
var rtc = {
     // 设置本地音频轨道和视频轨道。
     localAudioTrack: null,
     localVideoTrack: null,
 };

 var options = {
     // 传入 App ID。
     appId: "<Your app ID>",
     // 传入频道名。
     channel: "ChannelA",
     // 设置用户为 host (可发流) 或 audience（仅可收流）。
     role: "host"
 };

 // 从 Golang 服务器获取 Token。

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

     // 将获取到的 Token 赋值给 join 方法中的 token 参数，然后加入频道。
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

     // 收到 token-privilege-will-expire 回调时，从服务器重新申请一个 Token，并调用 renewToken 将新的 Token 传给 SDK。
     client.on("token-privilege-will-expire", async function () {
         let token = await fetchToken(uid, options.channel, 1);
         await client.renewToken(token);
     });

     // 收到 token-privilege-did-expire 回调时，从服务器重新申请一个 Token，并调用 join 重新加入频道。
     client.on("token-privilege-did-expire", async function () {
         console.log("Fetching the new Token")
         let token = await fetchToken(uid, options.channel, 1);
         console.log("Rejoining the channel with new Token")
         await client.join(options.appId, options.channel, token, uid);
     });

 }

 startBasicCall()
```


   在上述代码示例中，你可以看到 Token 与客户端的以下代码逻辑有关：
   - 调用 `join` 方法，使用 Token、用户 ID 和频道名加入频道。用户 ID 和频道名必须和用于生成 Token 的用户 ID 和频道名一致。
   - 在权限过期前 30 秒，SDK 会触发 `token-privilege-will-expire` 回调。收到该回调后，客户端需要从服务器获取新的 Token 并调用 `renewToken` 方法将新生成的 Token 传给 SDK。
   - 权限过期时，SDK 会触发 `token-privilege-did-expire` 回调。收到该回调后，客户端需要从服务器获取新的 Token 并调用 `join` 方法，再使用新的 Token 重新加入频道。

4. 用支持的浏览器打开 `index.html` 文件，可以看到客户端执行以下操作：
   - 成功加入频道。
   - 每隔 10 秒更新 Token。


## 参考

本节提供与 Token 鉴权相关的参考文档。

### AccessToken2 对 SDK 的兼容性要求

AccessToken2 支持以下版本的声网 RTC SDK （不包括客户端旁路推流功能）：

| SDK                  | 版本     |
| -------------------- | -------- |
| RTC Native SDK       | >= 3.6.0 |
| RTC Electron SDK     | >= 3.6.0 |
| RTC Unity SDK        | >= 3.6.0 |
| RTC React Native SDK | >= 3.6.0 |
| RTC Flutter SDK      | >= 5.10  |
| RTC Web SDK          | >= 4.8.0 |


使用 AccessToken2 的 RTC SDK 可与使用 AccessToken 的 RTC SDK 互通。支持 AccessToken2 的 RTC SDK 也支持 AccessToken。

### AccessToken2 生成器代码

声网在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。

| 语言 | 算法 | 核心方法 | 示例代码 |
| -------- | ----------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| C++      | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/cpp/src/RtcTokenBuilder2.h)                              | [RtcTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtcTokenBuilder2Sample.cpp)                           |
| Go       | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/go/src/rtctokenbuilder2/rtctokenbuilder.go)              | [sample.go](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/go/sample/rtctokenbuilder2/sample.go)                                            |
| Java     | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media/RtcTokenBuilder2.java) | [RtcTokenBuilderSample.java](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtcTokenBuilder2Sample.java) |
| Node.js  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder2.js)                          | [RtcTokenBuilderSample.js](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilder2Sample.js)                          |
| PHP      | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/php/src/RtcTokenBuilder2.php)                            | [RtcTokenBuilderSample.php](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/php/sample/RtcTokenBuilder2Sample.php)                           |
| Python   | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/python/src/RtcTokenBuilder2.py)                          | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/python/sample/RtcTokenBuilder2Sample.py)                          |
| Python3  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/python3/src/RtcTokenBuilder2.py)                         | [RtcTokenBuilderSample.py](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/python3/sample/RtcTokenBuilder2Sample.py)                         |

### BuildTokenWithUid API 参考

本节介绍生成 AccessToken2 的核心方法 `BuildTokenWithUid`。AccessToken2 生成器代码中提供两个 `BuildTokenWithUid` 方法：

- `BuildTokenWithUid` [1/2]：生成 AccessToken2，并设置 AccessToken2 和所有权限的过期时间。
- `BuildTokenWithUid` [2/2]：生成 AccessToken2，并设置如下过期时间：
 * AccessToken2 过期时间
 * 加入频道权限的过期时间
 * 频道内发布音频流权限的过期时间
 * 频道内发布视频流权限的过期时间
 * 频道内发布数据流权限的过期时间

#### BuildTokenWithUid [1/2]

该方法使用 `token_expire` 参数设置 AccessToken2 的过期时间，使用 `privilege_expire` 参数设置所有权限的过期时间。

```C++
// 以 C++ 为例
static std::string buildTokenWithUid(
    const std::string& appId,
    const std::string& appCertificate,
    const std::string& channelName,
    uint32_t uid,
    UserRole role,
    uint32_t privilegeExpiredTs = 0);
```

| 参数 | 描述 |
| -------------------- | ------------------------------------------------------------ |
| `appId` | 你在声网控制台创建项目时生成的 App ID。|
| `appCertificate` | 你的项目的 App 证书。 |
| `channelName` | 频道名称，长度在 64 个字节以内。以下为支持的字符集范围：<ul><li>26 个小写英文字母 a-z；</li><li>26 个大写英文字母 A-Z；</li><li>10 个数字 0-9；</li><li>空格</li><li>标点符号和其他符号, 包括: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ",".</li></ul> |
| `uid` | 待鉴权用户的用户 ID  32 位无符号整数，范围为1到 (2³² - 1)，  并保证唯一性。  如不需对用户 ID 进行鉴权，即客户端使用任何 `uid` 都可加入频道，请把 `uid` 设为 0。 |
| `role` | 用户权限，分为发流用户和接收用户。参数决定用户是否能在频道中发流。<ul><li>`kRole_Publisher(1)`：（默认）用户有发流权限，即用户可在频道中发流。</li><li>`kRole_Subscriber(2)`：用户有接收权限，即用户可在频道中接收，但不可发流。</li></ul>该参数仅在开启连麦鉴权后才生效。详情参考[开启连麦鉴权](#enable_cohost)。 |
| `token_Expire` | AccessToken2 从生成到过期的时间长度，单位为秒。例如，如果你将 `token_Expire` 设为 600 ，则 AccessToken2 会在生成后 10 分钟过期。AccessToken2 的最大有效期为 24 小时。 如果你将此参数设为超过 24 小时的时间，AccessToken2 有效期依然为 24 小时。如果你将此参数设为 0，AccessToken2 立即过期。 |
| `privilege_Expire` | 从 AccessToken2 生成到所有权限过期的时间长度，单位为秒。例如，如果你将 `privilege_Expire` 设为 600 ，则权限会在生成后 10 分钟过期。如果你将此参数设为 0（默认值），则权限永不过期。 |

<div class="alert info">当 AccessToken2 过期但权限未过期时，用户仍在频道里并且可以发流，不会触发 SDK 中与 Token 相关的任何回调。但是一旦和频道断开连接，用户将无法使用该 Token 加入同一频道。因此，确保 AccessToken2 的过期时间晚于权限过期时间。</div>


#### BuildTokenWithUid [2/2]

为支持在权限级别设置过期时间，声网还提供 `BuildTokenWithUid` 的同名重载方法。支持你设置 AccessToken2 的过期时间以及以下权限的过期时间：
- 加入频道
- 频道内发布音频流
- 频道内发布视频流
- 频道内发布数据流

```C++
// 以 C++ 为例
static std::string BuildTokenWithUid(
       const std::string& app_id,
       const std::string& app_certificate,
       const std::string& channel_name,
       uint32_t uid,
       uint32_t token_expire,
       uint32_t join_channel_privilege_expire = 0,
       uint32_t pub_audio_privilege_expire = 0,
       uint32_t pub_video_privilege_expire = 0,
       uint32_t pub_data_stream_privilege_expire = 0);
```

该方法生成 RTC AccessToken2，支持你设置 AccessToken2 的过期时间以及以下权限的过期时间：
- 加入 RTC 频道
- 在 RTC 频道中发布音频流
- 在 RTC 频道中发布视频流
- 在 RTC 频道中发布数据流
其中，在 RTC 频道中发布音频流、视频流和数据流的权限仅在[开启连麦鉴权](#enable_cohost)后才生效。

一个用户可以设置多个权限。每个权限的最大有效时间为 24 小时。权限即将过期或已经过期后，SDK 会分别触发 `onTokenPriviegeWillExpire` 或 `onRequestToken` 回调。你需要在 app 逻辑中添加如下操作：
1. 识别即将过期或已经过期的是哪类权限。
2. App 从 Token 服务器获取新的 AccessToken2。
3. SDK 调用` renewToken` 以更新 AccessToken2。

你需要根据实际业务场景设置合理的过期时间。例如，如果加入频道的权限过期时间早于发布音频流权限的过期时间，则在加入频道的权限过期后，用户就会被踢出 RTC 频道；即便发布音频流的权限没有过期，对用户来讲这个权限是没有意义的。

<div class="alert info">当 AccessToken2 过期但加入频道的权限未过期时，用户仍在频道里，并且只要发流权限未过期就可以发流，不会触发 SDK 中与 Token 相关的任何回调。但一旦和频道断开连接，用户将无法使用该 Token 加入同一频道。因此，确保 AccessToken2 的过期时间晚于其他权限过期时间。</div>

| 参数 | 描述 |
| -------------------- | ------------------------------------------------------------ |
| `token_Expire` | AccessToken2 从生成到过期的时间长度，单位为秒。例如，如果你将 `token_Expire` 设为 600 ，则 AccessToken2 会在生成后 10 分钟过期。AccessToken2 的最大有效期为 24 小时。 如果你将此参数设为超过 24 小时的时间，AccessToken2 有效期依然为 24 小时。如果你将此参数设为 0，AccessToken2 立即过期。 |
| `join_channel_privilege_expire` | 从 AccessToken2 生成到加入频道权限过期的时间长度，单位为秒。例如，如果你将此参数为 600 ，则加入频道权限会在 AccessToken2 生成后 10 分钟过期。如果你将此参数设为 0（默认值），则加入频道权限永不过期。 |
| `pub_audio_privilege_expire` | 从 AccessToken2 生成到在频道内发布音频流的权限过期的时间长度，单位为秒。例如，如果你将此参数为 600 ，则发布语音流权限会在 AccessToken2 生成后 10 分钟过期。如果你将此参数设为 0（默认值），则发布语音流权限永不过期。 |
| `pub_video_privilege_expire` | 从 AccessToken2 生成到在频道内发布视频流的权限过期的时间长度，单位为秒。例如，如果你将此参数为 600 ，则发布视频流权限会在 AccessToken2 生成后 10 分钟过期。如果你将此参数设为 0（默认值），则发布视频流权限永不过期。 |
| `pub_data_stream_privilege_expire` | 从 AccessToken2 生成到在频道内发布数据流的权限过期的时间长度，单位为秒。例如，如果你将此参数为 600 ，则发布数据流权限会在 AccessToken2 生成后 10 分钟过期。如果你将此参数设为 0（默认值），则发布数据流权限永不过期。 |

<a name="enable_cohost"/>

### 开启连麦鉴权

~fa66c8c0-0733-11ed-a46a-e58831549a58~

### AccessToken 升级指南

声网提供 <a href="./token_upgrade">AccessToken 升级指南</a>向你介绍如何使用 AccessToken 鉴权，如何升级至 AccessToken2。