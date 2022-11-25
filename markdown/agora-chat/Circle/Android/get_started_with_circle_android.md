# 环信超级社区（Circle）快速开始

## 集成准备

使用环信超级社区（Circle）之前，确保你已经集成即时通讯 IM Android SDK 1.0.8，详见 [即时通讯 IM Android 快速开始](./agora_chat_get_started_android?platform=Android)。

## 技术原理

用户需加入一个社区，选择加入社区中的频道，然后才能在频道中发送消息。

发送和接收消息的逻辑如下：

1. 发送方获取社区 ID；
2. 发送方获取频道 ID；
3. 发送方通过 `sendMessage` 发送消息；
4. 接收方通过 `MessageListener` 注册监听器接收各类消息的回调。

## 实现方法

### 获取 CircleManager

```java
CircleManager circleManager = ChatClient.getInstance().chatCircleManager();
```

### 获取指定的社区

你可以通过三种方式获取指定的社区 ID：

- 创建社区；
- 加入一个现有社区；
- 获取已加入的社区列表。

#### 创建社区

你可以调用 `CircleServerAttribute()` 方法创建一个社区：

```java
CircleServerAttribute serverAttribute=new CircleServerAttribute();
                serverAttribute.setName("server name");
                serverAttribute.setIcon(testImg);
                serverAttribute.setDesc("desc");
                serverAttribute.setExt("");
                circleManager.createServer(serverAttribute, new ValueCallBack<CircleServer>() {
                            @Override
                            public void onSuccess(CircleServer value) {
                                serverId = value.getServerId();
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.e(TAG, "回调 onSuccess,serverId=" + value.getServerId());
                                    }
                                });
                            }

                            @Override
                            public void onError(int error, String errorMsg) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Log.e(TAG, "回调 onError,error=" + error + ",errorMsg="+errorMsg);
                                    }
                                });
                            }
                        });
```

#### 加入一个现有社区

你可以调用 `joinServer` 方法加入一个现有社区：

```java
circleManager.joinServer(serverId, new ValueCallBack<CircleServer>() {
                    @Override
                    public void onSuccess(CircleServer circleServer) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.e(TAG, "  回调 joinToServer->onSuccess,serverId=" + circleServer.getServerId());
                            }
                        });
                    }

                    @Override
                    public void onError(int error, String errorMsg) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.e(TAG, "回调onError,error=" + error + ",errorMsg=" + errorMsg);
                            }
                        });
                    }
                });
```

#### 获取已加入的社区列表

你可以调用 `fetchJoinedServers` 方法获取已加入的社区列表：

```java
circleManager.fetchJoinedServers( 10, null, new ValueCallBack<CursorResult<CircleServer>>() {
                    @Override
                    public void onSuccess(CursorResult<CircleServer> value) {
                        List<CircleServer> datas = value.getData();
                        StringBuilder builder = new StringBuilder();
                        for (int i = 0; i < datas.size(); i++) {
                            String serverId = datas.get(i).getServerId();
                            builder.append("\nserverid=" + serverId);
                        }
                        Log.e(TAG, "回调 queryJoinedServers()->onSuccess " + ",serverIds=" + builder.toString());
                    }

                    @Override
                    public void onError(int error, String errorMsg) {
                        Log.e(TAG, "回调 onError,error=" + error + ",errorMsg=" + errorMsg);
                    }
                });
```

### 获取指定的频道

你可以通过三种方式获取指定的频道 ID：

- 创建频道；
- 加入一个现有频道；
- 获取已加入的频道列表。

#### 创建频道

你可以调用 `createChannel` 方法创建频道：

```java
CircleChannelAttribute channelAttribute1=new CircleChannelAttribute();
                channelAttribute1.setName("channel-name");
                channelAttribute1.setDesc("channel-desc");
                channelAttribute1.setExt("custom");
                circleManager.createChannel(serverId, channelAttribute1, CircleChannelStyle.EMChannelStylePublic, new ValueCallBack<CircleChannel>() {

                    @Override
                    public void onSuccess(CircleChannel value) {
                        Log.e(TAG, "回调 createChannel()->onSuccess " + ",channelId=" + value.getChannelId() + ",name=" + value.getName() + ",custom=" + value.getExt());
                    }

                    @Override
                    public void onError(int code, String errorMsg) {
                        Log.e(TAG, "回调 createChannel()->onError,code=" + code + ",errorMsg=" + errorMsg);
                    }
                });
```

