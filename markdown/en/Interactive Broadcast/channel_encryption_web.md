---
title: Channel Encryption
platform: Web
updatedAt: 2021-02-14 04:42:43
---
## Introduction
The Agora SDK provides methods for you to implement built-in encryption and set encryption password.

<div class="alert note"><li>Both Communication and Live Broadcast support channel encryption. For live broadcasts, if you need to push streams to the CDN, do not use channel encryption.<br><li>Ensure that all receivers and senders use the same encryption scheme. Otherwise, you may meet undefined behaviors such as no voice and black screen.</br></div>


## Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_web) or [Start Live Interactive Streaming](start_live_web) for details.

```
//javascript
//Sets encryption mode to "aes-128-xts","aes-256-xts" or "aes-128-ecb".
client.setEncryptionMode(encryptionMode);
//Sets AES encryption password.
client.setEncryptionSecret(password);
```

### API reference

- [`setEncryptionMode`](./API%20Reference/web/interfaces/agorartc.client.html#setencryptionmode)
- [`setEncryptionSecret`](./API%20Reference/web/interfaces/agorartc.client.html#setencryptionsecret)


## Considerations

Call this method before you call [`join`](./API%20Reference/web/interfaces/agorartc.client.html#join) to join a channel.