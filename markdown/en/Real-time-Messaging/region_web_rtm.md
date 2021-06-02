---
title: Geofencing
platform: Web
updatedAt: 2020-12-07 07:10:01
---
## Description

To meet the laws and regulations of different countries or regions, the Agora RTM SDK supports geofencing. You can limit the data transmission of the RTM SDK to a specific region. After enabling geofencing, the RTM SDK only connects to Agora RTM servers within the specified region.

<div class="alert note">To set the region as India, you must send the request from an IP address in India. Otherwise, your request fails.</div>

## Implementation

You need to use the `areaCodes` parameter when calling `createInstance` to set the region. The RTM SDK supports the following regions:

- `GLOB`: (Default) Global.
- `CN`: Mainland China.
- `NA`: North America.
- `EU`: Europe.
- `AS`: Asia excluding mainland China.
- `JP`: Japan.
- `IN`: India.

### Sample code

```javascript
// Set region for geofencing
AgoraRTM.createInstance('<appid>', { areaCodes: ["CN","GLOB"] })；
```

##  Considerations

### Firewall requirements


If a firewall is deployed in your network environment, ensure that you add the domains in the following table according to the region you specify, allow all IP addresses, and open the following firewall ports.

- Whitelist domains

| Region                   | Domain                                                    |
| :--------------------- | :----------------------------------------------------------- |
| Mainland China               | `webrtc2-ap-web-2.agoraio.cn` <br> `webrtc2-ap-web-4.agoraio.cn` <br> `statscollector-3.agoraio.cn` <br> `statscollector-4.agoraio.cn` <br> `logservice-china.agora.io` |
| North America               | `ap-web-1-north-america.agora.io` <br> `ap-web-2-north-america.agora.io` <br> `statscollector-1-north-america.agora.io` <br> `statscollector-2-north-america.agora.io`  <br>`logservice-north-america.agora.io` |
| Europe               | `ap-web-1-europe.agora.io`<br>`ap-web-2-europe.agora.io`<br>`statscollector-1-europe.agora.io`  <br> `statscollector-2-europe.agora.io` <br> `logservice-europe.agora.io` |
| Japan                  | `ap-web-1-japan.agora.io`<br>`ap-web-2-japan.agora.io`<br>`statscollector-1-japan.agora.io`<br>`statscollector-2-japan.agora.io`<br>`logservice-japan.agora.io` |
| India                   | `ap-web-1-india.agora.io`<br>`ap-web-2-india.agora.io`<br>`statscollector-1-india.agora.io`<br>`statscollector-2-india.agora.io`<br>`logservice-india.agora.io` |
| Asia excluding mainland China | `ap-web-1-asia.agora.io`<br>`ap-web-2-asia.agora.io`<br>`statscollector-1-asia.agora.io`<br>`statscollector-2-asia.agora.io`<br>`logservice-asia.agora.io` |

- Port

| Port            | Protocol | Operation |
| :---------------- | :--- | :--- |
| 443；9591；9593；9601; 6443  | TCP  | Allow |

## API reference

[`createInstance`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)