The Agora Chat SDK supports sending and receiving various types of messages:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- CMD messages.
- Extended messages.
- Custom messages.

You can send a message to a peer user, a chat group, or a chat room. After sending a message, you can listen for the message read receipt. You can also recall the message. 

To manage messages, for example, to delete a conversation, you can also retrieve historical messages from the local device or from the server.

This page introduces how to use the Agora Chat SDK to implement these functionalities in your app.

## Understand the tech

The Agora Chat SDK provides a `Message` class that defines the message type, and a `ChatManager` class that allows you to send, recieve, recall, and retrieve messages.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of users logged in. For details, see [Get Started with Agora Chat](agora_chat_get_started_web?platform=Web).
- You understand the [API call frequency limits](./agora_chat_limitation_web?platform=Web).


## Send and recieve messages

The process of sending and receiving a message is as follows:

1. On the sender's client, create a message and send it. The message is sent to the Agora Chat server.
2. The server delivers the message to the receiver.
3. When the receiver receives the message, the SDK triggers an event.
4. On the receiver's client, listen for the event, and get the message.

### Send a text message

Refer to the following code sample to create, send, and receive a text message:

```javascript
// Send a text message.
function sendPrivateText() {

    let option = {
        // Set the message content.
        msg: "message content",
        // Set the username of the receiver.
        to: "username",
        // Set the chat type
        chatType: "singleChat",
    };
    // Create a text message.
    let msg = WebIM.message.create(opt);
    // Call send to send the message
    conn.send(msg).then(()=>{
        console.log("send private text Success");
    }).catch((e)=>{
        console.log("Send private text error");
    });
}
```

### Receive a message

Refer to the following sample code to listen for message events using `addEventHandler`.

```javascript
// Use `addEventHandler` to listen for callback events.
WebIM.conn.addEventHandler("eventName",{
    // Occurs when the app is connected.
    onOpened: function (message) {},
    // Occurs when the connection is lost.
    onClosed: function (message) {},
    // Occurs when the text message is received.
    onTextMessage: function (message) {},
    // Occurs when the emoji message is received.
    onEmojiMessage: function (message) {},
    // Occurs when the image message is received.
    onImageMessage: function (message) {},
    // Occurs when the CMD message is received.
    onCmdMessage: function (message) {},
    // Occurs when the audio message is received.
    onAudioMessage: function (message) {},
    // Occurs when the location message is received.
    onLocationMessage: function (message) {},
    // Occurs when the file message is received.
    onFileMessage: function (message) {},
    // Occurs when the custom message is received.
    onCustomMessage: function (message) {},
    // Occurs when the video message is received.
    onVideoMessage: function (message) {},
    // Occurs when the presence state is updated.
    onPresence: function (message) {}, 
    // Occurs when a contact invitation is received.
    onRoster: function (message) {},
    // Occurs when a group invitation is received.
    onInviteMessage: function (message) {},
    // Occurs when the local network is connected.
    onOnline: function () {},
    // Occurs when the local network is disconnected.
    onOffline: function () {},
    // Occurs when an error occurs.
    onError: function (message) {},
    // Occurs when the block list is updated, for example, if you add a contact to the block list. list contains all the usernames on the block list.
    onBlacklistUpdate: function (list) {
    },
    // Occurs when the message is recalled.
    onRecallMessage: function (message) {},
    // Occurs when the message is received.
    onReceivedMessage: function (message) {},
    // Occurs when the message delevery receipt is received.
    onDeliveredMessage: function (message) {},
    // Occurs when the message read receipt is received.
    onReadMessage: function (message) {},
    // Occurs when the local user is muted and still attempts to send a group message. This callback is triggered only on the local client, not on other clients in the group.
    onMutedMessage: function (message) {},
    // Occurs when the conversation read receipt is received.
    onChannelMessage: function (message) {},
});
```

### Send attachment messages

Attachment messages include voice, image, video, and file messages. When you send an attachment message, the attachment is uploaded to the Agora Chat server.
- For voice, image, and video messages, the SDK automatically downloads the audio, image, or video thumbnail when they arrive.
- For file messages, the SDK does not automatically download the attachment. You need to call APIs to download the file on the receiver's client.

Refer to the following sample code to send a type of attachment message:

