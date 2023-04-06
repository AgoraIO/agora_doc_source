即时通讯通过 REST 平台提供 RESTful API，你可以通过你的业务服务器向 Agora 服务器发送 HTTP 请求，在服务端实现实时通信。

## RESTful 平台架构

即时通讯 REST 平台提供多租户架构，以集合（Collection）的形式管理资源，一个集合包含如下子集：

- 数据库（database）
- 组织（orgs）
- 应用（apps）
- 用户（users）
- 群组（chatgroups）
- 消息（chatmessages）
- 文件（chatfiles）

不同组织之间的用户数据相互隔离；同一组织下，不同 app 之间的用户数据也相互隔离。一个组织的数据架构如下图：

![](https://web-cdn.agora.io/docs-files/1642333129463)

## 前提条件

要调用即时通讯 RESTful API，请确保满足以下要求：

- 已在 Agora 控制台[开启和配置即时通讯服务](./enable_agora_chat?platform=RESTful)。
- 已从服务端获取应用权限 token，详见 [使用 Token 鉴权](./agora_chat_token?platform=RESTful)。

## 请求结构

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

### 服务器地址

同一个项目下，所有的请求均发送给同一个域名。如何获取域名，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。

### 通信协议

为了保障通信安全，即时通讯 RESTful API 仅支持 HTTPS 协议。

### 数据格式

- 请求：请求的格式详见具体 API 中的示例。
- 响应：响应内容的格式为 JSON。

> 所有的请求 URL 和请求包体内容都是区分大小写的。

## 主要特性

### 用户体系集成

用户体系管理功能，包括注册、获取、修改和删除用户等。

| 接口名称                   | 方法   | 请求                                                                  | 描述                       |
| :--------------------- | :----- | :-------------------------------------------------------------------- | :------------------------- |
| 注册单个用户           | POST   | /{org_name}/{app_name}/users                                          | 注册一个用户。             |
| 批量注册用户           | POST   | /{org_name}/{app_name}/users                                          | 一次注册多个用户。             |
| 查询单个用户的详情           | GET    | /{org_name}/{app_name}/users/{username}                               | 查询单个用户的详细信息。     |
| 批量查询用户详情          | GET    | /{org_name}/{app_name}/users                                          | 查询多个用户的信息列表。       |
| 删除单个用户           | DELETE | /{org_name}/{app_name}/users/{username}                               | 删除单个用户。             |
| 批量删除用户           | DELETE | /{org_name}/{app_name}/users                                          | 批量删除用户。      |
| 修改用户密码           | PUT    | /{org_name}/{app_name}/users/{username}/password                      | 修改用户的密码。           |
| 封禁用户               | POST   | /{org_name}/{app_name}/users/{username}/deactivate                  | 禁用一个用户账户。               |
| 解禁用户         | POST   | /{org_name}/{app_name}/users/{username}/activate                    | 解禁一个已被禁用的用户账户。             |
| 强制用户离线           | POST   | /{org_name}/{app_name}/users/{username}/disconnect                  | 强制下线一个用户，被下线的用户需要重新登录才能正常使用。         |
| 获取单个用户在线状态           | GET    | /{org_name}/{app_name}/users/{username}/status                      | 查看单个用户是在线还是离线状态。         |
| 批量获取用户在线状态 | POST   | /{org_name}/{app_name}/users/batch/status                           | 批量查看用户的在线状态。 |
| 获取用户离线消息数量       | GET    | /{org_name}/{app_name}/users/{owner_username}/offline_msg_count     | 获取即时通讯用户的离线消息数量。 |
| 查询离线消息的投递状态 | GET    | /{org_name}/{app_name}/users/{username}/offline_msg_status/{msg_id} | 查询离线消息是否已投递。   |

### 全局禁言

| 接口名称    | 方法 | 接口 URL       | 描述 |
| :-------------- | :--- | :----------------- | :------------------------- |
| 设置用户全局禁言       | POST | /{org_name}/{app_name}/mutes         | 设置指定用户的单聊、群组或聊天室的全局禁言。         |
| 查询单个用户 ID 全局禁言        | GET  | /{org_name}/{app_name}/mutes/username | 查询单个用户的单聊、群聊和聊天室的全局禁言详情。       |
| 查询 app 下的所有全局禁言的用户 | GET  | /{org_name}/{app_name}/mutes         | 查询 app 下所有全局禁言的用户及其禁言剩余时间。          |

### 发送消息和上传/下载文件

从服务端发送文本、图片、语音、视频、透传、扩展、文件、自定义等各种类型的消息，以及上传和下载文件。

| 接口名称                 | 方法   | 请求                              | 描述           |
| :------------------- | :----- | :------------------------ | :------------------------- |
| 发送消息             | POST   | /{org_name}/{app_name}/messages                      | 聊天相关 API，一般是模拟系统管理员给用户、群组或聊天室发送消息，支持发送文本消息、图片消息、语音消息、视频消息，透传消息，扩展消息以及文件类型消息。 |
| 上传文件             | POST   | /{org_name}/{app_name}/chatfiles                     | 上传语音和图片等文件。    |
| 下载文件/缩略图             | GET   | /{org_name}/{app_name}/chatfiles/{file_uuid}              | 下载语音和图片等文件或者下载图片或视频文件的缩略图。    |
| 获取聊天历史消息记录 | GET    | /{org_name}/{app_name}/chatmessages/${time}          | 获取聊天历史消息记录。   |
| 撤回消息             | POST   | /{org_name}/{app_name}/messages/msg_recall    | 在消息发送两分钟之内撤回消息。                                                                                                                 |
| 服务端单向删除会话   | DELETE | /{org_name}/{app_name}/users/{username}/user_channel | 从服务器中删除对话。                                                                                                                           |
| 导入单聊消息   | POST | /{org_name}/{app_name}/messages/users/import | 数据迁移时单聊消息的批量导入。           |
| 导入群聊消息   | POST | /{org_name}/{app_name}/messages/chatgroups/import | 导入群聊消息    |

### 用户关系管理

用户关系管理包括用户的好友列表和黑名单的管理。

| 接口名称         | 方法   | 请求                | 描述      |
| :----------- | :----- | :-------------- | :--------- |
| 添加好友     | POST   | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 添加为好友。           |
| 移除好友     | DELETE | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 移除好友列表中的用户。 |
| 获取好友列表 | GET    | /{org_name}/{app_name}/users/{owner_username}/contacts/users                   | 获取好友列表。         |
| 获取黑名单   | GET    | /{org_name}/{app_name}/users/{owner_username}/blocks/users                     | 获取当前用户的黑名单列表。           |
| 添加用户至黑名单   | POST   | /{org_name}/{app_name}/users/{owner_username}/blocks/users                     | 将指定用户添加到黑名单。     |
| 从黑名单中移除用户  | DELETE | /{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username}  | 移除黑名单中的用户。   |

### 用户属性

用户属性管理包括设置、获取和删除用户属性。

| 接口名称          | 方法   | 请求                    | 描述                          |
| :------------------------- | :----- | :---------------- | :-------------------- |
| 设置用户属性               | PUT    | /{org_name}/{app_name}/metadata/user/{username} | 对指定的用户设置用户属性。                   |
| 获取指定用户的所有用户属性 | GET    | /{org_name}/{app_name}/metadata/user/{username} | 获取指定用户的所有用户属性。                 |
| 批量获取用户属性           | POST   | /{org_name}/{app_name}/metadata/user/get        | 根据指定的用户 ID 列表和属性列表查询用户属性。 |
| 删除用户属性               | DELETE | /{org_name}/{app_name}/metadata/user/{username} | 删除指定用户的所有用户属性。                 |
| 获取 app 下的用户属性总大小       | GET    | /{org_name}/{app_name}/metadata/user/capacity   | 获取该 app 下所有用户的用户属性总大小。      |

### 群组管理

创建、获取、修改和删除群组。

| 接口名称                            | 方法   | 请求                                           | 描述                                   |
| :------------------------------ | :----- | :--------------------------------------------- | :------------------------------------- |
| 创建群组                    | POST   | /{org_name}/{app_name}/chatgroups              | 创建一个群组。                         |
| 封禁群组                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/disable              | 封禁指定的群组。  |
| 解禁群组                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/enable              | 解禁指定的群组。  |
| 获取群组详情                    | GET    | /{org_name}/{app_name}/chatgroups/{group_ids}  | 根据群组 ID 获取群组的详情。           |
| 修改群组信息                    | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}   | 修改群组信息。                         |
| 删除群组                        | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}   | 删除一个群组。                         |
| 获取 app 中的所有群组 | GET    | /{org_name}/{app_name}/chatgroups?limit={N}&cursor={cursor}             | 分页获取应用下全部的群组信息。             |
| 获取单个用户加入的所有群组      | GET    | /{org_name}/{app_name}/users/{username}/joined_chatgroups?pagesize={}&pagenum={} | 根据用户 ID 称获取此用户加入的全部群组。 |
| 获取群组公告                    | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/announcement     | 获取指定群组 ID 的群组公告。 |
| 修改群组公告                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/announcement     | 修改指定群组 ID 的群公告。 |
| 获取群组共享文件                | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/share_files | 分页获取指定群组 ID 的群共享文件。 |
| 上传群组共享文件                | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/share_files      | 上传指定群组 ID 的群共享文件。 |
| 下载群组共享文件                | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id} | 根据指定的群组 ID 和文件 ID 下载群共享文件。   |
| 删除群组共享文件                | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id} | 根据指定的群组 ID 和文件 ID 删除群共享文件。|

