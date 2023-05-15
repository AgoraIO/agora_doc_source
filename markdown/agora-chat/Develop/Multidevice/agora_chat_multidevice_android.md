# 在多个设备上登录

即时通讯 IM 支持同一账号在多个设备上登录，所有已登录的设备同步以下信息和操作：

- 在线消息、离线消息、推送通知（若开启了第三方推送服务，离线设备收到）以及对应的回执和已读状态；
- 好友和群组相关操作。

即时通讯 IM 默认最多支持 4 个设备同时在线，详见[即时通讯 IM 计费说明](./agora_chat_pricing)。如需增加支持的设备数量，可以联系 [sales@agora.io](mailto:sales@agora.io)。

## 技术原理  

Android SDK 初始化时会生成登录 ID 用于在多设备登录和消息推送时识别设备，并将该 ID 发送到服务器。服务器会自动将新消息发送到用户登录的设备，可以自动监听到其他设备上进行的好友或群组操作。即时通讯 IM Android SDK 提供以下功能实现多个设备之间的同步：

- 获取其他登录设备的设备 ID；
- 获取其他设备上的好友或者群组操作。

## 前提条件

开始前，需确保完成 SDK 初始化，并连接到服务器。详见[快速开始](./agora_chat_get_started_android)。

## 实现方法

### 获取其他已登录设备的登录 ID 列表并向这些设备发送消息

你可以调用 `getSelfIdsOnOtherPlatform` 方法获取其他登录设备的登录 ID 列表。选择目标登录 ID 作为消息接收方发出消息，则这些设备上的同一登录账号可以收到消息，实现不同设备之间的消息同步。

```java
// 同步方法，会阻塞当前线程。异步方法为 asyncGetSelfIdsOnOtherPlatform(ValueCallBack)。
List<String> ids = ChatClient.getInstance().contactManager().getSelfIdsOnOtherPlatform();
// 选择一个登录 ID 作为消息发送方。
String toChatUsername = ids.get(0);
// 创建一条文本消息，content 为消息文字内容，toChatUsername 传入登录 ID 作为消息发送方。
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername); 
// 发送消息。
ChatClient.getInstance().chatManager().sendMessage(message); 
```

### 强制账号从单个设备下线

```java
// username：账户名称，password：账户密码。需要在异步线程中执行。
List<DeviceInfo> deviceInfos = ChatClient.getInstance().getLoggedInDevicesFromServer(username, password);
// username：账户名称，password：账户密码, resource：设备 ID。需要在异步线程中执行。
ChatClient.getInstance().kickDevice(username, password, deviceInfos.get(selectedIndex).getResource());
```

### 获取其他设备的好友或者群组操作

例如，账号 A 同时在设备 A 和 B 上登录，账号 A 在设备 A 上进行操作，设备 B 会收到这些操作对应的通知。

你需要先实现 `MultiDeviceListener` 类监听其他设备上的操作，然后调用 `addMultiDeviceListener` 方法添加多设备监听。

```java
//实现 `MultiDeviceListener` 监听其他设备上的操作。
private class ChatMultiDeviceListener implements MultiDeviceListener {
//@param event 事件。
    @Override
    //@param target 好友的用户 ID； @param ext 事件扩展信息。
    public void onContactEvent(int event, String target, String ext) {
        EMLog.i(TAG, "onContactEvent event"+event);
        DemoDbHelper dbHelper = DemoDbHelper.getInstance(DemoApplication.getInstance());
        String message = null;
        switch (event) {
            //好友已在其他设备上被移除。
            case CONTACT_REMOVE: 
                break;
            //好友请求已在其他设备上同意。
            case CONTACT_ACCEPT:
                break;
            //好友请求已在其他设备上被拒绝。  
            case CONTACT_DECLINE: 
                break;
            //当前用户在其他设备将某个用户添加至黑名单。                   
            case CONTACT_BAN: 
                break;
            // 用户在其他设备被移出黑名单。                   
            case CONTACT_ALLOW:
                break; 
        }
    }

    @Override
    public void onGroupEvent(int event, String groupId, List<String> usernames) {
        EMLog.i(TAG, "onGroupEvent event"+event);
        String message = null;
        switch (event) {
            //当前⽤户在其他设备创建了群组。
            case GROUP_CREATE:
                break;
            //当前⽤户在其他设备销毁了群组。
            case GROUP_DESTROY:
                break;
            //当前⽤户在其他设备加⼊了群组。
            case GROUP_JOIN:
                break;
            //当前⽤户在其他设备离开了群组。
            case GROUP_LEAVE:
                break;
            //当前⽤户在其他设备发起了入群申请。
            case GROUP_APPLY:
                break;
            //当前⽤户在其他设备同意了入群申请。
            case GROUP_APPLY_ACCEPT:
                break;
            //当前⽤户在其他设备拒绝了入群申请。
            case GROUP_APPLY_DECLINE:
                break;
            //当前⽤户在其他设备邀请了群成员。
            case GROUP_INVITE:
                break;
            //当前⽤户在其他设备同意了入群邀请。
            case GROUP_INVITE_ACCEPT:
                break;
            //当前⽤户在其他设备拒绝了入群邀请。
            case GROUP_INVITE_DECLINE:
                break;
            //当前⽤户在其他设备将成员踢出群。
            case GROUP_KICK:
                break;
            //当前⽤户在其他设备将成员加⼊群组⿊名单。
            case GROUP_BAN:
                break;
            //当前⽤户在其他设备将成员移除群组⿊名单。
            case GROUP_ALLOW:
                break;
            //当前⽤户在其他设备屏蔽了群组。
            case GROUP_BLOCK:
                break;
            //当前⽤户在其他设备取消群组屏蔽。
            case GROUP_UNBLOCK:
                break;
            //当前⽤户在其他设备转移群所有权。
            case GROUP_ASSIGN_OWNER:
                break;
            //当前⽤户在其他设备添加管理员。
            case GROUP_ADD_ADMIN:
                break;
            //当前⽤户在其他设备移除管理员。
            case GROUP_REMOVE_ADMIN:
                break;
            //当前⽤户在其他设备禁⾔⽤户。
            case GROUP_ADD_MUTE:
                break;
            //当前⽤户在其他设备移除禁⾔。
            case GROUP_REMOVE_MUTE:
                break;
            //当前⽤户在其他设备设置了群成员自定义属性。
            case GROUP_METADATA_CHANGED:
                break;    
            default:
                break;
        }
    }

    @Override
    // 当前用户在其他设备上单向删除服务端的历史消息。
    public void onMessageRemoved(String conversation, String deviceId) {            
    }    
}

ChatMultiDeviceListener chatMultiDeviceListener = new ChatMultiDeviceListener();

//设置多设备监听。
ChatClient.getInstance().addMultiDeviceListener(chatMultiDeviceListener);

//移除多设备监听。
ChatClient.getInstance().removeMultiDeviceListener(chatMultiDeviceListener);
```

### 典型示例

当 PC 端和移动端登录同一个账号时，在移动端可以通过调用方法获取到 PC 端的登录 ID。该登录 ID 相当于特殊的好友用户 ID，可以直接使用于聊天，使用方法与好友的用户 ID 类似。

```java
List<String> selfIds = ChatClient.getInstance().contactManager().getSelfIdsOnOtherPlatform();
```