---
title: 自定义视频采集和渲染
platform: Android
updatedAt: 2021-03-24 02:20:23
---

## 功能介绍

实时音视频传输过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。在以下场景中，你可能会发现默认的音视频模块无法满足开发需求：

- app 中已有自己的音频或视频模块
- 希望使用非 Camera 采集的视频源，如录屏数据
- 需要使用自定义的美颜库或有前处理库
- 某些视频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

基于此，Agora Native SDK 支持使用自定义的音视频源或渲染器，实现相关场景。本文介绍如何实现自定义视频采集和渲染。

## 实现方法

开始自定义采集和渲染前，请确保你已在项目中实现基本的通话或者直播功能，详见[一对一通话](start_call_android)或[互动直播](start_live_android)。

### 自定义视频采集

Agora Native SDK 目前提供 Push 方式和 MediaIO 两种方式实现自定义的视频源。其中：

- Push 方式下，SDK 默认不会对采集传入的音频数据做消噪等处理。如有音频消噪需求，需要开发者自行实现。
- MediaIO 方式下，自定义视频源可以搭配自定义渲染器使用，实现更为丰富的场景。

#### Push 方式

参考如下步骤，在你的项目中使用 Push 方式实现自定义视频源功能：

1. 在 `joinChannel` 前通过调用 `setExternalVideoSource` 指定外部视频采集设备。
2. 指定外部采集设备后，开发者自行管理视频数据采集和处理。
3. 完成视频数据处理后，再通过 `pushExternalVideoFrame` 发送给 SDK 进行后续操作。

**API 时序图**

参考下图时序在你的项目中自定义视频采集。