### 群组成员管理

管理群组成员，包括添加、移除群组成员关系列表，转让群主等。

| 接口名称                     | 方法   | 请求              | 描述              |
| :----------------------- | :----- | :---------------------- | :--------------------- |
| 分页获取群组成员         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/users?pagenum={N}&pagesize={N}                        | 分页获取指定群组的群成员列表。     |
| 添加单个群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username}             | 添加群成员至群组成员列表。           |
| 批量添加群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/users                     | 批量添加用户至群组成员列表。       |
| 移除单个群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username}             | 从群组成员列表中移除用户。         |
| 批量移除群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{usernames}            | 从群组成员列表中批量移除用户。     |
| 获取群管理员列表         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/admin                        | 获取群组管理员列表。               |
| 添加群管理员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/admin                        | 添加用户至群组管理员列表。         |
| 移除群管理员             | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/admin/{oldadmin}             | 从群组管理员列表中移除用户。       |
| 转让群组                 | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}                               | 转让群主权限。                     |
| 查询群组黑名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users                 | 查询群组的黑名单列表。             |
| 添加单个用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}      | 将用户添加至群组的黑名单列表。     |
| 批量添加用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users                 | 将用户批量添加至群组的黑名单列表。 |
| 从群组黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}      | 将用户从黑名单列表中移除。         |
| 批量从群组黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{usernames}     | 批量将用户从黑名单列表中移除。     |
| 查询群组白名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/white/users                  | 查询群组白名单中的用户列表。       |
| 添加单个用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}      | 将指定的单个用户添加至群组白名单。 |
| 批量添加用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/white/users                | 添加多个用户至群组白名单。         |
| 将用户移除群组白名单     | DELETE | {org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}        | 将指定用户从群组白名单中移除。     |
| 获取禁言列表             | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/mute                       | 获得指定群组的禁言列表。           |
| 禁言指定群成员           | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/mute                         | 将指定群成员禁言。                 |
| 禁言全体群成员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/ban                          | 对所有群组成员一键禁言。           |
| 解除指定成员禁言         | DELETE   | /{org_name}/{app_name}/chatgroups/{group_id}/mute/{member_id} | 将一个或多个群成员移除禁言列表。   |
| 解除全员禁言             | DELETE    | /{org_name}/{app_name}/chatgroups/{group_id}/ban                          | 一键取消对群组全体成员的禁言。     |

