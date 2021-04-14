---
title: Custom Video Source and Renderer
platform: iOS
updatedAt: 2020-12-01 03:27:49
---
## Introduction

By default, the Agora SDK uses default audio and video modules for capturing and rendering in real-time communications. 

However, the default modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio or video module.
- You want to use a non-camera source, such as recorded screen data.
- You need to process the captured video with a pre-processing library for functions such as image enhancement.
- You need flexible device resource allocation to avoid conflicts with other services.

This article tells you how to use the Agora Native SDK to customize the video source and renderer.

## Implementation

Before customizing the video source or renderer, ensure that you have implemented the basic real-time communication functions in your project. For details, see the following documents:
- iOS: [Start a Call](start_call_ios) or [Start a Live Broadcast](start_live_ios).
- macOS: [Start a Call](start_call_mac) or [Start a Live Broadcast](start_live_mac).

### Customize video source

The Agora SDK provides two methods to customize the video source: Push mode and MediaIO.

- With Push mode, the SDK conducts no data processing to the audio frame, such as noise reduction. Implement noise reduction on your own if you have such requirements.
- With MediaIO, Agora provides the `AgoraVideoSourceProtocol` and `AgoraVideoSinkProtocol`. You can create more varied use cases by using these two interfaces.

#### Push mode

Refer to the following steps to customize the video source in Push mode:

1. Call the `setExternalVideoSource` method by `joinChannelByToken` to enable the external video source.
2. Manage video data capturing and processing on your own.
3. Send the video data back to the SDK using the `pushExternalVideoFrame` method.

**API call sequence**

Refer to the following diagram to customize the video source in your project.

