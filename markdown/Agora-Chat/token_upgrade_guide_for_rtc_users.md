## 升级 Agora RTC SDK 的 Token 鉴权机制

如果你同时集成了 Agora Chat SDK 和 Agora RTC SDK，Agora 建议你将 Agora RTC SDK 的 Token 鉴权机制升级到 [access token 2](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/AccessToken2.h)。

Agora Chat SDK 的首个版本支持且仅支持 access token 2。
Agora RTC SDK 对于 access token 2 的支持情况如下：

| SDK 类型             | 支持 access token 2 的首个版本 |
|----------------------|--------------------------------|
| RTC Native SDK       | 3.5.2                          |
| RTC ELectron SDK     | 3.5.2                          |
| RTC Unity SDK        | 3.5.2                          |
| RTC React Native SDK | 3.5.2                          |
| RTC Flutter SDK      | 4.2.0                          |
| RTC Web SDK          | 4.8.0                          |
| RTC 微信小程序 SDK    | 暂不支持                        |

<div class="alert note">如果你还使用了云端录制、推流等 RTC 配套产品或服务，请在升级到 access token 2 之前<a href="https://agora-ticket.agora.io/">提交工单</a>联系技术支持。</div>


## 前提条件

- 你已经根据[使用 Token 鉴权](//TODO LINK) 文档完成了基于 Spring 框架的 Token 服务端和基于 Web 的客户端的搭建。
- 为 Agora Chat 的 Token 服务端添加基于 [access token](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/AccessToken.h) 的 RTC Token 服务。在 `AgoraChatTokenController.java` 文件中，增加以下引用：

    ```java
    import com.agora.chat.token.io.agora.media.RtcTokenBuilder;
    ```

    并添加以下方法：

    ```java
    // 生成 RTC access token
    @GetMapping("/rtc/{rtcChannelName}/{rtcUserId}/{role}/token")
    public String getRtcToken(@PathVariable String rtcChannelName, @PathVariable int rtcUserId, @PathVariable int role) {

        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            return "appid or appcert is empty";
        }

        RtcTokenBuilder builder = new RtcTokenBuilder();

        RtcTokenBuilder.Role rtcRole;

        switch(role) {
            case 1:
            default:
                rtcRole = RtcTokenBuilder.Role.Role_Publisher;
                break;
            case 2:
                rtcRole = RtcTokenBuilder.Role.Role_Subscriber;
                break;
        }

        return builder.buildTokenWithUid(appid, appcert, rtcChannelName, rtcUserId, rtcRole, expire);
    }
    ```

- 添加 RTC SDK 客户端鉴权逻辑。在客户端新建一个文件夹 `agoraRtcTokenClient`，并在文件夹中新建两个文件：

  - `index.html`

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

  - `client.js`。你需要将 `<Your app ID>` 替换为你的 App ID。

    ```js
    var rtc = {
        // 设置本地音频轨道和视频轨道。
        localAudioTrack: null,
        localVideoTrack: null,
    };

    var options = {
        // 传入 App ID
        appId: "<Your app ID>",
        // 传入频道名
        channel: "ChannelA",
        // 设置用户为 host (可发流) 或 audience（仅可收流）
        role: "host"
    };

    // 从 Golang 服务器获取 Token
    function fetchToken(uid, channelName, tokenRole) {

        url = 'http://localhost:8090/rtc/' + channelName + '/' + uid + '/' + tokenRole + '/' + 'token'

        return new Promise(function (resolve) {
            axios.get(url)
                .then(function (response) {
                    const token = response.text();
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

        // 将获取到的 Token 赋值给 join 方法中的 token 参数，然后加入频道
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

        // 收到 token-privilege-will-expire 回调时，从服务器重新申请一个 Token，并调用 renewToken 将新的 Token 传给 SDK
        client.on("token-privilege-will-expire", async function () {
            let token = await fetchToken(uid, options.channel, 1);
            await client.renewToken(token);
        });

        // 收到 token-privilege-did-expire 回调时，从服务器重新申请一个 Token，并调用 join 重新加入频道
        client.on("token-privilege-did-expire", async function () {
            console.log("Fetching the new Token")
            let token = await fetchToken(uid, options.channel, 1);
            console.log("Rejoining the channel with new Token")
            await rtc.client.join(options.appId, options.channel, token, uid);
        });

    }

    startBasicCall()
    ```

- 验证 access token 的鉴权效果。

    用支持的浏览器打开 `index.html` 文件，可以看到客户端执行以下操作：
    - 成功加入频道。
    - 每隔 10 秒更新 Token。

## 实现步骤

本文以 Java 服务端和 Web 客户端为例，通过具体步骤引导你搭建并升级 Agora RTC SDK 的 Token 鉴权机制。



### 在 Token 服务端将鉴权机制升级到 access token 2

该小节引导你将 Token 服务端升级到 access token 2。

1. 更新 import 语句，导入 `RtcTokenBuilder2`。

    ```java
    import com.agora.chat.token.io.agora.media.RtcTokenBuilder2;
    ```

2. 将 `getRtcToken` 方法的实现代码替换为以下逻辑：

    ```java
    // 生成 RTC access token 2
    public String getRtcToken(@PathVariable String rtcChannelName, @PathVariable int rtcUserId, @PathVariable int role) {

        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            return "appid or appcert is empty";
        }

        RtcTokenBuilder2 builder = new RtcTokenBuilder2();

        RtcTokenBuilder2.Role rtcRole;

        switch(role) {
            case 1:
            default:
                rtcRole = RtcTokenBuilder2.Role.ROLE_PUBLISHER;
                break;
            case 2:
                rtcRole = RtcTokenBuilder2.Role.ROLE_SUBSCRIBER;
                break;
        }

        return builder.buildTokenWithUid(appid, appcert, rtcChannelName, rtcUserId, rtcRole, expire);
    }
    ```

客户端无需进行任何操作即可兼容 access token 2。

### 验证 access token 2 的鉴权效果

用支持的浏览器打开 `index.html` 文件，可以看到客户端执行以下操作：
   - 成功加入频道。
   - 每隔 10 秒更新 Token。