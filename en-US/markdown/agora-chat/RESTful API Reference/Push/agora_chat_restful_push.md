# Offline Push

This page shows how to call Chat RESTful APIs to set the display name, display style, push notification mode, and do-not-disturb (DND) mode.

Before calling the following methods, ensure that you meet the following:
- You understand the call frequency limit of the Chat RESTful APIs as described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).
- You have activated the advanced features for push in [Agora Console](https://console.agora.io/). Advanced features allow you to set the push notification mode, do-not-disturb mode, and custom push template.

<div class="alert note">You must contact <a href="mailto:support@agora.io">support@agora.io</a> to disable the advanced features for push as this operation will delete all the relevant configurations.</div>

## Common parameters

The following table lists common request and response parameters of the Chat RESTful APIs:

### Request parameters
<a name="request"></a>

| Parameter | Type | Description | Required |
| :--------- | :----- | :----- | :----- |
| `host` | String | The domain name assigned by the Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Chat service. For how to get the organization name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Chat service. For how to get the app name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user.  | Yes |

### Response parameters
<a name="response"></a>

|  Parameter  |  Type  |  Description  |
| :-------- | :--------- | :--------- |
| `action` | String | The request method.   |
| `organization` | String | The unique identifier assigned to each company (organization) by the Chat service. This is the same as `org_name`.    |
| `application` | String | A unique internal ID assigned to each app by the Chat service. You can safely ignore this parameter.     |
| `applicationName`  | String | The unique identifier assigned to each app by the Chat service. This is the same as `app_name`.       |
| `timestamp`  | Number |  The Unix timestamp (ms) of the HTTP response.    |
| `duration`  | Number | The duration (ms) from when the HTTP request is sent to the time the response is received.    |
| `path`  | String | The request path, which is part of the request URL. You can safely ignore this parameter.    |
| `uri`  | String | The request URI.   |
| `entities`  | JSON | The response entities.  |
| `data`  | JSON | The response details.  |


## Authorization

Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).

## Bind or unbind push information

To push messages, you need to bind push information to the device, including the device ID, push certificate, and device token.

- Device ID: The unique identifier assigned by the SDK to each device. 
- Device token: The push token is provided by a third-party push service to identify the app on each device. For example, for the Firebase Cloud Messaging (FCM) push, the device token refers to the registration token that the FCM SDK generates for the client app instance during the first launch of the app. With this token, the third-party push service determines which device the message is sent to, and then sends the message. Upon receiving the message, the device forwards it to the app. 
- Push certificate: The push certificate provided by a third-party push service. Each app has one push certificate.

You can obtain the device token and push certificate name from the third-party push server and upload them to the Chat server which pushes messages to users based on the device token.

You can call this API to bind the push information to the device or unbind them from the device.

### HTTP request

