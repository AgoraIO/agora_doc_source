# 即时通讯 REST 概览

Agora 即时通讯（Agora Chat）通过 REST 平台提供 RESTful API，你可以通过你的业务服务器向 Agora 服务器发送 HTTP 请求，在服务端实现实时通信。

## REST 平台架构

Agora 即时通讯 REST 平台提供多租户架构，以集合（Collection）的形式管理资源，一个 Collection 包含如下子集：

- 数据库（database）
- 组织（orgs）
- 应用（apps）
- 用户（users）
- 群组（chatgroups）
- 消息（chatmessages）
- 文件（chatfiles）

不同 org 之间的用户数据相互隔离；同一个 org 下，不同 app 之间的用户数据也相互隔离。一个 org 的数据架构如下图：

![](https://web-cdn.agora.io/docs-files/1642333129463)

## 前提条件

要调用 Agora 即时通讯 RESTful API，请确保满足以下要求：

- 已在 Agora 控制台[开启和配置即时通讯服务](./enable_agora_chat?platform=RESTful)。
- 已从服务端获取 app token，详见 [使用 App Token 鉴权](./generate_app_tokens?platform=RESTful)。

## 主要功能

### 用户体系集成

用户体系管理功能，包括注册、获取、修改和删除用户等。

| 名称         | 方法   | 请求                                             | 描述                  |
| :----------- | :----- | :----------------------------------------------- | :-------------------- |
| 注册单个用户 | POST   | /{org_name}/{app_name}/users                     | 注册一个用户。        |
| 批量注册用户 | POST   | /{org_name}/{app_name}/users                     | 注册多个用户。        |
| 获取单个用户 | GET    | /{org_name}/{app_name}/users/{username}          | 获取单个用户的信息。  |
| 批量获取用户 | GET    | /{org_name}/{app_name}/users                     | 获取多个用户的信息。  |
| 删除单个用户 | DELETE | /{org_name}/{app_name}/users/{username}          | 删除单个用户。        |
| 批量删除用户 | DELETE | /{org_name}/{app_name}/users                     | 删除 app 下所有用户。 |
| 修改用户密码 | PUT    | /{org_name}/{app_name}/users/{username}/password | 修改用户的密码。      |

### 设置消息离线推送

设置推送消息展示方式、显示昵称、免打扰模式等。

| 名称                 | 方法 | 请求                                    | 描述                                                            |
| :------------------- | :--- | :-------------------------------------- | :-------------------------------------------------------------- |
| 设置推送消息显示昵称 | PUT  | /{org_name}/{app_name}/users/{username} | 设置用户离线推送消息显示的昵称。                                |
| 设置推送消息展示方式 | PUT  | /{org_name}/{app_name}/users/{username} | 设置用户离线推送消息展示为仅通知还是详情可见。                  |
| 设置免打扰           | PUT  | /{org_name}/{app_name}/users/{username} | 设置用户离线推送是否开启免打扰模式，以及开启/关闭免打扰的时间。 |

### 消息发送及文件下载

从服务端发送文本、图片、语音、视频、透传、扩展、文件、自定义等各种类型的消息，以及上传和下载文件。

| 名称             | 方法 | 请求                                        | 描述                                                                                                                                           |
| :--------------- | :--- | :------------------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| 发送消息         | POST | /{org_name}/{app_name}/messages             | 聊天相关 API，一般是模拟系统管理员给用户或者群组发送消息，支持发送文本消息、图片消息、语音消息、视频消息，透传消息，扩展消息以及文件类型消息。 |
| 上传文件         | POST | /{org_name}/{app_name}/chatfiles            | 上传语音和图片等文件。                                                                                                                         |
| 下载文件         | POST | /{org_name}/{app_name}/chatfiles/{uuid}     | 下载语音和图片等文件。                                                                                                                         |
| 获取聊天记录文件 | GET  | /{org_name}/{app_name}/chatmessages/${time} | 获取聊天记录文件。                                                                                                                             |

### 用户属性

设置、获取和删除用户属性。

| 名称                       | 方法   | 请求                                            | 描述                                         |
| :------------------------- | :----- | :---------------------------------------------- | :------------------------------------------- |
| 设置用户属性               | PUT    | /{org_name}/{app_name}/metadata/user/{username} | 对指定的用户设置用户属性。                   |
| 获取指定用户的所有用户属性 | GET    | /{org_name}/{app_name}/metadata/user/{username} | 获取指定用户的所有用户属性。                 |
| 批量获取用户属性           | POST   | /{org_name}/{app_name}/metadata/user/get        | 根据指定的用户名列表和属性列表查询用户属性。 |
| 删除用户属性               | DELETE | /{org_name}/{app_name}/metadata/user/{username} | 删除指定用户的所有用户属性。                 |
| 获取用户属性总量大小       | GET    | /{org_name}/{app_name}/metadata/user/capacity   | 获取该 app 下所有用户的用户属性总大小。      |

### 用户关系管理

管理用户的好友列表和黑名单。

| 名称         | 方法   | 请求                                                                           | 描述                   |
| :----------- | :----- | :----------------------------------------------------------------------------- | :--------------------- |
| 添加好友     | POST   | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 添加为好友。           |
| 移除好友     | DELETE | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 移除好友列表中的用户。 |
| 获取好友列表 | GET    | /{org_name}/{app_name}/users/{owner_username}/contacts/users                   | 获取好友列表。         |
| 获取黑名单   | GET    | /{org_name}/{app_name}/users/{owner_username}/blocks/users                     | 获取黑名单。           |
| 添加黑名单   | POST   | /{org_name}/{app_name}/users/{owner_username}/blocks/users                     | 添加用户至黑名单。     |
| 移除黑名单   | DELETE | /{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username}  | 移除黑名单中的用户。   |

### 群组管理

创建、获取、修改和删除群组。

| 名称                            | 方法   | 请求                                           | 描述                                   |
| :------------------------------ | :----- | :--------------------------------------------- | :------------------------------------- |
| 获取 app 中所有的群组（可分页） | GET    | /{org_name}/{app_name}/chatgroups              | 获取应用下全部的群组信息。             |
| 获取一个用户参与的所有群组      | GET    | /{app_name}/users/{username}/joined_chatgroups | 根据用户名称获取此用户加入的全部群组。 |
| 获取群组详情                    | GET    | /{org_name}/{app_name}/chatgroups/{group_ids}  | 根据群组 ID 获取群组的详情。           |
| 创建一个群组                    | POST   | /{org_name}/{app_name}/chatgroups              | 创建一个群组。                         |
| 修改群组信息                    | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}   | 修改群组信息。                         |
| 删除群组                        | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}   | 删除一个群组。                         |

