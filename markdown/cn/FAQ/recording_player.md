---
title: 录制生成的文件支持哪些播放器？
platform: ["Linux"]
updatedAt: 2020-07-09 21:11:23
Products: ["Recording"]
---
根据选择的录制模式不同，在录制结束后生成的录制文件也不一样。

- 在单流录制模式下，会生成每个用户的音频文件和视频文件，通常需要[使用转码脚本](/cn/Recording/recording_merge_files)将这些文件合成为一个 MP4 文件播放。

- 在合流录制模式下，如果 `mixedVideoAudio` 参数设置为 `0`，会生成一个包含所有用户音频的文件和一个包含所有用户视频的文件，也同样需要使用转码脚本将音频文件和视频文件合成为一个 MP4 文件。因此我们推荐合流录制时将 `mixedVideoAudio` 参数设置为 `2`，这样可以直接录制得到一个 MP4 文件。

下面列出转码后的录制文件、`mixedVideoAudio` 设为 `1` 得到的录制文件以及 `mixedVideoAudio` 设为 `2` 得到的录制文件在各个平台对播放器的支持。

> 转码后的录制文件包括：
> - 单流模式的录制文件转码合成的 MP4 文件。
> - 合流模式下，将 `mixedVideoAudio` 参数设置为 `0` 得到的录制文件转码合成的 MP4 文件。

| 平台    | 播放器/浏览器           | 转码后文件 | mixedVideoAudio=1 | mixedVideoAudio=2 |
| ------- | ----------------------- | ---------- | ----------------- | ----------------- |
| Linux   | VLC Media Player        | 支持       | 支持              | 支持              |
| Linux   | FFplay                | 支持       | 支持              | 支持              |
| Linux   | Chrome                  | **不支持** | **不支持**        | **不支持**        |
| Windows | Media Player            | 支持       | **不支持**        | 支持              |
| Windows | KM Player               | 支持       | 支持              | 支持              |
| Windows | VLC Player              | 支持       | 支持              | 支持              |
| Windows | Chrome (49.0.2623+)     | 支持       | 支持              | 支持              |
| macOS   | QuickTime Player        | 支持       | 支持              | 支持              |
| macOS   | VLC                     | **不支持** | **不支持**        | **不支持**        |
| macOS   | Movist                  | 支持       | 支持              | 支持              |
| macOS   | MPlayerX                | 支持       | 支持              | 支持              |
| macOS   | KM Player               | **不支持** | **不支持**        | **不支持**        |
| macOS   | Chrome (47.0.2526.111+) | 支持       | 支持              | 支持              |
| macOS   | Safari (11.0.3+)        | 支持       | 支持              | 支持              |
| iOS     | Default Player          | 支持       | 支持              | 支持              |
| iOS     | VLC for Mobile          | **不支持** | **不支持**        | 支持              |
| iOS     | KM Player               | 支持       | 支持              | 支持              |
| iOS     | Safari (9.0+)           | 支持       | 支持              | 支持              |
| Android | Default Player          | 支持       | 支持              | 支持              |
| Android | MX Player               | 支持       | 支持              | 支持              |
| Android | VLC for Android         | 支持       | 支持              | 支持              |
| Android | KM Player               | 支持       | 支持              | 支持              |
| Android | Chrome (49.0.2623+)     | 支持       | 支持              | 支持              |