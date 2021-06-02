---
title: RESTful API
platform: All Platforms
updatedAt: 2020-06-12 13:06:43
---
Visit our interactive API documentation at [Cloud Recording RESTful API](https://docs.agora.io/en/cloud-recording/restfulapi). This documentation contains detailed help for each Cloud Recording RESTful API and its parameters, and provides the **Try it out** function which allows you to send RESTful API requests and receive responses directly on the web page.

## API Overview

| API                                                          | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [`acquire`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/acquire) | Before starting a cloud recording, you need to call this method to get a resource ID. |
| [`start`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/start) | After getting a resource ID, call this method to start cloud recording. |                    
| [`update`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/update) | During a recording, you can call this method to update the subscription lists multiple times. |
| [`updateLayout`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/updateLayout) | During a recording, you can call this method to update the video mixing layout multiple times. |
| [`query`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/query) | After you start a recording, you can call `query` to check its status. |
| [`stop`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/stop) | When a recording finishes, call this method to leave the channel and stop recording. To use Agora Cloud Recording again, you need to call the `acquire` method for a new resource ID. |

