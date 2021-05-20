---
title: Generate a Token
platform: Server
updatedAt: 2020-12-15 08:21:58
---
This page shows how to generate a token on your server for Agora SDK versions 2.1.0+. The token is used for joining a channel.

The following programming languages are covered. Choose the one that applies to you:

- Java
- C++
- Python
- Go
- PHP
- Node.js

> Agora does not support signing Token with a non-zero string uid for the time being.

## Java

### Initializes the Token Builder

```java
public boolean initTokenBuilder(String originToken);
```

This method uses the original token to reinitialize the token builder. This method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and Privilege of the original token.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



**Struct of the TokenBuilder**

```java
public SimpleTokenBuilder(String appId, String appCertificate, String channelName, String uid);
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>


### Generates a Token \(buildToken\)

```java
public String buildToken();
```

This method generates a token in the string format.

## C++

### Initializes the Token Builder

```c++
bool initTokenBuilder(const std::string& originToken);
```

This method uses the original token to reinitialize the token builder. This method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and privilege of the original token.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>

**Struct of the TokenBuilder**

```c++
SimpleTokenBuilder();
SimpleTokenBuilder(const std::string& appId, const std::string& appCertificate,
                   const std::string& channelName, uint32_t uid = 0);
SimpleTokenBuilder(const std::string& appId, const std::string& appCertificate,
                   const std::string& channelName, const std::string& uid = "");
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
	<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>

### Generates a Token \(buildToken\)

```c++
std::string buildToken();
```

This method generates a token in the string format.

## Python

### Initializes the Token Builder

```python
def initTokenBuilder(self, originToken);
```

This method uses the original token to reinitialize the token builder. This method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and Privilege of the original token.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong</td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



**Struct of the TokenBuilder**

```python
def __init__(self, appID, appCertificate, channelName, uid);
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
	<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>

### Generates a Token \(buildToken\)

```python
def buildToken(self);
```

This method generates a token in the string format.

## Go

### Initializes the Token Builder

```go
func (builder SimpleTokenBuilder) InitTokenBuilder(originToken string);
```

This method uses the original token to reinitialize the token builder. This method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and Privilege of the original token.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



**Struct of the TokenBuilder**

```go
func CreateSimpleTokenBuilder(appID, appCertificate, channelName string, uid uint32) SimpleTokenBuilder;
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>

<a name = "initPrivilegesGo"></a>

### Generates a Token \(buildToken\)

```go
func (builder SimpleTokenBuilder) BuildToken() (string,error);
```

This method generates a token in the string format.

## PHP

### Initializes the Token Builder

```php
function initTokenBuilder($originToken);
```

This method uses the original token to reinitialize the token builder. This method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and Privilege of the original token.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
	<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



**Struct of the TokenBuilder**

```php
public function __construct($appID, $appCertificate, $channelName, $uid);
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>

### Generates a Token \(buildToken\)

```php
public function buildToken();
```

This method generates a token in the string format.

## Node.js

### Initializes the Token Builder

```javascript
initTokenBuilder = function (originToken);
```

This method uses the original token to reinitialize the token builder. Once called, this method enables the token builder to inherit the App ID, App Certificate, Channel Name, uid, and Privilege of the original token.


<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td><code>originToken</code></td>
<td>The original token.</td>
</tr>
<tr><td>Return value</td>
<td><ul>
<li>0: Method call succeeded.</li>
<li>&lt;0: Method call failed.</li>
</ul>
</td>
</tr>
</tbody>
</table>



**Struct of the TokenBuilder**

```javascript
var SimpleTokenBuilder = function (appID, appCertificate, channelName, uid);
```

This method is the struct of SimpleTokenBuilder.

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>Name</strong></td>
<td><strong>Description</strong></td>
</tr>
<tr><td>App ID</td>
<td>ID of the application that you registered in the Agora Dashboard. See <a href="./token/#app-id"><span>Getting an App ID</span></a>.</td>
</tr>
<tr><td>App Certificate</td>
<td>Certificate of the application that you registered in the Agora Dashboard. See <a href="./token/#app-certificate"><span> Get an App Certificate</span></a>.</td>
</tr>
	<tr><td><code>channelName</code></td>
<td>Name of the channel that the user wants to join.</td>
</tr>
<tr><td><code>uid</code></td>
<td>ID of the user who wants to join a channel.</td>
</tr>
</tbody>
</table>

### Generates a Token \(buildToken\)

```javascript
this.buildToken = function ();
```

This method generates a token in the string format.

