# See also

This section provides additional information for your reference.

## Sample project

Agora provides an open source sample project [start-sample-project-android] on GitHub that implements one-to-one video call and group video call for your reference.

<a name="other"></a>
## Other approaches to integrate the SDK

In addition to integrating the Agora Video SDK for Android through JitPack, you can also import the SDK into your project through mavenCentral or by manually copying the SDK files.

**Automatically integrate the SDK with mavenCentral**

1. In `/Gradle Scripts/build.gradle(Project: <projectname>)`, add the following lines to add the mavenCentral dependency:

    ```java
    buildscript {
        repositories {
            ...
            mavenCentral()
        }
        ...
    }

    allprojects {
        repositories {
            ...
            mavenCentral()
        }
    }
    ```

1. In `/Gradle Scripts/build.gradle(Module: <projectname>.app)`, add the following lines to integrate the Agora Video SDK into your Android project:

    ```java
    ...
    dependencies {
     ...
     // For x.y.z, fill in a specific SDK version number. For example, 3.5.0.
     // Get the latest version number through the release notes.
     implementation 'io.agora.rtc:full-sdk:x.y.z'
    }
    ```

This method only applies to v3.5.0 or later.

**Manually copy the SDK files**

1. Go to [SDK Downloads](https://docs.agora.io/en/Video/downloads?platform=Android), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

2. Copy the following files or subfolders from the libs folder of the downloaded SDK package to the path of your project.

    | File or subfolder        | Path of your project     |
    | :----------------------- | :----------------------- |
    | `agora-rtc-sdk.jar` file | `/app/libs/`             |
    | `arm-v8a` folder         | `/app/src/main/jniLibs/` |
    | `armeabi-v7a` folder     | `/app/src/main/jniLibs/` |
    | `x86` folder             | `/app/src/main/jniLibs/` |
    | `x86_64` folder          | `/app/src/main/jniLibs/` |
    | `include` folder         | `/app/src/main/jniLibs/` |

-   If you use the armeabi architecture, copy files from the `armeabi-v7a` folder to the `armeabi` file of your project. Contact support@agora.io if you encounter any incompability issue.
-   Not all libraries in the SDK package are necessary. Refer to [How can I reduce the app size after integrating the RTC Native SDK](https://docs.agora.io/en/Video/faq/reduce_app_size_rtc) for details.
