---
title: Chrome 屏幕共享插件
platform: NULL
updatedAt: 2020-10-12 15:34:44
---
# Chrome 屏幕共享插件

在 Chrome 上使用屏幕共享功能需要安装 Agora 提供的屏幕共享插件。

关于如何实现屏幕共享，详见 [进阶：实现网页端屏幕共享](/cn/Quickstart%20Guide/screensharing_web)。

## 安装 Chrome 屏幕共享插件

按照以下步骤安装 Chrome 屏幕共享插件：

### 获取 Chrome 屏幕共享插件

点击 [下载](http://download.agora.io/sdk/release/chrome-extension.zip)。

<img alt="../_images/chrome_extension_screenshare.png" src="https://web-cdn.agora.io/docs-files/cn/chrome_extension_screenshare.png" style="width: 702.0px; height: 122.0px;"/>


### 修改 json 文件

删除 Chrome 屏幕共享插件包中 `manifest.json`文件内 **“key”** 行的全部内容，以及 **“key”** 上排的 **逗号**：

```
{
   "manifest_version": 2,
   "minimum_chrome_version": "34",
   "name": "Agora Web Screensharing",
   "permissions": [ "desktopCapture" ],
   "short_name": "Screen sharing for Agora",
   "update_url": "https://clients2.google.com/service/update2/crx",
   "version": "0.0.0.1",

   "background": {
      "persistent": true,
      "scripts": [ "script.js" ]
   },
   "description": "Extension to allow screen sharing in Agora Web Application.",
   "externally_connectable": {
      "matches": ["*://gs.agora.io/*", "*://webdemo.agora.io/*", "*://webdemo.agorabeckon.com/*"] // 将 Agora 的域名替换为你的网站域名
   },
   "icons": {
      "128": "128w.png",
      "16": "16w.png",
      "48": "48w.png"
   },
   "browser_action":{
     "default_icon": "16w.png"
   },
   "key": "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyRcxkUO0XuAsLqzRMIL+XlNTAgbc4/CtRrC2o7qDHGv6uAjmeS7HiK0hzK4PowsUTi0Y38LLzxju0Zr0IFoz9R5fKQt45rAdViujkuCURI4gFKUn6nOJ1/LjaTXYh02v1qWR17Aih8dc1VkWlBQKcapaH6y0N35i7IHZVWsT+ySXsdS6GDFPZVb1wYhDZRZYbkRYpBVEf11HOX+PkQGO5zhbdjBsp7BPF4L//vRwUxcxmeqgkRgzPAAy99UMsrgh/kbJSzE8XacUET9eYKzT21/ZSkiXEddWWCm2jeRWTrfie6D+c1K4zGFnS47in9timvpkMl5OM7J58wqjK20FiwIDAQAB"
}
```

### 安装插件并获取插件 ID

在 Chrome 网页端安装获取到的 Chrome 插件。 首先打开你的 Chrome 浏览器，点击屏幕右上方的扩展按钮，选择 **更多工具** \> **扩展程序**。

<img alt="../_images/chrome_extension_install_1.png" src="https://web-cdn.agora.io/docs-files/cn/chrome_extension_install_1.png" style="width: 864.0px; height: 540.0px;"/>


然后点击 **加载已解压的扩展程序** ，点击你刚刚获取并解压的 **chrome-extension** 文件夹，然后点击 **选择** 。

<img alt="../_images/chrome_extension_install_2.png" src="https://web-cdn.agora.io/docs-files/cn/chrome_extension_install_2.png" style="width: 736.8px; height: 418.8px;"/>


完成插件安装后，你可以直接在 Chrome 浏览器界面查看你的插件 ID。

<img alt="../_images/chrome_extension_id.png" src="https://web-cdn.agora.io/docs-files/cn/chrome_extension_id.png" style="width: 522.0px; height: 272.4px;"/>


### 修改域名

点击打开插件文件夹中的 `manifest.json` 文件，然后将 `match` 行的域名替换为你的网页域名。

<img alt="../_images/chrome_extension_url.png" src="https://web-cdn.agora.io/docs-files/cn/chrome_extension_url.png" style="width: 792.0px; height: 29.0px;"/>


