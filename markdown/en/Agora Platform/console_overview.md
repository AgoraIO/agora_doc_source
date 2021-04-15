---
title: Console Overview
platform: All Platforms
updatedAt: 2020-07-16 21:50:29
---
Agora Dashboard allows you to check your usage and the QoE, add money to your account, manage your projects and team members, and connect with Agora customer support.

Before using Agora Dashboard, [create an Agora account](./sign_in_and_sign_up) at [www.agora.io](https://www.agora.io/en/).

## Introduction

<table>
<tr>
<th>Function</th>
<th>Description</th>
</tr>
<tr>
<td>Check your usage</td>
<td>Check the usage of your voice and video calls in a channel during a specific time frame to calculate your charges.</td>
</tr>
<tr>
<td>Check the QoE</td>
<td>Check the performance of Agora's products from diagrams associated with your project to quickly identify problems.</td>
</tr>
<tr>
<td>Add money to your account</td>
<td>Add money to your balance using Alipay, check your balance and view your transaction history.</td>
</tr>
<tr>
<td>Manage projects</td>
<td>Create and manage projects, and get the App ID and App Certificate.</td>
</tr>
<tr>
<td>Manage team members</td>
<td>Add and manage team members, and set the permissions for different roles.</td>
</tr>
<tr>
<td>Submit and track tickets</td>
<td>Search for solutions to problems or submit tickets to Agora customer support.</td>
</tr>
<tr>
<td>Use RESTful APIs</td>
<td>Use RESTful APIs to ban users, check the usage, and inquire about online statistics at the server.</td>
</tr>
<tr>
<td>Other functions</td>
<td>Change the profile information and account settings, and connect with developer communities.</td>
</tr>
</table>

## Overview

![](https://web-cdn.agora.io/docs-files/1551353882782)

The **Overview** page provides entrypoints to commonly-used Dashboard features. On this page, you can:

- View project usage.
- View account balance and transactions, and add money your account.
- Learn about Agora products, SDKs, code samples and API reference.
- Learn to integrate Agora products.
- View call quality.

## Check your usage and the QoE

Click on ![](https://web-cdn.agora.io/docs-files/1551260936285) in the left navigation menu to go to the **Usage & Stats** page. Select a project, and then you can check the usage of your voice & video calls and recording, and analyze the QoE during a specific time frame. 

#### Check the usage of voice & video calls

![](https://web-cdn.agora.io/docs-files/1551354077719)

Click on the following icons to check the usage of your voice & video calls during a specific time frame. You can calculate your charges based on the usage<sup>[1]</sup>.

- **Duration**: Check the duration (minutes) of the voice & video calls for both [hosts](/cn/Agora%20Platform/terms#host) and [audience](/cn/Agora%20Platform/terms#audience) during a specific time frame.
- **Bandwidth**: Check the peak bandwidth of both [hosts](/cn/Agora%20Platform/terms#host) and [audience](/cn/Agora%20Platform/terms#audience) during a specific time frame.
- **Transcoding**: Check the duration (minutes) of the voice and video (SD, HD, and HDP<sup>[2]</sup>) calls during a specific time frame.
- **Mini App**: Check the duration (minutes) of the voice & video calls made on Mini Apps during a specific time frame.

> [1] See [Pricing and Billing](https://docs.agora.io/en/Agora%20Platform/billing_faq).
>
> [2] Video Quality Types
>
> | SD | Resolution < 360p              |
> |------|----------------------------------|
> | HD | 360p ≤ Resolution ≤ 720p |
> | HDP | Resolution > 720p             |

#### Check the QoE of voice & video calls

Click on **Agora Analytics > Call Search** in the left navigation menu to go to **QoE Page**.

Select a **Project** and **Time Frame**, and enter a **Channel Name** or **UID** to check the QoE. For more information, see [Agora Analytics Tutorial](/en/Agora%20Platform/aa_guide).

#### Check the usage of recording

Click on the **Recording** button in the left navigation menu to check the duration (minutes) of recording files during a specific time frame.

## Manage projects

Click on ![](https://web-cdn.agora.io/docs-files/1551254998344) **Project** in the left navigation menu to manage projects.

![](https://web-cdn.agora.io/docs-files/1551257409179)

You can: 

- Click on **Create** to create a new project, get an app ID and enable a app certificate. For details, see [User Security Keys](/en/Interactive%20Broadcast/token).
- Enter a project name or app ID in the input box and click on ![](https://web-cdn.agora.io/docs-files/1551255111208) to search for projects.
- Click on ![](https://web-cdn.agora.io/docs-files/1551255135678)to edit the project information.
- Click on ![](https://web-cdn.agora.io/docs-files/1551255151708)to view the project usage.
- View the project states according to the icons ![](https://web-cdn.agora.io/docs-files/1551255188685) and ![](https://web-cdn.agora.io/docs-files/1551255166718).

## Manage members

Click on ![](https://web-cdn.agora.io/docs-files/1551255228096) **Member** in the left navigation menu to manage team members.

![](https://web-cdn.agora.io/docs-files/1551257470398)

You can:

- Click on **Add** to add a new team member and set the role permissions. The invitee will receive an email invitation.
- Click on ![](https://web-cdn.agora.io/docs-files/1551255422216)to reset the role and permissions of a team member.
- Click on ![](https://web-cdn.agora.io/docs-files/1551255494008) to allow a team member to reset the password. The team member will receive an email to reset the password.
- Click on ![](https://web-cdn.agora.io/docs-files/1551255516590) to remove a team member from your project.

### Role permissions

Different roles have different permissions:

- **Administrator** can view the usage, Agora Analytics, finance center, and manage the projects and members.
- **Finance** can only view the finance center.
- **Product Manager** and **Operation Manager** can only view the usage.
- **Customer Support** and **Maintenance Manager** can only view Agora Analytics.
- **Engineer** can only manage the projects.

You can also create custom roles under **Customized**.



## Submit and Track a Ticket

If you have any questions about Agora's products, you can: 

1. Click on **Support > Submit Ticket** in the top navigation menu to go to **Agora Customer Service Center**.
2. Type in your question or keywords to see if the question has been answered.
3. If you cannot find your answer, select a category and submit a ticket to Agora customer support.
4. Click on **Support > View Ticket** to track the status of your ticket.

## Use RESTful APIs

Agora Dashboard provides RESTful APIs for you to ban users, check your usage, and inquire about online statistics at the server. 

Click on **User Name > RESTful API** in the top navigation menu to get the Customer ID and Customer Certificate for the RESTful API. See [RESTful API](./dashboard_restful_live).

## Other Functions

### Change the Profile Information and Account Settings

By clicking on **User Name** in the top navigation menu, you can:
* Modify personal information;
* Change the password;
* And change the language of the Dashboard and Agora newsletter.

### Reach out to Developer Communities

Click on **Community** in the top navigation menu to connect with global developers in developer communities such as Github, online forums, and WeChat public accounts.