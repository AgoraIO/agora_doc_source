## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

#### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert note">声网 4.x SDK 均支持使用通配 Token。</div>

2. **预加载频道**

   该版本新增 `preloadChannel[1/2]` 和 `preloadChannel[2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频的耗时，提升观众端的音频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

#### 改进

**跨频道连麦优化**

该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

#### 问题修复

该版本修复了以下问题：

- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 多设备音频录制场景下，反复插拔或开启/禁用音频录制设备后，偶现调用 `startRecordingDeviceTest` 进行音频采集设备测试时听不到声音。

#### API 变更

**新增**

- `preloadChannel[1/2]`
- `preloadChannel[2/2]`
- `updatePreloadChannelToken`