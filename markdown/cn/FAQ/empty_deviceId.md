---
title: 为什么在 Chrome 81 浏览器上无法获取设备 ID？
platform: ["Web"]
updatedAt: 2020-05-07 15:10:47
Products: ["Voice","Video","Interactive Broadcast"]
---
## 问题描述

在 Chrome 81 浏览器上调用 `getDevices`，获得的 `deviceId` 为空。

<div class="alert info">在 Safari 和 Firefox 上也可能遇到该问题。</div>

## 问题原因

出于保护用户隐私的考虑，从 Chrome 81 版本起，如果浏览器没有获得使用媒体设备的权限，将无法获取设备 ID 信息。

对于 Agora Web SDK 来说，如果在 `Stream.init` 成功之前调用获取设备信息的方法，获得的 `deviceId` 都可能为空。

## 解决方案

你可以通过额外创建临时的流采集音视频，触发媒体设备权限申请，以获得完整的设备信息。

1. 根据需要创建临时的音频流和视频流分别用于采集音频和视频，触发麦克风和摄像头的权限申请。

   ```javascript
   const tempAudioStream = AgoraRTC.createStream({ audio: true, video: false });
   const tempVideoStream = AgoraRTC.createStream({ audio: false, video: true });
   ```

2. 采集完成后，调用 `getDevices` 即可获得完整的设备信息。
   <div class="alert note">注意事项：<ul>
   <li>如果用户没有麦克风或者摄像头，或者禁用了这些设备，采集可能会失败。此时采集音频和视频的目的是获取使用媒体设备的权限，因此只要确保采集失败不影响整个流程即可。 </li><li>如果发生采集失败，获取到的设备列表中可能还是会存在 <code>deviceId</code> 和 <code>label</code> 为空的设备。</li></ul></div>

 ``` javascript
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
    
   // 音视频采集完成后，调用 getDevices 获取 label 和 deviceId
     const devices = AgoraRTC.getDevices(info => {
       tempAudioStream.close();
       tempVideoStream.close();
       console.log("get device info!", info);
     });
   });
   ```

## 相关链接

Agora 提供一个获取设备信息的[在线 demo](https://webdemo.agora.io/device_permission_demo) 供你参考。