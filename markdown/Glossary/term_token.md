Token 也称为动态密钥，是一种鉴权方案，用于对使用 Agora 服务的用户校验权限，保证通信安全。

下图展示了用 Token 校验用户权限的流程：

![token 工作流程](https://web-cdn.agora.io/docs-files/1621413049902)

开发者需要在自己的 app 服务端部署 Agora 提供的代码并生成 Token，回传给客户端，当用户使用 Agora 服务（如加入 RTC 频道、登录 RTM 系统、进入白板房间等）时传入 Token，Agora 服务端会根据 Token 中的信息校验用户的权限。

对于不同的产品，Token 中包含的信息不完全相同。一般来说，Token 中会包括 Agora 项目的信息（如 App ID）、要使用的 Agora 服务的信息（如 RTC 频道名、白板房间的 UUID）、用户角色或权限、Token 的有效期。

Token 过期后，用户将无法正常使用 Agora 服务。开发者可以根据自己的业务需要，合理设置 Token 的有效期，并及时更换过期 Token。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/faq/appid_to_token">如何升级到 Token 鉴权方案？</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/token#temptoken">获取临时 Token</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server">生成 RTC 产品的 Token</a></li><li><a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token">生成 RTM 产品的 Token</a></li><li><a href="https://docs.agora.io/cn/whiteboard/whiteboard_token_overview">互动白板 Token 概述</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>
