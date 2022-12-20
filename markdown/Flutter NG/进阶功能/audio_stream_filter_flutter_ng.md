# 音强选流

## 概述

默认情况下，用户加入频道后会默认订阅所有远端用户的音频流。但在多个用户同时发流的场景中（如大型会议），这会占用接收端较大的带宽及系统资源。为减少接收端下行带宽压力及系统资源消耗，Agora 推出音强选流功能。

<div class="alert info">如需启用该功能，请<a href="https://agora-ticket.agora.io/">联系技术支持</a>。</div>

## 技术原理

音强选流是指 Agora 服务器根据音强算法对接收端订阅的音频流进行选流，选出 N 路音量最大的音频流传输至接收端。N 支持自定义设置，默认为 3 路。为灵活适应各种业务场景，Agora 还支持发流端自定义设置其发布的音频流不参与音强选流，直接传输到接收端。

## 前提条件

在进行操作之前，请确保你已经在项目中实现了基本的实时音视频功能。详见[实现语音通话](./start_call_audio_flutter_ng)或[实现互动直播](./start_live_flutter_ng)。

## 实现方法

本节介绍常见业务场景下音强选流功能的应用。

### 仅启用音强选流

开启音强选流功能后，当前频道内的所有音频流默认均会参与选流，声网服务器默认传输实时音量最大的 3 路音频流至接收端。如果你需要自定义传输的音频流的数量（N），请[联系技术支持](https://agora-ticket.agora.io/)。当你自定义 N 后，声网服务器会根据你的设置选出 N 路音量最大的音频流进行传输。在几十人甚至上百人同时发流的场景下，启用音强选流可帮助减小接收端的下行带宽资源压力。

### 自定义设置是否参与音强选流

如果用户希望自己的音频流不参与选流，无论其声音大小都需要传输至接收端时，你可以选择下列其中一种方式来设置：

- 调用 [joinChannel](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_joinchannel2) 或 [joinChannelWithUserAccount](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_joinchannelwithuseraccount2) 加入频道，通过 `options` 参数将 [ChannelMediaOptions](./API%20Reference/flutter_ng/API/rtc_api_data_type.html#class_channelmediaoptions) 中的 `isAudioFilterable` 设为 `false`。
- 在加入频道后调用 [updateChannelMediaOptions](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_updatechannelmediaoptions)，然后通过 `options` 参数将 [ChannelMediaOptions](./API%20Reference/flutter_ng/API/rtc_api_data_type.html#class_channelmediaoptions) 中的 `isAudioFilterable` 设为 `false`。

此外，如果某一个接收端希望其接收的音频流不受音强选流功能控制，需要拉取所有订阅的远端音频流，可以调用 [`setParameters`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_setparameters) 方法通过 JSON 选项进行设置，详情请[联系技术支持](https://agora-ticket.agora.io/)。

**场景示例**

在大型企业会议场景下启用音强选流，同时某些会议关键人物指定其发布的音频流不参与选流，直接传输至接收端。

假设接入频道的人数为 500 人，N 设置为 4，即在接收端订阅的音频流中选出音量最大的 4 路音频流并传输至接收端，同时总部发言代表 A 及其他分支机构发言代表 B、C、D 将其发布的音频流设为不参与选流。设置之后可降低接收端播放音频流的卡顿率，同时针对于某些重要的发流用户，即便其说话音量较低，接收端依然可以收到其音频流。

<img src="https://web-cdn.agora.io/docs-files/1671519367185" width=70%/>

## 参考信息

本节介绍音强选流功能的集成注意事项以及本文中使用方法的更多信息。

### API 参考

- [`joinChannel`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_joinchannel2)
- [`joinChannelWithUserAccount`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_joinchannelwithuseraccount2)
- [`updateChannelMediaOptions`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_updatechannelmediaoptions)
- [`setParameters`](./API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_setparameters)
- [`ChannelMediaOptions`](./API%20Reference/flutter_ng/API/rtc_api_data_type.html#class_channelmediaoptions)