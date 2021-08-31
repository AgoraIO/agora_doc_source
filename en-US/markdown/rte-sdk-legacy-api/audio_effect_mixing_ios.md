# Play audio effect or music file

In real-time audio and video sessions, playing an audio effect or adding background music adds more fun to use cases such as online gaming or karaoke. 

This page shows how to implement audio effects or play music files in your project.

## Understand the tech

Agora provides the following APIs that help you implement playing audio effects or music files:

- Audio Effect APIs: Play ambient sounds with a short duration. For example, applause, cheers, fighting sounds, and gunshots. You can play **multiple audio effect files** at the same time. 

- Audio Mixing APIs: Play a relatively long music file, such as the accompaniment and background music. You can play **only one music file** at a time.

These methods support the following functions:

| Function | Audio Effect APIs | Audio Mixing APIs |
| -- | -- | -- |
| Play and stop playing the specified audio file | <ul><li>`preloadEffect`</li><li>`unloadEffect`</li><li>`playEffect`</li><li>`stopEffect`</li><li>`stopAllEffects`</li></ul> | <ul><li>`startAudioMixing`</li><li>`stopAudioMixing`</li></ul> |
| Pause and resume playing the audio file | <ul><li>`pauseEffect`</li><li>`pauseAllEffects`</li><li>`resumeEffect`</li><li>`resumeAllEffects`</li></ul> |<ul><li>`pauseAudioMixing`</li><li>`resumeAudioMixing`</li></ul> | 
| Get and set the playback position and volume | <ul><li>`setEffectPosition`</li><li>`getEffectCurrentPosition`</li><li>`getEffectsVolume`</li><li>`setEffectsVolume`</li><li>`setVolumeOfEffect`</li></ul> | <ul><li>`getAudioMixingCurrentPosition`</li><li>`setAudioMixingPosition`</li><li>`getAudioMixingPublishVolume`</li><li>`adjustAudioMixingPublishVolume`</li><li>`getAudioMixingPlayoutVolume`</li><li>`adjustAudioMixingPlayoutVolume`</li></ul> |
| Report the playback state of the audio file | `rtcEngineDidAudioEffectFinish` | `audioMixingStateChanged` |

## Prerequsites

Before proceeding, ensure that you have the following:
- A project that has implemented the [basic real-time audio and video engagement functionalities]().
- A working knowledge of [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).


## Implement playing audio file

This section explains how to use the audio effect APIs and audio mixing APIs to implment playing audio effect and audio mixing files in your project.

### Implement playing audio effects

Call the `preloadEffect` method before joining channel to preload the audio effect file. After joining the channel, call `playEffect` to play the specified audio effect. To play multiple audio effect files at the same time, ycall `playEffect` multiple times and specify different audio effect files with the effect ID. Once the audio effect playback finishes, the SDK triggers the `rtcEngineDidAudioEffectFinish` callback. 

In your Agora project, open the file used to manage audio effect playback and add the following code.

```objective-c
// Objective-C
// Specify the audio effect ID. This is the unique identifier of the audio effect file.
int EFFECT_ID = 1;
// Specify the path of the audio effect file.
NSString *filePath = "your filepath";
// Preload an audio effect file into the memory   if you want to play the audio effect repeatedly. Do not preload an audio effect file if the file size is large.
// You can only preload local audio effect files.
[agoraKit preloadEffect: EFFECT_ID filePath: filePath];

// The number of audio effect loops. -1 means an inifinite loop.
int loopCount = -1;
// The pitch of the audio effect. 1 represents the original pitch.
double pitch = 1;
// The spatial positition of the audio effect. 0.0 represents that the audio effect plays in the front.
double pan = 1;
// The volume of the audio effect. 100 represents the original volume.
double gain = 100.0;
// Whether to publish the audio effect to remote users.
BOOL publish = true;
// Call playEffect to play the specified audio effect file.
// Call playEffect multiple times and set different audio effect IDs to play multiple audio effect files at the same time.
[agoraKit playEffect: EFFECT_ID filePath: filePath loopCount: loopCount pitch: pitch pan: pan gain: gain publish: publish];


// Pause and resume playing a specified audio file.
[agoraKit pauseEffect: EFFECT_ID];
[agoraKit resumeEffect: EFFECT_ID];

// Set the playback position of a specified local audio file.
[agoraKit setEffectPosition: EFFECT_ID pos: 500];

// Set the playback volume of all audio effect files.
[agoraKit setEffectsVolume: volume: 50.0];
// Set the playback volume of a specified audio effect file.
[agoraKit setVolumeOfEffect: EFFECT_ID volume: 50.0];

// Unload the preloaded audio effect file.
[agoraKit unloadEffect: EFFECT_ID];
// Stop playing all audio effect files.
[agoraKit stopAllEffects];

// Occurs when the audio effect playback finishes.
- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit* _Nonnull)engine soundId:(NSInterger)soundId;
}
```

