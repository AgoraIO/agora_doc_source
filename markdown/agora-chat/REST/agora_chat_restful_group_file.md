本文展示如何调用即时通讯 RESTful API 管理群公告与群文件。调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。 |
| `uri`                | String  | 请求 URL。                                                   |
| `entities`           | JSON    | 返回实体信息。                                               |
| `created`            | Number | 群组创建时间，Unix 时间戳，单位为毫秒。                      |
| `timestamp`          | Number  | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 获取群公告

获取指定群组 ID 的群组公告。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                   | 是否必填 |
| :------------ | :----- | :------------------------------ | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数         | 类型   | 描述         |
| :----------- | :----- | :----------- |
| `data` | JSON | 获取的群公告。 |
| `data.announcement` | String | 群公告内容。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

修改指定群组 ID 的群公告。群公告不能超过 512 个字符。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数   | 类型    | 描述                                                  |
| :----- | :------ | :---------------------------------------------------- |
| `data` | JSON | 群组修改结果。 |
| `data.id`     | String  | 群组 ID。                                             |
| `data.result` | Boolean | 修改群公告是否成功：<ul><li>`true`: 修改成功</li><li>`false`: 修改失败</li></ul> |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

<a name="retrieve"></a>

## 获取群共享文件

分页获取指定群组 ID 的群共享文件。调用该 API 后，你可以根据响应中返回的文件 ID（`file_id`，即群共享文件的唯一标识文件 ID）调用[下载群组共享文件](#download)接口下载该文件，或调用[删除群组共享文件](#delete)接口删除该文件。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files?pagenum=1&pagesize=10
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| group_id | String | 群组 ID。 | 是       |

参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `pagesize` | String   | 每页期望返回的共享文件数。取值范围为 [1,1000]，默认为 `1000`。| 否 |
| `pagenum` | Number | 当前页码。默认从第 1 页开始获取。  | 否 |

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `data` | JSON Array | 获取的群共享文件的信息。 |
| `data.file_id`    | String | 群共享文件 ID。若要[下载](#download)或[删除](#delete)该群共享文件，需要使用该字段。|
| `data.file_name`  | String | 群共享文件名称。                                             |
| `data.file_owner` | String | 上传该群共享文件的用户 ID。                                  |
| `data.file_size`  | Number | 群共享文件的大小，单位为字节。                               |
| `data.created`    | Number  | 上传该群共享文件的时间。                                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |
| `restrict-access` | Boolean | 是否仅群成员可见。<ul><li>`true`：是</li><li>`false`：否</li></ul>  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `data` | JSON | 上传的群共享文件的相关信息。 |
| `data.file_url`  | String | 群共享文件在服务器上保存的 URL 地址。            |
| `data.group_id`  | String | 群组 ID。                                                    |
| `data.file_name` | String | 群共享文件名称。                                             |
| `data.created`   | Number  | 上传该群共享文件的时间。                                     |
| `data.file_id`   | String | 群共享文件 ID。若要[下载](#download)或[删除](#delete)该群共享文件，需使用该字段。 |
| `data.file_size` | Number | 群共享文件的大小，单位为字节。                               |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

<a name="download"></a>

## 下载群共享文件

根据指定的群组 ID 和文件 ID 下载群共享文件。你可以调用[获取群共享文件](#retrieve)的方法获取文件 ID（`file_id`）。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |
| `file_id`  | String | 文件 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `data`      | JSON   | 下载的共享文件的相关信息。     |
| `data.file_url`  | String | 群共享文件在服务器上保存的 URL 地址。            |
| `data.group_id`  | String | 群组 ID。                                                    |
| `data.file_name` | String | 群共享文件名称。                                             |
| `data.created`   | Number   | 上传该群共享文件的时间。                                     |
| `data.file_id`   | String | 群共享文件 ID。若要[删除群共享文件](#delete)，需使用该字段。 |
| `data.file_size` | Number | 群共享文件的大小，单位为字节。                               |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

<a name="delete"></a>

## 删除群共享文件

根据指定的群组 ID 和文件 ID 删除群共享文件，文件 ID 可从[获取群组共享文件](#retrieve) 接口的响应中获取。

### HTTP 请求

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |
| `file_id`  | String | 文件 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数     | 类型    | 描述                                                         |
| :------- | :------ | :----------------------------------------------------------- |
| `data`      | JSON   | 删除的群共享文件的相关信息。     |
| `group_id` | String  | 群组 ID。                                                    |
| `file_id`  | String  | 删除的群共享文件的 ID。若要[下载群共享文件](#download)，需使用该字段。 |
| `result`   | Boolean | 是否成功删除群共享文件：<ul><li>`true`: 删除成功；</li><li>`false`：删除失败。</li></ul>         |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。