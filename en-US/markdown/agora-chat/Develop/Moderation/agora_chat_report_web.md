The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console and process the messages and message senders according to their content policy.

## Understand the tech

Call `reportMessage` provided by the Agora Chat Web SDK to implement the reporting feature.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](/en/agora-chat/agora_chat_get_started_web).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](/en/agora-chat/agora_chat_limitation_web).
- You have enabled the message reporting feature on Agora Console. For details, see [Content Moderation Overview](/en/agora-chat/agora_chat_moderation_overview).

## Implementation

The following code sample shows how to call the reporting API:

```javascript
connection.reportMessage({
    reportType: 'report type';
        reportReason: 'report reason';
        messageId: 'ID of the reported message';
})
```