- Voice messages

    ```javascript
    var sendPrivateAudio = function () {
        // Create a voice message.
        var msg = new WebIM.message('audio');
        // Select the local audio file.
        var input = document.getElementById('audio');
        // Turn the audio file to a binary file.
        var file = WebIM.utils.getFileUrl(input);
        var allowType = {
            'mp3': true,
            'amr': true,
            'wmv': true
        };
        if (file.filetype.toLowerCase() in allowType) {
            var option = {
                // Set the message type
                type: 'audio',
                file: file,
                // Set the length of the audio file in seconds.
                length: '3',
                // Set the username of the message receiver.
                to: 'username',
                // Set the chat type.
                chatType: 'singleChat',
                // Occurs when the audio file fails to be uploaded.
                onFileUploadError: function () {
                    console.log('onFileUploadError');
                },
                // Reports the progress of uploading the audio file.
                onFileUploadProgress: function (e) {
                    console.log(e)
                },
                // Occurs when the audio file is successfully uploaded.
                onFileUploadComplete: function () {
                    console.log('onFileUploadComplete');
                },
                ext: {file_length: file.data.size}
            };
            // Create a voice message.
            var msg = WebIM.message.create(option);
            // Call send to send the voice message.
            conn.send(msg).then((res)=>{
                // Occurs when the audio file is successfully sent.
                console.log('Success');
            }).catch((e)=>{
                // Occurs when the audio file fails to be sent 
                console.log("Fail");
            });
        }
    };
    ```

- Image messages

    ```javascript
    var sendPrivateImg = function () {
        // Select the local image file.
        var input = document.getElementById("image");
        // Turn the image to a binary file.
        var file = WebIM.utils.getFileUrl(input);
        var allowType = {
            jpg: true,
            gif: true,
            png: true,
            bmp: true,
        };
        if (file.filetype.toLowerCase() in allowType) {
            var option = {
                // Set the message type.
                type: 'img',
                file: file,
                ext: {
                    // Set the image file length.
                    file_length: file.data.size,
                },
                // Set the username of the message receiver.
                to: "username",
                // Set the chat type.
                chatType: "singleChat",
                // Occurs when the image file fails to be uploaded.
                onFileUploadError: function () {
                    console.log("onFileUploadError");
                },
                // Reports the progress of uploading the image file.
                onFileUploadProgress: function (e) {
                    console.log(e);
                },
                // Occurs when the image file is successfully uploaded.
                onFileUploadComplete: function () {
                    console.log("onFileUploadComplete");
                },
            };
            // Create a voice message.
            var msg = WebIM.message.create(option);
            // Call send to send the voice message.
            conn.send(msg).then((res)=>{
                // Occurs when the audio file is successfully sent.
                console.log('Success');
            }).catch((e)=>{
                // Occurs when the audio file fails to be sent 
                console.log("Fail");
            });
        }
    };
    ```

- URL image messages

  > To send a URL image message, make sure you set `useOwnUploadFun` as `true`.

    ```javascript
    var sendPrivateUrlImg = function () {

        var option = {
            chatType: 'singleChat',
            // Set the message type.
            type: "img",
            // Set the URL address of the image file.
            url: "img url",
            // Set the usernmae of the message receiver.
            to: "username",
        };
        // Create an image message.
        var msg = WebIM.message.create(option);
        // Call send to send to image file.
        conn.send(msg);
    };
    ```

- Video messages

  By default, the SDK generates a thumbnail When sending the video message, and downloads the thumbnail when receiving the video message.

    ```javascript
    var sendPrivateVideo = function () {

        // Select the local video file.
        var input = document.getElementById("video");
        // Turn the video to a binary file.
        var file = WebIM.utils.getFileUrl(input);
        var allowType = {
            mp4: true,
            wmv: true,
            avi: true,
            rmvb: true,
            mkv: true,
        };
        if (file.filetype.toLowerCase() in allowType) {
            var option = {
                // Set the message type
                type: 'video',
                file: file,
                // The username of the message receiver
                to: "username",
                // Set the chat type
                chatType: "singleChat",
                onFileUploadError: function () {
                    // Occurs when the file fails to be uploaded.
                    console.log("onFileUploadError");
                },
                onFileUploadProgress: function (e) {
                    // Reports the progress of uploading the file.
                    console.log(e);
                },
                onFileUploadComplete: function () {
                    // Occurs when the file is uploaded.
                    console.log("onFileUploadComplete");
                },
                ext: {file_length: file.data.size},
            };
            // Create a video message.
            var msg = WebIM.message.create(option);
            // Call send to send the video message.
            conn.send(msg).then((res)=>{
                // Occurs when the message is sent.
                console.log('success')
            }).catch((e)=>{
                // Occurs when the message fails to be sent, for example, because the local user is muted or blocked.
                console.log("Fail");
            });
        }
    };
    ```

