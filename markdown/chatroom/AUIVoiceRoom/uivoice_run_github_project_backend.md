# UIKit 语聊房场景后台服务


## 项目简介

- 本项目基于Spring Boot框架开发, 依赖Redis/MongoDB/RTM/NCS/环信IM组件
    - Redis, 主要用于在线人数定时刷新/分布式锁方式保证数据更新的一致性
    - MongoDB, 主要用于维护房间列表
    - RTM, 存储场景数据, 消息传输通道
    - NCS, RTC频道事件回调通知, 处理人员进出/房间销毁逻辑
    - 环信 IM, 用于语聊房聊天服务

## 服务部署

### 快速体验

- > 采用Docker部署服务, 服务安装环境需要提前安装好Docker环境, 并安装最新版[docker-compose](https://docs.docker.com/compose/)部署工具
    - 可以下载安装[Docker Desktop](https://www.docker.com/products/docker-desktop/), 并已默认安装docker-compose
- 本地部署
    - > 本地启动服务前, 需要在项目根目录创建`.env`文件, 并且填入以下字段：
        - TOKEN_APPID=< Your TOKEN_APPID >
        - TOKEN_APPCERTIFICATE=< Your TOKEN_APPCERTIFICATE >
        - TOKEN_BASICAUTH_USERNAME=< Your TOKEN_BASICAUTH_USERNAME >
        - TOKEN_BASICAUTH_PASSWORD=< Your TOKEN_BASICAUTH_PASSWORD >
        - NCS_SECRET=< Your NCS_SECRET >
        - EM_AUTH_APPKEY=< Your EM_AUTH_APPKEY >
        - EM_AUTH_CLIENTID=< Your EM_AUTH_CLIENTID >
        - EM_AUTH_CLIENTSECRET=< YourEM_AUTH_CLIENTSECRET >

    字段说明如下：

| 字段名 | 字段说明                                     | 相关文档地址 |
|--|------------------------------------------|-|
| TOKEN_APPID | 声网 AppID，用于登录 RTC、RTM                    |https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E8%8E%B7%E5%8F%96-app-id|
| TOKEN_APPCERTIFICATE | 声网App证书 用于登录 RTC、RTM                     |https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E8%8E%B7%E5%8F%96-app-id |
| TOKEN_BASICAUTH_USERNAME | 声网 RESTfulAPI Basic Auth Username，用于踢人服务 |https://docportal.shengwang.cn/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms |
| TOKEN_BASICAUTH_PASSWORD | 声网 RESTfulAPI Basic Auth Password，用于踢人服务 |https://docportal.shengwang.cn/cn/Agora%20Platform/agora_console_restapi?platform=All%20Platforms |
| NCS_SECRET | 消息通知服务签名密钥，用于检验 NCS事件回调内容                |https://docportal.shengwang.cn/cn/Agora%20Platform/ncs?platform=All%20Platforms |
| EM_AUTH_APPKEY | 环信 IM AppKey，用于创建环信 IM 聊天室               |https://docs-im-beta.easemob.com/document/server-side/enable_and_configure_IM.html |
| EM_AUTH_CLIENTID | 环信 IM ClientID，用于创建环信 IM 聊天室             |https://docs-im-beta.easemob.com/document/server-side/enable_and_configure_IM.html |
| EM_AUTH_CLIENTSECRET | 环信 IM ClientSecret，用于创建环信聊天室             |https://docs-im-beta.easemob.com/document/server-side/enable_and_configure_IM.html |

    - 在当前项目根目录下执行 `docker compose up -d --build`, 会拉取相关镜像并启动Redis/MongoDB/Web服务. 如镜像拉取失败, 可配置国内镜像源解决
    - 服务启动后, 可使用 `curl http://localhost:8080/health/check` 测试
    - 如果使用App调试本地服务, 需要在App上替换对应后端服务域名为http://服务机器IP:8080, 替换域名后可以使用App体验相关服务
    - 停止服务, 执行 `docker compose down`

  > 注意! 未开启NCS消息通知, 不能自动处理人员进出和房间销毁逻辑, 如果需要开启此功能, 需开通NCS服务.

  > RTM和环信 IM 未开通, 功能体验会受限, 如需完整体验功能, 可以参考[上线部署权限开通说明](#上线部署)

### 本地开发

- Java版本推荐>=11
- 编辑器可采用 [Visual Studio Code](https://code.visualstudio.com/), 安装以下插件
    - [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (已提供本地容器开发[Dockerfile](Dockerfile_dev)文件)
    - [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
  > RTM运行依赖Linux环境
- vscode打开项目目录, 进入容器开发
- 修改配置文件[application.yml](src/main/resources/application.yml)
    - spring.data.mongodb.uri
    - spring.redis.host
    - spring.redis.password
    - ncs.secret
    - token.appId
    - token.appCertificate
    - token.basicAuth.username
    - token.basicAuth.password
    - em.auth.appKey
    - em.auth.clientId
    - em.auth.clientSecret

### 上线部署

- 正式上线前, 需要调整Redis/MongoDB等配置, 并将服务部署在网关后, 网关可提供鉴权/限流等能力, 本服务不带网关能力
- 同时还需要开通以下服务
    - RTM, [联系客服人员开通](https://www.shengwang.cn)
    - NCS, RTC频道事件回调通知, 处理人员进出/房间销毁逻辑
        - [开通消息通知服务
          ](https://docs.agora.io/cn/video-call-4.x/enable_webhook_ncs?platform=All%20Platforms)
            - 选择以下事件类型
                - channel create, 101
                - channel destroy, 102
                - broadcaster join channel, 103
                - broadcaster leave channel, 104
            - 回调地址
                - https://你的域名/v1/ncs/callback
            - 修改Secret
                - 根据配置界面提供的Secret值, 修改项目配置文件application.yml的ncs.secret
        - [频道事件回调
          ](https://docs.agora.io/cn/video-call-4.x/rtc_channel_event?platform=All%20Platforms)
    - 环信 IM，在环信 Console 控制台进行配置 [开通配置环信即时通讯 IM 服务](https://docs-im-beta.easemob.com/document/server-side/enable_and_configure_IM.html)
- 指标收集, https://您的域名:9090/metrics/prometheus, 可根据需要收集相应指标监控服务
- 服务可以部署在云平台, 比如[阿里云容器服务ACK](https://www.alibabacloud.com/zh/product/kubernetes)

## 目录结构

```
├── Dockerfile
├── Dockerfile_Dev
├── HELP.md
├── README.md
├── README_zh.md
├── docker-compose.yaml
├── init-mongo.js
├── mvn_settings.xml
├── mvnw
├── mvnw.cmd
├── pom.xml
└── src
    ├── main
    │         ├── java
    │         │         └── io
    │         │             └── agora
    │         │                 └── uikit
    │         │                     ├── Application.java
    │         │                     ├── bean
    │         │                     │         ├── domain                                        // 领域对象
    │         │                     │         ├── dto                                           // 数据传输对象
    │         │                     │         ├── entity                                        // 实体对象
    │         │                     │         ├── enums                                         // 枚举
    │         │                     │         ├── exception                                     // 异常
    │         │                     │         ├── process                                       // 业务逻辑
    │         │                     │         ├── req                                           // 请求对象
    │         │                     │         └── valid                                         // 参数校验
    │         │                     ├── config
    │         │                     │         ├── EmServiceConfig.java                          // 环信配置
    │         │                     │         ├── GlobalExceptionHandler.java                   // 全局异常处理
    │         │                     │         ├── RedisConfig.java                              // Redis 配置
    │         │                     │         ├── RtcChannelAPIClient.java                      // RTC Channel API 客户端
    │         │                     │         └── WebMvcConfig.java                             // Web MVC 配置
    │         │                     ├── controller
    │         │                     │         ├── ApplicationController.java                    // 申请控制器
    │         │                     │         ├── ChatRoomController.java                       // 聊天室控制器
    │         │                     │         ├── ChorusController.java                         // 合唱控制器
    │         │                     │         ├── GiftController.java                           // 礼物控制器
    │         │                     │         ├── HealthController.java                         // 健康检查控制器
    │         │                     │         ├── InvitationController.java                     // 邀请控制器
    │         │                     │         ├── MicSeatController.java                        // 麦位控制器
    │         │                     │         ├── NcsController.java                            // NCS 控制器
    │         │                     │         ├── RoomController.java                           // 房间控制器
    │         │                     │         ├── SongController.java                           // 歌曲控制器
    │         │                     │         ├── TokenController.java                          // token 控制器
    │         │                     │         └── UserController.java                           // 用户控制器
    │         │                     ├── interceptor                                             // 拦截器
    │         │                     │         ├── PrometheusMetricInterceptor.java              // 指标拦截器
    │         │                     │         └── TraceIdInterceptor.java                       // 链路追踪拦截器
    │         │                     ├── metric                                                  // 指标
    │         │                     │         └── PrometheusMetric.java
    │         │                     ├── repository                                              // 数据库操作
    │         │                     │         └── RoomListRepository.java
    │         │                     ├── service
    │         │                     │         ├── IApplicationService.java                      // 申请服务
    │         │                     │         ├── IChatRoomService.java                         // 聊天室服务
    │         │                     │         ├── IChorusService.java                           // 合唱服务
    │         │                     │         ├── IGiftService.java                             // 礼物服务
    │         │                     │         ├── IIMService.java                               // IM服务
    │         │                     │         ├── IInvitationService.java                       // 邀请服务
    │         │                     │         ├── IMicSeatService.java                          // 麦位服务
    │         │                     │         ├── INcsService.java                              // NCS服务
    │         │                     │         ├── IProcessService.java                          // 申请、邀请业务处理服务
    │         │                     │         ├── IRoomService.java                             // 房间服务
    │         │                     │         ├── IRtcChannelAPIService.java                    // RTC频道管理服务
    │         │                     │         ├── IRtcChannelService.java                       // RTC频道服务
    │         │                     │         ├── IService.java
    │         │                     │         ├── ISongService.java                             // 歌曲服务
    │         │                     │         ├── ITokenService.java                            // token服务
    │         │                     │         ├── IUserService.java                             // 用户服务
    │         │                     │         └── impl
    │         │                     │             ├── ApplicationServiceImpl.java
    │         │                     │             ├── ChatRoomServiceImpl.java
    │         │                     │             ├── ChorusServiceImpl.java
    │         │                     │             ├── GiftServiceImpl.java
    │         │                     │             ├── IMServiceImpl.java
    │         │                     │             ├── InvitationServiceImpl.java
    │         │                     │             ├── MicSeatServiceImpl.java
    │         │                     │             ├── NcsServiceImpl.java
    │         │                     │             ├── ProcessServiceImpl.java
    │         │                     │             ├── RoomServiceImpl.java
    │         │                     │             ├── RtcChannelServiceImpl.java
    │         │                     │             ├── SongServiceImpl.java
    │         │                     │             ├── TokenServiceImpl.java
    │         │                     │             └── UserServiceImpl.java
    │         │                     ├── task                                    // 定时任务
    │         │                     │         └── RoomListTask.java             // 房间列表定时任务
    │         │                     └── utils
    │         │                         ├── HmacShaUtil.java                    // HmacSha1 加密工具
    │         │                         ├── RedisUtil.java                      // Redis 工具
    │         │                         ├── RtmUtil.java                        // RTM 工具
    │         │                         └── TokenUtil.java                      // Token 工具
    │         └── resources
    │             ├── application.yml                                           // 默认配置文件
    │             ├── lib                                                       // 声网 RTM SDK
    │             │         ├── agora-rtm-sdk.jar
    │             │         ├── libagora-fdkaac.so
    │             │         ├── libagora-ffmpeg.so
    │             │         ├── libagora-soundtouch.so
    │             │         ├── libagora_rtc_sdk.so
    │             │         └── libagora_rtm_sdk.so
    │             └── logback-spring.xml                                        // 日志配置
    └── test                                                                    // 单元测试
```