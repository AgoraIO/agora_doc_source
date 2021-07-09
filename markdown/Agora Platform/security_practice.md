---
title: 安全最佳实践
platform: All Platforms
updatedAt: 2021-02-14 07:13:57
---
安全与合规是实时互动的基本要求。声网 Agora 遵守不同国家和行业的合规性要求，打造安全可靠的云服务，目前已通过 ISO/IEC 27001 认证。详细认证及证书下载请参考 [ISO 证书](iso_cert)。

此外，声网 Agora 产品在设计和构建过程中，根据音视频传输领域常见的攻击类型和安全需求，还集成了多重防护措施，满足客户及终端用户的数据安全要求。

| 防护措施 | 是否默认应用 | 推荐场景 |
| ---------------- | ---------------- | ---------------- |
| 资源隔离      | 是      | 所有实时场景。      |
| 频道隔离 | 是 | 所有实时场景。 |
| 身份认证 | 否 | Agora 推荐正式生产阶段的 app 均使用该措施。 |
| 加密 | 否 | 对于有保密需求的实时互动场景，Agora 推荐使用该措施。 |
| 限定访问区域 | 否 | 适用于将音视频数据及实时消息数据传输限定在某一区域范围内的场景。 |

<a name="project"></a>
## 资源隔离

客户在使用 Agora SDK 或服务前，需要先在 [Agora 控制台](https://console.agora.io/)新建项目。成功创建后，Agora 会自动为每个项目分配一个用于识别项目的 App ID。不同的项目之间彼此独立，通话无法互通，客户可以通过使用项目对应的 App ID，隔离不同的项目。

## 频道隔离

Agora 为每路音频、视频或消息传输建立单独且逻辑隔离的通道，即频道。在 App ID 一致的前提下，只有在同一频道内的用户才可以进行对应资源（音频、视频、消息）的访问，进行互动。

## 身份认证

除上述基本保障外，Agora 还提供动态 Token 对即将加入频道的终端用户进行鉴权。

目前 Agora 提供了如下两种认证方式：
- 基于 App ID 认证
- 基于 Token 认证。在采用 Token 认证方式后，客户可通过 App ID 和 App 证书生成 Token，并使用该 Token 对终端用户进行身份认证。

动态 Token 从以下几个方面提供安全保障：

- Token 采用业界标准化的 HMAC/SHA1 加密方案，可对 App ID 和频道名称等重要信息进行加密处理，保证不会泄露。
- 支持自定义 Token 有效期。Token 的默认有效期为 24 小时。客户可以根据自己的安全需求自定义 Token 的服务有效期。
- 支持定制不同的服务权限。

详细的生成 Token 的方法及注意事项，请参考[在服务端生成 Token](token_server)。

## 数据加密

对于对互动内容有保密需求的场景，Agora 还提供了内容加密和传输加密功能。

### 内容加密

下图分别展示了 RTC Native SDK 和 Web SDK 应用加密功能后的数据传输流程：

- Native SDK

![](https://web-cdn.agora.io/docs-files/1607585172098)

- Web SDK

![](https://web-cdn.agora.io/docs-files/1607585184084)

#### 内置加密
Agora RTC SDK 均内置多种加密算法。客户可以通过该功能对音视频内容进行加密。该加密功能可对所有传输的音视频流进行端到端加密。使用时，客户可以自行配置使用的加密算法。音视频数据在发送端完成加密后，在接收端完成解密，数据以密文形式进行网络传输。客户自行对密钥进行管理，包括密钥的生成、存储、传输和校验等。除涉及 WebRTC 服务外，Agora 不接触密钥，也无法对密文数据进行解密。

在 WebRTC 服务中，Agora 需要在服务端进行数据解密和协议转换。Agora 已实施安全的密钥传输和使用机制，保护客户的密钥不被泄露。

#### 自定义加密

如果使用的是 Agora RTC Native SDK，除内置加密外，客户还可以使用自定义加密功能。Agora 可以将发送前和接收后的音视频数据通过回调发给 app，app 再自行选择加密算法和密钥。自定义加密下，Agora 接触不到任何加密信息，适用于安全需求更高的场景。

不同平台设置加密方案的步骤详见：

- [Android](channel_encryption_android?platform=Android)
- [iOS](channel_encryption_apple?platform=iOS)
- [macOS](channel_encryption_apple?platform=macOS)
- [Web](channel_encryption_web?platform=Web)
- [Windows](channel_encryption_windows?platform=Windows)

### 传输加密

为保证数据在传输过程中的保密性，Agora 各产品和服务均实施了覆盖全数据链路的传输加密机制，并采用业内主流的强加密算法。其中：

- RTC Native SDK 和 RTM Native SDK 使用 TLS (Transport Layer Security) 加密协议。
- RTC Web SDK 和 RTM Web SDK 使用 SSL (Secure Sockets Layer) 加密协议。

## 限定访问区域

为适应不同国家或地区的法律法规，Agora RTC SDK 和 RTM SDK 还支持只访问指定区域内的 Agora 服务器，将音视频数据及实时消息数据传输限定在某一区域范围内。

目前支持限定访问的区域有全球（默认）、中国大陆、北美、欧洲、亚洲（中国大陆除外）、日本、印度。当客户将访问区域限定在指定区域后，音频、视频、实时消息数据将不会访问指定区域以外的服务器。

具体使用方法，详见：

- RTC SDK:
	- [Android](region_java_rtc?platfrom=Android)
	- [iOS](region_oc_rtc?platfrom=iOS)
	- [macOS](region_oc_rtc?platform=macOS)
	- [Web](region_web_rtc?platform=Web)
	- [Windows](region_cpp_rtc?platform=Windows)
- RTM SDK:
  - [Android](region_java_rtm?platform=Android)
  - [iOS](region_oc_rtm?platform=iOS)
  - [macOS](region_oc_rtm?platform=macOS)
  - [Web](region_web_rtm?platfrom=Web)
  - [Windows](region_cpp_rtm?platfrom=Windows)
  - [Linux C++](region_cpp_rtm?platform=Linux)
  - [Linux Java](region_java_linux_rtm?platform=Linux)

