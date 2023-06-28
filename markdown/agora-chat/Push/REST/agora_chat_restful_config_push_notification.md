# 配置推送通知

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
  "fcm": {},
  "xiaomi": {},
  "vivo": {},
  "oppo": {},
  "meizu": {},
  "huawei": {},
}
```

<a name="param"></a> 

## 基本推送配置

| 字段   | 类型 | 描述  | 支持平台  | 是否必需 |
| :--------- | :-----| :--------- | :------- | :--------- |
| `title`    | String   | 通知栏展示的通知标题，默认为**您有一条新消息**。该字段长度不能超过 32 个字符（一个汉字相当于两个字符）。 | iOS & Android | 是   |
| `subTitle` | String   | 通知栏展示的通知副标题。该字段长度不能超过 10 个字符。  | iOS   | 否    |
| `content`  | String   | 通知栏展示的通知内容。默认为**请及时查看**。该字段长度不能超过 100 个字符（一个汉字相当于两个字符）。  | iOS & Android | 是  |
| `ext`      | JSON   | 推送自定义扩展信息，为自定义键值对。键值对不能超过 10 个且长度不能超过 1024 个字符。       | iOS & Android  | 否 |
| `config`   | JSON   | 在通知栏中点击触发的动作以及角标的配置，包含 `clickAction` 和 `badge` 字段。 | iOS & Android  | 否 |
| `config.clickAction` | JSON   | 在通知栏中点击触发的动作，均为 String 类型：<ul><li>`url`：打开自定义的 URL；</li><li>`action`：打开应用的指定页面；</li><li>`activity`：打开应用包名或 Activity 组件路径。</li></ul><br/> 若不传该字段，默认打开应用的首页。| Android  | 否       |
| `config.badge`       | JSON   | 推送角标，包含以下两个字段，均为整型：<ul><li>`addNum`：表示推送通知到达设备时，角标数字累加的值；</li><li>`setNum`：表示推送通知到达设备时，角标数字显示的值。</li><li>activity：字符串类型，入口类（华为角标需要配置）。</li></ul> | iOS & Android  | 否       |

## 各厂商推送配置 

| 字段   | 类型 | 描述  | 是否必需 |
| :--------- | :----------- | :------- | :----------------- |
| `agora`  | JSON   | 声网推送 | 否       |
| `apns`     | JSON   | Apple 推送通知服务（APNs） | 否        |
| `fcm`      | JSON   | 谷歌 Firebase 云消息传递  (FCM) | 否        |
| `xiaomi`      | JSON   | 小米推送 | 否        |
| `vivo`      | JSON   | vivo 推送 | 否        |
| `oppo`      | JSON   | OPPO 推送 | 否        |
| `meizu`      | JSON   | 魅族推送 | 否        |
| `huawei`      | JSON   | 华为推送 | 否        |

### 声网推送

下面为包含大图片的通知的代码示例：

```
{
    "title": "通知栏显示的通知标题",
    "content": "通知栏展示的通知内容",
    "subTitle": "通知栏显示的通知副标题",
    "iconUrl": "https://web-cdn.agora.io/doc-center/image/agora-logo.png",
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
    "bigPicture": "https://web-cdn.agora.io/doc-center/image/agora-image.png",
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

### APNs 推送

APNs 推送相关字段与 APNs 官网的字段的映射关系如下表所示：

| APNs 推送字段               | APNs 官网字段    | 
| :----------------- | :---------- | 
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

关于以上字段的描述，详见 APNs 官网的[生成远程通知](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)和[向 APNs 发送通知请求](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)页面。

### FCM 推送

FCM 相关字段与 FCM 官网的字段的映射关系如下表所示：

| FCM 推送字段   | FCM 官网字段                                                    |
| :-------------- | :------------------------ |
| `condition`                     | `condition`                              |
| `collapseKey`                   | `collapse_key`  |
| `priority`                      | `priority` |
| `timeToLive`                    | `time_to_live`  |
| `dryRun`                        | `dry_run`  |
| `restrictedPackageName`         | `restricted_package_name` |
| `data`                          | `data`                                            |
| `notification`                  | `notification` |
| `notification.title`            | `title`         |
| `notification.body`             | `body`           |
| `notification.androidChannelId` | `android_channel_id` |
| `notification.sound`            | `sound`          |
| `notification.tag`              | `tag`     |
| `notification.color`            | `color`     |
| `notification.clickAction`      | `click_action` |
| `notification.titleLocKey`      | `title_loc_key` |
| `notification.titleLocArgs`     | `title_loc_args`   |
| `notification.bodyLocKey`       | `body_loc_key`                     |
| `notification.bodyLocArgs`      | `body_loc_args` |

关于以上字段的描述，详见 [FCM 官网](https://firebase.google.com/docs/cloud-messaging/http-server-ref?hl=zh-cn)。

### 小米推送


小米推送相关字段与小米推送官网的字段的映射关系如下表所示：

| 小米推送字段                     | 小米推送官网字段                   |
| :----------------------- | :----------------------------------------------------------- |
| `title`                  |    `title`  |
| `description`            |    `description`  |
| `restrictedPackageNames` |    `restricted_package_name`   |
| `passThrough`            |    `pass_through`   |
| `payload`                |    `payload`   |
| `notifyType`             |    `notify_type`    |
| `timeToLive`             |    `time_to_live`    |
| `timeToSend`             |    `time_to_send`   |
| `notifyId`               |    `notify_id`     |
| `sound`                  |    `extra.sound_uri`      |
| `ticker`                 |    `extra.ticker`   |
| `notifyForeground`       |    `extra.notify_foreground`  |
| `notifyEffect`           |    `extra.notify_effect`  |
| `intentUri`              |    `extra.intent_uri` |
| `webUri`                 |    `extra.web_uri`|
| `flowControl`            |    `extra.flow_control`  |
| `jobkey`                 |    `extra.jobkey` |
| `callbackUrl`            |    `extra.calllback`  |
| `callbackParam`          |    `extra.callback.param` |
| `callbackType`           |    `extra.callback.type` |
| `locale`                 |    `extra.locale` |
| `localeNotIn`            |    `extra.locale_not_in`  |
| `model`                  |    `extra.model`  |
| `modelNotIn`             |    `extra.model_not_in`|
| `appVersion`             |    `extra.app_version` |
| `appVersionNotIn`        |    `extra.app_version_not_in`|
| `connpt`                 |    `extra.connpt` |
| `onlySendOnce`           |    `extra.only_send_once`  |
| `channelId`              |    `extra.channel_id`|

关于以上字段的描述，详见[小米推送官网](https://dev.mi.com/console/doc/detail?pId=1163#_0)。

### vivo 推送说明


vivo 推送相关字段与 vivo 推送官网的字段的映射关系如下表所示：

| vivo 推送字段              | vivo 推送官网字段        |
| :---------------- | :------------------------- |
| `title`           |    `title`    |
| `content`         |    `content`    |
| `notifyType`      |    `notifyTyp`    |
| `timeToLive`      |    `timeToLive`                               |
| `skipType`        |    `skipType`     |
| `skipContent`     |    `skipContent`    |
| `networkType`     |    `networkType`    |
| `classification`  |    `classification`    |
| `clientCustomMap` |    `clientCustomMap`    |
| `requestId`       |    `requestId`   |
| `pushMode`        |    `pushMode`    |
| `extra`           |    `extra`     |
| `category` | `category` | 

vivo 推送回调相关字段与 vivo 推送官网的字段的映射关系如下表所示：

| vivo 推送字段              | vivo 推送官网字段        |
| :---------------- | :------------------------- |
| `callback`        |    `extra.callback`    |
| `callbackParam`   |    `extra.callback.param`    |

关于以上字段的描述，详见 [vivo 推送官网](https://dev.vivo.com.cn/documentCenter/doc/362#w2-98542835)。

### OPPO 推送说明

OPPO 推送相关字段与 OPPO 推送官网的字段的映射关系如下表所示：

| OPPO 推送字段        | OPPO 推送官网字段       |
| :-------------------- | :----------------------------------------------------------- |
| `title`               |     `title`     |
| `subTitle`            |     `sub_title`                         |
| `content`             |     `content`      |
| `channelId`           |     `channel_id`         |
| `appMessageId`        |     `app_message_id`         |
| `style`               |     `style`       |
| `clickActionType`     |     `click_action_type`       |
| `clickActionActivity` |     `click_action_activity`       |
| `clickActionUrl`      |     `click_action_url`      |
| `actionParameters`    |     `action_parameters`      |
| `offLine`             |     `off_line`      |
| `offLineTtl`          |     `off_line_ttl`        |
| `timeZone`            |     `time_zone`     |
| `callBackUrl`         |     `call_back_url`     |
| `callBackParameter`   |     `call_back_parameter`      |
| `showTtl`             |     `show_ttl`      |
| `notifyId`            |     `notify_id`      |


关于以上字段的描述，详见 [OPPO 推送官网](https://open.oppomobile.com/new/developmentDoc/info?id=11236)。

### 魅族推送


魅族推送相关字段与魅族推送官网的字段的映射关系如下表所示：

| 字段                  | 描述                                                     |
| :-------------------- | :----------------------------------------------------------- |
| `title`               |   `title`  |
| `content`             |   `content`  |
| `noticeExpandType`    |   `noticeExpandType`    |
| `noticeExpandContent` |   `noticeExpandContent`       |
| `clickType`           |   `clickType`     |
| `url`                 |   `url`     |
| `parameters`          |   `parameters`    |
| `activity`            |   `activity`     |
| `customAttribute`     |   `customAttribute`     |
| `isOffLine`           |   `offLine`    |
| `validTime`           |   `validTime`     |
| `isSuspend`           |   `suspend`     |
| `isClearNoticeBar`    |   `clearNoticeBar`      |
| `isFixDisplay`        |   `fixDisplay`      |
| `fixStartDisplayDate` |   `fixStartDisplayTime`       |
| `fixEndDisplayDate`   |   `fixEndDisplayTime`       |
| `vibrate`             |   `vibrate`       |
| `lights`              |   `lights`      |
| `sound`               |   `sound`     |
| `notifyKey`           |   `notifyKey`    |
| `callback`            |   `callback`          |
| `callbackParam`       |   `callback.param`            |
| `callbackType`        |   `callback.type`            |

关于以上字段的描述，详见[魅族推送官网](https://open-res.flyme.cn/fileserver/upload/file/201803/be1f71eac562497f92b42c750196a062.pdf)。

### 华为推送说明

华为推送相关字段与华为推送官网的字段的映射关系如下表所示：

#### 请求 body

| 华为推送字段           | 华为推送官网字段                                               |
| :------------- | :----------------------------------------------------------- |
| `validateOnly` |   `validate_only`   |
| `message`      |   `message`   |
| `review`       |   `review`   |

#### 推送消息结构体

| 华为推送字段           | 华为推送官网字段                                               |
| :------------- | :----------------------------------------------------------- |
| `data`         |    `data`             |
| `notification` |    `notification`     |
| `android`      |    `android`        |

##### 通知栏消息内容

| 华为推送字段           | 华为推送官网字段                                               |
| :------ | :------------------------------------- |
| `title` |   `title`              |
| `body`  |   `body`              |
| `image` |   `image`  |

##### 安卓消息推送控制参数

| 华为推送字段           | 华为推送官网字段                                               |
| :------------------ | :----------------------------------------------------------- |
| `collapseKey`       |    `collapse_key`      |
| `urgency`           |    `urgency`                              |
| `category`          |    `category`        |
| `ttl`               |    `ttl`                   |
| `biTag`             |    `bi_tag`                 |
| `fastAppTargetType` |    `fast_app_target`     |
| `data`              |    `data`     |
| `notification`      |    `notification`       |

##### 安卓通知栏消息结构体

| 华为推送字段           | 华为推送官网字段                                               |
| :------------------ | :----------------------------------------------------------- |
| `title`             | `title`                                                     |
| `body`              | `body`                                                  |
| `icon`              | `icon`                                        |
| `color`             | `color`                                             |
| `sound`             | `sound`                                     |
| `defaultSound`      | `default_sound`                  |
| `tag`               | `tag`                      |
| `clickAction`       | `click_action`       |
| `bodyLocKey`        | `body_loc_key`           |
| `bodyLocArgs`       | `body_loc_args`                                                     |
| `titleLocKey`       | `title_loc_key`                                             |
| `titleLocArgs`      | `title_loc_args`                                                     |
| `multiLangKey`      | `multi_lang_key`          |
| `channelId`         | `channel_id`                              |
| `notifySummary`     | `notify_summary`                               |
| `image`             | `image`                                    |
| `style`             | `style`                            |
| `bigTitle`          | `big_title`                                |
| `bigBody`           | `big_body`                          |
| `autoClear`         | `auto_clear`          |
| `notifyId`          | `notify_id`               |
| `group`             | `group`                                |
| `badge`             | `badge`                            |
| `when`              | `when`                             |
| `importance`        | `importance`                       |
| `useDefaultVibrate` | `use_default_vibrate`               |
| `useDefaultLight`   | `use_default_light`              |
| `vibrateConfig`     | `vibrate_config`               |
| `visibility`        | `visibility`                        |
| `lightSettings`     | `light_settings`              |
| `foregroundShow`    | `foreground_show`           |
| `inboxContent`      | `inbox_content`               |
| `buttons`           | `buttons`                          |

##### 通知栏消息动作按钮

| 华为推送字段           | 华为推送官网字段                                               |
| :----------- | :----------------------------------------------------------- |
| `name`       |      `name`                 |
| `actionType` |      `action_type`               |
| `intentType` |      `intent_type`               |
| `intent`     |      `intent`               |
| `data`       |      `data`               |

##### 自定义消息点击行为

| 华为推送字段           | 华为推送官网字段                                               |
| :------- | :----------------------------------------------------------- |
| `type`   |      `type`      |
| `intent` |      `intent`      |
| `url`    |      `url`            |
| `action` |      `action`                |


##### 自定义角标

| 华为推送字段           | 华为推送官网字段                                               |
| :----------- | :----------------------------------------------------------- |
| `addNum`     |    `add_num`     |
| `badgeClass` |    `class`      |
| `setNum`     |    `set_num`              |


##### 自定义呼吸灯模式

| 华为推送字段           | 华为推送官网字段                                               |
| :----------------- | :----------------------------------------------------------- |
| `color`            |  `color`   |
| `lightOnDuration`  |  `light_on_duration`          |
| `lightOffDuration` |  `light_off_duration`          |

##### 呼吸灯颜色

| 华为推送字段           | 华为推送官网字段                                               |
| :------ | :------------------------------------------------------ |
| `alpha` |   `alpha`  |
| `red`   |   `red`    |
| `green` |   `green`  |
| `blue`  |   `blue`   |

关于以上字段的描述，详见[华为推送官网](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-References/https-send-api-0000001050986197#section13271045101216)。

### 荣耀推送

荣耀推送相关字段与荣耀推送官网的字段的映射关系如下表所示：

#### 推送消息结构体

| 荣耀推送字段           | 荣耀推送官网字段            |
| :------------- | :-------------------------- |
| `data` | `data`   |
| `androidConfig`     | `android` |

##### 安卓消息推送控制参数

| 荣耀推送字段 | 荣耀推送官网字段                  | 
| :-------------------- | :----- | 
| `ttl`                 | `ttl` | 
| `biTag`               | `biTag` | 
| `data`                | `data` | 
| `androidNotification` | `notification` | 

##### 安卓通知栏消息结构体

| 荣耀推送字段       | 荣耀推送官网字段    |
| :-------------------- | :------------- |
| `title`             | `title`     |
| `body`              | `body`    |
| `clickAction`       | `clickAction`    | 
| `image`             | `image`   |
| `style`             | `style`     |
| `bigTitle`          | `bigTitle`     |
| `bigBody`           | `bigBody`          |
| `importance`        | `importance`    | 
| `when`              | `when`   |
| `buttons`           | `buttons`    |
| `badgeNotification` | `badge`         |
| `notifyId`          | `notifyId`     | 

#####  通知栏消息点击行为

| 荣耀推送字段 | 荣耀推送官网字段  |
| :-------------------- | :----- |
| `type`   | `actionType`  | 
| `intent` | `intent`  | 
| `url`    | `url`    |
| `action` | `action`    |

##### 通知栏消息动作按钮

| 荣耀推送字段       | 荣耀推送官网字段             |
| :-------------------- | :----- |
| `name`       | `name`       |
| `actionType` | `actionType`    |
| `intentType` | `intentType`    |
| `intent`     | `intent`    |  
| `data`       | `data`  |

##### 角标控制

| 参数       | 荣耀推送官网字段      |
| :-------------------- | :----- |
| `addNum`     | `addNum`        | 
| `badgeClass` | `badgeClass`        |
| `setNum`     | `setNum`        |

关于以上字段的描述，详见 [荣耀推送官网](https://developer.hihonor.com/cn/kitdoc?category=基础服务&kitId=11002&navigation=ref&docId=downlink-message.md)。