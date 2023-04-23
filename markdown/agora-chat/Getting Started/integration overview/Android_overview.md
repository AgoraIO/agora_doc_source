# SDK 集成概述

本页介绍用户注册、登录和登出即时通讯 IM、监听即时通讯 IM 与声网服务器之间的连接状态以及查看和获取日志。

## 注册用户

本节介绍三种用户注册方式。

### 控制台注册

登录[声网控制台](https://console.agora.io/)，选择**即时通讯** > **运营管理** > **用户**，创建即时通讯用户。

### RESTful API 注册

调用服务器端[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

### SDK 注册

可以使用如下代码创建账号：

```java
// 注册失败会抛出 ChatException。
ChatClient.getInstance().createAccount(mAccount, mPassword);// 同步方法。
```

以上为客户端注册，旨在方便测试，并不推荐在生产环境中使用。生产环境中应[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

## 用户登录

目前登录服务器支持手动和自动登录。手动登录有两种方式：

- 用户 ID + 密码
- 用户 ID + token

手动登录时传入的用户 ID 必须为 String 类型，支持的字符集详见[调用 RESTful 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

调用登录接口后，收到 `ConnectionListener#onConnected` 回调表明 SDK 与声网服务器连接成功。

### 手动登录

**用户 ID + 密码** 登录是传统的登录方式。用户 ID 和密码均由你的终端用户自行决定，需要符合[设置要求](./agora_chat_restful_registration#开放注册单个用户)。

```java
ChatClient.getInstance().login(mAccount, mPassword, new CallBack() {
    // 登录成功回调
    @Override 
    public void onSuccess() {

    }

    // 登录失败回调，包含错误信息
    @Override 
    public void onError(int code, String error) {

    }

});
```

**用户 ID + token** 是更加安全的登录方式。用户权限 token 可从你的 app server 获取，详见[实现 Token 鉴权](./agora_chat_token)。

<div class="alert note">使用 token 登录时需要处理 token 过期的问题，比如每次登录时更新 token 等机制。</div>

```java
ChatClient.getInstance().loginWithAgoraToken(mAccount, mToken, new CallBack() {
    // 登录成功回调
    @Override
    public void onSuccess() {

    }
    // 登录失败回调，包含错误信息
    @Override
    public void onError(int code, String error) {

    }
});
```

### 自动登录

初始化时可以设置是否自动登录。如果设置为自动登录，则登录成功之后，后续启动初始化的时候会自动登录。

## 退出登录

- 主动退出登录

同步方法如下：

```java
// unbindToken 表示是否解除账号与设备绑定。若解除绑定，用户登出账号后设备将不再收到消息推送。
ChatClient.getInstance().logout(unbindToken);
```

异步方法如下：

```java
// unbindToken 表示是否解除账号与设备绑定。若解除绑定，用户登出账号后设备将不再收到消息推送。
ChatClient.getInstance().logout(unbindToken, new CallBack() {

    @Override
    public void onSuccess() {

    }

    @Override
    public void onError(int code, String message) {

    }
});
```

- 被动退出登录

你可以监听 `ConnectionListener#onLogout(int)` 回调后，调用 `ChatClient#logout(boolean, CallBack)` 方法退出登录，返回登录界面。

`ConnectionListener#onLogout(int)` 返回的 `errorCode` 有如下几种情况：

- `USER_LOGIN_ANOTHER_DEVICE=206`: 用户已经在其他设备登录。
- `USER_REMOVED=207`: 用户账户已经被移除。
- `USER_BIND_ANOTHER_DEVICE=213`: 用户已经绑定其他设备。
- `USER_LOGIN_TOO_MANY_DEVICES=214`: 用户登录设备超出数量限制。
- `USER_KICKED_BY_CHANGE_PASSWORD=216`: 由于密码变更被踢下线。
- `USER_KICKED_BY_OTHER_DEVICE=217`: 由于其他设备登录被踢下线。
- `USER_DEVICE_CHANGED=220`: 和上次登录设备不同导致下线。
- `SERVER_SERVING_DISABLED=305`: 服务器服务停止。

## 监听连接状态

你可以通过注册连接监听 `connectionListener` 中的回调确认连接状态。

```java
ConnectionListener connectionListener = new ConnectionListener() {
    @Override
    public void onConnected() {

    }
    @Override
    public void onDisconnected(int errorCode) {

    }

    @Override
    public void onLogout(int errorCode) {

    }

    @Override
    public void onTokenWillExpire() {

    }

    @Override
    public void onTokenExpired() {

    }
};
// 注册连接状态监听
ChatClient.getInstance().addConnectionListener(connectionListener);
// 移除连接状态监听
ChatClient.getInstance().removeConnectionListener(connectionListener);
```

## 断网自动重连

如果由于网络信号弱、切换网络等引起的连接终端，SDK 会自动尝试重连。重连成功或者失败的结果分别会触发 `onConnected` 和 `onDisconnected` 回调。

## 输出信息到日志文件

开发者可以在开发阶段开启 `DEBUG` 模式，获取更多的调试信息。

```java
// 需要在 SDK 初始化后调用
ChatClient.getInstance().setDebugMode(true);
```

## 获取本地日志

```shell
adb pull /sdcard/android/data/{应用包名}/{App Key}/core_log/easemob.log
```

获取本地日志，需要将 `{应用包名}` 替换为应用的包名，例如 `io.agora.chatuidemo`；`{App Key}` 需要替换为应用设置的即时通讯服务的 [App Key](./enable_agora_chat#获取即时通讯项目信息)。