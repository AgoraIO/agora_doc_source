---
title: 什么是 Token？Token 在哪里生成？何时使用？
platform: ["All Platforms"]
updatedAt: 2020-04-27 00:11:37
Products: ["Voice","Video","Interactive Broadcast","Recording","Real-time-Messaging","RTSA","cloud-recording","Volcengine AI Vision","Kingsoft Audio Moderation","Aliyun Audio Moderation"]
---
## 简介

Token 也称为动态密钥，用于在生产环境等安全要求更高的环境下对 app 用户在加入 RTC 频道或登录 RTM 系统时进行动态鉴权。



## Token 的功能

- 对于 RTC 产品、本地录制和云录制产品，Token 用于在用户加入频道时检查 App ID、用户加入频道权限、用户发流权限，和用户权限有效期；
- 对于 RTM 产品， Token 用于在用户登录 RTM 系统时检查 App ID、用户角色，和用户权限有效期。

## Token 的生成与使用

正式生产环境下， Token 需要由客户自行在业务服务端生成并在加入RTC 频道或登录 RTM 系统时回传给客户端。处于测试阶段的 RTC 产品客户如果不想自己的业务服务端搭建 Token 生成器，也可以在[控制台](https://console.agora.io/)创建项目后选择由控制台生成临时 Token。临时 Token 的功能与正式 Token 完全一致。

详见：

- [RTC 产品的临时 Token 获取](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#%E8%8E%B7%E5%8F%96%E4%B8%B4%E6%97%B6-token)
- [RTC 产品的 Token 生成](https://docs.agora.io/cn/Interactive%20Broadcast/token_server_cpp?platform=CPP)
- [RTM 产品的 Token 生成](https://docs.agora.io/cn/Real-time-Messaging/rtm_token?platform=All%20Platforms)

## Token 的有效期

所有 Token 都有授权有效期和服务有效期两种有效期。授权有效期是在用户生成 Token 时设置的权限的有效时间；Token 的服务有效期指的是每个 Token 在生成后的过期时间，默认设为 24 小时。

## Token 到期时的SDK 行为与建议操作

RTC 产品、本地录制和云录制产品的用户的 Token 有效期（无论是授权有效期还是服务有效期）到期时用户会被立刻踢出所在频道；RTM 产品的用户 Token 有效期到期时，用户不会被立即踢出 RTM 系统，但是在下次连接服务器时无法成功登录。所有用户在 Token 即将到期或到期时应尽快重新生成 Token 用于下次加入 RTC 频道或登录 RTM 系统。