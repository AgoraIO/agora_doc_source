# Error Codes for Agora Chat

This page introduces the error codes and error messages that might be returned by the SDK when you call the Agora Chat APIs.

Possible reasons for the errors are given to assist you in debugging. If you receive an error code not included here, Agora recommends you contact support@agora.io so that the technical support team can help resolve the issue.

During the run time of the Agora Chat SDK, the error codes and error messages might be returned in the following ways

- The return value when a method call fails.
- The error code reported through the `onError` callback.

For example, when a user registration request fails because the username already exists, the `onError` callback returns the following error code and error message:

```c#
SDKClient.Instance.Login(username, passwd,
            handle: new CallBack(
                onSuccess: () =>
                {
                },
                onError: (code, desc) =>
                {
                    // code: USER_ALREADY_EXIST(203)
                    // desc: User already exist.
                }
            )
        );
```


| Error code | Error message                        | Error description                                     | Error description                                                    |
| :----- | :------------------------------ | :--------------------------------------- | :----------------------------------------------------------- |
| 0      | EM_NO_ERROR                     | 操作成功                                 | The operation succeeds.            |
| 1      | GENERAL_ERROR                   | 默认未区分类型的错误                     | The SDK is not properly initialized or the server cannot identify this error. |
| 2      | NETWORK_ERROR                   | 网络错误                                 | The SDK is disconnected from the server due to network interruption.   |
| 4      | EXCEED_SERVICE_LIMIT            | 超过服务限制                             | The usage exceeds the service limit. For example, the total number of registered user exceeds the upper limit of the current pricing plan. |
| 100    | INVALID_APP_KEY                 | App Key 不合法                           | The App Key is invalid.                               |
| 101    | INVALID_USER_NAME               | 用户 ID 不正确                           | The user ID is invalid. For example, when you request to add a contact, the username is set to an empty string. |
| 102    | INVALID_PASSWORD                | 用户密码不正确                           | The login password is empty or invalid.                              |
| 104    | INVALID_TOKEN                   | 用户 token 不正确                        | The login token is empty or invalid.                          |
| 105    | USER_NAME_TOO_LONG              | 用户名过长                               | The length of the username exceeds the limit of 64 bytes.                               |
| 108    | TOKEN_EXPIRED                   | 声网 token 已过期                        | The token has expired.                               |
| 109    | TOKEN_WILL_EXPIRE               | 声网 token 即将过期                      | The token has passed half of its validity period.       |
| 200    | USER_ALREADY_LOGIN              | 用户已经登录                             | The user has already logged in.                                  |
| 201    | USER_NOT_LOGIN                  | 用户未登录                               | The login session is either invalid or has expired when you request to send a message or perform operations to a chat group. |
| 202    | USER_AUTHENTICATION_FAILED      | 用户鉴权失败                             | The user authentication fails because the token is either invalid or has expired.             |
| 203    | USER_ALREADY_EXIST              | 用户已经存在                             | When you register a user account, the specified user ID already exists.         |
| 204    | USER_NOT_FOUND                  | 用户不存在                               | When you request to log in as a user or retrieve the conversation list of a user, the specified user ID does not exist.          |
| 205    | USER_ILLEGAL_ARGUMENT           | 用户参数不正确                           | When you request to register a user account or update user attributes, the specified user ID is invalid or empty. |
| 206    | USER_LOGIN_ANOTHER_DEVICE       | 用户在其他设备登录                       | If you have not enabled the multi-device service, you are forced to log out on one device by a login attempt on another device. |
| 207    | USER_REMOVED                    | 用户已经被注销                           | Your account is deleted in the backend.             |
| 208    | USER_REG_FAILED                 | 用户注册失败                             | The request to register a user account fails because the registration is closed.         |
| 209    | PUSH_UPDATECONFIGS_FAILED       | 更新推送配置错误                         | The nickname displayed during message push fails to be updated.                    |
| 210    | USER_PERMISSION_DENIED          | 用户无权限                               |  You are blocked and not allowed to send messages.               |
| 213    | USER_BIND_ANOTHER_DEVICE        | 用户已经在另外设备登录                   | If you set that the login device takes precedence, a login attempt on another device triggers this error to notify that this user has already logged in. |
| 214    | USER_LOGIN_TOO_MANY_DEVICES     | 用户登录设备数超过限制                   | The number of devices on which a user ID logs in exceeds the upper limit.               |
| 215    | USER_MUTED                      | 用户在群组聊天室中被禁言                 | You are muted and not allowed to send messages in a chat group or chat room.                           |
| 216    | USER_KICKED_BY_CHANGE_PASSWORD  | 用户密码更新                             | Once the password of a user account is updated, the current login session ends and you must log in again with the new password.   |
| 217    | USER_KICKED_BY_OTHER_DEVICE     | 用户被踢下线                             | If you have enabled the multi-device service, you log out on one device by either a force quit API call on another device or a force quit operation in the backend. |
| 218    | USER_ALREADY_LOGIN_ANOTHER      | 其他用户已登录                           | Log in to the SDK with another user account while the current account has not been logged out.             |
| 219    | USER_MUTED_BY_ADMIN             | 用户被禁言                               | The App Key of a user is globally muted and not allowed to send messages.          |
| 220    | USER_DEVICE_CHANGED             | 用户登录设备与上次不一致                 |  If you set that the login device takes precedence, a login attempt on another device triggers this error to notify that the login device is detected irregular.
If you set to allow login attempts on another device, |
| 221    | USER_NOT_FRIEND                 | 非好友禁止发消息                         | If you set that only contacts can send messages to you in the console, the SDK returns this error when strangers attempt to send messages.        |
| 300    | SERVER_NOT_REACHABLE            | 请求服务失败                             | The SDK is disconnected from the server due to unstable networks when you send API requests. |
| 301    | SERVER_TIMEOUT                  | 请求服务超时                             | The server does not respond to an API request within the allocated period, generally 30 seconds or 60 seconds. |
| 302    | SERVER_BUSY                     | 服务器忙碌                               | The server is busy. Retry later.         |
| 303    | SERVER_UNKNOWN_ERROR            | 服务请求的通用错误码                     | A default error returned by the server. You need to further identify and troubleshoot this error with logs.  |
| 304    | SERVER_GET_DNSLIST_FAILED       | 获取服务器配置信息错误                   | The SDK fails to retrieve the DNS server information.                       |
| 305    | SERVER_SERVICE_RESTRICTED       | 当前 app 被禁用                          | This error returned when the app server is restricted.                |
| 400    | FILE_NOT_FOUND                  | 文件未找到                               | The request to retrieve a log file or download an attachment fails.     |
| 401    | FILE_INVALID                    | 文件异常                                 | The request to upload a group shared file or a message attachment fails.          |
| 402    | FILE_UPLOAD_FAILED              | 上传文件错误                             |  The request to upload a message attachment fails.                             |
| 403    | FILE_DOWNLOAD_FAILED            | 下载文件错误                             | The request to download a message attachment fails.                            |
| 404    | FILE_DELETE_FAILED              | 删除文件错误                             | The outdated file fails to be deleted when retrieving the latest log file. |
| 405    | FILE_TOO_LARGE                  | 文件太大                                 | The message attachment or shared group file you attempt to upload exceeds the limit of the file size.          |
| 406    | FILE_CONTENT_IMPROPER           | 文件内容不合规                           | The content of a message attachment or shared group file does not meet the compliance requirements.                |
| 500    | MESSAGE_INVALID                 | 消息异常错误                             | The request to send a message is invalid, for example, the message body or message ID is empty, or the user ID of the sender is inconsistent with the user ID of the current login session. |
| 501    | MESSAGE_INCLUDE_ILLEGAL_CONTENT | 消息含有非法内容                         | The message contains illegal content.            |
| 502    | MESSAGE_SEND_TRAFFIC_LIMIT      | 消息限流          | Request too often. Agora recommends that you reduce the call frequency or the message size.  |
| 504    | MESSAGE_RECALL_TIME_LIMIT       | 消息撤回超时错误                         | A message cannot be recalled because the message exceeds the recall period.          |
| 505    | SERVICE_NOT_ENABLED             | 服务未开启                               | The feature that you attempt to use is not activated. Contact support@agora.io to activate this feature for your user account.                      |
| 506    | MESSAGE_EXPIRED                 | 消息已过期                               | The chat group receipt has expired. The default valid period is 3 days. |
| 507    | MESSAGE_ILLEGAL_WHITELIST       | 用户未在白名单中                         | You are not allowed to send messages because a chat group or chat room mutes all members and you are not on the allow list.  |
| 508    | MESSAGE_EXTERNAL_LOGIC_BLOCKED  | 消息执行发送前回调，被用户自己的逻辑拦截 | The message that you send is blocked by the logic defined in your own server.  |
| 600    | GROUP_INVALID_ID                | 群组 ID 异常                             | The request to perform operations to a chat group fails because the chat group ID is an empty string.       |
| 601    | GROUP_ALREADY_JOINED            | 已在该群组中                             | The request to join a chat group fails because you have already in the chat group.       |
| 602    | GROUP_NOT_JOINED                | 未加入该群组                             | The request to send a message or perform operations to a chat group fails because you have not joined the chat group.    |
| 603    | GROUP_PERMISSION_DENIED         | 无权限的群组操作                         | You do not have the privilege to perform the operation to a chat group. For example, a chat group member does not have the permission to add or remove a chat group admin.      |
| 604    | GROUP_MEMBERS_FULL              | 群组已满                                 |  The number of chat group members exceeds the upper limit.                                     |
| 605    | GROUP_NOT_EXIST                 | 群组不存在                               | The chat group to which you request to perform operations does not exist.                    |
| 700    | CHATROOM_INVALID_ID             | 聊天室 ID 异常                           | The request to perform operations to a chat room fails because the chat room ID is an empty string.        |
| 701    | CHATROOM_ALREADY_JOINED         | 已在该聊天室中                           |  The request to join a chat room fails because you have already in the chat room.  |
| 702    | CHATROOM_NOT_JOINED             | 未加入该聊天室                           |The request to send a message or perform operations to a chat room fails because you have not joined the chat room.  |
| 703    | CHATROOM_PERMISSION_DENIED      | 无权限的聊天室操作                       | You do not have the privilege to perform the operation to a chat room. For example, a chat room member does not have the permission to add or remove a chat room admin.   |
| 704    | CHATROOM_MEMBERS_FULL           | 聊天室已满                               |  The number of chat room members exceeds the upper limit.                              |
| 705    | CHATROOM_NOT_EXIST              | 聊天室不存在                             | The chat room to which you request to perform operations does not exist.                 |
| 900    | PUSH_NOT_SUPPORT                | 第三方推送不支持                         | The third-party push service is not supported by the current device.  |
| 901    | PUSH_BIND_FAILED                | 绑定第三方推送 token 失败                |  The token of the third-party push service fails to upload to the server.    |
| 902    | PUSH_UNBIND_FAILED              | 解绑第三方推送 token 失败        | The token of the third-party push service fails to unbind.               |