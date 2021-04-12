本文展示 Agora 互动白板的计费方式。

<div class="alert note">如果你已与我们的销售签约，则实际计费信息以合同为准。</div>

## 概述

当你在项目中开通并使用了 Agora 互动白板，Agora 会收取费用，并按月发布账单、进行扣款。详见[账单、扣费与账户冻结](https://docs.agora.io/cn/faq/billing_account)。

## 费用组成

Agora 互动白板提供以下服务：

- 互动白板
- 白板录制
- 文档转换
  - 文档转图片
  - 文档转网页

每月结束时，Agora 会统计[你的开发者账户](https://console.agora.io/)下所有项目产生的各项互动白板服务的用量，减去每月免费额度，乘以相应的单价，将各项服务的费用相加，得出本月总费用。

**月总费用 = 互动白板费用 + 白板录制费用 + 文档转图片费用 + 文档转网页费用**

Agora 互动白板各项服务的单价、免费额度和费用计算方式如下：

<html>
    <head>
        <title></title>
    </head>
    <body>
        <div class="table-wrap">
            <table class="wrapped confluenceTable">
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh">
                            Agora 互动白板服务
                        </th>
                        <th class="confluenceTh">
                            <span>用量统计维度</span>
                        </th>
                        <th colspan="1" class="confluenceTh">
                            单价
                        </th>
                        <th colspan="1" class="confluenceTh">
                            免费额度
                        </th>
                        <th colspan="1" class="confluenceTh">
                            费用
                        </th>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                            互动白板
                        </td>
                        <td class="confluenceTd">
                            <span class="inline-comment-marker" data-ref="d806330e-d051-4722-96ac-763b59a4eb01">时长（分钟数）</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            9.6 元/千分钟
                        </td>
                        <td colspan="1" class="confluenceTd">
                            每月前 10000 分钟免费
                        </td>
                        <td colspan="1" class="confluenceTd">
                            （月累计分钟数 - 10000）× <span>9.6</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                            白板录制
                        </td>
                        <td class="confluenceTd">
                            <span>时长（分钟数）</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            12 <span>元/千分钟</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>每月前 1000 分钟免费</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>（月累计分钟数 - 1000）</span><span>×</span> <span>12</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                            文档转图片
                        </td>
                        <td class="confluenceTd">
                            页数
                        </td>
                        <td rowspan="2" class="confluenceTd">
                            3 元/千页
                        </td>
                        <td rowspan="2" class="confluenceTd">
                            <p>
                                <span style="color: rgb(0,0,0);">每月前 1000 张图片免费</span>
                            </p>
                        </td>
                        <td rowspan="2" class="confluenceTd">
                            <p>
                                (月累计转换图片页数 + <span style="letter-spacing: 0.0px;">月累计转换网页页数 <span>× 5 - 1000) <span>×</span> <span>3</span></span></span>
                            </p>
                            <p>
                                <br>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            文档转网页
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <p>
                                页数
                            </p>
                            <p>
                                <span>( 1 张网页 = 5 张图片）</span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>


<div class="alert note"><ul>
	<li>文档转网页的实际费用是文档转图片的 5 倍。在计费时，Agora 会将文档转网页的用量转换成文档转图片的用量，即文档转网页总页数 × 5。</li>
	<li>文档转换服务也可以按 QPS 计费。如有需要，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a >。</li>
	<li>Agora 会将每月的总费用四舍五入，精确到小数点后两位。</li>
	<li>如果某项互动白板服务的月累计用量未超过免费额度，则当月该项服务免费。剩余的免费额度会在月底清零。</li></ul></div>

### 用量计算

本节介绍 Agora 互动白板各项服务的计量方式。

#### 互动白板

对于互动白板的用量，Agora 根据互动白板房间的人数计算，即每个互动白板房间的用量为该房间内**所有用户产生的时长之和**。

针对每个用户，Agora 从其加入互动白板房间开始计时，到离开这个房间结束计时。**用量的精度为分钟**。

#### 白板录制

针对白板录制，创建互动白板房间时开启了录制功能后，Agora 会从第一个用户加入该房间开始计时，到所有用户离开房间停止计时。**用量的精度为分钟**。

<div class="alert note">当房间空闲，即房间内无用户时，Agora 会自动暂停计时，当有用户加入时继续计时。</div>

#### 文档转换

针对文档转换，Agora 根据成功转换后的图片或网页页数计算用量。

<div class="alert note"><ul>
	<li>在计费时，Agora 会将文档转网页的用量转换成文档转图片的用量，即文档转网页总页数 × 5。</li>
	<li>如果文档转换任务失败，则 Agora 不会统计该任务产生的用量。你可以调用<a href="/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）">互动白板服务端 RESTful API</a > 查询文档转换任务的进度。</li></ul></div>

### 用量查看

Agora 控制台提供产品用量查看功能，你可以参照以下步骤查看互动白板用量：

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏的**产品用量**按钮。

2. 点击页面左上角**聚合用量**旁的箭头 ![img](https://web-cdn.agora.io/docs-files/1607311735894)，在下拉框中选择需要查看的项目名称。

3. 在指定项目下，点击**互动白板**下的**分钟数**，设置需要查看的时间段，查看互动白板的时长用量。
   
<div class="alert note"><ul>
	<li>时间段范围不能超过 12 个月。</li>
	<li>角色为管理员或财务的 Agora 开发者账户拥有查看用量统计页面的权限。</li>
	<li>Agora 控制台展示的用量仅供参考，实际用量以账单为准。</li></ul></div>


## 计费示例

本节展示如何统计一个 Agora 开发者账号下整月的互动白板用量，并根据相应单价，计算总费用。

### 场景描述

假设你的 Agora 开发者账号下有一个启用了互动白板的项目，项目名为 Test，该项目在 2021 年 2 月 1 日 到 2 月 28 日之间使用互动白板服务的情况如下：

#### 场景一

2021 年 2 月 8 日，用户 A 和用户 B 同时加入互动白板房间，用户 A 对用户 B 进行 45 分钟的教学。在此期间，用户 A 使用文档转换服务成功将 30 页的 PDF 转换为 PNG 图片并在白板中展示。课程结束后，用户 A 和用户 B 同时离开白板房间。

用量统计如下：

| 计费项     | 用量                                    |
| :--------- | :-------------------------------------- |
| 互动白板   | <li>用户 A：45 分钟 <li>用户 B：45 分钟 |
| 文档转图片 | 30 页                                   |

####  场景二

2021 年 2 月 11 日，用户 A 加入互动白板房间进行在线公开授课，并使用文档转换服务成功将 50 页的动态 PPT 转换为 HTML 网页在白板中展示。200 名用户加入该房间实时观看。公开课持续 60 分钟，并使用白板录制服务录制了整个过程。

用量统计如下：

| 计费项     | 用量                                              |
| :--------- | :------------------------------------------------ |
| 互动白板   | <li>用户 A：60 分钟 <li>200 名用户：60 × 200 分钟 |
| 文档转网页 | 50 页                                             |
| 白板录制   | 60 分钟                                           |

### 费用计算

<html>
    <head>
        <title></title>
    </head>
    <body>
        <div class="table-wrap">
            <table class="wrapped confluenceTable">
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th rowspan="2" class="confluenceTh">
                            日期
                        </th>
                        <th colspan="4" class="confluenceTh">
                            用量
                        </th>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            互动白板 （分钟数）
                        </td>
                        <td class="confluenceTd">
                            白板录制 （分钟数）
                        </td>
                        <td class="confluenceTd">
                            文档转图片（页数）
                        </td>
                        <td colspan="1" class="confluenceTd">
                            文档转网页（页数）
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                            2021-02-08
                        </td>
                        <td colspan="1" class="confluenceTd">
                            90
                        </td>
                        <td class="confluenceTd">
                            0
                        </td>
                        <td class="confluenceTd">
                            30
                        </td>
                        <td colspan="1" class="confluenceTd">
                            0
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            2021-02-11
                        </td>
                        <td colspan="1" class="confluenceTd">
                            12,060
                        </td>
                        <td colspan="1" class="confluenceTd">
                            60
                        </td>
                        <td colspan="1" class="confluenceTd">
                            0
                        </td>
                        <td colspan="1" class="confluenceTd">
                            50
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            月累计用量
                        </td>
                        <td colspan="1" class="confluenceTd">
                            12,150
                        </td>
                        <td colspan="1" class="confluenceTd">
                            60
                        </td>
                        <td colspan="1" class="confluenceTd">
                            30
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>50</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            入账用量
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>12,150</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>60</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>30</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>50 <span>× 5 = 250</span></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            免费额度
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span class="inline-comment-marker" data-ref="4f39e4e5-9829-4e12-aaf0-d97b137ddbe8">10,000</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            1,000
                        </td>
                        <td colspan="2" style="text-align: center;" class="confluenceTd">
                            1,000
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            计费（元）
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <span>(12,150 - <span><span class="inline-comment-marker" data-ref="1d5317e1-b86e-4336-a320-b7abaae269b6">10,000</span>)/<span class="inline-comment-marker" data-ref="5babcb2e-dfe5-444a-85d9-4407fe57f4d3">1,000</span> <span>× <span>9.6 = 20.64</span></span></span></span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                            0
                        </td>
                        <td colspan="2" class="confluenceTd">
                            0
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            合计（元）
                        </td>
                        <td colspan="4" style="text-align: right;" class="confluenceTd">
                            <span>20.64</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>


## 常见问题

<details><summary><font color="#3ab7f8">如果直播结束，但用户没有退出房间，是否会一直计费？</font></summary>
会计费，因为白板底层只根据是否有活跃长连接来计算用量。因此，为避免产生额外费用，Agora 建议：
<ul>
	<li>在用户离开房间时，调用 <code>disconnect()</code> 断开与当前房间的连接，并确保收到 <code>onPhaseChanged(disconnected)</code> 回调。</li>
	<li>直播结束时在 app 服务端调用 <a href="https://docs.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#%E5%B0%81%E7%A6%81%E6%88%BF%E9%97%B4-%EF%BC%88patch%EF%BC%89">封禁房间 （PATCH）API</a > 强制所有人退出房间。</li>
</ul>
</details>

<details><summary><font color="#3ab7f8">是否从创建房间就开始计费？</font></summary>
不是，创建的房间中没有用户时不计时，因此不会产生费用。
</details>

<details><summary><font color="#3ab7f8">使用不同的模式加入房间，是否会导致收费不同？</font></summary>
不会，无论用户是以互动模式还是订阅模式加入房间，其产生的用量和单价都一样。
</details>