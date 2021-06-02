---
title: Why can't I get the device ID on Chrome 81?
platform: ["Web"]
updatedAt: 2020-05-09 09:52:18
Products: ["Voice","Video","Interactive Broadcast"]
---
## Problem

On Chrome 81, the `deviceId` field that the `getDevices` method returns is empty.

<div class="alert info">You may also encounter this issue on Safari and Firefox.</div>

## Reason

As of Chrome 81, device IDs are not exposed if permission to use devices has not been granted. This change is to protect user privacy.

For the Agora Web SDK, if you get device information before the method call of `Stream.init` succeeds, the returned `deviceId` may be empty.

## Solution

You can create temporary streams for media capture to trigger the device permission request and get the device information.

1. Based on your requirements, create temporary streams for audio or video capture to trigger requests for microphone or camera permissions.

   ```javascript
   const tempAudioStream = AgoraRTC.createStream({ audio: true, video: false});
   const tempVideoStream = AgoraRTC.createStream({ audio: false, video: true});
   ```

2. After the streams are initialized, call `getDevices` to get the complete device information.

   <div class="alert note">Note<ul><li>The capture may fail if no microphone or camera exists, or if the user has disabled these devices. The capture is a workaround and you only need to ensure that the failure does not stop the code execution. </li><li>If the capture fails, you may still get empty <code>deviceId</code> and <code>label</code> fields in the returned device list.</li></ul></div>

   ```javascript
   const audioPermissionOK = new Promise(resolve => {
     tempAudioStream.init(() => resolve(null), (e) => resolve(e));
   });
   const videoPermissionOK = new Promise(resolve => {
     tempVideoStream.init(() => resolve(null), (e) => resolve(e));
   });
    
   Promise.all([audioPermissionOK, videoPermissionOK]).then(res => {
     if (res[0] !== null) {
       console.warn("create audio temp stream failed!", res[0]);
     }
     if (res[1] !== null) {
       console.warn("create video temp stream failed!", res[0]);
     }
    
   // After the capture, call getDevices to get device information
     const devices = AgoraRTC.getDevices(info => {
       tempAudioStream.close();
       tempVideoStream.close();
       console.log("get device info!", info);
     });
   });
   ```

## Reference

Agora provides an [online demo](https://webdemo.agora.io/device_permission_demo) on obtaining device information.