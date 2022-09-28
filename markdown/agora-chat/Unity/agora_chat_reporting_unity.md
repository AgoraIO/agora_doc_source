即时通讯 IM SDK 提供消息举报接口。开发者可以在客户端调用该接口举报违规消息。当服务器端审核服务收到举报消息后，会将举报消息存储到数据库，并在 Console 展示。审核员可在 Console 查看举报记录，并进行相应处理。

## 技术原理

即时通讯 IM SDK 提供 `ReportMessage` 方法实现举报违规消息功能。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 已在 Agora 控制台开启消息上报功能。有关详细信息，请参阅 [内容审核概述](./agora_chat_moderation_overview)。

## 实现方法

举报违规消息的示例代码如下：

```c#
SDKClient.Instance.ChatManager.ReportMessage(msgId, tag, reason, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"ReportMessage success.");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"ReportMessage failed, code:{code}, desc:{desc}");
    }
));
```