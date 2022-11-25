# 管理频道

频道（Channel）是一个社区下不同子话题的讨论分区，因此一个社区下可以有多个频道。社区创建时会自动创建默认频道，该频道中添加了所有社区成员，用于承载各种系统通知。社区创建者可以根据自己需求创建公开或者私密频道。

## 技术原理

即时通讯 IM Android SDK 提供 `io.agora.chat.CircleManager` 类用于频道管理，支持你通过调用 API 在项目中实现如下功能：

- 创建和管理频道；
- 管理频道成员；
- 监听频道事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android?platform=Android)。
- 了解消息相关限制和即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation?platform=Android)。

## 实现方法

本节介绍如何使用即时通讯 IM Android SDK 提供的 API 实现上述功能。

### 创建和管理频道

#### <a name="create"></a>创建频道

1. 社区所有者可以调用 `createChannel` 方法在社区中创建公开或私密频道。参与频道创建的初始成员会收到 `onChannelCreated` 事件。

每个社区默认最多可创建 100 个频道，超过该阈值需要联系 [support@agora.io](support@agora.io) 调整。

示例代码如下：

```java
CircleChannelAttribute channelAttribute1 = new CircleChannelAttribute();
channelAttribute1.setName("name");
channelAttribute1.setDesc("desc");
channelAttribute1.setExt("custom");
ChatClient.getInstance().chatCircleManager().createChannel(serverId, channelAttribute1, CircleChannelStyle.EMChannelStylePublic, new ValueCallBack<CircleChannel>() {

   @Override
   public void onSuccess(CircleChannel value) {
     
   }

   @Override
   public void onError(int code, String errorMsg) {
      
   }
});
```

2. 邀请用户加入频道。

社区中的用户可以自由加入社区下的公开频道，私密频道只能由频道成员邀请用户加入。

- 调用 `inviteUserToChannel` 方法邀请用户加入频道，示例代码如下：

 ```java
ChatClient.getInstance().chatCircleManager().inviteUserToChannel(serverId, mChannelId, inviteUserId, "welcome", new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {
      
   }
});
 ```

- 用户监听 `onReceiveInvitation` 事件收到频道加入邀请，确认是否接受该邀请。

   - 用户调用 `acceptChannelInvitation` 方法同意加入频道，邀请人收到 `onInvitationBeAccepted` 回调，频道所有成员（不包括该新加入的成员）收到 `onMemberJoinedChannel` 回调。示例代码如下：

   ```java
ChatClient.getInstance().chatCircleManager().acceptChannelInvitation(serverId, mChannelId, mInviter,new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {
      
   }
});
   ```

   - 用户调用 `declineChannelInvitation` 方法拒绝加入频道，邀请人收到 `onInvitationBeDeclined` 回调。示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().declineChannelInvitation(serverId, mChannelId,mInviter ,new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {
      
   }
});
```

3. 用户加入频道后，可在频道中发送和接收消息。

#### 修改频道信息

仅社区所有者和管理员可调用 `updateChannel` 方法修改频道属性，如频道名称、频道描述、频道成员数量上限级别和频道自定义扩展信息。频道所有成员（除操作者外）会收到 `onChannelUpdated` 事件。示例代码如下：

```java
CircleChannelAttribute channelAttribute = new CircleChannelAttribute();
channelAttribute.setName("更新后的channel name");
channelAttribute.setDesc("更新后的channel desc");
channelAttribute.setExt("2");
ChatClient.getInstance().chatCircleManager().updateChannel(serverId, mChannelId, channelAttribute, new ValueCallBack<CircleChannel>() {
   @Override
   public void onSuccess(CircleChannel value) {
      
   }

   @Override
   public void onError(int code, String error) {
     
   }
});
```

#### 解散频道

仅社区所有者可以调用 `destroyChannel` 方法解散社区中的频道，频道内其他成员收到 `onChannelDestroyed` 回调并被移出频道。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().destroyChannel(serverId, mChannelId, new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {
      
   }
});
```

#### 获取频道详情

