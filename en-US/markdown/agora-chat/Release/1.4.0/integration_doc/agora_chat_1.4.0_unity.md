# Agora Chat 1.4.0 Unity/Windows

## 1. 发送和接收 GIF 图片消息

### 发送 GIF 图片消息

- 自 SDK 1.4.0 开始，支持发送 GIF 图片消息。
- GIF 图片消息是一种特殊的图片消息，与普通图片消息不同，**GIF 图片发送时不能压缩**。
- 图片缩略图的生成与普通图片消息相同，详见 [发送图片消息](#发送图片消息)。

发送 GIF 图片消息的过程如下：

1. 发送方调用 `Message#CreateImageSendMessage` 方法构造 GIF 图片消息体。
2. 发送方调用 `ChatManager#SendMessage` 发送 GIF 图片消息。SDK 会将图片上传至环信服务器，服务器自动生成图片缩略图。

```csharp
Message msg = Message.CreateImageSendMessage("to", "filepath");

// 设置 ImageBody 的 isGif 属性为 true
ImageBody imageBody = (ImageBody)msg.Body;
imageBody.isGif = true;

SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
    onSuccess: () =>
    {

    },
    onProgress: (progress) =>
    {

    },
    onError: (code, desc) =>
    {

    }
));
```

### 接收 GIF 图片消息

自 SDK 1.4.0 开始，支持接收 GIF 图片消息。

图片缩略图的下载与普通图片消息相同，详见 [接收图片消息](#接收图片消息)。

与普通消息相同，接收 GIF 图片消息时，接收方会收到 `OnMessagesReceived` 回调方法。接收方判断为图片消息后，读取消息体的 `isGif` 属性，若值是 `true`，则为 GIF 图片消息。

```csharp
public void OnMessagesReceived(List<Message> messages)
{
    foreach (var msg in messages)
    {
        if (msg.Body is ImageBody imageBody)
        {
            if (imageBody.isGif == true) {
                // 根据业务情况处理 gif message, 例如下载展示该消息
            }
        }
    }

}
```

## 2. 管理群组头像

自 SDK 1.4.0 开始，支持群组头像功能。

### 设置群组头像

- 创建群组时，可通过 `avatar` 参数设置群组头像：

```csharp
GroupOptions options = new GroupOptions(GroupStyle.PublicOpenJoin);

List<string> inviteMembers = new List<string>();
inviteMembers.Add("member1");

SDKClient.Instance.GroupManager.CreateGroup(name, options, avatar, desc, inviteMembers, inviteReason, new ValueCallBack<Group>(
      onSuccess: (group) =>
       {
        },
       onError: (code, error) =>
        {
        }
));
```

- 创建群组后，若设置群组头像，可调用 [修改群组头像](#修改群组头像) API 设置头像。

### 修改群组头像

创建群组完成后，群主或管理员可调用 `GroupManager#UpdateGroupAvatar` 设置或修改群组头像：

```csharp
SDKClient.Instance.GroupManager.UpdateGroupAvatar(currentGroupId, "newAvatar", new CallBack(
     onSuccess: () =>
      {
      },
     onError: (code, desc) =>
       {
       }
 ));
```

群组头像被修改后，其他群成员会收到 `IGroupManagerDelegate#OnSpecificationChangedFromGroup` 回调：

```csharp
// 实现监听器以及定义监听器对象
// 在本例中，用户 A 为当前用户。
public class GroupManagerDelegate : IGroupManagerDelegate {
     public void OnSpecificationChangedFromGroup(Group group)
    {

    }
    // other functions
}

// 注册群组回调。
GroupManagerDelegate adelegate = new GroupManagerDelegate();
SDKClient.Instance.GroupManager.AddGroupManagerDelegate(adelegate);

// 移除群组回调。
SDKClient.Instance.GroupManager.RemoveGroupManagerDelegate(adelegate);
```

### 获取群组头像

群成员可以通过获取群详情的方法 `GroupManager#GetGroupSpecificationFromServer`，获取群组头像：

```csharp
SDKClient.Instance.GroupManager.GetGroupSpecificationFromServer(currentGroupId, new ValueCallBack<Group>(
    onSuccess: (group) =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

## 3. 聊天室成员加入禁言列表事件

```csharp
// 禁言指定成员。被禁言的成员会收到该事件。
void OnMuteListAddedFromRoom(string roomId, List<string> mutes, long expireTime);
```

## 4. 从服务器获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从服务器获取指定成员（而非全部成员）发送的消息。

```csharp
  FetchServerMessagesOption option = new FetchServerMessagesOption();
  // 消息搜索方向。`UP` 表示按消息时间戳递减的方向获取，即先获取最新消息；`DOWN` 表示按消息时间戳递增的方向获取，即先获取最老的消息。
  option.Direction = MessageSearchDirection.UP;
  //消息发送方的用户 ID, 仅用于群组消息，即当 `FetchHistoryMessagesFromServerBy` 中的 `type` 为 `ConversationType.Group` 时使用。
  option.FromIds = new List();
  option.FromIds.Add("id1");
  option.FromIds.Add("id2");
  // 要获取的消息类型的数组。若不传值，会获取所有类型的消息。
  option.MsgTypes = new List<MessageBodyType>() { MessageBodyType.TXT };
  // 查询的起始时间戳，单位为毫秒。
  option.StartTime = 1709284487000;
  // 查询的结束时间戳，单位为毫秒。
  option.EndTime = 1709284499000;
  // conversationId 单聊为对端用户 ID，群组聊天为群组 ID，聊天室聊天为聊天室 ID。
  // type: 会话类型：单聊和群组聊天分别为 `Chat`, `Group`, `Room`。
  // cursor: 查询的起始消息 ID。若该参数设置为空字符串，从最新消息开始。
  // pageSize: 每页期望获取的消息条数。取值范围为 [1,50]，默认值为 10。
  // option: `FetchServerMessagesOption` 类型的查找选项。
  SDKClient.Instance.ChatManager.FetchHistoryMessagesFromServerBy(conversationId, type:ConversationType.Group, cursor:"", pageSize:10, option, new ValueCallBack<CursorResult<Message>>(
      onSuccess: (result) =>
      {
          if (0 == result.Data.Count)
          {
              return;
          }
          foreach (var msg in result.Data)
          {
              //process every msg
          }
      },
      onError: (code, desc) =>
      {
      }
  ));
```

// Notes：用上面的示例代码替换该地址的示例代码：https://docs.agora.io/en/agora-chat/client-api/messages/retrieve-messages?platform=unity#retrieve-message-history-of-the-specified-conversation

## 5. 从本地获取指定群成员发送的消息

自 SDK 1.4.0 版本开始，对于单个群组会话，你可以从本地获取指定成员（而非全部成员）发送的消息。

```csharp
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
conv.LoadMessagesWithScopeAndFromIds(keyword, timestamp, maxCount, fromIds, direction, scope, new ValueCallBack<List>(
    onSuccess: (list) =>
    {

    },
    onError: (code, desc) =>
    {

    }
));
```

## 6. 根据关键字获取本地会话中的消息

自 SDK 1.4.0 版本开始，你可以调用 `LoadConversationMessagesWithKeyword` 通过设置关键词获取本地会话中的某些消息。消息 ID 根据你设置的 `direction` 参数按照消息时间戳的正序或倒序列明。

```csharp
SDKClient.Instance.ChatManager.LoadConversationMessagesWithKeyword(keywords, timestamp, from, direction, scope, new ValueCallBack<Dictionary<string, List<string>>>(
                onSuccess: (result) =>
                {

                },
                onError: (code, desc) =>
                {
                }
            ));
```

## 7. 根据消息 ID 获取本地消息

自 SDK 1.4.0 版本开始，你可以调用 `LoadMessages`，传入单个或多个消息 ID 获取单个本地会话中的消息。

```csharp
// 创建消息ID列表
List<string> messageIdList = new List<string>();
messageIdList.Add("msgId1");
messageIdList.Add("msgId2");

SDKClient.Instance.ChatManager.LoadMessages(messageIdList, conversationId, new ValueCallBack<List<Message>>(
    onSuccess: (messages) =>
    {

    },
    onError: (code, desc) =>
    {

    }
));
```

## 8. 批量通知群成员进出群

1. 请在 Chat Unity 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform= unity#listen-for-chat-group-events)  的 "Listen for chat group events" 中添加进出群组的新事件，并移掉旧事件。

```csharp
// 有新成员加入群组。除了新成员，其他群成员会收到该回调。
public void OnMembersJoinedFromGroup(string groupId, string member)
{
}

// 群成员主动退出群组。除了退群的成员，其他群成员会收到该回调。
public void OnMembersExitedFromGroup(string groupId, string member)
{
}
```

2. 此外，请在 Chat Unity 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=unity) 中搜索所有的旧事件，用新事件进行替换。

## 9. 修改消息

对于单聊、群组和聊天室聊天会话中已经发送成功的消息，SDK 支持对这些消息的内容进行修改。

- SDK 1.4.0 之前的版本仅支持对单聊和群组会话中发送后的文本消息进行修改。
- SDK 1.4.0 及之后版本支持对单聊、群组和聊天室会话中各类消息进行修改：
  - 文本/自定义消息：支持修改消息内容（body）和扩展字段 `ext`。
  - 文件/视频/音频/图片/位置/合并转发消息：只支持修改消息扩展字段 `ext`。
  - 命令消息：不支持修改。

示例代码如下：

```csharp
// 文本消息：可同时修改消息体和消息扩展属性
TextBody textBody = new TextBody("new content");
Dictionary<string, AttributeValue> attributes = new Dictionary<string, AttributeValue>();
attributes["newkey"] = AttributeValue.Of("new value", AttributeValueType.STRING);

SDKClient.Instance.ChatManager.ModifyMessage("msgId", textBody, attributes, new ValueCallBack<Message>(
    onSuccess: (msg) =>
    {
        // 修改成功
    },
    onError: (code, desc) =>
    {
        // 修改失败
    }
));

// 自定义消息：可同时修改消息体和消息扩展属性
CustomMessageBody customBody = new CustomMessageBody("new action");
Dictionary<string, AttributeValue> attributes = new Dictionary<string, AttributeValue>();
attributes["newkey1"] = AttributeValue.Of("newvalue1", AttributeValueType.STRING);
attributes["newkey2"] = AttributeValue.Of(123, AttributeValueType.INT32);

SDKClient.Instance.ChatManager.ModifyMessage("msgId", customBody, attributes, new ValueCallBack<Message>(
    onSuccess: (msg) =>
    {
        // 修改成功
    },
    onError: (code, desc) =>
    {
        // 修改失败
    }
));


// 文件/视频/音频/图片/位置/合并转发消息：只能修改消息扩展属性
Dictionary<string, AttributeValue> attributes = new Dictionary<string, AttributeValue>();
attributes["newkey1"] = AttributeValue.Of(false, AttributeValueType.BOOL);
attributes["newkey2"] = AttributeValue.Of("new value", AttributeValueType.STRING);

SDKClient.Instance.ChatManager.ModifyMessage("msgId", null, attributes, new ValueCallBack<Message>(
    onSuccess: (msg) =>
    {
        // 修改成功
    },
    onError: (code, desc) =>
    {
        // 修改失败
    }
));
```

## 10. 撤回消息

- 对于单聊会话，只支持发送方撤回发送成功的消息。若消息过期，撤回失败。
- 对于群组/聊天室会话，普通成员只能撤回自己发送的消息，若消息过期，撤回失败。自 SDK 1.4.0 开始，群主/聊天室所有者和管理员可撤回其他用户发送的消息，即使消息过期也能撤回。

## 11. Token 即将过期回调触发时机变化

你可以在登录相关流程中注册连接监听。自 1.4.0 版本开始，SDK 会在 Token 有效期达到 80% 时回调即将过期通知。

```csharp
class ConnectionDelegate : IConnectionDelegate
{
    // Token 即将过期的通知。
    // 自 1.4.0 版本，SDK 会在 Token 有效期达到 80%（之前版本为 50%）时触发该回调。
    public void OnTokenWillExpire()
    {
    }
}
```

## 12. 群成员列表包含群成员的用户 ID、加群时间和成员角色

自 SDK 1.4.0 版本开始，群成员可以调用 `FetchGroupMemberInfoFromServer` 方法从服务器获取全部群成员（包括群主和群管理员）的信息，包括群成员的用户 ID、加群时间和成员角色。

```csharp
//pageSize：每页期望返回的群成员数量，上限取决于服务端，详见 https://docs.agora.io/en/agora-chat/restful-api/chat-group-management/manage-group-members#retrieving-group-members。
SDKClient.Instance.GroupManager.FetchGroupMemberInfoFromServer(currentGroupId, cursor, pageSize, new ValueCallBack<CursorResult<GroupMemberInfo>>(
       onSuccess: (result) =>
        {

        },
        onError: (code, error) =>
       {

       }
));
```

