---
title: 水印
platform: Linux C++
updatedAt: 2020-12-08 05:38:46
---

## 功能描述

在使用合流录制模式时，你可在录制视频文件中添加水印，如公司 logo、时间戳或特定文字信息，以实现防伪、版权声明、宣传或记录等目的。

录制 SDK 支持文字、动态时间戳和静态图片三种水印，你可按需选择。

- 文字水印：使用一段文字作为水印，可设置文字的字体和字号。
- 动态时间戳水印：使用录制服务器的当前时间作为水印，显示形式为“2019:06:18 14:30:35"。
- 静态图片水印：使用一张本地 PNG 图片作为水印。

> 录制 SDK 自 v2.8.0 起支持水印功能。

## 设置水印

`wm_num` 参数设置水印的总个数。最多可设 15 个水印，其中文字水印最多 10 个，时间戳水印最多 1 个，图片水印最多 4 个。

wm_configs 为水印具体设置，是由多个 `WatermarkConfig` 组成的数组。一个 `WatermarkConfig` 对应一个水印。`WatermarkConfig` 的个数需与 `wm_num` 参数中设置的水印个数保持一致。

`WatermarkConfig` 中，通过 `type` 参数指定水印类型，通过 `config` 参数定义该类型水印的具体设置。

### 文字水印

添加文字水印时，将 `type` 设置为 `WATERMARK_TYPE_LITERA`，同时必须设置 `config` 中的 `wm_litera` 参数添加文字内容。此外，你可以设置 `config` 中的 `font_size` 和 `font_file_path` 参数设置字号和指定字体文件路径。如不设置，字号默认值为 10 (相当于 144 DPI 设备上的 10 x 15 磅），字体默认为 NotoSansMonoCJKsc-Regular。

### 时间戳水印

添加时间戳水印时，将 `type` 设置为 `WATERMARK_TYPE_TIMESTAMP`。此外，你可以设置 `config` 中的 `font_size` 参数设置时间戳的字号，默认值为 10（相当于 144 DPI 设备上的 10 x 15 磅）。

### 图片水印

添加图片水印时，将 `type` 设置为 `WATERMARK_TYPE_LITERA`，同时必须设置 `config` 中的 `image_path` 指定图片路径，仅支持本地 PNG 图片。

### 设置水印大小和位置

无论添加哪种水印，你都必须通过 `config` 中的 `offset_x`，`offset_y`，`wm_width`，`wm_height` 四个参数设置水印的水平位置、垂直位置、宽度、高度。

![](https://web-cdn.agora.io/docs-files/1564471864622)

如上图所示，以**视频画布左上角**为原点，`offset_x` 和 `offset_y` 分别代表**水印框左上角**到原点的水平距离和垂直距离，`wm_width` 和 `wm_height` 分别代表水印框的**宽度**和**高度**。这四个参数均为绝对值，单位为像素，默认值为 0。

## 添加水印

你可通过以下方法在录制文件中添加水印：

- 在调用 `setVideoMixingLayout` 方法设置合流布局时，设置 `wm_num` 和 `wm_configs` 参数添加水印。
- 直接调用 `updateWatermarkConfigs` 方法，设置 `wm_num` 和 `configs` 参数添加水印。

## 更新和删除水印

调用 `setVideoMixingLayout` 或 `updateWatermarkConfigs` 方法均可更改水印的个数和具体设置，也可删除已添加的水印。

举例来说，假设视频中已有 1 个图片水印和 1 个文字水印。如想删除文字水印，可以将 `wm_num` 改为 1，传入原先的图片水印的设置，再调用 `updateWatermarkConfigs` 方法。

**注意**：如想删除全部已添加的水印，只能调用 `updateWatermarkConfigs` 方法，将 `wm_num` 设为 0，`configs` 设置为空。调用 `setVideoMixingLayout` 更新合流布局时，如果没有水印信息， 即不对水印进行任何修改，因此不能删除所有已添加的水印。

## 示例代码

以下示例代码设置了 3 个水印：1 个图片水印，1 个时间戳水印，1 个文字水印。

```cpp
agora::linuxsdk::VideoMixingLayout layout;

//TO DO: Set other video mixing layout configuration here.

//Watermark configuration.
agora::linuxsdk::WatermarkConfig config[3];
config[0].type = agora::linuxsdk::WATERMARK_TYPE_IMAGE;
config[0].config.image.image_path = "path-to-image.png";
config[0].config.image.offset_x = 20;
config[0].config.image.offset_y = 20;
config[0].config.image.wm_width = 200;
config[0].config.image.wm_height = 300;

config[1].type = agora::linuxsdk::WATERMARK_TYPE_TIMESTAMP;
config[1].config.timestamp.font_size = 10;
config[1].config.timestamp.offset_x = 20;
config[1].config.timestamp.offset_y = 400;
config[1].config.timestamp.wm_width = 200;
config[1].config.timestamp.wm_height = 20;

config[2].type = agora::linuxsdk::WATERMARK_TYPE_LITERA;
config[2].config.litera.font_size = 10;
config[2].config.litera.wm_litera = "test watermark";
config[2].config.litera.font_file_path = "path-to-font-file.otf";
config[2].config.litera.offset_x = 20;
config[2].config.litera.offset_y = 500;
config[2].config.litera.wm_width = 200;
config[2].config.litera.wm_height = 20;

layout.wm_num = 3;
layout.wm_configs = config;

int res = m_enigne->setVideoMixingLayout(layout);
```

## API 参考

- [`setVideoMixingLayout`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/recording_cpp/v2.8.0/classagora_1_1recording_1_1_i_recording_engine.html?transId=2.8.0#a4ac28b9e2342729c1b54400a5abb1d90)
- [`updateWatermarkConfigs`](https://docs-preview.agoralab.co/cn/Video/API%20Reference/recording_cpp/v2.8.0/classagora_1_1recording_1_1_i_recording_engine.html?transId=2.8.0#ac9431f0003db4f1d123dab8b4cc39202)