#### 加入一个现有频道

你可以调用 `joinToChannel` 方法加入频道：

```java
circleManager.joinToChannel(serverId, mChannelId, new ValueCallBack<CircleChannel>() {
                    @Override
                    public void onSuccess(CircleChannel circleChannel) {
                        Log.e(TAG, "回调 joinToChannel()-> onSuccess,circleChannel="+circleChannel.getChannelId());
                    }

                    @Override
                    public void onError(int code, String error) {
                        Log.e(TAG, "回调 joinToChannel()->onError,code=" + code + ",errorMsg=" + error);

                    }
                });
```

#### 获取已加入的公开频道列表

你可以调用 `fetchPublicChannels` 方法获取已加入的公开频道列表：

```java
circleManager.fetchPublicChannels(serverId, 10, null, new ValueCallBack<CursorResult<CircleChannel>>() {
                    @Override
                    public void onSuccess(CursorResult<CircleChannel> value) {
                        List<CircleChannel> datas = value.getData();
                        StringBuilder builder = new StringBuilder();
                        for (int i = 0; i < datas.size(); i++) {
                            String channelId = datas.get(i).getChannelId();
                            builder.append("\nchannelid=" + channelId);
                        }
                        Log.e(TAG, "回调 queryPublicChannelsInServer()->onSuccess "  + ",channelIds=" + builder.toString());

                    }

                    @Override
                    public void onError(int error, String errorMsg) {
                        Log.e(TAG, "回调 queryPublicChannelsInServer()->onError,code=" + error + ",errorMsg=" + errorMsg);
                    }
                });
```

#### 获取社区中当前用户可见的私有频道列表

社区中的普通成员只能获取到自己加入的私有频道，而社区所有者和管理员可以获取全部的私有频道。

```java
int limit=10;
                circleManager.fetchVisiblePrivateChannels(serverId, limit, null, new ValueCallBack<CursorResult<CircleChannel>>() {
                    @Override
                    public void onSuccess(CursorResult<CircleChannel> value) {
                        List<CircleChannel> datas = value.getData();
                        StringBuilder builder = new StringBuilder();
                        for (int i = 0; i < datas.size(); i++) {
                            String channelId = datas.get(i).getChannelId();
                            builder.append("\nchannelid=" + channelId);
                        }
                        Log.e(TAG, "回调 queryVisiblePrivateChannelsInServer()->onSuccess "  + ",channelIds=" + builder.toString());
                    }

                    @Override
                    public void onError(int error, String errorMsg) {
                        Log.e(TAG, "回调 queryVisiblePrivateChannelsInServer()->onError,code=" + error + ",errorMsg=" + errorMsg);
                    }
                });
```

### 发送和接收一条频道消息

在频道中发送和接收消息，你可以参考 [发送和接收消息](./agora_chat_manage_message_android?platform=Android)。

#### 发送一条频道消息

你可以调用 `createTxtSendMessage` 方法在指定频道中发送一条文本消息：

```java
// 创建一条文本消息，`content` 为消息文字内容，`channelID` 为频道 ID
ChatMessage message = ChatMessage.createTxtSendMessage(content, channelID);
// 设置消息类型，即设置 `Message` 类的 `ChatType` 为`GroupChat`。
message.setChatType(ChatType.GroupChat);
// 设置消息属性为 `Channel Message`。
message.setIsChannelMessage(true);

// 发送消息。
ChatClient.getInstance().chatManager().sendMessage(message);
// 发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
message.setMessageStatusCallback(new CallBack() {
     @Override
     public void onSuccess() {
         showToast("发送消息成功");
          dialog.dismiss();
     }
     @Override
     public void onError(int code, String error) {
         showToast("发送消息失败");
     }
     @Override
     public void onProgress(int progress, String status) {

     }

 });
ChatClient.getInstance().chatManager().sendMessage(message);
```

#### 接收一条频道消息

你可以注册 `MessageListener` 监听器接收消息。

```java
MessageListener msgListener = new MessageListener() {

   // 收到消息，遍历消息队列，解析和显示。
   @Override
   public void onMessageReceived(List<ChatMessage> messages) {

   }
};
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
```
