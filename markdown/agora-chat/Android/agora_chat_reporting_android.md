# 消息举报

Agora Chat SDK 提供消息举报接口。开发者可以在客户端调用该接口举报违规消息。当服务器端审核服务收到举报消息后，会将举报消息存储到数据库，并在 Agora Console 展示。审核员可在 Agora Console 查看举报记录，并进行相应处理。

## 技术原理

Agora Chat Android SDK 提供 `reportMessage` 方法实现举报违规消息功能。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速入门](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_get_started_unity)；
- 了解 Agora Chat API 的接口调用频率限制，详见 [使用限制](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_limitation_unity)；
- 已在 Agora 控制台开启举报功能，详见 [内容审核概述](https://docs.agora.io/en/agora-chat/agora_chat_moderation_overview)。

## 实现方法

举报违规消息的示例代码如下：

```java
AgoraChatClient.getInstance().chatManager().asyncReportMessage(msgid, label, reason, new EMCallBack() {
        @Override
        public void onSuccess() {

                }
        @Override
        public void onError(int code, String error) {

                }
        @Override
        public void onProgress(int progress, String status) {

                }
    });
```