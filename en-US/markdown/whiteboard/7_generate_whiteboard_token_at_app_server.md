Agora Interactive Whiteboard uses a set of tokens for user authentication: SDK Tokens, Room Tokens, and Task Tokens. Each type of token can be assigned to an admin, writer, or reader role. For details, see [Introduction](/cn/whiteboard/whiteboard_token_overview).

Agora provides an open source [netless-token](https://github.com/netless-io/netless-token) repository on GitHubthat includes code samples for generating tokens using JavaScript, TypeScript, Java, Golang, PHP, Ruby, and C#.

This article introduces how to generate tokens from your app server using these code samples and your access keys (the AK and SK).


<div class="alert note">To enhance security, do not save or send the AK and SK to your app clients. You should save the AK and SK on the app server, and issue tokens from the app server according to the actual needs of your app scenarios.</div>

## Prerequisites

Ensure that you have enabled the whiteboard service for your Agora Console project.

## JavaScript

In the `netless-token-master/Node/JavaScript` folder, you can find:

- `An index.js` file, which contains the source code for generating tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed the latest version of Node.js LTS.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/JavaScript` folder, and run the following command to install Node.js dependencies:
```
npm install
```

3. Create a file named `sdktoken.js`, and copy the following code into it:

```javascript
const  { sdkToken, TokenPrefix } = require("./index");
// Generate a SDK Token
const netlessSDKToken = sdkToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       role: 0 // Define the permissions granted by the token. You can set it to 0 (Admin), 1 (Writer), or 2 (Reader) 
      }
);
console.log(netlessSDKToken)
```



4. Run the following command.  You should see a token prefixed with `NETLESSSDK_` in the terminal.
```
	node sdktoken.js
```

### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/JavaScript` folder, and run the following command to install Node.js dependencies:
```
	npm install
```


3. Create a file named `roomtoken.js`, and copy the following code into it:

```javascript
const  { roomToken, TokenPrefix } = require("./index");
// Generate a Room token
const netlessRoomToken = roomToken(
  "Your AK", // Fill in the AK you get from Agora Console 
  "Your SK", // Fill in the SK you get from Agora Console 
  1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
    {
      role: 1 // Define the permissions granted by the token. You can set it to 0 (Admin), 1 (Writer), or 2 (Reader) 
      uuid: "Room UUID" // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
    }
);
console.log(netlessRoomToken)
```


4. Run the following command.  You should see a token prefixed with `NETLESSROOM_` in the terminal.
```
	node roomtoken.js
```


### Generate a Task Token

Refer to the following steps to generate a Task Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/JavaScript` folder, and run the following command to install Node.js dependencies:
```
npm install
```

3. Create a file named `tasktoken.js`, and copy the following code into it:

```javascript
const  { taskToken, TokenPrefix } = require("./index");
// Generate a Task Token
const netlessTaskToken = taskToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       role: 1 // Define the permissions granted by the token. You can set it to 0 (Admin), 1 (Writer), or 2 (Reader) 
       uuid: "Task UUID" // Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
      }
);
console.log(netlessTaskToken)
```

4. Run the following command.  You should see a token prefixed with `NETLESSTASK_` in the terminal.
```
node tasktoken.js
```


## TypeScript

In the `netless-token-master/Node/TypeScript` folder, you can find:

- `A src/index.ts` file, which contains the source code for generating Tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed the latest version of Node.js LTS.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/TypeScript` folder, and run the following command to install TypeScript:
```
npm install -g typescript
```

3. Create a file named `sdktoken.ts`, and copy the following code into it:

```typescript
import { sdkToken, TokenPrefix } from "./src/index";
const netlessSDKToken = sdkToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       role: TokenRole.Admin // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
      }
);
console.log(netlessSDKToken)
```

4. Run the following command to generate the corresponding `sdktoken.js` file:
```
tsc sdktoken.ts
```

5. Run the following command.  You should see a token prefixed with `NETLESSSDK_` in the terminal.
```
node sdktoken.js
```


### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/TypeScript` folder, and run the following command to install TypeScript:
```
npm install -g typescript
```

3. Create a file named `roomtoken.ts`, and copy the following code into it:

```typescript
import { roomToken, TokenPrefix } from "./src/index";
const netlessRoomToken = roomToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       role: TokenRole.Admin // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
       uuid: "Room UUID" // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
      }
);
console.log(netlessRoomToken)
```

4. Run the following command to generate the corresponding `roomtoken.js` file:
```
tsc roomtoken.ts
```

