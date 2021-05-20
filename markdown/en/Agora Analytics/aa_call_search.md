---
title: Call Search
platform: All Platforms
updatedAt: 2020-09-15 18:28:27
---
The [**Call Search**](https://dashboard.agora.io/analytics/call/search) function of Agora Analytics allows you to see the quality of your calls in diagrams displaying data during the call process. The information includes:

- The device status, including the system CPU usage and the app's CPU usage.
- The local captured volume and the remote playout volume.
- The bitrate of the sent or received audio and video.
- The frame rate of the sent or received audio and video.
- The resolution of the sent or received video.
- The upstream bitrate and packet loss rate of the sent audio and video.
- The downstream bitrate and end-to-end packet loss rate of the received audio and video.
- The freeze time in rendering the audio and video.
- User events. For example, stop sending audio or start receiving video.
- The users' ratings of the call.

See the use case [tutorials](./aa_tutorial) to learn how to analyze your calls.

<div class="alert note"><b>Call Search</b> supports viewing data for the past 14 days. </div>

## Search calls

Log in [Agora Console](https://dashboard.agora.io/) and click **Call Search** under **Agora Analytics** on the left of the navigation bar.

![](https://web-cdn.agora.io/docs-files/1600163073655)

To search calls, fill in the search fields:
1.  Select the project in the top-left corner.
2.  Specify the searching time frame (the default time frame is the last 14 days).
3.  Choose to search by **Channel Name** or **User** ([user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername)) in the drop-down menu.
4.  Filter the calls by the call states, and you can choose to search for calls that are ongoing or ended.
5.  Enter a channel name or [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername) and click **Search**.

<div class="alert note">By default, <b>Call Search</b> uses your local time zone. To use the UTC zone, click the clock icon <img src="https://web-cdn.agora.io/docs-files/1545894297187"/> on the top menu bar.</div>

## View Quality of Experience

You can go to the QoE page by clicking **View the call** on the search results page.

The QoE page shows each user's quality of experience as the receiver in the call. You can see whether any user experiences audio/video freeze, blurry video, or no audio or video. On this page, you can see the **Basic information**, the **User list** and the **Quality of Experience Overview** of the call from top to bottom.

### Basic information

![](https://web-cdn.agora.io/docs-files/1600164202811)

The top of the QoE page shows the basic information of the call, such as the project name, channel name, starting and ending times, and duration of the call.

<div class="alert info">The <b>QoE</b> page shows up to three hours duration of each call. If a call lasts more than 3 hours, the <b>QoE</b> page shows the last 3 hours by default. You can use the timeline to select the time frame to view.</div>

### User list

![](https://web-cdn.agora.io/docs-files/1600164214666)

The user list shows the information of the users in the call, such as the [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername), the location, when the user joins/leaves the channel and the actual time in the channel (In-call Periods).

The **View QoE** toggle switch turns on/off displaying the QoE diagram for each user.

<div class="alert note"> If a call has more than six users, the user list only shows some of the users. If the user that you want to view is not listed, select <b>Click here to expand</b> on the top-right corner to add the user. <b>Search</b> for the user by selecting attributes, such as the platform, device type and whether or not the user role is the host. When you find the user that you want, enable the <b>Action</b> button.</div>

### Quality of Experience Overview

![](https://web-cdn.agora.io/docs-files/1600164386879)

The **Quality of Experience Overview** section displays each user's QoE diagram.

The user's basic information is shown above the QoE diagram, including the [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername), platform, SDK version, and user's ratings of the call (when the rating function is enabled).

<div class="alert note">See how to enable the rating function on <a href="./rate_call_android">Android</a >, <a href="./rate_call_apple?platform=iOS">iOS</a >, <a href="./rate_call_apple?platform=macOS">macOS</a >, and <a href="./rate_call_windows">Windows</a >.</div>

![](https://web-cdn.agora.io/docs-files/1545382892984)

In the QoE diagram, the x-axis represents the time of the call, and the y-axis represents the bitrate of the received video and audio.

- The curve above the x-axis represents the bitrate of the received video from the sender. For multiple senders, the received video from each sender is shown by a colored curve.
- The red dotted line indicates a blurry video.
- The red glitches above the x-axis indicate video freeze.
- The curve below the x-axis represents the total bitrate of the received audio from all senders.
- The red glitches below the x-axis indicate audio freeze.

<div class="alert note">The <b>QoE</b> section displays data from all senders by default. You can select which senders to display by using the toolbar at the bottom-right of the page.</div>

If you find quality issues of a specific sender, click the **End-to-End Details** button to go to the E2E (End-to-End) page.

If you need support, click the bottom-right icon ![](https://web-cdn.agora.io/docs-files/1600162422683) to submit a ticket.

## Analyze quality issues

![](https://web-cdn.agora.io/docs-files/1600165256901)

The **End-to-End Details** page shows the audio and video statistics of a specific sender and receiver. These statistics affect the user's quality of experience and help you understand the quality issues. 

You can see the user's event timeline on the following diragrams:

- Audio Upstream Bitrate and Packet Loss
- Audio Downstream Bitrate and End-to-End Packet Loss
- Video Upstream Bitrate and Packet Loss
- Video Downstream Bitrate and End-to-End Packet Loss

Select the spikes on the timeline to see the [user events](#event). Pay attention to the red spikes, which represent important events, such as failure to join the channel.

<div class="alert note">You can also click <b>Change</b> to switch the user's perspective. For example, if the left page originally displays the audio/video information of user A as the sender and the right page originally displays the information of user B as the receiver, after switching the user's perspective, the left page displays the information of user B as the sender and the right page displays the information of user A as the receiver.</div>
Here is a brief explanation of these statistics:

<a name="device"></a>
### Device status

The CPU usage of the system and the App, indicating how busy the system is. If the system is busy (the CPU usage is high), the audio/video may freeze.

<div class="alert note">Changes in Android 8.0 make it difficult to get accurate CPU usage statistics. Agora provides a <b>Task Scheduling Delay</b> indicator to represent how busy the system is.</div>

<a name="event"></a>
### User events

You can find user events on the event timeline in the **Quality of Experience Overview** section and on the **End-to-End Details** page. There are red, yellow, and green spikes on the timeline, representing serious, general, and normal events:

- **Serious events**: Events that directly affect the call experience and make it difficult for receivers to see normal images. Such events occur when a user fails to join a channel, network connections fail, a user disables the audio/video module, or a user stops camera capturing.
- **General events**: Events that may affect the call experience to some extent. Such events occur when a user's network status is unknown, IP address changes, or a user stops sending audio/video streams.
- **Normal events**: Events that do not affect the call experience. Such events occur when a user successfully joins a channel, a user starts camera capturing, or a user receives the first audio/video frame.

<div class="alert note">If the same user event frequently occurs in a minute, the spike representing this user event will be higher.</div>

### Bitrate

The bitrate is the amount of data (bits) sent or received per second.

A higher audio/video bitrate means a higher audio/video quality. A low bitrate does not necessarily cause quality issues, but a very low bitrate often means poor audio/video quality.

### Packet loss

Data is transmitted in units called packets. In data transmission, some of the packets are lost. The packet loss rate is the percentage of the lost packets, which reflects the network quality:

- The packet loss rate of the sender is the packet loss rate of sending the data.
- The packet loss rate of the receiver is the packet loss rate from the sender to the receiver.

A low packet loss rate usually does not cause any quality issue. A high packet loss rate (5% or higher) means the network quality is poor and may cause audio/video freeze and blurry video.

### Frame rate

The frame rate is the frequency (rate) at which consecutive images (frames) appear on a display. 

A higher frame rate means smoother video but uses more bandwidth and CPU usage. A low frame rate may cause video freeze.

### Resolution

The resolution is the number of pixels in the width and height of an image. A higher resolution means clearer video.

## Key terms

This section describes the key terms used in **Call Search**. See [Agora Key Terms](./terms) for more key terms.

### Channel

Every call or interactive streaming must occur in a channel. If we imagine an app being a building, a channel will be a room in the building.

### Call

Many calls can occur in a channel. When a user joins an empty channel, a call starts. When all users leave the channel, this call ends. If a user joins the channel after the call ends, then a new call starts. The period between the first user joining a channel and the last user leaving the channel is considered one call. 

### User

Each user in the call has a unique [user ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameusernameausername). Agora Analytics displays and analyzes the users' QoE from the perspective of sending and receiving data.

<a name="rec"></a>
#### Receiver

The QoE page shows the QoE of each user as the receiver.

<a name="send"></a>
#### Sender

A sender is a user sending data and has a speaker icon ![](https://web-cdn.agora.io/docs-files/1545894218077) in the user list.

### Duration

- A call's duration is the time from starting to ending the call, that is from the first user joining the channel to the last user leaving the channel.
- A user's duration is the time from the user joining to leaving the channel. A user may join and leave a channel multiple times in a call.

### Actual time in the channel

The actual time in the channel reflects the actual minutes used in the channel for each user in the call.

<div class="alert note"> The calls are charged according to the actual minutes used in the channel.</div>