---
title: 自定义视频采集和渲染
platform: macOS
updatedAt: 2019-09-20 17:35:08
---
## 功能介绍

实时通信过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。如果想要在客户端实现自定义音视频采集和渲染，则可以使用自定义的音视频源或渲染器，来进行实现。

**自定义采集和渲染**主要适用于以下场景：

- 当 SDK 内置的音视频源不能满足开发者需求时，比如需要使用自定义的美颜库或前处理库
- 开发者的 App 中已有自己的音频或视频模块，为了复用代码，也可以自定义音视频源
- 开发者希望使用非 Camera 采集的视频源，如录屏数据
- 有些系统独占的视频采集设备，为避免与其他业务产生冲突，需要灵活的设备管理策略

## 实现方法

在开始自定义采集和渲染前，请确保你已完成环境准备、安装包获取等步骤，详见 [集成客户端](./mac_video)。

### 自定义音频源

你可以使用 Push 方法自定义音频源。该方法下，SDK 不会对采用传入的音频数据做消噪等处理。

```swift
//swift
// 推入数据类型为 rawData
agoraKit.pushExternalAudioFrameRawData("your rawData", samples: "per push samples", timestamp: 0)

// 推入数据类型为 CMSampleBuffer
agoraKit.pushExternalAudioFrameSampleBuffer("your CMSampleBuffer")
```

```objective-c
//objective-c
// 推入数据类型为 rawData
[agoraKit pushExternalAudioFrameRawData: "your rawData" samples: "per push samples", timestamp: 0];

// 推入数据类型为 CMSampleBuffer
[agoraKit pushExternalAudioFrameSampleBuffer: "your CMSampleBuffer"];
```

**相关 API 及链接**
* [`pushExternalAudioFrameRawData:samples:timestamp:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
* [`pushExternalAudioFrameSampleBuffer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)


### 自定义视频源

Agora SDK 目前提供两种自定义视频源的方法：

* 通过 MediaIO 接口实现（推荐）。
* 通过 Push 方法实现。和自定义音频源一样，该方法略过了 SDK 对视频帧的优化处理，因此适合客户端有能力对帧进行优化的用户。

#### 使用 MediaIO 接口自定义视频源

你可以使用 MediaIO 中的 AgoraVideoSourceProtocol 协议实现自定义视频源。该方法将视频帧数据传输到服务器，如需本地预览，还需要应用开发者自己处理本地渲染逻辑。示例代码如下：

1. 遵守 AgoraVideoSourceProtocol 协议， 并实现接口，构建自定义的 Video Source 类。

	```swift
	//swift
	// 协议中的变量
		 var consumer: AgoraVideoFrameConsumer?
	// 调用 consumer 的方法，将视频数据推入Agora SDK:

		// 推入rawData类型
		 consumer.consumeRawData("your rawData", withTimestamp: CMTimeMake(1, 15), format: "your data format", size: size, rotation: rotation)

		 // 推入CVPixelBuffer
		 consumer.consumePixelBuffer("your pixelBuffer", withTimestamp: CMTimeMake(1, 15), rotation: rotation)

	// 协议中的方法
	1. 视频采集使用的 Buffer 类型
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

	2. 在初始化视频源 (shouldInitialize) 中, 初始化自定义的 Video Source
		func shouldInitialize() -> Bool {
		}

	3. 自定义视频源开始采集视频数据，并通过 consumer 推入视频数据
		func shouldStart() {
		}

	4. 自定义视频源停止采集视频数据
		func shouldStop() { 
		}

	5. 在释放自定义视频源
		func shouldDispose() {
		}
	```
	
	```objective-c
	//objective-c
	// 协议中的变量
	@synthesize consumer;
	// 调用 consumer 的方法，将视频数据推入Agora SDK:

		// 推入rawData类型
		[consumer consumeRawData: "your rawData" withTimestamp: CMTimeMake(1, 15) format: "your data format" size: size rotation: rotation];

		// 推入CVPixelBuffer
		[consumer consumePixelBuffer: "your pixelBuffer" withTimestamp: CMTimeMake(1, 15) rotation: rotation];

	// 协议中的方法
	1. 视频采集使用的 Buffer 类型
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

	2. 在初始化视频源 (shouldInitialize) 中, 初始化自定义的 Video Source
		- (BOOL)shouldInitialize {
				return YES;
		}

	3. 自定义视频源开始采集视频数据，并通过 consumer 推入视频数据
		- (void)shouldStart {
		}

	4. 自定义视频源停止采集视频数据
		- (void)shouldStop {
		}

	5. 在释放自定义视频源
		- (void)shouldDispose {
		}
	```
	

2. 将遵守了 AgoraVideoSourceProtocol 协议的自定义 VideoSource 对象设给 AgoraRtcEngineKit。

	```swift
	//swift
	agoraKit.setVideoSource(videoSource)
	```

	```objective-c
	//objective-c
	[agoraKit setVideoSource: videoSource];
	```
	
**相关 API 及链接**
* [`setVideoSource:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoSource:)
* [`AgoraVideoSourceProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSourceProtocol.html)

#### 使用 Push 方法自定义视频源

相对于 MedioIO 接口，Push 方法代码较少，但缺少 SDK 对帧的优化过程，需要用户对自己采集到的视频数据进行处理。

