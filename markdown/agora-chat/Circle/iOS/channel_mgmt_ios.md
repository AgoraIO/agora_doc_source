# 管理频道

频道（Channel）是一个社区下不同子话题的讨论分区，因此一个社区下可以有多个频道。社区创建时会自动创建默认频道，该频道中添加了所有社区成员，用于承载各种系统通知。社区创建者可以根据自己需求创建公开或者私密频道。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatCircleManager` 类和 `AgoraChatCircleManagerChannelDelegate` 类用于频道管理，支持你通过调用 API 在项目中实现如下功能：

- 创建和管理频道；
- 管理频道成员；
- 监听频道事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios?platform=iOS)。
- 了解消息相关限制和即时通讯 IM API 的调用频率限制，详见 [使用限制](./agora_chat_limitation?platform=iOS)。

## 实现方法

本节介绍如何使用即时通讯 IM iOS SDK 提供的 API 实现上述功能。

### 创建和管理频道

#### <a name="create"></a>创建频道

1. 社区所有者可以调用 `createChannel` 方法在社区中创建公开或私密频道。参与频道创建的初始成员会收到 `onChannelCreated` 事件。

每个社区默认最多支持 100 个频道，超过该阈值需要联系 [support@agora.io](support@agora.io) 调整。

示例代码如下：

```swift
let channelAttr = AgoraChatCircleChannelAttribute()
channelAttr.name = channelName
channelAttr.desc = channelDesc
AgoraChatClient.shared().circleManager.createChannel(serverId, attribute: channelAttr, type: .public) { channel, error in                
}
```

2. 邀请用户加入频道。

社区中的用户可以自由加入社区下的公开频道，私密频道只能由频道成员邀请用户加入。

- 调用 `inviteUserToChannel` 方法邀请用户加入频道，示例代码如下：

```swift
 AgoraChatClient.shared().circleManager.inviteUserToChannel(serverId: serverId, channelId: channelId, userId: userId, welcome: welcome) { error in
 }
```

- 用户监听 `onReceiveChannelInvitation` 事件收到频道加入邀请，确认是否接受该邀请。

   - 用户调用 `acceptChannelInvitation` 方法同意加入频道，邀请人收到 `onReceiveChannelInvitation` 回调，频道所有成员（不包括该新加入的成员）收到 `onMemberJoinedChannel` 回调。示例代码如下：

   ```swift
   AgoraChatClient.shared().circleManager.acceptChannelInvitation(serverId, channelId: channelId, inviter: inviter) { channel, error in
   }
   ```

   - 用户调用 `declineChannelInvitation` 方法拒绝加入频道，邀请人收到 `onChannelInvitationBeDeclined` 回调。示例代码如下：

   ```swift
   AgoraChatClient.shared().circleManager.declineChannelInvitation(serverId, channelId: channelId, inviter: inviter) { error in
   }
   ```

3. 用户加入频道后，将可以在频道中发送和接收消息。

#### 修改频道信息

仅社区所有者和管理员可调用 `updateChannel` 方法修改频道属性，如频道名称、频道描述、频道成员数量上限级别和频道自定义扩展信息。频道所有成员（除操作者外）会收到 `onChannelUpdated` 事件。示例代码如下：

```swift
let channelAttr = AgoraChatCircleChannelAttribute()
channelAttr.name = channelName
channelAttr.desc = channelDesc
AgoraChatClient.shared().circleManager.updateChannel(serverId, channelId: channelId, attribute: channelAttr) { channel, error in
}
```

#### 解散频道

仅社区所有者可以调用 `destroyChannel` 方法解散社区中的频道。频道内其他成员收到 `onChannelDestroyed` 回调并被移出频道。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.destroyChannel(serverId, channelId: channelId) { error in
}
```

#### 获取频道详情

社区成员可以调用 `fetchChannelDetail` 方法获取频道的详情。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchChannelDetail(serverId, channelId: channelId) { channel, _ in
}
```

#### 获取频道列表

##### <a name="public"></a>获取社区下的所有公开频道列表

社区成员可以调用 `fetchPublicChannelsInServer` 方法获取社区下的所有公开频道列表，示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchPublicChannels(inServer: serverId, limit: 20, cursor: nil) { result, error in
}
```

##### 获取当前用户加入的私密频道列表

调用 `fetchVisiblePrivateChannelsInServer` 方法，社区所有者和管理员可以获取全部的私密频道，普通成员只能获取自己加入的私密频道，示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchVisiblePrivateChannels(inServer: serverId, limit: 20, cursor: nil) { result, error in
}
```

### 管理频道成员

#### 频道加人

用户加入频道分为两种方式：主动申请和频道成员邀请。只有公开频道支持用户以申请方式加入，私有频道不支持。

本节对用户申请加入频道进行详细介绍。邀请用户加入频道，详见 [创建频道](#create)。

若申请加入公开频道，用户需执行以下步骤：

1. 用户可获取[公开频道列表](#public)。

2. 调用 `joinChannel` 方法传入社区 ID 和频道 ID，申请加入对应频道。示例代码如下：

```swift
AgoraChatClient.shared().circleManager.joinChannel(serverId, channelId: channelId) { channel, error in
}
```

3. 用户加入频道后可以在频道中发送和接收消息。

#### 频道踢人

##### 频道成员主动退出频道

频道所有成员可调用 `leaveChannel` 方法退出频道。频道内的其他成员会收到 `onMemberLeftChannel` 回调。

退出频道的成员不会再收到频道消息。社区内的默认频道不允许成员主动退出。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.leaveChannel(serverId, channelId: channelId) { error in
}
```

##### 频道成员被移出频道

