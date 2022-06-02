This page introduces the error codes and error messages that might be returned by the SDK when you call the Agora Chat APIs.

Possible reasons for the errors are given to assist you in debugging. If you receive an error code not included here, Agora recommends you contact [support@agora.io](mailto:support@agora.io) so that the technical support team can help resolve the issue.

The error codes and error messages might be returned in the following ways:

- The return value when a method call fails.
- The error code reported through the `onError` callback.

| Error code | Error message     | Description       | Possible reason                                              |
| :--------- | :--------------- | :---------------- | :------------------- |
| 0          | `EM_NO_ERROR`                    | Operation succeeds                                           | None                                                         |
| 1          | `GENERAL_ERROR`                  | A general error occurs (no specified reason)                 | The SDK has not been successfully initialized, or the specified reason for the error is not identified when you request the server. You can try reinitializing the SDK. |
| 2          | `NETWORK_ERROR`                  | Network error                                                | Disconnections between the SDK and the server happen due to the network problems. |
| 4          | `EXCEED_SERVICE_LIMIT`           | The service limit is exceeded                                | The service limit is exceeded, for example, the total number of the registered users or their friends exceeds the plan limit. |
| 100        | `INVALID_APP_KEY`                | Invalid App Key                                              | The App Key is invalid. Log in again using a valid App Key.  |
| 101        | `INVALID_USER_NAME`              | Invalid user ID                                              | The user ID is empty, or the format of the parameter is incorrect. Use a [valid user ID](https://confluence.agoralab.co/pages/viewpage.action?pageId=846791321). |
| 102        | `INVALID_PASSWORD`               | Invalid password                                             | The password entered to log in is empty or incorrect. Log in again using the correct password. |
| 104        | `INVALID_TOKEN`                  | Invalid token                                                | The token entered to log in is empty or incorrect. Log in again using the correct token. |
| 200        | `USER_ALREADY_LOGIN`             | The user has already logged in                               | The user has already logged in. Do not log in repeatedly.    |
| 201        | `USER_NOT_LOGIN`                 | The user has not logged in                                   | The user has not logged in when the method is called. Please check the your code logic. |
| 202        | `USER_AUTHENTICATION_FAILED`     | The user authentication fails                                | The user authentication fails. Check whether the token has expired. |
| 203        | `USER_ALREADY_EXIST`             | User already exists                                          | A user with the same user ID is already logged in. Do not register repeatedly. |
| 204        | `USER_NOT_FOUND`                 | The user is not found                                        | The user is not registered when the method is called. Register before doing any other operation. |
| 205        | `USER_ILLEGAL_ARGUMENT`          | The user parameter is invalid                                | An invalid parameter is used when you call the method. For example, invalid characters are found in the specified user ID. Reset the parameter. |
| 206        | `USER_LOGIN_ANOTHER_DEVICE`      | The user has logged in at another device                     | If the user does not enable multi-device login, the user is forced to log out when logging in at another device, and the SDK returns this error code. |
| 207        | `USER_REMOVED`                   | The user is removed                                          | When the logged in user ID is deleted by the server, the SDK returns this error code. |
| 208        | `USER_REG_FAILED`                | The user registration fails                                  | When you call the server registration method, the parameter passed is empty or invalid. See [User registration RESTful API](./agora_chat_restful_registration). |
| 209        | `PUSH_UPDATECONFIGS_FAILED`      | The update push configuration fails                          | The update push configuration fails. Update the nickname and the Do Not Disturb mode. Try calling the method again. |
| 210        | `USER_PERMISSION_DENIED`         | Permission is denied to the user                             | The user has no permission to operate. Check whether the user is banned. If the user is banned, unban the user and log in again. |
| 213        | `USER_BIND_ANOTHER_DEVICE`       | The user has already logged in at another device.            | If the user sets the device login priority, that is, to log in at the device with higher priority, when the logged in user tries logging in at another device, the login fails, and the SDK returns this error code. |
| 214        | `USER_LOGIN_TOO_MANY_DEVICES`    | The user logs in at too many devices                         | If a user ID has logged in at four devices, when the user tries logging in at a fifth device, the SDK returns this error code. If you want a user to log in at more than four devices, contact [support@agora.io](mailto:support@agora.io). |
| 215        | `USER_MUTED`                     | The user is muted                                            | If the user is muted in the group or the chatroom, when the user sends a message, the SDK returns this error code. |
| 216        | `USER_KICKED_BY_CHANGE_PASSWORD` | The user is kicked out due to a password change              | If the logged in user changes the present password, the SDK kicks the user out and returns this error code. |
| 217        | `USER_KICKED_BY_OTHER_DEVICE`    | The user is kicked out from another device and logs out      | When the multi-device login function is enabled, if the user forces the user ID logged in at the current device to log out by calling APIs or managing the backend at another device, the SDK returns this error code. |
| 221        | `USER_NOT_FRIEND`                | You cannot send messages to a user that is not your contact.   | When a peer user sets not to receive messages from a user that is not a contact, if you send a message to this peer user, the SDK reports this error code. You can enable this service on Agora Console. | 
| 300        | `SERVER_NOT_REACHABLE`           | The requesting service fails                                 | The SDK disconnects from the Agora Chat system due to network problems. Try again later. |
| 301        | `SERVER_TIMEOUT`                 | A timeout occurs in the requesting service                   | Some API calls require the SDK to return the execution result. This error occurs if the SDK takes too long (more than 30 seconds) to return the result. |
| 302        | `SERVER_BUSY`                    | The server is busy                                           | The server is currently busy. Try again later.               |
| 303        | `SERVER_UNKNOWN_ERROR`           | The common error code of the requesting service              | This common error occurs when the requesting service fails. Check the log for troubleshooting. |
| 304        | `SERVER_GET_DNSLIST_FAILED`      | An error occurs in getting the server configuration information | The SDK fails in getting the configuration of the server that the app currently runs on. Try calling the method again. |
| 305        | `SERVER_SERVICE_RESTRICTED`      | The current app is banned                                    | If the app is banned, the SDK returns this error code when the methods are called. |
| 400        | `FILE_NOT_FOUND`                 | The file is not found                                        | When the user is unable to get the log file or download the attachment, the SDK returns this error code. |
| 401        | `FILE_INVALID`                   | The file is invalid                                          | When the uploaded message attachment or the shared file in the group is invalid, the SDK returns this error code. |
| 402        | `FILE_UPLOAD_FAILED`             | The file cannot be uploaded                                  | When the message attachment cannot be uploaded, the SDK returns this error code. Try uploading again. |
| 403        | `FILE_UPLOAD_FAILED`             | The file cannot be downloaded                                | When the message attachment cannot be downloaded, the SDK returns this error code. Try downloading again. |
| 404        | `FILE_DELETE_FAILED`             | The file cannot be deleted                                   | When getting the log file, the SDK deletes the old log file. If the old log files cannot be deleted, the SDK returns this error code. |
| 405        | `FILE_TOO_LARGE`                 | The file is too large                                        | When the size of the message attachment or the group shared file exceeds the limit, the SDK returns this error code. Adjust the file size, and try uploading again. |
| 500        | `MESSAGE_INVALID`                | The message is invalid                                       | The content of the message to be sent is empty, the message ID is empty, or the user ID of the sender is not the user ID that is currently logged in. Check the problems, and try sending the message again. |
| 502        | `MESSAGE_SEND_TRAFFIC_LIMIT`     | The message traffic is limited                               | The message-sending frequency is too high or the message size is too large. Agora recommends reducing the sending frequency or the message size. |
| 504        | `MESSAGE_RECALL_TIME_LIMIT`      | A timeout occurs when the message is recalled                | When a timeout occurs during message recall, the SDK returns this error code. |
| 505        | `SERVICE_NOT_ENABLED`            | The service is not enabled                                   | When you try using a service that is not enabled, the SDK returns this error code. |
| 506        | `MESSAGE_EXPIRED`                | The message expires                                          | If you send a group receipt after the time limit (the default is three days), the SDK returns this error code. |
| 507        | `MESSAGE_ILLEGAL_WHITELIST`      | The user is not included in the whitelist                    | If all members are banned in the group chatroom and the user ID is not included in the whitelist, when this user tries sending a message, the SDK returns this error code. |
| 600        | `GROUP_INVALID_ID`               | The group ID is invalid                                      | When you call the methods related to the group and the group ID provided is invalid, the SDK returns this error code. |
| 601        | `GROUP_ALREADY_JOINED`           | The user has already joined the group                        | When you call the group joining method, if the user has already joined the group, the SDK returns this error code. |
| 602        | `GROUP_NOT_JOINED`               | You have not joined the group                                | When you try sending messages or controlling a group that you have not joined, the SDK returns this error code. |
| 603        | `GROUP_PERMISSION_DENIED`        | Group permission is denied                                   | The user does not have permission to control the group, for example the group members do not have permission to set the group administrator. Check whether the user has administrator permissions. |
| 604        | `GROUP_MEMBERS_FULL`             | The group is full                                            | The number of the group members has reached the limit.       |
| 605        | `GROUP_NOT_EXIST`                | The group does not exist                                     | When you try controlling a group that does not exist, the SDK returns this error code. |
| 700        | `CHATROOM_INVALID_ID`            | The chatroom ID is invalid                                   | When you call the methods related to the chatroom and the chatroom ID provided is empty, the SDK returns this error code. |
| 701        | `CHATROOM_ALREADY_JOINED`        | The user has already joined the chatroom                     | When you call the chatroom-joining method, if the user has already joined the chatroom, the SDK returns this error code. |
| 702        | `CHATROOM_NOT_JOINED`            | You have not joined the chatroom                             | When you try sending messages or controlling a chatroom that you have not joined, the SDK returns this error code. |
| 703        | `CHATROOM_PERMISSION_DENIED`     | Chatroom permission is denied                                | The user does not have permission to control the chatroom, for example, the chatroom members do not have permission to set the chatroom administrator. Check whether the user has administrator permissions. |
| 704        | `CHATROOM_MEMBERS_FULL`          | The chatroom is full                                         | The number of the chatroom members has reached the limit.    |
| 705        | `CHATROOM_NOT_EXIST`             | The chatroom does not exist                                  | When you try controlling a chatroom that does not exist, the SDK returns this error code. |
| 900    | USERINFO_USERCOUNT_EXCEED     |  The number of users from whom you request to retrieve the attributes exceeds the upper limit of 100.   |
| 901    | USERINFO_DATALENGTH_EXCEED       |设置的用户属性太长| The size of user attributes exceeds the upper limit. The size of attributes from each user cannot exceed 2 KB. The size of attributes from all users in an app cannot exceed 10 GB.   |
| 903    | TRANSLATE_INVALID_PARAMS        | 翻译参数无效                            | The parameters you pass in when calling APIs of the translation service are invalid.  |
| 904    | TRANSLATE_FAIL                  | 翻译失败                              | The request to translate fails.        |
| 905    | TRANSLATE_NOT_INIT              | 翻译服务未初始化                      | The translation service has not been initialized.      |
| 1000   | CONTACT_ADD_FAILED              | 添加联系人失败                      | The request to add a contact fails.        |
| 1001   | CONTACT_REACH_LIMIT             | 邀请者联系人数量已经达到上限     |  You cannot add a contact because the number of your contacts has reached the upper limit.        |
| 1002   | CONTACT_REACH_LIMIT_PEER        | 受邀请者联系人达到上限    |    You cannot add a contact because the number of the contacts of the peer has reached the upper limit.    |
| 1100   | PRESENCE_PARAM_LENGTH_EXCEED    | 参数长度超出限制   |   The length of the parameters you pass in when calling APIs of the presence service exceed the upper limit.  |
| 1110   | TRANSLATE_PARAM_INVALID      |  翻译参数错误 |  The parameters you pass in when calling APIs of the translation service are invalid.    |
| 1111   | TRANSLATE_SERVICE_NOT_ENABLE   |  未启用服务    |  The translation service has not been activated.   |
| 1112   | TRANSLATE_USAGE_LIMIT   | 翻译用量达到上限  |  The usage of the translation service exceeds the upper limit. |
| 1113   | TRANSLATE_MESSAGE_FAIL  | 获取翻译服务失败 | The request to retrieve the translation service fails.  |
| 1300   | REACTION_REACH_LIMIT            | 数量达到限制   |  The number of reactions exceeds the upper limit.   |
| 1301   | REACTION_HAS_BEEN_OPERATED      | The reaction to add already exists in your reaction list.    |
| 1302   | REACTION_OPERATION_IS_ILLEGAL   | 没有操作权限   | You do not have the permission to perform operations to a reaction. For example, you cannot delete a reaction if the reaction does not exist in your reaction list.    |
| 1400   | THREAD_NOT_EXIST |  子区不存在 |  The thread does not exist.    |
| 1401   | THREAD_ALREADY_EXIST | 该子区已存在  |   The thread to create already exists.    |
| 1402  | THREAD_CREATE_MESSAGE_ILLEGAL | 创建子区的消息无效 | The message to send in a thread is invalid.     |
| 1500    | PUSH_NOT_SUPPORT                | 第三方推送不支持                         | The third-party push service is not supported on the current device.  |
| 1501    | PUSH_BIND_FAILED                | 绑定第三方推送 token 失败                | The token of the third-party push service fails to upload to the server.     |
| 1502    | PUSH_UNBIND_FAILED              | 解绑第三方推送 token 失败                | The token of the third-party push service fails to unbind. |