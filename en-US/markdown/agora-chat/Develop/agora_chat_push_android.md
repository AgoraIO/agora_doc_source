# Set up Push Notifications

Agora Chat supports the integration of third-party push notification services. This enables Android developers to use an offline push notification service. The service features low latency, high delivery, high concurrency, and no violation of the users' personal data.

When a user closes the app and goes offline, Agora Chat pushes notifications to the device of the user through third-party push notification services. Once online, the user will receive all the messages.


## Understand the tech

The following figure shows the basic workflow of Agora Chat:  
![](https://web-cdn.agora.io/docs-files/1648101989050)


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- A valid Agora Account.
- An Agora project with Agora Chat enabled.  
To enable the Agora Chat service for private BETA, contact support@agora.io.

## Add obfuscation rules
To prevent code obfuscation, add the following code to the obfuscation rules of your project:
```java
-dontwarn io.agora.push.***
-keep class io.agora.push.*** {*;}
```
If you need to add obfuscation rules of third-party push notification services, see their documentations for reference.


## Integrate third-party push notification services with Agora Chat

This section takes HUAWEI Push Service and Mi Push Service as examples to describe how to implement push notifications in client apps.

### Integrate HUAWEI Push Service with Agora Chat

Follow the steps to integrate HUAWEI Push Service with Agora Chat:

1. Log in to [HUAWEI Developer Console](https://developer.huawei.com/en/), create an Android app with the push service enabled, and generate the App ID and Secret Key. See [HUAWEI Official Documentation](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/service-introduction-0000001050040060).<a name="step1"></a>

2. Upload the HUAWEI Push Service certificate to Agora Console.
    1. Log in to [Agora Console](https://console.agora.io/) and click **Project Management** in the left navigation bar.

    2. In the **Project Management** page, locate the project item used to enable Agora Chat and click **Config** in the **Action** column.
    ![](https://web-cdn.agora.io/docs-files/1648126068444)

    3. Add `/chat` after the URL of the project config page and press **Enter**.

    4. In the **Push Notifications** module, click **Add Push Certificate**.
    ![](https://web-cdn.agora.io/docs-files/1648139580523)

    5. In the pop-up window, select the **HUAWEI** tab and configure the following fields:
        - **Certificate Name**: Fill in the App ID created in [step 1](#step1).
        - **Certificate Secret**: Fill in the Secret Key created in [step 1](#step1).
        - **App Package Name**: Fill in the package name specified when the Android app was created in [step 1](#step1).
        
        Click **Save** to add the push certificate.

3. Integrate the HMS Core SDK with Agora Chat. See [Integrating the HMS Core SDK](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/android-integrating-sdk-0000001050040084) for details.

4. Register the `HmsMessageService` service in the `Android Manifest.xml` file of your project. The sample code is as follows:
```xml
<!--HUAWEI HMS Config-->
<service android:name=".service.HMSPushService"
 android:exported="false">
 <intent-filter>
     <action android:name="com.huawei.push.action.MESSAGING_EVENT" />
 </intent-filter>
</service>
<!-- huawei push end -->
```

5. Obtain a Push Token and upload the token to Agora Chat. See [Obtaining and Deleting a Push Token](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/android-client-dev-0000001050042041) for details. The sample code is as follows:
```java
public class HMSPushService extends HmsMessageService {
@Override
public void onNewToken(String token) {
 if(token != null && !token.equals("")){
   // When the call fails, the token is null.
   EMLog.d("HWHMSPush", "service register huawei hms push token success token:" + token);
   ChatClient.getInstance().sendHMSPushTokenToServer(token);
 }else{
   EMLog.e("HWHMSPush", "service register huawei hms push token fail!");
 }
}
}
```

6. Enable HUAWEI Push Service and Initialize Agora Chat SDK. The sample code is as follows:
```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableHWPush();
// Set pushconfig to ChatOptions
options.setPushConfig(builder.build());
// To initialize Agora Chat SDK
ChatClient.getInstance().init(this, options);
```

### Integrate Mi Push Service with Agora Chat

Follow the steps to integrate Mi Push Service with Agora Chat:

1. Log in to [Mi Developer Center](https://dev.mi.com/console/), create an Android app with the push service enabled, and generate the App ID and Secret Key. See [Mi Official Documentation](https://dev.mi.com/console/doc/detail?pId=68).<a name="step1-1"></a>

2. Upload the HUAWEI Push Service certificate to Agora Console.
    1. Log in to [Agora Console](https://console.agora.io/) and click **Project Management** in the left navigation bar.

    2. In the **Project Management** page, locate the project item used to enable Agora Chat and click **Config** in the **Action** column.
    ![](https://web-cdn.agora.io/docs-files/1648126068444)

    3. Add `/chat` after the URL of the project config page and press **Enter**.

    4. In the **Push Notifications** module, click **Add Push Certificate**.
    ![](https://web-cdn.agora.io/docs-files/1648139580523)

    5. In the pop-up window, select the **XIAOMI** tab and configure the following fields:
        - **Certificate Name**: Fill in the App ID created in [step 1](#step1-1).
        - **Certificate Secret**: Fill in the Secret Key created in [step 1](#step1-1).
        - **App Package Name**: Fill in the package name specified when the Android app was created in [step 1](#step1-1).
        
        Click **Save** to add the push certificate.

3. Integrate the Mi Push SDK with Agora Chat. See [Integrating the Mi Push SDK](https://dev.mi.com/console/doc/detail?pId=41) for details.

4. Configure the `Android Manifest.xml` file of your project.  
    1. Grant the permissions. The sample code is as follows:
    ```xml
    <!--Note: If you use Mi Push SDK 4.8.0 or later, the following three permissions are no longer dependent.-->
    <!-- <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />-->
    <!-- <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />-->
    <!-- <uses-permission android:name="android.permission.READ_PHONE_STATE" />-->

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE"/>
    <permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE"
    android:protectionLevel="signature" /> <!--Specify the app package name for com.xiaomi.mipushdemo-->
    <uses-permission android:name="com.xiaomi.mipushdemo.permission.MIPUSH_RECEIVE" /><!--Specify the app package name for com.xiaomi.mipushdemo-->
    ```
    2. Secify the `service` and `receiver` attributes of the push. The sample code is as follows:
    ```xml
    <service
    android:name="com.xiaomi.push.service.XMPushService"
    android:enabled="true"
    android:process=":pushservice" />

    <!--Note: The following service is supported by Mi Push SDK 3.0.1 or later.-->
    <service
    android:name="com.xiaomi.push.service.XMJobService"
    android:enabled="true"
    android:exported="false"
    android:permission="android.permission.BIND_JOB_SERVICE"
    android:process=":pushservice" />

    <!--Note: Do not specify the app package name for com.xiaomi.xmsf.permission.MIPUSH_RECEIVE.-->
    <service
    android:name="com.xiaomi.mipush.sdk.PushMessageHandler"
    android:enabled="true"
    android:exported="true"
    android:permission="com.xiaomi.xmsf.permission.MIPUSH_RECEIVE" />

    <!--The following service is supported by Mi Push SDK 2.2.5 or later.-->
    <service
    android:name="com.xiaomi.mipush.sdk.MessageHandleService"
    android:enabled="true" />

    <receiver
    android:name="com.xiaomi.push.service.receivers.NetworkStatusReceiver"
    android:exported="true">
    <intent-filter>
        <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
    </receiver>

    <receiver
    android:name="com.xiaomi.push.service.receivers.PingReceiver"
    android:exported="false"
    android:process=":pushservice">
    <intent-filter>
        <action android:name="com.xiaomi.push.PING_TIMER" />
    </intent-filter>
    </receiver>
    ```
    3. Customize a `BroadcastReceiver` that inherits from the `EMMiMsgReceiver` class in the Agora Chat SDK and register it in the `AndroidManifest.xml` file. The sample code is as follows:
    ```xml
    <receiver android:name=".common.receiver.MiMsgReceiver">
    <intent-filter>
    <action android:name="com.xiaomi.mipush.RECEIVE_MESSAGE" />
    </intent-filter>
    <intent-filter>
    <action android:name="com.xiaomi.mipush.MESSAGE_ARRIVED" />
    </intent-filter>
    <intent-filter>
    <action android:name="com.xiaomi.mipush.ERROR" />
    </intent-filter>
    </receiver>
    ```

5. Enable Mi Push Service and Initialize Agora Chat SDK.
```java
ChatOptions options = new ChatOptions();
...
PushConfig.Builder builder = new PushConfig.Builder(this);
builder..enableMiPush(String appId, String appKey);
// Set pushconfig to ChatOptions
options.setPushConfig(builder.build());
// To initialize Agora Chat SDK
ChatClient.getInstance().init(this, options);
```

## Configure notification attributes

Configure the notification attributes, including the display name, the display style, and the do-not-disturb feature.

### Set the display name

The following sample code specifies whether to display the username of the sender in push notifications:
```
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushNickname("pushNickname");
```

### Set the display style

The following sample code specifies whether to display the message details in push notifications:

```java
// Displays "You have a new message".
PushManager.DisplayStyle displayStyle = PushManager.DisplayStyle.SimpleBanner;
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushDisplayStyle(displayStyle);
```

| Parameter          | Description                                                                            |
| :------------- | :------------------------------------------------------------------------------ |
| `displayStyle` | The display style of push notifications:<li>`SimpleBanner`: Displays "You have a new message".<li>`MessageSummary`: Displays the message details. |

### Set a chat group to do-not-disturb mode

After you set a group to do-not-disturb mode, you will not receive push notifications from this group when you go offline.  
The following sample code sets the specified groups to do-not-disturb mode:

```java
List<String> groupIds = new ArrayList<>();
// Specify the IDs of the groups that you want to set to do-not-disturb mode.
groupIds.add("groupId01");
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForGroup(groupIds, true);
```

| Parameter       | Description           |
| :--------- | :------------- |
| `groupIds` | The IDs of groups. |

### Retrieve the do-not-disturb group list

```java
List<String> noPushGroups = ChatClient.getInstance().pushManager().getNoPushGroups();
```

| Parameter       | Description                   |
| :--------- | :--------------------- |
| `groupIds` | The list of group IDs. |

### Set a user to do-not-disturb mode

After you set a user to do-not-disturb mode, you will not receive push notifications from this user when you go offline.  
The following sample code sets the specified users to do-not-disturb mode:

```json
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().updatePushServiceForUsers(userIds, true);
```

| Parameter    | Description         |
| :------ | :----------- |
| userIds | The IDs of users. |

### Retrieve the do-not-disturb user list

The following sample code retrieves the list of do-not-disturb users:

```json
List<String> noPushUsers = ChatClient.getInstance().pushManager().getNoPushUsers();
```

| Parameter        | Description                 |
| :---------- | :------------------- |
| noPushUsers | The list of usernames. |

### Set the do-not-disturb time period

The following sample code specifies the do-not-disturb time period when push notifications are disabled:

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().disableOfflinePush(start, end);
```

| Parameter    | Type |Description                                          |
| :------ | :--------|:----------------------------------- |
| `start` | Int type. |The start time of the do-not-disturb time period. The value range is [0,24].。 |
| `end`   | Int type.| The end time of the do-not-disturb time period. The value range is [0,24]。 |

### Enable push notifications

The following sample code enables push notifications:

```java
// Asynchronous processing is required.
ChatClient.getInstance().pushManager().enableOfflinePush();
```

### Retrieve the attributes of push notifications

The following sample code retrieves the attributes of push notifications:

```java
// Asynchronous processing is required.
PushConfigs pushConfigs = ChatClient.getInstance().pushManager().getPushConfigsFromServer();
```

`PushConfigs` includes the following fields:

| Method                                                                       | Description
| :------------------- | :------------------------------------------------------------------------- |
| getDisplayNickname() | Whether to display the username of the sender in push notifications.      |
| getDisplayStyle()    | Whether to display the message details in push notifications.                                          |
| getSilentModeStart() | The start time of the do-not-disturb time period.                             |
| getSilentModeEnd()   | The end time of the do-not-disturb time period.                             |
| silentModeEnabled()  | Whether to enable the do-not-disturb feature. Returns `YES` as long as the do-not-disturb time period is specified. |

## Parse push notifications

When a user receives and clicks a push notification through HUAWEI Push Service, the app parses this push notification as follows:
```java
public class SplashActivity extends BaseActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {		
		Bundle extras = getIntent().getExtras();
		if (extras != null) {
			String t = extras.getString("t");
			String f = extras.getString("f");
			String m = extras.getString("m");
			String g = extras.getString("g");
			Object e = extras.get("e");
			//handle
		}
	}
}
```
When a user receives and clicks a push notification through Mi Push Service, the app parses this push notification as follows:
```java
public class MiMsgReceiver extends EMMiMsgReceiver {
    @Override
    public void onNotificationMessageClicked(Context context, MiPushMessage miPushMessage) {
        String extStr = miPushMessage.getContent();
      	JSONObject extras = new JSONObject(extStr);
        if (extras !=null ){
          String t = extras.getString("t");
          String f = extras.getString("f");
          String m = extras.getString("m");
          String g = extras.getString("g");
          Object e = extras.get("e");
          //handle
        }
    }
}
```

| Parameter    | Description           |
| ------- | -------------- |
| `t`  | The username of the sender.    |
| `f` | The username of the receiver.   |
| `m`  |The ID of the message. The unique identifier of the message    |
| `g`  | The ID of the group. <br>If the push notification comes from a one-on-one chat instead of a group chat, this field doesn't exist.   |
| `e`  | The custom extension field.     |

## What's next

This section includes more advanced features of push notification. You can implement these features according to your needs.

### Custom fields

The following sample code redirects to an event page through the push notification:
```java
// This sample code takes a TXT message as an example. The message types such as IMAGE and FILE are set in the same way.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Set this value to the Agora ID of the sender.
message.setTo("toChatUsername");
// Specify the custom push alert.
JSONObject extObject = new JSONObject();
try {
    extObject.put("test1", "test 01");
} catch (JSONException e) {
    e.printStackTrace();
}
// Specify the message extension.
message.setAttribute("em_apns_ext", extObject);
// Specify the message body.
message.addBody(txtBody);
// Specify the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter             | Description               |
| :--------------- | :----------------- |
| `txtBody`        | The displayed content of the message.     |
| `toChatUsername` | The username of the receiver. |
| `em_apns_ext`    | The message extension field.    |

A `RemoteMessage` example is as follows:

```json
{
    "message": {
        "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
        "data": {
            "alert": "message content",
            "test1": "test 01"
        }
    }
}
```

| Parameter    | Description                                                                                   |
| ------- | -------------------------------------------------------------------------------------- |
| `data`  | The custom data in push notifications.                                                               |
| `alert` | The displayed content of the message. This value varies according to `DisplayStyle`. |
| `test1` | The custom field.                                                                           |

### Custom displays

The following sample code customizes the displayed content of the message:

```java
// This sample code takes a TXT message as an example. The message types such as IMAGE and FILE are set in the same way.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("message content");
// Set this value to the Agora ID of the sender.
message.setTo("toChatUsername");
// Specify the custom push alert.
JSONObject extObject = new JSONObject();
try {
    extObject.put("em_push_title", "costom push title");
    extObject.put("em_push_content", "costom push content");
    extObject.put("push_title", "costom push title");
    extObject.put("push_content", "costom push content");
} catch (JSONException e) {
    e.printStackTrace();
}
// Specify the message extension.
message.setAttribute("em_apns_ext", extObject);
// Specify the message body.
message.addBody(txtBody);
// Specify the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter              | Description               |
| :---------------- | :----------------- |
| `toChatUsername`  | The username of the receiver. |
| `em_apns_ext`     | The extension field.     |
| `em_push_title`   | The title of the push notification.    |
| `em_push_content` | The displayed content of the message.     |

A `RemoteMessage` example is as follows:

```json
{
    "message": {
        "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
        "data": {
            "alert": "push content",
            "push_title": "costom push title",
            "push_content": "costom push content"
        }
    }
}
```

| Parameter           | Description                                                             |
| -------------- | ----------------------------------------------------------------- |
| `data`         | The custom data in push notifications.                                           |
| `alert`        | The displayed content of the message. This value varies according to `DisplayStyle`. |
| `push_title`   | The custom title of push notifications.                            |
| `push_content` | The custom content in push notifications.                                               |

### Force push notifications

Once you force a push notification to a user, the user receives the message regardless of the do-not-disturb settings. The following sample code forces a push notification:

```java
// This sample code takes a TXT message as an example. The message types such as IMAGE and FILE are set in the same way.
ChatMessage message = ChatMessage.createSendMessage(ChatMessage.Type.TXT);
TextMessageBody txtBody = new TextMessageBody("test");
// Set this value to the Agora ID of the sender.
message.setTo("toChatUsername");
// Specify the custom extension field.
message.setAttribute("em_force_notification", true);
// Specify the message callback.
message.setMessageStatusCallback(new CallBack() {...});
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

| Parameter                    | Description                                                        |
| :---------------------- | :---------------------------------------------------------- |
| `txtBody`               | The displayed content of the message.                      |
| `toChatUsername`        | The username of the receiver.                             |
| `em_force_notification` | Whether to force a push notification.<li>`true`: Force the push notification.送<li>`false`: Do not force the push notification. |