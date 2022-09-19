# 使用 Token 鉴权

鉴权是指在用户访问你的系统前，对其进行身份校验。用户在使用 Agora 服务，如加入音视频通话或登录信令系统时，Agora 使用 Token 对其鉴权。

本文展示如何为 AccessToken2 在服务端部署一个 Token 生成器，以及如何搭建一个使用 Token 鉴权的客户端。


## 鉴权原理

~e4d86b10-072b-11ed-a46a-e58831549a58~


## 前提条件

~fc679b70-072b-11ed-a46a-e58831549a58~


## 实现鉴权流程

本节介绍如何使用 Agora 提供的[代码](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey)生成并提供 Token，对用户及其权限进行校验。

### 获取 App ID 及 App 证书

本节介绍如何获取生成 Token 所需的安全信息，如你的项目的 App ID 及 App 证书。

#### 获取 App ID

   ~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

#### 获取 App 证书

   ~7fa0dcd0-4c0c-11ec-8689-2164ade84c59~

### 部署 Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token 生成器会生成相应的 Token，再发送给客户端。

本节展示如何使用 Golang 在你的本地设备上搭建并运行一个 Token 服务器。

此示例服务器使用 `BuildTokenWithUid[1/2]`。

<div class="alert note">此示例服务器仅用于演示，请勿用于生产环境中。 </div>

1. 创建一个 `server.go` 文件，然后贴入如下代码。将其中的 `<Your App ID> `和 `<Your App Certificate>` 替换为你的 App ID 和 App 证书。

```golang
package main
  
import (
    rtctokenbuilder "github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/go/src/RtcTokenBuilder"
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

```golang
$ go mod init sampleServer
```

3. 运行如下命令行安装依赖。你可以使用 Go 镜像进行加速，例如 https://goproxy.cn/ 。

```golang
$ go get
```

4. 运行如下命令行启动服务器：

```golang
$ go run server.go
```

### 使用 Token 对用户鉴权

通过 HTTP 请求部署一个 Token 服务器，并使用获取到的 Token 加入频道。

```dart
// 使用 token 加入频道
await _engine.joinChannel(token: '', channelId: 'channelid', info: '', uid: 0);
```

### 运行项目

在本地设备的 Android 模拟器中构建并运行项目，app 会执行如下操作：

1. 加入频道。
2. 每隔 10 秒更新 token。

~54cbd8e0-0735-11ed-a46a-e58831549a58~