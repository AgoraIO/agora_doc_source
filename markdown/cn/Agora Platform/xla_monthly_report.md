---
title: 查看 XLA 月报
platform: All Platforms
updatedAt: 2020-09-28 16:29:17
---
XLA 月报可以帮助你查看 XLA 协议有效期和以下指标的达标情况：

- 登录成功达标率
- 音频卡顿达标率
- 视频卡顿达标率
- 端到端网络延时达标率

<div class="alert info"><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/xla_live_video?platform=All%20Platforms">体验等级协议</a >（eXperience Level Agreement，简称为 XLA）是声网面向实时互动服务（RTE）的体验质量标准。</li><li>XLA 协议仅适用于 <a href="https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk">Agora RTC Native SDK</a >。</li></div>

![](https://web-cdn.agora.io/docs-files/1601195435016)

## 使用步骤

1. 登录[控制台](https://console.agora.io/)，点击左侧菜单栏中的**体验等级协议**。

2. 在页面左上方的下拉菜单中选择已签署 XLA 的项目。

3. 点击 **XLA 月报**，即可查看 XLA 指标。

 <div class="alert note">如未签署 XLA 协议，则 XLA 月报界面会显示 <b>XLA 未开通</b>。</div>

## 指定查询月份

XLA 月报默认显示本月的 XLA 指标，你可以通过如下方法指定查询月份：

- 通过面板右上角**本月**或**上月**按钮，快速查看本月或上月的 XLA 指标。
- 在面板右上角的**日历**中选择具体月份，查看指定月份的 XLA 指标。

## 月报

月报面板显示指定查询月份、XLA 协议有效期、数据更新时间和指定月份的 XLA 指标达标情况。当月完整数据会在次月 1 日更新。

### XLA 指标

根据签署的 XLA 协议，月报面板可能会显示如下四个指标：

- 登录成功达标率
- 音频卡顿达标率
- 视频卡顿达标率
- 端到端网络延时达标率

<div class="alert info"><li>XLA 指标详细描述见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/xla_live_video?platform=All%20Platforms#level">体验质量保障等级</a >。</li><li>如果签署了纯音频服务的 XLA 协议，则 XLA 月报只会显示登录成功达标率、音频卡顿达标率和端到端网络延时达标率。</li></div>

### 达标状态

各 XLA 指标可能会显示如下三种状态：

| 状态   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| 达标   | 查询时间为历史月份时，如果 XLA 指标达标率**满足**达标率承诺，则界面会显示达标。 |
| 不达标 | 查询时间为历史月份时，如果 XLA 指标达标率**不满足**达标率承诺，则界面会显示不达标。 |
| 评估中 | 查询时间为本月时，由于本月达标率还在计算，界面会显示评估中。 |

你也可以在图表中看到如下信息：

- 蓝色进度条：服务月度的进度
- 红色进度条：不达标时长
- 红色虚线：不达标补偿线

如果不达标时长超过补偿线，Agora 会按照[损失补偿方案](https://docs.agora.io/cn/Interactive%20Broadcast/xla_live_video?platform=All%20Platforms#compensation)进行补偿。

## 每日明细

每日明细展示指定月份中各 XLA 指标的每日达标率和每日不达标时长，且当日数据会在次日更新。点击**下载**，你可以获取每日明细的 csv 文件。