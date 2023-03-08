灵动课堂是声网提供的在线互动课堂解决方案，分为低代码（Low-code）和无代码（No-code）方案。

低代码方案又称 aPaaS 方案，将声网 RTC SDK、声网 RTM SDK、声网互动白板服务和声网云端录制服务等产品的复杂 API 进行模块化封装。相比使用多个 SDK 和云服务产品搭建教育场景的 PaaS 方案，使用 aPaaS 方案，开发者可以无需深度学习音视频的复杂核心逻辑，低代码（Low-code）即可快速接入灵动课堂、上线在线互动课堂，极大地降低了节省了开发时间，降低了开发门槛。

![](https://web-cdn.agora.io/docs-files/1654068243051)

无代码方案又称秒搭，是声网为教育场景推出的可视化无代码开发平台，旨在让用户快速、轻松地构建出教育场景的应用程序。通过秒搭内置的场景模板、专业的功能组件、丰富的主题色，你可以以拖拽、点击等简单方式设计自己的应用程序，并通过预览和下载源代码等功能来进一步调整应用和本地部署。

![](https://web-cdn.agora.io/docs-files/1666602776342)

不管使用 aPaaS 方案还是秒搭，灵动课堂均覆盖 1 对 1 互动教学、在线互动小班课、互动直播大班课等多种班型，支持老师、学生、助教等多种课堂角色，具备实时音视频互动、实时消息互动、互动白板、实时录制、屏幕共享、教学组件（如云盘、奖杯）等丰富功能，支持通过云服务对课堂和用户等进行管理。此外，灵动课堂 aPaaS 方案还支持自定义组件，支持业务功能的灵活拓展，可以与教学机构的业务系统（用户系统和排课系统）无缝对接。


## aPaaS 方案优势

~a27d6b70-a96d-11eb-b31a-57565fd331e4~

## 无代码方案优势

相比市面上常见的无代码解决方案，秒搭有诸多优点和相似之处。详情对比如下：

|   | 秒搭   | 其他无代码解决方案   |
|-----|-----|-----|
| 产品定位    | 帮助开发者和普通用户快速搭建内置业务所需功能的在线课堂应用，部署步骤较少，因此可以用于生产上线 | 帮助开发者快速搭建在线互动应用，但业务功能无法直接使用，部署集成步骤较多，因此主要用于演示|
| 覆盖场景        | 教育场景                                    | 在线会议等通用音视频互动场景|
| 受众 | <li>开发者</li><li>开发能力弱的人</li> | 开发者  |
| 行业垂直度 | 深入教育行业，垂直性更强 | 在线会议等通用音视频互动行业，垂直性一般 |
| 产品功能     | 深入教育行业，既提供通用音视频互动场景的应用功能，也提供丰富的教学组件：<li>音视频互动</li><li>消息聊天</li><li>屏幕共享</li><li>录制</li><li>互动白板</li><li>课件云盘</li><li>拆分课堂为超级小班课</li><li>其他常见教学组件（如课堂奖励、答题器）</li>| 提供在线会议等通用音视频互动场景的应用功能：<li>音视频互动</li><li>消息聊天</li><li>屏幕共享</li><li>录制</li> |
| 编辑配置选项                 | <li>模板</li><li>功能模块</li><li>主题色设置</li>    | <li>模板</li><li>用户角色</li><li>单一功能，还需根据业务再开发</li><li>主题色设置</li>    |
| 其他差异点                       | <li>可视化配置</li><li>功能模块可拖拽</li><li>提供全量源代码和样式源代码</li> | <li>有配置项，但不能可视化配置</li><li>功能模块不可拖拽</li><li>只提供样式代码源代码  |

## 班型说明

灵动课堂支持以下班型：

| <span style="white-space:nowrap;">班型&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> | 说明                                                         | 适用场景                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 1 对 1 互动教学                                              | 1 位老师对 1 名学生进行专属在线辅导教学。                    | 适用于 1 对 1 VIP 个性化辅导教学。                           |
| 在线互动小班课                                               | 1 位老师进行在线教学，多名学生实时观看和收听。上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。小班课中课堂人数上限为 200，如需更多，请联系 sales@agora.io。 | 适用于强调同伴学习、互动性和参与性的教学场景，班级人数一般不超过 20 人。 |
| 互动直播大班课                                               | 1 位老师进行在线教学，多名学生实时观看和收听。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。大班课中课堂人数上限为 5,000，如需更多，请联系 sales@agora.io。 | 常用于公开课或引流课，以老师讲授为主，助教老师辅助答疑。     |

## 课堂角色说明

灵动课堂支持以下角色：

| 课堂角色 | Android | iOS | Web | macOS | Windows | H5 |
| :------- | :------- | :--- | :--- | :----- | :------- | -------- |
| 老师   | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font>    | <font color="green">✔</font>      | <font color="green">✔</font>        | <font color="red">✘</font> |
| 学生   | <font color="green">✔</font>        | <font color="green">✔</font>    | <font color="green">✔</font>    | <font color="green">✔</font>      | <font color="green">✔</font>        | <font color="green">✔</font> |
| 助教   | <font color="red">✘</font>        | <font color="red">✘</font>    | <font color="green">✔</font>    | <font color="green">✔</font>      | <font color="green">✔</font>        | <font color="red">✘</font> |
| 观众 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |

<div class="alert info">灵动课堂 macOS 和 Windows 客户端基于 Electron 框架开发。</div>

## 课堂展示

灵动课堂主要包含导航栏、白板、音视频、实时消息四大区域。

### 桌面端

![](https://web-cdn.agora.io/docs-files/1640784550634)

### 移动端

![](https://web-cdn.agora.io/docs-files/1640784215154)

## 计费说明

根据你的实际用量，声网会分别收取实时音视频、云信令（原实时消息）、云端录制和互动白板的费用。具体收费规则请参考以下文档：

-   [实时音视频计费说明](/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
-   [云信令计费说明](/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
-   [页面录制计费说明](/cn/cloud-recording/billing_cloud_recording_web?platform=RESTful)
-   [互动白板计费说明](/cn/whiteboard/billing_whiteboard?platform=Web)
-   [IM 计费说明](https://www.easemob.com/pricing/im)