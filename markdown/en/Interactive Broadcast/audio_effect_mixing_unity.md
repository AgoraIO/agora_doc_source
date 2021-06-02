---
title: Play Audio Effects/Audio Mixing File
platform: Unity
updatedAt: 2020-12-03 12:01:47
---
## Introduction

In a call or live broadcast, you may need to play custom audio or music files to all the users in the channel. For example, adding sound effects in a game, or playing background music. We provide two groups of methods for playing audio effect files and audio mixing.

Before proceeding, ensure that you implement a basic call or live broadcast in your project. See [Start a Voice Call](start_call_audio_unity) and [Start a Voice Broadcast](start_live_audio_unity) for details.

## Play audio effect files

The play audio effect methods can be used to play audio effects, such as clapping and gunshots. You can play multiple audio effects at the same time, and preload audio effect files for efficiency.

The Agora Unity SDK provides the `AudioEffectManagerImpl` class to manage audio effects, including a series of methods. The audio effect file is specified by the file path, but the `AudioEffectManagerImpl` class uses the sound ID to identify the audio effect file. The SDK does not follow any rule to define the sound ID. Each audio effect file must have a unique sound ID, and you can do that by incrementing the ID and using hashCode for the audio effect files.

### Implementation

Follow these steps to play audio effects:

1. Call the `GetAudioEffectManager` method to get the `AudioEffectManagerImpl` class.
2. Call the `PreloadEffect` method to preload the audio effect files.
3. After joining a channel, call the `PlayEffect` method to play the audio effects. We do not recommend playing more than three audio effects at the same time.

<div class="alert note">Call the audio effect methods in the AudioEffectManagerImpl class.</div>

The following figure shows the API call sequence. After playing the audio effects, you can pause the playback, set the volume, and remove the audio effects. See the sample code for details.

![](https://web-cdn.agora.io/docs-files/1582637580935)

**Sample code**

```C#
// Initializes the AudioEffectManagerImpl class.
AudioEffectManagerImpl audioEffectManager = (AudioEffectManagerImpl)mRtcEngine.GetAudioEffectManager();
// Preloads audio effects, you can call this method multiple times to preload multiple audio effects.
int ret = audioEffectManager.PreloadEffect(nSoundID, filePath);
// Plays a specified audio effect.
int ret = audioEffectManager.PlayEffect(nSoundID, filePath, nLoopCount, dPitch, dPan, nGain, true);
// Pauses a specified audio effect.
int ret = audioEffectManager.PauseEffect(nSoundID);
// Pauses all audio effects.
int ret = audioEffectManager.PauseAllEffects();
// Resumes playing a specified audio effect.
int ret = audioEffectManager.ResumeEffect(nSoundID);
// Resumes playing all audio effects.
int ret = audioEffectManager.ResumeAllEffects();
// Stops playing a specified audio effect.
int ret = audioEffectManager.StopEffect(nSoundID);
// Stops playing all audio effects.
int ret = audioEffectManager.StopAllEffects();
// Releases a specified audio effect from the memory.
int ret = audioEffectManager.UnloadEffect(nSoundID);
```

### API reference

- [GetAudioEffectManager](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6f928012c4340b00e12aaa0454fb50f6)
- [PreloadEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aab6c3c7609de0fd828f5ee9aa59ffb0b)
- [PlayEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a7a207e0a7571300b41dda0d090a6ab02)
- [PauseEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#ab978acce35871df40154119a18595545)
- [PauseAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aa01bdc22a8a367a4170012ad9b5a5310)
- [ResumeEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a85bec95b2d382fdfaebbcbf3f5a0f10f)
- [ResumeAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a1b7b23d134808c68457f589776731e2f)
- [StopEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aedeb24d257c949d0f85123f4c6032dab)
- [StopAllEffects](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#aef6fbcc325665a99f681fbe5a19c3aa5)
- [UnloadEffect](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#af7956fe2ea320af080f6970ac446496e)

### Considerations

Preloading audio effects is not mandatory. However, we recommend preloading audio effects to improve efficiency or to play an audio effect multiple times. We do not recommend preloading audio effects with large file sizes.

## Audio mixing

Audio mixing is playing a local or online music file while speaking, so that other users in the channel can hear the music. The audio mixing methods can be used to play background music, for example playing music in a live broadcast. Only one music file can be played at one time. If you start playing a second music file during audio mixing, the first music file stops playing.
Agora audio mixing supports the following options:

- Mix or replace the audio:
  - Mix the music file with the audio captured by the microphone and send it to other users
  - Replace the audio captured by the microphone with the music file.
- Loop: Sets whether to loop the audio mixing file and the number of times to play the file.
- State change notification: Reports when the state of the audio mixing file changes, for example when the audio mixing file pauses playback or resumes playback.

### Implementation

```C#
string filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
// Starts playing and mixing the music file.
int ret = mRtcEngine.StartAudioMixing(filePath, false, true, 1);
// Adjusts the volume of the music file as 50% of the original volume.
int ret = mRtcEngine.AdjustAudioMixingVolume(50);
// Gets the audio mixing volume for local playback.
int ret = mRtcEngine.GetAudioMixingPlayoutVolume();
// Gets the audio mixing volume for publishing.
int ret = mRtcEngine.GetAudioMixingPublishVolume();
// Gets the duration (ms) of the music file.
int ret = mRtcEngine.GetAudioMixingDuration();
// Gets the playback position (ms) of the music file.
int ret = mRtcEngine.GetAudioMixingCurrentPosition();
// Sets the playback position of the music file at 3000 ms.
int ret = mRtcEngine.SetAudioMixingPosition(3000);
// Stops playing and mixing the music file.
int ret = mRtcEngine.StopAudioMixing();
```

### API reference

- [StartAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6e819ce8d80033f797fd3044ec7dde86)
- [StopAudioMixng](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2781e98a720d801d1adffbb02b450929)
- [PauseAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a5150ffea0000bd7c39531192d836f307)
- [ResumeAudioMixing](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#af4bfe442eb4ab52d197a321387f73824)
- [AdjustAudioMixingVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae6a3b1041004fdd5a031975a2f9cdb7e)
- [AdjustAudioMixingPlayoutVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac7d6df07616489729d521ce47934bb299)
- [AdjustAudioMixingPublishVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0900c11feef9cbee498f17f95cd0aed2)
- [GetAudioMixingPlayoutVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0688ea2a1e059c437146653d72d70ac1)
- [GetAudioMixingPublishVolume](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aba5f24855b141e491b9af60837304625)
- [GetAudioMixingDuration](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9ea29289b75f1fb4623785854fb147eb)
- [GetAudioMixingCurrentPosition](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9dce60db3e49f48291a91e199d8c2065)
- [SetAudioMixingPosition](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac332a0186694b1a367996fa41d23b88d)
- [OnAudioMixingStateChangedHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ab061cd429286b98043db14f106029829)
- [OnRemoteAudioMixingBeginHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a09318aee595f81b430aba31a5f6ee7b3)
- [OnRemoteAudioMixingEndHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a72da329b0efbde86c91bb513dfaa43e3)

### Considerations

Ensure that you call the methods when you are in the channel.