# User attributes

User attributes refer to the information specific to a user, including the nickname, avatar, age, mobile phone number, and so on. Managing user attributes in a real-time chat session enables you to set and retrieve the information of a specified user or the specified users.

This page shows how to implement managing user attributes in your app by using the REST APIs provided by Agora.

> To manage user attributes, you need to store the user information in the Agora Chat server. If you are not comfortable with this, we recommend you managing user attributes yourself. 

## Basic information

Agora Chat provides servier-side services with REST APIs, which support the HTTP protocol and apply to various programming languages. The basic URL is `api.agora.io`.

## Set user attributes

This method sets the attributes of a specified user.

- Method: PUT
- Request URL: `/{org_name}/{app_name}/metadata/user/{username}`

### Path parameter

| Parameter | Description |
| --- | --- |
| `org_name` | The name of your organization or company. The value of this parameter is the same with the company name that you fill when you create an account on [Agora Console](https://console.agora.io/). |
| `app_name` | The name of your app. The value of this parameter is the same with the project name that you fill when you create a project on Agora Console. |
| `username` | The name of the user whose user attributes you want to set. |

### Request header

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `Content-Type` | String | Yes | The data type sent from the app client to the server. Set it as `application/x-www-form-urlencoded`. |
| `Authorization` | String | Yes | Your token for authentication. For details, see [Generate a token](). |


### Request body

| Parameter | Type | Manadatory | Description |
| --- | --- | --- | --- |
| `nickname` | String | No | The nickname of the user. |
| `avatarurl` | String | No | The URL address of the avator file. |
| `phone` | String | No | The phone number. |
| `mail` | String | No | The E-mail address. |
| `gender` | Number | No | The gender of the user. |
| `sign` | String | No | The personal message. |
| `birth` | String | No | The birthday infromation. |
| `ext` | String | No | Extra information. |

### Request sample

```json
curl -X PUT -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Bearer WMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw12' -d 'avatar=http://www.agorachat.com/avatar.png&ext=ext&nickname=nickname' 'http://a1.agorachat.com/agorachat-demo/testapp/metadata/user/user1'
```

### Response parameter

When the request succeeds, the reponse returns 200 with the following parameters:

| Parameter | Description |
| --- | --- |
| `timestamp` | The timestamp of this response. |
| `data` | The detailed information of the user attributes, including the following the members:<ul><li>`nickname`: The nickname of the user.</li><li>`avatarurl`: The URL address of the avatar file.</li><li>`phone`: The phone number.</li><li>`mail`: The E-mail address.</li><li>`gender`: The gender of the user.</li><li>`sign`: The personal message.</li><li>`birth`: The birthday information.</li><li>`ext`: Extra information.</li></ul>|
| `duration` | The time elapsed between sending the request and receiving the response. |

When the request fails, it returns a state code and the detailed desciption of the error message in `desc`. 

| State Code | Error message in `desc` | Description |
| --- | --- | --- | --- |
| 401 | `unauthorized` | You have no permission to set the user attributes. Only the user themselves and app admin have the privilege to do so. This error also occurs when you try to set the attributes of a user that does not exist. |
| 403 | `user metadata length exceed the limit` | The user attribtues you set exceeds the data size limit. This can either be the attributes of one user, or the attributes of all the users in the app. |
| 404 | `Not found` | The user does not exist. |
| 409 | `update userMetadata failed, concurrent updates not allowed` | Another user is modifying the user attributes. When more than one app clients attemp to modify the user attributes at the same time, only one client succeeds. All Other clients receive 409. |
| 500 | `org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection` | This is usually an MySQL error. Contact Agora if this error persists. |
| 429, 503, or 5xx | The request exceeds the QPS limit. | Pause and try again later.|

### Response sample 

```json
// Request succeeds
{
    "timestamp":1620445147011,
    "data":{
        "ext":"ext",
        "nickname":"nickname",
        "avatar":"http://www.easemob.com/avatar.png"
    },
    "duration":166
}

// Request fails with the state code 401
{
    "desc": "unauthorized",
    "duration": 10,
    "timestamp": 1616573382270
}

// Request fails with the state code 403
{
    "desc": "user metadata length exceed the limit",
    "duration": 10,
    "timestamp": 1616573382270
}

// Request fails with the state code 404
{
    "timestamp":1620445340631,
    "desc":"Not Found",
    "duration":0
}

// Request fails with the state code 409
{
   "desc": "update userMetadata failed, concurrent updates not allowed",
   "duration": 10,
   "timestamp": 1616573382270
}

// Request fails with the state code 500
{
   "desc": "org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection",
   "duration": 10,
   "timestamp": 1616573382270
}
```

## Retrieve user attributes

This method retrieves the user attributes of the specified user in the key-value format. If the specified user or user attribute does not exist, the response returns an empty `data` object.

- Method: GET
- Request URL: `/{org_name}/{app_name}/metadata/user/{username}`

### Path parameter

| Parameter | Description |
| --- | --- |
| `org_name` | The name of your organization or company. The value of this parameter is the same with the company name that you fill when you create an account on [Agora Console](https://console.agora.io/). |
| `app_name` | The name of your app. The value of this parameter is the same with the project name that you fill when you create a project on Agora Console. |
| `username` | The name of the user whose user attributes you want to get. |

### Request header

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `Authorization` | String | Yes | Your token for authentication. For details, see [Generate a token](). |

### Request sample

```json
curl -X GET -H 'Content-Type: application/json' -H 'Authorization: Bearer YWMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw' 'http://a1.easemob.com/easemob-demo/testapp/metadata/user/user1'
```

### Response parameter

When the request succeeds, the reponse returns 200 with the following parameters:

| Parameter | Description |
| --- | --- |
| `timestamp` | The timestamp of this response. |
| `data` | The detailed information of the user attributes, including the following the members:<ul><li>`nickname`: The nickname of the user.</li><li>`avatarurl`: The URL address of the avatar file.</li><li>`phone`: The phone number.</li><li>`mail`: The E-mail address.</li><li>`gender`: The gender of the user.</li><li>`sign`: The personal message.</li><li>`birth`: The birthday information.</li><li>`ext`: Extra information.</li></ul>|
| `duration` | The time elapsed between sending the request and receiving the response. |

When the request fails, it returns a state code in the and the detailed desciption of the error message in `desc`.

| State Code | Error message in `desc` | Description |
| --- | --- | --- | --- |
| 404 | `Not found` | The user does not exist. |
| 500 | `org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection` | This is usually an MySQL error. Contact Agora if this error persists. |
| 429, 503, or 5xx | The request exceeds the QPS limit. | Pause and try again later.|

### Response body

```json
// Request succeeds
{
    "timestamp":1620446048161,
    "data":{
        "ext":"ext",
        "nickname":"nickname",
        "avatar":"http://www.easemob.com/avatar.png"
    },
    "duration":2
}

// Request fails with the state code 404
{
    "timestamp":1620446033278,
    "data":{

    },
    "duration":9
}

// Request fails with the state code 500
{
    "desc": "org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection",
    "duration": 10,
    "timestamp": 1616573382270
}
```

## Retrieve specified user attributes

This method retrieves the specified user attributes of the specified users. If the specified user or attribute does not exist, the reponse returns am empty data object.

- Method: POST
- Request URL: `/{org_name}/{app_name}/metadata/user/get`

### Path parameter

| Parameter | Description |
| --- | --- |
| `org_name` | The name of your organization or company. The value of this parameter is the same with the company name that you fill when you create an account on [Agora Console](https://console.agora.io/). |
| `app_name` | The name of your app. The value of this parameter is the same with the project name that you fill when you create a project on Agora Console. |

### Request header

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `Content-Type` | String | Yes | The data type sent from the app client to the server. Set it as `application/json`. |
| `Authorization` | String | Yes | Your token for authentication. For details refer to [Generate a token](). |

### Request body

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `targets` | list | Yes | The list of usernames. You can specify a maximum of 100 usernames for each request.|
| `properties` | list | No | The list of the specified attributes. The request returns only the specified attribtues. |

### Request sample

```json
curl -X POST -H 'Content-Type:  application/json' -H 'Authorization: Bearer YWMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw' -d '{
  "properties": [
    "avatar",
    "ext",
    "nickname"
  ],
  "targets": [
    "user1",
    "user2",
    "user3"
  ]
}' 'http://a1.easemob.com/easemob-demo/testapp/metadata/user/get'
```

### Response body

When the request succeeds, the reponse returns 200 with the following parameters:

| Parameter | Description |
| --- | --- |
| `timestamp` | The timestamp of this response. |
| `data` | The detailed information of the specified user with the specified attributes:<ul><li>`username1`: The specified user, with the specified attributes in the format of list.<li>`username2`: The specified user, with the specified attributes in the format of list.</li><li>...</li></ul>|
| `duration` | The time elapsed between sending the request and receiving the response. |

When the request fails, it returns a state code in the and the detailed desciption of the error message in `desc`.

| State Code | Error message in `desc` | Description |
| --- | --- | --- | --- |
| 403 | `user metadata length exceed the limit` | The number of the specified usernames exceeds 100.|
| 500 | `org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection` | This is usually an MySQL error. Contact Agora if this error persists. |
| 429, 503, or 5xx | The request exceeds the QPS limit. | Pause and try again later.|

### Response sample

```json
// Request succeeds
{
    "timestamp":1620448826647,
    "data":{
        "user1":{
            "ext":"ext",
            "nickname":"nickname",
            "avatar":"http://www.easemob.com/avatar.png"
        },
        "user2":{
            "ext":"ext",
            "nickname":"nickname",
            "avatar":"http://www.easemob.com/avatar.png"
        },
        "user3":{
            "ext":"ext",
            "nickname":"nickname",
            "avatar":"http://www.easemob.com/avatar.png"
        }
    },
    "duration":3
}

// Request fails with the state code 403
{
   "desc": "exceed allowed batch size 100",
   "duration": 10,
   "timestamp": 1616573382270
}

// Request fails with the state code 500
{
    "desc": "org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection",
    "duration": 10,
    "timestamp": 1616573382270
}
```

## Retrieve the size of all user attributes

This method retrieves the total size (Bytes) of all the attributes of all the users in the app. 

- Method: GET
- Request URL: `/{org_name}/{app_name}/metadata/user/capacity`

### Path parameter

| Parameter | Description |
| --- | --- |
| `org_name` | The name of your organization or company. The value of this parameter is the same with the company name that you fill when you create an account on [Agora Console](https://console.agora.io/). |
| `app_name` | The name of your app. The value of this parameter is the same with the project name that you fill when you create a project on Agora Console. |

### Request header

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `Authorization` | String | Yes | Your token for authentication. Ensure that this is the token with the privilege of an admin. For details, see [Generate a token](). |

### Request sample

```json
curl -X GET -H 'Content-Type: application/json' -H 'Authorization: Bearer YWMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw' 'http://a1.easemob.com/easemob-demo/testapp/metadata/user/capacity'
```

### Response body

When the request succeeds, the reponse returns 200 with the following parameters:

| Parameter | Description |
| --- | --- |
| `timestamp` | The timestamp of this response. |
| `data` | The data size of the attributes of all the users in the app. |
| `duration` | The time elapsed between sending the request and receiving the response. |

When the request fails, it returns a state code and the detailed desciption of the error message in `desc`. 

| State Code | Error message in `desc` | Description |
| --- | --- | --- | --- |
| 401 | `unauthorized` | You have no permission retrieve the size of the user attributes. Only the app admin has the priviledge to do so. |
| 500 | `org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection` | This is usually an MySQL error. Contact Agora if this error persists. |
| 429, 503, or 5xx | The request exceeds the QPS limit. | Pause and try again later.|

### Response sample

```json
// Request succeeds
{
    "timestamp": 1620447051368,
    "data": 1673,
    "duration": 55
}

// Request fails with the state code 401
{
   "desc": "unauthorized",
   "duration": 10,
   "timestamp": 1616573382270
}

// Request fails with the sata code 500
{
    "desc": "org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection",
    "duration": 10,
    "timestamp": 1616573382270
}
```

## Delete user attributes

This method deletes all the attributes of the specified user. If the specified user or the user attributes do not exist, the server takes it as user attributes deleted and returns success.

- Method: DELETE
- Request URL: `/{org_name}/{app_name}/metadata/user/{username}`

### Path parameter

| Parameter | Description |
| --- | --- |
| `org_name` | The name of your organization or company. The value of this parameter is the same with the company name that you fill when you create an account on [Agora Console](https://console.agora.io/). |
| `app_name` | The name of your app. The value of this parameter is the same with the project name that you fill when you create a project on Agora Console. |

### Request header

| Parameter | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `Authorization` | String | Yes | Your token for authentication. Ensure that this is the token with the privilege of an admin. For details, see [Generate a token](). |

### Request sample

```json
curl -X DELETE -H 'Content-Type: application/json' -H 'Authorization: Bearer YWMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw' 'http://a1.easemob.com/easemob-demo/testapp/metadata/user/user1'
```

### Response body

When the request succeeds, the reponse returns 200 with the following parameters:

| Parameter | Description |
| --- | --- |
| `timestamp` | The timestamp of this response. |
| `data` | The result of the request: <ul><li>`true`: The request succeeds and the user attributes are deleted. Deleting the user attributes of a user that does not exist is also considered success. </li><li>`false`: The request fails.</li></ul> |
| `duration` | The time elapsed between sending the request and receiving the response. |

When the request fails, it returns a state code and the detailed desciption of the error message in `desc`. 

| State Code | Error message in `desc` | Description |
| --- | --- | --- | --- |
| 401 | `unauthorized` | You have no permission retrieve the size of the user attributes. Only the app admin has the priviledge to do so. |
| 500 | `org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection` | This is usually an MySQL error. Contact Agora if this error persists. |
| 429, 503, or 5xx | The request exceeds the QPS limit. | Pause and try again later.|

### Reponse sample

```json
// Request success
{
    "timestamp": 1620447526237,
    "data": true,
    "duration": 160
}

// Request fails with the state code 401
{
   "desc": "unauthorized",
   "duration": 10,
   "timestamp": 1616573382270
}

// Request fails with the state code 500
{
    "desc": "org.hibernate.exception.JDBCConnectionException: Unable to acquire JDBC Connection",
    "duration": 10,
    "timestamp": 1616573382270
}
```




