---
title: 快速跑通示例项目
platform: Android
updatedAt: 2020-11-24 07:37:44
---
本文指导开发者在将 RTSA Lite SDK 集成到项目中之前，编译并运行模拟数据 Demo 进行初步了解。

## 前提条件
请确保开发环境满足以下要求:

* Android 5.0 及以上
* Android Studio 3.0 及以上

请获取以下文件：

* 最新版本的 Agora RTSA Lite SDK for Android。
* 模拟数据 Demo。

## 创建 Agora 账号并获取 App ID
1. 进入[控制台](https://console.agora.io/)，并按照屏幕提示注册账号并登录控制台。详见[创建新账号](sign_in_and_sign_up)。

2. 点击左侧导航栏的 ![](https://web-cdn.agora.io/docs-files/1551254998344) 图标进入[项目管理](https://console.agora.io/projects)页面，点击**创建**按钮。

![](https://web-cdn.agora.io/docs-files/1574156100068)

3. 在弹出的对话框内输入**项目名称**，选择 App ID 作为**鉴权机制**，再点击“提交”。

![](https://web-cdn.agora.io/docs-files/1574921599254)

4. 项目创建成功后，你会在**项目列表**下看到刚刚创建的项目，并找到对应的 App ID。

![](https://web-cdn.agora.io/docs-files/1574921811175)




## 编译运行模拟数据 Demo

步骤如下：

1. 配置 SDK。
	解压 RTSA Lite SDK 包，将 SDK 包中的 agora-rtc-sdk.jar 放置于模拟数据 Demo 的 andorid/app/libs 目录下，将包中的其它文件夹放入 andorid/app/src/main/jniLibs 目录下。

2. 配置 App ID。
	
	1). 进入源码目录：
~~~shell
cd andorid/app/src/main/java/io/agora/rtc/agorartcdatademo/
~~~
	
	2). 将 PLACEHOLDER 重命名为 AppIdAndCert.java：
~~~shell
cp PLACEHOLDER AppIdAndCert.java
~~~
	
	3). 在 AppIdAndCert.java 中填写你获取到的 App ID：
~~~java
static final String APP_ID = "$YOUR_APP_ID";
~~~

3. 在 Android Studio 中打开模拟数据 Demo，连接两台 Android 设备，编译运行。
	
	1). 点击 Sync 按钮，提示 Build: completed successfully 表示编译成功后，点击 Run → Run app 按钮运行 Demo。
	
	2). Demo 中点击右下角按钮，进入频道并自动收发数据。
	
 ![](https://web-cdn.agora.io/docs-files/1565604729166)
	
	3). 再次点击该按钮退出频道，停止收发数据，并打印简略统计信息。
	
	![](https://web-cdn.agora.io/docs-files/1565604782304)