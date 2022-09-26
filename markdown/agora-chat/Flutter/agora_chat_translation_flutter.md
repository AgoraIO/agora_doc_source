翻译是实时聊天应用程序中广泛使用的一项流行功能。为了实现翻译，即时通讯 IM SDK 集成了 Microsoft Azure Translation API，支持在发送或接收消息时对文本消息进行按需翻译或自动翻译：

- 按需翻译：接收方在收到文本消息后，将消息内容翻译为目标语言。
- 自动翻译：发送方发送消息时，SDK 根据发送方设置的目标语言自动翻译文本内容，然后将消息原文和译文一起发送给接收方。

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 由于此功能由 Microsoft Azure 翻译 API 启用，因此请确保了解 [语言支持](https://docs.microsoft.com/en-us/azure)中所述的受支持的目标语言。
- 默认情况下不启用翻译。使用此功能，需要订阅 **专业版** 或 **企业版** [定价计划](./agora_chat_plan) 并在 [Agora Console](https://console.agora.io/) 中启用它。

如果使用此功能，则会产生附加费用。有关详细信息，请参阅 [定价](./agora_chat_pricing)。

## 技术原理

Chat SDK 提供以下方法来实现翻译功能：

- `fetchSupportedLanguages` 获取支持的翻译语言。
- 按需翻译：接收方在收到文本消息后调用 `translateMessage` 进行翻译。
- 自动翻译：发送方发送消息之前设置 `ChatTextMessageBody.targetLanguages`字段为目标语言，然后发送消息，接收方会收到消息原文和译文。

## 实现方法

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译，都需先调用 `fetchSupportedLanguages` 获取支持的翻译语言。获取支持的翻译语言的示例代码如下：

```dart
// 获取支持的翻译语言
try {
  List<ChatTranslateLanguage> list =
      await ChatClient.getInstance.chatManager.fetchSupportedLanguages();
} on ChatError catch (e) {
}
```

### 按需翻译

接收方调用 `translateMessage` 对收到的文本消息进行翻译。翻译调用过程如下：

```dart
// 指定需要翻译的目标语言
List<String> languages = ["en"];
try {
  // 执行消息内容的翻译，`textMessage`：收到的文本消息
  ChatMessage translatedMessage = await ChatClient.getInstance.chatManager
      .translateMessage(msg: textMessage, languages: languages);
} on ChatError catch (e) {
}
```

翻译成功之后，译文信息会保存到消息中。调用 `ChatTextMessageBody.translations`获取译文内容。示例代码如下：

```dart
ChatTextMessageBody body = translatedMessage.body as ChatTextMessageBody;
debugPrint("translation: ${body.translations}");
```

### 自动翻译

创建消息时，发送方设置 `ChatTextMessageBody.targetLanguages` 为翻译的目标语言来启用自动翻译：

```dart
// 指定翻译的目标语言
ChatMessage textMessage = ChatMessage.createTxtSendMessage(
  username: targetUser,
  content: content,
  targetLanguages: ["en"],
);
```

发送时消息原文和译文一起发送。

接收方收到消息后，调用 `translations` 获取消息的译文列表，示例代码如下：

```dart
ChatTextMessageBody body = receiveMessage.body as ChatTextMessageBody;
debugPrint("translation: ${body.translations}");
```