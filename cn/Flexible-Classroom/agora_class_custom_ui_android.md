本页介绍如何自定义修改灵动课堂的 UI，如颜色、按钮、布局等。

## 工作原理

自 1.1.0 起，Agora 将灵动课堂的 UI 代码和业务逻辑隔离开来，独立成 UIKi。开发者无需深入学习灵动课堂的核心业务逻辑细节，只需修改 UI 组件，即可自定义修改灵动课堂的 UI。

![](https://web-cdn.agora.io/docs-files/1619168618104)

UIKit 的源码位于 GitHub 上 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 仓库（dev/apaas/1.1.0 分支）中 `agoraui` 目录下。核心项目结构介绍如下：

| 文件夹       | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `interfaces` | 定义灵动课堂业务逻辑的 Protocol 和 Listener。自定义 UI 无需修改该目录下的内容。 |
| impl         | 灵动课堂对每个 Protocol 的默认实现，即灵动课堂使用的默认 UI 组件，包含：<ul><li>`chat`: 聊天区域。</li><li>`handsup`: 学生“举手”申请发言相关 UI。</li><li>`room`: 课堂状态、导航栏相关 UI。</li><li>`screnshare`: 屏幕共享相关 UI。</li><li>`tool`: 包含各种教具的工具栏。</li><li>`users`: 用户状态相关 UI。</li><li>`video`: 视频区域。</li><li>`whiterboard`: 白板区域。</li><li>`container`: 在灵动课堂的各种教学场景中组装默认 UI 组件形成 contentView 的管理类。</ul> |
| `component`  | 灵动课堂使用的公共组件。                                     |

## UI 修改示例

### 修改导航栏颜色

以下示例演示了如何通过修改 `agoraui/src/main/res/layout/agora_status_bar_layout.xml` 文件将导航栏组件的背景颜色从白色修改为灰色。

<div class="alert info">导航栏组件在 <code>agoraui/src/main/kotlin/io/agora/uikit/impl/room/AgoraUIRoomStatus.kt</code> 文件中实现。</div>

#### 修改前

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
 android:layout_width="match_parent"
 android:layout_height="match_parent"
 android:background="@drawable/agora_class_room_rect_bg">
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168631686)

#### 修改后

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
 android:layout_width="match_parent"
 android:layout_height="match_parent"
 android:background="#BFBFBF">
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168642141)

### 调整布局

以下示例演示了如何通过修改 `agoraui/src/main/res/layout/agora_status_bar_layout.xml` 文件将离开房间按钮与网络状态图标的位置对调。

<div class="alert info">导航栏组件在 <code>agoraui/src/main/kotlin/io/agora/uikit/impl/room/AgoraUIRoomStatus.kt</code> 文件中实现。</div>

#### 修改前

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  android:background="@drawable/agora_class_room_rect_bg">
  <androidx.appcompat.widget.AppCompatImageView
      android:id="@+id/agora_status_bar_network_state_icon"
      android:layout_width="@dimen/agora_status_bar_icon_size"
      android:layout_height="@dimen/agora_status_bar_icon_size"
      android:layout_centerVertical="true"
      android:layout_alignParentStart="true"
      android:layout_alignParentLeft="true"
      android:layout_marginStart="@dimen/margin_large"
      android:layout_marginLeft="@dimen/margin_large"/>
  <androidx.appcompat.widget.AppCompatImageView
      android:id="@+id/agora_status_bar_exit_icon"
      android:layout_width="@dimen/agora_status_bar_icon_size"
      android:layout_height="@dimen/agora_status_bar_icon_size"
      android:layout_centerVertical="true"
      android:layout_alignParentEnd="true"
      android:layout_alignParentRight="true"
      android:layout_marginEnd="@dimen/margin_large"
      android:layout_marginRight="@dimen/margin_large"
      android:src="@drawable/agora_room_icon_exit"/>
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168654208)

#### 修改后

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  android:background="@drawable/agora_class_room_rect_bg">
  <androidx.appcompat.widget.AppCompatImageView
    android:id="@+id/agora_status_bar_network_state_icon"
    android:layout_width="@dimen/agora_status_bar_icon_size"
    android:layout_height="@dimen/agora_status_bar_icon_size"
    android:layout_centerVertical="true"
    android:layout_alignParentEnd="true"
    android:layout_alignParentRight="true"
    android:layout_marginEnd="@dimen/margin_large"
    android:layout_marginRight="@dimen/margin_large"/>
 <androidx.appcompat.widget.AppCompatImageView
    android:id="@+id/agora_status_bar_exit_icon"
    android:layout_width="@dimen/agora_status_bar_icon_size"
    android:layout_height="@dimen/agora_status_bar_icon_size"
    android:layout_centerVertical="true"
    android:layout_alignParentStart="true"
    android:layout_alignParentLeft="true"
    android:layout_marginStart="@dimen/margin_large"
    android:layout_marginLeft="@dimen/margin_large"
    android:src="@drawable/agora_room_icon_exit"/>
...
</RelativeLayout>
```

![](https://web-cdn.agora.io/docs-files/1619168663484)

### 自定义 UI 组件

以下示例演示了如何自定义一个 UI 组件并在灵动课堂中的 1 对 1 互动教学场景中使用。

 假设该 UI 组件的属性如下：

- 大小：100*100
- 位置：居中
- 背景色：#BFBFBF
- 文字：`“离开”`/`“Leave”`
- 文字颜色：UIColor.white
- 点击按钮实现功能：离开房间

实现步骤如下：

1. 在 以下文件中分别添加中文和英文文案。
   `agoraui/src/main/res/values-zh/strings.xml`
   
   ```
   <!-- Customer -->
   <string name="custom_widget_text">离开</string>
   ```
   `agoraui/src/main/res/values/strings.xml`
   
   ```
   <!-- Customer -->
   <string name="custom_widget_text">Leave</string>
   ```

2. 在 `agoraui/src/main/res/layout` 目录下新增 `custom_widget_layout.xml` 文件，用于定义自定义组件的样式。
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

3. 修改 `agoraui/src/main/kotlin/io/agora/uikit/impl/container/AgoraUI1v1Container.kt` 文件，将自定义组件添加到 1 对 1 互动教学场景中。

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

   修改后，灵动课堂的 1 对 1 互动教学场景中，会出现如下图标。

   ![](https://web-cdn.agora.io/docs-files/1619168684154)