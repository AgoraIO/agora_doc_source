---
title: Geofencing
platform: Windows
updatedAt: 2020-12-07 07:10:17
---
## Description

To meet the laws and regulations of different countries or regions, the Agora RTM SDK supports geofencing. You can limit the data transmission of the RTM SDK to a specific region. After enabling geofencing, the RTM SDK only connects to Agora RTM servers within the specified region.


<div class="alert note">To set the region as India, you must send the request from an IP address in India. Otherwise, your request fails.</div>

## Implementation

You need to call `setRtmServiceContext` before calling `createRtmService` to initialize the RTM client. The RTM SDK supports the following regions:

- `AREA_CODE_GLOB`: (Default) Global.
- `AREA_CODE_CN`: Mainland China.
- `AREA_CODE_NA`: North America.
- `AREA_CODE_EU`: Europe.
- `AREA_CODE_AS`: Asia excluding mainland China.
- `AREA_CODE_JP`: Japan.
- `AREA_CODE_IN`: India.

### Sample code

```C++
// Set region for geofencing
agora::rtm::RtmServiceContext rtmContext;
rtmContext.areaCode = agora::rtm::AREA_CODE_CN | agora::rtm::AREA_CODE_AS;
agora::rtm::SET_RTM_SERVICE_CONTEXT_ERR_CODE errorCode = setRtmServiceContext(rtmContext);
```

##  Considerations

### Firewall requirements

If a firewall is deployed in your network environment, ensure that you add the domains in the following table according to the region you specify, allow all IP addresses, and open the following firewall ports.

- Whitelist domains

| Region                        | Domain                                                       |
| :---------------------------- | :----------------------------------------------------------- |
| Mainland China                | `ap.agoraio.cn` <br> `report-edge.agoraio.cn` <br> `service-agoraio.cn`  |
| North America                 | `ap-america.agora.io` <br> `report-america.agora.io` <br> `service-america.agora.io` |
| Europe                        | `ap-europe.agora.io` <br> `report-europe.agora.io` <br> `service-europe.agora.io` |
| Japan                         | `ap-japan.agora.io` <br> `report-japan.agora.io` <br> `service-japan.agora.io` |
| India                         | `ap-india.agora.io` <br> `report-india.agora.io` <br> `service-india.agora.io` |
| Asia excluding mainland China | `ap-asia.agora.io` <br> `report-asia.agora.io` <br> `service-asia.agora.io` |

- Port

| Port              | Protocol | Operation |
| :---------------- | :------- | :-------- |
| 9130; 9131; 9140  | TCP      | Allow     |
| 1080; 8000; 8130;  9120; 9121; 9700; 25000 | UDP      | Allow     |

## API reference

[`setRtmServiceContext`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/group__get_rtm_sdk_version.html#ga55ed2d637b72bf2940872b8736a00bd3)
