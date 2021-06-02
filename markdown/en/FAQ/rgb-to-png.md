---
title: How can I convert RGB to PNG?
platform: ["All Platforms"]
updatedAt: 2020-04-30 13:32:00
Products: []
---
The screenshots taken by the RTC Video Moderation are in the RGB format. Use any of the following three methods to convert an RGB file to PNG for future human review.

## Convert from a Web client (for projects built with webpack)

If your project is built with webpack, add the following code to your project, which converts an RGB file to PNG when the web page is loaded.

### Prerequisites

- Download Node.js LTS from [Node.js](https://nodejs.org/en/) and install it.
- Run `npm i fast-png` to install `fast-png`.

### Steps

1. Add the following code to your HTML file:
   1. An empty `<canvas>` element.
   2. Enter the `domId` of the RGB file in an `<img>` tag.

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
       <!-- Enter the domId of the RGB file -->
       <img id="domId">
       <!-- The canvas element is required to get the ArrayBuffer size of the browser. -->
       <canvas></canvas>
     </body>
   </html>
```

2. Add the following Javascript code to your web project, and enter the public URL of the RGB file stored on the third-party cloud storage and `domId`:

```javascript
  import {encode as encodePNG} from 'fast-png'; 
  
  let _byteLength = 0;
  
  // Fixed width and height
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
    // Transform rgb24 to rgba32
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
  
  //Enter the public URL of the RGB file stored on the third-party cloud storage and domId.
  downloadFetch('URL', 'domId').then(console.log).catch(console.warn);
```

When the method call of `downloadFetch` succeeds, you can view the PNG file converted from RGB from your web browser.

## Convert from a Web client (for projects not built with webpack)

If your project is not built with webpack, add the following code to your project, which converts an RGB file to PNG when the web page is loaded.

### Steps

1. Download [`dist.zip`](https://download.agora.io/docs/dist.zip). Unzip the file and find `index.js`.
2. Add the following code to your HTML file:
   1. An empty `<canvas>` element.
   2. Enter the `domId` of the RGB file in an `<img>` tag.
   3. Use the `<script>` element to import the `index.js` file that you get in the first step.

``` html
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
       <!-- Enter the domId of the RGB file -->
       <img id="domId">
       <!-- The canvas element is required to get the ArrayBuffer size of the browser. -->
       <canvas></canvas>
       <!-- Import the index.js file -->
       <script src="diretory of index.js"></script>
     </body>
   </html>
```

3. Add the following Javascript code to your project, and enter the public URL of the RGB file stored on the third-party cloud storage and `domId`:

```javascript
    // const FastPng = new window.FastPng();
    const encodePNG = window.FastPng.encode;
    let _byteLength = 0;
   
    // fixed width and height
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
    // Transform rgb24 to rgba32
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
    
    //Enter the public URL of the RGB file stored on the third-party cloud storage and domId
     downloadFetch('URL', 'domId').then(console.log).catch(console.warn); 
```

When the method call of `downloadFetch` succeeds, you can view the PNG file converted from RGB in your web browser.


### Sample project

[`dist.zip`](https://download.agora.io/docs/dist.zip) provides a sample project file (`index.html`) and an RGB file. Follow these steps to convert an RGB file and view the generated PNG file from your web browser.

1. Download Node.js LTS from [Node.js](https://nodejs.org/en/) and install it.
2. Download [`dist.zip`](https://download.agora.io/docs/dist.zip) and unzip the file.
3. Open a Terminal window and change directory (cd) to the `dist` folder. Run `npx serve` to launch a web service.
   Two URLs are listed in the Terminal when the command succeeds.
   ![](https://web-cdn.agora.io/docs-files/1579492317712)
5. Enter one of the URLs in your web browser to view the PNG file converted from RGB.

## Convert from your server using Node.js

You can convert an RGB file to PNG from your server by executing the Javascript file in Node.js.

### Prerequisites

On your web server:

- Download Node.js LTS from [Node.js](https://nodejs.org/en/) and install it.
- Run `npm i fast-png` to install `fast-png`.


### Steps

1. Create a Javascript file and add the following code. Enter the public URL of the RGB file stored on the third-party cloud storage and `domId`.

```javascript
   // npm i fast-png
   const {encode} = require('fast-png');
   const fs = require('fs');
   
   // Enter the public URL of the RGB file stored on the third-party cloud storage and domId.
   const fullFilePath = "URL of the RGB file";
   const outputFilePath = "Output path of the converted file";
   const data = fs.readFileSync(fullFilePath);
   
   const width = 299; // fixed width
   const height = 299; // fixed height
   
   const uint8 = new Uint8Array(data);
   const array = [];
   
   // Transform rgb24 to rgba32
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
   //  Transform rgba32 to png
   const rawData = encode({
       data: buffer,
       height,
       width
   });
   
   // rgb32 saved as png
   fs.writeFileSync(outputFilePath, rawData);
```

2. Run the Javascript file in Node.js. Open a Terminal window, change directory (cd) to the folder holding the Javascript file, and run the following command:

```
node <Name of the Javascript file>
```

You can find the PNG file converted from RGB in the specified directory.