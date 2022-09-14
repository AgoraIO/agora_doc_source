# 使用 Token 鉴权

鉴权指对用户身份进行校验的过程。当你使用 Agora 服务时，例如加入音视频通话、登录即时通讯系统，Agora 会使用 Token 对用户身份及权限进行验证。

为了保证即时通讯连接的安全性，Agora 提供 Token 用于用户鉴权。 Token 由你的 App Server 使用 AgoraTools 生成，用于以下两种场景：

<table style="width: 657px;">
<tbody>
<tr>
<td style="width: 138px;">
<p>应用场景</p>
</td>
<td style="width: 138px;">
<p>Token 权限</p>
</td>
<td style="width: 215px;">
<p>Token 构成</p>
</td>
<td style="width: 138px;">
<p>Token 最长有效期</p>
</td>
</tr>
<tr>
<td style="width: 138px;">
<p>RESTful API 调用</p>
</td>
<td style="width: 138px;">
<p>App 权限</p>
</td>
<td style="width: 215px;">
<ul>
<li>你的即时通讯 IM 项目的 App ID。</li>
<li>你的即时通讯 IM 项目的 App 证书。</li>
<li>你设置的即时通讯 Token 的有效期。</li>
</ul>
</td>
<td style="width: 138px;" rowspan="2">
<p>24 小时（以 UTC 时区为准）</p>
</td>
</tr>
<tr>
<td style="width: 138px;">
<p>SDK API 调用</p>
</td>
<td style="width: 138px;">
<p>用户权限</p>
</td>
<td style="width: 215px;">
<ul>
<li>你的即时通讯 IM 项目的 App ID。</li>
<li>你的即时通讯 IM 项目的 App 证书。</li>
<li>待鉴权用户的 UUID。UUID 是通过[用户注册 RESTful API](./agora_chat_restful_registration#注册单个用户) 为每个用户所生成的唯一内部标识。</li>
</ul>
</td>
</tr>
</tbody>
</table>

本文介绍如何从你的 App Server 中获取 Token 实现用户鉴权。

## 技术原理 

1. 使用 App 权限的 Token 鉴权的流程，如下图所示：

![img](./images/token/app_token_auth.png)

2. 使用用户权限 Token 鉴权的流程，如下图所示：

![img](./images/token/user_token_auth.png)


## 前提条件

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 拥有 [App 证书](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)和已开通即时通讯的 [Agora 项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。详见[开启和配置即时通讯服务](./enable_agora_chat)开通即时通讯服务。
- 你的 Agora 项目的 App ID、OrgName、AppName，详见[开启和配置即时通讯服务](./agora-chat/enable_agora_chat)。
- [Node.js 和 npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)。

如果你的网络环境部署了防火墙，为允许你在有网络访问限制的环境中使用即时通讯服务，Agora 提供防火墙白名单方案。如需使用请[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会提供目标域名及对应的端口。

## 实现鉴权流程

本节介绍使用即时通讯 App Token 进行鉴权的完整流程：

### 搭建 App Server 生成 Token

即时通讯 IM 的 Token 需要在你的 App Server 端部署生成。当客户端发送请求时，App Server 会生成相应的 Token。

本节展示如何使用 Java 语言在你的本地设备上搭建并运行一个 App Server。此示例服务器仅用于演示，请勿用于生产环境中。

下图为生成即时通讯 IM 的用户权限 Token 的 API 调用时序图： 

![img](./images/token/generate_user_token.png)

1. 在 `IntelliJ` 中创建一个 Maven 项目，设置项目名称、选择项目储存路径后，点击 **Finish**。

2. 在 `<Project name>/pom.xml` 文件中，添加以下依赖并点击 [Reload project](https://www.jetbrains.com/help/idea/delegate-build-and-run-actions-to-maven.html#maven_reimport)：

   ```xml
   <properties>
       <java.version>1.8</java.version>
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

3. 将 token builders 导入到你的项目中：

   1. 下载 [chat](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) 和 [media](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) 文件包。

   2. 在你的项目中 `<Project name>/src/main/java` 路径下，创建 `com.agora.chat.token.io.agora` 文件包。

   3. 将 `chat` 和 `media` 文件包复制到 `com.agora.chat.token.io.agora` 文件包中。此时你的项目结构应如下图所示：

      ![](https://web-cdn.agora.io/docs-files/1638864182234)

   4. 解决 `chat/ChatTokenBuilder2` 和 `media/AccessToken` 文件中的报错。

      - 在 `ChatTokenBuilder2` 中，将 `package io.agora.chat;` 修改为 `package com.agora.chat.token.io.agora.chat;`，将 `import io.agora.media.AccessToken2;` 修改为 `import com.agora.chat.token.io.agora.media.AccessToken2;`。
      - 对于 `com.agora.chat.token.io.agora.media` 包中的全部文件，将 `package io.agora.media;` 修改为 `package com.agora.chat.token.io.agora.media;`。
      - 在 `AccessToken` 中，将 `import static io.agora.media.Utils.crc32;` 修改为 `import static com.agora.chat.token.io.agora.media.Utils.crc32`。

4. 在 `<Project name>/src/main/resource` 路径下创建 `application.properties` 配置文件存储用于生成 Token 的信息。你需要将该文件中的相关值替换你的 Agora 项目的值并设置你的即时通讯 Token 的有效期，例如将 `expire.second` 设为 `6000`，即 Token 的有效期为 6000 秒。

    ```txt
    ## 服务器端口
    server.port=8090
    ## 填入你的 Agora 项目的 App ID
    appid=
    ## 填入你的 Agora 项目的 App 证书
    appcert=
    ## 设置 Token 的有效期，单位为秒，最长时间为 24 小时
    expire.second=
    ## 填入你的 Agora 项目的 App Key
    appkey=
    ## 填入即时通讯 IM 的 REST API 域名
    domain=
    ```

 关于如何获取 App Key 和获取 RESTful API 请求域名，详见[获取即时通讯项目信息](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms#获取即时通讯项目信息)。


5. 在 `com.agora.chat.token` 路径下，创建 `AgoraChatTokenController.java` 类，将以下代码复制到该文件中：

   ```java
    package com.agora.chat.token;

    import com.agora.chat.token.io.agora.chat.ChatTokenBuilder2;
    import com.agora.chat.token.io.agora.media.AccessToken2;
    import org.springframework.beans.factory.annotation.Value;
    import org.springframework.http.*;
    import org.springframework.util.StringUtils;
    import org.springframework.web.bind.annotation.CrossOrigin;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.PathVariable;
    import org.springframework.web.bind.annotation.RestController;
    import org.springframework.web.client.RestClientException;
    import org.springframework.web.client.RestTemplate;

    import java.util.Collections;
    import java.util.HashMap;
    import java.util.List;
    import java.util.Map;

    @RestController
    @CrossOrigin
    public class AgoraChatTokenController {

        @Value("${appid}")
        private String appid;

        @Value("${appcert}")
        private String appcert;

        @Value("${expire.second}")
        private int expire;

        @Value("${appkey}")
        private String appkey;

        @Value("${domain}")
        private String domain;

        private final RestTemplate restTemplate = new RestTemplate();


        /**
        * 请求 App 权限 Token
        * @return token
        */
        @GetMapping("/chat/app/token")
        public String getAppToken() {
            if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
                return "appid or appcert is not empty";
            }

            // 生成 App 权限 token
            AccessToken2 accessToken = new AccessToken2(appid, appcert, expire);
            AccessToken2.Service serviceChat = new AccessToken2.ServiceChat();
            serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_APP, expire);
            accessToken.addService(serviceChat);

            try {
                return accessToken.build();
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }

        // 获取用户权限 Token
        @GetMapping("/chat/user/{chatUserName}/token")
        public String getChatUserToken(@PathVariable String chatUserName) {
            if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
                return "appid or appcert is not empty";
            }
            if (!StringUtils.hasText(appkey) || !StringUtils.hasText(domain)) {
                return "appkey or domain is not empty";
            }
            if (!appkey.contains("#")) {
                return "appkey is illegal";
            }
            if (!StringUtils.hasText(chatUserName)) {
                return "chatUserName is not empty";
            }
            ChatTokenBuilder2 builder = new ChatTokenBuilder2();
            String chatUserUuid = getChatUserUuid(chatUserName);
            if (chatUserUuid == null) {
                chatUserUuid = registerChatUser(chatUserName);
            }

            // 生成用户权限 Token
            AccessToken2 accessToken = new AccessToken2(appid, appcert, expire);
            AccessToken2.Service serviceChat = new AccessToken2.ServiceChat(chatUserUuid);
            serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_USER, expire);
            accessToken.addService(serviceChat);

            try {
                return accessToken.build();
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }

        // 获取用户名对应的 UUID
        private String getChatUserUuid(String chatUserName) {
            String orgName = appkey.split("#")[0];
            String appName = appkey.split("#")[1];
            String url = "http://" + domain + "/" + orgName + "/" + appName + "/users/" + chatUserName;
            HttpHeaders headers = new HttpHeaders();
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            headers.setBearerAuth(getAppToken());
            HttpEntity<Map<String, String>> entity = new HttpEntity<>(null, headers);
            ResponseEntity<Map> responseEntity = null;
            try {
                responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
            } catch (Exception e) {
                System.out.println("get chat user error : " + e.getMessage());
            }
            if (responseEntity != null) {
                List<Map<String, Object>> results = (List<Map<String, Object>>) responseEntity.getBody().get("entities");
                return (String) results.get(0).get("uuid");
            }
            return null;
        }

        // 创建用户，密码为 "123"，然后获取 UUID。
        private String registerChatUser(String chatUserName) {
            String orgName = appkey.split("#")[0];
            String appName = appkey.split("#")[1];
            String url = "http://" + domain + "/" + orgName + "/" + appName + "/users";
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            headers.setBearerAuth(getAppToken());
            Map<String, String> body = new HashMap<>();
            body.put("username", chatUserName);
            body.put("password", "123");
            HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
            ResponseEntity<Map> response;
            try {
                response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
            } catch (Exception e) {
                throw new RestClientException("register chat user error : " + e.getMessage());
            }
            List<Map<String, Object>> results = (List<Map<String, Object>>) response.getBody().get("entities");
            return (String) results.get(0).get("uuid");
        }
    }
   ```

6. 在 `com.agora.chat.token` 路径下，创建 `AgoraChatTokenStarter` 类，将以下代码复制到该文件中：

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

7. 启动 App Server。点击图中绿色三角标识，选择 `Debug "AgoraChatTokenStarter..." `。

   ![](https://web-cdn.agora.io/docs-files/1638868741690)


### 使用 Token 调用即时通讯 RESTful API

本节介绍如何获取 App 权限 Token 并调用即时通讯 RESTful API 在你的 App 中注册一个新用户。

在 App Server 中生成 App 权限 Token 的核心代码如下：

```java
// 生成 App 权限 token，参数 appid 和 appcert 分别为 Agora 项目的 App ID 和 App 证书，expire 为 Token 有效期。
AccessToken2 accessToken = new AccessToken2(appid, appcert, expire);
AccessToken2.Service serviceChat = new AccessToken2.ServiceChat();
serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_APP, expire);
accessToken.addService(serviceChat);

try {
    return accessToken.build();
} catch (Exception e) {
    e.printStackTrace();
    return "";
}
```


1. 获取即时通讯 Token。在终端中，使用 curl 命令向你的 App Server 发送 GET 请求获取即时通讯 Token：

   ```shell
   curl http://localhost:8090/chat/app/token
   ```

   你的 App Server  会返回一个即时通讯 Token，如下图所示：

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

在 App Server 中生成用户权限 Token 的核心代码：

```java
// 生成 App 权限 Token，参数 appid 和 appcert 分别为 Agora 项目的 App ID 和 App 证书，expire 为 token 的有效期，chatUserUuid 为即时通讯 IM 用户的 UUID
AccessToken2 accessToken = new AccessToken2(appid, appcert, expire);
AccessToken2.Service serviceChat = new AccessToken2.ServiceChat(chatUserUuid);

serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_USER, expire);
accessToken.addService(serviceChat);