### 聊天室管理

聊天室管理包括创建、获取、修改和删除聊天室。

| 接口名称                    | 方法   | 请求                                                        | 描述                                     |
| :---------------------- | :----- | :---------------------------------------------------------- | :--------------------------------------- |
| 创建聊天室          | POST   | /{org_name}/{app_name}/chatrooms                            | 创建一个新聊天室。                       |
| 获取 app 中所有的聊天室 | GET    | /{org_name}/{app_name}/chatrooms?limit={N}&cursor={cursor}   | 分页获取应用下全部的聊天室信息。             |
| 获取用户加入的聊天室    | GET    | /{org_name}/{app_name}/users/{username}/joined_chatrooms    | 根据用户 ID 获取该用户加入的全部聊天室。 |
| 查询指定聊天室详情         | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 查询一个或多个聊天室的详情。       |
| 修改聊天室信息          | PUT    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 修改聊天室信息。                         |
| 删除聊天室              | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 删除一个聊天室。                         |
| 获取聊天室公告          | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 获取指定聊天室 ID 的聊天室公告。         |
| 修改聊天室公告          | POST    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 修改指定聊天室 ID 的聊天室公告。         |
| 设置聊天室自定义属性     | PUT    | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username} | 指定用户设置特定聊天室的自定义属性。        |
| 获取聊天室自定义属性          | POST    | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id} | 获取指定聊天室的自定义属性信息。         |
| 强制设置聊天室自定义属性 | PUT | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced | 用户强制设置指定聊天室的自定义属性信息，即该方法可覆盖其他用户设置的聊天室自定义属性。  |
| 删除聊天室自定义属性 | DELETE  | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username} | 用户删除其设置的聊天室自定义属性。该方法只能删除当前用户设置的聊天室自定义属性，不能删除其他成员设置的自定义属性。  |
| 强制删除聊天室自定义属性 | DELETE  | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced | 用户强制删除聊天室的自定义属性信息，即该方法除了会删除当前用户设置的聊天室自定义属性，还可以删除其他用户设置的自定义属性。 |

