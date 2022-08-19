# 翻译消息

翻译是实时聊天应用程序中广泛使用的一项流行功能。为了实现翻译，即时通讯 IM SDK 集成了 Microsoft Azure Translation API，支持在发送或接收消息时对文本消息进行按需翻译或自动翻译：

- 按需翻译：接收方在收到文本消息后，将消息内容翻译为目标语言。
- 自动翻译：发送方发送消息时，SDK 根据发送方设置的目标语言自动翻译文本内容，然后将消息原文和译文一起发送给接收方。

## 前提条件

开始前，请确保满足以下条件：

- 完成 v1.0.3 及以上版本即时通讯 IM SDK 初始化，详见 [快速开始](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。
- 默认情况下不启用翻译。要使用此功能，你需要订阅 **进阶版** 或 **企业版** [套餐包](https://docs.agora.io/en/agora-chat/agora_chat_plan) 并在 [Agora 控制台](https://console.agora.io/) 中启用它。
- 该功能由 Microsoft Azure Translation API 启用，因此请确保你了解该功能支持的 [目标语言](https://docs.microsoft.com/en-us/azure) 。

## 技术原理

SDK 支持你通过调用 API 在项目中实现如下功能：

- `getSupportedLanguages` ：获取支持的翻译语言；
- 按需翻译：接收方在收到文本消息后调用 `translateMessage` 进行翻译；
- 自动翻译：发送方发送消息之前设置 `languages` 字段为目标语言，然后发送消息，接收方会收到消息原文和译文。

## 实现方法

### 获取翻译服务支持的语言

无论是按需翻译还是自动翻译，都需先调用 `getSupportLanguages` 获取支持的翻译语言。示例代码如下：

```javascript
conn.getSupportedLanguages().then(res => console.log(res))
```

### 按需翻译

接收方调用 `translateMessage` 将接收到的消息翻译成目标语言。示例代码如下：

```javascript
conn.translateMessage('hello', ['zh']).then(res => console.log(res))
```

### 自动翻译

设置自动翻译的目标语言后，在发送消息时 SDK 会自动将文本翻译为目标语言，并将目标语言一并发送出去。

示例代码如下：
```javascript
// 发送消息。
let option = {
    chatType: 'singleChat',
    type: 'txt',
    to: 'userId',
    msg: 'hello',
    msgConfig:{ languages: ['zh'] } // 设置目标语言。
}
let msg = WebIM.message.create(option);
conn.send(msg)

// 接收消息。
conn.addEventHandler('MESSAGE', {
    onTextMessage: (message) => {
        console.log('message', message.translations)
    }
})
```

## 参考

### 设置和获取推送的目标语言

设置推送的目标语言，设置之后收到的离线推送就会是目标语言，如果目标语言在消息里不存在，就以原文推送，详见（https://docs.agora.io/en/agora-chat/agora_chat_push_web?platform=Web#set-up-push-translations）。