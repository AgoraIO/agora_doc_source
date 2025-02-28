# Offline Push Notification Extension

Agora Chat supports integration of APNs push and FCM push. When using offline push, you can implement corresponding push functions with message extension fields, for example, setting the push title and content in the push template, or setting personalized push notifications for certain users in the group.

## Push extension fields

`payload.ext` contains the following fields:

| Field                  | Type         | Description  |
| ---------------------- | ------------ | ------------------ |
| `em_push_filter`     | Object       | The push filter.       | 
| `em_push_template `      | Object       | The push template. |
| `em_ignore_notification` | Boolean      | Whether to send a silent message: <br/> - `true`: No notification is pushed when a message is sent to an offline user. <br/> - `false`: A notification is pushed when a message is sent to an offline user.  |
| `em_force_notification`  | Boolean      | Whether to push notifications when sending messages, even if the recipient is in DND mode. <br/> - `true`: Yes. Notifications are pushed for recipients even if they are in DND mode. Yes.  <br/> - No. No notifications are pushed for recipients in DND mode. |
| `em_apns_ext`            | Object       | APNs push extension settings. |
| `em_android_push_ext`    | Object       | Android push extension settings. |
| `em_push_ext`            | Object       | Common push extension settings. |

`em_push_filter` contains the following fields:

| Field                  | Type         | Description  |
| ----------------     | ------------ | ------------------------ |
| `accept_device_id`     | List<String> | The list of device IDs that receive push notifications.  |
| `ignore_device_id`     | List<String> | The list of device IDs that do not receive push notifications. |
| `accept_notifier_name` | List<String> | The list of push certificates of users that receive push notifications.    |
| `ignore_notifier_name` | List<String> |  The list of push certificates of users that do not receive push notifications.    |

`em_push_template` contains the following fields:

| Field                  | Type         | Description  |
| ------------ | ------------ | ------------------------------------------------------------ |
| `name`         | String       | The push template name.      |
| `title_args`   | List<String> | The push template title. For example, you fill it with an embedded parameter `{$fromNickname}` (nickname of the sender).   |
| `content_args` | List<String> | The push template content. For example, you fill it with an embedded parameter `{$msg}` (message content). If the translation function is activated, both the original message content and the translation will be included in the push notification. |
| `directed_template` | Object        | The targeted push template. This type of template applies to offline push of group message in a scenario where you want to send a push notification to specific users and another to others in the group. For the fields, see the following table.   |

A targeted template contains the following fields:

| Field                  | Type         | Description  |
| -------------- | ------------- | ---------------- |
| `target`       | Array<String> | The list of user IDs. All user IDs that you have passed must only contain lowercase letters. otherwise, the user IDs are invalid.    |
| `name`         | String        | The push template name.    |
| `title_args`   | Array<String> | The push template title. |
| `content_args` | Array<String> | The push template content. |

For how to use a targeted push template, see [the usage example](#targeted-push-template).

`em_push_ext` contains the following fields:

| Field                  | Type         | Description  |
| --------------------- | ------ | ---------------------------------------------- |
| `title`               | String | The custom push title.                                 |
| `content`             | String | The custom push content.                               |
| `custom`              | Object | The user-defined extension field. This field matches the `e` field among fields (like `t`, `f`, `m`, and `g`) to be parsed when receiving a push notification. |
| `group_user_nickname` | String | The nickname of the group to which the sender belongs.    |
| `type` | String | The VoIP push notification. Note: This field applies only when APNs supports VoIP notifications.   |

`em_apns_ext` contains the following fields for APNs:

| Field                  | Type         | Description  |
| -------------- | ---------------- | ------ |
| `em_push_category`           | String           | The push notification category.  |
| `em_push_mutable_content`    | Boolean          | Whether the push notification is a rich text notification or a common notification: <br/> - `true`: rich text notification <br/> - `false`: common notification |
| `em_push_sound`              | String           | Custom ringtone, which is a `aiff`, `wav`, or `caf` file in `Library/Sounds/`, for example, `appsound.caf`. |
| `em_push_badge`              | Integer          | Custom badge.  |
| `em_push_content_available`              | Integer          | The value `0` indicates background notification. For details, see the [user notification doc on Applet website](https://developer.apple.com/documentation/usernotifications/pushing-background-updates-to-your-app?language=objc). |

`em_android_push_ext` contains the following fields:

| Field                  | Type         | Description  |
| ------------------------- | ------- | ------------- |
| `fcm_options`               | Object  | FCM SDK options.                                           |
| `fcm_channel_id`            | String  | FCM channel (with the highest priority).|

## Example

### Structure of push extension fields

```json
{
    "ext": {
        "em_push_filter": {
            "accept_device_id": [

            ],
            "ignore_device_id": [

            ],
            "accept_notifier_name": [

            ],
            "ignore_notifier_name": [

            ]
        },
        "em_at_list": [
            "abc"
        ],
        "em_push_template": {
            "name": "test6",
            "title_args": [
                "test1"
            ],
            "content_args": [
                "{$fromNickname}",
                "{$msg}"
            ]
        },
        "em_push_ext": {
            "custom": {
                "test": 1
            },
            "group_user_nickname": "happy"
        },
        "em_ignore_notification": false,
        "em_force_notification": true,
        "em_apns_ext": {
            "em_push_title": "You've got a new message",
            "em_push_content": "Please click to view",
            "em_push_category": "",
            "em_push_mutable_content": true,
            "em_push_sound": "appsound.mp3",
            "em_push_badge": 1,
            "em_push_content_available": 1
        },
        "em_android_push_ext": {
            "fcm_options": {
                "key": "value"
            },
            "fcm_channel_id": ""
        },
    }
}
```

### Targeted push template

The following presents how to use a targeted push template when you sending a group message.

1. Create a push template.

```json
{
    "name": "at_push_template",
    "title_pattern": "{0}",
    "content_pattern": "{0}:{1}"
}
```

2. Apply this targeted push template when sending a group message. For example, the user `hxtest` receives the push notification "Tom mentions you in the group", and other offline users in the group receive the notification "Tome sends a message". 

```json
{
    "em_push_template": {
        "name": "push_template",
        "title_args": [
            "group name"
        ],
        "content_args": [
            "Tom",
            "sends a message"
        ],
        "directed_template": {
            "target": [
                "hxtest"
            ],
            "name": "at_push_template",
            "title_args": [
                "group name"
            ],
            "content_args": [
                "Tom",
                "mentions you in the group"
            ]
        }
    }
}
```

In this case, the push notification for other users can also be configured via push extension fields, apart from the push template.

```json
{
    "em_push_template": {
        "directed_template": {
            "target": [
                "hxtest"
            ],
            "name": "at_push_template",
            "title_args": [
                "group name"
            ],
            "content_args": [
                "Tom",
                "mentions you in the group"
            ]
        }
    },
    "em_push_ext": {
        "title": "group name",
        "content": "sends a message",
        "type": "call"
    }
}
```


