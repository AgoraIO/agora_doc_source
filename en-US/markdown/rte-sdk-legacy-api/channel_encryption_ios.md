Media encryption encrypts your app’s audio and video streams with a unique key and [salt](https://en.wikipedia.org/wiki/Salt_(cryptography)) controlled by the app developer. While not every use case requires media encryption, Agora provides the option to guarantee data confidentiality during transmission. 

This page shows you how to add Agora's built-in media stream encryption to your app.

## Understand the tech

The following figure shows the encrypted data transmission process after you enable the built-in encryption:

![](https://web-cdn.agora.io/docs-files/1630050188692)

## Prerequisites

Before implementing media stream encryption, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

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


2. The client logic you need to implement is:

   1. Manually add the encryption library to your project, as follows:

      1. Copy `AgoraRtcCryptoLoader.framework` from the SDK package to your project folder.
      2. Open Xcode (take the Xcode 11.0 as an example) and go to the **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu.
      3. Click **+** and  **Add Other...**  to add `AgoraRtcCryptoLoader.framework`.
      4. To ensure that the signature of the dynamic library is the same as the signature of the app, set the **Embed** attribute of the dynamic library to **Embed & Sign**.

      <div class="alert note">According to the requirement of Apple, the <b>Extension</b> of app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the <b>Extension</b>, change the file status as <b>Do Not Embed</b>.</div>

      <div class="alert info">For more integration methods, see <a href="#othermethods">Other approaches to integrate the encryption library</a></div>

   2. Import the `AgoraRtcCryptoLoader` library. To do this, add the following code to the `ViewController` file:

      ```swift
      import AgoraRtcCryptoLoader
      ```

   3. Get the key in the string format and the salt in the Base64 format from your server.

   4. Convert the salt from Base64 to uint8_t.

   5. Before joining a channel, call [enableEncryption]() to choose an encryption mode and pass the key and salt to the SDK. You can set the encryption mode as `AES_128_GCM2` or `AES_256_GCM2`.

      > - All users in a channel must use the same encryption mode, key, and salt; otherwise, undefined behaviors such as a black screen or audio loss occur.
      > - To enhance security, Agora recommends using a new key and salt every time you enable media stream encryption.

      The following sample code shows this logic:

      ```swift
      func getEncryptionSaltFromServer() -> Data {
        // Converts the salt from Base64 to uint8_t
        return "EncryptionKdfSaltInBase64Strings".data(using: .utf8)!
      }
      
      // Creates an EncryptionConfig instance
      let config = AgoraEncryptionConfig()
      // Sets the encryption mode as AES_128_GCM2
      config.encryptionMode = .AES128GCM2
      // Gets the salt in the Base64 format from the server
      config.encryptionKey = getEncryptionKdfSaltBase64FromServer()
      // Gets the key in the string format from your server
      config.encryptionKdfSalt = getEncryptionSaltFromServer()
      let ret = agoraKit.enableEncryption(true, encryptionConfig: config)
      if ret != 0 {
        self.showAlert(title: "Error", message: "enableEncryption call failed: \(ret), please check your params")
      }
      ```



## Reference

This section provides reference information you may need when implementing the built-in encryption.

### Sample project

Agora provides an open-source sample project that implements the [built-in media encryption](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/StreamEncryption/StreamEncryption.swift) on GitHub. You can try the demo and view the source code.

<a name="othermethods"></a>

### Integrate the encryption library through Cocoapods

Integrate the encryption library through Cocoapods, as follows:

1. Install CocoaPods. See the installation guide in  <a href="https://guides.cocoapods.org/using/getting-started.html#getting-started">Getting Started with CocoaPods</a >.

2. In Terminal, go to the project path and run the `pod init` command to create a `Podfile` in the project folder.

3. Open the `Podfile`, delete all contents and input the following contents. Remember to change `Your App` to the target name of your project, and change `version` to the version of the SDK which you want to integrate.

   ```shell
   # platform :ios, '9.0'
   target 'Your App' do
     pod 'AgoraRtcEngine_iOS_Crypto', '~> version'
   end
   ```

4. Go back to Terminal, and run the `pod install` command to install the Agora SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

5. Open the generated `xcworkspace` file in Xcode.