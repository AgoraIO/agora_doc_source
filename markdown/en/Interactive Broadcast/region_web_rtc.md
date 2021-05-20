---
title: Network Geofencing
platform: Web
updatedAt: 2021-02-25 08:30:50
---
<div class="alert note">This article only applies to the Agora Web SDK 3.x and earlier versions.</div>

## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

As of v3.1.2, the Agora RTC Web SDK supports geofencing. 

When creating a client instance by calling [`createClient`](./API%20Reference/web/v3.3.1/globals.html#createclient), set the `areaCode` parameter in `ClientConfig` to specify the region for connection:

- `ASIA`: Asia, excluding Mainland China
- `CHINA`: Mainland China
- `EUROPE`: Europe
- `GLOBAL`: Global
- `INDIA`: India
- `JAPAN`: Japan
- `NORTH_AMERICA`: North America

<div class="alert note">
	<ul>
		<li>The setting of the geofencing is global, which takes effect for the entire tab page. That is, as long as one client has set geofencing, other clients created on the same page comply with the same setting.</li>
		<li>Agora supports specifying only one area for connection.</li>
		</ul>
	</div>

## Sample code

```javascript
var config = {
    mode: "live",
    codec: "vp8",
    // Specify the region as North America.
    areaCode: [AgoraRTC.AREAS.NORTH_AMERICA]
};
// Create a client object.
var client = AgoraRTC.createClient(config);
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist certain domains, allow all IP addresses, and open certain firewall ports according to [Firewall Requirements](firewall).