Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, which enables messages to be translated either when they are being sent or after they are received.

The SDK supports translation in the following use cases:

- On-demand translation, where the SDK translates the text message after the recipient receives it.
- Automatic translation, where the SDK translates the text message when the sender sends it. The recipient receives both the original message and the translation simultaneously.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v1.0.6 and has implemented the basic [real-time chat functionalities](../Unity/quick_start_windows.md).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Windows).
- Translation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** [pricing plan](./agora_chat_plan) and enable it in [Agora Console](https://console.agora.io/).
- Because this feature is enabled by the Microsoft Azure Translation API, ensure that you understand the supported target languages as described in [Language support](https://docs.microsoft.com/en-us/azure).

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `FetchSupportLanguages`, which queries the supported languages for translation.
- `TranslateMessage`, which translates the text message after it is received.
- `TextBody.TargetLanguages`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both the original and target languages.

## Implementation

This section introduces how to integrate translation functionalities into your project.

### Query the supported languages for translation

In both on-demand translation and automatic translation scenarios, call `FetchSupportLanguages` to query the supported languages for translation first:

```c#
// Fetches the supported languages for translation。
SDKClient.Instance.ChatManager.FetchSupportLanguages(new ValueCallBack<List<SupportLanguage>>(
     onSuccess: (list) =>
     {
         Debug.Log($"FetchSupportLanguages found total: {list.Count}");
         foreach (var lang in list)
         {
             Debug.Log($"code: {lang.LanguageCode}, name:{lang.LanguageName}, nativename:{lang.LanguageNativeName}");
         }
     },
     onError: (code, desc) =>
     {
         Debug.Log($"FetchSupportLanguages failed, code:{code}, desc:{desc}");
     }
    ));
```

### On-demand translation

When the recipient receives a text message, call `TranslateMessage` to translate the message:

```c#
SDKClient.Instance.ChatManager.TranslateMessage(msg, targetLanguages, new ValueCallBack<Message>(
 onSuccess: (dmsg) =>
 {
     Debug.Log($"TranslateMessage success.");
     TextBody tb = (TextBody)dmsg.Body;
     foreach(var it in tb.Translations)
     {
         Debug.Log($"Translate, lang:{it.Key}, result:{it.Value}");
     }
 },
 onError: (code, desc) =>
 {
     Debug.Log($"TranslateMessage failed, code:{code}, desc:{desc}");
 }
));
```

### Automatic translation

When creating a text message, the sender enables automatic translation by setting `TextBody.TargetLanguages` as the target language for translation:

```c#
Message msg = Message.CreateTextSendMessage(to, text);
TextBody tb = (TextBody)msg.Body;
tb.TargetLanguages = languageList;
```

The SDK sends both the original message and the translated message. After the recipient receives the message, retrieve the translated message from `TextBody`:

```c#
TextBody tb = (TextBody)msg.Body;
foreach(var it in tb.Translations)
{
  Debug.Log($"Translate, lang:{it.Key}, result:{it.Value}");
}
```