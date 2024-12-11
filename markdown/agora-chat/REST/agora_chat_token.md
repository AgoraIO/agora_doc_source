# 使用 Token 鉴权

鉴权指对用户身份进行校验的过程。当你使用声网服务时，例如加入音视频通话、登录即时通讯系统，声网会使用 Token 对用户身份及权限进行验证。

为了保证即时通讯连接的安全性，声网提供以下两种场景的 Token 用于用户鉴权。

| 应用场景   | Token 权限 | Token 构成           | Token 最长有效期       |
| :------------ | :----- | :----------------------------------------- | :------- |
| RESTful API 调用 | App 权限   | <ul><li>你的即时通讯 IM 项目的 App ID。</li><li>你的即时通讯 IM 项目的 App 证书。</li><li>你设置的即时通讯 Token 的有效期。</li></ul> | 24 小时（以 UTC 时区为准） |
| SDK API 调用     | 用户权限   | <ul><li>你的即时通讯 IM 项目的 App ID。</li><li>你的即时通讯 IM 项目的 App 证书。</li><li> 你的即时通讯 IM 项目的 Token 有效期。</li><li>待鉴权用户的 ID。</li> |  24 小时（以 UTC 时区为准）                          |

## 体验 Token 生成

出于测试目的，声网控制台支持为即时通讯 IM 生成临时 Token，而在生产环境中，Token 需由你的 App Server 使用 AgoraTools 生成。

### 生成用户权限 Token

在测试环境中，用户权限 Token 基于用户 ID 生成。若尚未创建用户，需要首先注册即时通讯 IM 用户。

#### 注册用户

参考以下步骤注册用户：

1. 在**项目管理**页面，点击你要使用的项目的**操作**一栏中的**配置**。

