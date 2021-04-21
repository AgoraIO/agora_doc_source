---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## Introduction

During real-time audio and video interaction, for better atmosphere or entertainment, users often need to play audio effects or background music and make all users in the channel hear. For example, users might add fighting sounds when playing an action game or include an accompaniment when singing. Agora provides two independent groups of methods so that you can play audio effect files and a music file separately.

## Sample project

Agora provides an open-source demo project on GitHub that implements [audio effect](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioEffect) files and a [music file](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioMixing). You can view the source code on Github or download the project to try it out.

## Audio effect files

In this context, the audio effects refer to the ambient sounds with a short duration, such as applause, cheers, fighting sounds, and gunshots. Usually, you can play multiple audio effects at the same time.

Agora provides a group of methods to play and manage audio effect files that enable you to perform the following functions: 

- Play local or online audio effect files.
- Set the spatial position, number of loops, playback position, volume, and other playback options of an audio effect.
- Flexibly control the playing, pausing, resumption, and stopping of audio effect files, individually or globally.

<div class="alert note">Supported audio effect file formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a >.</div>

To play audio effect files, see the following steps:

1. Before joining a channel, call the `preloadEffect` method to preload the local audio effect file.
2. After joining a channel, call the `playEffect` method to play the audio effect file. After completing playing an audio effect file, the SDK triggers the `onAudioEffectFinished` callback.

### Specify an audio effect file

Before playing an audio effect file, you need to set `filePath` and `soundId` to specify the audio effect file. The representing of two parameters is as follows:

- `filePath`: The audio effect file path, including the local and online file path. The SDK searches for audio effect files in this path.
- `soundId`: The audio effect ID, which you define. This ID must be unique. The SDK identifies an audio effect file based on its audio effect ID. Common solutions for defining audio effect IDs include incrementing the ID and using hashCode for the audio effect file name.

```c++
// Automatically allocates soundId according to the specified path of the audio effect file, and associate the audio effect file path with soundId. 
m_mapEffect.insert(std::make_pair(strPath, m_soundId++));
```

### Preloading

The SDK supports preloading audio effect files. To improve performance, you can add the audio effect files into the memory in advance. Preloading is not required;, Agora recommends that you choose whether to preload audio effect files according to your needs.

- If you need to play a specified audio effect repeatedly, Agora recommends preloading the audio effect file.
- If an audio effect file size is large, Agora recommends not preloading the audio effect file.

To preload multiple audio effect files, you need to call `preloadEffect` multiple times.

<div class="alert note"><li>The SDK only supports preloading local audio effect files.</li><li>Call <code>preloadEffect</code> before joining a channel.</li><li>After calling <code>preloadEffect</code>, the audio effect file occupies memory until you call <code>unloadEffect</code> or the user leaves the channel.</li></div>

```c++
// Preloads the specified local audio effect file into the memory.  
m_rtcEngine->preloadEffect(m_mapEffect[strEffect], strPath.c_str()); 
// Unloads the preloaded audio effect file.  
m_rtcEngine->unloadEffect(m_mapEffect[strEffect]);
```

### Play and stop

Call `playEffect` to play the audio effect file. You can call `playEffect` multiple times to play multiple audio effect files at the same time according to your requirements. When playing an audio effect file, you can set the playback options, such as number of loops, pitch, volume, and playback position.

<div class="alert note">Call <code>playEffect</code> after joining a channel.</div>

```c++
// Sets the number of times the audio effect loops. -1 represents an infinite loop.  
int loops = -1; 
 // Sets the pitch of the audio effect. The value range is 0.5 to 2.0.  
double pitch = 1.5; 
 // Sets the volume of the audio effect. The value range is 0 to 100. 100 represents the original volume.  
int gain = 100; 
 // Sets the spatial position of the audio effect. The value range is -1.0 to 1.0. -1.0 represents the audio effect occurs on the left; 0 represents the audio effect occurs in the front; 1.0 represents the audio effect occurs on the right.  
double pan = 1.0; 
 // Sets whether to publish the audio effect to the remote users. true represents that both the local user and remote users can hear the audio effect; false represents that only the local user can hear the audio effect.  
BOOL publish = true; 
 // Sets the playback position (ms) of the audio effect file. 500 represents that the playback starts at the 500 ms mark of the audio effect file.  
int startPos = 500; 
 
// Plays the specified audio effect file. 
m_rtcEngine->playEffect(m_mapEffect[strEffect], strFile.c_str(), loops, pitch, pan, gain, publish, startPos); 
 
// Occurs when the local audio effect playback finishes.  
void onAudioEffectFinished(m_mapEffect[strEffect]);
```

