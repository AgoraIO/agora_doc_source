# 在多个设备上登录

即时通讯 IM 支持同一用户 ID 在多个设备上登录，所有已登录的设备可同步以下信息和操作：

- 在线消息、离线消息、推送通知（若开启了第三方推送服务，离线设备收到）以及对应的回执和已读状态；
- 好友和群组相关操作。

即时通讯 IM 默认最多支持 4 个设备同时在线，详见[即时通讯 IM 计费说明](./agora_chat_pricing)。如需增加支持的设备数量，可以联系 [sales@agora.io](mailto:sales@agora.io)。

## 技术原理

iOS SDK 初始化时会生成登录 ID 用于在多设备登录和消息推送时识别设备。服务器会自动将新消息发送到用户登录的设备。即时通讯 IM iOS SDK 提供以下功能实现多个设备之间的互动：

- 获取其他登录设备的设备 ID；
- 获取其他设备上的好友或者群组操作。

## 前提条件

开始前，需确保完成 SDK 初始化，并连接到服务器。详见[快速开始](./agora_chat_get_started_ios)。

## 实现方法

### 获取其他已登录设备的登录 ID 列表并向这些设备发送消息

你可以调用 `getSelfIdsOnOtherPlatform` 方法获取其他登录设备的登录 ID 列表。选择目标登录 ID 作为消息接收方发出消息，则这些设备上的同一登录账号可以收到消息，实现不同设备之间的消息同步。

```objectivec
NSArray *ids = [AgoraChatClient.sharedClient.contactManager getSelfIdsOnOtherPlatformWithError:nil];
//选择一个登录 ID 作为消息发送方。
NSString *toChatUserId = ids[0];
//创建一条文本消息，content 为消息文字内容，toChatUserId 传入登录 ID 作为消息发送方。
AgoraChatTextMessageBody *textBody = [[AgoraChatTextMessageBody alloc] initWithText:@"content"];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUserId from:AgoraChatClient.sharedClient.currentUsername to:toChatUserId body:textBody ext:nil];

    //发送消息。
    [AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

### 强制账号从单个设备下线

```objectivec
// ID：账户名称，password：账户密码, deviceResource：设备 ID。
    [AgoraChatClient.sharedClient kickDeviceWithUsername:@"ID" password:@"password" resource:@"deviceResource" completion:nil];
```

### 获取其他设备上进行的好友或群组操作

例如，账号 A 同时登录设备 A 和 B，账号 A 在设备 A 上进行操作，设备 B 会收到这些操作对应的通知。

你需要先实现 `EMMultiDevicesDelegate` 监听其他设备上的操作，再调用 `addMultiDevicesDelegate` 方法添加设备监听。

```objectivec
//实现 `EMMultiDevicesDelegate` 监听其他设备上的操作。
@interface ViewController () <AgoraChatMultiDevicesDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加监听
    [AgoraChatClient.sharedClient addMultiDevicesDelegate:self delegateQueue:nil];
}

- (void)dealloc {
    [AgoraChatClient.sharedClient removeMultiDevicesDelegate:self];
}


#pragma mark - EMMultiDevicesDelegate
- (void)multiDevicesContactEventDidReceive:(AgoraChatMultiDevicesEvent)aEvent
                                  username:(NSString *)aUsername
                                       ext:(NSString *)aExt {

    switch (aEvent) {
            //好友已经在其他设备上被移除。
        case AgoraChatMultiDevicesEventContactRemove:

            break;
            //好友请求已经在其他设备上被同意。
        case AgoraChatMultiDevicesEventContactAccept:

            break;
            //好友请求已经在其他设备上被拒绝。
        case AgoraChatMultiDevicesEventContactDecline:

            break;
            //当前用户在其他设备加某人进入黑名单。
        case AgoraChatMultiDevicesEventContactBan:

            break;
            //好友在其他设备被移出黑名单。
        case AgoraChatMultiDevicesEventContactAllow:
            break;
        default:
            break;
    }
}

