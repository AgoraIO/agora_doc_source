1. Clear all conversations and messages in them

`AgoraChatManager#deleteAllMessagesAndConversations:completion:`

```Swift
AgoraChatClient.shared().chatManager?.deleteAllMessagesAndConversations(true, completion: { err in
    if err == nil {
        // Succeeded in deleting conversations and messages in them.
    }
})
```

2. Search for messages by search scope

`AgoraChatManager#loadMessagesWithKeyword:timestamp:count:fromUser:searchDirection:scope:completion:`

```Swift
AgoraChatClient.shared().chatManager?.loadMessages(withKeyword: "keyword", timestamp: Int64((Date().timeIntervalSince1970 * 1000)), count: 100, fromUser: "", searchDirection: .up, scope: .content, completion: { messages, err in
    if err == nil {
        // Successfully retrieved messages.
    }
})
```

3. Mark a conversation

a. `AgoraChatManager#addConversationMark:completion`

```Swift
AgoraChatClient.shared().chatManager?.addConversationMark(["conversationId"], mark: .type0, completion: { err in
    if err == nil {
        // Succeeded in marking conversations.
    }
})
```

b. `AgoraChatManager#removeConversationMark:completion`

```Swift
AgoraChatClient.shared().chatManager?.removeConversationMark(["conversationId"], mark: .type0, completion: { err in
    if err == nil {
        // Succeeded in unmarking conversations. 
    }
})
```

c. `AgoraChatManager#getConversationsFromServerWithCursor:filter:completion`

```Swift
AgoraChatClient.shared().chatManager?.getConversationsFromServer(withCursor: "", filter: AgoraChatConversationFilter(mark: .type0, pageSize: 20), completion: { conversations, err in
    if err == nil {
        // Successfully retrieved conversations by mark.
    }
})
```

d. Gets local conversations by conversation mark

```Swift
let markType: AgoraChatMarkType = .type0
let marked0Conversations = AgoraChatClient.shared().chatManager?.getAllConversations()?.filter { $0.marks.contains(NSNumber(value: markType.rawValue))
}
```

e. `AgoraChatConversation#marks`

```Swift
if let conversation = AgoraChatClient.shared().chatManager?.getConversationWithConvId("conversationId") {
    let marks = conversation.marks
}
```

4. Set whether the message is delivered only when the recipient(s) is/are online.

`AgoraChatMessage#deliverOnlineOnly` 

```Swift
let textMessage = AgoraChatMessage(conversationId: "conversationId", body: .text(content: "hello"), ext: nil)
// Set whether the message is delivered only when the recipient(s) is/are online.
textMessage.deliverOnlineOnly = true
AgoraChatClient.shared().chatManager?.send(textMessage, progress: nil, completion: { message, err in
    if err == nil {
        // Succeeded in sending the message.
    }
})
```

5. Allow the current user to retrieve the total number of joined groups

`AgoraChatGroupManager#getJoinedGroupsCountFromServerWithCompletion`

```Swift
AgoraChatClient.shared().groupManager?.getJoinedGroupsCountFromServer(completion: { count, err in
    if err == nil {
        // Successfully getting the count of joined groups.
    }
})
```

6. Pin a message

`AgoraChatManager#pinMessage:completion:`

```Swift
AgoraChatClient.shared().chatManager?.pinMessage("messageId", completion: { message, err in
    if err == nil {
        // Succeeded in pinning messages.
     }
})
```

`AgoraChatManager#unpinMessage:completion:`

```Swift
AgoraChatClient.shared().chatManager?.unpinMessage("messageId", completion: { message, err in
    if err == nil {
        // Succeeded in unpinning messages.
    }
})
```

`AgoraChatManager#getPinnedMessagesFromServer:completion:`

```Swift
AgoraChatClient.shared().chatManager?.getPinnedMessages(fromServer: "conversationId", completion: { pinnedMessages, err in
    if err == nil {
        // Succeeded in getting pinned messages from the server.
    }
})
```

`AgoraChatConversation#pinnedMessages`: Gets the list of pinned messages in a local conversation.

