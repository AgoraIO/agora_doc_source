
# Authenticate your users with AccessTokens

Authentication is the act of validating the identity of each user who has credentials to access your system, and providing them with a digital AccessToken that gives privileges to specific Agora Call, Streaming, Messaging or Analytics functionality. 

Agora uses digital AccessTokens to authenticate users and their privileges before they access an Agora service. For example, the AccessToken granted to a standard user has the `kJoinChannel` privilege only; this user may only join a channel. A moderator has `kInvitePublishVideoStream` and can invite people to a video stream. As you see, the privileges names are incomprehensibly difficult, you grant admin users the `kAdministrateChannel` privilege. 

This section shows you how to integrate industrial grade security into your Agora app using `AccessToken`s. 

##  Understand the tech

The following figure shows the steps in the authentication flow:

![token authentication flow](https://web-cdn.agora.io/docs-files/1618395721208)

An AccessToken is a dynamic key generated on your app server that is valid for a maximum of 24 hours. When your users connect to a channel from your App client, Agora SDK validates the AccessToken and reads the user and project information stored in the AccessToken. The app information is related to your project:

![alt text](Images/project_information_in_the_console.png "Logo Title Text 1")


Agora SDK grants access according to the following information in the AccessToken:

- `appID` - the _App ID_ of your Agora project
- `appCertificate` - the _App certificate_ of your Agora project
- `channelName` - no idea where I find this
- `uid` - the ID of the user to be authenticated
- `I CANT FIND THE PARAMETER NAME`  - the privileges assigned to this user
- `privilegeExpiredT (THIS IS A GUESS)` - a timestamp stating the time this AccessToken expires

An AccessToken is valid for 24 hours at most. You need to regularly generate new AccessTokens to keep users connected.



## Prerequisites

In order to follow this procedure you must have:

* A valid [Agora account](https://console.agora.io/)
* An Agora project

* A [Heroku](https://dashboard.heroku.com) account

## Implement the authentication flow

This section shows you how to supply and consume the AccessToken that gives rights to specific functionality to authenticated users.

### Deploy an AccessToken server

AccessTokens generators create the AccessTokens requested by your Agora Client app to enable secure access to Agora SDK. To serve these AccessTokens you deploy a generator in your security infrastructure. 

In order to show the authentication workflow, this section shows how to deploy and run a demo AccessToken generator on a server using Heroku:

1. In your browser, login to Agora console at https://console.agora.io/.

1. Click Edit on the project to use.

   This opens the _Basic Info_ page which contains the information you need for the AccessTokens generator. 

1. In another tab in your browser, navigate to https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs. 

1. In _Create New App_ add the information for the Heroku deployment from the _Basic Info_ for your Agora project. 

1. In _Create New App_, add a staging pipeline and click *Deploy App*.

   Take the weight off and enjoy your beverage of choice, the deployment takes a few minutes. When the deployment is completed, Heroku displays **Your app was successfully deployed**.
 
1.  Click **Manage App**. 
   You see the dashboard for your Heroku app. 
    
1. Click **Open App**.

   Your browser makes a GET call to <heroku url>. For example: https://tokens-and-web-sdk.herokuapp.com/. There are no return parameters.

1. Test AccessToken generation. 

   In the address bar of your browser, add *access_token?channel=test&uid=1234* to *\<heroku url\>*. For example: https://<heroku url>/access_token?channel=test&uid=1234.

The AccessToken generator running in the Heroku cloud returns a valid access token. For example

````json
{"token":"006efb1df952a134400b1cbadc3409deIABAOVYZgbobti4I8MAzjp8xMarleyVDzjIR+Dsings+f9ij4OObgoodDILHA/l6YAEAASONGSAA"}
````

You have a working AccessToken server. However, this is a sample app running on an independent provider. To create a production grade AccessToken server, use the sample code in https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey to integrate an AccessToken generator into your infrastructure. 


## Login to Agora SDK using your app client

Your client app retrieves an AccessToken from your server in order to login to Agora SDK. 

IAIN: This does not say how i am doing this. Can I do it by adding the scripts to a web page and bob is your marley? Explain. 

To integrate authentication, add the following code to your Web App:

1. Fetch the AccessToken with uid and channel name:

   ```JavaScript
   // Assume the client sends
   //
   //  {
   //    "uid": "123456",
   //    "channelName": "channelA"
   //  }
   //
   // the AccessToken server returns:
   // {
   //    "code":"200",
   //    "token": "006970CA35de60c44645bbae8a215061b33IACtCBeHhqlszBWc9S8XyvSoz1fJm1YiL6OWFTbLNC7OMbdIfRCtk5C5IgB8zc0FZAN5YAQAAQD0v3dgAgD0v3dgAwD0v3dgBAD0v3dg"
   // }
   // Need to import axios
   function fetchToken(uid, channelName) {
   
       let data = JSON.stringify({ "uid": uid, "channelName": channelName });
   
       let config = {
           method: 'get',
           url: 'https://<heroku url>/access_token?channel=test&uid=1234',
           headers: {
               'Content-Type': 'application/json'
           },
           data: data
       };
   
       return new Promise(function (resolve) {
           axios(config)
               .then(function (response) {
                   const token = response.data.token;
                   resolve(token);
               })
               .catch(function (error) {
                   console.log(error);
               });
       })
   }
   ```

1. Join channel with the AccessToken, uid, and channel name

   ```JavaScript
   import AgoraRTC from "agora-rtc-sdk-ng"
   
   const client = AgoraRTC.createClient()
   
   async function startCall() {
     let token = await fetchToken(123456, "ChannelA");
     // Join channel with token and uid
     await client.join("APPID", "ChannelA", token, 123456);
     ...
   }
   ```

1. Handle AccessToken expiration.  AccessTokens expire, and when that happens, the user gets disconnected. To prevent that from happening, you also need to handle AccessToken expiration in your client logic.

   * When the AccessToken is about to expire

      The `token-privilege-will-expire` callback occurs 30 seconds before a AccessToken expires. When the `token-privilege-will-expire` callback is triggered，fetch the AccessToken from the server and call `renewToken` to pass the new AccessToken to the SDK.
      
      ```JavaScript
      client.on("token-privilege-will-expire", async function(){
        // After requesting a new token
        await client.renewToken(token);
      });
      ```

   * When the AccessToken has expired

      The `token-privilege-did-expire` callback occurs when the AccessToken expires. When the `token-privilege-did-expire` callback is triggered，the client must fetch the AccessToken from the server and call `join` to use the new AccessToken to join the channel.
      
      ```JavaScript
      client.on("token-privilege-did-expire", async function(){
        //After requesting a new token
        await rtc.client.join(options.appId, options.channel, options.token, 123456);
      });
      ```

1. Now say how to run the app 


## Reference



### Channel Key

AccessToken-based authentication has requirements on the SDK version:
- For RTC Native SDKs and the On-premise Recording SDK, ensure that the SDK version is v2.1.0 or later.
- For RTC Web SDKs, ensure that the SDK version is v2.4.0 or later.

If you are using an earlier version, refer to [Channel Keys](https://docs.agora.io/en/Agora%20Platform/channel_key) to authenticate your users.

### Related documents

You can also refer to the following documents according to your needs:

- [How to solve token-related errors?](https://docs.agora.io/en/faq/token_error)
- [What causes the 101 error on Cloud Recording SDK?](https://docs.agora.io/en/faq/101_error)
- [How to use co-host token authentication?](https://docs.agora.io/en/faq/token_cohost)

Agora provides code samples on [GitHub](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) for you to generate tokens.

When generating a token, you can specify whether a user has the privilege to publish streams in an RTC channel. See [How do I use co-host token authentication?](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost) for details.
