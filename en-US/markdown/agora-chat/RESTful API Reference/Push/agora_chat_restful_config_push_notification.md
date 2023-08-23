# Set push messages

This topic introduces the structure and fields of Chat push service.

Chat not only provides basic configurations that are adaptive to all, but also supports advanced configurations varied by service providers. You can choose the service provider and configure the notification fields based on your business requirements.

A push notification example is as follows:

```json
{  
  // Basic configurations available to all
  "title": "You have a message",
  "subTitle": "",
  "content": "Check the message",
  "ext": {},
  "config": {
    "clickAction": {
      "url":"", 
      "action":"", 
      "activity":""
    },
    "badge": {
      "addNum": 0, 
      "setNum": 0
      }
  },
  
  // Advanced configurations varied by service providers
  "agora":{},
  "apns": {},
  "fcm": {}
}
```

## <a name="param"></a>Basic configurations

The following table lists basic configuration fields available to all:

| Field   | Type | Description  | Supported platforms  | Required |
| :--------- | :-----| :--------- | :------- | :--------- |
| `title`    | String   | The title of the notification. The value of this field is "You have a message" by default. The length of this field cannot exceed 32 characters. | Android & iOS | Yes   |
| `subTitle` | String   | The subtitle of the notification that provides additional information. The length of this field cannot exceed 10 characters.  | iOS    | No    |
| `content`  | String   | The body text of the notification. The value of this field is "Check the message" by default. The length of this field cannot exceed 100 characters.  | Android & iOS  | Yes  |
| `ext`      | JSON   | The custom extension of the notification stored in key-value pairs. The number of key-value pairs can be a maximum of 10, and the total length of key-value pairs can be 1024 characters at most.      | Android & iOS   | No |
| `config`   | JSON   | The configuration of click action and badge value in the notifications center. | Android & iOS   | No |
| `config.clickAction` | JSON   | The action triggered by a user click on the notification, which contains the following fields:<ul><li>`url`: Direct to a URL. Specify a custom URL; otherwise, the user click on notifications cannot work as expected.</li><li>`action`: Open a specific page in the app. Specify the address of an in-app page.</li><li>Open a package or an Activity component. Specify a package name or component path.</li></ul>| Android  | No       |
| `config.badge`       | JSON    | The value of the badge displayed on the app’s icon, which contains the following fields (Int):<ul><li>`addNum`: The new notification adds on the badge number.</li><li>`setNum`: The new notification resets the badge number.</li></ul> | iOS & Android |


## Advanced configurations

If the basic configuration fields stated above cannot meet your business requirements, Chat allows you to implement advanced configurations provided by the following push services:

| Field      |  Type  | Description    | Required |
| :--------- | :----- | :------------- | :--------- |
| `agora`    | JSON   | The Agora push service. |  No     |
| `apns`     | JSON   | Apple Push Notification service (APNs). | No      |
| `fcm`      | JSON   | Firebase Cloud Messaging (FCM). | No     |

> Advanced configurations overwrite the basic ones by default.

### Agora push service

An Agora push notification example is as follows:

```json
{
    "title": "The title of the notification",
    "content": "The body text of the notification",
    "subTitle": "The subtitle of the notification",
    "iconUrl": "https://web-cdn.agora.io/docs-files/1676966850073",
    "needNotification": true,
    "badge": {
        "setNum": 0,
        "addNum": 1,
        "activity": "com.hyphenate.chat.section.me.activity.AboutHxActivity"
    },
    "operation": {
        "type": "2",
        "openUrl": "https://www.baidu.com/",
        "openAction": "com.hyphenate.chat.section.me.activity.OfflinePushSettingsActivity"
    },
    "channelId": "chat",
    "channelName": "message",
    "channelLevel": 3,
    "autoCancel": 1,
    "expiresTime": 3600000,
    "sound": 0,
    "vibrate": 0,
    "style": 2,
    "bigTxt": "Big text content",
    "bigPicture": "https://web-cdn.agora.io/docs-files/1676966850073",
    "id": 056734579
}
```

The following table lists advanced configuration fields provided by Agora:

