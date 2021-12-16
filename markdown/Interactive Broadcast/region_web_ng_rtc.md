---
title: 限定访问区域
platform: Web
updatedAt: 2021-02-25 08:26:53
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./region_web_rtc?platform=Web">限定访问区域</a>。</li></div>

## 功能描述

为适应不同国家或地区的法律法规，声网支持限定访问区域功能，实现 SDK 只访问指定区域内的声网服务器，希望将音视频和消息数据传输限定在某一区域范围内。

假设你指定北美为访问区域，SDK 只访问北美区域内的声网服务器。无法分配可用的北美区域服务器时，SDK 会报错，而不是使用其他区域服务器替代。

<div class="alert note">该功能为高级设置，适用于有访问安全限制的场景。</div>

## 实现方法

Agora Web SDK 支持限定区域访问。一旦指定了访问区域，音视频数据将不会访问制定区域以外的服务器。

你可以调用 `setArea` 方法来指定访问区域，可设为：

- `ASIA`: 除中国大陆以外的亚洲区域。
- `CHINA`: 中国大陆。
- `EUROPE`: 欧洲。
- `GLOBAL`: 全球。
- `INDIA`: 印度。
- `JAPAN`: 日本。
- `NORTH_AMERICA`: 北美。

<div class="alert note">
	<ul>
		<li>访问区域限制为全局设置。</li>
		<li>仅支持指定单个访问区域。</li>
	</ul>
</div>

## 开发注意事项

如果你的网络环境部署了防火墙，使用该功能还需要根据[应用企业防火墙限制](firewall)将对应的域名添加到防火墙白名单，不对 IP 地址设限，且开放相应端口。