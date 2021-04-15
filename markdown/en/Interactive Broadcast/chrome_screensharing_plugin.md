---
title: Chrome Extension for Screen Sharing
platform: NULL
updatedAt: 2020-10-20 14:40:16
---
To enable screen sharing on Google Chrome, you need to add the Google Chrome extension provided by Agora for screen sharing.

This page provides instructions on：

-   [Adding the Google Chrome Screen-sharing Extension](#Adding-the-Chrome-Screen-sharing-Extension)

-   [Uploading the Google Chrome Screen-sharing Extension](#Uploading-the-Chrome-Screen-sharing-Extension)


On how to enable screen sharing, see [Screen Sharing on the Web](/en/Quickstart%20Guide/screensharing_web)

<a name = "Adding-the-Chrome-Screen-sharing-Extension"></a>
## Adding the Google Chrome Screen-sharing Extension

To add the Google Chrome screen-sharing extension:

### 1. Acquire the screen-sharing extension

[Download](http://download.agora.io/sdk/release/chrome-extension.zip)

<img alt="../_images/chrome_extension_screenshare.png" src="https://web-cdn.agora.io/docs-files/en/chrome_extension_screenshare.png" style="width: 630px; "/>


### 2. Implement the extension and get the extension ID

Implement and check the extension ID in Google Chrome. You need the `extensionId` to enable screen sharing.

<img alt="../_images/chrome_extension_id.png" src="https://web-cdn.agora.io/docs-files/en/chrome_extension_id.png" style="width: 420px;"/>


### 3. Change the domain name

Open the `manifest.json` file in the extension package, and change the domain name in the line beginning with **matches**.

<img alt="../_images/chrome_extension_url.png" src="https://web-cdn.agora.io/docs-files/en/chrome_extension_url.png" />

<a name = "Uploading-the-Chrome-Screen-sharing-Extension"></a>
## Uploading the Google Chrome Screen-sharing Extension

1. Modify the JSON file.

	Delete the code that begins with **“key”** and the **,** above **“key”** in the `manifest.json` file in the extension package:

	```json
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
				"matches": ["*://gs.agora.io/*", "*://webdemo.agora.io/*", "*://webdemo.agorabeckon.com/*"]
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

2.  Package the modified Google Chrome screen-sharing extension and register it in the Google App Store so that your user can download and use it. 

	On how to publish your extension on the Chrome Web Store, see [https://developer.chrome.com/webstore/publish](https://developer.chrome.com/webstore/publish).

To enable your customers to directly download and install the extension from your website, see [https://developer.chrome.com/webstore/inline\_installation](https://developer.chrome.com/webstore/inline_installation). In your app, you also need to register the ID of the extension using the Agora Web SDK.


