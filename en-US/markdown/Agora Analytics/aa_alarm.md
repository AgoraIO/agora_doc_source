## Overview

Alert Notification sends alerts to you when abnormal metrics or events are detected in your Agora RTC projects. You can receive the alerts through e-mails or API callbacks and take action accordingly.

Alert Notification provides the following features:

- Predefined metrics that allow for easy alert creation.
- Support for sending alerts to multiple contacts through multiple channels.
- Automatic storage of the alert records for the last 7 days.
- Data synchronization with [Call Search](./aa_call_search) and [Data Insight](./aa_data_insight), so that you can easily dive into problem analysis.

## Getting started

To access the Alert Notification page, do the following:

1. Purchase the [support package](https://console.agora.io/support/plan) or contact [support@agora.io](mailto:support@agora.io) to enable the **Alert Notification** service.
2. Log in to [Agora Console](https://console.agora.io/), and click **Agora Analytics** > **Alert Notification** on the left navigation bar.

## Alert rules

An alert rule consists of three parts: associated product, rule settings, and notification type.

This section introduces how to create, enable, edit, and delete an alert rule. It also provides parameter descriptions for alert callbacks.

### Create an alert rule

To create an alert rule, do the following:

1. On the top of the page, click **Alert rules**.
2. In the upper-left corner, select a project from the dropdown menu.
3. In the upper-right corner, click the **Create a rule** button, and fill in the following information in the pop-up window:

[screenshot placeholder]

| Item                  | Description                                                  | Limitations                                                  |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Associated project    | The project to which the rule applies.                       | Each individual rule can only be associated with one project. |
| Rule name             | A name for the rule.                                         | Rules associated with the same project must have unique names. |
| Alert type            | Choose one of the following: <li>Metric alert: Sends an alert when a metric value is higher or lower than the threshold value.</li><li>Event alert: Sends an alert when a predefined event occurs.</li> | /                                                            |
| Alert granularity     | Choose one of the following: <li>Channel: Sends an alert when a channel encounters abnormalities. </li><li>User: Sends an alert when a user encounters abnormalities. </li> | **User** is the only option for event alerts.                |
| Rule description      | The conditions that must be met to trigger an alert.<br>For instance, the combination of **Audio Freeze Rate**, **20s Cycle**, **Lasts for 2 cycles**, **>=**, and **10%** indicates: The audio freeze rate is calculated every 20 seconds; if the calculated value equals or exceeds 10% for two continuous 20-second cycles, the alert is triggered.<br>To monitor multiple metrics or events, add additional rule descriptions. You can set the operator between different rule descriptions as "AND" or "OR". | The maximum number of rule descriptions per rule is 20.      |
| Silent period         | The time period after an alert during which the alert is not triggered even if the same alert rule is met again. In this case, "the same alert rule" means that both the alert granularity and the applicable rule description are identical. | /                                                            |
| Effective period      | The time period during which the alert can be triggered.     | /                                                            |
| Scope                 | Choose one of the following:<li>**All users** or **All channels**.</li><li>Name list: A custom list of user names or channel names. Separate list entries with hard line breaks.</li><li>Regular expression: A string search pattern. For example, "aa.\*" would apply to every channel whose name starts with "aa".</li> | /                                                            |
| Set advanced filters  | Predefined filters that help increase the precision of alerts. Click the button to edit or disable the default settings. | /                                                            |
| Alert level           | Choose one of the following:  <li>Critical<li>Warning<li>Info | /                                                            |
| Notification type     | Choose one or both:  <li>Email: Sends alerts to the email addresses of the specified contacts.</li><li>WeCom bot: Sends alerts to a WeCom group.</li> | A maximum of 500 alert emails can be sent per account per day. The number of emails is calculated based on the total recipients. For example, if two contacts are set to receive alert emails and the rule is triggered 20 times during the day, Agora counts the number of sent emails as 40. |
| Email note            | The message contained in emails of alert notifications.      | Notification type must be **Email** for this item to appear. |
| WeCom bot webhooks    | The webhook URL for the WeCom bot.                           | Notification type must be **WeCom bot** for this item to appear. |
| Alert contacts        | Email addresses set to receive alerts.                       | The maximum number of alert contacts per rule is five.       |
| Notification language | The language of the alert notification.                      | /                                                            |
| Timezone              | The timezone displayed in the alert notification.            | /                                                            |
| Alert callbacks       | A publicly accessible URL that receives HTTP requests. You can take further action according to the alert information in these requests. See [Alert callback parameters](#). | See [Alert callback parameters](#).                          |

### Enable an alert rule

A newly created alert rule is disabled by default. To enable a rule, do the following:

1. On the top of the page, click **Alert rules**.
2. Find the rule you want to enable, click **Enabled** in the **Operation** column, and click **OK** in the pop-up window.

To enable a group of rules all at once, check the box next to the name of each rule, and click **Enabled**.

### Edit an alert rule

To edit a rule, do the following:

1. On the top of the page, click **Alert rules**.

2. Find the rule you want to edit, and click **Edit** in the **Operation** column.

   If you did not create this rule, a pop-up window appears. Read the text, and click **OK**.

3. Make your changes, and click **OK**.

### Delete an alert rule

To delete a rule, do the following:

1. On the top of the page, click **Alert rules**.
2. Find the rule you want to delete, and click **Delete** in the **Operation** column.
3. Read the text in the pop-up window, and click **OK**.

To delete a group of rules all at once, check the box next to the name of each rule, and then click **Delete**.

### Alert callback parameters

If you create an alert callback for an alert rule, Agora sends requests to the URL you provide when the rule is triggered. Currently, the alert callback function has the following limitations:

- No authentication mechanism is supported, including HTTP authentication.
- If a request fails, Agora resends the request up to a maximum of two times. The timeout period for each request is two seconds.
- Agora sends a request whenever the alert rule is triggered.
- The outbound IP address of the alert callback API may change. You can do one of the following:
  - (Recommended) Open port 80 for your security group.
  - If opening port 80 is not an available option to you, contact Agora to get the outbound IP address. Note that when Agora changes the IP address, you need to make changes accordingly.

Alert information is sent to you through HTTP POST methods in JSON format. The following sections provide parameter descriptions and request examples for your reference.

**Metric alert**

If the alert granularity is set as **Channel**：

```json
{
"alertTime":"1631703720000", // The timestamp (seconds) when the alert is sent
"timeZone":"UTC+8", // The timezone you set for the rule
"projectName":"XlaTest", // Your Agora project name
"cname":"d13bd8305da84578a45452a7e2e37f02", // The channel name
"enContent":"video freeze rate≥85%", // Alert information（"cnContent" means Chinese, and "enContent" means English）
"currentUserNum":"2", // The number of users in the channel
"currentHostNum":"1", // The number of hosts in the channel
"callId":"6141d1efc3421ca63b6470e5", // The call ID
"url":"https://console.agora.io/analytics/call/qoe?id=6141d1efc3421ca63b6470e5" // The corresponding Call Search page
"remark":"Video freeze" // The email note you set for the rule
}
```

If the alert granularity is set as **User**：

```json
{
"alertTime":"1631780400000", // The timestamp (seconds) when the alert is sent
"timeZone":"UTC+8", // The timezone you set for the rule
"projectName":"XlaTest", // Your Agora project name
"cname":"97c1bb03586945c2a5c9e4ec66ee79e1", // The channel name
"uid":"957288696", // The user ID
"enContent":"video freeze rate≥10%", // Alert information（"cnContent" means Chinese, and "enContent" means English）
"currentUserNum":"2", // The number of users in the channel
"currentHostNum":"2", // The number of hosts in the channel
"callId":"6142fe37bd1791b232cbb90e", // The call ID
"url":"https://console.agora.io/analytics/call/qoe?id=6142fe37bd1791b232cbb90e" // The corresponding Call Search page
"remark":"Video freeze" // The email note you set for the rule
}
```

**Event alert**

```json
{
  "alertTime":"1631785450000",  // The timestamp (seconds) when the alert is sent
  "timeZone":"UTC+8", // The timezone you set for the rule
  "projectName":"Premium-broadcasting", // Your Agora project name
  "cname":"tm_913_cname", // The channel name
  "uid":"67891", // The user ID
  "enContent":"no frame sending,no voice sending,no voice receiving,wifi congestion,system CPU utility too high",  // Alert information（"cnContent" means Chinese, and "enContent" means English）
  "currentUserNum":"100", // The number of users in the channel
  "currentHostNum":"1", // The number of hosts in the channel
  "callId":"6136b9fcb145efc91f4248f5", // The call ID
 "url":"https://console.agora.io/analytics/call/qoe?id=6136b9fcb145efc91f4248f5", // The corresponding Call Search page
  "remark":"Abnormal events" // The email note you set for the rule
}
```

## Alert contacts

**Alert contacts** lists the contacts you have created for all alert rules. For an individual alert rule, only the contacts you add for the rule receive notifications when the rule is triggered.

This section introduces how to create, edit, and delete a contact.

### Create a contact

To create a contact, do the following: 

1. On the top of the page, click **Alert contacts**.
2. In the upper-right corner, click **Create a contact**.
3. Enter the contact's name and email address, and click **Get the verification code**.
4. Enter your verification code, and click **OK**.

Note the following limitations when creating a contact:

- Each email address can only be used to create one contact.
- An email address can request a verification code a maximum of five times per day.

### Edit a contact

To edit a contact, do the following: 

1. On the top of the page, click **Alert contacts**.
2. Find the contact, and click **Edit** below in the **Operation** column.
3. Make your changes in the pop-up window, and click **OK**.

### Delete a contact

To delete a contact, do the following: 

1. On the top of the page, click **Alert contacts**.
2. Find the contact, and click **Delete** in the **Operation** column.
3. Read the text in the pop-up window, and click **OK**.

To delete a group of contacts all at once, check the box next to the name of each contact, and then click **Delete**.

## Alert records

Records of your alert notifications are saved for seven days.

This section introduces how to view and manage alert records.

### View alert records

To view your alert records, do the following: 

1. On the top of the page, click **Alert records**.
2. (Optional) Apply the following filters:
   - Project filter: Select a project from the dropdown menu in the upper-left corner.
   - Time filter: Select a start date and end data on the top.
   - Filter for alert granularity, alert level, or status: Click the corresponding funnel icon in the header row.

### Manage alert records

To manage an alert record, do the following: 

1. On the top of the page, click **Alert records**.
2. Find the record, and click the dropdown menu in the **Status** column:
   - If you have resolved the issue, select **Resolved**.

   - If the issue does not require action, select **Ignored**.
4. (Optional) To further analyze an alert record, click **Call details** to use the [Call Search](./aa_call_search) service.
5. (Optional) To adjust the rule corresponding to an alert record, click **Edit Alert Rule**, and make changes in the pop-up window.

To manage a group of alert records all at once, check the box in the first column for each record and click **Mark as resolved**, **Mark as ignored**, or **Delete**.
