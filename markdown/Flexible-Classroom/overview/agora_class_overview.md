灵动课堂是 Agora 提供的在线互动课堂 aPaaS 解决方案，将 Agora RTC SDK、Agora RTM SDK、Agora 互动白板服务和 Agora 云端录制服务等产品的复杂 API 进行模块化封装。开发者无需深度学习音视频的复杂核心逻辑，低代码 (Low-code) 即可快速接入灵动课堂、上线在线互动课堂，极大地降低了节省了开发时间，降低了开发门槛。

灵动课堂覆盖 1 对 1 互动教学、在线互动小班课、互动直播大班课等多种班型，支持老师、学生、助教等多种课堂角色，具备实时音视频互动、实时消息互动、互动白板、实时录制、屏幕共享、教学组件（如云盘、奖杯）等丰富功能，支持通过云服务对课堂和用户等进行管理。此外，灵动课堂还支持自定义 UI 和自定义组件，支持业务功能的灵活拓展，可以与教学机构的业务系统（用户系统和排课系统）无缝对接。

## 教育解决方案区别

~a27d6b70-a96d-11eb-b31a-57565fd331e4~

## 班型说明

灵动课堂支持以下班型：

| <span style="white-space:nowrap;">班型&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> | 说明                                                                                                                                                                        | 适用场景                                                                 |
| :-------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------- |
| 1 对 1 互动教学                                                                         | 1 位老师对 1 名学生进行专属在线辅导教学。                                                                                                                                   | 适用于 1 对 1 VIP 个性化辅导教学。                                       |
| 在线互动小班课                                                                          | 1 位老师进行在线教学，多名学生实时观看和收听。上课过程中，老师可邀请学生“上台”发言，与老师进行实时音视频互动。小班课中课堂人数上限为 200，如需更多，请联系 sales@agora.io。 | 适用于强调同伴学习、互动性和参与性的教学场景，班级人数一般不超过 20 人。 |
| 互动直播大班课                                                                          | 1 位老师进行在线教学，多名学生实时观看和收听。上课过程中，学生可“举手”请求发言，与老师进行实时音视频互动。大班课中课堂人数上限为 5,000，如需更多，请联系 sales@agora.io。   | 常用于公开课或引流课，以老师讲授为主，助教老师辅助答疑。                 |

## 课堂角色说明

灵动课堂支持以下角色：

| 课堂角色 | Android                      | iOS                          | Web                          | macOS                        | Windows                      | H5                           |
| :------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- | ---------------------------- |
| 老师     | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 学生     | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| 助教     | <font color="red">✘</font>   | <font color="red">✘</font>   | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 观众     | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |

<div class="alert info">灵动课堂 macOS 和 Windows 客户端基于 Electron 框架开发。</div>

## 课堂展示

灵动课堂主要包含导航栏、白板、音视频、实时消息四大区域。

### 桌面端

![](https://web-cdn.agora.io/docs-files/1640784550634)

### 移动端

![](https://web-cdn.agora.io/docs-files/1640784215154)

## 计费说明

根据你的实际用量，Agora 会分别收取实时音视频、云信令（原实时消息）、云端录制和互动白板的费用。具体收费规则请参考以下文档：

-   [实时音视频计费说明](/cn/Interactive%20Broadcast/billing_rtc?platform=Android)
-   [云信令计费说明](/cn/Real-time-Messaging/billing_rtm?platform=All%20Platforms)
-   [页面录制计费说明](/cn/cloud-recording/billing_cloud_recording_web?platform=RESTful)
-   [互动白板计费说明](/cn/whiteboard/billing_whiteboard?platform=Web)
-   [IM 计费说明](https://www.easemob.com/pricing/im)
