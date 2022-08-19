# 聊天室-创建和管理聊天室及监听聊天室事件

聊天室是支持多人沟通的即时通讯系统。聊天室中的成员没有固定关系，用户离线后，超过 5 分钟会自动退出聊天室。聊天室成员离线后，不会收到推送消息。聊天室可以应用于直播、消息广播等。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

消息内容详见 [消息管理](https://docs.agora.io/en/agora-chat/agora_chat_message_overview?platform=Web)。

## 技术原理

即时通讯 IM SDK 支持你通过调用 API 在项目中实现如下聊天室管理功能：

- 创建聊天室；
- 从服务器获取聊天室列表；
- 加入聊天室；
- 获取聊天室详情；
- 退出聊天室；
- 解散聊天室；
- 监听聊天室事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。
- 了解即时通讯 IM 聊天室不同版本的数量限制，详见 [套餐包](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Web)。
- 只有应用超级管理员才有创建聊天室的权限。确保已通过调用[super-admin RESTful API](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) 添加了应用超级管理员。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建聊天室

仅 [应用超级管理员](https://docs.agora.io/en/agora-chat/agora_chat_restful_chatroom_superadmin) 可以创建聊天室并设置聊天室名称、描述、最大成员数等聊天室属性。创建聊天室后，超级管理员自动成为聊天室所有者。

```javascript
let options = {
    name: 'chatRoomName', // 聊天室名称。
    description: 'description', // 聊天室描述。
    maxusers: 200, // 聊天室最大成员数（包括聊天室创建者），默认值 200，最大不超过 5,000。
    members: ['user1', 'user2'] // 聊天室成员。此属性可选，但是如果包含此项，数组元素至少一个。
}
conn.createChatRoom(options).then(res => console.log(res))
```

### 从服务器获取聊天室列表

用户可调用 `getChatRooms` 方法从服务器获取指定数目的聊天室列表，能获取到的最大数量为 1,000。

### 加入聊天室

用户申请加入聊天室的步骤如下：

- 调用 `getChatRooms` 方法从服务器获取聊天室列表，查询到想要加入的聊天室 ID。
- 调用 `joinChatRoom` 方法传入聊天室 ID，申请加入对应聊天室。新成员加入聊天室时，其他成员收到 `memberPresence` 事件。

示例代码如下：

```javascript
// 获取聊天室列表，最多可获取 1000 个。
let option = {
    pagenum: 1,
    pagesize: 20
};
conn.getChatRooms(option).then(res => console.log(res))

// 加入聊天室。聊天室所有成员均可调用该接口。
let option = {
    roomId: 'roomId',
    message: 'reason'
}
conn.joinChatRoom(option).then(res => console.log(res))
```

### 获取聊天室详情

聊天室所有成员均可调用 `getChatRoomDetails` 方法获取聊天室的详情，包括聊天室 ID、聊天室名称、聊天室描述、聊天室公告、管理员列表、最大成员数、聊天室所有者、是否全员禁言以及聊天室角色类型。成员列表、黑名单列表、禁言列表需单独调用接口获取。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))
```

### 解散聊天室

仅聊天室所有者可以调用 `destroyChatRoom` 方法解散聊天室。聊天室解散时，其他成员收到 `destroy` 事件并被踢出聊天室。

示例如下：

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId'
}
conn.destroyChatRoom(option).then(res => console.log(res))
```

### 监听聊天室事件

你可以调用 `addEventHandler` 方法注册聊天室监听器，获取聊天室事件，并作出相应处理。

示例代码如下：

```javascript
conn.addEventHandler("eventName", {
  onGroupEvent: function(msg){
    switch(msg.operation){
         // 解除聊天室一键禁言。聊天室所有成员（除操作者外）会收到该事件。
        case 'unmuteAllMembers':
            break;
        // 聊天室一键禁言。聊天室所有成员（除操作者外）会收到该事件。
        case 'muteAllMembers':
            break;
        // 将成员移出聊天室白名单。被移出的成员收到该事件。
        case 'removeAllowlistMember':
            break;
        // 添加成员至聊天室白名单。被添加的成员收到该事件。
        case 'addUserToAllowlist':
            break;
        // 删除聊天室公告。聊天室的所有成员会收到该事件。
        case 'deleteAnnouncement':
            break;
        // 更新聊天室公告。聊天室的所有成员会收到该事件。
        case 'updateAnnouncement':
            break;
        // 解除对指定成员的禁言。被解除禁言的成员会收到该事件。
        case 'unmuteMember':
            break;
        // 禁言指定成员。被禁言的成员会收到该事件。
        case 'muteMember':
            break;
        // 移除管理员。被移除的管理员会收到该事件。
        case 'removeAdmin':
            break;
        // 设置管理员。被添加的管理员会收到该事件。
        case 'setAdmin':
            break;
        // 转让聊天室。聊天室全体成员会收到该事件。
        case 'changeOwner':
            break;
        // 主动退出聊天室。聊天室的所有成员（除退出的成员）会收到该事件。
        case 'memberAbsence':
            break;
        // 有成员被移出聊天室。被踢出聊天室的成员会收到该事件。
        case 'removeMember':
            break;
        // 有用户加入聊天室。聊天室的所有成员（除新成员外）会收到该事件。
        case 'memberPresence':
            break;
        default:
            break;
    }
  }
})
```