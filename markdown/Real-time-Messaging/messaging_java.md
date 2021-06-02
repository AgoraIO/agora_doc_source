---
title: 发送和接收点对点消息及频道消息
platform: Android
updatedAt: 2021-03-02 02:30:45
---
# 01 集成客户端

本文介绍在正式使用 Agora RTM SDK for Java 进行实时消息通讯前，需要准备的开发环境，包含前提条件及 SDK 集成方法等内容。

### 前提条件

请确保满足一下开发环境要求：

- 物理或虚拟, Ubuntu Linux 14.04 LTS 64 位 及以上

下载的文件包括 libs 文件和 sample 文件，其中 libs 文件包括：


### 创建 Agora 账号并获取 App ID

1. 进入 <https://dashboard.agora.io/> ，按照屏幕提示创建一个开发者账号。
2. 登录 Dashboard 页面，点击添加新项目。
3. 填写项目名， 然后点击提交 。
4. 在你创建的项目下，查看并获取该项目对应的App ID。

### 添加 SDK

将 AppID 填写进 RtmJavaDemo.java 中的 APPID.APP_ID

```java
public static final String APP_ID = "<#YOUR APP ID#>";
```

- 第1步: 在 Agora.io SDK 下载 RTM SDK，解压后将其中的 libs 文件夹下的 *.jar, *.so 复制到本项目的 lib/ 下
- 第2步: 如果没有maven环境，需要安装apache-maven-3.6.0
- 第2步: 将demo依赖的jar包安装到本地maven仓库, mvn install:install-file -Dfile=lib/agora_rtm.jar -DgroupId=io.agora.rtm -DartifactId=agora-rtm-sdk -Dversion=1.0 -Dpackaging=jar
- 第3步: 使用maven编译打包, 在pom.xml所在目录运行 “mvn package”

## 运行Demo

第4步: 运行Demo, “java -cp target/RTM-Client-Demo-1.0-SNAPSHOT.jar -Dsun.boot.library.path=lib/ io.agora.mainClass.RtmJavaDemo”

# 02 初始化

在创建实例前，请确保你已完成环境准备，安装包获取等步骤。

创建实例需要填入准备好的APP_ID, 只有APP_ID相同的应用才能互通。


指定一个事件回调，SDK通过回调通知应用程序SDK 的状态变化和运行事件等，如连接状态变化，消息接收等。

```java
import io.agora.rtm.ErrorInfo;
import io.agora.rtm.ResultCallback;
import io.agora.rtm.RtmChannel;
import io.agora.rtm.RtmChannelListener;
import io.agora.rtm.RtmChannelMember;
import io.agora.rtm.RtmClient;
import io.agora.rtm.RtmClientListener;
import io.agora.rtm.RtmMessage;
...
    
class ChannelListener implements RtmChannelListener {
    private String channel_;
    public ChannelListener(String channel) {
            channel_ = channel;
    }
    @Override
    public void onMessageReceived(
            final RtmMessage message, final RtmChannelMember fromMember) {
        String account = fromMember.getUserId();
        String msg = message.getText();
        System.out.println("Receive message from channel: " + channel_ +
        " member: " + account + " message: " + msg);
    }

    @Override
    public void onMemberJoined(RtmChannelMember member) {
        String account = member.getUserId();
        System.out.println("member " + account + " joined the channel "
                          + channel_);
    }

    @Override
    public void onMemberLeft(RtmChannelMember member) {
        String account = member.getUserId();
        System.out.println("member " + account + " lefted the channel "
                         + channel_);
    }
}

    public void init() {
        try {
            mRtmClient = RtmClient.createInstance(APPID.APP_ID,
                            new RtmClientListener() {
                @Override
                public void onConnectionStateChanged(int state, int reason) {
                    System.out.println("on connection state changed to "
                        + state + " reason: " + reason);
                }

                @Override
                public void onMessageReceived(RtmMessage rtmMessage, String peerId) {
                    String msg = rtmMessage.getText();
                    System.out.println("Receive message: " + msg 
                                + " from " + peerId);
                }
            });
        } catch (Exception e) {
            System.out.println("Rtm sdk init fatal error!");
            throw new RuntimeException("Need to check rtm sdk init process");
        }
    }
```



