# 管理社区

社区（Server）是一群有着共同兴趣爱好的人的专属天地，也可以是同学朋友的社交圈子。社区是环信圈子三层基础架构的最上层，各种消息事件均发生在社区内。任何用户均可以自由加入或退出社区，无需审批。

## 技术原理

环信即时通讯 IM iOS SDK 提供 `IAgoraChatCircleManager` 类和 `AgoraChatCircleManagerServerDelegate` 类用于社区管理，支持你通过调用 API 在项目中实现如下功能：

- 创建和管理社区；
- 管理社区成员；
- 监听社区事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 1.0.8 版本的初始化，详见 [快速开始](./agora_chat_get_started_ios?platform=iOS)；
- 了解环信即时通讯 IM 的使用限制，详见 [使用限制](./agora_chat_limitation?platform=iOS)。

## 实现方法

### 创建和管理社区

#### <a name="create"></a>创建社区

可创建社区数量根据套餐版本有所不同。每个用户最多可创建 100 个社区，超过该阈值需要联系 [support@agora.io](support@agora.io) 调整。

1. 调用 `createServer` 方法创建社区。

示例代码如下：

```swift
let attribute = AgoraChatCircleServerAttribute()
attribute.name = serverName
attribute.icon = serverIcon
attribute.desc = serverDesc
attribute.ext = serverExt
AgoraChatClient.shared().circleManager.createServer(attribute) { server, error in
    
}
```

创建社区时，需设置社区属性 `AgoraChatCircleServerAttribute`，如下表所示。

| 参数 | 类型        | 描述                 |
| :--------- | :----------------------- | :------------------ |
| name    | String     | 社区名称。          |
| icon    | String     | 社区图标。          |
| desc    | String     | 社区描述。          |
| ext    | String     | 社区扩展字段。         |

2. 邀请用户加入社区。

 社区创建者调用 `inviteUserToServer` 方法邀请用户加入社区。受邀用户收到 `onReceiveServerInvitation` 事件。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.inviteUserToServer(serverId: serverId, userId: userId, welcome: welcome) { error in
}
```

3. 用户确认是否加入社区。

  - 若同意加入社区，调用 `acceptServerInvitation` 方法。邀请人收到 `onServerInvitationBeAccepted` 事件，社区内所有成员（不包括加入社区的该新成员）会收到 `onMemberJoinedServer` 事件。示例代码如下：

```swift
AgoraChatClient.shared().circleManager.acceptServerInvitation(serverId, inviter: inviter) { server, error in
}
```

  - 若拒绝加入社区，调用 `declineServerInvitation` 方法。邀请人收到 `onServerInvitationBeDeclined` 事件。示例代码如下：

 ```swift
AgoraChatClient.shared().circleManager.declineServerInvitation(serverId, inviter: inviter) { error in
}
``` 

#### 修改社区信息

社区所有者和管理员可调用 `updateServer` 方法修改社区基本信息。社区信息修改后，除操作者外的社区所有成员会收到 `onServerUpdated` 回调。

示例代码如下：

```swift
let attribute = AgoraChatCircleServerAttribute()
attribute.name = serverName
attribute.desc = serverDesc
if let serverIcon = serverIcon {
    attribute.icon = serverIcon
}
AgoraChatClient.shared().circleManager.updateServer(serverId, attribute: attribute) { server, error in
}
```

#### 添加社区标签

社区所有者和管理员可以调用 `addTagsToServer` 方法为社区添加标签。非社区内用户可以通过搜索标签全名查找社区。每个社区最多可添加 10 个标签。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.addTags(toServer: serverId, tags: ["tag1", "tag2"]) { tags, error in
}
```

#### 移除社区标签

社区所有者和管理员可以调用 `removeTagsFromServer` 方法移除社区已有标签。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.removeTags(fromServer: serverId, tagIds: ["tagId1", "tagId2"]) { error in
}
```

#### 解散社区

仅社区所有者可调用 `destroyServer` 方法解散社区。解散社区后将删除本地的社区数据，除社区所有者外的社区所有成员会收到`onServerDestroyed` 回调。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.destroyServer(serverId) { error in
}
```

#### 获取社区详情

社区成员可以调用 `fetchServerDetail` 方法获取社区的详情。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchServerDetail(serverId) { server, error in
}
```

#### 获取已加入社区

用户可以调用 `fetchJoinedServers` 方法获取已加入的社区列表。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchJoinedServers(20, cursor: cursor) { result, error in
}
```

#### 分页获取社区成员列表

社区成员可以调用 `fetchServerMembers` 方法分页获取指定社区中的成员列表。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchServerMembers(serverId, limit: 20, cursor: cursor) { result, error in
}
```

### 管理社区成员

#### 加入社区

每个用户最多加入 100 个社区，超过该阈值需要联系 [support@agora.io](support@agora.io) 调整。用户可以通过以下两种方式加入社区：

1. 搜索社区名称和标签（同时支持 REST 通过社区 ID 搜索），主动申请加入社区。

2. 社区内成员邀请用户加入。

通过邀请加入频道，详见 [创建社区](#create)。下面介绍用户如何申请加入社区。

1. 用户可以调用 `fetchServersWithKeyword` 方法根据社区名称和标签名称搜索社区。

目前所有社区都为公开，任何用户都可以搜索到。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchServers(withKeyword: text) { servers, error in
}
```

