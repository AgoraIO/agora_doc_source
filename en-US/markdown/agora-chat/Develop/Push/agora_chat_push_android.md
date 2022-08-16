# Offline Push

Agora Chat supports the integration of Google Firebase Cloud Messaging (FCM). This enables Android developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

## Understand the tech

![](https://web-cdn.agora.io/docs-files/1655713515869)

Assume that User A sends a message to User B, but User B goes offline before receiving it. The Agora Chat server pushes a notification to the device of User B via FCM and temporarily stores this message. Once User B comes back online, the Agora Chat SDK pulls the message from the server and pushes the message to User B using persistent connections.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](./agora_chat_get_started_android).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You have activated the advanced features for push in [Agora Console](https://console.agora.io/). Advanced features allow you to set the push notification mode, do-not-disturb mode, and custom push template.
<div class="alert note">You must contact <a href="mailto:support@agora.io">support@agora.io</a> to disable the advanced features for push as this operation will delete all the relevant configurations.</div>


## Integrate FCM with Agora Chat

This section guides you through how to integrate FCM with Agora Chat.

### 1. Create an Android project in Firebase

1. Log in to [Firebase console](https://console.firebase.google.com/), and click **Add project**.

2. In the **Create a project** page, enter a project name, and click **Create project**.

<div class="alert note">You can toggle off **Enable Google Analytics for this project** if this option is not needed.</div>

3. After the project is ready, click **Continue** to redirect to the project page, and click the **Android** icon to register an Android project.

4. In the **Add Firebase to your Android app** page, perform the following operations:
    1. In the **Register app** step, enter an Android package name, app nickname (optional), and debug signing certificate SHA-1 (optional), and click **Register app**.
    2. In the **Download google-services.json** step, download `google-services.json`, move this file into your Android app module root directory, and click **Next**.
    3. In the **Add Firebase SDK** step, modify your `build.gradle` files to use Firebase, and click **Next**.
    4. In the **Next steps** step, click **Continue to console** to go back to the project page.

5. In the project page, click the Android project you have created.

6. In the **Project settings** page, select the **Cloud Messaging** tab, and locate the **Server key** and **Sender ID**.<a name="token"></a>

![](https://web-cdn.agora.io/docs-files/1649906356504)

### 2. Upload FCM certificate to Agora Console

1. Log in to [Agora Console](https://console.agora.io/), and click **Project Management** in the left navigation bar.

2. On the **Project Management** page, locate the project that has Chat enabled and click **Config**.

3. On the project edit page, click **Config** next to **Chat**.

4. On the project config page, select **Features** > **Push Certificate** and click **Add Push Certificate**.

5. In the pop-up window, select the **GOOGLE** tab, and configure the following fields:
  - **Certificate Name**: Fill in the [Sender ID](#token).
  - **Push Key**: Fill in the [Server Key](#token).

<img src="https://web-cdn.agora.io/docs-files/1658462250450">

### 3. Enable FCM in Agora Chat

1. In the `build.gradle` file of your project, configure dependencies on the FCM library. <a name="integrate"> </a>

```java
dependencies {
    // ...
    // Imports the Firebase BoM.
    implementation platform('com.google.firebase:firebase-bom:28.4.1')
    // Declares the dependencies for the Firebase Cloud Messaging.
    // When using the BoM, do not specify versions in Firebase library dependencies.
    implementation 'com.google.firebase:firebase-messaging'
}
```
<div class="alert note"> For Gradle 5.0 and later, BoM is automatically enabled, whereas for earlier versions of Gradle, you need to enable the BoM feature. See <a href="https://firebase.google.cn/docs/android/learn-more#bom">Firebase Android BoM</a> and <a href="https://firebase.google.cn/support/release-notes/android">Firebase Android SDK Release Notes</a> for details.</div>

2. Sync the project with the gradle files, extend `FirebaseMessagingService`, and register `FirebaseMessagingService` in the `AndroidManifest.xml` file of your project.

```java
public class EMFCMMSGService extends FirebaseMessagingService {
    private static final String TAG = "EMFCMMSGService";

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        if (remoteMessage.getData().size() > 0) {
            String message = remoteMessage.getData().get("alert");
            Log.d(TAG, "onMessageReceived: " + message);
        }
    }

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);
        Log.d(TAG, "onNewToken: " + token);
        ChatClient.getInstance().sendFCMTokenToServer(token);
    }
}
```

```xml
<service
    android:name=".java.MyFirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

3. Initialize and enable FCM in the Agora Chat SDK.
```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
// Replaces with your FCM Sender ID.
builder.enableFCM("Your FCM sender id");
// Sets push configurations in the ChatOptions class.
options.setPushConfig(builder.build());
// Initializes the Agora Chat SDK.
ChatClient.getInstance().init(this, options);
// Sets the push listener.
PushHelper.getInstance().setPushListener(new PushListener() {
    @Override
    public void onError(PushType pushType, long errorCode) {
        EMLog.e("PushClient", "Push client occur a error: " + pushType + " - " + errorCode);
    }
    @Override
    public boolean isSupportPush(PushType pushType, PushConfig pushConfig) {
        // Sets whether FCM is enabled.
        if(pushType == PushType.FCM) {
            return GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(MainActivity.this)
                        == ConnectionResult.SUCCESS;
        }
        return super.isSupportPush(pushType, pushConfig);
    }
});
```

4. Pass the device token of FCM to the Agora Chat SDK.

```java
// Checks whether FCM is enabled.
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
        // Gets a new FCM registration token.
        String token = task.getResult();
        EMLog.d("FCM", token);
        ChatClient.getInstance().sendFCMTokenToServer(token);
    }
});
```

5. Listen for device token generation.

Rewrite the `onNewToken` callback of `FirebaseMessagingService`. Once a device token is generated, this callback passes the new device token to the Agora Chat SDK at the earliest opportunity.

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

To optimize user experience when dealing with an influx of push notifications, Agora Chat provides fine-grained options for the push notification and do-not-disturb (DND) modes at both the app and conversation levels, as shown in the following table:

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
            <nobr><code>ALL</code>: Receives push notifications for all offline messages.</nobr>
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
            <nobr><code>MENTION_ONLY</code>: Only receives push notifications for mentioned messages.</nobr>
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
            <nobr><code>NONE</code>: Do not receive push notifications for offline messages.</nobr>
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
            <nobr><code>SILENT_MODE_DURATION</code>: Do not receive push notifications for the specified duration.</nobr>
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
            <nobr><code>SILENT_MODE_INTERVAL</code>: Do not receive push notifications in the specified time frame.</nobr>
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

For example, assume that the push notification mode of the app is set to `MENTION_ONLY`, while that of the specified conversation is set to `ALL`. You receive all the push notifications from this conversation, while you only receive the push notifications for mentioned messages from all the other conversations.

**Do-not-disturb mode**

<div class="alert note"><ol><li>You can specify both the DND duration and DND time frame at the app level. During the specified DND time periods, you do not receive any push notifications.<li>Conversations only support the DND duration setting; the setting of the DND time frame does not take effect.</ol></div>

For both the app and all the conversations in the app, the setting of the DND mode takes precedence over the setting of the push notification mode.

For example, assume that a DND time period is specified at the app level and the push notification mode of the specified conversation is set to `ALL`. The DND mode takes effect regardless of the setting of the push notification mode, that is, you do not receive any push notifications during the specified DND time period.

Alternatively, assume that a DND time period is specified for a conversation, while the app does not have any DND settings and its push notification mode is set to `ALL`. You do not receive any push notifications from this conversation during the specified DND time period, while the push of all the other conversations remains the same.


### Set the push notifications of an app

You can call `setSilentModeForAll` to set the push notifications at the app level and set the push notification mode and DND mode by specifying the `SilentModeParam` field, as shown in the following code sample:

```java
// Sets the push notification mode to `MENTION_ONLY` for an app.
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.REMIND_TYPE)
                                .setRemindType(PushManager.PushRemindType.MENTION_ONLY);
// Sets the push notifications at the app level.
ChatClient.getInstance().pushManager().setSilentModeForAll(param, new ValueCallBack<SilentModeResult>(){});
// Sets the DND duration to 15 minutes.
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_DURATION)
                                .setSilentModeDuration(15);
// Sets the DND time frame from 8:30 to 15:00.
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_INTERVAL)
                                .setSilentModeInterval(new SilentModeTime(8, 30), new SilentModeTime(15, 0));
