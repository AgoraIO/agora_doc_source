---
title: 频道事件回调
platform: RESTful
updatedAt: 2021-03-31 08:26:03
---
Agora 消息通知服务器以 HTTPS POST 请求方法向你的服务器发送频道事件消息通知回调。数据格式为 JSON，字符编码为 UTF-8，签名算法为 HMAC/SHA1 或 HMAC/SHA256。

## 请求的 Header

消息通知回调的 `header` 中包含以下字段：

| 字段名               | 值                                                           |
| :------------------- | :----------------------------------------------------------- |
| `Content-Type`       | application/json                                             |
| `Agora-Signature`    | Agora 用密钥（**secret**）和 HMAC/SHA1 算法生成的签名值。你需要使用密钥（**secret**）和 HMAC/SHA1 算法来验证该签名值。详见<a href="#signature">验证签名</a>。 |
| `Agora-Signature-V2` | Agora 用密钥（**secret**）和 HMAC/SHA256 算法生成的签名值。你需要使用密钥（**secret**）和 HMAC/SHA256 算法来验证该签名值。详见<a href="#signature">验证签名</a>。 |

## 请求的 Body

消息通知回调的请求包体包含以下字段：

| 字段        | 类型        | 描述                                                         |
| :---------- | :---------- | :----------------------------------------------------------- |
| `noticeId`  | String      | 通知 ID，标识来自 Agora 业务服务器的一次事件通知。           |
| `productId` | Number      | 业务 ID。值为 `1` 表示实时通信业务。                         |
| `eventType` | Number      | 通知的事件类型。详见[频道事件类型](https://confluence.agoralab.co/pages/viewpage.action?pageId=713706534#id-2.频道事件回调-eventtype)。 |
| `notifyMs`  | Number      | Agora 消息服务器向你的服务器发送事件通知的 Unix 时间戳 (ms)。通知**重试**时该值会更新。 |
| `payload`   | JSON Object | 通知事件的具体内容。`payload` 因 `eventType` 而异，详见<a href="#eventtype">频道事件类型</a>。 |

消息通知回调的请求包体示例：

```
{
    "noticeId": "2000001428:4330:107",
    "productId": 1,
    "eventType": 101,
    "notifyMs": 1611566412672,
    "payload": {...}
}
```

<a name="eventtype"></a>
##  频道事件类型

Agora 消息通知服务可以通知实时通信业务中的以下频道事件类型：

| eventType                                                    | event_name                                 | 事件描述                           |
| :----------------------------------------------------------- | :----------------------------------------- | :--------------------------------- |
| <a href="#101">101</a> | channel create                             | 创建频道。                         |
| <a href="#102">102</a>  | channel destroy                            | 销毁频道。                         |
| <a href="#103">103</a>  | broadcaster join channel                   | 直播场景下，主播加入频道。         |
| <a href="#104">104</a>  | broadcaster leave channel                  | 直播场景下，主播离开频道。         |
| <a href="#105">105</a>  | audience join channel                      | 直播场景下，观众加入频道。         |
| <a href="#106">106</a>  | audience leave channel                     | 直播场景下，观众离开频道。         |
|<a href="#107">107</a>  | user join channel with communication mode  | 通信场景下，用户加入频道。         |
| <a href="#108">108</a>  | user leave channel with communication mode | 通信场景下，用户离开频道。         |
| <a href="#111">111</a>| client role change to broadcaster          | 直播场景下，用户将角色切换为主播。 |
| <a href="#112">112</a> | client role change to audience             | 直播场景下，用户将角色切换为观众。 |

<a name="101"></a>
### **101 channel destroy**

`eventType` 为 `101` 表示创建频道（第一个用户加入频道），`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                |
| :------------ | :------- | :-------------------------------------------------- |
| `channelName` | String   | 频道名。                                            |
| `ts`          | Number   | 该事件在 Agora 业务服务器上发生的 Unix 时间戳 (s)。 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "ts": 1560396834
}
```

<a name="102"></a>
### 102 channel create

`eventType` 为 102 表示最后一个用户离开频道且频道销毁，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                |
| :------------ | :------- | :-------------------------------------------------- |
| `channelName` | String   | 频道名。                                            |
| `ts`          | Number   | 该事件在 Agora 业务服务器上发生的 Unix 时间戳 (s)。 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "ts": 1560399999
}
```

<a name="103"></a>
### 103 broadcaster join channel

`eventType` 为 `103` 表示直播场景下主播加入频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 主播在频道内的用户 ID。                                      | 
| `platform`    | Number   | 主播设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `clientType`  | Number   | Linux 平台的主播端使用的业务类型，常见的返回值包括：<li>`3`：本地服务端录制 <li>`8`：小程序<li>`10`：云录制 <div class="alert note">该字段仅当 <code>platform</code> 为 <code>6</code> 时返回。</div> |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "ts": 1560396843
}
```

