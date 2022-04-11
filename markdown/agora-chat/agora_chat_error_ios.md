本文主要介绍在调用 Agora Chat API 过程中，SDK 返回的错误码和错误信息。

你可以根据如下错误码及错误信息了解出错的可能原因，并采取响应措施。对于未给出解决方法的错误码，Agora 推荐你[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会根据你在实际场景中遇到的问题进行排查。

Agora Chat SDK 在运行过程中，如果方法调用成功，则返回 `nil`；如果方法调用失败，则返回如下错误码及错误信息：

| 错误码 | 错误信息                             | 描述                             | 可能原因                                                     |
| :----- | :----------------------------------- | :------------------------------- | :----------------------------------------------------------- |
| 1      | `AgoraChatErrorGeneral`              | 一般性错误（没有明确归类的错误） | SDK 尚未正确初始化，或请求服务器时未识别出具体原因的错误。你可以尝试重新初始化 SDK。 |
| 2      | `AgoraChatErrorNetworkUnavailable`   | 网络错误                         | 网络连接中断导致 SDK 与服务器的连接断开。                    |
| 3      | `AgoraChatErrorDatabaseOperationFailed`     | 数据库操作失败                   | 打开本地数据库失败。请联系 Agora 技术支持。                  |
| 4      | `AgoraChatErrorExceedServiceLimit`          | 超过服务限制                     | 超过即时通讯服务的数量限制，例如：注册用户总数或用户好友人数等超过[套餐包限制](./agora_chat_plan?platform=iOS#用户相关)。 |
| 100    | `AgoraChatErrorInvalidAppkey`               | 无效的 App Key                   | App Key 不正确，请更换有效的 App Key 并重新登录。如何获取 App Key 详见[获取即时通讯项目信息](./enable_agora_chat?platform=iOS#获取即时通讯项目信息)。 |
| 101    | `AgoraChatErrorInvalidUsername`             | 无效的用户名                     | 用户名为空或参数格式不正确，请更换有效的用户名。 |
| 102    | `AgoraChatErrorInvalidPassword`             | 错误的密码                       | 登录时提供的密码为空或不正确，请更换正确的密码并重新登录。   |
| 104    | `AgoraChatErrorUsernameTooLong`             | 错误的 Token                     | 登录时提供的 Token 为空或不正确，请更换正确的 Token 并重新登录。 |
| 200    | `AgoraChatErrorUserAlreadyLoginSame`        | 用户已登录                       | 该用户名已登录，请勿重复登录。                               |
| 201    | `AgoraChatErrorUserNotLogin`                | 用户未登录                       | 调用方法时用户尚未登录。请检查方法的调用逻辑。               |
| 202    | `AgoraChatErrorUserAuthenticationFailed`    | 用户鉴权失败                     | 鉴权失败，请检查 Token 是否过期。                            |
| 203    | `AgoraChatErrorUserAlreadyExist`            | 用户已存在                       | 用户名已注册，请勿重复注册。                                 |
| 204    | `AgoraChatErrorUserNotFound`                | 用户不存在                       | 调用方法时该用户尚未注册，请先注册再进行其他操作。           |
| 205    | `AgoraChatErrorUserIllegalArgument`         | 用户参数不正确                   | 调用方法时设置了无效的参数。例如指定的用户名中含有非法字符。请重新设置参数。 |
| 206    | `AgoraChatErrorUserLoginOnAnotherDevice`    | 用户在其他设备登录               | 如果用户未开启多设备登录，当在其他设备登录时，会被强制从当前登录的设备下线，且收到该错误码。 |
| 207    | `AgoraChatErrorUserRAgoraChatoved`                 | 用户已经被注销                   | 如果登录用户 ID 被管理员从管理后台删除则会收到此错误。       |
| 208    | `AgoraChatErrorUserRegisterFailed`          | 用户注册失败                     | 调用服务端注册方法时，传入参数为空或不合法，请确认后重新调用方法。详见[注册用户 RESTful API](./agora_chat_restful_reg?platform=RESTful#注册单个用户)。 |
| 209    | `AgoraChatErrorUpdateApnsConfigsFailed`     | 更新推送配置错误                 | 用户更新推送配置信息错误，如更新推送显示昵称、更新免打扰模式等。请重新调用方法。 |
| 210    | `AgoraChatErrorUserPermissionDenied`        | 用户无权限                       | 用户没有操作权限。请检查是用户是否被封禁，如被封禁需要解禁并重新登录。 |
| 213    | `AgoraChatErrorUserBindAnotherDevice`       | 用户已经在另外设备登录           | 如果用户设置了设备登录优先级（如先登录的设备优先级高），当已登录的用户登录其他设备时，则登录失败，且收到该错误码。 |
| 214    | `AgoraChatErrorUserLoginTooManyDevices`     | 用户登录设备数超过限制           | 用户登录新设备时，同一用户登录设备数量已达到最大值 4。如对登录设备数量有更高需求，请联系 Agora 技术支持。 |
| 215    | `AgoraChatErrorUserMuted`                   | 用户被禁言                       | 群组或聊天室中被禁言的用户发送消息。                         |
| 216    | `AgoraChatErrorUserKickedByChangePassword`  | 用户密码更新导致用户登出         | 已登录的用户修改密码导致被强制登出。请使用新密码重新登录。   |
| 217    | `AgoraChatErrorUserKickedByOtherDevice`     | 用户登出其他设备                 | 开启多设备登录后，用户在当前设备上通过调用 API 或管理后台从指定的其他设备登出。 |
| 300    | `AgoraChatErrorServerNotReachable`          | 请求服务失败                     | 网络原因导致 SDK 与即时通讯系统断开连接，建议稍后再次尝试。  |
| 301    | `AgoraChatErrorServerTimeout`               | 请求服务超时                     | 有些方法调用需要 SDK 返回结果，如果 SDK 处理事件过长，即超过 30 秒没有返回，则返回该错误码。 |
| 302    | `AgoraChatErrorServerBusy`                  | 服务器忙碌                       | 当前服务器忙碌，建议稍后再次尝试。                           |
| 303    | `AgoraChatErrorServerUnknownError`          | 请求服务的通用错误码             | 当请求服务未成功时的通用错误，该错误发生情况较多，需要根据日志进一步排查。 |
| 304    | `AgoraChatErrorServerGetDNSConfigFailed`    | 获取服务器配置信息错误           | SDK 获取当前应用的服务器配置时失败。请重新调用方法。         |
| 305    | `AgoraChatErrorServerServingForbidden`      | 当前 app 被禁用                  | 在被禁用的 App 下调用方法。                                  |
| 400    | `AgoraChatErrorFileNotFound`                | 文件未找到                       | 用户获取不到日志文件，或下载附件时获取不到文件。             |
| 401    | `AgoraChatErrorFileInvalid`                 | 文件无效                         | 上传消息附件或群组文件时的文件无效。                         |
| 402    | `AgoraChatErrorFileUploadFailed`            | 上传文件失败                     | 上传消息附件或群组文件失败。请尝试重新上传。                 |
| 403    | `AgoraChatErrorFileDownloadFailed`          | 下载文件失败                     | 下载消息附件或群组文件失败。请尝试重新下载。                 |
| 404    | `AgoraChatErrorFileDeleteFailed`            | 删除文件失败                     | 获取日志文件时，SDK 会删除旧日志文件，如果删除失败，则返回该错误码。 |
| 405    | `AgoraChatErrorFileTooLarge`                | 文件大小超限                     | 上传消息附件或群组文件时，文件大小超过限制。请确认文件大小并重新上传。 |
| 406    | `AgoraChatErrorFileContentImproper`         | 文件内容不合规                   | 发送消息上传附件失败时可能提示该错误。                       |
| 500    | `AgoraChatErrorMessageInvalid`              | 消息异常错误                     | 待发送的消息内容、消息 ID 为空，或消息发送方的用户名与当前登录的用户名不同。请排查后重新发送消息。 |
| 502    | `AgoraChatErrorMessageTrafficLimit`         | 消息限流                         | 发送消息频率过高或消息体积过大，建议降低发送频率或消息体积。 |
| 504    | `AgoraChatErrorMessageRecallTimeLimit`      | 消息撤回超时                     | 尝试撤回消息时超过撤回允许时间。                             |
| 505    | `AgoraChatErrorServiceNotEnable`            | 服务未开启                       | 尝试使用未开通的功能。                                       |
| 506    | `AgoraChatErrorMessageExpired`              | 消息已过期                       | 发送群组回执时超过时间限制 (默认 3 天) 。                    |
| 507    | `AgoraChatErrorMessageIllegalWhiteList`     | 用户未在白名单中                 | 当群组聊天室开启全员禁言，未在禁言白名单中的用户发送消息。   |
| 508    | `AgoraChatErrorMessageExternalLogicBlocked` | 消息执行发送前回调导致被拦截     | 发送的消息被用户定义的发送前回调规则拦截，请确认发送前回调规则。 |
| 600    | `AgoraChatErrorGroupInvalidId`              | 群组 ID 异常                     | 调用群组相关方法，提供的群组 ID 为空。                       |
| 601    | `AgoraChatErrorGroupAlreadyJoined`          | 已在该群组中                     | 已在群组中的用户尝试加入该群组。                             |
| 602    | `AgoraChatErrorGroupNotJoined`              | 未加入该群组                     | 尝试在未加入的群组中发送消息，或进行其他群组操作。           |
| 603    | `AgoraChatErrorGroupPermissionDenied`       | 无权限的群组操作                 | 用户没有群组操作的权限，例如群组成员不能设置群组管理员。请确认权限是否为管理员。 |
| 604    | `AgoraChatErrorGroupMAgoraChatbersFull`            | 群组已满                         | 群组人数已经达到上限。                                       |
| 605    | `AgoraChatErrorGroupNotExist`               | 群组不存在                       | 尝试对不存在的群组进行操作。                                 |
| 606    | `AgoraChatErrorGroupSharedFileInvalidId`    | 群组共享文件 ID 为空             | 群组共享文件 ID 为空导致无法上传或下载该群组共享文件。       |
| 700    | `AgoraChatErrorChatroomInvalidId`           | 聊天室 ID 异常                   | 调用聊天室相关方法时提供的聊天室 ID 为空。                   |
| 701    | `AgoraChatErrorChatroomAlreadyJoined`       | 已在该聊天室中                   | 已在聊天室中的用户尝试加入该聊天室。                         |
| 702    | `AgoraChatErrorChatroomNotJoined`           | 未加入该聊天室                   | 尝试在未加入的聊天室中发送消息，或进行聊天室操作。           |
| 703    | `AgoraChatErrorChatroomPermissionDenied`    | 无权限的聊天室操作               | 用户没有聊天室操作权限，例如聊天室成员不能设置聊天室管理员。请确认权限是否为管理员。 |
| 704    | `AgoraChatErrorChatroomMAgoraChatbersFull`         | 聊天室已满                       | 聊天室人数已经达到上限。                                     |
| 705    | `AgoraChatErrorChatroomNotExist`            | 聊天室不存在                     | 尝试对不存在的聊天室进行操作。                               |
| 900    | `AgoraChatErrorUserCountExceed`             | 第三方推送不支持                 | 用户配置的第三方推送在当前设备上不支持。请确认当前设备是否支持该第三方推送类型。 |
| 901    | `AgoraChatErrorUserInfoDataLengthExceed`    | 用户属性长度超限                 | 设置的用户属性长度超过限制。单个用户的所有用户属性之和不能超过 2 KB，单个 app 所有用户属性之和不能超过 10 GB。 |