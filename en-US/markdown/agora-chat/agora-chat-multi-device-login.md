# Log in to Multiple Devices

Agora Chat supports multi-device login. Users can sync their messages, groups, and contacts on all the logged in devices. By default, a user can log in to the same account on at most four devices. To modify this number or disable multi-device login, contact sales@agora.io.

## Understand the tech

Agora Chat automatically syncs the sent and received messsages for users who log in on multiple devices.

For the users to send messages to their own account on other devices, the SDK automatically assigns an ID that acts as a specical user ID for each logged in device. The logged in devices can send messages to each other using these IDs.

To sync the group and contact actions, the SDK provides a `MultiDeviceListener` class that listens for group and contact events on other devices.

## Prerequisites

Before proceeding, ensure that you have a project that has implemented [the basic real-time chat functionalities]().

## Implementation

This section describes how to exchange messages between the logged in devices and sync the group and contact actions.

### Send messages to other devices

To send messages to other logged in devices, do the following:

1. Call `getSelfIdsOnOtherPlatform` to get the IDs of the other logged in devices.

2. Set the ID of a device as the receiver and send messages. See [Send and receive messages]() for details.

```java
// Get the IDs of the other devices that are logged into with the same account.
List<String> ids = EMClient.getInstance().contactManager().getSelfIdsOnOtherPlatform();
// Get the ID of one device.
String toChatUsername = ids.get(0);
// Create a text message and set this ID as the receiver.
AgoraChatMessage message = AgoraChatMessage.createTxtSendMessage(content, toChatUsername); 
// Send the message.
AgoraChatClient.getInstance().chatManager().sendMessage(message); 
```

### Sync group and contact actions

If a user logs in the same account on device A and device B, and makes group or contact changes on device A, for example, joining a group chat or accepting a friend invitation, device B can be notified of these actions. To achive this, do the following:

1. Implement the `MultiDeviceListener` class.
2. Listen for the group events in `onGroupEvent`, and the contact events in `onContactEvent`.
3. Call `addMultiDeviceListener` to add the listener.

```java
private class ChatMultiDeviceListener implements AgoraChatMultiDeviceListener {
        @Override
        public void onContactEvent(int event, String target, String ext) {
            AgoraChatLog.i(TAG, "onContactEvent event"+event);
            DemoDbHelper dbHelper = DemoDbHelper.getInstance(DemoApplication.getInstance());
            switch (event) {
                // The user sends a contact request on another device.
                case CONTACT_ADD:
                    break;
                // The user removes a contact on another device.
                case CONTACT_REMOVE:
                    break;
                // Other contact events 
                ...
            }
        }

        @Override
        public void onGroupEvent(int event, String groupId, List<String> usernames) {
            AgoraChatLog.i(TAG, "onGroupEvent event"+event);
            switch (event) {
                // The user creats a group on another device.
                case GROUP_CREATE:
                    break;
                // The user destroys a group on another device.
                case GROUP_DESTROY:
                    break;
                // The user joins a group on another device.
                case GROUP_JOIN:
                    break;
                // Other group events.
                ...
                default:
                    break;
            }
        }
}

ChatMultiDeviceListener chatMultiDeviceListener = new ChatMultiDeviceListener();

// Add the multi-device listener.
AgoraChatClient.getInstance().addMultiDeviceListener(chatMultiDeviceListener);

// Remove the multi-device listener.
AgoraChatClient.getInstance().removeMultiDeviceListener(chatMultiDeviceListener);
```

## Reference

See [MultiDeviceListener]() for the list of all the group and contact events.