用户在加入音视频通话或直播时，声网会使用 Token 对用户鉴权。观众如果需要加入多个频道，或在频道间频繁切换，每加入一个新的频道都需要向服务端申请一个 Token，然后通过用户 ID、频道名、以及获取到的 Token 来加入频道。为解决观众在切换频道时需要频繁申请 Token 的问题，声网提供了基于频道通配符的 Token。通过使用通配 Token，观众可以复用同一个 Token 加入不同频道，既可减少频繁获取 Token 所造成的耗时，从而加快切换、加入频道的速度，同时也能减小你的 Token 服务器的压力。

## 前提条件

在生成通配 Token 前，请确保你已部署 AccessToken2 服务器。详见[使用 Token 鉴权](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android)。

- 如果你使用的是 AccessToken，请参考 [AccessToken 升级指南](https://docportal.shengwang.cn/cn/live-streaming-premium-legacy/token_upgrade?platform=Android#升级至-accesstoken2)升级至 AccessToken2。

- 如果你使用的是 Web 端，需要调用 `setParameter` 将 `USE_NEW_TOKEN` 设为 `true`，示例代码如下：

  ```js
  AgoraRTC.setParameter("USE_NEW_TOKEN", true);
  ```

## 生成通配 Token

AccessToken2 的[生成器代码](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android#token-生成器代码)中提供两个 `BuildTokenWithUid` 方法，你可以根据 [BuildTokenWithUid API 参考](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android#buildtokenwithuid-api-参考)按需选用 `BuildTokenWithUid`[1/2] 或 `BuildTokenWithUid`[2/2]，并填入对应参数信息。

生成通配 Token 时，需要注意以下参数的填写与生成一般 Token 时有所区别：

| 参数          | 一般 Token                                                   | 通配 Token                                                   |
| ------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `uid`         | 待鉴权用户的用户 ID 。 如不需对用户 ID 进行鉴权，即客户端使用任何 `uid` 都可加入频道，请把 `uid` 设为 0。 | 待鉴权用户的用户 ID ，支持使用 `int`、`string` 型的用户 ID，**但不得设为 0**。 |
| `channelName`      | 频道名称，长度在 64 个字节以内。 | 频道名设为通配符 `*`，表示任意频道名称。 |

按照上述方式生成通配 Token 后，用户可以通过同一用户 ID 的和通配 Token 加入任何频道。

## 注意事项

1. 目前声网仅支持使用任意用户 ID 都可加入频道的 Token（即 `uid` 设为 0，`channelName` 需指定），或指定一个用户 ID 来加入任意频道的通配 Token（即 `uid` 需指定，`channelName` 设为 `*`），不支持同时将 `uid` 设为 0、`channelName` 设为 `*`。
2. 为避免 Token 泄露后非法用户扰乱频道内秩序、炸房捣乱，请确保使用通配 Token 的用户其角色设为观众，用户权限（`role`）设为接收流（`kRoleSubscriber`）。

<div class="alert info">如果用户需要连麦，需要调用 <code>setClientRole</code> 来将用户角色设为主播（ <code>BROADCASTER</code>），然后在 <code>BuildTokenWithUid</code> 方法中指定频道名和用户 ID，且将用户权限（<code>role</code>）设为发流（ <code>kRolePublisher</code>），从而生成具有发流权限的 Token。</div>

2. 如果通配 Token 过期，你需要重新在服务端重新生成新的通配 Token，然后调用 [renewToken](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_renewtoken) 来传入新的通配 Token。

## 参考文档

- [使用 Token 鉴权](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android)
- [AccessToken 升级指南](https://docportal.shengwang.cn/cn/live-streaming-premium-legacy/token_upgrade?platform=Android#升级至-accesstoken2)
