---
title: Network Geofencing
platform: Web
updatedAt: 2021-02-25 08:30:12
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./region_web_rtc?platform=Web">Network Geofencing</a>.</li></div>

## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

You can call `AgoraRTC.setArea` to specify the region for connection. By default, the SDK connects to nearby Agora servers. After specifying the region, the SDK connects to the Agora servers within that region. The supported regions include:

- `ASIA`: Asia, excluding Mainland China
- `CHINA`: China
- `EUROPE`: Europe
- `GLOBAL`: Global
- `INDIA`: India
- `JAPAN`: Japan
- `NORTH_AMERICA`: North America

<div class="alert info">The SDK supports specifying only one region.</div>

## Sample code
```
AgoraRTC.setArea("NORTH_AMERICA");
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist certain domains, allow all IP addresses, and open certain firewall ports according to [Firewall Requirements](firewall).