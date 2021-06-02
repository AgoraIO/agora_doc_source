---
title: 加入实时房间
platform: Android
updatedAt: 2021-03-31 09:00:59
---
本文详细介绍如何建立一个简单的项目并使用 Agora 互动白板 SDK 实现基础的白板功能。

## 前提条件

- Android Studio
- Android SDK API level 19+
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。
- 已在 Agora 控制台[开启互动白板服务](/cn/whiteboard/enable_whiteboard)并获取项目的 [App Identifer](https://docs-preprod.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-app-identifier) 和 [SDK Token](https://docs-preprod.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-sdk-token)。

## 创建 Android 项目

使用 Android Studio [创建一个 Android 项目](https://developer.android.google.cn/studio/projects/create-project)。

- 项目名设为 `WhiteBoard`。
- Package 名设为 `com.example.whiteboard`。
- Activity 类型选择 **Empty Activity**。
- **Minimum SDK** 选择 **API 19**。

## 添加权限

在 `AndroidManifest.xml` 文件中添加访问网络权限：

```java
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.whiteboard">
 
    <uses-permission android:name="android.permission.INTERNET" />
 
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.WhiteBoard">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
```



## 获取 SDK

打开根目录下的 `build.gradle` 进行以下配置：

```java
allprojects {
    repositories {
        jcenter()
        // 添加以下内容
        maven { url 'https://jitpack.io' }
        // 对于国内用户，如果 Gradle sync 失败，可以选择国内镜像，例如阿里云 Maven 镜像
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/releases/'}
    }
}
```


然后打开 app 目录下的 `build.gradle` 进行如下配置：

```java
dependencies {
    // 本文使用 2.9.14 版
    implementation 'com.github.duty-os:white-sdk-android:2.9.14'
}
```

## 防止代码混淆 

在 `proguard-rules.pro` 文件中添加以下语句，防止代码混淆：

```java
# SDK model
-keep class com.herewhite.* { *; }
```

## 基本流程

现在，我们已经将 Agora 互动白板 SDK 集成到项目中了。接下来我们要调用 Agora 互动白板 SDK 提供的核心 API 实现基础的白板功能。

### 1. 创建房间

在 app 客户端加入互动白板房间前，你需要在 app 服务端调用互动白板服务端 RESTful API 创建一个房间。详见[创建房间（POST）](https://docs-preprod.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）)。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

  <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装</div>

```javascript
var request = require("request");
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/rooms",
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  }
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回新建房间的信息，其中的 `uuid` 是房间的唯一标识，app 客户端加入房间时需要传入该参数。

**响应示例**

```javascript
{
    "uuid": "4a50xxxxxx796b", // 房间的 UUID
    "name": "",
    "teamUUID": "RMmLxxxxxx15aw",
    "appUUID": "i54xxxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

###  2. 生成 Room Token

创建房间并获取新建房间的 `uuid` 后，你需要在 app 服务端生成 Room Token 并下发给 app 客户端。当 app 客户端加入房间时，Agora 互动白板服务端会使用该 Token 对其鉴权。

你可以通过以下方式在 app 服务端生成 Room Token：

- 使用代码生成 `Room Token`，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server)。（推荐）
- 调用互动白板服务端 RESTful API 生成 Room Token，详见[生成 Room Token（POST）](/cn/whiteboard/generate_whiteboard_token#生成-room-token（post）)。

下面以调用 RESTful API 的方式为例介绍如何生成 Room Token。

**请求示例**

你可以使用以下 Node.js 脚本发送请求：

 <div class="alert info">使用 Node.js 发送 HTTP 请求前安装 <code>request</code> 模块。你可以运行 <code>npm install request</code> 安装</div>

```javascript
var request = require('request');
var options = {
  "method": "POST",
  "url": "https://api.netless.link/v5/tokens/rooms/4a50xxxxxx796b",
  "headers": {
    "token": "你的 SDK Token",
    "Content-Type": "application/json"
  },
  body: JSON.stringify({"lifespan":60,"role":"admin"})
  
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
```

如果方法调用成功，Agora 互动白板服务端将返回生成的 Room Token。

**响应示例**
```javascript
"NETLESSROOM_YWs9XXXXXXXXXXXZWNhNjk" // Room Token
```

### 3. 创建 UI

修改 `activity_main.xml` 为如下内容，可以看到整个视图由一个白板页面填充，页面 `com.herewhite.sdk.WhiteboardView` 由白板 SDK 实现。

```java
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context=".MainActivity">
 
    <com.herewhite.sdk.WhiteboardView
        android:id="@+id/white"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:visibility="visible" />
 
</LinearLayout>
```



### 4. 初始化 SDK 并加入房间

编辑 `MainActivity.java` ，实现从初始化 SDK 到加入房间的基本操作。你需要传入以下参数：
- `appId`：互动白板项目的 App Identifier。详见[获取 App Identifier](https://docs-preprod.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-app-identifier)。
- `uuid`：房间的 UUID。详见<a href="#miao">创建房间</a>。// TODO 修改链接
- `roomToken`：用于鉴权的 Room Token。生成该 Room Token 使用的房间 UUID 必须和上面的房间 UUID 一致。详见<a href="#roomtoken">生成 Room Token</a>。// TODO 修改链接

```java
package com.example.whiteboard;
import androidx.appcompat.app.AppCompatActivity;
 
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
 
import com.herewhite.sdk.RoomParams;
import com.herewhite.sdk.WhiteboardView;
import com.herewhite.sdk.WhiteSdk;
import com.herewhite.sdk.WhiteSdkConfiguration;
import com.herewhite.sdk.Room;
import com.herewhite.sdk.domain.Promise;
 
import com.herewhite.sdk.domain.SDKError;
import com.herewhite.sdk.domain.MemberState;
 
 
public class MainActivity extends AppCompatActivity {
 
    // 你的互动白板 App Identifier
    final String appId = "Your App Identifier";
    // 你的房间 UUID
    final String uuid = "房间 UUID";
    // 你的 Room Token
    final String roomToken = "Room Token";
 
    // 创建 WhiteboardView 对象，实现白板 view
    WhiteboardView whiteboardView;
    // 创建 WhiteSdkConfiguration 对象，设置白板的 App Identifier 和日志参数
    WhiteSdkConfiguration sdkConfiguration = new WhiteSdkConfiguration(appId, true);
    // 创建 RoomParams 对象，设置房间参数，用于加入房间
    RoomParams roomParams = new RoomParams(uuid, roomToken);
 
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // 将 layout 中的白板 view 赋值给 WhiteboardView 对象
        whiteboardView = findViewById(R.id.white);
        // 创建 WhiteSdk 对象，用于初始化白板 SDK
        WhiteSdk whiteSdk = new WhiteSdk(whiteboardView, MainActivity.this, sdkConfiguration);
        // 加入房间
        whiteSdk.joinRoom(roomParams, new Promise<Room>() {
            @Override
            public void then(Room wRoom) {
                MemberState memberState = new MemberState();
                // 将教具设置为铅笔
                memberState.setCurrentApplianceName("pencil");
                // 将颜色设置为红色
                memberState.setStrokeColor(new int[]{255, 0, 0});
                // 设置当前用户教具
                wRoom.setMemberState(memberState);
            }
 
            @Override
            public void catchEx(SDKError t) {
                Object o = t.getMessage();
                Log.i("showToast", o.toString());
                Toast.makeText(MainActivity.this, o.toString(), Toast.LENGTH_SHORT).show();
            }
        });
 
    }
 
 
    @Override
    protected void onDestroy() {
            super.onDestroy();
            whiteboardView.removeAllViews();
            whiteboardView.destroy();
        }
 
    }
```

## 编译并运行项目

在 Android Studio 中编译并在模拟器或真机上运行项目。如果应用成功运行，你可以用鼠标在生成的页面上写写画画并看到笔迹。