---
title: Pricing and Billing
platform: Billing
updatedAt: 2020-05-06 17:47:46
---
This page describes how to calculate Agora's real-time communications and recording charges. For live broadcast and billing questions, contact sales-us@agora.io.

Agora's real-time communications include:

* Voice Communication: Users in a channel communicate with each other using voice only.
* Video Communication: Users in a channel communicate with each other with voice and video. Depending on different aggregate resolutions, video communication is split into two video formats with different unit prices:
    ≤ 720p
   &gt; 720p

The service is free of charge if the monthly voice and video usage is less than 10,000 minutes. The 10,000 minutes are deducted in the order of voice then video (≤ 720p and > 720p).

<table>
  <tr>
    <th>Communication</th>
    <th>Video Format</th>
    <th>How to Deduct the Free Monthly 10,000 Minutes</th>
  </tr>
  <tr>
    <td>Voice</td>
    <td>N/A</td>
    <td><li>If voice minutes &gt; 10,000 minutes, deduct the 10,000 minutes from voice.</li><li>If voice minutes &lt; 10,000 minutes, deduct the remaining minutes from ≤ 720p video.</li></td>
  </tr>
  <tr>
    <td>Video</td>
    <td>≤ 720p and &gt; 720p</td>
    <td><li>If voice minutes + video minutes (≤ 720p) &gt; 10,000 minutes, deduct the remaining minutes from ≤ 720p video.</li><li>If voice minutes + video minutes (≤ 720p) &lt; 10,000 minutes, deduct the remaining minutes from &gt; 720p video.</li></td>
  </tr>
</table>

> The free of charge policy for the first 10,000 minutes applies to the Native SDK, Web SDK, Recording SDK and Cloud Recording services.

## Frequently Asked Questions

### What is the price of integrating the Agora SDK?

* Voice or video calls are charged by minutes and is free for light usage.
* Live broadcast is charged by the minute or bandwidth. Contact sales-us@agora.io for details on how to calculate the charges

### Can I use the Agora service for free because my app only has very few users?

Yes, your users can use up to 10,000 minutes for free each month.

### If I do not use all my minutes this month, can I carry them over to the next month?

No, you cannot carry over any unused free minutes. The unused free minutes are removed from your account at the beginning of each month.

### How often do I receive a bill from Agora？

You can log in the Agora website to check your usage statistics in Dashboard. To receive a monthly bill, you can sign up with the Agora sales department. You are not charged if you use less than 10,000 minutes a month.

### Why does Dashboard display minutes used for voice communication even though my project is for video communication?

If you see voice minutes used in a video communication or live broadcast, it may not be a billing error but may be caused by the following reasons:

* A user disabled video and only transmitted voice communication.
* The video or images in the video communication could not be transmitted due to poor network connections.
* A single channel is calculated even if only one user is in the channel. For example, user A joins the channel before user B joins, or other users in the channel are disconnected.

### Does Agora provide other information on the bill besides the usage?

The bill can be customized. Contact sales-us@agora.io for details.

### How does Agora charge CDN live, recording, storage, and other services?

Contact sales-us@agora.io for details.

## Billing for Voice Call

### Cost

Voice communication is charged by the minutes used and the number of users.

After deducting the free monthly 10,000 minutes, Agora charges you:

<table>
  <tr>
    <th>Scenario</th>
    <th>Total Fee</th>
  </tr>
  <tr>
    <td>Recording disabled</td>
    <td>Communication Fee = Voice Unit Price x Total Communication Minutes</td>
  </tr>
  <tr>
    <td>Recording enabled </td>
    <td>Communication Fee + Recording Fee = Voice Unit Price x Total Communication Minutes + Voice Unit Price x Total Recording Minutes</td>
  </tr>
</table>

