# 在多个设备登录

<Toc />

即时通讯 IM 支持同一账号在多个设备上登录，所有已登录的设备同步以下信息和操作：

- 在线消息、离线消息以及对应的回执和已读状态；
- 好友和群组操作；
- 子区相关操作。

声网服务器提供接口查询每个账号已登录设备列表以及[将账号从已登录设备强制下线](./agora_chat_restful_registration#强制用户离线)。

即时通讯 IM 默认最多支持 4 个设备同时在线，详见[即时通讯 IM 计费说明](./agora_chat_pricing)。如需增加支持的设备数量，可联系 [sales@agora.io](mailto:sales@agora.io)。

## 技术原理

声网即时通讯 IM Web SDK 在用户每次登录时会生成一个新的唯一的登录 ID，并将该 ID 发送到服务器。服务器会自动将新消息发送到用户登录的设备，可以自动监听到其他设备上进行的好友或群组操作。

Web 端不存在用户获取其他登录设备的设备 ID 的 API，因此不支持查询其他同时登录的设备，也无法了解这些设备上进行的操作。

## 实现方法

你需要调用 `addEventHandler` 方法注册监听事件，监听其他设备上的操作。服务器同步信息之后，SDK 会回调这些事件，Web 端与其他端均会收到好友和群组相关操作的通知。

对于好友和群组的相关操作来说，多设备事件与单设备事件的名称相同，唯一区别在于事件中的 `from` 字段，即多端多设备事件中该字段的值为当前用户的用户 ID，而单设备事件中，该字段的值为操作方的用户 ID。详见[群组事件](./agora_chat_group_web#监听群组事件)和[用户关系事件](./agora_chat_contact_web#添加好友)。

子区和删除漫游消息事件会触发 `onMultiDeviceEvent` 事件，示例代码如下：

```javascript
conn.addEventHandler("handlerId", {
  onContactAgreed: (event) => {},
  onGroupEvent: (event) => {},
  onMultiDeviceEvent: (event) => {
    switch (event.operation) {
      case "chatThreadCreate":
        // 创建子区
        break;
      case "chatThreadDestroy":
        // 销毁子区
        break;
      case "chatThreadJoin":
        // 加入子区
        break;
      case "chatThreadLeave":
        // 离开子区
        break;
      case "chatThreadNameUpdate":
        // 更新子区名称
        break;
      case "deleteRoaming":
        // 删除漫游消息
        break;
      default:
        break;
    }
  },
});
```
