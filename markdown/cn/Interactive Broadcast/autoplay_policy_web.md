---
title: 处理浏览器的自动播放策略
platform: Web
updatedAt: 2021-02-03 11:21:07
---
## 什么是自动播放策略

浏览器为了防止网页在用户非自愿的情况下主动播放声音，对网页上的自动播放（Autoplay）功能做了限制：浏览器在**没有用户交互操作之前不允许有声音的媒体播放**。

这个限制是出于用户体验的考虑，因为通常情况下用户访问网页后突然自动播放音频可能是违背用户意愿的。

## 绕过 Autoplay 限制

绕过 Autoplay 限制主要有两种方案：

- 方案一：通过 `Stream.play("ID", { muted: true })` 播放。如果媒体不包含声音，则不会被 Autoplay 限制。

- 方案二：通过 UI 和产品设计让用户和页面发生交互操作（点击/触摸），在用户操作后再调用 `Stream.play 进行播放。`

如果你的产品设计要求在没有用户操作的前提下自动播放媒体，我们推荐使用方案一。

如果你的产品设计允许在播放媒体之前用户和页面产生某些交互，比如用户在进入直播间后需要点击某些按钮才会开始订阅主播，我们推荐使用方案二。

<div class="alert note">无论使用何种方案，在自动播放策略限制下，没有用户操作之前自动播放有声媒体都是不可能的。虽然浏览器会在本地维护一个白名单来决定对哪些网站解除自动播放限制，但这部分是无法用 Javascript 探测到的。</div>

### 方案一：通过 `muted: true` 绕过 Autoplay 限制

使用这个方案，媒体会首先通过静音的方式自动播放，等页面上出现任何交互操作时，再自动切成有声媒体的播放。

开发者通过 `createStream` 或者订阅远端的方式获取到可以播放的 `Stream` 对象后，立刻调用 `Stream.play("ID", { muted: true })` 自动以静音的方式播放这些流。同时将这些自动播放的 `Stream` 对象保存到一个内部列表对象 `playingStreamList` 中。

在代码的开始，我们在页面上注册一个全局的事件 `document.body.addEventListener("touchstart")` / `document.body.addEventListener("mousedown")`，在这些事件的回调函数中，将 `playingStreamList` 中的 `Stream` 对象再次播放，这次就无须设置 `muted` 了，`Stream.play("ID", { muted: false })`。

### 方案二：通过提前产生交互行为绕过 Autoplay 限制

简单来说，只要确保在调用 `Stream.play` 之前用户和页面发生过交互行为即可。对于桌面端的浏览器，这个方案可以绕过大部分 Autoplay 限制，但是在 iOS Safari/Webview 上，自动播放策略会更为严格。

## iOS Safari 的特殊处理

<div class="alert note">iOS Safari 只允许通过用户交互来<b>触发</b>有声媒体的播放，而不是在用户交互后就打开 Autoplay 限制。</div> 

如果你的应用需要兼容 iOS Safari，我们推荐对 iOS Safari 做特殊处理。

- 和方案一一样，所有的流自动播放时都设置 `muted: true。`
- 在每个 `Stream.play` 时指定的 `HTMLElement` 容器绑定交互事件（点击/触摸）。
- 在播放界面上通过图标显示当前流被静音，引导用户点击。
- 当用户点击某个流的播放界面（刚刚绑定的容器）时，在事件的回调中将这个流的静音取消，即重新调用 `Stream.play("ID", { muted: false }`，同时更改静音图标。

因为 iOS Safari 的自动播放策略更为严格，Agora Web SDK 在 Safari 浏览器上会默认设置 `<video controls>`，也就是显示 `<video>` 元素的原生控件，这样即使你在 Safari 上没有对 Autoplay 限制做处理，用户也可以通过手动点击 `<video>` 元素的原生播放按钮来播放音视频。