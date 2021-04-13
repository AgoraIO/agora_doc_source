---
title: 如何在 RESTful API 中进行 HTTP 基本认证和 Token 认证?
platform: ["RESTful"]
updatedAt: 2021-03-02 02:51:44
Products: ["Voice","Video","Interactive Broadcast","Recording","cloud-recording","Agora Analytics","Real-time-Messaging","live-streaming","advance media transcoding"]
---
## 功能描述

在使用 RESTful API 前，你需要通过 HTTP 基本认证或 Token 认证。

### HTTP 基本认证

使用 Agora 提供的客户 ID 和客户密钥生成一个使用 Base64 算法编码的凭证，并在 HTTP 请求头部的 `Authorization` 字段中填入该凭证。以下产品的 RESTful API 需要 HTTP 基本认证：

- [语音通话/视频通话/互动直播/极速直播](https://docs.agora.io/cn/Interactive%20Broadcast/rtc_restful_api?platform=RESTful)
- [云端录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful)
- [云信令（原实时消息）](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms)
- [水晶球](https://docs.agora.io/cn/Agora%20Analytics/aa_api?platform=RESTful)

### Token 认证

Token 认证目前仅适用于[云信令（原实时消息）](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms)。你需要在 HTTP 请求中 header 的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

- 服务端生成的 RTM Token。
- 生成 RTM Token 时使用的 RTM 用户 ID。


<div class="alert note">一般情况下，Agora 建议你在服务端进行 HTTP 基本认证和 Token 认证，否则会有数据泄露的风险。</div>

## 实现 HTTP 基本认证

### 实现方法

1. 登录 [Console](https://console.agora.io/)，点击右上角账户名，进入下拉菜单 RESTful API 页面。

   ![img](https://web-cdn.agora.io/docs-files/1595833692704)

2. 点击**下载**，即可获取**客户 ID**和**客户密钥**。

   ![img](https://web-cdn.agora.io/docs-files/1595834684732)

   <div class="alert note"><ul>
   <li>客户 ID 和客户密钥仅用于访问 RESTful API。客户密钥只能下载一次，下载后将不在控制台保存，请妥善保管。</li>
   <li>当使用水晶球内嵌功能时，你需要联系 <a href="mailto:sales@agora.io">sales@agora.io</a> 获取水晶球内嵌的客户 ID 与客户密钥进行 HTTP 基本认证。</li></ul></div>

3. 在请求认证的代码中，填入**客户 ID** (key) 和**客户密钥** (secret)，生成一个使用 Base64 算法编码的凭证，并在 HTTP 请求头部的 `Authorization` 字段中填入该凭证。

### 示例代码

下列示例代码实现了 HTTP 基本认证并使用服务端 RESTful API 发送一个简单的请求，获取所有的 Agora 项目信息：

#### Java

```java
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;


// 基于 Java 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
public class Base64Encoding {

    public static void main(String[] args) throws IOException, InterruptedException {

        // 客户 ID
        final String customerKey = "Your customer key";
        // 客户密钥
        final String customerSecret = "Your customer secret";

        // 拼接客户 ID 和客户密钥并使用 base64 编码
        String plainCredentials = customerKey + ":" + customerSecret;
        String base64Credentials = new String(Base64.getEncoder().encode(plainCredentials.getBytes()));
        // 创建 authorization header
        String authorizationHeader = "Basic " + base64Credentials;

        HttpClient client = HttpClient.newHttpClient();

        // 创建 HTTP 请求对象
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.agora.io/dev/v1/projects"))
                .GET()
                .header("Authorization", authorizationHeader)
                .header("Content-Type", "application/json")
                .build();
        // 发送 HTTP 请求
        HttpResponse<String> response = client.send(request,
                HttpResponse.BodyHandlers.ofString());

        System.out.println(response.body());
    }
}
```

#### Golang

```go
package main

import (
"fmt"
"strings"
"net/http"
"io/ioutil"
"encoding/base64"
)

// 基于 Golang 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
func main() {

// 客户 ID
customerKey := "Your customer key"
// 客户密钥
customerSecret := "Your customer secret"

// 拼接客户 ID 和客户密钥并使用 base64 进行编码
plainCredentials := customerKey + ":" + customerSecret
base64Credentials := base64.StdEncoding.EncodeToString([]byte(plainCredentials))

url := "https://api.agora.io/dev/v1/projects"
method := "GET"

payload := strings.NewReader(``)

client := &http.Client {
}
req, err := http.NewRequest(method, url, payload)

if err != nil {
    fmt.Println(err)
    return
}
// 增加 Authorization header
req.Header.Add("Authorization", "Basic " + base64Credentials)
req.Header.Add("Content-Type", "application/json")

// 发送 HTTP 请求
res, err := client.Do(req)
if err != nil {
    fmt.Println(err)
    return
}
defer res.Body.Close()

body, err := ioutil.ReadAll(res.Body)
if err != nil {
    fmt.Println(err)
    return
}
fmt.Println(string(body))
}
```

#### PHP

```php
<?php
// 基于 PHP 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
// 客户 ID
$customerKey = "Your customer key";
// 客户密钥
$customerSecret = "Your customer secret";
// 拼接客户 ID 和客户密钥
$credentials = $customerKey . ":" . $customerSecret;

// 使用 base64 进行编码
$base64Credentials = base64_encode($credentials);
// 创建 authorization header
$arr_header = "Authorization: Basic " . $base64Credentials;

$curl = curl_init();
// 发送 HTTP 请求
curl_setopt_array($curl, array(
CURLOPT_URL => 'https://api.agora.io/dev/v1/projects',
CURLOPT_RETURNTRANSFER => true,
CURLOPT_ENCODING => '',
CURLOPT_MAXREDIRS => 10,
CURLOPT_TIMEOUT => 0,
CURLOPT_FOLLOWLOCATION => true,
CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
CURLOPT_CUSTOMREQUEST => 'GET',

CURLOPT_HTTPHEADER => array(
    $arr_header,
    'Content-Type: application/json'
),
));

$response = curl_exec($curl);

if($response === false) {
    echo "Error in cURL : " . curl_error($curl);
}

curl_close($curl);

echo $response;

```

#### C&#35;

```c#
using System;
using System.IO;
using System.Net;
using System.Text;

// 基于 C# 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
namespace Examples.System.Net
{
    public class WebRequestPostExample
    {
        public static void Main()
        {
            // 客户 ID
            string customerKey = "Your customer key";
            // 客户密钥
            string customerSecret = "Your customer secret";
            // 拼接客户 ID 和客户密钥
            string plainCredential = customerKey + ":" + customerSecret;

            // 使用 base64 进行编码
            var plainTextBytes = Encoding.UTF8.GetBytes(plainCredential);
            string encodedCredential = Convert.ToBase64String(plainTextBytes);
            // 创建 authorization header
            string authorizationHeader = "Authorization: Basic " + encodedCredential;

            // 创建请求对象
            WebRequest request = WebRequest.Create("https://api.agora.io/dev/v1/projects");
            request.Method = "GET";

            // 添加 authorization header
            request.Headers.Add(authorizationHeader);
            request.ContentType = "application/json";

            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);

            using (Stream dataStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
            }

            response.Close();
        }
    }
}
```

#### node.js

```javascript
// 基于 node.js 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
const https = require('https')
// 客户 ID
const customerKey = "Your customer key"
// 客户密钥
const customerSecret = "Your customer secret"
// 拼接客户 ID 和客户密钥
const plainCredential = customerKey + ":" + customerSecret
// 使用 base64 进行编码
encodedCredential = Buffer.from(plainCredential).toString('base64')
authorizationField = "Basic " + encodedCredential


// 设置请求参数
const options = {
hostname: 'api.agora.io',
port: 443,
path: '/dev/v1/projects',
method: 'GET',
headers: {
    'Authorization':authorizationField,
    'Content-Type': 'application/json'
}
}

// 创建请求对象，发送请求
const req = https.request(options, res => {
console.log(`Status code: ${res.statusCode}`)

res.on('data', d => {
    process.stdout.write(d)
})
})

req.on('error', error => {
console.error(error)
})

req.end()
```

#### Python

```python
# -- coding utf-8 --
# Python 3
# 基于 Python 实现的 HTTP 基本认证示例，使用 RTC 的服务端 RESTful API
import base64
import http.client


# 客户 ID
customer_key = "Your customer key"
# 客户密钥
customer_secret = "Your customer secret"

# 拼接客户 ID 和客户密钥
credentials = customer_key + ":" + customer_secret
# 使用 base64 进行编码
base64_credentials = base64.b64encode(credentials.encode("utf8"))
credential = base64_credentials.decode("utf8")

# 通过基本 URL 创建连接对象
conn = http.client.HTTPSConnection("api.agora.io")

payload = ""

# 创建 Header 对象
headers = {}
# 添加 Authorization 字段
headers['Authorization'] = 'basic ' + credential

headers['Content-Type'] = 'application/json'

# 发送请求
conn.request("GET", "/dev/v1/projects", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

## 实现 Token 认证

### 实现方法

1. 在服务端[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms)。获取生成的 RTM Token 和生成 Token 时的 RTM 用户 ID。

2. 将 RTM Token 和 RTM 用户 ID 分别填入 HTTP 请求中 header 的 `x-agora-token` 字段和 `x-agora-uid` 字段。

### 示例代码

下列示例代码实现了 Token 认证并使用 RTM RESTful API 发送一个简单的请求，获取用户事件：

#### Java

```java
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;


// 基于 Java 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API
public class Base64Encoding {

    public static void main(String[] args) throws IOException, InterruptedException {

        // RTM Token
        String tokenHeader = "Your RTM token";
        // 生成 RTM Token 时使用的 user ID
        String uidHeader = "test_user";

        HttpClient client = HttpClient.newHttpClient();


        // 构建请求对象
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events"))
                .GET()
                // 在 header 中添加 x-agora-token 字段
                .header("x-agora-token", tokenHeader )
                // 在 header 中添加 x-agora-uid 字段
                .header("x-agora-uid", uidHeader)
                .header("Content-Type", "application/json")
                .build();
        // 发送请求
        HttpResponse<String> response = client.send(request,
                HttpResponse.BodyHandlers.ofString());

        System.out.println(response.body());
    }
}
```

#### Golang

```go
package main


import (
"fmt"
"strings"
"net/http"
"io/ioutil"
)

// 基于 Golang 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API
func main() {

// RTM Token
tokenHeader := "Your RTM Token"
// 生成 RTM Token 时使用的 user ID
uidHeader := "test_user"


url := "https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events"
method := "GET"

payload := strings.NewReader(``)

client := &http.Client {
}
req, err := http.NewRequest(method, url, payload)

if err != nil {
    fmt.Println(err)
    return
}
// 在 header 中添加 x-agora-token 字段
req.Header.Add("x-agora-token", tokenHeader)
// 在 header 中添加 x-agora-uid 字段
req.Header.Add("x-agora-uid", uidHeader)
req.Header.Add("Content-Type", "application/json")

// 发送请求
res, err := client.Do(req)
if err != nil {
    fmt.Println(err)
    return
}
defer res.Body.Close()

body, err := ioutil.ReadAll(res.Body)
if err != nil {
    fmt.Println(err)
    return
}
fmt.Println(string(body))
}
```

#### PHP

```php
<?php
// 基于 PHP 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API


// RTM Token
$token = "Your RTM Token";
// 生成 RTM Token 时使用的 user ID
$uid = "test_user";
// 在 header 中添加 x-agora-token 字段
$token_header = "x-agora-token: " . $token;
// 在 header 中添加 x-agora-uid 字段
$uid_header = "x-agora-uid: " . $uid;

$curl = curl_init();
// 发送请求
curl_setopt_array($curl, array(
CURLOPT_URL => 'https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events',
CURLOPT_RETURNTRANSFER => true,
CURLOPT_ENCODING => '',
CURLOPT_MAXREDIRS => 10,
CURLOPT_TIMEOUT => 0,
CURLOPT_FOLLOWLOCATION => true,
CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
CURLOPT_CUSTOMREQUEST => 'GET',

CURLOPT_HTTPHEADER => array(
    $token_header,
    $uid_header,
    'Content-Type: application/json'
),
));

$response = curl_exec($curl);

if($response === false) {
    echo "Error in cURL : " . curl_error($curl);
}

curl_close($curl);

echo $response;
```

#### C&#35;

```c#
using System;
using System.IO;
using System.Net;
using System.Text;
// 基于 C# 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API
namespace Examples.System.Net
{
    public class WebRequestPostExample
    {
        public static void Main()
        {

            // RTM Token
            string token = "Your RTM Token";
            // 生成 RTM Token 时使用的 user ID
            string uid = "userA";
            // 在 header 中添加 x-agora-token 字段
            string tokenHeader = "x-agora-token: " + token;
            // 在 header 中添加 x-agora-uid 字段
            string uidHeader = "x-agora-uid: " + uid;

            WebRequest request = WebRequest.Create("https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events");
            request.Method = "GET";

            // 在请求中添加 header
            request.Headers.Add(tokenHeader);
            request.Headers.Add(uidHeader);

            request.ContentType = "application/json";

            // 获取响应
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);


            using (Stream dataStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
            }

            response.Close();
        }
    }
}
```

#### node.js

```javascript
// 基于 node.js 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API
const https = require('https')


// RTM Token
token = "Your RTM Token"
// 生成 RTM Token 时使用的 user ID
uid = "test_user"

// 设置请求参数
const options = {
hostname: 'api.agora.io',
port: 443,
path: '/dev/v2/project/<Your App ID>/rtm/vendor/user_events',
method: 'GET',
headers: {
    // 在 header 中添加 x-agora-token 字段
    'x-agora-token':token,
    // 在 header 中添加 x-agora-uid 字段
    'x-agora-uid': uid,
    'Content-Type': 'application/json'
}
}

const req = https.request(options, res => {
console.log(`Status code: ${res.statusCode}`)
res.on('data', d => {
    process.stdout.write(d)
})
})

req.on('error', error => {
console.error(error)
})

req.end()
```

#### Python

```python
import http.client
# 基于 Python 实现的 Token 认证示例，使用 RTM 的用户事件 RESTful API

# 通过基本 URL 创建连接对象
conn = http.client.HTTPSConnection("api.agora.io")
# 创建 header
headers = {}
# 为 header 添加 x-agora-token 字段，内容为 RTM Token
headers['x-agora-token'] = "Your RTM Token"
# 为 header 添加 x-agora-uid 字段，内容为生成 RTM Token 时使用的 user ID
headers['x-agora-uid'] = "test_user"
headers['Content-Type'] = 'application/json'
payload = ""
# 发送请求
conn.request("GET", "/dev/v2/project/<Your App ID>/rtm/vendor/user_events", payload, headers)

res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```
