---
title: In RTM SDK, does the call frequency limit refer to the limit of one client instance?
platform: ["Android","iOS","macOS","Web","Windows","Linux","RESTful"]
updatedAt: 2020-11-02 16:15:20
Products: ["Real-time-Messaging"]
---
In RTM SDK, the call frequency limit refers to the limit of one client instance.

- For the native platform, you can increase the call limit of an API by creating multiple client instances. 
- For the web platform, we <b>do not recommend</b> increasing the call limit by creating multiple client instances. 