群组是支持多人沟通的即时通讯系统。本页介绍如何使用即时通讯 IM SDK 管理应用中的群组属性。

## 技术原理

即时通讯 IM SDK 提供 `Group`、`GroupManager` 和 `GroupChangeListener` 类用于群组管理，可实现以下功能：

- 修改群组名称及描述
- 获取和更新群组公告
- 管理群组共享文件
- 更新群扩展字段

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 修改群组名称

仅群主和群管理员可以调用 `changeGroupName` 方法设置和修改群组名称，群名称的长度限制为 128 个字符。群组名称修改后，其他群成员收到 `GroupChangeListener#onSpecificationChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().groupManager().changeGroupName(groupId,changedGroupName);
```

### 修改群组描述

仅群主和群管理员可以调用 `changeGroupDescription` 方法设置和修改群组描述，群描述的长度限制为 512 个字符。群组描述修改后，其他群成员收到 `GroupChangeListener#onSpecificationChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().groupManager().changeGroupDescription(groupId,description);
```

### 更新群公告

仅群主和群管理员可以调用 `updateGroupAnnouncement` 方法设置和更新群公告，群公告的长度限制为 512 个字符。群公告更新后，所有群组成员都会收到 `GroupChangeListener#onAnnouncementChanged` 回调。所有群组成员都可以获取群组公告。

示例代码如下：

```java
ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, announcement);
```

### 获取群公告

所有群成员均可以调用 `fetchGroupAnnouncement` 方法从服务器获取群公告。

示例代码如下：

```java
ChatClient.getInstance().groupManager().fetchGroupAnnouncement(groupId);
```

### 管理群组共享文件

#### 上传共享文件

所有群组成员均可以调用 `uploadGroupSharedFile` 方法上传共享文件至群组，群共享文件大小限制为 10 MB。上传共享文件后，其他群成员收到 `GroupChangeListener#OnSharedFileAdded` 回调。

示例代码如下：

```java
ChatClient.getInstance().groupManager().uploadGroupSharedFile(groupId, filePath, callBack);
```

#### 下载共享文件

所有群成员均可调用 `asyncDownloadGroupSharedFile` 方法下载群组共享文件。

```java
// 同步方法，需要放到异步线程
List<MucSharedFile> sharedFiles = ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
// 获取需要的共享文件信息
MucSharedFile sharedFile = sharedFiles.get(index);
// 异步方法
ChatClient.getInstance().groupManager().asyncDownloadGroupSharedFile(groupId, sharedFile.getFileId(), savePath, new CallBack() {
    @Override
    public void onSuccess() {
        // 在这里处理 savePath 保存的文件
    }

    @Override
    public void onError(int code, String error) {

    }
});
```

#### 删除共享文件

所有群成员均可以调用 `DeleteGroupSharedFile` 方法删除群共享文件。删除共享文件后，其他群成员收到 `GroupChangeListener#OnSharedFileDeleted` 回调。

群主和群管理员可删除全部的群共享文件，群成员只能删除自己上传的群文件。

示例代码如下：

```java
ChatClient.getInstance().groupManager().deleteGroupSharedFile(groupId, fileId);
```

#### 从服务器获取共享文件

所有群成员均可以调用 `fetchGroupSharedFileList` 方法从服务器获取群组的共享文件列表。示例代码如下：

```java
ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
```

### 更新群扩展字段

仅群主和群管理员可以调用 `updateGroupExtension` 方法更新群组的扩展字段，群组扩展字段设置 JSON 格式的数据，用于自定义更多群组信息。群扩展字段的长度限制为 8 KB。

示例代码如下：

```java
ChatClient.getInstance().groupManager().updateGroupExtension(groupId,extension);
```

### 监听群组事件

详见 [监听群组事件](./agora_chat_group_android?platform=Android#监听群组事件)。