---
title: 播放音频文件
platform: Windows
updatedAt: 2020-12-04 01:39:56
---
## Description

In the process of     real-time audio and video interaction, in order to enhance the atmosphere and add interest, users usually need to play sound effects or music files and let all users in the channel hear them. For example, adding fighting sounds to the game, and accompaniment when singing. Agora provides two independent methods, you can play sound effects and music files separately.

## Sample project

Agora provides an open-source sample project on GitHub [](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioEffect)[](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/AudioMixing)that implements setting the video profile. You can view the source code on Github or download the project to try it out.

## Sound file

The sound effects mentioned in this article refer to short-duration ambient sounds, such as applause, cheers, fighting sounds, gunshots, etc. Usually multiple sound effects can be used in a superimposed manner.

Agora provides a set of methods to play and manage sound effect files, mainly including the following functions:

- Play local or online audio files
- Set the space position, loop times, playback position, volume and other playback options of the sound effect
- Flexible control of the play, pause, resume and stop of specified or all sound effect files

<div class="alert note">Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. Fore more information, see<a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">  Supported Media Formats in Media Foundation</a >。</div>

Refer to the following steps to play audio files:

1. Call the `preloadEffect `method to preload the local sound effect file before joining the channel.
2. After joining the channel, call the `playEffect` method to play the sound effect file. After completing playing an audio effect file, the SDK triggers the `onAudioEffectFinished` callback.

### Plays a specified audio effect.

Before playing the sound effect file, you need to set `filePath` and `soundId to specify the sound effect file`. The meaning of the two parameters is as follows:

- `filePath`: Sound effect file path, supports local or online file path. The SDK will look for the sound effect file in this path.
- `soundId`: Sound effect ID, which is defined by you and is unique. The SDK will identify the sound effect file based on the sound effect ID. Common methods for defining sound effect ID include self-incrementing ID, hashCode using sound effect file name, and so on.

```c++
// Set to automatically allocate soundId according to the specified sound effect file path, and associate the sound effect file path with soundId. m_mapEffect.insert(std::make_pair(strPath, m_soundId++));
```

### 预加载

The SDK supports pre-loading. You can load the sound effect files into the memory in advance to improve performance. Preloading is not a necessary step, Agora recommends that you choose according to your needs.

- If you need to play a specific sound effect repeatedly, it is recommended to preload the sound effect file.
- Agora recommends you preload the audio effect to improve the efficiency or to play the audio effect multiple times.

To load multiple local sound effect files, you need to call preloadEffect multiple times``.

<div class="alert note"><li>Only supports pre-loading local sound effect files.</li><li><code>preloadEffect</code> 需要在加入频道前调用。</li><li>调用 <code>preloadEffect</code> 后，音效文件会一直占用内存，直至调用 <code>unloadEffect</code> 或者离开频道。</li></div>

```c++
// Preload the specified local sound effect file into the memory.  m_rtcEngine-> preloadEffect (m_mapEffect [strEffect], strPath.c_str ());
// Release the preloaded sound effect file.  m_rtcEngine-> unloadEffect (m_mapEffect [strEffect]);
```

### 播放和停止

Call `playEffect` to play the sound effect file. According to your needs, you can call playEffect multiple times` to play` multiple sound effect files at the same time. When playing a sound effect file, you can set the number of loops, pitch, volume, playback position, etc.

<div class="alert note"><code>playEffect</code> 需要在加入频道后调用。</div>

```c++
// Set the number of times the sound effect is played in a loop. -1 means infinite loop.  int loops = -1;
// Set the tone of the sound effect. The value range is [0.5, 2.0].  double pitch = 1.5;
// Set the volume. The value range is [0,100], 100 represents the original volume.  int gain = 100;
// Set the sound effect space position. 1.0: The audio effect displays to the right.  double pan = 1.0;
// Set whether to publish the sound effect to the remote end. true means that both local users and remote users can hear the sound effect; false means that only the local user can hear the sound effect.  BOOL publish = true;
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

### 暂停与恢复

When the sound effect file is playing, you can pause or resume playing the specified or all sound effect files.

<div class="alert note">Call this method after <code>playEffect</code>.</div>

```c++
// Pause playing the specified sound effect file.  m_rtcEngine-> pauseEffect (m_mapEffect [strEffect]);
 Resumes playing a specified audio effect.  m_rtcEngine-> resumeEffect (m_mapEffect [strEffect]);
 
