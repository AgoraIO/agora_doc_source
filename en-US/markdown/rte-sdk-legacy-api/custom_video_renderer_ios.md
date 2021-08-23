This article introduces how to use the methods provided by the Agora SDK to implement custom video rendering to meet your needs.

## Understand the tech

The Agora SDK uses default video modules for rendering in real-time communications.
However, these modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own video module.
- You want to use a pre-processing library for the video data.
- You need flexible device resource allocation to avoid conflicts with other services.

## Prerequisites

Before implementing custom video rendering, ensure that you have implemented the raw video data function in your project. For details, see [Raw video Data](raw_audio_data_android).
## Implementation

### Implement the workflow

1. Get the video data to play from `onCaptureVideoFrame`, `onScreenCaptureVideoFrame`, or `onRenderVideoFrame`.
2. Render and play the video data on your own.

## Reference

### Sample project

Agora provides the following open-source sample project on GitHub:
- [Custom video renderer](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomVideoRender/CustomVideoRender.swift)