---
title: RESTful API
platform: All_Platforms|全平台
updatedAt: 2020-08-20 11:54:00
---

# Dashboard RESTful API

## 1. 认证

RESTful API 仅支持 HTTPS。用户必须通过 basic HTTP 认证:

- 用户名: Customer ID

- 密钥: Customer Certificate

与 Agora SDK 所使用的 App ID 和 App Certificate 不同，Customer ID 和 Customer Certificate 仅用于访问 Restful API。

> 你可以登录 [Dashboard](https://dashboard.agora.io)，点击右上角账户名，进入下拉菜单 RESTFUL API 页面获取 Customer ID 和 Customer Certificate。Vender Key 和 Sign Key 在 Dashboard 里已分别改名为 App ID 和 App Certificate，但本文代码里仍沿用 vendor_key 和 sign_key。

## 2. 接入点

所有请求都发送给 BaseUrl：**https://api.agora.io/dev/v1**

- 请求：参数格式必须为 JSON ，内容类型: application/json
- 响应：响应内容的格式为 JSON。以下为定义的响应状态：

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td>Status 200</td>
  <td>请求处理成功</td>
  </tr>
  <tr><td>Status 400</td>
  <td>输入格式错误</td>
  </tr>
  <tr><td>Status 401</td>
  <td>未经授权的(App ID/Customer Certificate匹配错误)</td>
  </tr>
  <tr><td>Status 404</td>
  <td>API调用错误</td>
  </tr>
  <tr><td>Status 500</td>
  <td>服务器内部错误</td>
  </tr>
  </tbody>
  </table>

## 3. 项目相关的 API

BaseUrl：**https://api.agora.io/dev/v1**

### 获取所有项目 \(GET\)

- 方法：GET
- 路径：BaseUrl/projects/
- 参数：None
- 响应：

  ```
  {
    "projects":[

                {

                  "id": 'xxxx',
                  "name": 'project1',
                  "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
                  "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
                  "recording_server": '10.2.2.8:8080',
                  "status": 1,
                  "created": 1464165672

                }

             ]
  }
  ```

- 状态：

  - 1: 启用
  - 0: 禁用

### 获取单个项目（GET）

- 方法：GET
- 路径：BaseUrl/project/
- 参数：

  ```
  {
    "id":'xxxx',
    "name":'xxxx'
  }
  ```

- 响应：

  ```
  {
    "projects":[

             {

                  "id": 'xxxx',
                  "name": 'project1',
                  "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
                  "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
                  "recording_server": '10.2.2.8:8080',
                  "status": 1,
                  "created": 1464165672

                }

             ]
  }
  ```

- 状态：

  - 1: 启用
  - 0: 禁用

### 创建项目（POST）

- 方法：POST
- 路径：BaseUrl/project/
- 参数：

  ```
  {
    "name":'projectx',
    "enable_sign_key": true
  }
  ```

- 响应：

  ```
  {
    "project":
            {

               "id": 'xxxx',
               "name": 'project1',
               "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
               "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
               "status": 1,
               "created": 1464165672

            }
  }
  ```

### 禁用或启用项目（POST）

- 方法：POST
- 路径：BaseUrl/project_status/
- 参数：

  ```
  {
    "id":'xxx',
    "status": 0
  }
  ```

- 响应：

  - 成功:

    ```
    {
      "project":
              {

               "id": 'xxxx',
               "name": 'project1',
               "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
               "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
               "status": 0,
               "created": 1464165672

               }

     }
    ```

  - 如果指定的项目不存在 \(被删除或不存在\):

    ```
    status 404
    content:
    {

      "error_msg": "project not exist"

    }
    ```

### 删除项目（DELETE）

- 方法：DELETE
- 路径：BaseUrl/project/
- 参数：

  ```
  {
    "id":'xxxx'
  }
  ```

- 响应：

  - 项目已删除：

    ```
    {
      "success": true
    }
    ```

  - 未找到项目：

    ```
    status 404

     {
        "error_msg": "project not exist"
     }
    ```

### 设置项目的录制项目服务器 IP（POST）

- 方法：POST
- 路径：BaseUrl/recording_config/
- 参数：

  ```
  {
    "id":'xxxx',
    "recording_server": '10.12.1.5:8080'
  }
  ```

> - 如果您使用的 Recording SDK 版本 <= v1.9.0，请关注 `recording_server` 字段；
> - 如果您使用的 Recording SDK 版本 \>= v1.11.0，请忽略 `recording_server` 字段。

- 响应：

  - 成功

    ```
    {
      "success": true
    }
    ```

  - 项目未找到或已禁用：

    ```
    status 404

     {
       "error_msg": "project not exist"
     }
    ```

### 启用项目 App Certificate（POST）

- 方法：POST
- 路径：BaseUrl/signkey/
- 参数：

  ```
  {
    "id": `xxx`,
    "enable": true
  }
  ```

- 响应：

  - 成功

    ```
    {

      "success": true

    }
    ```

  - 项目未找到或已禁用：

    ```
    status 404
    {

      "error_msg": "project not exist"

    }
    ```

### 重置项目的 App Certificate（POST）

- 方法：POST
- 路径：BaseUrl/reset_signkey/
- 参数：

  ```
  { "id": “xxx”} // 项目 id
  ```

- 响应：

  - 成功

    ```
    {
      "success": true
    }
    ```

  - 项目未找到或已禁用：

    ```
    status 404
      {
        "error_msg": "project not exist"
      }
    ```

> 如果该项目的 App Certificate 尚未启用，调用该方法会启用 App Certificate 。

## 4. 用量相关的 API

BaseUrl：**https://api.agora.io/dev/v1**

### 获取用量数据（GET)

- 方法：GET
- 路径：BaseUrl/usage/
- 参数 (格式为一个日期到另一个日期的 YYYY-MM-DD)：

  ```
  "from_date"=YYYY-MM-DD&to_date=YYYY-MM-DD&projects=id1,id2,id3
  "from_date"=2015-01-01&to_date=2015-03-21&projects=id1,id2
  ```

  您可以指定项目，但如果不指定，系统将查询该账户下的全部项目。

- 响应：

  - 成功：

    ```
    {
      "usages":[

                { "project": 'xxx',
                            "daily": [
                                  { "date": 20150101, "audio": 20, "sd": 100, "hd": 132, "hdp": 225},
                                  { "date": 20150102, "audio": 20, "sd": 100, "hd": 132, "hdp": 225},
                              ]
                            },

                            { "project": 'yyy',
                              "daily": [....]
                            }

              ]
    }
    ```

  - 报错: 如果指定的项目 \(projects\) 不存在，会直接被忽略。不会报错。

> 该响应中 _audio_、_sd_、_hd_ 及 _hdp_ 的单位为分钟。

## 5. 服务端踢人 API

BaseUrl: **https://api.agora.io/dev/v1**

### 创建规则 (POST)

- 方法：POST
- 路径：BaseUrl/kicking-rule/
- 参数:

  ```
  {
          "appid":"",   // dashboard中项目的appID，必填
          "cname":"",   // channel name 频道名称，非必填，可以不传，但不能传 cname:""
          "uid":"",     // uid，sdk可以获取到，非必填，可以不传，但不能传 uid:0
          "ip":"",      // IP地址需要封的用户IP，非必填，可以不传，但不能传 ip:0
          "time": 60    //  封人时间，单位是分钟，最大1440分钟，如果大于1440分钟，会被处理成1440分钟，最小一分钟,非必填。比如：time:60
   }
  ```

>     踢人规则通过 cname、uid 和 ip 三个字段组合起来过滤实现，规则如下：
>     -   如果填写 ip，不填写 cname 或 uid，则该 ip 无法登陆 App 中的任何频道
>     -   如果填写 cname，不填写 uid 或 ip，则任何人都无法登陆 App 中该 cname 对应的频道
>     -   如果填写 cname 和 uid，不填写 ip，则该 uid 无法登陆 App 中该 cname 对应的频道

- 响应：

  ```
  {
      "status": "success",  // 请求状态
      "id": 1953            // 规则id，如：更新规则是需要带上此id
  }
  ```

### 获取规则列表 (GET)

- 方法：GET
- 路径：BaseUrl/kicking-rule/
- 参数：

  ```
  {
     "appid":""    // dashboard中项目的appID，必填
   }
  ```

- 响应：

  ```
  {
      "status": "success",                                    // 请求状态
      "rules": [
          {
              "id": 1953,                                     // 规则id，如：更新规则是需要带上此id
              "appid": "80e54398fed94ae8a010acf782f569b7"     // 对应dashboard中项目的appID
              "uid": 1,                                       // uid，客户端中看到
              "opid": 1406,                                   // 操作id，用于核对操作记录（查问题时使用）
              "cname": "11",                                  // 频道名
              "ip": null,                                     // ip地址
              "ts": "2018-01-09T07:23:06.000Z",               // 规则生效截止时间
              "createAt": "2018-01-09T06:23:06.000Z",         // 规则创建时间
              "updateAt": "2018-01-09T14:23:06.000Z"          // 规则更新时间
          }
      ]
  }
  ```

### 更新规则时间 (PUT)

- 方法：PUT
- 路径：BaseUrl/kicking-rule/
- 参数：

  ```
  {
           "appid":"",   // dashboard中项目的appID，必填
           "id":"",      // 获取规则列表的规则id，必填
           "time":""     // 需要更新的封人的时间，必填
  }
  ```

- 响应：

  ```
  {
      "result": {
          "id": 1953,                         // 规则id，
          "ts": "2018-01-09T08:45:54.545Z"    // 规则生效截止时间
      },
      "status": "success"                     // 请求状态
  }
  ```

### 删除规则 \(DELETE\)

- 方法：DELETE
- 路径：BaseUrl/kicking-rule/
- 参数：

  ```
  {
      "appid":"",   // dashboard中项目的appID，必填
      "id":""       // 获取规则列表的规则id，必填
  }
  ```

- 响应：

  ```
  {
      "status": "success",  // 请求状态
      "id": 1953            // 规则id，如：更新规则是需要带上此id
  }
  ```

## 6. 在线查询频道信息 API

BaseUrl：**http://api.agora.io/dev/v1/**

> 为防止大量异常请求影响其他用户的正常使用，我们对 API 的调用频率做了限制。当达到限流阈值时，会返回 HTTP 错误 429 \(Too Many Requests\)。我们认为设置的阈值可以满足绝大多数用户的使用场景，如果您被限制，请尝试调整调用频率。如果该限制使您的需求无法得到满足，请联系 [sales@agora.io](mailto:sales@agora.io) 。

### 关于用户角色

目前通过 RESTful API 查询到的用户角色（即 online role），和调用 SDK 的 setClientRole 指定的角色含义不同。Online role 是根据频道模式，以及用户的上行媒体流类型来区分的，共有以下几种：

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Online Role</td>
<td>枚举值</td>
</tr>
<tr><td>未知</td>
<td>0</td>
</tr>
<tr><td>通信模式用户</td>
<td>1</td>
</tr>
<tr><td>直播模式视频主播</td>
<td>2</td>
</tr>
<tr><td>直播模式观众</td>
<td>3</td>
</tr>
<tr><td>直播模式纯音频主播</td>
<td>4</td>
</tr>
</tbody>
</table>

> 目前 _直播模式纯音频主播_ 尚未区分，会被归属到 _直播模式观众_ 中。

### 查询用户在频道中的状态信息 \(GET\)

该方法查询某个用户是否在指定频道中，如果是，则给出用户在该频道中的角色等状态。

- 方法：GET
- 路径：BaseUrl/channel/user/property/
- 参数: appid, uid, cname

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>appid</td>
  <td>必填，dashboard 中项目的 appID</td>
  </tr>
  <tr><td>uid</td>
  <td>必填，用户 ID，可以通过 SDK 获取到</td>
  </tr>
  <tr><td>cname</td>
  <td>必填，channel name，频道名称</td>
  </tr>
  </tbody>
  </table>

如：/channel/user/property/<appid\>/<uid\>/<channelName\>

- 响应:

      ```
      {
           "success": true,
           "data": {
               "in_channel": false,
               "role": 2
           }
      }
      ```

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>success</td>
  <td><p>查询请求状态</p>
  <ul>
  <li>true：请求成功</li>
  <li>false：请求不成功</li>
  </ul>
  </td>
  </tr>
  <tr><td>in_channel</td>
  <td><p>查询用户是否在频道内</p>
  <ul>
  <li>true：用户在频道内</li>
  <li>false：用户不在频道内</li>
  </ul>
  </td>
  </tr>
  <tr><td>role</td>
  <td><p>查询用户在频道内的角色</p>
  <ul>
  <li>0：未知</li>
  <li>1：用户角色为通信用户</li>
  <li>2：用户角色为直播模式视频主播</li>
  <li>3：用户角色为主播模式观众</li>
  <li>4：用户角色为直播模式纯音频主播</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>

### 查询频道内的分角色用户列表 \(GET\)

该方法查询指定频道内的分角色用户列表。

- 方法：GET
- 路径：BaseUrl/channel/user/
- 参数: appid, cname

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>appid</td>
  <td>必填，dashboard 中项目的 appID</td>
  </tr>
  <tr><td>cname</td>
  <td>必填，channel name，频道名称</td>
  </tr>
  </tbody>
  </table>

如：/channel/user/<appid\>/<channelName\>

- 响应:

      ```
      // 如果是通信频道
      {
           "success": true,
           "data": {
               "channel_exist": true,
               "mode": 1,
               "total": 1,
               "users": [
                   <uid>
               ]
            }
       }

      // 如果频道不存在
      {
          "success": true,
          "data": {
              "channel_exist": false
          }
      }
      ```

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>success</td>
  <td><p>查询请求状态</p>
  <ul>
  <li>true：请求成功</li>
  <li>false：请求不成功</li>
  </ul>
  </td>
  </tr>
  <tr><td>channel_exsit</td>
  <td><p>查询频道是否存在：</p>
  <ul>
  <li>true：频道存在</li>
  <li>false：频道不存在</li>
  </ul>
  </td>
  </tr>
  <tr><td>mode</td>
  <td><p>查询频道模式：</p>
  <ul>
  <li>1：频道为通信模式</li>
  <li>2：频道为直播模式</li>
  </ul>
  </td>
  </tr>
  <tr><td>total</td>
  <td>频道内的用户总人数</td>
  </tr>
  <tr><td>users</td>
  <td>频道内所有用户的 uid</td>
  </tr>
  </tbody>
  </table>

### 查询厂商频道列表 \(GET\)

该方法查询指定厂商的频道列表。

- 方法：GET
- 路径：BaseUrl/channel/appid/
- 参数：?page_no=0&page_size=100（非必须）

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>page_no</td>
  <td>选填，起始页码，默认值为 0</td>
  </tr>
  <tr><td>page_size</td>
  <td>选填，每页条数，默认值为 100</td>
  </tr>
  </tbody>
  </table>

如: /channel/<appid\>

带参数: /channel/<appid\>/?page_no=0&page_size=100

- 响应:

      ```
       {
                "success": true,
                "data": {
                    "channels": [
                        {
                            "channel_name": "lkj144",
                            "user_count": 3
                        }
                    ],
                    "total_size": 3
            }

      }
      ```

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>参数</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td>success</td>
  <td><p>查询请求状态</p>
  <ul>
  <li>true：请求成功</li>
  <li>false：请求不成功</li>
  </ul>
  </td>
  </tr>
  <tr><td>channel_name</td>
  <td>频道名</td>
  </tr>
  <tr><td>user_count</td>
  <td>频道内用户数量</td>
  </tr>
  <tr><td>total_size</td>
  <td>频道总数</td>
  </tr>
  </tbody>
  </table>

> 使用该方法查询后会将结果缓存 1 分钟。因此一分钟内再次查询会从缓存结果中提取，而不再更新数据。

## 7. 错误代码和警告代码

详见 [错误代码和警告代码](/cn/API%20Reference/the_error_native)。
