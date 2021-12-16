---
title: Channel Key 密钥说明
platform: All Platform
updatedAt: 2021-02-08 08:52:12
---
本文主要介绍在使用 Agora SDK 过程中使用 Channel Key 的方法。

## App ID

开发者在我们官网注册后，可以创建多个项目，每一个项目对应的唯一标识就是 App ID。 如果有人非法获取了你的 App ID，他将可以在 Agora 提供的 SDK 中使用你的 App ID，如果他知道你的频道名字，甚至有可能干扰你正常的通话。

所以建议仅在测试阶段或对安全性要求不高的场景里使用 App ID。

## Channel Key 机制

以用户 UID 123 加入某个房间 ABC 为例，Channel Key 的机制相当于门禁。Channel Key 相当于门卡, 以下简述签发 Channel Key 的过程:

1. 用户向服务台请求签发门卡，并提供信息:

	> - 自己的身份证明信息 (UID):123
	> - 自己想要加入的房间号 (ChannelName):ABC

1. 服务台确认请求来自合法的 App 用户，并根据要求现场签发用于该用户加入该频道号的门卡:

	> - 门卡从签发时间（当前时间戳）起五分钟是有效的;
	> - 门卡可以约定能在房间中待到什么时候（服务过期时间戳），到了时间点时间会被请出房间。也可以不约定，想待多久待多久（服务过期时间戳传 0);

1. 用户加入频道的时候，门禁验证用户持有的卡是否在有效期内，是否是用于该房间的门卡（验证频道名），是否是该用户本人持有的卡（验证 UID);
2. 用户在门卡签发的五分钟内离开房间（leavechannel 或断线），重新回来的时候需要通过门禁，持有的房卡有效，可以进入房间;
3. 用户在门卡签发的五分钟后离开房间，重新回来的时候通过门禁，门卡已经失效，需要去服务台重新签发门卡，才可以重新加入;
4. 用户一直待在房间内，到了门卡约定的服务到期时间，会被立即请出房间，此时需要去服务台重新签发门卡，才能重新加入;
5. 服务到期时间为 0 的情况下，也即不限定用户在房间内停留的时间，只要用户不离开，就不需要重新签发门卡;

## 获取 Channel Key

### 步骤 1: 获取 App ID