- File messages

    ```javascript
    var sendPrivateFile = function () {
        // Select the local file.
        var input = document.getElementById("file");
        // Turn the file message to a binary file.
        var file = WebIM.utils.getFileUrl(input);
        var allowType = {
            jpg: true,
            gif: true,
            png: true,
            bmp: true,
            zip: true,
            txt: true,
            doc: true,
            pdf: true,
        };
        if (file.filetype.toLowerCase() in allowType) {
            var option = {
                // Set the message type.
                type: 'file',
                file: file,
                // Set the username of the message receiver.
                to: "username",
                // Set the chat type.
                chatType: "singleChat",
                // Occurs when the file fails to be uploaded.
                onFileUploadError: function () {
                    console.log("onFileUploadError");
                },
                // Reports the progress of uploading the file.
                onFileUploadProgress: function (e) {
                    console.log(e);
                },
                // Occurs when the file is uploaded.
                onFileUploadComplete: function () {
                    console.log("onFileUploadComplete");
                },
                ext: {file_length: file.data.size},
            };
            // Create a file message.
            var msg = WebIM.message.create(option);
            // Call send to send the file message.
            conn.send(msg).then((res) => {
                // Occurs when the file message is sent.
                console.log("Success");
            }).catch((e)=>{
                // Occurs when the file message fails to be sent.
                console.log("Fail");
            });
        }
    };
    ```

### Send CMD messages

CMD messages are command messages that tell the specified user to take a certain action. The receiver deals with the command message themselves.

The following code sample shows how to send and receive a CMD message:

```javascript
var options = {
  // Set the message type.
  type: 'cmd',  
  // Set the chat type.
  chatType: 'singleChat',
  // The username of the message receiver.
  to: 'username',
  // Set the custom action.
  action : 'action',
  // Set the extended message.
  ext :{'extmsg':'extends messages'}
}
// Create a CMD message.
var msg = WebIM.message.create(options);
// Call send to send the CMD message.
conn.send(msg).then((res)=>{
    // Occurs when the message is sent.
    console.log("Success")
}).catch((e)=>{
    // Occurs when the message fails to be sent.
    console.log("Fail");
});

```

### Custom messages

Custom messages are self-defined key-value pairs that include the message type and the message content.

The following code sample shows how to send a custom message:

```javascript
var sendCustomMsg = function () {

    // Set the custom event.
    var customEvent = "customEvent";
    // Set the custom message content with key-value pairs.
    var customExts = {};
    var options = {
        // Set the message type.
        type: "custom",
        // Set the username of the message receiver.
        to: "username",
        // Set the chat type.
        chatType: "singleChat",
        customEvent,
        customExts,
        // The extended field. Do not set it as null.
        ext: {},
    }
    // Create a custom message.
    var msg = WebIM.message.create(options);
    // Call send to send the custom message.
    conn.send(msg).then((res)=>{
        // Occurs when the message is sent.
        console.log("Success")
    }).catch((e)=>{
        // Occurs when the message fails to be sent.
        console.log("Fail");
    });
};
```

### Extended messages

You can also custom the message content by extending the message type. The following code sample shows how to send an extended message:

```javascript
function sendPrivateText() {
    var options = {
        type: "txt",
        msg: "message content",
        to: "username",
        chatType: "singleChat",
        // Set the message extension.
        ext: {
            key1: "Self-defined value1",
            key2: {
                key3: "Self-defined value3",
            },
        }
    }
    let msg = WebIM.message.create(options);
    // Call send to send the extended message.
    conn.send(msg).then((res)=>{
        console.log("send private text Success");
    }).catch((e)=>{
        console.log("Send private text error");
    });
}
```

### Recall messages

After sending a message, you can recall it using the `recallMessage` method. The default time limit for recalling a message is two minutes after the message. To customize this time limit, contact support@agora.io.

Refer to the following code sample to recall a message:

```javascript
let option = {
    // Set the message ID.
    mid: 'msgId',
    // Set the username of the message receiver.
    to: 'userID',
    // Set the chat type.
    chatType: 'singleChat'
};
// Call recallMessage to recall the specified message.
connection.recallMessage(option).then((res) => {
    // Occurs when the message is recalled.
    console.log('success', res)
}).catch((error) => {
    // Occurs when the message fails to be recalled 2 minutes within the message call.
    console.log('fail', error)

// You can call addEventHandler to minitor the recall status and add handling logics.
WebIM.conn.addEventHandler('MESSAGES',{
   onRecallMessage: => (msg) {
          // You can delete the message on the local conversation and inject a message such as "XXX recalls a message".
          console.log('Message recall succeeds'，msg) 
   }, 
})
```

## Manage local messages

The Agora Chat SDK stores the sent and received messages in the local database, and you can manage these messages in conversations. 

The followings are the core methods for managing the local messages:
- `getSessionList`: Retrieves all the conversations on the local device.
- `fetchHistoryMessages`: Retrieves the messages in the specified conversation.

### Retrieve the conversation list

