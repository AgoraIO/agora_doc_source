# 实现音视频通话

AgoraChatCallKit 是一套基于声网的实时通讯和信令服务开发的开源音视频 UI 库。利用该库可实现音视频通话功能，提升多种服务之间的同步。同时，用户在多个设备登录时能同步处理呼叫振铃，即当用户在一台设备上处理振铃后，其他设备自动停止振铃。

本文展示如何使用 AgoraChatCallKit 快速构建实时音视频场景。

## 实现原理

使用 AgoraChatCallKit 实现音视频通话的基本流程如下：

1. 调用 `init` 初始化 AgoraChatCallKit。
2. 主叫方调用 `startCall` 发起一对一通话或多人通话的邀请。
3. 被叫方在 `onInvite` 中收到呼叫邀请，选择接听或拒绝呼叫。成功接听后，进入通话。
4. 结束通话时，SDK 触发 `onStateChange` 回调。

## 前提条件

开始前，请确保你的项目满足如下条件：

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA-agora-%E8%B4%A6%E5%8F%B7)。
- 已[开通即时通讯 IM 服务](./enable_agora_chat?platform=iOS)的 Agora 项目。
- 有一个集成了 Chat SDK 的 Agora Chat 项目，实现了基本的实时聊天功能，包括用户的登录和注销和消息的发送和接收。

## 项目设置

参考如下步骤，下载 AgoraChatCallKit 并将其集成到你的项目中，并完成相关配置。

参考下文步骤使用 npm 将 AgoraChatCallKit 导入到项目中。

1. 在终端中，运行以下命令安装 AgoraChatCallKit。

```bash
npm install AgoraChatCallKit
```

2. 导入 AgoraChatCallKit。

```javascript
import Callkit from 'chat-callkit'; 
```

## 实现音视频通话

参考如下步骤在项目中实现音视频通话。

### 初始化 AgoraChatCallKit

调用 `init` 对 AgoraChatCallKit 进行初始化。

```javascript
/**
 * 初始化 AgoraChatCallKit。
 *
 * @param appId       声网 App ID。
 * @param agoraUid    声网 UID。
 * @param connection  Agora Chat SDK Connection 类的实例。
 */
CallKit.init(appId, agoraUid, connection);
```

### 主叫发起通话邀请

主叫调用 `startCall` 方法，发起通话邀请。你需要在该方法中指定通话类型。

-   一对一通话
    一对一通话中，主叫方会向对方发送一条文本消息作为通话邀请。

```javascript
let options = {
	callType: 0, //通话类型：0：一对一语音通话；1：一对一视频通话；2：多人视频通话；3：多人语音通话。
	chatType: 'singleChat', //会话类型：单聊。
	to: 'userId', // 对方的即时通讯 IM 用户 ID。
	message: '邀请你加入语音', //邀请消息。
	channel: 'channel', //当前用户生成的频道名称，让对方加入该频道。
	accessToken: '声网 token', //声网 RTC token。
};
CallKit.startCall(options);
```

- 多人通话
  多人通话中，主叫方向群组或聊天室里发送一条文本消息，同时向受邀用户发送命令消息邀请其加入通话。

```javascript
let options = {
	callType: 2, //通话类型：0：一对一语音通话；1：一对一视频通话；2：多人视频通话；3：多人语音通话。
	chatType: 'groupChat', 
	to: ['userId'], //受邀用户的即时通讯 IM 用户 ID。
	message: '邀请你视频通话', //邀请消息。
	groupId: 'groupId', //群组 ID。
	groupName: 'group name', //群组名称。
	accessToken: '声网 token', //声网 RTC token。
	channel: 'channel', //当前用户生成的频道名称，让对方加入该频道。
};
CallKit.startCall(options);
```

