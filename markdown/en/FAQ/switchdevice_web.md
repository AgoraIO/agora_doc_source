---
title: How can I switch the input device during a web call?
platform: ["Web"]
updatedAt: 2020-05-07 17:43:17
Products: ["Voice","Video","Interactive Broadcast"]
---
The Agora Web SDK identifies media input devices by the device ID (`deviceId`). Each device has a unique device ID that you can get by [`getDevices`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/globals.html#getdevices). The device ID is randomly generated, and may change for the same device, so Agora recommends calling  `getDevices` every time before switching the device.

<div class="alert note">On Chrome 81 or later, Safari, and Firefox, device IDs are only available after the user has granted permissions to use the media device. See <a href="https://docs.agora.io/en/faq/empty_deviceId">Why can't I get device ID on Chrome 81?</a></div>

## For the Agora Web SDK v2.5.0 or later

1. Call `getDevices` to enumerate available devices and get the device IDs.
2. Call [`switchDevice`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#switchdevice) after getting the device ID. 

<div class="alert note"><code>switchDevice</code> does not work on Firefox, and cannot switch audio input devices on Safari 11 or earlier. See the API Reference for other limitations.</div>

### Switch cameras on mobile devices

To switch cameras on mobile devices, for example, switching between the rear camera and the front camera, you need to stop the current video track before calling `switchDevice`.

``` javascript
switchBtn.onclick=()=>{
  localStream.getVideoTrack().stop();
  localStream.switchDevice("video",devices.value);
};
```

## For versions earlier than v2.5.0

Set the `microphoneId` and `cameraId` parameters in the `createStream` method to switch the microphone and camera.

1. Call [`close`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#close) to close the local stream.
2. Call `getDevices` to enumerate available devices and get the device IDs.
3. Call [`createStream`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/globals.html#createstream) and fill the [`microphoneId`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.streamspec.html#microphoneid) or [`cameraId`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.streamspec.html#cameraid) parameter with the device ID.

To use the first input device by default, set `cameraId` and `microphoneId` as `""` in `createStream`.