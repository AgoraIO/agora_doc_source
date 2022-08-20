# Thread Messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.

## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `isChatThread` field, as shown in the following code sample:

```javascript
function sendTextMessage() {
    let option = {
        chatType: 'groupChat',     // Sets `chatType` to `groupChat` as a thread belongs to a chat group.
        type: 'txt',               // Sets `type` to `txt` to create and send a text message.
        to: chatThreadId,          // Sets `to` to the ID of a thread that receives the text message.
        msg: 'message content'     // Sets `msg` to the content of the text message.
        isChatThread:true,         // Sets `isChatThread` to `true` to mark this message as a thread message.
    }
    // Calls `create` to create a text message.
    let msg = WebIM.message.create(option); 
    // Calls `send` to send the text message.
    connection.send(msg).then(() => {
        console.log('send private text Success');  
    }).catch((e) => {
        console.log("Send private text error");  
    })
};
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_web?platform=Web#send-a-text-message).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `onChatThreadChange` callback triggered by the `update` event. Thread members can also listen for the `onTextMessage` callback to receive thread messages, as shown in the following code sample:

```javascript
// The SDK triggers the `onTextMessage` callback when it receives a message.
// After receiving this callback, the SDK parses the message and displays it.
connection.addEventHandler('THREADMESSAGE',{
  onTextMessage:(message) =>{
			if(message.chatThread && JSON.stringify(message.chatThread)!=='{}'){
        console.log(message)
        // You can implement subsequent settings in this callback.
      }
	},
});
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_web?platform=Web#receive-a-message).


### Recall a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `isChatThread` field.

Once a message is recalled in a thread, all chat group members receive the `onChatThreadChange` callback triggered by the `update` event. Thread members can also listen for the `onRecallMessage` callback, as shown in the following code sample:

```javascript
let option = {
  mid: 'msgId',           // The ID of the message to be recalled.
  to: 'userID',           // The username of the message receiver.
  chatType: 'groupChat'   // Sets `chatType` to `groupChat` as a thread belongs to a chat group.
  isChatThread: true      // Sets `isChatThread` to `true` to mark this message as a thread message.
};
// Calls `recallMessage` to recall a message.
connection.recallMessage(option).then((res) => {
  console.log('success', res)
}).catch((error) => {
  // Occurs when the message fails to be recalled within the default time limit of two minutes.
  console.log('fail', error)
})
// The SDK triggers the `onRecallMessage` callback when it recalls a message.
// After receiving this callback, the SDK parses the message and updates its display.
conn.addEventHandler('MESSAGES',{
   onRecallMessage: => (msg) {
       // You can implement subsequent settings in this callback.
   	   console.log('Message recall succeeds.'，msg) 
   }, 
})
```

For more information about recalling a message, see [Recall Messages](./agora_chat_send_receive_message_web?platform=Web#recall-a-message).


### Retrieve thread messages from the server

For details about how to retrieve messages from the server, see [Retrieve Historical Messages](./agora_chat_retrieve_message_web?platform=Web#retrieve-historical-messages-of-the-specified-conversation).