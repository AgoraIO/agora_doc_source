---
title: 生成 Token
platform: 服务端
updatedAt: 2021-03-02 03:06:27
---

Token，也称动态密钥，是 app 用户在加入频道或登录服务系统时采用的一种鉴权方式。

Token 在你的业务服务端生成。用户加入频道或登录服务时，客户端需要向服务端申请 Token；服务器生成 Token 后，再将其传给客户端。

本文展示如何使用 Agora 提供的代码在服务端生成 Token。

<div class="alert note">根据你使用的 Agora SDK，需要生成不同的 Token：
	<ul>
		<li>RTC Token：如果你使用的是 Agora RTC SDK、本地服务端录制 SDK、云端录制、实时码流加速 SDK 或互动游戏 SDK，则参考本文内容生成 RTC Token。</li>
		<li>RTM Token：如果你使用的是 Agora 实时消息 SDK，则需要生成 RTM Token。详情请参考<a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token?platform=All%20Platforms">生成 RTM Token</a>。</li>
	</ul>
</div>

## 前提条件

开始前，请确保你的项目或使用的 Agora 产品满足如下条件：

- 你的 Agora 项目在控制台已开启 App 证书。
- 你所使用的 Agora 产品，满足如下版本要求：

  | 产品               | 支持 Token 的版本                                                                                                                     |
  | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------- |
  | RTC SDK            | <ul><li>Native SDK: v2.1.0 及以上</li><li>Web SDK: v2.4.0 及以上</li><li>Electron SDK: 所有版本</li><li>Unity SDK: 所有版本</li></ul> |
  | 本地服务端录制 SDK | v2.1.0 及以上                                                                                                                         |
  | 云端录制           | 无版本要求                                                                                                                            |
  | 实时码流           | 所有版本                                                                                                                              |
  | 互动游戏 SDK       | v2.2.0 及以上                                                                                                                         |

## Token 代码说明

Agora 在 GitHub 提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Python、PHP、Ruby、Node.js、Go 等语言在你的服务端部署生成 Token。下图以 C++ 为例，展示生成 Token 代码的文件结构：

