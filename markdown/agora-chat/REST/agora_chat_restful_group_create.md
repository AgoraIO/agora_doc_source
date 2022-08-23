# 创建群组

用户登录即时通讯 IM 后就可以创建群组、修改群组消息、删除创建的群组。

本文展示如何调用 Agora 即时通讯 RESTful API 创建、获取、修改并删除群组。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                                                                                       | 是否必填 |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。                                                                                                                                                                 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。                                                                                                                                                            | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。                                                                                                                                                                   | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                     |
| :---------------- | :----- | :----------------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                               |
| `organization`    | String | 组织 ID，等同于 org_name，即时通讯服务分配给每个企业（组织）的唯一标识。 |
| `application`     | String | 系统内为 app 生成的唯一内部标识，无需关注。                              |
| `applicationName` | String | App ID，等同于 app_name，即时通讯服务分配给每个 app 的唯一标识。         |
| `uri`             | String | 请求 URL。                                                               |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                              |
| `entities`        | JSON   | 返回实体信息。                                                           |
| `data`            | Array  | 实际请求到的数据。                                                       |
| `Long`            | Number | 响应的 Unix 时间戳（毫秒）。                                             |
| `duration`        | Number | 从发送请求到响应的时长（毫秒）。                                         |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 创建群组

创建一个新的群组，并设置群组名称、群组描述、公开群/私有群属性、群成员最大人数（包括群主）、加入公开群是否需要批准、群主、以及群成员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups
```

#### 路径参数

路径参数说明详见公共参数。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。请填 `application/json` | 是       |
| `Accept`        | String | 内容类型。请填 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数                  | 类型    | 描述                                                                                                                                                                             | 是否必需 |
| :-------------------- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `groupname`           | String  | 群组名称，最大长度为 128 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                                                                               | 是       |
| `desc`                | String  | 群组描述，最大长度为 512 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                                                                               | 是       |
| `public`              | Boolean | 群组是否为公开群。公开群可以被搜索到，用户可以申请加入公开群；私有群不可以被搜索到，因此需要群主或群管理员添加，用户才可以加入。<ul><li>`true`：是</li><li>`false`：否</li></ul> | 是       |
| `maxusers`            | String  | 群组成员（包含群主）数量最大值。默认值为 200，最大值为 2000。不同套餐支持的人数上限不同，详情可以参考[套餐包详情](./agora_chat_plan?platform=RESTful)                            | 否       |
| `allowinvites`        | Boolean | 是否允许群组成员邀请别人加入群组：<ul><li>`true`：允许</li><li>`false`：不允许。只有群主或者群管理员才可以加人</li></ul>                                                         | 否       |
| `membersonly`         | Boolean | 用户加入公开群是否需要群主或者群管理员批准：<ul><li>`true`：需要</li><li>`false`：(默认) 不需要</li></ul>                                                                        | 否       |
| `invite_need_confirm` | Bool    | 邀请用户入群时是否需要被邀用户同意。<ul><li> （默认）`true`：是；</li><li> `false`：否。</li></ul>                                                                                            | 否       |
| `owner`               | String  | 该群组的群主。                                                                                                                                                                   | 是       |
| `members`             | Array   | 群组成员。该数组中不需要包含群主。如果设置该字段，则至少要提供一个数组元素，最多不能超过 100 个。                                                                                | 否       |
| `custom`              | String  | 群组扩展信息，例如给群组添加业务相关标记，最大长度为 1,024 字符。                                                                                                                | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 的 data 字段中包含如下内容：

| 参数      | 类型   | 说明      |
| :-------- | :----- | :-------- |
| `groupid` | String | 群组 ID。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "groupname": "testgroup",
    "desc": "test",
    "public": true,
    "maxusers": 300,
    "owner": "testuser",
    "members": [
      "user2"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups",
    "entities": [],
    "data": {
      "groupid": "6602XXXX783617"
    },
    "timestamp": 1542361730243,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 获取群组详情

获取指定的一个或多个群组的详情。如果你指定获取多个群组的详情，会返回所有存在群组的详情。如果你指定的群组不存在，会返回 "group id doesn't exist"。

### HTTP 详情

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_ids}
```

#### 路径参数

| 参数        | 类型   | 描述                                                                  | 是否必需 |
| :---------- | :----- | :-------------------------------------------------------------------- | :------- |
| `group_ids` | String | 想获取详情的群组 ID。如果想获取多个群组的详情，则使用英文的逗号隔开。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 参数类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中的 data 字段说明如下：

