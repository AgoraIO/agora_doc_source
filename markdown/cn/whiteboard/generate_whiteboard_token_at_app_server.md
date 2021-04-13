---
title: 在 app 服务端生成 Token 
platform: Android
updatedAt: 2021-04-01 03:08:54
---
互动白板 Token，包括不同权限的 SDK Token、Room Token 和 Task Token，是互动白板服务对用户采用的一种鉴权方式。详见[互动白板 Token 类型和权限](https://confluence.agoralab.co/pages/viewpage.action?pageId=713688237#id-4.2在App服务端生成Token-token)。



Agora 在 GitHub 提供一个开源的 [netless-token](https://github.com/netless-io/netless-token) 仓库，支持使用 Java、JavaScript、TypeScript、C#、Go、PHP、Ruby 等语言在你的服务端部署生成 SDK Token、Room Token、Task Token。

本文展示如何使用 Agora 提供的代码和你的访问密钥对（即 AK 和 SK）在业务服务端生成各种类型的互动白板 Token。


<div class="alert note">为提高项目的安全性，请勿将 AK 和 SK 保存或发送给客户端。你需要将 AK 和 SK 保存在业务服务端，并根据实际业务场景的需求，在业务服务端签发所需的 Token。</div>

##  前提条件

开始前，请确保你的 Agora 互动白板项目在控制台处于开启状态。

## 使用 JavaScript 示例代码快速生成 Token

Agora 在 `netless-token-master/Node/JavaScript` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 JavaScript 示例代码，其中：

- `index.js` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装最新版本的 Node.js LTS 版本。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/JavaScript` 文件夹，运行如下命令安装 Node.js 依赖。

    `npm install`

3. 新建 `sdktoken.js` 文件，将以下代码复制到该文件：

```
const  { sdkToken, TokenPrefix } = require("./index");
 
// 生成 SDK Token
const netlessSDKToken = sdkToken(
    "Your AK", // 将 Your AK 替换成你从控制台获取的 AK。
    "Your SK", // 将 Your SK 替换成你从控制台获取的 SK。
    1000 * 60 * 10, // Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。
    {
        role: 0 // Token 的权限，取值包括 0（Admin），1（Writer），2（Reader）。
    }
);
 
console.log(netlessSDKToken)
```

   

4. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `node sdktoken.js`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/JavaScript` 文件夹，运行如下命令安装 Node.js 依赖。

   `npm install`

3. 新建 `roomtoken.js` 文件，将以下代码复制到该文件：

   `const { roomToken, TokenPrefix } = require(``"./index"``);` `// 生成 Room Token``const netlessRoomToken = roomToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``role: 1, ``// Token 的权限，取值包括 0（Admin），1（Writer），2（Reader）。``    ``uuid: ``"房间 UUID"` `// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``  ``}``);` `console.log(netlessRoomToken)`

   

4. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `node roomtoken.js`

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Task Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/JavaScript` 文件夹，运行如下命令安装 Node.js 依赖。

   `npm install`

3. 新建 `tasktoken.js` 文件，将以下代码复制到该文件：

   `const { taskToken, TokenPrefix } = require(``"./index"``);` `// 生成 task token``const netlessTaskToken = taskToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``role: 1, ``// Token 的权限，取值包括 0（Admin），1（Writer），2（Reader）。``    ``uuid: ``"Task UUID"` `// 填入转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``  ``}``);` `console.log(netlessTaskToken)`

   

4. 运行如下命令生成 Task Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `node tasktoken.js`

## 使用 TypeScript 示例代码快速生成 Token

Agora 在 `netless-token-master/Node/TypeScript` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 TypeScript 示例代码，其中：

- `src/index.ts` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装最新版本的 Node.js LTS 版本。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/TypeScript` 文件夹，运行如下命令安装 TypeScript。

   `npm install -g typescript`

3. 新建 `sdktoken.ts` 文件，将以下代码复制到该文件：

   `import { sdkToken, TokenPrefix } from ``"./src/index"``;` `const netlessSDKToken = sdkToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``role: TokenRole.Admin ``// Token 的权限，可选值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``  ``}``);` `console.log(netlessSDKToken)`

4. 运行如下命令，生成相应的 `sdktoken.js` 文件。

   `tsc sdktoken.ts`

   

5. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `node sdktoken.js`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/TypeScript` 文件夹，运行如下命令安装 TypeScript。

   `npm install -g typescript`

3. 新建 `roomtoken.ts` 文件，将以下代码复制到该文件：

   `import { roomToken, TokenPrefix } from ``"./src/index"``;` `const netlessRoomToken = roomToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``role: TokenRole.Admin, ``// Token 的权限，可选值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``    ``uuid: ``"房间的 UUID"` `// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``  ``}``);` `console.log(netlessRoomToken)`

4. 运行如下命令，生成相应的 `room``token.js` 文件。

   `tsc roomtoken.ts`

   

5. 运行如下命令生成 Room Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `node roomtoken.js`

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Node/TypeScript` 文件夹，运行如下命令安装 TypeScript。

   `npm install -g typescript`

3. 新建 `tasktoken.ts` 文件，将以下代码复制到该文件：

   `import { taskToken, TokenPrefix } from ``"./src/index"``;` `const netlessTaskToken = taskToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``      ``role: TokenRole.Writer, ``// Token 的权限，可选值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``      ``uuid: ``"Task UUID"` `// 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``    ``}``);` `console.log(netlessTaskToken)`

4. 运行如下命令，生成相应的 `task``token.js` 文件。

   `tsc tasktoken.ts`

   

5. 运行如下命令生成 Task Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `node tasktoken.js`

## 使用 Java 示例代码快速生成 Token

Agora 在 `netless-token-master/Java` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 Java 示例代码，其中：

- `Token.java` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装 Java Development Kit。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Java` 文件夹，在 `Token.java` 文件中添加如下代码：

   `public` `static` `void` `main(String[] args) ``throws` `Exception {``  ``Map<String, String> map = ``new` `HashMap<>();``  ``// Token 的权限，取值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``  ``map.put(``"role"``, Token.TokenRole.Admin.getValue());` `  ``String sdkToken = Token.sdkToken(``    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``    ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``    ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``    ``map);` `  ``System.out.println(sdkToken);``}`

3. j进入 `Token.java` 所在路径，运行如下命令：

   `javac Token.java`

   

4. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `java Token`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Java` 文件夹，在 `Token.java` 文件中添加如下代码：

   `public` `static` `void` `main(String[] args) ``throws` `Exception {``  ``Map<String, String> map = ``new` `HashMap<>();``    ``// Token 的权限，可选值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``    ``map.put(``"role"``, Token.TokenRole.Reader.getValue());``    ``// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``    ``map.put(``"uuid"``, ``"房间的 UUID"``);` `  ``String roomToken = Token.roomToken(``    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``    ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``    ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``    ``map);` `  ``System.out.println(roomToken);``}`

3. j进入 `Token.java` 所在路径，运行如下命令：

   `javac Token.java`

   

4. 运行如下命令生成 Room Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `java Token`

### 生成 Task Token

你可以参考如下步骤，通过命令直接使用上述示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/Java` 文件夹，在 `Token.java` 文件中添加如下代码：

   `public` `static` `void` `main(String[] args) ``throws` `Exception {` `  ``Map<String, String> map = ``new` `HashMap<>();` `    ``// Token 的权限，可选值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。` `    ``map.put(``"role"``, Token.TokenRole.Writer.getValue());` `    ``// 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。` `    ``map.put(``"uuid"``, ``"文档转换任务的 UUID"``);`   `  ``String taskToken = Token.taskToken(` `    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。` `    ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。` `    ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。` `    ``map);`   `  ``System.out.println(taskToken);` `}`

3. j进入 `Token.java` 所在路径，运行如下命令：

   `javac Token.java`

   

4. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `java Token`

## 使用 Golang 示例代码快速生成 Token

Agora 在 `netless-token-master/golang` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 Golang 示例代码，其中：

- `token.go` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装最新版本的 Golang。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 新建 `sdktoken.go` 文件，将以下代码复制到该文件：

   `package main` `import (``  ``"fmt"``  ``"../golang"` `// 将 ../golang 替换成你的 token 包所在路径。``)` `func main() {``  ``c := token.SDKContent{``    ``// Token 的权限，可选值包括 token.AdminRole、token.ReaderRole、token.WriterRole。``    ``Role: token.AdminRole,``  ``}` `  ``netlessSDKToken := token.SDKToken(``    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``    ``"You SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``    ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``    ``&c,``  ``)` `   ``fmt.Println(netlessSDKToken)``}`

   

3. 进入 `sdktoken.go` 所在路径，运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `go sdktoken.go`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 新建 `roomtoken.go` 文件，将以下代码复制到该文件：

   `package main` `import (``  ``"fmt"``  ``"../golang"` `// 将 ../golang 替换成你的 token 包所在路径。``)` `func main() {``  ``c := token.RoomContent{``    ``// Token 的权限，可选值包括 token.AdminRole、token.ReaderRole、token.WriterRole。``    ``Role: token.AdminRole,``    ``// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``    ``Uuid: ``"房间的 uuid"``,``  ``}` `  ``netlessRoomToken := token.RoomToken(``    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``    ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``    ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``    ``&c,``  ``)` `   ``fmt.Println(netlessRoomToken)``}`

   

3. 进入 `roomtoken.go` 所在路径，运行如下命令生成 Room Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `go roomtoken.go`

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Task Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 新建 `tasktoken.go` 文件，将以下代码复制到该文件：

   `package main` `import (``  ``"fmt"``  ``"../golang"` `// 将 ../golang 替换成你的 token 包所在路径。``)` `func main() {``  ``c := token.TaskContent{``    ``// Token 的权限，可选值包括 token.AdminRole、token.ReaderRole、token.WriterRole。``    ``Role: token.WriterRole,``    ``// 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``    ``Uuid: ``"Task UUID"``,``  ``}` `  ``netlessTaskToken := token.TaskToken(``    ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``    ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``    ``1000 * 60 * 10, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``    ``&c,``  ``)` `   ``fmt.Println(netlessTaskToken)``}`

   

3. 进入 `tasktoken.go` 所在路径，运行如下命令生成 Task Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `go tasktoken.go`

## 使用 PHP 示例代码快速生成 Token

Agora 在 `netless-token-master/php` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 PHP 示例代码，其中：

- `Generate.php` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装 7.3 或以上版本的 PHP。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/php` 文件夹，新建 `sdktoken.php` 文件，将以下代码复制到该文件：

   `<?php` `// 引入 composer 管理的依赖包。``require __DIR__ . ``'/vendor/autoload.php'``;` `use Netless\Token\Generate;` `$netlessToken = ``new` `Generate;``$sdkToken = $netlessToken->sdkToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``array(``    ``"role"` `=> Generate::AdminRole ``// Token 的权限，可选值包括 AdminRole、WriterRole、ReaderRole。``  ``)``);` `echo $sdkToken;`

3. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `php sdktoken.php`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/php` 文件夹，新建 `room``token.php` 文件，将以下代码复制到该文件：

   `<?php` `// 引入 composer 管理的依赖包。``require __DIR__ . ``'/vendor/autoload.php'``;` `use Netless\Token\Generate;` `$netlessToken = ``new` `Generate;``$roomToken = $netlessToken->roomToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``array(``    ``"role"` `=> Generate::ReaderRole, ``// Token 的权限，可选值包括 AdminRole、WriterRole、ReaderRole。``    ``"uuid"` `=> ``"房间的 UUID"` `// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``  ``)``);` `echo $roomToken;`

3. 运行如下命令生成 Room Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `php roomtoken.php`

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Task Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/php` 文件夹，新建 `tasktoken.php` 文件，将以下代码复制到该文件：

   `<?php` `// 引入 composer 管理的依赖包。``require __DIR__ . ``'/vendor/autoload.php'``;` `use Netless\Token\Generate;` `$netlessToken = ``new` `Generate;``$roomToken = $netlessToken->roomToken(``  ``"Your AK"``, ``// 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``// 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``array(``    ``"role"` `=> Generate::ReaderRole, ``// Token 的权限，可选值包括 AdminRole、WriterRole、ReaderRole。``    ``"uuid"` `=> ``"任务的 UUID"` `// 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``  ``)``);` `echo $sdkToken;`

3. 运行如下命令生成 Task Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `php tasktoken.php`

## 使用 Ruby 示例代码快速生成 Token

Agora 在 `netless-token-master/ruby` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 Ruby 示例代码，其中：

- `token.rb `文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装 2.1 或以上版本的 Ruby。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/ruby` 文件夹，运行以下命令，安装 `uuidtools`。

   `gem install uuidtools`

3. 在 `ruby` 文件夹，新建 `sdktoken.rb` 文件，将以下代码复制到该文件：

   `require ``'./lib/token.rb'` `sdktoken = NetlessToken.sdk_token(``  ``"Your AK"``, ``# 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``# 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``# Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``:role` `=> NetlessToken::``ROLE``::``ADMIN` `# Token 的权限，可选值包括 ADMIN、WRITER、READER。``  ``}``)``puts sdktoken`

4. 运行如下命令生成 SDK Token。 生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

   `ruby sdktoken.rb`

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/ruby` 文件夹，运行以下命令，安装 `uuidtools`。

   `gem install uuidtools`

3. 在 `ruby` 文件夹，新建 `roomtoken.rb` 文件，将以下代码复制到该文件：

   `require ``'./lib/token.rb'` `roomtoken = NetlessToken.room_token(``  ``"Your AK"``, ``# 将 Your AK 替换成你从控制台获取的 AK。``  ``"Your SK"``, ``# 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``# Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``:role` `=> NetlessToken::``ROLE``::``ADMIN` `# Token 的权限，可选值包括 ADMIN、WRITER、READER。``    ``:uuid` `=> ``"房间的 UUID"` `# 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``  ``}``)``puts roomtoken`

4. 运行如下命令生成 Room Token。 生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

   `ruby roomtoken.rb`

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Task Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/ruby` 文件夹，运行以下命令，安装 `uuidtools`。

   `gem install uuidtools`

3. 在 `ruby` 文件夹，新建 `tasktoken.rb` 文件，将以下代码复制到该文件：

   `require ``'./lib/token.rb'` `tasktoken = NetlessToken.task_token(``  ``"Your AK"``, ``# 将 Your AK 替换成你从控制台获取的 AK。``  ``"netless sk"``, ``# 将 Your SK 替换成你从控制台获取的 SK。``  ``1000` `* ``60` `* ``10``, ``# Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``  ``{``    ``:role` `=> NetlessToken::``ROLE``::``ADMIN` `# Token 的权限，可选值包括 ADMIN、WRITER、READER。``    ``:uuid` `=> ``"房间的 UUID"` `# 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``  ``}``)``puts tasktoken`

4. 运行如下命令生成 Task Token。 生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。

   `ruby tasktoken.rb`

## 使用 C# 示例代码快速生成 Token

Agora 在 `netless-token-master/csharp` 文件夹下提供了生成 SDK Token、Room Token、Task Token 的 C# 示例代码，其中：

- `Token.cs` 文件包含用于生成互动白板 Token 的 API 源代码。
- `README.md` 文件包含用于生成互动白板 Token 的示例代码。

开始前请确保已安装最新版本的 Visual Studio。

### 生成 SDK Token

你可以参考如下步骤，使用示例代码生成 SDK Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/csharp` 文件夹，使用 Visual Studio 打开 `csharp.sln` 文件。

3. 在 `Program.cs` 的示例代码中填入你的 AK，SK，Token 有效期和 Token 的角色。

   `using` `System;``using` `Netless;` `class` `Program``{``  ``static` `void` `Main(``string``[] args)``  ``{``    ``string` `token = NetlessToken.SdkToken(``      ``// 将 Your AK 替换成你从控制台获取的 AK。``      ``"ak"``,``      ``// 将 Your SK 替换成你从控制台获取的 SK。``      ``"sk"``,``      ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``      ``1000 * 60 * 10,``      ``// Token 的权限，取值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``      ``new` `SdkContent(TokenRole.Admin));` `    ``Console.WriteLine(token);``  ``}``}`

4. 在 Visual Studio 中运行项目。生成的 Token 会显示在终端中，并带有 `NETLESSSDK_` 前缀。

### 生成 Room Token

你可以参考如下步骤，使用示例代码生成 Room Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/csharp` 文件夹，使用 Visual Studio 打开 `csharp.sln` 文件。

3. 将 `Program.cs` 文件中的代码删除，并将以下示例代码复制到该文件中：

   `using` `System;``using` `Netless;` `class` `Program``{``  ``static` `void` `Main(``string``[] args)``  ``{``    ``string` `token = NetlessToken.RoomToken(``      ``// 将 Your AK 替换成你从控制台获取的 AK。``      ``"ak"``,``      ``// 将 Your SK 替换成你从控制台获取的 SK。``      ``"sk"``,``      ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``      ``1000 * 60 * 10,``      ``// 设置 Token 的权限，取值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``      ``// 填入你的房间 UUID，可通过调用服务端创建房间 API 或获取房间列表 API 获取。``      ``new` `RoomContent(TokenRole.Admin, ``"房间的 UUID"``)``      ``);` `    ``Console.WriteLine(token);``  ``}``}`

4. 在 Visual Studio 中运行项目。生成的 Token 会显示在终端中，并带有 `NETLESSROOM_` 前缀。

### 生成 Task Token

你可以参考如下步骤，使用示例代码生成 Task Token。

1. 下载 [netless-token](https://github.com/netless-io/netless-token) 仓库或克隆至本地。

2. 进入 `netless-token-master/csharp` 文件夹，使用 Visual Studio 打开 `csharp.sln` 文件。

3. 将 `Program.cs` 文件中的代码删除，并将以下示例代码复制到该文件中：

   `using` `System;``using` `Netless;` `class` `Program``{``  ``static` `void` `Main(``string``[] args)``  ``{``    ``string` `token = NetlessToken.TaskToken(``      ``// 将 Your AK 替换成你从控制台获取的 AK。``      ``"ak"``,``      ``// 将 Your SK 替换成你从控制台获取的 SK。``      ``"sk"``,``      ``// Token 有效时间，单位为毫秒。设为 0 时，表示永不过期。``      ``1000 * 60 * 10,``      ``// 设置 Token 的权限，取值包括 TokenRole.Admin，TokenRole.Writer，TokenRole.Reader。``      ``// 填入文档转换任务的 UUID，可通过调用服务端发起文档转换任务 API 获取。``      ``new` `TaskContent(TokenRole.Admin, ``"任务的 UUID"``)``      ``);` `    ``Console.WriteLine(token);``  ``}``}`

4. 在 Visual Studio 中运行项目。生成的 Token 会显示在终端中，并带有 `NETLESSTASK_` 前缀。