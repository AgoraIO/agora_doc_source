To enhance communication security, Agora Interactive Whiteboard uses tokens for user authentication.



This article introduces how to generate and use different types of tokens for the whiteboard service.

<a name="tokenoverview"></a>
## Introduction

The whiteboard service has three types of tokens: SDK Token, Room Token, and Task Token, in descending order of granted permissions. Each token can be assigned to an `admin`, `writer`, or `reader` role. These tokens must be issued from your app server.

### SDK Token

An SDK Token is linked with a whiteboard project in Agora Console and grants the most permissions. With an SDK Token, a user can get access to every room and file-conversion task under the linked project. The permissions granted by an SDK Token in a specific role are as follows:

| Permissions | admin SDK Token | writer SDK Token | reader SDK Token |
| :----------------------------------------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| Create a room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Join a room in interactive mode | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Join a room in read-only mode | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> |
| Get a list of rooms | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Get room information | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Disable a room | <font color="green">✔</font> | <font color="red">✘</font> | <font color="red">✘</font> |
| Take a screenshot for a specific scene | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Take screenshots for a scene directory | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Get a list of scene paths in a room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Add a scene | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Switch to a scene | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Start a file-conversion task | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Generate a Room Token for an equal or inferior role (for example, an admin SDK Token can generate an  `admin`, `writer`, or `reader` Room Token) | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |
| Generate a Task Token for an equal or inferior role (for example, an admin SDK Token can generate an  `admin`, `writer`, or `reader` Task Token) | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |


<div class="alert note">Exposure of SDK Tokens may cause security risks because they grant a large number of permissions. Agora recommends the following precautions:
<ul>
	<li>Do not send SDK Tokens to your app clients, save them in a database, or write them in a configuration file. You should issue them from your app server only when necessary.</li>
<li>Do not issue a permanent SDK Token. You should set a validity period according to your app scenario.</li>
	</ul>
</div>

### Room Token

A Room Token is linked with a room under a whiteboard project in Agora Console. With a Room Token, a user can get access to the linked room. The permissions granted by a Room Token in a specific role are as follows:

| Permissions | admin SDK Token | writer SDK Token | reader SDK Token |
| :--------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| Join the room in interactive mode | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Join the room in read-only mode | <font color="red">✘</font> | <font color="red">✘</font> | <font color="green">✔</font> |
| Get information about the room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Disable the room | <font color="green">✔</font> | <font color="red">✘</font> | <font color="red">✘</font> |
| Take a screenshot for a specific scene | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Take screenshots for a scene directory | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Get a list of scene paths in the room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Add a scene in the room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |
| Switch to a scene in the room | <font color="green">✔</font> | <font color="green">✔</font> | <font color="red">✘</font> |

### Task Token

A Task Token is linked with a file-conversion task under a whiteboard project in Agora Console. With a Task Token, a user can get access to the linked  task. The permissions granted by a Task Token in a specific role are as follows:

| Permissions | admin SDK Token | writer SDK Token | reader SDK Token |
| :------------------------- | :--------------------------- | :--------------------------- | :--------------------------- |
| Query the progress of the file-conversion task | <font color="green">✔</font> | <font color="green">✔</font> | <font color="green">✔</font> |

## Generate a token

You can generate a token for the whiteboard service through one of the following methods:

- Use [Agora Console](https://console.netless.link/zh-CN/). See [Get a SDK Token](/cn/whiteboard/enable_whiteboard).

<div class="alert note">This method can only generate a permanent <code>admin</code> SDK Token. Do not send this token to your app clients; otherwise, there may be a risk of exposure.</div>

- Call the the Interactive Whiteboard RESTful API on your app server. See [Generate a token using RESTful API](/cn/whiteboard/generate_whiteboard_token).

- Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server). (Recommended)

When generating a token, pass in the following parameters:

- A pair of access keys (AK and SK)
- The role of the token
- The validity period of the token
- The Room UUID (for Room Tokens only)
- The Task UUID (for Task Tokens only)

### Get access keys

The access keys consist of an AK (Access Key) and an SK (Secret Key). Follow these steps to get the access keys:

