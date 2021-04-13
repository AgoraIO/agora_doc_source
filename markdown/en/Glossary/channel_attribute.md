---
title: channel attribute
platform: All Platforms
updatedAt: 2020-07-03 20:47:21
---
Channel attributes are tags added to RTM channels, including the property name, property value, the ID of the last RTM user who updated the attribute, and the time of the last update. The Agora RTM SDK supports adding, deleting, updating, and getting the channel attributes. Each property name must have only one property value. Each channel attribute can contain multiple pairs of property names and property values. For example, the following property name and property value in a channel attribute describes the title and content of a group notification:

```json
{"group_notice_title":"This is a group notice","group_notice_content":"Hello"}
```

## Related links

[Channel attribute operations](/en/Real-time-Messaging/API%20Reference/RTM_java/index.html#channelattributes)