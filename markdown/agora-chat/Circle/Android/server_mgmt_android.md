# 管理社区

社区（Server）是一群有着共同兴趣爱好的人的专属天地，也可以是同学朋友的社交圈子。社区是环信圈子三层基础架构的最上层，各种消息事件均发生在社区内。任何用户均可以自由加入或退出社区，无需审批。

## 技术原理

环信即时通讯 IM Android SDK 提供 `io.agora.chat.CircleManager` 类用于社区管理，支持你通过调用 API 在项目中实现如下功能：

- 创建和管理社区；
- 管理社区成员；
- 监听社区事件。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 1.0.8 初始化，详见 [Android 快速开始](./agora_chat_get_started_ios?platform=Android)；
- 了解环信即时通讯 IM 的使用限制，详见 详见 [限制条件](./agora_chat_limitation?platform=Android)。

## 实现方法

### 创建和管理社区

#### <a name="create"></a>创建社区

可创建社区数量根据套餐版本有所不同。每个用户最多可创建 100 个社区，超过该阈值需要联系 [support@agora.io] 调整。

1. 调用 `createServer` 方法创建社区。

示例代码如下：

```java
  CircleServerAttribute serverAttribute = new CircleServerAttribute();
    serverAttribute.setName("name");
    serverAttribute.setIcon("iconUrl");
    serverAttribute.setDesc("环信社区circle聚集地");
    serverAttribute.setExt("");
                
  ChatClient.getInstance().chatCircleManager().createServer(serverAttribute, new ValueCallBack<CircleServer>() {
      @Override
      public void onSuccess(CircleServer value) {
          
      }

      @Override
      public void onError(int error, String errorMsg) {
          
      }
  });

```
创建社区时，需设置社区属性 `CircleServerAttribute`，如下表所示。

| 参数 | 类型        | 描述                 |
| :--------- | :----------------------- | :------------------ |
| name    | String     | 社区名称。          |
| icon    | String     | 社区图标。          |
| desc    | String     | 社区描述。          |
| ext    | String     | 社区扩展字段。         |

2. 邀请用户加入社区。

社区创建者调用 `inviteUserToServer` 方法邀请用户加入社区。受邀用户会收到 `io.agora.CircleServerListener#onReceiveInvitation` 事件。

示例代码如下：

```java
  ChatClient.getInstance().chatCircleManager().inviteUserToServer(serverId, inviteUserId, "欢迎加入server", new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});

```

3. 用户确认是否加入社区。

