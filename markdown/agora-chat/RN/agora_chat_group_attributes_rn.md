群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中实现群组属性相关功能。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatGroupManager` 类和 `ChatGroup` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：

- 修改群组名称及描述
- 获取、更新群组公告
- 管理群组共享文件
- 更新群扩展字段

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [RN 快速开始](./agora_chat_get_started_rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。


## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 修改群组名称

仅群主和群管理员可以调用 `changeGroupName` 方法设置和修改群组名称，群名称的长度限制为 128 个字符。

示例代码如下：

```typescript
// 修改群组名称。
ChatClient.getInstance()
  .groupManager.changeGroupName(groupId, local_name)
  .then(() => {
    console.log("update group name success.");
  })
  .catch((reason) => {
    console.log("update group name fail.", reason);
  });
```

### 修改群组描述

仅群主和群管理员可以调用 `changeGroupDescription` 方法设置和修改群组描述，群描述的长度限制为 512 个字符。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.changeGroupDescription(groupId, desc)
  .then(() => {
    console.log("update group description success.");
  })
  .catch((reason) => {
    console.log("update group description fail.", reason);
  });
```

### 管理群公告

#### 更新群公告

仅群主和群管理员可以调用 `updateGroupAnnouncement` 方法设置和更新群公告，群公告的长度限制为 512 个字符。群公告发生变化时，群成员会收到群组事件通知 `IGroupManagerDelegate#OnAnnouncementChangedFromGroup`。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.updateGroupAnnouncement(groupId, announcement)
  .then(() => {
    console.log("update ann success.");
  })
  .catch((reason) => {
    console.log("update ann fail.", reason);
  });
```

#### 获取群公告

所有群成员均可以调用 `fetchAnnouncementFromServer` 方法从服务器获取群公告。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.fetchAnnouncementFromServer(groupId)
  .then((ann) => {
    console.log("get ann success.", ann);
  })
  .catch((reason) => {
    console.log("get ann fail.", reason);
  });
```

当群组公告发生变化时，所有群成员收到通知 `ChatGroupEventListener#onAnnouncementChanged`。

### 管理共享文件

#### 上传共享文件

所有群组成员均可以调用 `uploadGroupSharedFile` 方法上传共享文件至群组，群共享文件大小限制为 10 MB。上传共享文件后，其他群成员收到 `ChatGroupEventListener#onSharedFileAdded` 回调。

示例代码如下：

```typescript
// 设置文件进度回调
const callback = new (class implements ChatGroupFileStatusCallback {
  that: any;
  constructor(t: any) {
    this.that = t;
  }
  onProgress(groupId: string, filePath: string, progress: number): void {
    console.log(`onProgress: `, groupId, filePath, progress);
  }
  onError(groupId: string, filePath: string, error: ChatError): void {
    console.log(`onError: `, groupId, filePath, error);
  }
  onSuccess(groupId: string, filePath: string): void {
    console.log(`onSuccess: `, groupId, filePath);
  }
})(this);

ChatClient.getInstance()
  .groupManager.uploadGroupSharedFile(groupId, filePath, callback)
  .then(() => {
    console.log("upload file success.");
  })
  .catch((reason) => {
    console.log("upload file fail.", reason);
  });
```

#### 删除共享文件

所有群成员均可以调用 `removeGroupSharedFile` 方法删除群共享文件。删除共享文件后，其他群成员收到 `ChatGroupEventListener#onSharedFileDeleted` 回调。

群主和群管理员可删除全部的群共享文件，群成员只能删除自己上传的群文件。示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.removeGroupSharedFile(groupId, fileId)
  .then(() => {
    console.log("remove file success.");
  })
  .catch((reason) => {
    console.log("remove file fail.", reason);
  });
```

#### 从服务器获取共享文件

所有群成员均可以调用  `fetchGroupFileListFromServer` 方法从服务器获取群组的共享文件列表。

```typescript
// 分页获取群组文件
ChatClient.getInstance()
  .groupManager.fetchGroupFileListFromServer(groupId, pageSize, pageNum)
  .then(() => {
    console.log("get file success.");
  })
  .catch((reason) => {
    console.log("get file fail.", reason);
  });
```

### 更新群扩展字段

仅群主和群管理员可以调用 `updateGroupExtension` 方法更新群组的扩展字段，群组扩展字段设置 JSON 格式的数据，用于自定义更多群组信息。群扩展字段的长度限制为 8 KB。

示例代码如下：

```typescript
// 设置扩展字段
const extension = { key: "value" };
ChatClient.getInstance()
  .groupManager.updateGroupExtension(groupId, JSON.stringify(extension))
  .then(() => {
    console.log("update success.");
  })
  .catch((reason) => {
    console.log("update fail.", reason);
  });
```

### 监听群组事件

有关详细信息，请参阅 [监听群组事件](./agora_chat_group_rn?platform=rn#监听群组事件)。