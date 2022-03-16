## Overview

Agora provides the complete Agora Classroom SDK on CocoaPods. However, if you want to customize the user interfaces of classrooms, Agora provides the source code of the Agora Classroom SDK for you to further develop, debug, and compile. The source code of the Agora Classroom SDK for iOS is in the [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS)repository on GitHub (branch release/apaas/1.1.0). The Agora Classroom SDK separates the code of the user interfaces from the code of core business logic and provides two libraries, UIKit and EduCore. These two libraries connect with each other through [Agora Edu Context](https://docs.agora.io/cn/agora-class/edu_context_api_ref_ios_overview?platform=iOS). For example, for the chat module in the  Flexible Classroom, a user needs to click on a button to send a message, and they also receive messages sent by other users. In this case, in UIKit, we can call a method in the Chat Context to send a message and listen for the events in the Chat Context to receive messages.

![](https://web-cdn.agora.io/docs-files/1619696813295)

UIKit provides all the code for the user interfaces in Flexible Classroom. You can find the source code of the UIKit in the `Modules` folder in the CloudClass-Android repository on GitHub (Branch release/apaas/1.1.0). The project structure of UIKit is as follows:

| Folder | Description |
| :-------------------- | :---------------------------------------------------- |
| `AgoraUIBaseViews` | The source code of the basic UI components used by Flexible Classroom, including buttons and views. |
| `AgoraUIEduBaseViews` | The source code of the function-level UI components used by Flexible Classroom, such as the chat area. |
| `AgoraUIManager` | Assemble UI components in various classrooms. |

## UI customization example

This section provides examples of customizing the user interfaces of Flexible Classroom.

### Change the color of the navigation bar

The following example demonstrates how to modify the background color of the navigation bar component from white to gray by modifying `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift`.

#### Before

```
func initView() {
        self.backgroundColor = UIColor.white
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169606618)

#### After

```
func initView() {
        self.backgroundColor = UIColor.init(rgb: UInt32("BFBFBF", radix: 16) ??  0)
        ...
    }
```

![](https://web-cdn.agora.io/docs-files/1619169615790)

### Adjust the layout

The following example demonstrates how to change the position of the leave room button and the network status icon by modifying `AgoraUIEduBaseViews/AgoraUIEduBaseViews/AgoraUINavigationBar/AgoraUINavigationBar.swift`.

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

The following example shows how to add a custom basic UI component and use it in Flexible Classroom:

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

2. Add properties in `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift`.

   ```
   /*
 * Operation:
 *           add a property to the class AgoraUIManager
 */
weak var demoButton: AgoraBaseUIButton?
   ```

   ```
   
   ```

3. Add the following code in `/AgoraUIEduAppViews/AgoraUIEduAppViews/AgoraUIManager.swift`.

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

   After modification, the following icon appears in the one-to-one classroom.

   ![](https://web-cdn.agora.io/docs-files/1619169646534)