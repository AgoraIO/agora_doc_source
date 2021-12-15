---
title: 摄像头曝光与对焦
platform: Android
updatedAt: 2020-04-16 15:11:45
---

## 功能描述

视频场景中，经常会使用到摄像头曝光和对焦的功能，帮助被拍摄物成像清晰、亮度适宜。
Agora SDK 在移动平台提供整套的摄像头管理方法，方便用户切换前后摄像头，并对摄像头的缩放、对焦和曝光进行设置。

- 曝光：支持手动选择曝光区域，摄像头自动曝光。
- 对焦：支持人脸自动对焦和手动对焦。

## 实现方法

在实现摄像头曝光与对焦功能前，请确保已在你的项目中实现基本的实时音视频功能。详见开始[视频通话](start_call_android)/[视频互动直播](start_live_android)。

参考如下步骤，在你的项目中实现摄像头曝光与对焦功能：

- **实现曝光功能**

  调用 `isCameraExposurePositionSupported` 方法检测设备是否支持曝光，如果支持则调用 `setCameraExposurePosition` 方法设置手动曝光位置。

  如果你想获取摄像头曝光位置，可以在 `onCameraExposureAreaChanged` 回调中实现。

- **实现人脸自动对焦功能**

  调用 `isCameraAutoFocusFaceModeSupported` 方法检测设备是否支持人脸对焦功能，如果支持则调用 `setCameraAutoFocusModeEnabled` 方法设置开启该功能。

- **实现手动对焦功能**

  调用 `isCameraFocusSupported` 方法检测设备是否支持手动对焦功能，如果支持则调用 `setCameraFocusPositionInPreview` 方法设置手动对焦位置并触发对焦。

  如果你想获取摄像头对焦位置，可以在 `onCameraFocusAreaChanged` 回调中实现。

### 示例代码

```java
// 测当前设备是否支持曝光并手动设置曝光区域。
boolean shouldSetExposure = rtcEngine.isCameraExposurePositionSupported();
if (shouldSetExposure) {
    // 假设在屏幕(50，100)的位置曝光。
    float positionX = 50.0f;
    float positionY = 100.0f;
    rtcEngine.setCameraExposurePosition(positionX, positionY);
}

// 检测当前设备是否支持人脸自动对焦并设置。
boolean shouldSetFaceMode = rtcEngine.isCameraAutoFocusFaceModeSupported();
rtcEngine.setCameraAutoFocusFaceModeEnabled(shouldSetFaceMode);

// 检测当前设备是否支持手动对焦并设置。
boolean shouldManualFocus = rtcEngine.isCameraFocusSupported();
if (shouldManualFocus) {
    // 假设在屏幕(50，100)的位置对焦。
    float positionX = 50.0f;
    float positionY = 100.0f;
    rtcEngine.setCameraFocusPositionInPreview(positionX, positionY);
}

// 曝光区域更新。你可以在这里监听到曝光更新事件，并进行自己的逻辑处理。
public void onCameraExposureAreaChanged(rect) {
}

// 对焦区域更新。你可以在这里监听到焦点更新事件，并进行自己的逻辑处理。
public void onCameraFocusAreaChanged(rect) {
}
```

### API 参考

- [`isCamerExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)
- [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a09f61f738cf7d8a1902761e03a7fa600)
- [`setCameraAutoFocusModeEnabled`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7e67afe7ad0045448fe0bd97203afcee)
- [`isCameraFocusSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e20f04ccecfc41aa23bf63116c9a8cd)
- [`setCameraFocusPositionInPreview`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aba273e4337a760d883b6c7c1344183c0)
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)
- [`onCameraFocusAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7af6c96c4c35587a13d1e367255e3ec0)