The Unit Price (price per minute) can be found at [Pricing](https://www.agora.io/en/price/).
Regardless of the number of users recording at the same time in a channel, the recording of the entire channel is only charged as one stream.

### Example: Voice Only

In this example, Agora charges Communication Fee + Recording Fee

#### Communication Fee

<table>
  <tr>
    <th>User</th>
    <th>Minutes</th>
  </tr>
  <tr>
    <td>A</td>
    <td>30</td>
  </tr>
  <tr>
    <td>B</td>
    <td>40</td>
  </tr>
  <tr>
    <td>C</td>
    <td>20</td>
  </tr>
  <tr>
    <td>D</td>
    <td>15</td>
  </tr>
</table>

Communication Fee = Voice Unit Price x (30 + 40 + 20 + 15) min

#### Recording Fee

<table>
  <tr>
    <th>User</th>
    <th>10 min</th>
    <th>20 min</th>
    <th>30 min</th>
    <th>40 min</th>
  </tr>
  <tr>
    <td>A</td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
    <td></td>
  </tr>
  <tr>
    <td>B</td>
    <td></td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
  </tr>
  <tr>
    <td>C</td>
    <td>Recording</td>
    <td>Recording</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>D</td>
    <td>Recording</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>

Recording Fee = Voice Unit Price x 40 min

## Billing for Video Call

### Cost

Video communication is charged by the minutes used, the number of users, and the resolution used.
After deducting the monthly 10,000 minutes, Agora charges:

<table>
  <tr>
    <th>Scenario</th>
    <th>Total Fee</th>
  </tr>
  <tr>
    <td>Recording disabled</td>
    <td><li>Users in the same video format: Communication Fee = Unit Price for the Video Format x Total Communication Minutes</li><li>Users in different video formats: Communication Fee = Σ(Unit Price for Each Video Format x Total Minutes for Each Video Format</li></td>
  </tr>
  <tr>
    <td>Recording enabled</td>
    <td><li>Users in the same video format: Communication Fee + Recording Fee = Unit Price for the Video Format x Total Communication Minutes + Unit Price for the Video Format x Total Recording Minutes</li><li>Users in different video formats: Communication Fee + Recording Fee = Σ(Unit Price for Each Video Format x Total Communication Minutes for Each Video Format + Σ(Unit Price for Each Video Format x Total Recording Minutes for Each Video Format)</li></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>

* For communication, each user is calculated as one stream based on the user's `:ref: communication aggregate resolution<video_communication_aggregate>`. For recording, regardless of the number of users recording at the same time in a channel, the entire channel is calculated as one stream based on the `:ref: recording aggregate resolution<video_recording_aggregate> `of all users.
* Σ is a mathematical symbol meaning to sum up the values.

The unit price is the same for communication and recording in the same video format decided by the aggregate resolution:

<table>
  <tr>
    <th>Video Format</th>
    <th>Aggregate Resolution</th>
  </tr>
  <tr>
    <td>≤ 720p</td>
    <td>Resolution≤ 1280 x 720</td>
  </tr>
  <tr>
    <td>&gt; 720p</td>
    <td>Resolution &gt; 1280 x 720</td>
  </tr>
</table>

The examples on this page assume that the users do not change their resolution. If any user changes their resolution, both the communication and recording aggregate resolutions change accordingly.

The following example shows how to calculate the communication and recording aggregate resolutions:

#### Calculating the Communication Aggregate Resolution

For example, there are four users (A, B, C, and D) in a channel. For user A, the aggregate resolution is the sum of the image areas (Width x Height) of the other users' resolutions.

For example,

* B = 640 x 360 = 230400
* C = 240 x 180 = 43200
* D = 640 x 360 = 230400

Hence, the aggregate resolution for user A = B + C + D = 504000

Since 504000 < 1280 x 720, User A is charged according to the ≤ 720p video format fee.

<a name = "the-Recording-Aggregate-Resolution"></a>

#### Calculating the Recording Aggregate Resolution

For example, there are four users (A, B, C, and D) in a channel. The aggregate resolution is the sum of the image area (Width x Height) of each user's resolution.

For example,

* A = 240 x 180 = 43200
* B = 640 x 360 = 230400
* C = 240 x 180 = 43200
* D = 640 x 360 = 230400

Hence, the aggregate resolution for recording = A + B + C + D = 547200

Since 547200 < 1280 x 720, the recording is charged according to the ≤ 720p video format unit price.

If user B uses voice only (B area = 0), the aggregate resolution for recording = A + B + C + D = 316800. Since 316800 < 1280 x 720, the recording is still charged according to the ≤ 720p video format unit price.

See the following examples for details:

### Example 1: ≤ 720p Video

In this example, Agora charges Communication Fee + Recording Fee

#### Communication Fee

<table>
  <tr>
    <th>User</th>
    <th>Minutes</th>
    <th>Resolution</th>
    <th>Aggregate Resolution</th>
    <th>Video Format</th>
  </tr>
  <tr>
    <td>A</td>
    <td>30</td>
    <td>640 x 360</td>
    <td>547200&lt;1280x720</td>
    <td>≤ 720)</td>
  </tr>
  <tr>
    <td>B</td>
    <td>40</td>
    <td>640 x 360</td>
    <td>547200&lt;1280x720</td>
    <td>≤ 720</td>
  </tr>
  <tr>
    <td>C</td>
    <td>10</td>
    <td>640 x 360</td>
    <td>547200&lt;1280x720</td>
    <td>≤ 720</td>
  </tr>
  <tr>
    <td>D</td>
    <td>15</td>
    <td>240 x 180</td>
    <td>734400&lt;1280x720</td>
    <td>≤ 720</td>
  </tr>
  <tr>
    <td>E</td>
    <td>30</td>
    <td>240 x 180</td>
    <td>734400&lt;1280x720</td>
    <td>≤ 720</td>
  </tr>
</table>

Communication Fee = Video Unit Price (≤ 720p)  x (30 + 40 + 10 + 15 + 30) min

#### Recording Fee

<table>
	<tr>
    <th>User</th>
    <th>10 min</th>
    <th>20 min</th>
    <th>30&nbsp;&nbsp;min</th>
    <th>40 min</th>
  </tr>
  <tr>
    <td>A</td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
    <td></td>
  </tr>
  <tr>
    <td>B</td>
    <td></td>
    <td>Recording</td>
    <td>Recording</td>
    <td></td>
  </tr>
  <tr>
    <td>C</td>
    <td>Recording</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>D</td>
    <td>Recording</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>E</td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
    <td></td>
  </tr>
</table>

Recording Fee = Video Unit Price (≤ 720p) x 30 min

### Example 2: ≤ 720p and > 720p Video

In this example, Agora charges Communication Fee + Recording Fee

#### Communication Fee

<table>
  <tr>
    <th>User</th>
    <th>Minutes</th>
    <th>Resolution</th>
    <th>Aggregate Resolution</th>
    <th>Video Format</th>
  </tr>
  <tr>
    <td>A</td>
    <td>30</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>B</td>
    <td>40</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>C</td>
    <td>10</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>D</td>
    <td>15</td>
    <td>1280 x 720</td>
    <td>921600 = 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>E</td>
    <td>30</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
</table>

Communication Fee = Video Unit Price (> 720p) x (30 + 40 + 10 + 30) min + Video Unit Price (> 720p) x 15 min

#### Recording Fee

<table>
  <tr>
    <th>User</th>
    <th>10 min</th>
    <th>20 min</th>
    <th>30&nbsp;&nbsp;min</th>
    <th>40 min</th>
  </tr>
  <tr>
    <td>A</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>B</td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
    <td>Recording</td>
  </tr>
  <tr>
    <td>C</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>D</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>E</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>

### Example 3: Voice and Video

#### Communication Fee

<table>
  <tr>
    <th>User</th>
    <th>Minutes</th>
    <th>Resolution</th>
    <th>Aggregate Resolution</th>
    <th>Video Format</th>
  </tr>
  <tr>
    <td>A</td>
    <td>30</td>
    <td>640 x 360(Disable video, voice only)</td>
    <td>N/A</td>
    <td>Charged as video communication</td>
  </tr>
  <tr>
    <td>B</td>
    <td>40</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>C</td>
    <td>10</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
  <tr>
    <td>D</td>
    <td>15</td>
    <td>1280 x 720</td>
    <td>921600 = 1280 x 720</td>
    <td>≤ 720p</td>
  </tr>
  <tr>
    <td>E</td>
    <td>30</td>
    <td>640 x 360</td>
    <td>1612800 &gt; 1280 x 720</td>
    <td>&gt; 720p</td>
  </tr>
</table>

Communication Fee = Video Unit Price (≤ 720p) x 30 min + Video Unit Price (> 720p) x (40 + 10 + 30) min + Video Unit Price (≤ 720p) x 15 min

#### Recording Fee

Recording is not enabled so no recording fee is charged.