### 聊天室成员管理

聊天室成员管理，包括添加和移除聊天室成员以及设置和移除聊天室管理员。

| 接口名称                       | 方法   | 请求                              | 描述            |
| :------------------------- | :----- | :---------------------------------- | :------------------------- |
| 添加聊天室超级管理员           | POST | /{org_name}/{app_name}/chatrooms/super_admin             | 添加一个超级管理员。该超级管理员拥有聊天室创建权限。       |
| 撤销聊天室超级管理员           | DELETE | /{org_name}/{app_name}/chatrooms/super_admin/{superAdmin}             | 撤销指定用户的聊天室超级管理员角色，使之成为普通聊天室成员，将不能再创建聊天室。      |
| 分页查询聊天室超级管理员           | GET | /{org_name}/{app_name}/chatrooms/super_admin?pagenum={N}&pagesize={N}             | 查询指定页码的聊天室超级管理员列表。       |
| 分页获取聊天室成员         | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users?pagenum={N}&pagesize={N}                        | 分页获取一个聊天室的成员列表。       |
| 添加单个聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username}              | 向聊天室添加一名用户。           |
| 批量添加聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users                         | 向聊天室添加多名用户。       |
| 删除单个聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username}              | 从聊天室成员列表中删除用户。         |
| 批量删除聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{usernames}             | 从聊天室成员列表中批量删除用户。     |
| 获取聊天室管理员列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin                        | 获取聊天室管理员列表。               |
| 添加单个聊天室管理员           | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin                        | 将一个聊天室普通成员设置为聊天室管理员。 |
| 移除聊天室管理员权限           | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin}             | 从聊天室管理员列表中移除用户。       |
| 查询聊天室黑名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users                 | 查看聊天室的黑名单列表。             |
| 添加单个用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}      | 将用户添加至聊天室的黑名单。         |
| 批量添加用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users                 | 将单个用户批量添加至聊天室的黑名单。 |
| 从聊天室黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}      | 将用户从聊天室黑名单中移除。         |
| 批量从聊天室黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{usernames}     | 批量将用户从黑名单列表中移除。       |
| 查询聊天室白名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users                 | 查询一个聊天室白名单中的用户列表。   |
| 添加单个用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}       | 将指定的单个用户添加至聊天室白名单。 |
| 批量添加用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users                  | 添加多个用户至聊天室白名单。         |
| 将用户移除聊天室白名单     | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}       | 将指定用户从聊天室白名单移除。       |
| 禁言聊天室单个成员             | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute                         | 将聊天室成员禁言。                   |
| 禁言聊天室全体成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban                          | 对所有聊天室成员一键禁言。           |
| 解除聊天室禁言成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member} | 将指定用户从禁言列表中移除。         |
| 解除聊天室全员禁言         | DELETE    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban                          | 一键取消对聊天室全体成员的禁言。     |
| 获取聊天室的禁言列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute                         | 获取当前聊天室的禁言用户列表。       |

