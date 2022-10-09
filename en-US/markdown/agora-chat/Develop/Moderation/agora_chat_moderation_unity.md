The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console and process the messages and message senders according to their content policy.

## Understand the tech
Call `ReportMessage` provided by the Agora Chat Android SDK to implement the reporting feature.

## Prerequisites

- You have created a valid [Agora developer account](/en/Agora%20Platform/get_appid_token?platform=All%20Platforms#create-an-agora-account).
- Moderation is not enabled by default. To use this feature, you need to subscribe to the **Pro** or **Enterprise** [pricing plan](./agora_chat_plan) and enable it in [Agora Console](https://console.agora.io/).

## Implementation

The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console and process the messages and message senders according to their content policy.

To use the reporting feature, refer to the following code sample to call the reporting API:

```c#
SDKClient.Instance.ChatManager.ReportMessage(msgId, tag, reason, new CallBack(
    onSuccess: () =>
    {
        Debug.Log($"ReportMessage success.");
    },
    onError: (code, desc) =>
    {
        Debug.Log($"ReportMessage failed, code:{code}, desc:{desc}");
    }
));
```