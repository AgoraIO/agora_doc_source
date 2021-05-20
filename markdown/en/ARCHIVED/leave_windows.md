---
title: Leave the Channel
platform: Windows
updatedAt: 2019-10-30 11:24:11
---
When a call or live broadcast ends, use the Agora SDK to leave the channel.

## Implementation

When a call or live broadcast ends, call the <code>leaveChannel</code> method to leave the channel.

The <code>leaveChannel</code> method releases all resources related to the call or live broadcast. When the user leaves the channel, the SDK triggers the <code>onleaveChannel</code> callback.

```
int nRet = m_lpAgoraEngine->leaveChannel();
```

> If the <code>leaveChannel</code> method is called immediately after the <code>release</code> method, the process will be interrupted, and the SDK will not trigger the <code>onleaveChannel</code> callback.


## Next Steps
You have now integrated basic communication or live broadcast into your app. For advanced functions, see the sections under **Advanced Guide**.

If you encounter any problem integrating or using the Agora SDK, refer to the following sections or submit a ticket at [Agora Dashboard](https://dashboard.agora.io).

- [General Asked Questions](/en/Agora%20Platform/general_questions#general-questions)
- [Integration and Deployment](/en/Agora%20Platform/general_questions#intergration-and-deployment)
- [Troubleshooting](/en/Agora%20Platform/general_questions#troubleshooting)