- (void)multiDevicesGroupEventDidReceive:(AgoraChatMultiDevicesEvent)aEvent
                                 groupId:(NSString *)aGroupId
                                     ext:(id)aExt {
    switch (aEvent) {
            //当前⽤户在其他设备创建了群组。
        case AgoraChatMultiDevicesEventGroupCreate:
            break;
            //当前⽤户在其他设备销毁了群组。
        case AgoraChatMultiDevicesEventGroupDestroy:
            break;
            //当前⽤户在其他设备已经加⼊群组。
        case AgoraChatMultiDevicesEventGroupJoin:
            break;
            //当前⽤户在其他设备已经离开群组。
        case AgoraChatMultiDevicesEventGroupLeave:
            break;
            //当前⽤户在其他设备发起了群组申请。
        case AgoraChatMultiDevicesEventGroupApply:
            break;
            //当前⽤户在其他设备同意了群组申请。
        case AgoraChatMultiDevicesEventGroupApplyAccept:
            break;
            //当前⽤户在其他设备拒绝了群组申请。
        case AgoraChatMultiDevicesEventGroupApplyDecline:
            break;
            //当前⽤户在其他设备邀请了群成员。
        case AgoraChatMultiDevicesEventGroupInvite:
            break;
            //当前⽤户在其他设备同意了群组邀请。
        case AgoraChatMultiDevicesEventGroupInviteAccept:
            break;
            //当前⽤户在其他设备拒绝了群组邀请。
        case AgoraChatMultiDevicesEventGroupInviteDecline:
            break;
            //当前⽤户在其他设备将某⼈踢出群。
        case AgoraChatMultiDevicesEventGroupKick:
            break;
            //当前⽤户在其他设备将成员加⼊群组⿊名单。
        case AgoraChatMultiDevicesEventGroupBan:
            break;
            //当前⽤户在其他设备将成员移除群组⿊名单。
        case AgoraChatMultiDevicesEventGroupAllow:
            break;
            //当前⽤户在其他设备屏蔽群组。
        case AgoraChatMultiDevicesEventGroupBlock:
            break;
            //当前⽤户在其他设备取消群组屏蔽。
        case AgoraChatMultiDevicesEventGroupUnBlock:
            break;
            //当前⽤户在其他设备转移群主。
        case AgoraChatMultiDevicesEventGroupAssignOwner:
            break;
            //当前⽤户在其他设备添加管理员。
        case AgoraChatMultiDevicesEventGroupAddAdmin:
            break;
            //当前⽤户在其他设备移除管理员。
        case AgoraChatMultiDevicesEventGroupRemoveAdmin:
            break;
            //当前⽤户在其他设备禁⾔⽤户。
        case AgoraChatMultiDevicesEventGroupAddMute:
            break;
            //当前⽤户在其他设备移除禁⾔。
        case AgoraChatMultiDevicesEventGroupRemoveMute:
            break;
        default:
            break;
    }
}
// 当前⽤户在其他设备单向删除服务端的历史消息。
- (void)multiDevicesMessageBeRemoved:(NSString *_Nonnull)conversationId deviceId:(NSString *_Nonnull)deviceId;
```

### 典型示例

当 PC 端和移动端登录同一个账号时，在移动端可以通过调用方法获取到 PC 端的登录 ID。该登录 ID 相当于特殊的好友用户 ID，可以直接使用于聊天，使用方法与好友的用户 ID 类似。

```objectivec
    NSArray *otherPlatformIds = [[AgoraChatClient sharedClient].contactManager getSelfIdsOnOtherPlatformWithError:nil];
    if ([otherPlatformIds count] > 0) {
        NSString *chatter = otherPlatformIds[0];
        //获取会话
        AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:chatter type:AgoraChatConversationTypeChat createIfNotExist:YES];
        
        //发送消息
        NSString *sendText = @"test";
        AgoraChatTextMessageBody *body = [[AgoraChatTextMessageBody alloc] initWithText:sendText];
        NSString *from = [[AgoraChatClient sharedClient] currentUsername];
        AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversation.conversationId from:from to:chatter body:body ext:nil];
        message.chatType = AgoraChatTypeChat;
        [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
    }
```