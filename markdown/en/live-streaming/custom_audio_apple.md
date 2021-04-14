---
title: Custom Audio Source and Renderer
platform: iOS
updatedAt: 2021-01-21 03:50:40
---
## Introduction

The Agora SDK uses default audio modules for capturing and rendering in real-time communications.
However, these modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You want to use a pre-processing library for the audio data.
- You need flexible device resource allocation to avoid conflicts with other services.

This article introduces how to use the methods provided by the Agora SDK to implement custom audio capture and rendering to meet your needs.

## Sample project

Agora provides an open-sourced API-Example iOS sample project on GitHub that includes the following files that implement custom audio source and renderer functions:

| File                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [CustomAudioSource.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/CustomAudioSource.swift) | Implements the custom audio source function. Major methods include the following:<li><code>setupExternalAudioWithAgoraKit</code>: Sets the customized audio source.</li><li><code>enableExternalAudioSourceWithSampleRate</code>: Enables the external audio source.</li><li><code>joinChannelWithToken</code>: Joins an RTC channel.</li><li><code>willMove</code>: Stops using the external audio source and leaves the channel.</li> |
| [CustomAudioRender.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/CustomAudioRender.swift) | Implements the custom audio render function. Major methods include the following: <li><code>setupExternalAudioWithAgoraKit</code>: Sets the customized audio source.</li><li><code>setParameters</code>: Disables the audio rendering of the SDK.</li><li><code>joinChannelWithToken</code>: Joins an RTC channel.</li><li><code>willMove</code>: Stops using the external audio renderer and leaves the channel.</li> |
| [AudioController.h](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/ExternalAudio.h) | Defines an `AudioControllerDelegate` class. Once you implement this class, the app triggers callbacks that contain the captured audio data or the audio data to be rendered. |
| [AudioController.m](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/AudioController.m) | Implements the class and methods in the `AudioController.h` file. |
| [ExternalAudio.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/ExternalAudio.mm) | Implements customized audio source and renderer, and sends the captured audio data to the SDK. Major methods include the following:<li><code>setupExternalAudioWithAgoraKit</code>: Sets the audio sample rate, number of channels, capture mode, and render mode of the audio data.</li><li><code>didCaptureData</code>: Occurs when the audio data is received. Calls <code>setupExternalAudioWithAgoraKit</code> in this callback to send the captured data to the SDK.</li><li><code>didRenderData</code>: Occurs when the audio data to be rendered is received. Call <code>readAudioData</code> to render the audio in this callback.</li> |

## Custom audio source

### Implementation

Use the following steps to implement the custom audio source:

1. Before joining a channel, call `enableExternalAudioSourceWithSampleRate` to notify the SDK to use the external audio source.
2. Record and process the audio data on your own.
3. Send the audio data back to the SDK using `pushExternalAudioFrame`.

The API call sequence is as follows:

