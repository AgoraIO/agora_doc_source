---
title: 媒体流加密
platform: Windows
updatedAt: 2021-02-20 10:43:04
---
## 功能描述

在实时音视频互动过程中，开发者需要对媒体流加密，从而保障用户的数据安全。Agora 提供内置加密方案和自定义加密方案，区别如下：

- 内置加密：加密模式和密钥存在于 app 和 SDK 中。
- 自定义加密：加密模式和密钥仅存在于 app 中。

你可以根据需要选择合适的加密方案。

<div class="alert note"><li>通信和直播场景均支持媒体流加密功能。但是在直播场景下，Agora 不支持将加密后的媒体流推到 CDN 上。</li><li>如需使用媒体流加密功能，请确保接收端和发送端都使用相同的加密方案，否则会出现未定义行为（例如音频无声或视频黑屏）。</li></div>

下图描述了启用媒体流加密后的数据传输流程：

![](https://web-cdn.agora.io/docs-files/1596706031835)

## 实现方法

在启用媒体流加密前，请确保已在你的项目中实现基本的实时音视频功能。详见[实现音视频通话](start_call_windows)或[实现互动直播](start_live_windows)。

### 使用内置的加密方案

在加入频道前，调用 `enableEncryption` 方法开启内置加密，并设置加密模式和密钥。

<div class="alert note">同一频道内所有用户必须使用相同的加密模式和密钥。</div>

Agora 支持 4 种加密模式：

- `AES_128_XTS`: 128 位 AES 加密，XTS 模式。
- `AES_128_ECB`: 128 位 AES 加密，ECB 模式。
- `AES_256_XTS`: 256 位 AES 加密，XTS 模式。
- `SM4_128_ECB`: 128 位国密 SM4 加密，ECB 模式。

我们在 GitHub 提供一个实现了媒体流加密的示例项目 [OpenVideoCall-Windows](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Windows)。你可以下载体验并参考源代码。

#### 示例代码

```c++
// 创建一个 EncryptionConfig 实例
EncryptionConfig config;
// 设置加密模式为国密 SM4 加密模式
config.encryptionMode = SM4_128_ECB;
// 设置加密密钥
config.encryptionKey = "xxxxxxxxxxxxxxxx";
// 启用内置加密
rtcEngine.enableEncryption(true, config);
```

#### API 参考

[`enableEncryption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad5ea5f0dfd8117f38d9c4b12fe01fece)

### 使用自定义的加密方案

Agora 在各平台上提供了 C++ 的 `registerPacketObserver` 方法及 `IPacketObserver` 类，帮助你实现自定义加密功能。参考步骤如下：

1. 在加入频道前，调用 `registerPacketObserver` 注册数据包观测器，从而在语音或视频数据包传输时接收事件。

   ```c++
	 virtual int registerPacketObserver(IPacketObserver* observer);
	 ```

2. 实现一个 `IPacketObserver` 类:

   ```c++
    class IPacketObserver
    {
    public:
    
    struct Packet
    {
    // 需要发送或接收的数据的缓存地址。
    const unsigned char* buffer;
    // 需要发送或接收的数据的缓存大小。
    unsigned int size;
    };
    
    // 已发送音频包回调。
    // 在音频包被发送给远端用户前触发。
    // @param packet 详见: Packet。
    // @return
    // - true: 发送音频包。
    // - false: 丢弃音频包。
    virtual bool onSendAudioPacket(Packet& packet) = 0;
    
    // 已发送视频包回调。
    // 在视频包被发送给远端用户前触发。
    // @param packet 详见: Packet。
    // @return
    // - true: 发送视频包。
    // - false: 丢弃视频包。
    virtual bool onSendVideoPacket(Packet& packet) = 0;
    
    // 收到音频包回调。
    // 在收到远端用户的音频包前触发。
    // @param packet 详见: Packet。
    // @return
    // - true: 发送音频包。
    // - false: 丢弃音频包。
    virtual bool onReceiveAudioPacket(Packet& packet) = 0;
    
    // 收到视频包回调。
    // 在收到远端用户的视频包前触发。
    // @param packet 详见: Packet。
    // @return
    // - true: 发送视频包。
    // - false: 丢弃视频包。
    virtual bool onReceiveVideoPacket(Packet& packet) = 0;
    };
```

3. 继承 `IPacketObserver`，并在你的 app 上使用你自定义的数据加密算法。

   ```c++
   class AgoraPacketObserver : public agora::IPacketObserver
    {
    public:
        AgoraPacketObserver()
        {
            m_txAudioBuffer.resize(2048);
            m_rxAudioBuffer.resize(2048);
            m_txVideoBuffer.resize(2048);
            m_rxVideoBuffer.resize(2048);
        }
        virtual bool onSendAudioPacket(Packet& packet)
        {
            int i;
            // 加密数据包。
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
   
            for (i = 0; p < pe && i < m_txAudioBuffer.size(); ++p, ++i)
            {
                m_txAudioBuffer[i] = *p ^ 0x55;
            }
            // 将加密后数据的缓存地址和缓存大小发回 SDK。
            packet.buffer = &m_txAudioBuffer[0];
            packet.size = i;
            return true;
        }
   
        virtual bool onSendVideoPacket(Packet& packet)
        {
            int i;
            // 加密数据包。
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_txVideoBuffer.size(); ++p, ++i)
            {
                m_txVideoBuffer[i] = *p ^ 0x55;
            }
            // 将加密后数据的缓存地址和缓存大小发回 SDK。
            packet.buffer = &m_txVideoBuffer[0];
            packet.size = i;
            return true;
        }
   
        virtual bool onReceiveAudioPacket(Packet& packet)
        {
            int i = 0;
            // 解密数据包。
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_rxAudioBuffer.size(); ++p, ++i)
            {
                m_rxAudioBuffer[i] = *p ^ 0x55;
            }
            // 将解密后数据的缓存地址和缓存大小发回 SDK。
            packet.buffer = &m_rxAudioBuffer[0];
            packet.size = i;
            return true;
        }
   
        virtual bool onReceiveVideoPacket(Packet& packet)
        {
            int i = 0;
            // 解密数据包。
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
   
            for (i = 0; p < pe && i < m_rxVideoBuffer.size(); ++p, ++i)
            {
                m_rxVideoBuffer[i] = *p ^ 0x55;
            }
            // 将解密后数据的缓存地址和缓存大小发回 SDK。
            packet.buffer = &m_rxVideoBuffer[0];
            packet.size = i;
            return true;
        }
   
    private:
        std::vector<unsigned char> m_txAudioBuffer; // 发送音频数据 buffer。
        std::vector<unsigned char> m_txVideoBuffer; // 发送视频数据 buffer。
   
        std::vector<unsigned char> m_rxAudioBuffer; // 接收音频数据 buffer。
        std::vector<unsigned char> m_rxVideoBuffer; // 接收视频数据 buffer。
    };
```

4. 调用 `registerPacketObserver` 为 `IPacketObserver` 类注册一个实例。

#### API 参考

[`registerPacketObserver`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a95b53a32d598c3d98a51c24f7f9af4b4)