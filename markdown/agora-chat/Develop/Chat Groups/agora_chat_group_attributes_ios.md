群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中实现群组属性相关功能。

## 技术原理

即时通讯 IM SDK 提供 `IAgoraChatGroupManager`、`AgoraChatGroupManagerDelegate` 和 `AgoraChatGroup` 类，可以实现以下功能：

- 修改群组名称及描述
- 获取、更新群组公告
- 管理群组共享文件
- 更新群扩展字段

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 修改群组名称

仅群主和群管理员可以调用 `changeGroupSubject` 方法设置和修改群组名称，群名称的长度限制为 128 个字符。

群组名称修改后，其他群成员收到 `AgoraChatGroupManagerDelegate#groupSpecificationDidUpdate` 回调。

```objective-c
[[AgoraChatClient sharedClient].groupManager changeGroupSubject:@"subject"
                                                                                                              forGroup:@"groupID"
                                                                                                                   error:nil];
```

### 修改群组描述

仅群主和群管理员可以调用 `changeDescription` 方法设置和修改群组描述，群描述的长度限制为 512 个字符。

群组描述修改后，其他群成员收到 `AgoraChatGroupManagerDelegate#groupSpecificationDidUpdate` 回调。

```objective-c
[[AgoraChatClient sharedClient].groupManager changeDescription:@"desc"
                                                                                                             forGroup:@"groupID"
                                                                                                                 error:nil];
```

### 更新群公告

仅群主和群管理员可以调用 `updateGroupAnnouncementWithId` 方法设置和更新群公告，群公告的长度限制为 512 个字符。群公告更新后，其他群成员收到 `AgoraChatGroupManagerDelegate#groupAnnouncementDidUpdate` 回调。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager updateGroupAnnouncementWithId:@"groupID"
                                                                                                                          announcement:@"announcement"
                                                                                                                                       error:nil];
```

### 获取群公告

所有群成员均可以调用 `getGroupAnnouncementWithId` 方法从服务器获取群公告。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager getGroupAnnouncementWithId:@"groupID"
                                                                                                                                   error:nil];
```

### 管理共享文件

#### 上传共享文件

所有群组成员均可以调用 `uploadGroupSharedFileWithId` 方法上传共享文件至群组，群共享文件大小限制为 10 MB。上传共享文件后，其他群成员收到 `AgoraChatGroupManagerDelegate#groupFileListDidUpdate` 回调。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager uploadGroupSharedFileWithId:@"groupID"
                                                                                                                                 filePath:@"filePath"
                                                                                                                               progress:nil
                                                                                                                             completion:nil];
```

#### 删除共享文件

所有群成员均可以调用 `removeGroupSharedFileWithId` 方法删除群共享文件。删除共享文件后，其他群成员收到 `AgoraChatGroupManagerDelegate#groupFileListDidUpdate` 回调。

群主和群管理员可删除全部的群共享文件，群成员只能删除自己上传的群文件。

```objective-c
[[AgoraChatClient sharedClient].groupManager removeGroupSharedFileWithId:@"groupID"
                                                                                                                       sharedFileId:@"fileID"
                                                                                                                                  error:nil];
```

### 从服务器获取群组的共享文件

所有群成员均可以调用 `getGroupFileListWithId` 方法获取群共享文件。

```objective-c
[[AgoraChatClient sharedClient].groupManager getGroupFileListWithId:@"groupID"
                                                                                                                  pageNumber:pageNumber
                                                                                                                    pageSize:pageSize
                                                                                                                           error:nil];
```

### 更新群扩展字段

仅群主和群管理员可以调用 `updateGroupExtWithId` 方法更新群组的扩展字段。群组扩展字段设置 JSON 格式的数据，用于自定义更多群组信息。群扩展字段的长度限制为 8 KB。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager updateGroupExtWithId:@"groupID"
                                                                                                                            ext:@"ext"
                                                                                                                        error:nil];
```

### 监听群组事件

详见 [监听群组事件](./agora_chat_group_ios#监听群组事件)。