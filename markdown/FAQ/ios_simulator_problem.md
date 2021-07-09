---
title: 为什么在 Xcode 12.3 及之后版本中使用 iOS 模拟器构建项目会失败？
platform: ["iOS"]
updatedAt: 2021-01-29 04:02:32
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 问题描述

在 Xcode 12.3 及之后版本中，集成 Agora SDK 并使用 iOS 模拟器构建项目，你可能会收到如下错误信息：

```swift
Building for iOS Simulator, but the linked and embedded framework 'xxx.framework' was built for iOS + iOS Simulator.
```

## 问题原因

自 Xcode 11.0 起，Apple 允许但不推荐把用于多平台的二进制框架或库捆绑到一个 `.framework` 文件中。自 Xcode 12.3 起，Apple 不允许在一个 `.framework` 文件中绑定多平台的库，你必须使用 `.xcframework` 文件替代。为支持在 iOS 模拟器上运行项目，3.3.0 之前版本的 Agora SDK 在 `.framework` 文件中捆绑了多平台的库，所以 `.framework` 文件会在使用模拟器构建项目时被 Xcode 识别为错误配置。

## 解决方案

### 方案一：升级 SDK

自 3.3.0 版本起，Agora SDK 将 `.framework` 文件修改为 `.xcframework` 文件。该文件符合 Xcode 的要求，且支持在 iOS 真机和 iOS 模拟器上运行项目。Agora 推荐你将 SDK 升级至 3.3.0 或之后版本。集成步骤参考[获取 SDK](./start_live_ios?platform=iOS#integrate_sdk)。

### 方案二：修改构建选项

在 Xcode 中，进入 **TARGETS > Project Name > Build Settings > Build Options** 菜单，将 **Validate Workspace** 设置为 **Yes**。

### 方案三：构建 .xcframework 文件

对 3.0.0 至 3.2.1 版本的 SDK，Agora 提供 `xcframework.sh` 脚本，你可以基于 `.framework` 文件构建 `.xcframework` 文件。参考如下步骤使用该脚本：

1. 新建 `xcframework.sh` 文件，并在文件中添加如下代码：

 ```bash
#!/bin/bash
echo "Start building xcframework..."
AgoraIosFrameworkDir=$1
cd $AgoraIosFrameworkDir
# SDK 路径检测
if [ ! -d "libs" ]; then
    echo "SDK path error, please check!"
    exit 1
fi
cd libs/
cur_path=`pwd`
framework_suffix=".framework"
frameworks=""
# 寻找 libs 文件夹下所有的 .framework 文件
for file in `ls $cur_path`; do
    echo $file
    if [[ $file == *$framework_suffix* ]]; then
        frameworks="$frameworks $file"
    fi
done
echo "Frameworks found:$frameworks"
for framework in $frameworks; do
    binary_name=${framework%.*}
    echo "framework_name is $binary_name"
    supported_platforms="\"iPhoneSimulator\""
    # 在 ALL_ARCHITECTURE/xxx.framework 路径下的 Info.plist 文件中将 CFBundleSupportedPlatforms 修改为只支持 x86-64 或 i386 架构
    plutil -replace CFBundleSupportedPlatforms -json "[$supported_platforms]" ALL_ARCHITECTURE/$framework/Info.plist || exit 1
    # 移除 ALL_ARCHITECTURE 文件夹下 .framework 文件包含的 armv7 和 arm64 架构，只保留 x86-64 或 i386 架构
    lipo -remove armv7 ALL_ARCHITECTURE/$framework/$binary_name -output ALL_ARCHITECTURE/$framework/$binary_name
    lipo -remove arm64 ALL_ARCHITECTURE/$framework/$binary_name -output ALL_ARCHITECTURE/$framework/$binary_name
    # 使用 xcodebuild 命令，基于 libs 文件夹下 devices 架构和 ALL_ARCHITECTURE 文件夹下的 .framework 文件，构建 .xcframework 文件
    xcodebuild -create-xcframework -framework $framework -framework ALL_ARCHITECTURE/$framework -output $binary_name.xcframework
done
echo "Build xcframework successfully."
```

2. 在终端运行如下命令构建 `.xcframework` 文件：

 ```shell
// 将 xcframework_path 替换为 xcframework.sh 文件所在路径
cd xcframework_path
// 运行 xcframework.sh 文件
// 将 sdk_path 替换为 SDK 所在路径，例如，/Users/agora/Downloads/Agora_Native_SDK_for_iOS_FULL
sh xcframework.sh sdk_path
```

3. 进入你的项目文件夹，用生成的 `.xcframework` 文件替换原有的 `.framework` 文件。

4. 在 Xcode 中（界面描述以 Xcode 12.3 为例），进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单：

   1. 点击 **-** 移除 `.framework` 文件。
   2. 点击 **+ > Add Other ... > Add Files** 添加对应的 `.xcframework` 文件，并确保动态库的 **Embed** 属性为 **Embed & Sign**。

   以 3.2.0 版本的视频 SDK 为例，配置成功后，你会看到如下界面。

  ![](https://web-cdn.agora.io/docs-files/1611565418238)

参考 [Create an XCFramework](https://help.apple.com/xcode/mac/11.4/#/dev544efab96) 获取更多构建 `.xcframework` 文件的信息。