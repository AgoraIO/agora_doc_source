This page introduces the error codes and error messages that might be returned by the SDK when you call the Agora Chat APIs.

Possible reasons for the errors are given to assist you in debugging.  If you receive an error code not included here, Agora recommends you contact support@agora.io so that the technical support team can help resolve the issue.

During the run time of the Agora Chat SDK, if the method call succeeds, the SDK returns `nil`; of not, the SDK returns the following error codes and error messages:

| Error code | Error message | Description | Possible reason |
| :----- | :----------------------------------- | :------------------------------- | :----------------------------------------------------------- |
| 1 | `AgoraChatErrorGeneral` | A general error occurs (no specified reason) | The SDK has not been successfully initialized, or the specified reason for the error is not identified when you request the server. You can try reinitializing the SDK. |
| 2 | `AgoraChatErrorNetworkUnavailable` | Network error | Disconnections between the SDK and the server happen due to the network problems. |
| 3 | `AgoraChatErrorDatabaseOperationFailed` | The database operation fails | Fails to open local database. Please contact Agora technical support. |
| 4 | `AgoraChatErrorExceedServiceLimit` | The service limit is exceeded | The service limit is exceeded, for example: the total number of registered users or their friends exceeds the plan limit described in [Package plan](./agora_chat_plan?platform=iOS). |
| 100 | `AgoraChatErrorInvalidAppkey` | Invalid App Key | The App Key is invalid. Log in again using a valid App Key. For how to get the App Key, see [Get the information of theAgora Chat project](./enable_agora_chat?platform=iOS). |
| 101 | `AgoraChatErrorInvalidUsername` | Invalid user ID | The user ID is empty, or the format of the parameter is incorrect. Use a valid user ID. |
| 102 | `AgoraChatErrorInvalidPassword` | Invalid password | The password entered to log in is empty or incorrect. Log in again using the correct password. |
| 104 | `AgoraChatErrorUsernameTooLong` | The user ID is too long | The user ID is too long. Log in again with a valid user ID. |
| 200 | `AgoraChatErrorUserAlreadyLoginSame` | The user is already logged in | This user is already logged in. Do not log in repeatedly. |
| 201 | `AgoraChatErrorUserNotLogin` | The user is not logged in | The user is not logged in when the method is called. Please check your code logic. |
| 202 | `AgoraChatErrorUserAuthenticationFailed` | The user authentication fails | The user authentication fails. Check whether the token has expired. |
| 203 | `AgoraChatErrorUserAlreadyExist` | User already exists | A user with the same user ID is already logged in. Do not register repeatedly. |
| 204 | `AgoraChatErrorUserNotFound` | The user is not found | The user is not registered when the method is called. Register before doing any other operation. |
| 205 | `AgoraChatErrorUserIllegalArgument` | The user parameter is invalid | An invalid parameter is used when you call the method.  For example, invalid characters are found in the specified user ID.  Reset the parameters. |
| 206 | `AgoraChatErrorUserLoginOnAnotherDevice` | The user is logged in at another device | If the user does not enable multi-device login, the user is forced to log out when logging in at another device, and the SDK returns this error code. |
| 207 | `AgoraChatErrorUserRemoved` | The user is removed | When the logged in user ID is deleted by the server, the SDK returns this error code. |
| 208 | `AgoraChatErrorUserRegisterFailed` | The user registration fails | When you call the server registration method, the parameter passed is empty or invalid. For details, see [User registration RESTful API](./agora_chat_restful_reg?platform=RESTful). |
| 209 | `AgoraChatErrorUpdateApnsConfigsFailed` | Fails to update the push message configurations | Fails to update the push message configurations, such as the push display nickname, do-not-disturb mode, etc. Try calling the method again. |
| 210 | `AgoraChatErrorUserPermissionDenied` | The permission is denied to the user | The user has no permission to operate. Check whether the user is banned. If the user is banned, unban the user and log in again. |
| 213 | `AgoraChatErrorUserBindAnotherDevice` | The user is already logged in at another device | If the user sets the device login priority, that is, to log in at the device with higher priority, when the logged in user tries logging in to another device, the login fails, and the SDK returns the error code. |
| 214 | `AgoraChatErrorUserLoginTooManyDevices` | The user logs in at too many devices | If a user ID is logged in at four devices, when the user tries logging in at a fifth device, the SDK returns this error code. If you want a user to log in at more than four devices, contact support@agora.io. |
| 215 | `AgoraChatErrorUserMuted` | The user is muted | If the user is muted in the group or the chatroom, when the user sends a message, the SDK returns this error code. |
| 216 | `AgoraChatErrorUserKickedByChangePassword` | The user is kicked out due to a password change | If the logged in user changes the present password, the SDK kicks the user out and returns this error code. Try logging in again with the new password. |
| 217 | `AgoraChatErrorUserKickedByOtherDevice` | The user lis kicked out from another device and logs out | When the multi-device login function is enabled, if the user forces the user ID logged in at the current device to log out by calling APIs or managing the backend at another device, the SDK returns this error code. |
| 300 | `AgoraChatErrorServerNotReachable` | The requesting service fails | The SDK disconnects from the Agora Chat system due to network problems. Try again later. |
| 301 | `AgoraChatErrorServerTimeout` | A timeout occurs in the requesting service | Some API calls require the SDK to return the execution result. This error occurs if the SDK takes too long (more than 30 seconds) to return the result. |
| 302 | `AgoraChatErrorServerBusy` | The server is busy | The server is currently busy. Try again later. |
| 303 | `AgoraChatErrorServerUnknownError` | The common error code of the requesting service | This common error occurs when the requesting service fails. Check the log for troubleshooting. |
| 304 | `AgoraChatErrorServerGetDNSConfigFailed` | An error occurs in getting the server configuration information | The SDK fails in getting the configuration of the server that the app currently runs on.  Try calling the method again. |
| 305 | `AgoraChatErrorServerServingForbidden` | The current app is banned | If the app is banned, the SDK returns this error code when the methods are called. |
| 400 | `AgoraChatErrorFileNotFound` | The file is not found | When the user is unable to get the log file or download the attachment, the SDK returns this error code. |
| 401 | `AgoraChatErrorFileInvalid` | The file is invalid | When the uploaded message attachment or the shared file in the group is invalid, the SDK returns this error code. |
| 402 | `AgoraChatErrorFileUploadFailed` | The file cannot be uploaded | When the message attachment cannot be uploaded, the SDK returns this error code.  Try uploading again. |
| 403 | `AgoraChatErrorFileDownloadFailed` | The file cannot be downloaded | When the message attachment cannot be downloaded, the SDK returns this error code. Try downloading again. |
| 404 | `AgoraChatErrorFileDeleteFailed` | The file cannot be deleted | When getting the log file, the SDK deletes the old log file. If the old log files cannot be deleted, the SDK returns this error code. |
| 405 | `AgoraChatErrorFileTooLarge` | The file is too large | When the size of the message attachment or the group shared file exceeds the limit, the SDK returns this error code.  Adjust the file size, and try uploading again. |
| 406 | `AgoraChatErrorFileContentImproper` | The file content does not comply with certain rules. | This error can also be reported if you fail to upload a message attachment. |
| 500 | `AgoraChatErrorMessageInvalid` | The message is invalid | The content of the message to be sent is empty, the message ID is empty, or the user ID of the sender is not the user ID that is currently logged in.  Check the problems, and try sending the message again. |
| 502 | `AgoraChatErrorMessageTrafficLimit` | The message traffic is limited | The message-sending frequency is too high or the message size is too large. Agora recommends reducing the sending frequency or the message size. |
| 504 | `AgoraChatErrorMessageRecallTimeLimit` | A timeout occurs when the message is recalled | When a timeout occurs during message recall, the SDK returns this error code. |
| 505 | `AgoraChatErrorServiceNotEnable` | The service is not enabled | When you try using a service that is not enabled, the SDK returns this error code. |
| 506 | `AgoraChatErrorMessageExpired` | The message expires | If you send a group receipt after the time limit (the default is three days), the SDK returns this error code. |
| 507 | `AgoraChatErrorMessageIllegalWhiteList` | The user is not included in the whitelist | If all members are banned in the group chatroom and the user ID is not included in the whitelist, when this user tries sending a message, the SDK returns this error code. |
| 508 | `AgoraChatErrorMessageExternalLogicBlocked` | The callback is triggered before the method is executed | The sent message is intercepted by the user-defined pre-send callback rule. Check your settings of the pre-send callback rule. |
| 600 | `AgoraChatErrorGroupInvalidId` | The group ID is invalid | When you call the methods related to the group and the group ID provided is invalid, the SDK returns this error code. |
| 601 | `AgoraChatErrorGroupAlreadyJoined` | The user has already joined the group | When you call the group joining method, if the user has already joined the group, the SDK returns this error code. |
| 602 | `AgoraChatErrorGroupNotJoined` | You have not joined the group | When you try sending messages or controlling a group that you have not joined, the SDK returns this error code. |
| 603 | `AgoraChatErrorGroupPermissionDenied` | Group permission is denied | The user does not have permission to control the group, for example the group members do not have permission to set the group administrator.  Check whether the user has administrator permissions. |
| 604 | `AgoraChatErrorGroupMembersFull` | The group is full | The number of the group members has reached the limit. |
| 605 | `AgoraChatErrorGroupNotExist` | The group does not exist | When you try controlling a group that does not exist, the SDK returns this error code. |
| 606 | `AgoraChatErrorGroupSharedFileInvalidId` | The group shared file ID is empty | The group shared file ID is empty and the group shared file cannot be uploaded or downloaded. |
| 700 | `AgoraChatErrorChatroomInvalidId` | The chatroom ID is invalid | When you call the methods related to the chatroom and the chatroom ID provided is empty, the SDK returns this error code. |
| 701 | `AgoraChatErrorChatroomAlreadyJoined` | The user has already joined the chatroom | When you call the chatroom-joining method, if the user has already joined the chatroom, the SDK returns this error code. |
| 702 | `AgoraChatErrorChatroomNotJoined` | You have not joined the chatroom | When you try sending messages or controlling a chatroom that you have not joined, the SDK returns this error code. |
| 703 | `AgoraChatErrorChatroomPermissionDenied` | Chatroom permission is denied | The user does not have permission to control the chatroom, for example, the chatroom members do not have permission to set the chatroom administrator.  Check whether the user has administrator permissions. |
| 704 | `AgoraChatErrorChatroomMembersFull` | The chatroom is full | The number of the chatroom members has reached the limit. |
| 705 | `AgoraChatErrorChatroomNotExist` | The chatroom does not exist	 | When you try controlling a chatroom that does not exist, the SDK returns this error code. |
| 900 | `AgoraChatErrorUserCountExceed` | The number of users when retrieving user attributes exceeds 100 | When retrieiving user arrtributes, if the number of the specified users exceed 100, the SDK returns this error code. |
| 901 | `AgoraChatErrorUserInfoDataLengthExceed` | The length of the user attribute exceeds the limit | The length of the set user attribute exceeds the limit. The sum of all user attributes for a single user cannot exceed 2 KB, and the sum of all user attributes for a single app cannot exceed 10 GB. |