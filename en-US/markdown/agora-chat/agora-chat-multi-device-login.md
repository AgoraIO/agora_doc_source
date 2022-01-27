# Multi-device Login

When you implement Agora Chat in your app, each user can log into their account on your chat network from up to four devices concurrently; all messages are automatically synchronized across all devices. You can also implement more advanced features with a few lines of code.

This page shows you how to enable each user to send messages to themselves， kick out a logged in device, and synchronize group and contact changes between devices.

## Understand the tech

Agora Chat automatically syncs the sent and received messsages for users who log in on multiple devices.

For the users to send messages to their own account on other devices, the SDK assigns an ID that acts as a specical user ID for each logged in device. The logged in devices can send messages to each other using these IDs.

To synchronize the group and contact updates, the SDK provides a `MultiDeviceListener` class that listens for group and contact events on other devices.

## Prerequisites

Before proceeding, ensure that you have a project that has implemented [Agora Chat functionality](link) in your app.

## Implementation

This section describes how to enable users to send messages to themselves, synchronize the group and contact updates between devices, and kick out a logged in device.

### Enable users to send messages to themselves on all their devices

To send messages to other logged in devices, do the following:

1. Get the IDs of the other logged in devices.
   
   ```java
   // Get the IDs of the other devices that are logged in with the same account.
   List<String> ids = ChatClient.getInstance().contactManager().getSelfIdsOnOtherPlatform();
   // Get the ID of one device.
   String toChatUsername = ids.get(0);
   ```

2. Set the ID as the message receiver when sending a message. See [Send and receive messages](link) for details.

   ```java
   // Create a text message and set this ID as the receiver.
   ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername); 
   // Send the message.
   ChatClient.getInstance().chatManager().sendMessage(message); 
   ```

### Synchronize group and contact updates

When a user is logged into your app on multiple devices, best practice is to update changes made on one device to all others. For example, if a user joins a chat group, it makes sense that this is reflected on all devices. Agora supplies the `MultiDeviceListener` class that listens to actions made by the current user in other instances of your app. You use an implementation of this class to reflect actions made on one device on all others. To achive this, do the following:

1. Implement a custom instance of `MultiDeviceListener`, listen for the group events in `onGroupEvent` and the contact events in `onContactEvent`, and react to actions preformed by the current user on another device:
   ```java
    private class ChatMultiDeviceListener implements MultiDeviceListener {
            @Override
            public void onContactEvent(int event, String target, String ext) {
                ChatLog.i(TAG, "onContactEvent event"+event);
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
                ChatLog.i(TAG, "onGroupEvent event"+event);
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
    ```

2. In the initiation procedure for your app, add your custom listener to your `ChatClient` instance:

    ```java
    // Add the multi-device listener.
    ChatClient.getInstance().addMultiDeviceListener(chatMultiDeviceListener);
    ```

3. Remove the listener when it is no longer needed.
   
   ```java
   // Remove the multi-device listener.
   ChatClient.getInstance().removeMultiDeviceListener(chatMultiDeviceListener);
   ```

### Kick out a logged in device


## Reference

See [MultiDeviceListener](link) for all the group and contact events.

To modify the limit of concurrent devices or disable multi-device login, contact support@agora.io.
