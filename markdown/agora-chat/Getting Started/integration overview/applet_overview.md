
本页介绍小程序 SDK 集成过程中的初始化及登录。

## 前提条件

开始前，请注册有效的声网账号并创建开启了即时通讯 IM 服务的 App Key 的声网项目。详见[开发环境要求](./agora_chat_get_started_web#前提条件)。

## 导入 SDK

对于 JavaScript SDK，导入代码如下：

```javascript
import AC from "agora-chat";
```

对于 TypeScript SDK，导入代码如下, 其中 `AgoraChat` 是 SDK 类型的命名空间。

```javascript
import AC, { AgoraChat } from "agora-chat";
```

## SDK 初始化

使用 SDK 前需要进行初始化，示例代码如下：

(url, apiUrl 需要换成声网的)

```javascript
const conn = new AC.connection({
  appKey: "your appKey",
  url: "wss://im-api-wechat.easemob.com/websocket",
  apiUrl: "https://a1.easemob.com",
});
```

初始化 SDK 参数说明：

| 参数    | 类型   | 是否必需 | 描述       |
| :------------ | :----- | :------- | :---------------- |
| `appKey`              | String | 是    | 声网控制台为你的应用生成的唯一标识，由应用名称（`AppName`）和组织名称（`OrgName`）组成。 |
| `isHttpDNS`           | Boolean   | 否       | 是否开启 DNS，防止 DNS 劫持。<ul><li>（默认）`true`：开启 DNS；</li><li>`false`：关闭 DNS。</li></ul>  |
| `delivery`            | Boolean   | 否       | 是否开启送达回执：<ul><li>`true`：开启；</li><li>（默认）`false`：关闭。</li></ul>   |
| `https`               | Boolean   | 否       | 是否支持通过 HTTPS 访问即时通讯 IM：<ul><li>（默认）`true`：支持 HTTPS 和 HTTP；</li><li>`false`：浏览器根据使用的域名自行判断。  </li></ul>        |
| `heartBeatWait`       | Number   | 否       | 心跳间隔，单位为秒，默认为 30000 秒。              |
| `deviceId`            | String | 否       | 设备 ID，为默认随机值。       |
| `useOwnUploadFun`     | Boolean   | 否       | 是否支持通过自己的路径将图片、文件上传到自己的服务器。<ul><li>`true`：支持，需要指定路径；</li><li>（默认）`false`：关闭，通过消息服务器上传下载文件。</li></ul> |
| `autoReconnectNumMax` | Number   | 否       | 最大重连次数。  |
| `apiUrl`              | String | 是       | 指定的 REST 服务器。在未开启 DNS 的情况下使用，一般适用于开发者要实现数据隔离、特别注重数据安全的场景。如有需求，请联系 [sales@agora.io](mailto:sales@agora.io) 获取指定的服务器地址。   |
| `url`                 | String | 是       | 指定的消息服务器。在未开启 DNS 的情况下使用，一般适用于开发者要实现数据隔离、特别注重数据安全的场景。如有需求，请联系 [sales@agora.io](mailto:sales@agora.io) 获取指定的服务器地址。     |

## 注册用户

本节介绍三种用户注册方式。

### 控制台注册

登录[声网控制台](https://console.agora.io/)，选择**即时通讯** > **运营管理** > **用户**，创建即时通讯用户。

### REST API 注册

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

## 手动登录

**用户 ID +密码** 登录是传统的登录方式。用户 ID 和密码都是你的终端用户自行决定，密码需要符合密码规则要求。

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

**用户 ID + token** 是更加安全的登录方式。token 用户权限 token 可从你的 app server 获取。

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

### 自动登录（小程序 SDK 暂不支持）

在初始化的时候，可以设置是否自动登录。如果设置为自动登录，则登录成功之后，后续启动初始化的时候会自动登录，登录结果通过回调返回。

## 退出登录

```typescript
conn.close();
```

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

### 断网自动重连

如果由于网络信号弱、切换网络等引起的连接中断，系统会自动尝试重连。重连成功或者失败分别会收到 `onConnected` 和 `onDisconnected` 通知。

### 被动退出登录

对于 `onDisconnected` 通知，错误码（`errorCode`）可能为以下几种，建议 App 返回登录界面。

| 错误码                                             | 描述                       |
| :------------------------------------------------- | :------------------------- |
| WEBIM_CONNCTION_USER_LOGIN_ANOTHER_DEVICE=206      | 用户已经在其他设备登录。   |
| WEBIM_CONNCTION_USER_REMOVED=207                   | 用户账户已经被移除。       |
| WEBIM_CONNCTION_USER_KICKED_BY_CHANGE_PASSWORD=216 | 由于密码变更被踢下线。     |
| WEBIM_CONNCTION_USER_KICKED_BY_OTHER_DEVICE=217    | 由于其他设备登录被踢下线。 |

## 输出信息到日志文件

开启日志输出：

```javascript
logger.enableAll();
```

关闭日志输出：

```javascript
logger.disableAll();
```

设置日志输出等级：

```javascript
// 0 - 5 或者 'TRACE'，'DEBUG'，'INFO'，'WARN'，'ERROR'，'SILENT';
logger.setLevel(0);
```