```
PUT https://{host}/{org_name}/{app_name}/users/{username}/push/binding
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#param). 

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the app administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `device_id`     | String | The identifier of a mobile device assigned by the SDK. With the device ID, the Chat server identifies the mobile device before binding or unbinding push information.   | Yes      |
| `notifier_name` | String | The push certificate name: <ul><li>The certificate name you pass in must be the same as the value of `Certificate Name` for FCM or APNs in the **Add Push Certificate** dialog box on the [Agora Console](https://console.agora.io/). Otherwise, the push fails. </li><li>If `notifier_name` is empty, all push information is unbound from the mobile device.</li></ul> | Yes    |
| `device_token`  | String | The device token. If an incorrect device token is passed in, the push fails and the Chat server unbinds the device token from the device. If `device_token` is empty, the Chat server unbinds the current certificate name from the current device.  | Yes       |  

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Description |
| :---- | :----- | :------------------- |
| `entities`  | JSONArray  | The list of push information bound to the current device. For the device that is not bound to any push information, an empty list is returned to the binding request that is sent.|

The `device_id`, `device_token`, and `notifier_name` in the `entities` JSON array in the response have the same meanings as those in the request body of the HTTP request. For details, see parameters in the request body.

For other fields and descriptions, see [Common parameters](#param).

### Example

#### Request example

**Bind push information to a device**

```shell
curl --location --request PUT 'https://XXXX/XXXX/XXXX/users/XXXX/push/binding' \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer <YourAppToken>' \
-d '{    
    "device_id": "8ce08cad-XXXX-XXXX-86c8-695a0d247cda",    
    "device_token": "XXXX",    
    "notifier_name": "104410638"
}'
```

**Unbind push information from the device**

```shell
curl --location --request PUT 'https://XXXX/XXXX/XXXX/users/XXXX/push/binding' \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer <YourAppToken>' \
-d '{    
    "device_id": "8ce08cad-XXXX-XXXX-86c8-695a0d247cda",    
    "device_token": "",    
    "notifier_name": "104410638"
}'
```

#### Response example

**Response to a binding request**

```json
{ 
  "timestamp": 1688030642443, 
  "entities": [ 
    {            
      "device_id": "8ce08cad-9369-XXXX-86c8-695a0d247cda",
      "device_token": "BAEAAAAAB.jkuDmf8hRUPDgOel-zX9exVlcjS1akCWQIUA3XXXX_XXXXHMeFR11PV1of1sVNKPmKdKhMB22YuO8-Z_Ksoqxo8Y",
      "notifier_name": "104410638"       
    }   
  ],    
  "action": "put",   
  "duration": 28
}
```

**Response to an unbinding request**

```json
{    
  "timestamp": 1688030767345,    
  "entities": [],    
  "action": "put",    
  "duration": 24
}
```

## Retrieve the push information bound to devices of a user

Retrieves the push information bound to all devices of the current user.

### HTTP request

```
GET https://{host}/{org_name}/{app_name}/users/{username}/push/binding
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#param). 

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Authorization` | String | The authentication token of the app administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes      |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following parameters:

| Parameter | Type | Description |
| :----- | :--- | :----------- |
| `entities` | JSONArray | The list of push information bound to all devices of the current user. If the current user has no device bound to any push information, an empty list is returned. |

The `device_id`, `device_token`, and `notifier_name` in the `entities` JSON array in the response have the same meanings as those in the request body of the HTTP request. For details, see parameters in the request body.

For the other parameters and descriptions, see [Common parameters](#param).

### Example

#### Request example

```shell
curl --location --request GET 'https://XXXX/XXXX/XXXX/users/XXXX/push/binding' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{    
  "timestamp": 1688031327535,   
  "entities": [       
    {            
      "device_id": "8ce08cad-9369-4bdd-XXXX-695a0d247cda",      
      "device_token": "BAEAAAAAB.jkuDmf8hRUPDgOel-zX9exVlcjS1akCWQIUA3XXXX_XXXXHMeFR11PV1of1sVNKPmKdKhMB22YuO8-Z_Ksoqxo8Y",  
      "notifier_name": "104410638"      
    }   
    {            
      "device_id": "8ce08cad-9369-4bdd-XXXX-695a0d247cda",      
      "device_token": "BAEAAAAAB.jkuDmf8hRUPDgOel-zX9exVlcjS1akCWQIUA3XXXX_XXXXHMeFR11PV1of1sVNKPmKdKhMB22YuO8-Z_Ksoqxo8Y",  
      "notifier_name": "104410638"      
    }  
  ],    
  "action": "get",    
  "duration": 6
}
```

## Set the display name in push notifications

Sets the nickname displayed in push notifications.

For each App Key, the total call frequency limit of this method and the method to set the display style is 100 per second.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/users/{username}
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Content-Type` | String | The content type. Set it as `application/json`.   | Yes  |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `nickname` | String | The nickname that is displayed in the push notification bar of the recipient's client when a message from the user is pushed. The length of the nickname cannot exceed 100 characters, and the following character sets are supported:<li>26 lowercase English letters (a-z)<li>26 uppercase English letters (A-Z)<li>10 numbers (0-9)<li>Chinese characters<li>Special characters <br/>If no nickname is set, when a message from this user is pushed, the user ID of the message sender, instead of the nickname, is indicated in the notification details (`notification_display_style` is set to 1). <div class="alert note">The nickname can be different from the nickname in user attributes. However, Agora recommends that you use the same nickname for both. Therefore, if either nickname is updated, the other should be changed at the same time. To update the nickname in user attributes, see <a href="https://docs.agora.io/en/agora-chat/agora_chat_restful_user_attributes?platform=RESTful#setting-user-attributes">Setting user attributes</a>.</div>  | No  |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
|  `uuid` | String | A unique internal identifier generated by the Chat service for the user in this request. |
| `type`  |  String  | The type of the chat. "user" indicates a one-to-one chat. |
| `created`  | Number | The Unix timestamp (ms) when the user account is registered.  |
| `modified`  | Number | The Unix timestamp (ms) when the user information is last modified.  |
| `username`  | String | The ID of the user. |
| `activated`  | Bool | Whether the user account is active:<li>`true`: The user account is active.<li>`false`: The user account is deactivated. To unban a deactivated user account, refer to [Unbanning a user](./agora_chat_restful_registration#unbanning-a-user). |
|  `nickname`  | String | The nickname displayed in push notifications.  |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{ "nickname": "testuser" }' 'http://XXXX/XXXX/XXXX/users/user1'
```

#### Response example

```json
{  
  "action": "put",  
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",  
  "path": "/users",  
  "uri": "https://XXXX/XXXX/XXXX/users",  
  "entities": [    
    {      
      "uuid": "4759aa70-XXXX-XXXX-925f-6fa0510823ba",      
      "type": "user",      
      "created": 1542595573399,      
      "modified": 1542596083687,      
      "username": "user1",      
      "activated": true,      
      "nickname": "testuser"    
      }  ],  
"timestamp": 1542596083685,  
"duration": 6,  
"organization": "agora-demo",  
"applicationName": "testapp"
}
```


## Set the display style in push notifications

Sets the display style of push notifications.

For each App Key, the total call frequency limit of this method and the method to set the display name is 100 per second.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/users/{username}
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `notification_display_style` | Int | The display style of push notifications:<ul><li>(Default) `0`: The push title is "You have a new message", and the push content is "Click to check".</li><li>`1`: The push title is "You have a new message", and the push content contains the nickname of the sender and the content of the offline message.</li></ul>  | No  |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
|  `uuid` | String | A unique internal identifier generated by the Chat service for the user in this request. |
| `type`  | String | The type of the chat. "user" indicates a one-to-one chat. |
| `created`  | Number | The Unix timestamp (ms) when the user account is registered.  |
| `modified`  | Number | The Unix timestamp (ms) when the user information is last modified.  |
| `username`  | String | The ID of the user. |
| `activated`  | Bool | Whether the user account is active:<li>`true`: The user account is active.<li>`false`: The user account is deactivated. To unban a deactivated user account, refer to [Unbanning a user](./agora_chat_restful_registration#unbanning-a-user). |
| `notification_display_style`  |  Int  | The display style of push notifications. This parameter is returned only if you specify it when sending the request. |
| `nickname`  | String | The nickname displayed in push notifications. |
| `notifier_name` | String  | The name of the push certificate. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -X PUT -H "Authorization: Bearer <YourAppToken>" -i https://XXXX/XXXX/XXXX/users/a -d '{"notification_display_style": "1"}'
```

#### Response example

```json
{  
  "action" : "put",  
  "application" : "17d59e50-XXXX-XXXX-8092-0dc80c0f5e99",  
  "path" : "/users",  
  "uri" : "https://XXXX/XXXX/XXXX/users",  
  "entities" : [ 
    {    
      "uuid" : "3b8c9890-XXXX-XXXX-9d88-f50bf55cafad",    
      "type" : "user",    
      "created" : 1530276298905,    
      "modified" : 1534407146060,   
      "username" : "user1",    
      "activated" : true,      
      "notification_display_style" : 1,    
      "nickname" : "testuser",    
      "notifier_name" : "2882303761517426801"  
      } ],  
"timestamp" : 1534407146058,  
"duration" : 3,  
"organization" : "XXXX",  
"applicationName" : "XXXX"
}
```


## Set up push notifications

Sets the push notification and DND modes at both the app and conversation levels.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
PUT https://{host}/{org}/{app}/users/{username}/notification/{chattype}/{key}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `chattype` | String | The type of the chat:<li>`user`: one-to-one chats.<li>`chatgroup`: Group chats.  | Yes |
| `key` | String | The identifier of the chat:<li>If `type` is set to `user`, `key` indicates the user ID of the peer user.<li>If `type` is set to `chatgroup`, `key` indicates the ID of the chat group. | Yes |

<div class="alert info">To set up push notifications at the app level, you can set <code>type</code> to <code>user</code> and <code>key</code> to the user ID of the current user.</div>

For the descriptions of other path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Content-Type` | String | The content type. Set it as `application/json`.   | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `type` | String | The push notification mode:<li>`DEFAULT`: A specific conversation uses the setting at the app level. This parameter is valid only for one-to-one and group chat conversations, but not for the app level. <li>`ALL`: Receives push notifications for all offline messages.<li>`AT`: Only receives push notifications for mentioned messages.<li>`NONE`: Do not receive push notifications for offline messages.  | No |
| `ignoreInterval` | String | The interval during which the DND mode is scheduled everyday. The value is in the format of {HH:MM-HH:MM}, for example, 08:30-10:00, where HH ranges from `00` to `23` in hour and MM from `00` to `59` in minute. <ul><li>This parameter works only when `chattype` is set to `user` and `key` to the current user ID in the request header, meaning that the DND interval is valid only for the entire app rather than specific one-to-one or group chat conversations.</li><li>The DND mode is enabled everyday in the specified interval. For example, if you set this parameter to 08:00-10:00, the app stays in DND mode during 8:00-10:00; if you set the same period at 9:00, the DND mode works during 9:00-10:00 on the current day and 8:00-10:00 in later days.</li><li>If the start time is set to the same time spot as the end time, like 00:00-00:00, the app enters the permanent DND mode.</li><li>If the start time is later than the end time, the app remains in DND mode from the start time on the current day until the end time next day. For example, if you set 10:00-08:00, the DND mode lasts from 10:00 until 08:00 the next day. </li><li> Currently, only one DND interval is allowed, with the new setting overwriting the old.</li><li>If this parameter is not specified, pass in an empty string.</li><li> If both `ignoreInterval` and `ignoreDuration` are set, the DND mode works in both periods. For example, at 8:00, you set `ignoreInterval` to 8:00-10:00 and `ignoreDuration` to 14400000 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li></ul>  | No |
| `ignoreDuration` | Number   | The DND duration in milliseconds. The value range is [0,604800000], where `0` indicates that this parameter is invalid and `604800000` indicates that the DND mode lasts for 7 days. <ul><li>This parameter works for both the app and one-to-one and group chat conversations in it. </li><li> Unlike `ignoreInterval` set as a daily period, this parameter specifies that the DND mode works only for the given duration starting from the current time. For example, if this parameter is set to 14400000 (4 hours) for the app at 8:00, the DND mode lasts only during 8:00-12:00 on the current day.</li><li> If both `ignoreInterval` and `ignoreDuration` are set, the DND mode remains in both periods. For example, at 8:00, you set `ignoreInterval` to 8:00-10:00 and `ignoreDuration` to 14400000 (4 hours) for the app, the app stays in DND mode during 8:00-12:00 on the current day and 8:00-10:00 in the later days.</li></ul> | No  |

<div class="alert note">For both the app and all the conversations in the app, the DNS mode setting (`ignoreInterval` or `ignoreDuration`) takes precedence over the setting of the push notification mode (`type`). For example, assume that `ignoreInterval` or `ignoreDuration` is specified at the app level and `type` is set to `ALL` for a specific conversation. The app enters the DND mode during the designated period and you do not receive any push notifications during the period.</div>


### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `type`  | String | The push notification mode. |
| `ignoreInterval`  | String | The DND interval.  |
| `ignoreDuration`  | Long | The DND duration. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -L -X PUT 'http://XXXX/XXXX/XXXX/users/{username}/notification/user/{key}' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "type":"NONE",
    "ignoreInterval":"21:30-08:00",
    "ignoreDuration":86400000
}'
```

#### Response example

```json
{
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users/notification/user/hxtest",
    "timestamp": 1647503749918,
    "organization": "XXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "type": "NONE",
        "ignoreDuration": 1647590149924,
        "ignoreInterval": "21:30-08:00"
    },
    "duration": 20,
    "applicationName": "XXXX"
}
```


## Retrieve the settings of push notifications

Retrieves the push notification and DND modes at both the app and conversation levels.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/notification/{chattype}/{key}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `chattype` | String | The type of the chat:<li>`user`: One-to-one chats.<li>`chatgroup`: Group chats.  | Yes |
| `key` | String | The identifier of the chat:<li>If `type` is set to `user`, `key` indicates the user ID of the peer user.<li>If `type` is set to `chatgroup`, `key` indicates the ID of the chat group. | Yes |

For the descriptions of other path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `type`  | String | The push notification mode. |
| `ignoreInterval`  | String | The DND interval.  |
| `ignoreDuration`  | Long | The DND duration. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -L -X GET 'https://XXXX/XXXX/XXXX/users/{username}/notification/chatgroup/{key}' \
-H 'Authorization: Bearer <YourAppToken>' 
```

#### Response example

```json
{
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users/notification/chatgroup/12312312321",
    "timestamp": 1647503749918,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "get",
    "data": {
        "type": "NONE",
        "ignoreDuration": 1647590149924,
        "ignoreInterval": "21:30-08:00"
    },
    "duration": 20,
    "applicationName": "XXXX"
}
```


## Set the preferred language of push notifications

Sets the preferred language of push notifications.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/users/{username}/notification/language
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Content-Type` | String | The content type. Set it as `application/json`.   | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `translationLanguage` | String | The code for the language that the user prefers to see push notifications in. If set to an empty string, the server pushes the notifications of the original language directly.  | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `language`  | String | The code for the language that the user prefers to see push notifications in. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -L -X PUT 'https://XXXX/XXXX/XXXX/users/{username}/notification/language' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "translationLanguage":"EU"
}'
```

#### Response example

```json
{
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users/notification/language",
    "timestamp": 1648089630244,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "language": "EU"
    },
    "duration": 66,
    "applicationName": "XXXX"
}
```


## Retrieve the preferred language of push notifications

Retrieves the preferred language of push notifications.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org}/{app}/users/{username}/notification/language
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Content-Type` | String | The content type. Set it as `application/json`.   | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `language`  | String | The code for the language that the user prefers to see push notifications in. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -L -X GET 'https://XXXX/XXXX/XXXX/users/{username}/notification/language' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users/notification/language",
    "timestamp": 1648089630244,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "language": "EU"
    },
    "duration": 66,
    "applicationName": "XXXX"
}
```


## Create a push template

Creates a template for push notifications.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
POST https://{host}/{org}/{app}/notification/template`
```

#### Path parameter

For the descriptions of path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Content-Type` | String | The content type. Set it as `application/json`.   | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `name` | String | The name of the push template. | Yes |
| `title_pattern` | String | The custom title of the push template. You can add variables in the title, such as {0}. | Yes |
| `content_pattern` | String | The custom content of the push template. You can add variables in the content, such as {0} and {1}. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `name`  | String | The name of the push template. |
| `createAt`  | Number | The Unix timestamp (ms) when the template is created. |
| `updateAt`  | Number | The Unix timestamp (ms) when the template is last modified. |
| `title_pattern`  | String | The custom title of the push template. |
| `content_pattern`  | String | The custom content of the push template. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -X POST 'https://XXXX/XXXX/XXXX/notification/template' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "name": "test7",
    "title_pattern": "Hello,{0}",
    "content_pattern": "Test,{0}"
}'
```

#### Response example

```json
{
    "uri": "https://XXXX/XXXX/XXXX/notification/template",
    "timestamp": 1646989584108,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "post",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 26,
    "applicationName": "XXXX"
}
```


## Retrieve a push template

Retrieves the specified template for push notifications.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```
GET https://{host}/{org}/{app}/notification/template/{name}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `name` | String | The name of the push template.  | Yes |