5. Run the following command.  You should see a token prefixed with `NETLESSROOM_` in the terminal.
```
node roomtoken.js
```

### Generate a Task Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Node/TypeScript` folder, and run the following command to install TypeScript:
```
npm install -g typescript
```

3. Create a file named `tasktoken.ts`, and copy the following code into it:

```typescript
import { taskToken, TokenPrefix } from "./src/index";
const netlessTaskToken = taskToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
           role: TokenRole.Writer // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
           uuid: "Task UUID" // Fill in the Task UUID. You can get it by calling the RESTful API to start a file conversion task 
              }
);
console.log(netlessTaskToken)
```

4. Run the following command to generate the corresponding `tasktoken.js` file:
```
tsc tasktoken.ts
```

5. Run the following command.  You should see a token prefixed with `NETLESSTASK_` in the terminal.
```
node tasktoken.js
```

## Java

In the `netless-token-master/Java` folder, you can find:

- `A Token.java` file, which contains the source code for generating Tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed a Java Development Kit.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Java` folder, and add the following code to the `Token.java` file:

```java
public static void main(String[] args) throws Exception {
   Map<String, String> map = new HashMap<>();
   // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
      map.put("role", Token.TokenRole.Admin.getValue());

      String sdkToken = Token.sdkToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              map);

      System.out.println(sdkToken);
}
```

3. Go to the directory of the `Token.java` file, and run the following command:
```java
javac Token.java
```

4. Run the following command.  You should see a token prefixed with `NETLESSSDK_` in the terminal.
```java
java Token
```


### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Java` folder, and add the following code to the `Token.java` file:

```java
public static void main(String[] args) throws Exception {
   Map<String, String> map = new HashMap<>();
       // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
              map.put("role", Token.TokenRole.Reader.getValue());
       // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
              map.put("uuid", "Your Room UUID");

      String roomToken = Token.roomToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              map);

      System.out.println(roomToken);
}
```

3. Go to the directory of the `Token.java` file, and run the following command:
```java
javac Token.java
```

4. Run the following command.  You should see a token prefixed with `NETLESSROOM_` in the terminal.
```java
java Token
```


### Generate a Task Token

Refer to the following steps:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/Java` folder, and add the following code to the `Token.java` file:

```java
public static void main(String[] args) throws Exception {
   Map<String, String> map = new HashMap<>();
       // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
              map.put("role", Token.TokenRole.Writer.getValue());
       // Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
              map.put("uuid", "Your Task UUID");

      String taskToken = Token.taskToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              map);

      System.out.println(taskToken);
}
```

3. Go to the directory of the `Token.java` file, and run the following command:
```java
javac Token.java
```

4. Run the following command.  You should see a token prefixed with `NETLESSTASK_` in the terminal.
```java
java Token
```

## Golang

In the `netless-token-master/golang` folder, you can find:

- `A Token.go` file, which contains the source code for generating tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed the latest version of Golang.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Create a file named `sdktoken.go`, and copy the following code into it:

```go
package main
import (
   "fmt"
   "../golang" // Replace ../golang with the path to the netless-token folder in your local directory 
)
func main() {
   c := token.SDKContent{
       // Define the permissions granted by the token. You can set it to token.AdminRole, token.ReaderRole, or token.WriterRole 
              Role: token.AdminRole,
   }
   netlessSDKToken := token.SDKToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              &c,
   )
    fmt.Println(netlessSDKToken)
}
```

3. Go to the directory of the `sdktoken.go` file, and run the following command,  after which you should see a token prefixed with `NETLESSSDK_` in the terminal:
```go
go sdktoken.go
```


### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Create a file named `roomtoken.go`, and copy the following code into it:

```go
package main
import (
   "fmt"
   "../golang" // Replace ../golang with the path to the netless-token folder in your local directory 
)
func main() {
   c := token.RoomContent{
       // Define the permissions granted by the token. You can set it to token.AdminRole, token.ReaderRole, or token.WriterRole 
              Role: token.AdminRole,
       // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
              Uuid: "Your Room UUID",
   } 
   netlessRoomToken := token.RoomToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              &c,
   )
    fmt.Println(netlessRoomToken)
}
```

3. Go to the directory of the `roomtoken.go` file, and run the following command, after which  you should see a token prefixed with `NETLESSROOM_` in the terminal:
```go
go roomtoken.go
```

### Generate a Task Token

Refer to the following steps to generate a Task Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Create a file named `tasktoken.go`, and copy the following code into it:

```go
package main
import (
   "fmt"
   "../golang" // Replace ../golang with the path to the netless-token folder in your local directory 
)
func main() {
   c := token.TaskContent{
       // Define the permissions granted by the token. You can set it to token.AdminRole, token.ReaderRole, or token.WriterRole 
              Role: token.WriterRole,
       // Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
              Uuid: "Task UUID",
   }
   netlessTaskToken := token.TaskToken(
       "Your AK", // Fill in the AK you get from Agora Console 
       "Your SK", // Fill in the SK you get from Agora Console 
       1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
              &c,
   )
    fmt.Println(netlessTaskToken)
}
```

3. Go to the directory of the `tasktoken.go` file, and run the following command, after which  you should see a token prefixed with `NETLESSTASK_` in the terminal:
```go
go tasktoken.go
```

## PHP

In the `netless-token-master/php` folder, you can find:

- `A Generate.php` file, which contains the source code for generating tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed PHP 7.3 or later.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/php` folder, create a file named `sdktoken.php`, and copy the following code into it:

