# 使用 Token 鉴权

鉴权是指在用户访问你的系统前，对其进行身份校验。用户在使用 Agora 服务，如加入音视频通话或登录信令系统时，Agora 使用 Token 对其鉴权。

本文展示如何为 AccessToken2 在服务端部署一个 Token 生成器，以及如何搭建一个使用 Token 鉴权的客户端。


## 鉴权原理

~e4d86b10-072b-11ed-a46a-e58831549a58~


## 前提条件

~fc679b70-072b-11ed-a46a-e58831549a58~


## 实现鉴权流程

本节介绍如何使用 Agora 提供的[代码](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey)生成并提供 Token，对用户及其权限进行校验。

### 获取 App ID 及 App 证书

本节介绍如何获取生成 Token 所需的安全信息，如你的项目的 App ID 及 App 证书。

#### 获取 App ID

   ~bbd6ec60-19e2-11eb-b0e2-eb6c69fefbc6~

#### 获取 App 证书

   ~7fa0dcd0-4c0c-11ec-8689-2164ade84c59~

### 部署 Token 服务器

Token 需要在你的服务端部署生成。当客户端发送请求时，服务端部署的 Token 生成器会生成相应的 Token，再发送给客户端。

本节展示如何使用 Golang 在你的本地设备上搭建并运行一个 Token 服务器。

此示例服务器使用 `BuildTokenWithUid[1/2]`。

<div class="alert note">此示例服务器仅用于演示，请勿用于生产环境中。 </div>

1. 创建一个 `server.go` 文件，然后贴入如下代码。将其中的 `<Your App ID> `和 `<Your App Certificate>` 替换为你的 App ID 和 App 证书。

```golang
package main
  
import (
    rtctokenbuilder "github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/go/src/RtcTokenBuilder"
    "fmt"
    "log"
    "net/http"
    "encoding/json"
    "errors"
    "strconv"
)
  
type rtc_int_token_struct struct{
    Uid_rtc_int uint32 `json:"uid"`
    Channel_name string `json:"ChannelName"`
    Role uint32 `json:"role"`
}
  
var rtc_token string
var int_uid uint32
var channel_name string
  
var role_num uint32
var role rtctokenbuilder.Role
  
// 使用 RtcTokenBuilder 来生成 RTC Token
func generateRtcToken(int_uid uint32, channelName string, role rtctokenbuilder.Role){
  
    appID := "<Your App ID>"
    appCertificate := "<Your App Certificate>"
    // AccessToken2 过期的时间，单位为秒
    // 当 AccessToken2 过期但权限未过期时，用户仍在频道里并且可以发流，不会触发 SDK 回调。
    // 但一旦用户和频道断开连接，用户将无法使用该 Token 加入同一频道。请确保 AccessToken2 的过期时间晚于权限过期时间。
    tokenExpireTimeInSeconds := uint32(40)
    // 权限过期的时间，单位为秒。
    // 权限过期30秒前会触发 token-privilege-will-expire 回调。
    // 权限过期时会触发 token-privilege-did-expire 回调。
    // 为作演示，在此将过期时间设为 40 秒。你可以看到客户端自动更新 Token 的过程
    privilegeExpireTimeInSeconds := uint32(40)
  
    result, err := rtctokenbuilder.BuildTokenWithUid(appID, appCertificate, channelName, int_uid, role, tokenExpireTimeInSeconds, privilegeExpireTimeInSeconds)
    if err != nil {
        fmt.Println(err)
    } else {
        fmt.Printf("Token with uid: %s\n", result)
        fmt.Printf("uid is %d\n", int_uid )
        fmt.Printf("ChannelName is %s\n", channelName)
        fmt.Printf("Role is %d\n", role)
    }
    rtc_token = result
}
  
  
func rtcTokenHandler(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Content-Type", "application/json; charset=UTF-8")
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS");
    w.Header().Set("Access-Control-Allow-Headers", "*");
  
    if r.Method == "OPTIONS" {
        w.WriteHeader(http.StatusOK)
        return
    }
  
    if r.Method != "POST" && r.Method != "OPTIONS" {
        http.Error(w, "Unsupported method. Please check.", http.StatusNotFound)
        return
    }
  
  
    var t_int rtc_int_token_struct
    var unmarshalErr *json.UnmarshalTypeError
    int_decoder := json.NewDecoder(r.Body)
    int_err := int_decoder.Decode(&t_int)
    if (int_err == nil) {
  
                int_uid = t_int.Uid_rtc_int
                channel_name = t_int.Channel_name
                role_num = t_int.Role
                switch role_num {
                    case 1:
                        role = rtctokenbuilder.RolePublisher
                    case 2:
                        role = rtctokenbuilder.RoleSubscriber
                }
    }
    if (int_err != nil) {
  
        if errors.As(int_err, &unmarshalErr){
                errorResponse(w, "Bad request. Wrong type provided for field " + unmarshalErr.Value  + unmarshalErr.Field + unmarshalErr.Struct, http.StatusBadRequest)
                } else {
                errorResponse(w, "Bad request.", http.StatusBadRequest)
            }
        return
    }
  
    generateRtcToken(int_uid, channel_name, role)
    errorResponse(w, rtc_token, http.StatusOK)
    log.Println(w, r)
}
  
func errorResponse(w http.ResponseWriter, message string, httpStatusCode int){
    w.Header().Set("Content-Type", "application/json")
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.WriteHeader(httpStatusCode)
    resp := make(map[string]string)
    resp["token"] = message
    resp["code"] = strconv.Itoa(httpStatusCode)
    jsonResp, _ := json.Marshal(resp)
    w.Write(jsonResp)
  
}
  
func main(){
    // 使用 int 型 uid 生成 RTC Token
    http.HandleFunc("/fetch_rtc_token", rtcTokenHandler)
    fmt.Printf("Starting server at port 8082\n")
  
    if err := http.ListenAndServe(":8082", nil); err != nil {
        log.Fatal(err)
    }
}
```

