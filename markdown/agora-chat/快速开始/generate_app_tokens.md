鉴权指对用户身份进行校验的过程。当你使用 Agora 服务时，例如加入音视频通话、登录 Agora 即时通讯系统，Agora 会使用 Token 来对用户身份及权限进行核验。

为保证 Agora 即时通讯连接的安全性，Agora 提供两种类型的 Token 进行鉴权：

- User token：针对拥有 app 用户级别权限的用户进行鉴权。例如，当用户登录集成了 Agora 即时通讯 SDK 的 app 时，需通过 User Token 进行鉴权。详见[使用 User Token 鉴权](https://docs-preprod.agora.io/cn/agora-chat/generate_user_tokens%20?platform=All%20Platforms)。 
- App token：针对拥有 app 管理员级别权限的用户进行鉴权。管理员级别权限为最高权限，可以对整个 app 进行管理，例如创建或删除用户。

在服务器端调用 RESTful 接口来使用 Agora 即时通讯 服务时，需要获取 Agora 即时通讯 App Token。本文介绍如何从你的 App Token 服务器中获取 Agora App Token，并将该 token 置换为 Agora 即时通讯 App Token 来调用 Agora 即时通讯 RESTful 接口。

## 技术原理：

下图展示了使用 Agora 即时通讯 App Token 鉴权的原理：

![](https://web-cdn.agora.io/docs-files/1642583268105)

Agora 即时通讯 App Token 的最长有效期为 **24 小时**。当你调用 Agora 即时通讯 RESTful 接口时，Agora 即时通讯服务器会对读取包含在 Token 中的信息并进行鉴权。一个 Agora 即时通讯 App Token 中包含以下信息：

- 你的 Agora 项目的 App ID。
- 你的 Agora 项目的 App 证书。
- 你设置 Agora 即时通讯 App Token 的有效期。

## 前提条件

- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-账号)。
- 拥有 [App 证书](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)和已开通 Agora 即时通讯的 [Agora 项目](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#创建-agora-项目)。详见[开启和配置即时通讯服务](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms)开通 Agora 即时通讯服务。
- 你的 Agora 项目的 App ID、OrgName、AppName，详见[开启和配置即时通讯服务](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms)。

如果你的网络环境部署了防火墙，为允许你在有网络访问限制的环境中使用 Agora 即时通讯服务，Agora 提供防火墙白名单方案。如需使用请[提交工单](https://agora-ticket.agora.io/)，我们的技术服务会提供目标域名及对应的端口。

## 实现鉴权流程

本节介绍使用 Agora 即时通讯 App Token 进行鉴权的完整流程：

### 搭建 App Token 服务器

App Token 需要在你的服务端部署生成。当客户端发送请求时，App Token 服务器会生成相应的 Token。

本节展示如何使用 Java 语言在你的本地设备上搭建并运行一个 Token 服务器。此示例服务器仅用于演示，请勿用于生产环境中。

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

      ![](https://web-cdn.agora.io/docs-files/1638864182234)

   4. 解决 `chat/ChatTokenBuilder2` 和 `media/AccessToken` 文件中的报错。

      - 在 `ChatTokenBuilder2` 中，将 import 修改为 `import com.agora.chat.token.io.agora.media.AccessToken2`。

      - 在 `AccessToken` 中，将 import 修改为如下所示：

        ```java
         import java.io.ByteArrayOutputStream;
                import java.io.IOException;
                import java.util.TreeMap;
                
                import static com.agora.chat.token.io.agora.media.Utils.crc32;
        ```

4. 在 `<Project name>/src/main/resource` 路径下创建 `application.properties` 配置文件。你需要将该文件中的相关值替换你的 Agora 项目的值并设置你的 Agora App Token 的有效期，例如将 `expire.second` 设为 `6000`，即 Token 的有效期为 6000 秒。

   <div class="alert note">
	<p>Agora 即时通讯 App Token 的有效期从 Agora App Token 生成时开始计算。</p>
  <p> 例如，如果将 Agora App Token 的有效期设为 10,000 秒，生成 Agora App Token 并将其成功置换为 Agora 即时通讯 App Token 用了 100秒，则 Agora 即时通讯 App Token 将在 9,900 秒后过期。</p></div>

   ```txt
   ## server port
   server.port=8090
   ## Fill in the App ID of your Agora project
   appid=
   ## Fill in the app certificate of your Agora project
   appcert=
   ## Set the valid period (in seconds) for the Agora app token
   expire.second=
   ## domain
   domain=
   ```

 获取 RESTful API 请求地址域名（`domain`）, 详见[获取即时通讯项目信息](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms#获取即时通讯项目信息)。

5. 在  `com.agora.chat.token` 路径下，创建一个名为 `AgoraChatTokenController.java` 文件，并将以下代码复制到该文件中：

   ```java
   package com.agora.chat.token;
   
   import com.agora.chat.token.io.agora.chat.ChatTokenBuilder2;
   import org.springframework.beans.factory.annotation.Value;
   import org.springframework.util.StringUtils;
   import org.springframework.web.bind.annotation.GetMapping;
   import org.springframework.web.bind.annotation.PathVariable;
   import org.springframework.web.bind.annotation.RestController;
   
   @RestController
   public class AgoraChatTokenController {
   
       @Value("${appid}")
       private String appid;
   
       @Value("${appcert}")
       private String appcert;
   
       @Value("${expire.second}")
       private int expire;
   
       /*
        * 请求 App Token。
        * @return token
        */
       @GetMapping("/chat/app/token")
       public String getAppToken() {
           if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
               return "appid or appcert is not empty";
           }
   
           ChatTokenBuilder2 builder = new ChatTokenBuilder2();
   
           // 生成 App Token.
           return builder.buildAppToken(appid, appcert, expire);
       }
   }
   ```

6. 在 `com.agora.chat.token` 路径下，创建一个类，名为 `AgoraChatTokenStarter` 并将以下代码复制到该文件中：

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

7. 启动 App Token 服务器。点击图中绿色三角标识，选择 `Debug "AgoraChatTokenStarter..." `。

   ![](https://web-cdn.agora.io/docs-files/1638868741690)

### 使用 Agora 即时通讯 App Token 调用 Agora 即时通讯 RESTful API

本节介绍如何获取 Agora 即时通讯 App Token 并调用 Agora 即时通讯 RESTful API 在你的 app 中注册一个新用户。

1. 获取 Agora App Token 并将其置换为 Agora 即时通讯 App Token。打开终端，使用 curl 命令向你的 Agora App Token 服务器发送 GET 请求来获取 Agora App Token：

   ```shell
   curl http://localhost:8090/chat/app/token
   ```

   你的 token 服务器会返回一个 Agora App Token，如下图所示：

   ```shell
   007eJxTYPj3p2Tnb4tznzxfO/0LK5cu/GZmI71PnWPVkbVhP/aniEspMBhbJJqnGKclmVsYJ5kYWBhbJqcapqRZpJmbm5ikGRsnnT12OrGhN5pB97zpVEYGVgZGBiYGEJ+BAQBN0CGG
   ```

2. 将你获取的 Agora App Token 作为 `Authorization: Bear` 这一请求参数的值来置换出 Agora 即时通讯 App Token，请求示例如下：

   ```shell
   curl -X POST -H 'Content-Type: application/json' -H 'Authorization: Bearer 007eJxTYPj3p2Tnb4tznzxfO/0LK5cu/GZmI71PnWPVkbVhP/aniEspMBhbJJqnGKclmVsYJ5kYWBhbJqcapqRZpJmbm5ikGRsnnT12OrGhN5pB97zpVEYGVgZGBiYGEJ+BAQBN0CGG' -d '{"grant_type":"agora"}' 'http://a41.chat.agora.io/41434878/504205/token'
   ```

   响应体参数包含 Agora 即时通讯 App Token 和该 Token 过期的时间戳（ms），响应示例如下：

   ```json
   {
       "access_token": "YWMtocXMjBEEQhmBqj-1iqWUywAAAAAAAAAAAAAAAAAAAAH_Z4gybPJPQ4EwWKw4y2wVAgMAAAF7D4Ab0QBPGgD6xFOaPCHEVIzBMQAtlGlZ3wQF2Ju68ZHglAxaaFRPRg==",
       "expire_timestamp": 1628148692771
   } 
   ```

3. 使用 Agora 即时通讯 App Token 调用 Agora 即时通讯 RESTful API 来注册一个新用户。在终端中，使用 curl 命令向 Agora 即时通讯服务器发送请求注册一个新用户，示例如下：

   ```shell
   # 将 <YourAppToken> 替换为你通过置换获得的 Agora Chat App Token。
   curl -X POST -H "Authorization: Bearer <YourAppToken>" -i "https://XXXX/XXXX/XXXX/users" -d '[
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

## 更多信息

本节介绍和 Agora 即时通讯 App Token 有关的更多信息供你参考。

### 请求路径

当你请求获取 Agora 即时通讯 App Token 时，需在请求路径中传入以下参数：

| 参数       | 数据类型 | 必需/选填 | 描述                                                         |
| ---------- | :------: | :-------- | :----------------------------------------------------------- |
| `OrgName` |  String  | 必需  | Agora 即时通讯服务分配给每个企业（组织）的唯一标识。         |
| `AppName` |  String  | 必需      | Agora 即时通讯服务分配给每个 app 的名称。同一企业（组织）下，`AppName` 唯一。 |
| `token`    |  String  | 必需      | Agora App Token.                                             |

### 请求头部

使用 Agora App Token 置换 Agora 即时通讯 App Token 的请求头部如下：

| 参数       | 数据类型 |必需/选填 | 描述               |
| :-------------- | :-------- | :---------------- | :-------------------------- |
| `Content-Type`  | String    | 必需          | 类型为 `application/json`。 |
| `Authorization` | String    | 必需          | Bearer Agora app token。    |

### 请求体参数

| 参数    | 数据类型 | 必需/选填 | 值 |
| :----------- | :-------- | :---------------- | :---- |
| `grant_type` | String    | 必需          | agora |

### 响应码

| 响应码 | 描述                                                         |
| :------------------- | :----------------------------------------------------------- |
| `200`                | 请求置换 Agora 即时通讯 App Token 成功，Agora 即时通讯服务器返回所请求的 Token 及 Token 过期的时间戳。 |
| `5xx`                | 请求置换 Agora 即时通讯 App Token 失败，原因可能是被限流或发生异常。 |

## 注意事项

如果你在使用 Agora 即时通讯的同时也正在使用 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk)，Agora 建议你升级到 [Access Token 2](https://docs-preprod.agora.io/cn/agora-chat/access_token_2?platform=All%20Platforms)。