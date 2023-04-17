灵动课堂是声网提供的在线互动课堂解决方案，分为低代码（Low-code）和无代码（No-code）方案。

低代码方案又称 aPaaS 方案，将声网 RTC SDK、声网 RTM SDK、声网互动白板服务和声网云端录制服务等产品的复杂 API 进行模块化封装。相比使用多个 SDK 和云服务产品搭建教育场景的 PaaS 方案，使用 aPaaS 方案，开发者可以无需深度学习音视频的复杂核心逻辑，低代码（Low-code）即可快速接入灵动课堂、上线在线互动课堂，极大地节省了开发时间，降低了开发门槛。

![](https://web-cdn.agora.io/docs-files/1681289544119)

无代码方案又称秒搭，是声网为教育场景推出的可视化无代码开发平台，旨在让用户快速、轻松地构建出教育场景的应用程序。通过秒搭内置的场景模板、专业的功能组件、丰富的主题色，你可以以拖拽、点击等简单方式设计自己的应用程序，并通过预览和下载源代码等功能来进一步调整应用和本地部署。

![](https://web-cdn.agora.io/docs-files/1681289558187)

不管使用 aPaaS 方案还是秒搭，灵动课堂均覆盖 1 对 1 互动教学、在线互动小班课、互动直播大班课等多种班型，支持老师、学生、助教等多种课堂角色，具备实时音视频互动、实时消息互动、互动白板、实时录制、屏幕共享、教学组件（如云盘、奖杯）等丰富功能，支持通过云服务对课堂和用户等进行管理。此外，灵动课堂 aPaaS 方案还支持自定义组件，支持业务功能的灵活拓展，可以与教学机构的业务系统（用户系统和排课系统）无缝对接。


## 方案优势

声网针对在线互动课堂提供 No-Code(无代码)、Low-Code（低代码）、Full-Code（全代码） 三种解决方案。下表列出这三种解决方案的详细区别：


|      解决方案        | No-Code                  | Low-Code         | Full-Code     |
| :----------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 方案介绍     | 使用声网灵动课堂预设的教学场景模版，搭建个性化的在线互动教学场景。 | 使用声网灵动课堂来实现在线互动教学场景。                     | 分别集成声网 RTC SDK、声网 RTM SDK、声网互动白板 SDK 和声网云端录制服务来搭建在线互动教学场景。 |
| 适用客户     | 适用于开发能力较弱、仅对UI有简单定制化需求的客户。           | 适用于开发资源有限、排期紧、需要快速上线在线互动教学场景、对UI和功能有定制化需求的客户。 | 适用于开发资源充足、对定制化需求较高的客户。                 |
| 开发成本     | 极低                                                         | 低                                                           | 高                                                           |
| 上线时间     | 最短10分钟                                                   | 最短 15 分钟                                                 | 1 个月至 3 个月                                              |
| 实现功能     | <ul><li>提供各类常用教学场景模版，支持个性化调整UI和教学组件。</li><li>提供一键云端部署，支持客户快速上线业务</li></li></ul> | <ul><li>提供课堂内的实时互动体验，支持实时音视频、实时消息、互动白板、实时录制、屏幕共享等核心功能。</li><li>提供灵动课堂云服务用于课堂和用户管理。</li><li>支持业务功能的灵活扩展，能够与教学机构的用户系统和排课系统无缝对接。</li></ul> | 客户自行实现实时音视频、实时消息、互动白板等功能。           |
| 可拓展性     | 弱                                                           | 较强                                                         | 强                                                           |
| 业务数据安全 | 声网不保存客户的业务数据。                                   | 声网不保存客户的业务数据。                                   | 声网不保存客户的业务数据。                                   |
| 前端 UI      | 提供的课堂 UI 简单定制化修改。如颜色、logo、背景等           | 声网提供默认的课堂 UI 且支持定制化修改。                     | 客户自行实现所有 UI。                                        |
| 平台         | <ul><li>Android</li><li>iOS</li><li>macOS</li><li>Windows</li><li>Web</li><li>Electron</li><li>H5</li></ul>      | <ul><li>Android</li><li>iOS</li><li>macOS</li><li>Windows</li><li>Web</li><li>Electron</li><li>H5</li></ul>      | 支持超过 20 个平台和框架。                                   |
| 支持场景     | 1 对 1、互动小班课、直播大班课、通用教学场景、双师课堂、在线自习室等多类教学场景 | 1 对 1 互动教学在线互动小班课互动直播大班课                  | 客户自行定义和实现任意在线互动教学场景。                     |



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

![](https://web-cdn.agora.io/docs-files/1681440834178)

### 移动端

![](https://web-cdn.agora.io/docs-files/1681440843757)


## 计费说明

根据你的实际用量，声网会分别收取实时音视频、云信令（原实时消息）、云端录制和互动白板的费用。具体收费规则请参考以下文档：

-   [实时音视频计费说明](/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
-   [云信令计费说明](/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
-   [页面录制计费说明](/cn/cloud-recording/billing_cloud_recording_web?platform=RESTful)
-   [互动白板计费说明](/cn/whiteboard/billing_whiteboard?platform=Web)
-   [IM 计费说明](https://www.easemob.com/pricing/im)