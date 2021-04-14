---
title: RESTful API
platform: All_Platforms
updatedAt: 2020-08-06 18:28:18
---
# Dashboard RESTful API

## 1. Authentication

The RESTful API only supports HTTPS, and the user must pass the basic HTTP authentication with the following information:

-   **User Name**: Customer ID
-   **Password**: Customer Certificate


Unlike the App ID and App Certificate used for Agora SDKs, the Customer ID and Customer Certificate are only used for RESTful API access.

> You can login [https://dashboard.agora.io](https://dashboard.agora.io), click the account name on the top right of the dashboard, and enter the **Restful API** page from the drop-down list to get the **Customer ID** and **Customer Certificate**.
> Currently, the Vendor Key and Sign Key are renamed to the App ID and App Certificate respectively on the Dashboard, but *vendor\_key* and *sign\_key* are still used in this document.

## 2. EndPoint

All requests should be sent to BaseUrl: *https://api.agora.io/dev/v1*.

- Request: All parameters must be sent in JSON format, with content type: Content-Type: application/json.
- Response: The response content is in JSON format. The response status is defined as follows:

  -   Status 200: Request handle successful.
  -   Status 400: The input is in the wrong format.
  -   Status 401: Unauthorized \(incorrect App ID/Customer Certificate\).
  -   Status 404: Wrong API invoked.
  -   Status 500: Internal error of the Agora RestfulAPI service.

## 3. Project API

BaseUrl: **http://api.agora.io/dev/v1**.

### Fetch all Projects (GET)

-  Method: GET
-  Path: BaseUrl/projects/
-  Parameter: None
-  Response:

	```
	{
		"projects":[

								{

									"id": 'xxxx',
									"name": 'project1',
									"vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
									"sign_key": '4855898a22ae4102a29b81ba76f2eae2',
									"recording_server": '10.2.2.8:8080',
									"status": 1,
									"created": 1464165672

								}

						 ]
	}
	```

- Status:

  -  1: Active
  -  0: Disable


### Fetch a Single Project (GET)

-  Method: GET
-  Path: BaseUrl/project/
-  Parameter:

	```
	{
		"id":'xxxx',
		"name":'xxxx'
	}
	```

-  Response:

	```
	{
		"projects":[

						 {

									"id": 'xxxx',
									"name": 'project1',
									"vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
									"sign_key": '4855898a22ae4102a29b81ba76f2eae2',
									"recording_server": '10.2.2.8:8080',
									"status": 1,
									"created": 1464165672

								}

						 ]
	}
	```

- Status:

  -  1: Active
  -  0: Disable


### Create a Project (POST)

-  Method: POST
-  Path: BaseUrl/project/
-  Parameter:

	```
	{
		"name":'projectx',
		"enable_sign_key": true
	}
	```

- Response

	```
	{
		"project":
						{

							 "id": 'xxxx',
							 "name": 'project1',
							 "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
							 "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
							 "status": 1,
							 "created": 1464165672

						}
	}
	```

### Disable/Enable a Project (POST)

-  Method: POST
-  Path: BaseUrl/project\_status/
-  Parameter:

	```
	{
		"id":'xxx',
		"status": 0
	}
	```

-  Response:

    -  Success:

			```
			{
				"project":
								{

								 "id": 'xxxx',
								 "name": 'project1',
								 "vendor_key": '4855898a22ae4102a29b81ba76f2eae2',
								 "sign_key": '4855898a22ae4102a29b81ba76f2eae2',
								 "status": 0,
								 "created": 1464165672

								 }

			 }
			```

    -  If a specified project does not exist \(deleted or no such project\):

        ```
        status 404
        content:
        {
        
          "error_msg": "project not exist"
        
        }
        ```


### Delete a Project (DELETE)

-  Method: DELETE
-  Path: BaseUrl/project/
-  Parameter:

	```
	{
		"id":'xxxx'
	}
	```

-  Response:

  -  Project deleted:

		```
		{
			"success": true
		}
		```

  -  Project not found:

		```
		status 404

		 {
				"error_msg": "project not exist"
		 }
		```

### Set a Project’s Recording Server IP (POST)

-  Method: POST
-  Path: BaseUrl/recording\_config/
-  Parameter:

	```
	{
		"id":'xxxx',
		"recording_server": '10.12.1.5:8080'
	}
	```

>  - If your Recording SDK version is before v1.9.0 (include), please pay attention to the `recording_server` parameter.
>  - If your Recording SDK version is later than v1.11.0 (include), please neglect the `recording_server` parameter.

-  Response:

   -  Success:

		```
		{
			"success": true
		}
		```

   -  Project not found or disabled:

    ```
    status 404
    
     {
       "error_msg": "project not exist"
     }
    ```


### Enable a Project’s App Certificate (POST)

-  Method: POST
-  Path: BaseUrl/signkey/
-  Parameter:

	```
	{
		"id": `xxx`,
		"enable": true
	}
	```

-  Response:

   -  Success:

		```
		{

			"success": true

		}
		```

   -  Project not found or disabled:

		```
		status 404
		{

			"error_msg": "project not exist"

		}
		```

### Reset a Project’s App Certificate (POST)

-  Method: POST
-  Path: BaseUrl/reset_signkey/
-  Parameter:

	```
	{ "id" : "xxx"}   // project id
	```

-  Response:

   -  Success:

		```
		{
			"success": true
		}
		```

   -  Project not found or disabled:

		```
		status 404
			{
				"error_msg": "project not exist"
			}
		```

> If an App Certificate is not enabled for a project, calling this method will enable it.

## 4. Usage API

BaseUrl: **https://api.agora.io/dev/v1**.

### Fetch Usages (GET)

-  Method: GET
-  Path: BaseUrl/usage/
-  Parameter: (from date & to date pattern: YYYY-MM-DD)

	```
	"from_date"=YYYY-MM-DD&to\_date=YYYY-MM-DD&projects=id1,id2,id3
	"from_date"=2015-01-01&to_date=2015-03-21&projects=id1,id2
	```

   It is optional to specify projects. If it is not specified, the usage is queried on all projects of this account.

-  Response:

   -  Success:

		```
		{
			"usages":[

								{ "project": 'xxx',
														"daily": [
																	{ "date": 20150101, "audio": 20, "sd": 100, "hd": 132, "hdp": 225},
																	{ "date": 20150102, "audio": 20, "sd": 100, "hd": 132, "hdp": 225},
															]
														},

														{ "project": 'yyy',
															"daily": [....]
														}

							]
		}
		```

   -  Error:

      If some of the specified projects do not exist, they will be omitted and no error will occur.

> The *audio*, *sd*, *hd* and *hdp* parameters in this response are in minutes.

## 5. Ban Users at the Server

BaseUrl: **https://api.agora.io/dev/v1**.

> Contact [sales-us@agora.io](mailto:sales-us@agora.io) to enable this service before using the following methods.

### Create a Rule (POST)

-  Method: POST
-  Path: BaseUrl/kicking-rule/
-  Parameter:

    ```
    {
            "appid":"",   // Mandatory, project App ID
            "cname":"",   // Optional, channel name. Do not pass cname:""
            "uid":"",     // Optional, UID which can be obtained by using the SDK API. Do not pass uid:0
            "ip":"",      // Optional, IP address of the user to be banned. Do not pass ip:0
            "time": 60    // Optional, banned period in minutes. 1440 minutes maximum, 1 minute minimum. If you set it to over 1440 minutes, it will be processed as 1440 minutes
     }
    ```

> The ban rule is based on the permutation and combination of the three fields: cname, uid and ip. See the following examples:
> -   If you pass the ip parameter, but not cname or uid, then the rule is that this ip cannot login any channel in the App.
> -   If you pass the cname parameter, but not uid or ip, then the rule is that no one can login the channel specified by the cname parameter.
> -   If you pass the cname and uid parameter, but not ip, then the rule is that the uid cannot login the channel specified by the cname parameter.

-  Response:

    ```
    {
        "status": "success",  // Status of the request
        "id": 1953            // The rule ID. If you want to update the rule, then you need the rule ID to specify one
    }
    ```


### Get the Rule List (GET)

-  Method: GET
-  Path: BaseUrl/kicking-rule/
-  Parameter:

    ```
    {
       "appid":""    // Mandatory, project App ID
     }
    ```

-  Response:

    ```
    {
        "status": "success",                                    // Status of the request
        "rules": [
            {
                "id": 1953,                                     // The rule ID. If you want to update the rule, then you need the rule ID to specify one
                "appid": "80e54398fed94ae8a010acf782f569b7"     // project App ID
                "uid": 1,                                       // UID which can be obtained by using the SDK API
                "opid": 1406,                                   // Operating ID which is used to check the operation records for issues tracking
                "cname": "11",                                  // The channel name
                "ip": null,                                     // The IP address
                "ts": "2018-01-09T07:23:06.000Z",               // Time when the rule takes effect
                "createAt": "2018-01-09T06:23:06.000Z",         // Time when the rule is created
                "updateAt": "2018-01-09T14:23:06.000Z"          // Time when the rule is updated
            }
        ]
    }
    ```


### Update the Rule Period (PUT)

-  Mrethod: PUT
-  Path: BaseUrl/kicking-rule/
-  Parameter :

    ```
    {
             "appid":"",   // Mandatory, project App ID
             "id":"",      // Mandatory, rule ID with the rule list to be retrieved
             "time":""     // Mandatory, banned period to be updated
    }
    ```
-  Response:

    ```
    {
        "result": {
            "id": 1953,                         // The rule ID
            "ts": "2018-01-09T08:45:54.545Z"    // Time when the rule expires
        },
        "status": "success"                     // Status of the request
    }
    ```


### Delete a Rule (DELETE)

-  Method: DELETE
-  Path: BaseUrl/kicking-rule/
-  Parameter:

    ```
    {
                   "appid":"",   // Mandatory, project App ID
                   "id":""       // Mandatory, rule ID with the rule list to be retrieved
    }
    ```
		
-  Response:

    ```
    {
        "status": "success",  // Status of the request
        "id": 1953            // The rule ID
    }
    ```


## 6. Online Statistics Query API

BaseUrl：**http://api.agora.io/dev/v1/**.

> To ensure the availability of this function to all our customers, Agora decides to rate limit on the call frequency of this API. When this frequency limit is exceeded, the HTTP Error Code 429 \(Too Many Requests\) is triggered. Agora considers this frequency limit adequate for most of our customers in most scenarios. Should you receive this Error Code, Agora recommends adjusting your call frequency. Should this limit fails to meet your need, please contact [sales-us@agora.io](mailto:sales-us@agora.io).

### About the User Role

At present, the user roles, also called online roles, retrieved by the RESTful API is different from the roles that are specified in the *setClientRole* method. The online roles are distinguished by the channel profile and the type of the upstream media data. Currently we have the following 5 online roles:

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>Online Role</td>
<td>Enumeration</td>
</tr>
<tr><td>Unknown role</td>
<td>0</td>
</tr>
<tr><td>Communication user</td>
<td>1</td>
</tr>
<tr><td>Video live broadcaster</td>
<td>2</td>
</tr>
<tr><td>Live broadcast audience</td>
<td>3</td>
</tr>
<tr><td>Audio live broadcaster</td>
<td>4</td>
</tr>
</tbody>
</table>

> At present, the role of the *Audio live broadcaster* has yet to be distinguished and will be categorized as the *Live broadcast audience*.

### Get a User Role in the Channel (GET)

This method checks if a specified user is in a specified channel, and if yes, checks the role of this user in the channel.

-  Method: GET
-  Path: BaseUrl/channel/user/property/
-  Parameters: appid, uid, cname

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameter</strong></td>
	<td><strong>Description</strong></td>
	</tr>
	<tr><td>appid</td>
	<td>Mandatory, App ID in the dashboard</td>
	</tr>
	<tr><td>uid</td>
	<td>Mandatory, user ID which can be obtained by using the SDK</td>
	</tr>
	<tr><td>cname</td>
	<td>Mandatory, channel name</td>
	</tr>
	</tbody>
	</table>

Example: /channel/user/property/<appid\>/<uid\>/<channelName\>

-  Response:

    ```
    {
         "success": true,
         "data": {
             "in_channel": false,
             "role": 2
         }
    }
    ```

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameter</strong></td>
	<td><strong>Description</strong></td>
	</tr>
	<tr><td>success</td>
	<td><p>Checks the request state</p>
	<ul>
	<li>true: Request succeeded</li>
	<li>false: Request failed</li>
	</ul>
	</td>
	</tr>
	<tr><td>in_channel</td>
	<td><p>Checks if the user is in the channel</p>
	<ul>
	<li>true: The user is in the channel</li>
	<li>false: The user is not in the channel</li>
	</ul>
	</td>
	</tr>
	<tr><td>role</td>
	<td><p>Checks the role of the user in the channel</p>
	<ul>
	<li>0: Unknown role</li>
	<li>1: Communication user</li>
	<li>2: Video live broadcaster</li>
	<li>3: Live broadcast audience</li>
	<li>4: Audio live broadcaster</li>
	</ul>
	</td>
	</tr>
	</tbody>
	</table>



### Get the User Role List in a Channel (GET)

This method checks the user role list in a specified channel.

-  Method: GET
-  Path: BaseUrl/channel/user/
-  Parameters: appid, cname

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameter</strong></td>
	<td><strong>Description</strong></td>
	</tr>
	<tr><td>appid</td>
	<td>Mandatory, App ID in the dashboard</td>
	</tr>
	<tr><td>cname</td>
	<td>Mandatory, channel name</td>
	</tr>
	</tbody>
	</table>

Example: /channel/user/<appid\>/<channelName\>

-  Response:

    ```
    // If it is a communication channel
    {
         "success": true,
         "data": {
             "channel_exist": true,
             "mode": 1,
             "total": 1,
             "users": [
                 <uid>
             ]
          }
     }
    
    // No channel
    {
        "success": true,
        "data": {
            "channel_exist": false
        }
    }
    ```

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameter</strong></td>
	<td><strong>Description</strong></td>
	</tr>
	<tr><td>success</td>
	<td><p>Checks the request state:</p>
	<ul>
	<li>true: Request succeeded</li>
	<li>false: Request failed</li>
	</ul>
	</td>
	</tr>
	<tr><td>channel_exist</td>
	<td><p>Checks if the channel exits:</p>
	<ul>
	<li>true: Channel exists</li>
	<li>false: Channel does not exist</li>
	</ul>
	</td>
	</tr>
	<tr><td>mode</td>
	<td><p>Checks the channel mode:</p>
	<ul>
	<li>1: The communication mode</li>
	<li>2: The live broadcast mode</li>
	</ul>
	</td>
	</tr>
	<tr><td>total</td>
	<td>Total number of the users in the channel</td>
	</tr>
	<tr><td>users</td>
	<td>UIDs of all users in the channel</td>
	</tr>
	</tbody>
	</table>



### Get the Vendor Channel List (GET)

This method gets the channel list of a specified vendor.

-  Method: GET
-  Path: BaseUrl/channel/appid/
-  Parameters: ?page\_no=0&page\_size=100 \(Optional\)

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameter</strong></td>
	<td><strong>Name</strong></td>
	</tr>
	<tr><td>page_no</td>
	<td>Optional. The starting page; the default value is 0.</td>
	</tr>
	<tr><td>page_size</td>
	<td>Optional. The number of items in a page; the default value is 100.</td>
	</tr>
	</tbody>
	</table>

Example: /channel/<appid\>
Example with parameters: /channel/<appid\>/page\_no=0&page\_size=100

-  Response:

    ```
     {
              "success": true,
              "data": {
                  "channels": [
                      {
                          "channel_name": "lkj144",
                          "user_count": 3
                      }
                  ],
                  "total_size": 3
          }
    
    }
    ```

	<table>
	<colgroup>
	<col/>
	<col/>
	</colgroup>
	<tbody>
	<tr><td><strong>Parameters</strong></td>
	<td><strong>Description</strong></td>
	</tr>
	<tr><td>success</td>
	<td><p>Checks the request state:</p>
	<ul>
	<li>true: Request succeeded</li>
	<li>false: Request failed</li>
	</ul>
	</td>
	</tr>
	<tr><td>channel_name</td>
	<td>Name of the specified channel</td>
	</tr>
	<tr><td>user_count</td>
	<td>Total number of users the channel</td>
	</tr>
	<tr><td>total_size</td>
	<td>Total number of the channel</td>
	</tr>
	</tbody>
	</table>

> The channel lists retrieved in this method will cache for 1 minute. And if you use this method twice within 1 minute, the result stays the same.

## 7. Error Codes

See [Error Codes and Warning Codes](/en/API%20Reference/the_error_native).

