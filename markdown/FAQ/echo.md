---
title: 如何处理音频回声问题？
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-11-12 07:40:13
Products: ["Voice","Video","Interactive Broadcast"]
---
Agora SDK 支持对多数设备进行回声消除。如果遇到回声问题，可以佩戴耳机进行规避，并确认耳机本身不会引起回声。

另外，当一台设备出现问题时，频道内其他所有用户都能听到。因此排查问题时还需注意，听到回声的一方，并不一定是出现问题的一方。

## 步骤 1：自检操作

* 定位引起回声的用户。可通过依次静音频道内的用户进行确认。
* 判断回声是持续性的还是一次性的。后者是由设备性能过度消耗引起的。在水晶球的[通话调查](https://docs.agora.io/cn/Agora%20Platform/aa_call_search?platform=All%20Platforms#%E5%88%86%E6%9E%90%E9%80%9A%E8%AF%9D%E8%B4%A8%E9%87%8F%E9%97%AE%E9%A2%98)中，可通过**端到端详情页面**查看设备状态。
* 请确保各通话方处于互相隔离的物理环境中（非近场测试），不要相距太近。
* 请检查 SDK 版本，如果低于以下版本，请升级至以下版本再尝试：
	* Android/iOS: v1.6.0 或更高版本
	* Windows/macOS: v1.7.0 或更高版本
* 确认音频是否使用了自采集模式。该模式 SDK 默认不会对采集到的信号做回声消除处理。
* Windows 平台上，检查在麦克风属性里是否已勾选**监听麦克风**选项，如有，取消该勾选。
* iOS 平台上，检查 app 的 Audio Session 是否设置了 `AVAudioSessionCategoryOptionMixWithOthers` 属性。设置此参数后，如果有其他音频类应用也在使用音频设备，可能会导致回声。
* 有的设备（Android，Windows）带有系统厂商提供的回声消除功能，在此情况下有可能因为其算法效果不佳导致有回声，建议完全关闭系统回声消除而使用 Agora 提供的回声消除功能。
* 请佩戴耳机。
	* 1 对 1 通话：如果您听到回声，请让对方佩戴耳机进行通话。
	* 多人通话：可以请用户轮流静音，找出回声源。引起回声的用户请佩戴耳机，或在无需发言时，请将自己设为静音状态。

## 步骤 2：联系技术支持

如果问题仍然存在，请联系技术支持，并提供以下信息，方便快速定位问题：

<table>
  <tr>
    <th>信息</th>
    <th>详情</th>
  </tr>
  <tr>
    <td rowspan="4">必要信息</td>
    <td>存在回声的通话频道号</td>
  </tr>
  <tr>
    <td>哪些用户听到了回声，提供他们的 UID</td>
  </tr>
  <tr>
    <td>哪些用户引起了回声，提供他们的 UID，例如，当某个用户加入频道时，其他用户开始听到回声</td>
  </tr>
  <tr>
    <td>录音文件（如果有的话）</td>
  </tr>
  <tr>
    <td rowspan="3">更多信息</td>
    <td>出现回声的具体时间段</td>
  </tr>
  <tr>
    <td>退出频道，再重新加入频道后，该问题是否仍旧存在</td>
  </tr>
  <tr>
    <td>引起回声或听到回声的用户切换语音路由后，该问题是否仍旧存在。例如：插入耳机，切换为听筒模式等</td>
  </tr>
</table>

## 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](https://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349)。
