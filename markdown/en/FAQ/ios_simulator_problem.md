---
title: Why does my project build fail when I use the iOS simulator in Xcode 12.3 or later?
platform: ["iOS"]
updatedAt: 2021-01-29 04:12:37
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Problem

When you integrate the Agora SDK and use an iOS simulator to build a project in Xcode 12.3 or later, you may receive the following error message:

```swift
Building for iOS Simulator, but the linked and embedded framework 'xxx.framework' was built for iOS + iOS Simulator.
```

## Reason

Starting in Xcode 11.0, Apple recommended against using a single `.framework` file to bundle a binary framework or library for multiple platforms, although they still allowed it. As of Xcode 12.3, however, Apple no longer allows this; instead, you must use an `.xcframework` file. To support running a project on an iOS simulator, versions of the Agora SDK earlier than v3.3.0 bundle a library for multiple platforms in a `.framework` file, so `.framework` files are identified by Xcode as a prohibited configuration when you use an iOS simulator to build a project.

## Solution

### Solution one: Upgrade the SDK

As of v3.3.0, the Agora SDK uses `.xcframework` files in place of `.framework` files, which comply with Xcode's requirements and support running projects on iOS physical devices or iOS simulators. Agora recommends upgrading the SDK to v3.3.0 or later. See [Integrate the SDK](./start_call_ios?platform=iOS#integrate_sdk).

### Solution two: Change build options

In Xcode, navigate to **TARGETS > Project Name > Build Settings > Build Options** menu, and set **Validate Workspace** as **Yes**.

### Solution three: Create .xcframework files

For the SDK v3.0.0 to v3.2.1, Agora provides an `xcframework.sh` script to create `.xcframework` files based on `.framework` files. Refer to the following steps to use this script:

1. Create an `xcframework.sh` file, and add the following code to the file:

 ```bash
#!/bin/bash
echo "Start building xcframework..."
AgoraIosFrameworkDir=$1
cd $AgoraIosFrameworkDir
# Detect the SDK path
if [ ! -d "libs" ]; then
    echo "SDK path error, please check!"
    exit 1
fi
cd libs/
cur_path=`pwd`
framework_suffix=".framework"
frameworks=""
# Find all .framework files under the libs folder
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
    # In the Info.plist file under the ALL_ARCHITECTURE/xxx.framework path, change the CFBundleSupportedPlatforms attribute to x86-64 or i386 only
    plutil -replace CFBundleSupportedPlatforms -json "[$supported_platforms]" ALL_ARCHITECTURE/$framework/Info.plist || exit 1
    # Remove the armv7 and arm64 architectures in the .framework file under the ALL_ARCHITECTURE folder, and keep the x86-64 or i386 architecture only
    lipo -remove armv7 ALL_ARCHITECTURE/$framework/$binary_name -output ALL_ARCHITECTURE/$framework/$binary_name
    lipo -remove arm64 ALL_ARCHITECTURE/$framework/$binary_name -output ALL_ARCHITECTURE/$framework/$binary_name
    # Use the xcodebuild command to create an .xcframework file based on the devices architecture under the libs folder and the .framework file under the ALL_ARCHITECTURE folder
    xcodebuild -create-xcframework -framework $framework -framework ALL_ARCHITECTURE/$framework -output $binary_name.xcframework
done
echo "Build xcframework successfully."
```

2. In Terminal, run the following command to create `.xcframework` files:

 ```shell
// Replace the xcframework_path with the path of the xcframework.sh script
cd xcframework_path
// Run the xcframework.sh script
// Replace the sdk_path with the path of the SDK. For example, /Users/agora/Downloads/Agora_Native_SDK_for_iOS_FULL
sh xcframework.sh sdk_path
```

3. Navigate to your project folder, delete the `.framework` files, and copy the `.xcframework` files into the folder.

4. In Xcode (the interface description in this article is based on Xcode 12.3), navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu:

   1. Click **-** to remove `.framework` files.
   2. Click **+ > Add Other… > Add Files** to add the corresponding `.xcframework` files. Ensure the status of these dynamic libraries is **Embed & Sign**.

   For example, with the Video SDK v3.2.0, after you successfully configure the project, you see the following interface:

  ![](https://web-cdn.agora.io/docs-files/1611565418238)

For more information about creating an `.xcframework` file, see [Create an XCFramework](https://help.apple.com/xcode/mac/11.4/#/dev544efab96).