Translation is a popular feature widely used in real-time chat apps. To enable translation, the Agora Chat SDK has integrated the Microsoft Azure Translation API, which enables messages to be translated either when they are being sent or after they are received.

The SDK supports translation in the following use cases:

- On-demand translation, where the SDK translates the text message after the recipient receives it.
- Automatic translation, where the SDK translates the text message when the sender sends it. The recipient receives both the original message and the translation simultaneously.

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v1.0.3 and has implemented the basic [real-time chat functionalities](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Web).
- Translation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** [pricing plan](./agora_chat_plan) and enable it in [Agora Console](https://console.agora.io/).
- Because this feature is enabled by the Microsoft Azure Translation API, ensure that you understand the supported target languages as described in [Language support](https://docs.microsoft.com/en-us/azure).

## Understand the tech

The Chat SDK provides the following methods for implementing translation functionalities:

- `getSupportedLanguages`, which queries the supported languages for translation.
- `translateMessage`, which translates the received text message after it is received.
- `languages` in `msgConfig`, which automatically translates the text message when it is being sent. When the recipient receives the message, it contains the message in both the original and target languages.

## Implementation

This section introduces how to integrate translation functionalities into your project.

### Query the supported languages for translation

In both on-demand translation and automatic translation scenarios, call `getSupportedLanguages` to query the supported languages for translation first:

```javascript
conn.getSupportedLanguages().then(res => console.log(res))
```

### On-demand translation

When the recipient receives a text message, call `translateMessage` to translate the message:

```javascript
conn.translateMessage('hello', ['zh']).then(res => console.log(res))
```

### Automatic translation

When creating a text message, the sender enables automatic translation by setting `languages` in `msgConfig` as the target language for translation. The SDK sends both the original message and the translated message.

```javascript
// Send the message.
let option = {
    chatType: 'singleChat',
    type: 'txt',
    to: 'userId',
    msg: 'hello',
    msgConfig:{ languages: ['zh'] } // Set the target language for translation.
}
let msg = WebIM.message.create(option);
conn.send(msg)

// Occurs when the message is received.
conn.addEventHandler('MESSAGE', {
    onTextMessage: (message) => {
        console.log('message', message.translations)
    }
})
```

 
