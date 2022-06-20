# Presence

The presence feature enables users to to publicly display their online presence status and quickly determine the status of other users. Users can also customize their presence status, which adds fun and diversity to real-time chatting.

The following illustration shows the implementation of creating a custom presence status and how various presence statues look in a contact list:

![](https://web-cdn.agora.io/docs-files/1655302046418)

This page shows how to use the Agora Chat SDK to implement presence in your project.


## Understand the tech

The Agora Chat SDK provides the `ChatPresence`, `ChatPresenceManager`, and `ChatPresenceEventListener` classes for presence management, which allows you to implement the following features:

- Subscribe to the presence status of one or more users
- Unsubscribe from the presence status of one or more users
- Listen for presence status updates
- Publish a custom presence status
- Retrieve the list of subscriptions
- Retrieve the presence status of one or more users

The following figure shows the workflow of how clients subscribe to and publish presence statuses:

![](https://web-cdn.agora.io/docs-files/1655718659347)

As shown in the figure, the workflow of presence subscription and publication is as follows:

1. User A subscribes to the presence status of User B.
2. User B publishes a presence status.
3. The Agora Chat server triggers an event to notify User A about the presence update of User B.

## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You have activated the presence feature in [Agora Console](http://console.staging.agora.io/).

## Implementation

This section introduces how to implement presence functionalities in your project.

### Subscribe to the presence status of one or more users

By default, you do not subscribe to any user. To subscribe to the presence statuses of the specified users, you can call `subscribe`. Whenever the specified users update their presence statuses, the `onPresenceStatusChanged` callback is triggered, notifying you about the updated statuses asynchronously.

The following code sample shows how to subscribe to the presence status of one or more users:

```dart
// members: The ID list of users to whom you subscribe.
List<String> members = [];
// expiry: The subscription duration in seconds.
int expiry = 100;
try {
  List<ChatPresence> list =
      await ChatClient.getInstance.presenceManager.subscribe(
    members: members,
    expiry: expiry,
  );
} on ChatError catch (e) {
  // If the call fails, you can troubleshoot according to the returned code and reason.
}
```

<div class="alert info"><ol><li>You can subscribe to a maximum of 100 users at each call. The total subscriptions of each user cannot exceed 3,000. Once the number of subscriptions exceeds the limit, the subsequent subscriptions with longer durations succeed and replace the existing subscriptions with shorter durations.<li>The subscription duration can be a maximum of 30 days. When the subscription to a user expires, you need subscribe to this user once again. If you subscribe to a user again before the current subscription expires, the duration is reset.</ol></div>


### Publish a custom presence status

You can call `publishPresence` to publish your custom statuses. Whenever your presence status updates, the users who subscribe to you receive the `onPresenceStatusChanged` callback.

The following code sample shows how to publish a custom status:

```dart
try {
  // description: The custom presence status.
  await ChatClient.getInstance.presenceManager.publishPresence(description);
} on ChatError catch (e) {
}
```


### Listen for presence status updates

Refer to the following code sample to listen for presence status updates:

```dart
// Inherits and implements the ChatPresenceEventListener class.
class _ChatPageState extends State<ChatPage>
    implements ChatPresenceManagerListener {
  @override
  void initState() {
    super.initState();
    // Adds the presence status listener.
    ChatClient.getInstance.presenceManager.addPresenceManagerListener(this);
  }
  @override
  void dispose() {
    // Removes the presence status listener.
    ChatClient.getInstance.presenceManager.removePresenceManagerListener(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // Occurs when the presence statuses of the subscriptions update.
  @override
  void onPresenceStatusChanged(List<ChatPresence> list) {}
}
```

### Unsubscribe from the presence status of one or more users

You can call `unSubscribe` to unsubscribe from the presence statuses of the specified users, as shown in the following code sample:

```dart
// memberIds: The ID list of users from whom you unsubscribe.
try {
  await ChatClient.getInstance.presenceManager.unSubscribe(
    members: members,
  );
} on ChatError catch (e) {
}
```

### Retrieve the list of subscriptions


You can call `fetchSubscribedMembers` to retrieve the list of your subscriptions in a paginated list, as shown in the following code sample:

```dart
try {
  List<String> subMembers =
      await ChatClient.getInstance.presenceManager.fetchSubscribedMembers();
} on ChatError catch (e) {
  // If the call fails, you can troubleshoot according to the returned code and reason.
}
```

### Retrieve the presence status of one or more users

You can call `fetchPresenceStatus` to retrieve the current presence statuses of the specified users without the need to subscribe to them, as shown in the following code sample:

```dart
// memberIds: The ID list of users whose presence statuses you retrieve.
try {
  List<ChatPresence> list = await ChatClient.getInstance.presenceManager
      .fetchPresenceStatus(members: memberIds);
} on ChatError catch (e) {
}
```
