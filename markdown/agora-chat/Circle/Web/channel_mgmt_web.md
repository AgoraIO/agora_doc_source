# 管理频道

频道（Channel）是一个社区下不同子话题的讨论分区，因此一个社区下可以有多个频道。社区创建时会自动创建默认频道，该频道中添加了所有社区成员，用于承载各种系统通知。社区创建者可以根据自己需求创建公开或者私密频道。

## 技术原理

即时通讯 IM Web SDK 支持你通过调用 API 在项目中实现如下功能：

- 创建和管理频道；
- 管理频道成员；
- 监听频道事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 1.0.8 版本的初始化，详见 [Web 快速开始](./agora_chat_get_started_web?platform=Web)；
- 了解即时通讯 IM 的使用限制，详见 [使用限制](./agora_chat_limitation?platform=Web)。

## 实现方法

本节介绍如何使用环信即时通讯 IM Web SDK 提供的 API 实现上述功能。

### 创建和管理频道

#### <a name="create"></a>创建频道

1. 社区所有者可以调用 `createChannel` 方法在社区中创建公开或私密频道。创建者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelCreate`。

每个社区默认最多可创建 100 个频道，超过该阈值需要联系 [support@agora.io](support@agora.io) 调整。

示例代码如下：

```javascript
let options = {
   serverId: 'serverID',
   isPublic: true,
   name: 'channelName',
   description: 'this is my channel',
   ext: 'ext'
}

WebIM.conn.createChannel(options).then((res) => {
   console.log(res)
})
```

2. 邀请用户加入频道。

社区中的用户可以自由加入社区下的公开频道，私密频道只能由频道中的成员邀请用户加入。受邀用户会收到 `onChannelEvent` 回调，事件为 `inviteToJoin`。邀请人多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelInviteUser`。

- 调用 `inviteUserToChannel` 方法邀请用户加入频道，示例代码如下：
 
```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
   userId: 'userId'
}

WebIM.conn.inviteUserToChannel(options).then(() => {
   console.log('发送邀请成功')
})
```

- 用户监听 `onChannelEvent` 回调，事件为 `inviteToJoin`，收到频道加入邀请，确认是否接受邀请。

   - 用户调用 `acceptChannelInvite` 方法同意加入频道。邀请人会收到 `onChannelEvent` 回调，事件为 `acceptInvite`，频道所有成员（不包括该新加入的成员）收到 `onChannelEvent` 回调，事件为`memberPresence`。受邀用户多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelAcceptInvite`。

   ```javascript
   let options = {
      serverId: 'serverId',
      channelId: 'channelId',
      inviter: 'inviterUserId'
   }

   WebIM.conn.acceptChannelInvite(options)
   ```

   - 用户调用 `rejectChannelInvite` 方法拒绝加入频道。邀请人会收到 `onChannelEvent` 回调，事件为 `rejectInvite`。受邀用户多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelRejectInvite`。

   ```javascript
   let options = {
      serverId: 'serverId',
      channelId: 'channelId',
      inviter: 'inviterUserId'
   }

   WebIM.conn.rejectChannelInvite(options)
   ```

3. 用户加入频道后，可在频道中发送和接收消息。

#### 修改频道信息

仅社区所有者和管理员可调用 `updateChannel` 方法修改频道属性，如频道名称、频道描述、频道成员数量上限级别和频道自定义扩展信息。频道所有成员（除操作者外）会收到 `onChannelEvent` 回调，事件为 `update`。操作者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelUpdate`。

```javascript
let options = {
   serverId: 'serverId',
 	channelId: 'channelId'
  	name: 'the new channel name',
  	description: 'the new channel description',
}

WebIM.conn.updateChannel(options).then((res) => {
   console.log(res)
})

```

#### 解散频道

仅社区所有者可以调用 `destroyChannel` 方法删除社区中的频道，频道内其他成员收到 `onChannelEvent` 回调，事件为 `destroy`。操作者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelDestroy`。

```javascript
let options = {
   serverId: 'serverId',
 	channelId: 'channelId'
}

WebIM.conn.destroyChannel(options).then(() => {
   console.log('删除频道成功')
})
```
#### 获取频道详情

社区成员可以调用 `getChannelDetail` 方法获取频道的详情。

示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
 	channelId: 'channelId'
}

WebIM.conn.getChannelDetail(options).then((res) => {
   console.log(res)
})
```

#### 获取频道列表

##### <a name="public"></a>获取社区下的所有公开频道列表

社区成员可以调用 `getPublicChannels` 方法获取社区下的所有公开频道列表，示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
 	pageSize: 20,
   cursor: ''
}

WebIM.conn.getPublicChannels(options).then((res) => {
   console.log(res)
})
```

##### 获取当前用户加入的私密频道列表

社区所有者和管理员可以获取全部的私密频道，普通用户获取自己加入的私密频道，示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
 	pageSize: 20,
   cursor: ''
}

