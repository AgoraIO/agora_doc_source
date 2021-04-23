本页介绍如何自定义修改灵动课堂的 UI，如颜色、按钮、布局等。

## 工作原理

自 1.1.0 起，Agora 将灵动课堂的 UI 代码和业务逻辑隔离开来，独立成 UIKi。 开发者无需深入学习灵动课堂的核心业务逻辑细节，只需修改 UI 组件，即可自定义修改灵动课堂的 UI。

![](https://web-cdn.agora.io/docs-files/1619169594360)

UIKit 的源码位于 GitHub 上 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 仓库（dev/apaas/1.1.0 分支）中 `Modules` 目录下，主要包含以下文件夹：

| 文件夹 | 描述 |
| :-------------------- | :------------------------------------------------- |
| `AgoraUIBaseViews` | 灵动课堂使用的基础 UI 组件，如基础 btn、view。 |
| `AgoraUIEduBaseViews` | 灵动课堂使用的高阶 UI 组件，如聊天区域、渲染视图。 |
| `AgoraUIEduAppViews` | 在灵动课堂的各种教学场景中组装 UI 组件。 |

## UI 修改示例

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
        self.backgroundColor = UIColor.init(rgb: UInt32("BFBFBF", radix: 16) ??  0)
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
   
* Add a function like below
*/
DemoLeave = "离开";
   ```
   `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraResources/en.lproj/Localizable.strings`
   ```
   /*
* Add a function like below
*/
DemoLeave = "Leave";
   ```
   
   
2. 在 `AgoraUIEduAppViews/AgoraUIEduAppViews/Views/AgoraUIEduAppViews.swift` 文件中添加属性。

   ```
   /*
   
* Add a property to the AgoraUIEduAppViews class
*/
weak var demoButton: AgoraBaseUIButton?
   ```
   
   
3. 在 `AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIEduAppViews.swift` 文件中添加如下代码。

   ```
   
   
/*
* Add the initView function
*/
func initView() {
···
let demoBtn = AgoraBaseUIButton()
demoBtn.setTitle(AgoraKitLocalizedString("DemoLeave"), for: UIControl.State.normal)
demoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
demoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
demoBtn.backgroundColor = UIColor(rgb: UInt32("BFBFBF",radix: 16) ??  0)
demoBtn.addTarget(self,
action: #selector(onTouchLeaveDemo(_:)),
for: UIControl.Event.touchUpInside)
self.demoButton = demoBtn
addSubview(demoBtn)
}
/*
* Add the initLayout function
*/
func initLayout() {
···
demoButton?.agora_center_x = self.agora_center_x
demoButton?.agora_center_y = self.agora_center_y
demoButton?.agora_width = 100
demoButton?.agora_height = 100
}
/*
* Add the onTouchLeaveDemo function
*/
@objc func onTouchLeaveDemo(_ btn: AgoraBaseUIButton) {
self.roomListener?.onLeaveRoom()
}
```
   修改后，灵动课堂的 1 对 1 互动教学场景中，会出现如下图标。 

   
   ![](https://web-cdn.agora.io/docs-files/1619169646534)