![](https://web-cdn.agora.io/docs-files/1600072461550)

其中：

- `./sample/RtcTokenBuilderSample.cpp` 文件包含用于生成 RTC Token 的示例代码。
- `./src/RtcTokenBuilder.h` 文件包含用于生成 RTC Token 的 API 源代码。

### 使用示例代码快速生成 Token

Agora 在各语言的 sample 文件夹下提供了生成 Token 的示例代码供你参考。以 C++ 为例：

```C++
int main(int argc, char const *argv[]) {

  // 请填入你的项目 App ID
  std::string appID  = "970Cxxxxxxxxxxxxxxxxxxxxxxx1b33";
  // 请填入你的项目 App 证书
  std::string  appCertificate = "5CFdxxxxxxxxxxxxxxxxxxxxxxx5d3b";
  // 请填入频道名
  std::string channelName= "7d72xxxxxxxxxxxxxxxxxxxxxxbdda";
  // 请填入 uid。如果填 0，则表示不对 uid 鉴权
  uint32_t uid = 2882341273;
  // Token 服务过期时间
  uint32_t expirationTimeInSeconds = 3600;
  uint32_t currentTimeStamp = time(NULL);
  uint32_t privilegeExpiredTs = currentTimeStamp + expirationTimeInSeconds;
  std::string result;

  result = RtcTokenBuilder::buildTokenWithUid(
      appID, appCertificate, channelName, uid, UserRole::Role_Publisher,
      privilegeExpiredTs);
  std::cout << "Token With Int Uid:" << result << std::endl;
```

你可以参考如下步骤，通过命令行直接使用上述示例代码生成 Token。开始前请确保已安装 OpenSSL 库。

1. 将 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库下载或克隆至本地。
2. 打开 `AgoraDynamicKey/cpp/sample/RtcTokenBuilderSample.cpp` 文件，使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 `buildTokenWithUserAccount` 代码片段。
3. 进入 `RtcTokenBuilderSample.cpp` 所在路径，然后运行如下命令行。运行结束后，相同文件夹下会生成一个可执行文件 `RtcTokenBuilderSample`。

   ```
   g++ -std=c++0x -O0 -I../../ -L. RtcTokenBuilderSample.cpp -lz -lcrypto -o RtcTokenBuilderSample
   ```

4. 运行如下命令行生成 Token。生成的 Token 会显示在 Terminal 中。

   ```
   ./RtcTokenBuilderSample
   ```

使用其他语言的示例代码在本地生成 Token 的步骤如下：

<details>
	<summary><font color="#3ab7f8">Java</font></summary>
开始前确保已安装 Java IDE。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>在你的 Java IDE 中打开 <code>AgoraDynamicKey/java</code> 文件。</li>
		<li>打开 <code>AgoraDynamicKey/java/src/io/agora/sample/RtcTokenBuilderSample.java</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>在你的 Java IDE 中运行项目。生成的 Token 会显示在 IDE 中。</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Python</font></summary>
开始前请确保已安装 Python 2，且运行环境为 Python 2。你可以运行如下命令行查询当前 Python 版本。
<pre><code>Python -V</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/python/sample/RtcTokenBuilderSample.py</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>RtcTokenBuilderSample.py</code> 所在路径，然后运行如下命令行生成 Token。 生成的 Token 会显示在 Terminal 中。
			<pre><code>python RtcTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Python3</font></summary>
开始前请确保已安装 Python 3，且运行环境为 Python 3。你可以运行如下命令行查询当前 Python 版本。
<pre><code>Python -V</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/python/sample/RtcTokenBuilderSample.py</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>RtcTokenBuilderSample.py</code> 所在路径，然后运行如下命令行生成 Token。 生成的 Token 会显示在 Terminal 中。
			<pre><code>python RtcTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">PHP</font></summary>
开始前请确保已安装最新版本的 PHP。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/sample/RtcTokenBuilderSample.php</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>RtcTokenBuilderSample.php</code> 所在路径，然后运行如下命令行生成 Token。 生成的 Token 会显示在 Terminal 中。
			<pre><code>php RtcTokenBuilderSample.php</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Node.js</font></summary>
开始前请确保已安装最新版本的 Node.js LTS 版本。
	<ol>
		<li>运行如下命令行安装 Node.js 依赖。
			<pre><code>npm install</code></pre>
		</li>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/nodejs/sample/RtcTokenBuilderSample.js</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>RtcTokenBuilderSample.js</code> 所在路径，然后运行如下命令行生成 Token。 生成的 Token 会显示在 Terminal 中。
			<pre><code>node RtcTokenBuilderSample.js</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Go</font></summary>
开始前请确保已安装最新版本的 Golang。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/go/sample/RtcTokenBuilder/sample.go</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>sample.go</code> 所在路径，然后运行如下命令行。 运行结束后，相同文件夹下会生成一个可执行文件 <code>RtcTokenBuilder</code>。
			<pre><code>go build</code></pre>
		</li>
		<li>运行如下命令行生成 Token。生成的 Token 会显示在 Terminal 中。
			<pre><code>./RtcTokenBuilder</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Ruby</font></summary>
开始前请确保已安装 Ruby v1.9 及以上。你可以通过如下命令行查询当前的 Ruby 版本。
	<pre><code>ruby -version</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/ruby/sample/rtc_token_builder_sample.rb</code> 文件。使用自己的 App ID、App 证书、用户 ID 以及频道名替换示例代码中的值，并注释掉示例代码中的 <code>buildTokenWithUserAccount</code> 代码片段。</li>
		<li>进入 <code>rtc_token_builder_sample.rb</code> 所在路径，然后运行如下命令行生成 Token。生成的 Token 会显示在 Terminal 中。
			<pre><code>ruby rtc_token_builder_sample.rb</code></pre>
		</li>
	</ol>
</details>

### API 参考

下文以 C++ 的 API 为例，介绍生成 Token 的 API 参数含义。具体参数解释也适用于其他语言。

```C++
static std::string buildTokenWithUid(
    const std::string& appId,
    const std::string& appCertificate,
    const std::string& channelName,
    uint32_t uid,
    UserRole role,
    uint32_t privilegeExpiredTs = 0);
```

| 参数                 | 描述                                                                                                                                                                                                                                                                                                                                |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `appId`              | 你在 Agora 控制台创建项目时生成的 App ID。                                                                                                                                                                                                                                                                                          |
| `appCertificate`     | 你的 App 证书。                                                                                                                                                                                                                                                                                                                     |
| `channelName`        | 标识通话的频道名称，长度在 64 字节以内。以下为支持的字符集范围：</br><ul><li>26 个小写英文字母 a-z；</li><li>26 个大写应为字母 A-Z；</li><li>10 个数字 0-9；</li><li>空格；</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", " {", "}", "\|", "~", ","。</li></ul> |
| `uid`                | 用户 ID，32 位无符号整数。建议设置范围：1 到 (2<sup>32</sup>-1)，并保证唯一性。如果不需要校验 uid，即客户端使用任何 uid 都可以加入频道或登录服务，请把 `uid` 设为 0。                                                                                                                                                               |
| `role`               | 用户发流权限：<ul><li>`Role_Publisher`(1)：（默认）用户有发流权限。<li>`Role_Subscriber`(2)：用户没有发流权限。</ul>在需要连麦鉴权的场景中，该参数的设置与用户在 `setClientRole` 中的角色共同决定用户是否能发流。详见 FAQ：<a href="https://docs.agora.io/cn/faq/token_cohost">如何使用连麦鉴权功能</a>。                           |
| `privilegeExpiredTs` | Token 过期的 Unix 时间戳，单位为秒。该值为当前之间戳和 Token 有效期的总和。比如，如果你将 `privilegeExpiredTs` 设为当前时间戳再加 600 秒，那么 Token 会在生成 10 分钟后过期。Token 的最大有效期为 24 小时。如果你设为 0，或超过 24 小时，则 Token 有效期依然是 24 小时。                                                            |

<div class="note alert">Agora 还提供了一个通过 String 型用户名生成 Token 的方法 <code>buildTokenWithUserAccount</code>，但不推荐使用。</div>
	
## 开发注意事项
	
### 参数匹配

生成 Token 时填入的频道名和用户 ID，需要和加入频道时填入的参数一致。

### App 证书与 Token

生成 Token 需要先在控制台启用对应项目的 App 证书。项目一旦开启了 App 证书，就必须使用 Token 鉴权。

### Token 过期

Token 的最大有效期为 24 小时。为保证通信体验，Agora 会在 Token 即将过期或已经过期时，分别触发以下回调：

- `onTokenPrivilegeWillExpire`：该回调表示 Token 即将失效。收到这个回调时，你需要在服务端重新生成 Token，然后调用 renewToken 方法，将新生成的 Token 传给 SDK。
- `onRequestToken`（Web 平台为 `onTokenPrivilegeDidExpire`）：该回调表示 Token 已经失效。收到这个回调时，你需要在服务端重新生成 Token，然后重新加入频道。

## 相关链接

生成 Token 过程中，你也可以参考如下文档：

- [如何处理 Token 相关错误码](https://docs.agora.io/cn/faq/token_error)
- [如何处理云端录制 101 错误码](https://docs.agora.io/cn/faq/101_error)
- [如何使用连麦鉴权功能](https://docs.agora.io/cn/faq/token_cohost)
