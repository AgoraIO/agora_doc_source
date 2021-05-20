---
title: Custom Video Source and Renderer
platform: iOS
updatedAt: 2019-09-20 17:36:41
---
## Introduction

By default, An App uses the internal audio and video modules for capturing and rendering during real-time communication. If developers hope to use external audio or video source and renderer, this page shows how to use the APIs provided by Agora SDK to customize the audio and video source and renderer.

**Customizing audio and video source and renderer** mainly applies to the following scenarios:

- When the audio or video source captured by the internal modules can not meet the needs of the developers. For example, for the purpose of image enhancement, developers need to process the captured video frame with a preprocessing library.
- When an App contains its own audio or video module and wants a cusmized source for  code reuse.
- When developers want to use non-camera source, such as recorded screen data.
- When developers need flexible device resource allocation to avoid conflicts with other services.

## Implementaions

Before proceeding, ensure that you have finished preparing the development environment. See [Integrate the SDK](./ios_video) for details.

### Customize the Audio Source

Use the Push method to customize the audio source, where the SDK conducts no data processing to the audio frame, such as noise reduction.

```swift
//swift
// Push the video frame in the format of rawData
agoraKit.pushExternalAudioFrameRawData("your rawData", samples: "per push samples", timestamp: 0)

// Push the video frame in the format of CMSampleBuffer
agoraKit.pushExternalAudioFrameSampleBuffer("your CMSampleBuffer")
```

```objective-c
//objective-c
// Push the video frame in the format of rawData
[agoraKit pushExternalAudioFrameRawData: "your rawData" samples: "per push samples", timestamp: 0];

// Push the video frame in the format of CMSampleBuffe
[agoraKit pushExternalAudioFrameSampleBuffer: "your CMSampleBuffer"];
```

**Relevant APIs and descriptions**
* [`pushExternalAudioFrameRawData:samples:timestamp:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
* [`pushExternalAudioFrameSampleBuffer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)


### Customize the Video Source

Agora SDK provides two methods to customze the video source:

- The MediaIO method (Recommended).
- The Push method. This method skips processing the video frame, and works best for clients with frame optimization capacity.

#### The MediaIO Method

Use the IVideoSource interface in MediaIO to customize the video source. This method sends the external video frame to the server, and developers need to implement local rendering if local preview is to be enabled.

1. Implement the AgoraVideoSourceProtocal to create a video source class.

	```swift
	     //swift
	     // variable in the protocal
		 var consumer: AgoraVideoFrameConsumer?
	     // use the consumer method to transfer the video data to Agora SDK

		 // transfer the video frame in the format of rawData
		 consumer.consumeRawData("your rawData", withTimestamp: CMTimeMake(1, 15), format: "your data format", size: size, rotation: rotation)

		 // transfer the video frame in the format of CVPixelBuffer
		 consumer.consumePixelBuffer("your pixelBuffer", withTimestamp: CMTimeMake(1, 15), rotation: rotation)

	// Implement the protocal
	1. Set the buffer type to capture the video
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

	2.initialize the custom  video source
		func shouldInitialize() -> Bool {
		}

	3. transfer the video data with Consumer when the customized video source starts capturing 
		func shouldStart() {
		}

	4. stop capturing
		func shouldStop() { 
		}

	5. release the video source
		func shouldDispose() {
		}
	```
	
	```objective-c
	//objective-c
	// variable in the protocal
	@synthesize consumer;
	// use the consumer method to transfer the video data to Agora SDK:

		// transfer the video frame in the format of rawData
		[consumer consumeRawData: "your rawData" withTimestamp: CMTimeMake(1, 15) format: "your data format" size: size rotation: rotation];

		// transfer the video frame in the format of CVPixelBuffer
		[consumer consumePixelBuffer: "your pixelBuffer" withTimestamp: CMTimeMake(1, 15) rotation: rotation];

	// Implement the protocal
	1. Set the buffer type to capture the video
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

	2. initialize the custom  video source
		- (BOOL)shouldInitialize {
				return YES;
		}

	3. transfer the video data with Consumer when the customized video source starts capturing 
		- (void)shouldStart {
		}

	4. stop capturing
		- (void)shouldStop {
		}

	5. release the video source
		- (void)shouldDispose {
		}
	```
	
2. Pass the VideoSource object to AgoraRtcEngineKit.

	```swift
	//swift
	agoraKit.setVideoSource(videoSource)
	```

	```objective-c
	//objective-c
	[agoraKit setVideoSource: videoSource];
	```
	
##### API Reference

