本文主要介绍 Agora 即时通讯的使用限制条件，包括用户、消息、群组、聊天室相关限制，及服务端 API 调用频率限制。

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

### 用户属性 

用户属性包括用户头像、昵称、邮箱等属性信息，总长度必须在 2 KB 以内， 一个 app 下所有用户属性的总长度必须在 10 GB 以内。

## 消息相关

### 消息存储时长

Agora 即时通讯提供消息云存储服务，包括历史消息、漫游消息、离线消息。

根据不同的套餐版本，消息存储时长（在即时通讯服务器上的保存的最长时间）如下：

| 套餐版本 | 消息存储时长（天） |
| :------- | :----------------- |
| 免费版   | 3                  |
| 基础版   | 7                  |
| 进阶版   | 90                 |
| 企业版   | 180                |

### 消息长度

对于不同的消息类型，消息长度限制如下：

| 消息类型       | 消息长度限制                         | 相关 API                                                     |
| :------------- | :----------------------------------- | :----------------------------------------------------------- |
| 文本消息       | 5 KB                                 | [`createTxtSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#af6312e5ea0ca70b36d22c5e0bdfc288f) |
| 图片消息       | 10 MB                                | <li>[`createImageSendMessage`[1/2]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#af8d0cd1cfc67aa8deb50386ff4dac2cd)<li>[`createImageSendMessage`[2/2]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a1207ebdd9c5ee4abd78ca1e49de6c7e1) |
| 语音消息       | 10 MB                                | <li>[`createVoiceSendMessage`[1/2\]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#afff9282db0b4fe2086a7afc70dc092f8)<li>[`createVoiceSendMessage`[2/2\]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a5935e8c3e8ed4069b01ca38b1f1a6ab9)|
| 视频消息       | 10 MB                                | <li>[`createVideoSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#ac78142ff1dfe3fa07d63027978a9ef84)[[1/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[`createVideoSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a487c212c323a110d1d5ca6406903e11f)[[2/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8)<li>[`createVideoSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#aae1215a31dad2f68bcad9a321defe3fd)[[3/3\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#afff9282db0b4fe2086a7afc70dc092f8) |
| 文件消息       | 10 MB                                |<li> [`createFileSendMessage`[1/2\]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a7b0d8a9c7edb6a7ed02a02a9d67d65f7)<li>[`createFileSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#acbab1df477a2b8a5aaf7053e27fc9232)[[2/2\]](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_message.html#a1207ebdd9c5ee4abd78ca1e49de6c7e1) |
| 透传消息       | 5 KB                                 | [`createSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a1c26e1f6420a89921bae7eb9ea362506) |
| 消息自定义扩展 | 扩展消息大小不能超过原类型消息的大小 | [`createSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a1c26e1f6420a89921bae7eb9ea362506) |
| 自定义消息     | 5 KB                                 | [`createSendMessage`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a1c26e1f6420a89921bae7eb9ea362506) |

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

当创建群组（[`createGroup`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_group_manager.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a57cfa23aae3b00d282b75023fc43899c)）时，群组属性长度限制如下：

- 群组名称：128 个字符以内
- 群组描述：512 个字符以内
- 群组扩展信息：1024 个字符以内

## 聊天室

### 聊天室数量

根据不同的套餐版本，聊天室数量限制如下：

| 套餐版本 | 聊天室总数 | 聊天室成员数 | 用户可加入聊天室数 |
| :------- | :--------- | :----------- | :----------------- |
| 免费版   | 不支持     | 无上限       | 无上限             |
| 基础版   | 100        | 无上限       | 无上限             |
| 进阶版   | 无上限     | 无上限       | 无上限             |
| 企业版   | 无上限     | 无上限       | 无上限             |

### 聊天室属性

当创建聊天室（[`createChatRoom`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_room_manager.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a6ea3f7131041f844e710f00996091cab)）时，聊天室属性长度限制如下：

- 聊天室名称：128 个字符以内
- 聊天室描述：512 个字符以内

## 服务端调用频率限制

- 除获取聊天记录文件 RESTful API，所有即时通讯 RESTful API 的调用频率都针对单个 IP 地址。
- 获取聊天记录文件 API 的调用频率上限为针对单个 app 1 次/分钟。

根据不同的套餐包版本，即时通讯 RESTful API 调用频率限制见下表：

| 套餐版本 | 调用频率（次/秒） |
| :------- | :---------------- |
| 免费版   | 10                |
| 基础版   | 30                |
| 进阶版   | 50                |
| 企业版   | 200               |