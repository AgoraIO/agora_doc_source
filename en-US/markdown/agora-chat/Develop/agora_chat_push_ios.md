# Set up Push Notifications

Agora Chat supports the integration of Apple Push Notification service (APNs). This provides iOS developers with an offline push notification service that has low latency, high delivery, high concurrency, and no violation of users' personal data.

When a user closes the app and goes offline, Agora Chat will push notifications to the offline user's device through APNs. Once online, the user will receive all the messages.

## Understand the tech

The following figure shows the basic workflow of Agora Chat:

![](https://web-cdn.agora.io/docs-files/1647946470817)

## Prerequisites

- Enable Agora Chat in Agora Console. For details, see [Enable and Configure Agora Chat Service](./enable_agora_chat?platform=iOS)。
- Enable the APNs service and upload the APNs certificate to Agora Console.  
To do so, perform the following operations:

### Step 1 Enable the APNs service<a name="step1"></a>

1. Request a Certificate Signing Request (CSR) file.<a name="step1-1"></a>   
i. Click **Keychain Access** > **Certificate Assistant** > **Request a Certificate from a Certificate Authority**.  
ii. In the **Certificate Assistant** dialog box, fill in the **User Email Address** and **Common Name**, select **Saved to disk**, and click **Contitue** to specify a path to save the file.  
![](https://web-cdn.agora.io/docs-files/1647878103996)  
iii. You will get a CSR file named `CertificateSigningRequest.certSigningRequest` in the specified path.

2. Request an App ID.<a name="step1-2"></a>  
Log in to the [iOS Developer Center](https://developer.apple.com/), click **Account** > **Certificates, Identifiers & Profiles** > **Identifiers** to add an App ID, and configure the following fields:
    - **Select a type**: Select **App**.
    - **Description**: The description of the App ID.
    - **Bundle ID**: Set to `com.YourCompany.YourProjectName`.
    - **Capabilities**: Select **Push Notification**.  

3. Create a push certificate for the development environment and the production environment respectively.<a name="step1-3"></a>  
    - **Development environment**  
    i. Click **app** > **Push Notifications** > **Development SSL Certificate** > **Create Certificate**.  
    ii. Select **iOS** for **Platform**, select the CSR file created in [ step 1](#step1-1) for **Choose File**, and click **Continue**. This generates an [Apple Development IOS Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) file.  
    - **Production environment**  
    i. Click **app** > **Push Notifications** > **Production SSL Certificate** > **Create Certificate**.  
    ii. Select **iOS** for **Platform**, select the CSR file created in [step 1](#step1-1) for **Choose File**, and click **Continue**. This geneerates an [Apple Development IOS Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) file.

4. Get the push certificate.<a name="step1-4"></a>  
Double-click to import the push certificate created in [step 3](#step1-3). Go to **Keychain Access** > **login** > **My Certificates**, locate the imported certificate, right-click the certificate to export as a .p12 file, and set the certificate key.

5. Generate a Provisioning Profile file.  
Log in to [iOS Developer Center](https://developer.apple.com/), click **Account** > **Certificates, Identifiers & Profiles** > **Profiles** to add a Provisioning Profile file, and click **Continue** to configure the following fields:
    - **Development**: Select **iOS App Development**.
    - **Distribution**: Select **Ad Hoc**. For an official release on the App Store, select **App Store**.
    - **App ID**: Fill in the App ID created in [step 2](#step1-2).
    - **Select Certificates**: Select the push certificate created in [step 3](#step1-3).
    - **Select Devices**: Select the device to develop.
    - **Provisioning Profile Name**: Fill in the name of the Provisioning Profile file.  

    Click **Generate** to generate the Provisioning Profile file.

### Step 2 Upload the push certificate to Agora Console

To upload the push certificate to Agora Console, perform the following operations:

1. Log in to [Agora Console](https://sso2.agora.io/) and click **Project Management** in the left navigation bar.

2. On the **Project Maanagement** page, select the item used to enable Agora Chat and click **Config** in the **Action** column.
![](https://web-cdn.agora.io/docs-files/1647923143179)

3. Under **Real-time engagement extensions**, find **Agora Chat** and click **Enable**.
![](https://web-cdn.agora.io/docs-files/1642564694699)

4. In the **Push Notifications** module, click **Add Push Certificate**.
![](https://web-cdn.agora.io/docs-files/1647923153068)

5. In the pop-up window, select the **APPLE** tab and configure the following fields:
   - **Bind ID**: Fill in the bundle ID specified when the App ID was created in [Step 1](#step1-2).
   - **Certificate Type**: Select the file type specified when the certificate was exported in [Step 1](#step1-4). You can select p8 or p12.
   - **Certificate Name**: Fill in the name specified when the certificate was created in [Step 1](#step1-3).
   - **Certificate Secret**: Fill in the secret specified when the certificate was exported in [Step 1](#step1-4).
   - **Upload**: Upload the certificate created in [Step 1](#step1-3).
   - **Environment**: Select the environment based on your business needs. Upload the certificate for the development and production environment respectively.

    Click **Save**.

## Set up push notifications

1. Open Xcode and click **Targets** > **Capability** > **Push Notifications** to enable push notifications.

2. Pass the certificate name to the SDK.

```swift
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

3. Get a Device Token and pass it to the SDK.

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

4. Configure the notification attributes, including the display name, the display style, and the mute feature.

**Set the display name**

The following sample code specifies the display name of push notifications:

```swift
[AgoraChatClient.sharedClient.pushManager updatePushDisplayName:@"displayName" completion:^(NSString * aDisplayName, AgoraError * aError) {
    if (aError) 
    {
        NSLog(@"update push display name error: %@", aError.errorDescription);
    }
}];
```

**Set the display style**

The following sample code specifies the display style of push notifications:

```swift
[AgoraChatClient.sharedClient.pushManager updatePushDisplayStyle:AgoraPushDisplayStyleSimpleBanner completion:^(AgoraError * aError)
{
    if(aError)
    {
        NSLog(@"update display style error --- %@", aError.errorDescription);
    }
}];
```

| Parameter         | Description                                                         |
| :----------- | :----------------------------------------------------------- |
| `DisplayStyle` | `AgoraPushDisplayStyleSimpleBanner`: Displays "You have a new message".</br>`AgoraPushDisplayStyleMessageSummary`：Displays the content of the message. |

**Mute a group**

After you mute a group, you will not receive push notifications from this group when you go offline.  
The following sample code mutes the specified groups:

```
[AgoraChatClient.sharedClient.pushManager updatePushServiceForGroups:groupIds disablePush:YES completion:^(AgoraError * aError)
{
    if(aError)
    {
        NSLog(@"update groups disable push error --- %@", aError.errorDescription);
    }
}];
```

| Parameter     | Description           |
| :------- | :------------- |
| `groupIds` | The IDs of groups. |

**Retrieve the mute group list**

The following sample code retrieves the list of mute groups:

```swift
NSArray<NSString*>* groupIds = [AgoraChatClient.sharedClient.pushManager noPushGroups];
```

| Parameter     | Description                   |
| :------- | :--------------------- |
| `groupIds` | The list of group IDs. |

**Mute a user**

After you mute a user, you will not receive push notifications from this user when you go offline.  
The following sample code mutes the specified users:

```swift
[AgoraChatClient.sharedClient.pushManager updatePushServiceForUsers:userIds disablePush:YES completion:^(EMError * _Nonnull aError) {
    if(aError)
    {
        NSLog(@"update users disable push error --- %@", aError.errorDescription);
    }
}];
```
| Parameter    | Description         |
| :------ | :----------- |
| `userIds` | The IDs of users. |

**Retrieve the mute user list**

The following sample code retrieves the list of mute users:

```swift
NSArray<NSString*>* userIds = [EMClient.sharedClient.pushManager noPushUIds];
```

| Parameter    | Description                 |
| :------ | :------------------- |
| `userIds` | The list of user IDs. |

**Disable push notifications**

The following sample code specifies the mute time period when push notifications are disabled:

```swift
AgoraError *aError = [AgoraChatClient.sharedClient.pushManager disableOfflinePushStart:22 end:7];
if (aError) 
{
    NSLog(@"disable push error --- %@", aError.errorDescription);
}
```

| Parameter | Type | Description |
| :------ | :----------------- |:---------------------------- |
| `start` | Int | The start time of the mute time period. This value ranges from 0 to 24. |
| `end`   | Int | The end time of the mute time period. This value ranges from 0 to 24. |

**Enable push notifications**

You can cut short the mute time period and enable push notifications based on your needs.  
The following sample code enables push notifications:
    
```swift
AgoraError *aError = [AgoraChatClient.sharedClient.pushManager enableOfflinePush];
if (aError) 
{
    NSLog(@"enable push error --- %@", aError.errorDescription);
}
```

**Retrieve the attributes of push notifications**

The following sample code retrieves the attributes of push notifications:

```swift
[AgoraChatClient.sharedClient.pushManager getPushNotificationOptionsFromServerWithCompletion:^(AgoraPushOptions * aOptions, AgoraError * aError)
{
    if (aError)
    {
        NSLog(@"get push options error --- %@", aError.errorDescription);
    }
}];
```
`aOptions` includes the following fields:

| Field                 | Description                 |
| :------------------- | :------------------- |
| `displayName`        | The display name of push notifications.    |
| `displayStyle`       | The display style of push notifications.       |
| `noDisturbingStartH` | The start time of the mute time period.   |
| `noDisturbingEndH`   | The end time of the mute time period.   |
| `isNoDisturbEnable`  | Whether push notifications are enabled.|

5. When a user receives and clicks a push notification, the app parses this push notification as follows:

```swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
}
```

An example of a push notification is as follows:
	
```json
{
    "aps":{
        "alert":{
            "body":"You have a new message"
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

| Parameter    | Description                                |
| :------ | :---------------------------------- |
| `body`  | The displayed content of the message.                      |
| `badge` | The number of push notifications.                            |
| `sound` | The sound of push notifications.                          |
| `f`     | The user ID of the sender.                  |
| `t`     | The user ID of the receiver.                  |
| `g`     | The ID of the group.<br>If the push notification comes from a one-on-one chat instead of a group chat, this field doesn't exist. |
| `m`     | The ID of the message. The unique identifier of the message.        |

## Configure more features

### Custom fields

You can add custom fields to push notifications based on your business needs.
The following sample code redirects to an event page through this push notification:

```swift
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
| `from`           | The user ID of the sender.  |
| `to`             | The user ID of the receiver. |
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
| `f`     | The user ID of the sender. |
| `t`     | The user ID of the receiver. |
| `e`     | The custom message.  |
| `m`     | The ID of the message.      |

### Custom displays

The following sample code customizes the displayed content of the message:

```swift
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
| `from`            | The user ID of the sender.  |
| `to`              | The user ID of the receiver. |
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
| `f`     | The user ID of the sender.       |
| `t`     | The user ID of the receiver.      |
| `m`     | The ID of the message. The unique identifier of the message. |

### Custom sounds

To use a custom sound for push notifications, you need to add the audio file to the app and configure the filename for the push. For details, see [Apple Official Documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification?language=objc).  
The following sample code customizes the sound of the push notification:

```swift
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
| `from`           | The user ID of the sender.    |
| `to`             | The user ID of the receiver.   |
| `em_apns_ext`    | The extension field.        |
| `em_push_sound`  | The cusom sound.     |
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

| 参数    | 描述                      |
| :------ | :------------------------ |
| `body`  | The displayed content of the message.           |
| `badge` | The number of push notifications.                 |
| `sound` | The sound of push notifications.                |
| `f`     | The user ID of the sender.        |
| `t`     | The user ID of the receiver.       |
| `m`     | The ID of the message. The unique identifier of the message. |

### Force push notifications

Once you force a push notification to a user, the user receives the message regardless of the mute settings.  
The following sample code forces a push notification:

```swift
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
| `from`                  | The user ID of the sender.                 |
| `to`                    | The user ID of the receiver.                       |
| `em_force_notification` | Whether to force a push notification.<br>- YES: Force the push notification.<br>- NO: Do not force the push notification. |

### Extensions

If you target platform is iOS 10.0 or later, you can enable the
[`UNNotificationServiceExtension`](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension?language=objc) extension.  
The following sample code enables the `UNNotificationServiceExtension` extension:
```swift
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
| `from`                    | The user ID of the sender.             |
| `to`                      | The user ID of the receiver.             |
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
| `mutable-content` | Set to 1 to enable `UNNotificationServiceExtension`. |
| `f`               | The user ID of the sender.        |
| `t`               | The user ID of the receiver.                                 |
| `m`               | The ID of the message.                               |