
本页介绍注册用户、登录和登出即时通讯 IM、监听即时通讯 IM 与声网服务器之间的连接状态以及日志相关设置。

## 注册用户

本节介绍三种用户注册方式。

### 控制台注册

登录[声网控制台](https://console.agora.io/)，选择**即时通讯** > **运营管理** > **用户**，创建即时通讯用户。

### RESTful API 注册

调用服务器端[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

### SDK 注册

```javascript
conn
  .registerUser({
    /** 用户 ID。 */
    username: string,
    /** 密码。 */
    password: string,
    /** 显示昵称。用于移动端推送的时候通知栏显示。 */
    nickname: string,
  })
  .then((res) => {
    console.log(res);
  });
```

## 用户登录

目前登录服务器有两种方式：

- 用户 ID + 密码
- 用户 ID + token

登录时传入的用户 ID 必须为 String 类型，支持的字符集详见[调用 RESTful API 接口注册用户](./agora_chat_restful_registration#注册单个用户)。

调用登录接口后，收到 `onConnected` 回调表明 SDK 与声网服务器连接成功。

- **用户 ID +密码** 登录是传统的登录方式。用户 ID 和密码均由你的终端用户自行决定，需要符合[设置要求](./agora_chat_restful_registration#开放注册单个用户)。

```javascript
conn
  .open({
    user: "username",
    pwd: "password",
  })
  .then(() => {
    console.log("login success");
  })
  .catch((reason) => {
    console.log("login fail", reason);
  });
```

- **用户 ID + token** 是更加安全的登录方式。用户权限 token 可从你的 app server 获取，详见[实现 Token 鉴权](./agora_chat_token)。

<div class="alert note">使用 token 登录时需要处理 token 过期的问题，比如每次登录时更新 token 等机制。</div>

```javascript
conn
  .open({
    user: "username",
    agoraToken: "token",
  })
  .then(() => {
    console.log("login success");
  })
  .catch((reason) => {
    console.log("login fail", reason);
  });
```

## 退出登录

- 主动退出登录：

```typescript
conn.close();
```

- 被动退出登录：

对于 `onDisconnected` 通知，错误码（`errorCode`）可能为以下几种，建议 App 返回登录界面。

| 错误码                                             | 描述                       |
| :------------------------------------------------- | :------------------------- |
| WEBIM_CONNCTION_USER_LOGIN_ANOTHER_DEVICE=206      | 用户已经在其他设备登录。   |
| WEBIM_CONNCTION_USER_REMOVED=207                   | 用户账户已经被移除。       |
| WEBIM_CONNCTION_USER_KICKED_BY_CHANGE_PASSWORD=216 | 由于密码变更被踢下线。     |
| WEBIM_CONNCTION_USER_KICKED_BY_OTHER_DEVICE=217    | 由于其他设备登录被踢下线。 |

## 连接状态相关

你可以通过注册连接监听器确认连接状态。

```javascript
conn.addEventHandler("handlerId", {
  onConnected: () => {
    console.log("onConnected");
  },
  onDisconnected: () => {
    console.log("onDisconnected");
  },
  onTokenWillExpire: () => {
    console.log("onTokenWillExpire");
  },
  onTokenExpired: () => {
    console.log("onTokenExpired");
  },
});
```

## 断网自动重连

如果由于网络信号弱、切换网络等引起的连接中断，系统会自动尝试重连。重连成功或者失败分别会收到 `onConnected` 和 `onDisconnected` 通知。

## 输出信息到日志文件

- 开启日志输出：

```javascript
logger.enableAll();
```

- 关闭日志输出：

```javascript
logger.disableAll();
```

- 设置日志输出等级：

```javascript
// 0 - 5 或者 'TRACE'，'DEBUG'，'INFO'，'WARN'，'ERROR'，'SILENT';
logger.setLevel(0);
```
