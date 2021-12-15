---
title: 如何设置推流组件的镜像模式？
platform: ["Android", "iOS"]
updatedAt: 2021-02-23 08:56:59
Products: ["Interactive Broadcast"]
---

## Android

Agora 推流组件提供多种场景下的镜像模式：

- 本地主播看自己的视频镜像：这种镜像指本地预览的视频为镜像，你可以通过 `VideoPreviewRender` 类中的 [`setMirrorMode`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/rsk_java/interfaceio_1_1agora_1_1streaming_1_1_video_preview_renderer.html#a5eaf09fd62ebb1e405053aeb55bba0da) 方法实现。
- 观众等其他远端用户看本地主播的视频镜像：这种镜像指本地发送的视频为镜像，你可以通过 `StreamingKit` 类中的 [`create`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/rsk_java/classio_1_1agora_1_1streaming_1_1_streaming_kit.html#a4b82d6738edce98630aa36124784ccd3) 方法实现。

`setMirrorMode` 设置的镜像模式会受到 `create` 设置的镜像模式的影响，详见下表。

本地主播设备摄像头方向前置：

| `create` 的 `mirrorMode` 值 | `setMirrorMode` 的 `mirrorMode` 值 | 本地预览的视频效果 | 本地发送的视频效果 |
| :-------------------------- | :--------------------------------- | :----------------- | :----------------- |
| `DISABLED`                  | `AUTO`                             | 镜像               | 正常               |
| `DISABLED`                  | `ENABLED`                          | 镜像               | 正常               |
| `DISABLED`                  | `DISABLED`                         | 正常               | 正常               |
| `ENABLED`                   | `AUTO` 或 `ENABLED` 或 `DISABLED`  | 镜像               | 镜像               |
| `AUTO`                      | `AUTO` 或 `ENABLED` 或 `DISABLED`  | 镜像               | 镜像               |

本地主播设备摄像头方向后置：

| `create` 的 `mirrorMode` 值 | `setMirrorMode` 的 `mirrorMode` 值 | 本地预览的视频效果 | 本地发送的视频效果 |
| :-------------------------- | :--------------------------------- | :----------------- | :----------------- |
| `DISABLED`                  | `AUTO`                             | 正常               | 正常               |
| `DISABLED`                  | `ENABLED`                          | 镜像               | 正常               |
| `DISABLED`                  | `DISABLED`                         | 正常               | 正常               |
| `ENABLED`                   | `AUTO` 或 `ENABLED` 或 `DISABLED`  | 镜像               | 镜像               |
| `AUTO`                      | `AUTO`                             | 正常               | 正常               |
| `AUTO`                      | `ENABLED`                          | 镜像               | 正常               |
| `AUTO`                      | `DISABLED`                         | 正常               | 正常               |

## iOS

Agora 推流组件提供多种场景下的镜像模式：

- 本地主播看自己的视频镜像：这种镜像指本地预览的视频为镜像，你可以通过 `AgoraVideoPreviewRenderer` 类中的 [`setMirrorMode`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/rsk_oc/Classes/AgoraVideoPreviewRenderer.html#//api/name/setMirrorMode:) 方法实现。
- 观众等其他远端用户看本地主播的视频镜像：这种镜像指本地发送的视频为镜像，你可以通过 `AgoraStreamingKit` 类中的 [`sharedStreamingKitWithContext`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/rsk_oc/Classes/AgoraStreamingKit.html#//api/name/sharedStreamingKitWithContext:) 方法实现。

`setMirrorMode` 设置的镜像模式会受到 `sharedStreamingKitWithContext` 设置的镜像模式的影响，详见下表。

本地主播设备摄像头方向前置：

| `sharedStreamingKitWithContext` 的 `mirrorMode` 值 | `setMirrorMode` 的 `mirrorMode` 值 | 本地预览的视频效果 | 本地发送的视频效果 |
| :------------------------------------------------- | :--------------------------------- | :----------------- | :----------------- |
| `Disabled`                                         | `Auto`                             | 镜像               | 正常               |
| `Disabled`                                         | `Enabled`                          | 镜像               | 正常               |
| `Disabled`                                         | `Disabled`                         | 正常               | 正常               |
| `Enabled`                                          | `Auto` 或 `Enabled` 或 `Disabled`  | 镜像               | 镜像               |
| `Auto`                                             | `Auto` 或 `Enabled` 或 `Disabled`  | 镜像               | 镜像               |

本地主播设备摄像头方向后置：

| `sharedStreamingKitWithContext` 的 `mirrorMode` 值 | `setMirrorMode` 的 `mirrorMode` 值 | 本地预览的视频效果 | 本地发送的视频效果 |
| :------------------------------------------------- | :--------------------------------- | :----------------- | :----------------- |
| `Disabled`                                         | `Auto`                             | 正常               | 正常               |
| `Disabled`                                         | `Enabled`                          | 镜像               | 正常               |
| `Disabled`                                         | `Disabled`                         | 正常               | 正常               |
| `Enabled`                                          | `Auto` 或 `Enabled` 或 `Disabled`  | 镜像               | 镜像               |
| `Auto`                                             | `Auto`                             | 正常               | 正常               |
| `Auto`                                             | `Enabled`                          | 镜像               | 正常               |
| `Auto`                                             | `Disabled`                         | 正常               | 正常               |
