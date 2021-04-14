---
title: Camera Exposure and Focus
platform: Android
updatedAt: 2020-07-06 16:19:15
---
## Introduction

Camera exposure and focus are commonly used in video calls to enable high-quality video capture. Agora SDK provides a set of camera management methods on the Android platform, with which you can switch between the front and rear camera, set the camera zoom factor, set the exposure region and set the focus position.

- Camera exposure: Auto exposure is supported where users can maually set the exposure region.
- Camera focus: Auto face-focus and manual focus are supported.

## Implementation

Before proceeding, ensure that you implement a basic video call or live broadcast in your project. See [Start a Call](start_call_android)/[Start a Live Broadcast](start_live_android) for details.

Refer to the following steps to set the camera exposure and focus:

- **Exposure**
Call the `isCameraExposurePositionSupported` method to check whether exposure function is supported. If it is supported, call the `setCameraExposurePosition` method to set the camera exposure.
You can monitor the exposure position by the `onCameraExposureAreaChanged` callback.
- **Auto face-focus**
Call the `isCameraAutoFocusFaceModeSupported` method to check whether auto face-focus function is supported. If it's supported, call the `setCameraAutoFocusModeEnabled` method to set the focus.
- **Manual focus**
Call the `isCameraFocusSupported` method to check whether manual focus function is supported. If it is supported, call the `setCameraFocusPositionInPreview` method to set the focus.
You can monitor the focus position with the `onCameraFocusAreaChanged` callback.

### Sample code

```java
// Check whether exposure function is supported and enable exposure.
boolean shouldSetExposure = rtcEngine.isCameraExposurePositionSupported();
if (shouldSetExposure) {
    // Set the camera exposure at (50, 100).
    float positionX = 50.0f;
    float positionY = 100.0f;
    rtcEngine.setCameraExposurePosition(positionX, positionY);
}

// Check whether auto face-focus function is supported and enable auto-face focus.
boolean shouldSetFaceMode = rtcEngine.isCameraAutoFocusFaceModeSupported();
rtcEngine.setCameraAutoFocusFaceModeEnabled(shouldSetFaceMode);

// Check whether manual focus function is supported and set the focus.
boolean shouldManualFocus = rtcEngine.isCameraFocusSupported();
if (shouldManualFocus) {
    // Set the camera focus at (50, 100).
    float positionX = 50.0f;
    float positionY = 100.0f;
    rtcEngine.setCameraFocusPositionInPreview(positionX, positionY);
}

// The camera focus area is updated. You can monitor the update event and implement corresponding logic.
public void onCameraExposureAreaChanged(rect) {
}

// The camera exposure area is updated. You can monitor the update event the implement corresponding logic.
public void onCameraFocusAreaChanged(rect) {
}
```

### API Reference

- [`isCamerExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)
- [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a09f61f738cf7d8a1902761e03a7fa600)
- [`setCameraAutoFocusModeEnabled`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7e67afe7ad0045448fe0bd97203afcee)
- [`isCameraFocusSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e20f04ccecfc41aa23bf63116c9a8cd)
- [`setCameraFocusPositionInPreview`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aba273e4337a760d883b6c7c1344183c0)
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)
- [`onCameraFocusAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7af6c96c4c35587a13d1e367255e3ec0)