社区成员可以调用 `fetchChannelDetail` 方法获取社区的详情。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchChannelDetail(serverId, mChannelId, new ValueCallBack<CircleChannel>() {
   @Override
   public void onSuccess(CircleChannel value) {
      
   }

   @Override
   public void onError(int error, String errorMsg) {
      
   }
});
```

#### 获取频道列表

##### <a name="public"></a>获取社区下的所有公开频道列表

社区成员可以调用 `fetchPublicChannelsInServer` 方法获取社区下的所有公开频道列表，示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchPublicChannelsInServer(serverId, 20, null, new ValueCallBack<CursorResult<CircleChannel>>() {
   @Override
   public void onSuccess(CursorResult<CircleChannel> value) {
      
   }

   @Override
   public void onError(int error, String errorMsg) {
      
   }
});
```

##### 获取当前用户加入的私密频道列表

社区所有者和管理员可以获取全部的私密频道，普通成员只能获取自己加入的私密频道，示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchVisiblePrivateChannelsInServer(serverId, 20, null, new ValueCallBack<CursorResult<CircleChannel>>() {
   @Override
   public void onSuccess(CursorResult<CircleChannel> value) {
      
   }

   @Override
   public void onError(int error, String errorMsg) {
      
   }
});
```

### 管理频道成员

#### 频道加人

用户加入频道分为两种方式：主动申请和频道成员邀请。邀请用户加入频道，详见 [创建频道](#create)。本节对用户申请加入频道进行详细介绍。

只有公开频道支持用户以申请方式加入，私有频道不支持。若申请加入公开频道，用户需执行以下步骤：

1. 用户可 [获取社区下的所有公开频道列表](#public)。

2. 调用 `joinChannel` 方法传入社区 ID 和频道 ID，申请加入对应频道。示例代码如下：

```java
   ChatClient.getInstance().chatCircleManager().joinChannel(serverId, mChannelId, new ValueCallBack<CircleChannel>() {
   @Override
   public void onSuccess(CircleChannel value) {
      
   }

   @Override
   public void onError(int code, String error) {

   }
});
```

3. 用户加入频道后可以在频道中发送和接收消息。

#### 退出频道

##### 频道成员主动退出频道

频道所有成员可调用 `leaveChannel` 方法退出频道。频道内的其他成员会收到 `onMemberLeftChannel` 回调。

退出频道的成员不会再收到频道消息。社区内的默认频道不允许成员主动退出。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().leaveChannel(serverId, mChannelId, new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {

   }
});
```

##### 频道成员被移出频道

仅频道所有者和管理员可以调用 `removeUserFromChannel` 方法将指定成员移出频道。被移出的频道的成员会收到 `onMemberRemovedFromChannel` 事件，其他成员会收到 `onMemberLeftChannel` 事件。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().removeUserFromChannel(serverId, mChannelId, inviteUserId, new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {

   }
});
```

#### 将成员加入频道禁言列表

社区所有者和社区管理员可以调用 `muteUserInChannel` 方法将频道成员加入禁言列表，禁言列表中的成员无法在频道中发送消息，但可以接收频道中的消息。被禁言的社区成员、社区所有者和管理员（除操作者外）会收到 `onMemberMuteChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().muteUserInChannel(serverId, mChannelId, muteUserId, 24*60*3600, new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {
      
   }
});
```

#### 将成员移出频道禁言列表

社区所有者和社区管理员可以将频道禁言列表上的频道成员移出频道禁言列表。被移出禁言列表的社区成员、社区所有者和管理员（除操作者外）会收到 `onMemberMuteChanged` 回调。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().unmuteUserInChannel(serverId, mChannelId, muteUserId, new CallBack() {
   @Override
   public void onSuccess() {
      
   }

   @Override
   public void onError(int code, String error) {

   }
});
```

#### 获取频道禁言列表

社区所有者和社区管理员可以获取频道下被禁言用户的列表。示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchChannelMuteUsers(serverId, mChannelId, new ValueCallBack<Map<String, Long>>() {
   @Override
   public void onSuccess(Map<String, Long> value) {
      //key 为用户 ID，value 为禁言时长。
   }

   @Override
   public void onError(int error, String errorMsg) {
      
   }
});
```

#### 获取指定频道的成员列表

频道中的成员可以获取该频道下的成员列表。示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchChannelMembers(serverId, mChannelId, 10, null, new ValueCallBack<CursorResult<CircleUser>>() {
   @Override
   public void onSuccess(CursorResult<CircleUser> value) {
      

   }

   @Override
   public void onError(int error, String errorMsg) {
      
   }
});
```

