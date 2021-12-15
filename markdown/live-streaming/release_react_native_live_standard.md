---
title: 发版说明
platform: React Native
updatedAt: 2020-12-23 03:13:37
---

## 3.2.0 版

该版本于 2020 年 12 月 23 日发布。这是极速直播的首个版本。

极速直播与互动直播的区别主要在于观众端延时级别不同：

- 互动直播中观众端延时级别为超低延时 400 ms - 800 ms。
- 极速直播中观众端延时级别为低延时 1500 ms - 2000 ms。

声网针对不同级别的观众端延时收取不同的费用。更多信息见[极速直播产品概述](/cn/live-streaming/product_live_standard)。

你可通过该版本中的 [`setClientRole`](./API%20Reference/react_native/classes/rtcengine.html#setclientrole) 方法将用户角色设置为观众、用户级别设置为低延时来实现极速直播场景。
