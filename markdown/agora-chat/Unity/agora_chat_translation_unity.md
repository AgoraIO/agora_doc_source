翻译是实时聊天应用程序中广泛使用的一项流行功能。为了实现翻译，即时通讯 IM SDK 集成了 Microsoft Azure Translation API，支持在发送或接收消息时对文本消息进行按需翻译或自动翻译：

- 按需翻译：接收方在收到文本消息后，将消息内容翻译为目标语言。
- 自动翻译：发送方发送消息时，SDK 根据发送方设置的目标语言自动翻译文本内容，然后将消息原文和译文一起发送给接收方。

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 该功能由 Microsoft Azure Translation API 提供，因此开始前请了解 [翻译语言支持](https://docs.microsoft.com/en-us/azure)。
- 默认情况下不启用翻译。要使用此功能，请订阅 **专业版** 或 **企业版** [定价计划](./agora_chat_plan) 并在 [Agora Console](https://console.agora.io/) 中启用翻译服务。

如果使用此功能，会产生附加费用。详细信息，请参阅 [定价](./agora_chat_pricing)。

## 技术原理

SDK 支持你通过调用 API 在项目中实现如下功能：

- `FetchSupportLanguages` 获取支持的翻译语言；
- 按需翻译：接收方在收到文本消息后调用 `TranslateMessage` 进行翻译；
- 自动翻译：发送方发送消息之前设置 `TextBody` 中的 `TargetLanguages` 字段为目标语言，然后发送消息，接收方会收到消息原文和译文。

## 实现方法

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译，都需先调用 `FetchSupportLanguages` 获取支持的翻译语言。示例代码如下：

```c#
// 获取翻译服务支持的语言。
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

### 按需翻译

接收方调用 `TranslateMessage` 对收到的文本消息进行翻译。翻译调用过程如下：

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

### 设置自动翻译

创建消息时，发送方设置 `TextBody` 中的 `TargetLanguages` 字段为译文语言，设置过程如下：

```c#
Message msg = Message.CreateTextSendMessage(to, text);
TextBody tb = (TextBody)msg.Body;
tb.TargetLanguages = languageList;
```

发送时消息原文和译文一起发送。

接收方收到消息后，接收方从 `TextBody` 中获取消息的译文列表，示例代码如下：

```c#
TextBody tb = (TextBody)msg.Body;
foreach(var it in tb.Translations)
{
  Debug.Log($"Translate, lang:{it.Key}, result:{it.Value}");
}
```