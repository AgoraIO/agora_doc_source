---
title: Big Channel Config (Beta)
platform: All Platforms
updatedAt: 2020-09-24 14:28:05
---
The **Big Channel Config** function of Agora Analytics enables you to customize big channels in your project, and you can choose **Enable All**, **Enable by Project** or **Enable by Channel** according to your actual needs.

## Getting started

1. Contact [sales-us@agora.io](mailto:sales-us@agora.io) to enable **Big Channel** for your project.
2. Login to [Agora Console](https://console.agora.io/) and click Agora Analytics on the left navigation panel.
3. Select a project in the top-left corner.
   ![](https://web-cdn.agora.io/docs-files/1581333255519)
4. Click **Big Channel Config** to customize big channels in your project.

> By default, **Big Channel Config** uses the UTC zone. To use your local time zone, click ![](https://web-cdn.agora.io/docs-files/1545894297187) on the top menu bar.

## Strategy

### Enable All

Click ![](https://web-cdn.agora.io/docs-files/1579063555007) next to **Enable All** to enable **Big Channel** for all channels of all projects under your account.

### Enable by Project

![](https://web-cdn.agora.io/docs-files/1581333894222)

Click ![](https://web-cdn.agora.io/docs-files/1579063555007) next to **Enable by Project** to enable **Big Channel** for specified projects. After enabling/disabling **Enable by Project**, you can see the latest operating time.

After enabling **Enable by Project**, you can set the benchmark (positive integer) of Peak Concurrent Users (PCU) to enable **Big Channel** for all channels where PCU are higher than the benchmark. 

Select target projects, check **On Condition**, input the benchmark (positive integer) of PCU, and click **Add/Update** to add or update the **Big Channel** configuration. In the **Enable Channels** list, you can see all configuration information, delete selected entries, or download the configuration list.

### Enable by Channel

![](https://web-cdn.agora.io/docs-files/1581333930574)

Click ![](https://web-cdn.agora.io/docs-files/1579063555007) next to **Enable by Channel** to enable **Big Channel** for specified channels. After enabling/disabling **Enable by Channel**, you can see the latest operating time.

In **Configuration Options**, **Allow Pre-Configuration** and **Allow Real-Time Configuration** is enabled by default.

In the **Enable Channels** list, you can see all configuration information, delete selected entries, or download the configuration list.

#### **Allow Pre-Configuration**

Enable **Big Channel** for channels to be created. Select a target project, input the channel name, and click **Add** to add a **Big Channel** to this project. Then, go to **Call Search**, you can see a magnifier at the right-down corner of the **View Call Quality** page. You can also click the magnifier to go to the **Big Channel** page.

#### **Allow Real-Time Configuration**

Enable **Big Channel** for ongoing channels on the **Call \**Search\**** page. In the **Call \**Search\**** page, choose an ongoing channel where PCU are more than 50, click the magnifier at the right-down corner, and follow the instructions to enable **Big Channel** for this channel.

<div class="alert note"><li>If a call is end or the PCU of a channel is less than 50, you cannot enable **Big Channel** for this channel in real time.<br><li>If you do not have permission to enable **Big Channel**, contact your admin to enable it for you in <a href="https://console.agora.io/role">Role Management</a >.</li></div>

## Log

This page records logs of big channels for the past 90 days. You can check the status of configurations, configuration contents, operator and operating time.

![](https://web-cdn.agora.io/docs-files/1581334771308)