---
title: Play Audio Effects/Audio Mixing File
platform: Android
updatedAt: 2020-12-04 02:22:55
---
## Introduction
In a call or live interactive streaming, you may need to play custom audio or music files to all the users in the channel. For example, adding sound effects in a game, or playing background music. We provide two groups of methods for playing audio effect files and audio mixing.

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_android) or [Start Live Interactive Streaming](start_live_android) for details.

## Play audio effect files

The play audio effect methods can be used to play audio effects, such as clapping and gunshots. You can play multiple audio effects at the same time, and preload the audio effect file for efficiency.

The Agora SDK provides the `IAudioEffectManager` class to manage the audio effects, including a series of methods. The audio effect file is specified by the file path, but the `IAudioEffectManager` class uses the sound ID to identify the audio effect file. The file is usually placed in the **assets** folder. The SDK does not have any rule to define the sound ID. You need to ensure that each audio effect file has a unique sound ID. You can do that by incrementing the ID and using hashCode for the audio effect files.

### Implementation

Follow these steps to play audio effects:

1. Call the `getAudioEffectManager` method to get the `IAudioEffectManager` class.
2. Call the `preloadEffect` method to preload the audio effect files. 
3. After joining a channel, call the `playEffect` method to play the audio effects. Do not play more than three audio effects at the same time.

<div class="alert note">Call the audio effect methods in the <code>IAudioEffectManager</code> class.</div>

The following figure shows the API call sequence. After playing the audio effects, you can pause the playback, set the volume, and unload the audio effects. See the sample code for details.

![](https://web-cdn.agora.io/docs-files/1569381491660)

**Sample code**

```java
// Gets the global audio effect manager.
IAudioEffectManager manager = rtcEngine.getAudioEffectManager();
  
// Preloads the audio effect (recommended). Note the file size, and preload the file before joining the channel.
// Only mp3, aac, m4a, 3gp, and wav files are supported.
// You may need to record the correlation between the sound IDs and the file paths.
int id = 0;
manager.preloadEffect(id++, "path/to/effect1");
  
// You can preload multiple audio effects.
manager.preloadEffect(id++, "path/to/effect2");
  
// Plays an audio effect file.
manager.playEffect(
0,  // The sound ID of the audio effect file to be played.
"path/to/effect1",  // The file path of the audio effect file.
-1,   // The number of playback loops. -1 means an infinite loop.
0.0,  // Sets the spatial position of the effect. 0 means the effect shows ahead.
100,  // Sets the volume. The value ranges between 0 and 100. 100 is the original volume.
true // Sets whether to publish the audio effect.
);
  
// Pauses all audio effects.
manager.pauseAllEffects();
  
// Gets the volume of the audio effect. The value ranges between 0 to 100.
double volume = manager.getEffectsVolume();
  
// Ensures that the audio effect's volume is at least 80% of the original volume.
volume = volume < 80 ? 80 : volume;
manager.setEffectsVolume(volume);
  
// Resumes playing the audio effect.
manager.resumeAllEffects();
  
// Stops playing all audio effects.
manager.stopAllEffects();
  
// Releases the preloaded audio effect from the memory.
manager.unloadAllEffects();
```

### API reference

- [`getAudioEffectManager`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afd61b8d5e923f9e03cd419dcaf23b4af)

### Considerations

- Preloading the audio effect is not mandatory. However, we recommend preloading the audio effect to improve the efficiency or to play the audio effect multiple times. We do not recommend preloading audio effects with a large file size.
- The API methods have return values. If the method call fails, the return value is < 0.

## Audio mixing

Audio mixing is playing a local or online music file while speaking, so that other users in the channel can hear the music. The audio mixing methods can be used to play background music, for example playing music in a live broadcast. Only one music file can be played at one time. If you start playing a second music file during audio mixing, the first music file stops playing.
Agora audio mixing supports the following options:
- Mix or replace the audio: 
	- Mix the music file with the audio captured by the microphone and send it to other users 
	- Replace the audio captured by the microphone with the music file.
- Loop: Sets whether to loop the audio mixing file and the number of times to play the file.
- State change notification: Reports when the state of the audio mixing file changes, for example when the audio mixing file pauses playback or resumes playback.

### Implementation

```java
// Sets the audio mixing options.
int loopCount = -1; // Loops the audio mixing file playback infinitely. Set a positive integer for the number of times to play the file.
boolean shouldLoop = true; // Sets whether other users can hear the audio mixing. If set as true, only the local user can hear the audio mixing.
boolean replaceMic = false; // The audio captured by the microphone is not replaced by the audio mixing file.
  
// Starts audio mixing.
rtcEngine.startAudioMixing("path/to/music", shouldLoop, replaceMic, loopCount);
  
// Adjusts the volume of audio mixing. The value ranges between 0 and 100. 100 represents the orginial volume (default).
int volume = 50;
rtcEngine.adjustAudioMixingVolume(volume);
  
// Gets the duration of the current audio mixing file.
int duration = rtcEngine.getAudioMixingDuration();
// duration can be used to set the maximum length of the progress bar.
// seekBar.setMax(duration);
  
// Gets the current progress of the audio mixing playback.
int currentPosition = rtcEngine.getAudioMixingCurrentPosition();
// You can set a timer to get and display the progress regularly.
// seekBar.setProgress(currentPosition);
  
// If the user drags the progress bar, you can get the progress in the callback of seekBar and reset the current position of the audio mixing playback.
rtcEngine.setAudioMixingPosition(progress);
  
// Pauses and resumes the audio mixing playback.
rtcEngine.pauseAudioMixing();
rtcEngine.resumeAudioMixing();
  
// Stops the audio mixing playback and re-enables the microphone capturing.
rtcEngine.stopAudioMixing()；
```

We also provide an open-source demo project that implements audio mixing on [GitHub](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Android). You can try the demo and refer to the code in [`CallActivity.java`](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Android/app/src/main/java/io/agora/openvcall/ui/CallActivity.java#L510).

### API reference

- [`startAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac56ceea1a143a4898382bce10b04df09)
- [`stopAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#addb1cbc23b7f725eea6eedd18412854d)
- [`adjustAudioMixingVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a13c5737248d5a5abf6e8eb3130aba65a)
- [`pauseAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab2d4fb72ec3031f59da72b55857e0da7)
- [`resumeAudioMixing`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aedad78215c21f0a6acac7f155199f3ce)
- [`getAudioMixingDuration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8bbeb8a8b07e4e7b1a0a493f1c66998d)
- [`getAudioMixingCurrentPosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5119b0e6b356f867f7e13a6e1b2bb3e5)
- [`setAudioMixingPosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a12c3dc250c86d54552c1589dfda2e002)
- [`onAudioMixingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aee0aa9286a39654312b162750713e986)

### Considerations

- The audio mixing methods require Android 4.2+ and API v16+.
- Ensure that you call the methods when you are in the channel.
- If you call the methods on an emulator, you can only play the MP3 files in the **/sdcard/** folder for audio mixing.
- The API methods have return values. If the method call fails, the return value is < 0.