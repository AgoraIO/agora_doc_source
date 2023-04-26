灵动课堂主要提供课堂内的实时互动体验，自身并不提供用户系统和排课系统。如果你使用自己部署的用户系统和排课系统，可参考以下信息集成。

## 技术原理

![](https://web-cdn.agora.io/docs-files/1672817279600)

如上图所示，如需要集成灵动课堂与你的用户系统及排课系统，你需要实现以下业务逻辑：

- 在你的服务端部署 RTM Token 生成器，通过声网 的 App ID，App 证书和用户 ID 参数生成 RTM Token。详情请参考[使用 AccessToken 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_upgrade_rtm?platform=All%20Platforms)。
- 设计一个 RESTful API，用于实现以下三个目的：
    - 验证登录 App 的用户是否在用户系统中存在。
    - 如存在该用户，获取该用户的用户信息与排课信息。
    - 获取 RTM Token 生成器为该用户签发的 RTM Token。
- 客户端获取到用户 ID，课堂 ID 和 RTM Token 后，根据[启动灵动课堂](agora_class_quickstart_web#%E5%90%AF%E5%8A%A8%E7%81%B5%E5%8A%A8%E8%AF%BE%E5%A0%82)调用 [声网 Classroom SDK](agora_class_api_ref_web) 的 launch 方法，传入用户 ID，课堂 ID，RTM Token 以及其他参数，启动灵动课堂。

## 注意事项

### 集成用户系统
需要将你自己的用户系统中的用户 ID（或用户 ID 的映射）传入灵动课堂，作为灵动课堂内用户的 `userUuid`。

灵动课堂的 `userUuid` 具有全局唯一性，即同一时间同一个 `userUuid` 只允许在一个设备的一个实例上登陆，再次登陆会将之前设备登录状态踢出。

相同 `userUuid` 在同一个 `roomUuid` 中的数据会被保留，即如果同一个 `userUuid` 在同一节课中更换了设备（如从浏览器登录切换到了手机 App 登录），该用户在该课堂中的信息仍会存在。

### 集成排课系统
需要将你自己的排课系统中的课堂 ID（或课堂 ID 的映射）传入灵动课堂，作为灵动课堂内课堂的 `roomUuid`。

灵动课堂的 `roomUuid` 是一次会话的概念。课堂会在第一位用户进入后自动创建，并在最后一位用户离开 1 小时后彻底销毁。

声网不会保存您的用户信息和课堂信息。在课堂销毁之后，如果你复用之前的 `roomUuid` 再次进入房间，将会得到一个全新的课堂，而不是之前的课堂。
<div class="alert info">声网不建议你复用 <code>roomUuid</code>，这样会导致无法区分两次会话。例如，给一年级 1 班学生排数学课，建议每次上课都使用新的 <code>roomUuid</code> 来创建新的会话，而不是一个学期每节数学课都复用同一个 <code>roomUuid</code>。</div>