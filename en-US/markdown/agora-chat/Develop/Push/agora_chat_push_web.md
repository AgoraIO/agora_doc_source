# Offline Push

Agora Chat provides an offline push notification service that features low latency, high delivery, high concurrency, and no violation of the users' personal data.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Set the push notifications of an app
- Retrieve the push notification setting of an app
- Set the push notifications of a conversation
- Retrieve the push notification settings of one conversation or multiple conversations
- Clear the push notification mode of a conversation
- Set and retrieve the preferred language of push notifications


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).

## Implementation

To optimize user experience when dealing with an influx of push notifications, Agora Chat provides fine-grained options for the push notification and do-not-disturb (DND) modes at both the app and conversation levels.

**Push notification mode**

<table width="781" height="300" border="1">
  <tbody>
    <tr>
      <td width="192"><strong>Push Notification Mode</strong></td>
      <td width="379"><strong>Description </strong></td>
      <td width="188"><strong>Application Scope</strong></td>
    </tr>
    <tr>
      <td>ALL</td>
      <td>Receives push notifications for all offline messages.</td>
      <td rowspan="3">Application and one-to-one and group chat conversations</td>
    </tr>
    <tr>
      <td>AT</td>
      <td>Only receives push notifications for mentioned messages. This mode is recommended for group chats. To mention one or more members in a group, you need to pass `em_at_list":["user1", "user2" ...]` for the `ext` field; to mention all members in a group, pass "em_at_list":"all" for the `ext` field.</td>
    </tr>
    <tr>
      <td>NONE</td>
      <td>Do not receive push notifications for offline messages.</td>
    </tr>
  </tbody>
</table>

The setting of the push notification mode at the conversation level takes precedence over that at the app level, and those conversations that do not have specific settings for the push notification mode inherit the app setting by default.

For example, assume that the push notification mode of the app is set to `AT`, while that of the specified conversation is set to `ALL`. You receive all the push notifications from this conversation, while you only receive the push notifications for mentioned messages from all the other conversations.

**Do-not-disturb mode**

You can specify both the DND duration and DND interval at the app level. During the specified DND time periods, you do not receive any push notifications.

<table width="726" border="1">
  <tbody>
    <tr>
      <td width="196" height="32"><strong>Do-not-disturb Parameter</strong></td>
      <td width="83"><strong>Type</strong></td>
      <td width="272"><strong> Description</strong></td>
      <td width="147"><strong> Application Scope</strong></td>
    </tr>
    <tr>
      <td height="65">startTime - endTime</td>
      <td>Number</td>
      <td><p>The interval during which the DND mode is scheduled everyday. The time is represented in the 24-hour notation in the form of H:M, for example, 8:30-10:00, where H ranges from `0` to `23` in hour and M from `0` to `59` in minute. </p><li>The DND mode is enabled everyday in the specified interval. For example, if you set the start time to 8:0 and end time to 10:0, the app stays in DND mode during 8:00-10:00; if you set the same period at 9:00, the DND mode works during 9:00-10:00 on the current day and 8:00-10:00 in subsequent days.</li>
        <li>If the start time is set to the same time spot as the end time, the app enters the permanent DND mode. However, the value 0:0-0:0 means to disable the DND mode.</li>
        <li>If the start time is later than the end time, the app remains in DND mode from the start time on the current day until the end time next day. For example, if you set the interval as 10:0-8:0, the DND mode lasts from 10:00 until 08:00 the next day. </li>
        <li> Currently, only one DND interval is allowed, with the new setting overwriting the old.</li>
        <li>If this parameter is not specified, pass in an empty string.</li>
        <li>If both `startTime` and `endTime` and `duration` are set, the DND mode works in both periods. For example, at 8:00, you set  `startTime` and `endTime` to 8:0-10:0 and `duration` to 240 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li></td>
      <td>App</td>
    </tr>
    <tr>
      <td height="108">duration</td>
      <td>Number</td>
      <td><p>The DND duration in minutes. The value range is [0,10080], where `0` indicates that this parameter is invalid and `10080` indicates that the DND mode lasts for 7 days. </p>
        <li>Unlike `startTime` and `endTime` set as a daily period, this parameter specifies that the DND mode works only for the given duration starting from the current time. For example, if this parameter is set to 240 (4 hours) for the app at 8:00, the DND mode lasts only during 8:00-12:00 on the current day.</li>
      <li> If both  `startTime` and `endTime` and `duration` are set, the DND mode works in both periods. For example, at 8:00, you set `startTime` and `endTime` to 8:0-10:0 and `duration` to 240 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li>        </p></td>
      <td>App and one-to-one and group chat conversations in it </td>
    </tr>
  </tbody>
</table>

For both the app and all the conversations in the app, the setting of the DND mode takes precedence over the setting of the push notification mode.

For example, assume that a DND time period is specified at the app level and the push notification mode of the specified conversation is set to `ALL`. The DND mode takes effect regardless of the setting of the push notification mode, that is, you do not receive any push notifications during the specified DND time period.

Alternatively, assume that a DND time period is specified for a conversation, while the app does not have any DND settings and its push notification mode is set to `ALL`. You do not receive any push notifications from this conversation during the specified DND time period, while the push of all the other conversations remains the same.

### Set the push notifications of an app

