本文主要介绍即时通讯的使用限制条件，包括用户、消息、群组、聊天室相关限制以及服务端 API 调用频率限制。

如果以下限制条件无法满足你的实际业务需求，你可以联系技术支持申请调整限制。

## 用户相关

### 用户数量

根据不同的套餐版本，用户及好友数量限制如下：

| 套餐版本 | 用户好友人数 | 注册用户总数 | 同时在线用户数 |
| :------- | :----------- | :----------- | :------------- |
| 免费版   | 100          | 100          | 100            |
| 基础版   | 3,000        | 无上限       | 无上限         |
| 进阶版   | 无上限       | 无上限       | 无上限         |
| 企业版   | 无上限       | 无上限       | 无上限         |

用户 ID 为用户的唯一登录账号，长度在 64 个字符内，支持以下字符集：
- 26 个小写英文字母 a-z
- 26 个大写英文字母 A-Z
- 10 个数字 0-9
- "_", "-", "."
<div class="alert note"><li>不区分大小写。<li>同一个 app 下，用户 ID 唯一。<li>`username` 用户 ID 是公开信息，请勿使用 UUID、邮箱地址、手机号等敏感信息。</div>

### 用户属性

用户属性包括用户头像、昵称、邮箱等属性信息，总长度必须在 2 KB 以内， 一个 app 下所有用户属性的总长度必须在 10 GB 以内。

## 消息相关

### 消息存储时长

即时通讯提供消息云存储服务，包括历史消息、漫游消息、离线消息。

根据不同的套餐版本，消息存储时长（在即时通讯服务器上的保存的最长时间）如下：

| 套餐版本 | 消息存储时长（天） |
| :------- | :----------------- |
| 免费版   | 3                  |
| 基础版   | 7                  |
| 进阶版   | 90                 |
| 企业版   | 180                |

### 消息长度

对于不同的消息类型，消息长度限制如下：

| 消息类型       | 消息长度限制                         | 
| :------------- | :----------------------------------- | 
| 文本消息       | 3 KB。                                | 
| 图片消息       | 消息长度上限为 3 KB，图片文件不能超过 10 MB。  | 
| 语音消息       | 消息长度上限为 3 KB，语音文件不能超过 10 MB。  | 
| 视频消息       | 消息长度上限为 3 KB，视频文件不能超过 10 MB。 | 
| 文件消息       | 消息长度上限为 3 KB，文件不能超过 10 MB。 | 
| 透传消息       | 3 KB。                                 | 
| 消息自定义扩展 | 扩展消息大小不能超过原类型消息的大小。 | 
| 自定义消息     | 3 KB。                                 | 

## 群组相关

### 群组数量

根据不同的套餐版本，群组数量限制如下：

| 套餐版本 | 群组总数 | 群成员数 | 用户可加入群组数 |
| :------- | :------- | :------- | :--------------- |
| 免费版   | 100      | 100      | 100              |
| 基础版   | 100,000  | 300      | 600              |
| 进阶版   | 无上限   | 3,000    | 无上限           |
| 企业版   | 无上限   | 8,000    | 无上限           |

### 群组属性

当创建群组时，群组基础属性长度限制如下：

- 群组名称：128 个字符以内；
- 群组描述：512 个字符以内；
- 群组扩展信息：1024 个字符以内。

## 聊天室相关

### 聊天室数量

根据不同的套餐版本，聊天室数量限制如下：

| 套餐版本 | 聊天室总数 | 聊天室成员数 | 用户可加入聊天室数 |
| :------- | :--------- | :----------- | :----------------- |
| 免费版   | 无   | 无      | 无             |
| 基础版   | 100        | 无上限       | 无上限             |
| 进阶版   | 无上限     | 无上限       | 无上限             |
| 企业版   | 无上限     | 无上限       | 无上限             |

### 聊天室属性

当创建聊天室时，聊天室属性长度限制如下：

- 聊天室名称：128 个字符以内；
- 聊天室描述：512 个字符以内；

聊天室的自定义属性，存储为键值对（key-value）集合。在每个键值对中，key 为属性名称，value 为属性值。

每个聊天室最多可有 100 个自定义属性，每个应用的聊天室自定义属性总大小不超过 10 GB。

聊天室自定义属性为键值对（key-value）结构，单个 key 不能超过 128 个字符，支持以下字符集：
- 26 个小写英文字母 a-z；
- 26 个大写英文字母 A-Z；
- 10 个数字 0-9；
- “_”, “-”, “.”。

