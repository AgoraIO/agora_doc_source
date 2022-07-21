Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, which enables messages to be translated either when they are being sent or after they are received.

The SDK supports translation in the following use cases:

- On-demand translation, where the SDK translates the text message after the recipient receives it.
- Automatic translation, where the SDK translates the text message when the sender sends it. The recipient receives both the original message and the translation simultaneously.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v3.9.1 and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_rn?platform=React%20Native).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=React%20Native).
- Translation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** [pricing plan](./agora_chat_plan) and enable it in [Agora Console](https://console.agora.io/).
- Because this feature is enabled by the Microsoft Azure Translation API, ensure that you understand the supported target languages as described in [Language support](https://docs.microsoft.com/en-us/azure).

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `fetchSupportedLanguages`, which queries the supported languages for translation.
- `translateMessage`, which translates the text message after it is received.
- `ChatTextMessageBody.targetLanguages`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both the original and target languages.

## Implementation

This section introduces how to integrate translation functionalities into your project.

### Query the supported languages for translation

In both on-demand translation and automatic translation scenarios, call `fetchSupportedLanguages` to query the supported languages for translation first:

```typescript
// Fetches the supported lanaguages for translation
ChatClient.getInstance()
  .chatManager.fetchSupportedLanguages()
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### On-demand translation

When the recipient receives a text message, call `translateMessage` to translate the message:

```typescript
// Creates a text message. Only text messages can be translated.
const msg = ChatMessage.createTextMessage(targetId, content);
// Specifies the target language for translation.
const languages = ["en"];
// Translates the text message.
ChatClient.getInstance()
  .chatManager.translateMessage(msg, languages)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

When the translation finishes, the translated message is stored in the message. Call `translations` to get the translated message:

```typescript
const body = result.body as ChatTextMessageBody;
console.log("translation: ", body.translations);
```

### Automatic translation

When creating a text message, the sender enables automatic translation by setting `ChatTextMessageBody.targetLanguages` as the target language for translation:

```typescript
// Specifies the target language for translation.
const languages: string[] = ["en"];
const msg = ChatMessage.createTextMessage(
  targetId,
  content,
  ChatMessageChatType.PeerChat,
  { targetLanguages: languages }
);
```

The SDK sends both the original message and the translated message. After the recipient receives the message, call `translations` to retrieve the translated message:

```typescript
const body = result.body as ChatTextMessageBody;
console.log("translation: ", body.translations);
```