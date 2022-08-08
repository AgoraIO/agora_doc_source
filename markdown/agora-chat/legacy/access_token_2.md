如果你同时集成了 Agora Chat SDK 和 Agora RTC SDK，Agora 建议你将 Agora RTC SDK 的 Token 鉴权机制从 [AccessToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/AccessToken.h) 升级到 [AccessToken2](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/AccessToken2.h)。
本文以 Java 服务端和 Web 客户端为例，通过具体步骤引导你搭建并升级 Agora RTC SDK 的 Token 鉴权机制。

## 前提条件
- 你已经根据[使用 User Token 鉴权](https://docs-preprod.agora.io/cn/null/generate_user_tokens%20?platform=All%20Platforms)文档完成了基于 Spring 框架的 Token 服务端和基于 Web 的 Agora Chat 客户端的搭建。
- 为 Agora Chat 的 Token 服务端添加基于 [AccessToken](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/AccessToken.h) 的 RTC Token 服务。在 AgoraChatTokenController.java 文件中，增加 `import com.agora.chat.token.io.agora.media.RtcTokenBuilder;` 引用并添加以下方法：
```java
// 生成 RTC AccessToken
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
- 添加 RTC SDK 客户端鉴权逻辑。在客户端新建一个文件夹 agoraRtcTokenClient，并在文件夹中新建两个文件：
  - `index.html`文件

   ```html
   <html>

     <head>
       <title>Token demo</title>
     </head>

    <body>
       <h1>Token demo</h1>
       <script src="https://download.agora.io/sdk/release/AgoraRTC_N.js"></script>
       <script src="./client.js"></script>
     </body>
   </html>
   ```
 - `client.js` 文件。你需要将 `<Your app ID>` 替换为你的 App ID。

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
     role: "host",
   };
   
   // 从服务器获取 Token
   function fetchToken(uid, channelName, tokenRole) {
   
   url = 'http://localhost:8090/rtc/' + channelName + '/' + uid + '/' + tokenRole + '/' + 'token'
   
   return new Promise(function (resolve) {
   
       fetch(url)
           .then(res => res.text())
           .then((token => { resolve(token); }))
   
   })
       .catch(function (error) {
           console.log(error);
       });
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
         remotePlayerContainer.textContent =
           "Remote user " + user.uid.toString();
         remotePlayerContainer.style.width = "640px";
         remotePlayerContainer.style.height = "480px";
         document.body.append(remotePlayerContainer);
         remoteVideoTrack.play(remotePlayerContainer);
       }
   
       if (mediaType === "audio") {
         const remoteAudioTrack = user.audioTrack;
         remoteAudioTrack.play();
       }
   
       client.on("user-unpublished", (user) => {
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
       console.log("Fetching the new Token");
       let token = await fetchToken(uid, options.channel, 1);
       console.log("Rejoining the channel with new Token");
       await rtc.client.join(options.appId, options.channel, token, uid);
     });
   }
	 
   startBasicCall();
   ```
- 验证 AccessToken 的鉴权效果。
 用支持的浏览器打开 `index.html` 文件，可以看到客户端执行以下操作：
   - 成功加入频道。
   - 每隔 10 秒更新 Token。

## 实现步骤

你可以通过以下步骤将鉴权机制升级到 AccessToken2。

### 在 Token 服务端将鉴权机制升级到 AccessToken2

该小节引导你将 Token 服务端升级到 AccessToken2。
1. 更新 import 语句，导入 `RtcTokenBuilder2`。
```java
import com.agora.chat.token.io.agora.media.RtcTokenBuilder2;
```
2.将 `getRtcToken` 方法的实现代码替换为以下逻辑：

   ```java
   // 生成 RTC AccessToken2
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
客户端无需进行任何操作即可兼容 AccessToken2。

### 验证 AccessToken2 的鉴权效果

用支持的浏览器打开 `index.html` 文件，可以看到客户端执行以下操作：
- 成功加入频道。
- 每隔 10 秒更新 Token。

## 参考信息

本节介绍 SDK 版本支持、AccessToken2 生成器代码库等相关文档。

### SDK 版本支持
Agora RTC SDK 对于 AccessToken2 的支持情况如下：

| SDK 类型             | 支持 AccessToken2 鉴权的首个版本 |
| :------------------- | :------------------------------- |
| RTC Native SDK       | 3.5.2                            |
| RTC ELectron SDK     | 3.5.2                            |
| RTC Unity SDK        | 3.5.2                            |
| RTC React Native SDK | 3.5.2                            |
| RTC Flutter SDK      | 4.2.0                            |
| RTC Web SDK          | 4.8.0                            |
| RTC 微信小程序 SDK   | 暂不支持                         |

使用 AccessToken2 的 SDK 版本可以和使用 AccessToken 的 SDK 版本互通。同时，支持 AccessToken2 的版本也支持 AccessToken。

如果你还使用了云端录制、推流等 RTC 配套产品或服务，请在升级到 AccessToken2 之前[提交工单](https://agora-ticket.agora.io/)联系技术支持。

### Token 生成器代码
Agora 在 GitHub 上提供一个开源的[ AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 AccessToken2。


| 语言    | 算法        | 核心方法                                                     | 示例代码                                                     |
| :------ | :---------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| C++     | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/RtcTokenBuilder2.h) | [RtcTokenBuilder2Sample.cpp](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/sample/RtcTokenBuilder2Sample.cpp) |
| Go      | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/go/src/rtctokenbuilder2/rtctokenbuilder.go) | [sample.go](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/go/sample/rtctokenbuilder2/sample.go) |
| Java    | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media/RtcTokenBuilder2.java) | [RtcTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/RtcTokenBuilder2Sample.java) |
| Node.js | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/nodejs/src/RtcTokenBuilder2.js) | [RtcTokenBuilder2Sample.js](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/nodejs/sample/RtcTokenBuilder2Sample.js) |
| PHP     | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/php/src/RtcTokenBuilder2.php) | [RtcTokenBuilder2Sample.php](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/php/sample/RtcTokenBuilder2Sample.php) |
| Python  | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python/src/RtcTokenBuilder2.py) | [RtcTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python/sample/RtcTokenBuilder2Sample.py) |
| Python3 | HMAC-SHA256 | [buildTokenWithUid](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python3/src/RtcTokenBuilder2.py) | [RtcTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/release/accesstoken2/DynamicKey/AgoraDynamicKey/python3/sample/RtcTokenBuilder2Sample.py) |

### API 参考
本节介绍生成 AccessToken2 的 API 参数和描述。 以 Java 为例：

```java
public String buildTokenWithUid(String appId, String appCertificate, String channelName, int uid, Role role, int expire) 
```

| 参数             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| `appId`          | 你在 Agora 控制台创建项目时生成的 App ID。                   |
| `appCertificate` | 你的项目的 App 证书。                                        |
| `channelName`    | 频道名称，长度在 64 个字节以内。以下为支持的字符集范围：26 个小写英文字母 a-z；26 个大写英文字母 A-Z；10 个数字 0-9；空格标点符号和其他符号, 包括: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",". |
| `uid`            | 待鉴权用户的用户 ID 32 位无符号整数，范围为 1 到 (2³² - 1)， 并保证唯一性。 如不需对用户 ID 进行鉴权，即客户端使用任何 `uid` 都可加入频道，请把 `uid` 设为 0。 |
| `role`           | 用户权限，分为发流用户和接收用户。参数决定用户是否能在频道中发流。`ROLE_PUBLISHER(1)`：（默认）用户有发流权限，即用户可在频道中发流。`ROLE_SUBSCRIBER(2)`：用户有接收权限，即用户可在频道中接收，但不可发流。该参数仅在开启连麦鉴权后才生效。详情参考[开通连麦鉴权](https://file+.vscode-resource.vscode-webview.net/c%3A/Users/WL/Documents/GitHub/doc_source/markdown/Agora-Chat/token_upgrade_guide_for_rtc_users.md#cohost)。 |
| `expire`         | AccessToken2 过期的 Unix 时间戳，单位为秒。该值为当前时间戳和 AccessToken2 有效期的总和。 例如，如果你将 `expire` 设为当前时间戳再加 600 秒，则 AccessToken2 会在 10 分钟内过期。 AccessToken2 的最大有效期为 24 小时。 如果你将此参数设为 0，或时间长度超过 24 AccessToken2 有效期依然为 24 小时。 |

### 精细权限设置

为方便你对频道中的用户的发流权限进行更精细的控制，Agora 还提供一个同名的重载方法。支持你对用户分别设置加入频道、发布音频流、发布视频流及发布数据流的权限进行分别设置。以 Java 为例：

```java
public String buildTokenWithUid(String appId, String appCertificate, String channelName, int uid, int tokenExpire, int joinChannelPrivilegeExpire, int pubAudioPrivilegeExpire, int pubVideoPrivilegeExpire, int pubDataStreamPrivilegeExpire) 
```

该方法生成带角色权限的 RTC AccessToken2，支持对如下权限及其过期时间进行更精确的设置：

- AccessToken2 过期时间
- 加入 RTC 频道过期时间
- 在 RTC 频道中发布音频过期时间
- 在 RTC 频道中发布视频过期时间
- 在 RTC 频道中发布数据流过期时间

其中，发布音频、视频和数据流的权限仅在开通连麦鉴权服务后才生效。

一个用户可以设置多个权限。每个权限的最大有效时间为 24 小时。权限即将过期或已经过期后，SDK 会分别触发 `onTokenPriviegeWillExpire` 或 `onRequestToken` 回调。你需要在业务层区分即将过期或已经过期的是哪个权限，并根据业务需要及时生成新的 Token，然后调用 `renewToken` 将新的 Token 传给 SDK，或重新调用 `joinChannel` 加入频道。

你需要根据实际业务场景设置合理的过期时间戳。例如，如果加入频道的权限过期时间早于发布音频权限的过期时间，则在加入频道的权限过期后，用户就会被踢出 RTC 频道；即便发布音频的权限没有过期，对用户来讲这个权限是没有意义的。

| 参数                           | 描述                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `tokenExpire`                  | 从 AccessToken2 生成到 AccessToken2 过期的时长，单位为秒。该值为当前时间戳和权限有效期的总和。比如，你将 `tokenExpire` 设为当前时间戳再加 600 秒，那么 AccessToken2 会在生成 10 分钟后过期。 |
| `joinChannelPrivilegeExpire`   | 从 AccessToken2 生成到加入频道权限过期的时长，单位为秒。该值为当前时间戳和权限有效期的总和。比如，你将 `joinChannelPrivilegeExpire` 设为当前时间戳再加 600 秒，那么加入频道的权限会在生成 10 分钟后过期。 |
| `pubAudioPrivilegeExpire`      | 从 AccessToken2 生成到发布音频权限过期的时长，单位为秒。该参数仅在开启连麦鉴权后生效。该值为当前时间戳和权限有效期的总和。比如，你将 `pubAudioPrivilegeExpire` 设为当前时间戳再加 600 秒，那么发布音频的权限会在生成 10 分钟后过期。如果不希望设置该权限，则将该参数设为当前时间戳。 |
| `pubVideoPrivilegeExpire`      | 从 AccessToken2 生成到发布视频权限过期的时长，单位为秒。该参数仅在开启连麦鉴权后生效。该值为当前时间戳和权限有效期的总和。比如，你将 `pubVideoPrivilegeExpire` 设为当前时间戳再加 600 秒，那么发布视频的权限会在 10 分钟后过期。如果不希望设置该权限，则将该参数设为当前时间戳。 |
| `pubDataStreamPrivilegeExpire` | 从 AccessToken2 生成到发布数据流权限过期的时长，单位为秒。该参数仅在开启连麦鉴权后生效。该值为当前时间戳和权限有效期的总和。比如，你将 `pubDataStreamPrivilegeExpire` 设为当前时间戳再加 600 秒，那么发布数据流的权限会在 10 分钟后过期。如果不希望设置该权限，则将该参数设为当前时间戳。 |

### 开通连麦鉴权

请参考以下步骤在 Agora 控制台开启连麦鉴权服务：

1. 登录 Agora 控制台，在**项目列表**区域选择你想要开启的项目，点击编辑按钮，进入编辑项目页面。
2. 在项目详情页，下滑到功能区域，点击激活**连麦鉴权**。
3. 按照屏幕提示，了解开通该功能的主要事项，勾选后点击 **Enable**。

在控制台启用连麦鉴权后，该服务会在约 5 分钟后生效。

项目一旦开启了连麦鉴权服务，则用户在频道中发流需要同时满足两个条件，以 Java 为例：

- 在 `setClientRole` 中设置的 `role` 参数为 `BROADCASTER`。
- 在生成 Token 的代码中设置的 `role` 参数为 `ROLE_PUBLISHER`。