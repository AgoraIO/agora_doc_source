即时通讯 IM 为开发者提供高可靠、低时延、高并发、安全、全球化的通信云服务。IM 提供多平台 SDK 支持，包括 Android、iOS、Web 和小程序，同时，提供服务端 REST API，支持在单聊、群聊、聊天室等聊天场景中实现消息、群组、聊天室、用户属性、用户关系、推送、在线状态订阅、消息表情回复、消息审核、子区以及音视频通话等配套功能，帮助开发者快速构建端到端的通信场景。

## 功能列表

即时通讯 IM 提供以下功能：

### 消息管理

即时通讯 IM 提供单聊和多人群聊功能，支持文本、表情、图片、语音、视频、地理位置、文件，以及弹幕、红包和礼物等自定义消息类型。即时通讯 IM 的消息管理功能包括：
- 发送、接收和撤回消息消息；
- 管理本地消息数据，例如导入、插入和更新消息；
- 管理服务的消息，例如获取和删除服务端的消息；
- 管理消息回执，包括单聊和群聊消息回执；
- 消息翻译，即支持在发送或接收消息时对文本消息进行按需翻译或自动翻译。

### 单聊

即时通讯 IM 支持两个用户进行一对一聊天。用户可以发送、接收或撤回消息、以及发送已读回执。单聊支持丰富的消息类型，并支持本地和服务器端的消息管理。

### 群组管理

即时通讯 IM 提供全面的群组管理能，包括以下功能：

- 群组管理：支持创建和解散群组以及获取群组详情、群组列表和群成员列表等。
- 群成员管理：群组中的用户分为普通成员、管理员或群主。权限因角色而异。支持用户加入和退出群组，提供群组白名单、黑名单以及禁言功能。
- 群属性管理：支持修改群组名称和描述、获取和更新群组公告以及管理群组共享文件等。

### 聊天室管理

即时通讯 IM 提供全面的聊天室管理能，包括以下功能：

- 聊天室管理：支持创建和解散群组以及获取聊天室列表和详情等。
- 聊天室成员管理：聊天室中的用户分为普通成员、管理员或聊天室所有者，权限因角色而异。支持用户加入和退出聊天室，提供聊天室白名单、黑名单以及禁言功能。
- 聊天室属性管理：支持获取和修改群组名称、描述和公告以及管理聊天室自定义属性（key-value）等。

### 用户管理

即时通讯 IM 提供用户信息存储、用户身份管理等用户体系管理能力，如自定义头像、昵称，以及好友关系、黑名单管理等。

### 离线消息推送

离线消息推送指当应用在后台运行或进程被杀掉时，用户处于离线状态，新消息在发送至声网服务器后，会被转发至第三方推送服务器进行推送，以确保该消息依然可以送达客户端。即时通讯服务为开发者提供低延时、高送达、高并发、不侵犯用户个人数据的第三方厂商推送服务，支持在 Android 端使用谷歌云消息传递服务（FCM）等服务实现，在 iOS 端使用苹果推送通知服务（APNs）实现。

### 声网即时推送

声网即时推送为开发者提供低延时、高送达、高并发、不侵犯用户个人数据的即时推送服务。通过该推送服务，你可以主动为用户推送系统消息通知、活动促销通知、社交互动通知以及内容订阅等信息，有效提升活跃度，增加用户粘性，实现业务增长。

### 在线状态订阅

支持在即时通讯应用中发布、订阅和查询用户的在线状态（Presence）。

### 消息表情回复 Reaction

即时通讯 IM 提供消息表情回复（Reaction）功能。用户可以在单聊和群聊中对消息添加、删除表情。表情可以直观地表达情绪，利用 Reaction 可以提升用户的使用体验。同时在群组中，利用 Reaction 可以发起投票，根据不同表情的追加数量来确认投票。

### 子区

子区是群组成员的子集，是支持多人沟通的即时通讯系统。即时通讯 IM 支持在实时互动 app 中创建和管理子区，并实现子区相关功能。

### 消息审核（举报）

即时通讯 IM 支持用户举报违规消息。当服务器端审核服务收到举报消息后，会将举报消息存储到数据库，并提供接口供声网控制台后台搜索展示。审核员可以对举报记录进行相应处理。

## 产品优势

即时通讯 IM 主要具备以下优势：

### 全球部署

即时通讯 IM 在全球设有中国、新加坡、美国和德国四大数据中心，以及超过 200 个边缘加速节点，网络服务覆盖全球 200 多个国家和地区。

### 超低延时

全球范围内的平均延时小于 200 毫秒，单个区域内的平均延时小于 100 毫秒。

### 高并发

支持同时在线人数无上限，在聊天室内可达到亿级消息并发。

### 高可靠性

- 即时通讯支持同城三数据中心的部署架构，提供 SLA 质量保证，登录成功率 > 99%，全年可用时间高达 99.95%。
- 优异的弱网对抗能力，保证在 70% 丢包情况下，消息到达率仍然为 100%。

### 高安全性

使用 TLS/SSL 和文件加密构建安全的聊天应用程序，并允许用户删除个人数据确保数据隐私合规性。

## 平台支持

即时通讯支持 Android、iOS、Web 和微信小程序平台，而且各平台之间可互通。下表为即时通讯支持的各平台版本：

| 平台     | 支持的版本                                   |
| ------------ | ------------------------------------------------------------ |
| Android      | Android 5.0 或以上版本（API 级别 21 或以上）   |
| iOS          | iOS 10.0 或以上版本                                            |
| Web          | <li>Internet Explorer 9 或以上 <li>FireFox 10 或以上 <li>Chrome 54 或以上 Safari 6 或以上<li>Edge 12 或以上 <li>Opera 58 或以上<li>iOS Safari 7 或以上<li>Android Browser 4.4 (KitKat) 或以上 |
| 微信小程序      | <li>微信 App iOS 最低版本要求：6.5.8<li>微信 App Android 最低版本要求：6.5.7<li>小程序基础库最低版本要求：1.7.0   |

## 云信令与即时通讯的区别

下表从技术架构、功能定位、性能表现和应用场景方面系统比较云信令 (RTM) 和即时通信 (IM) 两款产品的差异：

|          | 云信令 (RTM)   | 即时通讯服务                         |
| :------- | :---------------- | :-------------------- |
| 技术架构 | 分布式架构，数据在边缘节点实进行交换和处理。 | 中心化架构，数据通过过中心节点交换和处理。 |
| 功能定位 | 低延迟、高并发的可靠控制信令及状态同步，优势功能在于分布式快速可靠信令、消息及状态传输。不关注消息类型、用户关系链、消息持久化存储能力。 | 全消息类型即时通讯系统，优势功能在于用户关系管理、全消息类型、群聊、历史数据存储、内容审核等。强调人与人之间的互动关系及消息内容自身的传输、存储、合规。 |
| 性能表现 | 超低延迟实时互动：< 100 ms | 低延迟即时互动：200 ms - 400 ms |
| 应用场景 |<li>在线教育场景中，师生之间通过教学胶片和其他元素进行协作互动<li>游戏中玩家状态、位置、属性等数据的实时同步<li>直播打赏<li>IoT 传感器数据上报<li>RTC 音视频会话中发起会话、麦位控制 | <li>企业办公即时通讯<li>游戏群聊<li>直播间互动聊天 |

综上所述，云信令和即时通讯的应用场景不同。即时通讯面向人人沟通场景，云信令面向设备同步场景。即时通讯提供更完善的业务功能支持。