每个聊天室属性 value 不能超过 4096 个字符。

## 服务端接口调用频率限制

- 除获取聊天记录文件 RESTful API，所有即时通讯 RESTful API 的调用频率都针对单个 IP 地址。
- 获取聊天记录文件 API 的调用频率上限为针对单个 app 1 次/分钟。
- 除部分 API 接口有特殊说明外，API 调用频率限制默认为 100 次/秒，具体每个接口限制以下表为准。

按模块查看接口调用频率限制：

### 用户帐号管理<a name="account"></a>

| RESTful API 接口        | 方法   | 接口 URL             | 接口最高调用频率（默认值） |
| :------------------- | :----- | :------------------- | :------------------------- |
| 注册单个用户  | POST | /{org_name}/{app_name}/users | 100 次/秒/App Key          |
| 批量注册用户  | POST | /{org_name}/{app_name}/users | 100 次/秒/App Key          |
| 设置推送消息显示昵称 | PUT  | /{org_name}/{app_name}/users/{username} | 
| 设置推送消息展示方式 | PUT  | /{org_name}/{app_name}/users/{username} | 

以上四个接口的总调用频率（默认值）为 100 次/秒/App Key。

| RESTful API 接口        | 方法   | 接口 URL             | 接口最高调用频率（默认值） |
| :------------------- | :----- | :------------------- | :------------------------- |
| 获取 app/用户 token  | POST   | /{org_name}/{app_name}/token       | 300 次/秒/App Key |
| 获取单个用户         | GET    | /{org_name}/{app_name}/users/{username}                      | 100 次/秒/App Key  |
| 批量获取用户         | GET    | /{org_name}/{app_name}/users                                 | 100 次/秒/App Key          |
| 删除单个用户         | DELETE | /{org_name}/{app_name}/users/{username}                      | 100 次/秒/App Key          |
| 批量删除用户         | DELETE | /{org_name}/{app_name}/users                                 | 30 次/秒/App Key           |
| 修改用户密码         | POST   | /{org_name}/{app_name}/users/{username}/password             | 100 次/秒/App Key          |
| 获取用户在线状态     | GET    | /{org_name}/{app_name}/users/{username}/status               | 100 次/秒/App Key          |
| 批量获取用户在线状态 | POST   | /{org_name}/{app_name}/users/batch/status                    | 50 次/秒/App Key           |
| 获取离线消息数       | GET    | /{org_name}/{app_name}/users/{owner_username}/offline_msg_count | 100 次/秒/App Key          |
| 获取离线消息的投递状态   | GET    | /{org_name}/{app_name}/users/{username}/offline_msg_status/{msg_id} | 100 次/秒/App Key          |
| 账号封禁             | POST   | /{org_name}/{app_name}/users/{username}/deactivate           | 100 次/秒/App Key          |
| 账号解禁             | POST   | /{org_name}/{app_name}/users/{username}/activate             | 100 次/秒/App Key          |
| 强制下线             | GET    | /{org_name}/{app_name}/users/{username}/disconnect           | 100 次/秒/App Key          |

### 全局禁言

| RESTful API 接口    | 方法 | 接口 URL       | 接口最高调用频率（默认值） |
| :-------------- | :--- | :----------------- | :------------------------- |
| 设置用户全局禁言       | POST | /{org_name}/{app_name}/mutes         | 100 次/秒/App Key          |
| 查询单个用户 ID 全局禁言        | GET  | /{org_name}/{appName}/mutes/username | 100 次/秒/App Key          |
| 查询 app 下的所有全局禁言的用户 | GET  | /{org_name}/{app_name}/mutes         | 100 次/秒/App Key          |

### 消息管理

