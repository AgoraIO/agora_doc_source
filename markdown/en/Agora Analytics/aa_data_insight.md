---
title: Data Insight (Beta)
platform: All Platforms
updatedAt: 2020-09-18 17:35:43
---
The **Data Insight** function of Agora Analytics provides usage and quality statistics over a certain period of time to help you understand the trend of the usage and quality of your calls, distribution in various dimensions, and daily data breakdown.

- Shows daily data in the specified date range.
- Updates the statistics every day.

<div class="alert info">Only covers the usage and quality statistics of the Agora RTC SDK.</div>

## Get started

1. Contact sales-us@agora.io to enable the Data Insight function for your project.
2. Login to [Agora Console](https://dashboard.agora.io) and click **Agora Analytics** on the left navigation bar.
3. Select a project in the top-left corner.
![](https://web-cdn.agora.io/docs-files/1570775919538)
5. Click [**Usage Overview**](#usage) to view the usage statistics or [**Quality Overview**](#quality) to view the quality statistics.
6. Specify the date range in the upper-right corner (UTC time) and click the settings button to select items to display (all selected by default).
![](https://web-cdn.agora.io/docs-files/1570776247336)

<div class="alert note">Data Insight has the following limits:
  <li>Provides data after August 1, 2019.</li>
<li>The specified date range has a maximum of 30 days.</li>
<li>Supports viewing data within the last three months. You can click <b>More</b> in the top-right corner of the charts to download the data.</li>
</div>

## <a name="usage"></a>Usage Overview

View the following statistics on the **Usage Overview** page:

- **Overview**: View the trend of calls' duration, number of channels, maximum online users, and number of users, and locate the dates with abnormal data.
- **Top**: View the top five/ten usage statistics by different dimensions, including country, OS, SDK versions and so on.

### Overview

The Overview panel shows the daily usage data in two sections.

In each section, the left area shows the total or average values, and the right area shows the daily values in line charts. The dates with abnormal values are marked with red dots. 

Click **More** in the top-right corner of the charts to view the data in a table or download the data.

![](https://web-cdn.agora.io/docs-files/1570776637728)

**Duration**

|       Metric        | Description                                                  |
| :-----------------: | :----------------------------------------------------------- |
|   Total duration    | Total duration (minutes) of the voice and video calls of all users. |
| Video call duration | Total duration (minutes) of the video usage of all users.    |
| Audio call duration | Total duration (minutes) of the audio usage of all users.    |

**Channel & User**

|          Metric          | Description                                                  |
| :----------------------: | :----------------------------------------------------------- |
|      Total channels      | Each time the first user joins a channel until the last user leaves that channel is counted as one channel. |
|    Total big channels    | The number of channels with more than 100 users online at the same time. |
| Peak concurrent channels | Greatest number of simultaneous calls in one day.            |
|  Peak concurrent users   | Greatest number of online users in all the channels in one day. |
|       Total users        | Total number of unique UIDs in each channel.                 |
|    Total join counts     | Each time a user joins a channel is one count.               |

### Top

The Top panel shows the top five/ten usage statistics in the following dimensions.

|    Dimension     | Description                                                  |
| :--------------: | :----------------------------------------------------------- |
|   Geo - Globe    | Top 10 countries in usage.                                   |
|   Geo - China    | Top 10 provinces in China in usage.                          |
|   Network type   | Top 5 network types in usage.                                |
|        OS        | Top 5 operating systems in usage.                            |
| Peak user bucket | Top 5 types of channels in usage. The channels are grouped by the peak online users. |
|   SDK version    | Top 10 SDK versions in usage.                                |


## <a name="quality"></a>Quality overview

View the following statistics on the **Quality Overview** page:

- **Overview**: View the trend of join-channel success rate, first loading delay, audio/video freeze rate and network quality, and locate the dates with abnormal data.
- **Top**: View the top five/ten quality statistics of  by different dimensions, including country, OS, SDK versions and so on.

### Overview

The Overview panel shows the daily quality data in five sections.

In each section, the left area shows the daily average values (sum of all days/number of days), and the right area shows the daily values in line charts (the dotted lines indicate the averages). The dates with abnormal values are marked with red dots. 

Click **More** in the top-right corner of the charts to view the data in a table or download the data.

![](https://web-cdn.agora.io/docs-files/1570776833862)

**Join Channel**

|           Metric           | Description                                                  |
| :------------------------: | :----------------------------------------------------------- |
|     Join success rate      | Number of users joined / Number of users trying to join      |
| Join success in 5 sec rate | Number of users joined within 5 seconds / Number of users trying to join |

**First Loading**

|         Metric         | Description                                                  |
| :--------------------: | :----------------------------------------------------------- |
| Audio first show delay | The elapsed time from a user joining a channel to starting the audio playback. The daily value is the median of all the users' elapsed times on that day. If there is no audio stream when joining the channel, that user is excluded. |
| Video first show delay | The elapsed time from a user joining a channel to starting the video playback. The daily value is the median of all the users' elapsed times on that day. If there is no video stream when joining the channel, that user is excluded. |

**User Experience**

|      Metric       | Description                                                  |
| :---------------: | :----------------------------------------------------------- |
| Audio freeze rate | Total audio freeze time / Total audio playback duration. In every two seconds, the audio frame loss rate reaching 4% is counted as one audio freeze. Total audio freeze time = Number of audio freezes × 2000 ms. |
| Video freeze rate | Total video freeze time / Total video playback duration. Video freezes when the freeze time exceeds 600 ms. |

**Network Delay**

|    Metric     | Description                                                  |
| :-----------: | :----------------------------------------------------------- |
| Network delay | The network delay (ms) from the sender to the receiver. The daily value is the median of  all the users' delays on that day. |

**Network Transmission**

|                Metric                | Description                                                  |
| :----------------------------------: | :----------------------------------------------------------- |
| High-quality audio transmission rate | The percentage of audio transmission with a packet loss rate ≤ 5%. |
| High-quality video transmission rate | The percentage of video transmission with a packet loss rate ≤ 5%. |

### Top

The Top panel shows the top five/ten quality statistics in the following dimensions.

|    Dimension     | Description                                                  |
| :--------------: | :----------------------------------------------------------- |
|   Geo - Globe    | Top 5 countries in usage.                                    |
|   Network type   | Top 5 network types with highest usage.                      |
|        OS        | Top 5 operating systems with highest usage.                  |
| Peak user bucket | Top 5 types of channels in usage. The channels are grouped by the peak online users. |
|   SDK version    | Top 10 SDK versions with highest usage.                      |

## Key terms

This section describes the key terms used in **Data Insight**. See [Agora Key Terms](https://docs.agora.io/en/Agora%20Platform/terms) for more key terms.

### Channel

Every call or live broadcast must occur in a channel. If we imagine an app being a building, a channel will be a room in the building.

### User

Each user in the channel has a unique [username](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername). 

Data Insight counts a unique username in a unique channel as one user. If a real-life user joins one channel with different usernames, or joins different channels with one username, Data Insight counts both situations as multiple users.

### Usage

Usage counts the user's actual duration in the channel.

After a user joins a channel, the duration of receiving video is counted as video usage, while the duration of not receiving video is counted as audio usage.

### Outlier

An outlier is a value that differs significantly from other values.

Data Insight marks outliers in red numbers on the Top panel under **Quality Overview**, to indicate the dates when some issues might occur.