### 推送

### IM 离线推送

IM 离线推送包括设置推送消息展示方式、显示昵称、免打扰模式等。

| 接口名称                 | 方法 | 请求                                    | 描述                                                            |
| :------------------- | :--- | :-------------------------------------- | :-------------------------------------------------------------- |
| 设置离线推送时显示的昵称 | PUT  | /{org_name}/{app_name}/users/{username} | 设置用户离线推送消息显示的昵称。                                |
| 设置离线推送通知的展示方式 | PUT  | /{org_name}/{app_name}/users/{username} | 设置用户离线推送消息展示为仅通知还是展示消息详情。                  |
| 设置推送通知          | PUT  | /{org}/{app}/users/{username}/notification/{chattype}/{key} | 在应用和会话级别设置推送通知方式和免打扰模式。 |
| 获取推送通知的设置          | GET  | /{org}/{app}/users/{username}/notification/{chattype}/{key} | 查询指定单聊、指定群聊或全局的离线推送设置。 |
| 设置推送通知的首选语言         | PUT  | /{org_name}/{app_name}/users/{username}/notification/language | 设置推送通知的首选语言。 |
| 获取推送通知的首选语言        | GET  | /{org_name}/{app_name}/users/{username}/notification/language | 在应用和会话级别设置推送通知方式和免打扰模式。 |
| 创建推送模板         | POST  | /{org_name}/{app_name}/notification/template | 创建推送通知模板。 |
| 查询离线推送模板         | GET  | /{org_name}/{app_name}/notification/template/{name} | 查询离线推送消息使用的模板。 |
| 删除推送模板         | DELETE  | /{org_name}/{app_name}/notification/template/{name} | 删除推送通知的指定模板。 |

### Agora 推送

Agora 推送包括推送标签管理和发送推送通知。

| 接口名称        | 方法 | 请求         | 描述 |
| :------------------- | :--- | :------------------- |:-------------------------------------------------------------- |
| 创建推送标签 | POST  | /{org_name}/{app_name}/push/label | 为推送的目标用户添加标签，对用户进行分组，实现精细化推送。          |
| 查询指定的推送标签 | GET  | /{org_name}/{app_name}/push/label/{labelname} | 查询指定的推送标签。          |
| 分页查询推送标签 | GET  | /{org_name}/{app_name}/push/label | 分页查询推送标签。          |
| 删除指定的推送标签 | DELETE  | /{org_name}/{app_name}/push/label/{labelname} | 删除指定的推送标签。          |
| 在推送标签下添加用户 | POST  | /{org_name}/{app_name}/push/label/{labelname}/user | 为用户分配指定的推送标签。          |
| 查询标签下的指定用户 | GET  | /{org_name}/{app_name}/push/label/{labelname}/user/{username} | 查询推送标签是否存在指定用户。          |
| 分页查询指定标签下的用户 | GET  | /{org_name}/{app_name}/push/label/{labelname}/user | 分页查询指定标签下包含的用户。          |
| 批量移出指定推送标签下的用户 | DELETE  | /{org_name}/{app_name}/push/label/{labelname}/user | 一次移除指定推送标签下的单个或多个用户。          |
| 向指定用户发送推送通知 | POST  | /{org_name}/{app_name}/push/single | 向单个或多个用户发送推送通知。           |
| 对指定标签下的用户发送推送通知 | POST  | /{org_name}/{app_name}/push/list/label | 对指定标签下的用户发送推送通知。若传单个标签，则向单个标签内的所有用户发送推送通知。若传多个标签，则消息推送给同时存在这些标签中的用户，即取标签中的用户交集。         |
| 对 app 下的所有用户发送推送通知 | POST  | /{org_name}/{app_name}/push/task | 对 app 下的所有用户发送推送通知。          |


### 用户在线状态管理

用户在线状态管理包括设置用户在线状态信息、订阅和获取在线状态以及查询订阅列表。

