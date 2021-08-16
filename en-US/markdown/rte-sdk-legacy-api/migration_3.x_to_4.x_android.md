# Migrate from 3.x to 4.0 Preview

This migration guide helps you migration from RTC SDK 3.x to 4.0 Preview. If you are migrating from 3.x, feel free to reach us at support@agora.io.

## Benefits

- Multiple tracks.

## What has changed

This section includes detailed reference in API changes that you need to know before migrating the SDK.

### SDK behavior changes

This section includes changes on the default behavior of the SDK.

#### 1. Channel profile and client role

The Video SDK 3.x has the default channel profile of `COMMUNICATION`, and diffferent channel profiles have different client roles:

- In the `COMMUNCATION` channel profile, the default client role is `BROADCASTER`.
- In the `LIVE_BROADCASTING` channel profile, the default client role is `AUDIENCE`.

In the 4.0 Preview version, the default channel profile is `LIVE_BROADCASTING`. And client roles are not bound to the channel profile. Regardless of the channel profile, for a user to publish audio or video in the channel, you need to call `setClientRole` and set the role as `BROADCASTER`.

#### 2. Local preview

In a video call or live streaming powered by the Video SDK 3.x, when a user joins a channel, the user automaticcally sees the local preview.

With 4.0 Preview, you need to call `startPreview` before joining a channel to see the local view.

#### 3. Audio route

**3.1 How audio route changes when an external device is removed**

When an external playback device is removed, for example, by unplugging the Bluetooth headset, the audio route change in Video SDK 3.x and 4.0 Preview are different:

- In Video SDK 3.x, the audio route is as follows (in terms of priority): The external device connected next to last (if any) > ... > The external device connected first > `setEnableSpeakerphone` > `setDefaultAudioRoutetoSpeakerphone` > The default audio route.
- In Video SDK 4.0 Preview, the audio route is as follows (in terms of priority): The external device connected next to last (if any) > ... > The external device connected first > `setDefaultAudioRoutetoSpeakerphone` > The default audio route.

**3.2 How system limitations affect the audio route**

The audio route change is subject to system limitations, and such limitations have different impacts on the two SDKs:

- In Video SDK 3.x, as long as an external playback device is connected, you cannot change the audio route to the headset or loudspeaker. The audio route always go the external device.
- In 4.0 Preview, such limitations only apply to iOS when you want to change the audio route to loudspeaker by calling `setEnableSpeakerphone(true)`.

**3.3 How audio routes affect system volume and in-call volume**

To be added


### API behavior changes

This section includes changes in 4.0 Preview to the API behavior and prototype that are imcompatible with 3.x.

#### 1. Audio profile and audio scenario

#### 2. Error codes and warning codes

The 4.0 Preview SDK deletes the `onError` and `onWarning` callback that report error and warning messages during SDK runtime. The `ERROR_CODE` and `WARN_CODE` class are also deleted and the SDK uses state codes and error codes in respective callbacks to report error messages.

### Updated methods and parameters

This section lists the methods and parameters that have changed in 4.0 Preview SDK that can lead to incompatability issues in your project. 

