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
| `content`  | String   | The body text of the notification. The value of this field is "Check the message" by default.通知栏展示的通知内容。The length of this field cannot exceed 100 characters.  | Android & iOS  | Yes  |
| `ext`      | JSON   | 推送自定义扩展信息，为自定义键值对。键值对不能超过 10 个且长度不能超过 1024 个字符。       | Android & iOS   | No |
| `config`   | JSON   | 在通知栏中点击触发的动作以及角标的配置，包含 `clickAction` 和 `badge` 字段。 | Android & iOS   | No |
| `config.clickAction` | JSON   | 在通知栏中点击触发的动作，均为 String 类型：<ul><li>`url`：打开自定义的 URL；</li><li>`action`：打开应用的指定页面；</li><li>`activity`：打开应用包名或 Activity 组件路径。</li></ul> | Android  | No       |
| `config.badge`       | JSON   | 推送角标，包含以下两个字段，均为整型：<ul><li>`addNum`：表示推送通知到达设备时，角标数字累加；</li><li>`setNum`：表示推送通知到达设备时，角标数字重置。</li></ul> //TODO: 然后呢？并没说怎么配置啊 0和1分别代表什么 | Android & iOS   | No       |


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
        "activity": "com.hyphenate.easeim.section.me.activity.AboutHxActivity"
    },
    "operation": {
        "type": "2",
        "openUrl": "https://www.baidu.com/",
        "openAction": "com.hyphenate.easeim.section.me.activity.OfflinePushSettingsActivity"
    },
    "channelId": "chat",
    "channelName": "message",
    "channelLevel": 3,
    "autoCancel": 1,
    "expiresTime": 3600000,
    "sound": 0,
    "vibrate": 0,
    "style": 2,
    "bigTxt": "大文本内容",
    "bigPicture": "https://web-cdn.agora.io/docs-files/1676966850073",
    "id": 056734579
}
```

推送字段说明如下表所示： 

| Field              | Type    | Description               | Supported platforms    |
| :----------------- | :------ | :------------------------ | :--------------------- |
| `title`            | String  | The title of the notification.        | iOS & Android |
| `content`          | String  | The body text of the notification.    | iOS & Android |
| `subTitle`         | String  | The subtitle of the notification that provides additional information.     | iOS           |
| `iconUrl`          | String  | The URL of the app icon.                  | iOS & Android |
| `needNotification` | Boolean | Wether a notification pops out:<ul><li>`true`: (Default) Yes.</li><li>`false`: No.</li></ul> | iOS & Android |
| `badge`            | JSON    | The value of the badge displayed on the app’s icon, which contains the following fields:<ul><li>`addNum`: The new notification adds on the badge number.</li><li>`setNum`: The new notification resets the badge number.</li></ul> | iOS & Android |
| `operation`        | JSON    | The action triggered by a user click on the notification. | iOS & Android |
| `operation.type`  | Number   | 在通知栏中点击触发的动作类型。<ul><li>`0`: (Default) Launch the app.</li><li>`1`: Direct to a URL. Set `operation.openUrl` to a custom URL; otherwise, the user click on notifications cannot work as expected.</li><li>`2`: Open a specific page in the app. Set `operation.openAction` to the address of the in-app page, and set `operation.openActivity` to the package name or component path; otherwise, the user click on notifications cannot work as expected.//TODO: 你自己看看示例呢openActivity在哪</li></ul>   | iOS & Android |
| `channelId`        | String  | 通知渠道 ID，默认为 `chat`。客户端渠道存在则通知。若客户端渠道不存在，则结合 `channelName` 和 `channelLevel` 创建新通道。 | Android  |
| `channelName`      | String  | 通知渠道名称，默认为 `消息`。只有第一次创建通道时使用。         | Android     |
| `channelLevel`     | Number | 通知级别，只有第一次创建通道时使用。<ul><li>`0`：最低；</li><li>`3`：默认；</li><li>`4`：高。</li></ul> | Android     |
| `autoCancel`       | Number | 点击通知后是否自动关闭通知栏。<ul><li>`0`：否</li><li>（默认）`1`：是</li></ul> | Android     |
| `expiresTime`      | Number    | 通知展示的过期时间，为 Unix 时间戳，单位为毫秒。                   | iOS & Android |
| `sound`            | Number | 声音提醒。<ul><li>（默认）`0`：无声音</li><li>`1`：声音提醒</li></ul>           | iOS & Android |
| `vibrate`          | Number | 振动提醒。<ul><li>（默认）`0`：无振动</li><li>`1`：振动提醒</li></ul>             | iOS & Android |
| `style`            | Number | 通知的展示样式。<ul><li>（默认）`0`：普通样式</li><li> `1`：大文本样式</li><li>`2`：大图片样式</li></ul>| iOS & Android |
| `bigTxt`           | String  | 大文本内容。该字段仅在 `style` 为 `1` 时需要设置。         | iOS & Android |
| `bigPicture`       | String  | 大图片 URL。该字段仅在 `style` 为 `2` 时需要设置。             | Android     |
| `id`               | Number    | 通知 ID。默认值为随机数。当 ID 相同时，新通知的内容会覆盖之前的通知。 | iOS & Android |

### APNs

APNs 推送相关字段与 APNs 官网的字段的映射关系如下表所示：

| APNs 推送字段               | APNs 官网字段    | 
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

关于这些字段的描述，详见 APNs 官网的[生成远程通知](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)和[向 APNs 发送通知请求](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)。

### FCM

FCM 相关字段与 FCM 官网的字段的映射关系如下表所示：

| FCM 推送字段   | FCM 官网字段                                                    |
| :-------------- | :------------------------ |
| `condition`             | `condition`                              |
| `collapseKey`           | `collapse_key`  |
| `priority`              | `priority` |
| `timeToLive`            | `time_to_live`  |
| `dryRun`                | `dry_run`  |
| `restrictedPackageName` | `restricted_package_name` |
| `data`                  | `data`                                            |
| `notification`          | `notification` |
| `notification.title`            | `notification.title`         |
| `notification.body`             | `notification.body`           |
| `notification.androidChannelId` | `notification.android_channel_id` |
| `notification.sound`            | `notification.sound`          |
| `notification.tag`              | `notification.tag`     |
| `notification.color`            | `notification.color`     |
| `notification.clickAction`      | `notification.click_action` |
| `notification.titleLocKey`      | `notification.title_loc_key` |
| `notification.titleLocArgs`     | `notification.title_loc_args`   |
| `notification.bodyLocKey`       | `notification.body_loc_key`                     |
| `notification.bodyLocArgs`      | `notification.body_loc_args` |

关于这些字段的描述，详见 [FCM 官网](https://firebase.google.com/docs/cloud-messaging/http-server-ref)。