1. On the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.
2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.
3. On the **Whiteboard Configuration** page, find **AK** and **SK**. Click the eye icons on the right to copy the **AK** and **SK**, respectively, to a secure location.![](https://web-cdn.agora.io/docs-files/1616656748111)


<div class="alert note">Unexpected exposure of these access keys can cause severe security problems. To enhance security, Agora recommends the following precautions:
<ul>
<li>Do not send the access keys to your app clients or hard-code the access keys in your app. Ensure that only your app server is allowed to read the access keys from the configuration file.</li>
<li>If you believe there may be a risk that your access keys have been exposed, contact support@agora.io to get new access keys.</li></ul></div>

### Set token role

A token can be assigned to an `admin`, `writer`, or `reader` role. The permissions granted by each token role are described in<a href="#tokenoverview">Introduction</a>.


<div class="alert note">To enhance security, Agora recommends the following precautions:
<ul>
	<li>Avoid sending tokens that grant a lot of permissions to your app clients.</li>
	<li> When it is necessary to send a token to an app client, do not use tokens that grant more permissions than are needed in your app scenario.</li>
	</ul>
</div>

### Set the validity period

Token validity periods are set as positive integers in milliseconds. You can get the expiration time by adding the validity period and the UTC time when the token was generated. Once a token expires, a user cannot use it to join a room or access the whiteboard service. To ensure availability, you should generate new tokens on your app server in a timely manner.

<div class="alert info">If a user uses a token to join a room and the token expires while the user is still in the room, the user will not be kicked out of the room.</div>

Not setting the validity period or setting it to 0 generates a permanent Token,

<div class="alert note">which may cause security risks for your app service. If an illegal user gets a permanent token that grants a lot of permissions, they could use it to disrupt or damage your app system. The only way to invalidate a token is to disable the access keys used to generate it, but this action has significant side effects. Therefore, Agora recommends that you estimate the maximum amount of time a token will be used on app clients based on your app scenario and set this as the validity period.</div>

### Get a Room UUID

To generate a Room Token, you need to pass in the Room UUID, the unique identifier of a whiteboard room, so that the Room Token is linked with the room. Follow these steps to get a Room UUID:

- If the room has been created, [call the Interactive Whiteboard RESTful API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间列表（get）) to get a list of rooms. You can get the corresponding Room UUID in the response body if the request succeeds.
- If the room has not been created, [call the Interactive Whiteboard RESTful API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) to create a room. You can get the corresponding Room UUID in the response body if the request succeeds.

<div class="alert note">
If you call the Interactive Whiteboard RESTful API to generate a Room Token, the SDK Token in the request header must be the same as that used to create the room.</br>

If you generate the Room Token by adding code on the app server, the access keys passed in must be the same as those used to generate the SDK Token for creating the room.
</div>

### Get a Task UUID

To generate a Task Token, you need to pass in the Task UUID, the unique identifier of a file-conversion task, so that the Task Token is linked with the task.

To get a Task UUID, [call the Interactive Whiteboard RESTful API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）) to start a file-conversion task. You can get the Task UUID in the response body if the request succeeds.

## Use a Token

When your app client or server uses a token to access the whiteboard service, the Agora server needs to verify its corresponding permissions.

The following examples explain how tokens are used in this process:

**Example 1: An app client requests to join a room**

1. The app server calls the Interactive Whiteboard RESTful API or uses code to generate an SDK Token.
2. The app server uses the SDK Token to call the Interactive Whiteboard RESTful API to create a room.
3. The Agora server receives the request from the app server and verifies the corresponding permissions. If verification passes and the room is created, the Agora server sends a successful response to the app server.
4. The app server reads the Room UUID in the response and calls the Interactive Whiteboard RESTful API or uses code to generate the Room Token.
5. The app server sends the Room Token and Room UUID to the app client.
6. The app client uses the Room Token and Room UUID to join the room.
7. The Agora server receives the request from the app client and verifies the corresponding permissions. If verification passes, the app client can join the room and use the corresponding features.

**Example 2: An app client requests to start a file-conversion task**

1. The app server calls the Interactive Whiteboard RESTful API or uses code to generate an SDK Token.

2. The app server uses the SDK Token to call the Interactive Whiteboard RESTful API to create a file-conversion task.

3. The Agora server receives the request from the app server and verifies the corresponding permissions. If verification passes and the task is created, the Agora server sends a successful response to the app server.

4. The app server reads the Task UUID in the response and calls the Interactive Whiteboard RESTful API or uses code to generate the Task Token.

5. The app server uses the Task Token and Task UUID to call the Interactive Whiteboard RESTful API to query the progress of the conversion task.

6. The Agora server receives the request from the app client and verifies the corresponding permissions. If verification passes and the request succeeds, the Agora server returns the conversion progress to the app server.


## Invalid Token

A token becomes invalid if one of the following happens:

- The linked project is disabled or deleted. 
This also disables or deletes the access keys in the project, thus invalidating the tokens generated using those access keys.
- The token expires. 
Once a token expires, a user cannot use it to join a room or access the whiteboard service.

## Token errors

You might encounter the following token errors when using the whiteboard service:

| Error | Instruction |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `invalid format of token` | The data format of the token is wrong. Please check:<li>Whether the data type is string.<li>Whether there are extra spaces or characters before and after the token string.<li>Whether the prefix is correct:<ul><li>A SDK Token is prefixed with `NETLESSSDK_.`</li><li>A Room Token is prefixed with `NETLESSROOM_.`</li><li>A Task Token is prefixed with `NETLESSTASK_.`</li></ul> |
| `expired token` | The token expires. Please call the Interactive Whiteboard RESTful API or use code to generate a new token from the app server. |
| `invalid signature of token` | The token signature is invalid. This error might occur if you use code to generate a token from the app server. Ensure that your algorithm and code are correct. |
| `unknown error` | An unknown error occurs. |
| `token access role$`</br>`{permission} forbidden` | The token cannot grant the permission because it is assigned to an inferior role. For instance, you use a `reader` token to access services that must be granted by a `writer `token. Ensure that the token you use can grant the permissions you need. |
| `token access task forbidden` | The Task Token is banned from accessing the file-conversion task. Ensure that the Task Token is generated using the Task UUID of the corresponding file-conversion task. |
| `token access room forbidden` | The Room Token is banned from accessing the room. Ensure that the Room Token is generated using the Room UUID of the corresponding room. |
| `token access team forbidden` | The token is invalid because the linked project is deleted or disabled. |