// 暂停播放所有的音效文件。 m_rtcEngine-> pauseAllEffects ();
 Resumes playing all audio effects. m_rtcEngine->resumeAllEffects();
```

### 播放位置

If you need to adjust the playback position after playing the sound effect file, you can call this group of methods. For example, you can call this group of methods to adjust the playback position during the loop playback of the sound effect file without stopping the playback.

- Call this method` after playEffect`.
- This set of methods is only applicable to local sound effect files.

```c++
// Get the total duration of the specified local sound effect file.  m_rtcEngine-> getEffectDuration (m_mapEffect [strEffect]);
 Sets the playback position of an audio effect file.  m_rtcEngine-> setEffectPosition (m_mapEffect [strEffect], pos);
 
// 获取指定本地音效文件的总时长。  m_rtcEngine-> getEffectCurrentPosition (m_mapEffect [strEffect]);
```

### Volume setting

After the sound effect file starts to play, you can call this set of methods to adjust the playback volume. For example, you can call this group of methods to adjust the playback volume during the loop playback of the sound effect file without stopping the playback.

<div class="alert note">Call this method after <code>playEffect</code>.</div>

```c++
// Set the playback volume of all sound effect files. The value range is [0,100], 100 represents the original volume.  m_rtcEngine->setEffectsVolume(50);
 
// 设置指定音效文件的播放音量。 The value range is [0,100], 100 represents the original volume.  m_rtcEngine-> setVolumeOfEffect (m_mapEffect [strEffect], 50);
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

<div class="alert note">Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. Fore more information, see<a href="https://docs.microsoft.com/zh-cn/windows/desktop/medfound/supported-media-formats-in-media-foundation">  Supported Media Formats in Media Foundation</a >。</div>

After successfully calling `startAudioMixing`, the SDK will trigger the `onAudioMixingStateChanged `callback when the playback state of the music file changes.

### 播放和停止

720: Successfully call `startAudioMixing` to play music files. When playing music files, you can set the number of loops, playback position, etc.

<div class="alert note">如果在播放一个音乐文件时再次调用 <code>startAudioMixing</code>，则 SDK 会自动停止播放上一个音乐文件并开始播放下一个音乐文件。</div>

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

### 暂停与恢复

When the music file is playing, you can pause or resume playing the music file.

<div class="alert note">Call this method after calling `<code>startAudioMixing</code>`.</div>

```c++
Pauses playing and mixing the music file.  m_rtcEngine-> pauseAudioMixing ();
 Resumes playing and mixing the music file.  m_rtcEngine->resumeAudioMixing();
```

### 播放位置

When the music file is playing, you can call this group of methods to adjust the playback position of the music file without stopping the playback.

<div class="alert note">本组方法需要在调用 <code>startAudioMixing</code> 并收到 <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> 回调后调用。</div>

```c++
Retrieves the total duration of the music file.  m_rtcEngine->getAudioMixingDuration(filePath);
 // Set the playback position of the current music file. 500 means to start playing from the 500th ms of the music file.  m_rtcEngine->setAudioMixingPosition(500);
 // Get the playback progress of the current music file.  m_rtcEngine->getAudioMixingCurrentPosition();
```

### Volume and tone

After successfully playing the music file, you can call this set of methods to adjust the playback volume and pitch of the music file without stopping the playback.

<div class="alert note">本组方法需要在调用 <code>startAudioMixing</code> 并收到 <code>onAudioMixingStateChanged(AUDIO_MIXING_STATE_PLAYING)</code> 回调后调用。</div>

```c++
// Adjust the local and remote playback volume of the current music file. The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingVolume(50);
 
// 调节当前音乐文件在远端的播放音量。 The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingPublishVolume(50);
 
// 调节当前音乐文件在本地的播放音量。 The value range is [0,100], 100 represents the original volume.  m_rtcEngine->adjustAudioMixingPlayoutVolume(50);
 
// 获取当前音乐文件在本地的播放音量。 The volume range is [0,100], and 100 represents the original volume.  m_rtcEngine->getAudioMixingPlayoutVolume();
 
// 获取当前音乐文件在远端的播放音量。 The volume range is [0,100], and 100 represents the original volume.  m_rtcEngine->getAudioMixingPublishVolume();
 
// 调节当前音乐文件的音调。 The value range is [-12,12], 0 means the original pitch, and 1 means raising it by a semitone. m_rtcEngine->setAudioMixingPitch(5);
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