- 若同意加入社区，调用 `acceptServerInvitation` 方法。邀请人收到 `io.agora.CircleServerListener#onInvitationBeAccepted` 事件，社区内所有成员（不包括加入社区的该新成员）收到 `io.agora.CircleServerListener#onMemberJoinedServer` 事件。示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().acceptServerInvitation(serverId,inviterID, new ValueCallBack<CircleServer>() {
    @Override
    public void onSuccess(CircleServer circleServer) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

- 若拒绝加入社区，调用 `declineServerInvitation` 方法。邀请人收到 `io.agora.CircleServerListener#onInvitationBeDeclined` 事件。
示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().declineServerInvitation(serverId,inviterID, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 修改社区信息

社区所有者和管理员可调用 `updateServer` 方法修改社区基本信息。社区信息修改后，除操作者外的社区所有成员会收到 `io.agora.CircleServerListener#onServerUpdated` 事件。

示例代码如下：

```java
CircleServerAttribute serverAttribute = new CircleServerAttribute();
                serverAttribute.setName("name");
                serverAttribute.setIcon("iconUrl");
                serverAttribute.setDesc("update desc");
                serverAttribute.setExt("");
ChatClient.getInstance().chatCircleManager().updateServer(serverId, serverAttribute, new ValueCallBack<CircleServer>() {
    @Override
    public void onSuccess(CircleServer circleServer) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 添加社区标签

社区所有者和管理员可以调用 `addTagsToServer` 方法为社区添加标签。非社区内用户可以通过搜索标签全名查找社区。每个社区最多可添加 10 个标签。

示例代码如下：

```java
String tag = "动漫";
ArrayList<String> tags = new ArrayList<>();
tags.add(tag);

ChatClient.getInstance().chatCircleManager().addTagsToServer(serverId, tags, new ValueCallBack<List<CircleTag>>() {
    @Override
    public void onSuccess(List<CircleTag> tags) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 移除社区标签

社区所有者和管理员可以调用 `removeTagsFromServer` 方法移除社区已有标签。

示例代码如下：

```java
ArrayList<String> tagsRemoved = new ArrayList<>();
tagsRemoved.add("你要移除的tagId");
ChatClient.getInstance().chatCircleManager().removeTagsFromServer(serverId, tagsRemoved, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 解散社区

仅社区所有者可调用 `destroyServer` 方法解散社区。解散社区后将删除本地的社区数据，除社区所有者外的社区所有成员会收到 `io.agora.CircleServerListener#onServerDestroyed` 事件并被移出社区。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().destroyServer(serverId, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int code, String error) {
        
    }
});
```

#### 获取社区详情

社区成员可以调用 `fetchServerDetail` 方法获取社区的详情。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchServerDetail(serverId, new ValueCallBack<CircleServer>() {
    @Override
    public void onSuccess(CircleServer value) {
      
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 获取已加入社区

用户可以调用 `fetchJoinedServers` 方法获取已加入的社区列表。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchJoinedServers(20, null, new ValueCallBack<CursorResult<CircleServer>>() {
    @Override
    public void onSuccess(CursorResult<CircleServer> value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 分页获取社区成员列表

社区成员可以调用 `fetchServerMembers` 方法分页获取指定社区中的成员列表。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchServerMembers(serverId, 20, null, new ValueCallBack<CursorResult<CircleUser>>() {
    @Override
    public void onSuccess(CursorResult<CircleUser> value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
      
    }
});
```

### 管理社区成员

#### 加入社区

每个用户最多加入 100 个社区，超过需要联系商务。用户可以通过以下两种方式加入社区：

1. 搜索社区名称和标签（同时支持 REST 通过社区 ID 搜索），主动申请加入社区。

2. 社区内成员邀请用户加入。

通过邀请加入频道，详见[创建社区](#create)。下面介绍用户如何申请加入社区。

1. 用户可以调用 `fetchServersWithKeyword` 方法根据社区名称和标签名称搜索社区。

目前所有社区都为公开，任何用户都可以搜索到。

示例代码如下：

```java
String keyWord="动漫";
ChatClient.getInstance().chatCircleManager().fetchServersWithKeyword(keyWord, new ValueCallBack<List<CircleServer>>() {
    @Override
    public void onSuccess(List<CircleServer> value) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
      
    }
});
```

2. 用户调用 `joinServer` 方法加入社区。加入成功后，社区内其他成员收到 `io.agora.CircleServerListener#onMemberJoinedServer`事件。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().joinServer(serverId, new ValueCallBack<CircleServer>() {
    @Override
    public void onSuccess(CircleServer circleServer) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 退出社区

社区所有者不支持退出社区操作，只能解散社区。

退出社区分为主动退出和被动退出，被动退出即为被社区所有者或管理员踢出社区。

##### 用户主动退出社区

用户可调用 `leaveServer` 方法退出社区。社区其他成员会收到 `io.agora.CircleServerListener#onMemberLeftServer` 事件。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().leaveServer(serverId, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```
##### 用户被踢出社区

社区所有者和管理员调用 `removeUserFromServer` 方法将普通成员踢出社区，管理员只能被社区所有者踢出社区。被踢出社区的成员、社区所有者和管理员（除操作者外）会收到 `io.agora.CircleServerListener#onMemberRemovedFromServer` 事件。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().removeUserFromServer(serverId, inviteUserId, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 查询当前用户是否在社区内

用户可调用 `checkSelfIsInServer` 方法查询自己是否已经加入了指定社区。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().checkSelfIsInServer(serverId, new ValueCallBack<Boolean>() {
    @Override
    public void onSuccess(Boolean isInServer) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 查询当前用户在社区里的角色

用户可调用 `fetchSelfServerRole` 方法查询当前用户在社区中的角色。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().fetchSelfServerRole(serverId, new ValueCallBack<CircleUserRole>() {
    @Override
    public void onSuccess(CircleUserRole role) {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 设置社区管理员

仅社区所有者可以调用 `addModeratorToServer` 方法设置社区管理员。成功设置后，除社区所有者之外的其他社区成员会收到 `io.agora.CircleServerListener#onRoleAssigned` 事件。

社区管理员除了不能解散社区等少数权限外，拥有对社区的绝大部分权限。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().addModeratorToServer(serverId, userID, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

#### 移除社区管理员

仅社区所有者可以调用 `removeModeratorFromServer` 方法移除社区管理员。成功移除后，除社区所有者之外的其他社区成员会收到 `io.agora.CircleServerListener#onRoleAssigned` 事件。

若社区管理员被移除管理员权限后，将只拥有社区普通成员的权限。

示例代码如下：

```java
ChatClient.getInstance().chatCircleManager().removeModeratorFromServer(serverId, inviteUserId, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int error, String errorMsg) {
        
    }
});
```

### 监听社区事件

#### 单设备登录监听事件

```java
CircleServerListener circleServerListener = new CircleServerListener() {
    //社区被解散。社区所有成员（除社区所有者外）会收到该事件。
    @Override
    public void onServerDestroyed(String serverId, String initiator) {
        
    }
    //社区信息更新。社区所有成员（除操作者外）会收到该事件。
    @Override
    public void onServerUpdated(CircleServerEvent event) {
        
    }
    //有用户加入社区。社区所有成员（除加入社区的新成员外）会收到该事件。
    @Override
    public void onMemberJoinedServer(String serverId, String member) {
        
    }
    //有成员主动退出社区。社区所有者和管理员会收到该事件。
    @Override
    public void onMemberLeftServer(String serverId, String member) {
        
    }
    //有成员被移出社区。被移除者、社区所有者和管理员（除操作者外）会收到该事件。
    @Override
    public void onMemberRemovedFromServer(String serverId, List<String> members) {
        
    }
    //用户收到社区加入邀请。受邀用户会收到该事件。
    @Override
    public void onReceiveInvitation(CircleServerEvent event, String inviter) {
        
    }
    //用户同意社区加入邀请。邀请人会收到该事件。
    @Override
    public void onInvitationBeAccepted(String serverId, String invitee) {
        
    }
    //用户拒绝社区加入邀请。邀请人会收到该事件。
    @Override
    public void onInvitationBeDeclined(String serverId, String invitee) {
        
    }
    //社区成员的角色发生变化。社区所有成员（除操作者外）会收到该事件。
    @Override
    public void onRoleAssigned(String serverId, String member, CircleUserRole role) {
        
    }
};

ChatClient.getInstance().chatCircleManager().addServerListener(circleServerListener);

```

#### 多设备登录监听事件

```java
public void onCircleServerEvent(int event, String serverId, List<String> usernames) {
            switch (event) {
                //当前用户在其他设备上创建社区。
                case SERVER_CREATE:
                    break;
                // 当前用户在其他设备上删除社区。
                case SERVER_DELETE:
                    break;
                // 当前用户在其他设备上更新社区。
                case SERVER_UPDATE:
                    break;
                // 当前用户在其他设备上加入社区。
                case SERVER_JOIN:
                    break;
                // 当前用户在其他设备上退出社区。
                case SERVER_LEAVE:
                    break;
                // 当前用户在其他设备上接受加入社区的邀请。
                case SERVER_INVITE_ACCEPT:
                    break;
                // 当前用户在其他设备上拒绝加入社区的邀请。
                case SERVER_INVITE_DECLINE:
                    break;
                // 当前用户在其他设备上为用户设置社区角色。
                case CIRCLE_SERVER_SET_ROLE:
                    break;
                // 当前设备在其他设备上从社区中移除成员。
                case CIRCLE_SERVER_REMOVE_USER:
                    break;
                // 当前设备在其他设备上邀请其他用户加入社区。
                case CIRCLE_SERVER_INVITE_USER:
                    break;
            }
        }

```
