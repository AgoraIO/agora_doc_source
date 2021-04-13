---
title: Watermark
platform: Linux Java
updatedAt: 2020-12-08 05:52:54
---
## Overview

In **Composite Recording** mode, you can add watermarks to the video, such as a logo, timestamp, or text, for anti-counterfeiting, copyright protection, promotion, or recording.

The On-premise Recording SDK supports three types of watermarks: 

- Text watermarks: Use text as the watermark. You can specify the font size of the text.
- Timestamp watermarks: Use a dynamic timestamp which shows the current time of the recording server (such as "2019:06:18 14:30:35") as the watermark. You can specify the font size of the timestamp.
- Image watermark: Use a PNG image as the watermark. The image is displayed at a fixed position on the video.

> The On-premise Recording SDK v2.8.0 and later support watermarks.

## Configure watermarks

### Text watermarks

Set the `literalWms` parameter to add a text watermark. You can specify multiple `LiteraWatermarkConfig` objects in the `literalWms` parameter. 

A `LiteraWatermarkConfig` object contains the following parameters:

- Set wmLitera to add the text in the string format. The default font of the text is NotoSansMonoCJKsc-Regular.
- Set `font_size `to specify the font size of the text. If not specified, the default font size is 10, which equals to 10 x 15 points at 144 dpi.
- Set `offsetX`, `offsetY`,  `wmWidth`, and `wmHeight` to [specify the position and size of the watermark rectangle](#size).

> The Recording SDK supports up to ten text watermarks. 

### Timestamp watermarks

Set the `timestampWms` parameter to add a timestamp watermark. You can specify a `TimestampWatermarkConfig` object in the `timestampWms` parameter.

A `TimestampWatermarkConfig` object contains the following parameters:

- Set `font_size` to specify the font size of the timestamp.
- Set `offsetX`,  `offsetY`,  `wmWidth`, and `wmHeight` to [specify the position and size of the watermark rectangle](#size).

> The Recording SDK only supports one timestamp watermark. 

### Image watermarks

Set the `imageWms` parameter to add an image watermark.  You can specify multiple `ImageWatermarkConfig` objects in the `imageWms` parameter. 

An `ImageWatermarkConfig` object contains the following parameters:

- Set the `image_path` parameter in config to specify the path of the image. The Recording SDK only supports PNG images.
- Set `offsetX`, `offsetY`, `wmWidth`, and `wmHeight` to [specify the position and size of the watermark rectangle](#size).

> - The Recording SDK supports up to four image watermarks. 

### <a name="size"></a>Specify the size and position of a watermark rectangle

No matter what type of watermark you want to add, you must set the `offsetX`, `offsetY`, `wmWidth`, and `wmHeight` parameters to specify the horizontal position, vertical position, width, and height of the watermark rectangle.

![](https://web-cdn.agora.io/docs-files/1564742707814)

As shown in the figure above, we set the upper left corner of the video canvas as the origin. The `offsetX` and `offsetY` parameters define the position of the watermark rectangle on the canvas, representing the horizontal and vertical distances between the upper left corner of the rectangle and the origin respectively. The `wmWidth` and `wmHeight` parameters define the width and height of the rectangle. The `offsetX, ``offsetY, ``wmWidth, and ``wmHeight` parameters are absolute values in pixels. The default value is 0.

## Add watermarks 

You can add watermarks to the recorded video in the following ways:

- Set the `literalWms, timestampWms,` or `imageWms` parameters when calling the `setVideoMixingLayout` method.
- Set the `literaWms`, `timestampWms`, or `imgWms` parameters when calling the `updateWatermarkConfigs` method.

## Update and delete watermarks

You can call the `setVideoMixingLayout` or `updateWatermarkConfigs` methods to update the configuration of the watermarks and also to delete them.

For example, if you have added an image watermark and a text watermark and you want to delete the text watermark, you can delete the configuration of the text watermark, pass in the configuration of the original image watermark, and then call the `setVideoMixingLayout`  or `updateWatermarkConfigs` method.

Note that if you want to delete all the watermarks that you have added, you must call the `updateWatermarkConfigs` method and set the `literaWms`, `timestampWms,` and `imgWms parameters` as null. If you call the `setVideoMixingLayout` method and do not set the `literalWms, timestampWms,` or `imageWms` parameters, the On-premise Recording SDK will not change the watermarks. 

## Sample code

The following Java sample code shows how to add an image watermark, a timestamp watermark, and a text watermark by calling the `setVideoMixingLayout` method.

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

## API Reference

- [`setVideoMixingLayout`](./API%20Reference/recording_java/v2.8.0/classio_1_1agora_1_1recording_1_1_recording_s_d_k.html?transId=2.8.0#a5834d23933d66ff7a5555b0de22c4313)
- [`updateWatermarkConfigs`](./API%20Reference/recording_java/v2.8.0/classio_1_1agora_1_1recording_1_1_recording_s_d_k.html?transId=2.8.0#a88eb63ddbae307480770c4376444d473)