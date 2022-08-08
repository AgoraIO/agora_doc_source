Agora 即时通讯支持集成 APNs 消息推送服务，为 iOS 开发者提供低延时、高送达、高并发、不侵犯用户个人数据的离线消息推送服务。

当客户端应用进程被关闭等原因导致用户离线，Agora 即时通讯服务会通过 APNs 消息推送服务向该离线用户的设备推送消息通知。当用户再次上线时，会收到离线期间所有消息。

## 技术原理

下图展示了消息推送的基本工作流程：

![](https://web-cdn.agora.io/docs-files/1642564011796)

## 前提条件

- 已开启 Agora 即时通讯服务，详见[开启和配置即时通讯服务](./enable_agora_chat?platform=iOS)。
- 参考如下步骤，开启 APNs 推送服务，并将 APNs 的推送证书等信息上传到 Agora 控制台。

### <a name="step1"></a>步骤一 开启 APNs 推送服务

1. 申请证书签名请求 Certificate Signing Request (CSR) 文件。
点击**钥匙串访问** > **证书助理** > **从证书颁发机构请求证书**，在**证书助理**界面填写电子邮件地址和常用名称，并选择**存储到磁盘**。
![](https://web-cdn.agora.io/docs-files/1642564150801)
点击**继续**，添加存储路径，你会在该路径获取到一个名为 `CertificateSigningRequest.certSigningRequest` 的 CSR 文件。

2. 申请 App ID。
登录 [iOS Developer Center](https://developer.apple.com/cn/)，点击 **Account** > **Certificates, Identifiers & Profiles** > **Identifiers** 添加 App ID，并参考如下配置：
 - **Select a type**: 选择 **App**
 - **Description**: App ID 的描述信息。
 - **Bundle ID**: 可以设置为 `com.YourCompany.YourProjectName`。
 - **Capabilities**: 选择 **Push Notification**。

3. 分别创建开发环境和生产环境的消息推送证书。
**开发环境**
 1. 点击 **app** > **Push Notifications** > **Development SSL Certificate** > **Create Certificate**。
 2. **Platform** 选择 iOS , **Choose File** 选择第 1 步中创建的 CSR 文件，点击 **Continue**，生成 [Apple Development IOS Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) 文件。

 **生产环境**
 1. 点击 **app** > **Push Notifications** > **Production SSL Certificate** > **Create Certificate。**
 2. **Platform** 选择 iOS , **Choose File** 选择第 1 步中创建的 CSR 文件，点击 **Continue**，生成 [APS (Apple Push Service)](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) 文件。

4. 获取消息推送证书。
双击导入**第 3 步**创建的推送证书，在**钥匙串访问** > **登录** > **我的证书**中，找到已经导入的证书，右键选择该证书导出为 .p12 文件，并设置证书密钥。

5. 生成 Provisioning Profile 文件。
登录 [iOS Developer Center](https://developer.apple.com/cn/)，点击 **Account** > **Certificates, Identifiers & Profiles** > **Profiles** 添加 Provisioning Profile，点击 **Continue**，并参考如下配置：

 - **Development**：选择 **iOS App Development**。
 - **Distribution**：选择 **Ad Hoc**。如需在 App Store 正式发布版本，请选择 **App Store**。
 - **App ID**：填写**第 2 步**创建的 App ID。
 - **Select Certificates**：选择**第 3 步**创建的推送证书。
 - **Select Devices**：选择待开发的设备。
 - **Provisioning Profile Name**：填写 Provisioning Profile 文件名称。

 点击 **Generate**，生成 Provisioning Profile 文件。

### 步骤二 上传推送证书等信息到控制台

按照以下步骤，在 Agora 控制台上传消息推送证书等信息：

1. 登录[控制台](https://sso2.agora.io/cn/)，点击左侧导航栏**项目管理**。
2. 选择需要开通即时通讯服务的项目，点击**配置**。
![](https://web-cdn.agora.io/docs-files/1642564654253)

3. 找到**实时互动拓展能力**模块的**即时通讯IM**，点击**配置**。
![](https://web-cdn.agora.io/docs-files/1642564694699)

4. 在消息推送模块，点击添加推送证书。
![](https://web-cdn.agora.io/docs-files/1642564728101)
在弹窗中选择**苹果**，并配置如下字段，完成后点击**保存**：
   - 证书类型：消息推送证书类型，目前支持 p8 和 p12。
   - 证书名称：消息推送证书名称。填写在[步骤一](#step1)中创建的消息推送证书名称。
   - 证书密钥：消息推送证书密钥。填写在在[步骤一](#step1)中导出消息推送证书文件时设置的证书密钥。
   - 上传文件：上传[步骤一](#step1)中获取的消息推送证书文件。
   - 绑定 ID：Bundle ID。[步骤一](#step1)中创建 App ID 时设置的 Bundle ID。
   - 环境：根据业务需要选择环境。开发、生产环境的证书需要分开上传。

## 在客户端实现消息推送

1. 打开 Xcode，点击 **Targets** > **Capability** > **Push Notifications** 开启消息推送权限。

2. 将证书名称传递给 SDK。

```swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注册推送
    [application registerForRemoteNotifications];
    
    // 初始化 Options，并设置 AppKey
    AgoraOptions *options = [AgoraOptions optionsWithAppkey:@"XXXX#XXXX"];
    
    // 填写上传证书时设置的名称
    options.apnsCertName = @"PushCertName";
    
    [AgoraChatClient.sharedClient initializeSDKWithOptions:options];
    
    return YES;
}
```

3. 获取 Device Token，并传递给 SDK。

```swift
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AgoraChatClient.sharedClient registerForRemoteNotificationsWithDeviceToken:deviceToken completion:^(AgoraError *aError) {
        if (aError) {
            NSLog(@"bind deviceToken error: %@", aError.errorDescription);
        }
    }];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Register Remote Notifications Failed");
}
```

4. 配置推送属性，包括推送显示名称、推送样式、群组是否接收推送以及推送免打扰等。

**设置推送显示名称**

参考如下代码设置推送显示名称：

```swift
[AgoraChatClient.sharedClient.pushManager updatePushDisplayName:@"displayName" completion:^(NSString * aDisplayName, AgoraError * aError) {
    if (aError) 
    {
        NSLog(@"update push display name error: %@", aError.errorDescription);
    }
}];
```

**设置推送显示样式**

参考如下代码设置是否显示推送消息内容：

```swift
[AgoraChatClient.sharedClient.pushManager updatePushDisplayStyle:AgoraPushDisplayStyleSimpleBanner completion:^(AgoraError * aError)
{
    if(aError)
    {
        NSLog(@"update display style error --- %@", aError.errorDescription);
    }
}];
```

| 参数         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `DisplayStyle` | <li>`AgoraPushDisplayStyleSimpleBanner`：显示"您有一条新消息"。<li>`AgoraPushDisplayStyleMessageSummary`：显示具体消息内容。 |

**设置群组免打扰**

群组免打扰指不接收指定群组的消息推送，设置群组免打扰后，当用户与服务器断开连接时不会收到该群组的消息推送。

```
[AgoraChatClient.sharedClient.pushManager updatePushServiceForGroups:groupIds disablePush:YES completion:^(AgoraError * aError)
{
    if(aError)
    {
        NSLog(@"update groups disable push error --- %@", aError.errorDescription);
    }
}];
```

| 参数     | 描述           |
| :------- | :------------- |
| groupIds | 群组 ID 列表。 |

**获取免打扰群组列表**

参考如下代码获取免打扰的群组列表：

```swift
NSArray<NSString*>* groupIds = [AgoraChatClient.sharedClient.pushManager noPushGroups];
```

| 参数     | 描述                   |
| :------- | :--------------------- |
| `groupIds` | 免打扰的群组 ID 列表。 |

**设置单人免打扰**

单人免打扰主指不接收指定用户的消息推送，设置单人免打扰后，当用户与服务器断开连接时不会收到该用户的消息推送。

```swift
[AgoraChatClient.sharedClient.pushManager updatePushServiceForUsers:userIds disablePush:YES completion:^(EMError * _Nonnull aError) {
    if(aError)
    {
        NSLog(@"update users disable push error --- %@", aError.errorDescription);
    }
}];
```
| 参数    | 描述         |
| :------ | :----------- |
| `userIds` | 用户名列表。 |

**获取单人免打扰列表**

参考如下代码获取免打扰的用户列表：

```swift
NSArray<NSString*>* userIds = [EMClient.sharedClient.pushManager noPushUIds];
```

| 参数    | 描述                 |
| :------ | :------------------- |
| `userIds` | 免打扰的用户名列表。 |

**设置消息推送免打扰**

参考如下代码，设置消息推送免打扰时间段：

```swift
AgoraError *aError = [AgoraChatClient.sharedClient.pushManager disableOfflinePushStart:22 end:7];
if (aError) 
{
    NSLog(@"disable push error --- %@", aError.errorDescription);
}
```

| 参数    | 描述                                          |
| :------ | :-------------------------------------------- |
| `start` | Int 类型。免打扰的起始时间。取值范围 [0,24]。 |
| `end`   | Int 类型。免打扰的结束时间。取值范围 [0,24]。 |

**开启消息推送**

参考如下代码，开启消息推送：
	
```swift
AgoraError *aError = [AgoraChatClient.sharedClient.pushManager enableOfflinePush];
if (aError) 
{
    NSLog(@"enable push error --- %@", aError.errorDescription);
}
```

**获取消息推送属性**

参考如下代码，获取消息推送属性：

```swift
[AgoraChatClient.sharedClient.pushManager getPushNotificationOptionsFromServerWithCompletion:^(AgoraPushOptions * aOptions, AgoraError * aError)
{
    if (aError)
    {
        NSLog(@"get push options error --- %@", aError.errorDescription);
    }
}];
```
`aOptions` 包含如下字段：

| 字段                 | 描述                 |
| :------------------- | :------------------- |
| `displayName`        | 推送显示名称。       |
| `displayStyle`       | 推送显示方式。       |
| `noDisturbingStartH` | 免打扰的起始时间。   |
| `noDisturbingEndH`   | 免打扰的结束时间。   |
| `isNoDisturbEnable`  | 是否开启消息免打扰。 |

5. 收到用户设备收到推送通知，并点击推送消息时，app 解析消息字段。

```swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
}
```
推送消息 userInfo 示例如下：
	
```json
{
    "aps":{
        "alert":{
            "body":"您有一条新消息"
        },	 
        "badge":1,				 
        "sound":"default"	
    },
    "f":"6001",					 
    "t":"6006",	
    "g":"1421300621769",	
    "m":"373360335316321408"
}
```

| 参数    | 描述                                |
| :------ | :---------------------------------- |
| `body`  | 消息显示内容。                      |
| `badge` | 角标数。                            |
| `sound` | 提示铃声。                          |
| `f`     | 消息发送方用户名。                  |
| `t`     | 消息接收方用户名。                  |
| `g`     | 群组 ID，如果是单聊则该字段不存在。 |
| `m`     | 消息 ID。消息的唯一标识符。         |

## 更多功能

### 自定义字段

向推送中添加你自己的业务字段以满足业务需求，比如通过这条推送跳转到某个活动页面。

```swift
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"extern":@"custom string"}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| 参数             | 描述                |
| :--------------- | :------------------ |
| `body`           | 推送消息内容。      |
| `ConversationID` | 消息所属的会话 ID。 |
| `from`           | 消息发送方用户名。  |
| `to`             | 消息接收方用户名。  |
| `em_apns_ext`    | 消息扩展字段。      |
| `extern`         | 消息扩展具体内容。  |

示例如下：
	
```json
{
    "apns": {
        "alert": {
            "body": "test"
        }, 
        "badge": 1, 
        "sound": "default"
    }, 
    "e": "custom string", 
    "f": "6001", 
    "t": "6006", 
    "m": "373360335316321408"
}
```

| 参数    | 描述            |
| :------ | :-------------- |
| `body`  | 显示内容。      |
| `badge` | 角标数。        |
| `sound` | 提示铃声。      |
| `f`     | 消息发送方 ID。 |
| `t`     | 消息接收方 ID。 |
| `e`     | 自定义信息。    |
| `m`     | 消息 ID。       |

### 自定义显示

参考如下代码，自定义推送消息显示内容：

```swift
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_content":@"custom push content"}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| 参数              | 描述                |
| :---------------- | :------------------ |
| `body`            | 推送消息内容。      |
| `ConversationID`  | 消息所属的会话 ID。 |
| `from`            | 消息发送方用户名。  |
| `to`              | 消息接收方用户名。  |
| `em_apns_ext`     | 消息扩展字段。      |
| `em_push_content` | 消息扩展具体内容。  |


示例如下：
```json
{
    "aps":{
        "alert":{
            "body":"custom push content"
        },	 
        "badge":1,				 
        "sound":"default"		 
    },
    "f":"6001",					 
    "t":"6006",					 
    "m":"373360335316321408",
}
```

| 参数    | 描述                      |
| :------ | :------------------------ |
| `body`  | 推送消息内容。            |
| `badge` | 角标数。                  |
| `sound` | 提示铃声。                |
| `f`     | 消息发送方用户名。        |
| `t`     | 消息接收方用户名。        |
| `m`     | 消息 ID。消息唯一标识符。 |

### 自定义铃声

推送铃声指用户收到消息推送时的提示音，你需要将音频文件加入到 app 中，并在推送中配置使用的音频文件名称。详见[苹果官方文档](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification?language=objc)。

```swift
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_sound":@"custom.caf"}};
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| 参数             | 描述                 |
| :--------------- | :------------------- |
| `body`           | 推送消息内容。       |
| `ConversationID` | 消息所属的会话 ID。  |
| `from`           | 消息发送方用户名。   |
| `to`             | 消息接收方用户名。   |
| `em_apns_ext`    | 消息扩展字段。       |
| `em_push_sound`  | 自定义提示铃声。     |
| `custom.caf`     | 铃声的音频文件名称。 |

示例如下：
```json
{
    "aps":{
        "alert":{
            "body":"您有一条新消息"
        },  
        "badge":1,  
        "sound":"custom.caf"  
    },
    "f":"6001",  
    "t":"6006",  
    "m":"373360335316321408"  
}
```

| 参数    | 描述                      |
| :------ | :------------------------ |
| `body`  | 推送消息内容。            |
| `badge` | 角标数。                  |
| `sound` | 提示铃声。                |
| `f`     | 消息发送方用户名。        |
| `t`     | 消息接收方用户名。        |
| `m`     | 消息 ID。消息唯一标识符。 |

### 强制推送

设置强制推送后，用户发送消息时会忽略接收方的免打扰设置，不论是否处于免打扰时间段都会正常向接收方推送消息。

```swift
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_force_notification":@YES};
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| 参数                    | 描述                                        |
| :---------------------- | :------------------------------------------ |
| `body`                  | 推送消息内容。                              |
| `ConversationID`        | 消息所属的会话 ID。                         |
| `from`                  | 消息发送方用户名。                          |
| `to`                    | 消息接收方用户名。                          |
| `em_force_notification` | 是否为强制推送：YES：强制推送NO：非强制推送 |

### 扩展功能

如果你的目标平台是 iOS 10.0 或更高版本，你可以参考如下代码，实现 [`UNNotificationServiceExtension`](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension?language=objc) 的扩展功能。

```swift
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_mutable_content":@YES}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| 参数                      | 描述                           |
| :------------------------ | :----------------------------- |
| `body`                    | 推送消息内容。                 |
| `ConversationID`          | 消息所属的会话 ID。            |
| `from`                    | 消息发送方用户名。             |
| `to`                      | 消息接收方用户名。             |
| `em_apns_ext`             | 消息扩展内容，包含自定义字段。 |
| `em_push_mutable_content` | 是否使用 `em_apns_ext。`       |

示例如下：
```json
{
    "aps":{
        "alert":{
            "body":"test"
        },  
        "badge":1,  
        "sound":"default",
        "mutable-content":1  
    },
    "f":"6001",  
    "t":"6006",  
    "m":"373360335316321408"  
}
```

| 参数              | 描述                                               |
| :---------------- | :------------------------------------------------- |
| `body`            | 推送消息内容。                                     |
| `badge`           | 角标数。                                           |
| `sound`           | 提示铃声。                                         |
| `mutable-content` | 设置为 1 表示激活 UNNotificationServiceExtension。 |
| `f`               | 消息发送方用户名。                                 |
| `t`               | 消息接收方用户名。                                 |
| `m`               | 消息 ID。                                          |