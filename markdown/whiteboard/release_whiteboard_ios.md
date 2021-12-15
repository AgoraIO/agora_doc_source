---
title: 发版说明
platform: iOS
updatedAt: 2021-04-01 02:52:23
---

本文提供 Agora 互动白板 SDK 的发版说明。

## 2.12.8 版

该版本于 2021 年 3 月 30 日发布。

该版本更新 `@netless/iframe-bridge` 至 2.0.7。

## 2.12.7 版

该版本于 2021 年 3 月 30 日发布。

该版本更新 `white-web-sdk` 至 2.12.6。

## 2.12.6 版

该版本于 2021 年 3 月 25 日发布。

该版本更新 `@netless/iframe-bridge` 至 2.0.5，优化了白板回放时 H5 课件的展示。

## 2.12.5 版

该版本于 2021 年 3 月 25 日发布。

该版本在 `Displayer` 类中新增 `scaleIframeToFit` 方法，支持等比例缩放视角，以保证完整显示 H5 课件的内容。

## 2.12.4 版

该版本于 2021 年 3 月 24 日发布。

该版本更新 `@netless/cursor-tool` 至 0.0.7。

## 2.12.3 版

该版本于 2021 年 3 月 20 日发布。

为解决笔锋效果与 2.2.12 之前版本 SDK 不兼容的问题，该版本将 `WhiteRoomConfig` 接口中的 `disableNewPencil` 属性设为 `false`，以默认关闭笔锋效果。

<div class="alert note">为正常显示笔迹，在开启笔峰效果前，请确保该房间内的所有用户使用如下 SDK：

- Android SDK 2.12.3 版或之后
- iOS SDK 2.12.3 版或之后
- Web SDK 2.12.5 版或之后</div>

## 2.12.2 版

该版本于 2021 年 3 月 16 日发布。

#### 新增特性

为优化笔迹显示，该版本新增笔锋效果。你可以通过 `WhiteRoomConfig` 接口中的 `disableNewPencil` 属性关闭或开启笔锋功能。

<div class="alert note">为正常显示笔迹，在开启笔峰效果前，请确保该房间内的所有用户使用如下 SDK：

- Android SDK 2.12.2 版或之后
- iOS SDK 2.12.2 版或之后
- Web SDK 2.12.5 版或之后</div>

#### 改进

- 更新 `white-web-sdk` 至 2.12.4 版本，优化 PPT 显示逻辑。
- 优化音视频插件在白板回放时的按钮显示。
