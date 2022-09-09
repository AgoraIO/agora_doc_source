翻译是实时聊天应用程序中广泛使用的一项流行功能。为了实现翻译，即时通讯 IM SDK 集成了 Microsoft Azure Translation API，它可以在消息发送时或收到消息后进行翻译。

SDK 在支持按需翻译和自动翻译：

- 按需翻译，即 SDK 在收到消息时，接收方将消息内容翻译成目标语言。
- 自动翻译，用户发送消息时，SDK 根据设置的目标语言自动翻译消息内容，然后将消息原文和译文一并发送给消息接收方。

## 前提条件

开始前，请确保满足以下条件：

- 完成即时通讯 IM SDK 集成，并实现基本的实时聊天功能，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM API 的 [使用限制](./agora_chat_limitation)。
- 默认情况下不启用翻译。要使用此功能，你需要订阅 **进阶版** 或 **企业版** [定价计划](./agora_chat_plan) 并在 [Agora 控制台](https://console.agora.io/) 中启用该功能。
- 由于此功能由 Microsoft Azure 翻译 API 启用，因此请了解 [语言支持](https://docs.microsoft.com/en-us/azure) 中所述的受支持的目标语言。

## 技术原理

SDK 支持你通过调用 API 在项目中实现如下功能：

- `fetchSupportedLanguages` 获取支持的翻译语言；
- 按需翻译：接收方在收到文本消息后调用 `translateMessage` 进行翻译；
- 自动翻译：发送方发送消息之前设置 `ChatTextMessageBody` 中的 `targetLanguages` 字段为目标语言，然后发送消息，接收方会收到消息原文和译文。

## 实现方法

本节介绍如何将翻译功能集成到项目中。

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译，都需先调用 `fetchSupportedLanguages` 获取支持的翻译语言。获取支持的翻译语言的示例代码如下：

```typescript
// 获取支持的翻译语言
ChatClient.getInstance()
  .chatManager.fetchSupportedLanguages()
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 按需翻译

接收方调用 `translateMessage` 对收到的文本消息进行翻译。翻译调用过程如下：

```typescript
// 创建文本消息，只有文本消息可以翻译
const msg = ChatMessage.createTextMessage(targetId, content);
// 指定需要翻译的目标语言
const languages = ["en"];
// 执行消息内容的翻译
ChatClient.getInstance()
  .chatManager.translateMessage(msg, languages)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

翻译成功之后，译文信息会保存到消息中。调用 `translations` 获取译文内容。示例代码如下：

```typescript
const body = result.body as ChatTextMessageBody;
console.log("translation: ", body.translations);
```

### 自动翻译

创建消息时，发送方设置 `ChatTextMessageBody` 中的 `targetLanguages` 字段为译文语言，设置过程如下：

```typescript
// 指定翻译的目标语言
const languages: string[] = ["en"];
const msg = ChatMessage.createTextMessage(
  targetId,
  content,
  ChatMessageChatType.PeerChat,
  { targetLanguages: languages }
);
```

发送时消息原文和译文一起发送。

接收方收到消息后，调用 `translations` 获取消息的译文列表，示例代码如下：

```typescript
const body = result.body as ChatTextMessageBody;
console.log("translation: ", body.translations);
```
