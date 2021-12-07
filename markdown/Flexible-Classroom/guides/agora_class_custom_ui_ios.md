## 概述

Agora 在 CocoaPods 上提供完整的 Agora Classroom SDK 供你集成。但是，如果 Agora Classroom SDK 中默认的 UI 无法满足你的需求，你也可以获取 Agora Classroom SDK 的源码，自行开发、调试和编译。Agora Classroom SDK for iOS 的源码位于 GitHub 上 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 仓库（release/apaas/1.1.0 分支）。在 Agora Classroom SDK 中，灵动课堂的 UI 代码和核心业务逻辑相隔离，独立成 UIKit 和 EduCore 两个库，两者通过 [Agora Edu Context](https://docs.agora.io/cn/agora-class/edu_context_api_ref_ios_overview?platform=iOS) 产生关联。举例来说，对于灵动课堂中的文字聊天功能，需要通过一个按钮发送消息，同时需要接收其他用户发送的消息。这种情况下，我们在 UIKit 中可以调用 Chat Context 中的发送消息方法，并监听 Chat Context 中消息接收相关事件。

![](https://web-cdn.agora.io/docs-files/1619696813295)

UIKit 中提供灵动课堂的 UI 组件代码。UIKit 的源码位于 GitHub 上 CloudClass-Android 仓库（release/apaas/1.1.0 分支）中 `Modules` 目录下，核心项目结构介绍如下：

| 文件夹                | 描述                                                  |
| :-------------------- | :---------------------------------------------------- |
| `AgoraUIBaseViews`    | 灵动课堂使用的基础 UI 组件，如基础 btn、view。        |
| `AgoraUIEduBaseViews` | 灵动课堂使用的高阶 UI 组件，如聊天区域 UI、渲染视图。 |
| `AgoraUIManager`      | 在灵动课堂的各种教学场景中组装 UI 组件。              |

## UI 修改示例

以下提供几个修改灵动课堂 UI 的示例。

### 修改导航栏颜色

以下示例演示了如何通过修改 `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift` 文件将导航栏组件的背景颜色从白色修改为灰色。

#### 修改前

```
func initView() {
        self.backgroundColor = UIColor.white
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169606618)

#### 修改后

```
func initView() {
        self.backgroundColor = UIColor.init(rgb: UInt32("BFBFBF", radix: 16) ?? 0)
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169615790)

### 调整布局

以下示例演示了如何通过修改 `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift` 文件将离开房间按钮与网络状态图标的位置对调。

#### 修改前

```
func initLayout() {
        signalImgView.agora_safe_x = 10
        signalImgView.agora_width = 20
        signalImgView.agora_height = 20
        signalImgView.agora_center_y = 0
         
        leaveButton.agora_safe_right = 10
        leaveButton.agora_width = 24
        leaveButton.agora_height = 24
        leaveButton.agora_center_y = 0
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169626442)

#### 修改后

```
func initLayout() {
        signalImgView.agora_safe_right = 10
        signalImgView.agora_width = 20
        signalImgView.agora_height = 20
        signalImgView.agora_center_y = 0
         
        leaveButton.agora_safe_x = 10
        leaveButton.agora_width = 24
        leaveButton.agora_height = 24
        leaveButton.agora_center_y = 0
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169635097)

### 自定义 UI 组件

以下示例演示了如何自定义一个 UI 组件并在灵动课堂中的 1 对 1 互动教学场景中使用。

 假设该 UI 组件的属性如下：

- 大小：100*100
- 位置：居中
- 背景色：#BFBFBF
- 文字：“离开”/“Leave”
- 文字颜色：UIColor.white
- 点击按钮实现功能：离开房间

实现步骤如下：

1. 在以下文件中分别添加中文和英文文案。

   `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraResources/zh-Hans.lproj/Localizable.strings`

   ```
   /*
    * Operation:
    *          add a function like below
    */
   DemoLeave = "离开";
   ```
   `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraResources/en.lproj/Localizable.strings`

   ```
   /*
    * Operation:
    *          add a function like below
    */
   DemoLeave = "Leave";
   ```


   ```
   
   ```

2. 在 `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift` 文件中添加属性。

   ```
   /*
    * Operation:
    *           add a property to the class AgoraUIManager
    */
   weak var demoButton: AgoraBaseUIButton?
   ```

   ```
   
   ```

3. 在 `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift` 文件中添加如下代码。

   ```
   /*
    * Function:
    *          addContainerViews
    * Operation:
    *          add code like below
    */
   func addContainerViews() {
   ···
   let demoBtn = AgoraBaseUIButton()
   demoBtn.setTitle(AgoraKitLocalizedString("DemoLeave"), for: UIControl.State.normal)
   demoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
   demoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
   demoBtn.backgroundColor = UIColor(rgb: UInt32("BFBFBF",radix: 16) ?? 0)
   demoBtn.addTarget(self,
                     action: #selector(onTouchLeaveDemo(_:)),
                     for: UIControl.Event.touchUpInside)
   self.demoButton = demoBtn
   self.appView.addSubview(demoBtn)
   }
 
   /*
    * Function:
    *          initLayout
    * Operation:
    *          add code like below
    */
   func layoutContainerViews() {
        ···
        demoButton?.agora_center_x = self.agora_center_x
        demoButton?.agora_center_y = self.agora_center_y
        demoButton?.agora_width = 100
        demoButton?.agora_height = 100
   }
   /*
    * Operation:
    *          add a function like below
    */
   @objc func onTouchLeaveDemo(_ btn: AgoraBaseUIButton) {
       self.roomListener?.onLeaveRoom()
   }
   ```

   修改后，灵动课堂的 1 对 1 互动教学场景中，会出现如下图标。

   ![](https://web-cdn.agora.io/docs-files/1619169646534)