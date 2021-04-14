---
title: Channel Encryption
platform: Windows
updatedAt: 2021-02-20 11:11:18
---
## Introduction

To improve data security, developers can encrypt users' media streams during the real-time engagement. Agora supports built-in encryption and customized encryption, and the differences between two encryption schemes are as follows:

- Built-in encryption: The encryption mode and encryption key exist in the app and the SDK.
- Customized encryption: The encryption mode and encryption key only exist in the app.

You can choose an encryption schema according to your needs.

<div class="alert note"><li>Both the communication and live interactive streaming scenarios support encryption, but Agora does not support pushing encrypted streams to the CDN in a live-streaming channel.</li><li>Eure that both the receivers and senders use the same encryption scheme. Otherwise, undefined behaviors such as no voice and black screen may occour.</li></div>

The following diagram describes the encrypted data transmission process:

![](https://web-cdn.agora.io/docs-files/1596711714514)

## Sample project

We provide an open-source demo project that implements [built-in encryption](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/MediaEncrypt) and [customized encryption](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/CustomEncrypt) on GitHub. You can try the demo and view the source code.

## Implementation

Before enabling the encryption, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Video Call](start_call_windows) or [Start Live Interactive Video Streaming](start_live_windows).

### Use the built-in encryption

Before joining a channel, call `enableEncryption` to enable the built-in encryption, and set the encryption mode and encryption key.

<div class="alert note">All users in the same channel must use the same encryption mode and encryption key.</div>

Agora supports the following encryption modes:

- `AES_128_XTS`: 128-bit AES encryption, XTS mode.
- `AES_128_ECB`: 128-bit AES encryption, ECB mode.
- `AES_256_XTS`: 256-bit AES encryption, XTS mode.

#### Sample code

```c++
// Creates an EncryptionConfig instance.
EncryptionConfig config;
// Sets the encryption mode as AES_128_XTS.
config.encryptionMode = EncryptionConfig.AES_128_XTS;
// Sets the encryption key.
config.encryptionKey = "xxxxxxxxxxxxxxxx";
// Enables the built-in encryption.
rtcEngine.enableEncryption(true, config);
```

#### API reference

[`enableEncryption`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad5ea5f0dfd8117f38d9c4b12fe01fece)

### Use the customized encryption

To implement the customized encryption, use `IPacketObserver` class and `registerPacketObserver` in C++ as follows:

1. Before joining a channel, call `registerPacketObserver` to register the packet observer, so that you can receive events during audio or video packet transmission.

   ```c++
	 virtual int registerPacketObserver(IPacketObserver* observer);
```

2. Implement an `IPacketObserver` class.

   ```c++
   class IPacketObserver
   {
   public:
    
   struct Packet
   {
   // Buffer address of the sent or received data.
   const unsigned char* buffer;
   // Buffer size of the sent or received data.
   unsigned int size;
   };
    
   // Occurs when the local user sends an audio packet.
   // The SDK triggers this callback before the audio packet is sent to the remote user.
   // @param packet See Packet.
   // @return
   // - true: The audio packet is sent successfully.
   // - false: The audio packet is discarded.
   virtual bool onSendAudioPacket(Packet& packet) = 0;
    
   // Occurs when the local user sends a video packet.
   // The SDK triggers this callback before the video packet is sent to the remote user.
   // @param packet See Packet.
   // @return
   // - true: The video packet is sent successfully.
   // - false: The video packet is discarded.
   virtual bool onSendVideoPacket(Packet& packet) = 0;
    
   // Occurs when the local user receives an audio packet.
   // The SDK triggers this callback before the audio packet of the remote user is received.
   // @param packet See Packet.
   // @return
   // - true: The audio packet is sent successfully.
   // - false: The audio packet is discarded.
   virtual bool onReceiveAudioPacket(Packet& packet) = 0;
    
   // Occurs when the local user receives a video packet.
   // The SDK triggers this callback before the video packet of the remote user is received.
   // @param packet See Packet.
   // @return
   // - true: The video packet is sent successfully.
   // - false: The video packet is discarded.
   virtual bool onReceiveVideoPacket(Packet& packet) = 0;
   };
```

3. Inherit the `IPacketObserver` class and use your customized encryption algorithm on your app.

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
            // Encrypts the packet.
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
    
            for (i = 0; p < pe && i < m_txAudioBuffer.size(); ++p, ++i)
            {
                m_txAudioBuffer[i] = *p ^ 0x55;
            }
            // Sends the buffer and size of the encrypted data to the SDK.
            packet.buffer = &m_txAudioBuffer[0];
            packet.size = i;
            return true;
        }
    
        virtual bool onSendVideoPacket(Packet& packet)
        {
            int i;
            // Encrypts the packet.
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_txVideoBuffer.size(); ++p, ++i)
            {
                m_txVideoBuffer[i] = *p ^ 0x55;
            }
            // Sends the buffer and size of the encrypted data to the SDK.
            packet.buffer = &m_txVideoBuffer[0];
            packet.size = i;
            return true;
        }
    
        virtual bool onReceiveAudioPacket(Packet& packet)
        {
            int i = 0;
            // Decrypts the packet.
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_rxAudioBuffer.size(); ++p, ++i)
            {
                m_rxAudioBuffer[i] = *p ^ 0x55;
            }
            // Sends the buffer and size of the decrypted data to the SDK.
            packet.buffer = &m_rxAudioBuffer[0];
            packet.size = i;
            return true;
        }
    
        virtual bool onReceiveVideoPacket(Packet& packet)
        {
            int i = 0;
            // Decrypts the packet.
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
    
            for (i = 0; p < pe && i < m_rxVideoBuffer.size(); ++p, ++i)
            {
                m_rxVideoBuffer[i] = *p ^ 0x55;
            }
            // Sends the buffer and size of the decrypted data to the SDK.
            packet.buffer = &m_rxVideoBuffer[0];
            packet.size = i;
            return true;
        }
    
    private:
        std::vector<unsigned char> m_txAudioBuffer; // Buffer for sending the audio data
        std::vector<unsigned char> m_txVideoBuffer; // Buffer for sending the video data
    
        std::vector<unsigned char> m_rxAudioBuffer; // Buffer for receiving the audio data
        std::vector<unsigned char> m_rxVideoBuffer; // Buffer for receiving the video data
    };
```

4. Call `registerPacketObserver` to register the `IPacketObserver` instance.

#### API reference

[`registerPacketObserver`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a95b53a32d598c3d98a51c24f7f9af4b4)