For the descriptions of other path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `name`  | String | The name of the push template. |
| `createAt`  | Number | The Unix timestamp (ms) when the template is created. |
| `updateAt`  | Number | The Unix timestamp (ms) when the template is last modified. |
| `title_pattern`  | String | The custom title of the push template. |
| `content_pattern`  | String | The custom content of the push template. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -X GET 'https://XXXX/XXXX/XXXX/notification/template/{name}' \
-H 'Authorization: Bearer <YourAppToken>' 
```

#### Response example

```json
{
    "uri": "https://XXXX/XXXX/XXXX/notification/template/test7",
    "timestamp": 1646989686393,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "get",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 11,
    "applicationName": "XXXX"
}
```


## Delete a push template

Deletes the specified template for push notifications.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
DELETE https://{host}/{org}/{app}/notification/template/{name}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `name` | String | The name of the push template.  | Yes |

For the descriptions of other path parameters, see [Common Parameters](#request).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | -------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `name`  | String | The name of the push template. |
| `createAt`  | Number | The Unix timestamp (ms) when the template is created. |
| `updateAt`  | Number | The Unix timestamp (ms) when the template is last modified. |
| `title_pattern`  | String | The custom title of the push template. |
| `content_pattern`  | String | The custom content of the push template. |

For other fields and detailed descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```bash
curl -X DELETE 'https://XXXX/XXXX/XXXX/notification/template' \
-H 'Authorization: Bearer <YourAppToken>' 
```

#### Response example

```json
{
    "uri": "https://XXXX/XXXX/XXXX/notification/template",
    "timestamp": 1646989686393,
    "organization": "XXXX",
    "application": "17fe201b-XXXX-XXXX-83df-1ed1ebd7b227",
    "action": "delete",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 11,
    "applicationName": "XXXX"
}
```


## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code).