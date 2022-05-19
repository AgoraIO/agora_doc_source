## 教室和 UI 组件介绍

### 数据交互流程

在 Agora Classroom SDK 中，灵动课堂的 UI 层代码和核心业务逻辑相隔离，独立成 **AgoraEduUI** 和 **AgoraEduCore** 两个库，两者通过 [Agora Edu Context](/cn/agora-class/API%20Reference/edu_context_kotlin/API/edu_context_api_overview.html) 产生关联。举例来说，对于灵动课堂中的设备开关功能，需要通过一个按钮改变设备状态。为实现该功能，我们在 `AgoraEduUI` 中调用 `MediaContext` 的 `openLocalDevice` 方法，并监听 `IMediaHandler` 抛出的设备状态改变相关事件。数据流转示意图如下：

![](https://web-cdn.agora.io/docs-files/1650273644082)

### 教室和 UI 组件结构说明

教室的类结构示意图如下：

![](https://web-cdn.agora.io/docs-files/1650362684444)

每种班型的 UI 在对应的 `.xml` 文件中定义，包含多个独立的 UI 组件 (Component)。UI 组件的结构示意图如下：

![](https://web-cdn.agora.io/docs-files/1650362871036)

开发者可自由组合 UI 组件搭建自定义版型，也可以自定义 UI 组件或修改灵动课堂的 UI 组件。

## 自定义课堂 UI

本节介绍自定义课堂 UI 的具体步骤。

### 1. 获取灵动课堂源码

如需修改灵动课堂的默认 UI，你需要通过下载 [GitHub 源码](https://github.com/AgoraIO-Community/CloudClass-Android)的方式集成灵动课堂，步骤如下：

1. 运行以下命令克隆仓库到本地：

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-Android.git
    ```

2. 运行以下命令切换分支至指定版本，将 {VERSION} 替换为要切换的版本号：

    ```bash
    git checkout release/apaas/{VERSION}
    ```

    例如要切换到 2.1.0 版本分支，执行以下命令：

    ```bash
    git checkout release/apaas/2.1.0
    ```

    Agora 建议你切换到最新发版分支。参考下图在 GitHub 仓库中查看最新发版分支：

    ![](https://web-cdn.agora.io/docs-files/1648636502733)

后续 UI 相关的改动主要在以下两个目录中进行：

-   `/AgoraClassSDK`：实现教室页面。
-   `/AgoraEduUIKit`：教室使用到的所有 UI 组件。

### 2. 引入 UI 组件库

参考以下步骤引入 UI 组件库：

1. 参考[集成灵动课堂文档](/cn/agora-class/agora_class_integrate_android)将灵动课堂以 maven 的方式引入到你自己的项目中。

2. 修改 `AgoraEduUIKit` 和 `AgoraClassSDK` 模块的引用方式。你需要在 `build.gradle` 文件中进行如下修改：

    ```kotlin
    dependencies {
     // ...
     implementation "io.github.agoraio-community:hyphenate:版本号"
     implementation "io.github.agoraio-community:AgoraEduCore:版本号"
     // implementation "io.github.agoraio-community:AgoraEduUIKit:版本号"
     // implementation "io.github.agoraio-community:AgoraClassSDK:版本号"
     implementation project(path: ':AgoraClassSDK')
    }
    ```

<div class="alert info"><code>AgoraClassSDK</code> 里引用了 <code>AgoraEduUIKit</code> 模块。</div>

<div class="alert note">GitHub 源码的版本号要和 maven 引用的版本号保持一致。</div>

### 3. 修改现有的 UI 组件

所有 UI 组件都位于 `com.agora.edu.component` 目录下，找到对应的组件就可以修改 UI。

<img src="https://web-cdn.agora.io/docs-files/1650365793677" style="zoom:30%;" />

#### 修改示例

下文以小班课为例，介绍如何修改顶部导航栏的高度、标题以及背景色：

1. 在 `AgoraClassSDK` 模块的 `io.agora.classroom.ui` 下面找到小班课的 `AgoraClassSmallActivity`。

2. 在 `AgoraClassSmallActivity` 对应的 `activity_agora_class_small.xml` 中找到 `AgoraEduHeadComponent` 组件。`Activity` 与 `.xml` 是通过 `viewbinding` 绑定的。

    ![](https://web-cdn.agora.io/docs-files/1650438722532)

3. 打开 `AgoraEduHeadComponent` 对应的 `agora_edu_head_component.xml`。在这个文件中，你可以直接修改导航栏的高度、标题以及背景色。

    ![](https://web-cdn.agora.io/docs-files/1650438755866)

    ![](https://web-cdn.agora.io/docs-files/1650438826125)

### 4. 新增 UI 组件

所有 UI 组件都必须继承 `AbsAgoraEduComponent`，且调用 `initView(agoraUIProvider: IAgoraUIProvider)` 方法初始化 UI 组件。

UI 组件可通过 `IAgoraUIProvider` 接口获取 EduCore 层的数据。

```kotlin
interface IAgoraUIProvider {
    /**
     * 获取 EduCore 数据
     */
    fun getAgoraEduCore(): AgoraEduCore?

    /**
     * UI 可以自定义数据
     */
    fun getUIDataProvider(): UIDataProvider?
}
```

#### 修改示例

下文介绍如何为 1 对 1 班型新增一个 `AgoraEduMyComponent` 组件。具体步骤如下：

1. 定义 `AgoraEduMyComponent`：

    ```kotlin
    class AgoraEduMyComponent : AbsAgoraEduComponent {
        constructor(context: Context) : super(context)
        constructor(context: Context, attr: AttributeSet) : super(context, attr)
        constructor(context: Context, attr: AttributeSet, defStyleAttr: Int) : super(context, attr, defStyleAttr)

        // TODO: 替换成你自己定义的 xml
        private var binding: xxxxBinding = xxxBinding.inflate(LayoutInflater.from(context), this, true)

        override fun initView(agoraUIProvider: IAgoraUIProvider) {
           super.initView(agoraUIProvider)
           // TODO: 在这里处理 View
           // TODO: agoraUIProvider 提供教室数据能力和 View 需要的数据，你可自行定义
        }

    }
    ```

2. 在 `.xml` 中使用定义好的 `AgoraEduMyComponent`：

    ```xml
    <xxxx.xxx.xxxx.AgoraEduMyComponent
        android:id="@+id/agora_class_head"
        android:layout_width="match_parent"
        android:layout_height="@dimen/agora_head_h_small"
        android:gravity="center"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintTop_toTopOf="parent" />
    ```

3. 在 `AgoraClass1V1Activity` 中初始化组件：

    ```kotlin
    class AgoraClass1V1Activity : AgoraEduClassActivity() {
        private val TAG = "AgoraClass1V1Activity"
        lateinit var binding: ActivityAgoraClass1v1Binding

        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            binding = ActivityAgoraClass1v1Binding.inflate(layoutInflater)
            setContentView(binding.root)

            // 创建教室对象
            createEduCore(object : EduContextCallback<Unit> {
                override fun onSuccess(target: Unit?) {
                    // 教室资源加载完成后
                    joinClassRoom()
                }

                override fun onFailure(error: EduContextError?) {
                    error?.let {
                        ToastManager.showShort(it.msg)
                    }
                    finish()
                }
            })
        }

        private fun joinClassRoom() {
            runOnUiThread {
                eduCore()?.eduContextPool()?.let { context ->
                    // 初始化 view
                    binding.agoraEduMyComponent.initView(this)
                }
                join()
            }
        }
    }
    ```
