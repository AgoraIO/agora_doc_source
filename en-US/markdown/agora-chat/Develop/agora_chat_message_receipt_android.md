After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to provide message receipt. Followings are the core methods:

- `ChatOptions.setRequireAck`: Enables message read receipt.
- `ChatOptions.setRequireDeliveryAck`: Enables message delievery receipt.
- `ackConversationRead`: Sends a conversation read receipt.
- `ackMessageRead`: Sends a message read receipt.
- `ackGroupMessageRead`: Sends a message read receipt for group chat.

The logic for implementing these receipts are as follows:

- Message delivery receipts

  1. The message sender enables delivery receipts by setting `ChatOptions.setRequireDeliveryAck` as `true`.
  2. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  3. The sender receives the delivery receipt by listening for `onMessageDelivered`.

- Conversation and message read receipts

  1. The message sender enables read receipt by setting `ChatOptions.setRequireAck` as `true`.
  2. After reading the message, the recipient calls `ackConversationRead` or `ackMessageRead` to send a conversation or message read receipt.
  3. The sender receives the conversation or message receipt by listening for `onConversationRead` or `onMessageRead`.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_android?platform=Android).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Android).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. The message sender sets `setRequireDeliveryAck` in `ChatOptions` as `true` before sending the message:

    ```java
    options.setRequireDeliveryAck(true);
    ```

2. Once the recipient receives the message, the SDK triggers `onMessageDelivered` on the message sender's client, notifying the message sender that the message has been delivered to the recipent.

    ```java
    // Add a message listener to listen for the receipt message.
    MessageListener msgListener = new MessageListener() {
        // Occurs when the message is received.
        @Override
        public void onMessageReceived(List<ChatMessage> messages) {
        }
        // Occurs when the message deliery receipt is received
        @Override
        public void onMessageDelivered(List<ChatMessage> message) {
        }
    };
    ```

### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### One-to-one chats

In one-to-one chats, the SDK supports sending both the conversation read receipts and message read receipts. Agora recommends using conversation read receipts if the new message arrives when the message recipient has not entered the conversation UI. 

- Conversation read receipts

    Follow the steps to implement conversation read receipts in one-to-one chats.

    1. When a user enters the conversation UI, check whether the conversation contains unread messages. If yes, call `ackConversationRead` to send a conversation read receipt.
    
    ```java
    // The message receiver calls ackConversationRead to send the converation read receipt.
    // This is an asynchronous method.
    try {
        ChatClient.getInstance().chatManager().ackConversationRead(conversationId);
    } catch (ChatException e) {
        e.printStackTrace();
    }
    ```


    2. The message sender listens for message events and receives the conversation read receipt in `onConversationRead`.

    ```java
    // The message sender calls addConversationListener to listen for converation events.
    ChatClient.getInstance().chatManager().addConversationListener(new ConversationListener() {
                ...
                @Override
                // Occurs when the all the messages in the converation is read.
                public void onConversationRead(String from, String to) {
                    // Add follow-up logics such as poping up a notification.
                }
            });
    ```

    <div class="alert note">In scenarios where a user is logged in multiple devices, if the user sends a conversation read receipt from one device, the server sets the count of unread messages in the conversation as 0, and all the other devices receive <code>onConversationRead</code>.</note>

- Message read receipts

    To implement the message read receipt, take the following steps:

    1. Send a converation read receipt when the recipient enters the conversation.

    ```java
    // The message receiver calls ackMessageRead to send the converation read receipt.
    try {
        ChatClient.getInstance().chatManager().ackMessageRead(conversationId);
    }catch (ChatException e) {
        e.printStackTrace();
    }
    ```

    2. When a new message arrives, send the message read receipt and add proper handling logics for the different message types.

    ```java
    ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
        ......

        @Override
        // Occurs when the specified message is received.
        public void onMessageReceived(List<ChatMessage> messages) {
            ......
            // Send the message read receipt.
            sendReadAck(message);
            ......
        }
        ......
    });
    // Send the message read receipt.
    public void sendReadAck(ChatMessage message) {
        // For messages in one-to-one chat
        if(message.direct() == ChatMessage.Direct.RECEIVE
                undefined message.getChatType() == ChatMessage.ChatType.Chat) {
            ChatMessage.Type type = message.getType();
            // For voice, video, and file messages, you need to send the receipt after clicking the files.
            if(type == ChatMessage.Type.VIDEO || type == ChatMessage.Type.VOICE || type == ChatMessage.Type.FILE) {
                return;
            }
            try {
                // Call ackMessageRead to send the message read receipt.
                ChatClient.getInstance().chatManager().ackMessageRead(message.getFrom(), message.getMsgId());
            } catch (ChatException e) {
                e.printStackTrace();
            }
        }
    }
    ```

    3. The message sender listens for the message receipt:

    ```java
    // The message sender calls addMessageListener to listen for message events.
    ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
        ......
        @Override
        // Occurs when the specified message is read.
        public void onMessageRead(List<ChatMessage> messages) {
            // Add follow-up logics such as poping up a notification.
        }
        ......
    });
    ```

#### Chat groups

In group chats, you can use message read receipts to notify the group owner or admins that the chat group message has been read. Ensure that each group member that has read the message should send a message read receipt.

Follow the steps to implement chat message read receipts.

1. For chat group messages, the group owner and admins can set to require the message read receipt when sending the message.

    ```java
    // Set setIsNeedGroupAck as true when sending the group message
    ChatMessage message = ChatMessage.createTxtSendMessage(content, to);
    message.setIsNeedGroupAck(true);
    ```

2. After the group member reads the chat group message, call `sendAckMessage` from the group member's client to send a message read receipt:

    ```java
    // Send the group message read receipt.
    public void sendAckMessage(ChatMessage message) {
            if (!validateMessage(message)) {
                return;
            }

            if (message.isAcked()) {
                return;
            }

            // May a user login from multiple devices, so do not need to send the ack msg.
            if (ChatClient.getInstance().getCurrentUser().equalsIgnoreCase(message.getFrom())) {
                return;
            }

            try {
                if (message.isNeedGroupAck() && !message.isUnread()) {
                    String to = message.conversationId(); // do not use getFrom() here
                    String msgId = message.getMsgId();
                    ChatClient.getInstance().chatManager().ackGroupMessageRead(to, msgId, ((TextMessageBody)message.getBody()).getMessage());
                    message.setUnread(false);
                    EMLog.i(TAG, "Send the group ack cmd-type message.");
                }
            } catch (Exception e) {
                EMLog.d(TAG, e.getMessage());
            }
        }
    ```

3. The message sender listens for the message read receipt.

    ```java
    // Occurs when the group message is read.
    void onGroupMessageRead(List<GroupReadAck> groupReadAcks) {
        // Add follow-up notifications
    }
    ```

4. The message sender can get the detailed informaiton of the read receipt using `asyncFetchGroupReadAcks`.

    ```java
    /**
    * Fetches the details of the group message read receipt.
    * @param msgId The message ID.
    * @param pageSize The page size.
    * @param startAckId The receipt ID from which you want to fetch. If you set it as null, the SDK fetches from the latest receipt.
    * @return The message receipt list and a cursor.
    */
    public void asyncFetchGroupReadAcks(final String msgId, final int pageSize,final String startAckId, final ValueCallBack<CursorResult<GroupReadAck>> callBack) {}
    ```