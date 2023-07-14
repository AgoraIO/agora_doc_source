## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

#### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert note">声网 4.x SDK 均支持使用通配 Token。</div>

2. **预加载频道**

   该版本新增 `preloadChannel[1/2]` 和 `preloadChannel[2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频以及看到首帧画面的耗时，提升观众端的音视频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

3. **自定义视频画布背景颜色**

   该版本在 `VideoCanvas` 中增加了 `backgroundColor` 成员，支持你在设置本地或远端视频显示属性时，自定义视频画布的背景颜色。

4. **发布多源采集的视频流** (Windows, macOS)

   该版本在 `ChannelMediaOptions` 中新增下列成员，支持你发布第三个、第四个摄像头和屏幕采集到的视频流：

   - `publishThirdCameraTrack`：发布第三个摄像头采集的视频。
   - `publishFourthCameraTrack`：发布第四个摄像头采集的视频。
   - `publishThirdScreenTrack`：发布第三个屏幕采集的视频。
   - `publishFourthScreenTrack`：发布第四个屏幕采集的视频。

   <div class="alert note">目前 SDK 支持在同一时间、同一 <code>RtcConnection</code> 中发布多路音频流、一路视频流。</div>

#### 改进

1. **虚拟背景算法升级**

   该版本升级了虚拟背景的人像分割算法，全面提升了人像分割的准确度、人像边缘与虚拟背景间的平滑度以及人物移动时边缘的贴合度，同时优化了虚拟背景在会议、办公、居家等场景下，以及逆光、弱光等条件下的人物边缘精度。

2. **跨频道连麦优化**

   该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

3. **视频编解码查询能力增强**

   为提升设备编解码能力查询功能，该版本在 `CodecCapInfo` 中新增 `codecLevels` 成员。当成功调用 `queryCodecCapability` 后，可通过 `codecLevels` 得知当前设备对于 H.264 和 H.265 格式的视频的硬件和软件解码能力等级。

该版本还进行了如下改进：

1. 在屏幕共享场景下，SDK 根据共享的场景自动调节发送端的帧率。尤其是在共享文档场景下，避免发送端的视频码率超出预期的情况，以提高传输效率、减小网络负担。
2. 为帮助用户了解更多类型的远端视频状态改变的原因，`onRemoteVideoStateChanged` 回调中新增了 `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` 枚举，表示本地的视频解码器不支持对收到的远端视频流进行解码。

#### 问题修复

该版本修复了以下问题：

- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 在屏幕共享场景下，部分机型偶现屏幕共享画面出图延迟高于预期。
- 自采集场景下，`setBeautyEffectOptions`、`setLowlightEnhanceOptions`、`setVideoDenoiserOptions` 和 `setColorEnhanceOptions` 无法自动加载插件。
- 多设备音频录制场景下，反复插拔或开启/禁用音频录制设备后，偶现调用 `startRecordingDeviceTest` 进行音频采集设备测试时听不到声音。

#### API 变更

**新增**

- `preloadChannel[1/2]`
- `preloadChannel[2/2]`
- `updatePreloadChannelToken`
- `ChannelMediaOptions` 中增加下列成员：
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `VideoCanvas` 中增加 `backgroundColor` 成员
- `CodecCapInfo` 中增加 `codecLevels` 成员
- `REMOTE_VIDEO_STATE_REASON` 中增加 `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` 枚举