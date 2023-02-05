消息回调本文主要介绍在调用即时通讯 Web API 过程中，SDK 返回的错误码和错误信息。

你可以在 `listen` 方法中通过 `options` 参数注册 `onError` 回调，然后通过该回调返回的参数，或其他 API 调用失败回调中返回的参数判断出错的原因。示例代码如下：

error.type === statusCode.WEBIM_CONNCTION_USER_NOT_ASSIGN_ERROR 其中 `error` 为回调返回的参数，`statusCode` 为 SDK 定义的错误信息。

即时通讯 SDK 在运行过程中，可能通过如下方式返回错误码和错误信息：

- 调用方法失败时的返回值。
- 通过 `onError` 回调报告错误码。

你可以根据如下错误码及错误信息了解出错的可能原因，并采取响应措施。对于未给出解决方法的错误码，Agora 推荐你[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会根据你在实际场景中遇到的问题进行排查。

| 错误码 | 错误信息        | 描述和可能原因                          |
| :----- | :------------------- | :----------------- |
| 0      | REQUEST_SUCCESS                                | 提示操作成功，没有错误。                                     |
| -1     | REQUEST_TIMEOUT                             | 请求服务超时。                                        |
| -2     | REQUEST_UNKNOWN                                | 默认未区分类型的错误。                                     |
| -3     | REQUEST_PARAMETER_ERROR               | 参数错误。                                     |
| -4     | REQUEST_ABORT               | 取消请求。                                     |
| 1      | WEBIM_CONNCTION_OPEN_ERROR                    | 登录失败：获取 token 接口请求失败。                          |
| 2      | WEBIM_CONNCTION_AUTH_ERROR                     | 鉴权失败：调用 API 时校验 App Key 失败，App Key 不合法。     |
| 12     | WEBIM_CONNCTION_GETROSTER_ERROR                | 获取 Chat token 失败：通过 Agora token 置换 Chat token 失败。 |
| 16     | WEBIM_CONNCTION_DISCONNECTED                   | WebSocket 断开连接：由于断网等原因 WebSocket 已经断开。      |
| 17     | WEBIM_CONNCTION_AJAX_ERROR                     | 默认未区分类型的错误。 |
| 27     | WEBIM_CONNCTION_APPKEY_NOT_ASSIGN_ERROR        | 未设置 App Key：设置的 App Key 错误，登录时会报此错误。      |
| 28     | WEBIM_CONNCTION_TOKEN_NOT_ASSIGN_ERROR         | 未传 token：调用 API 时没有携带 token，一般没登录时调用 API 会提示这个错误。 |
| 31     | WEBIM_CONNCTION_CALLBACK_INNER_ERROR           | 消息发送成功的回调函数内部错误：在接收消息的回调及后续处理的函数中有错误。 |
| 32     | WEBIM_CONNCTION_CLIENT_OFFLINE                 | 当前用户未登录。                                             |
| 39     | WEBIM_CONNECTION_CLOSED                        | 退出或未登录：未登录或掉线后发送消息。                       |
| 40     | WEBIM_CONNECTION_ERROR                         | 用户鉴权失败。                  |
| 50     | MAX_LIMIT                         | 达到上限，如：Reaction 数量已达到限制；翻译用量达到上限。                  |
| 51     | MESSAGE_NOT_FOUND                         | 没查到消息，如：没有查询到要举报的消息。                 |
| 52     | NO_PERMISSION                          | 用户对当前操作没有权限。                 |
| 53     | OPERATION_UNSUPPORTED                         | 不支持的操作。                 |
| 101    | WEBIM_UPLOADFILE_ERROR                         | 上传文件失败：如文件过大等。                                 |
| 102    | WEBIM_UPLOADFILE_NO_LOGIN                      | 上传文件未携带 token：如未登录就上传文件。                   |
| 200    | WEBIM_DOWNLOADFILE_ERROR                       | 下载文件失败：如超时、网络错误。                             |
| 204    | USER_NOT_FOUND                     | 用户不存在，如创建群拉人时不存在的用户报错。                             |
| 206    | WEBIM_CONNCTION_USER_LOGIN_ANOTHER_DEVICE      | 用户在其他设备登录：如果没有开启多设备登录，则在其他设备登录会将当前登录的设备踢下线，用户会收到此错误。 |
| 207    | WEBIM_CONNCTION_USER_REMOVED                   | 用户已经被注销：如果登录用户的 ID 被管理员从管理后台删除则会收到此错误。 |
| 216    | WEBIM_CONNCTION_USER_KICKED_BY_CHANGE_PASSWORD | 用户密码更新：当前登录的用户密码被修改后，当前登录会断开并提示该错误。 |
| 217    | WEBIM_CONNCTION_USER_KICKED_BY_OTHER_DEVICE    | 用户被踢下线：开启多设备登录后，如果用户在其他设备上调用 API 或者通过管理后台踢出当前设备登录的 ID，SDK 会提示该错误。 |
| 219    | USER_MUTED_BY_ADMIN                            | 用户被全局禁言：在管理后台禁言了此用户。                     |
| 221    | USER_NOT_FRIEND                                | 非好友禁止发消息：开通非好友禁止发消息后，非好友间发消息提示此错误。该功能可在控制台开通。 |
| 500    | SERVER_BUSY                                    | 服务器忙碌。                                                 |
| 501    | MESSAGE_INCLUDE_ILLEGAL_CONTENT                | 敏感词：发送的消息包含敏感词时报此错误。                     |
| 502    | MESSAGE_EXTERNAL_LOGIC_BLOCKED                 | 消息被拦截：开通反垃圾服务后，消息被拦截报此错误。           |
| 503    | SERVER_UNKNOWN_ERROR                           | 消息发送失败未知错误：服务端返回的错误信息超出 SDK 处理范围。 |
| 504    | MESSAGE_RECALL_TIME_LIMIT                      | 撤回消息时超出限定时间。                                     |
| 505    | SERVICE_NOT_ENABLED                            | 服务未开启：要使用的某些功能未开通。                         |
| 506    | SERVICE_NOT_ALLOW_MESSAGING                    | 用户未在白名单中：群组或聊天室开启全员禁言时，若用户未在白名单中发送消息时提示该错误。 |
| 507    | SERVICE_NOT_ALLOW_MESSAGING_MUTE               | 当前用户被禁言：在群组或者聊天室中被禁言后发消息报此错误。           |
| 508    | MESSAGE_MODERATION_BLOCKED                     | 消息被 Moderation 服务拦截。                                 |
| 601    | GROUP_ALREADY_JOINED                           | 已在群组内：当前用户已在该群组中。                           |
| 602    | GROUP_NOT_JOINED                               | 不在群组内：用户发送群消息时未加入该群组。                   |
| 603    | PERMISSION_DENIED                              | 用户无权限：例如如果用户被封禁，发送消息时会提示该错误。     |
| 604    | WEBIM_LOAD_MSG_ERROR                           | 消息回调函数内部错误：在接收消息的回调及后续处理的函数中有错误。 |
| 605    | GROUP_NOT_EXIST                                | 群组不存在：发送消息时群组 ID 不正确。                       |
| 606    | GROUP_MEMBERS_FULL                             | 群组人数达到上限。                                           |
| 607    | GROUP_NOT_EXIST                                | 设置的群组最大人数超过限制：创建群组，群成员数量超出了群组设置的最大数量。 |
| 700    | REST_PARAMS_STATUS                             | 没有 token 或 App Key。                                      |
| 702    | CHATROOM_NOT_JOINED                             | 被操作的人员不在聊天室。                               |
| 704    | CHATROOM_MEMBERS_FULL                          | 聊天室已满：聊天室已经达到人数上限。                         |
| 705    | CHATROOM_NOT_EXIST                             | 聊天室不存在：尝试对不存在的聊天室进行操作时提示该错误。     |
| 999    | SDK_RUNTIME_ERROR                              | Websocket 发送消息错误。                                     |
| 1100   | PRESENCE_PARAM_EXCEED                          | 发布自定义在线状态时，参数长度超出限制。                     |
| 1101   | REACTION_ALREADY_ADDED                         | Reaction 重复添加。                                          |
| 1102   | REACTION_CREATING                              | 创建 Reaction 时，其他人正在创建。                           |
| 1103   | REACTION_OPERATION_IS_ILLEGAL                  | 用户对该 Reaction 没有操作权限：没有添加过该 Reaction 的用户进行删除操作，或者单聊消息非发送者和非接受者进行添加 Reaction 操作。 |
| 1200   | TRANSLATION_NOT_VALID                          | 翻译参数错误。                                               |
| 1201   | TRANSLATION_TEXT_TOO_LONG                      | 翻译的文本过长。                                             |
| 1204   | TRANSLATION_FAILED                             | 获取翻译服务失败。                                           |
| 1300   | THREAD_NOT_EXIST                               | 子区不存在：未找到该子区。                                   |
| 1301   | THREAD_ALREADY_EXIST                           | 该消息 ID 下子区已存在，重复添加子区。                       |