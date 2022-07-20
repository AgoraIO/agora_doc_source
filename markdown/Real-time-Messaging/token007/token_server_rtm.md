<div class="alert note">自 RTM 全平台 1.5.0 版和 Web 1.4.6 版开始，Agora 升级了 Token 鉴权逻辑。<li>如你首次接触该产品，Agora 建议你使用最新版的 RTM SDK 并参照本文档为 AccessToken2 部署服务器和客户端；<li>如你已在先前版本中部署过 AccessToken 鉴权，可以参照 <a href="https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm#upgrade">升级至 AccessToken2</a> 中的步骤快速完成升级。</div>

<div class="alert info">使用 AccessToken2 的 SDK 版本可以和使用 AccessToken 的 SDK 版本互通。同时，支持 AccessToken2 的版本也支持 AccessToken。</div>

鉴权是指在用户访问你的系统前，对其进行身份校验。用户在使用 Agora 服务，如加入音视频通话或登录信令系统时，Agora 使用 Token 对其鉴权。

本文展示如何在服务端部署一个 RTM Token 生成器，以及如何搭建一个使用 RTM Token 鉴权的客户端。

## 鉴权原理

下图展示了鉴权的基本流程：

![RTM Token 鉴权流程](https://web-cdn.agora.io/docs-files/1624437370778)

RTM Token 在 app 服务器上生成，其最长有效期为 24 小时。当用户从你的 app 客户端登录到 RTM 系统时，Agora 平台会读取该 Token 中包含的信息，并进行校验。Token 包含以下信息：

- 你在 Agora 控制台创建项目时生成的 App ID
- RTM 用户 ID
- RTM Token 过期的 Unix 时间戳

## 前提条件

开始前，请确保你的项目或使用的 Agora 产品满足如下条件：

- 一个有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 已开启 [App 证书](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates)的 Agora 项目。
- [Golang](https://golang.org/) 1.14 以上版本，GO111MODULE 设置为开启。
   <div class="alert note">如果你使用的是 Go 1.16 及以上版本，GO111MODULE 已默认开启。详情请参考 <a href="https://blog.golang.org/go116-module-changes">New module changes in Go 1.16</a>。</div>
- [npm](https://www.npmjs.com/get-npm) 以及[支持的浏览器](https://docs.agora.io/cn/All/faq/browser_support)。
- 使用支持 AccessToken2 的 Agora RTM SDK 版本，详情如下：<a name="sdk-version"></a>

| SDK 类型 | 支持 AccessToken2 鉴权的首个版本 |
|:---|:---|
| RTM Android SDK | 1.5.0 |
| RTM iOS SDK | 1.5.0 |
| RTM macOS SDK | 1.5.0 |
| RTM Web SDK | 1.4.6 |
| RTM Windows SDK | 1.5.0 |
| RTM Linux SDK | 1.5.0 |

## 实现鉴权流程

本节介绍如何使用 Agora 提供的[代码](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey)生成并提供 Token，对用户及其权限进行校验。

### 获取 App ID 及 App 证书

本节介绍如何获取生成 Token 所需的安全信息，如你的项目的 App ID 及 App 证书。

#### 1. 获取 App ID

~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

#### 2. 获取 App 证书

~7fa0dcd0-4c0c-11ec-8689-2164ade84c59~

### 部署 Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token Generator 会生成相应的 Token，再发送给客户端。

本节展示如何使用 Golang 在你的本地设备上搭建并运行一个 Token 服务器。

<div class="alert warning">此示例服务器仅用于演示，请勿用于生产环境中。</div>

1. 创建一个 `server.go` 文件，然后贴入如下代码。将其中的 `<Your App ID>`和 `<Your App Certificate>` 替换为你的 App ID 和 App 证书。

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

2. `go.mod` 文件定义导入路径及依赖项。运行如下命令来为你的 Token 服务器创建 `go.mod` 文件：

   ```shell
   $ go mod init sampleServer
   ```

3. 运行如下命令行安装依赖：

   ```shell
   $ go get
   ```

4. 运行如下命令行启动服务器：

   ```shell
   $ go run server.go
   ```

### 使用 Token 对用户鉴权

本节以 Web 客户端为例，展示如何使用 Token 对客户端的用户进行鉴权。

<div class="alert warning">此示例仅用于演示，请勿用于生产环境中。</div>

1. 创建一个项目文件夹，其中包含如下文件：
   - `index.html`：用户界面
   - `client.js`：使用 RTM SDK 的 app 逻辑
   ```text
   |
   |-- index.html
   |-- client.js
   ```

2. 下载 [Agora RTM SDK for Web](https://docs.agora.io/cn/Real-time-Messaging/downloads?platform=Web)。将 `libs` 中的 JS 文件保存到你的项目下。

3. 在 `index.html` 中加入以下代码，创建用户界面。
    - 你需要将 `<path to the JS file>` 替换为你上一步保存的 JS 文件的路径。

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

4. 将如下代码贴入 `client.js` 文件中，实现客户端鉴权逻辑。
    - 将 `<Your App ID>` 替换为你的 App ID。该 App ID 必须与 Token 生成代码中的 App ID 一致。
    - 将 `<Your Host URL and port>` 替换为你部署好的本地 Golang 服务器的主机 URL 和端口，如 `10.53.3.234:8082` 。

    ```js
    // login 方法参数
    let options = {
        token: "",
        uid: ""
    }

    // 是否开启 Token 更新循环
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

        // 你的 app ID
        const appID = "<Your App ID>"

        // 初始化客户端
        const client = AgoraRTM.createInstance(appID)

        // 显示连接状态变化
        client.on('ConnectionStateChanged', function (state, reason) {
            console.log("State changed To: " + state + " Reason: " + reason)
        })

        // 设置 RTM 用户 ID
        options.uid = "1234"
        // 获取 Token
        options.token = await fetchToken(options.uid)
        // 登录 RTM 系统
        await client.login(options)

        while (!stopped)
        {
            // 每 30 秒更新一次 Token。此更新频率是为了功能展示。生产环境建议每小时更新一次。
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

   在上述代码示例中，你可以看到 Token 与客户端的以下代码逻辑有关：
   - 调用 `login` 方法，使用 Token 和用户 ID 登录 RTM 系统。用户 ID 必须和用于生成 Token 的用户 ID 一致。
   - 定时从服务端获取新的 Token 并调用 `renewToken` 方法更新 SDK 的 Token。Agora 建议你定时（例如每小时）从服务端生成 Token 并调用 `renewToken` 方法更新 SDK 的 Token，保证 SDK 的 Token 一直处于有效状态。

4. 用支持的浏览器打开 `index.html` 文件，进入开发者模式。在控制台可以看到客户端执行以下操作：
   - 成功登录 RTM 系统。
   - 每隔 30 秒调用 `renewToken` 方法更新 Token。


## 参考

### Token 生成器代码

Agora 在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。

| 语言 | 算法 | 核心方法 | 示例代码 |
| -------- | ----------- | ---------- | ---------------- |
| C++ | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtmTokenBuilder2.h) | [RtmTokenBuilder2Sample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtmTokenBuilder2Sample.cpp) |
| Go | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/rtmtokenbuilder2/rtmtokenbuilder.go) | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/rtmtokenbuilder2/sample.go) |
| Java | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/rtm/RtmTokenBuilder2.java) | [RtmTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtmTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder2.js) | [RtmTokenBuilder2Sample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilder2Sample.js) |
| PHP | HMAC-SHA256 | [buildToken](hhttps://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtmTokenBuilder2.php) | [RtmTokenBuilder2Sample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtmTokenBuilder2Sample.php) |
| Python 2 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtmTokenBuilder2.py) | [RtmTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtmTokenBuilder2Sample.py) |
| Python 3 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtmTokenBuilder2.py) | [RtmTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtmTokenBuilder2Sample.py) |

### API 参考

本节介绍生成 Token 的 API 参数和描述。以 Golang 为例：

```golang
func BuildToken(appId string, appCertificate string, userId string, expire uint32) (string, error) {
    token := accesstoken.NewAccessToken(appId, appCertificate, expire)

    serviceRtm := accesstoken.NewServiceRtm(userId)
    serviceRtm.AddPrivilege(accesstoken.PrivilegeLogin, expire)
    token.AddService(serviceRtm)

    return token.Build()
}
```

| 参数               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| `appId`              | 你在 Agora 控制台创建项目时生成的 App ID。                   |
| `appCertificate`     | 你的 App 证书。                                              |
| `userId`        | 用于登录 RTM 系统的用户 ID。你需要自行设定。支持的字符参考 [login 方法中的 userId 参数](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b)。                                            |
| `expire` | RTM Token 过期的 Unix 时间戳，单位为秒。该值为当前时间戳和 Token 有效期的总和。 例如，如果你将 `expire` 设为当前时间戳再加 600 秒，则 RTM Token 会在 10 分钟内过期。 RTM Token 的最大有效期为 24 小时。 如果你将此参数设为 0，或时间长度超过 24 小时，Token 有效期依然为 24 小时。 |


### 将 AccessToken 服务器升级至 AccessToken2<a name="upgrade"></a>

该小节引导你将 AccessToken 服务端鉴权机制升级到 AccessToken2。

#### 前提条件

- 你已为 AccessToken 部署了服务器及客户端；
- 你已集成支持 AccessToken2 的 [SDK 版本](#sdk-version)；

#### 更新 Token 服务器部署

1. 替换 `rtmtokenbuilder` 导入声明：

```golang
// 将原先的 "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/RtmTokenBuilder"
// 替换为 "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/rtmtokenbuilder2"
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

2. 更新 `BuildToken` 函数：

```golang
// 原先为 result, err := rtmtokenbuilder.BuildToken(appID, appCertificate, rtm_uid, rtmtokenbuilder.RoleRtmUser, expireTimestamp)
// 现移除 rtmtokenbuilder.RoleRtmUser
result, err := rtmtokenbuilder.BuildToken(appID, appCertificate, rtm_uid, expireTimestamp)
```

#### 测试服务器和客户端的连接

客户端无需更新，仅需关注升级至 AccessToken2 后 [客户端鉴权逻辑的改变](#expiration)。


## 开发注意事项

### 参数匹配

生成 RTM Token 时填入的用户 ID，需要和登录 RTM 系统时填入的用户 ID 一致。

### App 证书与 RTM Token

生成 RTM Token 需要先在控制台启用对应项目的 App 证书。项目一旦开启了 App 证书，就必须使用 RTM Token 鉴权。

### RTM Token 过期<a name="expiration"></a>

你可以根据业务需求指定 RTM Token 的有效期 (最长为 24 小时)。当 RTM Token 临 30 秒过期时，会触发 `onTokenPrivilegeWillExpire` 回调，提醒用户 Token 即将过期。收到该回调时，你可以在服务端重新生成 RTM Token，然后调用 `renewToken` 方法，将新生成的 RTM Token 传给 SDK。

Token 过期时，分为以下两种情况：
- 如果用户处于已连接状态 (`CONNECTION_STATE_CONNECTED`)，会收到 `onTokenExpired` 回调和因 Token 过期 (`CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`) 触发的 `onConnectionStateChanged` 回调，提醒用户连接状态切换至停止登录 (`CONNECTION_STATE_ABORTED`)。此时，用户需要调用 `login` 方法重新登录。
- 如果用户由于网络问题处于断线重连状态 (`CONNECTION_STATE_RECONNECTING`)，会在网络恢复时收到 `onTokenExpired` 回调。此时，用户需要调用 `renewToken` 方法恢复连接。

<div class="alert note">你可以通过 <code>onTokenPrivilegeWillExpire</code> 回调和 <code>onTokenExpired</code> 回调进行 Token 过期处理，但 Agora 推荐你通过定时（例如每小时）更新 Token 来解决 Token 过期问题。</div>

<div class="alert info">该小节的方法、回调、枚举名仅适用于 C++ SDK，其他平台的方法、回调、枚举名可参考各平台的 API 文档。</div>