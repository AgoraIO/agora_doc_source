# Presence

The presence feature enables users to display their online status to publicly display their online presence status and quickly determine the status of other users. Users can also customize their presence status, which adds fun and diversity to real-time chatting.

The following illustration shows the implementation of creating a custom presence status and and how various presence statuses look in the app:

![](https://web-cdn.agora.io/docs-files/1655302111155)

This page shows how to use the Agora Chat SDK to implement presence in your project.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Subscribe to the presence status of one or more users
- Unsubscribe from the presence status of one or more users
- Listen for presence status updates
- Publish a custom presence status
- Retrieve the list of subscriptions
- Retrieve the presence status of one or more users

The following figure shows the workflow of how clients subscribe to and publish presence statuses:

![](https://web-cdn.agora.io/docs-files/1655308138447)

As shown in the figure, the workflow of presence subscription and publication is as follows:

1. User A subscribes to the presence status of User B.
2. User B publishes a presence status.
3. The Agora Chat server triggers an event to notify User A about the presence update of User B.


## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- The project has integrated a version of the Agora Chat SDK later than v1.0.3 and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_web).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation).
- You have activated the presence feature in [Agora Console](http://console.staging.agora.io/).


## Implementation

This section introduces how to implement presence functionalities in your project.

### Subscribe to the presence status of one or more users

By default, you do not subscribe to any user. To subscribe to the presence statuses of the specified users, you can call `subscribePresence`. Whenever the specified users update their presence statuses, the `onPresenceStatusChange` callback is triggered, notifying you about the updated statuses asynchronously.

The following code sample shows how to subscribe to the presence status of one or more users:

```javascript
let option = {
  usernames: ['Alice','Bob'],
  expiry: 7*24*3600
}
conn.subscribePresence(option).then(res => {console.log(res)})
```

<div class="alert info"><ol><li>You can subscribe to a maximum of 100 users at each call. The total subscriptions of each user cannot exceed 3,000. Once the number of subscriptions exceeds the limit, the subsequent subscriptions with longer durations succeed and replace the existing subscriptions with shorter durations.<li>The subscription duration can be a maximum of 30 days. When the subscription to a user expires, you need subscribe to this user once again. If you subscribe to a user again before the current subscription expires, the duration is reset.</ol></div>


### Publish a custom presence status

You can call `publishPresence` to publish your custom statuses. Whenever your presence status updates, the users who subscribe to you receive the `onPresenceStatusChange` callback.

The following code sample shows how to publish a custom status:

```javascript
let option = {
  description: 'custom presence'
}
conn.publishPresence(option).then(res => {console.log(res)})
```


### Listen for presence status updates

Refer to the following code sample to listen for presence status updates:

```javascript
// Adds the presence status listener.
WebIM.conn.addEventHandler('MESSAGES',{
  // Occurs when the presence statuses of the subscriptions update.
   onPresenceStatusChange: => (msg) {
       // You can implement subsequent settings in this callback.
   	   console.log('status updates'，msg) 
   }, 
})
```

### Unsubscribe from the presence status of one or more users

You can call `unsubscribePresence` to unsubscribe from the presence statuses of the specified users, as shown in the following code sample:

```javascript
let option = {
  usernames: ['Alice','Bob']
}
conn.unsubscribePresence(payload).then(res => {console.log(res)})
```

### Retrieve the list of subscriptions

You can call `getSubscribedPresenceList` to retrieve the list of your subscriptions in a paginated list, as shown in the following code sample:

```javascript
let option = {
  pageNum: 0,
  pageSize: 50
}
conn.getSubscribedPresenceList(payload).then(res => {console.log(res)})
```

### Retrieve the presence status of one or more users

You can call `getPresenceStatus` to retrieve the current presence statuses of the specified users without the need to subscribe to them, as shown in the following code sample:

```javascript
let option = {
  usernames: ['Alice','Bob']
}
conn.getPresenceStatus(payload).then(res => {console.log(res)})
```