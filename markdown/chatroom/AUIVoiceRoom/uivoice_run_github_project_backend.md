本文介绍如何使用语聊 UI Kit 的后端服务。源代码你可参考 [AUIVoiceRoom/backend](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/backend)。

## 项目简介

本项目基于 Spring Boot 框架开发，依赖以下组件或服务：

- Redis：用于定时刷新在线人数并通过分布式锁方式保证数据更新的一致性。
- MongoDB：用于维护房间列表。
- 声网实时消息（RTM）：提供场景数据存储和消息传输通道。
- 声网即时通讯（IM）：用于提供聊天服务功能。
- 声网消息通知服务：用于处理人员进出和房间销毁逻辑，并通过声网 RTC 频道事件回调通知相关操作。

## 服务部署

### 1. 快速体验

本节介绍如何快速体验示例项目中已经搭建好的后端服务。

#### 前提条件

请确保已经安装如下环境或工具：

- Docker 环境
- 最新版 [docker-compose](https://docs.docker.com/compose/) 工具

你可以直接下载安装 [Docker Desktop](https://www.docker.com/products/docker-desktop/) 工具，它已默认安装 docker-compose。


#### 运行步骤

以下是运行服务的步骤：

1. 在项目根目录创建 `.env` 文件，并填入以下字段：

    ```
    TOKEN_APPID=<Your_App_ID>
    TOKEN_APPCERTIFICATE=<Your_App_Certificate>
    TOKEN_BASICAUTH_USERNAME=<Your_BasicAuth_Username>
    TOKEN_BASICAUTH_PASSWORD=<Your_BasicAuth_Password>
    NCS_SECRET=<Your_NCS_Secret>
    EM_AUTH_APPKEY=<Your_IM_Auth_AppKey>
    EM_AUTH_CLIENTID=<Your_IM_Auth_ClientID>
    EM_AUTH_CLIENTSECRET=<Your_IM_Auth_ClientSecret>
    ```

    你可以在[开通声网服务](//TODO)后，获取这些字段的值，详情如下：


    | 字段名                   | 字段描述         | 获取方式    |
    |----------------------|-----------------------|----------------------------------|
    | `TOKEN_APPID`          | 声网项目的 App ID，用于登录 RTC 和 RTM 系统。                 |[获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id) |
    | `TOKEN_APPCERTIFICATE` | 声网项目的 App 证书，用于登录 RTC 和 RTM 系统。                            | [获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书) |
    | `TOKEN_BASICAUTH_USERNAME` | [声网频道管理 RESTful 服务](https://doc.shengwang.cn/doc/rtc/restful/best-practice/user-privilege)所需的客户 ID，用于实现封禁 RTC 频道内的用户权限。               | [生成客户 ID 和密钥](https://doc.shengwang.cn/doc/rtc/restful/get-started/enable-service#获取客户-id-和客户密钥) |
    | `TOKEN_BASICAUTH_PASSWORD` | [声网频道管理 RESTful 服务](https://doc.shengwang.cn/doc/rtc/restful/best-practice/user-privilege)所需的客户密钥，用于实现封禁 RTC 频道内的用户权限。               | [生成客户 ID 和密钥](https://doc.shengwang.cn/doc/rtc/restful/get-started/enable-service#获取客户-id-和客户密钥) |
    | `NCS_SECRET`           | 消息通知服务的密钥，用于保障消息通知服务安全性。                     | [验证签名](https://doc.shengwang.cn/doc/rtc/restful/advanced-features/webhook#验证签名) |
    | `EM_AUTH_APPKEY`       | IM 服务的应用标识，用于创建 IM 聊天室。                          | [获取即时通讯项目信息](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms#获取即时通讯项目信息) |
    | `EM_AUTH_CLIENTID`     | IM 服务的用户 ID，用于创建 IM 聊天室。                        | [IM 集成概述](https://docs-preprod.agora.io/cn/agora-chat/integration_overview_android?platform=Android#用户登录) |
    | `EM_AUTH_CLIENTSECRET` | IM 服务的 Token（//TODO 更新成环信和对应链接），用于创建 IM 聊天室。                      | [IM 集成概述](https://docs-preprod.agora.io/cn/agora-chat/integration_overview_android?platform=Android#用户登录) |

    在体验阶段，你可以根据需求选择是否开通声网消息通知、RTM、IM 服务。如果未开通这些服务，你会受到如下影响：

    - 如果未开启声网消息通知服务，将无法自动处理用户进出房间和房间销毁的逻辑。
    - 如果未开启 RTM 和 IM 服务，功能体验会受限。

2. 在项目根目录下执行以下命令启动服务：

    ```shell
    docker compose up -d --build
    ```

    该命令会拉取所需的镜像并启动 Redis、MongoDB 和 Web 服务。如果遇到镜像拉取失败的问题，你可以通过配置国内镜像源解决。

3. 服务启动后，继续输入如下命令进行测试：

    ```shell
    curl http://localhost:8080/health/check
    ```

4. 如果你需要使用移动端 App 调试本地服务，你需要将移动端 App 上对应的后端服务域名替换成如下：

    ```http
    http://{your_ip}:8080
    ```

    `your_ip` 为本地运行服务的机器 IP 地址。

5. 如果你需要停止服务，执行如下命令：

    ```shell
    docker compose down
    ```


### 2. 本地开发

本节介绍如何通过 Visual Studio Code（简称 VS Code）工具在本地开发语聊后端服务。如果你使用其他工具，你也可以参考本节步骤进行相应操作。

#### 前提条件

除了满足[上一步的前提条件](#前提条件)外，还需确保已经安装如下环境或工具：

- Java 11 或之后
- VS Code 和如下插件：
    - Dev Containers
    - Extension Pack for Java

Dev Containers 插件允许你在 Linux 环境的 Docker 容器中进行开发。因为 RTM 服务的运行依赖于 Linux 环境，所以使用 VS Code 工具开发时建议你安装 Dev Containers。

#### 开发步骤

以下是本地开发的步骤：

1. 使用 VS Code 中打开项目目录，并进入容器开发模式。

    在 Docker 容器中开发时可以使用示例项目中的 [Dockerfile](https://github.com/AgoraIO-Community/AUIVoiceRoom/blob/main/backend/Dockerfile_Dev)，相关配置项已经在该文件中设置。

2. 修改 [application.yml](https://github.com/AgoraIO-Community/AUIVoiceRoom/blob/main/backend/src/main/resources/application.yml) 配置文件中的以下内容：

   - `spring.data.mongodb.uri`：将应用连接到数据库。
   - `spring.redis.host`：配置 Redis 缓存。
   - `spring.redis.password`：配置 Redis 缓存。
   - `ncs.secret`
   - `token.appId`
   - `token.appCertificate`
   - `token.basicAuth.username`
   - `token.basicAuth.password`
   - `em.auth.appKey`
   - `em.auth.clientId`
   - `em.auth.clientSecret`

    `spring.*` 之外的内容含义详见[字段描述](#运行步骤)。

3. 构建并运行 Spring Boot 应用。


### 3. 上线部署

完成本地开发后，你还需要进行以下操作才能将服务部署上线：

1. 确保已[开通所有声网服务](//TODO)，并根据[本地开发步骤 2](#开发步骤) 检查 `application.yml` 中字段内容填写无误。

2. 调整 Redis 和 MongoDB 配置。

3. 将服务部署在网关。网关可提供鉴权和限流等能力。本示例项目中展示的服务暂时未包含网关能力。

4. 设置指标收集。通过 `https://{your_hostname}:9090/metrics/prometheus` 收集指标进行服务监控。

5. 将服务部署在云平台，例如[阿里云容器服务（ACK）](https://www.alibabacloud.com/zh/product/kubernetes)。


## 目录结构

本节介绍示例项目中 [backend](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/backend) 文件夹下目录结构和各文件用途。

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
    │         │                     │         ├── RtcChannelAPIClient.java                      // RTC 频道 API 客户端
    │         │                     │         └── WebMvcConfig.java                             // Web MVC 配置
    │         │                     ├── controller
    │         │                     │         ├── ApplicationController.java                    // 申请控制器
    │         │                     │         ├── ChatRoomController.java                       // 聊天室控制器
    │         │                     │         ├── ChorusController.java                         // 合唱控制器
    │         │                     │         ├── GiftController.java                           // 礼物控制器
    │         │                     │         ├── HealthController.java                         // 健康检查控制器
    │         │                     │         ├── InvitationController.java                     // 邀请控制器
    │         │                     │         ├── MicSeatController.java                        // 麦位控制器
    │         │                     │         ├── NcsController.java                            // 消息通知服务（NCS）控制器
    │         │                     │         ├── RoomController.java                           // 房间控制器
    │         │                     │         ├── SongController.java                           // 歌曲控制器
    │         │                     │         ├── TokenController.java                          // Token 控制器
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
    │         │                     │         ├── IIMService.java                               // IM 服务
    │         │                     │         ├── IInvitationService.java                       // 邀请服务
    │         │                     │         ├── IMicSeatService.java                          // 麦位服务
    │         │                     │         ├── INcsService.java                              // 消息通知服务（NCS）服务
    │         │                     │         ├── IProcessService.java                          // 申请、邀请业务处理服务
    │         │                     │         ├── IRoomService.java                             // 房间服务
    │         │                     │         ├── IRtcChannelAPIService.java                    // RTC 频道管理服务
    │         │                     │         ├── IRtcChannelService.java                       // RTC 频道服务
    │         │                     │         ├── IService.java
    │         │                     │         ├── ISongService.java                             // 歌曲服务
    │         │                     │         ├── ITokenService.java                            // Token 服务
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

## 下一步

//TODO