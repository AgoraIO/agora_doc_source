---
title: Does the Agora RTM SDK have a limit on the number of concurrent online users and the frequency of sending channel messages?
platform: ["Android","iOS","macOS","Web","Windows","Linux","RESTful"]
updatedAt: 2020-12-11 09:05:14
Products: ["Real-time-Messaging"]
---
The Agora RTM SDK does not have a limit on the number of concurrent online users. However, Agora has the following recommendations on the maximum number of channel messages per second for a single channel:

| Concurrent online users in a single channel | Number of channel messages per second |
| ------------------------------------------- | ----------------------------- |
| &lt; 1,000                                  | &lt; 200                      |
| &ge; 1,000 and &lt; 10,000                  | &lt; 100                      |
| &ge; 10,000                                 | &lt; 30                       |


<div class="alert note"><ul><li>If the number of messages per second exceeds the recommended values, latency can increase significantly and may also cause the following issues: <ul><li>The user cannot send or receive messages.</li><li>The user always stays in the RECONNECTING state or keeps switching between the CONNECTED state and the RECONNECTING state. For other users, the current user may appear offline.</li></ul></li><li>Agora provides customized service to increase the number of messages per second without affecting latency or stability. Please contact <a href="mailto:support@agora.io">support@agora.io</a> for more information. </li></ul></div>