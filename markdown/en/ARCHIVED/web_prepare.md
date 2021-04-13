---
title: Integrate the SDK
platform: Web
updatedAt: 2020-09-11 15:18:49
---
The Quickstart Guide will take you throught the steps in creating a basic voice/video call demo with the Agora Web SDK.

> If you want to try Agora's demo first, see [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Web) on GitHub.

## <a name = "pre"></a>Prerequisites

1. Install a browser supported by the Agora Web SDK as shown in the following table:
  <table>
  <tr>
    <th>Platform</th>
    <th>Google Chrome 58 or later</th>
    <th>Firefox 56 or later</th>
    <th>Safari 11 or later</th>
    <th>Opera 45 or later</th>
    <th>QQ Browser</th>
    <th>360 Secure Browser</th>
    <th>WeChat Built-in Browser</th>
  </tr>
   <tr>
    <td>Android 4.1 or later</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
		<td><b>N/A</b></td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>iOS 11 or later</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="green">✔</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>macOS 10 or later</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="red">✘</td>
    <td><font color="red">✘</td>
  </tr>
  <tr>
    <td>Windows 7 or later</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
		<td><b>N/A</b></td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="green">✔</td>
    <td><font color="red">✘</td>
  </tr>
</table>

> - The Agora Web SDK v2.5 or later also supports Google Chrome 49 on Windows XP.
> - To use Safari on iOS 12.2+ or macOS Mojave 10.14.4+, upgrade to Agora Web SDK v2.6.

2. Get a valid Agora account. ([Sign up](https://sso.agora.io/en/signup) for free)
3. Open the ports and whitelist the domains as specified in [Firewall Requirements](/en/Agora%20Platform/firewall).
4. Understand the limitations in [Known Issues](./release_web_video#known-issues-and-limitations) and [FAQ](websdk_related_faq).

## Create the project

You need to create an HTML file for this project.

1. Create an HTML file. Here we name it as `demo.html`.
2. Open the project file with a code editor (such as Visual Studio Code).
3. Copy the following code and add it to the `demo.html` file in the code editor.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <style>
  *{
    font-family: sans-serif;
  }
  h1,h4{
    text-align: center;
  }
  #local{
    position: absolute;
    width: 480px;
    height: 360px;
    bottom: 10px;
    left: 10px;
    z-index: 100;
    border: 3px solid white;
    border-radius: 3px;
  }
  #local video{
    position: relative !important;
  }
  #remote{
    position: absolute;
    width: 480px;
    height: 360px;
    top: 40px;
    right: 5px;
  }
  #remote video{
    height: auto;
    position: relative !important;
  }
  </style>
</head>
<body>
  <h1>Agora Video Call Web Demo</h1>
  <div id="video">
    <div id="local"></div>
    <div id="remote"></div>
  </div>
  <button onclick="join()">Join</button>
  <button onclick="leave()">Leave</button>
  <script>
  </script>
</body>
</html>
```


## Import the Agora Web SDK to Your Project

Choose one of the following methods to obtain the Agora Web SDK:

### Method 1: Get the SDK through npm

This method requires npm, see [Install npm](https://www.npmjs.com/get-npm) for details.

1. Run the following command to install the SDK.
  `npm install agora-rtc-sdk`

	
2. Add the following code to your project.

	```javascript
	import AgoraRTC from 'agora-rtc-sdk'
	```

### Method 2: Get the SDK through the CDN

Add the following code to the line after `<head>` in your project.

```javascript
<script src="https://cdn.agora.io/sdk/web/AgoraRTCSDK-2.6.js"></script>
```

### Method 3: Get the SDK from the official Agora website

1. [Download](https://docs.agora.io/en/Agora%20Platform/downloads) the latest Agora Web SDK.

2. Copy the `AgoraRTCSDK-2.6.js` file to the same directory as your project file.

3. Add the following code to the line above `</body>` in your project.

   ```javascript
<script src="./AgoraRTCSDK-2.6.js"></script>
	 ```

For convenience, let's use the second method and copy the code to the project file.

Now the project is set up. Next we'll add the javascript code to define the `join()` and `leave()` functions used in the above code. See [Make a Voice/Video Call](./communication_web_video-1?platform=Web) for details.