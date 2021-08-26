## Understand the tech

During real-time communications, you can pre- and post-process the audio and video data and modify them for desired playback effects.

Agora provides the raw data function for you to process the audio data according to your scenarios. This function enables you to pre-process the captured audio signal before sending it to the encoder, or to post-process the decoded audio signal.

The raw audio data function is resource intensive and may affect performance.
### Data transfer

The following figure shows the data transfer while pre- or post-processing raw audio data.

![](https://web-cdn.agora.io/docs-files/1604635727525)

With `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame` , you can:

- Get raw audio frames.
- Process the raw frames and return to the SDK.
### API call sequence

The following figure shows how to implement the raw audio data function in your project:

![](https://web-cdn.agora.io/docs-files/1618545452564)

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

To implement the raw audio data function in your project, refer to the following steps.

1. Call `setAudioFrameDelegate` to set the audio frame delegate before joining the channel.

2. Call the `setRecordingAudioFrameParametersWithSampleRate`, `setPlaybackAudioFrameParametersWithSampleRate`, `setMixedAudioFrameParametersWithSampleRate`, or `setPlaybackAudioFrameBeforeMixingParametersWithSampleRate` methods to set the format of the audio frames.

3. Implement the `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, and `onMixedAudioFrame` callbacks. These callbacks capture and process the audio frames. If the callback returns `false`, the audio frame is not successfully processed.

### Sample code

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

## Reference

This section includes reference information about the function.

### Sample project

Agora provides the following open-source sample project on GitHub that implement the raw audio data function:

[RawAudioData](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/RawAudioData/RawAudioData.swift)

### API Reference

- [`setAudioFrameDelegate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioFrameDelegate:)
- [`setRecordingAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRecordingAudioFrameParametersWithSampleRate:channel:mode:samplesPerCall:)
- [`setPlaybackAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setPlaybackAudioFrameParametersWithSampleRate:channel:mode:samplesPerCall:)
- [`setMixedAudioFrameParametersWithSampleRate`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMixedAudioFrameParametersWithSampleRate:samplesPerCall:)
- [`onRecordAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onRecordAudioFrame:)
- [`onPlaybackAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrame:)
- [`onMixedAudioFrame`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onMixedAudioFrame:)
- [`onPlaybackAudioFrameBeforeMixing`](https://docs.agora.io/cn/Voice/API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrameBeforeMixing:uid:)