```swift
// Swift
// Specify the audio effect ID. This is the unique identifier of the audio effect file.
let EFFECT_ID:Int32 = 1
// Specify the path of the audio effect file.
let filePath = "your filepath"
// Preload an audio effect file into the memory   if you want to play the audio effect repeatedly. Do not preload an audio effect file if the file size is large.
// You can only preload local audio effect files.
agoraKit.preloadEffect(EFFECT_ID, filePath: filePath)

// The number of audio effect loops. -1 means an inifinite loop.
let loopCount = 1
// The pitch of the audio effect. 1 represents the original pitch.
let pitch = 1
// The spatial positition of the audio effect. 0.0 represents that the audio effect plays in the front.
let pan = 1
// The volume of the audio effect. 100 represents the original volume.
let gain = 100.0
// Whether to publish the audio effect to remote users.
let publish = true
// Call playEffect to play the specified audio effect file.
// Call playEffect multiple times and set different audio effect IDs to play multiple audio effect files at the same time.
agoraKit.playEffect(EFFECT_ID, filePath: filePath, loopCount: Int32(loopCount), pitch: pitch, pan: pan, gain: gain, publish: publish)


// Pause and resume playing a specified audio file.
agoraKit.pauseEffect(EFFECT_ID)
agoraKit.resumeEffect(EFFECT_ID)

// Set the playback position of a specified local audio file.
agoraKit.setEffectPosition(EFFECT_ID, pos: 500)

// Set the playback volume of all audio effect files.
agoraKit.setEffectsVolume(volume: 50.0)
// Set the playback volume of a specified audio effect file.
agoraKit.setVolumeOfEffect(EFFECT_ID, volume: 50.0)

// Unload the preloaded audio effect file.
agoraKit.unloadEffect(EFFECT_ID)
// Stop playing all audio effect files.
agoraKit.stopAllEffects()

// Occurs when the audio effect playback finishes.
func rtcEngineDidAudioEffectFinish(_engine: AgoraRtcEngineKit soundId: soundId)
}
```

### Implement audio mixing

Call the `startAudioMixing` method to play a music file before or after joining a channel. After a successful method call, the SDK triggers `audioMixingStateChanged` callback when the audio mixing state changes. This callback also contains why the audio mixing state changes.

In your Agora project, open the file used to manage audio effect playback and add the following code.

```objective-c
// Objective-c
// Specify the path of the local or online music file.
NSString *filePath = @"your file path";
// Whether to only play the music file on the local client. NO represents that both the local user the remote users can hear the music file.
BOOL loopback = NO;
// Whether to replace the audio captured by the microphone with the music file. NO represents that the user can hear both the music and the audio captured by the microphone.
BOOL replace = NO;
// The number of times to loop the music file. 1 represents playing the file once.
NSInteger cycle = 1;
// Call startAudioMixing to play the audio file.
[agoraKit startAudioMixing: filePath loopback: loopback replace: replace cycle: cycle];

// Occurs when the state of the music file playback changes.
// Agora reconmmends calling other Audio Mixing APIs, for example, pauseAudioMixing or getAudioMixingDuration, after receiving the localAudioMixingStateDidChanged callback.
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine audioMixingStateChanged:(AgoraAudioMixingStateType)state reason:(AgoraAudioMixingErrorType)errorCode;

// Pause and resume playing the audio file.
[agoraKit pauseAudioMixing];
[agoraKit resumeAudioMixing];

// Get the total duration of the current music file.
[agoraKit getAudioMixingDuration];
// Set the playback position of the current music file. 500 represents that the playback starts at the 500 ms of the music file.
[agoraKit setAudioMixingPosition: pos: 500];

// Adjust the playback volume of the current music file for the remote user.
[agoraKit adjustAudioMixingPublishVolume: volume: 50];
// Adjust the playabck volume of the current music file for the local user.
[agoraKit adjustAudioMixingPlayoutVolume: volume: 50];
```

```swift
// Swift
// Specify the path of the local or online music file.
let filePath = "your file path"
// Whether to only play the music file on the local client. false represents that both the local user the remote users can hear the music file.
let loopback = false
// Whether to replace the audio captured by the microphone with the music file. false represents that the user can hear both the music and the audio captured by the microphone.
let replace = false
// The number of times to loop the music file. 1 represents playing the file once.
let cycle = 1
// Call startAudioMixing to play the audio file.
agoraKit.startAudioMixing(filePath, loopback: loopback, replace: replace, cycle: cycle)

// Occurs when the state of the music file playback changes.
// Agora reconmmends calling other Audio Mixing APIs, for example, pauseAudioMixing or getAudioMixingDuration, after receiving the localAudioMixingStateDidChanged callback.
func rtcEngine(_ engine: AgoraRtcEngineKit, audioMixingStateChanged state: AgoraAudioMixingStateType, errorCode: AgoraAudioMixingErrorType) {
}

// Pause and resume playing the audio file.
agoraKit.pauseAudioMixing()
agoraKit.resumeAudioMixing()

// Get the total duration of the current music file.
agoraKit.getAudioMixingDuration()
// Set the playback position of the current music file. 500 represents that the playback starts at the 500 ms of the music file.
agoraKit.setAudioMixingPosition(pos: 500)

// Adjust the playback volume of the current music file for the remote user.
agoraKit.adjustAudioMixingPublishVolume(volume: 50)
// Adjust the playabck volume of the current music file for the local user.
agoraKit.adjustAudioMixingPlayoutVolume(volume: 50)
```

## Reference

This section provides reference information that you need to know when playing audio effects or implementing audio mixing.

- Agora provides an open-source [AudioMixing](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/AudioMixing) sample project on Github for your reference. You can download the project to try it or view the source code.
- API Reference:
  - [playEffect]()
  - [rtcEngineDidAudioEffectFinished]()
  - [startAudioMixing]()
  - [audioMixingStateChanged]()