* [`setVideoSource:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoSource:)
* [`AgoraVideoSourceProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSourceProtocol.html)
	
#### The Push Method

Compared to the MediaIO method, the Push method uses less codes, but lacks any optimization to the captured video frame. This method requires developers to do the processing.

```swift
//swift
// push the video frame in the format of CVPixelBufferRef
let videoFrame = AgoraVideoFrame()
videoFrame.format = 12
videoFrame.time = CMTimeMake(1, 15)
videoFrame.textureBuf = "Your CVPixelBufferRef"
videoFrame.ratation = 0

// push the video frame in the format of rawData
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
// push the video frame in the format of CVPixelBufferRef
AgoraVideoFrame *videoFrame = [[AgoraVideoFrame alloc] init];
videoFrame.format = 12;
videoFrame.time = CMTimeMake(1, 15);
videoFrame.textureBuf = "Your CVPixelBufferRef";
videoFrame.ratation = 0;

// push the video frame in the format of rawData
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

##### API Reference

* [`pushExternalVideoFrame:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalVideoFrame:)

### Customize the Video Renderer

Use the IVideoSink Interface of MediaIO to customize the video renderer.

1. Implement the AgoraVideoSinkProtocal and create the customized video renderer class.

	```swift
	//swift
	//Implement AgoraVideoSinkProtocal
	1. Set the buffer type that Agora SDK sends
		func bufferType() -> AgoraVideoBufferType {
				return bufferType
		}

		Set the video data format that Agora SDK send
		func pixelFormat() -> AgoraVideoPixelFormat {
				return pixelFormat
		}

	2. Initialize the custom Video Renderer
		func shouldInitialize() -> Bool {
				return true
		}

	3. Start the Video Renderer   
		func shouldStart() {

		}

	4. Agora SDK stops sending out video data
		func shouldStop() {

		}

	5. Release the custom Video Renderer
		func shouldDispose() {

		}

	6. Agora SDK sends out the video frame in the format of CVPixelBuffer, and the customized Video Renderer gets the data for rendering
		func renderPixelBuffer(_ pixelBuffer: CVPixelBuffer, rotation: AgoraVideoRotation) {
		}

		Agora SDK sends out the video frame in the format of rawData, and the customized Video Renderer gets the data for rendering
		func renderRawData(_ rawData: UnsafeMutableRawPointer, size: CGSize, rotation: AgoraVideoRotation) {
		}
	}
	```

	```objective-c
	//objective-c
	//Implement AgoraVideoSinkProtocal
	1. Set the buffer type that Agora SDK sends
		- (AgoraVideoBufferType)bufferType {
				return AgoraVideoBufferTypePixelBuffer;
		}

		Set the video data format that Agora SDK send
		- (AgoraVideoPixelFormat)pixelFormat {
			 return AgoraVideoPixelFormatI420;
		}

	2. Initialize the custom Video Renderer
		- (BOOL)shouldInitialize {
			return YES;
		}

	3. Start the Video Renderer 
		- (void)shouldStart {
		}

	4. Agora SDK stops sending out video data
		- (void)shouldStop {
		}

	5. Release the custom Video Renderer
		- (void)shouldDispose {
		}

	6. Agora SDK sends out the video frame in the format of CVPixelBuffer, and the customized Video Renderer gets the data for rendering
		- (void)renderPixelBuffer:(CVPixelBufferRef _Nonnull)pixelBuffer rotation:(AgoraVideoRotation)rotation {
		}

		Agora SDK sends out the video frame in the format of rawData, and the customized Video Renderer gets the data for rendering
		- (void)renderRawData:(void * _Nonnull)rawData size:(CGSize)size rotation:(AgoraVideoRotation)rotation {
		}
	```
	
2. Pass the VideoRenderer object to AgoraRtcEngineKit.

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

#### API Reference

* [`setLocalVideoRenderer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVideoRenderer:)
* [`setRemoteVideoRenderer:forUserId:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVideoRenderer:forUserId:)
* [`AgoraVideoSinkProtocal`](./API%20Reference/oc/Protocols/AgoraVideoSinkProtocol.html)

Agora also provides a sample app for customizing the video source and video sink. For details, see [Agora Custom Media Device](https://github.com/AgoraIO/Advanced-Video/tree/master/Custom-Media-Device/Agora-Custom-Media-Device-iOS).

## Considerations
Customizing audio/video source and renderer is an advanced feature provided by Agora SDK. To develop this function, we believe it necessary that you have adequate knowledge and experience in audio and video application development.


	
