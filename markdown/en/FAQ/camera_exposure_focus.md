---
title: How can I enable camera exposure and focus?
platform: ["Android","iOS"]
updatedAt: 2020-10-19 10:43:59
Products: ["Video","Interactive Broadcast"]
---
Camera exposure and focus are commonly used in video calls to enable high-quality video capture. The Agora RTC SDK provides a set of camera management methods on the Android and iOS platforms, with which you can switch between the front and rear camera, set the camera zoom factor, set the exposure region and set the focus position.

- Camera exposure: Auto exposure is supported where users can manually set the exposure region.
- Camera focus: Auto face-focus and manual focus are supported.

## Implementation

> Before proceeding, ensure that you have implemented basic real-time functions in your project.

Refer to the following steps to set the camera exposure and focus:

- **Exposure**
Call the `isCameraExposurePositionSupported` method to check whether exposure function is supported. If it is supported, call the `setCameraExposurePosition` method to set the camera exposure.
You can monitor the exposure position with the `onCameraExposureAreaChanged` callback.
- **Auto face-focus**
Call the `isCameraAutoFocusFaceModeSupported` method to check whether auto face-focus function is supported. If it is supported, call the `setCameraAutoFocusModeEnabled` method to set the focus.
- **Manual focus**
Call the `isCameraFocusSupported` method to check whether manual focus function is supported. If it is supported, call the `setCameraFocusPositionInPreview` method to set the focus.
You can monitor the focus position with the `onCameraFocusAreaChanged` callback.

### Sample code

```java
// Java
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

```swift
// Swift
// Check whether exposure function is supported and enable exposure.
  let isSupported = agoraKit.isCameraExposurePositionSupported()

if isSupported {
    // Set the camera exposure at (50, 100).
    let point = CGPoint(x: 50, y: 100)
    agoraKit.setCameraExposurePosition(point)
}

// Check whether auto face-focus function is supported and enable auto-face focus.
let isSupported = agoraKit.isCameraAutoFocusFaceModeSupported()
agoraKit.setCameraAutoFocusFaceModeEnabled(isSupported)

// Check whether manual focus function is supported and set the focus.
let isSupported = agoraKit.isCameraFocusPositionInPreviewSupported()

if isSupported {
    // Set the camera focus at (50, 100).
    let point = CGPoint(x: 50, y: 100)
    agoraKit.setCameraFocusPositionInPreview(point)
}


// The camera focus area is updated. You can monitor the update event and implement corresponding logic.
func rtcEngine(_ engine: AgoraRtcEngineKit, cameraExposureDidChangedToRect: CGRect) {
}

// The camera exposure area is updated. You can monitor the update event the implement corresponding logic.
func rtcEngine(_ engine: AgoraRtcEngineKit, cameraFocusDidChangedToRect: CGRect) {
}
```

```objective-c
// Objective-C
// Check whether exposure function is supported and enable exposure.
let isSuppported = [agoraKit isCameraExposurePositionSupported];

if (isSupported) {
    // Set the camera exposure at (50, 100).
    CGPoint *point = CGPointMake(50, 100);
    [agoraKit setCameraExposurePosition: point];
}

// Check whether auto face-focus function is supported and enable auto-face focus.
Bool isSupported = [agoraKit isCameraAutoFocusFaceModeSupported];
[agoraKit setCameraAutoFocusFaceModeEnabled: isSupported];

// Check whether manual focus function is supported and set the focus.
let isSupported = [agoraKit isCameraFocusPositionInPreviewSupported];

if (isSupported) {
    // Set the camera focus at (50, 100).
    CGPoint *point = CGPointMake(50, 100);
    [agoraKit setCameraFocusPositionInPreview: point];
}


// The camera focus area is updated. You can monitor the update event and implement corresponding logic.
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraExposureDidChangedToRect:(CGRect)rect {
}

// The camera exposure area is updated. You can monitor the update event the implement corresponding logic.
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraFocusDidChangedToRect:(CGRect)rect {
}
```

### API comparison table

The following table shows the API comparison table of Java and Objective-C languages.

|Java|Objective-C|
|----|-----------|
|`onCameraExposureAreaChanged`|`cameraFocusDidChangedToRect`|
|`isCameraFocusSupported`|`isCameraAutoFocusFaceModeSupported`|
|`isCameraFocusSupported`|`isCameraFocusPositionInPreviewSupported`|
|`onCameraFocusAreaChanged`|`cameraExposureDidChangedToRect`|


### API reference
- Java
    - [`isCameraExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)
    - [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)
    - [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a09f61f738cf7d8a1902761e03a7fa600)
    - [`setCameraAutoFocusModeEnabled`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7e67afe7ad0045448fe0bd97203afcee)
    - [`isCameraFocusSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e20f04ccecfc41aa23bf63116c9a8cd)
    - [`setCameraFocusPositionInPreview`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aba273e4337a760d883b6c7c1344183c0)
    - [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)
    - [`onCameraFocusAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7af6c96c4c35587a13d1e367255e3ec0)

- Objective-C
    - [`isCameraExposurePositionSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraExposurePositionSupported)
    - [`setCameraExposurePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraExposurePosition:)
    - [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraAutoFocusFaceModeSupported)
    - [`setCameraAutoFocusModeEnabled`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraAutoFocusFaceModeEnabled:)
    - [`isCameraFocusPositionInPreviewSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraFocusPositionInPreviewSupported)
    - [`setCameraFocusPositionInPreview`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraFocusPositionInPreview:)
    - [`cameraExposureDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraExposureDidChangedToRect:)
    - [`cameraFocusDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraFocusDidChangedToRect:)