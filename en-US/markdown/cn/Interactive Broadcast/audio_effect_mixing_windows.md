---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## Introduction

In real-time audio and video interaction, to foil the atmosphere and add fun, users often need to play audio effects or a music file and all users in the channel can hear. For example, users can add fighting sounds when playing the game or add an accompaniment when singing. Agora provides two independent groups of methods, you can play audio effect files and a music file separately.

## Sample project

Agora provides an open-source demo project on GitHub that implements [audio effect](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioEffect) files and a [music file](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioMixing). You can view the source code on Github or download the project to try it out.

## Audio effect files

The audio effect mentioned in this article refers to the ambient sound with a short duration, such as applause, cheers, fighting sounds, and gunshots. Usually, you can play multiple audio effects at the same time.

Agora provides a group of methods to play and manage audio effect files, mainly including the following functions:

- Play local or online audio effect files.
- Set the spatial position, number of loops, playback position, volume, and other playback options of an audio effect.
- Flexibly control the play, pause, resumption, and stop of specified or all audio effect files.

<div class="alert note">Supported audio effect file formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a >.</div>

To play audio effect files, see the following steps:

1. Before joining a channel, call the `preloadEffect` method to preload the local audio effect file.
2. After joining a channel, call the `playEffect` method to play the audio effect file. After completing playing an audio effect file, the SDK triggers the `onAudioEffectFinished` callback.

### Specify an audio effect file

Before playing an audio effect file, you need to set `filePath` and `soundId` to specify an audio effect file. The meaning of two parameters is as follows:

- ` filePath`: The audio effect file path, including the local and online file path. The SDK searches for audio effect files in this path.
- ` soundId`: The audio effect ID, which is defined by yourself and must be unique. The SDK identifies the audio effect file based on the audio effect ID. Common solutions for defining audio effect IDs include incrementing the ID and using hashCode for the audio effect file name.

```c++
// Sets to automatically allocate soundId according to the specified path of the audio effect file, and associate the audio effect file path with soundId. 
m_mapEffect.insert(std::make_pair(strPath, m_soundId++));
```

### Preloading

The SDK supports preloading audio effect files. To improve performance, you can load the audio effect files into the memory in advance. Preloading is not a necessary step, Agora recommends that you choose whether to preload audio effect files according to your needs.

- If you need to play a specified audio effect repeatedly, Agora recommends preloading the audio effect file.
- If the audio effect file size is large, Agora recommends not preloading the audio effect file.

To preload multiple audio effect files, you need to call `preloadEffect` multiple times.

<div class="alert note"><li>The SDK only supports preloading local audio effect files.</li><li>Call <code>preloadEffect</code> before joining a channel.</li><li>After calling <code>preloadEffect</code>, the audio effect file occupies the memory until you call <code>unloadEffect</code> or the user leaves the channel.</li></div>

```c++
// Preloads the specified local audio effect file into the memory.  
m_rtcEngine->preloadEffect(m_mapEffect[strEffect], strPath.c_str()); 
// Unloads the preloaded audio effect file.  
m_rtcEngine->unloadEffect(m_mapEffect[strEffect]);
```

### Play and stop

Call `playEffect` to play the audio effect file. According to your needs, you can call `playEffect` multiple times to play multiple audio effect files at the same time. When playing an audio effect file, you can set the number of loops, pitch, volume, and playback position.

<div class="alert note">Call <code>playEffect</code> after joining a channel.</div>

```c++
// Sets the number of times the audio effect loops. -1 represents infinite loop.  
int loops = -1; 
 // Sets the pitch of the audio effect. The value range is 0.5 to 2.0.  
double pitch = 1.5; 
 // Sets the volume of the audio effect. The value range is 0 to 100. 100 represents the original volume.  
int gain = 100; 
 // Sets the spatial position of the audio effect. 1.0 represents the audio effect occurs on the right.  
double pan = 1.0; 
 // Sets whether to publish the audio effect to the remote users. true means that both local users and remote users can hear the sound effect; false means that only the local user can hear the sound effect.  BOOL publish = true;
// Set the playback progress of the sound effect file. 500 means to start playing from the 500th ms of the sound effect file.  int startPos = 500;
 // Play the specified sound effect file. (The demo lacks the sample code of startPos)
m_rtcEngine-> playEffect (m_mapEffect [strEffect], strFile.c_str (), loops, pitch, pan, gain, publish, startPos);
 Occurs when the local audio effect playback finishes.  void onAudioEffectFinished (m_mapEffect [strEffect]);
```

After successful playback, you can stop playing the specified or all sound effect files.

```c++
Stops playing a specified audio effect. m_rtcEngine-> stopEffect (m_mapEffect [strEffect]);
 Stops playing all audio effects. m_rtcEngine-> stopAllEffects ();
```

### Pause and resume

When the sound effect file is playing, you can pause or resume playing the specified or all sound effect files.

<div class="alert note">Call this method after <code>playEffect</code>.</div>

```c++
// Pause playing the specified sound effect file.  m_rtcEngine-> pauseEffect (m_mapEffect [strEffect]);
 Resumes playing a specified audio effect.  m_rtcEngine-> resumeEffect (m_mapEffect [strEffect]);
 Pauses all audio effects. m_rtcEngine-> pauseAllEffects ();
 Resumes playing all audio effects. m_rtcEngine->resumeAllEffects();
```

### The playback state.

If you need to adjust the playback position after playing the sound effect file, you can call this group of methods. For example, you can call this group of methods to adjust the playback position during the loop playback of the sound effect file without stopping the playback.

- Call this method` after playEffect`.
- This set of methods is only applicable to local sound effect files.

