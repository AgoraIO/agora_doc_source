Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, which enables messages to be translated either when they are being sent or after they are received.

The SDK supports translation in the following use cases:

- On-demand translation, where the SDK translates the text message after the recipient receives it.
- Automatic translation, where the SDK translates the text message when the sender sends it. The recipient receives both the original message and the translation simultaneously.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v1.0.3 and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=iOS).
- Because this feature is enabled by the Microsoft Azure Translation API, ensure that you understand the supported target languages as described in [Language support](https://learn.microsoft.com/en-us/azure/ai-services/translator/language-support).
- Translation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** [pricing plan](./agora_chat_plan) and enable it in [Agora Console](https://console.agora.io/).

<div class="alert note">Add-on fees are incurred if you use this feature. See <a href="https://docs.agora.io/en/agora-chat/agora_chat_pricing#optional-add-on-fee">Pricing</a> for details.</div>

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `fetchSupportLanguages`, which queries the supported languages for translation.
- `translateMessage`, which translates the text message after it is received.
- `AgoraChatTextMessageBody.targetLanguages`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both the original and target languages.

## Implementation

This section introduces how to integrate translation functionalities into your project.

### Query the supported languages for translation

In both on-demand translation and automatic translation scenarios, call `fetchSupportLanguages` to query the supported languages for translation first:

```objective-c
[AgoraChatClient.sharedClient.chatManager fetchSupportedLangurages:^(NSArray<AgoraChatLanguage *> * _Nullable languages, AgoraChatError * _Nullable error) {
                    
}];
```

### On-demand translation

When the recipient receives a text message, call `translateMessage` to translate the message. When the translation finishes, the translated message is stored in the message. 

```objective-c
// Only text messages can be translated.
[AgoraChatClient.sharedClient.chatManager translateMessage:message targetLanguages:@[@"en"] completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    // Get the translation.
    AgoraChatTextMessageBody* body = (AgoraChatTextMessageBody*)message.body;
    NSDictionary* translations = body.translations;
    }];
```

### Automatic translation

When creating a text message, the sender enables automatic translation by setting `AgoraChatTextMessageBody.targetLanguages` as the target language for translation:

```objective-c
AgoraChatTextMessageBody* msgBody = [[AgoraChatTextMessageBody alloc] initWithText:@"Hello!!"];
msgBody.targetLanguages = @[@"en",@"ja"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:@"to" from:@"from" to:@"to" body:msgBody ext:nil];
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

The SDK sends both the original message and the translated message. Once the recipient receives the message, refer to the following code sample to get the translation:

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
