The **Data Insight** function of Agora Analytics provides periodic call usage and quality statistics. It is designed to help you understand the usage and quality of calls in your app, their distribution in multiple dimensions, and daily and hourly data breakdown.

<div class="alert info"><b>Data Insight</b> only provides the usage and quality statistics after July 1, 2021 for the Agora RTC SDK.</div>

## Getting started

1. Purchase the <a href="https://console.agora.io/support/plan">support package</a > or contact support@agora.io to enable the **Data Insight** function for your project.
2. Login to [Agora Console](https://console.agora.io) and click **Agora Analytics** on the left navigation bar.
3. Select a project in the top-left corner.
4. Click **Usage Overview** to view the usage statistics or **Quality Overview** to view the quality statistics.
5. Configure the data filter:
   <li>**Usage Overview**: Select the timezone, data granularity, and time frame in the upper-right corner.</li>
   <li>**Quality Overview**: Select the product type in the upper-left corner, and the timezone, data granularity, and time frame in the upper-right corner.</li>


## <a name="usage"></a>Usage Overview

The **Usage Overview** page presents **Overall Trend** and **Multidimensional Analysis** for usage metrics, which can help you locate the dates with abnormalities and understand how usage is distributed in different dimensions.

<div class="alert warning">The usage data provided in the Usage Overview page is for reference only and is not used for billing calculation.</div>

### Overall Trend

The **Overall Trend** panel has three sections: **Peak traffic**, **Channel and user count**, and **Service minutes**. In each section, the cards in the upper-left corner highlight the aggregate or peak value of each usage metrics, and the line chart in the bottom area shows the daily values of each usage metrics. You can click **More** in the top-right corner of each section to view all data in a table or download the data.

![1](/Users/dyx/Desktop/1.jpg)

Descriptions of each usage metrics are listed in [Usage metrics](#usagemetrics). 

Each line chart provides the following features:

- Hide and display: To hide or display the line for an usage metrics, click on the corresponding card.
- Jump to multidimensional analysis: To jump to the multidimensional analysis panel of an usage metrics for a specific day, click the corresponding data point on the line and select **Multidimensional analysis**. If you want to use the previously selected time frame, click **Reapply filter** in the upper-left area of the panel.

<div class="alert note">Jump to multidimensional analysis is not supported for the following usage metrics: Peak channel traffic, Peak user traffic, and Total number of channels.</div>

### Multidimensional Analysis

The **Multidimensional Analysis** panel has six sections: **Geography**, **Network type**, **Operating system**, **SDK version**, **Device type**, and **Channel size**. Each section presents the top six numbers in the form of bar chart.

In the top-right corner of the panel, you can select the usage metrics. In the top-right corner of each section, you can click **More** to view all data in a table or download the data.

![2](/Users/dyx/Desktop/2.jpg)

Definitions of each dimension are listed in [Dimensions](#dimensions). 

<div class="alert note"><li>By default, the <b>Geography</b> section presents the region bar chart for the country ranking first in the country bar chart. To see the region bar chart for another country, click the corresponding bubble in the map.</li><li>Items with no usage are not displayed.</li></div>

## <a name="quality"></a>Quality Overview

The **Quality Overview** page presents **Overall Trend** and **Multidimensional Analysis** for quality metrics, which can help you locate the dates and hours with abnormalities and understand how quality is related to usage in different dimensions.

### Overall Trend

The **Overall Trend** panel has two sections: **User experience** and **Channel-joining success**. In each section, the cards in the upper-left corner highlight the peak or bottom value of each quality metrics, and the line chart in the bottom area shows the daily or hourly values of each quality metrics. You can click **More** in the top-right corner of the section to view all data in a table or download the data.

![3](/Users/dyx/Desktop/3.jpg)

Definitions of each quality metrics are listed in [Quality metrics](#qualitymetrics).

<div class="alert note">Audio freeze rate is not included in the quality metrics of the Agora RTC SDK for Web. That is, if you select <b>Web RTC</b> for product type in the data filter, the audio freeze rate card does not display in the <b>User experience</b> section.</div>

Each line chart provides the following features:

- Hide and display: To hide or display the line for a quality metrics, click on the corresponding card.
- Change time selection: When data granularity is set to **Daily** in the data filter, you can click a data point and select **Hourly data**, which changes the data granularity to **Hourly** and the time frame to the hour corresponding to the data point. If you want to switch back to the original filter setting, click **Restore filter** in the upper-center area of the panel.![4](/Users/dyx/Desktop/4.jpg)
- Jump to multidimensional analysis: To jump to the multidimensional analysis panel of a quality metrics for a specific day or hour, click the corresponding data point on the line and select **Multidimensional analysis**. If you want to use the previously selected time frame, click **Restore** in the upper-left area of the panel.

### Multidimensional Analysis

The **Multidimensional Analysis** panel has six sections: **Geography**, **Network type**, **Operating system**, **SDK version**, **Device type**, and **Channel size**. Each section presents the relation between quality and usage in the form of bubble chart.

In the top-right corner of the panel, you can select the quality metrics. In the top-right corner of each section, you can click ***\*More\****  to view all data in a table or download the data.![5](/Users/dyx/Desktop/5.jpg)

Definitions of each dimension are listed in [Dimensions](#dimensions).

<div class="alert note"><li>By default, the Geography section presents the region bubble chart for the country ranking first in the country bubble chart. To see the region bubble chart for another country, click the corresponding bubble in the map.</li><li>Items with no usage are not displayed.</li></div>

## Key terms

This section describes the key terms used in **Data Insight**. See [Agora Key Terms](https://docs.agora.io/en/Agora%20Platform/terms) for more key terms.

### Channel

Every call happens in a channel. If we imagine an app being a building, a channel will be a room in the building.

**Data Insight** does not count a channel by name, but by lifecycle. It counts each time from when the first users joins the channel to when the last user leaves it.

### User

Each user in the channel has a unique [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername). 

**Data Insight** counts a unique username in a unique channel as one user. If a real-life user joins one channel with different usernames, or joins different channels with one username, **Data Insight** counts the user in both situations as multiple users.

### Usage metrics

| Usage metrics                | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| Peak channel traffic         | The maximum number of channels in use.                       |
| Peak user traffic            | The maximum number of in-call users across channels.         |
| Total number of channels     | A channel begins when the first user joins and ends when the last user leaves. |
| Total number of users        | The number of users across channels. A user joining the same channel with different UIDs or joining different channels with the same UID is counted multiple times. |
| Total channel-joining counts | Each time a user joins a channel is counted.                 |
| Total minutes                | The total duration of video and audio-only calls calculated by users. |
| Video minutes                | The total duration of video calls calculated by users.       |
| Audio minutes                | The total duration of audio-only calls calculated by users   |

<div class="alert warning">The usage data provided in the Usage Overview page is for reference only and is not used for billing calculation.</div>

### Quality metrics

| Quality metrics                               | Description                                                  |
| --------------------------------------------- | ------------------------------------------------------------ |
| Video freeze rate                             | Total video freeze time ÷ Total video minutes calculated by streams. Only video freezes longer than 600 milliseconds are counted. |
| Audio freeze rate                             | Total audio freeze time ÷ Total audio minutes calculated by streams. Only audio freezes longer than 200 milliseconds are counted. |
| Network delay rate                            | Total end-to-end network delay ÷ Total audio and video minutes calculated by streams. Only end-to-end network delays longer than 400 milliseconds are counted. |
| Channel-joining success rate                  | Number of users who have joined ÷ Number of attempts to join |
| Channel-joining success rate within 5 seconds | Number of users who have joined within 5 seconds ÷ Number of attempts to join |

### Dimensions
| Dimension        | Description                                             |
| ---------------- | ------------------------------------------------------- |
| Geography        | The country and region where the user is.               |
| Network type     | The user's network type, such as Wi-Fi and 4G.          |
| Operating system | The user's operating system, such as Windows and iOS.   |
| SDK version      | The version number of the SDK that implements the call. |
| Device type      | The user's device type.                                 |
| Channel size     | The number of users in the channel.                     |


### Calculated by users and calculated by streams

They are two different approaches to calculate RTC service minutes. Their difference is described in [How does Agora calculate service minutes](https://docs.agora.io/en/Interactive%20Broadcast/faq/billing_basis).

