为提高通信安全，Agora 互动白板使用 Token 对用户进行鉴权。



本文介绍 Agora 互动白板 Token 的类型与权限、生成方式和使用方法。

<a name="tokenoverview"></a>
## Token 类型与权限

Agora 互动白板 Token 按照级别由高至低分为 SDK Token、Room Token 和 Task Token，每个级别的 Token 均可设置 `admin`、`writer` 或 `reader` 角色。Token 的级别越高，包含的权限越多。你需要在 app 服务端签发 Token。

### SDK Token

SDK Token 与特定的互动白板项目绑定，是级别最高的 Token。持有 SDK Token 用户可操作绑定的项目下的所有房间和文档转换任务。不同角色的 SDK Token 具有的权限如下：

| 权限                                                         | admin（管理员）              | writer（读写）               | reader（只读）               |
| :----------------------------------------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| 创建房间                                                     | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 以互动模式加入房间                                           | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 以只读模式加入房间                                           | <font color="red">✘</font>   | <font color="red">✘</font>   | <font color="green">✔</font> |
| 获取房间列表                                                 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 获取房间信息                                                 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 封禁房间                                                     | <font color="green">✔</font> | <font color="red">✘</font>   | <font color="red">✘</font>   |
| 对指定场景进行截图                                           | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 对场景组下的所有场景进行截图                                 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 获取房间的场景地址列表                                       | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 插入新场景                                                   | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 场景跳转                                                     | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 发起文档转换任务                                             | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 生成同等或以下角色的 Room Token（例如，admin 角色的 SDK Token 可以生成 `admin`、`writer` 或 `reader` 角色的 Room Token） | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| 生成同等或以下角色的 Task Token（例如，admin 角色的 SDK Token 可以生成 `admin`、`writer` 或 `reader` 角色的 Task Token） | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |


<div class="alert note">SDK Token 的权限级别很高，如果泄漏，会危害你的业务安全。因此，Agora 建议：
<ul>
	<li>不要将 SDK Token 暴露给客户端、存入数据库或写入配置文件，而是在需要时从业务服务端签出 SDK Token。</li>
<li>不要签出永不过期的 SDK Token，而是根据业务需要，设置 SDK Token 的有效时长。</li>
	</ul>
</div>

### Room Token

Room Token 与特定互动白板项目下的特定房间绑定。持有 Room Token 的用户可操作绑定的房间。不同角色的 Room Token 具有的权限如下：

| 权限                         | admin（管理员）              | writer（读写）               | reader（只读）               |
| :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| 以互动模式加入特定房间       | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 以只读模式加入特定房间       | <font color="red">✘</font>   | <font color="red">✘</font>   | <font color="green">✔</font> |
| 获取特定房间信息             | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 封禁特定房间                 | <font color="green">✔</font> | <font color="red">✘</font>   | <font color="red">✘</font>   |
| 对指定场景进行截图           | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 对场景组下的所有场景进行截图 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 获取特定房间的场景地址列表   | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 在特定房间内插入新场景       | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |
| 特定房间内的场景跳转         | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font>   |

### Task Token

Task Token 与特定项目下的特定文档转换任务绑定。持有 Task Token 的用户可操作绑定的文档转换任务。不同角色的 Task Token 具有的权限如下：

| 权限                       | admin（管理员）              | writer（读写）               | reader（只读）               |
| :------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| 查询特定文档转换任务的进度 | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

## 生成 Token

你可以通过以下方式在业务服务端生成 Agora 互动白板 Token：

- 在 [Agora 控制台](https://console.netless.link/zh-CN/)生成 SDK Token。详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard)。
  
 <div class="alert note">该方法只能生成 <code>admin</code> 角色的永久 SDK Token。请勿将该 Token 下发给客户端，否则会有泄露的风险。</div>

- 在 app 服务端调用互动白板服务端 RESTful API，详见[使用 RESTful API 生成 Token](/cn/whiteboard/generate_whiteboard_token)。

- 在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server)（推荐）。

生成 Token 时，你需要传入以下参数：

- 访问密钥对（AK 和 SK）
- 角色
- 有效时长
- 房间的 UUID （仅生成 Room Token 需要）
- 转换任务的 UUID （仅生成 Task Token 需要）