You can call `setSilentModeForAll` to set the push notifications at the app level and set the push notification mode and DND mode by specifying the `paramType` field, as shown in the following code sample:

```` javascript

  options // The push notification options.
	options: {
    paramType: 0, // The push notification mode.
    remindType: 'ALL' // Sets to `ALL`, `AT`, or `NONE`.
  }
  options: {
    paramType: 1, // The DND duration.
    duration: 7200000 // Sets the DND duration to `7200000` in milliseconds.
  }
  options: {
    paramType: 2, // The DND interval.
    startTime: {
    	hours: 8, // Sets the start hour to `8`.
    	minutes: 0 // Sets the start minute to `0`.
    }，
    endTime: {
    	hours: 12, // Sets the end hour to `12`.
    	minutes: 0 // Sets the end minute to `0`.
    }
  }

const params = {
  options: {
    paramType: 0,
    remindType: 'ALL'
  }
}
WebIM.conn.setSilentModeForAll(params)
````

### Retrieve the push notification setting of an app

You can call `getSilentModeForAll` to retrieve the push notification settings at the app level, as shown in the following code sample:

```` javascript
WebIM.conn.getSilentModeForAll()
````

### Set the push notifications of a conversation

You can call `setSilentModeForConversation` to set the push notifications for the conversation specified by the `conversationId` and `type` fields, as shown in the following code sample:

``` javascript

	const params = {
    conversationId: 'test', // The conversation ID. For one-to-one chats, sets to the ID of the peer user. For group chats, sets to the ID of the chat group or chat room.
    type: 'singleChat', // The chat type. Sets the chat type to `singleChat`, `groupChat`, or `chatRoom`.
    options: {
      paramType: 0, // The push notification mode.
      remindType: 'ALL' // Sets to `ALL`, `AT`, or `NONE`.
    }
  }
	
	const params = {
    conversationId: '12345567',
    type: 'groupChat',
    options: {
      paramType: 1, // The DND duration.
      duration: 7200000 // Sets the DND duration to `7200000` in milliseconds.
    }
  }
  
  const params = {
    conversationId: '121231233',
    type: 'chatRoom',
    options: {
      paramType: 2, // The DND interval.
      startTime: {
        hours: 8, // Sets the start hour to `8`.
        minutes: 0 // Sets the start minute to `0`.
      }，
      endTime: {
        hours: 12, // Sets the start hour to `12`.
        minutes: 0 // Sets the start hour to `0`.
      }
    }
  }

const params = {
  conversationId: '12345',
  type: 'groupChat',
  options: {
    paramType: 0,
    remindType: 'ALL'
  }
}
WebIM.conn.setSilentModeForConversation(params)
```

### Retrieve the push notification setting of a conversation

You can call `getSilentModeForConversation` to retrieve the push notification settings of the specified conversation, as shown in the following code sample:

```` javascript
const params = {
  conversationId: 'test', // The conversation ID. For one-to-one chats, sets to the ID of the peer user. For group chats, sets to the ID of the chat group or chat room.
  type: 'singleChat', // The chat type. Sets the chat type to `singleChat`, `groupChat`, or `chatRoom`.
}
WebIM.conn.getSilentModeForConversation(params)
````

### Retrieve the push notification settings of multiple conversations

<div class="alert info"><ol><li>You can retrieve the push notification settings of up to 20 conversations at each call.<li>If a conversation inherits the app setting or its push notification setting has expired, the returned dictionary does not include this conversation.</ol></div>

You can call `getSilentModeForConversations` to retrieve the push notification settings of multiple conversations, as shown in the following code sample:

```` javascript
const params = {
  conversationList: [
    {
      id: 'test', // The conversation ID. For one-to-one chats, sets to the ID of the peer user. For group chats, sets to the ID of the chat group or chat room.
      type: 'singleChat' // The chat type. Sets the chat type to `singleChat`, `groupChat`, or `chatRoom`.
    },
    {
      id: '1234',
      type: 'groupChat'
    }
  ]
}
WebIM.conn.getSilentModeForConversations(params)
````


### Clear the push notification mode of a conversation

You can call `clearRemindTypeForConversation` to clear the push notification mode of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification mode of a conversation:

```` javascript
const params = {
  conversationId: '12345', // The conversation ID. For one-to-one chats, sets to the ID of the peer user. For group chats, sets to the ID of the chat group or chat room.
  type: 'groupChat', // The chat type. Sets the chat type to `singleChat`, `groupChat`, or `chatRoom`.
}
WebIM.conn.clearRemindTypeForConversation(params)
````

### Set up push translations

If a user enables the [automatic translation](./agora_chat_translation_web) feature and sends a message, the SDK sends both the original message and the translated message.

Push notifications work in tandem with the translation feature. As a receiver, you can set the preferred language of push notifications that you are willing to receive when you are offline. If the language of the translated message meets your setting, the translated message displays in push notifications; otherwise, the original message displays instead.

The following code sample shows how to set and retrieve the preferred language of push notifications:

```` javascript
// Sets the preferred language of push notifications.
const params = {
  language: 'EU'
}
WebIM.conn.setPushPerformLanguage(params)

// Retrieves the preferred language of push notifications.
WebIM.conn.getPushPerformLanguage()
````