2. 用户调用 `joinServer` 方法加入社区。加入成功后，社区内其他成员会收到 `onMemberJoinedServer` 回调。
示例代码如下：

```swift
AgoraChatClient.shared().circleManager.joinServer(serverId) { server, error in
}
```

#### 退出社区

社区所有者不支持退出社区操作，只能解散社区。

退出社区分为主动退出和被动退出，被动退出即为被社区所有者或管理员踢出社区。

#### 用户主动退出社区

用户可调用 `leaveServer` 方法退出社区。社区内其他成员会收到 `onMemberLeftServer` 回调。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.leaveServer(serverId) { error in
}
```

#### 用户被踢出社区

社区所有者和管理员调用 `removeUserFromServer` 方法将普通成员踢出社区，管理员只能被社区所有者踢出社区。被踢出社区的成员、社区所有者和管理员（除操作者外）会收到 `onMemberRemovedFromServer` 事件。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.removeUser(fromServer: serverId, userId: userId) { error in
}
```

#### 查询当前用户是否在社区内

用户可调用 `checkSelfIsInServer` 方法查询自己是否已经加入了指定社区。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.checkSelfIs(inServer: serverId) { isIn, error in
}
```

### 查询当前用户在社区里的角色

用户可调用 `fetchSelfServerRole` 方法查询当前用户在社区中的角色。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.fetchSelfServerRole(serverId) { role, error in
}
```

#### 设置社区管理员

仅社区所有者可以调用 `addModeratorToServer` 方法设置社区管理员。成功设置后，除社区所有者之外的其他社区成员会收到 `onServerRoleAssigned` 事件。

社区管理员除了不能解散社区等少数权限外，拥有对社区的绝大部分权限。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.addModerator(toServer: serverId, userId: userId) { error in
}
```
#### 移除社区管理员

仅社区所有者可以调用 `removeModeratorFromServer` 方法移除社区管理员。成功移除后，除社区所有者之外的其他社区成员会收到 `onServerRoleAssigned` 事件。

若社区管理员被移除管理员权限后，将只拥有社区普通成员的权限。

示例代码如下：

```swift
AgoraChatClient.shared().circleManager.removeModerator(fromServer: serverId, userId: userId) { error in
}
```

### 监听社区事件

#### 单设备登录监听事件 

```swift
//社区信息更新。社区所有成员（除操作者外）会收到该事件。
func onServerUpdated(_ event: AgoraChatCircleServerEvent) {
        
}
//社区被解散。社区所有成员（除社区所有者外）会收到该事件。
func onServerDestroyed(_ serverId: String, initiator: String) {

}
//用户收到社区加入邀请。受邀用户会收到该事件。
func onReceiveServerInvitation(_ event: AgoraChatCircleServerEvent, inviter: String) {
    
}
//用户同意社区加入邀请。邀请人会收到该事件。
func onServerInvitationBeAccepted(_ serverId: String, invitee: String) {
    
}
//用户拒绝社区加入邀请。邀请人会收到该事件。
func onServerInvitationBeDeclined(_ serverId: String, invitee: String) {
    
}
//社区成员的角色发生变化。社区所有成员（除操作者外）会收到该事件。
func onServerRoleAssigned(_ serverId: String, member: String, role: AgoraChatCircleUserRole) {
    
}
//有用户加入社区。社区所有成员（除加入社区的新成员外）会收到该事件。
func onMemberJoinedServer(_ serverId: String, member: String) {
    
}
//有成员主动退出社区。社区所有者和管理员会收到该事件。
func onMemberLeftServer(_ serverId: String, member: String) {
    
}
//有成员被移出社区。被移除者、社区所有者和管理员（除操作者外）会收到该事件。
func onMemberRemoved(fromServer serverId: String, members: [String]) {
    
}
```

#### 多设备登录监听事件 

```objectivec
(void)multiDevicesCircleServerEventDidReceive:(AgoraChatMultiDevicesEvent)aEvent
                                       serverId:(NSString * _Nonnull)serverId
                                           ext:(id _Nullable)aExt
{
    switch (aEvent) {
        // 当前用户在其他设备创建了社区。
        case AgoraChatMultiDevicesEventCircleServerCreate:
            break;
        // 当前用户在其他设备销毁了社区。
        case AgoraChatMultiDevicesEventCircleServerDestroy:
            break;
        // 当前用户在其他设备更新了社区。
        case AgoraChatMultiDevicesEventCircleServerUpdate:
            break;
        // 当前用户在其他设备加入了社区。
        case AgoraChatMultiDevicesEventCircleServerJoin:
            break;
        // 当前用户在其他设备退出了社区。
        case AgoraChatMultiDevicesEventCircleServerExit:
            break;
        // 当前用户在其他设备同意了社区邀请。
        case AgoraChatMultiDevicesEventCircleServerInviteBeAccepted:
            break;
        // 当前用户在其他设备拒绝了社区邀请。
        case AgoraChatMultiDevicesEventCircleServerInviteBeDeclined:
            break;
        // 当前用户在其他设备设置了社区角色。
        case AgoraChatMultiDevicesEventCircleServerSetRole:
            break;
        // 当前用户在其他设备将用户踢出了社区。
        case AgoraChatMultiDevicesEventCircleServerRemoveUser:
            break;
        // 当前用户在其他设备邀请用户加入社区。
        case AgoraChatMultiDevicesEventCircleServerInviteUser:
            break;
        default:
            break;
    }
}
```