try {
    return accessToken.build();
} catch (Exception e) {
    e.printStackTrace();
    return "";
}
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

4. 添加项目依赖。将以下代码复制到  `package.json` 文件：

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
        "agora-chat-sdk": "latest"
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

   复制以下代码到 `index.js` 文件中，将 `<Your App Key>` 替换为你的 App Key。

   在下列示例代码中可以看到，就客户端而言，用户权限 Token 和以下代码逻辑有关：

   - 调用 `open` ，使用 Token 和用户名登录即时通讯 IM 系统。需使用注册时所输入的用户名获得 UUID。

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

### API 参考

本节以 Java 为例，介绍生成即时通讯 Token 的方法。

- 生成用户权限 Token

```java
public String buildUserToken(String appId, String appCertificate, String uuid, int expire) {
     AccessToken2 accessToken = new AccessToken2(appId, appCertificate, expire);
     AccessToken2.Service serviceChat = new AccessToken2.ServiceChat(uuid);
     serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_USER, expire);
     accessToken.addService(serviceChat);
     try {
         return accessToken.build();
     } catch (Exception e) {
         e.printStackTrace();
         return "";
     }
 }
```
- 生成 App 权限 Token

```java
public String buildAppToken(String appId, String appCertificate, int expire) {
        AccessToken2 accessToken = new AccessToken2(appId, appCertificate, expire);
        AccessToken2.Service serviceChat = new AccessToken2.ServiceChat();

        serviceChat.addPrivilegeChat(AccessToken2.PrivilegeChat.PRIVILEGE_CHAT_APP, expire);
        accessToken.addService(serviceChat);

        try {
            return accessToken.build();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

```

### Token 过期   

即时通讯 Token 的最长有效期为 24 小时。

权限即将过期或已经过期后，SDK 会分别触发 `onTokenWillExpire` 或 `onTokenExpired` 回调。你需要在 app 逻辑中添加如下操作：

- 识别即将过期或已经过期的是哪类权限。
- App 从 Token 服务器获取新的 AccessToken2。
= SDK 调用 `renewToken` 以更新 AccessToken2。


### Token 和 RTC 产品

如果你在使用即时通讯 IM 的同时也正在使用 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk)，即时通讯 IM 建议你升级到 [Access Token 2](https://docs-preprod.agora.io/cn/agora-chat/access_token_2?platform=All%20Platforms)。