![](https://web-cdn.agora.io/docs-files/1569392908808)

**示例代码**

参考下文代码在你的项目中自定义视频采集。

```java
// 首先通知 SDK 现在开始使用外部视频源
rtcEngine.setExternalVideoSource(
    true，      // 是否使用外部视频源
    false,       // 是否使用 Texture作为输出
    true         // true 为使用推送模式，false 为拉取模式，但目前不支持
);

// 在获得视频数据的时候调用 Push 方法将数据传送出去
rtcEngine.pushExternalVideoFrame(new AgoraVideoFrame(
    // 在构造方法传入帧数据的参数，比如格式，宽高等
    // 具体的请查看 AgoraVideoFrame 类的说明
));
```

同时，我们在 GitHub 提供一个开源的 [Switch external video](https://github.com/AgoraIO/Advanced-Video/blob/master/Android/sample-switch-external-video) 示例项目。你可以前往下载，或参考 [SwitchVideoInputActivity.java](https://github.com/AgoraIO/Advanced-Video/blob/master/Android/sample-switch-external-video/src/main/java/io/agora/advancedvideo/switchvideoinput/SwitchVideoInputActivity.java) 文件中的 `setVideoInput` 方法的源代码。

**API 参考**

- [`isTextureEncodeSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a60c16364ab588a38f5155d9c94eaf800)
- [`setExternalVideoSource`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2d9966c52798ab62ed941fa865e926cd)
- [`pushExternalVideoFrame`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6e7327f4449800a2c2ddc200eb2c0386)

#### MediaIO 方式

Agora 通过 MediaIO 提供 `IVideoSource` 接口和 `IVideoFrameConsumer` 类，你可以通过该类设置采集的视频数据格式，并控制外部视频的采集过程。

参考如下步骤，在你的项目中使用 MediaIO 方式实现自定义视频源功能：

1. 实现 `IVideoSource` 类。Agora 通过 `IVideoSource` 类下的各回调设置视频数据格式，并控制采集过程：
   - 收到 `getBufferType` 回调后，在该回调的返回值中指定想要采集的视频数据格式；
   - 收到 `onInitialize` 回调后，保存该回调中的 `IVideoFrameConsumer` 对象。Agora 通过 `IVideoFrameConsumer` 对象发送和接收自定义的视频数据；
   - 收到 `onStart` 回调后，通过 `IVideoFrameConsumer` 对象向 SDK 发送视频帧；
   - 收到 `onStop` 回调后，停止使用 `IVideoFrameConsumer` 对象向 SDK 发送视频帧；
   - 收到 `onDispose` 回调后，释放 `IVideoFrameConsumer` 对象。
2. 继承实现的 `IVideoSource` 类，构建一个自定义的视频源对象。
3. 调用 `setVideoSource` 方法，将自定义的视频源对象设置给 RtcEngine。
4. 根据场景需要，调用 `startPreview`、`joinChannel` 等方法预览或发送自定义采集的视频数据。

**API 时序图**

参考下图时序使用 MediaIO 在你的项目中实现自定义视频采集。

![](https://web-cdn.agora.io/docs-files/1568970684954)

**示例代码**

参考下文代码使用 MediaIO 在你的项目中实现自定义视频采集。

```java
IVideoFrameConsumer mConsumer;
boolean mHasStarted;

// 先创建一个实现 VideoSource 接口的实例
VideoSource source = new VideoSource() {
	@Override
	public int getBufferType() {
		// 返回当前帧数据的 Buffer 类型，每种数据类型在 SDK 内部会经过不同的处理，所以必须与帧数据的类型保持一致
		// 若切换 VideoSource 的类型，必须重新创建另一个实例
		// 有三种类型：BYTE_BUFFER(1)；BYTE_ARRAY(2)；TEXTURE(3)
		return BufferType.BYTE_ARRAY;
	}

	@Override
	// 初始化视频源。你需要在该方法中传入一个 IVideoFrameConsumer 对象
 	public boolean onInitialize(IVideoFrameConsumer consumer) {
		// Consumer 是由 SDK 创建的，在 VideoSource 生命周期中注意保存它的引用
		mConsumer = consumer;
	}

	@Override
	// 启动视频源。你可以在该方法中启动视频帧捕捉。输入 true，表示自定义视频源已成功启动。
 	public boolean onStart() {
		mHasStarted = true;
	}

	 @Override
	// 停止视频源。你可以在该方法中停止采集视频。
   public void onStop() {
	 mHasStarted = false;
	}

	@Override
	// 释放视频源。你可以在该方法中关闭视频源设备。同时 SDK 会销毁 IVideoFrameConsumer 对象。
 	public void onDispose() {
		// 释放对 Consumer 的引用
		mConsumer = null;
	}
};

// 将输出流切换到刚创建的 VideoSource 实例
rtcEngine.setVideoSource(source);

// 在得到视频帧数据之后，可以调用 Consumer 类的方法传送数据
// 必须根据帧数据的类型来选择用不同的方法
// 假设从视频源中得到的视频为 Data, 从 Android 相机中获取的帧类型可能是 NV21 和 TEXTURE_OES，假设当前类型为 byte array，即 NV21
if (mHasStarted && mConsumer != null) {
	mConsumer.consumeByteArrayFrame(data, AgoraVideoFrame.NV21, width, height, rotation, timestamp);
}
```

同时，我们在 GitHub 提供一个开源的 [Custom-Media-Device-Android](https://github.com/AgoraIO/Advanced-Video/tree/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android) 示例项目。你可以前往下载，或参考 [ViewSharingCapturer.java](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android/app/src/main/java/io/agora/rtc/mediaio/app/shareScreen/source/ViewSharingCapturer.java) 文件中的源代码。

**API 参考**

- [`setVideoSource`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa240e991d12b5240fc5fd362cbc0d521)
- [`IVideoSource`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_source.html) 类
- [`IVideoFrameConsumer`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_frame_consumer.html) 类

**相关文档**

你也可以选择自己管理视频设备的生命周期，只是根据 Media Engine 的回调来打开和关闭视频帧的输入开关。对于开发者 App 之前已有自己的采集模块，需要集成 Agora SDK 以获得实时通信能力的使用场景下，这种方式更简单。详见 [使用 Agora SDK 提供的组件自定义视频源](./custom_advanced_android#custom_video_source) 中的描述。

### 自定义视频渲染器

通过 MediaIO 采集到的视频数据，还可以搭配 Agora 的 `IVideoSink` 接口使用，实现自定义渲染功能。

参考如下步骤，在你的项目中使用 MediaIO 方式实现自定义渲染器功能：

1. 实现 `IVideoSink` 类。Agora 通过 `IVideoSink` 类下的各回调设置视频数据格式，并控制渲染过程：
   - 收到 `getBufferType` 和 `getPixelFormat` 回调后，在对应回调的返回值中设置你想要渲染的数据类型；
   - 根据收到的 `onInitialize`、`onStart`、`onStop`、`onDispose`、`getEglContextHandle` 回调，控制视频数据的渲染过程；
   - 实现一个对应渲染数据类型的 `IVideoFrameConsumer` 对象，以获取视频数据。
2. 继承实现的 `IVideoSink 类`，构建一个自定义的渲染器。
3. 调用 `setLocalVideoRenderer` 或 `setRemoteVideoRenderer`，用于本地渲染或远端渲染。
4. 根据场景需要，调用 `startPreview`、`joinChannel` 等方法预览或发送自定义渲染的视频数据。

**API 调用时序**

参考下图时序使用 MediaIO 在你的项目中实现自定义视频渲染。

![](https://web-cdn.agora.io/docs-files/1585284367293)

**示例代码**

参考下文代码使用 MediaIO 在你的项目中实现自定义视频渲染。

```java
// 先创建一个实现 IVideoSink 接口的实例
IVideoSink sink = new IVideoSink() {
	@Override
	// 初始化渲染器。你可以在该方法中对渲染器进行初始化，也可以提前初始化好。将返回值设为 true，表示已完成初始化
	public boolean onInitialize () {
		return true;
	}

	@Override
	// 启动渲染器
	public boolean onStart() {
		return true;
	}

	@Override
	// 停止渲染器
	public void onStop() {

	}

	@Override
	// 释放渲染器
	public void onDispose() {

	}

	@Override
	public long getEGLContextHandle() {
		// 构造你的 Egl context
		// 返回 0 代表渲染器中并没有创建 Egl context
		return 0;
	}

    // 返回当前渲染器需要的数据 Buffer 类型
	// 若切换 VideoSink 的类型，必须重新创建另一个实例
	// 有三种类型：BYTE_BUFFER(1)；BYTE_ARRAY(2)；TEXTURE(3)
	@Override
	public int getBufferType() {
		return BufferType.BYTE_ARRAY;
	}

    // 返回当前渲染器需要的 Pixel 格式
	@Override
	public int getPixelFormat() {
		return PixelFormat.NV21;
	}

   // SDK 调用该方法将获取到的视频帧传给渲染器
   // 根据获取到的视频帧的格式，选择相应的回调
   @Override
   public void consumeByteArrayFrame(byte[] data, int format, int width, int height, int rotation, long timestamp) {

   // 渲染器在此渲染
   }
   public void consumeByteBufferFrame(ByteBuffer buffer, int format, int width, int height, int rotation, long timestamp) {


   // 渲染器在此渲染
   }
   public void consumeTextureFrame(int textureId, int format, int width, int height, int rotation, long timestamp, float[] matrix) {

   // 渲染器在此渲染
   }

}

rtcEngine.setLocalVideoRenderer(sink);
```

同时，我们在 GitHub 提供一个开源的 [Custom render](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render) 示例项目。你可以前往下载，或参考 [CustomRemoteRenderActivity.java](https://github.com/AgoraIO/Advanced-Video/blob/master/Android/sample-custom-render/src/main/java/io/agora/advancedvideo/customrenderer/CustomRemoteRenderActivity.java) 文件中的源代码。

**API 参考**

- [`setLocalVideoRenderer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab10fd6d8dd89a5bca09b115ecd9e3416)
- [`setRemoteVideoRenderer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0da32c040cb9d987df2950b83459ba56)
- [`IVideoSink`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_sink.html) 类
- [`IVideoFrameConsumer`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_frame_consumer.html) 类

**相关文档**

为了方便开发者集成和创建自定义的视频渲染器，Agora 也提供了一些辅助类和示例代码；开发者也可以直接使用这些组件，或者利用这些组件构建自定义的渲染器，详见下文的 [使用 Agora SDK 提供的组件自定义渲染器](./custom_advanced_android#custom_video_renderer) 。

## 开发注意事项

自定义视频采集和渲染场景中，需要开发者具有采集或渲染视频的能力：

- 自定义视频采集场景中，你需要自行管理视频数据的采集和处理。
- 自定义视频渲染场景中，你需要自定管理视频数据的处理和显示。

## 相关文档

如果你还想在项目中实现自定义的音频采集和渲染功能，请参考文档[自定义音频采集和渲染](custom_audio_android)。
