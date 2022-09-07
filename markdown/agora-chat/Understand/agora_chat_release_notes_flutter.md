## v1.0.7 

#### 新增特性

- `ChatClient` 类中增加 `customEventHandler` 属性，设置自定义监听器，接收 Android 或者 iOS 设备发送到 Flutter 层的数据。
- 添加各类事件的监听器类，实现事件监听。
- 增加 `PushTemplate` 方法，可使用户自定义推送模板。
- 在 `Group` 类中增加 `isDisabled` 属性显示群组的禁用状态，需要开发者在服务端设置。该属性在调用 `fetchGroupInfoFromServer` 方法获取群组详情时返回。
- 在 `PushConfigs` 类中增加 `displayName` 属性，允许用户查看推送通知中显示的昵称。

#### 优化

- 将 `AddXXXManagerListener` 方法（例如，addChatManagerListener 和 addContactManagerListener）标记为过期。

- 修改 API 参考文档。