```swift
//swift
// 推入数据类型为 CVPixelBufferRef
let videoFrame = AgoraVideoFrame()
videoFrame.format = 12
videoFrame.time = CMTimeMake(1, 15)
videoFrame.textureBuf = "Your CVPixelBufferRef"
videoFrame.ratation = 0

// 推入数据类型为 rawData
let videoFrame = AgoraVideoFrame()
videoFrame.format = "your data fromat"
videoFrame.time = CMTimeMake(1, 15)
videoFrame.data = "your CVPixelBufferRef"
videoFrame.strideInPixels = "your stride"
videoFrame.height = "your height"
videoFrame.dataBuf = "your rawData"
videoFrame.ratation = 0

agoraKit.pushExternalVideoFrame(videoFrame)
```

```objective-c
//objective-c
// 推入数据类型为 CVPixelBufferRef
AgoraVideoFrame *videoFrame = [[AgoraVideoFrame alloc] init];
videoFrame.format = 12;
videoFrame.time = CMTimeMake(1, 15);
videoFrame.textureBuf = "Your CVPixelBufferRef";
videoFrame.ratation = 0;

// 推入数据类型为 rawData
AgoraVideoFrame *videoFrame = [[AgoraVideoFrame alloc] init];
videoFrame.format = "your data fromat";
videoFrame.time = CMTimeMake(1, 15);
videoFrame.data = "your CVPixelBufferRef";
videoFrame.strideInPixels = "your stride";
videoFrame.height = "your height";
videoFrame.dataBuf = "your rawData";
videoFrame.ratation = 0;

[agoraKit pushExternalVideoFrame: videoFrame];
```

**相关 API 及链接**
* [`pushExternalVideoFrame:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalVideoFrame:)

### 自定义渲染器

你可以使用 MediaIO 中 AgoraVideoSinkProtocol 协议来自定义渲染器。示例代码如下：

1. 遵守 AgoraVideoSinkProtocol 协议， 并实现接口，构建自定义的 Video Renderer 类。

	```swift
	//swift
	// 协议中的方法
	1. 希望 Agora SDK 抛出的视频 Buffer 类型
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

		希望 Agora SDK 抛出的视频数据格式
		func pixelFormat() -> AgoraVideoPixelFormat {
				return pixelFormat
		}

	2. 初始化自定义的 Video Renderer
		func shouldInitialize() -> Bool {
				return true
		}

	3. 	启动自定义的 Video Renderer   
		func shouldStart() {

		}

	4. Agora SDK 停止抛出视频数据
		func shouldStop() {

		}

	5. 自定义的 Video Renderer 可以被释放   
		func shouldDispose() {

		}

	6. Agora SDK 通过该接口抛出 CVPixelBuffer 类型的视频数据, 自定义 Video Renderer 可以获取数据进行渲染
		func renderPixelBuffer(_ pixelBuffer: CVPixelBuffer, rotation: AgoraVideoRotation) {
		}

		Agora SDK 通过该接口抛出 rawData 类型的视频数据, 自定义 Video Renderer 可以获取数据进行渲染
		func renderRawData(_ rawData: UnsafeMutableRawPointer, size: CGSize, rotation: AgoraVideoRotation) {
		}
	}
	```

	```objective-c
	//objective-c
	// 协议中的方法
	1. 希望 Agora SDK 抛出的视频 Buffer 类型
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

		希望 Agora SDK 抛出的视频数据格式
		- (AgoraVideoPixelFormat)pixelFormat {
			 return AgoraVideoPixelFormatI420;
		}

	2. 初始化自定义的 Video Renderer
		- (BOOL)shouldInitialize {
			return YES;
		}

	3. 启动自定义的 Video Renderer 
		- (void)shouldStart {
		}

	4. Agora SDK 停止抛出视频数据
		- (void)shouldStop {
		}

	5. 自定义的 Video Renderer 可以被释放   
		- (void)shouldDispose {
		}

	6. Agora SDK 通过该接口抛出 CVPixelBuffer 类型的视频数据, 自定义 Video Renderer 可以获取数据进行渲染
		- (void)renderPixelBuffer:(CVPixelBufferRef _Nonnull)pixelBuffer rotation:(AgoraVideoRotation)rotation {
		}

		Agora SDK 通过该接口抛出 rawData 类型的视频数据, 自定义 Video Renderer 可以获取数据进行渲染
		- (void)renderRawData:(void * _Nonnull)rawData size:(CGSize)size rotation:(AgoraVideoRotation)rotation {
		}
	```

2. 将遵守了  AgoraVideoSourceProtocol 协议的自定义 VideoRenderer 对象设给 AgoraRtcEngineKit。

	```swift
	//swift
	agoraKit.setLocalVideoRenderer(videoRenderer)
	agoraKit.setRemoteVideoRenderer(videoRenderer, forUserId: uid)
	```
	
	```objective-c
	//objective-c
	[agoraKit setLocalVideoRenderer: videoRenderer];
	[agoraKit setRemoteVideoRenderer: videoRenderer, uid];
	```

**相关 API 及链接**
* [`setLocalVideoRenderer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVideoRenderer:)
* [`setRemoteVideoRenderer:forUserId:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVideoRenderer:forUserId:)
* [`AgoraVideoSinkProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSinkProtocol.html)

## 开发注意事项
客户端自定义采集和渲染属于较复杂的功能，开发者自身需要具备音视频相关知识，能够自己独立开发完成采集与渲染。