- The 4.0 Preview SDK does not have the following methods, parameters, members, and Constants:
  - `onFirstLocalAudioFrame`, which is replaced by `onFirstLocalAudioFramePublished`.
  - `setClientRole[2/2]`, which will be added in a subsequent version.
  - `switchChannel`, because the SDK supports automatically quickly switching channels.
  - `onUserMuteAudio`, which is replaced by `onRemoteAudioStateChanged`.
  - The `info` parameter in `joinChannel[2/2]`, which was optional and rarely used in 3.x.
  - The `publishLocalAudio` and `publishLocalVideo` members in `ChannelMediaOptions` which are replaced by parameters with more specified information such as `publishAudioTrack`, `publishCustomAudioTrack`, `publishCameraTrack`, and `publishScreenTrack`.
  - The `gatewayRtt` member in `RtcStats`, which does not take effect in 3.0.
  - The `txPacketLossRate` member in `LocalAudioStats`, which will be added in the subsequent version.
  - `totalActiveTime`, `publishDuration`, `qoeQuality`, and `qualityChangedReason` in `RemoteAudioStats`, which will be added in the subsequent version.
  - `qualitAdaptIndication`, `txPacketLossRate`, `captureFrameRate`, and `captureBrightnessLevel` in `LocalVideoStats`, which will be added in the subsequent version.
  - `LOCAL_AUDIO_STREAM_ERROR_INTERRUPTED(8)`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND(8)`

- The 4.0 Preview SDK renamed the following methods or parameters:
  - The `fileSize` member in `LogConfig` is renamed to `fileSizeInKB`.
  - The `channelId` and `uid` parameters in `joinChannel[2/2]` are renamed to `channelName` and `optionalUid` respectively.
  - The `localVideoState` parameter in `onLocalVideoStateChanged` is renamed to `state`.
  - The `REMOTE_VIDEO_STATE_DECODING(2)` enumeration is renamed to `REMOTE_VIDEO_STATE_PLAYING(2)`.

- The 4.0 Preview SDK changes the path of the following files in the SDK:
  - The path to ChannelMediaOptions.java file in the SDK is changed from `/models` to the root directory.

- The 4.0 Preview SDK changes the data type in the following methods:
    - The `state` and `error` parameters in `onLocalAudioStateChanged`are enum classes in 4.0 Preview, while those in 3.x are integers.
    - The `state` and `reason` parameters in `onRemoteAudioStateChanged` are enum classes in 4.0 Preview, while those in 3.x are integers.
    - The `oldState` and `newState` parameters in `onAudioPublishStateChanged`, `onVideoPublishStateChanged`, `onAudioSubscribeStateChanged`, and `onVideoSubscribeStateChanged` are enum classes, while those in 3.0 are integers.

Note that the list is not comprehensive and you can refer to the actual header file or details. 

### Function gaps

MediaIO is not supported in 4.0 Preview.

## Migrate to 4.0 Preview

Follow the steps in this section to migrate to 4.0 Preview according to the functions you implement in your app.

### 1. Integrate the SDK

RTC SDK 4.x has not been released to package repositories. To integrate the SDK, remove references to package repositories and add the SDK libraries into your project manually. To do this:

1. Remove references to the Agora SDK by deleting the following line from the `/Gradle Scripts/build.gradle(Module: <projectname>.app)` file:
   ```
   implementation 'com.github.agorabuilder:native-full-sdk:x.y.z'
   ```
2. Download the Android SDK from http://10.80.1.174:8090/ and copy the files into your project.

   | File or folder | Path in your project |
   |---|---|
   | `/sdk/agora-rtc-sdk.jar` file | `/app/libs/` |
   | `/sdk/arm-v8a` folder | `/app/src/main/jniLibs/` |
   | `/sdk/armebi-v7a` folder | `/app/src/main/jniLibs/` |
   | `/sdk/x86` folder | `/app/src/main/jniLibs/` |
   | `/sdk/x86_64` folder | `/app/src/main/jniLibs/` |
   | `/sdk/high_level_api/include` folder | `/app/src/main/jniLibs/` |

### 2. Rename imports

To integrate the 4.0 Preview SDK functionality into your app, for each Agora import in each source file of your app, change `import io.agora.rtc` to `import io.agora.rtc2`.

### 3. Update the Agora code in your app

SDK 4.0 Preview makes changes to the API and callflow. In order to retain Agora functionality in your app, update your app to match the following code mapping.

| Function | 3.x API | 4.0 Preview API |
|---|---|---|
| Start a video call  | `create`</br>`enableVideo`</br>`CreateRendererView`</br>`setupLocalVideo`</br>`joinChannel`</br>`setupRemoteVideo`</br> | `create`</br>`setClientRole`</br>`enableVideo`</br>`setupLocalVideo`</br>`startPreview`</br>`joinChannel`</br>`setupRemoteVideo`</br> |
| Start an interactive live streaming |`create`</br>`setChannelProfile`</br>`setClientRole`</br>`enableVideo`</br>`CreateRendererView`</br>`setupLocalVideo`</br>`joinChannel`</br>`setupRemoteVideo`  | `create`</br>`setClientRole`</br>`enableVideo`</br>`setupLocalVideo`</br>`startPreview`</br>`joinChannel`</br>`setupRemoteVideo` |
| Custom audio source and renderer |`setExternalAudioSource`</br>`pushExternalAudioFrame`</br>`setExternalAudioSink`</br>`pullPlaybackAudioFrame`  |  |
| Custom video source and renderer | `setExternalVideoSource`</br>`pushVideoFrame` |  |
| Raw audio data | `registerAudioFrameObserver` |  |
| Raw video data | `registerVideoFrameObserver`  |  |
| Join multiple channels | `create`</br>`setChannelProfile`</br>`createRtcChannel`</br>`RtcChannel::setRtcChannelEventHandler`</br>`RtcChannel::setClientRole`</br>`RtcChannel::joinChannel`</br> |  |

Agora also provides the complete demo project for major functions of the new SDK on GitHub. You can download [API Examples](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/Android/APIExample) to try the demo and check the source code. If you want to see the logic change compared to 3.x SDK, switch to the `master` branch to view the source code.




