# 离线推送

Agora 即时通讯支持集成 APNs 消息推送服务，为 iOS 开发者提供低延时、高送达、高并发、不侵犯用户个人数据的离线消息推送服务。

当客户端应用进程被关闭等原因导致用户离线，Agora 即时通讯服务会通过 APNs 消息推送服务向该离线用户的设备推送消息通知。当用户再次上线时，会收到离线期间所有消息。

## 技术原理

下图展示了消息推送的基本工作流程：

![](https://web-cdn.agora.io/docs-files/1642564011796)

## 前提条件

- 已开启 Agora 即时通讯服务，详见[开启和配置即时通讯服务](./enable_agora_chat?platform=iOS)；
- 了解 Agora Chat 套餐包中的 API 调用频率限制，详见 [使用限制](https://docs.agora.io/cn/agora-chat/agora_chat_limitation)；
- 你已在[Agora 控制台](https://console.agora.io/)中激活推送高级功能。高级功能激活后，你可以设置推送通知方式、免打扰模式和自定义推送模板。

<div class="alert note">关闭推送高级功能必须联系 support@agora.io，因为该操作会删除所有相关配置。</div>

## 集成 APNs

### 1. 创建推送证书

参考以下步骤开启 APNs 推送服务：

1. 申请证书签名请求 Certificate Signing Request (CSR) 文件。<a name="step1-1"></a>
     1. 在设备上打开 **Keychain Access** 应用，选择**Keychain Access** > **Certificate Assistant** > **Request a Certificate from a Certificate Authority**。
     2. 在 **Certificate Assistant** 对话框中填写 **User Email Address**（电子邮件地址）和 **Common Name**（常用名称），选择 **Saved to disk**，点击**Continue**，添加存储路径保存文件。
     ![](https://web-cdn.agora.io/docs-files/1642564150801)
     3. 你会在该路径获取到一个名为 `CertificateSigningRequest.certSigningRequest` 的 CSR 文件。

2.创建 App ID。<a name="step1-2"></a>
   1. 登录 [iOS Developer Center](https://developer.apple.com/cn/)，选择 **Account** > **Certificates, Identifiers & Profiles** > **Identifiers** 。
   2. 在 **Identifiers** 页签，点击 **Identifiers**  右侧的 **+** 。
   3. 在**Register a new identifier** 页面中， **Select a type**: 选择 **App**，点击 **Continue**。
   4. 在**Register an App ID**页面中，配置如下字段：
       - **Description**: App ID 的描述信息。
       - **Bundle ID**: 可以设置为 `com.YourCompany.YourProjectName`。
       - **Capabilities**: 选择 **Push Notification**。

3. 分别创建开发环境和生产环境的消息推送证书。<a name="step1-3"></a>
     1. 在  **Identifiers** 页签中，选择[步骤 2](#step1-2)中创建的 **App ID**。
     2. 在 **Edit your App ID Configuration** 页面，找到 **Push Notifications**，点击 **Configure**。
     3. 在 **Apple Push Notification service SSL Certificates** 对话框中，点击 **Create Certificate** 创建适用于开发环境或生产环境的推送证书。
     4. 在 **Create a New Certificate** 页面，**Platform** 选择 **iOS**，上传[步骤 1](#step1-1) 中创建的 CSR 文件，点击  **Continue**。
     5. 在 **Download Your Certificate** 页面，点击 **Download** 生成 [APNs](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) 证书。

4. 生成推送证书。<a name="step1-4"></a>
     1. 双击导入[步骤 3](#step1-3)中 Keychain 中创建的推送证书。
     2. 打开 **Keychain Access**，选择  **login** > **Certificates**，找到已经导入的证书，右键选择该证书导出为 `.p12`  文件，设置证书密钥。

5. 生成 Provisioning Profile 文件。
   1. 登录 [iOS Developer Center](https://developer.apple.com/cn/)，选择 **Account** > **Certificates, Identifiers & Profiles** > **Profiles**。
   2. 在 **Provisioning** 页签，点击 **Profiles** 右侧的 **+** 图标。
   3. 在 **Register a New Provisioning Profile** 页面，**Development** 选择 **iOS App Development**，**Distribution** 选择 **Ad Hoc**，点击 **Continue**。
  对应于 App Store 上的正式版本，**Distribution** 选择 **App Store** 。
   4. 在 **Generate a Provisioning Profile** 页面，配置如下字段：
      - **App ID**：填写[步骤 2](#step1-2)创建的 App ID。
      - **Select Certificates**：选择[步骤 4](#step1-4)中生成的 `.p12` 文件。
      - **Select Devices**：选择待开发的设备。
      - **Provisioning Profile Name**：填写 Provisioning Profile 文件名称。
   5. 确认信息，点击 `Download` 生成 Provisioning Profile 文件。

### 2.上传推送证书到控制台

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
   - 证书名称：消息推送证书名称。填写在[创建推送证书](#certificate)中创建的消息推送证书名称。
   - 证书密钥：消息推送证书密钥。填写在[创建推送证书](#certificate)中导出消息推送证书文件时设置的证书密钥。
   - 上传文件：上传[创建推送证书](#certificate)中获取的消息推送证书文件。
   - 绑定 ID：Bundle ID。[创建推送证书](#certificate)中创建 App ID 时设置的 Bundle ID。
   - 环境：根据业务需要选择环境。开发、生产环境的证书需要分开上传。

## 在客户端实现消息推送

1. 打开 Xcode，点击 **Targets** > **Capability** > **Push Notifications** 开启消息推送权限。

2. 将证书名称传递给 SDK。

```swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注册推送
    [application registerForRemoteNotifications];
    
    // 初始化选项，并设置 App Key
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

## 设置推送通知 

为优化用户在处理大量推送通知时的体验，Agora Chat 在 app 和会话层面提供了推送通知和免打扰模式的细粒度选项，如下表所示：

<table>
  <tr>
    <th>模式</th>
    <th>选项</th>
    <th>App</th>
    <th>会话</th>
  </tr>
  <tr>
    <td rowspan="3">推送通知方式</td>
    <td>All：接收所有离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>MentionOnly：仅接收提及消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
     <td>NONE：不接收离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
    <tr>
    <td rowspan="2">免打扰模式</td>
    <td>silentModeDuration：在指定的持续时间内不接收推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>silentModeStartTime & silentModeEndTime：在指定的时间范围内不接收推送通知。</td>
    <td>✓</td>
    <td>✗</td>
  </tr>
  </tr>
</table>

**推送通知方式**

会话级别的推送通知方式设置优先于 app 级别的设置，未设置推送通知方式的会话默认采用 app 的设置。

例如，假设 app 的推送方式设置为 `MentionOnly`，而指定会话的推送方式设置为 `All`。你会收到来自该会话的所有推送通知，而对于其他会话来说，你只会收到提及你的消息的推送通知。

**免打扰模式**

1. 你可以在 app 级别指定免打扰时长和免打扰时间范围。这两个时间段内你不会收到任何离线推送通知。

2. 会话仅支持免打扰时长设置；免打扰时间范围的设置不生效。

对于 app 和 app 中的所有会话，免打扰模式的设置优先于推送通知方式的设置。

例如，假设在 app 级别指定了免打扰时间段，并将指定会话的推送通知方式设置为 `All`。免打扰模式与推送通知方式的设置无关，即在指定的免打扰时间段内，你不会收到任何推送通知。

或者，假设为会话指定了免打扰时间段，而 app 没有任何免打扰设置，并且其推送通知方式设置为 `All`。在指定的免打扰时间段内，你不会收到来自该会话的任何推送通知，而所有其他会话的推送保持不变。

### 设置 app 的推送通知

你可以调用 `setSilentModeForAll` 设置 app 级别的推送通知，并通过指定 `AgoraChatSilentModeParam` 字段设置推送通知方式和免打扰模式，如下代码示例所示：

```java
// 设置推送通知方式为 `MentionOnly`。
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeRemindType];
    param.remindType = AgoraChatPushRemindTypeMentionOnly;
// 设置 app 的离线推送通知。
[[AgoraChatClient sharedClient].pushManager setSilentModeForAll:param completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (aError) {
                NSLog(@"setSilentModeForAll error---%@",aError.errorDescription);
            }
        }];
// 设置离线推送免打扰时长为 15 分钟。
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeDuration = 15;
//设置离线推送的免打扰时间段为 8:30 到 15:00。
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeStartTime = [[AgoraChatSilentModeTime alloc]initWithHours:8 minutes:30];
    param.silentModeEndTime = [[AgoraChatSilentModeTime alloc]initWithHours:15 minutes:0];
```

### 获取 app 的推送通知设置

你可以调用 `getSilentModeForAllWithCompletion` 获取 app 级别的推送通知设置，如以下代码示例所示：

```java
[[AgoraChatClient sharedClient].pushManager getSilentModeForAllWithCompletion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (!aError) {
                // 获取 app 的推送通知方式的设置。
                AgoraChatPushRemindType remindType = aResult.remindType;
                // 获取 app 的离线推送免打扰过期的 Unix 时间戳。
                NSTimeInterval ex = aResult.expireTimestamp;
                // 获取 app 的离线推送免打扰时间段的开始时间。
                AgoraChatSilentModeTime *startTime = aResult.silentModeStartTime;
                // 获取 app 的离线推送免打扰时间段的结束时间。
                AgoraChatSilentModeTime *endTime = aResult.silentModeEndTime;
            }else{
                NSLog(@"getSilentModeForAll error---%@",aError.errorDescription);
            }
        }];
```

### 设置单个会话的推送通知

你可以调用 `setSilentModeForConversation` 方法设置指定会话的推送通知，并通过指定 `SilentModeParam` 字段设置推送通知方式和免打扰模式，如以下代码示例所示：

```java
// 设置推送通知方式为 `MentionOnly`。
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeRemindType];
    param.remindType = AgoraChatPushRemindTypeMentionOnly;

// 设置离线推送免打扰时长为 15 分钟。
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeDuration = 15;
// 设置会话的离线推送免打扰模式。目前，暂不支持设置会话免打扰时间段。
AgoraChatConversationType conversationType = AgoraChatConversationTypeGroupChat;
[[AgoraChatClient sharedClient].pushManager setSilentModeForConversation:@"conversationId" conversationType:conversationType params:param completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
        if (aError) {
                NSLog(@"setSilentModeForConversation error---%@",aError.errorDescription);
         }
     }];
```

### 获取单个会话的推送通知设置

你可以调用 `getSilentModeForConversation` 获取指定会话的推送通知设置，如以下代码示例所示：

```java
[[AgoraChatClient sharedClient].pushManager getSilentModeForConversation:@"conversationId" conversationType:AgoraChatConversationTypeChat completion:^(AgoraChatSilentModeResult * _Nullable aResult, AgoraChatError * _Nullable aError) {
    }];
```

### 获取多个会话的推送通知设置

1. 你可以在每次调用中最多获取 20 个会话的推送通知设置。

2. 如果会话继承了 app 设置或其推送通知设置已过期，则返回的字典不包含此会话。

你可以调用 `getSilentModeForConversations` 获取多个会话的推送通知设置，如以下代码示例所示：

```java
NSArray *conversations = @[conversation1,conversation2];
[[AgoraChatClient sharedClient].pushManager getSilentModeForConversations:conversationArray completion:^(NSDictionary<NSString*,AgoraChatSilentModeResult*>*aResult, AgoraChatError *aError) {
        if (aError) {
            NSLog(@"getSilentModeForConversations error---%@",aError.errorDescription);
        }
    }];
```

### 清除单个会话的推送通知方式的设置

你可以调用 `clearRemindTypeForConversation` 方法清除指定会话的推送通知方式的设置。清除后，默认情况下，此会话会继承 app 的设置。

以下代码示例显示了如何清除会话的推送通知方式：

```java
    [[AgoraChatClient sharedClient].pushManager clearRemindTypeForConversation:@"" conversationType:conversationType completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (aError) {
                NSLog(@"clearRemindTypeForConversation error---%@",aError.errorDescription);
            }
    }];
```

## 设置显示属性

### 设置推送通知的显示属性

你可以调用 `updatePushDisplayName` 设置推送通知中显示的昵称，如以下代码示例所示：

```java
[AgoraChatClient.sharedClient.pushManager updatePushDisplayName:@"displayName" completion:^(NSString * aDisplayName, AgoraChatError * aError) {
    if (aError) 
    {
        NSLog(@"update push display name error: %@", aError.errorDescription);
    }
}];
```

你也可以调用 `updatePushDisplayStyle` 设置推送通知的显示样式，如下代码示例所示：

```java
// 设置为简单样式 `AgoraPushDisplayStyleSimpleBanner`，即只显示 "你有一条新消息"。
// 若要显示消息内容，需将 `DisplayStyle` 设置为 `AgoraPushDisplayStyleMessageSummary`。
[AgoraChatClient.sharedClient.pushManager updatePushDisplayStyle:AgoraPushDisplayStyleSimpleBanner completion:^(AgoraChatError * aError)
{
    if(aError)
    {
        NSLog(@"update display style error --- %@", aError.errorDescription);
    }
}];
```

### 获取推送通知的显示属性

你可以调用 `getPushNotificationOptionsFromServerWithCompletion` 方法获取推送通知中的显示属性，如以下代码示例所示：

```java
[[AgoraChatClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(AgoraChatPushOptions *aOptions, AgoraChatError *aError) {
            if (!aError) {
                // 获取推送通知中的显示昵称。
                NSString *displayName = aOptions.displayName;
                // 获取推送通知的显示样式。
                AgoraChatPushDisplayStyle displayStyle = aOptions.displayStyle;
            }
        }];
```

## 设置推送翻译

如果用户启用[自动翻译功能](https://docs.agora.io/en/agora-chat/agora_chat_translation_ios?platform=iOS#automatic-translation)并发送消息，SDK 会同时发送原始消息和翻译后的消息。

推送通知与翻译功能协同工作。作为接收方，你可以设置你在离线时希望接收的推送通知的首选语言。如果翻译消息的语言符合你的设置，则翻译消息显示在推送通知中；否则，将显示原始消息。

以下代码示例显示了如何设置和获取推送通知的首选语言：

```java
// 设置离线推送的首选语言。
[[AgoraChatClient sharedClient].pushManager setPreferredNotificationLanguage:@"EU" completion:^(AgoraChatError *aError) {
    if (aError) {
        NSLog(@"setPushPerformLanguageCompletion error---%@",aError.errorDescription);
    }
}];
// 获取设置的离线推送的首选语言。
[[AgoraChatClient sharedClient].pushManager getPreferredNotificationLanguageCompletion:^(NSString *aLanguageCode, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"getPushPerformLanguage---%@",aLanguageCode);
    }
}];
```

## 设置推送模板

Agora Chat 支持自定义推送通知模板。使用前，你可以参考以下步骤为用户创建和提供推送模板：

1. 登录 Agora 控制台，点击左侧导航栏中的**项目管理**。

2. 在**项目管理**页面，找到开启聊天功能的项目，点击**配置**。

3. 在项目编辑页面，点击 **Chat** 旁边的**配置**。

4. 在项目配置页面，选择**特性 > 推送模板**并单击**添加推送模板**，在弹出的对话框中配置字段，如下图所示。

   ![image](../doc_cn_easemob/images/push_android/push_android_template_mgmt.png)

5. 创建推送模板后，用户可以在发送消息时选择使用此模板，代码示例如下所示。

```java
// 下面以文本消息为例，其他类型的消息设置方法相同。
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc]initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc]initWithConversationID:@"conversationId" from:@"currentUsername" to:@"conversationId" body:body ext:nil];
       // 将在 Agora 控制台上创建的推送模板设置为默认推送模板。
       NSDictionary *pushObject = @{
           @"name":@"templateName",// // 设置推送模板名称。
           @"title_args":@[@"titleValue1"],// 设置模板名称变量。
           @"content_args":@[@"contentValue1"]// 设置模板内容变量。
       };
       message.ext = @{
           @"em_push_template":pushObject,
       };
       message.chatType = AgoraChatTypeChat;
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```

## 更多功能

本节介绍更多通用的推送通知功能，如果需要，你可以使用这些功能来实现其他功能。

如果现有的模板不能满足你的要求，你还可以自定义推送通知。

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
| `from`           | 消息发送方的用户 ID。  |
| `to`             | 消息接收方的用户 ID。  |
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
| `f`     | 消息发送方的用户 ID。 |
| `t`     | 消息接收方的用户 ID。 |
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
| `from`            | 消息发送方的用户 ID。  |
| `to`              | 消息接收方的用户 ID。  |
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
| `f`     | 消息发送方的用户 ID。        |
| `t`     | 消息接收方的用户 ID。        |
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
| `from`           | 消息发送方的用户 ID。   |
| `to`             | 消息接收方的用户 ID。   |
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
| `f`     | 消息发送方的用户 ID。        |
| `t`     | 消息接收方的用户 ID。        |
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
| `from`                  | 消息发送方的用户 ID。                          |
| `to`                    | 消息接收方的用户 ID。                          |
| `em_force_notification` | 是否为强制推送：<br/> - `YES`：强制推送；<br/> - `NO`：非强制推送。|

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
| `from`                    | 消息发送方的用户 ID。             |
| `to`                      | 消息接收方的用户 ID。             |
| `em_apns_ext`             | 消息扩展内容，包含自定义字段。 |
| `em_push_mutable_content` | 是否使用 `em_apns_ext`。       |

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
| `f`               | 消息发送方的用户 ID。                                 |
| `t`               | 消息接收方的用户 ID。                                 |
| `m`               | 消息 ID。                                          |