```c++
// Get the total duration of the specified local sound effect file.  m_rtcEngine-> getEffectDuration (m_mapEffect [strEffect]);
 Sets the playback position of an audio effect file.  m_rtcEngine-> setEffectPosition (m_mapEffect [strEffect], pos);
 Retrieves the duration of the audio effect file.  m_rtcEngine-> getEffectCurrentPosition (m_mapEffect [strEffect]);
```

### Volume setting

After the sound effect file starts to play, you can call this set of methods to adjust the playback volume. For example, you can call this group of methods to adjust the playback volume during the loop playback of the sound effect file without stopping the playback.

<div class="alert note">Call this method after <code>playEffect</code>.</div>

```c++
// Set the playback volume of all sound effect files. The value range is [0,100], 100 represents the original volume.  m_rtcEngine->setEffectsVolume(50);
 Sets the volume of the audio effects. The value range is [0,100], 100 represents the original volume.  m_rtcEngine-> setVolumeOfEffect (m_mapEffect [strEffect], 50);
 Retrieves the volume of the audio effects. The volume range is [0,100], and 100 represents the original volume.  m_rtcEngine->getEffectsVolume();
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

Music mixing refers to mixing music files with audio collected by a microphone. Users who use the audio mixing function usually play relatively long music files and only play one music file at a time. For example, play accompaniment when singing, and play background music when chatting.

Agora provides a set of methods to play and manage music files, mainly including the following functions:

- Play local or online music files
- Set the number of play times, play position, volume, tone and other play options of music files
- Flexible control of the playback, pause, resume and stop of music files
- Report the current music file playback status and the reason for the playback status change

<div class="alert note">Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See <a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">Supported Media Formats in Media Foundation</a >.</div>

After successfully calling `startAudioMixing`, the SDK will trigger the `onAudioMixingStateChanged `callback when the playback state of the music file changes.

### Play and stop

720: Successfully call `startAudioMixing` to play music files. When playing music files, you can set the number of loops, playback position, etc.

<div class="alert note">If startAudioMixing is called again while playing a music file<code></code>, the SDK will automatically stop playing the previous music file and start playing the next music file.</div>

```c++
// Specify the absolute path of the local or online music file that needs to be mixed.  std::string filePath = "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3";
// Set whether to play music files locally. true means that only local users can hear music; false means that both local users and remote users can hear music.  BOOL loopback = false;
// Set whether to replace the audio collected by the microphone with a music file. true means that the user can only hear music; false means that the user can hear the music and audio collected by the microphone.  BOOL replace = true;
// Set the number of times the music file is played. 1 means play once.  int cycle = 1;
// Set the playback progress of the music file. 500 means to start playing from the 500th ms of the music file.  int startPos = 500;
 Starts playing and mixing the music file. (The demo lacks the sample code of startPos)
m_rtcEngine->startAudioMixing(filePath, loopback, replace, cycle, startPos);
 Occurs when the state of the local user's audio mixing file changes.  virtual void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason) {}
```

After successfully playing the music file, you can call `stopAudioMixing` to stop the playback.

```c++
Stops playing and mixing the music file. m_rtcEngine->stopAudioMixing();
```

### Pause and resume

When the music file is playing, you can pause or resume playing the music file.

<div class="alert note">Call this method after calling `<code>startAudioMixing</code>`.</div>

```c++
Pauses playing and mixing the music file.  m_rtcEngine-> pauseAudioMixing ();
 Resumes playing and mixing the music file.  m_rtcEngine->resumeAudioMixing();
```

### The playback state.

When the music file is playing, you can call this group of methods to adjust the playback position of the music file without stopping the playback.

<div class="alert note">After playing the <code>music file</code> successfully, the SDK triggers <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code>.</div>

```c++
Retrieves the total duration of the music file.  m_rtcEngine->getAudioMixingDuration(filePath);
 // Set the playback position of the current music file. 500 means to start playing from the 500th ms of the music file.  m_rtcEngine->setAudioMixingPosition(500);
 // Get the playback progress of the current music file.  m_rtcEngine->getAudioMixingCurrentPosition();
```

### Volume and tone

After successfully playing the music file, you can call this set of methods to adjust the playback volume and pitch of the music file without stopping the playback.

<div class="alert note">After playing the <code>music file</code> successfully, the SDK triggers <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code>.</div>

```c++
// Adjust the local and remote playback volume of the current music file. The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingVolume(50);
 Adjusts the audio mixing volume for publishing (for remote users). The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingPublishVolume(50);
 Adjusts the volume during audio mixing. The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingPlayoutVolume(50);
 Retrieves the audio mixing volume for local playback. The volume range is [0,100], and 100 represents the original volume.  m_rtcEngine->getAudioMixingPlayoutVolume();
 Retrieves the audio mixing volume for publishing. The volume range is [0,100], and 100 represents the original volume.  m_rtcEngine->getAudioMixingPublishVolume();
 Sets the pitch of the local music file. The value range is [-12,12], 0 means the original pitch, and 1 means raising it by a semitone. m_rtcEngine->setAudioMixingPitch(5);
```

### API reference

- `startAudioMixing`
- `stopAudioMixng`
- `pauseAudioMixing`
- `resumeAudioMixing`
- 3. `getAudioMixingDuration`
- `setAudioMixingPosition`
- `getAudioMixingCurrentPosition`
- `adjustAudioMixingVolume`
- `adjustAudioMixingPublishVolume`
- `adjustAudioMixingPlayoutVolume`
- `getAudioMixingPlayoutVolume`
- `getAudioMixingPublishVolume`
- `setAudioMixingPitch`
- 1. `onAudioMixingStateChanged`