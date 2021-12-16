---
title: 如何在网页端通话中切换音视频输入设备？
platform: ["Web"]
updatedAt: 2020-06-03 10:54:42
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
音视频输入设备通过设备 ID（`deviceId`） 标识，每个音视频设备均有一个唯一的设备 ID，可以通过 [`getDevices`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/globals.html#getdevices) 方法获取。设备 ID 是随机生成的，部分情况下同一个设备的 ID 可能会改变，因此我们建议每次切换设备时都先调用  `getDevices` 获取设备 ID。

<div class="alert note">Chrome 81 及以上版本、Safari 和 Firefox 浏览器需要在获得媒体设备权限后才能获取设备 ID，详见<a href="https://docs.agora.io/cn/faq/empty_deviceId">为什么在 Chrome 81 浏览器上无法获取设备 ID？</a></div>

## 2.5.0 及以后版本

1. 调用 `getDevices` 获取设备 ID。

2. 调用 [`switchDevice`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#switchdevice) 实时切换设备。

<div class="alert note"><code>switchDevice</code> 方法不支持 Firefox，且无法在 Safari 11 及之前版本上切换音频输入设备。该方法的其他限制详见 API 文档。</div>

### 移动端切换视频输入设备

如果要在移动端切换视频输入设备，例如从后置摄像头切换为前置摄像头，在调用 `switchDevice` 之前必须先关闭当前视频轨道。

``` javascript
switchBtn.onclick=()=>{
  localStream.getVideoTrack().stop();
  localStream.switchDevice("video",devices.value);
};
```

## 2.5.0 之前版本

通过在 `createStream` 时设置 `microphoneId` 或 `cameraId` 来切换视频和音频输入设备。步骤如下：

 1. 调用 [`close`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#close) 方法关闭当前流。
 2. 调用 `getDevices` 方法枚举可用设备。
 3. 根据获得的设备 ID 和设备类型，调用 [`createStream`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/globals.html#createstream) 方法并将新的设备 ID 填入 [`microphoneId`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.streamspec.html#microphoneid) 或 [`cameraId`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.streamspec.html#cameraid)。

如果不需要选择设备，直接用默认识别到的第一个设备，可以直接在 `createstream` 时把 `cameraId`、`microphoneId` 填为 ""。