<a name="104"></a>
### 104 broadcaster leave channel

`eventType` 为 `104` 表示直播场景下主播离开频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 主播在频道内的用户 ID。                                      |
| `platform`    | Number   | 主播设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `clientType`  | Number   | Linux 平台的主播端使用的业务类型，常见的返回值包括：<li>`3`：本地服务端录制 <li>`8`：小程序 <li>`10`：云录制 <div class="alert note">该字段仅当 <code>platform</code> 为 <code>6</code> 时返回。</div> |
| `reason`      | Number   | 主播离开频道的原因：<li>`1`：主播正常离开频道。<li>`2`：客户端与 Agora 业务服务器连接超时。判断标准为 Agora SD-RTN 超过 10 秒未收到该主播的任何数据包。<li>`3`：权限问题。如被运营人员通过踢人 RESTful API 踢出频道。<li>`4`：Agora 业务服务器内部原因。如 Agora 业务服务器在调整负载，和客户端短暂断开连接，之后会重新连接。<li>`5`：主播切换新设备，迫使旧设备下线。<li>`0`：其他原因。 |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "reason": 1,
    "ts": 1560396943
}
```

<a name="105"></a>
### 105 audience join channel

`eventType` 为 `105` 表示直播场景下观众加入频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 观众在频道内的用户 ID。                                      | 
| `platform`    | Number   | 观众设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `clientType`  | Number   | Linux 平台的观众端使用的业务类型，常见的返回值包括：<li>`3`：本地服务端录制 <li>`8`：小程序<li>`10`：云录制 <div class="alert note">该字段仅当 <code>platform</code> 为 <code>6</code> 时返回。</div> |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "ts": 1560396843
}
```

<a name="106"></a>
### 106 audience leave channel

`eventType` 为 `106` 表示直播场景下观众离开频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 观众在频道内的用户 ID。                                      |
| `platform`    | Number   | 观众设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `clientType`  | Number   | Linux 平台的观众端使用的业务类型，常见的返回值包括：<li>`3`：本地服务端录制 <li>`8`：小程序<li>`10`：云录制 <div class="alert note">该字段仅当 <code>platform</code> 为 <code>6</code> 时返回。</div> |
| `reason`      | Number   | 观众离开频道的原因：<li>`1`：观众正常离开频道。<li>`2`：客户端与 Agora 业务服务器连接超时。判断标准为 Agora SD-RTN 超过 10 秒未收到该观众的任何数据包。<li>`3`：权限问题。如被运营人员通过踢人 RESTful API 踢出频道。<li>`4`：Agora 业务服务器内部原因。如 Agora 业务服务器在调整负载，和客户端短暂断开连接，之后会重新连接。<li>`5`：观众切换新设备，迫使旧设备下线。<li>`0`：其他原因。 |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "reason": 1,
    "ts": 1560396943
}
```

<a name="107"></a>
### 107 user join channel with communication mode

`eventType` 为 `107` 表示通信场景下用户加入频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 用户在频道内的用户 ID。                                      |
| `platform`    | Number   | 用户设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "ts": 1560396834
}
```

<a name="108"></a>
### 108 user leave channel with communication mode

