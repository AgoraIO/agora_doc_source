---
title: 为什么无法通过浏览器调用云端录制 RESTful API？
platform: ["RESTful"]
updatedAt: 2020-07-09 21:45:24
Products: ["cloud-recording"]
---

要使用云端录制 RESTful API，Web API 需要发送跨域请求。根据 CORS 规范，浏览器针对跨域请求会先发送一个 OPTIONS 请求，查询服务器是否允许跨域请求，然后才有可能发起真正的 POST 请求。但是由于云端录制 RESTful API 不支持 OPTIONS 方法，所以无法支持 Web API 调用的方式。
