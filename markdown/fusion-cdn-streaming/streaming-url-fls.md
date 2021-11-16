你需要根据 Agora 的规则拼接得到直播推流和播流的 URL。本文介绍直播流 URL 的拼接规则。

## 技术原理

因为 URL 中可能包含鉴权信息，Agora 建议在你的业务服务器上实现 URL 拼接，使用流程如下：

![process of constructing urls](https://web-cdn.agora.io/docs-files/1635838191301)



## 拼接推流 URL

推流 URL 由四部分组成，如下图的示例 URL 所示：

![example url of strream pushing](https://web-cdn.agora.io/docs-files/1635229049639)

各部分说明：

| URL分段    | 是否必须 | 描述                                                         |
| :--------- | :------- | :----------------------------------------------------------- |
| 域名       | 是       | 推流使用的域名，必须已备案且 CNAME 配置成功。                |
| 发布点     | 是       | 默认发布点为 live，每个发布点都有一套直播流相关的配置。      |
| 流名       | 是       | 直播流名称，用于标识一路直播流，请确保直播流名称唯一。       |
| 鉴权字符串 | 否       | 如果没有设置直播流鉴权，则 URL 地址中无需 "?" 及后面的内容。<br/>鉴权字符串由以下参数组成：<ul><li>`ts`：URL 失效的 Unix 时间戳，单位为秒。该值表示鉴权字符串过期的时间，例如，`ts=1635004800` 表示鉴权字符串在 2021 年 10 月 24 日 0 点前有效。</li><li>`sign`：防盗链签名。</li></ul>详见<a href="#key">计算鉴权字符串</a>。 |

## 拼接播流 URL

播流 URL 的拼接规则和推流 URL 类似，但不同的播流协议对应的 URL 路径略有差异。

> URL 中的域名必须为播流域名。

| 播放协议 | URL 路径                              | URL 示例                                                     |
| :------- | :------------------------------------ | :----------------------------------------------------------- |
| RTMP     | /{entry-point}/{stream}               | rtmp(s)://domain/live/stream?ts=1635004800&sign=95b0a9970c593819 |
| HTTP-FLV | /{entry-point}/{stream}.flv           | http(s)://domain/live/stream**.flv**?ts=1635004800&sign=337f185b6571cd42 |
| HLS      | /{entry-point}/{stream}/playlist.m3u8 | http(s)://domain/live/stream/**playlist.m3u8**?ts=1635004800&sign=a1d2d3bcce31c9fe |


<a name="key"></a>

## 计算鉴权字符串

本节介绍如何生成 URL 鉴权字符串。

### 第一步：提供防盗链密钥

防盗链密钥用于在业务服务器生成签名，以及在使用 Agora 融合 CDN 直播服务时进行验证。

防盗链密钥为不超过 128 字节的字符串，你需要自行设置。每个推流域名和播流域名都可以分别设置防盗链密钥，详见[直播流鉴权配置](https://docs.agora.io/cn/fusion-cdn-streaming/rest-api-authentication-fls?platform=RESTful)。

<div class="alert warning">不要在客户端使用防盗链密钥或者将其泄露给第三方，否则有被盗链风险。</div>

### 第二步：计算失效时间戳

推流/播流 URL 中的 `ts` 参数决定了该 URL 的有效时间。

假设当前时间 2021-10-23 10:00:00，转换为 Unix 时间戳为 1634954400。如果我们期望 URL 的有效期为 10 分钟，即在 2021-10-23 10:10:00 前有效，转换为 Unix 时间戳为 1634955000，即 ts=1634955000。

URL 的有效期不宜设置太短或者太长，Agora 推荐设置在 5 到 10 分钟之内。

- 有效期太短，客户端断线重连后可能会推流/播流失败，需要重新生成防盗链鉴权字符串。
- 有效期设置太长会增加被盗链的风险。

### 第三步：计算防盗链签名

签名（sign）为防盗链密钥、推流/播流 URL 的路径、失效时间戳 ts 这三部分拼接后的字符串计算得到的 MD5 值。

例如，假设 URL 为 `http://domain/live/stream.flv`，防盗链密钥为 `z2tn3uiny0aasebz`，`ts` 为 `1634955000`，则 sign=MD5(z2tn3uiny0aasebz/live/stream.flv1634955000)=f7c1bd88e911b72c。

### 示例代码

以下为用 Python3 代码计算鉴权字符串的示例：

```python
#!/usr/bin/python3
import time
from urllib.parse import urlparse
import hashlib
key = 'test_key'
play_url_str = 'http://push.test.com/live/test.flv'
key_expire_time = 60*15
url = urlparse(play_url_str)
now = int(time.time()) + key_expire_time
sign = key + url.path + str(now)
md5 = hashlib.md5()
md5.update(sign.encode('utf-8'))
play_url_str += "?ts={}&sign={}".format(now, md5.hexdigest())
print(play_url_str)
```