`eventType` 为 `108` 表示通信场景下用户离开频道，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| `channelName` | String   | 频道名。                                                     |
| `uid`         | Number   | 用户在频道内的用户 ID。                                      |
| `platform`    | Number   | 用户设备所属平台：<li>`1`：Android <li>`2`：iOS <li>`5`：Windows <li>`6`：Linux <li>`7`：Web <li>`8`：macOS <li>`0`：其他平台 |
| `reason`      | Number   | 用户离开频道的原因：<li>`1`：用户正常离开频道。<li>`2`：客户端与 Agora 业务服务器连接超时。判断标准为 Agora SD-RTN 超过 10 秒未收到该用户的任何数据包。<li>`3`：权限问题。如被运营人员通过踢人 RESTful API 踢出频道。<li>`4`：Agora 业务服务器内部原因。如 Agora 业务服务器在调整负载，和客户端短暂断开连接，之后会重新连接。<li>`5`：用户切换新设备，迫使旧设备下线。<li>`0`：其他原因。 |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。                 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "platform": 1,
    "reason": 1,
    "ts": 1560496834
}
```

<a name="111"></a>
### 111 client role change to broadcaster

`eventType` 为 `111` 表示直播场景下观众上麦，即调用 `setClientRole` 将用户角色从观众切换为主播，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                         |
| :------------ | :------- | :------------------------------------------- |
| `channelName` | String   | 频道名。                                     |
| `uid`         | Number   | 用户在频道内的用户 ID。                      |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。 |

`payload` 示例：

```
{
    "channelName": "test_webhook",
    "uid": 12121212,
    "ts": 1560396834
}
```

<a name="112"></a>
### 112 client role change to audience

`eventType` 为 `112` 表示直播场景下主播下麦，即调用 `setClientRole` 将用户角色从主播切换为观众，`payload` 中包含以下字段：

| 字段          | 数据类型 | 含义                                         |
| :------------ | :------- | :------------------------------------------- |
| `channelName` | String   | 频道名。                                     |
| `uid`         | Number   | 用户在频道内的用户 ID。                      |
| `ts`          | Number   | 该事件在业务服务器上发生的 Unix 时间戳 (s)。 |

`payload` 示例：

```
{
   "channelName": "test_webhook",
    "uid": 12121212,
    "ts": 1560496834
}
```

<a name="signature"></a>
## 验证签名

为提高 Agora 消息服务器和你的服务器之间的通信安全，Agora 使用签名机制进行身份验证。签名验证流程如下：

1. 在配置 Agora 消息通知服务时，Agora 会生成一个密钥（**secret**）。你需要在开通服务时，向 Agora 技术支持获取并保存该密钥。
2. 当 Agora 向你的服务器发送消息通知回调时，会使用密钥通过 HMAC/SHA1 和 HMAC/SHA256 算法生成签名值，并分别添加在 HTTPS 请求 `header` 的 `Agora-Signature` 和 `Agora-Signature-V2` 字段中。
3. 收到回调后，你可以使用密钥和请求包体里的参数，选用 HMAC/SHA1 或 HMAC/SHA256 算法计算签名值，以验证 `Agora-Signature` 或 `Agora-Signature-V2`。

你可以参考如下示例代码验证签名：
	
* Python 

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">HMAC/SHA1</div>
		<div class="switch-tab">HMAC/SHA256</div>
	</div>
<pre class="HMAC/SHA1 show"><code class="language-python">#!/usr/bin/env python3
# !-*- coding: utf-8 -*-
import hashlib
import hmac
# 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 dictionary
request_body = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'
secret = 'secret'
signature = hmac.new(secret, request_body, hashlib.sha1).hexdigest()
print(signature) # 033c62f40f687675f17f0f41f91a40c71c0f134c</code></pre>
<pre class="HMAC/SHA256"><code class="language-python">#!/usr/bin/env python3
# !-*- coding: utf-8 -*-
import hashlib
import hmac
# 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 dictionary
request_body = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'
secret = 'secret'
signature2 = hmac.new(secret, request_body, hashlib.sha256).hexdigest()
print(signature2) # 6d3320c60b11101395b7fc8f9068748808a0aa1bfa064438e39d1bc2c7d74d99</code></pre>
</div>

* Node.js

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">HMAC/SHA1</div>
		<div class="switch-tab">HMAC/SHA256</div>
	</div>
<pre class="HMAC/SHA1 show"><code class="language-javascript">const crypto = require('crypto')  
// 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 requestBody 是反序列化之前的 binary byte array，不是反序列化之后的 object
const requestBody = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'  
const secret = 'secret'  
const signature = crypto.createHmac('sha1', secret).update(requestBody, 'utf8').digest('hex')  
console.log(signature) // 033c62f40f687675f17f0f41f91a40c71c0f134c
</code></pre>
<pre class="HMAC/SHA256"><code class="language-javascript">const crypto = require('crypto')  
// 拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 requestBody 是反序列化之前的 binary byte array，不是反序列化之后的 object
const requestBody = '{"eventMs":1560408533119,"eventType":10,"noticeId":"4eb720f0-8da7-11e9-a43e-53f411c2761f","notifyMs":1560408533119,"payload":{"a":"1","b":2},"productId":1}'  
const secret = 'secret'   
const signature2 = crypto.createHmac('sha256', secret).update(requestBody, 'utf8').digest('hex') 
console.log(signature2) // 6d3320c60b11101395b7fc8f9068748808a0aa1bfa064438e39d1bc2c7d74d99</code></pre>
</div>

* Java

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">HMAC/SHA1</div>
		<div class="switch-tab">HMAC/SHA256</div>
	</div>
<pre class="HMAC/SHA1 show"><code class="language-java">import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
public class HmacSha {
    // 将加密后的字节数组转换成字符串
    public static String bytesToHex(byte[] bytes) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() < 2) {
                sb.append(0);
            } 
            sb.append(hex);
        } 
        return sb.toString();
    }
    //HMAC/SHA1 加密，返回加密后的字符串
    public static String hmacSha1(String message, String secret) {
        try {
            SecretKeySpec signingKey = new SecretKeySpec(secret.getBytes(
                        "utf-8"), "HmacSHA1");
            Mac mac = Mac.getInstance("HmacSHA1");
            mac.init(signingKey); 
            byte[] rawHmac = mac.doFinal(message.getBytes("utf-8"));
            return bytesToHex(rawHmac);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    } 
    public static void main(String[] args) {
        //拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 object
        String request_body = "{\"eventMs\":1560408533119,\"eventType\":10,\"noticeId\":\"4eb720f0-8da7-11e9-a43e-53f411c2761f\",\"notifyMs\":1560408533119,\"payload\":{\"a\":\"1\",\"b\":2},\"productId\":1}";
        String secret = "secret";
        System.out.println(hmacSha1(request_body, secret)); //033c62f40f687675f17f0f41f91a40c71c0f134c
    }
}
</code></pre>
<pre class="HMAC/SHA256"><code class="language-java">import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
public class HmacSha {
    // 将加密后的字节数组转换成字符串
    public static String bytesToHex(byte[] bytes) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() < 2) {
                sb.append(0);
            } 
            sb.append(hex);
        } 
        return sb.toString();
    }
    //HMAC/SHA256 加密，返回加密后的字符串
    public static String hmacSha256(String message, String secret) {
        try {
            SecretKeySpec signingKey = new SecretKeySpec(secret.getBytes(
                        "utf-8"), "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey); 
            byte[] rawHmac = mac.doFinal(message.getBytes("utf-8"));
            return bytesToHex(rawHmac);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    } 
    public static void main(String[] args) {
        //拿到消息通知的 raw request body 并对其计算签名，也就是说下面代码中的 request_body 是反序列化之前的 binary byte array，不是反序列化之后的 object
        String request_body = "{\"eventMs\":1560408533119,\"eventType\":10,\"noticeId\":\"4eb720f0-8da7-11e9-a43e-53f411c2761f\",\"notifyMs\":1560408533119,\"payload\":{\"a\":\"1\",\"b\":2},\"productId\":1}";
        String secret = "secret";
        System.out.println(hmacSha256(request_body, secret)); //033c62f40f687675f17f0f41f91a40c71c0f134c
    }
}</code></pre>
</div>