| RESTful API 接口                | 方法   | 接口 URL                                             | 接口最高调用频率（默认值）                                   |
| :--------------------------- | :----- | :---------------- | :-------------------- |
| 发送单聊消息                 | POST   | /{org_name}/{app_name}/messages/users                | 6000 条/分钟/App Key                                         |
| 发送群聊消息                 | POST   | /{org_name}/{app_name}/messages/chatgroups           | 20 条/秒/App Key                                             |
| 发送聊天室消息               | POST   | /{org_name}/{app_name}/messages/chatrooms            | 100 条/秒/App Key                                            |
| 上传文件                     | POST   | /{org_name}/{app_name}/chatfiles                     | 100 次/秒/App Key                                            |
| 下载文件/缩略图                     | GET    | /{org_name}/{app_name}/chatfiles/{file_uuid}              | 100 次/秒/App Key                                            |
| 获取历史消息记录 | GET    | /{org_name}/{app_name}/chatmessages/${time}          | 10 次/分钟/App Key                                           |
| 服务端消息撤回               | POST   | {org_name}/{app_name}/messages/recall                | 100 次/秒/App Key                                            |
| 服务端单向删除会话           | DELETE | /{org_name}/{app_name}/users/{username}/user_channel    | 5 次/分钟/单用户 ID，100 次/秒/App Key                                            |
| 拉取会话列表                 | GET    | /{org_name}/{app_name}/user/{username}/user_channels | 5 次/分钟/单用户 ID，100 次/秒/App Key                       |
| 导入单聊消息                 | POST    | /{org_name}/{app_name}/messages/users/import | 100 次/秒/App Key                       |
| 导入群聊消息                 | POST    | /{org_name}/{app_name}/messages/chatgroups/import | 100 次/秒/App Key    |

### 消息推送

#### IM 离线推送

| RESTful API 接口        | 方法 | 接口 URL           | 接口最高调用频率（默认值） |
| :------------------- | :--- | :------------------- |
| 设置离线推送         | PUT  | /{org}/{app}/users/{username}/notification/{chattype}/{key} | 100 次/秒/App Key          |
| 查询离线推送设置     | GET  | /{org}/{app}/users/{username}/notification/{type}/{key} | 100 次/秒/App Key          |
| 设置推送翻译语言     | PUT  | /{org}/{app}/users/{username}/notification/language | 100 次/秒/App Key          |
| 查询离线推送消息的翻译语言 | PUT  | /{org}/{app}/users/{username}/notification/language | 100 次/秒/App Key  |
| 创建离线推送模板          | POST  | /{org}/{app}/notification/template | 10 次/秒/App Key  |
| 查询离线推送模板          | GET  | /{org}/{app}/notification/template/{name} | 10 次/秒/App Key  |
| 删除离线推送模板          | DELETE  | /{org}/{app}/notification/template/{name} | 10 次/秒/App Key  |

#### Agora 推送

| RESTful API 接口        | 方法 | 接口 URL           | 
| :------------------- | :--- | :------------------- |
| 创建推送标签 | POST  | /{org_name}/{app_name}/push/label | 
| 查询指定的推送标签 | GET  | /{org_name}/{app_name}/push/label/{labelname} |   
| 分页查询推送标签 | GET  | /{org_name}/{app_name}/push/label |     
| 删除指定的推送标签 | DELETE  | /{org_name}/{app_name}/push/label/{labelname} |      
| 在推送标签下添加用户 | POST  | /{org_name}/{app_name}/push/label/{labelname}/user |     
| 查询标签下的指定用户 | GET  | /{org_name}/{app_name}/push/label/{labelname}/user/{username} |      
| 分页查询指定标签下的用户 | GET  | /{org_name}/{app_name}/push/label/{labelname}/user |       
| 批量移出指定推送标签下的用户 | DELETE  | /{org_name}/{app_name}/push/label/{labelname}/user |       

以上接口的最高调用频率总和为 100 次/秒/App Key。

| RESTful API 接口        | 方法 | 接口 URL           | 接口最高调用频率（默认值） |
| :------------------- | :--- | :------------------- |
| 向指定用户发送推送通知 | POST  | /{org_name}/{app_name}/push/single |  600 次/分钟/App Key         |
| 对指定标签下的用户发送推送通知 | POST  | /{org_name}/{app_name}/push/list/label | 600 次/分钟/App Key，同时执行的任务不能超过 3 个          |
| 对 app 下的所有用户发送推送通知 | POST  | /{org_name}/{app_name}/push/task | 5 次/分钟/App Key，同时执行的任务不能超过 3 个          |

### 用户属性

