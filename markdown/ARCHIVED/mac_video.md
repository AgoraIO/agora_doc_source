---
title: 集成客户端
platform: macOS
updatedAt: 2020-12-16 02:56:01
---

## 前提条件

- Xcode 9.0+。
- OS X 10.0+ 真机（MacBook）。
- 请确保你的项目已设置有效的开发者签名。
- 请确保在使用 Agora 相关功能及服务前，已打开特定端口，详见 [防火墙说明](/cn/Agora%20Platform/firewall)。

## <a name = "appid-mac"></a>创建 Agora 账号并获取 App ID

1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)

## 添加 Agora SDK 到项目中

你可以选择两种方式将 Agora SDK 添加到你的项目中：

- [自动添加库](#auto-add)：该方法无需下载 Agora SDK，直接使用 CocoaPods 将 SDK 库添加到项目中。
- [手动添加库](#man-add)：该方法需要下载 Agora SDK，并手动将 SDK 的库添加到项目中。

### <a name = "auto-add"></a>自动添加库

1. 安装 CocoaPods。在 Terminal 里输入以下命令行：

   ```
   brew install cocoapods
   ```

> - 如果你已在系统中预置了 CocoaPods 和 Homebrew，可以跳过这一步。
> - 如果 Terminal 显示 `-bash: brew: command not found`，则需要先安装 Homebrew，再输入该命令行。详见 [Homebrew 安装方法](https://brew.sh/index.html)。

2. 创建 Podfile 文件。在 Terminal 里进入项目所在路径，然后输入以下命令行。输入后，项目路径下会出现一个 Podfile 文本文件。

   ```
   pod init
   ```

3. 添加 Agora SDK 的引用。打开 Podfile 文本文件，修改文件为如下内容。注意 **“Your App”** 是你的 Target 名称。

   ```
   platform :macOS, '10.11'
   use_frameworks!

   target 'Your App' do
   	pod 'AgoraRtcEngine_macOS'
   end
   ```

4. 更新本地 CocoaPods 库。在 Terminal 内输入以下命令更新本地库版本：

   ```
   pod update
   ```

5. 安装 Agora SDK。在 Terminal 内输入以下命令进行安装：

   ```
   pod install
   ```

   如果 Terminal 显示 `Pod installation complete!`，则表示自动添加库已完成。点击打开项目的 `YourApp.xcworkspace` 文件，或输入以下命令行进行打开，注意 **“YourApp”** 是你的 Target 名称。

   ```
   open YourApp.xcworkspace
   ```

### <a name = "man-add"></a>手动添加库

1. 下载 [Agora Video SDK for macOS](https://docs.agora.io/cn/Agora%20Platform/downloads)，并解压。
2. 使用 Xcode 打开你想要运行的项目，然后选中当前 Target。

 <img alt="../_images/mac_video_1.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_1.jpg" />

3. 打开 **Build Phases** 页签。

 <img alt="../_images/mac_video_2.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_2.jpg" />

4. 展开 **Link Binary with Libraries** 项并添加如下库。点击 **+** 图标开始添加。

- `libresolv.tbd`
- `libc++.1.dylib`
- `Accelerate.framework`
- `SystemConfiguration.framework`
- `CoreWLAN.framework`
- `Foundation.framework`
- `QTKit.framework`
- `CoreAudio.framework`
- `CoreMedia.framework`
- `AVFoudation.framework`
- `VideoToolbox.framework`
- `AudioToolbox.framework`
- `AgoraRtcEngineKit.framework`

  **添加前：**

  <img alt="../_images/mac_video_3.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_3.jpg" />

  **添加后：**

  <img alt="../_images/mac_video_4.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_4.jpg" />

  其中，`AgoraRtcEngineKit.framework` 位于下载下来的 SDK 包 `libs` 文件夹下。因此点击 **+** 后，还需要点击 **Add Other…** ，然后进入到 SDK 的 `libs` 路径下，点击并添加 `AgoraRtcEngineKit.framework`。

  <img alt="../_images/mac_video_5.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_5.jpg" />

## 授权使用 Agora SDK

使用 Agora SDK 前，需要对设备的摄像头和麦克风进行授权。打开 `info.plist` ，点击 **+** 图标开始添加：

- **Privacy - Microphone Usage Description**，并填入使用麦克风的目的，例如：**Video Chat**。
- **Privacy - Camera Usage Description**，并填入使用摄像头的目的，例如：**Video Chat**。

**添加前：**

<img alt="../_images/mac_video_6.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_6.jpg" />

**添加后：**

<img alt="../_images/mac_video_7.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_7.jpg" />

## 访问库

根据你的项目所对应的编程语言，选择使用 [Objective-C](#oc) 或 [Swift](#swift) 进行访问。

### <a name = "oc"></a>Objective-C

在项目需要使用 Agora Video SDK API 的文件里，填入 `#import <AgoraAudioKit/AgoraRtcEngineKit.h>`。

> Agora Native SDK 默认使用 libc++ \(LLVM\)，如需使用 libstdc++ \(GNU\)，请联系 [sales@agora.io](mailto:sales@agora.io)。SDK 提供的库是 Fat Image，包含 32/64 位模拟器、32/64 位真机版本。

### <a name = "swift"></a>Swift

在项目需要使用 Agora Video SDK API 的文件里，填入 `import AgoraAudioKit`。

<img alt="../_images/mac_video_8.jpg" src="https://web-cdn.agora.io/docs-files/cn/mac_video_8.jpg" />

你已经完成了客户端集成，可以 开始使用 Agora SDK。
