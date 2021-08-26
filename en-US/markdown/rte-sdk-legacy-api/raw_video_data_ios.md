## Understand the tech

During real-time communications, you can pre- and post-process the video data and modify it for desired playback effects.

The Native SDK uses the `IVideoFrameObserver` class to provide raw video data functions. You can pre-process the data before sending it to the encoder and modify the captured video frames. You can also post-process the data after sending it to the decoder and modify the received video frames.

The raw video data function is resource intensive and may affect performance.
## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

### Process raw video data using Objective-C APIs

1. Call `setVideoFrameDelegate` to set the video frame delegate before joining the channel.
2. Implement the `onCaptureVideoFrame`, `onScreenCaptureVideoFrame`, and `onRenderVideoFrame` callbacks. These callbacks capture and process the video frames.

```swift
// swift

class RawVideoDataMain: BaseViewController {
    var localVideo = Bundle.loadVideoView(type: .local, audioOnly: false)
    var remoteVideo = Bundle.loadVideoView(type: .remote, audioOnly: false)

    @IBOutlet weak var container: AGEVideoContainer!
    // Define the agoraKit variable
    var agoraKit: AgoraRtcEngineKit!

    ...
     // Initialize agoraKit and register related callbacks
    agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)

    // Call setVideoFrameDelegate to set the video frame delegate.
    agoraKit.setVideoFrameDelegate (self)

    ...

    // Implement an extension of the AgoraVideoFrameDelegate protocol in the current class
    extension RawVideoDataMain: AgoraVideoFrameDelegate {

        // Implement the onCaptureVideoFrame callback
        func onCaptureVideoFrame(_ videoFrame: AgoraOutputVideoFrame) -> Bool {
               return true;
        }

        // Implement the onScreenCaptureVideoFrame callback
        func onScreenCaptureVideoFrame(_ videoFrame: AgoraOutputVideoFrame) -> Bool {
               return true;
        }

        // Implement the onScreenCaptureVideoFrame callback
        // TODO Still subject to changes
        func onRenderVideoFrame(_ videoFrame: AgoraOutputVideoFrame, uid: UInt, channelId: String) -> Bool {
               return true;
        }

```

## Reference

This section includes reference information about the function.
### API reference

- [setVideoFrameDelegate]()
- [onCaptureVideoFrame]()
- [onScreenCaptureVideoFrame]()
- [onRenderVideoFrame]()
- [onMediaPlayerVideoFrame]()