### 群组成员管理

管理群组成员，包括添加、移除群组成员关系列表，转让群主等。

| 名称                     | 方法   | 请求                                                                      | 描述                               |
| :----------------------- | :----- | :------------------------------------------------------------------------ | :--------------------------------- |
| 分页获取群组成员         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/users                        | 分页获取一个群组的群成员列表。     |
| 添加单个群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username}             | 添加用户至群组成员列表。           |
| 批量添加群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{chatgroupid}/users                     | 批量添加用户至群组成员列表。       |
| 移除单个群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username}             | 从群组成员列表中移除用户。         |
| 批量移除群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{usernames}            | 从群组成员列表中批量移除用户。     |
| 获取群管理员列表         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/admin                        | 获取群组管理员列表。               |
| 添加群管理员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/admin                        | 添加用户至群组管理员列表。         |
| 移除群管理员             | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/admin/{oldadmin}             | 从群组管理员列表中移除用户。       |
| 转让群组                 | PUT    | /{org_name}/{app_name}/chatgroups/{groupid}                               | 转让群主权限。                     |
| 查询群组黑名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users                 | 查询群组的黑名单列表。             |
| 添加单个用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}      | 将用户添加至群组的黑名单列表。     |
| 批量添加用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users                 | 将用户批量添加至群组的黑名单列表。 |
| 从群组黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}      | 将用户从黑名单列表中移除。         |
| 批量从群组黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{usernames}     | 批量将用户从黑名单列表中移除。     |
| 查询群组白名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/white/users                  | 查询群组白名单中的用户列表。       |
| 添加单个用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}}      | 将指定的单个用户添加至群组白名单。 |
| 批量添加用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users                 | 添加多个用户至群组白名单。         |
| 将用户移除群组白名单     | DELETE | {org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}        | 将指定用户从群组白名单中移除。     |
| 获取禁言列表             | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/mute}                        | 获得指定群组的禁言列表。           |
| 禁言指定群成员           | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/mute                         | 将指定群成员禁言。                 |
| 禁言全体成员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/ban                          | 对所有群组成员一键禁言。           |
| 解除指定成员禁言         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/mute/{member1}(,{member2},…) | 将一个或多个群成员移除禁言列表。   |
| 解除全员禁言             | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}/ban                          | 一键取消对群组全体成员的禁言。     |

### 管理子区

子区管理包括子区的创建、获取、修改、删除等。

| 名称                                             | 方法   | 请求                                                                 | 描述                                           |
| :----------------------------------------------- | :----- | :------------------------------------------------------------------- | :--------------------------------------------- |
| 获取 app 中所有的子区（分页获取）                | GET    | /{org_name}/{app_name}/thread                                        | 获取应用下全部的子区列表。                     |
| 获取一个用户加入的所有子区（分页获取）           | GET    | /{org_name}/{app_name}/threads/user/{username}                       | 根据用户 ID 获取用户加入的所有的子区。         |
| 获取一个用户某个群组下加入的所有子区（分页获取） | GET    | /{org_name}/{app_name}//threads/chatgroups/{group_id}user/{username} | 根据用户 ID 和群组 ID 获取用户加入的所有子区。 |
| 创建子区                                         | POST   | /{org_name}/{app_name}/thread                                        | 创建一个新子区。                               |
| 修改子区                                         | PUT    | /{org_name}/{app_name}/thread/{thread_id}                            | 修改子区的部分信息。                           |
| 删除子区                                         | DELETE | /{org_name}/{app_name}/thread/{thread_id}                            | 删除一个子区。                                 |