After successfully playing audio effect files, you can stop playing either a specified file or all audio effect files.

```c++
// Stops playing a specified audio effect file. 
m_rtcEngine->stopEffect(m_mapEffect[strEffect]);
 
// Stops playing all audio effect files. 
m_rtcEngine->stopAllEffects();
```

### Pause and resumption

When you play audio effect files, you can pause or resume playing either a specified file or all audio effect files.

<div class="alert note">Call this group of methods after <code>playEffect</code>.</div>

```c++
// Pauses playing a specified audio effect file.  
m_rtcEngine->pauseEffect(m_mapEffect[strEffect]); 
 
// Resumes playing a specified audio effect.  
m_rtcEngine->resumeEffect(m_mapEffect[strEffect]); 
 
// Pauses playing all audio effect files. 
m_rtcEngine->pauseAllEffects(); 
 
// Resumes playing all audio effect files. 
m_rtcEngine->resumeAllEffects();
```

### Playback position

If you need to adjust the playback position after playing the audio effect file, you can call this group of methods. For example, you can call this group of methods to adjust the playback position during looped playback of the audio effect file without stopping the playback.

- Call this group of methods after `playEffect`.
- This group of methods only applies to the local audio effect file.

```c++
// Gets the total duration of a specified local audio effect file.  
m_rtcEngine->getEffectDuration(m_mapEffect[strEffect]); 
 
// Sets the playback position (ms) of a specified local audio effect file. 500 represents that the playback starts at the 500 ms mark of the music file.  
m_rtcEngine->setEffectPosition(m_mapEffect[strEffect], pos); 
 
// Gets the playback position of a specified local audio effect file.  
m_rtcEngine->getEffectCurrentPosition(m_mapEffect[strEffect]);
```

### Volume

After the audio effect file starts to play, you can call this group of methods to adjust the playback volume. For example, you can call this group of methods to adjust the playback volume during looped playback of the audio effect file without stopping the playback.

<div class="alert note">Call this group of methods after <code>playEffect</code>.</div>

```c++
 // Sets the playback volume of all audio effect files. The value range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->setEffectsVolume(50); 

// Sets the playback volume of a specified audio effect file. The value range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->setVolumeOfEffect(m_mapEffect[strEffect], 50); 
 
// Gets the playback volume of all audio effect files. The volume range is 0 to 100.  100 represents the original volume.  
m_rtcEngine->getEffectsVolume();
```

### API reference

- `preloadEffect`
- `unloadEffect`
- `playEffect`
- `stopEffect`
- `stopAllEffects`
- `pauseEffect`
- `pauseAllEffects`
- `resumeEffect`
- `resumeAllEffects`
- `getEffectDuration`
- `setEffectPosition`
- `getEffectCurrentPosition`
- `setEffectsVolume`
- `setVolumeOfEffect`
- `getEffectsVolume`
- `onAudioEffectFinished`

## Audio mixing

Audio mixing refers to mixing a music file with the audio captured by a microphone. Users who use the audio mixing function often play a relatively long music file and only play one music file at a time. For example, users can play accompaniment when singing or play background music when chatting.

Agora provides a group of methods to play and manage music files that enable you to perform the following functions:

- Play local or online music files.
- Set the number of playbacks , playback position, volume, pitch, and other playback options of a music file.
- Flexibly control the playing, pausing, resumption, and stopping of the music file.
- Report the current playback state of the music file and the reason for the change.

<div class="alert note">Supported music file formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a >.</div>

After successfully calling `startAudioMixing`, the SDK triggers the `onAudioMixingStateChanged` callback when the playback state of the music file changes.

