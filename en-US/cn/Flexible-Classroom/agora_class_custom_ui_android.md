This page introduces how to customize the UI of Flexible Classroom, such as colors, buttons, and layout.

## Working principles

Since 1.1.0, Agora has separated the UI code and business logic of the Smart Flexible Classroom and became UIKi independently. Developers do not need to deeply study the core business logic details of   Flexible Classroom, but only need to modify the UI components to customize and modify the UI of the  Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1619168618104)

You can find the source code of the UIKit in the packages[/agora-scenario-ui-kit/src folder](https://github.com/AgoraIO-Community/CloudClass-Android) in the CloudClass-Desktop repository on GitHub (Branch dev/apaas/1.1.0)`. The project` structure of the UIKit is as follows: The core project structure is introduced as follows:

| Folder | Description |
| :----------- | :----------------------------------------------------------- |
| `interfaces` | Define the Protocol and Listener of the  Flexible Classroom business logic. There is no need to modify the contents of this directory to customize the UI. |
| impl |  Flexible Classroom default implementation of each Protocol, that is, the default UI components used   Flexible Classroom, include:<ul><li>`chat`: chat area.</li><li>`handsup`: UI related to students "raising their hands" to apply for speaking.</li><li>`room`: Classroom status, navigation bar related UI.</li><li>`screnshare`: Screen sharing related UI.</li><li>`tool`: Toolbar containing various teaching aids.</li><li>`users`: UI related to user status.</li><li>`"`video`"`: Video track.</li><li>`whiterboard`: Whiteboard area.</li><li>`container`: Assemble default UI components in various teaching scenarios in the smart classroom to form the management class of contentView.</ul> |
| `component`: Custom, | The source code of the basic UI components used by Flexible Classroom. |

## UI modification example

### Change the color of the navigation bar

The following example demonstrates how to modify the background color of the` navigation bar component from white to gray by modifying the agoraui/src/main/res/layout/agora_status_bar_layout.xml` file.

<div class="alert info">The navigation bar component is implemented in the <code>Agora/src/main/kotlin/io/Agora/uikit/impl/room/Agora</code> file.</div>

#### Before

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
 android:layout_width="match_parent"
 android:layout_height="match_parent"
 android:background="@drawable/agora_class_room_rect_bg">
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168631686)

#### After

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
 android:layout_width="match_parent"
 android:layout_height="match_parent"
 android:background="#BFBFBF">
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168642141)

### Adjust the layout

The following example demonstrates how to change the position of the` leave room button and the network status icon by modifying the agoraui/src/main/res/layout/agora_status_bar_layout.xml` file.

<div class="alert info">The navigation bar component is implemented in the <code>Agora/src/main/kotlin/io/Agora/uikit/impl/room/Agora</code> file.</div>

#### Before

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  android:background="@drawable/agora_class_room_rect_bg">
  <androidx.appcompat.widget.AppCompatImageView
      android:id="@+id/agora_status_bar_network_state_icon"
      android:layout_width="match_parent"
      android:layout_height="match_parent"
      android:supportsRtl="true"
      android:supportsRtl="true"
      android:supportsRtl="true"
      android:layout_marginStart="@dimen/margin_large"
      android:layout_marginLeft="@dimen/margin_large"/>
  <androidx.appcompat.widget.AppCompatImageView
      android:id="@+id/activity_main"
      android:layout_width="match_parent"
      android:layout_height="match_parent"
      android:supportsRtl="true"
      android:supportsRtl="true"
      android:supportsRtl="true"
      android:layout_marginEnd="@dimen/margin_large"
      android:layout_marginRight="@dimen/margin_large"
      android:src="@drawable/agora_room_icon_exit"/>
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168654208)

#### After

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  android:background="@drawable/agora_class_room_rect_bg">
  <androidx.appcompat.widget.AppCompatImageView
    android:id="@+id/agora_status_bar_network_state_icon"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:supportsRtl="true"
    android:supportsRtl="true"
    android:supportsRtl="true"
    android:layout_marginEnd="@dimen/margin_large"
    android:layout_marginRight="@dimen/margin_large"/>
 <androidx.appcompat.widget.AppCompatImageView
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:supportsRtl="true"
    android:supportsRtl="true"
    android:supportsRtl="true"
    android:layout_marginStart="@dimen/margin_large"
    android:layout_marginLeft="@dimen/margin_large"
    android:src="@drawable/agora_room_icon_exit"/>
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168663484)

### Add a basic UI component

The following example shows how to add a customized basic UI component and use it in  Flexible Classroom:

Suppose the properties of the UI component are as follows:

- Size: 100*100
- Position: centered
- Background color: #BFBFBF
- Text: `"`Leave"/`"Leave"`
- Text color: UIColor.white
- Click the button to realize the function: leave the room

Complete the following steps to determine the call type:

1. Add Chinese and English copywriting to the following files respectively. `
agoraui/src/main/res/values-zh/strings.xml`

   ```
   <!-- Customer -->
<string name="custom_widget_text"> leave</string>
   ```
   `agoraui/src/main/res/values/strings.xml`

   ```
   <!-- Customer -->
<string name="custom_widget_text">Leave</string>
   ```

2. Add a `custom_widget_layout.xml `file under the `agoraui/src/main/res/`layout directory to define the style of custom components.
   ```
   <?xml version="1.0" encoding="utf-8"?>

   
<FrameLayout
xmlns:android="http://schemas.android.com/apk/res/android"
android:layout_width="match_parent"
android:layout_height="match_parent">
<TextView
android:id="@+id/tv_custom_leave"
android:layout_width="100dp"
android:layout_height="100dp"
android:background="#BFBFBF"
android:textColor="@android:color/white"
android:gravity="center"
android:layout_gravity="center"
android:text="@string/custom_widget_text"/>
</FrameLayout>
```
3. Modify the `Agora/src/main/kotlin/io/Agora/uikit/impl/container/Agora` file to add custom components to the   One-to-one Classroom scene.
```
class AgoraUI1v1Container : AbsUIContainer() {
override fun init(layout: ViewGroup, left: Int, top: Int, width: Int, height: Int) {
...
addCustomWidget(layout)
}

private fun addCustomWidget(layout: ViewGroup){
val customLayout = LayoutInflater.from(layout.context).inflate(R.layout.custom_widget_layout, layout)
customLayout.findViewById<TextView>(R.id.tv_custom_leave).setOnClickListener {
roomStatus?.showLeaveDialog()
}
}
}
```
After modification, the  Flexible Classroom will appear in the one-to-one interactive teaching scene of Smart Classroom. 

![](https://web-cdn.agora.io/docs-files/1619168684154)

