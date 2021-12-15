---
title: 开通消息通知服务
platform: RESTful
updatedAt: 2021-03-31 08:25:57
---

## 概述

Agora 提供频道事件消息通知服务，用于实时同步实时通信（RTC）业务中的频道状态。

开通消息通知服务后，当订阅的频道事件发生时，Agora RTC 业务服务器会将事件消息发送给 Agora 消息通知服务器，然后 Agroa 消息通知服务器会通过 HTTPS POST 请求方法将事件通知投递给你的服务器。

### 工作原理图

![](https://web-cdn.agora.io/docs-files/1616768581111)

## 开通服务

你需要提供以下信息，联系 Agora 技术支持 [support@agora.io](mailto:support@agora.io) 帮你配置并开通消息通知服务。

### 功能配置

1. 希望开通消息通知服务的业务，即实时音视频通信业务。

2. 希望监听的频道事件，详见[实时音视频通信频道事件类型](https://confluence.agoralab.co/pages/viewpage.action?pageId=713706534)。

<div class="alert note">如需配置 QPS (Query Per Second) 较高的事件，如实时通信中观众加入或离开直播频道，请确保你的服务器有足够的处理能力。</div>

3. 接收消息通知的 HTTPS 服务器地址。

 <div class="alert note">为降低消息投递的延时，Agora 建议你的服务器支持 HTTP 连接重用，即 kepp-alive 模式，并进行如下设置：<ul>
<li><code>MaxKeepAliveRequests</code>：大于等于 100。</li>
<li><code>KeepAliveTimeout</code>：大于等于 10 秒。</li></ul></div>

4. 你的消息通知接收服务器所在区域。

### 获取密钥

为提高通信安全，Agora 消息通知服务使用签名机制验证身份。配置消息通知服务时，Agora 为你生成用于验证签名的密钥（**secret**），你需要向 Agora 技术支持获取并保存这个密钥。关于如何使用密钥验证签名，详见[验证签名](https://confluence.agoralab.co/pages/viewpage.action?pageId=713706534)。

### 配置测试

配置完成后，你可以让 Agora 技术支持帮你测试该配置。如果测试成功，即可正式开通该服务。

## 消息通知回调格式与内容

成功开通 Agora 消息通知服务后，当订阅的频道事件发生时，Agora 消息服务器会以 HTTPS POST 请求的形式向你的服务器发送消息通知回调。频道事件消息回调的格式与内容，详见[频道事件回调](https://confluence.agoralab.co/pages/viewpage.action?pageId=713706534)。

## 消息通知回调响应

接收到消息通知回调后，你的服务器需要在 10 秒内对 Agora 消息服务器作出响应。响应包体格式为 JSON，包体内容不作要求。

<div class="alert note">Agora 消息服务器发送通知后的 10 秒内，如果没有收到你的服务器的响应，会认为消息通知失败。</div>

## 注意事项

- Agora 消息通知服务不保证消息通知完全按照事件发生的顺序到达，你的服务器需要能处理乱序消息。
- 为提高消息服务的可靠性，每次事件可能会有不止一次消息通知，你的服务器需要能处理重复消息。
