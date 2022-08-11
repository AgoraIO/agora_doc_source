# 在线状态订阅 Android

在线状态功能使用户可以公开显示其在线状态并快速确定其他用户的状态。用户还可以自定义他们的在线状态，为实时聊天增添乐趣和多样性。

下图显示了创建自定义在线状态的实现以及各种在线状态在联系人列表中的外观：

![img](https://web-cdn.agora.io/docs-files/1655302046418)

本文介绍如何使用 Agora Chat SDK 在项目中实现在线状态。

## 技术原理

Agora Chat SDK 提供 `Presence`、`PresenceManager` 和 `PresenceListener` 类用于管理在线状态订阅，包含如下核心方法：

- `subscribePresences`：订阅用户的在线状态；
- `publishPresence`：发布自定义在线状态；
- `addListener`：添加在线状态监听器；
- `onPresenceUpdated`：被订阅用户的在线状态变更时，订阅者收到监听回调；
- `unsubscribePresences`：无需关注用户的在线状态时，取消订阅；

订阅用户在线状态的基本工作流程如下：

![img](https://web-cdn.agora.io/docs-files/1655306619037)

如上图所示，订阅用户在线状态的基本步骤如下：

1. 用户 A 订阅用户 B 的在线状态；
2. 用户 B 的在线状态发生变更；
3. 用户 A 收到 `onPresenceUpdated` 回调。

## 前提条件

使用在线状态功能前，请确保满足以下条件：

- 初始化 Agora Chat SDK，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation)。
- 在 [Agora 控制台](http://console.agora.io/) 中启用在线状态功能。

## 实现方法

本节介绍如何使用 SDK 提供的 API 实现上述功能。

### 订阅指定用户的在线状态

默认情况下，你不关注任何其他用户的在线状态。你可以通过调用 `subscribePresences` 方法订阅指定用户的在线状态。

订阅成功后 `onSuccess` 触发回调，同步通知你指定用户的当前状态。每当指定用户更新他们的在线状态时，`onPresenceUpdated` 都会触发回调，异步通知更新的状态。

以下代码示例显示了如何订阅一个或多个用户的在线状态：

```java
ChatClient.getInstance().presenceManager().subscribePresences(contactsFromServer, 1 * 24 * 3600, new ValueCallBack<List<Presence>>() {
                    @Override
                    public void onSuccess(List<Presence> presences) {

                    }
                    @Override
                    public void onError(int errorCode, String errorMsg) {

                    }
                });
```

- 订阅时长最长为 30 天，过期需重新订阅。如果未过期的情况下重复订阅，新设置的有效期会覆盖之前的有效期。
- 每次调用接口最多只能订阅 100 个账号，若数量较大需多次调用。每个用户 ID 订阅的用户数不超过 3000。如果超过 3000，后续订阅也会成功，但默认会将订阅剩余时长较短的替代。

### 发布自定义在线状态

用户在线时，可调用 `publishPresence` 方法发布自定义在线状态。每当在线状态更新时，发布者和订阅者均会收到 `onPresenceUpdated` 回调。

以下代码示例显示了如何发布自定义状态：

```java
ChatClient.getInstance().presenceManager().publishPresence("custom status", new CallBack() {
                    @Override
                    public void onSuccess() {
                    }
                    @Override
                    public void onError(int code, String error) {
                    }
                });
```

### 添加在线状态监听器

添加用户在线状态的监听器，示例代码如下：

```java
ChatClient.getInstance().presenceManager().addListener(new MyPresenceListener());

// 用 `EMPresenceListener` 监听器实现以下接口。当订阅的用户在线状态发生变化时，会收到`onPresenceUpdated` 回调。
public interface PresenceListener {
    void onPresenceUpdated(List<Presence> presences);
}
```

### 取消订阅指定用户的在线状态

若取消指定用户的在线状态订阅，可调用 `unsubscribePresences`，示例代码如下：

```java
ChatClient.getInstance().presenceManager().unsubscribePresences(contactsFromServer, new CallBack() {
                    @Override
                    public void onSuccess() {

                    }
                    @Override
                    public void onError(int errorCode, String errorMsg) {

                    }
                });
```

### 查询被订阅用户列表

为方便用户管理订阅关系，SDK 提供 `fetchSubscribedMembers` 方法，可使用户分页查询自己订阅的用户列表，示例代码如下：

```java
ChatClient.getInstance().presenceManager().fetchSubscribedMembers(1, 50, new ValueCallBack<List<String>>() {
                    @Override
                    public void onSuccess(List<String> subscribedMembers) {

                    }
                    @Override
                    public void onError(int errorCode, String errorMsg) {

                    }
                });
```

### 获取用户的当前在线状态

如果不关注用户的在线状态变更，你可以调用 `fetchPresenceStatus` 获取用户当前的在线状态，而无需订阅状态。示例代码如下：

```java
ChatClient.getInstance().presenceManager().fetchPresenceStatus(contactsFromServer, new ValueCallBack<List<Presence>>() {
                    @Override
                    public void onSuccess(List<Presence> presences) {

                    }
                    @Override
                    public void onError(int errorCode, String errorMsg) {

                    }
                });
```