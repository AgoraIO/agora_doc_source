本文介绍使用 Agora 即时通讯 RESTful API 过程中常见的状态码，同时你可以根据响应报文中的 `error` 字段获取具体错误信息。

| 状态码 | 请求结果   | 可能原因                             | 建议措施                                                     |
| :----- | :--------- | :----------------------------------- | :----------------------------------------------------------- |
| `200`  | 请求成功。 | 无。                                 | 无。                                                         |
| `4xx`  | 请求失败。 | 请求出错导致服务器无法处理。         | 尝试重新调用。                                               |
| `5xx`  | 请求失败。 | 服务器在尝试处理请求时发生内部错误。 | 尝试重新调用。对于系统级别错误或重试后仍然请求失败的情况，则记录到系统日志并及时[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持。 |

## 状态码概览

| 状态码 | 说明                                                         |
| :----- | :----------------------------------------------------------- |
| `200`    | 请求成功。                                                   |
| `400`    | 错误请求。服务器不理解请求的语法。                           |
| `401`    | 未授权。对于需要 Token 鉴权的接口，服务器可能返回该状态码。  |
| `403`    | 禁止。请求不正确导致服务器拒绝请求。                         |
| `404`    | 未找到。服务器找不到请求的接口。                             |
| `405`    | 请求方式错误。                                               |
| `408`    | 请求超时。服务器响应请求时发生超时。                         |
| `413`    | 请求包体超过上限。                                           |
| `415`    | 不支持当前请求包体的类型。                                   |
| `429`    | 服务不可用。请求超过调用频率限制，详见[限制条件](./agora_chat_limitation?platform=RESTful)。 |
| `500`    | 服务器内部错误。服务器发生错误，无法完成请求。               |
| `501`    | 服务器不支持当前请求。例如，服务器无法识别当前请求方法。     |
| `502`    | 错误网关。充当网关或代理的服务器从上游服务器收到无效响应。   |
| `503`    | 服务器超时。服务不可用。                                     |
| `504`    | 网关超时。服务器作为网关或代理，没有及时从上游服务器收到请求。 |


## 状态码详细说明

| HTTP Status Code | Error                                | Error Description                                            | 可能的原因                                                   |
| :--------------- | :----------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `400`            | `invalid_grant`                      | Invalid username or password.                                | 用户名或密码输入错误。                                       |
| `400`            | `json_parse`                         | Unexpected character.                                        | 请求包体不是标准的 JSON 格式，导致服务器无法正确解析。       |
| `400`            | `illegal_argument`                   | Entity user requires a property named username.              | 注册用户请求未提供用户名（`username）`。                     |
| `400`            | `illegal_argument`                   | Password or pin must provided.                               | 注册用户请求未提供用户密码（`password`）或提供的密码为空。   |
| `400`            | `illegal_argument`                   | Newpassword is required.OldPassword is required.             | 修改用户密码请求未提供新密码或老密码。                       |
| `400`            | `illegal_argument`                   | Group member username1 doesn’t exist.                        | 批量添加群组成员时，`username1` 不存在。                     |
| `400`            | `illegal_argument`                   | This is an invalid request.                                  | 请求无效，请检查调用接口的 URL、请求头、请求包体是否正确。   |
| `400`            | `illegal_argument`                   | From can't be empty.                                         | 消息发送方（`from`）为空。                                   |
| `400`            | `illegal_argument`                   | Target_type can only be 'users' or 'chatgroups' or 'chatrooms'. | 发送消息时，对象类型（`target_type`）传入除 `users`、`chatgroups`、`chatrooms` 外的其他值。 |
| `400`            | `illegal_argument`                   | Username is not legal.                                       | 注册使用的用户名（`username`）不合法，请参考[注册用户 RESTful API](./agora_chat_restful_reg?platform=RESTful#注册单个用户) 重新设置用户名。 |
| `400`            | `illegal_argument`                   | This chatmessage request is not supported.                   | 查询历史消息时传入的时间格式不正确，正确的格式为 YYYYMMDDHH。 |
| `400`            | `illegal_argument`                   | Illegal arguments: appkey: XXXX, time: 2018020918, maybe chat message history is expired or unstored. | 查询的历史消息未生成或已过期。详见[查询历史消息](./agora_chat_restful_message?platform=RESTful#查询历史消息)。 |
| `400`            | `invalid_parameter`                  | Some of [groupid] are not valid fields.                      | 修改的群组名称、群组描述、群组人数上限时，传入的参数不合法。 |
| `400`            | `required_property_not_found`        | Entity user requires a property named username.              | 修改用户密码请求未提供用户名（`username`）。                   |
| `400`            | `duplicate_unique_property_exists`   | Application null Entity user requires that property named username be unique, value of username exists. | 注册用户时，用户名已存在，请更换用户名重新注册。             |
| `401`            | `unauthorized`                       | Registration is not open, please contact the app admin.      | 注册用户时，请求 header 未添加 app token 的 Authorization。  |
| `401`            | `unauthorized`                       | Unable to authenticate due to expired access token.          | 发送请求时使用的 Token 过期或未传入 Token。                  |
| `401`            | `auth_bad_access_token`              | Unable to authenticate due to corrupt access token.          | 发送请求时使用的 Token 格式错误。                            |
| `401`            | `auth_bad_access_token`              | Unable to authenticate.                                      | 无效 Token。Token 的格式正确，但不是由接收请求的服务器生成的，导致服务器无法识别该 Token。 |
| `403`            | `forbidden_op`                       | Can not join this group, reason:user: username already in group: 40659491815425. | 添加群组或聊天室成员时，被添加用户已在群组或聊天室内。       |
| `403`            | `forbidden_op`                       | Users [username] are not members of this group!              | 删除群组或聊天室成员时，被删除的用户不在群组或聊天室内。     |
| `403`            | `forbidden_op`                       | User: username doesn't exist in group: 40659491815425.       | 转让群组时，被转让的用户不是群组内成员。                     |
| `403`            | `forbidden_op`                       | New owner and old owner are the same.                        | 转让群组时，被转让的用户已经是群主。                         |
| `403`            | `forbidden_op`                       | Forbidden operation on group owner!                          | 当前操作禁止对群主使用，如将群主加入黑名单。                 |
| `403`            | `forbidden_op`                       | Can not join this group, reason：user %s has joined too many groups/chatroom! | 加入群组或聊天室时，群组或聊天室人数已达到上限。             |
| `403`            | `forbidden_op`                       | This appKey has create too many groups/chatrooms!            | 该 App 下的群组或聊天室数量已达到上限。不同套餐包支持的群组或聊天室数量上限详见[套餐包详情](./agora_chat_plan?platform=RESTful)。 |
| `404`            | `organization_application_not_found` | Could not find application for XXXX/XXXX from URI: XXXX/XXXX/token. | 请求 URL 的 orgname/appname 填写错误，请重新发起请求。       |
| `404`            | `service_resource_not_found`         | Service resource not found.                                  | URL 指定的资源不存在：用户不存在。群组不存在。聊天室不存在。 |
| `404`            | `service_resource_not_found`         | Service resource not found.                                  | 查询或删除用户时，获取或删除的 `username` 不存在。若该 `username` 存在，则可能是因为存在脏数据。你可以传入该用户的 UUID 删除用户，再使用原 `username` 重新注册。 |
| `404`            | `storage_object_not_found`           | Failed to find chat message history download url for appkey: XXXX, time: 2018020912. | 所查时间没有历史消息，如确定该时间段内有历史消息，请联系 Agora 技术支持。 |
| `413`            | `Request Entity Too Large`           | Request Entity Too Large.                                    | 请求包体超过上限：上传文件超过 10 MB。发送消息体积超过 5 KB。 |
| `415`            | `web_application`                    | Unsupported Media Type.                                      | 不支持该请求包体的类型。请检查以下情况：请求头是否添加 `Content-Type` 或 `Accept`。请求包体是否符合标准的 JSON 格式。请求头中是否有其他非接口需要的参数。 |
| `429`            | `resource_limited`                   | You have exceeded the limit of the Free edition. Please upgrade to higher edition. | 超过免费版套餐包限制。如已开通其他版本套餐包，请联系 Agora 商务。 |
| `429`            | `reach_limit`                        | This request has reached api limit.                          | 超过即时通讯 RESTful API 的[调用频率限制](./agora_chat_limitation_android?platform=RESTful#服务端调用频率限制)。如果限制条件无法满足你的实际业务需求，请联系 Agora 技术支持。 |
| `500`            | `no_full_text_index`                 | Entity 'user' with property named 'username' is not full text indexed. You cannot use the ‘contains’ operand on this field. | username 不支持全文索引，不可以对该字段进行 contains 操作。  |
| `500`            | `unsupported_service_operation`      | Service operation not supported.                             | 请求 URL 不支持该请求方式。                                  |
| `500`            | `web_application`                    | javax.ws.rs.WebApplicationException                          | 请求 URL 错误。                                              |