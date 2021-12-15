---
title: 限定访问区域
platform: Web
updatedAt: 2021-02-25 08:27:45
---

## 功能描述

为适应不同国家或地区的法律法规，声网支持限定访问区域功能，实现 SDK 只访问指定区域内的声网服务器，希望将音视频和消息数据传输限定在某一区域范围内。

假设你指定北美为访问区域，SDK 只访问北美区域内的声网服务器。无法分配可用的北美区域服务器时，SDK 会报错，而不是使用其他区域服务器替代。

<div class="alert note">该功能为高级设置，适用于有访问安全限制的场景。</div>

## 实现方法

Agora RTC Web SDK 从 v3.1.2 起，支持限定区域访问。一旦指定了访问区域，音视频数据将不会访问制定区域以外的服务器。

你需要在调用 [`createClient`](./API%20Reference/web/globals.html#createclient) 方法创建客户端实例时，通过设置 `ClientConfig` 的中的 `areaCode` 参数来指定访问区域，可设为：

- `ASIA`: 亚洲。
- `CHINA`: 中国大陆。
- `EUROPE`: 欧洲。
- `GLOBAL`: 全球。
- `INDIA`: 印度。
- `JAPAN`: 日本。
- `NORTH_AMERICA`: 北美。

<div class="alert note">
	<ul>
		<li>访问区域限制为全局设置，对整个标签页生效，即只要一个 Client 设置了访问区域，同页面创建的其他 Client 均会遵守访问区域限制。</li>
		<li>仅支持指定单个访问区域。</li>
	</ul>
</div>

## 示例代码

```javascript
var config = {
  mode: "live",
  codec: "vp8",
  // 指定仅访问北美的服务器。
  areaCode: [AgoraRTC.AREAS.NORTH_AMERICA],
};
// 创建客户端实例。
var client = AgoraRTC.createClient(config);
```

## 开发注意事项

如果你的网络环境部署了防火墙，使用该功能还需要根据[应用企业防火墙限制](firewall)将对应的域名添加到防火墙白名单，不对 IP 地址设限，且开放相应端口。
