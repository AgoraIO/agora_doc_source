# 环信超级社区（Circle）快速开始

## 集成准备

使用环信超级社区（Circle）之前，确保你已经集成即时通讯 IM Android SDK 1.0.8，详见 [即时通讯 IM iOS 快速开始](./agora_chat_get_started_ios?platform=iOS)。

## 技术原理

用户需加入一个社区，选择加入社区中的频道，然后才能在频道中发送消息。

发送和接收消息的逻辑如下：

1. 发送方获取社区 ID；
2. 发送方获取频道 ID；
3. 发送方通过 `sendMessage` 发送消息；
4. 接收方通过 `AgoraChatManagerDelegate` 添加消息接收的回调通知。

## 实现方法

### 获取指定的社区

你可以通过三种方式获取指定的社区 ID：

- 创建社区；
- 加入一个现有社区；
- 获取已加入的社区列表。

#### 创建社区

你可以调用 `createServer` 方法创建一个社区：

```swift
let attribute = AgoraChatCircleServerAttribute()
attribute.name = name
attribute.icon = icon
attribute.desc = desc
attribute.ext = ext
AgoraChatClient.shared().circleManager.createServer(attribute) { server, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
    } else if server != nil {
        Toast.show("创建成功", duration: 2)
    }
}
```

#### 加入一个现有社区

你可以调用 `joinServer` 方法加入一个现有社区：

```swift
AgoraChatClient.shared().circleManager.joinServer(serverId) { server, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
    } else if let server = server {
        Toast.show("加入成功", duration: 2)
    }
}
```

#### 获取已加入的社区列表

你可以调用 `fetchJoinedServers` 方法获取已加入的社区列表：

```swift
AgoraChatClient.shared().circleManager.fetchJoinedServers(20, cursor: self.cursor) { result, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
        return
    }
}
```

### 获取指定的频道

你可以通过三种方式获取指定的频道 ID：

- 创建频道；
- 加入一个现有频道；
- 获取已加入的频道列表；
- 获取社区中当前用户可见的频道列表；

#### 创建频道

你可以调用 `createChannel` 方法创建频道：

```swift
let channelAttr = AgoraChatCircleChannelAttribute()
channelAttr.name = name
channelAttr.desc = desc
AgoraChatClient.shared().circleManager.createChannel(serverId, attribute: channelAttr, type: .public) { channel, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
    } else {
        Toast.show("创建成功", duration: 2)
    }
}
```

#### 加入一个现有频道

你可以调用 `joinToChannel` 方法加入频道：

```swift
AgoraChatClient.shared().circleManager.joinChannel(serverId, channelId: channelId) { channel , error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
    } else {
        Toast.show("加入成功", duration: 2)
    }
}
```

#### 获取已加入的公开频道列表

你可以调用 `fetchPublicChannels` 方法获取已加入的公开频道列表：

```swift
AgoraChatClient.shared().circleManager.fetchPublicChannels(inServer: serverId, limit: 20, cursor: nil) { result, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
        return
    }
}
```

#### 获取社区中当前用户可见的私有频道列表

社区中的普通成员只能获取到自己加入的私有频道，而社区所有者和管理员可以获取全部的私有频道。

```swift
AgoraChatClient.shared().circleManager.fetchVisiblePrivateChannels(inServer: self.serverId, limit: 20, cursor: nil) { result, error in
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
        return
    }
}
```

### 发送和接收一条频道消息

在频道中发送和接收消息，你可以参考 [即时通讯 IM iOS 快速开始](./agora_chat_get_started_ios?platform=iOS)。

#### 发送一条频道消息

你可以调用 `createTxtSendMessage` 方法在指定频道中发送一条文本消息：

```swift
let messageBody = AgoraChatTextMessageBody(text: text)
let message = AgoraChatMessage(conversationID: channelId, from: selfUserId, to: channelId, body: messageBody, ext: nil)
message.isChannelMessage = true
message.chatType = .groupChat
AgoraChatClient.shared().chatManager.send(message, progress: nil) { message, error in 
    if let error = error {
        Toast.show(error.errorDescription, duration: 2)
    } else {
        Toast.show("发送成功", duration: 2)
    }
}
```

#### 接收一条频道消息

添加 `ChatManager` 回调的代理对象：

```swift
AgoraChatClient.shared().chatManager.add(self, delegateQueue: nil)
```

代理对象实现 `AgoraChatManagerDelegate` 接口的 `messagesDidReceive` 方法。

```swift
extension ChatViewController : AgoraChatManagerDelegate {
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
       
    }
}
```