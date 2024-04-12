The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console and process the messages and message senders according to their content policy.

## Understand the tech
Call `ReportMessage` provided by the Agora Chat Android SDK to implement the reporting feature.

## Prerequisites

- Your project integrates a version of the Agora Chat SDK later than v1.0.6 and has implemented the basic [real-time chat functionalities](../Unity/quick_start_windows.md).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Windows).

## Implementation

The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console and process the messages and message senders according to their content policy.

To use the reporting feature, refer to the following code sample to call the reporting API:

```c#
// msgId: The ID of the message to report.
// tag: The label of the illegal message. You need to add custom labels, like, pornography or advertising. It corresponds to the `Label` field on the `Message Report` page on the Agora Console.
// reason: The reason for reporting the message. It cannot exceed 512 bytes. It corresponds to the `Reason` field on the Message Report page on the Agora Console. 
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