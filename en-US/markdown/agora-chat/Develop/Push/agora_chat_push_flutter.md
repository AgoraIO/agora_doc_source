# Offline Push

Agora Chat supports the integration of Google Firebase Cloud Messaging (FCM). This enables Flutter developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

## Understand the tech

![](https://web-cdn.agora.io/docs-files/1655713515869)

Assume that User A sends a message to User B, but User B goes offline before receiving it. The Agora Chat server pushes a notification to the device of User B via FCM and temporarily stores this message. Once User B comes back online, the Agora Chat SDK pulls the message from the server and pushes the message to User B using persistent connections.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You have activated the advanced features for push in [Agora Console](https://console.agora.io/). Advanced features allow you to set the push notification mode, do-not-disturb mode, and custom push template.
<div class="alert note">You must contact <a href="mailto:support@agora.io">support@agora.io</a> to disable the advanced features for push as this operation will delete all the relevant configurations.</div>


## Integrate FCM with Agora Chat

This section guides you through how to integrate FCM with Agora Chat.

### 1. Create a Flutter project in Firebase

1. Log in to [Firebase console](https://console.firebase.google.com/), and click **Add project**.

2. In the **Create a project** page, enter a project name, and click **Create project**.

<div class="alert note">You can toggle off **Enable Google Analytics for this project** if this option is not needed.</div>

1. After the project is ready, click **Continue** to redirect to the project page, and click the **Flutter** icon and follow the **Firebase CLI** to setting your project.

2. In the **Project settings** page, perform the following operations:
    1. Find the **Android apps** in **Your apps**, Set your Android App according to **See SDK instructions**.
    2. Find the **Apple apps** in **Your apps**, Set your Apple App according to **See SDK instructions**.

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

1. Initialize and enable FCM in the Agora Chat SDK.

```dart
ChatOptions options = ChatOptions(
    // Replaces with your App Key.
    appKey: "<#Your AppKey#>",
    autoLogin: false,
);
// Replaces with your FCM Sender ID.
options.enableFCM("<#Your FCM sender id#>");
options.enableAPNs("<#Your FCM sender id#>");
await ChatClient.getInstance.init(options);

...

Firebase.initializeApp();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);


FirebaseMessaging.onMessageOpenedApp.listen((message) {
    debugPrint("message : $message");
});
```

2. Pass the device token of FCM to the Agora Chat SDK.

```dart
final fcmToken = await FirebaseMessaging.instance.getToken();
if (fcmToken != null) {
  try {
    if (Platform.isIOS) {
      await ChatClient.getInstance.pushManager.updateAPNsDeviceToken(
        fcmToken,
      );
    } else if (Platform.isAndroid) {
      await ChatClient.getInstance.pushManager.updateFCMPushToken(
        fcmToken,
      );
    }
  } on ChatError catch (e) {
    debugPrint("bind fcm token error: ${e.code}, desc: ${e.description}");
  }
}
```

3. Listen for device token generation.

Rewrite the `onTokenRefresh` callback. Once a device token is generated, this callback passes the new device token to the Agora Chat SDK at the earliest opportunity.

```dart
FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
  try {
    if (Platform.isIOS) {
      await ChatClient.getInstance.pushManager.updateAPNsDeviceToken(
        newToken,
      );
    } else if (Platform.isAndroid) {
      await ChatClient.getInstance.pushManager.updateFCMPushToken(
        newToken,
      );
    }
  } on ChatError catch (e) {
    debugPrint("bind fcm token error: ${e.code}, desc: ${e.description}");
  }
});
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

You can call `setSilentModeForAll` to set the push notifications at the app level and set the push notification mode and DND mode by specifying the `ChatSilentModeParam` field, as shown in the following code sample:

```dart
try {
  // Sets the push notification mode to `MENTION_ONLY` for an app.
  var param = ChatSilentModeParam.remindType(
    ChatPushRemindType.MENTION_ONLY,
  );
  await ChatClient.getInstance.pushManager.setSilentModeForAll(
    param: param,
  );

  // Sets the DND duration to 15 minutes.
  var param = ChatSilentModeParam.silentDuration(15);
  await ChatClient.getInstance.pushManager.setSilentModeForAll(
    param: param,
  );

  // Sets the DND time frame from 8:30 to 15:00.
  var param = ChatSilentModeParam.silentModeInterval(
    startTime: ChatSilentModeTime(hour: 8, minute: 30),
    endTime: ChatSilentModeTime(hour: 15, minute: 0),
  );
  await ChatClient.getInstance.pushManager.setSilentModeForAll(
    param: param,
  );

} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```


### Retrieve the push notification setting of an app

You can call `getSilentModeForAll` to retrieve the push notification settings at the app level, as shown in the following code sample:

```dart
try {
  ChatSilentModeResult result =
      await ChatClient.getInstance.pushManager.fetchSilentModeForAll();
  // Retrieves the setting of the push notification mode at the app level.
  ChatPushRemindType? remindType = result.remindType;
  // Retrieves the Unix timestamp when the DND duration of an app expires.
  int? timestamp = result.expireTimestamp;
  // Retrieves the start time specified in the DND time frame at the app level.
  ChatSilentModeTime? startTime = result.startTime;
  startTime?.hour; // The start hour of the DND time frame.
  startTime?.minute; // The start minute of the DND time frame.
  // Retrieves the end time specified in the DND time frame at the app level.
  ChatSilentModeTime? endTime = result.endTime;
  endTime?.hour; // The end hour of the DND time frame.
  endTime?.minute; // The end minute of the DND time frame.
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```


### Set the push notifications of a conversation

You can call `setConversationSilentMode` to set the push notifications for the conversation specified by the `conversationId` and `ConversationType` fields, as shown in the following code sample:

```dart
// Sets the push notification mode to `MENTION_ONLY` for a conversation.
var param = ChatSilentModeParam.remindType(
  ChatPushRemindType.MENTION_ONLY,
);
// Sets the DND duration to 15 minutes.
var param = ChatSilentModeParam.silentDuration(15);

try {
  // Sets the push notifications at the conversation level.
  await ChatClient.getInstance.pushManager.setConversationSilentMode(
    conversationId: conversationId,
    type: conversationType,
    param: param,
  );
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

### Retrieve the push notification setting of a conversation

You can call `fetchConversationSilentMode` to retrieve the push notification settings of the specified conversation, as shown in the following code sample:

```dart
try {
  ChatSilentModeResult result = await ChatClient.getInstance.pushManager
      .fetchConversationSilentMode(
    conversationId: conversationId,
    type: conversationType,
  );
  // Retrieves the setting of the push notification mode for the specified conversation.
  ChatPushRemindType? remindType = result.remindType;
  // Retrieves the Unix timestamp when the DND duration of a conversation expires.
  int? timestamp = result.expireTimestamp;
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

### Retrieve the push notification settings of multiple conversations

<div class="alert info"><ol><li>You can retrieve the push notification settings of up to 20 conversations at each call.<li>If a conversation inherits the app setting or its push notification setting has expired, the returned dictionary does not include this conversation.</ol></div>

You can call `fetchSilentModeForConversations` to retrieve the push notification settings of multiple conversations, as shown in the following code sample:

```dart
try {
  Map<String, ChatSilentModeResult> result = await ChatClient
      .getInstance.pushManager
      .fetchSilentModeForConversations(conversationList);
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

### Clear the push notification mode of a conversation

You can call `removeConversationSilentMode` to clear the push notification mode of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification mode of a conversation:

```dart
try {
  await ChatClient.getInstance.pushManager.removeConversationSilentMode(
    conversationId: conversationId,
    type: conversationType,
  );
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```


## Set up display attributes

### Set the display attributes of push notifications

You can call `updatePushNickname` to set the nickname displayed in your push notifications, as shown in the following code sample:

```dart
try {
  ChatClient.getInstance.pushManager.updatePushNickname("pushNickname");
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

You can also call `updatePushDisplayStyle` to set the display style of push notifications, as shown in the following code sample:<a name="style"></a>

```dart
try {
  ChatClient.getInstance.pushManager.updatePushDisplayStyle(
    // `Simple` indicates that only "You have a new message" displays.
    // To display the message content, set `Simple` to `Summary`.
    DisplayStyle.Simple,
  );
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

### Retrieve the display attributes of push notifications

You can call `fetchPushConfigsFromServer` to retrieve the display attributes in push notifications, as shown in the following code sample:

```dart
try {
  ChatPushConfigs configs = await ChatClient.getInstance.pushManager.fetchPushConfigsFromServer();
  // Retrieves the display style of push notifications.
  DisplayStyle displayStyle = configs.displayStyle;
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
```

## Set up push translations

If a user enables the [automatic translation](./agora_chat_translation_flutter#automatic-translation) feature and sends a message, the SDK sends both the original message and the translated message.

Push notifications work in tandem with the translation feature. As a receiver, you can set the preferred language of push notifications that you are willing to receive when you are offline. If the language of the translated message meets your setting, the translated message displays in push notifications; otherwise, the original message displays instead.

The following code sample shows how to set and retrieve the preferred language of push notifications:

```dart
// Sets the preferred language of push notifications.
try {
  ChatClient.getInstance.pushManager.setPreferredNotificationLanguage("en");
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}

// Retrieves the preferred language of push notifications.
try {
  String? languageCode = await ChatClient.getInstance.pushManager.fetchPreferredNotificationLanguage();
} on ChatError catch (e) {
  debugPrint("error: ${e.code}, ${e.description}");
}
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

```dart
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: "targetId",
  content: "message content",
);
// Sets the push template created in Agora Console as their default layout.
msg.attributes = {
  // Adds the push template to the message.
  "em_push_template": {
    // Sets the template name.
    "name": "test7",
    // Sets the template title by specifying the variable.
    "title_args": ["value1"],
    // Sets the template content by specifying the variable.
    "content_args": ["value1"],
  }
};
// Sets the message callback.
msg.setMessageStatusCallBack(MessageStatusCallBack());
// Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```


## What's next

This section includes more versatile push notification features that you can use to implement additional functions if needed.

If the ready-made templates do not meet your requirements, Agora Chat also enables you to customize your push notifications.

### Custom fields

The following code sample shows how to add an extension field in push notifications:

```dart
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: "targetId",
  content: "message content",
);
// Adds the extension object.
msg.attributes = {
  "em_apns_ext": {
    "test1": "test 01",
  }
};
// Sets the message callback.
msg.setMessageStatusCallBack(MessageStatusCallBack());
// Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `msg`        | The content of the text message.                                  |
| `targetId` | The username of the receiver.  |
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

```dart
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: "targetId",
  content: "message content",
);
// Adds the extension object.
msg.attributes = {
  "em_apns_ext": {
    "em_push_title": "custom push title",
    "em_push_content": "custom push content",
  }
};
// Sets the message callback.
msg.setMessageStatusCallBack(MessageStatusCallBack());
// Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

| Parameter             | Description                                                         |
| ---------------- | ------------------------------------------------------------ |
| `targetId` | The username of the sender. |
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

```dart
// This code sample takes a TXT message as an example. You can use the same approach to set IMAGE messages and FILE messages.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: "targetId",
  content: "message content",
);
// Adds the extension object.
msg.attributes = {
  "em_force_notification": true
};
// Sets the message callback.
msg.setMessageStatusCallBack(MessageStatusCallBack());
// Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

| Parameter                    | Description                                     |
| ----------------------- | ---------------------------------------- |
| `msg`               | The message body.                                 |
| `targetId`        | The username of the receiver.                    |
| `em_force_notification` | Whether to force a push notification.<li>`true`: Yes<li>`false`: No  |