WebIM.conn.getVisiblePrivateChannels(options).then((res) => {
   console.log(res)
})
```

### 管理频道成员

#### 频道加人

用户加入频道分为两种方式：主动申请和频道成员邀请。

邀请用户加入频道，详见 [创建频道](#create)。本节对用户申请加入频道进行详细介绍。

只有公开频道支持用户以申请方式加入，私有频道不支持。若申请加入公开频道，用户需执行以下步骤：

1. 用户可获取 [公开频道列表](#public)。

2. 调用 `joinChannel` 方法传入社区 ID 和频道 ID，申请加入对应频道。频道成员会收到 `onChannelEvent` 回调，事件为 `memberPresence`。申请人多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelJoin`。

   ```javascript
   let options = {
      serverId: 'serverId',
      channelId: 'channelId'
   }

   WebIM.conn.joinChannel(options).then((res) => {
      console.log(res)
   })
   ```

3. 用户加入频道后可以在频道中发送和接收消息。

#### 退出频道

##### 频道成员主动退出频道

频道所有成员可调用 `leaveChannel` 方法退出频道。频道内的其他成员会收到 `onChannelEvent` 回调，事件为`memberAbsence`。退出频道的成员多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelLeave`。

退出频道的成员不会再收到群消息。默认频道不允许主动退出。

示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId'
}

WebIM.conn.leaveChannel(options).then(() => {
   console.log('离开频道成功')
})
```

##### 频道成员被移出频道

社区所有者和管理员可以调用 `removeChannelMember` 方法将指定成员移出频道。被移出频道的成员会收到 `onChannelEvent` 回调，事件为 `removed`，频道其他成员会收到 `onChannelEvent` 回调，事件为 `memberAbsence`。操作者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelRemoveMember`。

示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
   userId: 'userId'
}

WebIM.conn.removeChannelMember(options).then(() => {
   console.log('移除频道成员成功')
})
```

#### 将成员加入频道禁言列表

仅社区所有者和社区管理员可以调用 `muteChannelMember` 将频道成员加入禁言列表，禁言列表中的成员无法在频道中发送消息，但可以接收频道中的消息。被禁言的频道成员、社区所有者和管理员（除操作者外）会收到 `onChannelEvent` 回调，事件为 `muteMember`。操作者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelMuteMember`。

示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
   userId: 'userId',
   duration: -1
}

WebIM.conn.muteChannelMember(options).then(() => {
   console.log('禁言频道成员成功')
})
```

#### 将成员移出频道禁言列表

社区所有者和社区管理员可以调用 `unmuteChannelMember` 将频道禁言列表上的频道成员移出频道禁言列表。被移出禁言列表的社区成员、社区所有者和管理员（除操作者外）会收到 `onChannelEvent` 回调，事件为 `unmuteMember`。操作者多设备登录时，其他设备会同时收到 `onMultiDeviceEvent` 回调，事件为 `channelUnmuteMember`。

示例代码如下：

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
   userId: 'userId',
}

WebIM.conn.unmuteChannelMember(options).then(() => {
   console.log('移除禁言成员成功')
})
```

#### 获取频道禁言列表

社区所有者和社区管理员可以调用 `getChannelMutelist` 方法获取频道下被禁言用户的列表。

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
}

WebIM.conn.getChannelMutelist(options).then((res) => {
   console.log(res)
})
```

#### 获取指定频道的成员列表

频道中的成员可以调用 `getChannelMembers` 方法获取该频道下的成员列表。

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
   pageSize: 20,
   cursor: ''
}

WebIM.conn.getChannelMembers(options).then((res) => {
   console.log(res)
})
```

#### 查询用户是否在频道中

用户可以调用 `isInChannel` 方法查询自己是否在指定频道中。

```javascript
let options = {
   serverId: 'serverId',
   channelId: 'channelId',
}

WebIM.conn.isInChannel(options).then((res) => {
   console.log(res)
})
```

### 监听频道事件

```javascript
WebIM.conn.addEventHandler("channelEvent", {
   onChannelEvent: (e) => {
      const { operation } = e;
      switch (operation) {
         case "destroy":
            // 解散频道。频道的所有成员（除操作者）会收到该事件。
            break;
         case "update":
            // 更新频道。频道所有成员（除操作者外）会收到该事件。
            break;
         case "memberAbsence":
            // 有成员主动退出频道。频道内的其他成员会收到该事件。
            break;
         case "memberPresence":
            // 有用户加入频道。频道的所有成员会收到该事件。
            break;
         case "removed":
            // 有成员被移出频道。被移出的成员会收到该事件。
            break;
         case "muteMember":
            // 有成员被添加至频道禁言列表。被添加至禁言列表的成员、社区所有者和管理员（除操作者外）会收到该事件。
            break;
         case "unmuteMember":
            // 有用户被移出频道禁言列表。被移出禁言列表的成员、社区所有者和管理员（除操作者外）会收到该事件。
            break;  
         case "inviteToJoin":
            // 用户收到频道加入邀请。受邀用户会收到该事件。
            break;
         case "rejectInvite":
            // 用户拒绝频道加入邀请。邀请人会收到该事件。
            break;
         case "acceptInvite":
            // 用户同意频道加入邀请。邀请人会收到该事件。
            break;
         default:
            break;
      }
   }
});
               
```