发起通话后的 UI 界面如下：
![](https://web-cdn.agora.io/docs-files/1655259671848)

### 被叫收到通话邀请

主叫方发起邀请后，如果被叫方在线且当前不在通话中，会触发 `onInvite` 回调。被叫在回调中可以处理是否弹出接听界面，弹出界面后可以选择接听或者挂断。

```javascript
/**
 * 处理通话邀请。
 * 
 * @param result 是否弹出接听界面：
 *               - `true`: 是；
 *               - `false`: 否。这种情况下，无需传声网 RTC token。
 * @param accessToken 声网 RTC token。
 */
CallKit.answerCall(result, accessToken);
```

被叫方收到通话邀请的界面：

![](https://web-cdn.agora.io/docs-files/1655259682186)

### 多人通话过程中发起邀请

在多人通话中若要再邀请其他用户，可以点击右上角的 **添加人** 按钮。发送通话邀请后，SDK 会触发 `onAddPerson` 回调。在该回调中，你可以要求邀请方指定要邀请的用户，然后调用 `startCall` 发出邀请。

### 添加监听器

通话过程中，你也可以监听以下回调事件：

```javascript
function Call() {
	// 通话状态变化回调。
	const handleCallStateChange = (info) => {
		switch (info.type) {
			case 'hangup':
				// 挂断事件。
				break;
			case 'accept':
				// 接听事件。
				break;
			case 'refuse':
				// 拒绝接听事件。
				break;
			case 'user-published':
				// 通话中其他用户发布媒体流事件。
				break;
			case 'user-unpublished':
				// 通话中其他用户取消发布媒体流。
				break;
			case 'user-left':
				// 通话中其他用户退出通话。
				break;
			default:
				break;
		}
	};
	return <Callkit onStateChange={handleCallStateChange} />;
}
```
### 通话结束

通话中的一方点击页面上的**挂断**按钮可以结束通话。在一对一音视频通话中，若其中一方挂断，双方的通话会自动结束。多人音视频通话场景中，用户主动挂断才能结束通话。若当前用户挂断，则其收到的 `onStateChange` 回调中，`info.type` 为 `hangup`。若通话中的对端用户挂断，当前用户收到的 `onStateChange` 回调中， `info.type` 为 `user-left`。

## 更多操作

本节介绍你的项目中涉及的音视频通话功能的其他操作。

### 获取声网 RTC token

为提高通信安全性，声网建议你在应用用户加入通话前使用 RTC token 对其进行身份验证。为此，您需要确保[启用项目的主证书](https://docs.agora.io/cn/All/faq/appid_to_token)。

Token 由声网提供的 token 生成器在你的应用服务器上生成。获取 Token 后，在调用 `startCall` 和 `answerCall` 方法时将 token 传递给 AgoraChatCallKit。关于如何在服务器上生成 token 并在客户端获得和更新 token，请参阅 [基于 Token 的用户验证](https://docs.agora.io/cn/video-legacy/token_server?platform=Web)。

## 参考

本节提供其他参考信息，供你在实现实时音视频通信功能时参考。

### API 列表

方法：

| 方法   | 说明   |
| :------------------- | :------- | 
| init  | 初始化 AgoraChatCallKit。 |
| startCall  | 发起通话。 |
| answerCall  | 接听通话。 |
| setUserIdMap  | 设置声网 UID 映射与自定义用户 ID 之间的映射，格式为 {[uid1]: 'custom name', [uid2]: 'custom name'} 。 |

回调：

| 方法   | 说明   |
| :------------------- | :------- | 
| onAddPerson  | 多人通话点击邀请人按钮的回调。 |
| onInvite  | 收到通话邀请的回调。 |
| onStateChange  | 通话状态发生变化的回调。 |


属性：

| 属性   | 说明   |
| :------------------- | :------- | 
| contactAvatar  | 一对一通话时显示的头像。 |
| groupAvatar  | 多人通话时显示的头像。 |
### 示例项目

为方便快速体验，我们在 GitHub 上提供了一个开源的 [AgoraChatCallKit](https://github.com/AgoraIO-Usecase/AgoraChat-CallKit-web/tree/master/demo) 示例项目，你可以下载体验，或查看源代码。

AgoraChatCallKit 在通话过程中，使用即时通讯 IM 的用户 ID 加入频道，方便音视频视图中显示用户 ID。如果你直接调用声网 API 实现音视频通话功能，也可以直接使用 Int 型 UID 加入频道。