```


### Retrieve the push notification setting of an app

You can call `getSilentModeForAll` to retrieve the push notification settings at the app level, as shown in the following code sample:

```java
ChatClient.getInstance().pushManager().getSilentModeForAll(new ValueCallBack<SilentModeResult>(){
    @Override
    public void onSuccess(SilentModeResult result) {
        // Retrieves the setting of the push notification mode at the app level.
        PushManager.PushRemindType remindType = result.getRemindType();
        // Retrieves the Unix timestamp when the DND duration of an app expires.
        long timestamp = result.getExpireTimestamp();
        // Retrieves the start time specified in the DND time frame at the app level.
        SilentModeTime startTime = result.getSilentModeStartTime();
        startTime.getHour(); // The start hour of the DND time frame.
        startTime.getMinute(); // The start minute of the DND time frame.
        // Retrieves the end time specified in the DND time frame at the app level.
        SilentModeTime endTime = result.getSilentModeEndTime();
        endTime.getHour(); // The end hour of the DND time frame.
        endTime.getMinute(); // The end minute of the DND time frame.
    }
    @Override
    public void onError(int error, String errorMsg) {}
});
```


### Set the push notifications of a conversation

You can call `setSilentModeForConversation` to set the push notifications for the conversation specified by the `conversationId` and `ConversationType` fields, as shown in the following code sample:

```java
// Sets the push notification mode to `MENTION_ONLY` for a conversation.
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.REMIND_TYPE)
                                .setRemindType(PushManager.PushRemindType.MENTION_ONLY);
