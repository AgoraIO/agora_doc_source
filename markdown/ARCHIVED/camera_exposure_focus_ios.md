---
title: 摄像头曝光与对焦
platform: iOS
updatedAt: 2020-04-16 15:11:46
---
## 功能描述

视频场景中，经常会使用到摄像头曝光和对焦的功能，帮助被拍摄物成像清晰、亮度适宜。
Agora SDK 在移动平台提供整套的摄像头管理方法，方便用户切换前后摄像头，并对摄像头的缩放、对焦和曝光进行设置。

- 曝光：支持手动选择曝光区域，摄像头自动曝光。
- 对焦：支持人脸自动对焦和手动对焦。

## 实现方法

在实现摄像头曝光与对焦功能前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始视频通话](start_call_ios)或[视频互动直播](start_live_ios)。

参考如下步骤，在你的项目中实现摄像头曝光与对焦功能：

- **实现曝光功能**

  调用 `isCameraExposurePositionSupported` 方法检测设备是否支持曝光，如果支持则调用 `setCameraExposurePosition` 方法设置手动曝光位置。

  如果你想获取摄像头曝光位置，可以在 `cameraFocusDidChangedToRect` 回调中实现。

- **实现人脸自动对焦功能**

  调用 `isCameraAutoFocusFaceModeSupported` 方法检测设备是否支持人脸对焦功能，如果支持则调用 `setCameraAutoFocusModeEnabled` 方法设置开启该功能。

- **实现手动对焦功能**

  调用 `isCameraFocusPositionInPreviewSupported` 方法检测设备是否支持手动对焦功能，如果支持则调用 `setCameraFocusPositionInPreview` 方法设置手动对焦位置并触发对焦。

  如果你想获取摄像头对焦位置，可以在 `cameraExposureDidChangedToRect` 回调中实现。

### 示例代码

```swift
//Swift
// 测当前设备是否支持曝光并手动设置曝光区域
  let isSupported = agoraKit.isCameraExposurePositionSupported()

if isSupported {
    // 假设在屏幕(50，100)的位置曝光
    let point = CGPoint(x: 50, y: 100)
    agoraKit.setCameraExposurePosition(point)
}

// 检测当前设备是否支持人脸自动对焦并设置
let isSupported = agoraKit.isCameraAutoFocusFaceModeSupported()
agoraKit.setCameraAutoFocusFaceModeEnabled(isSupported)

// 检测当前设备是否支持手动对焦功能并设置
let isSupported = agoraKit.isCameraFocusPositionInPreviewSupported()

if isSupported {
    // 假设在屏幕（50，100）的位置对焦
    let point = CGPoint(x: 50, y: 100)
    agoraKit.setCameraFocusPositionInPreview(point)
}


// 曝光区域更新。你可以在这里监听到曝光更新事件，并进行自己的逻辑处理
func rtcEngine(_ engine: AgoraRtcEngineKit, cameraExposureDidChangedToRect: CGRect) {
}

// 对焦区域更新。你可以在这里监听到焦点更新事件，并进行自己的逻辑处理
func rtcEngine(_ engine: AgoraRtcEngineKit, cameraFocusDidChangedToRect: CGRect) {
}
```

```objective-c
//Objective-C
// 测当前设备是否支持曝光并手动设置曝光区域
let isSuppported = [agoraKit isCameraExposurePositionSupported];

if (isSupported) {
    // 假设在屏幕(50，100)的位置曝光
    CGPoint *point = CGPointMake(50, 100);
    [agoraKit setCameraExposurePosition: point];
}

// 检测当前设备是否支持人脸自动对焦并设置
Bool isSupported = [agoraKit isCameraAutoFocusFaceModeSupported];
[agoraKit setCameraAutoFocusFaceModeEnabled: isSupported];

// 检测当前设备是否支持手动对焦功能并设置
let isSupported = [agoraKit isCameraFocusPositionInPreviewSupported];

if (isSupported) {
    // 假设在屏幕（50，100）的位置对焦
    CGPoint *point = CGPointMake(50, 100);
    [agoraKit setCameraFocusPositionInPreview: point];
}


// 曝光区域更新。你可以在这里监听到曝光更新事件，并进行自己的逻辑处理
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraExposureDidChangedToRect:(CGRect)rect {
}

// 对焦区域更新。你可以在这里监听到焦点更新事件，并进行自己的逻辑处理
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraFocusDidChangedToRect:(CGRect)rect {
}
```

### API 参考

- [`isCamerExposurePositionSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraExposurePositionSupported)
- [`setCameraExposurePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraExposurePosition:)
- [`isCameraAutoFocusFaceModeSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraAutoFocusFaceModeSupported)
- [`setCameraAutoFocusModeEnabled`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraAutoFocusFaceModeEnabled:)
- [`isCameraFocusPositionInPreviewSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraFocusPositionInPreviewSupported)
- [`setCameraFocusPositionInPreview`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraFocusPositionInPreview:)
- [`cameraExposureDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraExposureDidChangedToRect:)
- [`cameraFocusDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraFocusDidChangedToRect:)