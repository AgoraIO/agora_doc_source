Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, which enables messages to be translated either when they are being sent or after they are received.

The SDK supports transtion in the following use cases:

- On-demand translation, where the SDK translates the text message after the recipient receives it.
- Automatic translation, where the SDK translates the text message when the sender sends it. The recipient receives both the original message and the translation simultaneously.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v1.0.3 and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_android?platform=Android).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Android).
- Translation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** pricing plan and contact support@agora.io to enable it.
- Because this feature is enabled by the Microsoft Azure Translation API, ensure that you understand the supported target languages as described in [Language support](https://docs.microsoft.com/en-us/azure).

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `fetchSupportLanguages`, which queries the supported languages for translation.
- `translateMessage`, which translates the text message after it is received.
- `MessageBody.setTargetLanguages`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both the original and target languages.

## Implementation

This section introduces how to integrate translation functionalities into your project.

### Query the supported languages for translation

In both on-demand translation and automatic translation scenarios, call `fetchSupportLanguages` to query the supported languages for translation first:

```java
ChatClient.getInstance().chatManager().fetchSupportLanguages(new ValueCallBack<List<Language>>{});
```

### On-demand translation

When the recipient receives a text message, call `translateMessage` to translate the message:

```java
List<String> languageList = new ArrayList<>();
languageList.add("en");
...
ChatClient.getInstance().chatManager().translateMessage(
         message,
         languageList,
         new ValueCallBack<ChatMessage>() {});
```

When the translation finishes, the translated message is stored in the message. Call `getTranslations` to get the translated message:

```java
TextMessageBody body = (TextMessageBody)message.getBody();
List<TranslationInfo> infoList = body.getTranslations();
```

### Automatic translation

When creating a text message, the sender enables automatic translation by setting `MessageBody.setTargetLanguage` as the target language for translation:

```java
TextMessageBody body = new TextMessageBody("The message content");
body.setTargetLanguages(languageList);
```

The SDK sends both the original message and the translated message. After the recipient recieves the message, call `getTranslations` to retrieve the translated message:

```java
TextMessageBody body = (TextMessageBody)message.getBody();
List<TranslationInfo> infoList = body.getTranslations();
```