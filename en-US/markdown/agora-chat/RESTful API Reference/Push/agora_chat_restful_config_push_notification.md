# Set push messages

本文主要介绍推送通知的结构和字段，建议按需配置。推送通知包含声网提供的基本推送配置以及各厂商的推送配置，默认情况下，后者优先级较高，会覆盖前者。

以下为推送通知的结构：

```
{  
  //基本推送配置。
  "title": "您有一条新消息",
  "subTitle": "",
  "content": "请及时查看",
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
  
  //各厂商推送配置
  "agora":{},
  "apns": {},
  "fcm": {}
}
```

## <a name="param"></a>基本推送配置 

| 字段   | 类型 | 描述  | 支持平台  | 是否必需 |
| :--------- | :-----| :--------- | :------- | :--------- |
| `title`    | String   | 通知栏展示的通知标题，默认为**您有一条新消息**。该字段长度不能超过 32 个字符（一个汉字相当于两个字符）。 | 全部 | 是   |
| `subTitle` | String   | 通知栏展示的通知副标题。该字段长度不能超过 10 个字符。  | 全部    | 否    |
| `content`  | String   | 通知栏展示的通知内容。默认为**请及时查看**。该字段长度不能超过 100 个字符（一个汉字相当于两个字符）。  | 全部 | 是  |
| `ext`      | JSON   | 推送自定义扩展信息，为自定义键值对。键值对不能超过 10 个且长度不能超过 1024 个字符。       | 全部  | 否 |
| `config`   | JSON   | 在通知栏中点击触发的动作以及角标的配置，包含 `clickAction` 和 `badge` 字段。 | 全部  | 否 |
| `config.clickAction` | JSON   | 在通知栏中点击触发的动作，均为 String 类型：<ul><li>`url`：打开自定义的 URL；</li><li>`action`：打开应用的指定页面；</li><li>`activity`：打开应用包名或 Activity 组件路径。</li></ul> | iOS & Android  | 否       |
| `config.badge`       | JSON   | 推送角标，包含以下两个字段，均为整型：<ul><li>`addNum`：表示推送通知到达设备时，角标数字累加；</li><li>`setNum`：表示推送通知到达设备时，角标数字重置。</li></ul> | iOS & Android  | No       |


## 各厂商推送配置 

| 字段   | 类型 | 描述  | 是否必需 |
| :--------- | :----------- | :------- | :----------------- |
| `agora`  | JSON   | 声网推送 | 否       |
| `apns`     | JSON   | Apple 推送通知服务（APNs） | 否        |
| `fcm`      | JSON   | 谷歌 Firebase 云消息传递  (FCM) | 否        |

### 声网推送

下面为包含大图片的通知的代码示例：

```
{
    "title": "通知栏显示的通知标题",
    "content": "通知栏展示的通知内容",
    "subTitle": "通知栏显示的通知副标题",
    "iconUrl": "https://docs-im.easemob.com/lib/tpl/bootstrap3_ori/images/logo.png",
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
    "bigPicture": "https://docs-im.easemob.com/lib/tpl/bootstrap3_ori/images/logo.png",
    "id": 056734579
}
```

推送字段说明如下表所示： 

