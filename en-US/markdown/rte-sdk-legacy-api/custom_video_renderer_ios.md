The default Agora video module interacts seamlessly with the devices your app runs on. The SDK enables you to add specialized video features to your app using custom video renderers.

## Understand the tech

By default, SDK integrates the default video modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom video renderer. For example:

- Your app has its own video module.
- You want to use a pre-processing library for the video data.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the processing and display of video frames when using a custom video renderer, use methods from outside the Agora SDK.

The rotation parameter of the video frames in `renderPixelBuffer` or `renderRawData` may not be 0. This is probably due to the settings of video capturing, and you need to process the rotation information yourself.

## Prerequisites

Before implementing custom video rendering, ensure that you have implemented the raw video data function in your project. For details, see [Raw video Data](raw_audio_data_ios).

## Implementation

To implement a custom video renderer in your project, refer to the following steps.

1. Get the video data to play from `onCaptureVideoFrame`, `onScreenCaptureVideoFrame`, or `onRenderVideoFrame`.
2. Render and play the video data on your own.

## Reference

This section includes reference information about the function.

### Sample project

Agora provides the following open-source sample project on GitHub:
- [Custom video renderer](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomVideoRender/CustomVideoRender.swift)