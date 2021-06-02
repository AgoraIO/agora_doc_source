---
title: How can I avoid being frequency limited when calling Agora Server RESTful APIs?
platform: ["RESTful"]
updatedAt: 2020-11-06 10:35:30
Products: ["Voice","Video","Interactive Broadcast"]
---
When the request of an Agora Server RESTful API exceeds its call frequency limit, the API returns the HTTP status code 429, indicating that you have made too many requests in a specified amount of time. The following suggestions can help you optimize API call frequency based on the needs of your project. 

## Tips to avoid exceeding call frequency limits

- Distribute your API requests evenly across time windows.
  For example, if you want to call [`https://api.agora.io/dev/v1/channel/user/{appid}/{channelName}`](https://docs.agora.io/en/rtc/restfulapi/#/Online%20channel%20statistics%20query/userList) to query the user list of 100 online channels, the default call frequency limit for this API is 20 times per second. To avoid exceeding the call frequency limit, you can set the query interval of a single channel to 5 seconds, and then query the user list of 20 channels per second.
- Do not directly call Agora Server RESTful APIs on your client; call these APIs on your application server instead.
  For example, when using the API for querying online channel statistics, you can configure your application server to periodically send requests to Agora and cache the returned results. When a client queries channel information, your server sends the latest locally cached data to the client.

If the default frequency limit still cannot meet your project needs after considering the preceding suggestions, contact [support@agora.io](mailto:support@agora.io) to apply to adjust the call frequency limit. See <a href="#raiselimit">Apply to raise API call frequency limit</a>.


<div class="alert note">Each Agora Server RESTful API has an upper call frequency limit and cannot guarantee high real-time performance. In the case of high concurrency, you can contact <a href="mailto:support@agora.io">support@agora.io</a > to <a href="https://docs-preview.agoralab.co/en/Agora Platform/ncs">enable Agora message notification service</a > and configure your server to receive <a href="https://docs-preview.agoralab.co/en/Agora Platform/rtc_eventtype?platform=All Platforms#实时通信">Real-Time Communication events</a >.</div>

## Apply to raise API call frequency limit<a name="raiselimit"></a>

To raise the call frequency limit of an Agora Server RESTful API, you need contact [support@agora.io](mailto:support@agora.io) with the following information:

- Your industry, such as education, pan-entertainment, or medical.
- Your application scenario, such as chat room, small class, or PK host.
- Both the average and maximum number of concurrent channels.
- Both the average and peak number of concurrent users in each channel.
- The RESTful API that does not meet your project needs, as well as how you use it and in what scenarios.