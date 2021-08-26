## Understand the tech

During real-time communications, you can pre- and post-process the video data and modify it for desired playback effects.

The Native SDK uses the `IVideoFrameObserver` class to provide raw video data functions. You can pre-process the data before sending it to the encoder and modify the captured video frames. You can also post-process the data after sending it to the decoder and modify the received video frames.

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

### Process raw video data using Objective-C APIs

1. Call `setVideoFrameDelegate` to set the video frame delegate before joining the channel.
2. Implement the `onCaptureVideoFrame`, `onScreenCaptureVideoFrame`, and `onRenderVideoFrame` callbacks. These callbacks capture and process the video frames.

### Process raw video data using C++ APIs

1. Before joining the channel, call `registerVideoFrameObserver` to register the video frame observer, and implement the `IVideoFrameObserver` class.
2. After registering the observer, the SDK returns the raw video data in the `onCaptureVideoFrame`, `onPreEncodeVideoFrame`, or `onRenderVideoFrame`  callbacks for each video frame.
3. Process the raw video data, and then send the processed data back to the SDK through the callbacks mentioned in step 2.

#### API call sequence

The following figure shows how to implement the raw data function in your project:

![img](https://web-cdn.agora.io/docs-files/1578466906009)

#### Sample code

In addition to the API call sequence diagram, you can refer to the following code samples to implement the raw video data function in your project.

1. Initialize `AgoraRtcEngineKit`, and enable the video module.

   ```swift
   // Swift
   // Initialize AgoraRtcEngineKit
   let config = AgoraRtcEngineConfig()
   agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

   // Enable the vide module
   agoraKit.enableVideo()
   ```

2. Register the video frame observer.

   ```swift
   // Swift
   let videoType:ObserverVideoType = ObserverVideoType(rawValue: ObserverVideoType.captureVideo.rawValue | ObserverVideoType.renderVideo.rawValue | ObserverVideoType.preEncodeVideo.rawValue)
   agoraMediaDataPlugin?.registerVideoRawDataObserver(videoType)
   agoraMediaDataPlugin?.videoDelegate = self;
   ```

   In the `.mm` file, call the C++ APIs to implement `registerVideoRawDataObserver`.

   ```objective-c
   - (void)registerVideoRawDataObserver:(ObserverVideoType)observerType {
     // Get the C++ handle of the Native SDK
     agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
     // Create IMediaEngine
     agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
     mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
     // Call registerVideoFrameObserver to register the video frame observer
     mediaEngine->registerVideoFrameObserver(&s_videoFrameObserver);
     s_videoFrameObserver.mediaDataPlugin = self;
   }
   ```

3. Join a channel.

   ```swift
   // Swift
   let result = agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed) -> Void in
     self.isJoined = true
     LogUtils.log(message: "Join \(channel) with uid \(uid) elapsed \(elapsed)ms", level: .info)
   }
   ```

4. Get the raw video data, and process the data.

   ```swift
   // Swift
   // Get the video frame captured by the local camera.
   func mediaDataPlugin(_ mediaDataPlugin: AgoraMediaDataPlugin, didCapturedVideoRawData videoRawData: AgoraVideoRawData) -> AgoraVideoRawData {
     return videoRawData
   }

   // Get the video frame sent by the remote user.
   func mediaDataPlugin(_ mediaDataPlugin: AgoraMediaDataPlugin, willRenderVideoRawData videoRawData: AgoraVideoRawData, ofUid uid: uint) -> AgoraVideoRawData {
     return videoRawData
   }
   ```

   In the `.mm` file, call the C++ APIs to implement the callbacks that get the raw data.

   ```objective-c
   // Get the video frame captured by the local camera through the onCaptureVideoFrame callback
   virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) override
   {
       if (!mediaDataPlugin && ((mediaDataPlugin.observerVideoType >> 0) == 0)) return true;
       @autoreleasepool {
           AgoraVideoRawData *newData = nil;
           if ([mediaDataPlugin.videoDelegate respondsToSelector:@selector(mediaDataPlugin:didCapturedVideoRawData:)]) {
               AgoraVideoRawData *data = getVideoRawDataWithVideoFrame(videoFrame);
               newData = [mediaDataPlugin.videoDelegate mediaDataPlugin:mediaDataPlugin didCapturedVideoRawData:data];
               modifiedVideoFrameWithNewVideoRawData(videoFrame, newData);
           }
       }
     return true;
   }

   // Get the video frame sent by the remote user through the  onRenderVideoFrame callback
   virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) override
   {
       if (!mediaDataPlugin && ((mediaDataPlugin.observerVideoType >> 1) == 0)) return true;
       @autoreleasepool {
           AgoraVideoRawData *newData = nil;
           if ([mediaDataPlugin.videoDelegate respondsToSelector:@selector(mediaDataPlugin:willRenderVideoRawData:ofUid:)]) {
               AgoraVideoRawData *data = getVideoRawDataWithVideoFrame(videoFrame);
               newData = [mediaDataPlugin.videoDelegate mediaDataPlugin:mediaDataPlugin willRenderVideoRawData:data ofUid:uid];
               modifiedVideoFrameWithNewVideoRawData(videoFrame, newData);
           }
       }
     return true;
   }
   ```

5. Unregister the video frame observer.

   ```swift
   // Swift
   agoraMediaDataPlugin?.deregisterVideoRawDataObserver(ObserverVideoType(rawValue: 0))
   ```

   Call the C++ APIs in the `.mm` file to implement `deregisterVideoRawDataObserver`.

   ```objective-c
   - (void)deregisterVideoRawDataObserver:(ObserverVideoType)observerType {
     // Get the C++ handle of the Native SDK
     agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
     // Create IMediaEngine
     agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
     mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
     // Call registerVideoFrameObserver to unregister the video frame observer
     mediaEngine->registerVideoFrameObserver(NULL);
     s_videoFrameObserver.mediaDataPlugin = nil;
   }
   ```

## Reference

This section includes reference information about the function.

### Sample project

Agora provides the following open-source sample projects on GitHub that implement the raw video data function:

- iOS: [RawMediaData](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/RawMediaData/RawMediaData.swift)

### API reference

- setVideoFrameDelegate

- onCaptureVideoFrame
- onScreenCaptureVideoFrame
- onRenderVideoFrame
- onMediaPlayerVideoFrame

- [`getNativeHandle`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getNativeHandle)
- [`registerVideoFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a5eee4dfd1fd46e4a865feba163f3c5de)
- [`onCaptureVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a915c673aec879dcc2b08246bb2fcf49a)
- [`onRenderVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a966ed2459b6887c52112af638bc27c14)
- [`onPreEncodeVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)

## Considerations

- The raw video data function is implemented by the C++ APIs of the SDK, and you need to mix the Objective-C and C++ in a `.mm` file. See [AgoraMediaDataPlugin.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/RawDataApi/AgoraMediaDataPlugin.mm) for reference.
- Ensure that you call `getNativeHandle` to get the C++ handle each time before calling `registerVideoFrameObserver`.
- The raw video data function is resource intensive and may affect performance.