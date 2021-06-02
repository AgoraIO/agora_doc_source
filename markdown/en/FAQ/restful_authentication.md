---
title: How can I pass the basic HTTP authentication or token authentication?
platform: ["RESTful"]
updatedAt: 2021-01-28 06:01:12
Products: ["Voice","Video","Interactive Broadcast","Real-time-Messaging","cloud-recording","Agora Analytics"]
---
## Introduction

Before using the Agora RESTful API, you need to pass basic HTTP authentication or token authentication.

### Basic HTTP authentication

You need to generate a Base64-encoded credential with the Customer ID and Customer Secret provided by Agora and pass the credential to the `Authorization` parameter in the request header. The following products need basic HTTP authentication:

- [Audio SDK/Video SDK/Live Interactive Streaming Premium/Live Interactive Streaming Standard](https://docs.agora.io/en/Interactive%20Broadcast/rtc_restful_api?platform=RESTful)
- [Cloud Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful)
- [Real-time Messaging](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms)
- [Agora Analytics](https://docs.agora.io/en/Agora%20Analytics/aa_api?platform=RESTful)

### Token authentication

Token authentication is currently only available for [Real-time Messaging](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms). You need to fill the `x-agora-token` and `x-agora-uid` fields in the request header with the following information:

- The RTM token generated from your server
- The RTM user ID used to generate the RTM token

<div class="alert note">Implement HTTP basic authentication or token authentication on the server; otherwise, you may encounter the risk of data leakage.</div>

## Implement Basic HTTP authentication

### Implementation

1. Log in to [Agora Console](https://console.agora.io/), click the account name on the top right of Agora Console, and click **RESTful API** from the drop-down list to enter the **RESTful** page.

   ![img](https://web-cdn.agora.io/docs-files/1595846692062)

2. Click **Download** to get the **Customer ID** and **Customer Secret**.

   ![img](https://web-cdn.agora.io/docs-files/1595845888224)


   <div class="alert note">The customer ID and customer secret are used for RESTful API access only. You can download the customer secret from Agora Console only once. After downloading the customer secret, keep the information secure.</div>

3. Use the customer ID (key) and customer secret (secret) to generate a Base64-encoded credential, and pass the Base64-encoded credential to the `Authorization` parameter in the HTTP request header.

### Sample code

The following sample codes implement basic HTTP authentication and send a request with the Server RESTful API to get the basic information of all current Agora projects.

#### Java

```java
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;


// HTTP basic authentication example in Java using the RTC Server RESTful API
public class Base64Encoding {

    public static void main(String[] args) throws IOException, InterruptedException {

        // Customer ID
        final String customerKey = "Your customer ID";
        // Customer secret
        final String customerSecret = "Your customer secret";

        // Concatenate customer key and customer secret and use base64 to encode the concatenated string
        String plainCredentials = customerKey + ":" + customerSecret;
        String base64Credentials = new String(Base64.getEncoder().encode(plainCredentials.getBytes()));
        // Create authorization header
        String authorizationHeader = "Basic " + base64Credentials;

        HttpClient client = HttpClient.newHttpClient();

        // Create HTTP request object
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.agora.io/dev/v1/projects"))
                .GET()
                .header("Authorization", authorizationHeader)
                .header("Content-Type", "application/json")
                .build();
        // Send HTTP request
        HttpResponse<String> response = client.send(request,
                HttpResponse.BodyHandlers.ofString());

        System.out.println(response.body());
    }
}
```

#### Golang

```go
package main

import (
  "fmt"
  "strings"
  "net/http"
  "io/ioutil"
  "encoding/base64"
)

// HTTP basic authentication example in Golang using the RTC Server RESTful API
func main() {

  // Customer ID
  customerKey := "Your customer ID"
  // Customer secret
  customerSecret := "Your customer secret"

  // Concatenate customer key and customer secret and use base64 to encode the concatenated string
  plainCredentials := customerKey + ":" + customerSecret
  base64Credentials := base64.StdEncoding.EncodeToString([]byte(plainCredentials))

  url := "https://api.agora.io/dev/v1/projects"
  method := "GET"

  payload := strings.NewReader(``)

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, payload)

  if err != nil {
    fmt.Println(err)
    return
  }
  // Add Authorization header
  req.Header.Add("Authorization", "Basic " + base64Credentials)
  req.Header.Add("Content-Type", "application/json")

  // Send HTTP request
  res, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer res.Body.Close()

  body, err := ioutil.ReadAll(res.Body)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println(string(body))
}
```

#### PHP

```php
<?php
// HTTP basic authentication example in PHP using the RTC Server RESTful API
// Customer ID
$customerKey = "Your customer ID";
// Customer secret
$customerSecret = "Your customer secret";
// Concatenate customer key and customer secret
$credentials = $customerKey . ":" . $customerSecret;

// Encode with base64
$base64Credentials = base64_encode($credentials);
// Create authorization header
$arr_header = "Authorization: Basic " . $base64Credentials;

$curl = curl_init();
// Send HTTP request
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.agora.io/dev/v1/projects',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',

  CURLOPT_HTTPHEADER => array(
    $arr_header,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

if($response === false) {
    echo "Error in cURL : " . curl_error($curl);
}

curl_close($curl);

echo $response;
```

#### C&#35;

```c#
using System;
using System.IO;
using System.Net;
using System.Text;

// HTTP basic authentication example in C# using the RTC Server RESTful API
namespace Examples.System.Net
{
    public class WebRequestPostExample
    {
        public static void Main()
        {
            // Customer ID
            string customerKey = "Your customer ID";
            // Customer secret
            string customerSecret = "Your customer secret";
            // Concatenate customer key and customer secret and use base64 to encode the concatenated string
            string plainCredential = customerKey + ":" + customerSecret;

            // Encode with base64
            var plainTextBytes = Encoding.UTF8.GetBytes(plainCredential);
            string encodedCredential = Convert.ToBase64String(plainTextBytes);
            // Create authorization header
            string authorizationHeader = "Authorization: Basic " + encodedCredential;

            // Create request object
            WebRequest request = WebRequest.Create("https://api.agora.io/dev/v1/projects");
            request.Method = "GET";

            // Add authorization header
            request.Headers.Add(authorizationHeader);
            request.ContentType = "application/json";

            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);

            using (Stream dataStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
            }

            response.Close();
        }
    }
}
```

#### node.js

```javascript
// HTTP basic authentication example in node.js using the RTC Server RESTful API
const https = require('https')
// Customer ID
const customerKey = "Your customer ID"
// Customer secret
const customerSecret = "Your customer secret"
// Concatenate customer key and customer secret and use base64 to encode the concatenated string
const plainCredential = customerKey + ":" + customerSecret
// Encode with base64
encodedCredential = Buffer.from(plainCredential).toString('base64')
authorizationField = "Basic " + encodedCredential


// Set request parameters
const options = {
  hostname: 'api.agora.io',
  port: 443,
  path: '/dev/v1/projects',
  method: 'GET',
  headers: {
    'Authorization':authorizationField,
    'Content-Type': 'application/json'
  }
}

// Create request object and send request
const req = https.request(options, res => {
  console.log(`Status code: ${res.statusCode}`)

  res.on('data', d => {
    process.stdout.write(d)
  })
})

req.on('error', error => {
  console.error(error)
})

req.end()
```

#### Python

```python
# -- coding utf-8 --
# Python 3
# HTTP basic authentication example in python using the RTC Server RESTful API
import base64
import http.client


# Customer ID
customer_key = "Your customer ID"
# Customer secret
customer_secret = "Your customer secret"

# Concatenate customer key and customer secret and use base64 to encode the concatenated string
credentials = customer_key + ":" + customer_secret
# Encode with base64
base64_credentials = base64.b64encode(credentials.encode("utf8"))
credential = base64_credentials.decode("utf8")

# Create connection object with basic URL
conn = http.client.HTTPSConnection("api.agora.io")

payload = ""

# Create Header object
headers = {}
# Add Authorization field
headers['Authorization'] = 'basic ' + credential

headers['Content-Type'] = 'application/json'

# Send request
conn.request("GET", "/dev/v1/projects", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

## Implement Token authentication

### Implementation

1. [Generate the RTM token](https://docs.agora.io/en/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) from your server.

2. Enter the RTM token and the RTM user ID into the `x-agora-token` and `x-agora-uid` fields of the HTTP request header, respectively.

### Sample code

The following sample codes implement token authentication and send a request with the RTM RESTful API to get RTM user events.


#### Java

```java
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;


// Token authentication example in Java using the RTM user events RESTful API
public class Base64Encoding {

    public static void main(String[] args) throws IOException, InterruptedException {

        // RTM Token
        String token = "Your RTM token";
        // User ID used to generate the RTM token
        String uid = "test_user";

        HttpClient client = HttpClient.newHttpClient();


        // Create request object
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events"))
                .GET()
                // Add the x-agora-token field to the header
                .header("x-agora-token", token )
                // Add the x-agora-uid field to the header
                .header("x-agora-uid", uid)
                .header("Content-Type", "application/json")
                .build();
        // Send request
        HttpResponse<String> response = client.send(request,
                HttpResponse.BodyHandlers.ofString());

        System.out.println(response.body());
    }
}
```

#### Golang

```go
package main


import (
  "fmt"
  "strings"
  "net/http"
  "io/ioutil"
)

// Token authentication example in Golang using the RTM user events RESTful API
func main() {

  // RTM Token
  token := "Your RTM Token"
  // User ID used to generate the RTM token
  uid := "test_user"


  url := "https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events"
  method := "GET"

  payload := strings.NewReader(``)

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, payload)

  if err != nil {
    fmt.Println(err)
    return
  }
  // Add the x-agora-token field to the header
  req.Header.Add("x-agora-token", token)
  // Add the x-agora-uid field to the header
  req.Header.Add("x-agora-uid", uid)
  req.Header.Add("Content-Type", "application/json")

  // Send request
  res, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer res.Body.Close()

  body, err := ioutil.ReadAll(res.Body)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println(string(body))
}
```

#### PHP

```php
<?php
// Token authentication example in PHP using the RTM user events RESTful API

// RTM Token
$token = "Your RTM Token";
// User ID used to generate the RTM token
$uid = "test_user";
// Add the x-agora-token field to the header
$token_header = "x-agora-token: " . $token;
// Add the x-agora-uid field to the header
$uid_header = "x-agora-uid: " . $uid;

$curl = curl_init();
// Send request
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',

  CURLOPT_HTTPHEADER => array(
    $token_header,
    $uid_header,
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

if($response === false) {
    echo "Error in cURL : " . curl_error($curl);
}

curl_close($curl);

echo $response;
```

#### C&#35;

```c#
using System;
using System.IO;
using System.Net;
using System.Text;
// Token authentication example in C# using the RTM user events RESTful API
namespace Examples.System.Net
{
    public class WebRequestPostExample
    {
        public static void Main()
        {

            // RTM Token
            string token = "Your RTM Token";
            // User ID used to generate the RTM token
            string uid = "userA";
            // Add the x-agora-token field to the header
            string tokenHeader = "x-agora-token: " + token;
            // Add the x-agora-uid field to the header
            string uidHeader = "x-agora-uid: " + uid;

            WebRequest request = WebRequest.Create("https://api.agora.io/dev/v2/project/<Your App ID>/rtm/vendor/user_events");
            request.Method = "GET";

            // Add header to the request
            request.Headers.Add(tokenHeader);
            request.Headers.Add(uidHeader);

            request.ContentType = "application/json";

            // Get response
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);


            using (Stream dataStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(dataStream);
                string responseFromServer = reader.ReadToEnd();
                Console.WriteLine(responseFromServer);
            }

            response.Close();
        }
    }
}
```

#### node.js

```javascript
// Token authentication example in node.js using the RTM user events RESTful API
const https = require('https')


// RTM Token
token = "Your RTM Token"
// User ID used to generate the RTM token
uid = "test_user"

// Set request parameters
const options = {
  hostname: 'api.agora.io',
  port: 443,
  path: '/dev/v2/project/<Your App ID>/rtm/vendor/user_events',
  method: 'GET',
  headers: {
    // Add the x-agora-token field to the header
    'x-agora-token':token,
    // Add the x-agora-uid field to the header
    'x-agora-uid': uid,
    'Content-Type': 'application/json'
  }
}

const req = https.request(options, res => {
  console.log(`Status code: ${res.statusCode}`)
  res.on('data', d => {
    process.stdout.write(d)
  })
})

req.on('error', error => {
  console.error(error)
})

req.end()
```

#### Python

```python
import http.client
# Token authentication example in Python using the RTM user events RESTful API

# Create connection object with base URL
conn = http.client.HTTPSConnection("api.agora.io")
# Create header
headers = {}
# Add the x-agora-token field to the header
headers['x-agora-token'] = "Your RTM Token"
# Add the x-agora-uid field to the header, which is the user ID used to generate the RTM token
headers['x-agora-uid'] = "test_user"
headers['Content-Type'] = 'application/json'
payload = ""
# Send request
conn.request("GET", "/dev/v2/project/<Your App ID>/rtm/vendor/user_events", payload, headers)

res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```