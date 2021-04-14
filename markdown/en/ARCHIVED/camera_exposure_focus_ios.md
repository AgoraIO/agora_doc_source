---
title: Camera Exposure and Focus
platform: iOS
updatedAt: 2020-07-06 16:19:41
---
## Introduction

Camera exposure and focus are commonly used in video calls to enable high-quality video capture. Agora SDK provides a set of camera management methods on the iOS platform, with which you can switch between the front and rear camera, set the camera zoom factor, set the exposure region and set the focus position.

- Camera exposure: Auto exposure is supported where users can maually set the exposure region.
- Camera focus: Auto face-focus and manual focus are supported.

## Implementation

Before proceeding, ensure that you implement a basic video call or live broadcast in your project. See [Start a Call](start_call_ios)/[Start a Live Broadcast](start_live_ios) for details.

Refer to the following steps to set the camera exposure and focus:

- **Exposure**
Call the `isCameraExposurePositionSupported` method to check whether exposure function is supported. If it is supported, call the `setCameraExposurePosition` method to set the camera exposure.
You can monitor the exposure position with the `cameraFocusDidChangedToRect` callback.
- **Auto face-focus**
Call the `isCameraAutoFocusFaceModeSupported` method to check whether auto face-focus function is supported. If it is supported, call the `setCameraAutoFocusModeEnabled` method to set the focus.
- **Manual focus**
Call the `isCameraFocusPositionInPreviewSupported` method to check whether manual focus function is supported. If it is supported, call the `setCameraFocusPositionInPreview` method to set the focus.
You can monitor the focus position with the `cameraExposureDidChangedToRect` callback.

### Sample code

```swift
//Swift
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
//Objective-C
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

### API Reference

- [`isCamerExposurePositionSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraExposurePositionSupported)
- [`setCameraExposurePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraExposurePosition:)
- [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraAutoFocusFaceModeSupported)
- [`setCameraAutoFocusModeEnabled`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraAutoFocusFaceModeEnabled:)
- [`isCameraFocusPositionInPreviewSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraFocusPositionInPreviewSupported)
- [`setCameraFocusPositionInPreview`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraFocusPositionInPreview:)
- [`cameraExposureDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraExposureDidChangedToRect:)
- [`cameraFocusDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraFocusDidChangedToRect:)