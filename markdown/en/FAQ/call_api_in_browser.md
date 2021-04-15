---
title: Why can't I call the Cloud Recording RESTful API through a web browser?
platform: ["RESTful"]
updatedAt: 2019-11-19 10:52:25
Products: ["cloud-recording"]
---
A Web API needs to make a cross-origin request in accordance with Cross-Origin Resource Sharing (CORS) to call the Cloud Recording RESTful API. The browser must first send an OPTIONS request to the server to query if the server accepts cross-origin requests before sending a cross-origin POST request. However, the Cloud Recording RESTful API does not support the OPTIONS method, and therefore you cannot call it with a Web API.