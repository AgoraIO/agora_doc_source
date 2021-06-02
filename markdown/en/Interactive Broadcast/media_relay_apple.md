---
title: Co-host across Channels
platform: iOS
updatedAt: 2021-03-08 02:40:18
---
## Introduction

Co-hosting across channels refers to the process where the Agora SDK relays the media stream of a host from an interactive live streaming channel (source channel) to a maximum of four interactive live streaming channels (destination channels). It has the following benefits:

- All hosts in the relay channels can see and hear each other.
- The audience members in the relay channels can see and hear all hosts.

Co-hosting across channels applies to scenarios such as an online singing contest, where hosts of different channels interact with each other.

## Sample project

We provide an open-source channel media relay demo project that implements channel media relay on GitHub. You can try the demo and view the source code.
- iOS: [ChannelMediaRelay](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/MediaChannelRelay/MediaChannelRelay.swift) 
- macOS: [ChannelMediaRelay](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Advanced/ChannelMediaRelay/ChannelMediaRelay.swift)

## Implementation

<div class="alert note">To enable channel media relay, contact <a href="mailto:support@agora.io">support@agora.io</a>.</div>

Before relaying media streams across channels, ensure that you have implemented the basic real-time communication functions in your project. For details, see the following documents:
- iOS: [Start Live Interactive Streaming](start_live_ios).
- macOS: [Start Live Interactive Streaming](start_live_mac).

As of v2.9.0, the Agora Native SDK supports co-hosting across channels with the following methods:

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

Once the channel media relay starts, the SDK relays the media streams of a host from the source channel to at most four destination channels.

During the relay, the SDK reports the states and events of the channel media relay with the `channelMediaRelayStateDidChange` and `didReceiveChannelMediaRelayEvent` callbacks. Refer to the following codes and their corresponding states to implement you code logic:

| State codes | Event codes | The media stream relay state |
| ---------------- | ---------------- | ---------------- |
| AgoraChannelMediaRelayStateRunning(2) and AgoraChannelMediaRelayErrorNone(0)      | AgoraChannelMediaRelayEventSent-</br>ToDestinationChannel(4)     | The channel media relay starts.      |
| AgoraChannelMediaRelayStateFailure(3)      | /     | Exceptions occur for the media stream relay. Refer to the error parameter for troubleshooting.      |
| AgoraChannelMediaRelayStateIdle(0) and AgoraChannelMediaRelayErrorNone(0)      | /     | The channel media relay stops.      |

**Note**:
- Any host in an interactive live streaming channel can call the `startChannelMediaRelay` method to enable channel media stream relay. The SDK relays the media streams of the host who calls the method.
- During the media stream relay, if the host of the destination channel drops offline or leaves the channel, the host of the source channel receives the `didOfflineOfUid` callback.

### API call sequence

Follow the API call sequence to implement your code logic:

![](https://web-cdn.agora.io/docs-files/1568964082213)

### Sample code

```swift
// Configures the information of the source channel. Set channelName as the default value, meaning the current channel name. Set uid as the default value 0.
let config = AgoraChannelMediaRelayConfiguration()
// Ensure that the uid you use to generate the sourceChannelToken is set as 0.
config.sourceInfo = AgoraChannelMediaRelayInfo(token: sourceChannelToken)
  
// Configures the information of the destination channel.
let destinationInfo = AgoraChannelMediaRelayInfo(token: destinationChannelToken)
config.setDestinationInfo(destinationInfo, forChannelName: destinationChannelName)
// Starts the channel media relay.
agoraKit.startChannelMediaRelay(config)

// Stops the channel media relay.
agoraKit.stopChannelMediaRelay()
```

```swift
// Uses the channelMediaRelayStateDidChange callback to monitor the state of the channel media relay.
func rtcEngine)(_ engine: AgoraRtcEngineKit, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
  LogUtils.log(message: "channelMediaRelayStateDidChange: \(state.rawVlue) error \(error.rawValue)", level: .info)
  
  switch(state){
    case .running:
        isRelaying = true
        break
    case .failure:
        showAlert(message: "Media Relay Failed: \(error.rawValue)")
        isRelaying = false
        break
    case .idle:
        isRelaying = false
        break
    default:break
  }
}
```

<div class="alert note">After calling the <code>startChannelMediaRelay</code> method, you can call the <code>updateChannelMediaRelay</code> method to add or delete the relay channels.</div>

### API Reference

- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:)

## Considerations

- The Agora RTC SDK supports relaying media streams to a maximum of four destination channels. To add or delete a destination channel, call `updateChannelMediaRelay`.
- This feature supports integer user IDs only.




- When setting the source channel information, ensure that you set `uid` as 0, and the `uid` that you use to generate the token should also be set as 0.

- To call `startChannelMediaRelay` again after it succeeds, you must call `stopChannelMediaRelay` to quit the current relay.