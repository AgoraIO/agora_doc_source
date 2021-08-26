## Understand the tech

During real-time communications, you can pre- and post-process the audio and video data and modify them for desired playback effects.

Agora provides the raw data function for you to process the audio data according to your scenarios. This function enables you to pre-process the captured audio signal before sending it to the encoder, or to post-process the decoded audio signal.

### Data transfer

The following figure shows the data transfer while pre- or post-processing raw audio data.

![](https://web-cdn.agora.io/docs-files/1604635727525)

With `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame` , you can:

- Get raw audio frames.
- Process the raw frames and return to the SDK.

### Process raw audio data using Objective-C APIs

#### API call sequence

The following figure shows how to implement the raw audio data function in your project:

![](https://web-cdn.agora.io/docs-files/1618545452564)

### Process raw audio data using C++ APIs

#### API call sequence

The following figure shows how to implement the raw data functions in your project:

![](https://web-cdn.agora.io/docs-files/1569210004744)


## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).
## Implementation

### Process raw audio data using Objective-C APIs


1. Call `setAudioFrameDelegate` to set the audio frame delegate before joining the channel.

2. Call the `setRecordingAudioFrameParametersWithSampleRate`, `setPlaybackAudioFrameParametersWithSampleRate`, `setMixedAudioFrameParametersWithSampleRate`, or `setPlaybackAudioFrameBeforeMixingParametersWithSampleRate` methods to set the format of the audio frames.

3. Implement the `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, and `onMixedAudioFrame` callbacks. These callbacks capture and process the audio frames.

   <div class="alert note">If the callback returns <code>false</code>, the audio frame is not successfully processed.</div>


#### Sample code

```swift
// swift

class RawAudioDataMain: BaseViewController {
    var localVideo = Bundle.loadVideoView(type: .local, audioOnly: true)
    var remoteVideo = Bundle.loadVideoView(type: .remote, audioOnly: true)

    @IBOutlet weak var container: AGEVideoContainer!
    // Define the agoraKit variable
    var agoraKit: AgoraRtcEngineKit!

    ...
     // Initialize agoraKit and register related callbacks
    agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

    // Call setAudioFrameDelegate to set the audio frame delegate. You need to implement an AgoraAudioFrameDelegate protocol in this method
    agoraKit.setAudioFrameDelegate (self)

    // Call the set methods to set the format of the audio frames captured by each callback
    agoraKit.setRecordingAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)
    agoraKit.setMixedAudioFrameParametersWithSampleRate (44100, samplesPerCall: 4410)
    agoraKit.setPlaybackAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)

    ...

    // Implement an extension of the AgoraAudioFrameDelegate protocol in the current class
    extension RawAudioDataMain: AgoraAudioFrameDelegate {


    // Implement the onRecordAudioFrame callback
        func onRecordAudioFrame(_ frame: AgoraAudioFrame) -> Bool {
               return true;
        }
    // Implement the onPlaybackAudioFrame callback
        func onPlaybackAudioFrame(_ frame: AgoraAudioFrame) -> Bool {
               return true;
        }
    // Implement the onMixedAudioFrame callback
        func onMixedAudioFrame(_ frame: AgoraAudioFrame) -> Bool {
               return true;
        }
    // Implement the onPlaybackAudioFrame callback
        func onPlaybackAudioFrame(beforeMixing frame: AgoraAudioFrame, uid: UInt) -> Bool {
               return true;
        }
      }

```

### Process raw audio data using C++ APIs

Follow these steps to implement the raw data functions using C++ APIs:

1. Call the `registerAudioFrameObserver` method to register a audio observer object before joining the channel. You need to implement an `IAudioFrameObserver` class in this method.
2. After you successfully register the observer object, the SDK triggers the  `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame`  callback to send the raw audio data at the set time interval.
3. After acquiring the raw data, you can process the captured raw data based on your scenario and send the processed data to the SDK via the callbacks mentioned in step 2.

<div class="alert note">To implement the preceding steps, you need to call C++ methods on iOS or macOS.
	<ul><li>Code logics where both Objective-C and C++ methods are called should be implemented in an <code>.mm</code> file.</li><li>Ensure that you import the C++ header file at the beginning of the <code>.mm</code> file.</li><li>Before calling <code>registerAudioFrameObserver</code>, you need to call <code>getNativeHandler</code> in order to receive C++ callbacks.</li></ul>
</div>

#### Sample code

In addition to the API call sequence diagram, you can refer to the following code samples.

**1. Initialize AgoraRtcEngineKit**

Call `sharedEngineWithConfig` to initialize AgoraRtcEngineKit.

```swift
// Swift
// Initialize AgoraRtcEngineKit
let config = AgoraRtcEngineConfig()
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
```

**2. Register an audio frame observer**

```swift
// Swift
let audioType:ObserverAudioType = ObserverAudioType(rawValue: ObserverAudioType.recordAudio.rawValue | ObserverAudioType.playbackAudioFrameBeforeMixing.rawValue | ObserverAudioType.mixedAudio.rawValue | ObserverAudioType.playbackAudio.rawValue);
agoraMediaDataPlugin?.registerAudioRawDataObserver(audioType)
agoraMediaDataPlugin?.audioDelegate = self
```

The Agora SDK provides only C++ methods and callbacks for implementing the raw audio data function. Therefore, you need to call C++ methods on iOS or macOS to register an audio frame observer.

<div class="alert note">The following code should be implemented in the <code>.mm</code> file.</div>

```C++
// Import the C++ header file
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>

- (void)registerAudioRawDataObserver:(ObserverAudioType)observerType {
    // Gets the C++ event handler of the RTC Native SDK
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    // Creates an IMediaEngine instance
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // Ensure that you call queryInterface in IMediaEngine to set the agora::AGORA_IID_MEDIA_ENGINE interface, or you cannot implement registerAudioFrameObserver
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);

    NSInteger oldValue = self.observerAudioType;
    self.observerAudioType |= observerType;

    if (mediaEngine && oldValue == 0)
    {
        // Register an audio frame observer
        mediaEngine->registerAudioFrameObserver(&s_audioFrameObserver);
        s_audioFrameObserver.mediaDataPlugin = self;
    }
}
```

**3. Set the audio frame capture parameters**

If you want to modify the audio sampling rate, use mode, number of channels, or sampling interval of the captured audio data, you can call the following methods:

```swift
// Swift
// Sets the audio data format returned in onRecordAudioFrame
agoraKit.setRecordingAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)
// Sets the audio data format returned in onMixedAudioFrame
agoraKit.setMixedAudioFrameParametersWithSampleRate(44100, samplesPerCall: 4410)
// Sets the audio data format returned in onPlaybackAudioFrame
agoraKit.setPlaybackAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)
```

**4. Join a channel**

Call `joinChannelByToken` to join an RTC channel.

```swift
// Swift
agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed)}
```

**5. Receive the captured audio data**

After joining a channel, you can receive the captured audio data from the callbacks in the `IAudioFrameObserver` class. You can also use these callbacks to send the processed audio data back to the SDK.

```swift
// Swift
// Gets the raw audio data of the local user, and sends the data back to the SDK after processing
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, didRecord audioRawData: AgoraAudioRawDate) -> AgoraAudioRawData {
  return audioRawData
}

