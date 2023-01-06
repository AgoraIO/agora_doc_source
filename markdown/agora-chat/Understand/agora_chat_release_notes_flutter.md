## v1.0.9 

v1.0.9 于 2022 年 12 月 19 日发布。

#### 修复

 - 修复 Android 12 上的一些告警。
 - 修复极少数场景下调用 `updateMessage` 方法导致的内存与数据库中的消息不一致的问题。    
 - 修复群解散回调 `EMGroupEventHandler#onDestroyedFromGroup` 在 Android 平台上不生效的问题。
 - 修复用户自动接受群组邀请的回调 `EMGroupEventHandler#onAutoAcceptInvitationFromGroup` 在 Android 平台上不生效的问题。   
 - 修复极少数场景下的崩溃问题。

## v1.0.8 

v1.0.8 于 2022 年 11 月 22 日发布。

#### 优化

 移除 SDK 一部分冗余日志。   
        
#### 修复

- 修复极少数场景下，从服务器获取较大数量的消息时失败的问题。
- 修复数据统计不正确的问题。       
- 修复极少数场景下打印日志导致的崩溃。


## v1.0.7 

#### 新增特性

- `ChatClient` 类中增加 `customEventHandler` 属性，设置自定义监听器，接收 Android 或者 iOS 设备发送到 Flutter 层的数据。
- 添加各类事件的监听器类，实现事件监听。
- 增加 `PushTemplate` 方法，可使用户自定义推送模板。
- 在 `Group` 类中增加 `isDisabled` 属性显示群组的禁用状态，需要开发者在服务端设置。该属性在调用 `fetchGroupInfoFromServer` 方法获取群组详情时返回。
- 在 `PushConfigs` 类中增加 `displayName` 属性，允许用户查看推送通知中显示的昵称。

#### 优化

- 将 `AddXXXManagerListener` 方法（例如，addChatManagerListener 和 addContactManagerListener）标记为已废弃。

- 修改 API 参考文档。