#### 查询当前用户是否在频道中

查询当前用户是否在指定频道中。示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().checkSelfIsInChannel(serverId, mChannelId, new ValueCallBack<Boolean>() {
   @Override
   public void onSuccess(Boolean value) {
      
   }

   @Override
   public void onError(int error, String errorMsg) {

   }
});
```

### 监听频道事件

#### 单设备登录监听事件

```java
CircleChannelListener channelListener = new CircleChannelListener() {

            //创建频道。参与创建的初始成员会收到该事件。
            @Override
            public void onChannelCreated(String serverId,String channelId, String creater) {
                
            }
            //解散频道。频道的所有成员（除操作者）会收到该事件。
            @Override
            public void onChannelDestroyed(String serverId,String channelId, String initiator) {
                
            }
            //更新频道。频道所有成员（除操作者外）会收到该事件。
            @Override
            public void onChannelUpdated(String serverId,String channelId,String channelName,String channelDesc, String initiator) {
                
            }
            //有用户加入频道。频道的所有成员会收到该事件。
            @Override
            public void onMemberJoinedChannel(String serverId,String channelId, String member) {
                
            }
            //用户收到频道加入邀请。受邀用户会收到该事件。
            @Override
            public void onReceiveInvitation(CircleChannelInviteInfo inviteInfo, String inviter) {

            }
            //用户同意频道加入邀请。邀请人会收到该事件。
            @Override
            public void onInvitationBeAccepted(String serverId,String channelId, String invitee) {

            }
            //用户拒绝频道加入邀请。邀请人会收到该事件。
            @Override
            public void onInvitationBeDeclined(String serverId,String channelId, String invitee) {
                
            }
            //有成员被移出频道。被移出的成员会收到该事件。
            @Override
            public void onMemberRemovedFromChannel(String serverId,String channelId, String memberRemoved, String initiator) {
                
            }
            //有成员主动退出频道。频道内的其他成员会收到该事件。
            @Override
            public void onMemberLeftChannel(String serverId,String channelId, String userExited) {
                
            }
            //有成员的禁言状态发生变化。禁言状态变更的成员、社区所有者和管理员（除操作者外）会收到该事件。
            @Override
            public void onMemberMuteChanged(String serverId,String channelId, boolean isMuted, List<String> muteMembers) {
                
            }
        };

        ChatClient.getInstance().chatCircleManager().addChannelListener(channelListener);
```

#### 多设备登录监听事件

```java
public void onCircleChannelEvent(int event, String channelId, List<String> usernames) {
            switch (event) {
                // 当前用户在其他设备上创建频道。
                case CHANNEL_CREATE:
                    break;
                // 当前用户在其他设备上删除频道。
                case CHANNEL_DELETE:
                    break;
                // 当前用户在其他设备上更新频道。
                case CHANNEL_UPDATE:
                    break;
                // 当前用户在其他设备上加入频道。
                case CHANNEL_JOIN:
                    break;
                // 当前用户在其他设备上接受加入频道的邀请。
                case CHANNEL_INVITATION_ACCEPT:
                    break;
                // 当前用户在其他设备上拒绝加入频道的邀请。
                case CHANNEL_INVITATION_DECLINE:
                    break;
                // 当前用户在其他设备上退出频道。
                case CHANNEL_LEAVE:
                    break;
                // 当前用户在其他设备上从频道中移除成员。
                case CIRCLE_CHANNEL_REMOVE_USER:
                    break;
                // 当前用户在其他设备上邀请用户加入频道。
                case CIRCLE_CHANNEL_INVITE_USER:
                    break;
                // 当前用户在其他设备上禁言频道成员。
                case CIRCLE_CHANNEL_MEMBER_ADD_MUTE:
                    break;
                // 当前用户在其他设备上解除对频道成员的禁言。
                case CIRCLE_CHANNEL_MEMBER_REMOVE_MUTE:
                    break;
            }
        }

    }
```