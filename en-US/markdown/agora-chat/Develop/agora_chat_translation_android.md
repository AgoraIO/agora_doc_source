Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, and messages can be translated when they are being sent or after they are received.

The SDK supports transtion in the following use cases:

- On-demand translation, that is, the SDK translates the text message after the recipient receives it.
- Automatic translation, that is, the SDK automatically translates the text message when the sender sends it. The recipient receives both the original and the translated messages.

## Prerequisites

Before proceeding, ensure that your environment has the following:

- A project that integrates the Agora Chat SDK later than v1.0.3. and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_android?platform=Android).
- Understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Android).
- Translation is enabled by default. To use this feature, contact support@agora.io to enable it.
- This feature is enabled by the Microsoft Azure Translation API. Ensure that you understand the supported target languages as described in [Language support](https://docs.microsoft.com/en-us/azure).

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `fetchSupportLanguages`, which queries the supported languages for translation.
- `translateMessage`, which translates the received text message on the recipient's client in on-demand translation scenarios.
- `MessageBody.setTargetLanguages`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both original and target languages.

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

When the translation finishes, the translated message is stored in the message. Call `getTranslation` to get sit:

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