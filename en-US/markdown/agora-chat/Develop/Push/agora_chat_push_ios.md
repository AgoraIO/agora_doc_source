# Offline Push

Agora Chat supports the integration of Apple Push Notification service (APNs). This enables iOS developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

## Understand the tech

The following figure shows the basic workflow of Agora Chat:

![](https://web-cdn.agora.io/docs-files/1655713469832)

Assume that User A sends a message to User B, but User B goes offline before receiving it. The Agora Chat server pushes a notification to the device of User B via APN and temporarily stores this message. Once User B comes back online, the Agora Chat SDK pulls the message from the server and pushes the message to User B using persistent connections.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios).
- You have activated the advanced features for push in [Agora Console](https://console.agora.io/). Advanced features allow you to set the push notification mode, do-not-disturb mode, and custom push template.


## Integrate APN with Agora Chat

### 1. Create push certificates<a name="step1"></a>

Follow these steps to enable the APNs service:

1. Request a Certificate Signing Request (CSR) file.<a name="step1-1"></a>   
    1. Open the **Keychain Access** app on your device, and select **Keychain Access** > **Certificate Assistant** > **Request a Certificate from a Certificate Authority**.
    2. In the **Certificate Assistant** dialog box, fill in **User Email Address** and **Common Name**, select **Saved to disk**, and click **Continue** to specify a path to save the file.  
    ![](https://web-cdn.agora.io/docs-files/1647878103996)  
    3. You can get a CSR file named `CertificateSigningRequest.certSigningRequest` in the specified path.

2. Create an App ID.<a name="step1-2"></a>  
    1. Log in to the [iOS Developer Center](https://developer.apple.com/), and select **Account** > **Certificates, Identifiers & Profiles** > **Identifiers**.
    2. In the **Identifiers** tab, click the **+** icon to the right of **Identifiers**.
    3. In the **Register a new identifier** page, select **App** for the type, and click **Continue**.
    4. In the **Register an App ID** page, configure the following fields:
        - **Description**: Fill in the description of the App ID.
        - **Bundle ID**: Specify a value in `com.YourCompany.YourProjectName` format.
        - **Capabilities**: Select **Push Notifications**.
    5. Confirm the information, and click **Register** to generate the App ID.  

3. Create a push certificate for both the development environment and the production environment in turn.<a name="step1-3"></a>  
    1. Go back to the **Identifiers** tab, and select the **App ID** created in [step 2](#step1-2).
    2. In the **Edit your App ID Configuration** page, locate **Push Notifications**, and click **Configure**.
    3. In the **Apple Push Notification service SSL Certificates** dialog box, click **Create Certificate** to create the push certificate for the development environment or the production environment, as applicable.
    4. In the **Create a New Certificate** page, select **iOS** for **Platform**, upload the CSR file created in [step 1](#step1-1), and click **Continue**.
    5. In the **Download Your Certificate** page, click **Download** to generate the [Apple Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) certificate.

4. Generate the push certificate.<a name="step1-4"></a>  
    1. Double-click to import the push certificate created in [step 3](#step1-3) to the Keychain.
    2. Open **Keychain Access**, select **login** > **Certificates**, right-click the push certificate to export as a `.p12` file, and set the certificate key.

5. Generate a Provisioning Profile file.  
    1. Log in to [iOS Developer Center](https://developer.apple.com/), and select **Account** > **Certificates, Identifiers & Profiles** > **Profiles**.
    2. In the **Profiles** tab, click the **+** icon to the right of **Profiles**.
    3. In the **Register a New Provisioning Profile** page, select **iOS App Development** for **Development**, select **Ad Hoc** for **Distribution**, and click **Continue**.  
    For an official release on the App Store, select **App Store** instead for **Distribution**.
    4. In the **Generate a Provisioning Profile** page, configure the following fields:
        - **App ID**: Fill in the App ID created in [step 2](#step1-2).
        - **Select Certificates**: Select the `.p12` file generated in [step 4](#step1-4).
        - **Select Devices**: Select the device used to develop.
        - **Provisioning Profile Name**: Fill in the name used to identify the profile.  
    5. Confirm the information, and click **Download** to generate the Provisioning Profile file.

### 2. Upload push certificates

Follow the steps to upload the certificates to Agora Console:

1. Log in to [Agora Console](https://console.agora.io/), and click **Project Management** in the left navigation bar.

2. In the **Project Management** page, select the project item used to enable Agora Chat, and click **Config** in the **Action** column.  

3. Add `/chat` after the URL of the project config page, and press **Enter**.

4. In the **Push Notifications** module, click **Add Push Certificate**.

5. In the pop-up window, select the **APPLE** tab, and configure the following fields:
   - **Bind ID**: Fill in the [bundle ID](#step1-2) specified when the App ID was created.
   - **Certificate Type**: Select the [file type](#step1-4) specified when the certificate was exported. In this case, select **p12**.
   - **Certificate Name**: Fill in the [name](#step1-4) specified when the certificate was exported.
   - **Certificate Secret**: Fill in the [secret](#step1-4) specified when the certificate was exported.
   - **Upload**: Upload the [certificate](#step1-4) exported.
   - **Environment**: Select **Development** or **Production Environment**. Upload the `p12` file for the development and production environments in turn.

    Click **Save** to add the push certificate.

![](https://web-cdn.agora.io/docs-files/1649907692419)

### 3. Enable APN in Agora Chat SDK

1. Open Xcode, and select **TARGETS** > **Capability** > **Push Notifications** to enable push notifications.

2. Pass the certificate name to the SDK.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Register for notifications
    [application registerForRemoteNotifications];
    
    // Initialize Options and set AppKey
    AgoraOptions *options = [AgoraOptions optionsWithAppkey:@"XXXX#XXXX"];
    
    // Fill in the name specified when uploading the certificate
    options.apnsCertName = @"PushCertName";
    
    [AgoraChatClient.sharedClient initializeSDKWithOptions:options];
    
    return YES;
}
```

3. Get a Device Token, and pass it to the SDK.

```objective-c
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

## Set up push notifications

To optimize user experience when dealing with an influx of push notifications, Agora Chat provides fine-grained options over the push notification and do-not-disturb (DND) modes at both the app level and the conversation level, as shown in the following table:

<table class="" cellspacing=0 border=1>
<tbody>
    <tr>
        <th style="font-family:Helvetica Neue">
            <nobr>Mode</nobr>
        </th>
        <th style="font-family:Helvetica Neue">
            <nobr>Option</nobr>
        </th>
        <th style="font-family:Helvetica Neue">
            <nobr>App</nobr>
        </th>
        <th style="font-family:Helvetica Neue">
            <nobr>Conversation</nobr>
        </th>
    </tr>
    <tr>
        <td rowspan=3>
            <nobr>Push notification mode</nobr>
        </td>
        <td>
            <nobr><code>All</code>: Receives push notifications for all offline messages.</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
    </tr>
    <tr>
        <td>
            <nobr><code>MentionOnly</code>: Only receives push notifications for mentioned messages.</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
    </tr>
    <tr>
        <td>
            <nobr><code>None</code>: Do not receive push notifications for offline messages.</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
    </tr>
    <tr>
        <td rowspan=2>
            <nobr>Do-not-disturb mode</nobr>
        </td>
        <td>
            <nobr><code>silentModeDuration</code>: Do not receive push notifications in the specified duration.</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
    </tr>
    <tr>
        <td>
            <nobr><code>silentModeStartTime</code> & <code>silentModeEndTime</code>: Do not receive push notifications in the specified time frame.</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✓</nobr>
        </td>
        <td style="text-align:center">
            <nobr>✗</nobr>
        </td>
    </tr>
</tbody>
</table>


**Push notification mode**

The setting of the push notification mode at the conversation level takes precedence over that at the app level, and those conversations that do not have specific settings for the push notification mode inherit the app setting by default.

Assume that the push notification mode of the app is set to `MentionOnly`, while that of the specified conversation is set to `All`. You receive all the push notifications from this conversation, while you only receive the push notifications for mentioned messages from all the other conversations.

**Do-not-disturb mode**

<div class="alert note"><ol><li>You can specify both the DND duration and DND time frame at the app level. During the specified DND time periods, you do not receive any push notifications.<li>Conversations only support the DND duration setting, while the setting of the DND time frame does not take effect.</ol></div>

For both the app and all the conversations in the app, the setting of the DND mode takes precedence over the setting of the push notification mode.

Assume that a DND time period is specified at the app level and the push notification mode of the specified conversation is set to `All`. The DND mode takes effect regardless of the setting of the push notification mode, that is, you do not receive any push notifications during the specified DND time period.

Assume that a DND time period is specified for a conversation, while the app does not have any DND settings and its push notification mode is set to `All`. You do not receive any push notifications from this conversation during the specified DND time period, while the push of all the other conversations remains the same.


### Set the push notifications of an app

You can call `setSilentModeForAll` to set the push notifications at the app level, and set the push notification mode and DND mode by specifying the `AgoraChatSilentModeParam` field, as shown in the following code sample:

```objective-c
// Sets the push notification mode to `MentionOnly` for an app.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeRemindType];
    param.remindType = AgoraChatPushRemindTypeMentionOnly;
// Sets the push notifications at the app level.
[[AgoraChatClient sharedClient].pushManager setSilentModeForAll:param completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (aError) {
                NSLog(@"setSilentModeForAll error---%@",aError.errorDescription);
            }
        }];
// Sets the DND duration to 15 minutes.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeDuration = 15;
// Sets the DND time frame from 8:30 to 15:00.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeStartTime = [[AgoraChatSilentModeTime alloc]initWithHours:8 minutes:30];
    param.silentModeEndTime = [[AgoraChatSilentModeTime alloc]initWithHours:15 minutes:0];
```


### Retrieve the push notification setting of an app

You can call `getSilentModeForAllWithCompletion` to retrieve the push notification settings at the app level, as shown in the following code sample:

```objective-c
[[AgoraChatClient sharedClient].pushManager getSilentModeForAllWithCompletion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (!aError) {
                // Retrieves the setting of the push notification mode at the app level.
                AgoraChatPushRemindType remindType = aResult.remindType;
                // Retrieves the Unix timestamp when the DND duration of an app expires.
                NSTimeInterval ex = aResult.expireTimestamp;
                // Retrieves the start time specified in DND time frame at the app level.
                AgoraChatSilentModeTime *startTime = aResult.silentModeStartTime;
                // Retrieves the end time specified in DND time frame at the app level.
                AgoraChatSilentModeTime *endTime = aResult.silentModeEndTime;
            }else{
                NSLog(@"getSilentModeForAll error---%@",aError.errorDescription);
            }
        }];
```


### Set the push notifications of a conversation

You can call `setSilentModeForConversation` to set the push notifications for the conversation specified by the `conversationId` and `AgoraChatConversationType` fields, as shown in the following code sample:

```objective-c
// Sets the push notification mode to `MentionOnly` for a conversation.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeRemindType];
    param.remindType = AgoraChatPushRemindTypeMentionOnly;
// Sets the DND duration to 15 minutes.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeDuration];
    param.silentModeDuration = 15;
// Sets the push notifications at the conversation level.                                    
AgoraChatConversationType conversationType = AgoraChatConversationTypeGroupChat;
[[AgoraChatClient sharedClient].pushManager setSilentModeForConversation:@"conversationId" conversationType:conversationType params:param completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
        if (aError) {
                NSLog(@"setSilentModeForConversation error---%@",aError.errorDescription);
         }
     }];
```


### Retrieve the push notification setting of a conversation

You can call `getSilentModeForConversation` to retrieve the push notification settings of the conversation specified by the `conversationId` and `AgoraChatConversationType` fields, as shown in the following code sample:

```objective-c
[[AgoraChatClient sharedClient].pushManager getSilentModeForConversation:@"conversationId" conversationType:AgoraChatConversationTypeChat completion:^(AgoraChatSilentModeResult * _Nullable aResult, AgoraChatError * _Nullable aError) {
    }];
```


### Retrieve the push notification settings of multiple conversations

<div class="alert info"><ol><li>You can retrieve the push notification settings of up to 20 conversations at each call.<li>If a conversation inherits the app setting or its push notification setting has expired, the returned dictionary does not include this conversation.</ol></div>

You can call `getSilentModeForConversations` to retrieve the push notification settings of multiple conversations, as shown in the following code sample:

```objective-c
NSArray *conversations = @[conversation1,conversation2];
[[AgoraChatClient sharedClient].pushManager getSilentModeForConversations:conversationArray completion:^(NSDictionary<NSString*,AgoraChatSilentModeResult*>*aResult, AgoraChatError *aError) {
        if (aError) {
            NSLog(@"getSilentModeForConversations error---%@",aError.errorDescription);
        }
    }];
```


### Clear the push notification setting of a conversation

You can call `clearRemindTypeForConversation` to clear the push notification setting of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification setting of a conversation:

```objective-c
    [[AgoraChatClient sharedClient].pushManager clearRemindTypeForConversation:@"" conversationType:conversationType completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (aError) {
                NSLog(@"clearRemindTypeForConversation error---%@",aError.errorDescription);
            }
    }];
```


## Set up display attributes

### Set the display attributes of push notifications

You can call `updatePushDisplayName` to set your nickname displayed in push notifications, as shown in the following code sample:

```objective-c
[AgoraChatClient.sharedClient.pushManager updatePushDisplayName:@"displayName" completion:^(NSString * aDisplayName, AgoraError * aError) {
    if (aError) 
    {
        NSLog(@"update push display name error: %@", aError.errorDescription);
    }
}];
```

You can also call `updatePushDisplayStyle` to set the display style of push notifications, as shown in the following code sample:

```objective-c
// `AgoraPushDisplayStyleSimpleBanner` indicates that only displays "You have a new message".
// To display the message content, set `DisplayStyle` to `AgoraPushDisplayStyleMessageSummary`.
[AgoraChatClient.sharedClient.pushManager updatePushDisplayStyle:AgoraPushDisplayStyleSimpleBanner completion:^(AgoraError * aError)
{
    if(aError)
    {
        NSLog(@"update display style error --- %@", aError.errorDescription);
    }
}];
```

### Retrieve the display attributes of push notifications

You can call `getPushNotificationOptionsFromServerWithCompletion` to retrieve the display attributes in push notifications, as shown in the following code sample:

```objective-c
[[AgoraChatClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(AgoraChatPushOptions *aOptions, AgoraChatError *aError) {
            if (!aError) {
                // Retrieves the nickname displayed in push notifications.
                NSString *displayName = aOptions.displayName;
                // Retrieves the display style of push notifications.
                AgoraChatPushDisplayStyle dispalyStyle = aOptions.displayStyle;
            }
        }];
```


## Set up push translations

If a user enables the [automatic translation](./agora_chat_translation_ios?platform=iOS#automatic-translation) feature and sends a message, the SDK sends both the original message and the translated message.

Push notifications work in tandem with the translation feature. As a receiver, you can set the preferable target language of push notifications that you are willing to receive when you are offline. If the language of the translated message meets your setting, the translated message displays in push notifications; otherwise, the original message displays instead.

The following code sample shows how to set and retrieve the preferable target language of push notifications

```objective-c
// Sets the preferable target language of push notifications.
[[AgoraChatClient sharedClient].pushManager setPreferredNotificationLanguage:@"EU" completion:^(AgoraChatError *aError) {
    if (aError) {
        NSLog(@"setPushPerformLanguageCompletion error---%@",aError.errorDescription);
    }
}];
// Retrieves the preferable target language of push notifications.
[[AgoraChatClient sharedClient].pushManager getPreferredNotificationLanguageCompletion:^(NSString *aLaguangeCode, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"getPushPerformLanguage---%@",aLaguangeCode);
    }
}];
```


## Set up push templates

Agora Chat allows users to use ready-made templates for push notifications.

You can create and provide push templates for users in [Agora Console](https://console.agora.io/) by referring to the following steps:

1. In the left-side panel, select **Project Management**.

2. On the **Project Management** page, select the **Config** button in the **Action** column of the project that you want to set push templates.

3. On the project details page, select the **Config** button in the **Agora Chat** section.

4. In the left-side panel of the Agora Chat configuration page, select **Push Template**.

5. On the **Push Template** page, click **Add Push Template**, and configure the fields in the pop-up window, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1655445229699)

Once the template creation is complete in Agora Console, users can set to use this push template when sending a message, as shown in the following code sample:

```objective-c
// Takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc]initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc]initWithConversationID:@"conversationId" from:@"currentUsername" to:@"conversationId" body:body ext:nil];
       // Sets to use the template created in Agora Console.
       NSDictionary *pushObject = @{
           @"name":@"templateName",// Sets the template name.
           @"title_args":@[@"titleValue1"],// Sets the template title by specifying the variable.
           @"content_args":@[@"contentValue1"]// Sets the template content by specifying the variable.
       };
       message.ext = @{
           @"em_push_template":pushObject,
       };
       message.chatType = AgoraChatTypeChat;
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```


## What's next

This section includes more versatile push notification features that you can use to implement additional functions if needed.

If the ready-made templates cannot meed your requirements, Agora Chat also enables you to customize your push notifications.

### Custom fields

The following code sample shows how to add an extension field in push notifications:

```objective-c
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"extern":@"custom string"}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| Parameter             | Description                |
| :--------------- | :------------------ |
| `body`           | The displayed content of the message.      |
| `ConversationID` | The ID of the session to which the message belongs. |
| `from`           | The username of the sender.  |
| `to`             | The username of the receiver. |
| `em_apns_ext`    | The message extension field.      |
| `extern`         | The message extension content.  |

An example is as follows:
	
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

| Parameter    | Description            |
| :------ | :-------------- |
| `body`  | The displayed content of the message.   |
| `badge` | The number of push notifications.       |
| `sound` | The sound of push notifications.      |
| `f`     | The username of the sender. |
| `t`     | The username of the receiver. |
| `e`     | The custom message.  |
| `m`     | The ID of the message.      |

### Custom displays

The following code sample shows how to customize the display style in push notifications:

```objective-c
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_content":@"custom push content"}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| Parameter              | Description                |
| :---------------- | :------------------ |
| `body`            | The displayed content of the message.      |
| `ConversationID`  | The ID of the session to which the message belongs. |
| `from`            | The username of the sender.  |
| `to`              | The username of the receiver. |
| `em_apns_ext`     | The extension field.     |
| `em_push_content` | The extension content.  |


An example is as follows:

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

| Parameter    | Description                      |
| :------ | :------------------------ |
| `body`  | The displayed content of the message.           |
| `badge` | The number of push notifications.                  |
| `sound` | The sound of push notifications.                |
| `f`     | The username of the sender.       |
| `t`     | The username of the receiver.      |
| `m`     | The ID of the message. The unique identifier of the message. |

### Custom sounds

To use a custom sound for push notifications, you need to add the audio file to the app and configure the filename for the push. For details, see [Apple Official Documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification?language=objc).  
The following sample code customizes the sound of the push notification:

```objective-c
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_sound":@"custom.caf"}};
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| Parameter             | Description                 |
| :--------------- | :------------------- |
| `body`           | The displayed content of the message.     |
| `ConversationID` | The ID of the session to which the message belongs.  |
| `from`           | The username of the sender.    |
| `to`             | The username of the receiver.   |
| `em_apns_ext`    | The extension field.        |
| `em_push_sound`  | The custom sound.     |
| `custom.caf`     | The filename of the sound. |

An example is as follows:

```json
{
    "aps":{
        "alert":{
            "body":"You have a new message"
        },  
        "badge":1,  
        "sound":"custom.caf"  
    },
    "f":"6001",  
    "t":"6006",  
    "m":"373360335316321408"  
}
```

| Parameter    | Description                      |
| :------ | :------------------------ |
| `body`  | The displayed content of the message.           |
| `badge` | The number of push notifications.                 |
| `sound` | The sound of push notifications.                |
| `f`     | The username of the sender.        |
| `t`     | The username of the receiver.       |
| `m`     | The ID of the message. The unique identifier of the message. |

### Force push notifications

Once you force a push notification to a user, the user receives the message regardless of the do-not-disturb settings.  
The following sample code forces a push notification:

```objective-c
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_force_notification":@YES};
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| Parameter                   | Description                                |
| :---------------------- | :------------------------------------------ |
| `body`                  | The displayed content of the message.                              |
| `ConversationID`        | The ID of the session to which the message belongs.                         |
| `from`                  | The username of the sender.                 |
| `to`                    | The username of the receiver.                       |
| `em_force_notification` | Whether to force a push notification:<li>YES: Force the push notification.<li> NO: Do not force the push notification. |

### Extensions

If the receiver uses a device running iOS 10.0 or later, you can refer to the following sample code to enable the
[`UNNotificationServiceExtension`](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension?language=objc) extension. 

```objective-c
TextMessageBody *body = [[TextMessageBody alloc] initWithText:@"test"];
Message *message = [[Message alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{@"em_push_mutable_content":@YES}}; 
message.chatType = AgoraChatTypeChat; 
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

| Parameter                      | Description                         |
| :------------------------ | :----------------------------- |
| `body`                    | The displayed content of the message.                 |
| `ConversationID`          | The ID of the session to which the message belongs.            |
| `from`                    | The username of the sender.             |
| `to`                      | The username of the receiver.             |
| `em_apns_ext`             | The extension field. |
| `em_push_mutable_content` | Whether to use `em_apns_ext`.       |

An example is as follows:
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

| Parameter              | Description                                              |
| :---------------- | :------------------------------------------------- |
| `body`            | The displayed content of the message.                                     |
| `badge`           | The number of push notifications.                            |
| `sound`           | The sound of push notifications.                     |
| `mutable-content` | Set the value to 1 to enable `UNNotificationServiceExtension`. |
| `f`               | The username of the sender.        |
| `t`               | The username of the receiver.                                 |
| `m`               | The ID of the message.                               |
