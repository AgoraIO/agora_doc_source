---
title: 水印
platform: Linux Java
updatedAt: 2020-12-08 05:42:27
---

## 功能描述

在使用合流录制模式时，你可在录制视频文件中添加水印，如公司 logo、时间戳或特定文字信息，以实现防伪、版权声明、宣传或记录等目的。

录制 SDK 支持文字、动态时间戳和静态图片三种水印，你可按需选择。

- 文字水印：使用一段文字作为水印，可设置文字的字号。
- 动态时间戳水印：使用录制服务器的当前时间作为水印，显示形式为“2019:06:18 14:30:35"。
- 静态图片水印：使用一张本地 PNG 图片作为水印。

> 录制 SDK 自 v2.8.0 起支持水印功能。

## 设置水印

### 文字水印

通过 `literalWms` 参数设置文字水印。`literaWms` 是由多个 `LiteraWatermarkConfig` 组成的数组，一个 `LiteraWatermarkConfig` 对应一个文字水印，最多可添加 10 个文字水印。

`LiteraWatermarkConfig` 中包含以下设置：

- 设置 `wmLitera` 参数添加文字内容。可添加中英文字符。支持换行符和自动换行。字体默认为 NotoSansMonoCJKsc-Regular。
- 设置 `fontSize` 参数指定文字的字号。如不设置，字号默认值为 10 （相当于 144 DPI 设备上的 10 x 15 磅）。
- 通过 `offsetX`，`offsetY`，`wmWidth`，`wmHeight` 四个参数设置水印的水平位置、垂直位置、宽度、高度，详见[设置水印大小和位置](#size)。

### 时间戳水印

通过 `timestampWms` 参数设置时间戳水印。`timestampWms` 是由 `TimestampWatermarkConfig` 组成的数组，一个 `TimestampWatermarkConfig` 对应一个时间戳水印。时间戳水印只能添加 1 个。

`TimestampWatermarkConfig` 中包含以下设置：

- 设置 `fontSize` 参数指定时间戳的字号。如不设置，字号默认值为 10 （相当于 144 DPI 设备上的 10 x 15 磅）。
- 通过 `offsetX`，`offsetY`，`wmWidth`，`wmHeight` 四个参数设置水印的水平位置、垂直位置、宽度、高度，详见[设置水印大小和位置](#size)。

### 图片水印

通过 `imageWms` 参数设置图片水印。`imageWms` 是由多个 `ImageWatermarkConfig` 组成的数组，一个 `ImageWatermarkConfig` 对应一个时间戳水印，最多可添加 4 个图片水印。

`ImageWatermarkConfig` 中包含以下设置：

- 设置 `imagePath` 参数指定图片路径，仅支持本地 PNG 图片。
- 通过 `offsetX`，`offsetY`，`wmWidth`，`wmHeight` 四个参数设置水印的水平位置、垂直位置、宽度、高度，详见[设置水印大小和位置](#size)。

### <a name= "size"></a>设置水印大小和位置

无论添加哪种水印，你都必须通过 `offsetX`，`offsetY`，`wmWidth`，`wmHeight` 四个参数设置水印的水平位置、垂直位置、宽度、高度。

如上图所示，以**视频画布左上角**为原点，`offsetX` 和 `offsetY` 分别代表**水印框左上角**到原点的水平距离和垂直距离，`wmWidth` 和 `wmHeight` 分别代表水印框的**宽度**和**高度**。这四个参数均为绝对值，单位为像素，默认值为 0。

## 添加、修改和删除水印

你可通过以下方法添加、修改和删除水印：

- 调用 `setVideoMixingLayout` 方法设置合流布局时，设置 `literalWms`、`timestampWms` 和 `imageWms` 参数分别添加或修改文字水印、时间戳水印或图片水印；
- 直接调用 `updateWatermarkConfigs` 方法设置 `literaWms` 、`timestampWms` 和 `imgWms` 参数分别添加或修改文字水印、时间戳水印或图片水印。

注意：如想删除全部已添加的水印，只能调用 `updateWatermarkConfigs` 方法。调用 `setVideoMixingLayout` 更新合流布局时，如果没有水印信息， 即不对水印进行任何修改，因此不能删除所有已添加的水印。

## 示例代码

以下 Java 示例代码演示了如何调用 `setVideoMixingLayout` 方法设置 `literalWms`、`timestampWms` 和 `imageWms` 参数添加 3 个水印：1 个图片水印，1 个时间戳水印，1 个文字水印。

```java
/*
 * RecordingSDKInstance is the instance of the RecordingSDK class.
 */
Common ei = new Common();
Common.VideoMixingLayout layout = ei.new VideoMixingLayout();
layout.timestampWms = new TimestampWatermarkConfig[1];
layout.timestampWms[0] = ei.new TimestampWatermarkConfig();
layout.timestampWms[0].fontSize = 10;
layout.timestampWms[0].offsetX = 10;
layout.timestampWms[0].offsetY = 110;
layout.timestampWms[0].wmWidth = 200;
layout.timestampWms[0].wmHeight = 100;
layout.literalWms = new LiteraWatermarkConfig[1];
layout.literalWms[0] = ei.new LiteraWatermarkConfig();
layout.literalWms[0].wmLitera = "hello world";
layout.literalWms[0].fontSize = 10;
layout.literalWms[0].offsetX = 10;
layout.literalWms[0].offsetY = 10;
layout.literalWms[0].wmWidth = 300;
layout.literalWms[0].wmHeight = 100;
layout.imageWms = new ImageWatermarkConfig[1];
layout.imageWms[0] = ei.new ImageWatermarkConfig();
layout.imageWms[0].imagePath = "path-to-test.png";
layout.imageWms[0].offsetX = 10;
layout.imageWms[0].offsetY = 220;
layout.imageWms[0].wmWidth = 400;
layout.imageWms[0].wmHeight = 400;
RecordingSDKInstance.setVideoMixingLayout(layout);
```

## API 参考

- [`setVideoMixingLayout`](./API%20Reference/recording_java/v2.8.0/classio_1_1agora_1_1recording_1_1_recording_s_d_k.html?transId=2.8.0#a5834d23933d66ff7a5555b0de22c4313)
- [`updateWatermarkConfigs`](./API%20Reference/recording_java/v2.8.0/classio_1_1agora_1_1recording_1_1_recording_s_d_k.html?transId=2.8.0#a88eb63ddbae307480770c4376444d473)