```Swift
if let conversation = AgoraChatClient.shared().chatManager?.getConversationWithConvId("conversationId") {
    let pinnedMessages = conversation.pinnedMessages()
}
```

`AgoraChatMessagePinInfo`: Gets pinning details of a message.

```Swift
if let message = AgoraChatClient.shared().chatManager?.getMessageWithMessageId("messageId") {
    let pinnedInfo = message.pinnedInfo
}
```

`AgoraChatManagerDelegate#onMessagePinChanged`

```Swift
// Add a delegate.
AgoraChatClient.shared().chatManager?.add(self, delegateQueue: nil)

// Occurs when the message pinning state is changed. 
func onMessagePinChanged(_ messageId: String, conversationId: String, operation pinOperation: AgoraChatMessagePinOperation, pinInfo: AgoraChatMessagePinInfo) {

}
```

7. Marks all conversations read

`AgoraChatManager#markAllConversationsAsRead`

```Swift
AgoraChatClient.shared().chatManager?.markAllConversationsAsRead()
```

8. `AgoraChatGroupManagerDelegate#joinGroupRequestDidDecline:reason:decliner:applicant:`

```swift
func joinGroupRequestDidDecline(_ aGroupId: String, reason aReason: String?, decliner aDecliner: String?, applicant aApplicant: String) {
        
}
```    

9. Forward a single message 

```swift
// messageId: The ID of the message to be forwarded.
if let message = AgoraChatClient.shared().chatManager?.getMessageWithMessageId("messageId") {
    // Create a new message with the body and extension fields of the original message.
    let newMessage = AgoraChatMessage(conversationID: "conversationId", body: message.body, ext: message.ext)
    AgoraChatClient.shared().chatManager?.send(newMessage, progress: nil, completion: { messageResult, err in
        if err == nil {
            // Succeeded in forwarding the message.
        }
    })
}
```

I provide the Easemob IM Doc here for your reference:

https://doc.easemob.com/document/ios/message_forward.html


10. Search for `agoraToken` in the quick start and replace it with `token`, as `agoraToken` is deprecated. In other words, you need to replace `agoraToken` in the following line with `token`:

```
let result: AgoraChatError? = agoraChatClient.login(withUsername: userId, agoraToken: token)
```

11. Chatroom: member count callback

### Update the chat room member count in real time

If many members join or leave a chat room in a very short time, you can update the chat room member count in real time:

1. When a user joins a chat room, other members in the chat room receive the `userDidJoinChatroom:user:` event. When a member leaves or is removed from a chat room, other members in the chat room receive the `userDidLeaveChatroom:user:` event.

2. After the event is received, you can call the `occupantsCount` method to get the current number of members in the chat room.

```Swift
extension ViewController: AgoraChatroomManagerDelegate {
  func userDidJoin(_ aChatroom: AgoraChatroom, user aUsername: String) {
    let memberCount = aChatroom.occupantsCount
  }
  func userDidLeave(_ aChatroom: AgoraChatroom, user aUsername: String) {
    let memberCount = aChatroom.occupantsCount
  }
}

AgoraChatClient.shared().roomManager?.add(self, delegateQueue: nil)
```

Above is my English translation. 

Following is the Chinese version of the Agora Chat doc for your reference. 

### 实时更新聊天室成员人数

如果聊天室短时间内有成员频繁加入或退出时，实时更新聊天室成员人数的逻辑如下：

1. 聊天室内有成员加入时，其他成员会收到 `userDidJoinChatroom:user:` 事件。有成员主动或被动退出时，其他成员会收到 `userDidLeaveChatroom:user:`  事件。

2. 收到通知事件后，通过 `AgoraChatroom#occupantsCount` 获取聊天室当前人数。

```Swift
extension ViewController: AgoraChatroomManagerDelegate {
  func userDidJoin(_ aChatroom: AgoraChatroom, user aUsername: String) {
    let memberCount = aChatroom.occupantsCount
  }
  func userDidLeave(_ aChatroom: AgoraChatroom, user aUsername: String) {
    let memberCount = aChatroom.occupantsCount
  }
}

AgoraChatClient.shared().roomManager?.add(self, delegateQueue: nil)
```






