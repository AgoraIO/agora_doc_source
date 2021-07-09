---
title: 如何处理音频噪声问题？
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","微信小程序","Electron","React Native","Flutter"]
updatedAt: 2020-07-09 21:30:39
Products: ["Voice","Video","Interactive Broadcast"]
---
噪声的问题一般是外部环境或者录放音设备导致的，SDK 本身一般是不会主动产生噪声。

## 步骤 1：自检操作

完成以下的自检操作，确认噪声是否已消除：

* 确认是否为近场测试：通信两端的手机在同一房间内，且处于公放状态，连环增益大于 1 时会产生近场啸叫。
* 确认音频是否使用了自采集模式。自采集本身不会引起噪声，但在传输给 SDK 的过程中，可能会因为数据不完整而产生噪声。该模式 SDK 不支持噪声消除。
* 通话时一方环境是否太过嘈杂（麦克风对着电脑风扇，宿舍很吵，窗外很吵等）。
* 确认录音设备是否正常工作（外置声卡、耳机、麦克风接触不良会造成电流声）。
* 耳机 Mic 晃动或和衣服摩擦也会产生杂音。

## 步骤 2：联系技术支持

如果问题仍旧存在，请联系技术支持，并提供以下信息，方便快速定位问题：

<table>
  <tr>
    <th>信息</th>
    <th>详情</th>
  </tr>
  <tr>
    <td rowspan="3">必要信息</td>
    <td>存在噪声的通话频道号</td>
  </tr>
  <tr>
    <td>哪些用户引起了噪声，提供他们的 UID，例如，当某个用户加入频道时，频道里开始出现噪声</td>
  </tr>
  <tr>
    <td>录音文件（如果有的话）</td>
  </tr>
  <tr>
    <td rowspan="4">更多信息</td>
    <td>出现噪声的具体时间段</td>
  </tr>
  <tr>
    <td>退出频道，再重新加入频道后，该问题是否仍旧存在</td>
  </tr>
  <tr>
    <td>macOS 或 Windows 的设备测试结果是否正常</td>
  </tr>
  <tr>
    <td>是否噪声一直存在，还是只有当你说话时你能听见噪声，而其他用户说话时没有噪声</td>
  </tr>
</table>

## 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](https://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349)。