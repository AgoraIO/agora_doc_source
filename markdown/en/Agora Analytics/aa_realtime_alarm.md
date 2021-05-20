---
title: Real-time Alarm (Beta)
platform: All Platforms
updatedAt: 2020-09-18 17:36:12
---
The **Real-time Alarm** function of Agora Analytics enables you to view [users](#User) who have [poor communication experiences](#Abnormal), recognize abnormal categories and quality factors.

<div class="alert info">Statistics are updated every minute. You can query the statistics for the past 24 hours at maximum.</div>

## Getting started

1. Contact [sales-us@agora.io](mailto:sales-us@agora.io) to enable the **Real-time Alarm** function for your project.
2. Log in to [Agora Console](https://console.agora.io/). Click **Agora Analytics** on the left navigation bar.
3. Select a project in the top-left corner.
4. Click **Auto Diagnosis** and **Real-time Alarm** to view and analyze users having poor communication experiences.

## Timeline

![](https://web-cdn.agora.io/docs-files/1586938329206)

- Specify a time frame: The default time frame is the past four hours. Drag the round icons on the timeline to specify a period to view, or use the shortcut buttons below the timeline.
- Specify a moment: Drag the clock icon on the timeline to specify a moment to view. 
  - Once you have dragged the icon, the Auto Update checkbox is deselected automatically.
  - If you drag the clock icon out of the specified time frame, the specified time frame extends following the clock icon.
- Auto Update: Click **Auto Update** at the bottom left of the timeline to enable the page to update the statistics automatically.

<div class="alert info">You can set the time to your local timezone or UTC by setting it from the top of the front page in Agora Analytics.</div>

## Overview

Overview displays the real-time statistics of users experiencing poor communication experiences in a card view. The left side of the card shows the current value (or the value at the specified moment) of the metric, along with the ratio, maximum, average, and minimum values for that metric. The right side shows the per-minute statistics for a specified time frame as a line chart.

![](https://web-cdn.agora.io/docs-files/1586938380827)

| Metric                          | Description                                                  |
| :------------------------------ | :----------------------------------------------------------- |
| Users experiencing join delay   | Users who successfully join a channel but experience a delay. The ratio is the number of users experiencing channel-join delay against the total number of users who apply to join a channel. |
| Users experiencing audio freeze | Users who experience an audio freeze during the call. The ratio is the number of users experiencing audio freezes against the total number of users in the channel. |
| Users experiencing video freeze | Users who experience a video freeze during the call. The ratio is the number of users experiencing video freezes against the total number of users in the channel. |

## Distribution

Distribution displays the distribution of communication quality factors, along with the associated scale statistics for the specified time frame. Click **All** to expand the drop-down menu, and choose an abnormal category to view the distribution of corresponding quality factors and affected users. For a description of quality factors, see [Factor ID](https://docs.agora.io/en/Agora%20Platform/aa_api?platform=All%20Platforms#a-namefactor_idafactor-id).

![](https://web-cdn.agora.io/docs-files/1586938403450)

## Details

Details displays the statistics of users having poor communication experiences, including the following information:

- Channel name
- User ID
- Abnormal sections
- Abnormal categories
- Issue descriptions
- Issue sources
- Quality factors

**Search**

- Enter the channel name to search the statistics of all users who have poor communication experiences in the specified channel.
- Enter the user ID to search the statistics of the specified user who has a poor communication experience.

**Query time**

Details displays the statistics of the specified time frame by default. To view the statistics of the current time (or the specified moment), click **Within selected moment** at the top right of the list. 

**Download**

Click **Download** to download the statistics. You can download a maximum of 1,000 items.

**Operation**

Under **Operation**, click **Details** to view all call statistics of a specific user. For details, see [Call Search](aa_call_search).

<div class="alert info">You can view or download a maximum of 1,000 items.</div>

| Metric              | Description                                                  |
| :------------------ | :----------------------------------------------------------- |
| Abnormal Sections   | The sections when users have poor user experiences, such as joining a channel and during the call. |
| Abnormal Categories | The categories of abnormal issues users encounter, such as delay, freeze and crash. |
| Issue Descriptions  | The detailed descriptions of all abnormal issues, such as channel-join delay, video freeze and black screen. |
| Issue Sources       | The user causing the poor communication experience, such as the local user or the remote users. |
| Quality Factors     | The factors causing the poor communication experiences. See [Factor ID](https://docs.agora.io/en/Agora%20Platform/aa_api?platform=All%20Platforms#a-namefactor_idafactor-id) for more information. |

## Key terms

This section describes the key terms used in Real-time Alarm. See [Glossary](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms) for more information.

<a name="Channel"></a>
### Channel

Every call or live broadcast occurs in a channel. If you imagine an app as a building, a channel is a room in the building.

Real-time Alarm does not count a channel by name, but by lifecycle. It counts a channel each time from the first user joining it to the last user leaving it.

<a name="User"></a>
### User

Each user in the channel has a unique [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#username).

Real-time Alarm counts a unique username in a unique channel as one user. If a real-life user joins one channel with multiple, different usernames, or joins different channels with one username, Real-time Alarm counts users in both situations as multiple users.

<a name="Abnormal"></a>
### Poor communication experience

During a call, users may experience quality issues, such as audio freeze or video freeze, caused by various factors. Agora calls this as a poor communication experience. See [Experience ID](https://docs.agora.io/en/Agora%20Platform/aa_api?platform=All%20Platforms#a-nameexp_idaexperience-id) for more information.