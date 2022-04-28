聊天室是支持多人加入的类似 Twitch 的组织。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员在离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建聊天室并管理聊天室和聊天室成员。

## 技术原理

Agora Chat SDK 支持你通过调用 API 在项目中实现如下功能：
- 创建、解散聊天室
- 加入、退出聊天室
- 从服务器获取聊天室
- 管理聊天室成员
- 管理聊天室属性和聊天室公告

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_web)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_web)。
- 了解聊天室数量限制。详见[套餐包详情](agora_chat_plan)。
- 只有超级管理员才有创建聊天室的权限，因此你还需要确保已调用[超级管理员 RESTful API](agora_chat_restful_chatroom_superadmin) 添加了超级管理员。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散聊天室

[超级管理员](agora_chat_restful_chatroom_superadmin)可以调用 `createChatRoom` 方法创建聊天室，并设置聊天室的主题、描述、最大人数等信息。成功创建聊天室后，该超级管理员就是该聊天室的所有者。

```javascript
// 超级管理员调用 createChatRoom 创建聊天室。成功创建聊天室后，该超级管理员成为聊天室所有者
let options = {
    name: 'chatRoomName', // 聊天室名称
    description: 'description', // 聊天室描述
    maxusers: 200, // 聊天室成员最大数（包括聊天室创建者），默认值 200，聊天室人数最大默认 5,000。
    members: ['user1', 'user2'] // 聊天室成员，此属性为可选的，但是如果加了此项，数组元素至少一个
}
conn.createChatRoom(options).then(res => console.log(res))

// 只有聊天室所有者才能调用 destroyChatRoom 解散聊天室
let option = {
    chatRoomId: 'chatRoomId'
}
conn.destroyChatRoom(option).then(res => console.log(res))
```

### 获取聊天室列表及信息

你可以从服务器获取指定数目的聊天室列表，并通过指定聊天室 ID 获取指定聊天室的基本信息。

示例代码如下：

```javascript
// 聊天室成员调用 getChatRooms 从服务器获取指定数目的聊天室列表。其中 pageSize 的最大值为 1,000
let option = {
    pagenum: 1,
    pagesize: 20
};
conn.getChatRooms(option).then(res => console.log(res))
														
// 聊天室成员调用 getChatRoomDetails 并指定聊天室 ID 开获取指定聊天室的基本信息
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))
```

### 加入和退出聊天室

所以用户都可以通过调用 `joinChatRoom` 加入指定聊天室。示例代码如下：

```javascript
// 成功加入聊天室后，聊天室其他成员会收到 memberJoinChatRoomSuccess 事件
let option = {
    roomId: 'roomId',
    message: 'reason'
}
conn.joinChatRoom(option).then(res => console.log(res))

// 聊天室所有成员都可以调用 quitChatRoom 离开指定聊天室。成功离开后，聊天室其他成员会收到 leaveChatRoom 事件
let option = {
    roomId: 'roomId'
}
conn.quitChatRoom(option).then(res => console.log(res))
```

### 获取、修改聊天室信息

聊天室所有成员都可以调用 `getChatRoomDetails` 方法获取聊天室详情，包括聊天室的主题、公告、描述、成员类型、管理员列表等。聊天室所有者和管理员还可以设置和更新聊天室名称。示例代码如下：

```javascript
// 聊天室成员调用 getChatRoomDetails 获取聊天室信息
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))

// 聊天室所有者和管理员调用 modifyChatRoom 更改聊天室主题、描述等信息
let option = {
    chatRoomId: 'chatRoomId',
    chatRoomName: 'chatRoomName', // 聊天室名称
    description: 'description',   // 聊天室描述
    maxusers: 200                 // 聊天室最大人数
}
conn.modifyChatRoom(option).then(res => console.log(res))
```

### 获取聊天室成员列表

所有聊天室成员都可以调用 `listChatRoomMember` 方法获取当前聊天室的成员列表。示例代码如下：

```javascript
let option = {
    pageNum: 1,
    pageSize: 10,
    chatRoomId: 'chatRoomId'
}
conn.listChatRoomMember(option).then(res => console.log(res))
```

### 管理聊天室黑名单列表

聊天室所有者及管理员可以将聊天室中的指成员加入或者移出聊天室黑名单。聊天室成员被加入黑名单后将无法收发聊天室消息，且无法申请再次加入聊天室。

添加、移除、获取聊天室黑名单的示例代码如下：

```javascript
// 聊天室所有者或管理员调用 blockChatRoomMembers 将指定成员加入聊天室黑名单
let option = {
    chatRoomId: 'chatRoomId',
    usernames: ['user1', 'user2'] // 用户 ID 数组
};
conn.blockChatRoomMembers(option).then(res => console.log(res));

// 聊天室所有者或管理员调用 removeChatRoomBlockMulti 将指定成员移出聊天室黑名单
let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // 用户 ID 数组
}
conn.let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // 用户 ID 数组
}
conn.removeChatRoomBlockMulti(option).then(res => console.log(res));(option).then(res => console.log(res));

// 聊天室所有者或管理员调用 getChatRoomBlacklist 获取当前的聊天室黑名单列表
let option = {
    chatRoomId: "chatRoomId",
};
conn.getChatRoomBlacklist(option);
```

### 管理聊天室禁言列表

为了管理聊天室成员发言，聊天室所有者和管理员可以将指定聊天室成员加入或者移出聊天室禁言列表。聊天室成员被加入聊天室禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取聊天室禁言列表的示例代码如下：