| 字段               | 类型    | 描述                | 支持平台    |
| :----------------- | :------ | :------------------------ | :---------- |
| `title`            | String  | 通知栏展示的通知标题。                                             | iOS & Android |
| `content`          | String  | 通知栏展示的通知内容。                                             | iOS & Android |
| `subTitle`         | String  | 通知栏展示的通知副标题。                                             | iOS         |
| `iconUrl`          | String  | 推送图标的 URL。           | iOS & Android |
| `needNotification` | Boolean | 是否弹出通知：<ul><li>（默认）`true`：通知消息；</li><li>`false`：透传消息。</li></ul> | iOS & Android |
| `badge`            | JSON  | 推送角标。详见[基本推送配置](#param)中的角标说明。 | iOS & Android |
| `operation`        | JSON  | 在通知栏中点击触发的动作。 | iOS & Android |
| `operation.type`  | Number   | 在通知栏中点击触发的动作类型。<ul><li>（默认）`0`：启动应用。</li><li>`1`：打开自定义 URL。需设置 `openUrl` 字段为自定义的 URL，若不设置，点击无效果。 </li><li>`2`：打开应用的指定页面。需设置 `openAction` 字段为打开的应用页面的地址，并设置 `openActivity` 为应用包名或 Activity 组件路径。若不设置这两个字段，点击无效果。</li></ul>   | iOS & Android |
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

### [APNs 推送相关字段](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)

| 字段               | 类型    | 描述                                                     |
| :----------------- | :------ | :----------------------------------------------------------- |
| `invalidationTime` | Number | 推送过期时间间隔，单位为毫秒。                         |
| `priority`         | Number | 通知的优先级。<ul><li>`5`：发送通知时会考虑设备电量</li><li>`10`：立即发送通知</li></ul>                   |
| `pushType`         | String  | 推送展示类型。在 iOS 13 或 watchOS 6 以上设备支持，只能为 `background` 或 `alert`，默认为 `alert`。|
| `collapseId`       | String  | 用于将多个通知合并为用户的单个通知的标识符。                                               |
| `apnsId`           | String    | 通知的唯一标识。                                                   |
| `badge`            | Number | 应用的图标上方显示的角标数字。                                                       |
| `sound`            | String  | 铃声。默认值为 `default`，播放系统声音。                                       |
| `mutableContent`   | Boolean    | 是否向推送中增加 `mutable-content` 字段开启 APNs 通知扩展。<ul><li>`true`：是</li><li>`false`：否</li></ul>|
| `contentAvailable` | Boolean    | 是否配置后台更新通知。开启后系统会在后台唤醒您的应用程序，并将通知传递。<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `categoryName`     | String  | 通知的类型。       |
| `threadId`         | String  | 通知分组标识符，在应用中唯一。                           |
| `title`            | String  | 通知的标题。                                               |
| `subTitle`         | String  | 通知的副标题。                                             |
| `content`          | String  | 通知的正文内容。                                               |
| `titleLocKey`      | String  | 用于将标题字符串进行本地化的键。                                         |
| `titleLocArgs`     | List    | 字符串的数组，用于替换标题字符串中的变量。                                         |
| `subTitleLocKey`   | String  | 用于将副标题字符串进行本地化的键。                |
| `subTitleLocArgs`  | List    | 字符串的数组，用于替换副标题字符串中的变量。      |
| `bodyLocKey`       | String  | 用于将消息文本进行本地化的键。                                         |
| `bodyLocArgs`      | List    | 字符串的数组，用于替换消息文本中的变量。                                         |
| `ext`              | JSON  | 自定义推送扩展信息。                                             |
| `launchImage`      | String  | 要显示的启动图像文件的名称。 |

### [FCM 推送相关字段](https://firebase.google.com/docs/cloud-messaging/http-server-ref?hl=zh-cn) 

| 字段                    | 类型   | 描述                                                     |
| :---------------------- | :----- | :----------------------------------------------------------- |
| `condition`             | String | 用于确定消息目标的逻辑条件表达式。                               |
| `collapseKey`           | String | 指定一组可折叠的消息（例如，含有 collapse_key: "Updates Available"），以便当恢复传送时只发送最后一条消息。这是为了避免当设备恢复在线状态或变为活跃状态时重复发送过多相同的消息。  |
| `priority`              | String | 消息的优先级，即 `normal`（普通）和 `high`（高）。在 Apple 平台中，这些值对应于 APNs 优先级中的 5 和 10。                                      |
| `timeToLive`            | String | 设备离线后消息在 FCM 存储空间中保留的时长（以秒为单位）。支持的最长存留时间为 4 周，默认值为 4 周。    |
| `dryRun`                | Boolean   | 是否为测试消息。<ul><li>`true`：是。开发者可在不实际发送消息的情况下对请求进行测试。</li><li>`false`：否。</li></ul>  |
| `restrictedPackageName` | String | 应用的软件包名称，其注册令牌必须匹配才能接收消息。       |
| `data`                  | JSON | 自定义推送扩展信息。                                             |
| `notification`          | JSON | 通知负载的用户可见的预定义键值对。|

#### [FCM 推送通知的字段](https://firebase.google.com/docs/cloud-messaging/http-server-ref?hl=zh-cn)

| 字段               | 类型   | 描述                                                     |
| :----------------- | :----- | :----------------------------------------------------------- |
| `title`            | String | 通知栏中展示的通知的标题。                                           |
| `body`             | String | 通知栏中展示的通知的内容。                                             |
| `androidChannelId` | String | 通知的渠道 ID。<br/>应用必须使用此渠道 ID 创建一个渠道，才能收到包含此渠道 ID 的所有通知。<br/>如果你不在请求中发送该渠道 ID，或者应用尚未创建所提供的渠道 ID，则 FCM 将使用应用清单文件中指定的渠道 ID。 |
| `icon`             | String | 通知图标。 |
| `sound`            | String | 设备收到通知时要播放的声音。                                                 |
| `tag`              | String | 用于替换抽屉式通知栏中现有通知的标识符。                     |
| `color`            | String | 通知的图标颜色。                                             |
| `clickAction`      | String | 用户点击通知触发的操作。点击通知时，将会启动带有匹配 intent 过滤器的 Activity。 |
| `titleLocKey`      | String | 应用的字符串资源中标题字符串的键，用于将标题文字本地化为用户当前的本地化设置语言。 |
| `titleLocArgs`     | List   | 将用于替换 `title_loc_key`（用于将标题文字本地化为用户当前的本地化设置语言）中的格式说明符的变量字符串值。   |
| `bodyLocKey`       | String | 应用的字符串资源中正文字符串的键，用于将正文文字本地化为用户当前的本地化设置语言。                        |
| `bodyLocArgs`      | List   | 将用于替换 `body_loc_key`（用于将正文文字本地化为用户当前的本地化设置语言）中的格式说明符的变量字符串值。  |
