---
title: 设置合流布局
platform: Linux
updatedAt: 2020-09-30 15:42:18
---
## 功能描述
在使用合流录制模式时，你需要设置频道内所有发流用户视窗的大小及其在视频画布上的位置，进行合流布局。

下图为合流后的视频示例。我们将视频的背景称为**画布**，每个发流用户占据一个**视窗**。

![](https://web-cdn.agora.io/docs-files/1577694882339)

>  如果原视频的宽高比和布局中用户视窗的宽高比不一致，可能出现裁剪或压缩。用户视窗的宽高比取决于视频画布的长宽比以及合流布局方式。


Agora 本地服务端录制支持两种合流布局的方式：
- 选择预设的合流布局样式：如果你通过命令行进行录制，Agora 本地服务端录制的 demo 提供悬浮布局、自适应布局和垂直布局三种预设的布局样式。你只需选择其中一种样式，就能实现预设的布局效果。
- 自定义合流布局：如果你调用 API 进行录制，你可以灵活设置用户画面的大小，指定用户画面在视频画布上的相对位置。

## 选择预设的合流布局样式
### 实现方法

在命令行中开始录制时设置 `--isMixingEnabled 1` 使用合流模式，同时设置 `--layoutMode` 参数选择一种布局：
- `--layoutMode 0`  使用[悬浮布局](#float)（默认）。第一个加入频道的用户在画布上会显示为大视窗，铺满整个画布；其他用户按照加入的顺序从画布左下角开始依次水平排列，显示为小视窗，最多 4 行，每行 4 个视窗。小视窗会悬浮在大视窗上面。最多支持共 17 个用户视窗。
- `--layoutMode 1` 使用[自适应布局](#bestfit)。用户视窗平铺在画布上。根据用户的数量自动调整每个用户视窗的大小，每个用户视窗的大小一致。最多支持 17 个用户视窗。
- `--layoutMode 2` 使用[垂直布局](#vertical)。指定一个用户在画布左侧显示大视窗，其他用户的小视窗在右侧垂直排列，最多两列，每列最多 8 个视窗。最多支持共 17 个用户视窗。

### <a name="float"></a>悬浮布局

默认布局方式。小视窗会悬浮在大视窗上面。第一个加入频道的用户在屏幕上会显示为大视窗，铺满整个画布，其他用户按照加入的顺序从屏幕左下角开始依次水平排列显示小视窗，最多 4 行，每行 4 个视窗。

对于悬浮布局，有以下注意事项：

- 如果某用户只发送音频，仍然会占据布局位，显示大视窗。
- 如果实际视频流的宽高比与视窗的宽高比不一致，视频视窗会裁剪以适配视窗的大小。
- 每个小视窗的宽和高分别为整个画布宽和高的 0.235，相邻小视窗的左右和上下间距分别为整个画布宽和高的 0.012。小视窗距离画布的水平和垂直边距也分别为整个画布宽和高的 0.012。

不同人数下实际布局效果如下图所示。

![](https://web-cdn.agora.io/docs-files/1577695077045)

![](https://web-cdn.agora.io/docs-files/1577695087376)

![](https://web-cdn.agora.io/docs-files/1577696102687)

### <a name="bestfit"></a>自适应布局

布局样式会根据频道人数自适应。每个用户视窗平铺在画布上，大小一致。

对于自适应布局，有以下注意事项：

- 在下面不同人数的合流布局下，如果频道中人数不足，则剩余的布局位置会空着，显示背景色。
- 如果某用户只发送音频，仍然会占据布局，显示背景色。
- 如果实际视频流的宽高比与视窗的宽高比不一致，视频会裁剪以适配视频的大小。

不同人数下实际布局效果如下图所示。

![](https://web-cdn.agora.io/docs-files/1577695108955)

![](https://web-cdn.agora.io/docs-files/1577695143313)

![](https://web-cdn.agora.io/docs-files/1577695187385)

17 人的布局与上面的情况不同，用户视窗没有铺满整个画布。每个用户视窗的宽和高分别为总宽度和总高度的 0.2，前四行每行四个用户，画布左右边距均为总宽度的 0.1。第五行居中显示第 17 个用户视窗。

![](https://web-cdn.agora.io/docs-files/1577696123459)

### <a name="vertical"></a>垂直布局

如果你选择了垂直布局，需要在开始录制的时候通过 `--maxResolutionUid`指定一个 UID 作为大视窗。

对于垂直布局，有以下注意事项：

- 大视窗显示指定的 UID 用户的视频流.
 - 如果未指定或者指定用户未进入频道，Large 区域显示背景色。
 - 如果实际视频流的宽高比与视窗的宽高比不一致，视窗会缩放以保证视频的完整性。
- 小视窗的排列顺序，是按照加入频道的时间先后顺序。
 - 如果用户1退出频道，用户2会占据用户1的视窗，依次替补。
 - 如果实际视频流的宽高比与视窗的宽高比不一致，视频会裁剪以适配视窗的大小。
- 在下面不同人数的合流布局下，若频道中人数不足，则剩余的布局位置会空着，显示背景色。
- 如果某用户只发送音频，仍然会占据布局位，显示背景色。

不同人数下实际布局效果如下图所示。

![](https://web-cdn.agora.io/docs-files/1577695422766)

- 1 - 5 人布局，小视窗 1 - 4 依次显示在画布右侧, 且不会覆盖大视窗。小视窗宽度是总宽的 1/5，视窗高度是总高的 1/4，如下左图所示。
- 6 - 7 人布局，小视窗 1 - 6 依次显示在画布右侧, 且不会覆盖大视窗。小视窗宽度是总宽的 1/7，视窗高度是总高的 1/6，如下右图所示。

![](https://web-cdn.agora.io/docs-files/1577695434982)

- 8 - 9 人布局，小视窗 1 - 8 依次显示在画布右侧, 且不会覆盖大视窗。小视窗宽度是总宽的 1/9，视窗高度是总高的 1/8，如下左图所示。
- 10 - 17 人布局，小视窗 1 - 16 依次显示在画布右侧, 且不会覆盖大视窗。小视窗宽度是总宽的 1/10，视窗高度是总高的 1/8，如下右图所示。

## 自定义合流布局

如果预设的布局样式无法满足你的场景需求，可直接调用 API 实现自定义合流布局，灵活设置用户画面的大小，指定用户画面在视频画布上的相对位置。

### 实现方法

在加入频道后，先通过 [`VideoMixingLayout`](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/structagora_1_1linuxsdk_1_1_video_mixing_layout.html#abb3d1ffd1269badf23786b6a7abe0bdb) 类设置合流布局的参数，然后调用 [`setVideoMixingLayout`](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/classagora_1_1recording_1_1_i_recording_engine.html#a4ac28b9e2342729c1b54400a5abb1d90) 方法来实现自定义的合流布局。

![](https://web-cdn.agora.io/docs-files/1600076506070)

设置视频合流布局时，需在 [`VideoMixingLayout`](https://docs.agora.io/cn/Recording/API%20Reference/recording_cpp/structagora_1_1linuxsdk_1_1_video_mixing_layout.html#abb3d1ffd1269badf23786b6a7abe0bdb) 中传入以下参数：

- `canvasWidth`：整个画布的宽度，单位为 pixels。
- `canvasHeight`：整个画布的高度，单位为 pixels。
- `backgroundColor`：整个画布的背景颜色。可根据所需颜色填写对应的 6 位 RGB 值，如 "#000000"。
- `regionCount`：频道内显示头像或视频的用户（通信模式）/主播（直播模式）的数量。
- `regions`：频道内每位用户（通信模式）/主播（直播模式）在画布上的画面，包含如下参数：
  - `uid`：待显示在该画面的用户的 UID。每当有用户加入频道时，调用 `onUserJoined` 方法可以获得当前加入频道用户的 `uid`。如果不指定 UID，会按照用户加入频道的顺序自动匹配 `regions` 中的画面设置。
  - `x`：画布上该画面左上角的横坐标的相对值，取值范围是 [0.0,1.0]。从左到右布局，0.0 在最左端，1.0 在最右端。
  - `y`：画布上该画面左上角的纵坐标的相对值，取值范围是 [0.0,1.0]。从上到下布局，0.0 在最上端，1.0 在最下端。
  - `width`：该画面宽度的相对值，取值范围是 [0.0,1.0]。
  - `height`：该画面高度的相对值，取值范围是 [0.0,1.0]。
  - `alpha`：图像的透明度。取值范围是 [0.0,1.0] 。0.0 表示图像为透明的，1.0 表示图像为完全不透明的。
  - `renderMode`：画面显示模式：
    - `RENDER_MODE_HIDDEN(0)`: (默认）裁剪模式。
    - `RENDER_MODE_FIT(1)`: 缩放模式。

其中，`x`，`y`，`width` 和 `height` 四个参数为必填，都是 0.0 至 1.0 之间的浮点数。

以视频画布左上角为原点，`x` 和 `y` 设置用户画面在视频画布上的相对位置，分别代表用户画面左上角到原点的水平相对距离和垂直相对距离。`width` 和 `height` 设置用户画面的相对宽度和相对高度，即用户画面的宽度和高度占画布的宽度和高度的比例。确保 `x` + `width` ≤ 1，`y` + `height` ≤ 1。

如下图所示：

![](https://web-cdn.agora.io/docs-files/1600075503129)

### 示例代码

本节以设置 4 人画面的合流布局为例，并结合示例代码介绍如何设置自定义合流布局。

在示例中，第一个加入频道的用户在画布上显示为大视窗，铺满整个画布；其他三个用户显示为小视窗，悬浮在大视窗上面，效果如下图所示：
![](https://web-cdn.agora.io/docs-files/1600075569027)

```
// 创建 IRecordingEngine 实例并加入频道后，设置整个画布的宽度、高度、背景颜色和用户画面的数量。
agora::linuxsdk::VideoMixingLayout layout;
layout.canvasWidth = 720;
layout.canvasHeight = 480;
layout.backgroundColor = "#E7E6E6";
layout.regionCount = 4;

// 设置 4 个用户画面的参数。
agora::linuxsdk::VideoMixingLayout::Region * regionList = new agora::linuxsdk::VideoMixingLayout::Region[4];
// 设置第一个加入频道的用户在屏幕上显示为大视窗，铺满整个画布。
regionList[0].uid = <uid0>;
regionList[0].x = 0.f;
regionList[0].y = 0.f;
regionList[0].width = 1.f;
regionList[0].height = 1.f;
regionList[0].alpha = 1.f;
regionList[0].renderMode = 0; 

// 设置其他 3 个用户按照加入的顺序从画布左下角开始依次水平排列，显示为小视窗。 
// 每个小画面的宽为整个画布宽的 0.235，高为小画面的宽 ×（整个画布的高/整个画布的宽），即小画面的宽高比与整个画布的宽高比相同。
// 相邻小画面的左右间距为整个画布宽的 0.012，上下间距为左右间距 × （整个画布的高/整个画布的宽）。
// 小画面距离画布的水平距离也为整个画布宽的 0.012，距离画布的垂直距离为水平距离 × （整个画布的高/整个画布的宽）。
float canvasWidth = 720;
float canvasHeight = 480;
float viewWidth = 0.235f;
float viewHEdge = 0.012f;
float viewHeight = viewWidth * (canvasHeight/canvasWidth);
float viewVEdge = viewHEdge * (canvasHeight/canvasWidth);

for (size_t i = 1; i < 4; i++) {
regionList[i].uid = <uidi>;
float xIndex = static_cast<float>((i-1) % 4);
float yIndex = static_cast<float>((i-1) / 4);
regionList[i].x = xIndex * (viewWidth + viewHEdge) + viewHEdge;
regionList[i].y = 1 - (yIndex + 1) * (viewHeight + viewVEdge);
regionList[i].width = viewWidth;
regionList[i].height = viewHeight;
regionList[i].alpha = static_cast<double>(i + 1);
regionList[i].renderMode = 0;
}
layout.regions = regionList;
// 调用 setVideoMixingLayout 实现自定义的合流布局。
m_engine->setVideoMixingLayout(layout);
```