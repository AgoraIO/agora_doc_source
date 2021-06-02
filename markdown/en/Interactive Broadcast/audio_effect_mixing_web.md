---
title: Play Audio Effects/Audio Mixing File
platform: Web
updatedAt: 2021-01-05 06:14:24
---
## Introduction

In a call or live interactive streaming, you may need to play custom audio or music files to all users in the channel. For example, adding sound effects in a game, or playing background music. Agora provides two groups of methods for playing audio effect files and audio mixing.

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_web) or [Start Live Interactive Streaming](start_live_web) for details.


<div class="alert info">Click the <a href="https://webdemo.agora.io/agora-web-showcase/examples/AgoraAudioIO-Web/">online demo</a> to try this feature out.</div>

## Play audio effect files

The play audio effect methods can be used to play ambient sound, such as clapping and gunshots. You can play multiple audio effects at the same time, and preload the audio effect file for efficiency.

The audio effect file is specified by the file path, but the SDK uses the sound ID to identify the audio effect file. The SDK does not have any rule to define the sound ID. You need to ensure that each audio effect file has a unique sound ID.

### Implementation


```javascript
// Preloads the audio effect (recommended). Note the file size.
stream.preloadEffect(1, "https://web-demos-static.agora.io/agora/smlt.flac", function(err){
    if (err){
        console.error("Failed to preload effect, reason: ", err);
    }else{
        console.log("Effect is preloaded successfully");
    }
});

// Plays an audio effect file.
stream.playEffect({
    soundId: 1,
    filePath: "https://web-demos-static.agora.io/agora/smlt.flac"
}, function(error) {
    if (error) {
        // Error handling
        return;
    }
    // Process after playing the audio effect successfully
});

// Gets the volume of all the audio effects. 
var volumes = stream.getEffectsVolume();
volumes.forEach(function({soundId, volume}){
    console.log("SoundId", soundId, "Volume", volume);
});

// Pauses playing all the audio effects.
stream.pauseAllEffects(function(err){
    if (err){
        console.error("Failed to pause effects, reason: ", err);
    }else{
        console.log("Effects are paused successfully");
    }
});

// Resumes playing the paused audio effects.
stream.resumeAllEffects(function(err){
    if (err){
        console.error("Failed to resume effects, reason: ", err);
    }else{
        console.log("Effects are resumed successfully");
    }
});

// Stops playing all the audio effects.
stream.stopAllEffects(function(err){
    if (err){
        console.error("Failed to stop effects, reason: ", err);
    }else{
        console.log("Effects are stopped successfully");
    }
});

// Releases the preloaded audio effect.
stream.unloadEffect(1, function(err){
    if (err){
        console.error("Failed to unload effect, reason: ", err);
    }else{
        console.log("Effect is unloaded successfully");
    }
});
```

### API reference

- [`Stream.playEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#playeffect)
- [`Stream.stopEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#stopeffect)
- [`Stream.pauseEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#pauseeffect)
- [`Stream.resumeEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#resumeeffect)
- [`Stream.setVolumeOfEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#setvolumeofeffect)
- [`Stream.preloadEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#preloadeffect)
- [`Stream.unloadEffect`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#unloadeffect)
- [`Stream.getEffectsVolume`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#geteffectsvolume)
- [`Stream.setEffectsVolume`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#seteffectsvolume)
- [`Stream.stopAllEffects`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#stopalleffects)
- [`Stream.pauseAllEffects`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#pausealleffects)
- [`Stream.resumeAllEffects`](./API%20Reference/web/v2.6/interfaces/agorartc.stream.html?transId=2.6#resumealleffects)

### Considerations

- Supports only the online audio effect files.
- Supports MP3, AAC, and other formats supported by the browser.
- All the above methods use the Node.js callback pattern.

## Audio mixing

Audio mixing is playing a local or online music file while speaking, so that other users in the channel can hear the music. The audio mixing methods can be used to play background music. For example, playing music in a live interactive streaming. Only one music file can be played at one time. 
Agora audio mixing supports the following options:

- Mix or replace the audio: 
	- Mix the music file with the audio captured by the microphone and send it to other users.
	- Replace the audio captured by the microphone with the music file.
- Loop: Sets whether to loop the audio mixing file and the number of times to play the file.

### Implementation

```javascript
// Sets the audio mixing options.
// filePath is a mandatory parameter used to indicate an online URL of the mixing audio.
// cycle is an optional parameter used to indicate the number of playback loops and it needs to be a positive integer. The web browser needs to be Google Chrome 65+.
// replace is an optional parameter used to indicate if the audio mixing replaces the original audio. 
// playTime is a mandatory parameter used to set the starting position of mixing audio playback. 0 means playing the mixing file from the beginning.
var options = {
      filePath: "http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3", 
      cycle: 1, 
      replace: false, 
      playTime:0 
}

// Starts audio mixing.
localStream.startAudioMixing(options, function(err){
     if (err){
             console.log("Failed to start audio mixing. " + err);
      }
});

// Adjusts the volume of audio mixing. The value of volume ranges between 1 and 100.
localStream.adjustAudioMixingVolume(volume);

// Gets the playback position (ms) of the mixed audio.
localStream.getAudioMixingCurrentPosition();

// Sets the playback position of the mixed audio.
localStream.setAudioMixingPosition(pos);

// Pauses audio mixing.
localStream.pauseAudioMixing();

// Resumes audio mixing.
localStream.resumeAudioMixing();

// Gets the duration (ms) of audio mixing. 
localStream.getAudioMixingDuration();

// Stops audio mixing.
localStream.stopAudioMixing();
```

### API Reference

- [`startAudioMixing`](./API%20Reference/web/interfaces/agorartc.stream.html#startaudiomixing)
- [`stopAudioMixing`](./API%20Reference/web/interfaces/agorartc.stream.html#stopaudiomixing)
- [`adjustAudioMixingVolume`](./API%20Reference/web/interfaces/agorartc.stream.html#adjustaudiomixingvolume)
- [`pauseAudioMixing`](./API%20Reference/web/interfaces/agorartc.stream.html#pauseaudiomixing)
- [`resumeAudioMixing`](./API%20Reference/web/interfaces/agorartc.stream.html#resumeaudiomixing)
- [`getAudioMixingDuration`](./API%20Reference/web/interfaces/agorartc.stream.html#getaudiomixingduration)
- [`getAudioMixingCurrentPosition`](./API%20Reference/web/interfaces/agorartc.stream.html#getaudiomixingcurrentposition)
- [`setAudioMixingPosition`](./API%20Reference/web/interfaces/agorartc.stream.html#setaudiomixingposition)

### Considerations

- Agora Web SDK supports using only online music files for audio mixing.
- The audio mixing methods support the following browsers:
  - Safari 12+
  - Google Chrome 65+
  - Firefox
- Call the methods when you are in the channel.
- Some parameters are supported by specific web browsers. See [`startAudioMixing`](./API%20Reference/web/interfaces/agorartc.stream.html#startaudiomixing) for details.

## Demo project

We provide an open-source [AgoraAudioIO-Web-Webpack](https://github.com/AgoraIO/Advanced-Audio/tree/master/Web/AgoraAudioIO-Web-Webpack) demo project on GitHub. [Try it online](https://webdemo.agora.io/agora-web-showcase/examples/AgoraAudioIO-Web/) and refer to the code in [`rtc-client.js`](https://github.com/AgoraIO/Advanced-Audio/blob/master/Web/AgoraAudioIO-Web-Webpack/src/rtc-client.js).