---
title: 生成 RTM Token
platform: All Platforms
updatedAt: 2021-01-27 07:56:07
---

RTM Token 是 app 用户在登录 RTM 系统时采用的一种鉴权方式。

RTM Token 在你的业务服务端生成。用户登录 RTM 系统时，客户端需要向服务端申请 RTM Token；服务器生成 RTM Token 后，再将其传给客户端。

本文展示如何使用 Agora 提供的代码在服务端生成 RTM Token。

# 前提条件

开始前，请确保你的 Agora 项目在控制台已开启 App 证书。

# RTM Token 代码说明

Agora 在 GitHub 提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Python、PHP、Ruby、Node.js、Go 等语言在你的服务端部署生成 RTM Token。下图以 C++ 为例，展示生成 RTM Token 代码的文件结构：

![](https://web-cdn.agora.io/docs-files/1602234153464)

其中：

- `./sample/RtmTokenBuilderSample.cpp` 文件包含用于生成 RTM Token 的示例代码。
- `./src/RtmTokenBuilder.h` 文件包含用于生成 RTM Token 的 API 源代码。

## 使用示例代码快速生成 RTM Token

Agora 在各语言的 sample 文件夹下提供了生成 RTM Token 的示例代码供你参考。以 C++ 为例：

```
int main(int argc, char const *argv[]) {

  // 请填入你的项目 App ID
  std::string appID  = "970CA35de60c44645bbae8a215061b33";
  // 请填入你的项目 App 证书
  std::string appCertificate = "5CFd2fd1755d40ecb72977518be15d3b";
  // 请填入用户 ID
  std::string user= "test_user_id";
  // Token 服务过期时间。此参数暂不生效。你无需设置此参数。每个 RTM Token 的有效期都是 24 小时。
  uint32_t expirationTimeInSeconds = 3600;
  uint32_t currentTimeStamp = time(NULL);
  uint32_t privilegeExpiredTs = currentTimeStamp + expirationTimeInSeconds;

  std::string result =
    RtmTokenBuilder::buildToken(appID, appCertificate, user,
        RtmUserRole::Rtm_User, privilegeExpiredTs);
  std::cout << "Rtm Token:" << result << std::endl;
  return 0;

}
```

你可以参考如下步骤，通过命令行直接使用上述示例代码生成 RTM Token。开始前请确保已安装 openssl 库。

1. 将 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库下载或克隆至本地。

2. 打开 `AgoraDynamicKey/cpp/sample/RtmTokenBuilderSample.cpp` 文件，使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。

3. 进入 `RtmTokenBuilderSample.cpp` 所在路径，然后运行如下命令行。运行结束后，相同文件夹下会生成一个可执行文件 `RtmTokenBuilderSample`。

   ```shell
    g++ -std=c++0x -O0 -I../../ -L. RtmTokenBuilderSample.cpp -lz -lcrypto -o RtmTokenBuilderSample
   ```

4. 运行如下命令行生成 RTM Token。生成的 RTM Token 会显示在 Terminal 中。

   ```shell
    ./RtmTokenBuilderSample
   ```

使用其他语言的示例代码在本地生成 RTM Token 的步骤如下：

 <details>
	<summary><font color="#3ab7f8">Java</font></summary>
开始前确保已安装 Java IDE。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>在你的 Java IDE 中打开 <code>AgoraDynamicKey/java</code> 文件。</li>
		<li>打开 <code>AgoraDynamicKey/java/src/io/agora/sample/RtmTokenBuilderSample.java</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>在你的 Java IDE 中运行项目。生成的 RTM Token 会显示在 IDE 中。</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Python</font></summary>
开始前请确保已安装 Python 2，且运行环境为 Python 2。你可以运行如下命令行查询当前 Python 版本。
<pre><code>Python -V</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>RtmTokenBuilderSample.py</code> 所在路径，然后运行如下命令行生成 RTM Token。 生成的 RTM Token 会显示在 Terminal 中。
			<pre><code>python RtmTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Python3</font></summary>
开始前请确保已安装 Python 3，且运行环境为 Python 3。你可以运行如下命令行查询当前 Python 版本。
<pre><code>Python -V</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>RtcTokenBuilderSample.py</code> 所在路径，然后运行如下命令行生成 RTM Token。 生成的 RTM Token 会显示在 Terminal 中。
			<pre><code>python RtmTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">PHP</font></summary>
开始前请确保已安装最新版本的 PHP。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/sample/RtmTokenBuilderSample.php</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>RtmTokenBuilderSample.php</code> 所在路径，然后运行如下命令行生成 RTM Token。 生成的 RTM Token 会显示在 Terminal 中。
			<pre><code>php RtmTokenBuilderSample.php</code></pre>
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
		<li>打开 <code>AgoraDynamicKey/nodejs/sample/RtmTokenBuilderSample.js</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>RtmTokenBuilderSample.js</code> 所在路径，然后运行如下命令行生成 RTM Token。 生成的 RTM Token 会显示在 Terminal 中。
			<pre><code>node RtmTokenBuilderSample.js</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Go</font></summary>
开始前请确保已安装最新版本的 Golang。
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/go/sample/RtcTokenBuilder/sample.go</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>sample.go</code> 所在路径，然后运行如下命令行。 运行结束后，相同文件夹下会生成一个可执行文件 <code>RtmTokenBuilder</code>。
			<pre><code>go build</code></pre>
		</li>
		<li>运行如下命令行生成 Token。生成的 Token 会显示在 Terminal 中。
			<pre><code>./RtmTokenBuilder</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Ruby</font></summary>
开始前请确保已安装 Ruby v1.9 及以上。你可以通过如下命令行查询当前的 Ruby 版本。
	<pre><code>ruby -version</code></pre>
	<ol>
		<li>将 <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> 仓库下载或克隆至本地。</li>
		<li>打开 <code>AgoraDynamicKey/ruby/sample/rtm_token_builder_sample.rb</code> 文件。使用自己的 App ID、App 证书、用户 ID 替换示例代码中的值。</li>
		<li>进入 <code>rtm_token_builder_sample.rb</code> 所在路径，然后运行如下命令行生成 Token。生成的 Token 会显示在 Terminal 中。
			<pre><code>ruby rtm_token_builder_sample.rb</code></pre>
		</li>
	</ol>
</details>

## API 参考

下文以 C++ 的 API 为例，介绍生成 RTM Token 的 API 参数含义。具体参数解释也适用于其他语言。

```
static std::string buildToken(const std::string& appId,
																const std::string& appCertificate,
																const std::string& userAccount,
																RtmUserRole userRole,
																uint32_t privilegeExpiredTs = 0);
```

| 参数               | 描述                                                                    |
| :----------------- | :---------------------------------------------------------------------- |
| appId              | 你在 Agora 控制台创建项目时生成的 App ID。                              |
| appCertificate     | 你的 App 证书。                                                         |
| userAccount        | RTM 系统用户 ID。                                                       |
| userRole           | 用户角色。暂时只支持一种角色，请使用默认值 `Rtm_User`。                 |
| privilegeExpiredTs | 此参数暂不生效。你无需设置此参数。每个 RTM Token 的有效期都是 24 小时。 |

# 开发注意事项

## 参数匹配

生成 RTM Token 时填入的用户 ID，需要和登录 RTM 系统时填入的用户 ID 一致。

## App 证书与 RTM Token

生成 RTM Token 需要先在控制台启用对应项目的 App 证书。项目一旦开启了 App 证书，就必须使用 RTM Token 鉴权。

## RTM Token 过期

RTM Token 的有效期为 24 小时。为保证通信体验，RTM 系统会在 RTM Token 过期且 SDK 处于重连 ([CONNECTION_STATE_RECONNECTING](https://docs.agora.io/cn/Real-time-Messaging/reconnecting_android?platform=Android)) 状态时触发 `onTokenExpired `回调（Web 平台为 `TokenExpired`，OC 平台为 `rtmKitTokenDidExpire`），表示 RTM Token 已失效。收到这个回调时，你需要在服务端重新生成 RTM Token，然后调用 `renewToken` 方法，将新生成的 RTM Token 传给 SDK。
