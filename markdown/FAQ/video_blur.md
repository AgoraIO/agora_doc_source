---
title: 如何处理视频模糊问题？
platform: ["Android","iOS","macOS","Web","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-11-12 07:15:09
Products: ["Video","Interactive Broadcast"]
---
视频模糊一般是由视频码率或分辨率过低导致。

## 步骤 1：自检

请按以下步骤进行排查：

* 确认 `videoProfile` 设置，如果可以的话，尝试更高的 profile 看是否可以解决问题；
* 看看接收端接受的是大流还是小流，是小流的话可以调用接口申请大流关闭小流；
* 尝试 4G 连接，或者其他 Wi-Fi 信号排除网络问题；
* 如果有视频前处理，请先关闭前处理； 

## 步骤 2：联系技术支持

如果上述措施没有解决问题，请联系技术支持并提供下列信息：

* 出现模糊画面的用户的 UID；
* 模糊的具体时间端；
* 出现问题的用户的 SDK 日志及录屏文件。

## 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](http://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349)。