1. 进入**控制台**，按照屏幕提示注册账号并登录控制台。详见[注册与登陆](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面。

3. 点击**创建**按钮。

 ![](https://web-cdn.agora.io/docs-files/1574156100068)

4. 在弹出的对话框内输入项目名称，选择 **APP ID** 为鉴权机制，并点击**提交**。

5. 项目创建成功后，你会在项目列表中看到刚刚创建的项目。点击 ![](https://web-cdn.agora.io/docs-files/1592488399929) 查看并复制该项目对应的 App ID。

 ![](https://web-cdn.agora.io/docs-files/1574921811175)

6. 在调用 Agora 的 API 接口实现功能，如 SDK 初始化时，Agora 会需要你填入 App ID。将你获取到的 App ID 直接填入即可。

### 步骤 2: 获取 App 证书

App 证书是 Agora 控制台为开发项目生成的字符串。根据不同的安全需求，Agora 在项目中设置了两种 App 证书，区别如下：

- 主要证书：用于生成临时 Token 和正式 Token。启用主要证书后，你不能直接删除主要证书。
- 次要证书：只可用于生成正式 Token。启用次要证书后，你可以将次要证书与主要证书互换或删除次要证书。

如果你是第一次启用 App 证书，你需要先启用主要证书。

参考如下步骤启用主要证书：

- 如果你在创建项目时，选择 **APP ID + APP 证书 + Token** 为鉴权机制，Agora 会默认为你启用主要证书。主要证书会显示在**编辑项目**页面，你可以点击 ![](https://web-cdn.agora.io/docs-files/1592488399929) 查看并复制主要证书。
  ![](https://web-cdn.agora.io/docs-files/1592488920717)
- 如果你在创建项目时，选择 **APP ID** 为鉴权机制，那么你需要手动启用主要证书。在**编辑项目**页面，找到**主要证书**，点击**启用**。成功启用后，你可以点击 ![](https://web-cdn.agora.io/docs-files/1592488399929) 查看并复制主要证书。
  ![](https://web-cdn.agora.io/docs-files/1592488560281)

### 步骤 3: 输入字段值以获取 Channel Key

你可以通过 `generateMediaChannelKey` 方法，以及 Agora 提供的示例代码来获取 Channel Key。 Agora 的示例代码涵盖 C++, Java, Python，node.js 等语言，你可以直接将相应的代码应用在你的程序中。

首先，请访问 <https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey>，下载相应编程语言的代码，并将代码部署到您的服务器上。

然后，在你所开发的程序中，输入如下字段的值。不同的编程语言，必须字段名称不完全相同:

<table>
  <tr>
    <th>字段</th>
    <th>C++</th>
    <th>Java</th>
    <th>Python</th>
    <th>Node.js</th>
    <th>Go</th>
  </tr>
  <tr>
    <td>App ID</td>
    <td>appID</td>
    <td>appID</td>
    <td>appID</td>
    <td>appID</td>
    <td>appID</td>
  </tr>
  <tr>
    <td>App 证书</td>
    <td>appCertificate</td>
    <td>appCertificate</td>
    <td>appCertificate</td>
    <td>appCertificate</td>
    <td>appCertificate</td>
  </tr>
  <tr>
    <td>频道名</td>
    <td>channelName</td>
    <td>channel</td>
    <td>channelName</td>
    <td>channel</td>
    <td>channelName</td>
  </tr>
  <tr>
    <td>授权时间戳 [1]</td>
    <td>unixTs</td>
    <td>ts</td>
    <td>unixTs</td>
    <td>ts</td>
    <td>unixTs</td>
  </tr>
  <tr>
    <td>随机数</td>
    <td>randomInt</td>
    <td>r</td>
    <td>randomInt</td>
    <td>r</td>
    <td>randomInt</td>
  </tr>
  <tr>
    <td>用户 ID</td>
    <td>uid</td>
    <td>uid</td>
    <td>uid</td>
    <td>uid</td>
    <td>uid</td>
  </tr>
  <tr>
    <td>服务到期时间戳 [2]</td>
    <td>expiredTs</td>
    <td>expiredTs</td>
    <td>expiredTs</td>
    <td>expiredTs</td>
    <td>expiredTs</td>
  </tr>
</table>

[1]: Channel Key 生成时的时间戳，自 1970.1.1 开始到当前时间的秒数。授权该 Channel Key 在生成后的 5 分钟内可以访问 Agora 服务，如果 5 分钟内没有访问，则该 Channel Key 无法再使用。

[2]: 用户使用 Agora 服务终止的时间戳，在此时间之后，将不能继续使用 Agora 服务（比如进行的通话会被强制终止）；如果对终止时间没有限制，设置为 0。设置服务到期时间并不意味着Dynamic Key 失效，而仅仅用于限制用户使用当前服务的时间。

输入完成后，服务端会最终返回对应的 Channel Key。

如需要验证用户 ID (User ID), 详见下表所列的 DynamicKey 与 SDK 的版本兼容。如不需验证 UID，则各版本 SDK 可使用任意 DynamicKey 版本:

<table>
  <tr>
    <th>DynamicKey 版本</th>
    <th>用户 ID</th>
    <th>SDK 版本</th>
  </tr>
  <tr>
    <td>DynamicKey4</td>
    <td>某个用户的 uid</td>
    <td>1.3+</td>
  </tr>
  <tr>
    <td>DynamicKey3</td>
    <td>某个用户的 uid</td>
    <td>1.2.3+</td>
  </tr>
  <tr>
    <td>DynamicKey</td>
    <td>N/A</td>
    <td>N/A</td>
  </tr>
</table>

### 步骤 4: 使用 Channel Key

每一次客户端加入频道前:

1. 客户端向企业自己的业务服务器申请授权。
2. 服务器端收到请求后，通过 Agora 提供的算法生成 Channel Key，返回给授权的客户端应用程序。
3. 客户端应用程序调用 API 加入频道时，第一个参数要求为 Channel Key。
4. Agora 的服务器接收到 Channel Key 信息，验证该通话是来自于合法用户，并允许访问 Agora SD-RTN。

采用了 Channel Key 方案后，在用户进入频道时，Channel Key 将替换原来的 App ID。 Channel Key在一段时间后会失效，应用程序获知密钥失效（即当 onError 或 didOccurError 回调方法报告 ERR_CHANNEL_KEY_EXPIRED（109））时，需调用 renewChannelKey() 方法进行更新。 Channel Key 采用业界标准化的 HMAC/SHA1 加密方案，在 node.js, Java, Python, C++ 等绝大多数通用的服务器端开发平台上均可获得所需库。具体加密方案可参看以下网页：<http://en.wikipedia.org/wiki/Hash-based_message_authentication_code>