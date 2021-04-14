---
title: Big Channel (Beta)
platform: All Platforms
updatedAt: 2020-09-11 17:50:38
---
The **[Big Channel](#BigChannel)** function of Agora Analytics enables you to view and analyze the real-time usage and quality of Big Channels, to help you improve the efficiency of activities in Big Channels.

Big Channel provides the following information:

- The number of [users](#User), [hosts](#Host), or [audience](#Audience) members.
- The number of users with [poor user experience](#Abnormal).
- The geographical distribution of the audience.
- The distribution of operating systems used by the audience.
- The distribution of SDK versions used by the audience.
- The distribution of quality factors causing the bad user experience of the audience.

> A channel with many online users is called a Big Channel. Define your Big Channels in the Big Channel Config page, see details in [Big Channel Config](aa_big_channel_config).

## Getting started

1. Contact [sales-us@agora.io](mailto:sales-us@agora.io) to enable the Big Channel feature for your project.
2. Log in to [Agora Console](https://console.agora.io/) and click Agora Analytics on the left navigation bar.
3. Select a project in the top-left corner.
  ![](https://web-cdn.agora.io/docs-files/1580097344188)
4. Click **Investigation Tool** > **Big Channel Config** to configure a Big Channel. For details, see [Big Channel Config](aa_big_channel_config).
5. Click **Investigation Tool** > **Big Channel** to view and analyze the real-time usage and quality of Big Channels.

> By default, Big Channel uses UTC. To change UTC to your local time zone, click ![](https://web-cdn.agora.io/docs-files/1545894297187) on the top menu bar.

## Find a Big Channel

On the **Big Channel** page, you can find a Big Channel by searching for it by name, selecting the [call](#Call) status, or specifying the time range.

![](https://web-cdn.agora.io/docs-files/1580097412621)

- Search: Enter the channel name to find, and the major channels that meet the search criteria will be displayed.
- Select the call status: By default, Agora Analytics shows all Big Channels for your project. Click **Ongoing** to view active Big Channels, or **Ended** to see those that have concluded.
- Specify the time range for the query: By default, Agora Analytics shows the Big Channel which has a call within 24 hours.
  - Click **Past 1hr/4hrs/24hrs** to view the Big Channel which has a call within 1 hour, 4 hours, or 24 hours.
  - Click the time table to specify the time range for the query.

<div class="alert note">Currently, you can view the Big Channels which has a call within 14 days. The time range for each query should not exceed 24 hours.</div>

## View Big Channel list

In the Big Channel list, you can view the basic information of Big Channels, such as the channel name, the number of online users, the peak number of online users, the rating and the call duration. If you check **Auto Update** at the top-right corner, the Big Channel list updates once per minute.

| Metric        | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| Channel Name  | The name of the Big Channel.                                 |
| Rating        | The score of the Big Channel, where the maximum value is 5. Agora Analytics calculates this value based on the users' calling experience in the channel. |
| [Call Duration](#Duration) | The time from the first user joining the channel to the last user leaving the channel. |
| Online Users  | The number of the concurrent online users in the Big Channel. |
| Peak Users    | The peak number of the concurrent online users in the Big Channel. |
| Start Time    | The time when the first user joins the channel.              |
| End Time      | The time when the last user leaves the channel.              |
| Last Updated  | The duration since the last channel information update.      |

## View Big Channel details

Click the channel name or **Detail** of the target channel to view and analyze the usage, the distribution of the audience, or the quality. You can also see the call duration at the top-right corner on the page.

<div class="alert note"><ul><li>During an ongoing call:<ul><li>If the call duration crosses a date and is more than 3 hours, Agora Analytics only displays the data of the Big Channel in last 3 hours of the call. You can check the data for the previous day by selecting it from the time line.<br><li>If the call duration does not cross a date and is less than 3 hours, Agora Analytics displays all data for the call.</li></ul><li>In an ended call:<ul><li>If the call duration crosses a date, Agora Analytics only displays the data of the Big Channel in last day of the call, and you can check the data for the previous day by selecting it from the time line.<br><li>If the call duration does not cross a date, Agora Analytics displays all data for the call.</li></ul></div>

### Overview

The **Overview** panel shows the usage and quality data in two sections: Scale and Quality.

In each section, the left area shows the [current/total](#Current) values, and the right area shows the values per 15 seconds in line charts. The red triangle in the line chart refers to the peak number of users.

![](https://web-cdn.agora.io/docs-files/1580097672855)

| Metric                    | Description                                                  |
| :------------------------ | :----------------------------------------------------------- |
| Rating                    | The score of the Big Channel, where the maximum value is 5. Agora Analytics calculates this value based on the users' calling experience in the channel. |
| Users with join issues    | The number of users having issues when joining the channel, including users who fail to join and users who experience a delay in joining the channel. |
| Users with in-call issues | The number of users having in-call quality issues, such as poor audio quality and frozen video. |

### Distribution

The **Distribution** panel shows the top usage statistics in the following dimensions. Click ![](https://web-cdn.agora.io/docs-files/1579062897264) to sample users with quality issues, and to analyze the call quality.

| Dimension                          | Description                                                  |
| :--------------------------------- | :----------------------------------------------------------- |
| Top Hosts                          | The current/total top fifteen hosts with the longest duration in channel. |
| Geo - Global\|China\|United States | The current/total top ten countries or cities with the highest number of audience members. |
| Operating System (OS)              | The current/total top ten operating systems with the highest number of audience members. |
| SDK Version                        | The current/total top ten SDK versions with the highest number of audience members. |
| Quality Factor                     | The current/total top ten factors, which impacting quality, with the highest number of audience members. |

<div class="alert note">When there is no data in a dimension, the panel for that dimension does not appear.</div>

#### Top Hosts

This panel shows the current/total top fifteen hosts with the longest duration in channel.

![](https://web-cdn.agora.io/docs-files/1580097755677)

| Metric                                 | Description                                                  |
| :------------------------------------- | :----------------------------------------------------------- |
| Duration in Channel                    | The time from a host joining to leaving the channel.         |
| Highest · Lowest Sent Video Resolution | The highest and lowest sent resolutions of a host in the channel. |
| Affected Users                         | The current/total users with quality issues.                 |


#### Geo - Global|China|United States

This panel shows the current/total top ten countries or cities with the highest number of audience members. In the chart, you can move your mouse on a target circle to check the number of audience members of the target country/city.

![](https://web-cdn.agora.io/docs-files/1580097784171)

| Metric                                         | Description                                                  |
| :--------------------------------------------- | :----------------------------------------------------------- |
| Audience                                       | The number of the current/total audience members.            |
| Audience affected by downstream network issues | The number of audience members having in-call quality issues due to an unstable downstream network. The in-call quality issues include poor audio quality and frozen video. |
| End-to-end high-quality transmission rate      | High-quality transmission rate is the percentage of transmission with a ≤ 5% packet loss rate. |

#### Operating System

This panel shows the current/total top ten operating systems with the highest number of audience members. In the chart, you can move your mouse on a part of the ring to check the number of audience members using the target operating system.

![](https://web-cdn.agora.io/docs-files/1580097801220)

| Metric                                | Description                                                  |
| :------------------------------------ | :----------------------------------------------------------- |
| Audience                              | The number of the current/total audience members.            |
| Audience affected by CPU usage issues | The number of the audience members having in-call quality issues, such as poor audio quality and frozen video, due to high CPU usage either on the audience or host side. |

#### SDK Version

This panel shows the current/total top ten SDK versions with the highest number of audience members. In the chart, you can move your mouse on a part of the ring to check the number of audience members using the target SDK version.

![](https://web-cdn.agora.io/docs-files/1581336804868)

| Metric                                | Description                                                  |
| :------------------------------------ | :----------------------------------------------------------- |
| Audience                              | The number of the current/total audience members.            |
| Audience affected by CPU usage issues | The number of the audience members having in-call quality issues, such as poor audio quality and frozen video, due to high CPU usage either on the audience or host side. |

#### Quality Factor

This panel shows the current/total top ten factors, which impacting the quality, with the highest number of audience members. In the chart, you can move your mouse on a part of the ring to check the number of audience members with the target quality factor.

![](https://web-cdn.agora.io/docs-files/1581336853185)

| Metric         | Description                                                  |
| :------------- | :----------------------------------------------------------- |
| Quality Factor | The factors causing the bad user experience by the local user or remote users. |
| Affected Users | The number of users having in-call quality issues, such as poor audio quality and frozen video, due to network or device issues on the host side. |

## Key terms

This section describes the key terms used in Call Search. See [Agora Key Terms](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms) for more.

<a name="BigChannel"></a>
### Big Channel

Every call or live broadcast must occur in a channel. If we imagine an app being a building, a channel is a room in the building. Agora calls a channel with many online users as a Big Channel, you need to define your own Big Channel in the **Big Channel Config** page. You can enable Big Channel for specified channels or projects.

<a name="User"></a>
### User

Each user in the call has a unique [username](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername).

Big Channel counts a unique username in a unique channel as one user. If a real-life user joins one channel with different usernames, Big Channel counts the user as multiple users.

<a name="Host"></a>
### Host

All users who have sent streams to the channel. If a user has sent streams in the first minute of a call and does not send any further streams, then Agora Analytics also determines this user as a host.

<a name="Audience"></a>
### Audience

The users who only receive streams from a channel.

<a name="Abnormal"></a>
### Poor user experience

During a call, users may have quality issues, such as poor audio quality and frozen video, caused by various factors. Agora calls this as a poor user experience, and you can see detailed information about quality factors in [Factor ID](https://docs.agora.io/en/Agora%20Platform/aa_api?platform=All%20Platforms#a-namefactor_idafactor-id).

<a name="Call"></a>
### Call

Many calls can occur in a channel. When a user joins an empty channel, a call starts. When all users leave the channel, this call ends. If a user joins the channel after the call ends, then a new call starts. The period between the first user joining a channel and the last user leaving the channel is considered one call.

<a name="Duration"></a>
### Call duration

- A call's duration is the time from the first user joining the channel to the last user leaving the channel.
- A user's duration is the time from the user joining to leaving the channel. A user may join and leave a channel repeatedly during a call.

<a name="Current"></a>
### Current/Total

- In a Big Channel with ongoing calls, **Details** shows the current data, such as the current number of users, hosts, and audience members.
- In a Big Channel with ended calls, **Details** shows the total data, such as the total number of users, hosts, and audience members during the call.

<div class="alert note">When the duration of an ongoing call crosses a date and is more than 3 hours, <b>Details</b> displays the total data for the previous day along with the data for the current day.</div>