
$$ 3265bf10-5be5-11ec-af4b-2b38abdb1c68
{
  "feature": "语音通话",
  "product": "Agora  SDK"
}
$$

## 前提条件

- [Microsoft Visual Studio 2017 或以上版本](https://visualstudio.microsoft.com/zh-hans/vs/older-downloads/)
- Windows 7 或以上版本的设备
- [.NET 桌面开发组件](https://learn.microsoft.com/en-us/dotnet/framework/install/guide-for-developers)
- 计算机可以访问互联网。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docportal.shengwang.cn/cn/video-call-4.x/firewall)。
- 有效的[声网账户](https://console.agora.io/)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)，从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - 频道名称：用于标识频道的字符串。

## 创建项目

参考以下操作，在你的 app 中实现音频通话功能：

### 创建 Windows 项目

1. 在 Visual Studio 上创建一个 Windows Forms 应用项目，详见 [Create a Windows Forms app in Visual Studio with C#](https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2017/ide/create-csharp-winform-visual-studio?view=vs-2017)。
3. 打开 **Configuration Manager** 窗口，在 **Active solution platform** 下拉菜单中选择 **New**，在弹出的窗口中选择 **x64** 或 **x86** 作为目标平台。

### 集成 SDK


使用 Visual Studio 中的 NuGet 包管理器，将 SDK 集成到项目中。详见[快速入门：在 Visual Studio 中安装和使用包](https://learn.microsoft.com/zh-cn/nuget/quickstart/install-and-use-a-package-in-visual-studio)。
 
<div class="alert info">你可以在 <a href="https://www.nuget.org/packages/agora_rtc_sdk/#versions-body-tab">agora_rtc_sdk</a> 中获取最新发布的 SDK 的版本信息。</div>
## 在客户端实现音频通话

本节介绍如何使用 SDK 在你的项目中实现音频通话功能。

### 创建用户界面

为直观地体验音频通话，你需要根据应用场景创建用户界面 (UI)。若你的项目中已有用户界面，可略过此步骤。

如果你想实现音频通话，推荐在 UI 上添加以下控件：

- 加入频道按钮
- 离开频道按钮

参考以下步骤创建 UI。

1. 创建 **Join** 和 **Leave** 按钮

   a. 在你的项目中，打开 **Solution Explore** 窗口，双击 **Form1.cs**，打开 **Toolbox** 窗口，选择 **Button** 控件，依次添加两个按钮，并将两个按钮拖放至合适位置。
   b. 将鼠标移至其中一个按钮上，点击鼠标右键，选中 **Properties**，在打开的 **Properties** 窗口中修改 **Text** 属性为 **Join**，修改 **Name** 属性为 **btnJoin**。
   c. 重复上一个步骤来修改另一个按钮的属性：修改 **Text** 为 **Leave**；修改 **Name** 为 **btnLeave**。

3. 创建频道名输入框

   a. 打开 **Toolbox** 窗口，选中 **TextBox** 控件，然后将其拖拽至合适位置。
   b. 将鼠标移至添加好的输入框控件上，点击鼠标右键，选中 **Properties** ，修改其属性 **Name** 为 **txChannelName**。

4. 保存上述步骤的更改。

5. 分别双击 **Join** 和 **Leave** 按钮，IDE 会自动关联点击事件处理函数。


### 实现音频通话逻辑



参考以下步骤来实现音频通话逻辑：

1. 在项目中，鼠标右键点击 **Solution Explorer** 中的 **Form1.cs**，单击 **View Code**。

2. 在弹出的 `Form1.cs` 界面中，将下列代码添加至 `using System.Windows.Forms;` 之后：

    ```c#
    using Agora.Rtc;
    ```

3. 创建加入频道相关变量
   在 `Form1.cs` 中，将下列代码添加至 `public Form1()` 之前：

   ```c#
   // 填写项目的 App ID，可在声网控制台中生成。
   private readonly string APP_ID = "";
   
   // 填写声网控制台中生成的临时 Token。
   private readonly string APP_TOKEN = "";
   
   // 声明 IRtcEngine 实例
   private IRtcEngine engine_ = null;
   
   // 声明 RtcEventHandler 
   private RtcEventHandler handler_ = null;
   ```

4. 声明一个 `RtcEventHandler` 类，用以处理事件
   在 `Form1.cs` 中，将以下代码添加至类 `Form1` 的定义之后:

   ```c#
   internal class RtcEventHandler : IRtcEngineEventHandler
   {
       // 声明一个代理，用于处理 OnUserJoined 事件。
       public delegate void OnUserJoinedHandler(RtcConnection connection, uint remoteUid, int elapsed);
   
       // 声明 OnUserJoined 回调。
       public event OnUserJoinedHandler EventOnUserJoined;
   
       public RtcEventHandler()
       {
       }
   
       public override void OnError(int error, string msg)
       {
           Console.WriteLine("=====>OnError {0} {1}", error, msg);
       }
   
       public override void OnJoinChannelSuccess(RtcConnection connection, int elapsed)
       {
           Console.WriteLine("----->OnJoinChannelSuccess channel={0} uid={1}", connection.channelId, connection.localUid);
       }
   
       public override void OnLeaveChannel(RtcConnection connection, RtcStats stats)
       {
           Console.WriteLine("----->OnLeaveChannel duration={0}", stats.duration);
       }
   
       public override void OnUserJoined(RtcConnection connection, uint remoteUid, int elapsed)
       {
           Console.WriteLine("----->OnUserJoined uid={0}", remoteUid);
   
           if (EventOnUserJoined != null)
               EventOnUserJoined.Invoke(connection, remoteUid, elapsed);
       }
   
       public override void OnUserOffline(RtcConnection connection, uint remoteUid, USER_OFFLINE_REASON_TYPE reason)
       {
           Console.WriteLine("----->OnUserOffline, channel={0}, remoteUid={1}, reason={2}", connection.channelId, remoteUid, reason);
       }
   
       public override void OnRemoteVideoStateChanged(RtcConnection connection, uint remoteUid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed)
       {
           Console.WriteLine("----->OnRemoteVideoStateChanged, channel={0}, remoteUid={1}, state={2}, reason={3}", connection.channelId, remoteUid, state, reason);
       }
   }
   ```

5. 创建并初始化 `IRtcEngine`

   a. 调用 `CreateAgoraRtcEngine` 来创建 `IRtcEngine` 实例。将以下代码添加到 `InitializeComponent();` 的后面：

   ```c#
    // 创建 IRtcEngine。
    engine_ = RtcEngine.CreateAgoraRtcEngine();
     
    RtcEngineContext ctx = new RtcEngineContext()
    {
        appId = APP_ID,
        areaCode = AREA_CODE.AREA_CODE_GLOB,
        logConfig =
        {
            filePath = "rtc.log"
        }
    };
     
    // 初始化 IRtcEngine。
    var ret = engine_.Initialize(ctx);
    if(ret != 0)
    {
        Console.WriteLine("=====>Initialize failed {0}", ret);
        return;
    }
   ```

   b. 创建并注册事件监听器。将以下代码添加至上一段代码之后：

   ```c#
   // 注册事件监听器。
   handler_ = new RtcEventHandler();
   handler_.EventOnUserJoined += OnUserJoined;
   engine_.InitEventHandler(handler_);
   ```

6. 实现加入频道逻辑。用以下代码替换 `btnJoin_Click` 函数：

   ```c#
    private void btnJoin_Click(object sender, EventArgs e)
   {
       if (null != engine_)
       {
           ChannelMediaOptions options = new ChannelMediaOptions();
           // 将频道场景设置为直播。
           options.channelProfile.SetValue(CHANNEL_PROFILE_TYPE.CHANNEL_PROFILE_LIVE_BROADCASTING);
           // 将用户角色设置为主播。
           options.clientRoleType.SetValue(CLIENT_ROLE_TYPE.CLIENT_ROLE_BROADCASTER);
           // 使用临时 Token 加入频道。
           var ret = engine_.JoinChannel(APP_TOKEN, txChannelName.Text, 0, options);
   
           Console.WriteLine("=====>JoinChannel result {0}", ret);
       }
   }
   ```

7. 实现离开频道逻辑。用以下代码替换 `btnLeave_Click` 函数：

   ```c#
    private void btnLeave_Click(object sender, EventArgs e)
   {
       if (null != engine_)
       {
           var ret = engine_.LeaveChannel();
           Console.WriteLine("=====>LeaveChannel result {0}", ret);
       }
   }
   ```


## 测试你的项目
按照以下步骤来测试你的音频通话项目：

1. 将你从声网控制台获取的 App ID 和临时 Token 分别填入到 `Form1.cs` 文件的 `APP_ID` 和 `APP_TOKEN` 中。
2. 在 Visual Studio 中点击 **Start** 按钮运行你的项目。
3. 在输入框中输入你在声网控制台获取的频道名，并点击 **Join** 按钮加入频道。
4. 邀请一位朋友通过另一台设备来使用相同的 App ID、频道名、Token 加入频道。你的朋友加入频道后，你们可以听见对方。


### 示例项目

声网在 GitHub 上提供了一个开源的示例项目 [Agora-C_Sharp-RTC-SDK-API_Example](https://github.com/AgoraIO-Extensions/Agora-C_Sharp-SDK/tree/master/Agora-C_Sharp-RTC-SDK-API_Example) 供你参考，可实现更多的应用场景。