2. `go.mod` 文件定义导入路径及依赖项。运行如下命令行来为你的 Token 服务器创建 `go.mod` 文件：

```golang
$ go mod init sampleServer
```

3. 运行如下命令行安装依赖。你可以使用 Go 镜像进行加速，例如 https://goproxy.cn/ 。

```golang
$ go get
```

4. 运行如下命令行启动服务器：

```golang
$ go run server.go
```

### 使用 Token 对用户鉴权

本节以 Android 客户端为例，展示如何使用 Token 对客户端的用户进行鉴权。

为了展示鉴权的工作流程，本节介绍如何在你的本地开发环境上使用 Android 模拟器搭建并运行一个 Android 客户端。

1. 基于你在实现互动直播时创建的项目，在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 路径下添加如下依赖：

   ```java
   dependencies {
    ...
    implementation 'com.squareup.okhttp3:okhttp:3.10.0'
    implementation 'com.google.code.gson:gson:2.8.4'
    ...
    }
   ```

2. 将 `MainActivity.java` 中的内容替换为如下代码。 将 `Your App ID` 替换为你的 App ID，必须与服务器中的 App ID 一致。 您还需要将 `<Your Host URL and port>` 替换为你刚刚部署的本地 Golang 服务器的主机 URL 和端口，例如 10.53.3.234:8082。

   在如下代码示例中，你可以看到 Token 与客户端的如下代码逻辑有关：

 - 调用 `joinChannel` 方法，使用 Token、用户 ID 和频道名加入频道。用户 ID 和频道名必须和用于生成 Token 的用户 ID 和频道名一致。
 - 在 Token 过期前 30 秒，SDK 会触发 `onTokenPrivilegeWillExpire` 回调。收到该回调后，客户端需要从服务器获取新的 Token 并调用 `renewToken` 将新生成的 Token 传给 SDK。
 - Token 过期时，SDK 会触发 `onRequestToken` 回调。收到该回调后，客户端需要从服务器获取新的 Token 并调用 `joinChannel` 方法，再使用新的 Token 重新加入频道。

  ```java
  package com.example.rtcquickstart;

  import androidx.appcompat.app.AppCompatActivity;

  import android.os.Bundle;

  import androidx.core.app.ActivityCompat;
  import androidx.core.content.ContextCompat;

  import android.Manifest;
  import android.content.pm.PackageManager;
  import android.view.SurfaceView;
  import android.widget.FrameLayout;
  import android.widget.Toast;
  import io.agora.rtc2.Constants;
  import io.agora.rtc2.IRtcEngineEventHandler;
  import io.agora.rtc2.RtcEngine;
  import io.agora.rtc2.video.VideoCanvas;
  import io.agora.rtc2.ChannelMediaOptions;

  import okhttp3.MediaType;
  import okhttp3.OkHttpClient;
  import okhttp3.Request;
  import okhttp3.RequestBody;
  import okhttp3.Response;
  import okhttp3.Call;
  import okhttp3.Callback;

  import com.google.gson.Gson;

  import java.util.Map;

  import org.json.JSONException;
  import org.json.JSONObject;

  import java.io.IOException;

  public class MainActivity extends AppCompatActivity {

      // 填入在 Agora 控制台创建项目时生成的 App ID
      private String appId = "Your App ID";
      // 填入频道名称
      private String channelName = "1234";

      private String token = "";

      private RtcEngine mRtcEngine;

      private int joined = 1;

      private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
          @Override
          // 监听远端用户加入频道，并获取远端用户的用户 ID
          public void onUserJoined(int uid, int elapsed) {
              runOnUiThread(new Runnable() {
                  @Override
                  public void run() {
                      // 在 onUserJoined 回调中获取用户 ID 后，调用 setupRemoteVideo 设置远端用户视图
                      setupRemoteVideo(uid);
                  }
              });
          }

          @Override
          public void onTokenPrivilegeWillExpire(String token) {
              fetchToken(1234, channelName, 1);
              runOnUiThread(new Runnable() {
                  @Override
                  public void run() {
                      Toast toast = Toast.makeText(MainActivity.this, "Token renewed", Toast.LENGTH_SHORT);
                      toast.show();
                  }
              });
              super.onTokenPrivilegeWillExpire(token);
          }

          @Override
          public void onRequestToken() {
              joined = 1;
              fetchToken(1234, channelName, 1);
              super.onRequestToken();
          }

      };

      private static final int PERMISSION_REQ_ID = 22;

      private static final String[] REQUESTED_PERMISSIONS = {
              Manifest.permission.RECORD_AUDIO,
              Manifest.permission.CAMERA
      };

      private boolean checkSelfPermission(String permission, int requestCode) {
          if (ContextCompat.checkSelfPermission(this, permission) !=
                  PackageManager.PERMISSION_GRANTED) {
              ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, requestCode);
              return false;
          }
          return true;
      }

      // 获取 RTC token
      private void fetchToken(int uid,String channelName,int tokenRole){
          OkHttpClient client = new OkHttpClient();
          MediaType JSON = MediaType.parse("application/json; charset=utf-8");
          JSONObject json = new JSONObject();
          try {
              json.put("uid", uid);
              json.put("ChannelName", channelName);
              json.put("role", tokenRole);
          } catch (JSONException e) {
              e.printStackTrace();
          }

          RequestBody requestBody = RequestBody.create(JSON, String.valueOf(json));
          Request request = new Request.Builder()
                  .url("http://<Your Host URL and port>/fetch_rtc_token")
                  .header("Content-Type", "application/json; charset=UTF-8")
                  .post(requestBody)
                  .build();
          Call call = client.newCall(request);
          call.enqueue(new Callback() {
              @Override
              public void onFailure(Call call, IOException e) {

              }

              @Override
              public void onResponse(Call call, Response response) throws IOException {
                  if(response.isSuccessful()){
                      Gson gson = new Gson();
                      String result = response.body().string();
                      Map map = gson.fromJson(result, Map.class);
                      new Thread(new Runnable() {
                          @Override
                          public void run() {
                              token = map.get("token").toString();
                              // 如果用户未加入频道，使用 token 加入频道
                              ChannelMediaOptions options = new ChannelMediaOptions();
                              if (joined != 0){joined = mRtcEngine.joinChannel(token, channelName, 1234, options);}
                              // 如果用户已加入频道，调用 renewToken 重新生成 token
                              else {mRtcEngine.renewToken(token);}
                          }
                      });
                  }
              }
          });
      }

      @Override
      protected void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);
          setContentView(R.layout.activity_main);

          // 如果所有权限都被授予，则初始化 RtcEngine 对象并加入频道
          if (checkSelfPermission(REQUESTED_PERMISSIONS[0], PERMISSION_REQ_ID) &&
                  checkSelfPermission(REQUESTED_PERMISSIONS[1], PERMISSION_REQ_ID)) {
              initializeAndJoinChannel();
          }
      }

      protected void onDestroy() {
          super.onDestroy();

          mRtcEngine.leaveChannel();
          mRtcEngine.destroy();
      }

      private void initializeAndJoinChannel() {
          try {
              mRtcEngine = RtcEngine.create(getBaseContext(), appId, mRtcEventHandler);
          } catch (Exception e) {
              throw new RuntimeException("Check the error.");
          }

          // 在互动直播中，设置频道场景为 BROADCASTING
          mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);
          // 根据实际情况，设置用户角色为 BROADCASTER 或 AUDIENCE
          mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER);

          // SDK 默认关闭视频。调用 enableVideo 开启视频
          mRtcEngine.enableVideo();

          FrameLayout container = findViewById(R.id.local_video_view_container);
          // 调用 CreateRendererView 创建一个 SurfaceView 对象并将其作为子项添加到 FrameLayout
          SurfaceView surfaceView = new SurfaceView (getBaseContext());
          container.addView(surfaceView);
          // 将 SurfaceView 对象传给 Agora，渲染本地视频
          mRtcEngine.setupLocalVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, 0));
          // 开始本地视频预览
          mRtcEngine.startPreview();
          // 从 token 服务器获取 token
          fetchToken(1234, channelName, 1);
      }

      private void setupRemoteVideo(int uid) {
          FrameLayout container = findViewById(R.id.remote_video_view_container);
          SurfaceView surfaceView = new SurfaceView (getBaseContext());
          surfaceView.setZOrderMediaOverlay(true);
          container.addView(surfaceView);
          mRtcEngine.setupRemoteVideo(new VideoCanvas(surfaceView, VideoCanvas.RENDER_MODE_FIT, uid));
      }

  }
  ```

### 运行项目

在本地设备的 Android 模拟器中构建并运行项目，app 会执行如下操作：

1. 加入频道。
2. 每隔 10 秒更新 token。

~54cbd8e0-0735-11ed-a46a-e58831549a58~