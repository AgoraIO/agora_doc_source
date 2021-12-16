---
title: 计费说明
platform: All Platforms
updatedAt: 2021-01-11 04:21:08
---
本文展示 Agora 本地服务端录制产品的计费方式。

自 2021 年 01 月起，Agora 将 HD+ 视频进一步划分为 Full HD，2K，2K+ 视频，对不同档位的视频进行差异化定价。

<div class="alert note"><ul><li>如果你已与我们的销售签约，则实际计费信息以合同为准。</li><li>如果你的录制视频用量依然按照 HD 和 HD+ 两个档位计费，关于视频档位划分和单价，详见 <a href="#HD+price">HD 和 HD+ 档位视频如何收费？</a ></li></ul>如果你已与我们的销售签约，则实际计费信息以合同为准。</div>

## 概述



Agora 会按月统计你的开发者账户下所有项目产生的费用。

当你使用 Agora 本地服务端录制 SDK 在你的项目中实现了本地服务端录制功能，如录制语音通话、视频群聊、互动直播的内容后，Agora 会收取录制费用，并按月发布账单、进行扣款。详见[账单、扣费与账户冻结](https://docs.agora.io/cn/faq/billing_account)。

<div class="alert note">Agora 给予每个 <a href="https://console.agora.io/">Agora 开发者账户</a>每个月一万分钟的免费时长。具体的扣除顺序和适用范围请参考《<a href="https://docs.agora.io/cn/faq/billing_free">每月一万分钟免费说明</a>》。</div> 





## 费用组成

每月结束时，Agora 会把你的开发者账户下所有项目整月的音频录制时长用量和各档位的视频录制时长用量（单位为秒）分别相加，再换算成分钟数（向上取整），乘以相应的单价，得出本月费用。

**费用 = 音频费用 + 视频费用 = 音频单价 × 音频时长用量 + 视频单价 × 视频时长用量**

<div class="alert note">
	<ul>
		<li>同一时间内，如果既录制了音频流，也录制了视频流，则只计算视频费用。</li>
		<li>录制过程中，频道空闲的时长也会按照空闲时长 × 音频单价计费。</li>
	</ul>
</div>


### 时长用量

针对录制服务，Agora 从开始录制计算时长用量，到结束录制停止计量。**时长用量的精度为秒**。

根据是否录制视频流，时长用量可分为如下两类：

- **视频时长用量**：录制服务在 RTC 频道内录制视频的时长，就是视频时长用量。
- **音频时长用量**：录制服务在 RTC 频道内的总时长，减去录制视频的时长后所得的剩余时间。无论是否录制了音频，都算作是音频时长用量。

<div class="alert note">如果频道内仅启动一个录制实例，同时录制多路音频流和视频流，则录制的时长用量不会叠加计算。<ul><li>如果同时录制用户 A 和 B 的视频流 10 分钟，则录制服务产生的费用就是 10 分钟视频的费用。</li><li>如果同时录制用户 A 的音频流和用户 B 的视频流 10 分钟，则录制服务产生的费用也是 10 分钟视频的费用。</li></ul>如果频道内同时启动多个录制实例，需要将所有录制实例产生的录制时长用量相加。</div>

### 单价

Agora 录制音视频单价如下：

<table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>类型</th>
                    <th>档位</th>
                    <th>单价（元/千分钟）</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>录制音频</td>
                    <td>无</td>
                    <td>7</td>
                </tr>
                <tr>
                    <td rowspan="4">录制视频</td>
                    <td>高清（HD）</td>
                    <td>28</td>
                </tr>
                <tr>
                    <td>超清（HD+）</td>
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


### 视频档位与集合分辨率

Agora 根据录制服务在某一时刻录制的所有视频分辨率之和，即“**集合分辨率**”，将视频划分为如下四个档位：

| 档位              | 录制视频的集合分辨率                              |
| :---------------- | :----------------------------------------------------------- |
| 高清（HD）        | 集合分辨率 ≤ 921,600（1280 × 720）                           |
| 全高清（Full HD） | 921,600（1280 × 720）＜ 集合分辨率 ≤ 2,073,600（1920 × 1080） |
| 2K                | 2,073,600 (1920 × 1080) ＜ 集合分辨率 ≤ 3,686,400 （2560 × 1440） |
| 2K+               | 3,686,400 （2560 × 1440）＜ 集合分辨率 ≤ 8,847,360 （4096 × 2160） |


## 计费示例

本节展示如何统计单个项目下整月的音频和各档位视频的录制时长用量，并根据相应单价，计算总费用。

### 场景描述

假设你的 Agora 开发者账号下有一个启用的项目，项目名为 Test，该项目使用 Agora 本地服务端录制 SDK 实现了录制功能。

该项目在 2021 年 2 月 1 日 到 2 月 28 日之间使用录制服务的情况如下：

#### 录制一

2021 年 2 月 4 日：四人同时加入频道，进行视频通话 6,000 秒，启动 1 个本地服务端录制实例，录制 4 路音频（仅录制音频）。

时长用量统计：该录制服务只产生了音频时长用量。

| 会话        | 音频  | 高清（HD）视频 | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :---------- | :---- | :------------- | :-------------------- | :------ | :------- |
| 用量 （秒） | 6,000 | 0              | 0                     | 0       | 0        |

#### 录制二

2021 年 2 月 9 日：四人同时加入频道，进行视频通话 6,000 秒，启动 2 个本地服务端录制实例，每个实例录制 4 路音频（仅录制音频）。

时长用量统计：该录制服务只产生了音频时长用量。

| 会话        | 音频                  | 高清（HD）视频 | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :---------- | :-------------------- | :------------- | :-------------------- | :------ | :------- |
| 用量 （秒） | 6,000 + 6,000= 12,000 | 0              | 0                     | 0       | 0        |

#### 录制三

2021 年 2 月 13 日：四人同时加入频道，进行视频通话 3,500 秒，启动 1 个本地服务端录制实例，录制 4 路音频和视频，每路视频的分辨率为 640 × 360。

时长用量统计：该录制服务产生了视频时长用量。录制的视频集合分辨率为 4 × 640 × 360 = 921,600，属于高清（HD）视频。

| 会话        | 音频 | 高清（HD）视频 | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :---------- | :--- | :------------- | :-------------------- | :------ | :------- |
| 用量 （秒） | 0    | 3,500          | 0                     | 0       | 0        |

#### 录制四

2021 年 2 月 15 日：A、B、C 三人同时加入频道，进行视频直播 1,680 秒，A、B、C 的视频分辨率分别为 640 x 360，1280 x 720，960 x 720；1,680 秒后 D 加入频道，进行视频直播 520 秒，视频分别率为 1920 x 1080。整个直播过程中，启动 1 个本地服务端录制实例，录制所有用户的音视频流。

时长用量统计：该录制服务产生了视频时长用量。

前 1,680 秒，录制的视频集合分别率 = 640 x 360 + 1280 x 720 + 960 x 720 = 1,843,200，属于全高清（Full HD）视频。

后 520 秒，录制的视频集合分辨率 = 640 x 360 + 1280 x 720 + 960 x 720 + 1920 x 1080 = 3,916,800，属于 2K+ 视频。

| 会话        | 音频 | 高清（HD）视频 | 全高清（Full HD）视频 | 2K 视频 | 2K+ 视频 |
| :---------- | :--- | :------------- | :-------------------- | :------ | :------- |
| 用量 （秒） | 0    | 0              | 1,680                 | 0       | 520      |

### 费用计算

<table class="relative-table confluenceTable" resolved=""
                style="border-collapse: collapse; margin: 0px; overflow-x: auto; letter-spacing: 0px;">
                <colgroup span="1">
                    <col style="width: 63px;" span="1" />
                    <col style="width: 94px;" span="1" />
                    <col style="width: 105px;" span="1" />
                    <col style="width: 105px;" span="1" />
                    <col style="width: 46px;" span="1" />
                    <col style="width: 105px;" span="1" />
                    <col style="width: 44px;" span="1" />
                    <col style="width: 44px;" span="1" />
                    <col style="width: 59px;" span="1" />
                    <col style="width: 44px;" span="1" />
                    <col style="width: 51px;" span="1" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh" rowspan="2"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            colspan="1">日期</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">实际用量 （秒）</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">控制台展示用量 （分钟）</th>
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
                            <p style="margin: 0px; padding: 0px;">Full HD 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2 K 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+     视频</p>
                        </td>
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
                            <p style="margin: 0px; padding: 0px;">Full HD 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2 K 视频</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2 K+ 视频</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2020-02-04</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">6,000</td>
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
                            rowspan="1">100</td>
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
                            rowspan="1" colspan="1">2020-02-09</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">12,000</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">200</td>
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
                            rowspan="1" colspan="1">2020-02-13</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">3,500</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
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
                            rowspan="1">59</td>
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
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2020-02-15</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,680</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">520</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">月用量</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">18,000</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">3,500</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,680</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">520</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">300</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">59</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>入账用量</strong></td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">300 分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">59 分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28 分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0 分钟</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9 分钟</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>控制台用量仅供参考，不用作实际计费依据。</strong></td>
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
                            rowspan="1">(300/1000 ) × 7 = 2.1</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(59/1000) × 28 = 1.652</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(28/1000) × 63 = 1.764</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(9/1000) × 252 = 2.268</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"></td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">合计 （元）</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: right; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;"><strong>7.78</strong></p>
                            <p><strong style="text-align: right;">（2.1 + 1.652 + 1.764 + 2.268 =
                                    7.784 ≈ 7.78）</strong></p>
                        </td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"></td>
                    </tr>
                </tbody>
            </table>

<div class="alert note"><ul><li>Agora 会将每月的总费用四舍五入，并保留两位小数点。</li><li>Agora 给予每个 Agora 开发者账号每个月一万分钟的免费时长。上述示例中的时长用量如果是该 Agora 开发者账号下所有项目的总时长用量，实际的费用为 0 元。</li></ul></div>



## 注意事项

### 时长用量精度

Agora 在控制台展示项目的每日用量时以分钟为单位，但在结算整月用量时，会把当月产生的音频和各档位的视频时长用量（单位为秒）分别相加，再换算成分钟数，最后向上取整。例如一个月产生了 59 秒的音频时长用量，则音频用量数据计为 1 分钟；如果产生了 61 秒的视频时长用量，则视频用量数据计为 2 分钟。月用量误差在 1 分钟内。





### 双流分辨率 

被录制用户开启双流后，录制服务器只能选取录制一路流：

- 如果录制的是大流，则集合分辨率的计算会根据被录制方设置的大流分辨率计算；
- 如果录制的是小流，则集合分辨率的计算会根据服务器实际收取到的分辨率计算。

### 分辨率校准

在计算集合分辨率时，我们会统一将所有面积为 225280 (640 x 352) 的视频流按照分辨率 (640 x 360）计算。





## 常见问题







<details>
	<summary><font color="#3ab7f8">问：采用不同的录制模式是否会导致收费不同？</font></summary>

录制的计费与录制模式无关。无论你采用单流录制模式还是合流录制模式，录制的计费仅与录制流数、录制时间以及录制集合分辨率相关。

</details>




<details>
	<summary><font color="#3ab7f8">问：录制截图功能是否单独收费？</font></summary>

录制截图功能不会单独收费。录制截图是录制功能的一种表现形式。录制服务必须加入录制频道并拉取相应的视频流才能实现截图输出，所以我们会按照录制指定用户的全时段视频来计费。

</details>




<details>
	<summary><font color="#3ab7f8">问：HD 和 HD+ 档位的视频如何收费？</font></summary>

自 2021 年 01 月起，Agora 将 HD+ 视频划分为 Full HD，2K，2K+ 视频，对不同档位的视频进行差异化定价。

如果你的视频用量依然按 HD 和 HD+ 两个档位计费，单价和视频档位划分如下：

#### 单价

Agora 录制音视频单价如下：

<table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>类型</th>
                    <th>档位</th>
                    <th>单价（元/千分钟）</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>录制音频</td>
                    <td>无</td>
                    <td>7</td>
                </tr>
                <tr>
                    <td rowspan="2">录制视频</td>
                    <td>高清（HD）</td>
                    <td>28</td>
                </tr>
                <tr>
                    <td>超清（HD+）</td>
                    <td>105</td>
                </tr>
            </tbody>
        </table>

#### 视频档位与集合分辨率

Agora 根据录制服务在某一时刻录制的所有视频分辨率之和，即“**集合分辨率**”，将划分为如下两个档位：

| 档位        | 用户订阅视频的集合分辨率            |
| :---------- | :---------------------------------- |
| 高清（HD）  | 集合分辨率 ≤ 921,600（1280 × 720）  |
| 超清（HD+） | 集合分辨率 ＞ 921,600（1280 × 720） |

</details>


## 相关文档


- [每月一万分钟免费说明](https://docs.agora.io/cn/faq/billing_free)
- [账单、扣费与账户冻结](https://docs.agora.io/cn/faq/billing_account)