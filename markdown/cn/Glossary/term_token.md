---
title: Token
platform: All Platforms
updatedAt: 2021-01-28 10:43:18
---
#### <a name="token"></a>**Token**

Token 也称为动态密钥，用于在生产环境等安全要求更高的环境下对 app 用户在加入 RTC 频道或登录 RTM 系统时进行动态鉴权。



- 对于 RTC 产品、本地录制和云录制产品，Token 用于在用户加入频道时检查 App ID、用户加入频道权限、用户发流权限，和用户权限有效期；
- 对于 RTM 产品， Token 用于在用户登录 RTM 系统时检查 App ID、用户角色，和用户权限有效期。

正式生产环境下， Token 需要由客户自行在业务服务端生成并在加入RTC 频道或登录 RTM 系统时回传给客户端。处于测试阶段的 RTC 产品客户如果不想自己的业务服务端搭建 Token 生成器，也可以在[控制台](https://console.agora.io/)创建项目后选择由控制台生成临时 Token。临时 Token 的功能与正式 Token 完全一致。

所有 Token 都有授权有效期和服务有效期两种有效期。授权有效期是在用户生成 Token 时设置的权限的有效时间；Token 的服务有效期指的是每个 Token 在生成后的过期时间，默认设为 24 小时。

RTC 产品、本地录制和云录制产品的用户的 Token 有效期（无论是授权有效期还是服务有效期）到期时用户会被立刻踢出所在频道；RTM 产品的用户 Token 有效期到期时，用户不会被立即踢出 RTM 系统，但是在下次连接服务器时无法成功登录。所有用户在 Token 即将到期或到期时应尽快重新生成 Token 用于下次加入 RTC 频道或登录 RTM 系统。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/token#appcertificate">启用 App 证书</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/token#temptoken">获取临时 Token</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server_cpp">生成 RTC 产品的 Token</a></li><li><a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token">生成 RTM 产品的 Token</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>