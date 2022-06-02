This page introduces the error codes and error messages that might be returned by the SDK when you call the Agora Chat APIs.

Possible reasons for the errors are given to assist you in debugging.  If you receive an error code not included here, Agora recommends you contact support@agora.io so that the technical support team can help resolve the issue.

During the run time of the Agora Chat SDK, the error codes and error messages might be returned in the following ways

- The return value when a method call fails.
- The error code reported through the `onError` callback, which you can register in the `addEventListener` method.

| Error code | Error message | Description | Possible reason |
| :----- | :----------------------------------------------- | :----------------------- | :----------------------------------------------------------- |
| 0 | `REQUEST_SUCCESS` | Operation succeeds | None. |
| 1 | `WEBIM_CONNCTION_OPEN_ERROR` | The user login fails. | The user does not exist or the password is incorrect. Please log in again with the correct user ID and password. |
| 2 | `WEBIM_CONNCTION_AUTH_ERROR` | Authentication fails. | The SDK fails to verify the App Key. Try logging in again with a valid App Key. |
| 12 | `WEBIM_CONNCTION_GETROSTER_ERROR` | Fails to retrieve a token | Fails to generate the token. |
| 16 | `WEBIM_CONNCTION_DISCONNECTED` | The WebSocket is disconnected | The WebSocket is disconnected due to network reasons. Try calling the method again. |
| 17 | `WEBIM_CONNCTION_AJAX_ERROR` | An error occurs with the AJAX request | A request error occurs probably due to network problems or excessive call frequency. Please call the method less frequently. |
| 27 | `WEBIM_CONNCTION_APPKEY_NOT_ASSIGN_ERROR` | Invalid App Key | The App Key is invalid. Log in again using a valid App Key. For how to get the App Key, see [Get the information of theAgora Chat project](./enable_agora_chat?platform=RESTful). |
| 28 | `WEBIM_CONNCTION_TOKEN_NOT_ASSIGN_ERROR` | Invalid token | The token entered to log in is empty or incorrect. Log in again using the correct token. |
| 31 | `WEBIM_CONNCTION_CALLBACK_INNER_ERROR` | An internal error occurs with the callback | An Internal error occurs when receiving the message callback. |
| 32 | `WEBIM_CONNCTION_CLIENT_OFFLINE` | The user is offline when sending the message | If a user is not logged in or drops offline, when the user sends a message, the SDK returns this error. Log in and try sending the message. |
| 39 | `WEBIM_CONNECTION_CLOSED` | The user is logged out when sending the message | If a user is not logged in, or logged out, when the user sends a message, the SDK returns this error, Log in again and try sending the message. |
| 40 | `WEBIM_CONNECTION_ERROR` | The WebSocket connection fails | The user authentication fails. Check whether the token has expired. |
| 101 | `WEBIM_UPLOADFILE_ERROR` | The file cannot be uploaded | The file upload fails because the message attachment or group file exceeds the file size limit. Adjust the file size, and try uploading again. |
| 102 | `WEBIM_UPLOADFILE_NO_LOGIN` | The user is not logged in when uploading the file | The user is not logged in when uploading the file, causing the file upload to fail. Log in and try uploading the file again. |
| 200 | `WEBIM_DOWNLOADFILE_ERROR` | The file cannot be downloaded | When the message attachment cannot be downloaded, the SDK returns this error code. Try downloading the file again. |
| 206 | `WEBIM_CONNCTION_USER_LOGIN_ANOTHER_DEVICE` | The user is logged in at another device | If the user does not enable multi-device login, the user is forced to log out when logging in at another device, and the SDK returns this error code. |
| 207 | `WEBIM_CONNCTION_USER_REMOVED` | The user is removed | The logged in user is removed in the app background. |
| 216 | `WEBIM_CONNCTION_USER_KICKED_BY_CHANGE_PASSWORD` | The user is kicked out due to a password change | If the logged in user changes the present password, the SDK kicks the user out and returns this error code. |
| 217 | `WEBIM_CONNCTION_USER_KICKED_BY_OTHER_DEVICE` | The user is kicked out from another device and logs out | When the multi-device login function is enabled, if the user forces the user ID logged in at the current device to log out by calling APIs or managing the backend at another device, the SDK returns this error code. |
| 221 | `USER_NOT_FRIEND` | You cannot send messages to a user that is not your contact.   | When a peer user sets not to receive messages from a user that is not a contact, if you send a message to this peer user, the SDK reports this error code. You can enable this feature on Agora Console. | 
| 503 | `SERVER_UNKNOWN_ERROR` | An unknown error occurs | The SDK fails to send the message due to an unknown error. |
| 504 | `MESSAGE_RECALL_TIME_LIMIT` | A timeout occurs when the message is recalled | When a timeout occurs during message recall, the SDK returns this error code. |
| 505 | `SERVICE_NOT_ENABLED` | The service is not enabled | When you try using a service that is not enabled, the SDK returns this error code. Activate the service first and then call the method again. |
| 506 | `SERVICE_NOT_ALLOW_MESSAGING` | The user is not included in the whitelist | If all members are banned in the group chatroom and the user ID is not included in the whitelist, when this user tries sending a message, the SDK returns this error code. |
| 507 | `SERVICE_NOT_ALLOW_MESSAGING_MUTE` | The user is muted | If the user is muted in the group or the chatroom, when the user sends a message, the SDK returns this error code. |
| 602 | `GROUP_NOT_JOINED` | You have not joined the group | When you try sending messages or controlling a group that you have not joined, the SDK returns this error code. |
| 603 | `PERMISSION_DENIED` | The permission is denied to the user | The user has no permission to operate. Check whether the user is banned. If the user is banned, unban the user and log in again. |
| 604 | `WEBIM_LOAD_MSG_ERROR` | An internal error occurs with the callback | An internal error occurs when receiving the callback and in the subsequent logic handling |
| 605 | `GROUP_NOT_EXIST` | The group does not exist | When you try controlling a group that does not exist, the SDK returns this error code. |
| 606   | GROUP_MEMBERS_FULL | 群组人数达到上限 | The number of chat group members has reached the upper limit. |
| 607   | GROUP_NOT_EXIST | 设置的群组最大人数超过限制 |The number of maximum chat group members that you specify when creating a chat group exceeds the upper limit of your current pricing plan. |
| 700  | REST_PARAMS_STATUS |  没有 token 或 App Key  |  The token or app key is an empty string when calling RESTful APIs.  |
| 704   | CHATROOM_MEMBERS_FULL | 聊天室已满 | The number of chat room members has reached the upper limit. |
| 705   | CHATROOM_NOT_EXIST | 聊天室不存在 | The chat room to which you request to perform operations does not exist. |
| 999   | SDK_RUNTIME_ERROR  | Websocket 发送消息错误 |  A Websocket error occurs when sending a message. |
| 1100   | PRESENCE_PARAM_EXCEED  | 发布自定义在线状态时，参数长度超出限制 | The length of the parameters you pass in when calling APIs of the presence service exceed the upper limit. |
| 1101   | REACTION_ALREADY_ADDED | Reaction 重复添加 | The reaction to add already exists in your reaction list. |
| 1102  | REACTION_CREATING  | 创建 Reaction 时，其他人正在创建 |The reaction that you are creating is being created by another user at the same time. |
| 1103  | REACTION_OPERATION_IS_ILLEGAL | 用户对该 Reaction 没有操作权限 | You do not have the permission to perform operations to a reaction. For example, you cannot delete a reaction if the reaction does not exist in your reaction list. |
| 1200  | TRANSLATION_NOT_VALID  | 翻译参数错误 | The parameters you pass in when calling APIs of the translation service are invalid. |
| 1201  | TRANSLATION_TEXT_TOO_LONG  |  翻译的文本过长 |  The length of the source text to translate exceeds the upper limit. |
| 1204  | TRANSLATION_FAILED  | 获取翻译服务失败 | The request to retrieve the translation service fails. |
| 1300   | THREAD_NOT_EXIST |  子区不存在 | The thread does not exist.    |
| 1301   | THREAD_ALREADY_EXIST | 该子区已存在  |  The thread to create already exists.    |