### 注意事项

RTM 支持多实例， 每个实例独立工作互不干扰，多个实例创建时可以用相同的context，事件回调须是不同的实例。


当实例不再使用的时，可以调用实例的release()方法释放资源。

# 03 登录

APP 必须在登录RTM服务器之后，才可以使用RTM的点对点消息和群聊功能，在此之前，请确保RTM client初始化完成。

登录实现方法

- 传入能标识用户角色和权限的 Token。如果安全要求不高，也可以将值设为 null。Token 需要在应用程序的服务器端生成，具体生成办法，详见密钥说明。
- 传入能标识每个用户账号的 ID。ID 为字符串，必须是可见字符（可以带空格），不能为空或者多于64个字符，也不能是字符串 “null“。
- 传入结果回调，用于接收登录 RTM 服务器成功或者失败的结果回调。

```java
        mRtmClient.login(null, userId, new ResultCallback<Void>() {
            @Override
            public void onSuccess(Void responseInfo) {
                loginStatus = true;
                System.out.println("login success!");
            }
            @Override
            public void onFailure(ErrorInfo errorInfo) {
                loginStatus = false;
                System.out.println("login failure!");
            }
        });

```

如果需要退出登录，可以调用 logout 方法，退出登录之后可以调用 login 重新登录或者切换账号。

```java
mRtmClient.logout(null);
```

# 04 点对点消息

pp 在成功登录 RTM 服务器之后，可以开始使用 RTM 的点对点消息功能。


### 实现方法

#### 发送点对点消息

调用 sendMessageToPeer 方法发送点对点消息。在该方法中：

- 传入目标消息接收方的用户账号 ID。
- 传入 RtmMessage 对象实例。该消息对象由 RtmClient 类的的 createMessage 实例方法创建，并使用消息实例的 setText 方法设置消息内容。
- 传入消息发送结果监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时，对方不可达等。

```java
    public void sendPeerMessage(String dst, String message) {
        RtmMessage msg = mRtmClient.createMessage();
        msg.setText(message);

        mRtmClient.sendMessageToPeer(dst, msg, new ResultCallback<Void>() {
            @Override
            public void onSuccess(Void aVoid) {
            }

            @Override
            public void onFailure(ErrorInfo errorInfo) {
                final int errorCode = errorInfo.getErrorCode();
                System.out.println("Send Message to peer failed, errorCode = "
                                + errorCode);
            }
        });
    }

```

#### 接收点对点消息

