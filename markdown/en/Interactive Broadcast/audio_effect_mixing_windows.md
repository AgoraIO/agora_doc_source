---
title: Play Audio Effects/Audio Mixing File
platform: Windows
updatedAt: 2020-12-04 02:05:06
---
## Introduction
In a call or live interactive streaming, you may need to play custom audio or music files to all the users in the channel. For example, adding sound effects in a game, or playing background music. We provide two groups of methods for playing audio effect files and audio mixing.

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_windows) or [Start Live Interactive Streaming](start_live_windows) for details.
## Play audio effect files

The play audio effect methods can be used to play ambient sound, such as clapping and gunshots. You can play multiple audio effects at the same time, and preload the audio effect file for efficiency.

The audio effect file is specified by the file path, but the SDK uses the sound ID to identify the audio effect file. The SDK does not have the rule to define the sound ID. You need to ensure that each audio effect file has a unique sound ID. Common practices include automatically incrementing the ID, and using the hashCode of the audio effect file.

### Implementation

```c++
// Preloads the audio effect (recommended). Note the file size and preload the file before joining the channel.
#ifdef UNICODE
  CHAR wdFilePath[MAX_PATH];
  ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
  int nRet = rtcEngine.preloadEffect(nSoundID, wdFilePath);
#else
  int nRet = rtcEngine.preloadEffect(nSoundID, filePath);
#endif

// Plays the audio effect file. If you preload the audio effect, you need to specify nSoundID.
#ifdef UNICODE
  CHAR wdFilePath[MAX_PATH];
  ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
  int nRet = rtcEngine.playEffect(nSoundID, // The unique sound ID of the audio effect.
  wdFilePath, // File path of the audio effect file.
  nLoopCount, // The number of playback loops. -1 means an infinite loop.
  dPitch, // Sets the pitch of the audio effect.
  dPan, // Sets the spatial position of the audio effect. 0 means the effect shows ahead.
  nGain, // Sets the volume. The value ranges between 0 and 100. 100 is the original volume.
  TRUE // Sets whether to publish the audio effect.
#else
  int nRet = rtcEngine.playEffect(nSoundID, filePath, nLoopCount, dPitch, dPan, nGain, TRUE);
#endif

// Pauses a specified audio effect.
int nRet = rtcEngine.pauseEffect(nSoundID);

// Pause all audio effects.
int nRet = rtcEngine.pauseAllEffects();

// Resumes playing the paused audio effect.
int nRet = rtcEngine.resumeEffect(nSoundID);

// Resumes playing all audio effects.
int nRet = rtcEngine.resumeAllEffects();

// Stops playing a specified audio effect.
int nRet = rtcEngine.stopEffect(nSoundID);

// Stops playing all audio effects.
int nRet = rtcEngine.stopAllEffects();

// Releases the preloaded audio effect from the memory.
int nRet = rtcEngine.unloadEffect(nSoundID);
```

### API reference

- [`preloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a02d0b23b0b66e8fb0e898eb2811a8e74)
- [`playEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a7f4ddb5170b19a471d8c3c721fa19c8d)
- [`pauseEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3c820db172c7fb43da58d81b7916d174)
- [`pauseAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad731a94d9db9e2c3390e1443b379095f)
- [`resumeEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6489955af474172afe4f4b44e4edb38a)
- [`resumeAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2fc1b5996df964f8e12ce579e0eb5f98)
- [`stopEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ad74eb7c7799b8762bff2b1e7e7bba8b9)
- [`stopAllEffects`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a888ecfec4fda81831988898420d60e49)
- [`unloadEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa560240d5994be0c1a7853e96077e5f9)

### Considerations

-  Preloading the audio effect is not mandatory. Agora recommends you preload the audio effect to improve the efficiency or to play the audio effect multiple times.
- The API methods have return values. If the method call fails, the return value is < 0.

## Audio mixing

Audio mixing is playing a local or online music file while speaking, so that other users in the channel can hear the music. The audio mixing methods can be used to play background music. For example, playing music in a live broadcast. Only one music file can be played at one time. If you start playing a second music file during audio mixing, the first music file stops playing.
Agora audio mixing supports the following options:

- Mix or replace the audio: 
	- Mix the music file with the audio captured by the microphone and send it to other users.
	- Replace the audio captured by the microphone with the music file.
- Loop: Sets whether to loop the audio mixing file and the number of times to play the file.
- Adjust the audio volume: Adjust the playback volume of local and/or remote music files at the same time or separately.
- Adjust the audio pitch: Adjust the pitch of the local music file or the pitch of the local voice separately.

### Implementation

```c++
LPCTSTR filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
// Starts audio mixing.
#ifdef UNICODE
 CHAR wdFilePath[MAX_PATH];
 ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
int nRet = rtcEngine.startAudioMixing(wdFilePath, // Path to the audio mixing file.
 FALSE, // All users can hear the audio mixing.
  TRUE, // The audio captured by the microphone is replaced by the audio mixing file.
  1 // The number of playback loops of the file. If set to -1, the file loops infinitely.
  );
#else
int nRet = rtcEngine.startAudioMixing(filePath, FALSE, TRUE, 1);
#endif

// Stops audio mixing.
int nRet = rtcEngine.stopAudioMixing();
```

### API reference

- [`startAudioMixing`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a6f573cd61d53147ed6a2b7f033091d86)
- [`stopAudioMixng`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2b90cbf4142c913b3efa795482713b08)
- [`adjustAudioMixingVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a544aee96b789ac5a57d26b61b7e1a5fa)
- [`setLocalVoicePitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a43616f919e0906279dff5648830ce31a)
- [`setAudioMixingPitch`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a26b117f7e097801b03522f7da9257425)
- [`pauseAudioMixing`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#ab86885c38e7ee7a4b37d5bbacafcaa24)
- [`resumeAudioMixing`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a5a9606ad7ca4995e0d37fcf1642fe401)
- [`getAudioMixingDuration`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a6a87b6b9135a6f45095dcf6aa62295cb)
- [`getAudioMixingCurrentPosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#aae54b86e9e6a7c0ed955b96f011855cb)
- [`setAudioMixingPosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1rtc_1_1_i_rtc_engine.html#a6c69e2229c438fd587b8f81df34214ad)
- [`onAudioMixingStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a298389513bfaa50af4277fc3296e3f22)

### Considerations

- Ensure that you call the methods when you are in the channel.
- The API methods have return values. If the method call fails, the return value is < 0.