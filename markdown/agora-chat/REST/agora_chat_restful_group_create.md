用户登录即时通讯 IM 后可以创建群组、修改群组消息以及删除创建的群组。

调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                 | 是否必填 |
| :--------- | :----- | :----------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。         | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。         | 是       |
| `group_id` | String | 群组 ID。| 是       |
| `username` | String | 用户 ID。| 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                     |
| :---------------- | :----- | :----------------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                               |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 系统内为 app 生成的唯一内部标识，无需关注。                              |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。       |
| `uri`             | String | 请求 URL。                                                               |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                              |
| `entities`        | JSON   | 返回实体信息。                                                           |
| `timestamp`       | Number | 响应的 Unix 时间戳，单位为毫秒。                                            |
| `duration`        | Number | 从发送请求到响应的时长，单位为毫秒。                                         |

## 群组角色

群组角色包含群主、群管理员和普通群成员，三个角色权限范围依次递减。

- 群主拥有群的所有权限；
- 群管理员拥有管理黑名单、白名单和禁言等权限；
- 群主加管理员数量共 100 个，即管理员最多可添加 99 个。

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下`Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 创建群组

创建一个群组，并设置群组名称、群组描述、公开群/私有群属性、群成员最大人数（包括群主）、加入公开群是否需要批准、群主、群成员、群组扩展信息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。请填 `application/json`。 | 是       |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。      | 是       |

#### 请求 body

| 参数                  | 类型    | 描述       | 是否必填 |
| :-------------------- | :------ | :----------------------------------------------- | :------- |
| `groupname`           | String  | 群组名称，最大长度为 128 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                                                                               | 是       |
| `description`                | String  | 群组描述，最大长度为 512 个字符。不支持 “/”。如果群组名称有空格，则使用 “+” 代替。                                                                                               | 是       |
| `public`              | Boolean | 群组是否为公开群。公开群可以被搜索到，用户可以申请加入公开群；私有群无法被搜索到，因此需要群主或群管理员添加，用户才可以加入。<ul><li>`true`：公开群</li><li>`false`：私有群</li></ul> | 是       |
| `maxusers`            | String  | 群组最大成员数（包含群主）。默认值为 200。不同套餐支持的人数上限不同，详见[套餐包详情](./agora_chat_plan?platform=RESTful)。                            | 否       |
| `allowinvites`        | Boolean | 是否允许群组成员邀请用户加入群组：<ul><li>`true`：群成员可拉人入群。</li><li>`false`：只有群主或者管理员才可以拉人入群。</li></ul>                                                         | 否       |
| `membersonly`         | Boolean | 用户加入公开群是否需要群主或者群管理员批准：<ul><li>`true`：需要</li><li>`false`：(默认) 不需要，用户直接进群。</li></ul>                                                                        | 否       |
| `invite_need_confirm` | Boolean    | 邀请用户入群时是否需要受邀用户同意。<ul><li>（默认）`true`：需要。受邀用户同意后才能加入群组；</li><li> `false`：不需要。邀请人直接拉用户进群。</li></ul>                                                                                            | 否       |
| `owner`               | String  | 群主。               | 是       |
| `members`             | Array   | 群组成员的用户 ID 数组，可包含 1-100 个元素，不涉及群主的用户 ID。                                                                                | 否       |
| `custom`              | String  | 群组扩展信息，例如可以给群组添加业务相关的标记，不能超过 1,024 个字符。    | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述      |
| :-------- | :----- | :-------- |
| `data` | JSON | 创建的群组的相关信息。 |
| `data.groupid` | String | 群组 ID。 |

其他字段及说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "groupname": "testgroup",
    "description": "test",
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

### 封禁群组

封禁指定的群组。例如，群成员经常在群中发送违规消息，可以调用该 API 对该群进行封禁。群组被封禁后，群中任何成员均无法在群组以及该群组下的子区中发送和接收消息，也无法进行群组和子区管理操作。

群组封禁后，可调用[解禁群组](#enablegroup) API 对该群组解禁。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/disable
```

##### 路径参数

