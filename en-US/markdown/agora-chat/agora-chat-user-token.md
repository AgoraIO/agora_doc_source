# Generate a User Token for Authentication

Authentication is the act of validating the identity of each user before they access your system. Agora uses digital tokens to authenticate users and their privileges before they access an Agora service, such as joining an Agora call, or logging into the real-time messaging system.

Agora Chat uses two types of tokens with different privieleges:

- App token: App tokens provide the most privileges and are required when you call the Agora Chat RESTful APIs to manage your Agora Chat application. For details, see [Generate an App Token for Authentication](link).
- User token: User tokens are used to authenticate users when they log in to your Agora Chat application.

This page shows you how to create an Agora Chat token server and an Agora Chat client app. The client app retrieves a user token from the token server. This token authenticates the current user when the user accesses the Agora Chat service.

## Understand the tech

The following figure shows the steps in the authentication flow:
![agora chat user token workflow](https://web-cdn.agora.io/docs-files/1639043175484)

A user token is a dynamic key generated on your app server that is valid for a maximum of 24 hours. When your users login to Agora Chat from your app client, Agora Platform validates the token and reads the user and project information stored in the token. A user token contains the following information:

- The App ID of your Agora project
- The App Certificate of your Agora project
- The [UUID](link) of the user to be authenticated.
- The Unix timestamp when the token expires.

## Prerequisites

Ensure that you meet the following requirements before proceeding:

- A valid [Agora Account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
- An Agora project with the Agora Chat service enabled.
- A valid Agora Chat app token. See [Generate an App Token](link) for details.

## Implementation

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users using the source code provided by Agora.

<a name="uuid"></a>

### Get the UUID

When a user is registered, Agora automatically assigns a UUID to identify that user.

You can get the UUID from the responses of the [User Account RESTful APIs](link).

The following example sends a request to register a user.

**Request example**

```shell
# Replace <YourAppToken> with an app token generated on your server.
curl -X POST -H "Authorization: Bearer <YourAppToken>" -i "https://a1.agora.com/{org-name}/{app-name}/users" -d '[
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
   "uri": "https://a1.agora.com/{org-name}/{app-name}/users",
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

### Deploy a token server

Token generators create the tokens requested by your client app to enable secure access to Agora Platform. To serve these tokens you deploy a generator in your security infrastructure.

To show the authentication workflow, this section shows how to build and run a token server written in Java on your local machine.

This sample server is for demonstration purposes only. Do not use it in a production environment.

1. Create a Maven project, and replace the content in `pom.xml` with the following code:

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

2. Create a `com.agora.chat.token.io.agora` package under `src->main->java`, and add the [chat](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) and [media](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) packages to the project, as the following figure shows:
   ![token server project](link)

3. Create a file named `application.properties` to hold the information for generating tokens:

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

4. Under the `com.agora.chat.token` package, create a file, `AgoraChatTokenController.java`, with the following content:

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

5. Under the `com.agora.chat.token` package, create a file, `AgoraChatTokenStarter.java`, with the following content:

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

6. To start the server, click the green triangle button, and select **Debug "AgoraChatTokenStarter..."**.
   ![start-the-server](link)

## Use tokens for user authentication

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
            <input type="text" placeholder="Username" id="userID">
        </div>
        <div class="input-field">
            <label>Password</label>
            <input type="passward" placeholder="Password" id="password">
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

4. Create the app logic by editing `client.js` with the following content. Then replace `<Your App Key>` with your App Key. You also need to replace `<Your Host URL and port>` with the host URL and port of the local Java server you have just deployed, such as `10.53.3.234:8090`.

   ```js
   WebIM.conn = new WebIM.connection({
     appKey: "<Your App Key>",
     isDebug: true,
   });

   function postData(url, data) {
     return fetch(url, {
       body: JSON.stringify(data),
       cache: "no-cache",
       headers: {
         "content-type": "application/json",
       },
       method: "POST",
       mode: "cors",
       redirect: "follow",
       referrer: "no-referrer",
     }).then((response) => response.json());
   }

   // Login
   document.getElementById("login").onclick = function () {
     username = document.getElementById("userID").value.toString();
     password = document.getElementById("password").value.toString();
     // fetch token with username and password
     postData("http://<Your Host URL and port>/token", {
       userAccount: username,
       userPassword: password,
     }).then((res) => {
       let agoraToken = res.accessToken;
       let chatUserName = res.chatUserName;
       // Login to Agora Chat with username and token
       WebIM.conn.open({
         user: chatUserName,
         agoraToken: agoraToken,
       });
     });
   };

   // Add listeners
   WebIM.conn.listen({
     // Connected to the server
     onOpened: function (message) {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Connect success !");
     },
     // Received a text message
     onTextMessage: function (message) {
       console.log(message);
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Message from: " + message.from + " Message: " + message.data);
     },
     // Renew token when the token is about to expire
     onTokenWillExpire: function (params) {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("Token is about to expire");
       refreshToken(username, password);
     },
     // Renew token when the token has expired
     onTokenExpired: function (params) {
       document
         .getElementById("log")
         .appendChild(document.createElement("div"))
         .append("The token has expired");
       refreshToken(username, password);
     },
     onError: function (error) {
       console.log("on error", error);
     },
   });

   function refreshToken(username, password) {
     postData("http://<Your Host URL and port>/token", {
       userAccount: username,
       userPassword: password,
     }).then((res) => {
       let agoraToken = res.accessToken;
       WebIM.conn.renewToken(agoraToken);
     });
   }
   ```

   In the code example, you can see that token is related to the following code logic in the client:

   - Call `open` to log in to the RTM system with token and username. You must use the username that is used to register the user and get the UUID.
   - Fetch a new token from the app server and call `renewToken` to update the token of the SDK when the token is about to expire and when the token expires. Agora recommends that you regularly (such as every hour) generate a token from the app server and call `renewToken` to update the token of the SDK to ensure that the token is always valid.

5. Open `index.html` with a supported browser to perform the following actions:
   - Successfully logging in to the Agora Chat system.
   - Renewing a token when it is about to expire.

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
public String buildUserToken(String appId, String appCertificate, String userId, int expire) {
        AccessToken2 accessToken = new AccessToken2(appId, appCertificate, expire);
        AccessToken2.Service serviceChat = new AccessToken2.ServiceChat(userId);

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
| userId         | The unique identifier (UUID) of a user in the Agora Chat system. You need get the UUID through RESTful APIs. See [Get the UUID](uuid). |
| expire         | The valid duration (in seconds) of the token. The maximum is 86,400, that is, 24 hours.                                                |

## Considerations

### UUID

The UUID that you use to generate the user token must macth the user account that logs in to the Agora Chat system.

### Token expiration

A user token is valid for a maximum of 24 hours.

When the Agora Chat SDK is in the `isConnected(true)` state, the user remains online even if the user token expires. If a user logs in with an expired token, the SDK returns the `TOKEN_EXPIRED` error.

The Agora Chat SDK triggers the `onTokenExpired` callback only when a token expires and the SDK is in the `isConnected(true)` state. The callback is triggered only once. Upon receiving this callback, you can generate a new token on your app server, and call `renewToken` to pass the new token to the SDK.

<div class="alert note">Although you can use the <code>onTokenExpired</code> callback to handle token expiration conditions, Agora recommends that you regularly renew the token (for example every hour) to keep the token valid.</div>

<div class="alert info">The names of methods, callbacks, and enums mentioned above only applies to Java. Refer to the API documentation for names in other platforms.</div>