```php
<?php 
// Import Composer to manage dependencies 
require __DIR__ . '/vendor/autoload.php';
use Netless\Token\Generate;
$netlessToken = new Generate;
$sdkToken = $netlessToken->sdkToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      array(
       "role" => Generate::AdminRole, // Define the permissions granted by the token. You can set it to AdminRole, WriterRole, or ReaderRole 
      )
);
echo $sdkToken;
```

3. Run the following command.  You should see a token prefixed with `NETLESSSDK_` in the terminal.
```php
php sdktoken.php
```


### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/php` folder, create a file named `roomtoken.php`, and copy the following code into it:

```php
<?php 
// Import Composer to manage dependencies 
require __DIR__ . '/vendor/autoload.php';
use Netless\Token\Generate;
$netlessToken = new Generate;
$roomToken = $netlessToken->roomToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      array(
       "role" => Generate::ReaderRole, // Define the permissions granted by the token. You can set it to AdminRole, WriterRole, or ReaderRole 
       "uuid" => "Your Room UUID" // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
      )
);
echo $roomToken;
```

3. Run the following command.  You should see a token prefixed with `NETLESSROOM_` in the terminal.
```php
php roomtoken.php
```


### Generate a Task Token

Refer to the following steps to generate a Task Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/php` folder, create a file named `tasktoken.php`, and copy the following code into it:

```php
<?php
// Import Composer to manage dependencies 
require __DIR__ . '/vendor/autoload.php';
use Netless\Token\Generate;
$netlessToken = new Generate;
$roomToken = $netlessToken->roomToken(
   "Your AK", // Fill in the AK you get from Agora Console 
   "Your SK", // Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      array(
       "role" => Generate::ReaderRole, // Define the permissions granted by the token. You can set it to AdminRole, WriterRole, or ReaderRole 
              "uuid" => "Your Task UUID" // Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
      )
);
echo $sdkToken;
```

3. Run the following command.  You should see a token prefixed with `NETLESSTASK_` in the terminal.
```php
php tasktoken.php
```


## Ruby

In the `netless-token-master/ruby` folder, you can find:

- `A token.rb` file, which contains the source code for generating tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed Ruby 2.1 or later.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/ruby` folder, and run the following command to install `uuidtools`:
```
	gem install uuidtools
```

3. In the `ruby` folder, create a file named `sdktoken.rb`, and copy the following code into it:

```ruby
require './lib/token.rb'
sdktoken = NetlessToken.sdk_token(
   "Your AK", # Fill in the AK you get from Agora Console 
   "Your SK", # Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       :role => NetlessToken::ROLE::ADMIN # Define the permissions granted by the token. You can set it to ADMIN, WRITER, or READER 
      }
)
puts sdktoken
```

4. Run the following command.  You should see a token prefixed with `NETLESSSDK_` in the terminal.
```ruby
ruby sdktoken.rb
```


### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/ruby` folder, and run the following command to install `uuidtools`:
```
gem install uuidtools
```

3. In the `ruby` folder, create a file named `roomtoken.rb`, and copy the following code into it:

```ruby
require './lib/token.rb'
roomtoken = NetlessToken.room_token(
   "Your AK", # Fill in the AK you get from Agora Console 
   "Your SK", # Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       :role => NetlessToken::ROLE::ADMIN # Define the permissions granted by the token. You can set it to ADMIN, WRITER, or READER 
       :uuid => "Your Room UUID" // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
      }
)
puts roomtoken
```