| 参数                 | 类型    | 说明                                                                                                                    |
| :------------------- | :------ | :---------------------------------------------------------------------------------------------------------------------- |
| `id`                 | String  | 群组 ID，是群组的唯一标识。                                                                                             |
| `name`               | String  | 群组名称。                                                                                                              |
| `description`        | String  | 群组描述。                                                                                                              |
| `membersonly`        | Boolean | 用户申请入群是否需要群主或者群管理员审批：<ul><li>`true`：需要</li><li>`false`：(默认) 不需要</li></ul>                 |
| `allowinvites`       | Boolean | 是否允许群组成员邀请别人加入群组：<ul><li>`true`：允许</li><li>`false`：不允许</li></ul>                                |
| `maxusers`           | Number  | 群组成员（包含群主）数量最大值。                                                                                        |
| `owner`              | String  | 群主的 Agora Chat ID，如 `{"owner":"user1"}`。                                                                          |
| `created`            | Long    | 群组创建的时间戳。                                                                                                      |
| `affiliations_count` | Number  | 群成员总人数。                                                                                                          |
| `affiliations`       | Array   | 现有群成员列表，包含了群主 owner 和其他群成员 member，如：`[{"owner":"user1"},{"member":"user2"},{"member":"user3"}]`。 |
| `public`             | Boolean | 群组是否为公开群：<ul><li>`true`：是</li><li>`false`：否</li></ul>                                                      |
| `custom`             | String  | 群组扩展信息。                                                                                                          |

其他相应参数说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585",
    "entities": [],
    "data": [
      {
        "id": "66016455491585",
        "name": "testgroup1",
        "description": "testgroup1",
        "membersonly": false,
        "allowinvites": false,
        "maxusers": 200,
        "owner": "user1",
        "created": 1542356598609,
        "custom": "",
        "affiliations_count": 3,
        "affiliations": [
          {
            "member": "user3"
          },
          {
            "member": "user2"
          },
          {
            "owner": "user1"
          }
        ],
        "public": true
      }
    ],
    "timestamp": 1542360200677,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
}
```

## 修改群组信息

修改指定的群组消息。该方法仅支持修改 `groupname`、`desc`、`maxusers`、`membersonly`、`allowinvites` 和 `custom` 字段。如果传入其他字段，或传入的字段不存在，则不能修改的字段会抛出异常。

### HTTP 请求

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必需 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json` | 是       |
| `Accept`        | String | 参数类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数           | 类型    | 描述                                                                                                                     | 是否必需 |
| :------------- | :------ | :----------------------------------------------------------------------------------------------------------------------- | :------- |
| `groupname`    | String  | 群组名称，最大长度为 128 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                       | 是       |
| `desc`         | String  | 群组描述，最大长度为 512 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                       | 是       |
| `maxusers`     | String  | 群组成员（包含群主）数量最大值。默认值为 200，最大值为 2000。不同套餐支持的人数上限不同，详情可以参考计费文档            | 否       |
| `allowinvites` | Boolean | 是否允许群组成员邀请别人加入群组：<ul><li>`true`：允许</li><li>`false`：不允许。只有群主或者群管理员才可以加人</li></ul> | 否       |
| `membersonly`  | Boolean | 用户加入公开群是否需要群主或者群管理员批准：<ul><li>`true`：需要</li><li>`false`：(默认) 不需要</li></ul>                | 否       |
| `custom`       | String  | 群组扩展信息，例如给群组添加业务相关标记，最大长度为 1,024 字符。                                                        | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中的 data 字段说明详见下文：

| 字段                | 类型 | 说明                                                                                                                          |
| :------------------ | :--- | :---------------------------------------------------------------------------------------------------------------------------- |
| `data.description`  | Bool | 群组描述：<ul><li>`true`：修改成功;</li><li> `false`：修改失败。</li></ul>                                                    |
| `data.maxusers`     | Bool | 群组最大成员数：<ul><li>`true`：修改成功;</li><li>`false`：修改失败。</li></ul>                                               |
| `data.groupname`    | Bool | 群组名称：<ul><li>`true`：修改成功;</li><li> `false`：修改失败。</li></ul>                                                    |
| `data.membersonly`  | Bool | 加入群组是否需要群主或者群管理员审批：<ul><li>`true`：是;</li><li>`false`：否。</li></ul>                                     |
| `data.allowinvites` | Bool | 是否允许群成员邀请别人加入此群<ul><li>`true`：允许群成员邀请人加入此群;</li><li>`false`：只有群主才可以往群里加人。</li></ul> |

