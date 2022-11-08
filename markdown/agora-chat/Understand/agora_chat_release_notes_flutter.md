## V1.0.8 

V1.0.8 于 2022 年 9 月 30 日发布。

#### 新增特性

- 新增聊天室自定义属性功能。
- 新增 `areaCode` 方法限制连接边缘节点的范围。
- `ChatGroup` 中增加 `isDisabled` 属性显示群组禁用状态，需要开发者在服务端设置。该属性在调用 `ChatGroupManager` 中的 `fetchGroupInfoFromServer` 方法获取群组详情时返回。

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