![custom audio source api sequence](https://web-cdn.agora.io/docs-files/1605766083489)

### Sample code

#### 1. Enable the external audio source

Call `enableExternalAudioSourceWithSampleRate` to notify the SDK to use customized audio source.

```swift
/**
 * Enables the external audio source.
 * @param sampleRate The sample rate of the audio data.
 * @param channel The number of channels of the audio data.
 */
agoraKit.enableExternalAudioSource(withSampleRate: sampleRate, channelsPerFrame: channel)
```

You need to define a method that specifies the sample rate and number of channels for capturing audio data. In the sample project, we define a `setUpAudioSessionWithSampleRate` method, and use the native methods of iOS to capture audio data.

```swift
/**
 * Enables external audio capture.
 * @param sampleRate The sample rate of the audio data.
 * @param channels The number of audio channels.
 * @param audioCRMode The audio capture mode.
 * @param ioType iOS The ioType for audio playback.
 */
[self.audioController setUpAudioSessionWithSampleRate:sampleRate channelCount:channels audioCRMode:audioCRMode IOType:ioType];
```

#### 2. Join a channel and start capturing

Call `joinChannelByToken` of the SDK to join a channel and use the `startWork` method to notify the app to start capturing audio data. In the sample code, we define a `startWork` method to enable the external audio source.

```swift
// Call joinChannelByToken to join a channel.
let result = agoraKit.joinChannel(byToken: nil, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed) -> Void in
        self.isJoined = true
        LogUtils.log(message: "Join \(channel) with uid \(uid) elapsed \(elapsed)ms", level: .info)
          
        // Call startWork to start capturing audio data.
        self.exAudio.startWork()
        try? AVAudioSession.sharedInstance().setPreferredSampleRate(Double(sampleRate))
              
    }
    if result != 0 {
        // A common error is invalid parameter.
        self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
    }
```

#### 3. Send the captured audio data to the SDK

After the system gets the audio data, call `pushExternalAudioFrameRawData` of the SDK to push the external audio data to the SDK.

You need a method to receive the captured audio data. In the sample code, we define an `AudioController` class, which contains a `didCaptureData` callback that occurs when receiving an audio frame.

```swift
// Occurs when the captured audio data is received. You can get the captured data in this callback.
- (void)audioController:(AudioController *)controller didCaptureData:(unsigned char *)data bytesLength:(int)bytesLength {
     
    if (self.audioCRMode != AudioCRModeExterCaptureSDKRender) {
        // Call pushExternalAudioFrameRawData to send the captured data to the SDK.
        [self.agoraKit pushExternalAudioFrameRawData:data samples:bytesLength / 2 timestamp:0];
    }
}
```

#### 4. Stop capturing audio data

Disable the external audio source to stop capturing when the user leaves the channel.

```swift
// Stops audio data capture when the user leaves the channel
if isJoined {
    exAudio.stopWork()
    // Call leaveChannel to leave the channel.
    agoraKit.leaveChannel { (stats) -> Void in
            LogUtils.log(message: "left channel, duration: \(stats.duration)", level: .info)
        }
    }
```

### API reference

- [`enableExternalAudioSourceWithSampleRate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSourceWithSampleRate:channelsPerFrame:)
- [`disableExternalAudioSource`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSource)
- [`pushExternalAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
- [`pushExternalAudioFrameSampleBuffer`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)


## Custom audio renderer

### Implementation

Choose either of the following methods to implement a custom audio renderer:

**Method one**

1. Before joining a channel, call `registerAudioFrameObserver` to register the audio frame observer, and implement the `IAudioFrameObserver ` class. 
   After registering the observer, you can get the raw audio data of all remote users through the `onPlaybackAudioFrame` callback.
2. Call `setParameters("{\"che.audio.external_render\": false}")` to disable the audio rendering of the SDK.
3. Use your own audio renderer to render the audio data in the `onPlaybackAudioFrame` callback.

<div class="alert note">
	To use this method, you need to call C++ APIs on iOS or macOS and pay attention to the following:
	<li>Mix the C++ and Objective-C code in a <code>.mm</code> file.</li>
	<li>Include the C++ header files in the begining of the <code>.mm</code> file:
		<pre>#import &lt;AgoraRtcKit/IAgoraMediaEngine.h>
#import &lt;AgoraRtcKit/IAgoraRtcEngine.h></pre>
	</li>
</div>

The API call sequence is as follows:

![custom audio renderer 1 api sequence](https://web-cdn.agora.io/docs-files/1605766115357)

**Method two**

1. Call `enableExternalAudioSink` to enable the external audio sink before joining a channel.
2. After you join the channel, call `pullPlaybackAudioFrameRawData` or `pullPlaybackAudioFrameSampleBufferByLengthInByte` to get the remote audio data according to the format of the audio data.
3. Render and play the remote audio data on your own.

The API call sequence is as follows:

![custom audio renderer 2 api sequence](https://web-cdn.agora.io/docs-files/1605766150369)

### Sample code

#### 1. Set up external audio

Define the `setupExternalAudioWithAgoraKit` method: First set the sample rate, number of audio channels, capture and render mode, and the playback channel, and then call `registerAudioFrameObserver` to register the audio frame observer.

```objective-c
// Define setupExternalAudioWithAgoraKit to set the external audio
- (void)setupExternalAudioWithAgoraKit:(AgoraRtcEngineKit *)agoraKit sampleRate:(uint)sampleRate channels:(uint)channels audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType {
   
  // Implement AudioController to trigger callbacks
  self.audioController = [AudioController audioController];
  self.audioController.delegate = self;
   
    // Register audio frame observer
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);  
 
    if (mediaEngine) {
        s_audioFrameObserver = new ExternalAudioFrameObserver();
        s_audioFrameObserver -> sampleRate = sampleRate;
        s_audioFrameObserver -> sampleRate_play = channels;
        mediaEngine->registerAudioFrameObserver(s_audioFrameObserver);
    }    
}
```

Call `setupExternalAudioWithAudioKit` and use the external renderer.

```swift
exAudio.setupExternalAudio(withAgoraKit: agoraKit, sampleRate: UInt32(sampleRate), channels: UInt32(channel), audioCRMode: .sdkCaptureExterRender, ioType: .remoteIO)
```

#### 2. Disable audio rendering of the SDK

```swift
agoraKit.setParameters("{\"che.audio.external_render\": false}")
```

#### 3. Get the audio data for rendering

After registering the audio frame observer, the SDK returns the raw audio data of remote users in the `onPlaybackAudioFrame` callback. Render the audio data in this callback.

```objective-c
virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
{
// Implement your own audio renderer
}
```

#### 4. Join a channel and start rendering

Call `joinChannelByToken` to join a channel, and start rendering after joining the channel successfully.

```swift
// Join a channel.
let result = agoraKit.joinChannel(byToken: nil, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed) -> Void in
        self.isJoined = true
        LogUtils.log(message: "Join \(channel) with uid \(uid) elapsed \(elapsed)ms", level: .info)
         
        // Start rendering audio.
        self.exAudio.startWork()
             
    }
    if result != 0 {
        // Report errors if joining failed, usually due to invalid parameters.
        self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
    }
```

#### 5. Stop rendering

Define `stopWork` and `cancelRegister.`

```objective-c
- (void)stopWork {
    [self.audioController stopWork];
    [self cancelRegister];
}
 
 
- (void)cancelRegister {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    // Unregister the audio frame observer.
    mediaEngine->registerAudioFrameObserver(NULL);
}
```

Stop rendering the audio when the user leaves the channel.

```swift
if isJoined {
// Stop rendering the audio
    exAudio.stopWork()
    // Leave the channel
    agoraKit.leaveChannel { (stats) -> Void in
            LogUtils.log(message: "left channel, duration: \(stats.duration)", level: .info)
        }
    }
```

### API reference

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)
- [`registerAudioFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae46ca0d20789787aaab2fb268a524100)
- [`onPlaybackAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)

## Considerations

Customizing the audio source and sink requires you to manage audio data recording and playback on your own.

- When customizing the audio source, you need to record and process the audio data on your own.
- When customizing the audio sink, you need to process and play back the audio data on your own.
- If you use the `onPlaybackAudioFrame` callback to get the raw audio data, ensure that you call `setParameters` to disable the audio rendering of the SDK.