### Play and stop

Call `startAudioMixing` to play a music file. When playing a music file, you can set the playback options, such as number of loops and playback position.

<div class="alert note">If you call <code>startAudioMixing</code> again when the SDK is playing a music file, the SDK automatically stops playing the previous music file and starts playing the next music file.</div>

```c++
// Specifies the absolute path of the local or online music file that you want to play.  
std::string filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3"; 
// Sets whether to only play a music file on the local client. true represents that only the local user can hear the music; false represents that both the local user and remote users can hear the music.  
BOOL loopback = false; 
// Sets whether to replace the audio captured by the microphone with a music file. true represents that the user can only hear music; false represents that the user can hear both the music and the audio captured by the microphone.  
BOOL replace = true; 
// Sets the number of times to play the music file. 1 represents play the file once.  
int cycle = 1; 
 // Sets the playback position (ms) of the music file. 500 represents that the playback starts at the 500 ms mark of the music file.  
int startPos = 500; 

// Starts to play the music file.
m_rtcEngine->startAudioMixing(filePath, loopback, replace, cycle, startPos); 
 
// Occurs when the state of the local user's music file changes.  
void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason)
```

After successfully playing the music file, you can call `stopAudioMixing` to stop the playback.

```c++
// Stops playing the music file. 
m_rtcEngine->stopAudioMixing();
```

### Pause and resumption

When you play the music file, you can pause or resume playing the music file.

<div class="alert note">Call this group of methods after calling <code>startAudioMixing</code>.</div>

```c++
// Pauses playing the music file.  
m_rtcEngine->pauseAudioMixing(); 
 
// Resumes playing the music file.  
m_rtcEngine->resumeAudioMixing();
```

### Playback position

When the music file is playing, you can call this group of methods to adjust the playback position of the music file without stopping the playback.

<div class="alert note">Call this group of methods after calling <code>startAudioMixing</code> and receiving the <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> callback.</div>

```c++
// Gets the total duration of a specified music file.  
m_rtcEngine->getAudioMixingDuration(filePath); 
 
// Sets the playback position (ms) of the current music file. 500 represents that the playback starts at the 500 ms mark of the music file.  
m_rtcEngine->setAudioMixingPosition(500); 
 
// Gets the playback position of the current music file.  
m_rtcEngine->getAudioMixingCurrentPosition();
```

### Volume and pitch

After successfully playing the music file, you can call this group of methods to adjust the playback volume and pitch of the music file without stopping the playback.

<div class="alert note">Call this group of methods after calling <code>startAudioMixing</code> and receiving the <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> callback.</div>

```c++
// Adjusts the playback volume of the current music file for both local and remote playback. The value range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->adjustAudioMixingVolume(50); 
 
// Adjusts the playback volume of the current music file for the remote playback. The value range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->adjustAudioMixingPublishVolume(50); 
 
// Adjusts the playback volume of the current music file for the local playback. The value range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->adjustAudioMixingPlayoutVolume(50); 
 
// Gets the playback volume of the current music file for the local playback. The volume range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->getAudioMixingPlayoutVolume(); 
 
// Gets the playback volume of the current music file for the remote playback. The volume range is 0 to 100. 100 represents the original volume.  
m_rtcEngine->getAudioMixingPublishVolume(); 
 
// Sets the pitch of the current music file. The value range is -12 to 12. 0 represents the original pitch; 1 represents raising the original pitch by a semitone. 
m_rtcEngine->setAudioMixingPitch(5);
```

### API reference

- `startAudioMixing`
- `stopAudioMixng`
- `pauseAudioMixing`
- `resumeAudioMixing`
- `getAudioMixingDuration`
- `setAudioMixingPosition`
- `getAudioMixingCurrentPosition`
- `adjustAudioMixingVolume`
- `adjustAudioMixingPublishVolume`
- `adjustAudioMixingPlayoutVolume`
- `getAudioMixingPlayoutVolume`
- `getAudioMixingPublishVolume`
- `setAudioMixingPitch`
- `onAudioMixingStateChanged`