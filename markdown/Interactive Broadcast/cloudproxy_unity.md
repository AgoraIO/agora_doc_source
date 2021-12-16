---
title: 使用云代理服务
platform: Unity
updatedAt: 2021-03-12 04:51:28
---
## 简介

为允许用户在有网络访问限制的环境中使用 Agora RTC Unity SDK，Agora 提供云代理服务。用户只需在防火墙上将特定的 IP 地址和端口加入白名单，并调用 API 配置 Agora 云代理服务。

### 工作原理

![](https://web-cdn.agora.io/docs-files/1543290381396)

1. Agora SDK 向 Agora 云代理发起请求。Agora 云代理返回相应代理信息。
2. Agora SDK 向 Agora 云代理发送数据。Agora 云代理接收数据并将数据透传给 Agora [SD-RTN™](terms#sd-rtn)（Software Defined Real-time Network）。
3. Agora SD-RTN™ 向 Agora 云代理返回数据。Agora 云代理接收数据并将数据发送给 Agora SDK。

## 实现方法

1. 下载 Agora RTC Unity SDK。

2. 参考《快速开始》文档完成开发环境准备。

3. 联系 Agora 技术支持 sales@agora.io，提供以下信息申请开通云代理服务。

   - App ID
   - 代理服务使用区域
   - 并发规模
   - 网络运营商等信息

4. 将表格中 IP 地址及端口**全部添加**到防火墙白名单。源地址为集成了 Agora RTC Unity SDK 的客户端 IP 地址。

   - 如果你使用的 SDK 版本为 v3.2.0 或更高，请参考下表。

      <div class="alert note">Agora 云代理服务提供两种方式的服务器资源：<ul><li>共享方式：你和其他用户共享 Agora 的服务器资源。</li><li>独享方式：你独享 Agora 的服务器资源。</li></ul>两种方式均保证 Agora 服务的安全性。如果你希望使用独享方式的服务器资源，请不要使用下表，并向 Agora 申请单独的服务器资源。你需要将 Agora 技术支持提供的 IP 和端口添加到防火墙白名单。</div>

      | 协议| 目标 IP 地址          | 端口        |  备注  |
      | ----|--------------------- | ----------- | ----------|
      | UDP |140.210.77.68（中国大陆）  | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |125.88.159.163（中国大陆） | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |128.1.87.146（亚洲区域，中国大陆除外）  | 8443  | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |128.1.77.34（欧洲）  | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |128.1.78.146（欧洲）  | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |69.28.51.142（北美）  | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |107.155.14.132（北美）  | 8443 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP |106.3.140.194（中国大陆） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务|
      | UDP |106.3.140.195（中国大陆） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |
      | UDP |164.52.53.77（亚洲区域，中国大陆除外） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |
      | UDP |164.52.53.78（亚洲区域，中国大陆除外） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |
      | UDP |128.1.78.94（欧洲）  | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |
      | UDP |148.153.53.105（北美） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |
      | UDP |148.153.53.106（北美） | 8001 - 8005, 4590 - 4600 | 用于 Agora 云代理服务 |

   - 如果你使用的 SDK 版本低于 v3.2.0，请参考下表。

      <div class="alert note">表格中部分 IP 地址和端口仅供测试使用。正式上线前你需要向 Agora 申请正式的 IP 地址和端口，以替换仅供测试的 IP 地址和端口。</div>

      | 协议 | 目标 IP 地址      | 端口                    | 备注   |
      | ---- | ------------- | ----------------------- | ------------ |
      | TCP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | TCP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | TCP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | TCP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | UDP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | 用于接入 Agora 服务，即 AP（Access Point） 通信 |
      | TCP  | 120.92.118.34 | 4000                    | 用于 Agora 云代理服务（仅供测试） |
      | TCP  | 120.92.18.162 | 4000                    | 用于 Agora 云代理服务（仅供测试） |
      | UDP  | 120.92.118.34 | 4500 - 4650             | 用于 Agora 云代理服务（仅供测试） |
      | UDP  | 120.92.18.162 | 4500 - 4650             | 用于 Agora 云代理服务（仅供测试） |


5. 调用 `SetParameters("{\"rtc.enable_proxy\":true}");` 开启云代理服务。


6. 开启云代理服务后，Agora 默认通过域名配置云代理服务。若默认方式无法满足需求，你可以调用 `SetParameters("{\"rtc.proxy_server\":[2, \"[\"ip1\",\"ip2\",\"ip3\"]\", 0]}");` 通过 IP 地址配置云代理服务。

   <div class="alert note"> Agora 推荐你优先通过域名配置云代理服务，当域名受限时，再通过 IP 地址配置云代理服务。</div>

7. 测试是否能正常实现音视频通话或直播。

<div class="alert note">若需关闭云代理服务，调用 <code>SetParameters("{\"rtc.enable_proxy\":false}");</code>。</div>

### 示例代码

```C#
// 开启云代理服务，并默认通过域名配置云代理服务。
SetParameters("{\"rtc.enable_proxy\":true}");
```

```C#
// 开启云代理服务，并通过 IP 地址配置云代理服务。
SetParameters("{\"rtc.enable_proxy\":true}");
// 以下 IP 地址仅为示例，你需要填所有需要打开的 IP 地址。
SetParameters("{\"rtc.proxy_server\":[2, \"[\"128.1.87.146\",\"164.52.53.77\",\"164.52.53.78\"]\", 0]}");
```

## 开发注意事项

- `SetParameters` 必须在加入频道前或离开频道后调用。
- 使用云代理时，推流到 CDN 和跨直播间连麦功能不可用。