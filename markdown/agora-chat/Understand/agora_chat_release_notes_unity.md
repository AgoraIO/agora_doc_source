## v1.1.0

v1.1.0 于 2023 年 2 月 28 日发布。

#### 新增特性

- 新增聊天室自定义属性功能。
- 新增聊天室消息优先级功能。
- 在 `XXX` 方法中新增分页参数 `XXX` 和 `XXX`，支持分页获取会话列表功能。
- 新增 `XXX` 方法单向删除漫游消息。

#### 修复

修复一些不安全的代码。

## v1.0.9 

v1.0.9 于 2023 年 2 月 1 日发布。

#### 新增特性

1. `SDKClient` 类中新增以下方法:      
  - `GetLoggedInDevicesFromServer`：获取通过指定账号登录的在线设备列表。
  - `KickDevice`：将指定账号登录的指定设备踢下线。
  - `kickAllDevices`：将指定账号登录的所有设备都踢下线。
2. `RoomManager` 类中新增以下方法： 
  - `FetchAllowListFromServer`：从服务器获取聊天室白名单列表。
  - `CheckIfInRoomAllowList`：检查当前用户是否在聊天室白名单中。
  - `GetChatRoom`：从内存中获取指定聊天室的详情。
  - `UnMuteAllRoomMembers`：解除对所有聊天室成员的禁言。
3. `IRoomManagerDelegate` 类中新增以下回调方法:
  - `OnSpecificationChangedFromRoom`：聊天室信息有更新。
  - `OnAddAllowListMembersFromChatroom`：有成员加入聊天室白名单。
  - `OnRemoveAllowListMembersFromChatroom`：有成员被移出聊天室白名单。
  - `OnRemoveFromRoomByOffline`：成员因为离线被移出聊天室。              
4. `IConnectionDelegate` 类中新增以下回调方法：
  - `OnLoggedOtherDevice`：当前登录账号在其它设备登录时会收到此回调。
  - `OnRemovedFromServer`：当前登录账号从服务器端删除时会收到该回调。
  - `OnForbidByServer`：当前用户账号被禁用时会收到该回调。
  - `OnChangedIMPwd`：当前登录账号因密码被修改被强制退出。
  - `OnLoginTooManyDevice`：当前登录账号因达到登录设备数量上限被强制退出。
  - `OnKickedByOtherDevice`：当前登录设备账号被登录其他设备的同账号踢下线。
  - `OnAuthFailed`：当前登录设备账号因鉴权失败强制退出。
5. `Group` 类中新增以下属性：             
  - `IsMemberOnly`：表示用户是否只能通过申请或邀请加入群组，而不能自由加入。
  - `IsMemberAllowToInvite`：群组是否允许成员邀请用户入群。
  - `MaxUserCount`：群组允许加入的最大成员数。
  - `Ext`：自定义群组扩展信息。
  - `IsDisabled`：群组是否禁用。         
              
#### 优化

1. 命名空间由 ChatSDK 修改为 AgoraChat。
2. 各方法中的 `handle` 参数重命名为 `callback`。
3. 移除 `pushmanager` 类。
4. `UserInfo` 类中的字段名均修改为首字母大写。
5. `Message` 类的 `AttributeValue` 子类中移除 `UINT32` 和 `JSONSTRING` 类型。
6. `OnDisconnected` 方法中移除整型参数 `i`。
7. 以下方法的返回结果进行了调整：
  - `importmessage` 的返回结果由直接返回调整为异步回调。
  - `GetGroupMuteListFromServer` 的返回结果的数据类型由 `List<string>` 调整为 `Dictionary<string, string>`。
  - `FetchRoomMuteList` 的返回结果的数据类型由 `List<string>` 调整为 `Dictionary<string, string>`。
8. `GroupManager` 类中的以下方法进行了重命名:
  - `AddGroupWhiteList` 重命名为 `AddGroupAllowList`。
  - `CheckIfInGroupWhiteList` 重命名为 `CheckIfInGroupAllowList`。
  - `GetGroupWhiteListFromServer` 重命名为 `GetGroupAllowListFromServer`。
  - `RemoveGroupWhiteList` 重命名为 `RemoveGroupAllowList`。            
9. `RoomManager` 类中的以下方法进行了重命名:
  - `AddWhiteListMembers` 重命名为 `AddAllowListMembers`。
  - `RemoveWhiteListMembers` 重命名为 `RemoveAllowListMembers`。           
10. `Message` 类中的 `ReactionList` 由属性调整为方法。           
11. `Group` 类的 `Options` 中的属性仅对内开放，不对外开放。                    
12. `IGroupManagerDelegate` 类中进行了以下调整:
  - `OnAddWhiteListMembersFromGroup` 方法重命名为 `OnAddAllowListMembersFromGroup`。
  - `OnRemoveWhiteListMembersFromGroup` 方法重命名为 `OnRemoveAllowListMembersFromGroup`。
  - `OnInvitationAcceptedFromGroup` 方法中移除 `reason` 参数。
  - `OnRequestToJoinDeclinedFromGroup` 方法中移除 `groupName` 和 `decliner` 参数。

## v1.0.8

v1.0.8 于 2022 年 11 月 22 日发布。
#### 优化

- 移除 SDK 一部分冗余日志。  
- 将命名空间由 ChatSDK 改为 AgoraChat;
        
#### 修复

  1. 修复极少数场景下，从服务器获取较大数量的消息时失败的问题。
  2. 修复数据统计不正确的问题。       
  3. 修复极少数场景下打印日志导致的崩溃。
  4. 修复连接监听器有时无法接收到连接回调的问题。

## v1.0.5

v1.0.5 于 2022 年 8 月 12 日发布。

#### 新增特性

- 用户在线状态订阅，可使用户订阅其他用户的在线状态；
- 消息表情回复，可使用户在指定消息中添加表情回复；
- 子区，可使用户针对指定消息进行深入讨论，而不影响整个会话流；
- 消息翻译；
- 举报非法消息功能。

#### 优化

- 调整 SDK 句柄管理方式；
- 增加 SDK 初始化检测点；
- 调整消息部分属性为实时获取方式。


#### 修复

- 修复部分数据结构转换问题；
- 修复 JSON 数据转换成 HTTP 参数失败的问题；
- 修复 HTTP 请求由于字符集不兼容导致的崩溃问题。
