# Implement the Reporting Feature

The Agora Chat SDK provides a message reporting API, which allows end-users to report objectionable messages directly from their applications. After the Agora Chat server receives the report, it stores the report and displays it on Agora Console. Moderators can view the report items on the Agora Console, and process the messages and message senders according to their content policy.

## Understand the tech

Call `reportMessage` provied by the Agora Chat Android SDK to implement the reporting feature.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](https://docs-preprod.agora.io/en/agora-chat/agora_chat_get_started_android).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation_android).

- You have enabled the message reporting feature on Agora Console. For details, see [Content Moderation]().

## Implementation

The following code snippet shows how to call the reporting API:

```java
EMClient.getInstance().chatManager().asyncReportMessage(msgid, label, reason, new EMCallBack() {
        @Override
        public void onSuccess() {

                }
        @Override
        public void onError(int code, String error) {

                }
        @Override
        public void onProgress(int progress, String status) {

                }
    });
```