![](https://web-cdn.agora.io/docs-files/1670827574193)

![](./images/quickstart/config_project.png)

2. 在**服务配置**页面，点击**即时通讯**中的**配置**。

![](https://web-cdn.agora.io/docs-files/1670827609516)

![](./images/quickstart/config_chat.png)

3. 在左侧导航栏，选择**运营管理** > **用户**，点击**创建IM用户**。

![](https://web-cdn.agora.io/docs-files/1670827634437)

![](./images/quickstart/user_mgmt.png)

4. 在**创建IM用户**对话框中，填写用户信息并点击**保存**，创建用户。

![](https://web-cdn.agora.io/docs-files/1670827653548)

![](./images/quickstart/create_user.png)

#### 生成 Token

在左侧导航栏选择**基本信息 > 应用信息**，在**数据中心**区域的 **Chat User Temp Token** 框中输入用户 ID，点击**生成**生成一个用户权限 Token，可用于调用 SDK 的 API。

![](./images/token/generate_user_token_ui.png)

### 生成 App 权限 Token

在左侧导航栏选择**基本信息 > 应用信息**，点击**数据中心**区域的 **Chat App Temp Token** 对应的 **生成** 生成一个 App 权限 Token，可用于调用 RESTful API。

![](https://web-cdn.agora.io/docs-files/1681094132023)

为了安全考虑，在生产环境中 Token 由你的 App Server 使用 AgoraTools 生成。本文介绍如何从你的 App Server 中获取 Token 实现用户鉴权。

## 技术原理

1. 使用 App 权限的 Token 鉴权的流程，如下图所示：

![](https://web-cdn.agora.io/docs-files/1683353354701)

[app_token_auth.png]

2. 使用用户权限 Token 鉴权的流程，如下图所示：

![](https://web-cdn.agora.io/docs-files/1683353376076)

[user_token_auth.png]

## 前提条件

- 有效的[声网账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建声网账号)。
- 拥有 [App 证书](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-App-证书)和已开通即时通讯的[声网项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建声网项目)。详见[开启和配置即时通讯服务](./enable_agora_chat)。
- 你的声网项目的 App ID、OrgName 和 AppName，详见[开启和配置即时通讯服务](./enable_agora_chat)。
- [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)。

如果你的网络环境部署了防火墙，为允许你在有网络访问限制的环境中使用即时通讯服务，声网提供防火墙白名单方案。如需使用请[联系技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)，我们的技术服务会提供目标域名及对应的端口。

## 实现鉴权流程

本节介绍使用即时通讯的 App 权限 Token 进行鉴权的完整流程：

<a name="deployserver"></a>

### 搭建 App Server 生成 Token

即时通讯 IM 的 Token 需要在你的 App Server 端部署生成。当客户端发送请求时，App Server 会生成相应的 Token。

本节展示如何使用 Java 语言在你的本地设备上搭建并运行一个 App Server。此示例服务器仅用于演示，请勿用于生产环境中。

下图为生成即时通讯 IM 的用户权限 Token 的 API 调用时序图：

![image-20240321144250563](/Users/easemob-dn0164/Library/Application Support/typora-user-images/image-20240321144250563.png)

1. 在 `IntelliJ` 中创建一个 Maven 项目，设置项目名称、选择项目储存路径后，点击 **Finish**。

2. 在 `<Project name>/pom.xml` 文件中，添加以下依赖并点击 [Reload project](https://www.jetbrains.com/help/idea/delegate-build-and-run-actions-to-maven.html#maven_reimport)：

   ```xml
   <properties>
       <java.version>11</java.version>
       <spring-boot.version>2.4.3</spring-boot.version>
   </properties>
   
   <packaging>jar</packaging>
   
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-dependencies</artifactId>
               <version>${spring-boot.version}</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter</artifactId>
       </dependency>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-configuration-processor</artifactId>
       </dependency>
       <dependency>
           <groupId>commons-codec</groupId>
           <artifactId>commons-codec</artifactId>
           <version>1.14</version>
       </dependency>
   
       <!-- agoraTools -->
       <dependency>
           <groupId>io.agora</groupId>
           <artifactId>authentication</artifactId>
           <version>2.0.0</version>
       </dependency>
   </dependencies>
   
   <build>
       <plugins>
           <plugin>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-maven-plugin</artifactId>
               <version>2.4.1</version>
               <executions>
                   <execution>
                       <goals>
                           <goal>repackage</goal>
                       </goals>
                   </execution>
               </executions>
           </plugin>
       </plugins>
   </build>
   ```
   
3. 在 `<Project name>/src/main/resource` 路径下创建 `application.properties` 配置文件存储用于生成 Token 的信息。你需要将该文件中的相关值替换你的声网项目的值并设置你的即时通讯 Token 的有效期，例如将 `expire.second` 设为 `6000`，即 Token 的有效期为 6000 秒。

   ```txt
   ## 服务器端口
   server.port=8090
   ## 填入你的声网项目的 App ID
   appid=
   ## 填入你的声网项目的 App 证书
   appcert=
   ## 设置 Token 的有效期，单位为秒，最长时间为 24 小时
   expire.second=
   ```

4. 在 `com.agora.chat.token` 路径下，创建 `AgoraChatTokenController.java` 类，将以下代码复制到该文件中：

```java
package com.agora.chat.token;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import io.agora.chat.ChatTokenBuilder2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.time.Duration;

@RestController
@CrossOrigin
public class AgoraChatTokenController {

    @Value("${appid}")
    private String appid;

    @Value("${appcert}")
    private String appcert;

    @Value("${expire.second}")
    private int expirePeriod;

    private Cache<String, String> agoraChatAppTokenCache;

    @PostConstruct
    public void init() {
        agoraChatAppTokenCache = CacheBuilder.newBuilder().maximumSize(1).expireAfterWrite(Duration.ofSeconds(expirePeriod)).build();
    }

    /**
     *
     * 获取 app 权限 token
     * @return app 权限 token
     */
    @GetMapping("/chat/app/token")
    public String getAppToken() {

        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            throw new IllegalArgumentException("appid or appcert is not empty");
        }

        return getAgoraChatAppTokenFromCache();
    }

    /**
     * 获取 user 权限 token
     * @param chatUserId chat 用户 id
     * @return user 权限 token
     */
    @GetMapping("/chat/user/{chatUserId}/token")
    public String getChatToken(@PathVariable String chatUserId) {

        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            throw new IllegalArgumentException("appid or appcert is not empty");
        }

        if (!StringUtils.hasText(chatUserId)) {
            throw new IllegalArgumentException("chatUserId is not empty");
        }

        ChatTokenBuilder2 builder = new ChatTokenBuilder2();
        return builder.buildUserToken(appid, appcert, chatUserId, expirePeriod);
    }

    /**
     * 生成 Agora Chat app token
     * @return Agora Chat app token
     */
    private String getAgoraAppToken() {
        if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
            throw new IllegalArgumentException("appid or appcert is not empty");
        }

        // Use agora App Id、App Cert to generate agora app token
        ChatTokenBuilder2 builder = new ChatTokenBuilder2();
        return builder.buildAppToken(appid, appcert, expirePeriod);
    }

    /**
     * 从缓存中获取 Agora Chat App Token
     * @return Agora Chat App Token
     */
    private String getAgoraChatAppTokenFromCache() {
        try {
            return agoraChatAppTokenCache.get("agora-chat-app-token", () -> {
                return getAgoraAppToken();
            });
        } catch (Exception e) {
            throw new IllegalArgumentException("Get Agora Chat app token from cache error");
        }
    }

}
```

5. 在 `com.agora.chat.token` 路径下，创建 `AgoraChatTokenStarter` 类，将以下代码复制到该文件中：

   ```java
   package com.agora.chat.token;
   
   import org.springframework.boot.SpringApplication;
   import org.springframework.boot.autoconfigure.SpringBootApplication;
   
   @SpringBootApplication(scanBasePackages = "com.agora")
   public class AgoraChatTokenStarter {
       public static void main(String[] args) {
           SpringApplication.run(AgoraChatTokenStarter.class, args);
       }
   }
   ```

6. 启动 App Server。点击图中绿色三角标识，选择 `Debug "AgoraChatTokenStarter..." `。

  ![](https://web-cdn.agora.io/docs-files/1670990071861)

   [agra_chat_token_starter.png]

### 使用 Token 调用即时通讯 RESTful API

本节介绍如何获取 App 权限 Token 并调用即时通讯 RESTful API 在你的 App 中注册一个新用户。

在 App Server 中生成 App 权限 Token 的核心代码如下：

```java
// 生成 App 权限 token，参数 appid 和 appcert 分别为声网项目的 App ID 和 App 证书，expirePeriod 为 Token 有效期。
ChatTokenBuilder2 builder = new ChatTokenBuilder2();
return builder.buildAppToken(appid, appcert, expirePeriod);
```

1. 获取即时通讯 Token。在终端中，使用 curl 命令向你的 App Server 发送 GET 请求获取即时通讯 Token：

   ```shell
   curl http://localhost:8090/chat/app/token
   ```

   你的 App Server 会返回一个即时通讯 Token，如下所示：

   ```shell
   007eJxTYPj3p2Tnb4tznzxfO/0LK5cu/GZmI71PnWPVkbVhP/aniEspMBhbJJqnGKclmVsYJ5kYWBhbJqcapqRZpJmbm5ikGRsnnT12OrGhN5pB97zpVEYGVgZGBiYGEJ+BAQBN0CGG
   ```

2. 使用即时通讯 Token 调用即时通讯 RESTful API 注册一个新用户。在终端中，使用 curl 命令向即时通讯服务器发送请求注册一个新用户，示例如下：

   ```shell
   curl -X POST -H "Authorization: Bearer <YourAgoraAppToken>" -i "https://XXXX/XXXX/XXXX/users" -d '[
       {
           "username": "user1",
           "password": "123",
           "nickname": "testuser"
       }
   ]'
   ```

   响应体参数中包含请求注册的新用户的相关信息，示例如下：

   ```shell
    {
          "action": "post",
          "application": "8be024f0-e978-11e8-b697-5d598d5f8402",
          "path": "/users",
          "uri": "https://a1.agora.com/XXXX/XXXX/users",
          "entities": [
              {
                  "uuid": "0ffe2d80-ed76-11e8-8d66-279e3e1c214b",
                  "type": "user",
                  "created": 1542795196504,
                  "modified": 1542795196504,
                  "username": "user1",
                  "activated": true,
                  "nickname": "testuser"
              }
          ],
          "timestamp": 1542795196515,
          "duration": 0,
          "organization": "XXXX",
          "applicationName": "XXXX"
      }
   ```

### 使用 Token 登录即时通讯 IM

本节以 Web 客户端为例，介绍如何使用用户权限 Token 在客户端进行鉴权。

请联系商务开通自动注册即使通讯 IM 用户的功能，这样可以使用 chatUserId 生成用户权限 Token 后，在登录即时通讯 IM 时，如果 chatUserId 未注册，那么IM 服务会自动使用 chatUserId 进行注册 IM 用户并登录。chatUserId 请符合 IM 用户名的规范。

在 App Server 中生成用户权限 Token 的核心代码：

```java
// 生成 App 权限 Token，参数 appid 和 appcert 分别为声网项目的 App ID 和 App 证书，expirePeriod 为 token 的有效期，chatUserId 为即时通讯 IM 用户 ID
ChatTokenBuilder2 builder = new ChatTokenBuilder2();
return builder.buildUserToken(appid, appcert, chatUserId, expirePeriod);
```

在 pom.xml 中引入 AgoraTools 依赖:

```
<dependency>
    <groupId>io.agora</groupId>
    <artifactId>authentication</artifactId>
    <version>2.0.0</version>
</dependency>
```

为展示鉴权流程，本节介绍如何在你的本地搭建并运行一个 Web 客户端。此客户端仅用于演示，请勿用于生产环境中。

参考以下步骤实现一个 Web 客户端：

1. 创建 `Agora Chat Web app` 文件夹。一个 Web 客户端项目至少需包含以下文件：

   - `index.html`: 用于设计 Web 应用的用户界面。
   - `index.js`: 实现具体应用逻辑的代码。
   - `webpack.config.js`: webpack 配置。

2. 将以下代码复制到 `webpack.config.js` 文件中配置 webpack：

   ```javascript
    const path = require('path');
   
    module.exports = {
        entry: './index.js',
        mode: 'production',
        output: {
            filename: 'bundle.js',
            path: path.resolve(__dirname, './dist'),
        },
        devServer: {
            compress: true,
            port: 9000,
            https: true
        }
    };
   ```

3. 为你的 Web app 安装 npm 包。打开终端，进入到你的项目的根目录，运行 `npm init` 命令创建 `package.json` 文件。

4. 添加项目依赖。将以下代码复制到 `package.json` 文件：

   ```json
   {
      "name": "web",
      "version": "1.0.0",
      "description": "",
      "main": "index.js",
      "scripts": {
        "build": "webpack --config webpack.config.js",
        "start:dev": "webpack serve --open --config webpack.config.js"
      },
      "keywords": [],
      "author": "",
      "license": "ISC",
      "dependencies": {
        "agora-chat": "latest"
      },
      "devDependencies": {
        "webpack": "^5.50.0",
        "webpack-cli": "^4.8.0",
        "webpack-dev-server": "^3.11.2"
      }
   }
   ```

5. 创建 UI。将 `index.html` 文件中的内容替换为以下代码：

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <title>Agora Chat Token demo</title>
     </head>
   
     <body>
       <h1>Token demo</h1>
       <div class="input-field">
         <label>Username</label>
         <input type="text" placeholder="Username" id="username" />
       </div>
       <div>
         <button type="button" id="login">Login</button>
       </div>
       <div id="log"></div>
       <script src="./dist/bundle.js"></script>
     </body>
   </html>
   ```

6. 实现 App 逻辑。

   复制以下代码到 `index.js` 文件中，将 `<Your App Key>` 替换为你的 [App Key](./enable_agora_chat#获取即时通讯项目信息) 。

   在下列示例代码中可以看到，就客户端而言，用户权限 Token 和以下代码逻辑有关：

   - 调用 `open`，使用 Token 和用户名登录即时通讯 IM 系统。
   - 当 Token 即将过期或已经过期时，从 App Server 重新获取新的 Token 并调用 `renewToken` 更新 Token。即时通讯 IM 建议你定期（例如每小时）生成一个 Token 并调用 `renewToken` 更新 Token，确保 Token 的有效性。

   ```js
   import WebIM from "agora-chat-sdk";
   WebIM.conn = new WebIM.connection({
    appKey: "<Your App Key>",
   });
   // 登录即时通讯 IM
   let username;
   document.getElementById("login").onclick = function () {
    username = document.getElementById("username").value.toString();
    // 用用户名信息获取即时通讯 IM 用户权限 Token
    fetch(`http://localhost:8090/chat/user/${username}/token`)
      .then((res) => res.text())
      .then((token) => {
        // 通过用户名和 Token 登录即时通讯
        WebIM.conn.open({
          user: username,
          agoraToken: token,
        });
      });
   };
   // 添加回调函数
   WebIM.conn.addEventHandler("AUTHHANDLER", {
   // 连接成功回调
    onConnected: () => {
      document
        .getElementById("log")
        .appendChild(document.createElement("div"))
        .append("Connect success !");
    },
   // 收到文本消息
    onTextMessage: (message) => {
      console.log(message);
      document
        .getElementById("log")
        .appendChild(document.createElement("div"))
        .append("Message from: " + message.from + " Message: " + message.data);
    },
    // Token 即将过期
    onTokenWillExpire: (params) => {
      document
        .getElementById("log")
        .appendChild(document.createElement("div"))
        .append("Token is about to expire");
      refreshToken(username);
    },
    // Token 已过期
    onTokenExpired: (params) => {
      document
        .getElementById("log")
        .appendChild(document.createElement("div"))
        .append("The token has expired");
      refreshToken(username);
    },
    onError: (error) => {
      console.log("on error", error);
    },
   });
   // 更新 Token
   function refreshToken(username) {
    fetch(`http://localhost:8090/chat/user/${username}/token`)
      .then((res) => res.text())
      .then((token) => {
        WebIM.conn.renewToken(token);
      }
    );
   }
   ```

7. 编译并运行你的项目。

   1. 运行 `npm install` 命令安装依赖。

   2. 运行以下命令来使用 webpack 编译并运行你的项目：

      ```shell
      # 用 webpack 打包项目
      npm run build
      
      # 用 webpack-dev-server 测试运行项目
      npm run start:dev
      ```

      `index.tml` 会自动在你的浏览器中打开。

   3. 输入用户名，点击 **Login**。

      打开浏览器的控制台，你可以看到 Web 客户端有以下行为：

      - 生成一个用户权限 Token。
      - 连接即时通讯 IM 系统。
      - 在 Token 即将过期时更新 Token。

## 更多信息

本节介绍 Token 生成器代码库、版本要求以及 Token 相关的其他文档。

### Token 生成器代码库

即时通讯 IM 在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。

Java AgoraTools 依赖:

```
<dependency>
    <groupId>io.agora</groupId>
    <artifactId>authentication</artifactId>
    <version>2.0.0</version>
</dependency>
```

### Token 过期

即时通讯 Token 的最长有效期为 24 小时。

Token 即将过期或已经过期后，即时通讯 IM SDK 会分别触发 `onTokenWillExpire` 或 `onTokenExpired` 回调。你需要在 app 逻辑中添加如下操作：

1. App 识别即将过期或已经过期的是哪类权限的 Token。
2. App 从 App Server 获取新的 Token。 
3. SDK 调用 `renewToken` 更新 Token。

### 实现 Token 过期后自动重连

Token 过期后自动重连可确保终端用户在后台运行应用时保持即时通讯服务的连接状态，重新进入应用时无需再次登录。实现该功能的流程如下：

1. [搭建 App Server 生成 Token 并提供获取 Token 的 API]((#deployserver))。
2. 在你的 App 端实现对 Token 过期的判断。当 Token 过期时，你的 App 需通过获取 Token 的 API 获取新的 Token，重新登录声网服务器。

### Token 和 RTC 产品

如果你在使用即时通讯 IM 的同时也正在使用[声网 RTC SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk)，即时通讯 IM 建议你升级到 [Access Token 2](./access_token_2)。