![](https://web-cdn.agora.io/docs-files/1569400609106)

**Sample code**

Refer to the following sample code to customize the video source in your project.

```swift
// Swift
// Push the video frame in the VPixelBufferRef format.
let videoFrame = AgoraVideoFrame()
videoFrame.format = 12
// [NSDate date].timeIntervalSince1970 indicates the current timestamp, and 1000 indicates 1000 frames per second.
videoFrame.time = CMTimeMakeWithSeconds([NSDate date].timeIntervalSince1970, 1000)
videoFrame.textureBuf = "Your CVPixelBufferRef"
videoFrame.ratation = 0

// Push the video frame in the rawData format.
let videoFrame = AgoraVideoFrame()
videoFrame.format = "your data fromat"
// [NSDate date].timeIntervalSince1970 indicates the current timestamp, and 1000 indicates 1000 frames per second.
videoFrame.time = CMTimeMakeWithSeconds([NSDate date].timeIntervalSince1970, 1000)
videoFrame.data = "your rawData"
videoFrame.strideInPixels = "your stride"
videoFrame.height = "your height"
videoFrame.dataBuf = "your rawData"
videoFrame.ratation = 0

agoraKit.pushExternalVideoFrame(videoFrame)
```

```objective-c
// Objective-C
// Push the video frame in the CVPixelBufferRef format.
AgoraVideoFrame *videoFrame = [[AgoraVideoFrame alloc] init];
videoFrame.format = 12;
// [NSDate date].timeIntervalSince1970 indicates the current timestamp, and 1000 indicates 1000 frames per second.
videoFrame.time = CMTimeMakeWithSeconds([NSDate date].timeIntervalSince1970, 1000);
videoFrame.textureBuf = "Your CVPixelBufferRef";
videoFrame.ratation = 0;

// Push the video frame in the rawData format.
AgoraVideoFrame *videoFrame = [[AgoraVideoFrame alloc] init];
videoFrame.format = "your data fromat";
// [NSDate date].timeIntervalSince1970 indicates the current timestamp, and 1000 indicates 1000 frames per second.
videoFrame.time = CMTimeMakeWithSeconds([NSDate date].timeIntervalSince1970, 1000);
videoFrame.data = "your rawData";
videoFrame.strideInPixels = "your stride";
videoFrame.height = "your height";
videoFrame.dataBuf = "your rawData";
videoFrame.ratation = 0;

[agoraKit pushExternalVideoFrame: videoFrame];
```

We provide an open-source [Agora-Custom-Media-Device](https://github.com/AgoraIO/Advanced-Video/tree/master/iOS%26macOS/Agora-Custom-Media-Device) demo project on GitHub. You can try the demo and view the source code in the [LiveRoomViewController.swift](https://github.com/AgoraIO/Advanced-Video/blob/master/iOS%26macOS/Agora-Custom-Media-Device/Agora-Custom-Media-Device/LiveRoomViewController.swift) file.

**API reference**

- [`setExternalVideoSource`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setExternalVideoSource:useTexture:pushMode:)
- [`pushExternalVideoFrame`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalVideoFrame:)

#### MediaIO

With MediaIO, Agora provides `AgoraVideoSourceProtocol`  and `AgoraVideoFrameConsumer` to set the video format of the external video data and control the capturing process.

Refer to the following steps to customize the video source with MediaIO in your project:

1. Implement `AgoraVideoSourceProtocol`. Agora manages external video data capturing with the callbacks in `AgoraVideoSourceProtocol`:
	- After receiving the `gufferType` callback, specify the format of the video data in the return value of this callback.
	- After receiving the `shouldInitialize` callback, save the `AgoraVideoFrameConsumer` object in this callback. Agora receives and sends the customized video data with the `AgoraVideoFrameConsumer` object.
	- After receiving the `shouldStart` callback, send the captured video data to the SDK with the `AgoraVideoFrameConsumer` object.
	- After receiving the `shouldStop` callback, stop sending the video data.
	- After receiving the `shouldDispose` callback, release the `AgoraVideoFrameConsumer` object.
2. Inherit `AgoraVideoSourceProtocol` class to create a custom video source object.
3. Call the `setVideoSource` method to set the custom video source to AgoraRtcEngineKit.
4. Call the `startPreview` or `joinChannelByToken` method to preview or send the customized video data according to your scenario.

**API call sequence**

Refer to the following diagram to customize the video source in your project.

![](https://web-cdn.agora.io/docs-files/1569401404182)

**Sample code**

Refer to the following code to customize the video source in your project.

1. Implement the AgoraVideoSourceProtocol to create a video source class.

	```swift
	//Swift
	     // variable in the protocal
		 var consumer: AgoraVideoFrameConsumer?
	     // Use the consumer method to transfer the video data to the Agora SDK.

		 // Transfer the video frame in the rawData format.
		 consumer.consumeRawData("your rawData", withTimestamp: CMTimeMake(1, 15), format: "your data format", size: size, rotation: rotation)

		 // Transfer the video frame in the CVPixelBuffer format.
		 consumer.consumePixelBuffer("your pixelBuffer", withTimestamp: CMTimeMake(1, 15), rotation: rotation)

	    // Implements the protocol.
	    // 1. Set the buffer type to capture the video.
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

	    // 2. Initializes the custom video source.
		func shouldInitialize() -> Bool {
		}

	    // 3. Transfers the video data with Consumer when the customized video source starts capturing.
		func shouldStart() {
		}

	    // 4. Stops capturing.
		func shouldStop() { 
		}

	    // 5. Releases the video source.
		func shouldDispose() {
		}
	```
	
	```objective-c
	// Objective-C
	// Variable in the protocol.
	@synthesize consumer;
	// Use the consumer method to transfer the video data to the Agora SDK:

		// Transfers the video frame in the rawData format.
		[consumer consumeRawData: "your rawData" withTimestamp: CMTimeMake(1, 15) format: "your data format" size: size rotation: rotation];

		// Transfers the video frame in the CVPixelBuffer format.
		[consumer consumePixelBuffer: "your pixelBuffer" withTimestamp: CMTimeMake(1, 15) rotation: rotation];

	    // Implements the protocol.
	    // 1. Sets the buffer type to capture the video.
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

	    // 2. Initializes the custom video source.
		- (BOOL)shouldInitialize {
				return YES;
		}

	    // 3. Transfers the video data with Consumer when the customized video source starts capturing.
		- (void)shouldStart {
		}

	    // 4. Stops capturing.
		- (void)shouldStop {
		}

	    // 5. Releases the video source.
		- (void)shouldDispose {
		}
	```
	
2. Pass the VideoSource object to AgoraRtcEngineKit.

	```swift
	// Swift
	agoraKit.setVideoSource(videoSource)
	```

	```objective-c
	// Objective-C
	[agoraKit setVideoSource: videoSource];
	```

We provide an open-source [Agora-Custom-Media-Device-iOS](https://github.com/AgoraIO/Advanced-Video/tree/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-iOS) demo project on GitHub. You can try the demo and view the source code in the [AgoraCamera.swift](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-iOS/Agora-Custom-Media-Device/CustomMediaDevices/AgoraCamera.swift) file.
	
**API Reference**

* [`setVideoSource`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoSource:)
* [`AgoraVideoSourceProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSourceProtocol.html)
* [`AgoraVideoFrameConsumer`](./API%20Reference/oc/Protocols/AgoraVideoFrameConsumer.html)
	

### Customize video renderer

Video data captured with MediaIO can be rendered with the customized video renderer using `AgoraVideoSinkProtocol`.

Refer to the following steps to customize the video renderer with MediaIO in your project:

1. Implement `AgoraVideoSinkProtocol`. Agora manages external video data rendering with the callbacks in `AgoraVideoSinkProtocol`:
	- After receiving the `bufferType` and `pixelFormat` callbacks, specify the format of video data in the return value of the respective callback.
	- Manage the rendering process of the video data with the `shouldInitialize`, `shouldStart`, `shouldStop`, and `onDispose` callbacks.
	- Implement an `AgoraVideoFrameConsumer` object with the specified video format to get the video data.
2. Inherit `AgoraVideoSinkProtocol` to create a customized sink object.
3. Call the `setLocalVideoRenderer` or `setRemoteVideoRenderer` method for local or remote rendering according to your scenario.
4. Call the `startPreview` or `joinChannelByToken` method to preview or send the rendered video data.

**API call sequence**

Refer to the following diagram to customize the video sink in your project.

![](https://web-cdn.agora.io/docs-files/1585286519369)

**Sample code**

Refer to the following code to customize the video sink in your project.

1. Implement the AgoraVideoSinkProtocal and create the customized video renderer class.

	```swift
	// Swift
	    // Implements AgoraVideoSinkProtocal.
	    // 1. Sets the buffer type that the Agora SDK sends.
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

		// Sets the video data format that the Agora SDK sends.
		func pixelFormat() -> AgoraVideoPixelFormat {
				return pixelFormat
		}

	    // 2. Initializes the custom Video Renderer.
		func shouldInitialize() -> Bool {
				return true
		}

	    // 3. Starts the Video Renderer.  
		func shouldStart() {

		}

	    // 4. The Agora SDK stops sending video data.
		func shouldStop() {

		}

	    // 5. Releases the custom Video Renderer.
		func shouldDispose() {

		}

	    // 6. The Agora SDK sends the video frame in the CVPixelBuffer format, and the customized Video Renderer gets the data for rendering.
		func renderPixelBuffer(_ pixelBuffer: CVPixelBuffer, rotation: AgoraVideoRotation) {
		}

		The Agora SDK sends the video frame in the rawData format, and the customized Video Renderer gets the data for rendering.
		func renderRawData(_ rawData: UnsafeMutableRawPointer, size: CGSize, rotation: AgoraVideoRotation) {
		}
	}
	```

	```objective-c
	// Objective-C
	    // Implements AgoraVideoSinkProtocal.
	    // 1. Sets the buffer type that the Agora SDK sends.
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

		// Sets the video data format that the Agora SDK sends.
		- (AgoraVideoPixelFormat)pixelFormat {
			 return AgoraVideoPixelFormatI420;
		}

	    // 2. Initializes the custom Video Renderer.
		- (BOOL)shouldInitialize {
			return YES;
		}

	    // 3. Starts the Video Renderer.
		- (void)shouldStart {
		}

	    // 4. The Agora SDK stops sending the video data.
		- (void)shouldStop {
		}

	    // 5. Releases the custom Video Renderer.
		- (void)shouldDispose {
		}

	    // 6. The Agora SDK sends the video frame in the CVPixelBuffer format, and the customized Video Renderer gets the data for rendering.
		- (void)renderPixelBuffer:(CVPixelBufferRef _Nonnull)pixelBuffer rotation:(AgoraVideoRotation)rotation {
		}

		// The Agora SDK sends the video frame in the rawData format, and the customized Video Renderer gets the data for rendering.
		- (void)renderRawData:(void * _Nonnull)rawData size:(CGSize)size rotation:(AgoraVideoRotation)rotation {
		}
	```
	
2. Pass the VideoRenderer object to AgoraRtcEngineKit.

	```swift
	// Swift
	agoraKit.setLocalVideoRenderer(videoRenderer)
	agoraKit.setRemoteVideoRenderer(videoRenderer, forUserId: uid)
	```
	
	```objective-c
	// Objective-C
	[agoraKit setLocalVideoRenderer: videoRenderer];
	[agoraKit setRemoteVideoRenderer: videoRenderer, uid];
	```

We provide an open-source [Agora-Custom-Media-Device-iOS](https://github.com/AgoraIO/Advanced-Video/tree/master/iOS%26macOS/Agora-Custom-Media-Device) demo project on GitHub. You can try the demo and view the source code in the [AgoraRenderView.swift](https://github.com/AgoraIO/Advanced-Video/blob/master/iOS%26macOS/Agora-Custom-Media-Device/Agora-Custom-Media-Device/CustomMediaDevices/AgoraRenderView.swift) file.

**API Reference**

* [`setLocalVideoRenderer`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVideoRenderer:)
* [`setRemoteVideoRenderer`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVideoRenderer:forUserId:)
* [`AgoraVideoSinkProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSinkProtocol.html)
* [`AgoraVideoFrameConsumer`](./API%20Reference/oc/Protocols/AgoraVideoFrameConsumer.html)


## Considerations
Customizing the video source and sink requires you to manage video data recording and playback on your own.

- When customizing the video source, you need to capture and process the video data on your own.
- When customizing the video sink, you need to process and render the video data on your own.

## Reference

Refer to [Custom Audio Source and Sink](custom_audio_apple) if you want to customize the audio source and sink in your project.


	
