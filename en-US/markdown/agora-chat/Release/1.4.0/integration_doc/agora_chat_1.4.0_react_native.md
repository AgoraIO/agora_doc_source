# Agora Chat 1.4.0 React Native

## 1. 发送和接收 GIF 图片消息

### 发送 GIF 图片消息

- 自 React Native SDK 1.4.0 开始，支持发送 GIF 图片消息。
- GIF 图片消息是一种特殊的图片消息，与普通图片消息不同，**GIF 图片发送时不能压缩**。
- 图片缩略图的生成与普通图片消息相同，详见 [发送图片消息](#发送图片消息)。

发送 GIF 图片消息的过程如下：

1. 发送方调用 `ChatMessage#createImageMessage` 方法构造 GIF 图片消息体。
2. 发送方调用 `ChatManager#sendMessage` 发送 GIF 图片消息。SDK 会将图片上传至环信服务器，服务器自动生成图片缩略图。

```typescript
const displayName = '<GIF_FILE_DISPLAY_NAME>';
const filePath = '<GIF_FILE_PATH>'; // GIF 文件的本地路径
const targetId = '<TARGET_ID>';
const chatType = ChatMessageChatType.PeerChat;
const message = ChatMessage.createImageMessage(
  targetId,
  filePath,
  chatType,
  { isGif: true, displayName: displayName, width: 100, height: 100 }
);
ChatClient.getInstance().chatManager.sendMessage(message, {
  onError(localMsgId, error) {
    console.log('Send message failed:', localMsgId, error);
  },
  onSuccess() {
    console.log('Send message succeeded');
  },
  onProgress(progress) {
    console.log('Send message progress:', progress);
  },
});
```

### 接收 GIF 图片消息

自 React Native SDK 1.4.0 开始，支持接收 GIF 图片消息。

图片缩略图的下载与普通图片消息相同，详见 [接收图片消息](#接收图片消息)。

与普通消息相同，接收 GIF 图片消息时，接收方会收到 `onMessagesReceived` 事件。接收方判断为图片消息后，读取消息体的 `isGif` 属性，若值是 `true`，则为 GIF 图片消息。

```typescript
ChatClient.getInstance().chatManager.addMessageListener({
  // 重写 onMessagesReceived
  onMessagesReceived(messages) {
    for (let index = 0; index < messages.length; index++) {
      const element = messages[index];
      if (element?.body.type === ChatMessageType.IMAGE) {
        const body = element.body as ChatImageMessageBody;
        // 查看图片是否为 GIF 图片
        if (body.isGif === true) {
          // 下载附件
          ChatClient.getInstance().chatManager.downloadAttachment(element);
        }
      }
    }
  },
});
```

## 2. 管理群组头像

自 SDK 1.4.0 版本开始，创建群组后，群主或管理员可调用 `GroupManager#updateGroupAvatar` 设置或修改群组头像。

```typescript
const groupId = '';
const avatar = '';
ChatClient.getInstance()
  .groupManager.updateGroupAvatar(groupId, avatar)
  .then(() => console.log('update group avatar success'))
  .catch((e) => console.log('update group avatar failed', e));
```

群组头像被修改后，其他群成员会收到 `ChatGroupEventListener#onDetailChanged` 事件。

```typescript
ChatClient.getInstance().groupManager.addGroupListener({
  onDetailChanged(group) {
    console.log('group detail changed: ', group);
  },
});
```

## 3. 创建群组

自 SDK 1.4.0 开始，你可以调用 createGroupEx 方法创建群组，设置群组头像，并通过 `ChatGroupOptions` 参数设置群组名称、群组描述、群组成员和建群原因。

```typescript
// 执行操作
ChatClient.getInstance().groupManager.createGroupEx({
  // 群组选项。核心选项为 `style`，用于设置群组类型。详见 `ChatGroupStyle`。
  options: new ChatGroupOptions({ style: ChatGroupStyle.PrivateOnlyOwnerInvite }),
  // 群组的名称，不能超过 128 个字符
  groupName: '<GROUP_NAME>',
  // 群组描述，不能超过 512 个字符
  desc: '<GROUP_DESC>',
  // 成员列表
  inviteMembers: ['<USER_ID_1>', '<USER_ID_2>'],
  inviteReason: '<INVITE_REASON>',
});
```

## 4. 聊天室成员加入禁言列表事件

```typescript
// 有成员被加入禁言列表。被添加的成员收到该事件。
onMuteListAddedV2(params: {
  roomId: string;
  mutes: Record<string, number>;
}): void {
  console.log(
    'onMuteListAddedV2:',
    params.roomId,
    params.mutes
  );
}
```

## 5. 从服务器获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从服务器获取指定成员（而非全部成员）发送的消息。

```typescript
const conversationId = '<YOUR_CONVERSATION_ID>';
const conversationType = ChatConversationType.GroupChat;
const cursor = '';
const pageSize = 20;
const options = new ChatFetchMessageOptions({
  senders: ['user1', 'user2'],
  direction: ChatSearchDirection.UP,
  startTs: 0,
  endTs: Date.now(),
  needSave: false,
});
ChatClient.getInstance()
  .chatManager.fetchHistoryMessagesByOptions(
    conversationId,
    conversationType,
    { cursor, pageSize, options }
  )
  .then((result) => {
    console.log('Fetched messages:', result.list);
  })
  .catch((error) => {
    console.error('Error fetching messages:', error);
  });
```

## 6. 从本地获取指定群成员发送的消息

自 SDK 1.4.0 开始，你可以调用 `getConvMsgsWithKeyword` 加载本地会话中指定成员发送的消息。

```typescript
const conversationId = '<YOUR_CONVERSATION_ID>';
const conversationType = ChatConversationType.GroupChat;
const senders = ['user1', 'user2'];
ChatClient.getInstance()
  .chatManager.getConvMsgsWithKeyword({
    convId: conversationId,
    convType: conversationType,
    senders: senders,
    keywords: '',
  })
  .then((messages) => console.log('Messages:', messages))
  .catch((error) => console.error('Error:', error));
```

## 7. 根据关键字获取本地会话中的消息

自 SDK 1.4.0 版本开始，你可以调用 `getConvsMsgsWithKeyword` 通过设置关键词获取本地会话中的某些消息。消息 ID 根据你设置的 `direction` 参数按照消息时间戳的正序或倒序列明。

```typescript
const keywords = 'hello';
const timestamp = -1;
const from = '<MESSAGE_SENDER_ID>';
const direction = ChatSearchDirection.UP;
const searchScope = ChatMessageSearchScope.All;
ChatClient.getInstance()
  .chatManager.getConvsMsgsWithKeyword({
    keywords,
    timestamp,
    from,
    direction,
    searchScope,
  })
  .then((result) => console.log('Result:', result))
  .catch((error) => console.error('Error:', error));
```

## 8. 根据消息 ID 获取本地消息

自 SDK 1.4.0 版本开始，你可以调用 `getMessagesWithIds`，传入单个或多个消息 ID 获取单个本地会话中的消息。

```typescript
const conversationId = '<YOUR_CONVERSATION_ID>';
const conversationType = ChatConversationType.GroupChat;
const msgIds = ['<MSG_ID_1>', '<MSG_ID_2>', '<MSG_ID_3>'];
ChatClient.getInstance()
  .chatManager.getMessagesWithIds({
    convId: conversationId,
    convType: conversationType,
    msgIds: msgIds,
  })
  .then((messages) => {
    console.log('Messages:', messages);
  })
  .catch((error) => {
    console.error('Error:', error);
  });
```

## 9. 批量通知群成员进出群

```typescript
// 有新成员加入群组，所有群成员收到该回调
onMembersJoined(params: { groupId: string; members: string[] }): void {
  console.log('onMembersJoined', params);
}

// 有群成员主动退出群，所有群成员收到该回调
onMembersExited(params: { groupId: string; members: string[] }): void {
  console.log('onMembersExited', params);
}
```

## 10. 监控从服务器拉取离线消息的开始和结束

自 SDK 1.4.0 开始，SDK 支持监控从服务器拉取离线消息的开始和结束。

```typescript
ChatClient.getInstance().addConnectionListener({
  // 结束接收离线消息的时候触发。
  onOfflineMessageSyncFinish(): void {
    console.log("onOfflineMessageSyncFinish");
  },
  // 开始接收离线消息的时候触发。
  onOfflineMessageSyncStart(): void {
    console.log("onOfflineMessageSyncStart");
  },
});
```

## 11. 修改消息

对于单聊、群组和聊天室聊天会话中已经发送成功的消息，SDK 支持对这些消息的内容进行修改。若使用该功能，**需联系环信商务开通**。

- SDK 1.4.0 之前的版本仅支持对单聊和群组会话中发送后的文本消息进行修改。
- SDK 1.4.0 及之后版本支持对单聊、群组和聊天室会话中各类消息进行修改：
  - 文本/自定义消息：支持修改消息内容（body）和扩展字段 `attributes`。
  - 文件/视频/音频/图片/位置/合并转发消息：只支持修改消息扩展字段 `attributes`。
  - 命令消息：不支持修改。

示例代码如下：

```typescript
// 文本消息：可同时修改消息体和消息扩展属性
const msgId = '<YOUR_MESSAGE_ID>';
const body = new ChatTextMessageBody({
  content: 'Updated message content',
});
const ext = {
  customKey: 'customValue',
};
ChatClient.getInstance()
  .chatManager.modifyMsgBody({ msgId, body, ext })
  .then((message) => {
    console.log('Message body updated successfully', message);
  })
  .catch((error) => {
    console.error('Error updating message body:', error);
  });

// 自定义消息：可同时修改消息体和消息扩展属性
const customBody = new ChatCustomMessageBody({
  event: '<CUSTOM_EVENT>',
  params: { key1: 'value1', key2: 'value2' },
});
ChatClient.getInstance()
  .chatManager.modifyMsgBody({ msgId, body: customBody })
  .then((message) => {
    console.log('Message body updated successfully', message);
  })
  .catch((error) => {
    console.error('Error updating message body:', error);
  });

// 文件/视频/音频/图片/位置/合并转发消息：只能修改消息扩展属性
ChatClient.getInstance()
  .chatManager.modifyMsgBody({ msgId, ext })
  .then((message) => {
    console.log('Message body updated successfully', message);
  })
  .catch((error) => {
    console.error('Error updating message body:', error);
  });
```

```typescript
ChatClient.getInstance().chatManager.addMessageListener({
  onMessageContentChanged: (
    message: ChatMessage,
    lastModifyOperatorId: string,
    lastModifyTime: number
  ): void => {
    console.log(
      `${QuickTestScreenChat.TAG}: onMessageContentChanged: `,
      JSON.stringify(message),
      lastModifyOperatorId,
      lastModifyTime
    );
  },
} as ChatMessageEventListener);
```

## 12. 撤回消息

- 对于单聊会话，只支持发送方撤回发送成功的消息。若消息过期，撤回失败。
- 对于群组/聊天室会话，普通成员只能撤回自己发送的消息，若消息过期，撤回失败。自 SDK 1.4.0 开始，群主/聊天室所有者和管理员可撤回其他用户发送的消息，即使消息过期也能撤回。



你可以设置消息撤回监听，通过 `onMessagesRecalledInfo` 事件监听发送方对已接收的消息的撤回。

- 若用户在线接收了消息，消息撤回时，该事件中的 `ChatRecalledMessageInfo` 中的 `recallMessage` 为撤回的消息的内容，`recalledMessageId` 属性返回撤回的消息的 ID。
- 若消息发送和撤回时接收方离线，该事件中的 `ChatRecalledMessageInfo` 中的 `recallMessage` 为空，`recalledMessageId` 属性返回撤回的消息的 ID。

```typescript
let listener = new (class implements ChatMessageEventListener {
  onMessagesRecalledInfo(info: Array<ChatRecalledMessageInfo>): void {
    // 消息撤回通知，info 为撤销的消息信息
  }
})();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

## 13. 消息附件下载鉴权

自 1.4.0 版本开始，即时通讯 IM 支持消息附件下载鉴权功能。该功能默认关闭，如要开通，请联系 [technical support](mailto:support@agora.io)。
。该功能开通后，用户必须调用 SDK 的 `downloadAttachment` 方法下载消息附件。

## 14. Token 即将过期回调触发时机变化

你可以通过注册连接监听确认连接状态。自 1.4.0 版本开始，SDK 会在 Token 有效期达到 80% 时触发该回调。

```typescript
ChatClient.getInstance().addConnectionListener({
  // Token 即将过期的通知。
  // 自 1.4.0 版本，SDK 会在 Token 有效期达到 80% 时触发该回调。
  onTokenWillExpire(): void {
    console.log("onTokenWillExpire");
  },
});
```

15. 从服务端获取群组信息

自 SDK 1.4.0 开始，你可以调用 `fetchGroupInfoFromServer` 方法从服务器获取群组详情，不包含群成员列表。返回的结果包括群组 ID、群组名称、群组头像 URL、群组描述、群组创建者/所有者的用户 ID、群组公告内容、群组成员总数、群组消息是否被屏蔽（`true`：屏蔽，`false`：未屏蔽）、是否禁言所有成员（`true`：是，`false`：否）、当前用户在群组中的角色（`Owner`/`Admin`/`Member`/`None`）、群组选项配置、群组允许的最大成员数。  
    
```typescript  
const groupId = '<YOUR_GROUP_ID>';
try {
const groupInfo = await ChatClient.getInstance()
.groupManager.fetchGroupInfoFromServer(groupId, false);
// false 表示不获取成员列表
console.log("Group name:", groupInfo.groupName);
console.log("Group owner:", groupInfo.owner);
} catch (error) {
console.error("Fetch group info failed:", error);
}
```

## 16. 群成员列表包含群成员的用户 ID、加群时间和成员角色

自 1.4.0 版本开始，你可调用 `fetchMemberInfoListFromServer` 方法获取全部群成员（包括群主和群管理员）的信息，包括群成员的用户 ID、加群时间和成员角色。

```typescript
const groupId = '<YOUR_GROUP_ID>';
const cursor = ''; // 开始分页的位置，第一页为空，后续页面请使用第一页返回的结果
const limit = 200; // 每页期望返回的群成员数量，上限取决于服务端，详见 https://docs.agora.io/en/agora-chat/restful-api/chat-group-management/manage-group-members#retrieving-group-members。
ChatClient.getInstance()
  .groupManager.fetchMemberInfoListFromServer(groupId, cursor, limit)
  .then((result) => {
    console.log('Fetch member info list result:', result);
  })
  .catch((error) => {
    console.error('Error fetching member info list:', error);
  });

```
