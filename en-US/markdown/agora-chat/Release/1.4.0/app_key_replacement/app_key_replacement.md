# App Key 替换为 App ID

本次 Chat 版本更新需要将 App Key 替换为 App ID，涉及到的文档如下：

## RESTful API

对于 RESTful API，App Key 的关系 App ID 为： `{org_name}/{app_name}` = `app-id/{app_id}`

你需要将如下进行替换

1. HTTP request URL

   这部分需要将 HTTP request URL 中的 `{org_name}/{app_name}` 替换为 `app-id/{app_id}`。

| 项           | 替换前  | 替换后 |
| :-------------- | :----- | :------- |
| HTTP request URL | https://{host}/{org_name}/{app_name}/messages/users | https://{host}/app-id/{app_id}/messages/users |

2. Path parameter 或 Common parameters

在 Path parameter 一节或 Common parameters 中的 Request parameters 一节中，删掉 org_name 和 app_name 参数的介绍，添加 app_id 参数的介绍

| Parameter           | Type  | Description | Required |
| :-------------- | :----- | :------- | :------- |
| app_id | String | 声网为每个项目自动分配的 App ID，作为项目唯一标识。| 是 |

3. 请求示例
| 项           | 替换前  | 替换后 |
| :-------------- | :----- | :------- |
| HTTP request URL | 'http://XXXX/XXXX/XXXX/messages/users'| 'https://XXXX/app-id/XXXX/messages/users' |

4.  发送附件消息中的替换

对于 [Send a one-to-one message](https://docs.agora.io/en/agora-chat/restful-api/message-management#send-a-one-to-one-message)、[Send a group message](https://docs.agora.io/en/agora-chat/restful-api/message-management#send-a-group-message) 和 [Send a chat room message](https://docs.agora.io/en/agora-chat/restful-api/message-management#send-a-chat-room-message) 这三个接口中发送附件消息，包括图片消息、语音消息、视频消息和文件消息，请求示例中的请求 body JSON 结构中的 body 中的 url 参数的值，也需要替换，例如 替换为 "url":"https://XXXX/app-id/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252"。

5. 响应示例

注意：响应示例中的 uri 参数的值无需替换。

6. 其他描述

在 RESTful API 文档中的全文查找  app key、appkey、app_key 进行替换。

## Token 认证（Secure authentication with tokens）

1. 代码中的替换

将 [Secure authentication with tokens](https://docs.agora.io/en/agora-chat/develop/authentication) 中 [Chat SDK token authentication](https://docs.agora.io/en/agora-chat/develop/authentication#-token-authentication) 的代码中的替换如下：

| 替换前          | 替换后   |
| :-------------- | :----- |
| `private String appKey = "<App key from Agora console>";`          |  `private String appId = "<App ID from Agora console>";`  |
| `if (appKey.isEmpty()) {`          |  `if (appId.isEmpty()) {`  |
| `showLog("You need to set your AppKey");`          | `showLog("You need to set your app ID");`   |
| `options.setAppKey(appKey); `          | `options.setAppId(appId); `   |

2. 正文中的替换

在 [Secure authentication with tokens](https://docs.agora.io/en/agora-chat/develop/authentication)文档中的全文查找  app key、appkey、app_key 进行替换。

## 客户端文档

### 替换正文描述/代码中的 app key

- 请在客户端的正文描述以及代码的注释中搜索 app key、appkey、app_key等，替换为 app ID。注意搜索时不区分大小写。
- 请在客户端的代码中搜索 app key、appkey、app_key等，替换为相应的 app key 方法或参数（详见下面初始化替换），搜索时不区分大小写。

### 替换初始化描述中的 app key

各客户端 SDK 的初始化文档或快速开始中的初始化描述中涉及 app key 设置，请进行替换。

#### Android

初始化示例代码：

```java
ChatOptions options = new ChatOptions();
options.setAppId("Your appId");
......// 其他 ChatOptions 配置。
ChatClient.getInstance().init(context, options);
```

#### Flutter

初始化示例代码：

```dart
final options = ChatOptions.withAppId(appId);
await ChatClient.getInstance.init(options); 
```

#### HarmonyOS

初始化示例代码：

```typescript
let options = new ChatOptions({
    appId: "Your AppId"
});
......// 其他 ChatOptions 配置。
// 初始化时传入上下文以及 options
ChatClient.getInstance().init(context, options);
```

#### iOS

初始化示例代码：

```objectivec
AgoraChatOptions *options = [AgoraChatOptions optionsWithAppId:@"xxx"];
        
......// 其他 AgoraChatOptions 配置。
[AgoraChatClient.sharedClient initializeSDKWithOptions:options];

```

#### React Native

初始化示例代码：

```typescript
ChatClient.getInstance()
  .init(
    ChatOptions.withAppId({
      appId: appId,
    }),
  )
  .then(() => {
    console.log("init: success");
  })
  .catch((reason) => {
    console.error(reason);
  });
```

#### Unity/Windows

初始化示例代码：

```csharp
var options = Options.InitOptionsWithAppId("YourAppId"); //将该参数设置为你的 App Id
//其他 Options 配置。
SDKClient.Instance.InitWithOptions(options);
```

#### Web

```javascript
import ChatSDK from "shengwang-chat";
const chatClient = new ChatSDK.connection({
  appId: "Your appId",
});
```

### 离线推送

#### iOS

在 iOS 离线推送 [Integrate APNs on the client](https://docs.agora.io/en/agora-chat/develop/offline-push/integrate-test?platform=ios#7-integrate-apns-on-the-client)这一节中， 将下面的 `[AgoraChatOptions optionsWithAppkey:@"XXXX#XXXX"]` 替换为 `[AgoraChatOptions optionsWithAppId:@"xxx"]`。


#### Flutter

在 Flutter 离线推送 [Integrate FCM on the client - SDK integration](https://docs.agora.io/en/agora-chat/develop/offline-push/integrate-test?platform=flutter#sdk-integration)这一节中， 将下面的 `var options = ChatOptions(appKey: "Your Appkey", autoLogin: false);` 替换为 `         `。


#### React Native

在 React Native 离线推送 [Integrate FCM on the client - FCM push code implementation](https://docs.agora.io/en/agora-chat/develop/offline-push/integrate-test?platform=react-native#fcm-push-code-implementation)这一节中， 将下面的 `appKey: appKey` 替换为 `appId: appId`。

```typescript
// Configure push settings in the ChatOptions class.
let o = new ChatOptions({
  autoLogin: false ,
  appKey: appKey,
  pushConfig: pushConfig,
});
```



