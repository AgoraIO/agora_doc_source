# Set up Push Notifications

Agora Chat supports the integration of Google Firebase Cloud Messaging (FCM). This enables Android developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

## Understand the tech

![Set up Push Notifications (Android)](https://web-cdn.agora.io/docs-files/1649843666791)

Assume that User A sends a message to User B, and User B goes offline. Agora Chat server pushes a notification to the device of User B via FCM, and temporarily stores this message. Once User B comes back online, Agora Chat SDK pulls the message from the server, and pushes the message to User B using persistent connections.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- An [Agora Account](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-account).  
- An [Agora project](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-project) with Agora Chat enabled. To enable the Agora Chat service for private BETA, contact support@agora.io.

## Integrate FCM with Agora Chat

This section guides you through how to integrate FCM with Agora Chat.

### 1. Create an Android project in Firebase

1. Log in to [Firebase console](https://console.firebase.google.com/), and click **Add project**.

2. In the **Create a project** page, enter a project name, toggle off **Enable Google Analytics for this project**, and click **Create project**.

3. After the project is ready, click **Continue** to redirect to the project page, and click the **Android** icon to register an Android project.

4. In the **Add Firebase to your Android app** page, perform the following operations:
    1. In the **Register app** step, enter a Android package name, app nickname (optional), and debug signing certificate SHA-1 (optional), and click **Register app**.
    2. In the **Download google-services.json** step, download `google-services.json`, move this file into your Android app module root directory, and click **Next**.
    3. In the **Add Firebase SDK** step, modify your `build.gradle` files to use Firebase, and click **Next**.
    4. In the **Next steps** step, click **Continue to console** to go back to the project page.

5. In the project page, click the Android project you have created.

6. In the **Project settings** page, select the **Cloud Messaging** tab, and locate the **Server key** and **Sender ID**.<a name="token"></a>

![](https://web-cdn.agora.io/docs-files/1649906356504)

### 2. Upload FCM certificate to Agora Console

1. Log in to [Agora Console](https://console.agora.io/), and click **Project Management** in the left navigation bar.

2. In the **Project Management** page, select the project item used to enable Agora Chat, and click **Config** in the **Action** column.

3. Add `/chat` after the URL of the project config page, and press **Enter**.

4. In the **Push Notifications** module, click **Add Push Certificate**.

5. In the pop-up window, select the **GOOGLE** tab, and configure the following fields:
  - **Certificate Name**: Fill in the [Sender ID](#token).
  - **Push Secret**: Fill in the [Server Key](#token).

![](https://web-cdn.agora.io/docs-files/1649906171334)

### 3. Enable FCM in Agora Chat

1. In the `build.gradle` file of your project, configure dependencies on the FCM library. <a name="integrate"> </a>

```java
dependencies {
    // ...
    // FCM: Import the Firebase BoM.
    implementation platform('com.google.firebase:firebase-bom:28.4.1')
    // FCM: Declare the dependencies for the Firebase Cloud Messaging.
    // When using the BoM, do not specify versions in Firebase library dependencies.
    implementation 'com.google.firebase:firebase-messaging'
}
```
>**Note**: For Gradle 5.0 and later, BoM is automatically enabled, whereas for earlier versions of Gradle, you need to enable the BoM feature. See [Firebase Android BoM](https://firebase.google.cn/docs/android/learn-more#bom) and [Firebase Android SDK Release Notes](https://firebase.google.cn/support/release-notes/android) for details.

2. Sync project with gradle files, extend `FirebaseMessagingService`, and register `FirebaseMessagingService` in the `AndroidManifest.xml` file of your project.

```xml
<service
    android:name=".java.MyFirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```
3. Initialize and enable FCM in Agora Chat SDK.
```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
// Replace with your FCM Sender ID.
builder.enableFCM("Your FCM sender id");
// Set pushConfig to ChatOptions.
options.setPushConfig(builder.build());
// To initialize Agora Chat SDK
ChatClient.getInstance().init(this, options);
// After the SDK is initialized
PushHelper.getInstance().setPushListener(new PushListener() {
    @Override
    public void onError(PushType pushType, long errorCode) {
        EMLog.e("PushClient", "Push client occur a error: " + pushType + " - " + errorCode);
    }
    @Override
    public boolean isSupportPush(PushType pushType, PushConfig pushConfig) {
        // Set whether FCM is enabled.
        if(pushType == PushType.FCM) {
            return GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(MainActivity.this)
                        == ConnectionResult.SUCCESS;
        }
        return super.isSupportPush(pushType, pushConfig);
    }
});
```

4. Pass the device token of FCM to Agora Chat SDK.

```java
// Check whether FCM is enabled.
if(GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(MainActivity.this) == ConnectionResult.SUCCESS) {
    return;
}
FirebaseMessaging.getInstance().getToken().addOnCompleteListener(new OnCompleteListener<String>() {
    @Override
    public void onComplete(@NonNull Task<String> task) {
        if (!task.isSuccessful()) {
            EMLog.d("PushClient", "Fetching FCM registration token failed:"+task.getException());
            return;
        }
        // Get a new FCM registration token.
        String token = task.getResult();
        EMLog.d("FCM", token);
        ChatClient.getInstance().sendFCMTokenToServer(token);
    }
});
```

5. Listen for device token generation.

Rewrite the `onNewToken` callback of `FirebaseMessagingService`. Once a device token is generated, this callback passes the new device token to Agora Chat SDK at the earliest opportunity.

```java
@Override
public void onNewToken(@NonNull String token) {
    Log.i("MessagingService", "onNewToken: " + token);
    // If you want to send messages to this application instance or manage the subscriptions of this app on the server side, send the FCM registration token to your app server.
    if(ChatClient.getInstance().isSdkInited()) {
        ChatClient.getInstance().sendFCMTokenToServer(token);
    }
}
```

## Set up push notifications

After integrating FCM with Agora Chat, you can specify the display name, display style, and do-not-disturb mode of push notifications.

### Set the display name

The following sample code specifies whether to display the username of the sender in push notifications:

```java
// Asynchronous processing is required.
// Set updatePushNickname to the display name of the sender.
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```
| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `updatePushNickname`   | The display name of the sender. |

### Set the display style<a name="style"></a> 

The following sample code specifies whether to display the message details in push notifications:

```java
// Set DisplayStyle to SimpleBanner.
PushManager.DisplayStyle displayStyle = PushManager.DisplayStyle.SimpleBanner;
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushDisplayStyle(displayStyle);
```

| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `DisplayStyle`   | The display style of push notifications:<li>`SimpleBanner`: Displays "You have a new message".<li>`MessageSummary`: Displays the message details. |

### Set a chat group to do-not-disturb mode

After you set a group to do-not-disturb mode, you do not receive push notifications from this group when you go offline.

The following sample code sets the specified groups to do-not-disturb mode:

```java
List<String> groupIds = new ArrayList<>();
// Add the IDs of the groups that you want to set to do-not-disturb mode.
groupIds.add("groupId01");
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForGroup(groupIds, true);
```
| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `groupIds`   | The IDs of groups. |

### Retrieve the do-not-disturb group list

Before proceeding, you must call [`getPushConfigsFromServer`](#getPushOptions) first to retrieve data from the server.

The following sample code retrieves the list of do-not-disturb groups:

```java
List<String> noPushGroups = ChatClient.getInstance().pushManager().getNoPushGroups();
```
| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `noPushGroup`   | The IDs of the groups that are not allowed to push notifications. |

### Set a user to do-not-disturb mode

After you set a user to do-not-disturb mode, you do not receive push notifications from this user when you go offline.

The following sample code sets the specified users to do-not-disturb mode:

```plaintext
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForUsers(userIds, true);
```
| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `userIds`   | The usernames. |

### Retrieve the do-not-disturb user list

Before proceeding, you must call [`getPushConfigsFromServer`](#getPushOptions) first to retrieve data from the server.

The following sample code retrieves the list of do-not-disturb users:

```plaintext
List<String> noPushUsers = ChatClient.getInstance().pushManager().getNoPushUsers();
```

| Parameter              | Description                   |
| ---------------- | ---------------------- |
| `noPushUsers`   | The usernames that are not allowed to push notifications. |

### Set a do-not-disturb time period

After you set a do-not-disturb time period, you do not receive push notifications from both one-on-one chats and group chats within the specified time period.

The following sample code specifies the do-not-disturb time period when push notifications are disabled:

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().disableOfflinePush(start, end);
```

| Parameter   | Data Type | Description                    |
| ------- | -----| ----------------------- |
| `start` | int | The start time of the do-not-disturb time period. The value range is [0,24]. Unit: hours. |
| `end`   | int | 	The end time of the do-not-disturb time period. The value range is [0,24]. Unit: hours. |

Assume that you set `start` to `22`, and set `end` to `7`. You do not receive push notifications from 22pm to 7am.

### Enable push notifications

The following sample code enables push notifications:

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().enableOfflinePush();
```

### Retrieve the attributes of push notifications <a name="getPushOptions"></a>

The following sample code retrieves the attributes of push notifications from the server:

```java
// Asynchronous processing is required.
PushConfigs pushConfigs = ChatClient.getInstance().pushManager().getPushConfigsFromServer();
```
`PushConfigs`includes the following fields:

| Field               | Description                                                         |
| -------------------- | ------------------------------------------------------------ |
| `getDisplayNickname()`    | Whether to display the username of the sender in push notifications.                        |
| `getDisplayStyle()`       | Whether to display the message details in push notifications.                                               |
| `getSilentModeStart()` | The start time of the do-not-disturb time period.                                       |
| `getSilentModeEnd()` | The end time of the do-not-disturb time period.                                       |
| `silentModeEnabled()` | Whether to enable the do-not-disturb feature. If the do-not-disturb time period is specified, this field returns `YES`.|

### Parse push notifications

To receive push notifications when offline, you must rewrite the `onMessageReceived` callback and act according to the received `RemoteMessage` object.

The following sample code listens for the `onMessageReceived` callback:

```java
@Override
public void onMessageReceived(RemoteMessage remoteMessage) {
    if (remoteMessage.getData().size() > 0) {
      //Handle received push notifications.
    }
}
```

An example of a `RemoteMessage` object is as follows:

```plaintext
{
  "message":{
    "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
    "data":{
      "alert" : "You have a new message!"
    }
  }
}
```

| Parameter    | Description           |
| ------- | -------------- |
| `data`  | The custom data of push notifications.    |
| `alert` | The displayed content of push notifications. Varies based on the settings of [`DisplayStyle`](#style).  |

## What's next

This section includes more advanced push notification features. You can implement these features based on your needs, such as redirecting to an event page via push notifications.

### Custom fields

The following sample code specifies a custom field when pushing notifications:

```java
// Take a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Specify the username of the sender.
message.setTo("toChatUsername");
// Set custom push notifications.
JSONObject extObject = new JSONObject();
try {
    extObject.put("test1", "test 01");
} catch (JSONException e) {
    e.printStackTrace();
}
// Add extension settings.
message.setAttribute("em_apns_ext", extObject);
// Set the message body.
message.addBody(txtBody);
// Set the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```
| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `txtBody`        | The displayed content of push notifications.                                  |
| `toChatUsername` | The username of the sender.  |
| `em_apns_ext`    | The custom extensions. This field cannot be modified. |
| `test1`          | The custom key.                               |


An example of a received `RemoteMessage` object is as follows:

```plaintext
{
  "message":{
    "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
    "data":{
      "alert" : "message content",
      "test1" : "test 01"
    }
  }
}
```

| Parameter    | Description           |
| ------- | -------------- |
| `data`  | The custom data of push notifications.     |
| `alert`  | The displayed content of messages. Varies based on the settings of [`DisplayStyle`](#style).   |
| `test1`  | The custom field.        |

### Custom displays

The following sample code customizes the display style of push notifications:

```java
// Take a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Specify the username of the sender.
message.setTo("toChatUsername");
// Set custom push notifications.
JSONObject extObject = new JSONObject();
try {
    extObject.put("em_push_title", "custom push title");
    extObject.put("em_push_content", "custom push content");
    extObject.put("push_title", "custom push title");
    extObject.put("push_content", "custom push content");
} catch (JSONException e) {
    e.printStackTrace();
}
// Add extension settings.
message.setAttribute("em_apns_ext", extObject);
// Set the message body.
message.addBody(txtBody);
// Set the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `toChatUsername` | The username of the sender. |
| `em_apns_ext`    | The custom extensions. This field cannot be modified. |
| `em_push_title`   | The custom key used to specify custom titles of push notifications. This field cannot be modified. |
| `em_push_content`| The custom key used to specify custom displayed content of push notifications. This field cannot be modified. |
| `push_title`   | The custom key used to specify custom titles of push notifications. You can modify this field based on your needs. |
| `push_content`| The custom key used to specify custom displayed content of push notifications. You can modify this field based on your needs. |

An example of a received `RemoteMessage` object is as follows:

```plaintext
{
  "message":{
    "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
    "data":{
      "alert" : "push content",
      "push_title" : "costom push title",
      "push_content" : "costom push content"
    }
  }
}
```

| Parameter    | Description           |
| ------- | -------------- |
| `data`  | The custom data of push notifications.     |
| `alert` | The displayed content of push notifications. Varies based on the settings of [`DisplayStyle`](#style).    |
| `push_title` | The custom title of push notifications.     |
| `push_content` | The custom displayed content of push notifications.     |

### Force push notifications

Once you force a push notification to a user, the user receives the message regardless of the do-not-disturb settings.

The following sample code forces a push notification:

```java
// Take a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("test");
// Set the username of the sender.
message.setTo("toChatUsername");
// Set the custom extension field.
message.setAttribute("em_force_notification", true);
// Set the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send a message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter                    | Description                                     |
| ----------------------- | ---------------------------------------- |
| `txtBody`               | The message body.                                 |
| `toChatUsername`        | The username of the sender.                    |
| `em_force_notification` | Whether to force a push notification. You cannot modify this field.  |