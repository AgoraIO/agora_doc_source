---
title: Set the Audio Profile
platform: Web
updatedAt: 2021-01-05 06:07:52
---
## Feature Description 

High-fidelity audio is essential for professional audio scenarios, such as for podcasts and singing competitions. For example, podcasts require stereo and high-fidelity audio. High-fidelity audio refers to an audio profile with a sample rate of 48 kHz and a bitrate of 192 Kbps.


## Implementations

Agora Web SDK provides the [setAudioProfile](./API%20Reference/web/interfaces/agorartc.stream.html#setaudioprofile) method for developers to set appropriate audio profiles according to the scenarios. The `profile` parameter sets the sampling rate, bitrate, and encode mode.

```javascript
  // Set the audio profile of 48 KHz sampling rate, stereo, and 192 Kbps bitrate.
  localStream.setAudioProfile("high_quality_stereo");
  localStream.init(function(){
   // init successful
  });
```

> For more options, see  [setAudioProfile](./API%20Reference/web/interfaces/agorartc.stream.html#setaudioprofile).

## Considerations

- Call this method before `Stream.init`.