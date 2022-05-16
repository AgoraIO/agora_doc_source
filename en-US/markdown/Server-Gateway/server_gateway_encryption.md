To improve data security, Agora supports encrypting media streams during real-time engagement. 

Agora Server Gateway SDK supports built-in encryption methods. Currently, only 128-bit SM4, ECB mode is supported.

## Implementation

Before enabling media-stream encryption, ensure that you have implemented the basic real-time communication functions in your project.

Before connecting to a channel, call `enableEncryption` to enable built-in encryption. You also need to set encryption mode and encryption key. All users connected to the same channel must use the same encryption mode and key.

```c++
// Create EncryptionConfig object
agora::rtc::EncryptionConfig Config;
// 128-bit SM4, ECB mode
Config.encryptionMode = agora::rtc::SM4_128_ECB;
// Set encryption key
Config.encryptionKey = options.encryptionKey.c_str();
// Enable built-in encryption
if (connection->enableEncryption(options.encryptionMode, Config) < 0) {
      AG_LOG(ERROR, "Failed to enable encryption!");
    }
AG_LOG(INFO, "Enable encryption successfully");
```