Call `getSessionList` to retrieve all the conversations to the local device.

> To retrieve the conversation list, ensure that the logged-in username are either all in uppercase or all in lowercase. Otherwise, the retrieved conversation list is empty.

```javascript
WebIM.conn.getSessionList().then(res => {
    console.log(res);
    /**
    The return value contains the following information:
    - All the conversation IDs
    - The last message
    - The count of unread messages in the current conversation
    */
});
```

### Retreive historical messages of the specified conversation

Refer to the following code sample for retrieving all the historical messages of the current conversation:

```javascript
var options = {
    // The ID of the peer user, or chat group, or chat room, depending on the chat type.
    // The value of queue must all be in lowercase. If the actual ID contains both uppercase and lowcase letters, change the uppercase letters to lowercase.
    queue: "test1",
    // Whether it is a group conversation.
    isGroup: false,
    // The number of conversations retrieved for each method call.
    count: 10,
    // Occurs when the historical messages are retrieved.
    success: function (res) {
        console.log(res);
    },
    fail: function () {},
};
// Call fetchHistoryMessages to retrieve the historical messages.
WebIM.conn.fetchHistoryMessages(options);
```

## Message receipts

The Agora Chat SDK supports message delivery and read receipt to inform the message sendser that the message is delivered or read.

### Message delivery receipt

When creating the `connection` instance, setting `delivery` in `options` as `true` enables message delivery receipt. When the message arrives, the SDK automatically sends the message delivery receipt and triggers the `onDeliveredMessage` callback on the message sender's client.

Refer to the following sample code to add a listener for message delivery.

```javascript
WebIM.conn.addEventHandler("message", {
    // Occurs when the message is received.
    onReceivedMessage: function (message) {},
    // Occurs when the message is delivered.
    onDeliveredMessage: function (message) {}
});
```

### Message Read receipts

Once the message is read by the receiver, the SDK sends a message read receipt to the message sender.

#### Conversation read receipts

Refer to the following code to implement read receipts for all the messages in the specified conversation:

```javascript
// Send a message in one-to-one chat.
var options = {
     chatType: 'singleChat',
     type: 'channel',
     to: 'username',
}
var msg = WebIM.message.create(options);
WebIM.conn.send(msg);
var options = {
     chatType: 'groupChat',
     type: 'channel',
     to: 'username',
}

// Send a message in group chat.
var msg = WebIM.message.create(options);
WebIM.conn.send(msg);
WebIM.conn.addEventHandler("message", {
  onChannelMessage:function(message){
    ...
  }
})
```

#### Message read receipts

Refer to the following code to implement read receipts for the specified message:

- The message receiver
    
  You can send the message read receipt when entering the conversation:

    ```javascript
    // The message ID that requires a read receipt
    var bodyId = message.id;
    var options = {
        type: "read",
        chatType: "singleChat",
        id: bodyId,
        to: 'from',
    }
    var msg = WebIM.message.create(options);
    conn.send(msg);
    WebIM.conn.addEventHandler("message", {
        // addEventHandler for the message read receipt
        onReadMessage: function(message){
            ...
        }
    })
    ```

#### Group message read receipts

For chat group messages, when the group owner or admin sends a message, they can set whether to require a message read receipt.

<div class="alert note">You need to contact support@agora.io to enable the group message read receipt feature. Once enabled, this feature applies to the chat group owner and chat group admin only.</div>

1. Enable group message read receipt

    ```javascript
    sendGroupReadMsg = () => {
        var options = {
            // The message ID that requires a read receipt.
            id: "message id ",
            // Set the message type.
            type: "read",
            // The message content.
            msg: "message content",
            // The username of the message receiver.
            to: "username",
            // Set the chat type.
            chatType: "groupChat",
        }
        // Create a group read message.
        let msg = WebIM.message.create(options);
        conn.send(msg);
    };
    ```

2. Listen for the group message read receipt

    ```javascript
    // Use onReadMessage to listen for the receipt when the user is online.
    onReadMessage: message => {
        const {mid} = message;
        const msg = {
            id: mid,
        };
        if (message.groupReadCount) {
            // The count of read group messages.
            msg.groupReadCount = message.groupReadCount[message.mid];
        }
    };

    // Use onStatisticMessage to listen for the receipt when the user is offline.
    onStatisticMessage: message => {
        let statisticMsg = message.location && JSON.parse(message.location);
        let groupAck = statisticMsg.group_ack || [];
    };
    ```

    You can also retrieve the users that have read the chat group message.

    ```javascript
    WebIM.conn
        .getGroupMsgReadUser({
            // The message ID.
            msgId,
            // The chat group ID.
            groupId,
        })
        .then(res => {
            console.log(res);
        });
    ```