// Gets the raw audio data of all remote users, and sends the data back to the SDK after processing
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, willPlaybackAudioRawData audioRawData: AgoraRawData) -> AgoraAudioRawData {
  return audioRawData
}

// Gets the raw audio data of a specified remote user, and sends the data back to the SDK after processing
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, willPlaybackBeforeMixing audioRawData: AgoraAudioRawData, ofUid uid: uint) -> AgoraAudioRawData {
  return audioRawData
}

// Gets the raw audio data of the local user and all remote users, and sends the data back to the SDK after processing
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, didMixedAudioRawData audioRawData: AgoraAudioRawData) -> AgoraAudioRawData {
  return audioRawData
}
```

Call the C++ methods in the `.mm` file to implement the callbacks.

```swift
// Swift
class AgoraMediaDataPluginAudioFrameObserver : public agora::media::IAudioFrameObserver
{
public:
    AgoraMediaDataPlugin *mediaDataPlugin;

    // Defines the format of the raw audio data
    AgoraAudioRawData* getAudioRawDataWithAudioFrame(AudioFrame& audioFrame)
    {
        AgoraAudioRawData *data = [[AgoraAudioRawData alloc] init];
        data.samples = audioFrame.samples;
        data.bytesPerSample = audioFrame.bytesPerSample;
        data.channels = audioFrame.channels;
        data.samplesPerSec = audioFrame.samplesPerSec;
        data.renderTimeMs = audioFrame.renderTimeMs;
        data.buffer = (char *)audioFrame.buffer;
        data.bufferSize = audioFrame.samples * audioFrame.bytesPerSample;
        return data;
    }

