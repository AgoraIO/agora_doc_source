# 管理群组属性

群组是支持多人沟通的即时通讯系统。

本页介绍如何使用 Agora Chat SDK 管理应用中的群组属性。

## 技术原理

SDK 提供了 `Group`, `GroupManager` 和 `GroupChangeListener` 类用于群组管理，可以实现以下功能：

- 修改群组名称及描述
- 获取、更新群组公告
- 管理群组共享文件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 了解群组和群成员的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android)。

## 实现方法

本节介绍如何调用 Agora Chat SDK 提供的 API 实现上述功能。

### 修改群组名称

仅群主和群管理员可以调用 `changeGroupName` 方法设置和修改群组名称，群名称的长度限制为 128 个字符。

示例代码如下：

```java
ChatClient.getInstance().groupManager().changeGroupName(groupId,changedGroupName);
```

### 修改群组描述

仅群主和群管理员可以调用 `changeGroupDescription` 方法设置和修改群组描述，群描述的长度限制为 512 个字符。

示例代码如下：

```java
ChatClient.getInstance().groupManager().changeGroupDescription(groupId,description);
```

### 管理群公告

仅群主和群管理员可以调用 `updateGroupAnnouncement` 方法设置和更新群公告，群公告的长度限制为 512 个字符。公告更新后，所有聊天组成员都会收到 `onAnnouncementChanged` 回调。所有群组成员都可以获取群组公告。

参考以下示例代码管理聊天群公告：

```java
ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, announcement);
```

### 获取群公告

所有群成员均可以调用 `fetchGroupAnnouncement` 方法从服务器获取群公告。

```java
ChatClient.getInstance().groupManager().fetchGroupAnnouncement(groupId);
```

### 管理群组共享文件

#### 上传共享文件

所有群组成员均可以调用 `uploadGroupSharedFile` 方法上传共享文件至群组，群共享文件大小限制为 10 MB。上传共享文件后，其他群成员收到 `GroupChangeListener#OnSharedFileAddedFromGroup` 回调。

示例代码如下：

```java
ChatClient.getInstance().groupManager().uploadGroupSharedFile(groupId, filePath, callBack);
```

#### 删除共享文件

所有群成员均可以调用 `DeleteGroupSharedFile` 方法删除群共享文件。删除共享文件后，其他群成员收到 `GroupChangeListener#OnSharedFileDeletedFromGroup` 回调。

群主和群管理员可删除全部的群共享文件，群成员只能删除自己上传的群文件。

示例代码如下：

```java
ChatClient.getInstance().groupManager().deleteGroupSharedFile(groupId, fileId);
```

#### 从服务器获取共享文件

所有群成员均可以调用 `fetchGroupSharedFileList` 方法从服务器获取群组的共享文件列表。示例如下：

```java
ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
```

### 监听聊天组事件

有关详细信息，请参阅 [聊天组事件](https://docs.agora.io/en/agora-chat/agora_chat_group_android?platform=Android#listen-for-chat-group-events)。