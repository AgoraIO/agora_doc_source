---
title: App ID
platform: All Platforms
updatedAt: 2020-07-03 18:12:49
---
App ID 是 Agora 为开发项目生成的字符串，是项目的唯一标识。当开发者在 [Agora 控制台](https://console.agora.io/)创建项目时，控制台会自动生成 App ID 用于标识这个项目。

开发者在初始化 Agora 相关服务时，需要填入 App ID。Agora 根据 App ID 提供计费、管理、数据统计等服务。

在正式生产环境中，Agora 建议在 app 用户加入 RTC 频道，或登录 RTM 系统时，使用动态的 Token 对用户鉴权，保证通信安全。

<div class="alert info">相关链接：
	<li><a href="https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms">校验用户权限</a></li>
	<li><a href="./terms#appid">App 证书</a></li>
	<li><a href="./terms#appcertificate">Token</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>