4. Run the following command.  You should see a token prefixed with `NETLESSROOM_` in the terminal.
```ruby
ruby roomtoken.rb
```


### Generate a Task Token

Refer to the following steps to generate a Task Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/ruby` folder, and run the following command to install `uuidtools`:
```
gem install uuidtools
```

3. In the `ruby` folder, create a file named `tasktoken.rb`, and copy the following code into it:

```ruby
require './lib/token.rb'
tasktoken = NetlessToken.task_token(
   "Your AK", # Fill in the AK you get from Agora Console 
   "netless sk", # Fill in the SK you get from Agora Console 
   1000 * 60 * 10, // Token validity period in milliseconds If you set it to 0, the Token will never expire 
      {
       :role => NetlessToken::ROLE::ADMIN # Define the permissions granted by the token. You can set it to ADMIN, WRITER, or READER 
       :uuid => "Your Room UUID" # Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
      }
)
puts tasktoken
```

4. Run the following command.  You should see a token prefixed with `NETLESSTASK_` in the terminal.
```ruby
ruby tasktoken.rb
```

## C#

In the `netless-token-master/csharp` folder, you can find:

- `A Token.cs` file, which contains the source code for generating tokens.
- `A README.md` file, which contains code samples for generating tokens.

Before proceeding, ensure that you have installed the latest version of Visual Studio.

### Generate an SDK Token

Refer to the following steps to generate an SDK Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/csharp` folder, and open the `csharp.sln` file in Visual Studio.

3. Fill in your AK, SK, token validity period, and token role in the `Program.cs` file.

```c#
using System;
using Netless;
class Program
{
   static void Main(string[] args)
   {
       string token = NetlessToken.SdkToken(
           // Fill in the AK you get from Agora Console 
                      "ak",
           // Fill in the SK you get from Agora Console 
                      "sk",
           // Token 有效时间，单位为毫秒。 If you set it to 0, the Token will never expire 
                      1000 * 60 * 10,
           // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
                      new SdkContent(TokenRole.Admin)); 
       Console.WriteLine(token);
   }
}
```

4. Run the project in Visual Studio. You should see a token prefixed with `NETLESSSDK_` in the terminal.

### Generate a Room Token

Refer to the following steps to generate a Room Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/csharp` folder, and open the `csharp.sln` file in Visual Studio.

3. Delete the code in the `Program.cs` file, and copy the following sample code into it:

```c#
using System;
using Netless;
class Program
{
   static void Main(string[] args)
   {
       string token = NetlessToken.RoomToken(
           // Fill in the AK you get from Agora Console 
                      "ak",
           // Fill in the SK you get from Agora Console 
                      "sk",
           // Token 有效时间，单位为毫秒。 If you set it to 0, the Token will never expire 
                      1000 * 60 * 10,
           // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
           // Fill in the Room UUID. You can get it by calling the RESTful API to create a room or get a room list 
                      new RoomContent(TokenRole.Admin, "Your Room UUID")
           ); 
       Console.WriteLine(token);
   }
}
```

4. Run the project in Visual Studio. You should see a token prefixed with `NETLESSROOM_` in the terminal.

### Generate a Task Token

Refer to the following steps to generate a Task Token:

1. Download the [netless-token](https://github.com/netless-io/netless-token) repository, or clone it to a local directory.

2. Go to the `netless-token-master/csharp` folder, and open the `csharp.sln` file in Visual Studio.

3. Delete the code in the `Program.cs` file, and copy the following sample code into it:
```c#
using System;
using Netless;
class Program
{
   static void Main(string[] args)
   {
       string token = NetlessToken.TaskToken(
           // Fill in the AK you get from Agora Console 
                      "ak",
           // Fill in the SK you get from Agora Console 
                      "sk",
           // Token 有效时间，单位为毫秒。 If you set it to 0, the Token will never expire 
                      1000 * 60 * 10,
           // Define the permissions granted by the token. You can set it to TokenRole.Admin, TokenRole.Writer, or TokenRole.Reader 
           // Fill in the Task UUID. You can get it by calling the RESTful API to start a file-conversion task 
                      new TaskContent(TokenRole.Admin, "Your Task UUID")
           );
       Console.WriteLine(token);
   }
}
```

4. Run the project in Visual Studio. You should see a token prefixed with `NETLESSTASK_` in the terminal.