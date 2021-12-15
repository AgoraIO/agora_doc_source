---
title: 使用云代理服务
platform: Web
updatedAt: 2021-01-27 07:11:18
---

## 功能描述

对于安全需求较高的企业用户，设置防火墙可以限制员工访问非认可的网站，保护内部信息安全。

为避免这些企业因防火墙无法使用 Agora 的服务，Agora 开发了云代理服务。用户只需要在防火墙上将特定的 IP 及端口列入白名单，就可以实现内网访问 Agora 服务。

相比配置单一的代理服务器的 IP，云代理服务更灵活稳定，因此在大型企业、医院、高校、金融等安全需求较高的机构内都有广泛的应用。

## 实现方法

Agora Web SDK v2.5.1 及以上版本支持云代理服务。

1.  下载[最新版的 Agora Web SDK](https://docs.agora.io/cn/Agora%20Platform/downloads)。
2.  参考[实现音视频通话](start_call_web)或[实现互动直播](start_live_web)完成开发环境准备。
3.  联系 support@agora.io，提供 App ID，并提供代理服务使用区域、并发规模、网络运营商等信息，申请开通云代理服务。
4.  将以下测试 IP 及端口添加到企业防火墙的白名单。

        源地址为集成了 Agora Web SDK 的客户端。

    #### 国内测试

    | 协议 | 目标地址       | 端口                      | 端口用途                      |
    | ---- | -------------- | ------------------------- | ----------------------------- |
    | TCP  | 150.138.153.78 | 443, 4000<br/>3433 - 3460 | 消息数据传输<br/>媒体数据交换 |
    | TCP  | 47.74.211.17   | 443                       | 边缘节点通信                  |
    | TCP  | 52.80.192.229  | 443                       | 边缘节点通信                  |
    | TCP  | 52.52.84.170   | 443                       | 边缘节点通信                  |
    | TCP  | 47.96.234.219  | 443                       | 边缘节点通信                  |
    | UDP  | 150.138.153.78 | 3478 - 3500               | 媒体数据交换                  |

#### 国外测试

| 协议 | 目标地址       | 端口                      | 端口用途                      |
| ---- | -------------- | ------------------------- | ----------------------------- |
| TCP  | 23.236.115.138 | 443, 4000<br/>3433 - 3460 | 消息数据传输<br/>媒体数据交换 |
| TCP  | 148.153.66.218 | 443, 4000<br/>3433 - 3460 | 消息数据传输<br/>媒体数据交换 |
| TCP  | 47.74.211.17   | 443                       | 边缘节点通信                  |
| TCP  | 52.80.192.229  | 443                       | 边缘节点通信                  |
| TCP  | 52.52.84.170   | 443                       | 边缘节点通信                  |
| TCP  | 47.96.234.219  | 443                       | 边缘节点通信                  |
| UDP  | 23.236.115.138 | 3478 - 3500               | 媒体数据交换                  |
| UDP  | 148.153.66.218 | 3478 - 3500               | 媒体数据交换                  |

 <div class="alert note">以上 IP 仅供测试阶段调试使用，正式上线前需要向 Agora 申请独立的云代理服务资源。</div>

5. 调用 `startProxyServer` 方法打开云代理功能，测试是否能正常实现音视频通话或直播。

6. 测试完成后，Agora 会为你部署云代理服务正式环境，并提供相应的 IP 和端口。将 Agora 提供的 IP 和端口添加到企业防火墙的白名单。

7. 如果需要关闭代理，调用 `stopProxyServer`。

### 示例代码

#### 开启云代理服务

```javascript
var client = AgoraRTC.createClient({mode: 'live',codec: 'vp8'});

// 开启云代理
client.startProxyServer();
// 加入频道
client.init(key, function() {
    client.join(channelKey, channel, null, function(uid) {
        .......
    })
})
```

#### 关闭云代理服务

```javascript
// 开启云代理并加入频道后
...
// 离开频道
client.leave();

// 关闭云代理服务
client.stopProxyServer();

// 重新加入频道
client.join(channelKey, channel, null, function(uid) {

 ...

}
```

### API 参考

- [startProxyServer](./API%20Reference/web/interfaces/agorartc.client.html#startproxyserver)
- [stopProxyServer](./API%20Reference/web/interfaces/agorartc.client.html#stopproxyserver)
- [setProxyServer](./API%20Reference/web/interfaces/agorartc.client.html#setproxyserver)
- [setTurnServer](./API%20Reference/web/interfaces/agorartc.client.html#setturnserver)

## 工作原理

Agora 云代理的工作原理如下：
![](https://web-cdn.agora.io/docs-files/1543290381396)

- Agora SDK 在连接 Agora SD-RTN 之前，向云代理发起请求；
- 云代理返回相应代理信息；
- Agora SDK 向云代理发送数据，云代理将接收到的数据透传给 Agora SD-RTN；
- Agora SD-RTN 向云代理返回数据，云代理再将接收到的数据发送给 Agora SDK。

## 开发注意事项

- `startProxyServer` 和 `stopProxyServer` 必须在加入频道前或离开频道后调用。
- Agora Web SDK 还提供 `setProxyServer` 和 `setTurnServer` 两个方法给用户[自行部署代理服务器](./proxy_web?platform=Web)。这两个方法与 `startProxyServer` 不可同时调用，调用了其中任一个方法，再调用 `startProxyServer` 会报错，反之亦然。
- `stopProxyServer` 会关闭所有代理服务，包括通过 `setProxyServer` 和 `setTurnServer` 设置的代理。
