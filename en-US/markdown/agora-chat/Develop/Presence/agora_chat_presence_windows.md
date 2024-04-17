# Presence

The presence feature enables users to publicly display their online presence status and quickly determine the status of other users. Users can also customize their presence status, which adds fun and diversity to real-time chatting.

The following illustration shows the implementation of creating a custom presence status and how various presence statues look in a contact list:

![](https://web-cdn.agora.io/docs-files/1655302111155)

This page shows how to use the Agora Chat SDK to implement presence in your project.

## Understand the tech

The Agora Chat SDK provides the `Presence`, `PresenceManager`, and `IPresenceManagerDelegate` classes for presence management, which allows you to implement the following features:

- Subscribe to the presence status of one or more users
- Unsubscribe from the presence status of one or more users
- Listen for presence status updates
- Publish a custom presence status
- Retrieve the list of subscriptions
- Retrieve the presence status of one or more users

The following figure shows the workflow of how clients subscribe to and publish presence statuses:

![](https://web-cdn.agora.io/docs-files/1662013983679)

As shown in the figure, the workflow of presence subscription and publication is as follows:

1. User A subscribes to the presence status of User B.
2. User B publishes a presence status.
3. The Agora Chat server triggers an event to notify User A about the presence update of User B.


## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Windows](./agora_chat_get_started_windows).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation).
- You have activated the presence feature in [Agora Console](http://console.agora.io/).


## Implementation

This section introduces how to implement presence functionalities in your project.

### Subscribe to the presence status of one or more users

By default, you do not subscribe to any users. To subscribe to the presence statuses of the specified users, you can call `PresenceManager#SubscribePresences`.

Once the subscription succeeds, the `onSuccess` callback is triggered, notifying you about the current statuses of the specified users synchronously. Whenever the specified users update their presence statuses, the `IPresenceManagerDelegate#OnPresenceUpdated` callback is triggered, notifying you about the updated statuses asynchronously.

The following code sample shows how to subscribe to the presence status of one or more users:

```c#
SDKClient.Instance.PresenceManager.SubscribePresences(members, expiry, new ValueCallBack<List<Presence>>(
    onSuccess: (list) =>
    {
        foreach (var it in list)
        {
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"SubscribePresences failed, code:{code}, desc:{desc}");
    }
));
```

<div class="alert info"><ol><li>You can subscribe to a maximum of 100 users at each call. The total subscriptions of each user cannot exceed 3,000. Once the number of subscriptions exceeds the limit, the subsequent subscriptions with longer durations succeed and replace the existing subscriptions with shorter durations.<li>The subscription duration can be a maximum of 30 days. When the subscription to a user expires, you need subscribe to this user once again. If you subscribe to a user again before the current subscription expires, the duration is reset.</ol></div>


### Publish a custom presence status

You can call `PresenceManager#PublishPresence` to publish a custom status. Whenever your presence status updates, the users who subscribe to you receive the `IPresenceManagerDelegate#OnPresenceUpdated` callback.

The following code sample shows how to publish a custom status:

```c#
SDKClient.Instance.PresenceManager.PublishPresence(ext, new CallBack(
    onSuccess: () => {
        Debug.Log($"PublishPresence success.");
    },
    onError: (code, desc) => {
        Debug.Log($"PublishPresence failed, code:{code}, desc:{desc}");
    }
));
```


### Listen for presence status updates

Refer to the following code sample to listen for presence status updates:

```c#
PresenceM
// Adds the presence status listener.anagerDelegate presenceManagerDelegate = new PresenceManagerDelegate();
SDKClient.Instance.PresenceManager.AddPresenceManagerDelegate(presenceManagerDelegate);

// Occurs when the presence statuses of the subscriptions update.
public interface IPresenceManagerDelegate
{
    void OnPresenceUpdated(List<Presence> presences);
}
```


### Unsubscribe from the presence status of one or more users

You can call `PresenceManager#UnsubscribePresences` to unsubscribe from the presence statuses of the specified users, as shown in the following code sample:

```c#
SDKClient.Instance.PresenceManager.UnsubscribePresences(mem_list, new CallBack(
    onSuccess: () => {
        Debug.Log($"UnsubscribePresences success.");
    },
    onError: (code, desc) => {
        Debug.Log($"UnsubscribePresences failed, code:{code}, desc:{desc}");
    }
));
```


### Retrieve the list of subscriptions

You can call `PresenceManager#FetchSubscribedMembers` to retrieve the list of your subscriptions in a paginated list, as shown in the following code sample:

```c#
SDKClient.Instance.PresenceManager.FetchSubscribedMembers(pageNum, pageSize, new ValueCallBack<List<string>>(
    onSuccess: (list) =>
    {

    },
    onError: (code, desc) =>
    {
        Debug.Log($"SubscribePresences failed, code:{code}, desc:{desc}");
    }
));
```

### Retrieve the presence status of one or more users

You can call `PresenceManager#FetchPresenceStatus` to retrieve the current presence statuses of the specified users without the need to subscribe to them, as shown in the following code sample:

```c#
// members: The ID list of users whose presence status you retrieve.
// You can pass in up to 100 user IDs.
SDKClient.Instance.PresenceManager.FetchPresenceStatus(members, new ValueCallBack<List<Presence>>(
    onSuccess: (list) =>
    {
        foreach (var it in list)
        {
        }
    },
    onError: (code, desc) =>
    {
        Debug.Log($"FetchPresenceStatus failed, code:{code}, desc:{desc}");
    }
));
```