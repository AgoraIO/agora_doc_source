鉴权是指在用户访问你的系统前，对其进行身份校验。用户在使用声网服务，如加入教室时，声网使用 Token 对其鉴权。

为提供更好的鉴权体验和安全性保障，声网自 2022 年 8 月 18 日推出新版 Token：AccessToken2。我们推荐使用 AccessToken2，同时也兼容 AccessToken。

本文提供如何使用 AccessToken2 在服务端部署一个 Token 生成器，如何在客户端使用 Token 鉴权，以及相关的参考信息。

## 鉴权原理

下图展示了鉴权的基本流程：

![FCR Token 鉴权流程](https://web-cdn.agora.io/docs-files/1684224617298)

声网 Token 在 app 服务器上生成，其最长有效期为 24 小时。当用户从你的 app 客户端登录到灵动课堂服务器时，声网平台会读取该 Token 中包含的信息，并进行校验。Token 包含以下信息：

- 你在声网控制台创建项目时生成的 App ID
- 灵动课堂用户 ID
- Token 过期的 Unix 时间戳

## 前提条件

开始前，请确保你的项目或使用的声网产品满足如下条件：

- 一个有效的[声网账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 已开启 [App 证书](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates)的声网项目。
- [Golang](https://golang.org/) 1.14 以上版本，GO111MODULE 设置为开启。
   <div class="alert note">如果你使用的是 Go 1.16 及以上版本，GO111MODULE 已默认开启。详情请参考 <a href="https://blog.golang.org/go116-module-changes">New module changes in Go 1.16</a>。</div>
- [npm](https://www.npmjs.com/get-npm) 以及[支持的浏览器](https://docs.agora.io/cn/All/faq/browser_support)。


## 实现鉴权流程

本节介绍如何使用声网提供的 [Token 生成器](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey)生成并提供 Token，对用户及其权限进行校验。

### 获取 App ID 及 App 证书

本节介绍如何获取生成 Token 所需的安全信息，如你的项目的 App ID 及 App 证书。

#### 1. 获取 App ID

~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

#### 2. 获取 App 证书

~7fa0dcd0-4c0c-11ec-8689-2164ade84c59~

### 为 AccessToken2 部署 Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token 生成器会生成相应的 Token，再发送给客户端。

本节展示如何使用 Golang 在你的本地设备上搭建并运行一个 Token 服务器。

<div class="alert warning">此示例服务器仅用于演示，请勿用于生产环境中。</div>

1. 创建一个 `server.go` 文件，然后贴入如下代码。将其中的 `<Your App ID>`和 `<Your App Certificate>` 替换为你的 App ID 和 App 证书。

    ```golang
    package main

    import (
        educationTokenBuilder "github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src/educationTokenBuilder"
        "fmt"
        "log"
        "net/http"
        "time"
        "encoding/json"
        "errors"
        "strconv"
    )

    type education_token_struct struct {
        roomUuid string `json:"roomUuid"`
        userUuid string `json:"userUuid"`
        role int `json:"role"`
    }

    var educationToken string

    func generateEducationToken(roomUuid string, userUuid string, role int) {
        appID := "Your_App_ID"
        appCertificate := "Your_Certificate"
        expire := uint32(3600)

        result, err := educationtokenbuilder.BuildRoomUserToken(appID, appCertificate, roomUuid, userUuid, role, expire)

        if err != nil {
            fmt.Println(err)
        } else {
            fmt.Printf("EducationToken: %s\n", result)
            educationToken = result
        }
    }

    func educationTokenHandler(w http.ResponseWriter, r *http.Request) {
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

        var t_education_str education_token_struct
        var unmarshalErr *json.UnmarshalTypeError
        str_decoder := json.NewDecoder(r.Body)
        education_err := str_decoder.Decode(&t_education_str)

        if (education_err != nil) {
            if errors.As(education_err, &unmarshalErr) {
                errorResponse(w, "Bad request. Please check your params.", http.StatusBadRequest)
            } else {
                errorResponse(w, "Bad request.", http.StatusBadRequest)
            }
            return
        }

        generateRtmToken(t_education_str.roomUuid,t_education_str.userUuid,t_education_str.role)
        errorResponse(w, educationToken, http.StatusOK)
        log.Println(w, r)
    }

    func errorResponse(w http.ResponseWriter, message string, httpStatusCode int) {
        w.Header().Set("Content-Type", "application/json")
        w.Header().Set("Access-Control-Allow-Origin", "*")
        w.WriteHeader(httpStatusCode)
        resp := make(map[string]string)
        resp["token"] = message
        resp["code"] = strconv.Itoa(httpStatusCode)
        jsonResp, _ := json.Marshal(resp)
        w.Write(jsonResp)
    }

    func main() {
        // Handling routes
        http.HandleFunc("/fetch_education_token", educationTokenHandler)

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

### 使用 AccessToken2 鉴权

#### Web

本节以 Web 端灵动课堂为例，展示如何使用 Token 对客户端的用户进行鉴权。

下列参考代码来自灵动课堂 Web 端源码 [`packages/agora-demo-app/src/pages/home/index.tsx`](https://github.com/AgoraIO-Community/flexible-classroom-desktop/blob/release/2.8.30/packages/agora-demo-app/src/pages/home/index.tsx)。

1. 向集成了声网 Token 生成器的服务端发起 Token 请求。

    ```typescript
    const { token, appId } = await roomApi.getCredentialNoAuth({
        userUuid,
        roomUuid,
        role: userRole,
    });
    ```

2. 将请求成功后获取到的 Token 用于创建 `launchOption` 对象。

    ```typescript
    const launchOption = {
    appId,
    sdkDomain,
    pretest: true,
    courseWareList: [],
    language: language as LanguageEnum,
    userUuid: `${userUuid}`,
    rtmToken: token,
    roomUuid: `${roomUuid}`,
    roomType: roomType,
    roomName: `${roomName}`,
    userName: userName,
    roleType: userRole,
    region: region as EduRegion,
    duration: +duration * 60,
    latencyLevel: 2,
    shareUrl,
    };
    ```

3. 调用 `launch` 方法，使用 Token 加入课堂。

    ```typescript
    AgoraEduSDK.launch(dom, launchOption);  
    ```

#### Android

#### 使用 Token 对用户鉴权

本节以 Android 端灵动课堂 App 为例，展示如何使用 Token 对客户端的用户进行鉴权。

下列参考代码来自灵动课堂 Android 端源码 [`app/src/main/java/io/agora/education/setting/FcrMainActivity.kt`](https://github.com/AgoraIO-Community/CloudClass-Android/blob/release/2.8.30/app/src/main/java/io/agora/education/setting/FcrMainActivity.kt)。

1. 向你已经集成了声网 Token 生成器的服务端，发起 Token 请求。

   ```kotlin
   ConfigUtil.getV3Config(region,roomUuid,roleType,userUuid,object : EduCallback<ConfigData> {})
   ```

2. 将请求成功后获取到的 Token 用于创建 `AgoraEduLaunchConfig` 对象。

   ```kotlin
   val config = AgoraEduLaunchConfig(userName, userUuid, roomName,roomUuid, roleType, roomType, token,null,duration)                                             
   ```

3. 调用 `launch` 方法，使用 Token 加入课堂。

   ```kotlin
    AgoraClassroomSDK.launch(this, config, AgoraEduLaunchCallback { event ->
       // class state
    })
   ```


#### iOS

本节以 iOS 端灵动课堂 App 为例，展示如何使用 Token 对客户端的用户进行鉴权。

以下参考代码来自灵动课堂 iOS 端源码 [`/App/AgoraEducation/Debug/DebugViewController.swift`](https://github.com/AgoraIO-Community/flexible-classroom-ios/blob/release/2.8.30/App/AgoraEducation/Debug/DebugViewController.swift)。

1. 向集成了声网 Token 生成器的服务端发起 Token 请求。

   ```swift
   data.requestToken(roomId: info.roomId,
                     userId: finalUserId,
                     userRole: info.roleType.rawValue,
                     success: tokenSuccessBlock,
                     failure: failureBlock)
   ```

2. 将请求成功后获取到的 Token 用于创建 `AgoraEduLaunchConfig` 对象。

   ```swift
   let launchConfig = AgoraEduLaunchConfig(userName: userName,
                                           userUuid: userId,
                                           userRole: userRole,
                                           roomName: roomName,
                                           roomUuid: roomId,
                                           roomType: roomType,
                                           appId: appId,
                                           token: token,
                                           startTime: nil,
                                           duration: nil,
                                           region: region,
                                           mediaOptions: nil,
                                           userProperties: nil)
   ```

3. 调用 `launch` 方法，使用 Token 加入课堂。

   ```swift
   AgoraClassroomSDK.launch(launchConfig,
                             success: launchSuccessBlock,
                             failure: failureBlock)
   ```


## 参考

### AccessToken2 生成器代码

声网在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。

#### App 全局 Token

作用域为 App 全局操作，如创建教室，设置和查询房间等。

| 语言 | 算法 | 核心方法       | 示例代码 |
| -------- | ----------- |----------------| ---------------- |
| C++ | HMAC-SHA256 | [BuildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                                    | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildAppToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                      | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_app_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                                    | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_app_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                                   | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |

#### 个人用户 Token

作用域为指定 App ID 下的用户级别操作，可跨房间使用，如个人云盘。

| 语言 | 算法 | 核心方法      | 示例代码 |
| -------- | ----------- |-------------------| ---------------- |
| C++ | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                               | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                 | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                         | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                          | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |

#### 指定房间指定用户（客户端使用）

作用域为制定房间中的制定用户，该 Token 打包了 `ServiceEducation` 和 `ServiceRtm` 两个服务，在客户端 SDK 启动时传入，可以帮助用户打通灵动课堂及 RTM 用户登录的 token。

| 语言 | 算法 | 核心方法       | 示例代码 |
| -------- | ----------- |--------------- |
| C++ | HMAC-SHA256 | [BuildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/EducationTokenBuilder2.h)                                  |  |
| Go | HMAC-SHA256 | [BuildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/educationtokenbuilder/educationtokenbuilder.go)             | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/educationtokenbuilder/sample.go) |
| Java | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/education/EducationTokenBuilder2.java) | [EducationTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/EducationTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/EducationTokenBuilder.js)                               | [EducationTokenSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/EducationTokenSample.js) |
| PHP | HMAC-SHA256 | [buildRoomUserToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/EducationTokenBuilder.php)                                 | [EducationTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/EducationTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [build_room_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/education_token_builder.pypy)                        | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/education_token_builder_sample.py) |
| Python 3 | HMAC-SHA256 | [build_room_user_token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/education_token_builder.py)                               | [education_token_builder_sample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/education_token_builder_sample.py) |

### AccessToken 生成器代码

如果你使用的是 AccessToken，可参考以下示例代码：

| 语言 | 算法 | 核心方法 | 示例代码 |
| -------- | ----------- | ---------- | ---------------- |
| C++ | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtmTokenBuilder.h) | [RtmTokenBuilderSample.cpp](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/sample/RtmTokenBuilderSample.cpp) |
| Go | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/src/RtmTokenBuilder/RtmTokenBuilder.go) | [sample.go](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/go/sample/RtmTokenBuilder/sample.go) |
| Java | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/rtm/RtmTokenBuilder.java) | [RtmTokenBuilderSample.java](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtmTokenBuilderSample.java) |
| Node.js | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder.js) | [RtmTokenBuilderSample.js](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilderSample.js) |
| PHP | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/src/RtmTokenBuilder.php) | [RtmTokenBuilderSample.php](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/php/sample/RtmTokenBuilderSample.php) |
| Python 2 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py) |
| Python 3 | HMAC-SHA256 | [buildToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/src/RtmTokenBuilder.py) | [RtmTokenBuilderSample.py](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/python3/sample/RtmTokenBuilderSample.py) |


## 开发注意事项

### 参数匹配

生成 Token 时填入的用户 ID，需要和登录灵动课堂系统时填入的用户 ID 一致。

### App 证书与 Token

生成 Token 需要先在控制台启用对应项目的 App 证书。项目一旦开启了 App 证书，就必须使用 Token 鉴权。

### Token 过期

你可以根据业务需求指定 Token 的有效期 (最长为 24 小时)。当 Token 临 30 秒过期时，会触发 `onTokenPrivilegeWillExpire` 回调，提醒用户 Token 即将过期。收到该回调时，你可以在服务端重新生成 RTM Token，然后调用 `renewToken` 方法，将新生成的 Token 传给 SDK。

Token 过期时，分为以下两种情况：
- 如果用户处于已连接状态 (`CONNECTION_STATE_CONNECTED`)，会收到 `onTokenExpired` 回调和因 Token 过期 (`CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`) 触发的 `onConnectionStateChanged` 回调，提醒用户连接状态切换至停止登录 (`CONNECTION_STATE_ABORTED`)。此时，用户需要调用 `login` 方法重新登录。
- 如果用户由于网络问题处于断线重连状态 (`CONNECTION_STATE_RECONNECTING`)，会在网络恢复时收到 `onTokenExpired` 回调。此时，用户需要调用 `renewToken` 方法恢复连接。

<div class="alert note">你可以通过 <code>onTokenPrivilegeWillExpire</code> 回调和 <code>onTokenExpired</code> 回调进行 Token 过期处理，但声网推荐你通过定时（例如每小时）更新 Token 来解决 Token 过期问题。</div>

