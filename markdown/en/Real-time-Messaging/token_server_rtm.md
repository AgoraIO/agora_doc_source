---
title: Generate an RTM Token
platform: All Platforms
updatedAt: 2021-01-27 08:20:00
---
The RTM Token is used for authenticating app users when a user logs in to the RTM system.

RTM Tokens are generated on your server. When an app user joins a channel or logs in to the RTM system, the app client interacts with the app server in the following way:

1. The app client sends a request for RTM token to the app server.
2. The app server generates an RTM token.
3. The app server passes the RTM token back to the app client.
4. The app client then passes the RTM token to the Agora server by calling `renewToken` provided by the RTM SDK.

This article introduces how to generate an RTM token on your server using the code provided by Agora.

## Prerequisites

Before proceeding, ensure that your Agora project has enabled the App Certificate on Console.

## Implementation

Agora provides an open-source [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository on GitHub, which enables you to generate RTM tokens on your server with programming languages such as C++, Java, Python, PHP, Ruby, Node.js, and Go. Take C++ as an example, the following picture shows the code structure:

![](https://web-cdn.agora.io/docs-files/1602235582287)

Under the `cpp` directory:

- `./sample/RtmTokenBuilderSample.cpp` contains the sample code for generating an RTM token.
- `./src/RtmTokenBuilder.h` contains the API used for generating an RTM token.

### Generate an RTM token with the sample code

Under the `sample` directory of each programming language, you can find the sample code for generating an RTM token. Take C++ as an example:

```
int main(int argc, char const *argv[]) {
  
  // Fill in your App ID
  std::string appID  = "970CA35de60c44645bbae8a215061b33";
  // Fill in your App Certificate
  std::string appCertificate = "5CFd2fd1755d40ecb72977518be15d3b";
  // Fill in your user ID
  std::string user= "test_user_id";
  // Expiration time of the RTM Token. The parameter is invalid. You do not have to specify this parameter. Each RTM Token is valid for 24 hours.
  uint32_t expirationTimeInSeconds = 3600;
  uint32_t currentTimeStamp = time(NULL);
  uint32_t privilegeExpiredTs = currentTimeStamp + expirationTimeInSeconds;
  
  std::string result =
    RtmTokenBuilder::buildToken(appID, appCertificate, user,
        RtmUserRole::Rtm_User, privilegeExpiredTs);
  std::cout << "Rtm Token:" << result << std::endl;
  return 0;
```

Refer to the following steps to generate an RTM token with the sample code above.

Before proceeding, ensure that you have installed openssl.

1. Download or clone the [AgoraDynamicKey](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey) repository.

2. Open the `AgoraDynamicKey/cpp/sample/RtmTokenBuilderSample.cpp` file, replace the value of `appID`, `appCertificate`, and `user` with your own.

3. Open your Terminal, navigate to the same directory that holds `RtmTokenBuilderSample.cpp`, and run the following command. After that, an executable file `RtmTokenBuilderSample` appears in the folder:

   ```
	 g++ -std=c++0x -O0 -I../../ -L. RtmTokenBuilderSample.cpp -lz -lcrypto -o RtmTokenBuilderSample
	 ```

4. Run the following command. You RTM token is generated and printed in your Terminal window.

   ```
	 ./RtmTokenBuilderSample
	 ```

Steps for generating an RTM token with the sample code of different programming languages are as follows:

<details>
	<summary><font color="#3ab7f8">Java</font></summary>
Before proceeding, ensure that you have installed a Java IDE.
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/java</code> file in your IDE.</li>
		<li>Open <code>AgoraDynamicKey/java/src/io/agora/sample/RtmTokenBuilderSample.java</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>,  and <code>uid</code> with your own.</li>
		<li>Run the sample project. Your RTM token is generated and printed in your IDE.
</li>
	</ol>
</details>


<details>
	<summary><font color="#3ab7f8">Python</font></summary>
Before proceeding, ensure that you have Python 2 as the development environment. Use the following command to check your current Python version:
<pre><code>python -V</code></pre>
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>uid</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>RtmTokenBuilderSample.py</code>, and run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>python RtmTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Python3</font></summary>
Before proceeding, ensure that you have Python 3 as the development environment. Use the following command to check your current Python version:
<pre><code>python -V</code></pre>
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/python/sample/RtmTokenBuilderSample.py</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>uid</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>RtmTokenBuilderSample.py</code>, and run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>python RtmTokenBuilderSample.py</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">PHP</font></summary>
Before proceeding, ensure that you have installed the latest version of PHP.
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/sample/RtmTokenBuilderSample.php</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>uid</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>RtmTokenBuilderSample.php</code>, and run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>php RtmTokenBuilderSample.php</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Node.js</font></summary>
Before proceeding, ensure that you have installed the LTS version of Node.js.
	<ol>
		<li>Run the following command to install the Node.js dependencies:
			<pre><code>npm install</code></pre>
		</li>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/nodejs/sample/RtmTokenBuilderSample.js</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>uid</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>RtmTokenBuilderSample.js</code>, and run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>node RtmTokenBuilderSample.js</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Go</font></summary>
Before proceeding, ensure that you have installed the latest version of Golang.
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/go/sample/RtmTokenBuilder/sample.go</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>uid</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>sample.go</code>, and run the following command. After that, an executable file <code>RtmTokenBuilder</code> appears in the folder
			<pre><code>go build</code></pre>
		</li>
		<li>Run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>./RtmTokenBuilder</code></pre>
		</li>
	</ol>
</details>

<details>
	<summary><font color="#3ab7f8">Ruby</font></summary>
Before proceeding, ensure that you have installed Ruby v1.9 or later. Run the following command to check your current Ruby version:
	<pre><code>ruby -version</code></pre>
	<ol>
		<li>Download or clone the <a href="https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey">AgoraDynamicKey</a> repository.</li>
		<li>Open the <code>AgoraDynamicKey/ruby/sample/rtm_token_builder_sample.rb</code> file, replace the value of <code>appID</code>, <code>appCertificate</code>, and <code>userAccount</code> with your own.</li>
		<li>Open Terminal, navigate to the same directory that holds <code>rtm_token_builder_sample.rb</code>, and run the following command. The RTM token is generated and printed in your Terminal window.
			<pre><code>ruby rtm_token_builder_sample.rb</code></pre>
		</li>
	</ol>
</details>

### API reference

This section introduces the method to generate an RTM token. Take C++ as an example:

```
static std::string buildToken(const std::string& appId,
                                const std::string& appCertificate,
                                const std::string& userAccount,
                                RtmUserRole userRole,
                                uint32_t privilegeExpiredTs = 0);
```


| Parameter          | Description                                                  |
| :----------------- | :----------------------------------------------------------- |
| appId              | The App ID of your Agora project.                            |
| appCertificate     | The App Certificate of your Agora project.                   |
| userAccount        | The user ID of the RTM system. See the [userId parameter of the login method](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b).                               |
| role               | The user role. Agora supports only one user role. Set the value as the default value `Rtm_User`. |
| privilegeExpiredTs | The Unix timestamp (s) when the token expires, represented by the sum of the current timestamp and the valid time of the token. This parameter is currently invalid. You can ignore this parameter. An RTM token is valid for 24 hours. |

## Considerations

### User ID

The user ID that you use to generate the RTM token must be the same with the one you use to log in to the RTM system.

### App Certificate and RTM token

To use the RTM token for authentication, you need to enable the App Certificate for your project on Console. Once a project has enabled the App Certificate, you must use RTM tokens to authenticate its users.

### RTM Token expiration

An RTM token is valid for 24 hours. To ensure the experience of your app user, the RTM SDK triggers the `onTokenExpired` callback (`TokenExpired` for the Web platform and the `rtmKitTokenDidExpire` for the OC platform) when a token expires and the SDK is in the [CONNECTION_STATE_RECONNECTING ](/en/Real-time-Messaging/reconnecting_cpp?platform=Windows%20CPP)state. Upon receiving this callback, you need to generate a new token on your server, and call `renewToken` to pass the new token to the SDK.