如果你在之前版本中修改了灵动课堂的默认 UI，需参考以下步骤从 1.1.5 之前的版本升级至 1.1.5：

## 步骤一：重新集成灵动课堂

根据[集成灵动课堂文档](/cn/agora-class/agora_class_integrate_ios?platform=iOS#change_default_ui)中的步骤将 1.1.5 集成至你的项目中。

## 步骤二：替换 SDKs/AgoraEduUI 目录下的文件

用原先 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppView 目录下的文件替换 SDKs/AgoraEduUI 目录下的文件，具体如下：

- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraResources 替换 SDKs/AgoraEduUI/AgoraEduUI/AgoraResources。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/Render 替换 SDKs/AgoraEduUI/AgoraEduUI/Render。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/UIController 替换 SDKs/AgoraEduUI/AgoraEduUI/UIController。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/WhiteBoard 替换 SDKs/AgoraEduUI/AgoraEduUI/WhiteBoard。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIEduAppViews.xcassets 替换 SDKs/AgoraEduUI/AgoraEduUI/AgoraEduUI.xcassets。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/UIManager 替换 SDKs/AgoraEduUI/AgoraEduUI/UIManager，并将 `AgoraUIManager.swift` 改名为 `AgoraEduUI.swift`，将`AgoraUIManager` 类改名为 `AgoraEduUI`。
- 用 AgoraEduSDK/Modules/AgoraUIEduAppViews/AgoraUIEduAppViews/Widget 替换 Widgets/AgoraWidgets/Chat。

<details>
<summary><font color="#3ab7f8">查看截图</font></summary>
1.1.5 之前版本的目录结构：<img src="https://web-cdn.agora.io/docs-files/1631955899733" />1.1.5 的目录结构：<img src="https://web-cdn.agora.io/docs-files/1631955832457" />
</details>

## 步骤三：修改 `AgoraEduUI.swift` 文件

在 `AgoraEduUI.swift` 中，进行以下修改：

1. 将 `AgoraEduContextAppType` 更名为 `AgoraEduContextRoomType`。
2. 将 `var chat: AgoraEduWidget` 改为 `var chat: AgoraBaseWidget`。
3. 参考下图，添加以下代码新增 `initWidgets` 方法。

    ![](https://web-cdn.agora.io/docs-files/1631956034236)

      ```swift
func initWidgets() {
        guard let widgetInfos = contextPool.widget.getWidgetInfos() else {
            return
        }
         
        for info in widgetInfos {
            switch info.widgetId {
            case "AgoraChatWidget":
                info.properties = ["contextPool": contextPool]
                let chat = contextPool.widget.create(with: info)
                chat.addMessageObserver(self)
                 
                let hasConversation = (viewType == .oneToOne ? 0 : 1)
                if let message = ["hasConversation": hasConversation].jsonString() {
                    chat.widgetDidReceiveMessage(message)
                }
                 
                self.chat = chat
            default:
                break
            }
        }
}
 ```
	
## 步骤四：替换 SDKs/Modules/AgraUIEduBaseViews 目录下的文件

用原先 AgoraEduSDK/Modules/AgraUIEduBaseViews 目录下的文件替换 SDKs/Modules/AgraUIEduBaseViews 目录下的文件，具体如下：

- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraResources 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraResources。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraAlertView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraAlertView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraAnimatedImage 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraAnimatedImage。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraHandsUpView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraHandsUpView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraRefresh 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraRefresh。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraToastView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraToastView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUIEduBaseViews.xcassets 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraUIEduBaseViews.xcassets。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUINavigationBar 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraUINavigationBar。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUIUserView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraUIUserView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUserListView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraUserListView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUserRenderListView 替换 SDKs/Modules/AgraUIEduBaseViews/AgoraUserRenderListView。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/Utils 替换 SDKs/Modules/AgraUIEduBaseViews/Utils。
- 用 AgoraEduSDK/Modules/AgraUIEduBaseViews/AgoraUIChatView 替换 Widgets/AgoraWidgets/Chat。

<details>
 <summary><font color="#3ab7f8">查看截图</font></summary>
1.1.5 之前版本的目录结构：<img src="https://web-cdn.agora.io/docs-files/1631956127330" />1.1.5 的目录结构：<img src="https://web-cdn.agora.io/docs-files/1631956146556" />
</details>   

## 步骤五：修改 `AgoraChatWidget.swift` 文件

在 `AgoraChatWidget.swift` 文件中进行以下操作：

1. 将初始化方法更改为下面的新的初始化方法：

   ```swift
   public required init(widgetId: String,
                        contextPool: AgoraEduContextPool,
                        properties: [AnyHashable : Any]?) {
       super.init(widgetId: widgetId,
                  contextPool: contextPool,
                  properties: properties)
       initViews()
       initLayout()
       initData()
   }
   ```

2. 增加 `AgoraEduMessageContext` 属性：

   ```swift
   private weak var context: AgoraEduMessageContext?
    
   public required override init(widgetId: String,
                                 properties: [AnyHashable: Any]?) {
       super.init(widgetId: widgetId,
                  properties: properties)
        
       initViews()
       initLayout()
        
       if let contextPool = properties?["contextPool"] as? AgoraEduContextPool {
           context = contextPool.chat
           initData()
       }
   }
   ```