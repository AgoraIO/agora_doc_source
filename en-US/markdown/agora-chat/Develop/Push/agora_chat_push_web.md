# Offline Push

Agora Chat provides an offline push notification service that features low latency, high delivery, high concurrency, and no violation of the users' personal data.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Set the push notifications of an app
- Retrieve the push notification setting of an app
- Set the push notifications of a conversation
- Retrieve the push notification settings of one conversation or multiple conversations
- Clear the push notification setting of a conversation
- Set and retrieve the preferred language of push notifications


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web).
- You have activated the advanced features for push in [Agora Console](https://console.agora.io/). Advanced features allow you to set the push notification mode and do-not-disturb mode.


## Implementation

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
            <nobr><code>AT</code>: Only receives push notifications for mentioned messages.</nobr>
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
            <nobr><code>duration</code>: Do not receive push notifications for the specified duration.</nobr>
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
            <nobr><code>startTime</code> & <code>endTime</code>: Do not receive push notifications in the specified time frame.</nobr>
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

For example, assume that the push notification mode of the app is set to `AT`, while that of the specified conversation is set to `ALL`. You receive all the push notifications from this conversation, while you only receive the push notifications for mentioned messages from all the other conversations.

**Do-not-disturb mode**

<div class="alert note"><ol><li>You can specify both the DND duration and DND time frame at the app level. During the specified DND time periods, you do not receive any push notifications.<li>Conversations only support the DND duration setting; the setting of the DND time frame does not take effect.</ol></div>

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
    paramType: 2, // The DND time frame.
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
      paramType: 2, // The DND time frame.
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


### Clear the push notification setting of a conversation

You can call `clearRemindTypeForConversation` to clear the push notification setting of the specified conversation. Once the specific setting of a conversation is cleared, this conversation inherits the app setting by default.

The following code sample shows how to clear the push notification setting of a conversation:

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