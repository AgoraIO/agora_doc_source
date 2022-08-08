消息回调本文主要介绍在调用 Agora Chat API 过程中，SDK 返回的错误码和错误信息。

你可以根据如下错误码及错误信息了解出错的可能原因，并采取响应措施。对于未给出解决方法的错误码，Agora 推荐你[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会根据你在实际场景中遇到的问题进行排查。

Agora Chat SDK 在运行过程中，可能通过如下方式返回错误码和错误信息：

- 调用方法失败时的返回值。
- 通过 `onError` 回调报告错误码。

| 错误码 | 错误信息                                         | 描述                     | 可能的原因                                                   |
| :----- | :----------------------------------------------- | :----------------------- | :----------------------------------------------------------- |
| `0`    | `REQUEST_SUCCESS`                                | 操作成功                 | 无                                                           |
| `1`    | `WEBIM_CONNCTION_OPEN_ERROR`                     | 用户登录失败             | 用户不存在或密码错误。请使用正确的用户名和密码重新登录。     |
| `2`    | `WEBIM_CONNCTION_AUTH_ERROR`                     | 鉴权失败                 | 校验 AppKey 失败。请更换有效的 AppKey 重新登录。             |
| `12`   | `WEBIM_CONNCTION_GETROSTER_ERROR`                | 获取 Token 失败          | 生成 Token 失败。                                            |
| `16`   | `WEBIM_CONNCTION_DISCONNECTED`                   | WebSocket 断开连接       | 网络原因导致 WebSocket 断开。请重新调用方法。                |
| `17`   | `WEBIM_CONNCTION_AJAX_ERROR`                     | AJAX 请求错误            | 网络异常或调用频率过高导致请求错误。请降低发送频率重新调用方法。 |
| `27`   | `WEBIM_CONNCTION_APPKEY_NOT_ASSIGN_ERROR`        | 无效的 App Key           | App Key 无效，请更换有效的 App Key 并重新登录。如何获取 App Key 详见[获取即时通讯项目信息](./enable_agora_chat?platform=Web#获取即时通讯项目信息)。 |
| `28`   | `WEBIM_CONNCTION_TOKEN_NOT_ASSIGN_ERROR`         | 错误的 Token             | 登录时提供的 Token 为空或不正确，请更换正确的 Token 并重新登录。 |
| `31`   | `WEBIM_CONNCTION_CALLBACK_INNER_ERROR`           | 回调函数内部错误         | 接收消息回调后的处理函数内部错误。                           |
| `32`   | `WEBIM_CONNCTION_CLIENT_OFFLINE`                 | 未登录或离线时发送消息   | 用户发送消息时尚未登录或离线，请登录后重新发送消息。         |
| `39`   | `WEBIM_CONNECTION_CLOSED`                        | 已登出或未登录时发送消息 | 用户发送消息时尚未登录或已登出，请重新登录后重新发送消息。   |
| `40`   | `WEBIM_CONNECTION_ERROR`                         | WebSocket 连接失败       | 鉴权失败，请检查 Token 是否过期。                            |
| `101`  | `WEBIM_UPLOADFILE_ERROR`                         | 上传文件失败             | 消息附件或群组文件超过文件大小限制导致文件上传失败。请确认文件大小并重新上传。 |
| `102`  | `WEBIM_UPLOADFILE_NO_LOGIN`                      | 未登录时上传文件         | 用户上传文件时尚未登录，导致文件上传失败。请登录后重新上传文件。 |
| `200`  | `WEBIM_DOWNLOADFILE_ERROR`                       | 下载文件失败             | 下载消息附件或群组文件失败。请尝试重新下载。                 |
| `206`  | `WEBIM_CONNCTION_USER_LOGIN_ANOTHER_DEVICE`      | 用户在其他设备登录       | 如果用户未开启多设备登录，当在其他设备登录时，会被强制从当前登录的设备下线，且收到该错误码。 |
| `207`  | `WEBIM_CONNCTION_USER_REMOVED`                   | 用户已经被注销           | 已登录的用户被后台删除。                                     |
| `216`  | `WEBIM_CONNCTION_USER_KICKED_BY_CHANGE_PASSWORD` | 用户密码更新             | 已登录的用户修改密码导致被强制登出。                         |
| `217`  | `WEBIM_CONNCTION_USER_KICKED_BY_OTHER_DEVICE`    | 用户被踢下线             | 开启多设备登录后，用户在当前设备上通过调用 API 或管理后台从指定的其他设备登出。 |
| `503`  | `SERVER_UNKNOWN_ERROR`                           | 消息发送未知错误         | 消息发送时发生未知错误导致消息发送失败。                     |
| `504`  | `MESSAGE_RECALL_TIME_LIMIT`                      | 消息撤回超时             | 尝试撤回消息时超过撤回允许时间。                             |
| `505`  | `SERVICE_NOT_ENABLED`                            | 服务未开通               | 调用方法相关的服务未开通。请先开通服务再重新调用。           |
| `506`  | `SERVICE_NOT_ALLOW_MESSAGING`                    | 用户未在白名单中         | 当群组聊天室开启全员禁言，未在禁言白名单中的用户发送消息。   |
| `507`  | `SERVICE_NOT_ALLOW_MESSAGING_MUTE`               | 用户被禁言               | 群组或聊天室中被禁言的用户发送消息。                         |
| `602`  | `GROUP_NOT_JOINED`                               | 未加入该群组             | 尝试在未加入的群组中发送消息，或进行其他群组操作。           |
| `603`  | `PERMISSION_DENIED`                              | 用户无权限               | 用户没有操作权限。请检查是用户是否被封禁，如被封禁需要解禁并重新登录。 |
| `604`  | `WEBIM_LOAD_MSG_ERROR`                           | 消息回调函数内部错误     | 在接收消息的回调及后续处理的函数中有错误。                   |
| `605`  | `GROUP_NOT_EXIST`                                | 群组不存在               | 尝试对不存在的群组进行操作。                                 |