| Field              | Type    | Description               | Supported platforms    |
| :----------------- | :------ | :------------------------ | :--------------------- |
| `title`            | String  | The title of the notification.        | iOS & Android |
| `content`          | String  | The body text of the notification.    | iOS & Android |
| `subTitle`         | String  | The subtitle of the notification that provides additional information.     | iOS           |
| `iconUrl`          | String  | The URL of the app icon.                  | iOS & Android |
| `needNotification` | Boolean | Wether a notification pops out:<ul><li>`true`: (Default) Yes.</li><li>`false`: No.</li></ul> | iOS & Android |
| `badge`            | JSON    | The value of the badge displayed on the app’s icon, which contains the following fields:<ul><li>`addNum`: The new notification adds on the badge number.</li><li>`setNum`: The new notification resets the badge number.</li></ul> | iOS & Android |
| `operation`        | JSON    | The action triggered by a user click on the notification. | iOS & Android |
| `operation.type`  | Number   | The type of the action.<ul><li>`0`: (Default) Launch the app.</li><li>`1`: Direct to a URL. Set `operation.openUrl` to a custom URL; otherwise, the user click on notifications cannot work as expected.</li><li>`2`: Open a specific page in the app. Set `operation.openAction` to the address of the in-app page, and set `operation.openActivity` to the package name or component path; otherwise, the user click on notifications cannot work as expected.</li></ul>   | iOS & Android |
| `channelId`        | String  | The channel ID of the notification. The default value is `chat`. If this parameter is not specified or does not exist, a channel ID is automatically created using `channelName` and `channelLevel`. | Android  |
| `channelName`      | String  | The name of the channel. The default value is `message`. This parameter is used to generate the channel ID.         | Android     |
| `channelLevel`     | Number | The level of the channel.<ul><li>`0`: Low.</li><li>`3`: (Default) Medium.</li><li>`4`: High.</li></ul>This parameter is used to generate the channel ID. |  Android     |
| `autoCancel`       | Number | Whether the notification center is automatically closed after the user click on notifications.<ul><li>`0`: No</li><li>`1`: (Default) Yes</li></ul> |  Android     |
| `expiresTime`      | Number | The Unix timestamp (ms) when the notification expires and disappears from the notification center.        | iOS & Android |
| `sound`            | Number | Whether a sound plays when the device receives notifications.<ul><li>`0`: (Default) No</li><li>`1`: Yes</li></ul>           | iOS & Android |
| `vibrate`          | Number | Whether a vibration occurs when the device receive notifications.<ul><li>`0`: (Default) No</li><li>`1`: Yes</li></ul>             | iOS & Android |
| `style`            | Number | The style of the notification.<ul><li>`0`: (Default) Normal style.</li><li> `1`: Big test style.</li><li>`2`: Big image style.</li></ul>| iOS & Android |
| `bigTxt`           | String  | The text content. This field is required when `style` is set to `1`.      | iOS & Android |
| `bigPicture`       | String  | The image URL. This field is required when `style` is set to `2`.      | Android     |
| `id`               | Number   | The ID of the notification. A random number assigned by the Chat service. Chat automatically assigns a random number for each notification by default. If you manually specify this parameter to a value same as a previous ID, the previous notification is overwritten by the new one.  | iOS & Android |

### APNs

The mapping of field names between Chat and APNs is as follows:

| Chat               | APNs            | 
| :----------------- | :-------------- | 
| `invalidationTime` | `apns-expiration`     | 
| `priority`         | `apns-priority`  | 
| `pushType`         | `apns-push-type`  | 
| `collapseId`       | `apns-collapse-id`  | 
| `apnsId`           | `apns-id`    | 
| `badge`            | `badge` | 
| `sound`            | `sound` | 
| `mutableContent`   | `mutable-content`    | 
| `contentAvailable` | `content-available`    | 
| `categoryName`     | `category`  | 
| `threadId`         | `thread-id`  | 
| `title`            | `title`  | 
| `subTitle`         | `subtitle`  | 
| `content`          | `body`       |
| `titleLocKey`      | `title-loc-key`  | 
| `titleLocArgs`     | `title-loc-args`    | 
| `subTitleLocKey`   | `subtitle-loc-key`  | 
| `subTitleLocArgs`  | `subtitle-loc-args`    | 
| `bodyLocKey`       | `localizedAlertKey`  | 
| `bodyLocArgs`      | `loc-key`    | 
| `ext`              | `loc-args`  | 
| `launchImage`      | `launch-image`  | 


For descriptions of these fields, see APNs official documentation below:

- [Generating a remote notification](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)
- [Sending Notification Requests to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)


### FCM

The mapping of field names between Chat and FCM is as follows:

| Chat                    | FCM                   |
| :---------------------- | :-------------------- |
| `condition`             | `condition`           |
| `collapseKey`           | `collapse_key`        |
| `priority`              | `priority`            |
| `timeToLive`            | `time_to_live`        |
| `dryRun`                | `dry_run`             |
| `restrictedPackageName` | `restricted_package_name` |
| `data`                  | `data`                    |
| `notification`          | `notification`            |
| `notification.title`            | `notification.title`              |
| `notification.body`             | `notification.body`               |
| `notification.androidChannelId` | `notification.android_channel_id` |
| `notification.sound`            | `notification.sound`              |
| `notification.tag`              | `notification.tag`                |
| `notification.color`            | `notification.color`              |
| `notification.clickAction`      | `notification.click_action`       |
| `notification.titleLocKey`      | `notification.title_loc_key`      |
| `notification.titleLocArgs`     | `notification.title_loc_args`     |
| `notification.bodyLocKey`       | `notification.body_loc_key`       |
| `notification.bodyLocArgs`      | `notification.body_loc_args`      |

For descriptions of these fields, see FCM official documentation: [Firebase Cloud Messaging HTTP protocol](https://firebase.google.com/docs/cloud-messaging/http-server-ref).