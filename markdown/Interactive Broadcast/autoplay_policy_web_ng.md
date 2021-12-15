---
title: 处理浏览器的自动播放策略
platform: Web
updatedAt: 2021-02-03 11:19:57
---

<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./autoplay_policy_web?platform=Web">处理浏览器的自动播放策略</a>。</li></div>

## 概览

浏览器为了防止网页在用户非自愿的情况下主动播放声音，对网页上的自动播放（Autoplay）功能做了限制：浏览器在**没有用户交互操作（点击、触摸等）之前不允许有声音的媒体播放**。

这个限制是出于用户体验的考虑，因为通常情况下用户访问网页后突然自动播放音频可能是违背用户意愿的。

在使用 Agora Web SDK 时，如果在发生交互之前调用 `remoteAudioTrack.play` 播放音频，浏览器的 Autoplay 限制可能导致用户听不到声音。

为了解决由于浏览器限制导致播放失败的问题，本文将分两种情况介绍使用 Agora Web SDK 时处理 Autoplay 限制的方案：

- 自动播放失败时解除 Autoplay 限制：监听 `onAudioAutoplayFailed` 回调，通过回调在页面上显示一个按钮引导用户点击。
- 在产品设计中确保在调用 `remoteAudioTrack.play` 和 `localAudioTrack.play` 之前用户已经和页面发生了点击交互。

<div class="alert info">无论使用何种方案，只要浏览器启用了自动播放策略，都需要用户至少进行一次交互操作才能播放音频。随着用户使用某个页面的次数变多，浏览器会在这个页面上默认关闭自动播放策略，此时不需要任何交互也可以播放音频了，但是我们无法通过 JavaScript 去感知浏览器这个行为。</div>

## 自动播放失败时解除 Autoplay 限制

你可以监听 `AgoraRTC.onAudioAutoplayFailed` 回调，在音频轨道自动播放失败时提示和引导用户与页面发生交互来恢复播放。

以下示例代码演示了当检测到音频轨道自动播放失败后的处理：在页面上动态显示一个按钮让用户点击。

<div class="alert note">短时间内可能有多个音频轨道对象都调用了 <code>play</code>，此时会触发多次 <code>onAudioAutoplayFailed</code> 回调。示例代码中通过 <code>isAudioAutoplayFailed</code> 这个对象防止创建重复的按钮对象。</div>

```js
let isAudioAutoplayFailed = false;
AgoraRTC.onAudioAutoplayFailed = () => {
  if (isAudioAutoplayFailed) return;

  isAudioAutoplayFailed = true;
  const btn = document.createElement("button");
  btn.innerText = "Click me to resume the audio playback";
  btn.onClick = () => {
    isAudioAutoplayFailed = false;
    btn.remove();
  };
  document.body.append(btn);
};
```

## 确保调用 play 前用户产生交互行为

简单来说，只要确保在调 `remoteAudioTrack.play` 和 `localAudioTrack.play` 之前用户和页面发生过交互行为即可。

对于桌面端的浏览器，这个方案可以处理大部分 Autoplay 限制，但是在 iOS Safari/WebView 上，自动播放策略会更为严格。

### iOS Safari/WebView 的特殊处理

iOS Safari 只允许通过用户交互来**触发**有声媒体的播放，而不是在用户交互后就打开 Autoplay 限制。

如果你的应用需要兼容 iOS Safari/WebView，我们推荐对 iOS Safari/WebView 做特殊处理。

- 为每个远端用户在播放界面上通过图标显示当前用户被静音，引导用户点击。
- 当本地用户点击某个远端用户的音频播放按钮时，在按钮的点击/触摸事件的回调中播放这个用户的音频轨道，同时更改静音图标。

```html
// HTML
<div id="user1-audio">已静音</div>
```

```js
// JavaScript
document.getElementById("user1-audio").onClick = e => {
  if (user1.audioTrack.isPlaying) {
    user1.audioTrack.stop();
    e.target.innerHTML = "已静音";
    return;
  }
  user1.audioTrack.play();
  e.target.innerHTML = "播放中";
};
```