| RESTful API 接口    | 方法   | 接口 URL                                        | 接口最高调用频率（默认值） |
| :--------------- | :----- | :---------------------------------------------- | :------------------------- |
| 设置用户属性     | PUT    | /{org_name}/{app_name}/metadata/user/{username} | 100 次/秒/App Key          |
| 批量获取用户属性 | POST   | /{org_name}/{app_name}/metadata/user/get        | 100 次/秒/App Key          |
| 删除用户属性     | DELETE | /{org_name}/{app_name}/metadata/user/{username} | 100 次/秒/App Key          |
| 获取指定用户的所有用户属性 | GET  | /{org_name}/{app_name}/metadata/user/{username} | 100 次/秒/App Key   |
| 获取 app 下的用户属性总大小      | GET  | /{org_name}/{app_name}/metadata/user/capacity   | 100 次/秒/App Key  |

### 用户关系管理

| RESTful API 接口  | 方法   | 接口 URL                                                     | 接口最高调用频率（默认值） |
| :------------- | :----- | :----------------------------------------------------------- | :------------------------- |
| 添加好友       | POST   | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 100 次/秒/App Key          |
| 移除好友       | DELETE | /{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username} | 100 次/秒/App Key          |
| 获取好友列表   | GET    | /{org_name}/{app_name}/users/{owner_username}/contacts/users | 100 次/秒/App Key          |
| 获取黑名单列表 | GET    | /{org_name}/{app_name}/users/{owner_username}/blocks/users   | 50 次/秒/App Key           |
| 添加用户至黑名单     | POST   | /{org_name}/{app_name}/users/{owner_username}/blocks/users   | 50 次/秒/App Key           |
| 从黑名单移除用户     | DELETE | /{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username} | 50 次/秒/App Key           |

### 群组管理

| RESTful API 接口                   | 方法   | 接口 URL                                                     | 接口最高调用频率（默认值） |
| :------------------------------ | :----- | :----------------------------------------------------------- | :------------------------- |
| 分页获取 app 中所有的群组 | GET    | /{org_name}/{app_name}/chatgroups                            | 100 次/秒/App Key          |
| 分页获取一个用户参与的所有群组      | GET    | /{app_name}/users/{username}/joined_chatgroups               | 50 次/秒/App Key           |
| 获取群组详情                    | GET    | /{org_name}/{app_name}/chatgroups/{group_ids}                | 100 次/秒/App Key          |
| 创建一个群组                    | POST   | /{org_name}/{app_name}/chatgroups                            | 100 次/秒/App Key          |
| 封禁群组                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/disable              | 100 次/秒/App Key  |
| 解禁群组                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/enable              | 100 次/秒/App Key  |
| 修改群组信息                    | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}                 | 100 次/秒/App Key          |
| 删除群组                        | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}                 | 100 次/秒/App Key          |
| 封禁群组                        | POST | /{org_name}/{app_name}/chatgroups/{group_id}/disable           | 100 次/秒/App Key          |
| 解禁群组                        | POST | /{org_name}/{app_name}/chatgroups/{group_id}/enable            | 100 次/秒/App Key          |
| 获取群组公告                    | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/announcement     | 100 次/秒/App Key          |
| 修改群组公告                    | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/announcement     | 100 次/秒/App Key          |
| 获取群组共享文件                | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/share_files | 100 次/秒/App Key          |
| 上传群组共享文件                | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/share_files      | 100 次/秒/App Key          |
| 下载群组共享文件                | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id} | 100 次/秒/App Key          |
| 删除群组共享文件                | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id} | 100 次/秒/App Key          |

### 群成员管理

| RESTful API 接口            | 方法   | 接口 URL                                                     | 接口最高调用频率（默认值） |
| :----------------------- | :----- | :----------------------------------------------------------- | :------------------------- |
| 分页获取群组成员         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/users           | 100 次/秒/App Key          |
| 添加单个群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username} | 100 次/秒/App Key          |
| 批量添加群组成员         | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/users        | 100 次/秒/App Key          |
| 移除单个群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{username} | 100 次/秒/App Key          |
| 批量移除群组成员         | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/users/{usernames} | 100 次/秒/App Key          |
| 获取群管理员列表         | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/admin           | 100 次/秒/App Key          |
| 添加群管理员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/admin           | 100 次/秒/App Key          |
| 移除群管理员             | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/admin/{oldadmin} | 100 次/秒/App Key          |
| 转让群组                 | PUT    | /{org_name}/{app_name}/chatgroups/{group_id}                  | 100 次/秒/App Key          |
| 查询群组黑名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users    | 100 次/秒/App Key          |
| 添加单个用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username} | 100 次/秒/App Key          |
| 批量添加用户至群组黑名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users    | 100 次/秒/App Key          |
| 从群组黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username} | 100 次/秒/App Key          |
| 批量从群组黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{usernames} | 100 次/秒/App Key          |
| 查询群组白名单           | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/white/users     | 100 次/秒/App Key          |
| 添加单个用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username} | 100 次/秒/App Key          |
| 批量添加用户至群组白名单 | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/blocks/users    | 100 次/秒/App Key          |
| 将用户移除群组白名单     | DELETE | {org_name}/{app_name}/chatgroups/{group_id}/white/users/{username} | 100 次/秒/App Key          |
| 获取禁言列表             | GET    | /{org_name}/{app_name}/chatgroups/{group_id}/mute}           | 100 次/秒/App Key          |
| 禁言单个群成员           | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/mute            | 100 次/秒/App Key          |
| 禁言全体成员             | POST   | /{org_name}/{app_name}/chatgroups/{group_id}/ban             | 100 次/秒/App Key          |
| 解除成员禁言             | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/mute/{member1}(,{member2},…) | 100 次/秒/App Key          |
| 解除全员禁言             | DELETE | /{org_name}/{app_name}/chatgroups/{group_id}/ban             | 100 次/秒/App Key          |

