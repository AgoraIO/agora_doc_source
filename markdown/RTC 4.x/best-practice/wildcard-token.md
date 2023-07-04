# 使用通配 Token

用户在加入音视频通话或直播时，声网会使用 Token 对用户鉴权。观众如果需要加入多个频道，或在频道间频繁切换，每加入一个新的频道都需要向服务端申请一个 Token，然后通过用户 ID、频道名、以及获取到的 Token 来加入频道。为解决观众在切换频道时需要频繁申请 Token 的问题，声网提供了基于频道通配符的 Token。通过使用通配 Token，观众可以复用同一个 Token 加入不同频道，既可减少频繁获取 Token 所造成的耗时，从而加快切换、加入频道的速度，同时也能减小你的 Token 服务器的压力。

## 生成通配 Token

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token 生成器会生成相应的 Token 并返回给客户端。你可以参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android)来在服务端部署一个 Token 生成器。

<div class="alert note">在生成通配 Token 前，请确保你使用的是 AccessToken2。如果你使用的是 AccessToken，请先参考 <a href="https://docportal.shengwang.cn/cn/live-streaming-premium-legacy/token_upgrade?platform=Android#升级至-accesstoken2">AccessToken 升级指南</a>升级至 AccessToken2。</div>

AccessToken2 生成器代码中提供两个 `BuildTokenWithUid` 方法，以 [BuildTokenWithUid](https://github.com/AgoraIO/Tools/blob/master/DynamicKey/AgoraDynamicKey/cpp/src/RtcTokenBuilder2.h)[1/2] 为例，通过该方法生成通配 Token 时，你需要参考 [BuildTokenWithUid API 参考](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android#buildtokenwithuid-api-参考)填入相关参数信息，并确保：

-  用户 ID 不设为 0（支持使用 `int`、`String` 型的用户 ID）
-  频道名设为 `*`

按照上述方式生成通配 Token 后，用户可以通过同一用户 ID 的和通配 Token 加入任何频道。

## 注意事项

1. 为避免 Token 泄露后非法用户扰乱频道内秩序、炸房捣乱，请确保使用通配 Token 的用户其角色设为观众，用户权限（`role`）设为接收流（`kRoleSubscriber`）。

<div class="alert info">如果用户需要连麦，需要调用 <code>setClientRole</code> 来将用户角色设为主播（ <code>BROADCASTER</code>），然后在 <code>BuildTokenWithUid</code> 方法中指定频道名和用户 ID，且将用户权限（<code>role</code>）设为发流（ <code>kRolePublisher</code>），从而生成具有发流权限的 Token。</div>

1. 通配 Token的超时管理等操作仍旧保持不变，比如当token过期后需要继续重新更新token，确保token在有效期内。







