# Authenticate Your Users with Tokens

Authentication is the act of validating the identity of each user before they access your system. Agora uses digital tokens to authenticate users and their privileges before they access an Agora service, such as joining an Agora call, or logging into the real-time messaging system.

Agora Chat uses two types of tokens with different privileges:

- App token: App tokens provide the most privileges and are required when you call the Agora Chat RESTful APIs to manage your Agora Chat application. For details, see [Generate an App Token for Authentication](link).
- User token: User tokens are used to authenticate users when they log in to your Agora Chat application.

This page shows you how to create an Agora Chat token server and an Agora Chat client app. The client app retrieves a user token from the token server. This token authenticates the current user when the user accesses the Agora Chat service.

## Understand the tech

The following figure shows the steps in the authentication flow:
![agora chat user token workflow](https://web-cdn.agora.io/docs-files/1639043175484)

A user token is a dynamic key generated on your app server that is valid for a maximum of 24 hours. When your users login from your app, Agora Chat reads the information stored in the token and uses it to authenticate the user. A user token contains the following information:

- The App ID of your Agora project
- The App Certificate of your Agora project
- The [UUID](uuid) of the user to be authenticated
- The valid duration of the token

## Prerequisites

Ensure that you meet the following requirements before proceeding:

- A valid [Agora Account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- An Agora project with the Agora Chat service enabled. 
  To enable the Agora Chat service, contact support@agora.io.
- A valid Agora Chat app token. See [Generate an App Token](link) for details.

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality for authenticated users using the source code provided by Agora.

### Deploy a token server

Token generators create the tokens requested by your client app to enable secure access to Agora Platform. To serve these tokens you deploy a generator in your security infrastructure.

To show the authentication workflow, this section shows how to build and run a token server written in Java on your local machine.

This sample server is for demonstration purposes only. Do not use it in a production environment.

1. Create a Maven project in IntelliJ, set the name of your project, choose the location to save your project, and click **Finish**.

1. In `<Project name>/pom.xml` , add the following dependencies and then [reload the Maven project](https://www.jetbrains.com/help/idea/delegate-build-and-run-actions-to-maven.html#maven_reimport):

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

1. Import the token builders to this project provided by Agora.
    1. Download the [chat](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) and [media](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) packages.
    1. In the token server project, create a `com.agora.chat.token.io.agora` package under `<Project name>/src/main/java`.
    1. Copy the chat and media packages and paste under `com.agora.chat.token.io.agora`. The following figure shows the project structure:
      ![token server project](https://web-cdn.agora.io/docs-files/1639043760281)
    1. Fix the import errors in `chat/ChatTokenBuilder2` and `media/AccessToken`.
      - In `ChatTokenBuilder2`, the import should be `import com.agora.chat.token.io.agora.media.AccessToken2`.
      - In `AccessToken`, the import should be as follows:
        ```java
        import java.io.ByteArrayOutputStream;
        import java.io.IOException;
        import java.util.TreeMap;

        import static com.agora.chat.token.io.agora.media.Utils.crc32;
        ```

1. In `<Project name>/src/main/resource`, create a `application.properties` file to hold the information for generating tokens:

   ```txt
   ## Server port
   server.port=8090
   ## Fill the App ID of your Agora project
   appid=""
   ## Fill the app certificate of your Agora project
   appcert=""
   ## Fill the app key of the Agora Chat service
   appkey=""
   ## Set the valid duration (in seconds) for the token
   expire.second=60
   ```

1. In the `com.agora.chat.token` package, create a Java class named `AgoraChatTokenController`, with the following content:

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

       @GetMapping("/chat/user/uuid/{chatUserUuid}/token")
       public String getChatToken(@PathVariable String chatUserUuid) {
           if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
               return "appid or appcert is not empty";
           }
           if (!StringUtils.hasText(chatUserUuid)) {
               return "chatUserUuid is not empty";
           }
           ChatTokenBuilder2 builder = new ChatTokenBuilder2();
           return builder.buildUserToken(appid, appcert, chatUserUuid, expire);
               }
   }
   ```

1. In the `com.agora.chat.token` package, create a Java class named `AgoraChatTokenStarter`, with the following content:

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

1. To start the server, click the green triangle button, and select **Debug "AgoraChatTokenStarter..."**.
   ![start the server](https://web-cdn.agora.io/docs-files/1639043996061)

<a name="uuid"></a>

### Get the UUID

When you create a user in Agora Chat, they are automatically assigned a UUID.

You can get the UUID through the [User Account RESTful APIs](https://docs-preprod.agora.io/en/test/agora_chat_restful_reg?platform=RESTful).

The following example registers a user with the username "user1" and password "123".

**Request example**

```shell
# Replace <YourAppToken> with an app token generated on your server.
curl -X POST -H "Authorization: Bearer <YourAppToken>" -i "https://api.agora.com/{org-name}/{app-name}/users" -d '[
   {
     "username": "user1",
     "password": "123",
     "nickname": "testuser"
   }
 ]'
```

**Response example**

The UUID is in the response.

```shell
{
   "action": "post",
   "application": "8be024f0-e978-11e8-b697-5d598d5f8402",
   "path": "/users",
   "uri": "https://api.agora.com/{org-name}/{app-name}/users",
   "entities": [
       {
           "uuid": "0ffe************214b",
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
   "organization": "{org-name}",
   "applicationName": "{app-name}"
}
```

### Use tokens for user authentication

This section uses the Web client as an example to show how to use a token for client-side user authentication.

To show the authentication workflow, this section shows how to build and run a Web client on your local machine.

This sample client is for demonstration purposes only. Do not use it in a production environment.

1. Create the project structure of the Web client with a folder including the following files.

   - `index.html`: User interface
   - `client.js`: App logic with Agora RTM Web SDK

   ```txt
    |
    |-- index.html
    |-- client.js
   ```

2. Download [Agora Chat SDK for Web](link) and save the JS file to your project.

3. In `index.html`, add the following code to include the app logic in the UI:

   > You need to replace `<path to the JS file>` with the path of the JS file you saved in step 2.

   ```html
   <head>
        <title>Agora Chat Token demo</title>
    </head>

    <body>
        <h1>Token demo</h1>
        <div class="input-field">
            <label>Username</label>
            <input type="text" placeholder="Username" id="username">
        </div>
        <div class="input-field">
            <label>UUID</label>
            <input type="text" placeholder="UUID" id="uuid">
        </div>
        <div>
            <button type="button" id="login">Login</button>
        </div>
        <div id="log"></div>
        <script src="<path to the JS file>"></script>
        <script src="./index.js"></script>
    </body>

    </html>
   ```

4. Create the app logic by editing `client.js` with the following content. Then replace `<Your App Key>` with your App Key.

   ```js
   WebIM.conn = new WebIM.connection({
     appKey: "<Your App Key>"
   });

   // Login with username and token
   let username, uuid;
   document.getElementById("login").onclick = function () {
     username = document.getElementById("username").value.toString();
     uuid = document.getElementById("uuid").value.toString();
     // fetch token with uuid
     fetch(`http://localhost:8090/chat/user/uuid/${uuid}/token`)
         .then((token) => {
       // Login to Agora Chat with username and token
       WebIM.conn.open({
         user: username,
         agoraToken: token,
       });
     });
   };

   // Add an event handler
   WebIM.conn.addEventHandler('AUTHHANDLER', {
     // Connected to the server
     onConnected: () => {
         document.getElementById("log").appendChild(document.createElement('div')).append("Connect success !")
     },
     // Receive a text message
     onTextMessage: (message) => {
         console.log(message)
         document.getElementById("log").appendChild(document.createElement('div')).append("Message from: " + message.from + " Message: " + message.data)
     },
     // Renew the token when the token is about to expire
     onTokenWillExpire: (params) => {
         document.getElementById("log").appendChild(document.createElement('div')).append("Token is about to expire")
         refreshToken(uuid)
     },
     // Renew the token when the token has expired
     onTokenExpired: (params) => {
         document.getElementById("log").appendChild(document.createElement('div')).append("The token has expired")
         refreshToken(uuid)
     },
     onError: (error) => {
         console.log('on error', error)
     }
   });

  // Renew token
  function refreshToken(uuid) {
     fetch(`http://localhost:8090/chat/user/uuid/${uuid}/token`)
         .then((token) => {
              WebIM.conn.renewToken(token)
         })
   }
   ```

   In the code example, you can see that token is related to the following code logic in the client:

   - Call `open` to log in to the Agora Chat system with token and username. You must use the username that is used to register the user and get the UUID.
   - Fetch a new token from the app server and call `renewToken` to update the token of the SDK when the token is about to expire and when the token expires. Agora recommends that you regularly (such as every hour) generate a token from the app server and call `renewToken` to update the token of the SDK to ensure that the token is always valid.

5. Open `index.html` with a supported browser to perform the following actions:
   - Successfully logging in to the Agora Chat system.
   - Renewing a token when it is about to expire.
   
To run this sample project, you need to input a username and the corresponding UUID. See [Get the UUID](uuid) for details.

## Reference

This section introduces token generator libraries, version requirements, and related documents about tokens.

### Token generator libraries

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate tokens on your server with programming languages such as C++, Java, and Go.

| Language | Algorithm   | Core method                                                                                                                                                 | Sample code                                                                                                                                                                       |
| -------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C++      | HMAC-SHA256 | [BuildUserToken](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/src/ChatTokenBuilder2.h)                             | [ChatTokenBuilder2Sample.cpp](hhttps://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/cpp/sample/ChatTokenBuilder2Sample.cpp)                          |
| Java     | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat/ChatTokenBuilder2.java) | [ChatTokenBuilder2Sample.java](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample/ChatTokenBuilder2Sample.java) |
| PHP      | HMAC-SHA256 | [buildUserToken](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/php/src/ChatTokenBuilder2.php)                           | [ChatTokenBuilder2.php](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/php/src/ChatTokenBuilder2.php)                                          |
| Python 2 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python/src/ChatTokenBuilder2.py)                       | [ChatTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python/sample/ChatTokenBuilder2Sample.py)                          |
| Python 3 | HMAC-SHA256 | [build_user_token](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python3/src/ChatTokenBuilder2.py)                      | [ChatTokenBuilder2Sample.py](https://github.com/AgoraIO/Tools/blob/dev/accesstoken2/DynamicKey/AgoraDynamicKey/python3/sample/ChatTokenBuilder2Sample.py)                         |

### API Reference

This section introduces the method to generate a user token. Take Java as an example:

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

| Parameter      | Description                                                                                                                            |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------- |
| appId          | The App ID of your Agora project.                                                                                                      |
| appCertificate | The App Certificate of your Agora project.                                                                                             |
| uuid         | The unique identifier (UUID) of a user in the Agora Chat system. You need get the UUID through RESTful APIs. See [Get the UUID](uuid). |
| expire         | The valid duration (in seconds) of the token. The maximum is 86,400, that is, 24 hours.                                                |

### UUID

The UUID that you use to generate the user token must macth the user account that logs in to the Agora Chat system.

### Token expiration

A user token is valid for a maximum of 24 hours.

When the Agora Chat SDK is in the `isConnected(true)` state, the user remains online even if the user token expires. If a user logs in with an expired token, the SDK returns the `TOKEN_EXPIRED` error.

The Agora Chat SDK triggers the `onTokenExpired` callback only when a token expires and the SDK is in the `isConnected(true)` state. The callback is triggered only once. Upon receiving this callback, you can generate a new token on your app server, and call `renewToken` to pass the new token to the SDK.

<div class="alert note">Although you can use the <code>onTokenExpired</code> callback to handle token expiration conditions, Agora recommends that you regularly renew the token (for example every hour) to keep the token valid.</div>

<div class="alert info">The names of methods, callbacks, and enums mentioned above only applies to Java. Refer to the API documentation for names in other platforms.</div>

### Tokens for Agora RTC products

 If you use Agora Chat together with the Agora RTC service, Agora recommends you upgrade to [access token 2](link) for smooth development experience.
