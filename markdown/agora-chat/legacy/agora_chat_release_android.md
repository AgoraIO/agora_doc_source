## 1.0.1 版

该版本于 2022 年 1 月 XX 日发布。

#### 新增特性

该版本增加了以下功能：

- 支持在创建位置消息时设置建筑物名称。
- 支持在指定时间前删除本地消息。
- 支持在一次会话中获取消息数。

#### 问题修复

该版本修复了以下问题：

- 一些崩溃问题。
- 数据库加密中的问题。

#### API 变更

该版本新增以下 API：

- [`createLocationSendMessage` [1/2]](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_message.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a8e5998f0cd6fd851153839aadef4d1ed)
- [`deleteMessagesBeforeTimestamp`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_chat_manager.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#a23b0355ffd351da0b203f6e0c130fdf6)
- [`getAllMsgCount`](./API%20Reference/im_java/v1.0.1/classio_1_1agora_1_1chat_1_1_conversation.html?transId=6d00fa40-7a6c-11ec-bcb4-b56a01c83d2e#abb427e43b0592ca0658de691e104ef49)