点对点消息的接收通过[创建 RtmClient 实例](https://confluence.agora.io/pages/viewpage.action?pageId=628998170)的时候传入的 RtmClientListener 回调接口进行监听。在该回调接口的 onMessageReceived(RtmMessage message, String peerId) 回调方法中：

- 通过 message.getText() 方法可以获取到消息文本内容。
- peerId 是消息发送方的用户账号 ID。


### 注意事项

- 接收到的 RtmMessage 消息对象不能重复利用再用于发送。

# 05 群聊

App 在成功登录RTM服务器 之后，可以开始使用 RTM 的群聊功能。

## 实现方法

### 创建加入频道实例

- 传入能标识每个频道的 ID。ID 为字符串，必须是可见字符（可以带空格），不能为空或者多于64个字符，也不能是字符串 “null“。  
- 指定一个事件回调。SDK 通过回调通知应用程序频道的状态变化和运行事件等，如: 接收到频道消息、用户加入和退出频道等。


```java
        mRtmChannel = mRtmClient.createChannel(channel,
                            new ChannelListener(channel));
        if (mRtmChannel == null) {
            System.out.println("channel created failed!");
            return;
        }
        mRtmChannel.join(new ResultCallback<Void>() {
            @Override
            public void onSuccess(Void responseInfo) {
                System.out.println("join channel success!");
            }

            @Override
            public void onFailure(ErrorInfo errorInfo) {
                System.out.println("join channel failure! errorCode = "
                                    + errorInfo.getErrorCode());
            }
        });
```

### 发送频道消息

在成功加入频道之后，用户可以开始向该频道发送消息。

调用 实例的 发送 方法向该频道发送消息。在该方法中：

- 传入 RtmMessage 对象实例。该消息对象由 RtmClient 类的 createMessage 实例方法创建，并使用消息实例的 setText 方法设置消息内容。
- 传入消息发送结果监听器，用于接收消息发送结果回调，如：服务器已接收，发送超时等。


```java
    public void sendChannelMessage(String msg) {
        RtmMessage message = mRtmClient.createMessage();
        message.setText(msg);

        mRtmChannel.sendMessage(message, new ResultCallback<Void>() {
            @Override
            public void onSuccess(Void aVoid) {
            }

            @Override
            public void onFailure(ErrorInfo errorInfo) {
            }
        });
    }
```

### 接收频道消息

频道消息的接收通过创建频道消息的时候传入的 回调接口进行监听（参考“创建频道实例”当中的代码）。

### 获取频道成员列表

调用实例的 getMembers 方法可以获取到当前在该频道内的用户列表。 


```java
    public void getChannelMemberList() {
        mRtmChannel.getMembers(new ResultCallback<List<RtmChannelMember>>() {
            @Override
            public void onSuccess(final List<RtmChannelMember> responseInfo) {
            }
            @Override
            public void onFailure(ErrorInfo errorInfo) {
            }
        });
    }
```

### 退出频道

调用实例的 leave 方法可以退出该频道。退出频道之后可以调用 join 方法再重新加入频道。

## 注意事项

- 每个客户端都需要首先调用创建channel方法创建频道实例才能使用群聊功能，该实例只是本地的一个类对象实例。
- RTM 支持同时创建多个不同的频道实例并加入到多个频道中，但是每个频道实例必须使用不同的频道 ID 以及不同的回调。
- 如果频道 ID 非法，或者具有相同 ID 的频道实例已经在本地创建，createChannel 将返回 null。
- 接收到的 RtmMessage 消息对象不能重复利用再用于发送。
- 当离开了频道且不再加入该频道时，可以调用 RtmChannel 实例的 release 方法及时释放频道实例所占用的资源。
- 所有回调如无特别说明，除了基本的参数合法性检查失败触发的回调，均为异步调用。

# 06 发送和接受呼叫邀请
在登陆 Agora RTM 系统后可以发送和接收呼叫邀请

## 获取 RtmCallManager

每个 RtmClient 只有一个 RtmCallManager 对象。

```
   RtmCallManager rtmCallMgr = rtmClient.getRtmCallManager();
```

## 设置回调(呼叫接受的状态都可以通过这里的回调方法得到)

```
   rtmCallMgr.setEventListener(new RtmCallEventListener() { ... });
```

## 创建呼叫邀请

```
   LocalInvitation rtmLocalInvitation = rtmCallMgr.createLocalInvitation(calleeId);
```

## 发送呼叫邀请

```
   rtmCallMgr.sendLocalInvitation(rtmLocalInvitation, new MyResultCallback());
```

## 取消呼叫邀请

```
   rtmCallMgr.cancelLocalInvitation(rtmLocalInvitation, new MyResultCallback());
```

## 接受呼叫邀请

```
   rtmCallMgr.acceptRemoteInvitation(rtmRemoteInvitation, new MyResultCallback());
```

## 拒绝呼叫邀请

```
   rtmCallMgr.refuseRemoteInvitation(rtmRemoteInvitation, new MyResultCallback());
```