| 接口名称       | 方法   | 请求         |  描述 |
| :------------- | :----- | :----------- | :------------------------ |
| 设置用户在线状态信息 | POST   | /{org_name}/{app_name}/users/{username}/presence/{resource}/{status} | 根据用户的唯一 ID 设置在线状态信息。       |
| 批量订阅在线状态     | POST   | /{org_name}/{app_name}/users/{username}/presence/{expiry}         | 一次可订阅多个用户的在线状态。     |
| 批量获取在线状态信息 | POST   | /{org_name}/{app_name}/users/{username}/presence                  | 一次可获取多个用户的在线状态信息。      |
| 取消订阅多个用户的在线状态   | DELETE | /{org_name}/{app_name}/users/{username}/presence                  | 取消订阅多个用户的在线状态。     |
| 查询订阅列表         | GET    | /{org_name}/{app_name}/users/{username}/presence/sublist?pageNum=1&pageSize=100 | 查询当前用户已订阅在线状态的用户列表。   |


### 消息表情回复 Reaction

消息表情回复 Reaction 管理包括创建/添加、获取和删除 Reaction。

| 接口名称      | 方法   | 请求        |  描述 |
| :------------------- | :----- | :------------------------ |
| 创建/添加 Reaction         | POST   | /{org_name}/{app_name}/reaction/user/{username}   | 在单聊和群聊场景中在单条消息上创建或添加 Reaction。|
| 根据消息 ID 获取 Reaction     | GET    | /{org_name}/{app_name}/reaction/user/{username}?msgIdList={N,M}&msgType={msgType}&groupId={groupId}  | 根据单聊或群聊中的消息 ID 获取单个或多个消息的 Reaction 信息。 |
| 删除 Reaction     | DELETE | /{org_name}/{app_name}/reaction/user/{username}?msgId={msgId}&message={message} | 删除当前用户追加的 Reaction。  |
| 根据消息 ID 和表情 ID 获取 Reaction 信息 | GET    | /{org_name}/{app_name}/reaction/user/{username}/detail?msgId={msgId}&message={message}&limit={limit}&cursor={cursor} | 根据指定的消息的 ID 和表情 ID 获取对应的 Reaction 信息，包括使用了该 Reaction 的用户 ID 及用户人数。  |

### 管理子区

子区管理包括子区的创建、获取、修改、删除等。

| 接口名称                  | 方法   | 请求                    | 描述            |
| :------------------------ | :----- | :---------------------------- | :--------------------- |
| 创建子区      | POST   | /{org_name}/{app_name}/thread                                        | 创建一个新子区。                               |
| 修改子区       | PUT    | /{org_name}/{app_name}/thread/{thread_id}                            | 修改子区的部分信息。                           |
| 删除子区     | DELETE | /{org_name}/{app_name}/thread/{thread_id}                            | 删除一个子区。                                 |
| 获取 app 中所有的子区              | GET    | /{org_name}/{app_name}/thread?limit={limit}&cursor={cursor}&sort={sort}        | 分页获取应用下全部的子区列表。    |
| 获取单个用户在应用下加入的所有子区          | GET    | /{org_name}/{app_name}/threads/user/{username}?limit={limit}&cursor={cursor}&sort={sort}   | 根据用户 ID 分页获取用户加入的所有的子区。   |
| 获取用户在群组下加入的所有子区 | GET    | /{org_name}/{app_name}/threads/chatgroups/{group_id}/user/{username}?limit={limit}&cursor={cursor}&sort={sort} | 根据用户 ID 和群组 ID 分页获取用户加入的所有子区。 |

### 管理子区成员

子区成员管理包括对子区的加入和移除等管理功能。

| 接口名称               | 方法   | 请求                                             | 描述                 |
| :----------------- | :----- | :----------------------------------------------- | :------------------- |
| 获取子区成员 | GET    | /{org_name}/{app_name}/thread/{thread_id}/users?limit={N}&cursor={cursor}  | 获取指定子区中的所有成员。 |
| 批量加入子区       | POST   | /{org_name}/{app_name}/thread/{thread_id}/users  | 将多个用户添加到指定子区。 |
| 批量删除子区成员   | DELETE | /{org_name}/{app_name}/threads/{thread_id}/users | 从指定子区中删除多个用户。 |