### 获取访问密钥对

Agora 互动白板的访问密钥对包括 AK (Access Key）和 SK（Secret Key），可以通过以下方式获取：

1. 在 Agora 控制台的[项目管理](https://console.agora.io/projects)页面，选择已开启互动白板服务的项目，点击**编辑**。
2. 在**编辑项目**页面，找到**白板**，点击**配置**。
3. 在**白板配置**页面，找到 **AK** 和 **SK**，点击其右侧的眼睛图标，复制并自行保存白板项目的 **AK** 和 **SK**。
 ![](https://web-cdn.agora.io/docs-files/1616656748111)

<div class="alert note">访问密钥对一旦泄露，会造成严重的安全问题。为提高项目的安全性，Agora 建议：
<ul>
<li>绝对不要将访问密钥对发送给客户端，也不要将它们写死在代码里。确保只有业务服务器能从配置文件中读取访问密钥对。</li>
<li>如果访问密钥对有泄露的风险，请及时联系互动白板技术支持重新生成访问密钥对。</li></ul></div>

### 设置 Token 的角色

Agora 支持对 Token 设置 `admin`、`writer` 或 `reader` 角色，每种角色的 Token 具有的权限详见 <a href="#tokenoverview">Token 的类型与权限</a>。


<div class="alert note">为提高业务安全，Agora 建议：
<ul>
	<li>尽量避免将权限很高的 Token 下发给客户端。</li>
	<li> 对于必须下发到客户端的 Token，根据业务需要生成相应权限的 Token，尽量避免使用高级别的 Token 替代低级别的 Token。</li>
	</ul>
</div>

### 设置 Token 的有效时长

Agora 支持对 Token 设置有效时长，取值为正整数，单位为毫秒。生成 Token 的 UTC 时间加上你设置的有效时长，即 Token 的过期时间。Token 过期后，用户将无法再使用该 Token 加入房间或访问互动白板服务。为确保业务可用性，你需要及时在 app 服务端生成新的 Token。

<div class="alert info">已经加入房间的用户不会因为 Token 过期被移出房间。</div>

如果你不设置 Token 的有效时长或将有效时长设为 0，生成的 Token 将永不过期。

<div class="alert note">永不过期的 Token 可能为你的业务带来安全隐患。想象一下，如果非法用户获取了一个权限很高且永不过期的 Token，他就可以使用该 Token 危害你的系统，而你将该 Token 失效的唯一手段只有禁用生成该 Token 的访问密钥对——这是一个副作用极大的操作。因此，Agora 建议你根据业务需要预估客户端使用 Token 的最长期限，并将这个最长期限设为 Token 的有效时长。</div>

### 获取房间的 UUID

生成 Room Token 时，还需要传入房间的 UUID，即房间的全局唯一标识符，使 Room Token 与特定房间绑定。你可以通过以下方式获取房间的 UUID：

- 如果房间已经存在，你可以调用互动白板[获取房间列表 RESTful API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间列表（get）) 查询已创建的房间列表。请求成功后，响应包体中包含查询房间的 UUID。
- 如果房间尚未创建，你可以调用互动白板[创建房间 RESTful API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）)。请求成功后，响应包体中包含新创建房间的 UUID。

<div class="alert note">
如果你调用互动白板 RESTful API 生成 Room Token，请求头中的 SDK Token 必须和创建房间时使用的 SDK Token 相同。</br>

如果你在 app 服务端用代码生成 Room Token，传入的访问密钥对必须和创建房间时使用的 SDK Token 的访问密钥对相同。
</div>

### 获取转换任务的 UUID

生成 Task Token 时，还需要传入文档转换任务的 UUID，即文档转换任务的全局唯一标识符，使 Task Token 与特定的文档转换任务绑定。

要获取文档转换任务的 UUID， 你需要调用互动白板 RESTful API [发起文档转换任务](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）)。请求成功后，响应包体会包含转换任务的 UUID。

## 使用 Token

你需要根据 app 客户端的请求，在 app 服务端生成相应权限的 Token。当 app 客户端或服务端使用获取的 Token 访问 Agora 互动白板服务时，互动白板服务端会使用该 Token 校验其权限。

下面以 app 客户端请求加入房间和发起文档转换任务为例，介绍使用 Token 的步骤。

**当 app 客户端请求加入房间时**：

1. App 服务端调用互动白板 RESTful API 或在本地用代码生成 SDK Token。
2. App 服务端使用生成的 SDK Token 调用互动白板 RESTful API 创建房间。
3. Agora 互动白板服务端收到请求后，根据 Token 校验 app 服务端的权限。如果验证通过且成功创建房间，会向 app 服务端发送请求成功的响应。
4. App 服务端读取响应包体中房间 UUID，调用互动白板 RESTful API 或在本地用代码生成 Room Token。
5. App 服务端将 Room Token 和房间 UUID 下发给 app 客户端。
6. App 客户端使用获取的 Room Token 和 房间 UUID 等信息加入互动白板房间。
7. Agora 互动白板服务端收到 app 客户端的请求后，会根据 Room Token 等信息校验 app 客户端的权限。如果验证通过，该 app 客户端可以加入互动白板房间并使用相应的服务。

**当 app 客户端发起文档转换任务时**：

1. App 客户端发起文档转换任务时，app 服务端调用互动白板 RESTful API 或在本地用代码生成 SDK Token。

2. App 服务端使用生成的 SDK Token 调用互动白板 RESTful API 创建文档转换任务。

3. Agora 互动白板服务端收到请求后，根据 Token 校验 app 服务端的权限。如果验证通过且成功创建文档转换任务，会向 app 服务端发送请求成功的响应。

4. App 服务端读取响应包体中新建转换任务的 UUID，然后调用互动白板 RESTful API 或在本地用代码生成 Task Token。

5. App 服务端使用 Task Token 和转换任务 UUID 调用互动白板 RESTful API 查询转换任务的进度。

6. Agora 互动白板服务端收到 app 服务端的请求后，会根据 Task Token 等信息校验用户权限。如果验证通过且请求成功，会向 app 服务端返回文档转换任务的进度。


## Token 失效

Agora 互动白板 Token 在下列情形会失效：

- 禁用或删除项目。
  项目被禁用或删除后，与之关联的访问密钥对也会被禁用或删除，所有使用该访问密钥对生成的 Token 都会失效。
- Token 过期。
  Token 过期后，用户将无法再使用该 Token 加入互动白板房间或使用互动白板服务。

## Token 相关错误

在使用 Token 访问互动白板服务时，你可能会遇到以下报错：

| 错误信息                                                     | 说明                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `invalid format of token`                                    | Token 的数据格式错误。请检查 Token 数据格式是否有效：<li>Token 是否为 String 型。<li>Token 前后是否有多余空格或字符。<li>Token 的前缀是否正确：<ul><li>SDK Token 的前缀为 `NETLESSSDK_`</li><li>Room Token 的前缀为 `NETLESSROOM_`</li><li>Task Token 的前缀为 `NETLESSTASK_`</li></ul> |
| `expired token`                                              | Token 已过期。请在 app 服务端调用互动白板 RESTful API 或用代码重新生成 Token。 |
| `invalid signature of token`                                 | Token 的签名无效。当你使用在 app 服务端用代码生成的 Token 时，可能会遇到该报错。请确保使用正确的生成 Token 算法和代码。 |
| `unknow error`                                               | 未知错误。                                                   |
| `token access role$`</br>`{发送过来的 token 的权限} forbidden` | Token 的权限过低，例如，使用 `reader` 角色的 Token 请求 `writer` 角色的 Token 才能访问的服务。请确保发起的请求与使用的 Token 权限一致。 |
| `token access task forbidden`                                | 禁止使用该 Task Token 访问 Task UUID 对应的文档转换任务。请确保请求中传入的 Task UUID 和 Task UUID 相匹配，即传入的 Task UUID 和生成该 Task Token 的 Task UUID 一致。 |
| `token access room forbidden`                                | 禁止使用该 Room Token 访问 Room UUID 对应的互动白板房间。请确保请求中传入的 Room UUID 和 Room UUID 相匹配，即传入的 Room UUID 和生成该 Room Token 的 Room UUID 一致。 |
| `token access team forbidden`                                | 项目被删除或禁用，导致 Token 失效。                          |