// Sets the DND duration to 15 minutes.
SilentModeParam param = new SilentModeParam(SilentModeParam.SilentModeParamType.SILENT_MODE_DURATION)
                                .setSilentDuration(15);
// Sets the push notifications at the conversation level.
ChatClient.getInstance().pushManager().setSilentModeForConversation(conversationId, conversationType, param, new ValueCallBack<SilentModeResult>(){});
```

### Retrieve the push notification setting of a conversation

You can call `getSilentModeForConversation` to retrieve the push notification settings of the specified conversation, as shown in the following code sample:

```java
ChatClient.getInstance().pushManager().getSilentModeForConversation(conversationId, conversationType, new ValueCallBack<SilentModeResult>(){
    @Override
    public void onSuccess(SilentModeResult result) {
        // Checks whether the push notification mode is set for the specified conversation.
        boolean enable = result.isConversationRemindTypeEnabled();
        // Retrieves the setting of the push notification mode for the specified conversation.
        if(enable){
            PushManager.PushRemindType remindType = result.getRemindType();
        }
        // Retrieves the Unix timestamp when the DND duration of a conversation expires.
        long timestamp = result.getExpireTimestamp();
    }
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### Retrieve the push notification settings of multiple conversations

<div class="alert info"><ol><li>You can retrieve the push notification settings of up to 20 conversations at each call.<li>If a conversation inherits the app setting or its push notification setting has expired, the returned dictionary does not include this conversation.</ol></div>

You can call `getSilentModeForConversations` to retrieve the push notification settings of multiple conversations, as shown in the following code sample:

```java
ChatClient.getInstance().pushManager().getSilentModeForConversations(conversationList, new ValueCallBack<Map<String, SilentModeResult>>(){
    @Override
    public void onSuccess(Map<String, SilentModeResult> value) {}
    @Override
    public void onError(int error, String errorMsg) {}
});
```

### Clear the push notification mode of a conversation

You can call `clearRemindTypeForConversation` to clear the push notification mode of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification mode of a conversation:

```java
ChatClient.getInstance().pushManager().clearRemindTypeForConversation(conversationId, conversationType, new CallBack(){});
```


## Set up display attributes

### Set the display attributes of push notifications

You can call `updatePushNickname` to set the nickname displayed in your push notifications, as shown in the following code sample:

```java
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```

You can also call `updatePushDisplayStyle` to set the display style of push notifications, as shown in the following code sample:<a name="style"></a>

```java
// `SimpleBanner` indicates that only "You have a new message" displays.
// To display the message content, set `DisplayStyle` to `MessageSummary`.
PushManager.DisplayStyle displayStyle = PushManager.DisplayStyle.SimpleBanner;
// An asynchronous processing is required for this method.
ChatClient.getInstance().pushManager().updatePushDisplayStyle(displayStyle);
```

### Retrieve the display attributes of push notifications

You can call `getPushConfigsFromServer` to retrieve the display attributes in push notifications, as shown in the following code sample:

```java
PushConfigs pushConfigs = ChatClient.getInstance().pushManager().getPushConfigsFromServer();
// Retrieves the nickname displayed in push notifications.
String nickname = pushConfigs.getDisplayNickname();
// Retrieves the display style of push notifications.
PushManager.DisplayStyle style = pushConfigs.getDisplayStyle();
```


## Set up push translations

If a user enables the [automatic translation](./agora_chat_translation_android#automatic-translation) feature and sends a message, the SDK sends both the original message and the translated message.

Push notifications work in tandem with the translation feature. As a receiver, you can set the preferred language of push notifications that you are willing to receive when you are offline. If the language of the translated message meets your setting, the translated message displays in push notifications; otherwise, the original message displays instead.

The following code sample shows how to set and retrieve the preferred language of push notifications:

```java
// Sets the preferred language of push notifications.
ChatClient.getInstance().pushManager().setPreferredNotificationLanguage("en", new CallBack(){});

// Retrieves the preferred language of push notifications.
ChatClient.getInstance().pushManager().getPreferredNotificationLanguage(new ValueCallBack<String>(){});
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

```java
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
message.setTo("6006");
// Sets the push template created in Agora Console as their default layout.
                    JSONObject pushObject = new JSONObject();
                    JSONArray titleArgs = new JSONArray();
                    JSONArray contentArgs = new JSONArray();
                    try {
                        // Sets the template name.
                        pushObject.put("name", "test7");
                        // Sets the template title by specifying the variable.
                        titleArgs.put("value1");
                        //...
                        pushObject.put("title_args", titleArgs);
                        // Sets the template content by specifying the variable.
                        contentArgs.put("value1");
                        //...
                        pushObject.put("content_args", contentArgs);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    // Adds the push template to the message.
                    message.setAttribute("em_push_template", pushObject);
// Sets the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Sends the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```


## What's next

This section includes more versatile push notification features that you can use to implement additional functions if needed.

If the ready-made templates do not meet your requirements, Agora Chat also enables you to customize your push notifications.

### Custom fields

The following code sample shows how to add an extension field in push notifications:

```java
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Specifies the username of the receiver.
message.setTo("toChatUsername");
// Sets the extension object.
JSONObject extObject = new JSONObject();
try {
    extObject.put("test1", "test 01");
} catch (JSONException e) {
    e.printStackTrace();
}
// Adds the extension object.
message.setAttribute("em_apns_ext", extObject);
// Sets the message body.
message.addBody(txtBody);
// Sets the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Sends the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```
| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `txtBody`        | The content of the text message.                                  |
| `toChatUsername` | The username of the receiver.  |
| `em_apns_ext`    | The custom key used to add the extension field. <br>**Note**: Do not modify the key. Modify the value of the key only. |


The following example shows a `RemoteMessage` object received by the remote user:

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
| `data`  | The custom data of the push notification.     |
| `alert`  | The displayed content of the push notification. This value varies based on the setting of [`DisplayStyle`](#style).   |
| `test1`  | The custom field of the push notification.        |


### Custom displays

The following code sample shows how to customize the display style in push notifications:

```java
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Specifies the username of the receiver.
message.setTo("toChatUsername");
// Sets the custom push notifications.
JSONObject extObject = new JSONObject();
try {
    extObject.put("em_push_title", "custom push title");
    extObject.put("em_push_content", "custom push content");
} catch (JSONException e) {
    e.printStackTrace();
}
// Adds the extension field.
message.setAttribute("em_apns_ext", extObject);
// Sets the message body.
message.addBody(txtBody);
// Sets the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Sends the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `toChatUsername` | The username of the sender. |
| `em_apns_ext`    | The custom key used to add the extension field. <br>**Note**: Do not modify the key. Modify the value of the key only. |
| `em_push_title`   | The custom key used to specify the custom titles of push notifications.<br>**Note**: Do not modify the key. Modify the value of the key only. |
| `em_push_content`| The custom key used to specify the custom displayed content of push notifications.<br>**Note**: Do not modify the key. Modify the value of the key only. |

The following example shows a `RemoteMessage` object received by the remote user:

```plaintext
{
  "message":{
    "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
    "data":{
      "alert" : "push content",
      "push_title" : "custom push title",
      "push_content" : "custom push content"
    }
  }
}
```

| Parameter    | Description           |
| ------- | -------------- |
| `data`  | The custom data of the push notification.     |
| `alert` | The displayed content of the push notification. This value varies based on the setting of [`DisplayStyle`](#style).    |
| `push_title` | The custom title of the push notification.     |
| `push_content` | The custom content of the push notification.     |


### Force push notifications

Once you force a push notification to a user, the user receives the message regardless of their settings on the push nosh notification and DND modes.

The following code sample shows how to force a push notification:

```java
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("test");
// Sets the username of the receiver.
message.setTo("toChatUsername");
// Sets the custom extension field.
message.setAttribute("em_force_notification", true);
// Sets the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Sends a message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter                    | Description                                     |
| ----------------------- | ---------------------------------------- |
| `txtBody`               | The message body.                                 |
| `toChatUsername`        | The username of the receiver.                    |
| `em_force_notification` | Whether to force a push notification.<li>`true`: Yes<li>`false`: No  |