# Offline Push

Agora Chat supports the integration of Apple Push Notification service (APNs). This enables iOS developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

## Understand the tech

The following figure shows the basic workflow of Agora Chat:

![](https://web-cdn.agora.io/docs-files/1655713469832)

Assume that User A sends a message to User B, but User B goes offline before receiving it. The Agora Chat server pushes a notification to the device of User B via APN and temporarily stores this message. Once User B comes back online, the Agora Chat SDK pulls the message from the server and pushes the message to User B using persistent connections.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).


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

2. On the **Project Management** page, locate the project that has Chat enable and click **Config**.

3. On the project edit page, click **Config** next to **Chat**.

4. On the project config page, select **Features** > **Push Certificate** and click **Add Push Certificate**.

5. In the pop-up window, select the **APPLE** tab, and configure the following fields:
   - **Certificate Type**: Select the [file type](#step1-4) specified when the certificate was exported. In this case, select **p12**.
   - **Certificate Name**: Fill in the [name](#step1-4) specified when the certificate was exported.
   - **Push Key**: Fill in the [secret](#step1-4) specified when the certificate was exported.
   - **Upload Certificate**: Upload the [certificate](#step1-4) exported.
   - **Integration Environment**: Select **Development** or **Production Environment**. Upload the `p12` file for the development and production environments in turn.
   - **Bind ID**: Fill in the [bundle ID](#step1-2) specified when the App ID was created.

    Click **Save** to add the push certificate.

<img src="https://web-cdn.agora.io/docs-files/1658462476793">

### 3. Enable APN in Agora Chat SDK

1. Open Xcode, and select **TARGETS** > **Capability** > **Push Notifications** to enable push notifications.

2. Pass the certificate name to the SDK.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Register for notifications
    [application registerForRemoteNotifications];
    
    // Initialize Options and set AppKey
    AgoraChatOptions *options = [AgoraChatOptions optionsWithAppkey:@"XXXX#XXXX"];
    
    // Fill in the name specified when uploading the certificate
    options.apnsCertName = @"PushCertName";
    
    [AgoraChatClient.sharedClient initializeSDKWithOptions:options];
    
    return YES;
}
```

3. Get a Device Token, and pass it to the SDK.

```objective-c
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AgoraChatClient.sharedClient registerForRemoteNotificationsWithDeviceToken:deviceToken completion:^(AgoraChatError *aError) {
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

To optimize user experience when dealing with an influx of push notifications, Agora Chat provides fine-grained options for the push notification and do-not-disturb (DND) modes at both the app and conversation levels.

**Push notification mode**

<table width="781" height="300" border="1">
  <tbody>
    <tr>
      <td width="192"><strong>Push Notification Mode</strong></td>
      <td width="379"><strong>Description </strong></td>
      <td width="188"><strong>Application Scope</strong></td>
    </tr>
    <tr>
      <td>All</td>
      <td>Receives push notifications for all offline messages.</td>
      <td rowspan="3">Application and one-to-one and group chat conversations</td>
    </tr>
    <tr>
      <td>MentionOnly</td>
      <td>Only receives push notifications for mentioned messages. This mode is recommended for group chats. To mention one or more members in a group, you need to pass `em_at_list":["user1", "user2" ...]` for the `ext` field; to mention all members in a group, pass "em_at_list":"all" for the `ext` field.</td>
    </tr>
    <tr>
      <td>None</td>
      <td>Do not receive push notifications for offline messages.</td>
    </tr>
  </tbody>
</table>

The setting of the push notification mode at the conversation level takes precedence over that at the app level, and those conversations that do not have specific settings for the push notification mode inherit the app setting by default.

For example, assume that the push notification mode of the app is set to `MentionOnly`, while that of the specified conversation is set to `All`. You receive all the push notifications from this conversation, while you only receive the push notifications for mentioned messages from all the other conversations.

**Do-not-disturb mode**

You can specify both the DND duration and DND interval at the app level. During the specified DND time periods, you do not receive any push notifications.

<table width="726" border="1">
  <tbody>
    <tr>
      <td width="196" height="32"><strong>Do-not-disturb Parameter</strong></td>
      <td width="83"><strong>Type</strong></td>
      <td width="272"><strong> Description</strong></td>
      <td width="147"><strong> Application Scope</strong></td>
    </tr>
    <tr>
      <td height="65">AgoraChatSilentModeParamTypeInterval</td>
      <td>String</td>
      <td><p>The interval during which the DND mode is scheduled everyday. The time is represented in the 24-hour notation in the form of H:M, for example, 8:30-10:00, where H ranges from `0` to `23` in hour and M from `0` to `59` in minute. </p><li>The DND mode is enabled everyday in the specified interval. For example, if you set the interval to 8:0-10:0, the app stays in DND mode during 8:00-10:00; if you set the same period at 9:00, the DND mode works during 9:00-10:00 on the current day and 8:00-10:00 in the later days.</li>
        <li>If the start time is set to the same time spot as the end time, the app enters the permanent DND mode. However, the value 0:0-0:0 means to disable the DND mode.</li>
        <li>If the start time is later than the end time, the app remains in DND mode from the start time on the current day until the end time next day. For example, if you set the interval as 10:0-8:0, the DND mode lasts from 10:00 until 08:00 the next day. </li>
        <li>Currently, only one DND interval is allowed, with the new setting overwriting the old.</li>
        <li>If this parameter is not specified, pass in an empty string.</li>
        <li>If both this interval and `silentModeDuration` are set, the DND mode works in both periods. For example, at 8:00, if you set `AgoraChatSilentModeParamTypeInterval` to 8:0-10:0 and `AgoraChatSilentModeParamTypeDuration` to 240 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li></td>
      <td>App</td>
    </tr>
    <tr>
      <td height="108">AgoraChatSilentModeParamTypeDuration</td>
      <td>Number</td>
      <td><p>The DND duration in minutes. The value range is [0,10080], where `0` indicates that this parameter is invalid and `10080` indicates that the DND mode lasts for 7 days. </p>
        <li>Unlike `AgoraChatSilentModeParamTypeInterval` set as a daily period, this parameter specifies that the DND mode works only for the given duration starting from the current time. For example, if this parameter is set to 240 (4 hours) for the app at 8:00, the DND mode lasts only during 8:00-12:00 on the current day.</li>
        <li>If both `AgoraChatSilentModeParamTypeInterval` and `AgoraChatSilentModeParamTypeDuration` are set, the DND mode works in both periods. For example, at 8:00, if you set `AgoraChatSilentModeParamTypeInterval` to 8:0-10:0 and `AgoraChatSilentModeParamTypeDuration` to 240 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li></td>
      <td>App and one-to-one and group chat conversations in it </td>
    </tr>
  </tbody>
</table>

For both the app and all the conversations in the app, the setting of the DND mode takes precedence over the setting of the push notification mode.

For example, assume that a DND time period is specified at the app level and the push notification mode of the specified conversation is set to `All`. The DND mode takes effect regardless of the setting of the push notification mode, that is, you do not receive any push notifications during the specified DND time period.

Alternatively, assume that a DND time period is specified for a conversation, while the app does not have any DND settings and its push notification mode is set to `All`. You do not receive any push notifications from this conversation during the specified DND time period, while the push of all the other conversations remains the same.


### Set the push notifications of an app

You can call `setSilentModeForAll` to set the push notifications at the app level and set the push notification mode and DND mode by specifying the `AgoraChatSilentModeParam` field, as shown in the following code sample:

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
// Sets the DND interval from 8:30 to 15:00.
AgoraChatSilentModeParam *param = [[AgoraChatSilentModeParam alloc]initWithParamType:AgoraChatSilentModeParamTypeInterval];
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
                // Retrieves the start time specified in the DND interval at the app level.
                AgoraChatSilentModeTime *startTime = aResult.silentModeStartTime;
                // Retrieves the end time specified in the DND interval at the app level.
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


### Clear the push notification mode of a conversation

You can call `clearRemindTypeForConversation` to clear the push notification mode of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification mode of a conversation:

```objective-c
    [[AgoraChatClient sharedClient].pushManager clearRemindTypeForConversation:@"" conversationType:conversationType completion:^(AgoraChatSilentModeResult *aResult, AgoraChatError *aError) {
            if (aError) {
                NSLog(@"clearRemindTypeForConversation error---%@",aError.errorDescription);
            }
    }];
```


## Set up display attributes

### Set the display attributes of push notifications

You can call `updatePushDisplayName` to set the nickname displayed in your push notifications, as shown in the following code sample:

```objective-c
[AgoraChatClient.sharedClient.pushManager updatePushDisplayName:@"displayName" completion:^(NSString * aDisplayName, AgoraChatError * aError) {
    if (aError) 
    {
        NSLog(@"update push display name error: %@", aError.errorDescription);
    }
}];
```

You can also call `updatePushDisplayStyle` to set the display style of push notifications, as shown in the following code sample:

```objective-c
// `AgoraPushDisplayStyleSimpleBanner` indicates that only "You have a new message" displays.
// To display the message content, set `DisplayStyle` to `AgoraPushDisplayStyleMessageSummary`.
[AgoraChatClient.sharedClient.pushManager updatePushDisplayStyle:AgoraPushDisplayStyleSimpleBanner completion:^(AgoraChatError * aError)
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

Push notifications work in tandem with the translation feature. As a receiver, you can set the preferred language of push notifications that you are willing to receive when you are offline. If the language of the translated message meets your setting, the translated message displays in push notifications; otherwise, the original message displays instead.

The following code sample shows how to set and retrieve the preferred language of push notifications

```objective-c
// Sets the preferred language of push notifications.
[[AgoraChatClient sharedClient].pushManager setPreferredNotificationLanguage:@"EU" completion:^(AgoraChatError *aError) {
    if (aError) {
        NSLog(@"setPushPerformLanguageCompletion error---%@",aError.errorDescription);
    }
}];
// Retrieves the preferred language of push notifications.
[[AgoraChatClient sharedClient].pushManager getPreferredNotificationLanguageCompletion:^(NSString *aLaguangeCode, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"getPushPerformLanguage---%@",aLaguangeCode);
    }
}];
```


## Set up push templates

Agora Chat allows users to use ready-made templates for push notifications.

You can create and provide push templates for users by referring to the following steps:

1. Log in to [Agora Console](https://console.agora.io/), and click **Project Management** in the left navigation bar.

2. On the **Project Management** page, locate the project that has Chat enable and click **Config**.

3. On the project edit page, click **Config** next to **Chat**.

4. On the project config page, select **Features** > **Push Template** and click **Add Push Template**, and configure the fields in the pop-up window, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1655445229699)

Once the template creation is complete in Agora Console, users can choose this push template as their default layout when sending a message, as shown in the following code sample:

```objective-c
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc]initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc]initWithConversationID:@"conversationId" from:@"currentUsername" to:@"conversationId" body:body ext:nil];
       // Sets the push template created in Agora Console as their default layout.
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

If the ready-made templates do not meet your requirements, Agora Chat also enables you to customize your push notifications.

### Custom fields

The following code sample shows how to add an extension field in push notifications:

```objective-c
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
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
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
message.ext = @{@"em_apns_ext":@{
    @"em_push_title": @"customTitle",
    @"em_alert_subTitle": @"customSubTitle",
    @"em_push_content": @"customContent"
}};
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
| `em_push_title` | The title of push notifications.  |
| `em_alert_subTitle` | The subtitle of push notifications.  |
| `em_push_content` | The content of push notifications.  |


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
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
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
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
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
AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:@"test"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId from:currentUsername to:conversationId body:body ext:nil];
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
