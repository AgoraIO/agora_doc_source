---
title: 媒体流加密
platform: iOS
updatedAt: 2021-02-20 10:42:49
---

## 功能描述

在实时音视频互动过程中，开发者需要对媒体流加密，从而保障用户的数据安全。Agora 提供内置加密方案和自定义加密方案，区别如下：

- 内置加密：加密模式和密钥存在于 app 和 SDK 中。
- 自定义加密：加密模式和密钥仅存在于 app 中。

你可以根据需要选择合适的加密方案。

<div class="alert note"><li>通信和直播场景均支持媒体流加密功能。但是在直播场景下，Agora 不支持将加密后的媒体流推到 CDN 上。</li><li>如需使用媒体流加密功能，请确保接收端和发送端都使用相同的加密方案，否则会出现未定义行为（例如音频无声或视频黑屏）。</li></div>

下图描述了启用媒体流加密后的数据传输流程：

![](https://web-cdn.agora.io/docs-files/1596706031835)

## 示例项目

Agora 在 GitHub 上提供以下实现了媒体流加密功能的开源示例项目：

- iOS：[StreamEncryption](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/StreamEncryption/StreamEncryption.swift)
- macOS：[StreamEncryption](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Advanced/StreamEncryption/StreamEncryption.swift)

你可以下载体验并参考源代码。

## 实现方法

在启用媒体流加密前，请确保已在你的项目中实现基本的实时音视频功能。详见如下文档：

- iOS: [实现音视频通话](start_call_ios)或[实现互动直播](start_live_ios)
- macOS: [实现音视频通话](start_call_mac)或[实现互动直播](start_live_mac)

### 使用内置的加密方案

**1. 集成加密库**

iOS SDK 包中有一个独立的动态加密库 `AgoraRtcCryptoLoader.framework`，参考以下步骤集成并导入加密库：

1. 选择以下一种方法集成加密库：

 <details>
	<summary><font color="#3ab7f8">使用 CocoaPods 自动集成</font></summary>
	a. 开始前确保你已安装 Cocoapods。参考 <a href="https://guides.cocoapods.org/using/getting-started.html#getting-started">Getting Started with CocoaPods</a > 安装说明。
	<p>b. 在 Terminal 里进入项目根目录，并运行 <tt>pod init</tt> 命令。项目文件夹下会生成一个 <tt>Podfile</tt> 文本文件。</p>
	<p>c. 打开 <tt>Podfile</tt> 文件，修改文件为如下内容。注意将 <tt>Your App</tt> 替换为你的 Target 名称，并将 <tt>version</tt> 替换为你需集成的 SDK 版本。</p>
	<pre>
	# platform :ios, '9.0' use_frameworks!
	target 'Your App' do
      pod 'AgoraRtcEngine_iOS_Crypto', '~> version'
	end</pre>
	<p>d. 在 Terminal 内运行 <tt>pod update</tt> 命令更新本地库版本。</p>
	<p>e. 运行 <tt>pod install</tt> 命令安装 Agora SDK。成功安装后，Terminal 中会显示 <tt>Pod installation complete!</tt>，此时项目文件夹下会生成一个 <tt>xcworkspace</tt> 文件。</p>
	<p>f. 打开新生成的 <tt>xcworkspace</tt> 文件。</p>
</details>

 <details>
	<summary><font color="#3ab7f8">手动集成</font></summary>
	a. 将 SDK 包中的 <tt>AgoraRtcCryptoLoader.framework</tt> 复制到项目文件夹下。
	<p>b. 打开 Xcode（以 Xcode 11.0 为例），进入 <b>TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content</b> 菜单，点击 <b>+</b>，再点击 <b>Add Other…</b> 添加 <tt>AgoraRtcCryptoLoader.framework</tt>。为保证动态库的签名和 app 的签名一致，你需要将动态库的 <b>Embed</b> 属性设置为 <b>Embed & Sign</b>。</p>
	 <div class="alert warning">根据 Apple 官方要求，app 的 <b>Extension</b> 不允许包含动态库。如果工程中的 <b>Extension</b> 需要集成 SDK，则集成动态库时需将文件状态改为 <b>Do Not Embed</b>。 </div>
</details>

2. 在项目中导入 `AgoraRtcCryptoLoader` 类：

```swift
// Swift
import AgoraRtcCryptoLoader
```

```objective-c
// Objective-C
#import <AgoraRtcCryptoLoader/AgoraRtcCryptoLoader.h>
```

**2. 开启内置加密**

在加入频道前，调用 `enableEncryption` 方法开启内置加密，并设置加密模式和密钥。

<div class="alert note">同一频道内所有用户必须使用相同的加密模式和密钥。</div>

Agora 支持 4 种加密模式：

- `AgoraEncryptionModeAES128XTS`: 128 位 AES 加密，XTS 模式。
- `AgoraEncryptionModeAES128ECB`: 128 位 AES 加密，ECB 模式。
- `AgoraEncryptionModeAES256XTS`: 256 位 AES 加密，XTS 模式。
- `AgoraEncryptionModeSM4128ECB`: 128 位国密 SM4 加密，ECB 模式。

#### 示例代码

```swift
// Swift
// 创建一个 AgoraEncryptionConfig 实例
let config = AgoraEncryptionConfig()
// 设置加密模式为国密 SM4 加密模式
config.encryptionMode = AgoraEncryptionMode.SM4128ECB
// 设置加密密钥
config.encryptionKey = "xxxxxxxxxxxxxxxx"
// 启用内置加密
agoraKit.enableEncryption(true, config)
```

```objective-c
// Objective-C
// 创建一个 AgoraEncryptionConfig 实例
AgoraEncryptionConfig *config = [[AgoraEncryptionConfig alloc] init];
// 设置加密模式为国密 SM4 加密模式，并设置加密密钥
config.encryptionMode = AgoraEncryptionModeSM4128ECB;
config.encryptionKey = @"xxxxxxxxxxxxxxxx";
// 启用内置加密
[agoraKit enableEncryption: YES encryptionConfig:config];
```

#### API 参考

[`enableEncryption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableEncryption:encryptionConfig:)

### 使用自定义的加密方案

Agora 提供 C++ 的 `registerPacketObserver` 方法及 `IPacketObserver` 类，帮助你实现自定义加密功能。

<div class="alert note">实现自定义加密需要在 iOS 或 macOS 平台上调用 SDK 的 C++ API，注意事项如下：
	<li>代码中涉及 Objective-C 与 C++ 混编的逻辑必须在 <code>.mm</code> 文件中实现。</li>
	<li><code>.mm</code> 文件的开头需要引入 C++ 头文件: <code>#include &lt;AgoraRtcKit/IAgoraRtcEngine.h></code>。</li></div>

参考步骤如下：

1. 在 `.mm` 文件中通过 `IPacketObserver` 类实现你自定义的数据加密算法。

   ```objective-c
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
        virtual bool onSendAudioPacket(Packet& packet) {
            int i;
            // 加密数据包
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;

            for (i = 0; p < pe && i < m_txAudioBuffer.size(); ++p, ++i)
            {
                m_txAudioBuffer[i] = *p ^ 0x55;
            }
            // 将加密后数据的缓存地址和缓存大小发回 SDK
            packet.buffer = &m_txAudioBuffer[0];
            packet.size = i;
            return true;
        }

        virtual bool onSendVideoPacket(Packet& packet) {
            int i;
            // 加密数据包
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_txVideoBuffer.size(); ++p, ++i)
            {
                m_txVideoBuffer[i] = *p ^ 0x55;
            }
            // 将加密后数据的缓存地址和缓存大小发回 SDK
            packet.buffer = &m_txVideoBuffer[0];
            packet.size = i;
            return true;
        }

        virtual bool onReceiveAudioPacket(Packet& packet) {
            int i = 0;
            // 解密数据包
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;
            for (i = 0; p < pe && i < m_rxAudioBuffer.size(); ++p, ++i)
            {
                m_rxAudioBuffer[i] = *p ^ 0x55;
            }
            // 将解密后数据的缓存地址和缓存大小发回 SDK
            packet.buffer = &m_rxAudioBuffer[0];
            packet.size = i;
            return true;
        }

        virtual bool onReceiveVideoPacket(Packet& packet) {
            int i = 0;
            // 解密数据包
            const unsigned char* p = packet.buffer;
            const unsigned char* pe = packet.buffer+packet.size;

            for (i = 0; p < pe && i < m_rxVideoBuffer.size(); ++p, ++i)
            {
                m_rxVideoBuffer[i] = *p ^ 0x55;
            }
            // 将解密后数据的缓存地址和缓存大小发回 SDK
            packet.buffer = &m_rxVideoBuffer[0];
            packet.size = i;
            return true;
        }

    private:
        // 发送音频数据 buffer
        std::vector<unsigned char> m_txAudioBuffer;
        // 发送视频数据 buffer
        std::vector<unsigned char> m_txVideoBuffer;
        // 接收音频数据 buffer
        std::vector<unsigned char> m_rxAudioBuffer;
        // 接收视频数据 buffer
        std::vector<unsigned char> m_rxVideoBuffer;
    };
   ```

2. 在加入频道前，注册数据包观测器，在语音或视频数据包传输时接收事件。

   ```swift
   // Swift
   AgoraCustomEncryption.registerPacketProcessing(agoraKit)
   ```

   在 `.mm` 文件中调用 `registerPacketObserver` 实现注册数据包观测器。

   ```objective-c
   + (void)registerPacketProcessing:(AgoraRtcEngineKit *)rtcEngineKit {
       if (!rtcEngineKit) {
           return;
       }
       // 获取 Native SDK 的 C++ 句柄
       agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)rtcEngineKit.getNativeHandle;
       // 注册数据包观测器
       rtc_engine->registerPacketObserver(&s_packetObserver);
   }
   ```

3. 离开频道后，取消注册数据包观测器。

   ```swift
   // Swift
   AgoraCustomEncryption.deregisterPacketProcessing(agoraKit)
   ```

   在 `.mm` 文件中调用 `registerPacketObserver(NULL)` 实现取消注册数据包观测器。

   ```objective-c
   + (void)deregisterPacketProcessing:(AgoraRtcEngineKit *)rtcEngineKit {
       if (!rtcEngineKit) {
           return;
       }
       // 获取 Native SDK 的 C++ 句柄
       agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)rtcEngineKit.getNativeHandle;
       // 取消注册数据包观测器
       rtc_engine->registerPacketObserver(NULL);
   }
   ```

#### API 参考

[`registerPacketObserver`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a95b53a32d598c3d98a51c24f7f9af4b4)
