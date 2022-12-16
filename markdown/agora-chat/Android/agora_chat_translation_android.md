翻译是实时聊天应用程序中广泛使用的一项流行功能。为实现翻译，即时通讯 IM SDK 集成了 Microsoft Azure Translation API，支持在发送或接收消息时对文本消息进行按需翻译或自动翻译：

- 按需翻译：接收方在收到文本消息后，将消息内容翻译为目标语言。
- 自动翻译：发送方发送消息时，SDK 根据发送方设置的目标语言自动翻译文本内容，然后将消息原文和译文一起发送给接收方。

## 前提条件

开始前，请确保满足以下条件：

- 项目集成了 v1.0.3 及以上版本的即时通讯 IM SDK，并实现了基本的 [实时聊天功能](./agora_chat_get_started_android)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。
- 默认情况下不启用翻译。要使用此功能，需要在 [控制台](./agora_chat_plan)[Agora Console](https://console.agora.io/) 中订阅 **进阶版** 或 **企业版** 套餐并开启翻译服务。
- 由于此功能由 Microsoft Azure 翻译 API 提供，开始前请确保你了解该功能支持的目标语言。详见 [翻译语言支持](https://docs.microsoft.com/en-us/azure) 。

## 技术原理

Chat SDK 提供以下方法来实现翻译功能：

- `fetchSupportLanguages`：获取支持的翻译语言。
- `translateMessage`：翻译收到的文本消息。
- `MessageBody.setTargetLanguages`：发送方发送消息之前调用该方法设置目标语言实现自动翻译，接收方会收到消息原文和译文。

## 实现方法

本节介绍如何将翻译功能集成到项目中。

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译，都需先调用 `fetchSupportLanguages` 获取支持的翻译语言。获取支持的翻译语言的示例代码如下：

```java
ChatClient.getInstance().chatManager().fetchSupportLanguages(new ValueCallBack<List<Language>>{});
```

### 按需翻译

接收方调用 `translateMessage` 对收到的文本消息进行翻译。翻译调用过程如下：

```java
List<String> languageList = new ArrayList<>();
languageList.add("en");
...
ChatClient.getInstance().chatManager().translateMessage(
         message,
         languageList,
         new ValueCallBack<ChatMessage>() {});
```

翻译成功之后，译文信息会保存到消息中。调用 `getTranslations` 获取译文内容。示例代码如下：

```java
TextMessageBody body = (TextMessageBody)message.getBody();
List<TranslationInfo> infoList = body.getTranslations();
```

### 设置自动翻译

创建文本消息时，发送方可将 `MessageBody.setTargetLanguage` 设置为消息的目标语言，发送消息时 SDK 会自动将文本翻译为目标语言，原文和译文一起发送。接收方收到的消息将包含译文信息。使用过程如下：

```java
TextMessageBody body = new TextMessageBody("The message content");
body.setTargetLanguages(languageList);
```

接收方收到消息后，调用 `getTranslations` 方法获取消息的译文列表，示例代码如下：

```java
TextMessageBody body = (TextMessageBody)message.getBody();
List<TranslationInfo> infoList = body.getTranslations();
```