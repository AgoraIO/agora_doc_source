---
title: 如何将 RGB 文件转换为 PNG 文件-deprecated
platform: ["All Platforms"]
updatedAt: 2020-04-26 14:02:58
Products: []
---
RTC 视频智能审核生成的视频截图为 RGB 格式，存储在你通过 `storageConfig` 参数定义的第三方云存储上。你可以通过以下三种方式，将 RGB 文件转换为可在浏览器中查看的 PNG 文件，以便人工复审。

## Web 前端转换 （webpack 项目）

如果你的 Web 项目基于 webpack，你可以在项目中集成以下代码，使 RGB 文件在前端页面直接显示为 PNG 图片。

### 前提条件

- 登录 [Node.js 官网](https://nodejs.org/en/) 安装 Node.js LTS 版

- 运行以下命令，安装 fast-png：

  ```
  npm i fast-png
  ```


### 实现方法

1. 在你的 HTML 文件中预先填入一个空的 \<canvas\> 标签，并在 \<img\> 标签中填入待展示图片的 `domId`：

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="utf-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1" />
       <title>raw rgb24 to png</title>
     </head>
     <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="root"></div>
       <!-- 填入待展示图片的 domId -->
       <img id="domId">
       <!-- 必须要有 canvas 元素，用于获取浏览器上的 ArrayBuffer size -->
       <canvas></canvas>
     </body>
   </html>
   ```

2. 在你的 Javascript 代码中添加以下代码，并在代码中填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和 DOM ID： 
  ```javascript
   import {encode as encodePNG} from 'fast-png'; 
   
   let _byteLength = 0;
   
   // 固定宽高
   const clientWidth = 299; 
   const clientHeight = 299;
     
   const imgByteLength = () => {
     if (_byteLength > 0) return _byteLength;
     const canvas = document.querySelector("canvas");
     const ctx = canvas.getContext('2d');
     if (ctx) {
       const {data} = ctx.getImageData(0, 0, clientWidth, clientHeight);
       return data.byteLength;
     }
     return 0;
   }
  
   const downloadFetch = async (filename, domId) => {
     const byteLength = imgByteLength();
     if (!byteLength) {
       console.warn('canvas not mounted');
     }
   
     const res = await fetch(filename, {
       method: 'GET',
    });
     const blob = await res.blob();
     const arrayBuffer = await blob.arrayBuffer();
     const uint8 = new Uint8Array(arrayBuffer);
     
     const data = new Uint8ClampedArray(byteLength);
     // transform rgb24 to rgba32
     for (let y = 0; y < clientHeight; y++) {
       for (let x = 0; x < clientWidth; x++) {
         const idx = y * clientWidth + x;
         const idxRGB = idx * 3;
         const idxRGBA = idx * 4;
         data[idxRGBA + 0] = uint8[idxRGB + 0];
         data[idxRGBA + 1] = uint8[idxRGB + 1];
         data[idxRGBA + 2] = uint8[idxRGB + 2];
         data[idxRGBA + 3] = 255;
       }
     }
    
     const pngBuffer = encodePNG({
       data: new Uint8Array(data.buffer),
       height: clientHeight,
       width: clientWidth
     });
   
     await new Promise((resolve, reject) => {
       const reader = new FileReader();
       reader.onload = (e) => {
         const {result} = e.currentTarget;
         const img = document.getElementById(domId);
         if (img) {
           img.src = result;
           img.complete && resolve(result);
         } else {
           console.warn('img is empty, domId: ', domId);
           resolve();
         }
       }
       reader.readAsDataURL(new Blob([pngBuffer], {type: "image/png"}));
     })
   }
   
   // 填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和 domId
   downloadFetch('RGB 文件地址', 'domId').then(console.log).catch(console.warn);
  ```

成功调用该 `downloadFetch` 函数后，你可以在浏览器上看到从 RGB 文件转码成 PNG 的图片。

## Web 前端转换 （非 webpack 项目）

如果你的 Web 项目不基于 webpack，你可以采用以下方法，使 RGB 文件在前端页面直接显示为 PNG 图片。


### 实现方法

1. 下载 [`dist.zip`](https://download.agora.io/docs/dist.zip)。解压后，你可以看到一个 `index.js` 文件。

2. 在你的 HTML 文件中填入以下信息：

   - 一个空的 \<canvas\> 标签
   - 在 \<img\> 标签中填入待展示图片的 `domId`
   - 使用 \<script\> 标签导入你在第一步中解压得到的 `index.js` 文件

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="utf-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1" />
       <title>raw rgb24 to png</title>
     </head>
     <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="root"></div>
       <!-- 填入待展示图片的 domId -->
       <img id="domId">
       <!-- 必须要有 canvas 元素，用于获取浏览器上的 ArrayBuffer size -->
       <canvas></canvas>
       <!-- 导入 index.js 文件-->
       <script src="index.js 文件路径"></script>
     </body>
   </html>
   ```

3. 在你的 Javascript 代码中添加以下代码，并在代码中填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和 DOM ID： 

   ```javascript
    // const FastPng = new window.FastPng();
    const encodePNG = window.FastPng.encode;
    let _byteLength = 0;
   
    // 固定宽高
    const clientWidth = 299;
    const clientHeight = 299;
   
    const imgByteLength = () => {
    if (_byteLength > 0) return _byteLength;
    const canvas = document.querySelector("canvas");
    const ctx = canvas.getContext('2d');
    if (ctx) {
    const { data } = ctx.getImageData(0, 0, clientWidth, clientHeight);
    return data.byteLength;
    }
    return 0;
    }
   
    const downloadFetch = async (filename, domId) => {
    const byteLength = imgByteLength();
    if (!byteLength) {
    console.warn('canvas not mounted');
    }
   
    const res = await fetch(filename, {
    method: 'GET',
    });
    const blob = await res.blob();
    const arrayBuffer = await blob.arrayBuffer();
    const uint8 = new Uint8Array(arrayBuffer);
   
    const data = new Uint8ClampedArray(byteLength);
    // transform rgb24 to rgba32
    for (let y = 0; y < clientHeight; y++) {
    for (let x = 0; x < clientWidth; x++) {
    const idx = y * clientWidth + x;
    const idxRGB = idx * 3;
    const idxRGBA = idx * 4;
    data[idxRGBA + 0] = uint8[idxRGB + 0];
    data[idxRGBA + 1] = uint8[idxRGB + 1];
    data[idxRGBA + 2] = uint8[idxRGB + 2];
    data[idxRGBA + 3] = 255;
    }
    }
   
    const pngBuffer = encodePNG({
    data: new Uint8Array(data.buffer),
    height: clientHeight,
    width: clientWidth
    });
   
    await new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e) => {
    const { result } = e.currentTarget;
    const img = document.getElementById(domId);
    if (img) {
    img.src = result;
    img.complete && resolve(result);
    } else {
    console.warn('img is empty, domId: ', domId);
    resolve();
    }
    }
    reader.readAsDataURL(new Blob([pngBuffer], { type: "image/png" }));
    })
    }
   
    // 填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和 domId
     downloadFetch('RGB 文件地址', 'domId').then(console.log).catch(console.warn); 
   ```

成功调用该 `downloadFetch` 函数后，你可以在浏览器上看到从 RGB 文件转码成 PNG 的图片。

### 示例项目

[`dist.zip`](https://download.agora.io/docs/dist.zip) 提供了一个示例项目文件（`index.html`）和示例 RGB 文件。你可以通过以下步骤，在浏览器中查看该 RGB 文件转换后的 PNG 图片。

1. 登录 [Node.js 官网](https://nodejs.org/en/) 安装 Node.js LTS 版。
2. 下载 `dist.zip` 并解压。
3. 进入 `dist` 文件夹，打开命令行窗口，运行 `npx serve` 命令启动一个 web 服务。如果命令执行成功，你可以在命令行窗口看到网页的 URL 地址。
![](https://web-cdn.agora.io/docs-files/1579490178808)
4. 在浏览器中输入 URL 地址，即可浏览转换后的 PNG 文件。

## Node.js 服务器端转换

你也可以使用 Node.js 执行 JS 脚本，在服务器端将 RGB 文件转码为 PNG 文件。

### 前提条件

你需要在你的 Web 服务器上进行如下操作：

- 安装 Node.js LTS 版

- 运行以下命令，安装 fast-png：

  ```
  npm i fast-png
  ```

### 实现方法

1. 创建一个 JS 文件，并写入以下代码。在代码中填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和图片输出路径。
   ```javascript
   // npm i fast-png
   const {encode} = require('fast-png');
   const fs = require('fs');
   
   // 填入 RGB 文件在第三方云存储上的 URL 地址 （可供公网访问）和 PNG 图片输出路径
   const fullFilePath = "RGB 文件路径";
   const outputFilePath = "图片输出路径";
   const data = fs.readFileSync(fullFilePath);
   
   const width = 299; // fixed width
   const height = 299; // fixed height
   
   const uint8 = new Uint8Array(data);
   const array = [];
   
   // rgb24 转换 rgb32
   for (let y = 0; y < height; y++) {
     for (let x = 0; x < width; x++) {
       const idx = y * width + x;
       const idxRGB = idx * 3;
       array.push(uint8[idxRGB + 0]);
       array.push(uint8[idxRGB + 1]);
       array.push(uint8[idxRGB + 2]);
       array.push(255);
     }
   }
   
   const buffer = Uint8Array.from(array);
   // rgb32 转换 png
   const rawData = encode({
       data: buffer,
       height,
       width
   });
   
   // rgb32 saved as png
   fs.writeFileSync(outputFilePath, rawData);
   ```

2. 在 Node.js 中运行该 JS 文件，便可以将指定的 RGB 文件转换为 PNG 文件。打开终端，进入该 JS 文件所在文件夹，并运行以下命令：

   ```
    node <JS 文件名>
   ```

执行该 JS 文件后，在你指定的图片输出路径下将生成一个从 RGB 文件转码成 PNG 的图片。

