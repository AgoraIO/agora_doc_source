This page introduces how to customize the UI of Flexible Classroom, such as colors, buttons, and layout.

## Working principles

From 1.1.0, Agora derives the UI code from the business logic of Flexible Classroom and provides the UIKit. UI Kit provides the source code of UI components for  Flexible Classroom. If developers only want to modify the classroom UI, they can modify only the UI components without in-depth study of the core business logic details of the smart Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1619169594360)

The source code of UIKit is located under the [Modules directory in the CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) repository (release/apaas/1.1.0 branch) on ``GitHub, and it mainly contains the following folders:

| Folder | Description |
| :-------------------- | :---------------------------------------------------- |
| `AgoraUIBaseViews` | Flexible Classroom UI components used in Smart Class, such as basic btn and view. |
| `AgoraUIEduBaseViews` | High-level UI components used by Smart Class, such as chat area UI, rendering view. |
| `AgoraUIManager` | Assemble UI Flexible Classroom in various teaching scenarios in the smart classroom. |

## UI customization example

Here are a few examples of modifying     Flexible Classroom.

### Change the color of the navigation bar

The following example demonstrates how to modify the background color of the navigation bar component` from white to gray by modifying the AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift` file.

#### Before

```
func initView () {
        self.backgroundColor = UIColor.white
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169606618)

#### After

```
func initView () {
        self.backgroundColor = UIColor.init(rgb: UInt32("BFBFBF", radix: 16) ??  0)
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169615790)

### Adjust the layout

The following example demonstrates how to change the position of the` leave room button and the network status icon by modifying the AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift` file.

#### Before

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

#### After

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

### Add a basic UI component

The following example shows how to add a custom basic UI component and use it in  Flexible Classroom:

Suppose the properties of the UI component are defined as follows:

- Size: 100*100
- Position: Centered
- Background color: #BFBFBF
- Text: “离开”/“Leave”
- Text color: UIColor.white
- What happens when clicking the button: Leave the room

Add a basic UI component, as follows:

1. Add Chinese and English texts in the following files respectively.

   `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraResources/zh-Hans.lproj/Localizable.strings`

   ```
   /*
 * Operation:
 *          add a function like below
 */
DemoLeave = "Leave";
   ```
   `AgoraUIEduBaseViews / AgoraUIEduBaseViews / AgoraResources / en.lproj / Localizable.strings`

   ```
   /*
 * Operation:
 *          add a function like below
 */
DemoLeave = "Leave";
   ```


   ```
   
   ```

2. Add properties in the `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift` file.

   ```
   /*
 * Operation:
 *           add a property to the class AgoraUIManager
 */
weak var demoButton: AgoraBaseUIButton?
   ```

   ```
   
   ```

3. Add the following code to the `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift` file.

   ```
   /*
 * Function:
 *          addContainerViews
 * Operation:
 *          add code like below
 */
func addContainerViews () {
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
     demoButton? .agora_center_x = self.agora_center_x
     demoButton? .agora_center_y = self.agora_center_y
     demoButton? .agora_width = 100
     demoButton? .agora_height = 100
}
/*
 * Operation:
 *          add a function like below
 */
@objc func onTouchLeaveDemo (_ btn: AgoraBaseUIButton) {
    self.roomListener?.onLeaveRoom()
}
   ```

   After modification, the following icon appears in the one-to-one classroom.

   ![](https://web-cdn.agora.io/docs-files/1619169646534)
