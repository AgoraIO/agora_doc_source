---
title: 发版说明
platform: Windows
updatedAt: 2020-12-17 03:47:01
---
## 3.2.0 版

该版本于 2020 年 12 月 9 日发布。这是极速直播的首个版本。

极速直播与互动直播的区别主要在于观众端延时不同：

- 互动直播的观众端为超低延时 400 ms - 800 ms。
- 极速直播的观众端为低延时 1500 ms - 2000 ms。

声网针对不同级别的观众端延时收取不同的费用。更多信息见[极速直播产品概述](/cn/live-streaming/product_live_standard)。

你可通过该版本中的 [`setClientRole`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a7f01b7bbf512a041afa99ec7ecfa11c4) 方法将用户角色设置为观众、用户级别设置为低延时来实现极速直播场景。