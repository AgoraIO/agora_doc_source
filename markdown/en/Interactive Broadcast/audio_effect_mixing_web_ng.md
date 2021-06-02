---
title: Play Audio Effects/Audio Mixing Files
platform: Web
updatedAt: 2020-12-30 09:08:47
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./audio_effect_mixing_web?platform=Web">Play Audio Effects/Audio Mixing Files</a>.</li></div>

## Introduction

In a call or live broadcast, you may need to play custom sound or music to all the users in the channel. For example, adding sound effects in a game, or playing background music.

The Agora Web SDK supports publishing and automatically mixing multiple audio tracks to create and play custom sound or music.

<div class="alert info">Click the <a href="https://webdemo.agora.io/agora-websdk-api-example-4.x/audioMixingAndAudioEffect/index.html">online demo</a> to try this feature out.</div>

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

To play a sound effect or background music, create an audio track from a local or online audio file and publish it together with the audio track from the microphone.

### Create audio track from audio file

The SDK provides `createBufferSourceAudioTrack` to read a local or online audio file and create an audio track object (`BufferSourceAudioTrack`).

```js
// Create an audio track from an online music file
const audioFileTrack = await AgoraRTC.createBufferSourceAudioTrack({
  source: "https://web-demos-static.agora.io/agora/smlt.flac",
});
console.log("create audio file track success");
```

If you call `audioFileTrack.play()` or `client.publish([audioFileTrack])` immediately after creating the audio track, your users will not hear anything. This is because the SDK processes the audio track created from an audio file differently from the microphone audio track (`MicrophoneAudioTrack`).

**MicrophoneAudioTrack**
![](https://web-cdn.agora.io/docs-files/1608477676258)

For the microphone audio track, the SDK keeps sampling the latest audio data (`AudioBuffer`) from the microphone.

- When you call `play`, the SDK sends the audio data to the local playback module (`LocalPlayback`), then the local user can hear the audio.
- When you call `publish`, the SDK sends the audio data to Agora SD-RTN, then the remote users can hear the audio.

Once the microphone audio track is created, the sampling continues until `close` is called, and then the audio track becomes unavailable.

**BufferSourceAudioTrack**
![](https://web-cdn.agora.io/docs-files/1608477687221)

For an audio file, the SDK cannot sample the audio data directly, and instead reads the file to achieve similar effects, such as the `processing` phase in the previous figure.

Sampling is different from file reading:

- Sampling cannot be paused, because only the latest data can be sampled.
- Reading an audio file enables more control over playback, including pausing, jumping to a different position, looping, and more. These are the core functions of `BufferSourceAudioTrack`. See [Control the playback](#control-the-playback) for details.

For the audio track created from an audio file, the SDK does not read the file by default. Call `BufferSourceAudioTrack.startProcessAudioBuffer()` to start reading and processing the audio data, and then call `play` and `publish` for the local and remote users to hear the audio.

### Publish multiple audio tracks

To start audio mixing, publish  `audioFileTrack` and the microphone audio track together.

```js
const microphoneTrack = await AgoraRTC.createMicrophoneAudioTrack();

// Start processing the audio data from the audio file
audioFileTrack.startProcessAudioBuffer();

// Publish audioFileTrack and microphoneTrack together
await client.publish([microphoneTrack, audioFileTrack]);

// To stop audio mixing, stop processing the audio data
audioFileTrack.stopProcessAudioBuffer();
// Or unpublish audioFileTrack
await client.unpublish([audioFileTrack]);
```

### Control the playback

`BufferSourceAudioTrack` provides the following methods to control the playback of the audio file:

- [`startProcessAudioBuffer`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html#startprocessaudiobuffer): Starts reading the audio file and processing data. This method also supports setting loop times and the playback starting position.
- [`pauseProcessAudioBuffer`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html#pauseprocessaudiobuffer): Pauses processing the audio data to pause the playback.
- [`resumeProcessAudioBuffer`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html#resumeprocessaudiobuffer): Resumes processing the audio data to resume the playback.
- [`stopProcessAudioBuffer`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html#stopprocessaudiobuffer): Stops processing the audio data to stop the playback.
- [`seekAudioBuffer`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html#seekaudiobuffer): Jumps to a specified position.

After the processing starts, if you have called `play` and `publish`, calling the above methods affects both the local and remote users.

```js
// Pause processing the audio data
audioFileTrack.pauseProcessAudioBuffer();
// Resume processing the audio data
audioFileTrack.resumeProcessAudioBuffer();
// Stop processing the audio data
audioFileTrack.stopProcessAudioBuffer();
// Start processing the audio data in loops
audioFileTrack.startProcessAudioBuffer({ loop: true });

// Get the current playback position (seconds)
audioFileTrack.getCurrentTime();
// The duration of the audio file (seconds)
audioFileTrack.duration;
// Jump to the playback position of 50 seconds
audioFileTrack.seekAudioBuffer(50);
```

If the local user does not need to hear the audio file, call `stop()` to stop the local playback, which does not affect the remote users.

### API reference

- [`createBufferSourceAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createbuffersourceaudiotrack)
- [`BufferSourceAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/ibuffersourceaudiotrack.html)
- [`publish`](./API%20Reference/web/v4.2.1/interfaces/iagorartcclient.html#publish)

## Considerations
- Ensure that you configure [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS) if you use online audio files.
- The supported audio formats include MP3, AAC and other audio formats that the browser supports.
- The local audio files must be [`File`](https://developer.mozilla.org/en-US/docs/Web/API/File) objects.
- Safari does not support publishing multiple audio tracks on versions earlier than Safari 12.
- No matter how many audio tracks are published, the SDK automatically mixes them into one audio track, therefore the remote users only get one `RemoteAudioTrack` object.
