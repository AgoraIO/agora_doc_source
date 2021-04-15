---
title: Channel Encryption
platform: Android
updatedAt: 2021-02-20 11:11:04
---
This page introduces various encryption modes. Choose one that best suits your needs.

<div class="alert note"><li>Both Communication and Live Broadcast support channel encryption. For live broadcasts, if you need to push streams to the CDN, do not use channel encryption.<br><li>Ensure that both receivers and senders use channel encryption, otherwise, you may meet undefined behaviors such as no voice and black screen.</br></div>

## Scenario 1: Do Not Use Encryption

If you do not use encryption, you can delete the unnecessary `libagora-crypto.so` file in the [Agora SDK](https://docs.agora.io/en/Agora%20Platform/downloads) to reduce the SDK package size.

## Scenario 2: Use Built-in Encryption

The following figure shows how Agora’s communications use built-in encryption:

![](https://web-cdn.agora.io/docs-files/1587019355409)

The [Agora SDK](https://docs.agora.io/en/Agora%20Platform/downloads) for Android includes an independent dynamic library, `libagora-crypto.so`, in both the `arm64-v8a` and `armeabi-v7a` folders under `libs` for the app to load dynamically.

### Step 1:

Put `libagora-crypto.so` in the specified path of your project where `libagora-rtc-sdk-jni.so` is located.

### Step 2: Enable encryption.

Call the `setEncryptionSecret` method to enable built-in encryption and set the encryption password.

### Step 3.  Set the encryption mode to be used.

Call the`setEncryptionMode` method to set the built-in encryption mode.

We provide an open-source demo project [OpenVideoCall-Android](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Android) that implements channel encryption on GitHub. You can try the demo and refer to the source code.

> To reduce the SDK size, if your app uses `libcrypto.so`, you can use it instead of `libagora-crypto.so` included in the Agora SDK since both files are the same. The Agora SDK `libagora-crypto.so` version is 1.0.2g.

## Scenario 3: Use Customized Encryption

The following figure shows the customized data encryption/decryption process:

![](https://web-cdn.agora.io/docs-files/1587019325696)


### Step 1: Register a Packet Observer

The Agora Native SDK allows your app to register a packet observer to receive events whenever a voice or video packet is transmitting.

Register a packet observer on your app using the following method:

```
virtual int registerPacketObserver(IPacketObserver* observer);
```

The observer must be inherited from `agora::IPacketObserver` and be implemented in C++. The following example is the definition of the `IPacketObserver` class:

```
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

### Step 2: Implement a Customized Data Encryption Algorithm

The observer must be inherited from `agora::IPacketObserver` to be implemented in the customized data encryption algorithm on your application. The following example uses XOR for data processing. For the Agora Native SDK, sending and receiving packets are handled by different threads, which is why encryption and decryption can use different buffers:

```
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
                     //assign the new buffer and the length back to the SDK
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
                 std::vector<unsigned char> m_txAudioBuffer; //buffer for sending the audio data
                 std::vector<unsigned char> m_txVideoBuffer; //buffer for sending the video data

                 std::vector<unsigned char> m_rxAudioBuffer; //buffer for receiving the audio data
                 std::vector<unsigned char> m_rxVideoBuffer; //buffer for receiving the video data
     };
```

### Step 3: Register the Instance

1.  Implement a Java wrapper. For example,

    ```
      JNIEXPORT jint JNICALL Java_io_agora_video_demo_RtcEngineEncryption_enableEncryption(JNIEnv *env, jclass clazz, jlong engineHandle)
    {
       typedef jint (*PFN_registerAgoraPacketObserver)(void* engine, agora::IPacketObserver* observer);
    
       void* handle = dlopen("libagora-rtc-sdk-jni.so", RTLD_LAZY);
       if (!handle)
       {
          __android_log_print(ANDROID_LOG_ERROR, "agora encrypt demo",
    
    "cannot find libagora-rtc-sdk-jni.so");
          return -1;
       }
       PFN_registerAgoraPacketObserver pfn = (PFN_registerAgoraPacketObserver)dlsym(handle, "registerAgoraPacketObserver");
       if (!pfn)
       {
          __android_log_print(ANDROID_LOG_ERROR, "aogra encrypt demo", "cannot find registerAgoraPacketObserver");
          return -2;
       }
       return pfn((void*)engineHandle, &s_packetObserver);
    }
    
    Java wrapper:
    public class RtcEngineEncryption {
        static {
            System.loadLibrary("agora-encrypt-demo-jni");
        }
        public static native int enableEncryption(long rtcEngineHandle);
    }
    ```

2.  Call the `registerAgoraPacketObserver` method to register the instance of the `agora::IPacketObserver` class implemented by your application.


