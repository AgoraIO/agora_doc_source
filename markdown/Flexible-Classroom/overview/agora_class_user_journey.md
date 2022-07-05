## 了解产品

使用灵动课堂前，Agora 建议你先阅读以下文档，以对灵动课堂形成一个初步的了解：

-   [产品概述](/cn/agora-class/product_agora_class)
-   [产品功能](/cn/agora-class/agora_class_prod_archit)
-   [技术架构](/cn/agora-class/agora_class_tech_archit)
-   [基本概念](/cn/agora-class/agora_class_tech_archit)
-   [平台支持](/cn/agora-class/agora_class_platform)

## 体验产品

Agora 提供 Android、iOS、macOS、Windows、Web、H5 端的灵动课堂体验 Demo App，点击[链接](/cn/agora-class/downloads?platform=All%20Platforms)前往下载体验。

## 快速入门

### 开通灵动课堂

参考[文档](/cn/agora-class/agora_class_enable)在 Agora 控制台快速开通灵动课堂服务。

### 跑通 GitHub 项目

Agora 提供不同平台的灵动课堂 GitHub 项目源码，跑通方法请参见以下文档：

-   [跑通 CloudClass-Android 项目](/cn/agora-class/agora_class_quickstart_android?platform=Android)
-   [跑通 CloudClass-iOS 项目](/cn/agora-class/agora_class_quickstart_ios?platform=iOS)
-   跑通 CloudClass-Desktop 项目
    -   [跑通 Web 端](/cn/agora-class/agora_class_quickstart_web?platform=Web)
    -   [跑通 Electron 端](/cn/agora-class/agora_class_quickstart_electron?platform=Electron)

### 集成灵动课堂

跑通 GitHub 项目后，可参考以下文档将灵动课堂集成到你的项目中：

-   [集成灵动课堂 (Android)](/cn/agora-class/agora_class_integrate_android?platform=Android)
-   [集成灵动课堂 (iOS)](/cn/agora-class/agora_class_integrate_ios?platform=iOS)
-   [集成灵动课堂 (Web/Electron)](/cn/agora-class/agora_class_integrate_web?platform=Web)

### 自定义课堂 UI

集成灵动课堂后，可参考以下文档自定义修改灵动课堂的 UI：

-   [自定义课堂 UI (Android)](/cn/agora-class/agora_class_custom_ui_android?platform=Android)
-   [自定义课堂 UI (iOS)](/cn/agora-class/agora_class_custom_ui_ios?platform=iOS)
-   [自定义课堂 UI (Web/Electron)](/cn/agora-class/agora_class_custom_ui_web?platform=Web)

### 自定义插件

集成灵动课堂后，可参考以下文档基于 Widget 开发自定义插件并注入灵动课堂内：

-   [自定义插件 (Android)](/cn/agora-class/agora_class_widget_android?platform=Android)
-   [自定义插件 (iOS)](/cn/agora-class/agora_class_widget_ios?platform=iOS)
-   [自定义插件 (Web/Electron)](/cn/agora-class/agora_class_widget_web?platform=Web)

## 开发资源

### 源码

Agora 提供不同平台的 GitHub 项目源码，你可前往 GitHub 查看：

<table>
<thead>
  <tr>
    <th>平台</th>
    <th>GitHub 仓库</th>
    <th>说明</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Android</td>
    <td><a href="https://github.com/AgoraIO-Community/CloudClass-Android" target="_blank" rel="noopener noreferrer">CloudClass-Android</a></td>
    <td>灵动课堂 Android 端的源码</td>
  </tr>
  <tr>
    <td rowspan="2">iOS</td>
    <td><a href="https://github.com/AgoraIO-Community/CloudClass-iOS" target="_blank" rel="noopener noreferrer">CloudClass-iOS</a></td>
    <td>灵动课堂 iOS 端的源码</td>
  </tr>
  <tr>
    <td><a href="https://github.com/AgoraIO-Community/apaas-extapp-ios" target="_blank" rel="noopener noreferrer">apaas-extapp-ios</a></td>
    <td>灵动课堂 iOS 端插件的源码</td>
  </tr>
  <tr>
    <td>Web/Electron</td>
    <td><a href="https://github.com/AgoraIO-Community/CloudClass-Desktop" target="_blank" rel="noopener noreferrer">CloudClass-Desktop</a></td>
    <td>灵动课堂桌面端的源码，包含 Web 端以及基于 Electron 框架开发的 macOS 和 Windows 端</td>
  </tr>
</tbody>
</table>

### API 文档

#### 客户端 API

<table>
<thead>
  <tr>
    <th>平台</th>
    <th>API 文档</th>
    <th>说明</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="2">Android</td>
    <td><a href="/cn/agora-class/agora_class_api_ref_android?platform=Android" target="_blank" rel="noopener noreferrer">Classroom SDK Kotlin API Reference</a></td>
    <td>启动课堂相关 API</td>
  </tr>
  <tr>
    <td><a href="/cn/agora-class/API%20Reference/edu_context_kotlin/API/edu_context_api_overview.html" target="_blank" rel="noopener noreferrer">Edu Context Kotlin API Reference</a></td>
    <td>实现灵动课堂业务功能的 API</td>
  </tr>
  <tr>
    <td rowspan="2">iOS</td>
    <td><a href="https://confluence.agoralab.co/cn/agora-class/agora_class_api_ref_ios?platform=iOS" target="_blank" rel="noopener noreferrer">Classroom SDK Swift API Reference</a></td>
    <td>启动课堂相关 API</td>
  </tr>
  <tr>
    <td><a href="/cn/agora-class/API%20Reference/edu_context_swift/API/edu_context_api_overview.html" target="_blank" rel="noopener noreferrer">Edu Context Swift API Reference</a></td>
    <td>实现灵动课堂业务功能的 API</td>
  </tr>
  <tr>
    <td rowspan="2">Web/Electron</td>
    <td><a href="/cn/agora-class/agora_class_api_ref_web?platform=Web" target="_blank" rel="noopener noreferrer">Classroom SDK TypeScript API Reference</a></td>
    <td>启动课堂相关 API</td>
  </tr>
  <tr>
    <td><a href="/cn/agora-class/API%20Reference/edu_context_web/index.html" target="_blank" rel="noopener noreferrer">Edu Store API Reference</a></td>
    <td>实现灵动课堂业务功能的 API</td>
  </tr>
</tbody>
</table>

#### 服务端 API

可通过调用 RESTful API 接口实现功能，详见[灵动课堂云服务 RESTful API 文档](/cn/agora-class/agora_class_restful_api?platform=RESTful)。
