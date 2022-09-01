# 离线推送


Agora Chat 提供离线推送服务，具有低延迟、高交付、高并发和不侵犯用户个人数据的特点。

## 技术原理

利用 Agora Chat SDK，可实现以下功能：

- 设置 app 的推送通知；
- 获取 app 的推送通知设置；
- 设置会话的推送通知；
- 获取一个或多个会话的推送通知设置；
- 清除会话的推送通知方式的设置；
- 设置和获取推送通知的首选语言。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见[快速开始](agora_chat_get_started_web)；
- 了解 Agora Chat 套餐包中的 API 调用频率限制，详见[使用限制](agora_chat_limitation)；
- 你已在 [Agora 控制台](https://console.agora.io/)中激活了推送高级功能。激活了高级功能后，你可以设置推送通知模式和免打扰模式。

<div class="alert note">关闭推送高级功能必须联系 <a href="mailto:support@agora.io">support@agora.io</a>，因为该操作会删除所有相关配置。</div>

## 实现方法

为优化用户在处理大量推送通知时的体验，Agora Chat 在应用和会话级别提供了推送通知和免打扰模式的细粒度选项，如下表所示：

<table>
  <tr>
    <th>模式</th>
    <th>选项</th>
    <th>App</th>
    <th>会话</th>
  </tr>
  <tr>
    <td rowspan="3">推送通知方式</td>
    <td>ALL：接收所有离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>AT：只接收提及当前用户的离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
     <td>NONE：不接收离线消息的推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  </tr>
  <tr>
    <tr>
    <td rowspan="2">免打扰模式</td>
    <td>duration：在指定时长内不接收推送通知。</td>
    <td>✓</td>
    <td>✓</td>
  <tr>
    <td>startTime & endTime：在指定的时间段内不接收推送通知。</td>
    <td>✓</td>
    <td>✗</td>
  </tr>
  </tr>
</table>

**推送通知方式**

会话级别的推送通知方式设置优先于 app 级别的设置，未设置推送通知方式的会话默认采用 app 的设置。

例如，假设 app 的推送方式设置为 `AT`，而指定会话的推送方式设置为 `ALL`。你会收到来自该会话的所有推送通知，而对于其他会话来说，你只会收到提及你的消息的推送通知。

**免打扰模式**

1. 你可以在 app 级别指定免打扰时长和免打扰时间段。环信 IM 在这两个时间段内不发送离线推送通知。

2. 会话仅支持免打扰时长设置；免打扰时间段的设置不生效。

对于 app 和 app 中的所有会话，免打扰模式的设置优先于推送通知方式的设置。

例如，假设在 app 级别指定了免打扰时间段，并将指定会话的推送通知方式设置为 `ALL`。免打扰模式与推送通知方式的设置无关，即在指定的免打扰时间段内，你不会收到任何推送通知。

或者，假设为会话指定了免打扰时间段，而 app 没有任何免打扰设置，并且其推送通知方式设置为 `ALL`。在指定的免打扰时间段内，你不会收到来自该会话的任何推送通知，而所有其他会话的推送保持不变。

### 设置 app 的推送通知

你可以调用 `setSilentModeForAll` 方法在 app 级别设置推送通知，并通过指定 `paramType` 字段设置推送通知方式和免打扰模式，如下代码示例所示：

```javascript
/**
  options // 推送通知配置选项。
	options: {
    paramType: 0, // 推送通知方式。
    remindType: 'ALL' // 可设置为 `ALL`、`AT` 或 `NONE`。
  }
  options: {
    paramType: 1, // 免打扰时长。
    duration: 7200000 // 免打扰时长，单位为毫秒。
  }
  options: {
    paramType: 2, // 免打扰时间段。
    startTime: {
    	hours: 8, // 免打扰时间段的开始时间中的小时数。
    	minutes: 0 // 免打扰时间段的开始时间中的分钟数。
    }，
    endTime: {
    	hours: 12, // 免打扰时间段的结束时间中的小时数。
    	minutes: 0 // 免打扰时间段的结束时间中的分钟数。
    }
  }
*/
const params = {
  options: {
    paramType: 0,
    remindType: "ALL",
  },
};
conn.setSilentModeForAll(params);
```

### 获取 app 的推送通知设置

你可以调用 `getSilentModeForAll` 获取 app 的推送通知设置，示例代码如下：

```javascript
// 无需传参数，直接调用。
conn.getSilentModeForAll();
```

### 设置单个会话的推送通知

你可以调用 `setSilentModeForConversation` 设置指定会话的推送通知设置，示例代码如下：

```javascript
/**
	const params = {
    conversationId: 'conversationId', // 会话 ID：单聊为对方用户 ID，群聊为群组 ID，聊天室会话为聊天室 ID。
    type: 'singleChat', // 会话类型：singleChat（单聊）、groupChat（群聊）和 chatRoom（聊天室）。
    options: {
      paramType: 0, // 推送通知方式。
      remindType: 'ALL' // 可设置为 `ALL`、`AT` 或 `NONE`。
    }
  }
	
	const params = {
    conversationId: 'conversationId',
    type: 'groupChat',
    options: {
      paramType: 1, // 免打扰时长。
      duration: 7200000 // 免打扰时长，单位为毫秒。
    }
  }
  
  const params = {
    conversationId: 'conversationId',
    type: 'chatRoom',
    options: {
      paramType: 2, // 免打扰时间段。
      startTime: {
        hours: 8, // 免打扰时间段的开始时间中的小时数。
        minutes: 0 // 免打扰时间段的开始时间中的分钟数。
      }，
      endTime: {
        hours: 12, // 免打扰时间段的结束时间中的小时数。
        minutes: 0 // 免打扰时间段的结束时间中的分钟数。
      }
    }
  }
*/
const params = {
  conversationId: "conversationId",
  type: "groupChat",
  options: {
    paramType: 0,
    remindType: "ALL",
  },
};
conn.setSilentModeForConversation(params);
```

### 获取单个会话的推送通知设置

调用 `getSilentModeForConversation` 获取单个会话的推送通知设置，示例代码如下：

```javascript
const params = {
  conversationId: "conversationId", // 会话 ID：单聊为对方用户 ID，群聊为群组 ID，聊天室会话为聊天室 ID。
  type: "singleChat", // 会话类型：singleChat（单聊）、groupChat（群聊）和 chatRoom（聊天室）。
};
conn.getSilentModeForConversation(params);
```

### 获取多个会话的推送通知设置

1. 你可以在每次通话中检索最多 20 个会话的推送通知设置。

2. 如果会话继承了 app 设置或其推送通知设置已过期，则返回的字典不包含此会话。

你可以调用 `getSilentModeForConversations` 获取多个会话的推送通知设置，示例代码如下：

```javascript
const params = {
  conversationList: [
    {
      id: "conversationId", // 会话 ID：单聊为对方用户 ID，群聊为群组 ID，聊天室会话为聊天室 ID。
      type: "singleChat", // 会话类型：singleChat（单聊）、groupChat（群聊）和 chatRoom（聊天室）。
    },
    {
      id: "conversationId",
      type: "groupChat",
    },
  ],
};
conn.getSilentModeForConversations(params);
```

### 清除单个会话的推送通知方式的设置

你可以调用 `clearRemindTypeForConversation` 方法清除指定会话的推送通知方式的设置。清除后，默认情况下，此会话会继承 app 的设置。

示例代码如下：

```javascript
const params = {
  conversationId: "conversationId", // 会话 ID：单聊为对方用户 ID，群聊为群组 ID，聊天室会话为聊天室 ID。
  type: "groupChat", // 会话类型：singleChat（单聊）、groupChat（群聊）或 chatRoom（聊天室）。
};
conn.clearRemindTypeForConversation(params);
```

### 设置推送翻译

如果用户启用[自动翻译](./agora_chat_translation_web)功能并发送消息，SDK 会同时发送原始消息和翻译后的消息。

推送通知与翻译功能协同工作。作为接收方，你可以设置你在离线时希望接收的推送通知的首选语言。如果翻译消息的语言符合你的设置，则翻译消息显示在推送通知中；否则，将显示原始消息。

你可以调用 `setPushPerformLanguage` 设置推送通知的首选语言，示例代码如下：

```javascript
// 设置推送通知的首选语言。
const params = {
  language: "EU",
};
conn.setPushPerformLanguage(params);

// 获取推送通知的首选语言
conn.getPushPerformLanguage();
```