# 管理群组属性

群组是支持多人沟通的即时通讯系统，本文指导你如何使用 Agora Chat SDK 在实时互动 app 中实现群组属性相关功能。

## 技术原理

Agora Chat SDK 提供 `Group`、`IGroupManager` 和 `IGroupManagerDelegate` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：

- 修改群组名称及描述
- 获取、更新群组公告
- 管理群组共享文件
- 更新群扩展字段

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速入门](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_get_started_unity)；
- 了解 Agora Chat API 的接口调用频率限制，详见 [使用限制](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_limitation_unity)；
- 了解群组和群成员的数量限制，详见 [套餐包详情](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 修改群组名称

仅群主和群管理员可以调用 `ChangeGroupName` 方法设置和修改群组名称，群名称的长度限制为 128 个字符。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.ChangeGroupName(groupId, groupName, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 修改群组描述

仅群主和群管理员可以调用 `ChangeGroupDescription` 方法设置和修改群组描述，群描述的长度限制为 512 个字符。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.ChangeGroupDescription(groupId, description, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 更新群公告

仅群主和群管理员可以调用 `UpdateGroupAnnouncement` 方法设置和更新群公告，群公告的长度限制为 512 个字符。群公告更新后，其他群成员收到 `IGroupManagerDelegate#OnAnnouncementChangedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.UpdateGroupAnnouncement(groupId, announcement, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
       
```

### 获取群公告

所有群成员均可以调用 `GetGroupAnnouncementFromServer` 方法从服务器获取群公告。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupAnnouncementFromServer(currentGroupId, new ValueCallBack<string>(
  onSuccess: (str) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));    
```

### 管理共享文件

#### 上传共享文件

所有群组成员均可以调用 `UploadGroupSharedFile` 方法上传共享文件至群组，群共享文件大小限制为 10 MB。上传共享文件后，其他群成员收到 `IGroupManagerDelegate#OnSharedFileAddedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.UploadGroupSharedFile(groupId, filePath, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 删除共享文件

所有群成员均可以调用 `DeleteGroupSharedFile` 方法删除群共享文件。删除共享文件后，其他群成员收到 `IGroupManagerDelegate#OnSharedFileDeletedFromGroup` 回调。群主和群管理员可删除全部的群共享文件，群成员只能删除自己上传的群文件。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.DeleteGroupSharedFile(groupId, id, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 从服务器获取共享文件

所有群成员均可以调用 `GetGroupFileListFromServer` 方法从服务器获取群组的共享文件列表。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupFileListFromServer(groupId, pageNum, pageSize, handle: new ValueCallBack<List<GroupSharedFile>> (
  onSuccess: (fileList) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 更新群扩展字段

群主和群管理员可以调用 `UpdateGroupExt` 方法更新群组的扩展字段，群组扩展字段设置 JSON 格式的数据，用于自定义更多群组信息。群扩展字段的长度限制为 8 KB。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.UpdateGroupExt(currentGroupId, extension, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 监听群组事件

详见 [监听群组事件](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_group_unity?platform=Unity#%E7%9B%91%E5%90%AC%E7%BE%A4%E7%BB%84%E4%BA%8B%E4%BB%B6)。