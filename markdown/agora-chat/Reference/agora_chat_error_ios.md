本文主要介绍在调用 Agora 即时通讯 iOS API 过程中，SDK 返回的错误码和错误信息。

你可以根据如下错误码及错误信息了解出错的可能原因，并采取响应措施。对于未给出解决方法的错误码，Agora 推荐你[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会根据你在实际场景中遇到的问题进行排查。

Agora 即时通讯 iOS SDK 在运行过程中，如果方法调用成功，则返回 `nil`；如果方法调用失败，则返回如下错误码及错误信息：

| 错误码 | 错误信息             | 描述和可能原因                            |
| :----- | :-----------------  | :------------------------------ |
| 1      | `AgoraChatErrorGeneral`       | 一般性错误（没有明确归类的错误）：SDK 尚未正确初始化，或请求服务器时未识别出具体原因的错误。你可以尝试重新初始化 SDK。 |
| 2      | `AgoraChatErrorNetworkUnavailable`   | 网络错误：网络连接中断导致 SDK 与服务器的连接断开。                    |
| 3      | `AgoraChatErrorDatabaseOperationFailed`     | 数据库操作失败：打开本地数据库失败。请联系 Agora 技术支持。                  |
| 4      | `AgoraChatErrorExceedServiceLimit`          | 超过服务限制：超过即时通讯服务的数量限制，例如：注册用户总数或用户好友人数等超过[套餐包限制](./agora_chat_plan#用户相关)。 |
| 100    | `AgoraChatErrorInvalidAppkey`               | 无效的 App Key：App Key 不正确，请更换有效的 App Key 并重新登录。关于如何获取 App Key，详见[获取即时通讯项目信息](./enable_agora_chat#获取即时通讯项目信息)。 |
| 101    | `AgoraChatErrorInvalidUsername`             | 用户 ID 为空或不正确，请更换有效的用户名。 |
| 102    | `AgoraChatErrorInvalidPassword`             | 用户密码不正确：登录时提供的密码为空或不正确。请更换正确的密码并重新登录。   |
| 104    | `AgoraChatErrorUsernameTooLong`             | 用户名过长。 |
| 200    | `AgoraChatErrorUserAlreadyLoginSame`        | 当前用户已经登录。       |
| 201    | `AgoraChatErrorUserNotLogin`                | 用户未登录：例如，如果未登录成功时调用发送消息或群组操作的 API 会提示该错误。              |
| 202    | `AgoraChatErrorUserAuthenticationFailed`    | 用户鉴权失败：一般是 token 鉴权失败或者 token 已经过期。   |
| 203    | `AgoraChatErrorUserAlreadyExist`            | 用户已经存在：注册的用户 ID 已存在。 |
| 204    | `AgoraChatErrorUserNotFound`                | 用户不存在：比如登录或者获取用户会话列表时用户 ID 不存在。      |
| 205    | `AgoraChatErrorUserIllegalArgument`         | 用户参数不正确：比如创建用户 ID 时不符合格式要求，或者更新用户属性时用户参数为空等。 |
| 206    | `AgoraChatErrorUserLoginOnAnotherDevice`    | 用户在其他设备登录：如果用户未开启多设备登录，当在其他设备登录时，会被强制从当前登录的设备下线，且收到该错误码。 |
| 207    | `AgoraChatErrorUserRemoved`                 | 用户已经被注销：如果登录用户 ID 被管理员从管理后台删除则会收到此错误。       |
| 208    | `AgoraChatErrorUserRegisterFailed`          | 用户注册失败：调用服务端注册方法时，传入参数为空或不合法，请确认后重新调用方法。详见[注册用户 RESTful API](./agora_chat_restful_reg?platform=RESTful#注册单个用户)。 |
| 209    | `AgoraChatErrorUpdateApnsConfigsFailed`     | 更新推送配置错误：用户更新推送配置信息错误，如更新推送显示昵称、更新免打扰模式等。请重新调用方法。 |
| 210    | `AgoraChatErrorUserPermissionDenied`        | 用户无权限 ：例如，如果用户被封禁，发送消息时会提示该错误。 |
| 214    | `AgoraChatErrorUserLoginTooManyDevices`     | 用户登录设备数超过限制：该错误在多设备自动登录场景中且打开不踢掉其他设备上的登录的开关时超过登录设备数量的限制才会出现。例如，用户最多可同时登录 4 台设备， A（实现了自动登录）、B、C 和 D。手动登录设备 E 后，用户再次自动登录设备 A 时登录失败且提示该错误。如对登录设备数量有更高需求，请联系 [support@agora.io](mailto:support@agora.io)。 |
| 215    | `AgoraChatErrorUserMuted`                   | 用户被禁言：群组或聊天室中被禁言的用户发送消息。                         |
| 216    | `AgoraChatErrorUserKickedByChangePassword`  | 用户密码更新：当前登录的用户密码被修改后，当前登录会断开并提示该错误。请使用新密码重新登录。   |
| 217    | `AgoraChatErrorUserKickedByOtherDevice`     | 用户被踢下线：未开启多设备登录，如果用户在其他设备上登录；或者开启多设备登录后，用户登录设备数量超过限制，则最新一台设备登录时会踢掉第一台设备，SDK 会提示该错误。 |
| 218    | `AgoraChatErrorUserAlreadyLoginAnother`    | 其他用户已登录：其他用户已在当前环境下登录 SDK，当前用户不能再登录。 |
| 219    | `AgoraChatErrorUserMutedByAdmin`       | 当前用户被管理员禁言，请联系管理员解除禁言。                 |
| 221    | `AgoraChatErrorUserNotOnRoster`          | 非好友禁止发消息：开通非好友禁止发消息后，非好友间发消息提示此错误。该功能可在控制台开通。 |
| 300    | `AgoraChatErrorServerNotReachable`          | 请求服务失败：发送或撤回消息时，如果 SDK 与消息服务器未保持连接，会返回该错误；操作群组、好友等请求时，如果因网络连接太差而不成功，也会返回该错误。  |
| 301    | `AgoraChatErrorServerTimeout`               | 请求服务超时：有些方法调用需要 SDK 返回结果，如果 SDK 处理事件过长，即超过 30 秒没有返回，则返回该错误码。 |
| 302    | `AgoraChatErrorServerBusy`                  | 服务器忙碌：当前服务器忙碌，建议稍后再次尝试。                           |
| 303    | `AgoraChatErrorServerUnknownError`          | 请求服务的通用错误码：当请求服务未成功时的通用错误，该错误发生情况较多，需要根据日志进一步排查。 |
| 304    | `AgoraChatErrorServerGetDNSConfigFailed`    | 获取服务器配置信息错误：SDK 获取当前应用的服务器配置时失败。请重新调用方法。         |
| 305    | `AgoraChatErrorServerServingForbidden`      | 当前 app 被禁用：在被禁用的 App 下调用方法。                                  |
| 400    | `AgoraChatErrorFileNotFound`                | 文件未找到：当用户获取不到日志文件，或下载附件时获取不到文件。             |
| 401    | `AgoraChatErrorFileInvalid`                 | 文件无效 ：当上传消息附件或者群组共享文件时可能会提示该错误。                      |
| 402    | `AgoraChatErrorFileUploadFailed`            | 上传文件失败：上传消息附件或群组文件失败。请尝试重新上传。                 |
| 403    | `AgoraChatErrorFileDownloadFailed`          | 下载文件失败：下载消息附件或群组文件失败。请尝试重新下载。                 |
| 404    | `AgoraChatErrorFileDeleteFailed`            | 删除文件失败：获取日志文件时，SDK 会删除旧日志文件，如果删除失败，则返回该错误码。 |
| 405    | `AgoraChatErrorFileTooLarge`                | 文件大小超限：上传消息附件或群组文件时，文件大小超过限制。请确认文件大小并重新上传。 |
| 406    | `AgoraChatErrorFileContentImproper`         | 文件内容不合规：发送消息上传附件失败时可能提示该错误。                       |
| 500    | `AgoraChatErrorMessageInvalid`              | 消息异常错误：待发送的消息内容、消息 ID 为空，或消息发送方的用户名与当前登录的用户名不同。请排查后重新发送消息。 |
| 502    | `AgoraChatErrorMessageTrafficLimit`         | 消息限流：消息发送速度过快，建议降低频率或者减少消息内容。 |
| 504    | `AgoraChatErrorMessageRecallTimeLimit`      | 消息撤回超时：尝试撤回消息时超过撤回允许时间。                             |
| 505    | `AgoraChatErrorServiceNotEnable`            | 服务未开通：尝试使用未开通的功能。                                       |
| 506    | `AgoraChatErrorMessageExpired`              | 消息已过期：发送群组回执时超过时间限制 (默认 3 天) 。                    |
| 507    | `AgoraChatErrorMessageIllegalWhiteList`     | 用户未在白名单中：当群组或聊天室开启全员禁言，未在禁言白名单中的用户发送消息。   |
| 508    | `AgoraChatErrorMessageExternalLogicBlocked` | 消息执行发送前回调导致被拦截：发送的消息被用户定义的发送前回调规则拦截，请确认发送前回调规则。 |
| 600    | `AgoraChatErrorGroupInvalidId`              | 群组 ID 异常：调用群组相关方法，传入的群组 ID 为空。                       |
| 601    | `AgoraChatErrorGroupAlreadyJoined`          | 已在该群组中：已在群组中的用户尝试加入该群组。                             |
| 602    | `AgoraChatErrorGroupNotJoined`              | 未加入该群组：尝试在未加入的群组中发送消息，或进行其他群组操作。           |
| 603    | `AgoraChatErrorGroupPermissionDenied`       | 无权限的群组操作：用户没有群组操作的权限，例如群组成员不能设置群组管理员。|
| 604    | `AgoraChatErrorGroupMembersFull`            | 群组已满：群组人数已经达到上限。                                       |
| 605    | `AgoraChatErrorGroupNotExist`               | 群组不存在：尝试对不存在的群组进行操作。                                 |
| 606    | `AgoraChatErrorGroupSharedFileInvalidId`    | 群组共享文件 ID 为空：群组共享文件 ID 为空导致无法上传或下载该群组共享文件。       |
| 700    | `AgoraChatErrorChatroomInvalidId`           | 聊天室 ID 异常：调用聊天室相关方法时传入的聊天室 ID 为空。                   |
| 701    | `AgoraChatErrorChatroomAlreadyJoined`       | 已在该聊天室中：调用加入聊天室的 API 添加的用户已经在该聊天室中。                 |
| 702    | `AgoraChatErrorChatroomNotJoined`           | 未加入该聊天室：用户在未加入的聊天室中发送消息或进行聊天室操作时提示该错误。        |
| 703    | `AgoraChatErrorChatroomPermissionDenied`    | 无权限的聊天室操作：没有权限进行聊天室操作，比如聊天室成员不能设置聊天室管理员。 |
| 704    | `AgoraChatErrorChatroomMembersFull`         | 聊天室已满：聊天室人数已经达到上限。                                     |
| 705    | `AgoraChatErrorChatroomNotExist`            | 聊天室不存在：尝试对不存在的聊天室进行操作。                               |
| 900    | `AgoraChatErrorUserCountExceed`             | 获取用户属性的用户个数超过 100。 |
| 901    | `AgoraChatErrorUserInfoDataLengthExceed`    | 设置的用户属性太长。单个用户的所有属性数据不能超过 2 KB，单个 app 所有用户属性数据不能超过 10 GB。 |
| 903    | `AgoraChatErrorTranslateParamInvalid`     | 调用翻译方法传入的参数无效，请检查传入的参数。                     |
| 904    | `AgoraChatErrorTranslateFail`         | 翻译服务接口返回错误。                                       |
| 905    | `AgoraChatErrorTranslateNotInit`       | 翻译服务未初始化。                                           |
| 1000   | `AgoraChatErrorContactAddFailed`       | 添加联系人失败。                                             |
| 1001   | `AgoraChatErrorContactReachLimit`       | 邀请者的联系人数量已经达到上限。                               |
| 1002   | `AgoraChatErrorContactReachLimitPeer`     | 受邀请者的联系人达到上限。                                     |
| 1100   | `AgoraChatErrorPresenceParamExceed`     | 调用 Presence 相关方法时参数长度超出限制。                   |
| 1101   | `AgoraChatErrorPresenceCannotSubscribeSelf`  | 用户订阅自己的在线状态时提示该错误。不能订阅你自己的状态。                                       |
| 1110   | `AgoraChatErrorTranslateParamError`      | 翻译参数错误。                                               |
| 1111   | `AgoraChatErrorTranslateServiceNotEnabled`  | 翻译服务未启用。                                             |
| 1112   | `AgoraChatErrorTranslateUsageLimit`      | 翻译用量达到上限。                                           |
| 1113   | `AgoraChatErrorTranslateServiceFail`     | 获取翻译服务失败。          |
| 1200   | `AgoraChatErrorModerationFailed`           | 第三方内容审核服务的消息审核结果为“拒绝”。 |
| 1299   | `AgoraChatErrorThirdServiceFailed`        | 除第三方内容审核服务外的其他服务的消息审核结果为“拒绝”。 |
| 1300   | `AgoraChatErrorReactionReachLimit`      | Reaction 数量已达到限制。           |
| 1301   | `AgoraChatErrorReactionHasBeenOperated`    | Reaction 重复添加。                                          |
| 1302   | `AgoraChatErrorReactionOperationIsIllegal`  | 没有操作权限：用户对该 Reaction 没有操作权限。例如没有添加过该 Reaction 的用户进行删除操作，或者单聊消息非发送者和非接受者进行添加 Reaction 操作。 |
| 1400   | `AgoraChatErrorThreadNotExist`        | 未找到该子区，该子区不存在。                                 |
| 1401   | `AgoraChatErrorThreadAlreadyExist`         | 该消息 ID 下子区已存在，重复添加子区。                       |
| 1402   | `AgoraChatErrorThreadCreateMessageIllegal`    | 创建子区的消息无效：创建子区时父消息被撤回了，或者无法使用。 |