### 聊天室管理

| RESTful API 接口           | 方法   | 接口 URL                                                    | 接口最高调用频率（默认值） |
| :---------------------- | :----- | :---------------------------------------------------------- | :------------------------- |
| 获取 app 中所有的聊天室 | GET    | /{org_name}/{app_name}/chatrooms                            | 50 次/秒/App Key           |
| 获取用户加入的聊天室    | GET    | /{org_name}/{app_name}/users/{username}/joined_chatrooms    | 50 次/秒/App Key           |
| 获取聊天室详情          | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 100 次/秒/App Key          |
| 创建一个聊天室          | POST   | /{org_name}/{app_name}/chatrooms                            | 50 次/秒/App Key           |
| 修改聊天室信息          | PUT    | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 100 次/秒/App Key          |
| 删除聊天室              | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}              | 100 次/秒/App Key          |
| 获取聊天室公告          | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 100 次/秒/App Key          |
| 修改聊天室公告          | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 100 次/秒/App Key          |
| 获取聊天室自定义属性 | POST  | /{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement | 100 次/秒/App Key                                                 |
| 设置聊天室自定义属性 | PUT  | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username} | 100 次/秒/App Key                                                 |
| 强制设置聊天室自定义属性 | PUT | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced | 100 次/秒/App Key                                                 |
| 删除聊天室自定义属性 | DELETE  | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username} | 100 次/秒/App Key                                                 |
| 强制删除聊天室自定义属性 | DELETE  | /{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced | 100 次/秒/App Key                                                 |

### 聊天室成员管理

| RESTful API 接口              | 方法   | 接口 URL                                                     | 接口最高调用频率（默认值） |
| :------------------------- | :----- | :----------------------------------------------------------- | :------------------------- |
| 分页获取聊天室成员         | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users         | 100 次/秒/App Key          |
| 添加单个聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username} | 100 次/秒/App Key          |
| 批量添加聊天室成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users          | 100 次/秒/App Key          |
| 删除单个聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username} | 100 次/秒/App Key          |
| 批量删除聊天室成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{usernames} | 100 次/秒/App Key          |
| 获取聊天室管理员列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin         | 100 次/秒/App Key          |
| 添加聊天室管理员           | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin         | 100 次/秒/App Key          |
| 移除聊天室管理员           | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin} | 100 次/秒/App Key          |
| 查询聊天室黑名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users  | 100 次/秒/App Key          |
| 添加单个用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username} | 100 次/秒/App Key          |
| 批量添加用户至聊天室黑名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users  | 100 次/秒/App Key          |
| 从聊天室黑名单移除单个用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username} | 100 次/秒/App Key          |
| 批量从聊天室黑名单移除用户 | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{usernames} | 100 次/秒/App Key          |
| 查询聊天室白名单           | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users`  | 100 次/秒/App Key          |
| 添加单个用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username} | 100 次/秒/App Key          |
| 批量添加用户至聊天室白名单 | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users   | 100 次/秒/App Key          |
| 将用户移除聊天室白名单     | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username} | 100 次/秒/App Key          |
| 获取聊天室的禁言列表       | GET    | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute          | 100 次/秒/App Key          |
| 禁言聊天室成员             | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute          | 100 次/秒/App Key          |
| 禁言聊天室全体成员         | POST   | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban           | 100 次/秒/App Key          |
| 解除聊天室禁言成员         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member1}(,{member2},…) | 100 次/秒/App Key          |
| 解除聊天室全员禁言         | DELETE | /{org_name}/{app_name}/chatrooms/{chatroom_id}/ban           | 100 次/秒/App Key          |
| 获取超级管理员列表         | GET    | /{org_name}/{app_name}/chatrooms/super_admin                 | 100 次/秒/App Key          |
| 添加超级管理员             | POST   | /{org_name}/{app_name}/chatrooms/super_admin                 | 100 次/秒/App Key          |
| 移除超级管理员             | DELETE | /{org_name}/{app_name}/chatrooms/super_admin/{superAdmin}    | 100 次/秒/App Key          |

### 全局禁言

| RESTful API 接口                   | 方法 | 接口 URL                           | 接口最高调用频率（默认值） |
| :------------------------------ | :--- | :--------------------------------- | :------------------------- |
| 设置用户全局禁言                | POST | {org_name}/{app_name}/mutes          | 100 次/秒/App Key          |
| 查询单个用户ID全局禁言          | GET  | {org_name}/{app_name}/mutes/username | 100 次/秒/App Key          |
| 查询 app 下的所有全局禁言的用户 | GET  | {org_name}/{app_name}/mutes          | 100 次/秒/App Key          |

### 用户在线状态管理

| RESTful API 接口        | 方法   | 接口 URL          | 接口最高调用频率（默认值） |
| :------------- | :----- | :--------------------------------- | :------------------------- |
| 设置用户在线状态信息 | POST   | /{org_name}/{app_name}/users/{uid}/presence/{resource}/{status} | 50 次/秒/App Key           |
| 批量订阅在线状态     | POST   | /{org_name}/{app_name}/users/{uid}/presence/{expiry}         | 50 次/秒/App Key           |
| 批量获取在线状态信息 | POST   | /{org_name}/{app_name}/users/{uid}/presence                  | 50 次/秒/App Key           |
| 取消订阅             | DELETE | /{org_name}/{app_name}/users/{uid}/presence                  | 50 次/秒/App Key           |
| 查询订阅列表         | GET    | /{org_name}/{app_name}/users/{uid}/presence/sublist?pageNum=1&pageSize=100 | 50 次/秒/App Key           |


### 消息表情回复 Reaction

| RESTful API 接口      | 方法   | 接口 URL        | 接口最高调用频率（默认值） |
| :------------------- | :----- | :------------------------ | :----------- |
| 创建/添加 Reaction         | POST   | /{org_name}/{app_name}/reaction/user/{userId}   | 100/second  |
| 根据消息 ID 获取 Reaction     | GET    | /{org_name}/{app_name}/reaction/user/{userId}  | 100/second  |
| 删除 Reaction     | DELETE | /{org_name}/{app_name}/reaction/user/{userId} | 100/second  |
| 根据消息 ID 和表情 ID 获取 Reaction 信息 | GET    | /{org_name}/{app_name}/reaction/user/{userId}/detail | 100/second        |

### 子区管理

| RESTful API 接口      | 方法   | 接口 URL        | 接口最高调用频率（默认值） |
| :------------------- | :----- | :------------------------ | :----------- |
| 分页获取 app 中的子区  | GET  | /{org_name}/{app_name}/thread | 100/second   |
| 分页获取单个用户加入的所有子区  | GET     | /{org_name}/{app_name}/threads/user/{username}    | 100/second    |
| 分页获取单个用户在指定群组中加入的所有子区  | GET  | /{org_name}/{app_name}/threads/chatgroups/{group_id}/user/{username}    | 100/second    |
| 创建子区  | POST     | /{org_name}/{app_name}/thread    | 100/second    |
| 修改子区  | PUT     | /{org_name}/{app_name}/thread/{thread_id}    | 100/second    |
| 删除子区  | DELETE     | /{org_name}/{app_name}/thread/{thread_id}    | 100/second    |
| 分页获取子区成员列表  | GET     | /{org_name}/{app_name}/thread/{thread_id}/users    | 100/second    |
| 用户批量加入子区  | POST     | /{org_name}/{app_name}/thread/{thread_id}/users   | 100/second    |
| 批量踢出子区成员  | DELETE     | /{org_name}/{app_name}/threads/{thread_id}/users   | 100/second    |