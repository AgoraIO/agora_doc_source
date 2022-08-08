群组是支持多人沟通的即时通讯系统，本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建群组并管理群组和群组成员。

## 技术原理

Agora Chat Android SDK 提供 `GroupManager` 和 `Group` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：
- 创建、解散群组
- 加入、退出群组
- 获取群成员列表、已加入群组列表
- 管理群成员
- 管理群组属性、群公告及群共享文件

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_web)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_web)。
- 了解群组和群成员数量限制。详见[套餐包详情](agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散群组

创建群组包含如下步骤：

1. 群主调用 `createGroup` 方法创建群组，你可以在该方法中设置群组名、群组描述、群组成员、建群原因，并通过 `GroupOptions` 参数设置群组的最大人数及群组类型。
2. 根据被邀请人是否需要确认才能加群的设置，后续的实现逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `invite` 事件。如果同意入群，则邀请人会收到 `invite_accept` 事件。被邀请人进群后，所有群组成员会收到 `memberJoinPublicGroupSuccess` 事件；如果被邀请人不同意入群，则邀请人收到 `onInvitationDeclined` 回调。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `direct_joined` 事件。群主会收到每个已加入成员对应的 `memberJoinPublicGroupSuccess` 监听事件，同时先加入的群成员会收到 `memberJoinPublicGroupSuccess` 监听事件。

创建和解散群组的示例代码如下：

```javascript
let option = {
    groupname: "groupName",
    desc: "A description of a group",
    members: ["user1", "user2"],
    // 设置该群为公开群。其他用户可以看到并申请加入
    public: true,
    // 设置需要群主或群管理员通过才可以加群
    approval: true,
    // 设置群成员也可以邀请其他成员入群
    allowinvites: true,
    // 设置入群邀请需要群主或群管理员审批
    inviteNeedConfirm: true
}
// 调用 createGroup 方法创建群组后。成功创建后，调用该方法的用户即该群组的群主
conn.createGroup(option).then(res => console.log(res))


// 调用 destroyGroup 方法解散群组。解散群组后，本地数据库和内存中的群相关信息和群会话均会消息
// 该方法只有群主才能调用。成功解散群组后，群成员会收到 deleteGroupChat 事件
let option = {
    groupId: "groupId"
};
conn.destroyGroup(option).then(res => console.log(res))
```

### 用户申请入群与退出群组

当群组类型为 `public` 时，用户可以申请加入该群。

申请入群的步骤如下：
1. 调用 `listGroup` 方法获取群组列表，并获取想要加入的群组的 ID。
2. 调用 `joinGroup` 方法加入群组：
    - 如果群组类型 `approval` 为 `false`，则用户可以直接调用 `joinGroup` 加入该群。成功入群后，群组成员会收到 `memberJoinPublicGroupSuccess` 事件
    - 如果群组类型 `approval` 为 `true`，则群主和群管理员会收到 `joinPublicGroupSuccess` 事件。群主和群管理员可以同意或拒绝该入群申请。成功入群后，群组成员会收到 `memberJoinPublicGroupSuccess` 事件

用户申请入群与退出群组的示例代码如下：

```javascript
// 从服务器获取自己加入或创建的群组列表
conn.getGroup().then(res => console.log(res))

// 分页获取公开群列表
let limit = 20,
    cursor = globalCursor;
let option = {
    limit: limit,
    cursor: cursor, 
};
conn.listGroups(option).then(res => console.log(res))

// 调用 joinGroup 加入群组
let options = {
    groupId: "groupId",
    message: "I am Tom"
};
conn.joinGroup(options).then(res => console.log(res))

// 调用 leaveGroup 退出群组。退出后，其他群组成员会收到 leaveGroup 事件
let option = {
    groupId: "groupId"
};
conn.quitGroup(option).then(res => console.log(res))
```

### 获取群成员列表

你可以通过分页获取群成员。示例代码如下：

```javascript
let pageNum = 1,
    pageSize = 1000;
let options = {
    pageNum: pageNum,
    pageSize: pageSize,
    groupId: "groupId"
};
conn.listGroupMembers(options).then(res => console.log(res))
```

### 群组加人或踢人

无论是私有群还有公开群，群主和群管理员均可以通过调用 `inviteUsersToGroup` 将用户添加到群组。如果群组类型为 `allowinvites` 为 `true`，则群成员也可以添加其他用户进群。用户成功加入群组后，就可以接收群消息。

群组加人的步骤如下：
1. 群主、群管理员或群成员调用 `inviteUsersToGroup` 方法邀请用户入群
2. 根据被邀请人是否需要确认才能加群的设置，双方逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `invite` 事件。如果同意入群，则邀请人会收到 `invite_accept` 事件。被邀请人进群后，所有群组成员会收到 `memberJoinPublicGroupSuccess` 事件。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `direct_joined` 事件。被邀请人进群后，所有群组成员会收到 `memberJoinPublicGroupSuccess` 事件。

群组加人、踢人的示例代码如下：

```javascript
// 群主或群管理员调用 inviteUsersToGroup 加人
let option = {
    users: ["user1", "user2"],
    groupId: "groupId"
};
conn.inviteUsersToGroup(option).then(res => console.log(res))

// 只有群主和群管理员才可以将群成员踢出群组
// 群成员被踢出群组后，会收到 removedFromGroup 事件，且不会再接收群消息；其他群成员会收到 leaveGroup 事件
let option = {
    groupId: "groupId",
    username: "username"
};
conn.removeGroupMember(option).then(res => console.log(res))
```

### 转让群主、添加和移除群管理员

群主可以将权限移交给群组中指定成员，移交后原群主变为成员，群成员会接收到 `changeOwner` 事件。

群主还可以添加群管理员。成功添加后，被添加为群管理员的用户和其他管理员会收到 `addAdmin` 事件。

转让群主、添加和移除群管理员的示例代码如下：

```javascript
// 群主调用 chageGroupOwner 将群主权限移交给指定群成员
let option = {
    groupId: "groupId",
    newOwner: "username"
};
conn.changeGroupOwner(option).then(res => console.log(res))

// 群主调用 setGroupAdmin 添加群管理员
let option = {
    groupId: "groupId",
    username: "user"
};
conn.setGroupAdmin(option).then(res => console.log(res))

// 群主调用 removeAdmin 移除管理员权限。被移除群管理的用户和其他管理员会收到 removeAdmin 事件
let option = {
    groupId: "groupId",
    username: "user"
};
conn.removeAdmin(option).then(res => console.log(res))
```

### 管理群组黑名单列表

群主及群管理员可以将群组中的指定群成员加入或者移出群黑名单。群成员被加入黑名单后将无法收发群消息，且无法申请再次入群。

添加、移除、获取群组黑名单的示例代码如下：

```javascript
// 群主或群管理员调用 blockGroupMember 将指定用户移入黑名单
let option = {
    groupId: "groupId",
    usernames: ["user1", "user2"]
};
conn.blockGroupMember(option).then(res => console.log(res))

// 群主或群管理员调用 unblockGroupUser 将指定用户移出黑名单。移出后，该用户可以再次申请加入群组
let option = {
    groupId: "groupId",
    username: ["user1", "user2"]
}
conn.unblockGroupMembers(option).then(res => console.log(res))

// 群主或群管理员可以从服务器获取群组的黑名单列表
let option = {
    groupId: "groupId",
};
conn.getGroupBlacklist(option).then(res => console.log(res))
```

### 管理群组禁言列表

为了精细化管理群成员发言，群主和群管理员可以根据情况将指定群成员加入或者移出群禁言列表。群成员被加入群禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取群禁言列表的示例代码如下：

```javascript
// 群主或群管理员调用 muteGroupMember 将指定用户加入群禁言列表。被禁言成员和其他未操作的群主或群管理员会收到 addMute 事件
let option = {
    groupId: "groupId"，
    username: "user",
    muteDuration: 886400000 // 禁言的时长，单位是毫秒
};
conn.muteGroupMember(option).then(res => console.log(res))

// 群主或群管理员调用 unmuteGroupMember 将指定用户移出禁言列表。被移出的成员和其他未操作的群主或群管理员会收到 removeMute 事件
let option = {
    groupId: "groupId",
    username: "user"
};
conn.unmuteGroupMember(option).then(res => console.log(res))

// 群主或群管理员调用 getGroupMuteList 获取群组禁言列表
let option = {
    groupId: "groupId"
};
conn.getGroupMuteList(option).then(res => console.log(res))
```

为方便快捷管理，Agora Chat 还支持群主和群管理员开启和关闭群组全员禁言。开启群组全员禁言后，除了在群白名单中的群成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```javascript
// 群主或群管理员调用 disableSendGroupMsg 开启全员禁言。成功开启后，群成员会收到 muteGroup 事件
let options = {
    groupId: "groupId",
};
conn.disableSendGroupMsg(options).then(res => console.log(res))

// 群主或群管理员调用 enableSendGroupMsg 取消全员禁言。成功取消后，群成员会收到 rmGroupMute 事件
let options = {
    groupId: "groupId",
};
conn.enableSendGroupMsg(options).then(res => console.log(res))
```

### 管理群组白名单列表

白名单用户不受全员禁言限制。但是如果该白名单用户在群禁言列表中，则该用户不能发言。

添加、移除、获取白名单的示例代码如下：

```javascript
// 群主或群管理员调用 addUsersToGroupWhitelist 添加指定成员到白名单。成功添加后，该群成员和其他位操作的群主或群管理员会收到 addUsersToGroupWhitelist 事件
let option = {
    groupId: "groupId",
    users: ["user1", "user2"]
};
conn.addUsersToGroupWhitelist(option).then(res => console.log(res));

// 群主或群管理员调用 removeGroupWhitelistMember 将指定成员移除出白名单。成功移除后，该群成员和其他位操作的群主或群管理员会收到 rmUserFromGroupWhiteList 事件
let option = {
    groupId: "groupId",
    userName: "user"
}
conn.removeGroupWhitelistMember(option).then(res => console.log(res));

// 群成员可以调用 isInGroupWhiteList 检查自己是否在白名单中
let option = {
    groupId: "groupId",
    userName: "user"
}
conn.isInGroupWhiteList(option).then(res => console.log(res));

// 群主或群管理员调用 getGroupWhitelist 获取群组白名单列表
let options = {
    groupId: "groupId"
}
conn.getGroupWhitelist(options).then(res => console.log(res));
```

### 修改群组名称或描述

群主或群管理员可以修改群组的名称和描述。示例代码如下：

```javascript
// 群主或群管理员调用 modifyGroup 修改群组名和群组描述。群名称长度限制为 128 个字符，群描述长度限制为 512 个字符
let option = {
    groupId: "groupId",
    groupName: "groupName",
    description: "A description of group"
};
conn.modifyGroup(option).then(res => console.log(res))
```

### 更新、获取群公告

群主和群管理员可以设置和更新群公告，群成员可以获取群公告。示例代码如下：

```javascript
// 群主或群管理员调用 updateGroupAnnouncement 设置或更新群公告。成功设置后，所有群组成员收到 updateAnnouncement 事件。群公告长度限制为 512 个字符
let option = {
    groupId: "groupId",   
    announcement: "A announcement of group"                       
};
conn.updateGroupAnnouncement(option).then(res => console.log(res))

// 群成员均可以调用 fetchGroupAnnouncement 获取群公告
let option = {
    groupId: "groupId"
};
conn.fetchGroupAnnouncement(option).then(res => console.log(res))
```

### 上传、删除、获取群共享文件

所有群组成员都可以上传和获取群共享文件。只有群主和群管理员才能删除全部群共享文件，群成员只能删除自己上传的群文件。示例代码如下：

```javascript
// 群成员均可以调用 uploadGroupSharedFile 上传群共享文件。群共享文件大小限制为 10 M
// 成功上传群共享文件后，群成员会收到 onSharedFileAdded 回调
let option = {
    groupId: "groupId",
    file: file, // <input type="file"/>获取的file文件对象                         
    onFileUploadProgress: function(resp) {},   // 上传进度的回调
    onFileUploadComplete: function(resp) {},   // 上传完成时的回调
    onFileUploadError: function(e) {},         // 上传失败的回调
    onFileUploadCanceled: function(e) {}       // 上传取消的回调
};
conn.uploadGroupSharedFile(option);

// 调用 downloadGroupSharedFile 下载群共享文件
let option = {
    groupId: "groupId",
    fileId: "fileId", // 文件 ID                  
    onFileDownloadComplete: function(resp) {}, // 下载成功的回调
    onFileDownloadError: function(e) {},       // 下载失败的回调
};
conn.downloadGroupSharedFile(option);

// 群成员均可以调用 deleteGroupSharedFile 删除群共享文件
let option = {
    groupId: "groupId",
    fileId: "fileId", // 文件 ID 
};
conn.deleteGroupSharedFile(option).then(res => console.log(res))

// 群成员均可以调用 fetchGroupSharedFileList 获取群共享文件列表
let option = {
    groupId: "groupId"
};
conn.fetchGroupSharedFileList(option).then(res => console.log(res))
```

### 监听群组事件

Agora Chat SDK 提供了 `listen` 方法来注册监听事件，你可以通过设置此监听，获取到群组中的事件。

监听群组事件的示例代码如下：

```javascript
conn.listen({
  onPresence: function(msg){
    switch(msg.type){
    case 'rmGroupMute':
      // 解除群组一键禁言
      break;
    case 'muteGroup':
      // 群组一键禁言
      break;
    case 'rmUserFromGroupWhiteList':
      // 删除群白名单成员
      break;
    case 'addUserToGroupWhiteList':
      // 增加群白名单成员
      break;
    case 'deleteFile':
      // 删除群文件
      break;
    case 'uploadFile':
      // 上传群文件
      break;
    case 'deleteAnnouncement':
      // 删除群公告
      break;
    case 'updateAnnouncement':
      // 更新群公告
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
      // 转让群组
      break;
    case 'direct_joined':
      // 直接被拉进群
      break;
    case 'leaveGroup':
      // 退出群
      break;
    case 'memberJoinPublicGroupSuccess':
      // 加入公开群成功
      break;
    case 'removedFromGroup':
      // 从群组移除
      break;
    case 'invite_decline':
      // 拒绝加群邀请
      break;
    case 'invite_accept':
      // 接收加群邀请（群含权限情况）
      break;
    case 'invite':
      // 加群邀请
      break;
    case 'joinPublicGroupDeclined':
      // 拒绝入群申请
      break;
    case 'joinPublicGroupSuccess':
      // 同意入群申请
      break;
    case 'joinGroupNotifications':
      // 申请入群
      break;
    case 'leave':
      // 退出群
      break;
    case 'join':
      // 加入群
      break;
    case 'deleteGroupChat':
      // 解散群
      break;
    default:
      break;
  }}
})
```