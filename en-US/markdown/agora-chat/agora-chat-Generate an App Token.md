# Generate Agora Chat App Tokens for Authentication

Authentication is the process of validating identities. To ensure your app security, Agora Chat provides two types of tokens for authentication: user token and app token. A user token is used to validate the identities of your app users, which gives users the privilege to use some functions of your app. An app token is used to authenticate users assigned with the highest privilege, the admin privileges.

If you need to call Agora Chat RESTful APIs, you need to obtain an app token and convert this token to an Agora Chat app token. This page shows how to create an app token server and how to convert the app token you obtained to call Agora Chat RESTful APIs. 

## Understand the tech

The following figure shows the workflow of authenticating with Agora Chat app tokens:

![](https://web-cdn.agora.io/docs-files/1639378092974)

An Agora Chat app token is valid for a maximum of **24 hours**. When you call Agora Chat RESTful APIs on the server side, the Agora Chat server authenticate your identity by reading and validating the information stored in the token. An Agora Chat app token contains the following information:

- The App ID of your Agora project
- The App Certificate of your Agora project
- The Unix timestamp when the app token expires

## Preprequisites

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#create-an-agora-account)
- An [Agora project](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#create-an-agora-project) with the [App Certificate](https://docs.agora.io/en/Agora Platform/manage_projects?platform=All Platforms#manage-your-app-certificates) enabled
- The [App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#get-the-app-id)  your Agora project
- The [org_name]() and [app_name]() of your Agora project

> Note: If your network environment has a firewall, Agora provides firewall whitelists so that you can use Agora Chat with restricted network access. You can contact support@agora.io for more information about the firewall whitelists.

## Implement the authentication flow

This section shows how to implement autentication with an Agora Chat app token step by step.

### Deploy an app token server

Token generators create the tokens requested by your app client to enable secure access to Agora Chat. To serve these tokens you deploy a token generator on your app server.

The following example shows how to build and run an app token server written in Java on your local machine.

> Warning: This sample server is for demonstration purposes only. Do not use it in a production environment.

1. Create a Maven project in IntelliJ, set the name of your project, choose the location to save your project, and click **Finish**.

2. In `<Project name>/pom.xml` , add the following dependencies:

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

3. In `<Project name>/src/main/java`, create a package and name it `com/agora/chat/token/io/agora`. To generate an Agora Chat app token, in `com/agora/chat/token/io/agora`, create a folder named **chat** and a folder named **media**, and add the files in [chat](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/chat) and [media](https://github.com/AgoraIO/Tools/tree/dev/accesstoken2/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/media) to these two folders accordingly.

   ![](https://web-cdn.agora.io/docs-files/1638864182234)

4. In `<Project name>/src/main/resource`, create a `application.properties` file. You need to fill in the App ID and App Certificate your Agora project and set the validity period (in seconds) of the app token you request. 

   ```shell
   ## server port
   server.port=8090
   ## agora appid
   appid=xxx
   ## agora appcert
   appcert=xxx
   ## The validity period of the token
   expire.second=xxx
   ```
   
5. In `com.agora.chat.token`, create a file named `AgoraChatTokenController.java` and copy the following codes into the file:

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
   
       /**
        *
        * Apply for an App Token
        * @return token
        */
       @GetMapping("/chat/app/token")
       public String getAppToken() {
           if (!StringUtils.hasText(appid) || !StringUtils.hasText(appcert)) {
               return "appid or appcert is not empty";
           }
   
           ChatTokenBuilder2 builder = new ChatTokenBuilder2();
   
           // Generate an App Token.
           return builder.buildAppToken(appid, appcert, expire);
       }
   }
   ```

6. In `com.agora.chat.token` , create a file named `AgoraChatTokenStarter.java` and copy the following codes into the file:

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


7. Click **Build Project** to build your project. Click **Run** and select **Debug "AgoraChatTokenStarter..."** to run your server.

   ![](https://web-cdn.agora.io/docs-files/1638868741690)

8. Now your token server is successfully deployed. To get an app token from your token server, open http://localhost:8090/chat/app/token in your broswer and you see the token requested.

   ![](https://web-cdn.agora.io/docs-files/1638869051945)

### Convert an app token

Before you call Agora Chat RESTful APIs, you need to convert the app token to an Agora Chat app token in order to use Agora Chat.

> Note: The validity period of an Agora Chat app token is subject to that of the app token generated by your token server. 
>
> For example, if you set the validity period of the app token in step 4 as 10,000 seconds, and you use this token to request and obtain an Agora Chat app token after 1000 seconds, the Agora Chat app token is to be expired after 9,900 seconds.

#### Request example

To convert the app token to an Agora Chat app token, you need to send a POST request to the Agora Chat server. 

#### Request path

The following parameters are required in the URL:

| Parameter  | Data type | Required/Optional | Description                                                  |
| :--------- | :-------- | :---------------- | :----------------------------------------------------------- |
| `org_name` | String    | Required          | The organization name of your Agora project; click [here]() to see your `org_name`. |
| `app_name` | String    | Required          | The name of your app; click [here]() to see your `app_name`. |
| `token`    | String    | Required          | The Agora Chat app token.                                    |

The following is a request example:

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Authorization: Bearer 007eJxTYJBev+h8fkVfUlprbuqMNZpfd50yuuaW1Gc971rarOsPj89XYLBITE5NtTAyM0xLMjcxSjO3TLE0TbU0Mk1ONE9NSzYxFPinm9gQyMggfEsimZGBlYGRgYkBxGdgAAAuDh/p' -d '{"grant_type":"agora"}'' 'http://a1.agorachat.com/agorachat-demo/testapp/token'
```

For more details about the parameters in the request header and body, see <a href="api"> Reference</a>.

#### Response example

If the request is successful, the response returns:

-  an Agora Chat app token
-  the timestamp (in milliseconds) when the token expires

The following is a response example for a successful request:

```json
{
    "access_token": "YWMtocXMjBEEQhmBqj-1iqWUywAAAAAAAAAAAAAAAAAAAAH_Z4gybPJPQ4EwWKw4y2wVAgMAAAF7D4Ab0QBPGgD6xFOaPCHEVIzBMQAtlGlZ3wQF2Ju68ZHglAxaaFRPRg==",
    "expire_timestamp": 1628148692771
} 
```

### Call the Agora Chat RESTful APIs with an Agora Chat app token

The following is an example of calling the Agora Chat RESTful API with the converted Agora Chat app token to register a user:

#### Request example:

```shell
# Replace <YourAppToken> with the Agora Chat app token.
curl -X POST -H "Authorization: Bearer <YourAppToken>" -i "https://a1.agora.com/agora-demo/testapp/users" -d '[
   { 
     "username": "user1", 
     "password": "123", 
     "nickname": "testuser" 
   } 
 ]'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-e978-11e8-b697-5d598d5f8402",
    "path": "/users",
    "uri": "https://a1.agora.com/agora-demo/testapp/users",
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
    "organization": "agora-demo",
    "applicationName": "testapp"
}
```

## <a name = "api">Reference</a>

This section provides additional information about Agora Chat app tokens for your reference.

### Request header

To convert an app token to an Agora Chat app token, you need to pass in the following parameters in the request header:

| Parameter       | Data type | Required/Optional | Description        |
| :-------------- | :-------- | :---------------- | :----------------- |
| `Content-Type`  | String    | Required          | `application/json` |
| `Authorization` | String    | Required          | Bearer appToken    |

### Request body

| Parameter    | Data type | Required/Optional | Value |
| :----------- | :-------- | :---------------- | :---- |
| `grant_type` | String    | Required          | agora |

### Status codes

The possible response status codes are listed below:

| Response status code | Description                                                  |
| :------------------- | :----------------------------------------------------------- |
| `200`                | The request is successful, and the server returns the requested Agora Chat app token and the timestamp when the token expires. |
| `5xx`                | The request fails probably because the API to convert an app token to an Agora Chat app token might be rate-limited, or an error occur during the process. |

### Other Considerations

If you also enable the Agora RTC service, Agora recommends you updating your token to the [access token 2]() for smooth development experience.

