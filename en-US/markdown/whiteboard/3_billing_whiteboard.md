This article introduces the billing policy for the whiteboard service provided by Agora.

<div class="alert note">Your billing details may differ if you have signed a contract with Agora.</div>

## Overview

Billing for the whiteboard service begins once you enable and implement the service in your project. Agora sends your bill and deducts the payment from your account on a monthly basis. For details, see [Billing, fee deduction, and account suspension](https://docs.agora.io/cn/faq/billing_account).

## Calculation

Agora's whiteboard service provides the following features:

- Online whiteboard
- Whiteboard recording
- File conversion
   - Convert to image
   - Convert to web page

At the end of each month, Agora adds up the usage of each whiteboard feature in all projects under your [Agora account](https://console.agora.io/) and subtracts your monthly free usage allowances. Agora multiplies each resulting usage number by the corresponding price and adds up the cost of each feature to get the total cost for that month.

**Total cost = online whiteboard charges + whiteboard recording charges + charges for file conversion to image + charges for file conversion to web page**

The unit price, free usage, and cost calculation of each whiteboard feature is as follows:

<html>
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <div class="table-wrap">
            <table class="wrapped confluenceTable">
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh">
                                                        Whiteboard feature</th>
                        <th class="confluenceTh">
                                                        <span>Unit</span>
                        </th>
                        <th colspan="1" class="confluenceTh">
                                                        Unit price
                        </th>
                        <th colspan="1" class="confluenceTh">
                                                        Free usage 
                        </th>
                        <th colspan="1" class="confluenceTh">
                                                        Cost ($US)
                        </th>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                                                        Online whiteboard
                        </td>
                        <td class="confluenceTd">
                                                        <span class="inline-comment-marker" data-ref="d806330e-d051-4722-96ac-763b59a4eb01">Duration (in minutes)</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        $1.40/1,000 minutes
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        10,000 minutes per month
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        (Usage minutes - 10,000) × <span>1.4</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                                                        Whiteboard recording
                        </td>
                        <td class="confluenceTd">
                                                        <span>Duration (in minutes)</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        $2.00<span>/1,000 minutes</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>1,000 minutes per month</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>(Usage minutes - 1,000）</span><span>×</span> <span>2</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                                                        File conversion to image
                        </td>
                        <td class="confluenceTd">
                                                        Number of images
                        </td>
                        <td rowspan="2" class="confluenceTd">
                                                        $0.50/1,000 images
                        </td>
                        <td rowspan="2" class="confluenceTd">
                            <p>
                                                                <span style="color: rgb(0,0,0);">1,000 images per month</span>
                            </p>
                        </td>
                        <td rowspan="2" class="confluenceTd">
                            <p>
                                                                (Number of converted images + <span style="letter-spacing: 0.0px;">Number of converted web pages <span>× 5 - 1,000) <span>×</span> <span>0.5</span></span></span>
                            </p>
                            <p>
                                <br>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                                                        File conversion to web page
                        </td>
                        <td colspan="1" class="confluenceTd">
                            <p>
                                                                Number of web pages
                            </p>
                            <p>
                                                                <span>(1 web page is equivalent to 5 images）</span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>


<div class="alert note"><ul>
	<li>The price of converting a file to web pages is five times the price of converting it to images. When charging for file conversion to web pages, Agora multiplies the number of generated web pages by five in order to use a consistent unit price for the file conversion feature.</li>
	<li>The file conversion feature can also be charged by QPS. For more information, contact <a href="mailto:sales@agora.io">sales-us@agora.io</a >.</li>
	<li>Agora rounds up the monthly total fees to two decimal places.</li>
	<li>If the monthly total usage of a whiteboard feature does not exceed its free usage allowance, the feature will not be charged for that month. Any free usage that is not used in a month is not carried over to the next month.</li></ul></div>

### Usage calculation

This section describes how to calculate the usage of each whiteboard feature.

#### Online whiteboard

The usage duration of each whiteboard room equals **the total sum of usage duration of all users** in the room.

For each user, Agora calculates the usage duration from the user joining a room to the user leaving the room.  **The usage duration is accurate to the minute**.

#### Whiteboard recording

For a whiteboard room that has enabled recording, Agora calculates the usage duration from the first user joining the room to the last user leaving the room.  **The usage duration is accurate to the minute**.

<div class="alert note">Calculation pauses when no user is in the room and resumes when a user joins the room.</div>

#### File conversion

Agora calculates the usage amount by the number of images and web pages successfully converted from source files.

<div class="alert note"><ul>
	<li>When charging for file conversion to web pages, Agora multiplies the number of generated web pages by five in order to use a consistent unit price for the file conversion feature.</li>
	<li>Agora does not charge for a failed file conversion task. You can call the <a href="/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）">Interactive Whiteboard RESTful API</a > to query the progress of a file conversion task.</li></ul></div>

### Check usage duration

You can check your usage of the whiteboard service on Agora Console. Perform the following steps:

1. Log in to [Agora Console](https://console.agora.io/), and click the **Products & Usage** button on the left navigation panel.

2. Click the arrowhead ![img](https://web-cdn.agora.io/docs-files/1607311735894) in the top left corner, and select the project you want to check in the drop-down box.****

3. Click **Duration** under **Whiteboard**, select a time frame, and check the usage duration.

<div class="alert note"><ul>
	<li>The time frame cannot exceed 12 months.</li>
	<li>Only Agora accounts that are assigned with the role of Admin or Finance have access to the usage statistics.</li>
	<li>The usage duration provided by Agora Console is for reference only. Your actual billing may differ.</li></ul></div>


## Examples

This section shows how to calculate your monthly usage of the whiteboard service, as well as the total cost based on the corresponding unit price.

### Scenario description

Suppose you have a project named Test under your Agora account, and you have enabled the whiteboard service for the project. The project generates the following usage between February 1 and February 28, 2021:

#### Scenario one

On February 8, 2021, User A and B join a whiteboard room at the same time and User A tutors B for 45 minutes. During this period, User A successfully converts a 30-page PDF file to PNG files using the file conversion feature and presents them on the whiteboard. When tutoring ends, User A and B leave the room at the same time.

The usage calculation is as follows:

| Feature | Usage |
| :--------- | :-------------------------------------- |
| Online whiteboard | <li>User A: 45 minutes<li>User B: 45 minutes |
| Convert to image | 30 pages |

#### Scenario two

On February 11, 2021, User A joins a whiteboard room to give an online lecture and successfully converts a 50-page dynamic PPT file to HTML files using the file conversion feature. Another 200 users join the room to watch the lecture live. The lecture lasts 60 minutes and is completely recorded using the whiteboard recording feature.

The usage calculation is as follows:

| Feature | Usage |
| :--------- | :------------------------------------------------ |
| Online whiteboard | <li>User A: 60 minutes<li>200 users: 60 × 200 minutes |
| Convert to web page | 50 pages |
| Whiteboard recording | 60 minutes |

### Cost calculation

<html>
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <div class="table-wrap">
            <table class="wrapped confluenceTable">
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th rowspan="2" class="confluenceTh">
                            Date</th>
                        <th colspan="4" class="confluenceTh">
                            Usage</th>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Online whiteboard (minutes)</td>
                        <td class="confluenceTd">
                            Whiteboard recording (minutes)</td>
                        <td class="confluenceTd">
                            Convert to image (number of images)</td>
                        <td colspan="1" class="confluenceTd">
                            Convert to web page (number of web pages)</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd">
                            Feb 8, 2021</td>
                        <td colspan="1" class="confluenceTd">
                                                        90
                        </td>
                        <td class="confluenceTd">
                                                        0
                        </td>
                        <td class="confluenceTd">
                                                        30
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        0
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Feb 11, 2021</td>
                        <td colspan="1" class="confluenceTd">
                                                        12,060
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        60
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        0
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        50
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Monthly usage</td>
                        <td colspan="1" class="confluenceTd">
                                                        12,150
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        60
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        30
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>50</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Billable usage</td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>12,150</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>60</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>30</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>50 <span>* 5 = 250</span></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                                                        Free usage 
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        <span class="inline-comment-marker" data-ref="4f39e4e5-9829-4e12-aaf0-d97b137ddbe8">10,000</span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        1,000
                        </td>
                        <td colspan="2" style="text-align: center;" class="confluenceTd">
                                                        1,000
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Cost of each service ($US)</td>
                        <td colspan="1" class="confluenceTd">
                                                        <span>(12,150 - <span><span class="inline-comment-marker" data-ref="1d5317e1-b86e-4336-a320-b7abaae269b6">10,000</span>)/<span class="inline-comment-marker" data-ref="5babcb2e-dfe5-444a-85d9-4407fe57f4d3">1,000</span> <span>× <span>1.4 = 3.01</span></span></span></span>
                        </td>
                        <td colspan="1" class="confluenceTd">
                                                        0
                        </td>
                        <td colspan="2" class="confluenceTd">
                                                        0
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="confluenceTd">
                            Total cost ($US)</td>
                        <td colspan="4" style="text-align: right;" class="confluenceTd">
                                                        <span>3.01</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>


## FAQ

<details><summary><font color="#3ab7f8">Will usage calculation continue if live streaming has ended but users are still in the room?</font></summary>
Yes. Usage calculation for the whiteboard service depends on the presence of active long-lived connections. To avoid additional costs, Agora recommends that you:
<ul>
	<li>Call <code>disconnect()</code> to cut off a user's connection when the user leaves the room, and ensure that you receive the <code>onPhaseChanged(disconnected)</code> callback.</li>
	<li>Call the <a href="https://docs.agora.io/cn/whiteboard/whiteboard_room_management?platform=RESTful#%E5%B0%81%E7%A6%81%E6%88%BF%E9%97%B4-%EF%BC%88patch%EF%BC%89">Interactive Whiteboard RESTful API </a > on your app server to move all users out of the room when live streaming ends.</li>
</ul>
</details>

<details><summary><font color="#3ab7f8">Does billing begin when a room is created?</font></summary>
No, because no user joins the room.
</details>

<details><summary><font color="#3ab7f8">Does joining a room using different modes result in different costs?</font></summary>
No. The usage calculation and unit price are the same whether the user joins a room in interactive mode or subscription mode.
</details>