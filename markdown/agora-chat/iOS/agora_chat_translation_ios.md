# 翻译消息

翻译是实时聊天应用程序中广泛使用的一项流行功能。为了实现翻译，Agora Chat SDK 集成了 Microsoft Azure Translation API，它可以在消息发送时或收到消息后进行翻译。

SDK 在支持按需翻译和自动翻译：

- 按需翻译，即 SDK 在收到消息时，接收方将消息内容翻译成目标语言。
- 自动翻译，用户发送消息时，SDK 根据设置的目标语言自动翻译消息内容，然后将消息原文和译文一并发送给消息接收方。

## 前提条件

开始前，请确保满足以下条件：

- 完成 v1.0.3 的即时通讯 IM SDK 版本的集成，并实现了基本的实时聊天功能，详见 [快速入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM API 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 默认情况下不启用翻译。要使用此功能，你需要订阅 **Pro** 或 **Enterprise** [定价计划](https://docs.agora.io/en/agora-chat/agora_chat_plan) 并在 [Agora Console](https://console.agora.io/) 中启用该功能。
- 由于此功能由 Microsoft Azure 翻译 API 启用，因此请了解 [语言支持](https://docs.microsoft.com/en-us/azure) 中所述的受支持的目标语言。

## 技术原理

iOS SDK 支持你通过调用 API 在项目中实现如下功能：

- `fetchSupportedLanguages`：获取支持的翻译语言；
- `translateMessage`：翻译文本消息；
- `AgoraChatTextMessageBody.targetLanguages`，设置自动翻译。当收件人收到消息时，它包含原始语言和目标语言的消息。

## 实现方法

本节介绍如何将翻译功能集成到项目中。

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译场景，都需要先调用 `fetchSupportedLanguages` 查询支持的翻译语言：

```objective-c
[AgoraChatClient.sharedClient.chatManager fetchSupportedLangurages:^(NSArray<AgoraChatLanguage *> * _Nullable languages, AgoraChatError * _Nullable error) {

}];
```

### 按需翻译文本消息

当接收方收到文本消息时，调用 `translateMessage` 翻译。翻译完成后，已翻译的消息存储在消息中。

```objective-c
// 翻译消息。
[AgoraChatClient.sharedClient.chatManager translateMessage:message targetLanguages:@[@"en"] completion:^(AgoraChatMessage *message, AgoraChatError *error) {
        // 翻译后的译文信息获取。
    AgoraChatTextMessageBody* body = (AgoraChatTextMessageBody*)message.body;
    NSDictionary* translations = body.translations;
    }];
```

### 设置自动翻译

用户可以在发送文本消息时，设置消息的目标语言，消息将在翻译后进行发送，接收方收到的消息将包含译文信息。使用过程如下：

```objectivec
AgoraChatTextMessageBody* msgBody = [[AgoraChatTextMessageBody alloc] initWithText:@"Hello!!"];
msgBody.targetLanguages = @[@"en",@"ja"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:@"to" from:@"from" to:@"to" body:msgBody ext:nil];
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

SDK 发送原始消息和翻译后的消息。收件人收到消息后，请参阅以下代码示例以获取翻译：

```objective-c
- (void)messagesDidReceive:(NSArray *)aMessages
{
    for (AgoraChatChatMessage *msg in aMessages) {
        if (msg.body.type == AgoraChatMessageBodyTypeText) {
            // Get the translation
            AgoraChatTextMessageBody* body = (AgoraChatTextMessageBody*)message.body;
            NSDictionary* translations = body.translations;
        }
    }
}
```