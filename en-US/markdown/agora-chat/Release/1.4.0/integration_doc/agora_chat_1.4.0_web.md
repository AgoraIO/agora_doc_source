# Agora Chat 1.4.0 Web

## 1. 发送和接收 GIF 图片消息

### 发送 GIF 图片消息

- 自 SDK 1.4.0 开始，支持发送 GIF 图片消息。
- GIF 图片消息是一种特殊的图片消息，在发送图片消息时可以指定是否是 GIF 图片。
- GIF 图片缩略图的生成与普通图片消息相同，详见 [发送图片消息](#发送图片消息)。

发送 GIF 图片消息过程如下：

1. 构造消息，设置 `isGif` 为 `true`。
2. 调用 `send` 方法发送消息。

```javascript
sendGIFMsg(){
    const file = WebIM.utils.getFileUrl(imgInput as HTMLInputElement);
    let option = {
      chatType: "singleChat",
      type: "img",
      to: "userId",
      file: file,
      isGif: file.data.type === "image/gif", // 设置是否是为GIF图片
    };
    let msg = WebIM.message.create(option);
    conn.send(msg);
}
```

### 接收 GIF 图片消息

自 SDK 1.4.0 开始，支持接收 GIF 图片消息。

与普通消息相同，接收 GIF 图片消息时，接收方会收到 `onImageMessage` 回调方法。接收方收到消息后，读取消息体的 `isGif` 属性，若值是 `true`， 则为 GIF 图片消息。

```javascript
onImageMessage: (message) => {
    if(message.isGif){
        // 图片为GIF
    }
}
```

## 2. 管理群组头像

自 SDK 4.14.0 开始，支持群组头像功能。

#### 设置群组头像

- 创建群组时，可设置群组头像：

```javascript
conn.createGroupVNext({
    groupName: 'groupname',
    avatar: 'group avatar', // 群组头像 URL
    members: ['user1', 'user2']
})
```

- 创建群组后，若设置群组头像，可调用 [修改群组头像](#修改群组头像) API 设置头像。

#### 修改群组头像

创建群组完成后，群主或管理员可调用 `modifyGroup` 设置或修改群组头像：

```javascript
conn.modifyGroup({
    groupId: 'groupId',
    avatar: 'group avatar url'
})
```

群头像被修改后，其他群成员会收到 `onGroupEvent#updateInfo` 回调：

```javascript
conn.addEventHandler("eventName", {
    onGroupEvent: function (msg) {
        switch (msg.operation) {
            case 'updateInfo':
                console.log(msg)
                break;
        }
    }
})  

```

#### 获取群组头像

群成员可以通过获取群详情的方法，获取群组头像：

```javascript
conn.getGroupInfo({
    groupId: 'groupId'
})
.then((res) => {
    console.log(res)
})
```

## 3. 从服务器获取指定群成员发送的消息

你已经在下面的示例代码中已经添加了 searchOptions。只需要添加一句描述：自 1.4.0 版本开始，对于单个群组会话，你可以从服务器获取单个成员发送的消息。

https://docs.agora.io/en/agora-chat/client-api/messages/retrieve-messages?platform=web#retrieve-message-history-of-the-specified-conversation

## 4. 批量通知群成员进出群

1. 请在 Chat Web 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=web#listen-for-chat-group-events)  的 "Listen for chat group events" 中添加如下事件和说明（注意事件说明有变化，明确了单个和多个）。

```javascript
// 群成员（单个）退群。除退群成员外，其他群成员会收到该回调。
case "memberAbsence":
break;
// 群成员（单个或多个）退群。除退群成员外，其他群成员会收到该回调。
case "membersAbsence":
break;
// 用户（单个）加群。除新成员外，其他群成员会收到该回调。
case "memberPresence":
break;
// 用户（单个或多个）加群。除新成员外，其他群成员会收到该回调。
case "membersPresence":
break; 
```

2. 此外，请在 Chat Android 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=web) 中搜索 `memberAbsence` 和 `memberPresence` 事件，用新事件 `membersAbsence` 和 `membersPresence` 进行替换。
3. 
## 5. 新的创建群组的方法

调用 `createGroupVNext` 方法新建群组，设置群组参数。

群组分为私有群和公开群。私有群无法搜索到，公开群可通过群 ID 搜索到。

创建群组时，需设置以下参数：

| 参数                | 类型   | 描述          |
| :------------- | :----- | :--------------------------------------------- |
| `groupName` | String | 群组名称。 |
| `avatar` | String | 群组头像。 |
| `description` | String | 群组描述。 |
| `members` | `Array<string>` | 群成员的用户 ID 组成的数组，不包含群主的用户 ID。 |
| `isPublic` | Boolean | 是否为公开群：<br/> - `true`：是；<br/> - `false`：否。该群组为私有群。 |
| `needApprovalToJoin` | Boolean | 入群申请是否需群主或管理员审批：<br/> - `true`：需要；<br/> - `false`：不需要。<br/>由于私有群不支持用户申请入群，只能通过邀请方式进群，因此该参数仅对公开群有效，即 `isPublic` 设置为 `true` 时，对私有群无效。 |
| `allowMemberToInvite` | Boolean | 是否允许普通群成员邀请人入群：<br/> - `true`：允许；<br/> - `false`：不允许。只有群主和管理员才可以向群组添加用户。<br/>该参数仅对私有群有效，即 `isPublic` 设置为 `false` 时， 因为公开群（isPublic：`true`）仅支持群主和群管理员邀请人入群，不支持普通群成员邀请人入群。 |
| `inviteNeedConfirm` | Boolean | 邀请加群时是否需要受邀用户确认：<br/> - `true`：受邀用户需同意才会加入群组；<br/> - `false`：受邀用户直接加入群组，无需确认。 |
| `maxMemberCount` | Int | 群组最大成员数，默认为 `200`。不同套餐支持的人数上限不同，详见  [IM 套餐包功能详情](https://docs.agora.io/en/agora-chat/reference/pricing-plan-details#group)。 |
| `extension` | string | 群组扩展信息，例如可以给群组添加业务相关的标记，不要超过 8 KB。|


创建群组的示例代码如下：

```javascript
conn.createGroupVNext({
    groupName: 'groupname',
    avatar: 'group avatar',
    description: 'this is my group',
    members: ['user1', 'user2'],
    isPublic: true,
    needApprovalToJoin: false,
    allowMemberToInvite: true,
    inviteNeedConfirm: false,
    maxMemberCount: 200,
    extension: JSON.stringify({info: 'group info'})
})
.then((res) => {
    console.log(res)
})
```

// Notes：原创建群组方法 createGroup 方法废弃，使用 createGroupVNext 方法代替。在 Web 端所有文档中搜索createGroup，替换为 createGroupVNext 方法。

## 6. 修改消息

对于单聊、群组和聊天室聊天会话中已经发送成功的消息，SDK 支持对这些消息的内容进行修改。

- SDK 1.4.0 之前的版本仅支持对单聊和群组会话中发送后的文本消息进行修改。
- SDK 1.4.0 及之后版本支持对单聊、群组和聊天室会话中各类消息进行修改：
  - 文本/自定义消息：支持修改消息内容（body）和扩展字段 `ext`。
  - 文件/视频/音频/图片/位置/合并转发消息：只支持修改消息扩展字段 `ext`。
  - 命令消息：不支持修改。

```javascript
// 注册修改消息事件
conn.addEventHandler("modifiedMessage", {
    onModifiedMessage: message => {
        console.log('onModifiedMessage', message)
    },
});


// 修改文本消息只支持修改 `msg` 和 `ext` 字段
const textMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'txt',
  to: 'to',
  msg: 'message content',
  ext: { key: 'new value' }
})

// 自定义消息支持修改 `customEvent`、`customExts` 和 `ext` 字段
const customMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'custom',
  to: 'to',
  customEvent: 'new event',
  customExts: { key: 'new value' },
  ext: { key: 'new value' }
})

// 图片/语音/视频/文件/位置/合并消息只支持修改 `ext` 字段
const imageMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'img',
  url: 'origin message url',
  to: 'to',
  ext: { key: 'new value' }
})

const videoMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'video',
  to: 'to',
  body: {
    url: 'origin message url'
  },
  ext: { key: 'new value' }
})

const fileMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'file',
  to: 'to',
  body: {
    url: 'origin message url'
  },
  ext: { key: 'new value' }
})

const audioMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'audio',
  to: 'to',
  body: {
    url: 'origin message url'
  },
  ext: { key: 'new value' }
})

const combineMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'combine',
  to: 'to',
  compatibleText: 'origin message compatibleText',
  title: 'origin message title',
  summary: 'origin message summary',
  messageList: [],
  ext: { key: 'new value' }
})

const locationMessage = WebIM.message.create({
  chatType: 'singleChat',
  type: 'loc',
  to: 'to',
  addr: 'origin message addr',
  buildingName: 'origin message buildingName',
  lat: 'origin message lat',
  lng: 'origin message lng',
  ext: { key: 'new value' }
})

conn
  .modifyMessage({
    messageId: 'origin message id',
    modifiedMessage: textMessage
  })
  .then((res) => {
    console.log('modify msg success', res.modifiedInfo)
  })
  .catch((e) => {
    console.log('modify failed', e)
  })
```

## 7. 撤回消息

- 对于单聊会话，只支持发送方撤回发送成功的消息。若消息过期，撤回失败。
- 对于群组/聊天室会话，普通成员只能撤回自己发送的消息，若消息过期，撤回失败。自 SDK 1.4.0 开始，群主/聊天室所有者和管理员可撤回其他用户发送的消息，即使消息过期也能撤回。

## 8. Token 即将过期回调触发时机变化

```javascript
conn.addEventHandler("connectionListener", {
  // 自 1.4.0 版本，SDK 会在 Token 有效期达到 80% 时回调即将过期通知（之前版本为 50%）。
  onTokenWillExpire: () => {
    console.log("token 即将过期");
  },
});
```

## 9. 群成员列表和聊天室成员列表包含群成员的加群时间和成员角色

自 SDK 1.4.0 开始，所有群成员均可调用 `getGroupMembers` 方法获取全部群成员（包括群主和群管理员）的信息，包括用户 ID、用户角色和加入时间。原方法 `listGroupMembers` 废弃。

```javascript
conn
// limit：每页期望返回的群成员数量，默认值为 50，上限取决于服务端，详见 https://docs.agora.io/en/agora-chat/restful-api/chat-group-management/manage-group-members#retrieving-group-members。
// cursor：开始获取数据的游标位置。首次调用方法时传 `null` 、空字符串（''）或不传该字段。后续调用传入上一次查询结果的游标 res.data.cursor，若 cursor 的值为空字符串（''），表示当前为最后一页数据。
  .getGroupMembers({ cursor: "", limit: 50, groupId: "groupId" })
  .then((res) => {
    console.log(res);
  });
```

自 SDK 1.4.0 开始，聊天室所有成员均可调用 `getChatRoomMembers`方法获取聊天室成员信息，包括用户 ID、用户角色和加入时间。服务器不对成员进行排序，因此，返回的成员列表不保证有序。原方法 `listChatRoomMembers` 废弃。

```javascript
conn
// limit：每页期望返回的聊天室成员数量，默认值为 50，上限取决于服务端，详见 https://docs.agora.io/en/agora-chat/restful-api/chatroom-management/manage-chatroom-members#retrieving--members-with-pagination
  .getChatRoomMembers({ cursor: "", limit: 50, chatRoomId: "chatRoomId" })
  .then((res) => {
    console.log(res);
  });
```

// Note: 获取群组成员列表的原方法 listGroupMembers 废弃。使用 getGroupMembers 代替。在相关文档中查找替换。
// Note: 获取聊天室成员列表的原方法 listChatRoomMembers 废弃。使用 getChatRoomMembers 代替。在相关文档中查找替换。