### 管理子区成员

子区成员管理包括对子区的加入和踢出等管理功能。

| 名称               | 方法   | 请求                                             | 描述                 |
| :----------------- | :----- | :----------------------------------------------- | :------------------- |
| 查询子区成员(分页) | GET    | /{org_name}/{app_name}/thread/{thread_id}/users  | 获取子区下成员列表。 |
| 批量加入子区       | POST   | /{org_name}/{app_name}/thread/{thread_id}/users  | 批量往子区添加成员。 |
| 批量踢出子区成员   | DELETE | /{org_name}/{app_name}/threads/{thread_id}/users | 批量踢出子区成员。   |

### 聊天室管理

创建、获取、修改、删除聊天室。

| 名称                    | 方法   | 请求                                                        | 描述                                     |
| :---------------------- | :----- | :---------------------------------------------------------- | :--------------------------------------- |
| 获取 app 中所有的聊天室 | GET    | /{org_name}/{app_name}/chatrooms                            | 获取应用下全部的聊天室信息。             |
| 获取用户加入的聊天室    | GET    | /{org_name}/{app_name}/users/{username}/joined_chatrooms    | 根据用户名称获取此用户加入的全部聊天室。 |
| 获取聊天室详情          | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 根据聊天室 ID 获取此聊天室的详情         |
| 创建一个聊天室          | POST   | /{org_name}/{app_name}/chatrooms                            | 创建一个新聊天室。                       |
| 修改聊天室信息          | PUT    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 修改聊天室信息。                         |
| 删除聊天室              | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 删除一个聊天室。                         |
| 获取聊天室公告          | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 获取指定聊天室 ID 的聊天室公告。         |
| 修改聊天室公告          | PUT    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 修改指定聊天室 ID 的聊天室公告。         |

### 聊天室成员管理

添加、获取、修改和删除聊天室中的成员。

| 名称                       | 方法   | 请求                                                                        | 描述                                 |
| :------------------------- | :----- | :-------------------------------------------------------------------------- | :----------------------------------- |
| 分页获取聊天室成员         | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users                        | 分页获取一个聊天室的成员列表。       |
| 添加单个聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username}              | 添加用户至聊天室成员列表。           |
| 批量添加聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroomid}/users                         | 批量添加用户至聊天室成员列表。       |
| 删除单个聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username}              | 从聊天室成员列表中删除用户。         |
| 批量删除聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{usernames}             | 从聊天室成员列表中批量删除用户。     |
| 获取聊天室管理员列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin                        | 获取聊天室管理员列表。               |
| 添加聊天室管理员           | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin                        | 添加用户至聊天室管理员列表。         |
| 移除聊天室管理员           | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin}             | 从聊天室管理员列表中移除用户。       |
| 查询聊天室黑名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users                 | 查看聊天室的黑名单列表。             |
| 添加单个用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}      | 将用户添加至聊天室的黑名单。         |
| 批量添加用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users                 | 将单个用户批量添加至聊天室的黑名单。 |
| 从聊天室黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}      | 将用户从聊天室黑名单中移除。         |
| 批量从聊天室黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{usernames}     | 批量将用户从黑名单列表中移除。       |
| 查询聊天室白名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users`                 | 查询一个聊天室白名单中的用户列表。   |
| 添加单个用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}       | 将指定的单个用户添加至聊天室白名单。 |
| 批量添加用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users                  | 添加多个用户至聊天室白名单。         |
| 将用户移除聊天室白名单     | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}       | 将指定用户从聊天室白名单移除。       |
| 获取聊天室的禁言列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute                         | 获取当前聊天室的禁言用户列表。       |
| 禁言聊天室成员             | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute                         | 将聊天室成员禁言。                   |
| 禁言聊天室全体成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban                          | 对所有聊天室成员一键禁言。           |
| 解除聊天室禁言成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member1}(,{member2},…) | 将指定用户从禁言列表中移除。         |
| 解除聊天室全员禁言         | PUT    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban                          | 一键取消对聊天室全体成员的禁言。     |

## 请求结构

### 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

### 服务器地址

同一个项目下，所有的请求均发送给同一个域名。如何获取域名，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。

### 通信协议

为了保障通信安全，Agora 即时通讯 RESTful API 仅支持 HTTPS 协议。

### 数据格式

- 请求：请求的格式详见具体 API 中的示例。
- 响应：响应内容的格式为 JSON。

> 所有的请求 URL 和请求包体内容都是区分大小写的。