本文展示如何调用 Agora 即时通讯 RESTful API 管理群公告与群文件。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul><br>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，等同于 org_name，即时通讯服务分配给每个企业（组织）的唯一标识。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，等同于 app_name，即时通讯服务分配给每个 app 的唯一标识。 |
| `uri`                | String  | 请求 URL。                                                   |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `data`               | Array   | 实际请求到的数据。                                           |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 获取群公告

获取指定群组 ID 的群组公告。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数         | 类型   | 描述         |
| :----------- | :----- | :----------- |
| `announcement` | String | 群公告内容。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement",
    "entities": [],
    "data": {
      "announcement" : "群组公告..."
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 修改群公告

修改指定群组 ID 的群公告。注意群公告内容数据长度不能超过 512 个字符。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数   | 类型    | 描述                                                  |
| :----- | :------ | :---------------------------------------------------- |
| `id`     | String  | 群组 ID。                                             |
| `result` | Boolean | 修改群公告是否成功：<ul><li>`true`: 修改成功</li><li>`false`: 修改失败</li></ul> |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"announcement" : "群组公告…"}' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement",
    "entities": [],
    "data": {
      "id" : "66021836783617",
      "result" : true
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 获取群共享文件

分页获取指定群组 ID 的群共享文件。

成功调用该方法后，你可以从响应中获取 `file_id`，即群共享文件的唯一标识文件 ID。在下载或删除群共享文件时，即可使用该字段指定群共享文件。

该方法默认从第一页开始获取群组共享文件，每页最多可以获取 1,000 条文件。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files
 
// 分页获取群共享文件
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files?pagenum=1&pagesize=10
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| group_id | String | 群组 ID。 | 是       |

其他路径参数说明详见公共参数。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 data 字段的说明见下文。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `file_id`    | String | 群共享文件 ID。如果想要下载或移除该群共享文件，则需要使用该字段。 |
| `file_name`  | String | 群共享文件名称。                                             |
| `file_owner` | String | 上传该群共享文件的用户 ID。                                  |
| `file_size`  | Number | 群共享文件的大小，单位为字节。                               |
| `created`    | Long   | 上传该群共享文件的时间。                                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files?pagenum=1&pagesize=10'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "params": {
          "pagesize": [
              "10"
          ],
          "pagenum": [
              "1"
          ]
      },
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files",
    "entities": [],
    "data": [
          {
              "file_id": "dbd88d20-XXXX-XXXX-95fc-638fc2d59a8d",
              "file_name": "159781149272586.jpg",
              "file_owner": "u1",
              "file_size": 326127,
              "created": 1597811492594
          },
          {
              "file_id": "b30e0be0-XXXX-XXXX-8732-172a3f85134f",
              "file_name": "159781141836993.jpg",
              "file_owner": "u1",
              "file_size": 326127,
              "created": 1597811424158
          }
      ],
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## 上传群共享文件

上传指定群组 ID 的群共享文件。上传的群共享文件大小不能超过 10 MB。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见公共参数。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |
| `restrict-access` | Boolean | 是否仅群成员可见                                             | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| 参数      | 类型   | 描述                                                         |
| `file_url`  | String | 群共享文件在 Agora Chat 服务器上保存的 URL 地址。            |
| `group_id`  | String | 群组 ID。                                                    |
| `file_name` | String | 群共享文件名称。                                             |
| `created`   | Long   | 上传该群共享文件的时间。                                     |
| `file_id`   | String | 群共享文件 ID。如果想要下载或移除该群共享文件，则需要使用该字段。 |
| `file_size` | Number | 群共享文件的大小，单位为字节。                               |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -H 'restrict-access: true' -F file=@/Users/test/image/IMG_3.JPG
```

#### 响应示例

```json
{
    "action" : "post",
    "application" : "7f7b5180-XXXX-XXXX-9558-092397c841ef",
    "uri" : "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files",
    "entities" : [ ],
    "data" : {
      "file_url" : "https://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/c6906aa0-ed19-11ea-b480-f3cf141d15c0",
      "group_id" : "66021836783617",
      "file_name" : "img_3.jpg",
      "created" : 1599050554954,
      "file_id" : "c6906aa0-XXXX-XXXX-b480-f3cf141d15c0",
      "file_size" : 13512
    },
    "timestamp" : 1599050554978,
    "duration" : 0,
    "organization" : "XXXX",
    "applicationName" : "XXXX"
}
```


## 下载群共享文件

根据指定的群组 ID 和文件 ID 下载群共享文件。你可以通过获取群共享文件方法获取文件 ID（`file_id`）。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |
| `file_id`  | String | 文件 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| 参数      | 类型   | 描述                                                         |
| `file_url`  | String | 群共享文件在 Agora Chat 服务器上保存的 URL 地址。            |
| `group_id`  | String | 群组 ID。                                                    |
| `file_name` | String | 群共享文件名称。                                             |
| `created`   | Long   | 上传该群共享文件的时间。                                     |
| `file_id`   | String | 群共享文件 ID。如果想要下载或移除该群共享文件，则需要使用该字段。 |
| `file_size` | Number | 群共享文件的大小，单位为字节。                               |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-XXXX-XXXX-8732-172a3f85134f'
```

#### 响应示例

```json
{
    "action" : "post",
    "application" : "7f7b5180-XXXX-XXXX-9558-092397c841ef",
    "uri" : "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files",
    "entities" : [ ],
    "data" : {
      "file_url" : "https://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/c6906aa0-ed19-11ea-b480-f3cf141d15c0",
      "group_id" : "66021836783617",
      "file_name" : "img_3.jpg",
      "created" : 1599050554954,
      "file_id" : "c6906aa0-XXXX-XXXX-b480-f3cf141d15c0",
      "file_size" : 13512
    },
    "timestamp" : 1599050554978,
    "duration" : 0,
    "organization" : "XXXX",
    "applicationName" : "XXXX"
}
```

## 删除群共享文件

根据指定的群组 ID 和文件 ID 删除群共享文件。你可以通过获取群共享文件方法获取文件 ID（`file_id`）。

### HTTP 请求

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |
| `file_id`  | String | 文件 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数     | 类型    | 描述                                                         |
| :------- | :------ | :----------------------------------------------------------- |
| `group_id` | String  | 群组 ID。                                                    |
| `file_id`  | String  | 群共享文件 ID。如果想要下载或移除该群共享文件，则需要使用该字段。 |
| `result`   | Boolean | 删除群共享文件的结果：true: 删除成功false：删除失败          |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-XXXX-XXXX-8732-172a3f85134f'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-e1d4-11ea-8732-172a3f85134f",
    "entities": [],
    "data": {
        "group_id": "66021836783617",
        "file_id": "b30e0be0-XXXX-XXXX-8732-172a3f85134f",
        "result": true
    },
    "timestamp": 1599049350114,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="code"></a>
## 状态码汇总表

| 状态码              | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| 200                 | 请求成功。                                                   |
| 401                 | 鉴权失败。可能的原因是缺少 token、token 错误或 token 过期。请重新获取 token 后再试。 |
| 404                 | 群组 ID 不存在。                                             |
| 429，503 或其他 5xx | 调用频率超出上限，请暂停并稍后重试。如果你有更高调用频率需求，请联系技术支持。 |
| 500                 | 服务器内部错误，无法完成请求，请联系技术支持。               |