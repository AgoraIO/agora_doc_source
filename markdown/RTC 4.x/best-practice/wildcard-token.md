# 使用通配 Token

用户在加入音视频通话或直播时，声网会使用 Token 对用户鉴权。观众如果需要加入多个频道，或在频道间频繁切换，每加入一个新的频道都需要向服务端申请一个 Token，然后通过 用户 ID、频道名、以及获取到的 Token 来加入频道。为解决观众在切换频道时需要频繁申请 Token 的问题，声网提供了基于频道通配符的 Token。通过使用通配 Token，观众可以复用同一个 Token 加入不同频道，既可减少获取 Token 所需的耗时，从而加快切换、加入频道的速度，同时也能减小你的 Token 服务器的压力。

## 生成通配 Token

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token 生成器会生成相应的 Token 并返回给客户端。你可以参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/video-call-4.x/token_server_android_ng?platform=Android)来在服务端部署一个 Token 生成器。

在生成通配 Token 时，你需要填入下列信息：

- 你在声网控制台创建项目时生成的 App ID。
- 你的项目的 App 证书。
- 
- 待鉴权用户的用户 ID 32 位无符号整数，范围为1到 (2³² - 1)， 并保证唯一性。





