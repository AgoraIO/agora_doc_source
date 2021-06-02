---
title: Channel Encryption
platform: iOS
updatedAt: 2021-02-20 11:11:12
---
This page introduces various encryption modes. Choose one that best suits your needs.

<div class="alert note"><li>Both Communication and Live Broadcast support channel encryption. For live broadcasts, if you need to push streams to the CDN, do not use channel encryption.<br><li>Ensure that both receivers and senders use channel encryption, otherwise, you may meet undefined behaviors such as no voice and black screen.</br></div>

The [Agora SDK](https://docs.agora.io/en/Agora%20Platform/downloads) includes:

- `AgoraRtcCryptoLoader.framework`: An independent static framework that is the encryption module.
- `libcrypto.a`: A standard OpenSSL encryption library compatible with OpenSSL 1.0.2+.

## Scenario 1: Do Not Use Encryption

If you do not use encryption, you can delete the unnecessary `AgoraRtcCryptoLoader.framework` and `libcrypto.a` files in the [Agora SDK](https://docs.agora.io/en/Agora%20Platform/downloads) to reduce the SDK package size.

## Scenario 2: Use Encryption

The following figure shows how Agora’s communications use built-in encryption:

![](https://web-cdn.agora.io/docs-files/1587019534524)

We provide open-source demo projects that implement channel encryption on GitHub. You can try the demo and refer to the source code.

**iOS**
- [OpenVideoCall-iOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS) for Swift. 
- [OpenVideoCall-iOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS-Objective-C) for Objective-C. 

**macOS**

[OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-macOS) for Swift. Refer to [`RoomViewController.swift`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-macOS/OpenVideoCall/RoomViewController.swift#L398).

> To reduce the SDK size, if your app uses `libcrypto.a`, you can use it instead of `libagora-crypto.a` included in the Agora SDK since both files are the same. The Agora SDK `libagora-crypto.so` version is 1.0.2g.

### Objective-C

1. Set the search path of the framework in Xcode.

2. Add `AgoraRtcCryptoLoader.framework` and `libcrypto.a` in the **build phase**.

3. Enable encryption:

   Call the `setEncryptionSecret` method to enable built-in encryption and set the encryption password.

4. Set the encryption mode to be used:

   Call the `setEncryptionMode` method to set the built-in encryption mode. 

### Swift

1. Set the search path of the framework in Xcode. For example:

   <img alt="../_images/encryption_search_path.jpg" src="https://web-cdn.agora.io/docs-files/en/encryption_search_path.jpg" />

2. Add a bridging header file, for example `XXX-bridge.h`, to your project folder. Under **Swift Compiler - General**, set **Objective-C Bridging Header** to the bridging header file.

   <img alt="../_images/encryption_select_bridgefile.jpg" src="https://web-cdn.agora.io/docs-files/en/encryption_select_bridgefile.jpg" />

3. Click **build phase** and move `AgoraRtcCryptoLoader.framework` and `libcrypto.a` from the **libs** folder of the SDK to the **Frameworks** folder of your project folder.

   <img alt="../_images/encryption_add_encryptionlib.jpg" src="https://web-cdn.agora.io/docs-files/en/encryption_add_encryptionlib.jpg" />

4. Add `#import <AgoraRtcCryptoLoader/AgoraRtcCryptoLoader.h>` in the bridging header file.

5. Declare an **AgoraRtcCryptoLoader** object in the file where **AgoraRtcEngine** is initialized to load the encryption module when compiling the link.

   <img alt="../_images/encryption_declare_loader.png" src="https://web-cdn.agora.io/docs-files/en/encryption_declare_loader.png" />

6. Enable encryption:

    Call the `setEncryptionSecret` method to enable built-in encryption and set the encryption password. 

7. Set the encryption mode to be used.

    Call the `setEncryptionMode` method to set the built-in encryption mode. 

## Scenario 3: Use Customized Encryption

The following figure shows the customized encryption/decryption process:

![](https://web-cdn.agora.io/docs-files/1587019552665)

## Step 1: Register a Packet Observer

The Agora Native SDK allows your application to register a packet observer to receive events whenever a voice or video packet is transmitting.

Register a packet observer on your application using the following method:

```c++
virtual int registerPacketObserver(IPacketObserver* observer);
```

The observer must be inherited from `agora::IPacketObserver` and be implemented in C++. The following is the definition of the `IPacketObserver` class:

```c++
class IPacketObserver
{
public:

struct Packet
{
        /** Buffer address of the sent or received data.
         */
const unsigned char* buffer;
        /** Buffer size of the sent or received data.
         */
unsigned int size;
};
/** An audio packet is sent to other users.

     @param packet See Packet.
     @return
     - true: The packet is sent successfully.
     - false: The packet is discarded.
     */
virtual bool onSendAudioPacket(Packet& packet) = 0;
/** A video packet is sent to other users.

     @param packet See Packet.
     @return
     - true: The packet is sent successfully.
     - false: The packet is discarded.
     */
virtual bool onSendVideoPacket(Packet& packet) = 0;
/** An audio packet is sent by other users.

     @param packet See Packet.
     @return
     - true: The packet is received successfully.
     - false: The packet is discarded.
*/
virtual bool onReceiveAudioPacket(Packet& packet) = 0;
/** A video packet is sent by other users.

     @param packet See Packet.
     @return
     - true: The packet is received successfully.
     - false: The packet is discarded.
*/
virtual bool onReceiveVideoPacket(Packet& packet) = 0;
};
```

## Step 2: Implement a Customized Data Encryption Algorithm

The observer must be inherited from `agora::IPacketObserver` to be implemented in the customized data encryption algorithm on your application. The following example uses XOR for data processing. For the Agora Native SDK, sending and receiving packets are handled by different threads, which is why encryption and decryption can use different buffers:

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
                     //encrypt the packet
                     const unsigned char* p = packet.buffer;
                     const unsigned char* pe = packet.buffer+packet.size;


                      for (i = 0; p < pe && i < m_txAudioBuffer.size(); ++p, ++i)
                     {
                         m_txAudioBuffer[i] = *p ^ 0x55;
                     }
                     //assign new buffer and the length back to SDK
                     packet.buffer = &m_txAudioBuffer[0];
                     packet.size = i;
                     return true;
                 }

                 virtual bool onSendVideoPacket(Packet& packet)
                 {
                     int i;
                     //encrypt the packet
                     const unsigned char* p = packet.buffer;
                     const unsigned char* pe = packet.buffer+packet.size;
                     for (i = 0; p < pe && i < m_txVideoBuffer.size(); ++p, ++i)
                     {
                         m_txVideoBuffer[i] = *p ^ 0x55;
                     }
                     //assign the new buffer and the length back to the SDK
                     packet.buffer = &m_txVideoBuffer[0];
                     packet.size = i;
                     return true;
                 }

                 virtual bool onReceiveAudioPacket(Packet& packet)
                 {
                     int i = 0;
                     //decrypt the packet
                     const unsigned char* p = packet.buffer;
                     const unsigned char* pe = packet.buffer+packet.size;
                     for (i = 0; p < pe && i < m_rxAudioBuffer.size(); ++p, ++i)
                     {
                         m_rxAudioBuffer[i] = *p ^ 0x55;
                     }
                     //assign the new buffer and the length back to the SDK
                     packet.buffer = &m_rxAudioBuffer[0];
                     packet.size = i;
                     return true;
                 }

                 virtual bool onReceiveVideoPacket(Packet& packet)
                 {
                     int i = 0;
                     //decrypt the packet
                     const unsigned char* p = packet.buffer;
                     const unsigned char* pe = packet.buffer+packet.size;


                     for (i = 0; p < pe && i < m_rxVideoBuffer.size(); ++p, ++i)
                     {
                         m_rxVideoBuffer[i] = *p ^ 0x55;
                     }
                     //assign the new buffer and the length back to the SDK
                     packet.buffer = &m_rxVideoBuffer[0];
                     packet.size = i;
                     return true;
                 }

             private:
                 std::vector<unsigned char> m_txAudioBuffer; //buffer for sending the voice data
                 std::vector<unsigned char> m_txVideoBuffer; //buffer for sending the video data

                 std::vector<unsigned char> m_rxAudioBuffer; //buffer for receiving the voice data
                 std::vector<unsigned char> m_rxVideoBuffer; //buffer for receiving the video data
     };
```

## Step 3: Register the Instance

Call the `registerAgoraPacketObserver` method to register the instance of the `agora::IPacketObserver` class implemented by your application.