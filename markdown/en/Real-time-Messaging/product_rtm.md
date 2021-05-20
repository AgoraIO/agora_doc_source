---
title: Agora Real-time Messaging Overview
platform: All_Platforms
updatedAt: 2021-02-02 02:42:03
---
You can use the Agora RTM (Real-time Messaging) SDK to create a stable messaging mechanism for real-time messaging scenarios that require low latency and high concurrency for a global audience. 

## Functions

The RTM SDK supports the following functions:

-   Send and receive online or offline peer-to-peer messages.
-   Send and receive channel messages.
-   Get the member list of a channel.
-   Create, send, cancel, accept, or decline a call invitation. 
-   Set, update, or get user attributes or channel attributes.
-   Get the latest member count of specified channels. 
-   Subscribe to or unsubscribe from the online status of the specified users.
-   Get a list of the peers by subscription.
-   Interconnect with the legacy Agora Signaling SDK.


## Applications

You can use the RTM SDK for the following scenarios:

<table>
  <tr>
    <th>Industry</th>
    <th>Application</th>
  </tr>
  <tr>
    <td>live interactive streaming</td>
    <td><li>Commentaries<br><li>Chat rooms<br><li>Send gifts<br><li>Likes<br><li>Maintenance of the chat room status, such as the number of the channel members<br><li>Privilege management, such as removing or muting a specific user<br></td>
  </tr>
  <tr>
    <td>Social network</td>
    <td><li>Private chat messages<br><li>Group messages<br><li>Voice/Video call invitation commands<br></td>
  </tr>
  <tr>
    <td>Education</td>
    <td><li>Class group messages<br><li>Private chat messages<br><li>Whiteboard<br><li>Privilege management, such as awards, presenting, hands up or likes<br></td>
  </tr>
  <tr>
    <td>IoT</td>
    <td>Control messages</td>
  </tr>
</table>

## Features

The RTM SDK has the following features:

<table border="1" width="100%">
  <tr>
    <th width="20%">Feature </th>
    <th width="50%">Description</th>
  </tr>
  <tr>
    <td>High concurrency</td>
    <td>Supports sending up to a million channel messages simultaneously. Can cope with high-concurrency scenarios, such as in an online quiz. <br></td>
  </tr>
  <tr>
    <td>High reliability</td>
    <td>Service availability at 99.999%</td>
  </tr>
	  <tr>
    <td>Low latency</td>
    <td>We have data centers distributed worldwide. <li>The average inter-continental latency is less than 200 ms.<br><li>The average intra-continental latency is less than 100 ms.<br></td>
  </tr>
	  <tr>
    <td>Compatibility</td>
    <td>Supports the following platforms:<li>iOS, Android (arm64, armv7, x86), macOS, Windows, Linux, and Web<br><li> Web: Chrome 49+, Firefox 52+, Safari 9+, Internet Explorer 11+<br><li>Java server and C++ server<br></td>
  </tr>
</table>


## Reference

When integrating the Agora RTM SDK, you can also refer to the following article:

- [Does the Agora RTM SDK have a limit on the number of concurrent online users?](https://docs.agora.io/en/faq/rtm_concurrency)