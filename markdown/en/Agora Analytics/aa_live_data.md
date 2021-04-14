---
title: Realtime (Beta)
platform: All Platforms
updatedAt: 2020-07-06 13:53:42
---
Use the Realtime function of Agora Analytics to monitor the live status of your project. It also informs you of any abnormalities that occur along with their root cause. 

- The Live Beat page displays the live scale, quality, and any abnormalities that may occur in your project.
- Analytic diagrams display the scale, experience, and network statistics over a specified range of time.
- You can query the statistics of the past 24 hours at a maximum. The statistics are updated every minute.

> - You can also get these statistics by using [Agora Analytics RESTful API](/en/Agora%20Platform/aa_api). Contact sales-us@agora.io for details.
> - Realtime only covers statistics relating to the [Agora RTC SDK](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#rtc-sdk).

## Getting started

1. Contact sales-us@agora.io to enable the Realtime function for your project.
2. Login to [Agora Console](https://console.agora.io/) and click **Agora Analytics** on the left navigation bar.
3. Select a project in the top-left corner.
4. Click [**Live Beat**](#livebeat) under **Realtime** to view the live status of your project. Click [**Scale Overview**](#livescale), [**Experience Overview**](#livexp), or [**Network Overview**](#livenet) to view detailed live statistics and analytic diagrams.

## <a name="livebeat"></a>Live Beat

**Live Beat** displays the real-time status of your project via the **LIVE BEAT** dashboard. Click the expand button ![](https://web-cdn.agora.io/docs-files/1571712244221) at the top of the page to switch to the fullscreen view. 

Note: Only displays with a resolution of 1800 (px) or higher fully support the fullscreen view. Certain statistics may not be visible when not in fullscreen mode.

![](https://web-cdn.agora.io/docs-files/1571296191678)

### Live Scale

**Live Scale** displays minute-by-minute changes to the current channel number and current user number. 

| Metric                 | Description                                                  |
| :--------------------- | :----------------------------------------------------------- |
| Current Channel Number | A channel begins when the first user joins the channel and ends when the last user leaves that channel. |
| Current User Number    | Total number of unique UIDs.Note: If two channels have the same UID, Agora Analytics counts it as two users. |

### Live Quality

**Live Quality** displays a minute-by-minute update of the quality statistics of your project.

| Metric           | Description                                                  |
| :--------------- | :----------------------------------------------------------- |
| 5s Join Success  | Number of users who have joined a channel successfully within 5 seconds / Number of users who have tried to join. |
| Audio Smoothness | (Total audio playback duration - Total audio freeze time) / Total audio playback duration. Audio freeze time counts all the audio freezes at least 200 ms in length. |
| Video Smoothness | (Total video playback duration - Total video freeze time) / Total video playback duration. Video freeze time counts all the video freezes at least 200 ms in length. |

### Alerts

**Alerts** appears when an abnormality occurs. Abnormalities may include video freezes, audio freezes, and join-channel delays. This section reports alerts at the level of channels and hosts. The statistics are updated every minute.

Within this section, you can also view the name of the channel experiencing an abnormality, the number of affected users, the UID and the factor causing the issue.

### 3D Globe

**3D Globe** shows the status of your project with dots, beams, and wires. The statistics are updated every 10 seconds.

- A dot indicates users in the province or state. Larger dots indicate more users.
- A beam indicates the number of users in the province or state has increased within the past 10 seconds. Higher beams indicate a rapid increase in number.
- A wire indicates a connection between two provinces or states.

### Big Channel

**Big Channel** appears when a channel has over 100 users. This section provides the channel names of the big channels and their respective user number, host number, and the audience count. The statistics are updated every minute.

### User Number Ranking

When the users of a project are concentrated in one country, this section displays the top 10 provinces or states in the country that have the most users, along with their user numbers. When the users of a project are dispersed across different countries, this section displays the top 10 countries that have the most users, along with their user numbers. The statistics are updated every minute.

### High-Quality Transmission Rate

The radar chart displays the [high-quality transmission rates](#high-quality-transmission-rate) of the 6 countries, provinces, or states that have the most users. If a country, province, or state appears as concave within the radar chart, that indicates a relatively low-quality transmission rate.

When the users of a project are concentrated in one country, this section displays the top 6 provinces or states in the country that have the most users and their high-quality transmission rates. When the users of a project are dispersed across different countries, this section displays the top 6 countries that have the most users and their high-quality transmission rates.

![](https://web-cdn.agora.io/docs-files/1571296396737)

## <a name="livescale"></a>Scale Overview

Click [**Scale Overview**](#livebeat) under **Realtime** to view the live scale statistics and distribution for a specified period. The live scale statistics include the user number and the channel number.

![](https://web-cdn.agora.io/docs-files/1571712168039)

Use the timeline at the top of the page to adjust the range of time you want to view or specify whether the page should update the statistics automatically.

### <a name="timeline"></a> Timeline

![](https://web-cdn.agora.io/docs-files/1571296220700)

- Drag the round icons on the timeline to specify a period to view, or use the shortcut buttons below the timeline.

- Drag the clock icon on the timeline to specify a moment to view. Once you have dragged the icon, the **Auto Update** checkbox is deselected automatically.

- The timestamp at the bottom left of the timeline shows the current time or the selected time. If you select **Auto Update**, the timestamp indicates the current time; if you deselect **Auto Update**, the timestamp indicates the selected time.

- Click **Auto Update** at the bottom left of the timeline to enable the page to update the statistics automatically.

  

> You can select the time (UTC or your local timezone) by setting this at the top of the front page of Agora Analytics.

### Overview

**Overview** shows the real-time scale statistics on a set of cards. The left side of the card shows the current value (or the value at the specified moment) of the metric, along with the maximum, minimum, and average values of the metric. The right side of the card shows the per-minute statistics of a specified period of time through a diagram.

| Metric                 | Description                                                  |
| :--------------------- | :----------------------------------------------------------- |
| Current User Number    | If two channels have a same UID, Agora Analytics counts it as two users. |
| Current Channel Number | A channel begins when the first user joins the channel and ends when the last user leaves that channel. |
| Big Channel Number     | A channel becomes a big channel when it has 100 or more users. |

### Distribution

**Distribution** shows the distribution of users by different dimensions, along with their scale statistics at the current or specified time. If an item does not have any users, it does not appear in the panel.

| Dimension                     | Description                                                  |
| :---------------------------- | :----------------------------------------------------------- |
| Geo                           | Ranks regions by user number, and shows each region's user number along with the percentage of the overall users it contains. |
| Network Type                  | Ranks network types by user number, and shows each network type's user number along with the percentage of the overall users it contains. |
| OS                            | Ranks operating systems by user number, and shows each operating system's user number and the percentage of the overall users it contains. |
| Peak User Number in a Channel | Categorizes the channels by peak user number, and ranks the types of channels by user number. Shows the channel number and the percentage of the overall channels each type of channel has. |
| SDK Version                   | Ranks the SDK version by user number, and shows each SDK version's user number and the percentage of the overall users it contains. |

## <a name="livexp"></a>Experience Overview

**Experience Overview** shows the real-time experience statistics and distribution in a specified period of time. The real-time experience statistics include the join-channel success in 5 seconds rate, the audio freeze rate, and the video freeze rate.

Use the timeline at the top of the page to adjust the period to view, or specify whether the page should automatically update the statistics.

### Overview

**Overview** shows real-time experience statistics on a set of cards. The left side of the card shows the current value (or the value at the specified moment) of the metric, along with the maximum, minimum, and average values of the metric. The right side of the card shows the per-minute statistics of a specified period of time through a diagram.

| Metric                     | Description                                                  |
| :------------------------- | :----------------------------------------------------------- |
| Join Success in 5 sec Rate | Number of users who have joined a channel successfully within 5 seconds / Number of users who have tried to join. |
| Audio Freeze Rate          | Total audio freeze time / Total audio playback duration. Audio freeze time counts all audio freezes at least 200 ms in length. |
| Video Freeze Rate          | Total video freeze time / Total video playback duration. Video freeze time counts all video freezes at least 200 ms in length. |

### Distribution

**Distribution** shows the distribution of users by different dimensions, along with their experience statistics at either the current or specified time. If an item does not have any users, it does not appear in the panel.

| Dimension    | Description                                                  |
| :----------- | :----------------------------------------------------------- |
| Geo          | Ranks the regions by user number, and shows each region's join success in 5 sec rate along with audio and video freeze rates. |
| Network Type | Ranks the network type by user number, and shows each network type's join success in 5 sec rate along with audio and video freeze rates. |
| OS           | Ranks the operating systems by user number, and shows each operating system's join success in 5 sec rate along with audio and video freeze rates. |
| SDK Version  | Ranks the SDK version by user number, and shows each SDK version's join success in 5 sec rate and audio along with video freeze rates. |

## <a name="livenet"></a>Network Overview

**Network Overview** shows real-time network statistics and distribution in a specified period. The real-time network statistics include the upstream high-quality audio and video transmission rates along with the end-to-end high-quality audio and video transmission rates.

Use the [timeline](#timeline) at the top of the page to adjust the period to view or specify whether the page should update the statistics automatically.

### Overview

**Overview** shows the real-time scale statistics on a set of cards. The left side of the card depicts the current value (or the value at the specified moment) of the metric, along with the maximum, minimum, and average values of the metric. The right side of the card shows the per-minute statistics of a specified period of time through a diagram.



| Metric                                          | Description                                                  |
| :---------------------------------------------- | :----------------------------------------------------------- |
| High-Quality Audio Transmission Rate (Sender to Agora SD-RTN)  | The high-quality audio transmission rate from the sender to the Agora SD-RTN. High-quality audio transmission rate means the percentage of audio transmission with a ≤ 5% packet loss rate. |
| High-Quality Video Transmission Rate (Sender to Agora SD-RTN)   | The high-quality video transmission rate from the sender to the Agora SD-RTN. High-quality video transmission rate means the percentage of video transmission with a ≤ 5% packet loss rate. |
| High-Quality Audio Transmission Rate (End-to-End) | The high-quality audio transmission rate from the sender to the receiver. |
| High-Quality Video Transmission Rate (End-to-End) | The high-quality video transmission rate from the sender to the receiver. |


### Distribution

**Distribution** shows the distribution of users by different dimensions, along with their network statistics at the current or specified time. If an item does not have any users, it does not appear in the panel.

The first diagram ranks the regions by user number, and shows the upstream high-quality transmission rate of each region.

The second diagram shows the end-to-end high-quality transmission rate between regions. For example, in the diagram below, the statistic in the red box indicates that the end-to-end high-quality transmission rate from Jiangsu to Liaoning is 100%.

![](https://web-cdn.agora.io/docs-files/1571296237075)

## Key terms

This section describes the key terms used in Realtime. See [Agora Key Terms](https://docs.agora.io/en/Agora%20Platform/terms) for more information.

### Channel

Every call or live broadcast happens in a channel. If we imagine an app being a building, a channel will be a room in the building.

**Realtime** does not count a channel by name, but by lifecycle. It counts each time from when the first users joins the channel to when the last user leaves it.

### User

Each user in the channel has a unique [username](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%%20Platforms#a-nameusernameausername).

**Realtime** counts a unique username in a unique channel as one user. If a real-life user joins one channel with multiple, different usernames, or joins different channels with one username, **Realtime** counts users in both situations as multiple users.

### <a name="high-quality-transmission-rate"></a>High-Quality Transmission Rate

High-quality audio transmission rate is the percentage of audio transmission with a ≤ 5% packet loss rate. High-quality video transmission rate is the percentage of video transmission with a ≤ 5% packet loss rate.