其他相应字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "groupname": "testgroup1",
    "description": "test",
    "maxusers": 300,
    "membersonly": true,
    "allowinvites": true
}' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617'
```

#### 响应示例

```json
{
    "action": "put",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617",
    "entities": [],
    "data": {
      "membersonly": true,
      "allowinvites": true,
      "description": true,
      "maxusers": true,
      "groupname": true
    },
    "timestamp": 1542363146301,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 删除群组

删除一个指定的群组。

### HTTP 请求

```http
DELETE https://{host}//{org_name}/{app_name}/chatgroups/{group_id}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必需 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 参数类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中的 `data` 字段说明详见下文：

| 参数      | 类型    | 描述                                            |
| :-------- | :------ | :---------------------------------------------- |
| `success` | Boolean | 是否成功删除群组：true：删除成功false：删除失败 |
| `groupid` | String  | 删除的群组 ID。                                 |

其他相应字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617",
    "entities": [],
    "data": {
      "success": true,
      "groupid": "66021836783617"
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 获取所有群组（可分页）

获取 app 所有群组的信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups

// 分页获取 app 所有群组的信息
GET https://{host}/{org_name}/{app_name}/chatgroups?limit={N}&cursor={cursor}
```

#### 路径参数

路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 参数类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数     | 类型   | 描述                                                                                               | 是否必需 |
| :------- | :----- | :------------------------------------------------------------------------------------------------- | :------- |
| `limit`  | String | 一次请求获取的群组数量。                                                                           | 否       |
| `cursor` | String | 分页页码。如果你需要分页获取群组详情，则需要设置该参数。设置后，服务器会从游标起始的地方进行查询。 | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段说明如下：

| 参数            | 类型   | 描述                                      |
| :-------------- | :----- | :---------------------------------------- |
| `owner`         | String | 群主 ID。如 `{"owner":"user1"}`。         |
| `groupid`       | String | 群组 ID。                                 |
| `affiliations`  | Number | 群组现有人数。                            |
| `type`          | String | 群组类型。                                |
| `last_modified` | String | 最近一次修改群组信息的时间戳，单位为 ms。 |
| `groupname`     | String | 群组名称。                                |
| `count`         | Number | 实际返回的群组数量。                      |
| `cursor`        | String | 分页页码。                                |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
// 分页获取第一页上的群组信息
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups?limit=2'

// 分页获取第二页上的群组信息
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups?limit=2&cursor=ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06Z3JvdXA6ZWFzZW1vYi1kZW1vI3Rlc3RhcHA6Mg'
```

#### 响应示例

```json
{
    "action": "get",
    "params": {
        "limit": [
            "2"
        ]
    },
    "uri": "https://XXXX/XXXX/XXXX/chatgroups",
    "entities": [],
    "data": [
        {
            "owner": "XXXX#XXXX_user1",
            "groupid": "100743775617286960",
            "affiliations": 2,
            "type": "group",
            "last_modified": "1441021038124",
            "groupname": "testgroup1"
        },
        {
            "owner": "XXXX#XXXX_user2",
            "groupid": "100973270123152176",
            "affiliations": 1,
            "type": "group",
            "last_modified": "1441074471486",
            "groupname": "testgroup2"
        }
    ],
    "timestamp": 1441094193812,
    "duration": 14,
    "cursor": "Y2hhdGdyb3VwczplYXNlbW9iLWRlbW8vY2hhdGRlbW91aV8z",
    "count": 2
}
```

## 获取单个用户加入的所有群组（可分页）

根据用户 ID 称获取该用户加入的全部群组。

### HTTP 请求

直接请求：

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/joined_chatgroups
```

分页请求：

```http
GET https://{host}/{app_name}/users/{username}/joined_chatgroups?pagesize={}&pagenum={}
```

#### 路径参数

该方法路径参数说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必需 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明如下：

| 参数             | 类型   | 描述       |
| :--------------- | :----- | :--------- |
| `data.groupid`   | String | 群组 ID。  |
| `data.groupname` | String | 群组名称。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> '' 'http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups'
```

分页获取示例：

```json
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups?pagesize=1&pagenum=100'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups",
    "entities": [],
    "data": [
      {
        "groupid": "66XXXX85",
        "groupname": "testgroup1"
      },
      {
        "groupid": "66016467025921",
        "groupname": "testgroup2"
      },
    ],
    "timestamp": 1542359565885,
    "duration": 1,
    "organization": "XXXX",
  "applicationName": "testapp",
  "count": 2
}
```

分页获取响应示例：

```json
{
    "action":"get",
    "application":"8bXXXX02",
    "applicationName":"testapp",
    "count":0,
    "data":[

    ],
    "duration":0,
    "entities":[

    ],
    "organization":"XXXX",
    "params":{
        "pagesize":[
            "1"
        ],
        "pagenum":[
            "100"
        ]
    },
    "properties":{

    },
    "timestamp":1645177932072,
    "uri":"http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups"
}
```

<a name="code"></a>
## 状态码

有关详细信息，请参阅 [HTTP 状态代码](https://docs.agora.io/en/agora-chat/agora_chat_status_code?platform=RESTful)。