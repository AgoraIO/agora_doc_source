---
title: Play Audio Effects/Audio Mixing File
platform: iOS
updatedAt: 2020-12-04 02:05:05
---
## Introduction
In a call or live interactive streaming, you may need to play custom audio or music files to all the users in the channel. For example, adding sound effects in a game, or playing background music. We provide two groups of methods for playing audio effect files and audio mixing.

Before proceeding, ensure that you implement a basic call or live broadcast in your project. See the Quickstart Guides for details:

- iOS: [Start a Call](start_call_ios)/[Start a Live Broadcast](start_live_ios)
- macOS: [Start a call](start_call_mac)/[Start a Live Broadcast](start_live_mac)

## Play audio effect files

The play audio effect methods can be used to play audio effects, such as clapping and gunshots. You can play multiple audio effects at the same time, and preload the audio effect file for efficiency.

The audio effect file is specified by the file path, but the SDK uses the sound ID to identify the audio effect file. The SDK does not have any rule to define the sound ID. You need to ensure that each audio effect file has a unique sound ID. You may increment the ID and use the hashCode of the audio effect file.

### Implementation

```swift
// swift
// Preloads the audio effect (recommended). Note the file size and preload the file before joining the channel.
// Only mp3, aac, m4a, 3gp, and wav files are supported.
// You may need to record the correlation between the sound IDs and the file paths.
let soundId = 1
let filePath = "your filepath"

// You can preload multiple audio effects.
agoraKit.preloadEffect(soundId, filePath: filePath)

// Plays an audio effect file.
let soundId = 1 // The sound ID of the audio effect file to be played.
let filePath = "your filepath" // The file path of the audio effect file.
let loopCount = 1 // The number of playback loops. -1 means an infinite loop.
let pitch = 1 // Sets the pitch of the audio effect.
let pan = 1 // Sets the spatial position of the audio effect. 0 means the effect shows ahead.
let gain = 0 // Sets the volume. The value ranges between 0 and 100. 100 is the original volume.
let publish = true // Sets whether to publish the audio effect.
agoraKit.playEffect(Int32(soundId), filePath: filePath, loopCount: Int32(loopCount), pitch: pitch, pan: pan, gain: gain, publish: publish)

// Pauses all audio effects.
agoraKit.pauseAllEffects()

// Gets the volume of the audio effect. The value ranges between 0 and 100.
let volume = agoraKit.getEffectsVolume()

// Ensures that the audio effect's volume is at least 80% of the original volume.
volume = volume < 80 ? 80 : volume
agoraKit.setEffectsVolume(volume)

// Resumes playing the audio effect.
agoraKit.resumeAllEffects()

// Stops playing all audio effects.
agoraKit.stopAllEffects()
```

```objective-c
// objective-c
// Preloads the audio effect (recommended). Note the file size and preload the file before joining the channel.
// Only mp3, aac, m4a, 3gp, and wav files are supported.
// You may need to record the correlation between the sound IDs and the file paths.
int soundId = 1;
NSString *filePath = "your filepath";

// You can preload multiple audio effects.
[agoraKit preloadEffect: soundId filePath: filePath];

// Plays an audio effect file.
int soundId = 1; // The sound ID of the audio effect file to be played.
NSString *filePath = "your filepath"; // The file path of the audio effect file.
int loopCount = 1; // The number of playback loops. -1 means an infinite loop.
double pitch = 1; // Sets the pitch of the audio effect.
double pan = 1; // Sets the spatial position of the audio effect. 0 means the effect shows ahead.
double gain = 0; // Sets the volume. The value ranges between 0 and 100. 100 is the original volume.
BOOL publish = true; // Sets whether to publish the audio effect.
[agoraKit playEffect: soundId filePath: filePath loopCount: loopCount pitch: pitch pan: pan gain: gain publish: publish];

// Pauses all audio effects.
[agoraKit pauseAllEffects];

// Gets the volume of the audio effect. The value ranges between 0 and 100.
int volume = [agoraKit getEffectsVolume];

// Ensures that the audio effect's volume is at least 80% of the original volume.
volume = volume < 80 ? 80 : volume;
[agoraKit setEffectsVolume: volume];

// Resumes playing the audio effect.
[agoraKit resumeAllEffects];

// Stops playing all audio effects.
[agoraKit stopAllEffects];
```

### API reference

- [playEffect](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/playEffect:filePath:loopCount:pitch:pan:gain:)
- [preloadEffect](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/preloadEffect:filePath:)
- [pauseAllEffects](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pauseAllEffects)
- [getEffectsVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getEffectsVolume)
- [setEffectsVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setEffectsVolume:)
- [resumeAllEffects](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/resumeAllEffects)
- [stopAllEffects](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAllEffects)

### Considerations

- Preloading the audio effect is not mandatory. Agora recommends you preload the audio effect to improve the efficiency or to play the audio effect multiple times.
- The API methods have return values. If the method call fails, the return value is < 0.

## Audio mixing

Audio mixing is playing a local or online music file while speaking, so that other users in the channel can hear the music. The audio mixing methods can be used to play background music. For example, playing music in a live broadcast. Only one music file can be played at one time. If you start playing a second music file during audio mixing, the first music file stops playing.
Agora audio mixing supports the following options:

- Mix or replace the audio: 
	- Mix the music file with the audio captured by the microphone and send it to other users.
	- Replace the audio captured by the microphone with the music file.
- Loop: Sets whether to loop the audio mixing file and the number of times to play the file.
- State change notification: reports when the state of the audio mixing file changes, for example when the audio mixing file pauses playing or resumes playing.


### Implementation

```swift
// swift
// loopback sets whether other users can hear the audio mixing. If loopback is set as true, only the local user can hear the audio mixing.
// replace sets whether the audio captured by the microphone is replaced by the audio mixing file. 
// Setting cycle as -1 means looping the audio mixing file infinitely. Setting cycle as a positive integer means the number of times to play the file.
let filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3"
let loopback = false
let replace = false 
let cycle = 1 
  
// Starts audio mixing.
agoraKit.startAudioMixing(filePath, loopback: loopback, replace: replace, cycle: cycle)
```

```objective-c
// objective-c
// loopback sets whether other users can hear the audio mixing. If loopback is set as YES, only the local user can hear the audio mixing.
// replace sets whether the audio captured by the microphone is replaced by the audio mixing file. 
// Setting cycle as -1 means looping the audio mixing file infinitely. Setting cycle as a positive integer means the number of times to play the file.
NSString *filePath = @"http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
BOOL loopback = NO;
BOOL replace = NO;
NSInteger cycle = 1;

// Starts audio mixing.
[agoraKit startAudioMixing: filePath loopback: loopback replace: replace cycle: cycle];
```

We also provide open-source demo projects that implement audio mixing on GitHub. You can try the demo and refer to the source code.

**iOS**

- [OpenVideoCall-iOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS) for Swift. Refer to the code in [`RoomViewController.swift`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-iOS/OpenVideoCall/RoomViewController.swift#L45) .
- [OpenVideoCall-iOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS-Objective-C) for Objective-C. Refer to the code in [`RoomViewController.m`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-iOS-Objective-C/OpenVideoCall/RoomViewController.m#L60).

**macOS**

- [OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-macOS) for Swift. Refer to the code in [`RoomViewController.swift`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-macOS/OpenVideoCall/RoomViewController.swift#L232).

### API reference

- [`startAudioMixing`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioMixing:loopback:replace:cycle:)
- [`localAudioMixingStateDidChanged`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)

### Considerations

The API methods have return values. If the method call fails, the return value is < 0.