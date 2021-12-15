---
title: 极速直播计费
platform: All Platforms
updatedAt: 2021-01-15 04:33:07
---

本文展示 Agora 极速直播产品的计费方式。

<div class="alert note">如果你已与我们的销售签约，则实际计费信息以合同为准。</div>

## 概述

Agora 会按月统计你的开发者账户下所有项目产生的费用。

当你使用 Agora 音频/视频 SDK （不包括 Agora RTC 小程序 SDK）在你的项目中实现了音视频直播后，Agora 会收取实时音视频费用，并按月发布账单、进行扣款。详见[账单、扣费与账户冻结](https://docs.agora.io/cn/faq/billing_account)。

<div class="alert note">
	<ul>
		<li>Agora 给予每个 Agora 开发者账号每个月一万分钟的免费时长。具体的扣除顺序和适用范围请参考<a href="https://docs.agora.io/cn/faq/billing_free">每月一万分钟免费说明</a>。</li>
		<li>当用户通过集成了 Agora 音频/视频 SDK 的 app 加入直播频道后，默认会订阅频道内所有用户发送的音视频流，并产生相应的用量。</li>
	</ul>
</div>

## 费用组成

Agora 根据你的项目所产生的音视频会话时长用量进行计费。每月结束时，Agora 会把你的项目当月产生的音频和各档位的视频时长用量（单位为秒）分别相加，再换算成分钟数（**向上取整**），乘以相应的单价，得出本月费用。

**费用 = 音频费用 + 视频费用 = 音频时长用量 × 音频单价 + 视频时长用量 × 视频单价**

<div class="alert note"><ul><li>同一时间内，如果用户既订阅了音频流，也订阅了视频流，则只计算视频用量，收取视频费用。</li><li>如果会话中只有一个用户，则该会话的用量记为音频用量，仅收取音频费用。</li></ul></div>

### 时长用量

每个会话的时长用量，是这个会话中**所有用户产生的时长用量之和**。

针对每个用户，Agora 从其加入 RTC 频道开始计算时长用量，到离开这个频道结束计量。**用量的精度为秒**。

根据用户在会话中是否订阅视频流，时长用量可分为如下两类：

- **视频时长用量**：如果用户成功订阅了视频流，则产生视频用量。
- **音频时长用量**：如果用户没有订阅视频流，则无论其是否订阅了音频流，都会产生音频用量。

<div class="alert note">由于 Agora 采用按频道人数计时的方式，如果用户同时订阅多路音频流和视频流，则其订阅的时长用量不会叠加计算。详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/faq/billing_basis">按频道人数计时和按流计时有什么区别？</a >
<ul><li>如果用户 A 同时订阅用户 B 和 C 的视频流 10 分钟，则用户 A 仅产生 10 分钟的视频用量。</li><li>如果用户 A 同时订阅用户 B 的音频流和用户 C 的视频流 10 分钟，则用户 A 也仅产生 10 分钟的视频用量。</li></ul>
</div>

### 单价

在极速直播中，Agora 根据用户角色和用户等级收取不同的费用。

- **主播**：当用户角色为主播时，其音视频用量按<a href="#premium">互动直播产品的单价</a>计费。
- **观众**：
  - **极速直播观众**：当用户角色为观众且用户等级为低延时时，该用户为极速直播观众，其音视频用量按<a href="#standard">极速直播产品的单价</a>计费。
  - **互动直播观众**：当用户角色为观众且用户等级为超低延时时，该用户为互动直播观众，其音视频用量按<a href="#premium">互动直播产品的单价</a>计费。

<a name="standard"></a>

#### 极速直播产品单价

当极速直播观众订阅音视频时，单价如下：

<table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>单价</th>
                    <th>档位</th>
                    <th>单价（元/千分钟）</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>音频</td>
                    <td>无</td>
                    <td>4</td>
                </tr>
                <tr>
                    <td rowspan="4">视频</td>
                    <td>高清（HD）</td>
                    <td>14</td>
                </tr>
                <tr>
                    <td>全高清（Full HD）</td>
                    <td>32</td>
                </tr>
                <tr>
                    <td>2K</td>
                    <td>56</td>
                </tr>
                <tr>
                    <td>2K+</td>
                    <td>126</td>
                </tr>
            </tbody>
        </table>

<a name="premium"></a>

#### 互动直播产品单价

当主播或互动直播观众订阅音视频时，单价如下：

<table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>单价</th>
                    <th>档位</th>
                    <th>单价（元/千分钟）</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>音频</td>
                    <td>无</td>
                    <td>7</td>
                </tr>
                <tr>
                    <td rowspan="4">视频</td>
                    <td>高清（HD）</td>
                    <td>28</td>
                </tr>
                <tr>
                    <td>全高清（Full HD）</td>
                    <td>63</td>
                </tr>
                <tr>
                    <td>2K</td>
                    <td>112</td>
                </tr>
                <tr>
                    <td>2K+</td>
                    <td>252</td>
                </tr>
            </tbody>
        </table>

<div class="alert note">关于互动直播产品的详细计费说明，参见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/billing_rtc?platform=Android">互动直播实时音视频计费说明</a >。</div>

#### 视频档位与集合分辨率

Agora 根据用户成功订阅的所有视频流的分辨率之和，即“**集合分辨率**”，将视频划分为如下四个档位：

| 档位              | 用户订阅视频的集合分辨率                                           |
| :---------------- | :----------------------------------------------------------------- |
| 高清（HD）        | 集合分辨率 ≤ 921,600（1280 × 720）                                 |
| 全高清（Full HD） | 921,600（1280 × 720）＜ 集合分辨率 ≤ 2,073,600（1920 × 1080）      |
| 2K                | 2,073,600 (1920 × 1080) ＜ 集合分辨率 ≤ 3,686,400 （2560 × 1440）  |
| 2K+               | 3,686,400 （2560 × 1440）＜ 集合分辨率 ≤ 8,847,360 （4096 × 2160） |

例如，用户 A 同时订阅两路分辨率为 960 × 720 的视频流，则该用户订阅的视频集合分辨率为 960 × 720 + 960 × 720 = 1,382,400，其视频用量按全高清（Full HD）档位单价计费。

## 计费示例

本节展示如何统计单个项目下整月的音频和各档位视频的时长用量，并根据相应单价，计算总费用。

### 场景描述

假设你的 Agora 开发者账号下有一个启用的项目，项目名为 Test，该项目使用 Agora RTC SDK 实现了实时音视频功能。

该项目在 2021 年 2 月 1 日 到 2 月 28 日之间产生的会话如下：

#### 会话一：单主播视频直播

2021 年 2 月 8 日：A 在频道内进行视频直播 1,808 秒，三名极速直播观众 B、C、D 订阅 A 的视频流，A 的视频分辨率为 1280 × 720。

时长用量统计：该会话中 A 没有订阅行为，因此仅产生音频用量；三名极速直播观众订阅 A 的视频流，且订阅的视频分辨率为 1280 × 720，属于高清（HD）档位，因此产生了高清（HD）档位的视频用量。

| 会话        | 音频  | 高清（HD）视频    | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :---------- | :---- | :---------------- | :-------------------- | :------ | :------- |
| 用量 （秒） | 1,808 | 1,808 × 3 = 5,424 | 0                     | 0       | 0        |

#### 会话二：连麦视频直播

2021 年 2 月 11 日：A 在频道内进行单人视频直播 568 秒，两名极速直播观众 B 和 C 同时订阅 A 的视频流，A 的视频分辨率为 1920 x 1080。568 秒后观众 C 上麦，与 A 视频连麦 600 秒，A 和 C 互相订阅彼此的视频流，极速直播观众 B 同时订阅 A 和 C 的视频流，A 的视频分辨率不变，C 的视频分辨率为 1280 x 720。

时长用量统计：该会话中 A、B、C 都产生了用量。

- A 产生的用量

  - 前 568 秒：由于没有订阅行为，因此只产生了 568 秒的音频用量。
  - 后 600 秒：订阅 C 产生了 600 秒的视频用量，且视频分辨率为 1280 × 720，属于高清（HD）视频。

  由于 A 的用户角色始终为主播，其用量按互动直播单价计费。

- B 产生的用量

  - 前 568 秒：订阅 A 的视频，视频分辨率为 1920 × 1080，属于全高清（Full HD）视频，因此产生了 568 秒的全高清（Full HD）视频用量。
  - 后 600 秒：订阅 A 和 C 的视频，视频集合分辨率 = 1920 × 1080 + 1280 × 720 = 2,995,200，属于 2K 视频，因此产生了 600 秒的 2K 视频用量。

  在此会话中，B 的用户角色始终为极速直播观众，其用量按极速直播产品单价计费。

- C 产生的用量

  - 前 568 秒：订阅 A 的视频，视频分辨率为 1920 × 1080，属于全高清（Full HD）视频，因此产生了 568 秒的全高清（Full HD）视频用量。
  - 后 600 秒：订阅 A 产生了 600 秒的视频用量，且视频分辨率为 1920 x 1080，属于全高清（Full HD）视频。

  在此会话中，前 568 秒，C 的用户角色为极速直播观众，其用量按极速直播产品单价计费；后 600 秒，C 的用户角色切换为主播，其用量按互动直播单价计费。

| 会话                | 音频 | 高清（HD）视频 | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :------------------ | :--- | :------------- | :-------------------- | :------ | :------- |
| 极速直播用量 （秒） | 0    | 0              | 568 + 568 = 1,136     | 600     | 0        |
| 互动直播用量 （秒） | 568  | 600            | 600                   | 0       | 0        |

### 费用计算

#### 极速直播费用

<table class="relative-table wrapped confluenceTable" resolved=""
                style="border-collapse: collapse; margin: 0px; overflow-x: auto; width: 554.4px;">
                <colgroup span="1">
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh" rowspan="2"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            colspan="1">日期</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">极速直播实际用量 （秒）</th>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">音频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">HD 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Full HD</p>
                            <p style="margin: 10px 0px 0px; padding: 0px;">视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+ 视频</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-08</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">1,808</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">5,424</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-11</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">1,136</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">月累计用量</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,808</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">5,424</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,136</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>入账用量</strong></td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">31 <br />分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">91 <br />分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">19 <br />分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10 <br />分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0 <br />分钟</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">计费</p>
                            <p style="margin: 10px 0px 0px; padding: 0px;">(元)</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(31/1000 ) × 4= 0.124</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(91/1000) × 14 = 1.274</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(19/1000) × 32 = 0.608</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(10/1000) × 56 = 0.56</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">合计 （元）</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: right; min-width: 8px;"
                            rowspan="1">
                            <p><strong style="text-align: right;">2.57</strong></p>
                            <p>（0.124 + 1.274 + 0.608 + 0.56 = 2.566 ≈ 2.57）</p>
                        </td>
                    </tr>
                </tbody>
            </table>

#### 互动直播费用

<table class="relative-table wrapped confluenceTable" resolved=""
                style="border-collapse: collapse; margin: 0px; overflow-x: auto; width: 554.4px;">
                <colgroup span="1">
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh" rowspan="2"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            colspan="1">日期</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">互动直播实际用量 （秒）</th>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">音频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">HD 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Full HD <br />视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+ 视频</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-08</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-11</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">568</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">月累计用量</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">568</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>入账用量</strong></td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">10 <br />分钟</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">10 <br />分钟</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">10 <br />分钟</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0 <br />分钟</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0 <br />分钟</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">计费</p>
                            <p style="margin: 10px 0px 0px; padding: 0px;">(元)</p>
                        </td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">(10/1000 ) × 7= 0.07</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">(10/1000) × 28 = 0.28</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">(10/1000) × 63 = 0.63</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">合计 （元）</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><b>0.98</b><br />（0.07 + 0.28 + 0.63 = 0.98）</td>
                    </tr>
                </tbody>
            </table>

<div class="alert note"><ul><li>Agora 会将每月的总费用四舍五入，并保留两位小数点。</li><li>Agora 给予每个 Agora 开发者账号每个月一万分钟的免费时长。如果上述示例中的 Agora 开发者账号使用的月累计分钟数未超过 10000 分钟，则实际该月免费。</li></ul></div>

## 注意事项

### 时长用量精度

Agora 在每月底结算整月用量时，会把当月产生的音频和各档位的视频用量（单位为秒）分别相加，然后除以 60，分别得出音频分钟数和各档位的视频分钟数，最后**向上**取整。例如一个月产生了 59 秒的音频时长用量，则音频用量数据计为 1 分钟；如果产生了 61 秒的视频时长用量，则视频用量数据计为 2 分钟。月用量误差在 1 分钟内。

### 双流分辨率

双流模式下，用户的分辨率计算方式如下：

- 如果订阅的是大流，则用户的集合分辨率根据发送端设置的大流分辨率计算。
- 如果订阅的是小流，则用户的集合分辨率根据用户实际收到的分辨率计算。

### 屏幕共享流的分辨率

如果你的场景中涉及屏幕共享，则屏幕共享流的视频单价以你在 `ScreenCaptureParameters` 中设置的视频分辨率档位为准。详见以下类中的说明：

- Windows: [`ScreenCaptureParameters`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1rtc_1_1_screen_capture_parameters.html)
- macOS: [`AgoraScreenCaptureParameters`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html)

<div class="alert note">在 Web 端，由于设备和浏览器的限制，部分浏览器对设置的屏幕属性不一定能全部适配。这种情况下浏览器会自动调整分辨率，计费也将按照实际分辨率计算。详见 <a href="https://docs.agora.io/cn/Video/API%20Reference/web/v3.3.0/interfaces/agorartc.stream.html#setscreenprofile">setScreenProfile</a >。
</div>

### 分辨率校准

计算集合分辨率时，我们会将分辨率为 225,280（640 × 352）的视频流按分辨率 640 × 360 计算。

## 常见问题

<details><summary><font color="#3ab7f8">为什么只订阅了视频，却在账单中看到了音频分钟数？</font></summary>
<ul>
	<li>如果频道中有用户只发布，却没有订阅任何视频流，那么该用户的集合分辨率为 0，其产生的分钟数就是音频分钟数。</li>
	<li>如果因网络等原因导致某用户没有收到视频，则此刻该用户的集合分辨率计为 0，其对应的分钟数也是音频分钟数。</li>
</ul>
</details>
<details><summary><font color="#3ab7f8">为什么所有用户订阅的都是 360 × 640 的视频流，我的单价却被定在超高清档？</font></summary>
视频档位基于集合分辨率而定，即对你订阅的流的分辨率进行求和。所以，你订阅的视频流越多，你的集合分辨率越有可能超过 1,280 x 720 的超清档。
</details>
<details><summary><font color="#3ab7f8">我看到的音频服务使用时间是针对某个用户的吗？</font></summary>
不是。Agora 提供的音频分钟数不是某个用户的分钟数，也不是某一个频道内所有用户的分钟数，而是你的账户下所有频道内所有用户的分钟数的总和。
</details>

## 相关文档

- [每月一万分钟免费声明](https://docs.agora.io/cn/faq/billing_free)
- [账单、扣费与账户冻结](https://docs.agora.io/cn/faq/billing_account)
- [如何获取用户的通话时长？](https://docs.agora.io/cn/faq/business_billing)
