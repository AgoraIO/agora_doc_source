鉴权指对用户身份进行校验的过程。当你使用 Agora 服务时，例如加入音视频通话、登录 Agora Chat，Agora 会使用 Token 来对用户身份及权限进行核验。

为保证 Agora Chat 连接的安全性，Agora 提供两种类型的 Token 进行鉴权：

- User token：针对拥有 app 用户级别权限的用户进行鉴权。例如，当用户登录集成了 Agora Chat SDK 的 app 时，需通过 User Token 进行鉴权。
- App token：针对拥有 app 管理员级别权限的用户进行鉴权。管理员级别权限为最高权限，可以对整个 app 进行管理，例如创建或删除用户。详见[使用 App Token 鉴权](https://docs-preprod.agora.io/cn/agora-chat/generate_app_tokens?platform=All%20Platforms)。 

本文介绍如何搭建一个 Agora Chat User Token 服务器以及一个 Agora Chat app。客户端向 Token 服务器请求 Token，用获取到的 Token 登录 Agora Chat app。

## 技术原理

下图展示了使用 User Token 鉴权的流程：

![](https://web-cdn.agora.io/docs-files/1642577168336)

User Token 是一种动态密钥，由你的 app 服务器生成，最长有效期为 24 小时。当客户端 app 的用户登录时，Agora Chat 服务器会对读取包含在 token 中的信息并进行鉴权。一个 User token 中包含以下信息：

- 你的 Agora 项目的 App ID。
- 你的 Agora 项目的 App 证书。
- 待鉴权用户的 UUID。UUID 是通过[用户注册 RESTful API](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_restful_reg?platform=RESTful#注册单个用户) 为每一个用户所生成的独有的内部标识。

- 你设置 User Token 的有效期。

## 前提条件

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 已开通 Agora Chat 的 [Agora 项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。详见[开启和配置即时通讯服务](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms)开通 Agora Chat。
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)。

## 实现鉴权流程

本节介绍如何生成并使用 User Token 对拥有用户级别权限的用户进行鉴权。拥有用户级别权限的用户仅可使用 app 的部分功能。生成 User Token 的加密源代码由 Agora 提供。

### 搭建 User Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，Token 服务器会生成相应的 Token。

本节展示如何使用 Java 语言在你的本地设备上搭建并运行一个 Token 服务器。

下图展示生成 Agora Chat User Token 的 API 调用时序图：

![](https://web-cdn.agora.io/docs-files/1642576341028)

此示例服务器仅用于演示，请勿用于生产环境中。

1. 在 IntelliJ 中创建一个 Maven 项目，设置项目名称、选择项目储存路径后，点击 **Finish**。

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

      1. 下载 [chat](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) 和 [media](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) 文件包。

      2. 在你的项目中 `<Project name>/src/main/java` 路径下，创建一个文件包，名为 `com.agora.chat.token.io.agora`。

      3. 将 chat 和 media 文件包复制到 `com.agora.chat.token.io.agora` 文件包中。此时你的项目文件结构应如下图所示：

         ![token server project](https://web-cdn.agora.io/docs-files/1639043760281)

      4. 解决 `chat/ChatTokenBuilder2` 和 `media/AccessToken` 文件中的报错。

         - 在 `ChatTokenBuilder2` 中，将 import 修改为 `import com.agora.chat.token.io.agora.media.AccessToken2`。

         - 在 `AccessToken` 中，将 import 修改为如下所示：

           ```java
            import java.io.ByteArrayOutputStream;
                   import java.io.IOException;
                   import java.util.TreeMap;
                   
                   import static com.agora.chat.token.io.agora.media.Utils.crc32;
           ```

   4. 在 `<Project name>/src/main/resource` 路径下创建 `application.properties` 配置文件。你需要将该文件中的相关值替换你的 Agora 项目的值并设置 Token的有效期。填入 `appid`、 `appcert`、`appkey` 的值时无需加 `“”`。

      ```txt
      ## Server port
      server.port=8090
      ## Fill the App ID of your Agora project
      appid=
      ## Fill the app certificate of your Agora project
      appcert=
      ## Fill the app key of the Agora Chat service
      appkey=
      ## REST API domain for the Agora Chat service
      domain=
      ## Set the valid duration (in seconds) for the token
      expire.second=60
      ```

   5. 在  `com.agora.chat.token` 路径下，创建一个名为 `AgoraChatTokenController.java` 文件，并将以下代码复制到该文件中：

      ```java
      package com.agora.chat.token;
      import com.agora.chat.token.io.agora.chat.ChatTokenBuilder2;
      import org.springframework.beans.factory.annotation.Value;
      import org.springframework.util.StringUtils;
      import org.springframework.web.bind.annotation.CrossOrigin;
      import org.springframework.web.bind.annotation.GetMapping;
      import org.springframework.web.bind.annotation.PathVariable;
      import org.springframework.web.bind.annotation.RestController;
      import org.springframework.web.client.RestTemplate;
      import org.springframework.http.*;
      import org.springframework.web.client.RestClientException;
      import java.util.*;
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
       // 获取 Agora Chat User Token
       @GetMapping("/chat/user/{chatUserName}/token")
       public String getChatToken(@PathVariable String chatUserName) {
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
           return builder.buildUserToken(appid, appcert, chatUserUuid, expire);
       }
       // 获取用户名的 UUID。
       private String getChatUserUuid(String chatUserName) {
           String orgName = appkey.split("#")[0];
           String appName = appkey.split("#")[1];
           String url = "http://" + domain + "/" + orgName + "/" + appName + "/users/" + chatUserName;
           HttpHeaders headers = new HttpHeaders();
           headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
           headers.setBearerAuth(exchangeToken());
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
       // 创建一个用户，密码为 “123” 并获取该用户的 UUID。
       private String registerChatUser(String chatUserName) {
           String orgName = appkey.split("#")[0];
           String appName = appkey.split("#")[1];
           String url = "http://" + domain + "/" + orgName + "/" + appName + "/users";
           HttpHeaders headers = new HttpHeaders();
           headers.setContentType(MediaType.APPLICATION_JSON);
           headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
           headers.setBearerAuth(exchangeToken());
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
         // 获取 Agora app token
         private String getAppToken() {
             if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
                 return "appid or appcert is not empty";
             }
             ChatTokenBuilder2 builder = new ChatTokenBuilder2();
             return builder.buildAppToken(appid, appcert, expire);
         }
         // 将 Agora app token 置换为 Agora Chat app token
         private String exchangeToken() {
             String orgName = appkey.split("#")[0];
             String appName = appkey.split("#")[1];
             String url = "http://" + domain + "/" + orgName + "/" + appName + "/token";
             HttpHeaders headers = new HttpHeaders();
             headers.setContentType(MediaType.APPLICATION_JSON);
             headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
             headers.setBearerAuth(getAppToken());
             Map<String, String> body = new HashMap<>();
             body.put("grant_type", "agora");
             HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
             ResponseEntity<Map> response;
             try {
                 response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
             } catch (Exception e) {
                 throw new RestClientException("exchange token error : " + e.getMessage());
             }
             return (String) Objects.requireNonNull(response.getBody()).get("access_token");
         }
       }
      ```

   6. 在 `com.agora.chat.token` 路径下，创建一个类，名为 `AgoraChatTokenStarter` 并将以下代码复制到该文件中：

      ``` java
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

   7. 启动 Token 服务器。点击图中绿色三角标识，选择 `Debug "AgoraChatTokenStarter..." `。

      ![start the server](https://web-cdn.agora.io/docs-files/1639043996061)

### 使用 User Token 鉴权

 本节以 Web 客户端为例，介绍如何使用 User Token 在客户端进行鉴权。

为展示鉴权流程，本节介绍如何在你的本地搭建并运行一个 Web 客户端。此客户端仅用于演示，请勿用于生产环境中。

参考以下步骤实现一个 Web 客户端：

1. 创建一名为 `Agora Chat Web app` 的文件夹。一个 Web 客户端项目至少需包含以下文件：

   - `index.html`: 用于设计 Web 应用的用户界面。
   - `index.js`: 实现具体应用逻辑的代码。
   - `webpack.config.js`: webpack 配置。

2. 将以下代码复制到 `webpack.config.js` 文件中来配置 webpack：

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

3. 为你的 Web app 安装 npm 包。打开终端，进入到你的项目的根目录，运行 `npm init` 命令来创建一个 `package.json` 文件。

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

5. 创建 UI。将 `index.html `文件中的内容替换为以下代码：

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

6. 实现 app 逻辑。

   复制以下代码到 `index.js` 文件中，将 `<Your App Key>` 替换为你的 App key。

   在下列示例代码中可以看到，就客户端而言，User Token 和以下代码逻辑有关：

   - 调用 `open` ，使用 Token 和用户名登录 Agora Chat 系统。需使用注册时所输入的用户名来获得 UUID。

   - 当 Token 即将过期或已经过期时，从 app 服务器重新获取新的 Token 并调用 `renewToken` 来更新 Token。Agora 建议你定期（例如每小时）生成一个 Token 并调用 `renewToken` 来更新 Token 以确保 Token 的有效性。

    ```js
   import WebIM from "agora-chat-sdk";
   WebIM.conn = new WebIM.connection({
     appKey: "<Your App Key>",
   });
   // Login to Agora Chat
   let username;
   document.getElementById("login").onclick = function () {
     username = document.getElementById("username").value.toString();
     // Fetch the Agora Chat user token with username.
     fetch(`http://localhost:8090/chat/user/${username}/token`)
       .then((res) => res.text())
       .then((token) => {
         // Login to Agora Chat with username and token
         WebIM.conn.open({
           user: username,
           agoraToken: token,
         });
       });
   };
   // Add an event handler
   WebIM.conn.addEventHandler("AUTHHANDLER", {
     // Connected to the server
     onConnected: () => {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Connect success !");
     },
     // Receive a text message
     onTextMessage: (message) => {
       console.log(message);
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Message from: " + message.from + " Message: " + message.data);
     },
     // Renew the token when the token is about to expire
     onTokenWillExpire: (params) => {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Token is about to expire");
       refreshToken(username);
     },
     // Renew the token when the token has expired
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
   // Renew token
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
      # Use webpack to package the project
      npm run build
      
      # Use webpack-dev-server to run the project
      npm run start:dev
      ```

      `index.tml` 会自动在你的浏览器中打开。

   3. 输入用户名并点击**Login**。

      打开浏览器的控制台，你可以看到 Web 客户端有以下行为：

      - 生成一个 User Token。
      - 连接 Agora Chat 系统。
      - 在 Token 即将过期时更新 Token。

## 更多信息

本节介绍 Token 生成器代码库、版本要求以及 Token 相关的其他文档。      

### Token 生成器代码库

Agora 在 GitHub 上提供一个开源的 [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) 仓库，支持使用 C++、Java、Go 等语言在你自己的服务器上生成 Token。

### API 参考

本节以 Java 为例，介绍生成 User Token 的方法。

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

### Token 过期

User Token 的最长有效期为 24 小时。

如果 Agora Chat SDK 报告 `isConnected(true)` 的状态，则即便 User Token 过期，使用该 Token 登录的用户依然为在线状态。如果用户使用过期的 Token 登录，Agora Chat 会报告  `TOKEN_EXPIRED` 错误。

只有当 Token 过期、且 Agora Chat SDK 报告 `isConnected(true)` 的状态时，Agora Chat SDK 才会触发  `onTokenExpired`  回调，且只会触发一次。当监听到该回调时，应重新从你的 Token 服务器中获取新的 Token，然后调用 `renewToken` 来更新 Token。

> 注意：虽然你可以通过监听 `onTokenExpired` 回调来处理 Token 过期的情况，但 Agora 建议你定期（例如每小时）更新 Token 以确保 Token 的有效性。

### Token 和 RTC 产品

如果你在使用 Agora Chat 的同时也正在使用 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk)，Agora 建议你升级到 [Access Token 2](https://docs-preprod.agora.io/cn/agora-chat/access_token_2?platform=All%20Platforms)。