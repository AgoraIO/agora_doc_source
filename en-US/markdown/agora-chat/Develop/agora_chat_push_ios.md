# Set up Push Notifications

Agora Chat supports the integration of Apple Push Notification service (APNs). This enables iOS developers with an offline push notification service. This service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

When a user closes the app and goes offline, Agora Chat pushes notifications to the device of the user through APNs. Once online, the user will receive all the messages.

## Understand the tech

The following figure shows the basic workflow of Agora Chat:

![](https://web-cdn.agora.io/docs-files/1647946470817)

## Prerequisites

Before proceeding, ensure your project has the following:
- A valid [Agora Account](#https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- An [Agora project](#https://docs.agora.io/en/Agora%5DPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-project) with Agora Chat enabled.  To enable the Agora Chat service for private BETA, contact support@agora.io.
- Xcoode 12.3 or later.
- A device runnning iOS 10 or later.

## Enable the APNs service<a name="step1"></a>

Follow the steps to enable the APNs service

1. Request a Certificate Signing Request (CSR) file.<a name="step1-1"></a>   
i. Open the **Keychain Access** app on your device and click **Keychain Access** > **Certificate Assistant** > **Request a Certificate from a Certificate Authority** in the top navigation bar.  
ii. In the **Certificate Assistant** dialog box, fill in the **User Email Address** and **Common Name**, select **Saved to disk**, and click **Contitue** to specify a path to save the file.  
![](https://web-cdn.agora.io/docs-files/1647878103996)  
iii. You can get a CSR file named `CertificateSigningRequest.certSigningRequest` in the specified path.

2. Request an App ID.<a name="step1-2"></a>  
Log in to the [iOS Developer Center](https://developer.apple.com/), click **Account** > **Certificates, Identifiers & Profiles** > **Identifiers** to add an App ID, and configure the following fields:
    - **Select a type**: Select **App**.
    - **Description**: Fill in the description of the App ID.
    - **Bundle ID**: Set the value to `com.YourCompany.YourProjectName`.
    - **Capabilities**: Select **Push Notification**.  

3. Create a push certificate for the development environment and the production environment respectively.<a name="step1-3"></a>  
    - **Development environment**  
    i. Click **app** > **Push Notifications** > **Development SSL Certificate** > **Create Certificate**.  
    ii. Select **iOS** for **Platform**, select the CSR file created in [step 1](#step1-1) for **Choose File**, and click **Continue**. This generates an [Apple Development IOS Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) file.  
    - **Production environment**  
    i. Click **app** > **Push Notifications** > **Production SSL Certificate** > **Create Certificate**.  
    ii. Select **iOS** for **Platform**, select the CSR file created in [step 1](#step1-1) for **Choose File**, and click **Continue**. This generates an [Apple Development IOS Push Services](https://help.apple.com/xcode/mac/current/?spm=a2c4g.11186623.0.0.14864088B1zf4p#/dev80c6204ec) file.

4. Get the push certificate.<a name="step1-4"></a>  
Double-click to import the push certificate created in [step 3](#step1-3). Go to **Keychain Access** > **login** > **My Certificates**, locate the imported certificate, right-click the certificate to export as a .p12 file, and set the certificate key.

5. Generate a Provisioning Profile file.  
Log in to [iOS Developer Center](https://developer.apple.com/), click **Account** > **Certificates, Identifiers & Profiles** > **Profiles** to add a Provisioning Profile file, and click **Continue** to configure the following fields:
    - **Development**: Select **iOS App Development**.
    - **Distribution**: Select **Ad Hoc**. For an official release on the App Store, select **App Store**.
    - **App ID**: Fill in the App ID created in [step 2](#step1-2).
    - **Select Certificates**: Select the push certificate created in [step 3](#step1-3).
    - **Select Devices**: Select the device used to develop.
    - **Provisioning Profile Name**: Fill in the name of the Provisioning Profile file.  

    Click **Generate** to generate the Provisioning Profile file.

## Upload the push certificate to Agora Console

 Follow the steps to upload the certificates to Agora Console:

1. Log in to [Agora Console](https://sso2.agora.io/) and click **Project Management** in the left navigation bar.

2. On the **Project Management** page, select the item used to enable Agora Chat and click **Config** in the **Action** column.
![](https://web-cdn.agora.io/docs-files/1647923143179)

3. Add `/chat` after the URL of the project config page and press **Enter**.

4. In the **Push Notifications** module, click **Add Push Certificate**.
![](https://web-cdn.agora.io/docs-files/1647923153068)

5. In the pop-up window, select the **APPLE** tab and configure the following fields:
   - **Bind ID**: Fill in the [bundle ID](#step1-2) specified when the App ID was created.
   - **Certificate Type**: Select the [file type](#step1-4) specified when the certificate was exported. You can select p8 or p12.
   - **Certificate Name**: Fill in the [name](#step1-3) specified when the certificate was created.
   - **Certificate Secret**: Fill in the [secret](#step1-4) specified when the certificate was exported.
   - **Upload**: Upload the [certificate](#step1-3) created.
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
| `DisplayStyle` | The display style of the push notification:<br>* `AgoraPushDisplayStyleSimpleBanner`: Displays "You have a new message".</br>* `AgoraPushDisplayStyleMessageSummary`：Displays the content of the message. |

**Set a chat group to do-not-disturb mode**

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

**Retrieve the do-not-disturb group list**

The following sample code retrieves the list of mute groups:

```swift
NSArray<NSString*>* groupIds = [AgoraChatClient.sharedClient.pushManager noPushGroups];
```

| Parameter     | Description                   |
| :------- | :--------------------- |
| `groupIds` | The list of group IDs. |

**Set a user to do-not-disturb mode**

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

**Retrieve the do-not-disturb user list**

The following sample code retrieves the list of mute users:

```swift
NSArray<NSString*>* userIds = [EMClient.sharedClient.pushManager noPushUIds];
```

| Parameter    | Description                 |
| :------ | :------------------- |
| `userIds` | The list of usernames. |

**Set the time period for the global do-not-disturb mode**

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
| `start` | Int | The start time of the global do-not-disturb mode. The value range is [0,24]. |
| `end`   | Int | The end time of the global do-not-disturb mode. The value range is [0,24]. |

**Enable push notifications**

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
| `noDisturbingStartH` | The start time of the global do-not-disturb mode.   |
| `noDisturbingEndH`   | The end time of the global do-not-disturb mode.   |
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
| `f`     | The username of the sender.                  |
| `t`     | The username of the receiver.                  |
| `g`     | The ID of the group.<br>If the push notification comes from a one-on-one chat instead of a group chat, this field doesn't exist. |
| `m`     | The ID of the message. The unique identifier of the message.        |

## What's next

This section includes more advanced features of push notification. You can implement these features according to your needs.

### Custom fields

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
| `from`           | The username of the sender.    |
| `to`             | The username of the receiver.   |
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
| `from`                  | The username of the sender.                 |
| `to`                    | The username of the receiver.                       |
| `em_force_notification` | Whether to force a push notification.<br>- YES: Force the push notification.<br>- NO: Do not force the push notification. |

### Extensions

If the notification receiver uses devices running iOS 10.0 or later, you can refer to the following code sample to enable the
[`UNNotificationServiceExtension`](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension?language=objc) extension. 

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
