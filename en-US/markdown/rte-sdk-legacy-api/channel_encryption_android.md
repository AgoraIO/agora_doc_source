Media encryption encrypts your app’s audio and video streams with a unique key and [salt](https://en.wikipedia.org/wiki/Salt_(cryptography)) controlled by the app developer. While not every use case requires media encryption, Agora provides the option to guarantee data confidentiality during transmission. 

This page shows you how to add Agora's built-in media stream encryption to your app.

## Understand the tech

The following figure shows the encrypted data transmission process after you enable the built-in encryption:

![](https://web-cdn.agora.io/docs-files/1630050188692)

## Prerequisites

Before implementing media stream encryption, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

## Implement the built-in encryption

Add the built-in media stream encryption to your app, as follows:

1. Generate a key and salt on your server:

   - To generate a random 32-byte key in the string format through OpenSSL on your server, run the following command:

     ```bash
     // Generate a random 32-byte key in the string format
     openssl rand -hex 32
     dba643c8ba6b6dc738df43d9fd624293b4b12d87a60f518253bd10ba98c48453
     ```

   - To generate a random Base64-encoded, 32-byte salt through OpenSSL on your server, run the following command:

     ```bash
     // Generate a random 32-byte salt in the Base64 format
     openssl rand -base64 32
     X5w9T+50kzxVOnkJKiY/lUk82/bES2kATOt3vBuGEDw=
     ```

2. Implement the client logic:

   1. Get the key in the string format and the salt in the Base64 format from your server.

   2. Convert the salt from Base64 to uint8_t.

   3. Before joining a channel, call [enableEncryption]() to choose an encryption mode and pass the key and salt to the SDK. You can set the encryption mode as `AES_128_GCM2` or `AES_256_GCM2`.

      > - All users in a channel must use the same encryption mode, key, and salt; otherwise, undefined behaviors such as a black screen or audio loss occur.
      > - To enhance security, Agora recommends using a new key and salt every time you enable media stream encryption.

   The following sample code shows this logic:

   ```java
   import java.util.Base64;
   import io.agora.rtc2.RtcEngine;
   import io.agora.rtc2.internal.EncryptionConfig;
   
   class Example
   {
       public bool enableEncryption(RtcEngine engine) {
           if(engine == null)
               return false;
           // Gets the salt in the Base64 format from the server
           String encryptionKdfSaltBase64 = Server.getEncryptionKdfSaltBase64();
           // Gets the key in the string format from your server
           String encryptionSecret = Server.getEncryptionSecret();
           if(encryptionKdfSaltBase64 == null || encryptionSecret == null)
               return false;
         
           // Converts the salt from Base64 to uint8_t
           byte[] encryptionKdfSalt = Base64.getDecoder().decode(encryptionKdfSaltBase64);
           // Creates an EncryptionConfig instance
           EncryptionConfig config = new EncryptionConfig();
           // Sets the encryption mode as AES_128_GCM2
           config.encryptionMode = EncryptionConfig.EncryptionMode.AES_128_GCM2;
           config.encryptionKey = encryptionSecret;
           System.arraycopy(encryptionKdfSalt, 0, config.encryptionKdfSalt, 0, config.encryptionKdfSalt.length);
           int result = engine.enableEncryption(true, config);
           return (result == 0);
       }
   }
   ```

## Reference

This section provides reference information you may need when implementing the built-in encryption.

### Sample project

Agora provides an open-source sample project that implements the [built-in media encryption](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ChannelEncryption.java) on GitHub. You can try the demo and view the source code.
