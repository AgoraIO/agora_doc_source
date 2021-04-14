---
title: Test a Media Device
platform: Web
updatedAt: 2021-01-05 06:06:48
---
<div class="alert note">This article only applies to the Agora Web SDK 3.x and earlier versions. If you use the Web SDK 4.x, see <a href="./test_switch_device_web_ng?platform=Web"></a>.</div>

## Introduction

Agora supports the media device test and selection feature, allowing you to check if a camera or an audio device (a headset, microphone, or speaker) works properly.

You can use the media device test and selection feature in the following scenarios:

- A host self-checks before starting a live broadcast.
- An online user checks if the media device works properly.

## Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_web ) or [Start Live Interactive Streaming](start_live_web ) for details.

### Microphone/Camera test

Refer to the following steps to test the microphone and camera:

1. Call the `AgoraRTC.getDevices` method to get available devices.
2. Call the `AgoraRTC.createStream` method to create an audio or video stream. In this method, fill the `microphoneId` or `cameraId` parameter with the device ID to specify the device to be tested.
3. Call the `Stream.init` method to initialize the stream. In the `onSuccess` callback function, play the stream.
   - If testing the microphone, call the `Stream.getAudioLevel` method to get the current audio level. The audio level is greater than 0 if the microphone is working.
   - If testing the camera, the video shows if the camera is working.

```javascript
// Find all audio and video devices
AgoraRTC.getDevices(function(devices){
    var audioDevices = devices.filter(function(device){
        return device.kind === "audioinput";
    });
    var videoDevices = devices.filter(function(device){
        return device.kind === "videoinput";
    });

    var uid = Math.floor(Math.random()*10000);
    var selectedMicrophoneId = ...;
    var selectedCameraId = ...;
    var stream = AgoraRTC.createStream({
        streamID: uid,
        // Set audio to true if testing microphone
        audio: true,
        microphoneId: selectedMicrophoneId,
        // Set video to true if testing camera
        video: true,
        cameraId: selectedCameraId,
        screen: false
    });

    // Initialize the stream
    stream.init(function(){
        stream.play("mic-test");
        // Print the audio level every 1000 ms
        setInterval(function(){
            console.log(`Local Stream Audio Level ${stream.getAudioLevel()}`);
        }, 1000);
    })
});
```

### Audio playback device test

Due to browser security limitations, the Agora Web SDK does not support playing local audio files. You can use the following method to test the audio playback devices:

Use the HTML5 `<audio>` element to create an audio player on the web page for users to play an online audio file and confirm whether they can hear the sound.

### API reference

- [`AgoraRTC.getDevices`](./API%20Reference/web/v3.3.1/globals.html#getdevices)
- [`AgoraRTC.createStream`](./API%20Reference/web/v3.3.1/globals.html#createstream)
- [`Stream.init`](./API%20Reference/web/interfaces/agorartc.stream.html#init)
- [`Stream.play`](./API%20Reference/web/interfaces/agorartc.stream.html#play)
- [`Stream.getAudioLevel`](./API%20Reference/web/interfaces/agorartc.stream.html#getaudiolevel)

## Considerations

- On Chrome 81 or later, Safari, and Firefox, device IDs are only available after the user has granted permissions to use the media device. See [Why can't I get device ID on Chrome 81?](https://docs.agora.io/en/faq/empty_deviceId)
- Errors might occur when you call `stream.init`, see the [API Reference](./API%20Reference/web/interfaces/agorartc.stream.html#init) for details.
- The device ID is randomly generated, and might change for the same device, so we recommend you call the `getDevices` method every time before testing the devices.