参数及描述详见 [公共参数](#pubparam)。

##### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型      | 描述 |
|:------|:--------|:--|
| `data` | JSON | 群组禁用相关信息。 |
| `data.disabled` | Boolean | 群组是否为禁用状态：<br/> - `true`：群组被禁用；<br/> - `false`：群组为启用状态。 |

其他字段及描述详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/XXXX/disable' 
```

##### 响应示例

```json
{
    "action": "post",
    "application": "XXXX",
    "applicationName": "XXXX",
    "data": {
        "disabled": true
    },
    "duration": 740,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1672974260359,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/XXXX/disable"
}
```

### 解禁群组<a name="enablegroup"></a>

解除对指定群组的封禁。群组解禁后，群成员可以在该群组以及该群组下的子区中发送和接收消息并进行群组和子区管理相关操作。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/enable
```

##### 路径参数

参数及描述详见 [公共参数](#pubparam)。

##### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                  |
| :-------- | :----- |:--------------------|
| `data` | JSON | 群组解禁相关信息。 |
| `data.disabled` | Boolean | 群组是否为禁用状态：<br/> - `true`：群组被禁用；<br/> - `false`：群组为启用状态。 |

其他字段及描述详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。
#### 示例

##### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/XXXX/enable' 
```

##### 响应示例

```json
{
    "action": "post",
    "application": "XXXX",
    "applicationName": "XXXX",
    "data": {
        "disabled": false
    },
    "duration": 22,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1672974668171,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/XXXX/enable"
}
```

## 获取群组详情

获取指定的一个或多个群组的详情，最多可获取 100 个群组的详情。如果你指定获取多个群组的详情，会返回所有存在群组的详情。如果你指定的群组不存在，会返回 "group id doesn't exist"。

### HTTP 详情

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_ids}
```

#### 路径参数

| 参数        | 类型   | 描述                                                                  | 是否必填 |
| :---------- | :----- | :-------------------------------------------------------------------- | :------- |
| `group_ids` | String | 要获取详情的群组 ID。最多可传 100 个群组 ID，以逗号分隔。 | 是       |

其他参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。请填 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数                 | 类型    | 描述                                                                                                                   |
| :------------------- | :------ | :---------------------------------------------------------------------------------------------------------------------- |
| `data`               | JSON | 获取的群组详情。                                                                                             |
| `data.id`                 | String  | 群组 ID，群组唯一标识。                                                                                             |
| `data.name`               | String  | 群组名称。                                                                                                              |
| `data.description`        | String  | 群组描述。                                                                                                              |
| `data.membersonly`        | Boolean | 用户申请入群是否需要群主或者群管理员审批：<ul><li>`true`：需要</li><li>`false`：不需要</li></ul>                 |
| `data.allowinvites`       | Boolean | 是否允许群组成员邀请用户加入群组：<ul><li>`true`：允许群成员邀请其他用户加入此群</li><li>`false`：只有群主可以邀请其他用户入群。</li></ul>                                |
| `data.maxusers`           | Number  | 群组最大成员数（包含群主）。                                                                                        |
| `data.owner`              | String  | 群主的用户 ID，如 `{"owner":"user1"}`。                                                                          |
| `data.created`            | Long    | 群组创建的时间戳。                                                                                                      |
| `data.affiliations_count` | Number  | 群组现有成员总数。                                                                                                          |
| `data.disabled`           | Boolean | 群组是否为禁用状态：<ul><li>`true`：群组被禁用；</li><li>`false`：群组为启用状态。</li></ul> |
| `data.affiliations`       | Array   | 现有群成员列表，包含了群主 owner 和其他群成员 member，如：`[{"owner":"user1"},{"member":"user2"},{"member":"user3"}]`。 |
| `data.public`             | Boolean | 群组是否为公开群：<ul><li>`true`：公开群</li><li>`false`：私有群</li></ul>       |
| `data.custom`             | String  | 群组扩展信息。                                                                                                          |

其他相应参数说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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
        "disabled": false,
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

修改指定的群组消息。该方法仅支持修改 `groupname`、`description`、`maxusers`、`membersonly`、`allowinvites`、`invite_need_confirm`、`public` 和 `custom` 字段。如果传入其他字段，或传入的字段不存在，则对不能修改的字段抛出异常。

### HTTP 请求

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 Bearer ${YourAppToken}，其中 Bearer 是固定字符，后面加英文空格，再加获取到的 token 值。         | 是       |

#### 请求 body

| 参数           | 类型    | 描述                                                                                                                     | 是否必填 |
| :------------- | :------ | :----------------------------------------------------------------------------------------------------------------------- | :------- |
| `groupname`    | String  | 群组名称，最大长度为 128 个字符。不支持 “/”。如果有空格，使用 “+” 代替。                                       | 是       |
| `description`         | String  | 群组描述，最大长度为 512 个字符。不支持 “/”。如果有空格，使用 “+” 代替。                                  | 是       |
| `maxusers`     | String  | 群组最大成员数（包含群主）。默认值为 200。不同套餐支持的人数上限不同，详见[套餐包详情](./agora_chat_plan?platform=RESTful)。              | 否       |
| `allowinvites` | Boolean | 是否允许群组成员邀请用户加入群组：<ul><li>`true`：群成员可拉人入群。</li><li>（默认）`false`：只有群主或者管理员才可以拉人入群。</li></ul> | 否       |
| `invite_need_confirm` | Boolean   | 邀请用户入群时是否需要受邀用户同意：<ul><li>（默认）`true`：需要。受邀用户同意后才能加入群组；</li><li>`false`：不需要。邀请人直接拉用户进群。</li></ul> | 否       |
| `membersonly`  | Boolean | 用户加入公开群是否需要群主或者群管理员批准：<ul><li>`true`：需要</li><li>（默认）`false`：不需要，用户直接进群。</li></ul>                | 否       |
| `custom`       | String  | 群组扩展信息，例如给群组添加业务相关标记，不能超过 1,024 个字符。    | 否       |
| `public`              | Boolean   | 是       | 是否是公开群：<ul><li>`true`：公开群；</li><li>`false`：私有群。</li></ul>        |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中的 data 字段说明详见下文：

| 字段                | 类型 | 说明                                                                                                                          |
| :------------------ | :--- | :---------------------------------------------------------------------------------------------------------------------------- |
| `data.description`  | Boolean | 群组描述是否修改成功：<ul><li>`true`：修改成功；</li><li> `false`：修改失败。</li></ul>                                                    |
| `data.maxusers`     | Boolean | 群组最大成员数是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul>                                               |
| `data.groupname`    | Boolean | 群组名称是否修改成功：<ul><li>`true`：修改成功；</li><li> `false`：修改失败。</li></ul>                                                    |
| `data.membersonly`  | Boolean | “加入群组是否需要群主或者群管理员审批”是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul>   |
| `data.public`  | Boolean | “是否是公开群”是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul>   |
| `data.custom`  | String | 群组扩展信息是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul>   |
| `data.allowinvites` | Boolean | “是否允许群成员邀请其他用户入群”是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul> |
| `data.invite_need_confirm` | Boolean | “邀请用户入群时是否需要受邀用户同意”是否修改成功：<ul><li>`true`：修改成功；</li><li>`false`：修改失败。</li></ul> |

其他相应字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X PUT -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/6XXXX7' -d '{
    "groupname": "test groupname",
    "description": "updategroupinfo12311",
    "maxusers": 1500,
    "membersonly": true,
    "allowinvites": false,
    "invite_need_confirm": true,
    "custom":"abc",
    "public": true
}'
```

#### 响应示例

```json
{
    "action": "put",
    "application": "XXXXXX",
    "applicationName": "XXXX",
    "data": {
        "allowinvites": true,
        "invite_need_confirm": true,
        "membersonly": true,
        "public": true,
        "custom": true,
        "description": true,
        "maxusers": true,
        "groupname": true
    },
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1666062065529,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/6XXXX7"
}
```

## 删除群组

删除指定的群组。删除群组时会同时删除群组下所有的子区（Thread）。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。  | 是    |

### HTTP 响应

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型    | 描述                                                    |
| :-------- | :------ | :------------------------------------------------------ |
| `data` | JSON | 群组删除相关信息。 |
| `data.success` | Boolean | 群组删除结果: </br> - `true`：删除成功； <br/> - `false`：删除失败。 |
| `data.groupid` | String  | 删除的群组的 ID。                                         |

其他相应字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

## 获取 App 中的群组

分页获取应用下的群组的信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups?limit={N}&cursor={cursor}
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

##### 查询参数

| 参数     | 类型   | 描述                   | 是否必填 |
| :------- | :----- | :------------------------ | :------- |
| `limit`  | Number | 每次期望返回的群组数量。取值范围为 [1,100]，默认值为 `10`。 | 否  |
| `cursor` | String | 数据查询的起始位置。 | 否  |

<div class="alert info">若请求中均未设置 `limit` 和 `cursor` 参数，服务器按群组创建时间倒序返回前 10 个群组。</div>
#### 请求 header

| 参数     | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。   | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 字段             | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `data`         | JSON | 获取的群组的相关信息。                         |
| `data.owner`         | String | 群主的用户 ID。例如：{“owner”: “user1}。                         |
| `data.groupid`       | String | 群组 ID。                                                    |
| `data.affiliations`  | Number    | 群组现有成员数。                                             |
| `data.type`          | String | 群组类型 “group”。                                           |
| `data.last_modified` | String | 最近一次修改的时间戳，单位为毫秒。                           |
| `data.groupname`     | String | 群组名称。                                                   |
| `count`         | Number    | 实际获取的群组数量。                                         |
| `cursor` | String | 查询游标，指定下次查询的起始位置。 |

其他字段及描述详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
// 分页获取第一页的群组信息
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups?limit=2'

// 分页获取第二页的群组信息
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

## 分页获取单个用户加入的所有群组

根据用户 ID 获取该用户加入的全部群组。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/joined_chatgroups?pagesize={}&pagenum={}
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

##### 查询参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `pagesize` | String | 每页获取的群组数量。取值范围为 [1,100]，默认值为 `10`。          | 否     |
| `pagenum`  | String | 当前页码。默认从第 1 页开始获取。                       | 否     |

:::tip
若请求中均未设置 `pagesize` 和 `pagenum` 参数，服务器按用户加入群组的时间倒序返回前 500 个群组。
:::

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。         | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数             | 类型   | 描述       |
| :--------------- | :----- | :--------- |
| `data`   | JSON | 用户加入的群组的相关信息。  |
| `data.groupid`   | String | 群组 ID。  |
| `data.groupname` | String | 群组名称。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups?pagesize=1&pagenum=100'
```

#### 响应示例

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

## <a name="code"></code> 状态码

详见  [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。