语音连麦聊天在在线交友、游戏娱乐等场景下广泛应用。为了让用户获得更加沉浸式、有趣的语音聊天体验，声网推出了声动语聊解决方案。该方案搭载声网最新音频技术和最佳音效实践，提供更好的在线语音聊天室（即“语聊房”）体验。用户可以通过音频连麦互动，使用文字消息辅助聊天，并通过弹幕、礼物等方式活跃房间气氛。开发者可以使用声动语聊方案搭建符合业务需求的语聊应用，例如语音电台、K歌、游戏语音开黑房、你画我猜等游戏派对房。

## 方案优势

声动语聊解决方案有如下优势：

|优势概述|详情|
|-------|---------------|
| 搭载最新音频技术，打造更沉浸式的互动玩法   | <li>声动语聊采用声网新一代音频技术智能引擎，包含空间音频、AI 降噪、AI 回声消除、变声音效等功能，使语音互动中的声音具有方位感和空间感。</li><li>语聊房可以有效屏蔽和抑制环境中的噪音和回声，打造更纯净、更沉浸的语音互动。</li>   |
| 行业顶尖音效配置，聊得尽兴，玩得开心    |声动语聊综合声网超过万亿分钟的用户音效偏好的数据模型，汇总梳理语聊领域各类头部 app 的音效配置，并结合声网音频专家的多年沉淀与研究，提供针对各种语音场景的最佳音效配置，让用户享受行业顶尖的音效体验。    |
| 搭积木式开发，接入成本低    | 语聊房的客户端功能以组件化形式提供，开发者可以像搭积木一样按需调用对应组件（包括弹幕组件、席位管理组件、音效组件、房间管理组件），灵活高效，大幅降低开发接入成本。   |


## 支持功能

声动语聊解决方案支持的核心功能如下：

| 功能    | 描述    |
|-----|-------------------------|
| 多人实时语音    | 语聊房内多位用户实时连麦语聊。    |
| 麦位管理    | 上麦、下麦、静音、锁麦、换麦。详见[麦位管理](./chatroom_mic_seat_android)。    |
| 多种场景音效    | 房主为不同业务场景设置语聊房的最佳音效：包括语聊社交、KTV、游戏陪玩、专业音频直播的语音场景。 |
| 用户个人音效    | 用户自定义个人音效：<li>AI 降噪（NS）：降低语聊时的噪音。<li>AI 回声消除（AEC）：消除语聊时的回声。<li>语音自动增益（AGC）：自动调整唱歌的人声音量。    |
| 空间音效    | 使用户听到的音频具有 3D 空间立体感，让用户感觉更身临其境。用户可以调节麦位在空间中的位置，以选择更好的方位和距离来收听其他用户的发言。详见[空间音效](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/spatial_audio_android_ng?platform=Android)。    |
| 播放背景音乐    | 房主可以播放本地音乐文件、在线音乐文件、声网内容中心的版权音乐、第三方厂商的版权音乐。详见[进阶功能](./chatroom_set_audio)。    |
| 音量波纹提示    | 监听用户声音的音量并创造与音量高低相对应的波纹效果。详见[进阶功能](./chatroom_set_audio)。    |
| 录制    | 通过声网[本地服务端录制](https://docportal.shengwang.cn/cn/Recording/product_recording?platform=Linux)或[云端录制](https://docportal.shengwang.cn/cn/cloud-recording/product_cloud_recording?platform=All%20Platforms)服务对语聊房进行录制。    |
| 语音审核    |通过声网云市场丰富的插件实现语音审核，例如使用[依图](https://docportal.shengwang.cn/cn/extension_customer/quickstart_yitu_moderation_audio?platform=All%20Platforms)、[数美](https://docportal.shengwang.cn/cn/extension_customer/quickstart_shumei_moderation_audio?platform=All%20Platforms)、[图普](https://docportal.shengwang.cn/cn/extension_customer/quickstart_tupu_moderation_audio?platform=All%20Platforms)语音审核插件。     |
| 防止炸房捣乱现象    | 预防和应对炸房捣乱现象的有效措施，帮助维护房间秩序，提高业务安全性。详见[预防和应对炸房捣乱现象最佳实践](https://docportal.shengwang.cn/cn/live-streaming-premium-legacy/prevent_stream_bombing?platform=Android)。    |



## 支持平台

声动语聊目前支持 Android 和 iOS 平台。

## 技术架构 //TODO yf是否适用于UI方案

声网使用[声网 RTC SDK](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/product_live_ng?platform=Android)、[声网即时通讯（IM）SDK](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_overview?platform=All%20Platforms)、声网云服务（Service）共同搭建声动语聊场景：

- 声网 RTC SDK：实现频道用户的实时音频互动。
- 声网即时通讯（IM）SDK：实现房间内的信令通信。
- 声网云服务（Service）：实现房间列表的存储并管理房间生命周期。

![](https://web-cdn.agora.io/docs-files/1689243538283)