仅频道所有者和管理员可以调用 `removeUserFromChannel` 方法将指定成员移出频道。被移出的频道的成员会收到 `onMemberRemovedFromChannel`事件，其他成员会收到 `onMemberLeftChannel` 事件。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.removeUser(fromServer: serverId, userId: userId) { error in
}
```

#### 将成员加入频道禁言列表

社区所有者和社区管理员可以调用 `muteUserInChannel` 方法，将频道成员加入禁言列表，禁言列表中的成员无法发送频道消中息，可以接收频道中消息。禁言列表中的成员无法在频道中发送消息，但可以接收频道中的消息。被禁言的频道成员、社区所有者和管理员（除操作者外）会收到 `onMemberMuteChangeInChannel` 事件。

```swift
AgoraChatClient.shared().circleManager.muteUserInChannel(userId: userId, serverId: serverId, channelId: channelId, duration: 86400) { error in
}
```

#### 将成员移出频道禁言列表

社区所有者和社区管理员可以调用 `unmuteUserInChannel` 方法，将频道禁言列表上的频道成员移出频道禁言列表。被移出禁言列表的频道成员、社区所有者和管理员（除操作者）会收到 `onMemberMuteChangeInChannel` 事件。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.unmuteUserInChannel(userId: userId, serverId: serverId, channelId: channelId) { error in
}
```

#### 获取频道禁言列表

社区所有者和社区管理员可以获取频道下被禁言用户的列表。

```swift
AgoraChatClient.shared().circleManager.fetchChannelMuteUsers(serverId, channelId: channelId) { map, error in
}
```

#### 获取指定频道的成员列表

频道中的成员可以获取该频道下的成员列表。

```swift
AgoraChatClient.shared().circleManager.fetchChannelMembers(serverId, channelId: channelId, limit: 20, cursor: cursor) { result, error in
}
```

#### 查询当前用户是否在频道中

查询当前用户是否在指定频道中。示例代码如下：

```swift
AgoraChatClient.shared().circleManager.checkSelfIsInChannel(serverId: serverId, channelId: channelId) { isJoined, error in
}
```

### 监听频道事件

#### 单设备登录监听事件 

```swift
//创建频道。参与创建的初始成员会收到该事件。
func onChannelCreated(_ serverId: String, channelId: String, creator: String) {
        
}
//更新频道。频道所有成员（除操作者外）会收到该事件。
func onChannelUpdated(_ serverId: String, channelId: String, name: String, desc: String, initiator: String) {
   
}
//解散频道。频道的所有成员（除操作者）会收到该事件。
func onChannelDestroyed(_ serverId: String, channelId: String, initiator: String) {
   
}
//用户收到频道加入邀请。受邀用户会收到该事件。
func onReceiveChannelInvitation(_ invite: AgoraChatCircleChannelExt, inviter: String) {
   
}
//用户同意频道加入邀请。邀请人会收到该事件。
func onChannelInvitationBeAccepted(_ serverId: String, channelId: String, invitee: String) {
   
}
//用户拒绝频道加入邀请。邀请人会收到该事件。
func onChannelInvitationBeDeclined(_ serverId: String, channelId: String, invitee: String) {
   
}
//有用户加入频道。频道的所有成员会收到该事件。
func onMemberJoinedChannel(_ serverId: String, channelId: String, member: String) {
   
}
//有成员主动退出频道。频道内的其他成员会收到该事件。
func onMemberLeftChannel(_ serverId: String, channelId: String, member: String) {
   
}
//有成员被移出频道。被移出的成员会收到该事件。
func onMemberRemoved(fromChannel serverId: String, channelId: String, member: String, initiator: String) {
   
}
//有成员的禁言状态发生变化。禁言状态变更的成员、社区所有者和管理员（除操作者外）会收到该事件。
func onMemberMuteChange(inChannel serverId: String, channelId: String, muted isMuted: Bool, members: [String]) {
   
}
```

#### 多设备登录监听事件 

```objectivec
(void)multiDevicesCircleChannelEventDidReceive:(AgoraChatMultiDevicesEvent)aEvent
                                       channelId:(NSString * _Nonnull)channelId
                                           ext:(id _Nullable)aExt
{
    switch (aEvent) {
        // 当前用户在其他设备创建了频道。
        case AgoraChatMultiDevicesEventCircleChannelCreate:
            break;
        // 当前用户在其他设备销毁了频道。
        case AgoraChatMultiDevicesEventCircleChannelDestroy:
            break;
        // 当前用户在其他设备更新了频道。
        case AgoraChatMultiDevicesEventCircleChannelUpdate:
            break;
        // 当前用户在其他设备加入了频道。
        case AgoraChatMultiDevicesEventCircleChannelJoin:
            break;
        // 当前用户在其他设备同意了频道邀请。
        case AgoraChatMultiDevicesEventCircleChannelInviteBeAccepted:
            break;
        // 当前用户在其他设备拒绝了频道邀请。
        case AgoraChatMultiDevicesEventCircleChannelInviteBeDeclined:
            break;
        // 当前用户在其他设备退出了频道。
        case AgoraChatMultiDevicesEventCircleChannelExit:
            break;
        // 当前用户在其他设备将用户从频道中踢出。
        case AgoraChatMultiDevicesEventCircleChannelRemoveUser:
            break;
        // 当前用户在其他设备邀请用户加入频道。
        case AgoraChatMultiDevicesEventCircleChannelInviteUser:
            break;
        // 当前用户在其他设备将频道中的用户禁言。
        case AgoraChatMultiDevicesEventCircleChannelAddMute:
            break;
        // 当前用户在其他设备解除频道中的用户禁言。
        case AgoraChatMultiDevicesEventCircleChannelRemoveMute:
            break;
        default:
            break;
    }
}
```
