即时通讯 IM SDK 提供消息举报接口支持用户举报违规消息。当服务器端审核服务收到举报消息后，会将举报消息存储到数据库，并在声网控制台展示。审核员可在声网控制台查看举报记录，并进行相应处理。

## 技术原理

即时通讯 IM SDK 提供 `reportMessage` 方法实现举报违规消息功能。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM 的[使用限制](./agora_chat_limitation)。
- 已在声网控制台开启举报功能，详见[内容审核概述](./agora_chat_moderation_overview)。

## 实现方法

举报违规消息的示例代码如下：

```javascript
connection.reportMessage({
    reportType: 'report type'; // 举报类型。
    reportReason: 'report reason'; // 举报原因。
    messageId: 'ID of the reported message'; // 消息 ID
})
```