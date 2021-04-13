---
title: 如何实现忙线拒接功能？
platform: ["Android","iOS","macOS","Web","Windows","Linux","Unity","Cocos Creator","微信小程序","Electron","React Native","Flutter"]
updatedAt: 2020-03-17 16:06:47
Products: ["Voice","Video","Real-time-Messaging"]
---
## 问题描述

当主叫向指定用户发送呼叫邀请时，如果被叫用户已有一个呼叫进入或被叫用户正在接听另一个电话，主叫如何通过 Agora RTM SDK 的呼叫邀请功能得知对方正在忙线中？


## 功能说明

Agora RTM SDK 的呼叫邀请功能仅提供了呼叫邀请的控制逻辑实现，即该功能只负责控制通话的开始。如需完整实现一个通话场景，必须将 Agora RTM SDK 与其他音视频 SDK（比如 Agora RTC SDK）结合使用。

## 实现方法


Agora 建议在 app 层面为每个用户设立邀请状态标志 `inviteState` 和通话状态标志 `callState` 监听用户的接听状态。所有标志位默认初始状态为  `false`，只要用户的任一状态标志变为 `true` 时不能接受新的呼叫。


| `inviteState` | `callState` | 忙线状态 |
| ---------------- | ---------------- | ---------------- |
| `false`      | `false`      | 用户空闲     |
| `true`      | `false`      | 用户忙     |
| `false`      | `true`      | 用户忙     |



1. 确保你的项目已集成了 Agora RTM SDK 和音视频 SDK (比如 Agora RTC SDK)。
2. 当用户收到 Agora RTM SDK 返回的 `onRemoteInvitationReceived` 时，将状态标志 `inviteState` 设为 `true`：
    - 收到以下回调时，将状态标志 `inviteState` 设回 `false` 表示本次呼叫邀请结束而通话并未开始，不必进行后面的步骤。
       - `onRemoteInvitationRefused`：呼叫邀请已被被叫拒绝；
       - `onRemoteInvitationCanceled`：呼叫邀请已被主叫取消；
       - `onRemoteInvitationFailure`：呼叫邀请过程因其他原因失败。
    - 收到 `onRemoteInvitationAccepted` 回调（被叫已接受呼叫邀请）时，将状态标志 `inviteState` 设回 `false`，并将 `callState` 设为 `true` 表示本次呼叫邀请结束而通话即将开始。
3. 通过 Agora RTC SDK 提供的 `onConnectionStateChanged` 回调监听 `connectionState` 的状态：
    - 如果 `connectionState` 处于以下状态时保持状态标志 `callState` 为 `true`，表示用户正在建立通话或正在通话中：
        - `CONNECTING`: 建立网络连接中；
        - `CONNECTED`: 网络连接已建立；
        - `RECONNECTING`: 网络重连中。
    - 如果 `connectionState` 处于以下状态时将通话状态标志设回 `false`, 表示用户不在通话中：
        - `DISCONNECTED`: 网络连接断开；
        - `FAILED`: 网络连接失败。
4. 根据上表提供的判断依据判定用户是否忙线，如果用户忙线中，可以调用 Agora RTM SDK 提供的 `refuseRemoteInvitation` 方法拒绝呼叫邀请并在收到的 `RemoteInvitation` 内设置 `content` 属性为 `"busy"`。