```javascript
// 聊天室所有者或管理员调用 muteChatRoomMember 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收 addMute 事件
let option = {
    chatRoomId: "chatRoomId", // 聊天室 ID 
    username: 'username',     // 被禁言的聊天室成员的 ID 
    muteDuration: -1000       // 被禁言的时长，单位 ms，如果是 “-1,000” 代表永久
};
conn.muteChatRoomMember(option).then(res => console.log(res))

// 聊天室所有者或管理员调用 unmuteChatRoomMember 将指定用户加入聊天室禁言列表。被禁言成员和其他未操作的聊天室所有者或管理员会收 removeMute 事件
let option = {
    chatRoomId: "chatRoomId",
    username: 'username'
};
conn.unmuteChatRoomMember(option).then(res => console.log(res))

// 聊天室所有者或管理员调用 getChatRoomMuteList 获取聊天室禁言列表
let option = {
    chatRoomId: "chatRoomId"
};
conn.getChatRoomMuteList(option).then(res => console.log(res))
```

为方便快捷管理，Agora Chat 还支持聊天室所有者和管理员开启和关闭聊天室全员禁言。开启聊天室全员禁言后，除了在聊天室白名单中的成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```javascript
// 聊天室所有者或管理员调用 disableSendChatRoomMsg 开启全员禁言。成功开启后，聊天室成员会收let option = {
    chatRoomId: "chatRoomId"
};
conn.disableSendChatRoomMsg(option).then(res => console.log(res))

// 聊天室所有者或管理员调用 enableSendChatRoomMsg 解除全员禁言。成功解除后，聊天室成员会收到 onAllMemberMuteStateChanged 回调
let option = {
    chatRoomId: "chatRoomId"
};
conn.enableSendChatRoomMsg(option).then((res) => {
    console.log(res)
})
```

### 管理聊天室白名单

聊天室白名单用户不受全员禁言限制。但是如果该白名单用户在聊天室禁言列表中，则该用户不能发言。

添加、移除、获取聊天室白名单的示例代码如下：

```javascript
// 聊天室所有者或管理员调用 addUsersToChatRoomWhitelist 将指定成员添加到聊天室白名单中
let option = {
    chatRoomId: "chatRoomId",
    users: ["user1", "user2"] // 成员 ID 列表
};
conn.addUsersToChatRoomWhitelist(option);

// 聊天室所有者或管理员调用 removeChatRoomWhitelistMember 将指定成员从聊天室白名单中移除
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.removeChatRoomWhitelistMember(option);

// 聊天室成员可以调用 isChatRoomWhiteUser 查看自己是否在聊天室白名单中
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.isChatRoomWhiteUser(option);

// 聊天室所有者或管理员调用 getChatRoomWhitelist 获取当前的聊天室白名单列表
let option = {
    chatRoomId: "chatRoomId"
}
conn.getChatRoomWhitelist(option).then(res => console.log(res));
```

### 添加和移除聊天室管理员

聊天室所有者可以添加聊天室管理员。成功添加后，新添加的聊天室管理员和其他管理员会收到 `addAdmin` 事件。

添加和移除聊天室管理员的示例代码如下：

```javascript
// 聊天室所有者调用 setChatRoomAdmin 添加聊天室管理员
let option = {
    chatRoomId: 'chatRoomId',
    username: 'user1'
}
conn.setChatRoomAdmin(option).then(res => console.log(res))

// 聊天室所有者调用 removeChatRoomAdmin 移除聊天室管理员。被移除的聊天室管理员和其他管理员会收到 removeAdmin 事件
let option = {
    chatRoomId: 'chatRoomId',
    username: 'user1'
}
conn.removeChatRoomAdmin(option).then(res => console.log(res))
```

### 管理聊天室公告

聊天室所有成员都可以获取聊天室公告；聊天室所有者和管理员可以设置和更新群公告。成功设置或更新后，聊天室成员会收到 `updateAnnouncement` 事件。示例代码如下：

```javascript
// 聊天室成员调用 fetchChatRoomAnnouncement 获取聊天室公告
var option = {
    roomId: 'roomId'                        
};
conn.fetchChatRoomAnnouncement(option).then(res => console.log(res))

// 聊天室所有者和管理员调用 updateChatRoomAnnouncement 设置或更新聊天室公告
let option = {
    roomId: 'roomId',  
    announcement: 'hello everyone'                  
};
conn.updateChatRoomAnnouncement(option).then(res => console.log(res))
```

### 监听聊天室事件

Agora Chat SDK 提供了 `listen` 方法来注册监听事件，你可以通过设置此监听，获取到群组中的事件。

监听聊天室事件的示例代码如下：

```javascript
conn.listen({
  onPresence: function(msg){
    switch(msg.type){
        case 'rmChatRoomMute':
            // 解除聊天室一键禁言
            break;
        case 'muteChatRoom':
            // 聊天室一键禁言
            break;
        case 'rmUserFromChatRoomWhiteList':
            // 删除聊天室白名单成员
            break;
        case 'addUserToChatRoomWhiteList':
            // 增加聊天室白名单成员
            break;
        case 'deleteFile':
           // 删除聊天室文件
            break;
        case 'uploadFile':
            // 上传聊天室文件
            break;
        case 'deleteAnnouncement':
            // 删除聊天室公告
            break;
        case 'updateAnnouncement':
            // 更新聊天室公告
            break;
        case 'removeMute':
            // 解除禁言
            break;
        case 'addMute':
            // 禁言
            break;
        case 'removeAdmin':
            // 移除管理员
            break;
        case 'addAdmin':
            // 添加管理员
            break;
        case 'changeOwner':
           // 转让聊天室
            break;
        case 'leaveChatRoom':
            // 退出聊天室
            break;
        case 'memberJoinChatRoomSuccess':
            // 加入聊天室
            break;
        default:
            break;
    }}
})
```