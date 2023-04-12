本文介绍使用即时通讯 RESTful API 时返回的常见 HTTP 状态码。你可以根据响应中的 `error` 字段获取错误信息。

## 200 - 请求成功

HTTP 状态码 `200` 表示 API 请求成功。

## 4xx - 客户端错误 

HTTP 状态码 4xx 表示因客户端错误导致请求失败，即请求出错导致服务器无法处理。可根据返回的状态码排查问题并重新调用 API。

### 400 错误请求

这类错误指服务器不理解请求的错误语法。 

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `400`            | `invalid_grant`                      | “Invalid username or password”                                | 用户 ID 或密码输入错误。       |
| `400`              | `json_parse`                         | “Unexpected character (‘=’ (code 61)): was expecting a colon to separate field name and value\n at [Source: java.io.BufferedInputStream@170e3f35; line: 1, column: 23]” | 发送请求时请求体不符合标准的 JSON 格式，服务器无法正确解析。 |
| `400`            | `illegal_argument`                   | “Entity user requires a property named username”              | 注册用户请求未提供用户 ID（`username`）。                     |
| `400`            | `illegal_argument`                   | “password or pin must provided”                               | 注册用户请求未提供用户密码（`password`）或提供的密码为空。   |
| `400`              | `illegal_argument`                  | “newpassword is required”                                    | 修改用户密码的请求体未提供 `newpassword` 属性。                |
| `400`              | `illegal_argument`                   | “oldPassword is required”                                    | 修改用户密码的请求体未提供 `oldPassword` 属性。 |
| `400`            | `illegal_argument`                   | “group member username1 doesn’t exist”                        | 批量添加群组成员时，`username1` 不存在。                     |
| `400`            | `illegal_argument`                   | “this is an invalid request”                                  | 请求无效，请检查调用接口的 URL、请求头、请求包体是否正确。可以使用 `curl` 命令进行测试。  |
| `400`            | `illegal_argument`                   | “'from' can't be empty”                                         | 消息发送方（`from`）为空。若不传该字段， 服务器会默认设置为 `admin`。                                  |
| `400`            | `illegal_argument`                   | “target_type can only be 'users' or 'chatgroups' or 'chatrooms'” | 发送消息时，对象类型（`target_type`）只能传入 `users`、`chatgroups` 或 `chatrooms`。若传入其他值，提示该错误。 |
| `400`            | `illegal_argument`                   | “username is not legal”                                       | 注册使用的用户 ID（`username`）不合法，请参考[注册用户 RESTful API](./agora_chat_restful_reg?platform=RESTful#注册单个用户) 重新设置用户 ID。 |
| `400`            | `illegal_argument`                   | “This chatmessage request is not supported”                   | 查询历史消息时传入的时间格式不正确，正确的格式为 YYYYMMDDHH。例如，要获取 2018 年 02 月 09 日 12 点到 13 点的历史消息，传入的时间为 `2018020912`。 |
| `400`            | `illegal_argument`                   | “Illegal arguments: appkey: XXXX, time: 2018020918, maybe chat message history is expired or unstored” | 查询的历史消息未生成或已过期。消息的保留时间取决于产品套餐，详见[消息存储时长限制](agora_chat_limitation?platform=RESTful#消息存储时长)。|
| `400`            | `invalid_parameter`                  | “Some of [groupid] are not valid fields”                      | 修改的群组信息时，传入的参数不支持，例如修改 `groupid`。 |
| `400`            | `required_property_not_found`        | “Entity user requires a property named username”              | 修改用户密码请求未提供用户 ID（`username`）。                   |
| `400`            | `duplicate_unique_property_exists`   | “Application null Entity user requires that property named username be unique, value of username exists” | 注册用户时，用户 ID 已存在，请更换用户 ID 重新注册。             |
| `400`              | illegal_argument | “message is too large”     | 发送消息时消息体超过了 40 KB 会提示该错误，需要拆成几个更小的请求体重试。     |
| `400`              |                                    | “set presence failed”                                        | 在线状态设置失败。                                           |
| `400`              |                                    | “ext is too big”                                             | 在线状态扩展信息长度超过限制。                                 |
| `400`              |                                    | “resource not exist”                                         | 设备来源不存在。                                             |
| `400`              |                                    | “you can't sub yourself”                                     | 无法订阅自己的在线状态。                                     |
| `400`              |                                    | “too many sub presence”                                      | 订阅用户数量超过上限。                                       |
| `400`              |                                    | “too many get presences”                                     | 获取在线状态的用户数量超过上限。                             |
| `400`              |                                    | “too many unsub presences”                                   | 取消订阅的用户数量超过上限。                                 |
| `400`              |                                    | “too many queries”                                           | 查询次数超过限制。                                           |

### 401 未授权

这类错误指无效的 Token 导致鉴权失败。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `401`              | unauthorized                       | “registration is not open, please contact the app admin”     | 返回 401 是未授权，error_description 的描述为 App Key 使用了授权注册，需要 header 加上管理员 token，才有权限注册用户；若加上 token 返回 401，则 token 可能失效，建议重取重试。 |
| `401`            | `unauthorized`                       | “Unable to authenticate due to expired access token”         | 发送请求时使用的 Token 过期或未传入 Token。                  |
| `401`            | `auth_bad_access_token`              | “Unable to authenticate due to corrupt access token”          | 发送请求时使用的 Token 格式错误。                            |
| `401`            | `auth_bad_access_token`              | “Unable to authenticate”                                      | 无效 Token。Token 的格式正确，但不是由接收请求的服务器生成的，导致服务器无法识别该 Token。 |

### 403 禁止操作

这类错误指因请求不正确导致服务器拒绝请求。对于群组/聊天室服务，表示本次调用不符合群组/聊天室操作的正确逻辑，例如调用添加成员接口，添加已经在群组里的用户，或者移除聊天室中不存在的成员等操作。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `403`            | `forbidden_op`                       | “can not join this group, reason:user: username already in group: 40659491815425.”  | 添加群组或聊天室成员时，被添加用户已在群组或聊天室内。       |
| `403`            | `forbidden_op`                       | “users [username] are not members of this group!”               | 踢除群组或聊天室成员时，被踢除的用户不在群组或聊天室内。     |
| `403`            | `forbidden_op`                       | “user: username doesn't exist in group: 40659491815425”       | 转让群组时，被转让的用户不是群组内成员。                     |
| `403`            | `forbidden_op`                       | “new owner and old owner are the same.”                         | 转让群组时，被转让的用户已经是群主。                         |
| `403`            | `forbidden_op`                       | “forbidden operation on group owner!”                           | 当前操作禁止对群主使用，如将群主加入黑名单。                 |
| `403`            | `forbidden_op`                       | “can not join this group, reason：user %s has joined too many groups/chatroom!”  | 加入群组或聊天室时，群组或聊天室人数已达到上限。             |
| `403`            | `forbidden_op`                       | “this appKey has create too many groups/chatrooms!”             | 该 App 下的群组或聊天室数量已达到上限。不同套餐包支持的群组或聊天室数量上限详见[套餐包详情](./agora_chat_plan?platform=RESTful)。 |

### 404 资源未找到

这类错误指服务器找不到请求的接口。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `404`            | `organization_application_not_found` | “Could not find application for XXXX/XXXX from URI: XXXX/XXXX/token.”  | 请求 URL 的 orgname/appname 填写错误，请重新发起请求。       |
| `404`            | `service_resource_not_found`         | “Service resource not found.”                                   | URL 指定的资源不存在。例如，用户相关接口提示用户不存在，群组相关接口提示群组不存在，聊天室相关接口提示聊天室不存在。 |
| `404`              | `service_resource_not_found`         | “Service resource not found”                                 | 获取的 username 不存在，若用户列表存在该 username，则是因为存在脏数据，可以传入 uuid 删除用户，再使用该 username 重新注册用户。 |
| `404`              | `service_resource_not_found`         | “Service resource not found”                                 | 要删除的 username 不存在，若用户列表存在该 username，可以传入 uuid 删除用户。 |
| `404`            | `storage_object_not_found`           | “Failed to find chat message history download url for appkey: XXXX, time: 2018020912.”  | 对应的查询时间没有历史消息，如确定该时间段内有历史消息，请提交工单反馈 Agora 技术支持团队确认。 |

### 405 请求方式错误

服务器不支持使用的 API 请求方法。

### 408 请求超时

服务器在指定的时间段内未收到 API 请求。

### 413 请求包体超限

API 请求包体过大，导致服务器无法处理。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `413`            | `Request Entity Too Large`           | “Request Entity Too Large.”                                     | 请求包体超过上限，例如上传的文件超过 10 MB，需要拆成几个更小的请求体重试。 |

### 415 不支持的媒体类型

服务器不支持 API 请求的格式。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `415`            | `web_application`                    | “Unsupported Media Type.”                                       | 不支持该请求包体的类型。请检查以下情况：<ul><li>请求头是否添加 `Content-Type` 或 `Accept`。</li><li>请求包体是否符合标准的 JSON 格式。</li><li>请求头中是否有接口不需要的参数。</li></ul> |

### 429 因超限导致服务不可用

即时通讯 IM 的超过了当前套餐包的限制或 API 的调用频率超过了上限。

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `429`            | `resource_limited`                   | “You have exceeded the limit of the Free edition. Please upgrade to higher edition.”  | 超过免费版套餐包限制。如需开通其他版本套餐包，需联系 [sales@agora.io](mailto:sales@agora.io)。 |
| `429`            | `reach_limit`                        | “This request has reached api limit”                          | 超过即时通讯 RESTful API 的[调用频率限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)。如果限制条件无法满足你的实际业务需求，需联系请联系 [sales@agora.io](mailto:sales@agora.io)。 |

## 5xx - 服务器错误

服务器错误，即服务器在尝试处理请求时发生内部错误。对于此类错误，建议尝试重新调用。对于系统级别错误或重试后仍然请求失败的情况，可及时[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持并提供系统日志。

### 500 内部服务器错误

| HTTP 状态码 | 错误类型             | 错误提示             | 可能的原因                                                   |
| :--------------- | :---------------- | :-------------------------- | :--------------------------------- |
| `500`            | `no_full_text_index`                 | “Entity 'user' with property named 'username' is not full text indexed. You cannot use the ‘contains’ operand on this field”  | username 不支持全文索引，不可以对该字段进行 `contains` 操作。  |
| `500`            | `unsupported_service_operation`      | “Service operation not supported.”                             | 请求 URL 不支持该请求方式。                                  |
| `500`            | `web_application`                    | “javax.ws.rs.WebApplicationException”                           | 请求 URL 错误。                                              |

### 501 不支持的请求

服务器不支持当前请求。例如，服务器无法识别当前请求方法。

### 502 网关错误

服务器作为网关或代理，从上游服务器收到无效响应。

### 503 服务不可用

服务不可用。

### 504 网关超时   

服务器作为网关或代理，未及时从上游服务器收到请求。 