    // Defines the format of the processed audio data
    void modifiedAudioFrameWithNewAudioRawData(AudioFrame& audioFrame, AgoraAudioRawData *audioRawData)
    {
        audioFrame.samples = audioRawData.samples;
        audioFrame.bytesPerSample = audioRawData.bytesPerSample;
        audioFrame.channels = audioRawData.channels;
        audioFrame.samplesPerSec = audioRawData.samplesPerSec;
        audioFrame.renderTimeMs = audioRawData.renderTimeMs;
    }

    // Receives the raw audio data of the local user from onRecordAudioFrame
    virtual bool onRecordAudioFrame(AudioFrame& audioFrame) override
    {

        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 0) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didRecordAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didRecordAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }

        // Sets the return value as true, meaning to send the data back to the SDK
        return true;
    }

    // Receives the raw audio data of all remote users from onPlaybackAudioFrame
    virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
    {

        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 1) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // Sets the return value as true, meaning to send the data back to the SDK
        return true;
    }

    // Receives the raw audio data of all remote users from onPlaybackAudioFrameBeforeMixing
    virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) override
    {

        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 2) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackBeforeMixingAudioRawData:ofUid:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackBeforeMixingAudioRawData:data ofUid:uid];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // Sets the return value as true, meaning to send the data back to the SDK
        return true;
    }

    // Receives the raw audio data of the local user and all remote users from onMixedAudioFrame
    virtual bool onMixedAudioFrame(AudioFrame& audioFrame) override
    {

        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 3) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didMixedAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didMixedAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // Sets the return value as true, meaning to send the data back to the SDK
        return true;
    }
};
```

**6. Stop registering the audio frame observer**

Call `registerAudioFrameObserver(NULL)` to stop registering the audio frame observer.

<div class="alert note">The following code should be implemented in the <code>.mm</code> file.</div>

```C++
- (void)deregisterAudioRawDataObserver:(ObserverAudioType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);

    self.observerAudioType ^= observerType;

    if (mediaEngine && self.observerAudioType == 0)
    {
        mediaEngine->registerAudioFrameObserver(NULL);
        s_audioFrameObserver.mediaDataPlugin = nil;
    }
}
```

## Reference

This section includes reference information about the function.

### Sample project

Agora provides the following open-source sample projects on GitHub that implement the raw audio data function:

- Process raw audio data using Objective-C APIs: [RawAudioData](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/RawAudioData/RawAudioData.swift)
- Process raw audio data using C++ APIs: [RawMediaData](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/RawMediaData/RawMediaData.swift)

### API Reference

- [`setAudioFrameDelegate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioFrameDelegate:)
- [`setRecordingAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRecordingAudioFrameParametersWithSampleRate:channel:mode:samplesPerCall:)
- [`setPlaybackAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setPlaybackAudioFrameParametersWithSampleRate:channel:mode:samplesPerCall:)
- [`setMixedAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMixedAudioFrameParametersWithSampleRate:samplesPerCall:)
- [`onRecordAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onRecordAudioFrame:)
- [`onPlaybackAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrame:)
- [`onMixedAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onMixedAudioFrame:)
- [`onPlaybackAudioFrameBeforeMixing`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrameBeforeMixing:uid:)

- [registerAudioFrameObserver]()
- [setRecordingAudioFrameParameters]()
- [setPlaybackAudioFrameParameters]()
- [setMixedAudioFrameParameters]()
- [onRecordAudioFrame]()
- [onPlaybackAudioFrame]()
- [onPlaybackAudioFrameBeforeMixing]()
- [onMixedAudioFrame]()

### Considerations

* The raw audio data function is implemented by the C++ APIs of the SDK, and you need to mix the Objective-C and C++ methods in an `.mm` file. See [AgoraMediaDataPlugin.mm](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Common/RawDataApi/AgoraMediaDataPlugin.mm) for reference.

- Ensure that you call `getNativeHandler` to get the C++ handle before calling the C++ method.
- The raw audio data function is resource intensive and may affect performance.