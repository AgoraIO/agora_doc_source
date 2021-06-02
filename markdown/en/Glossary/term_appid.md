---
title: App ID
platform: All Platforms
updatedAt: 2020-07-03 20:47:04
---
App ID is a random string created within [Agora Console](https://console.agora.io/) and is the unique identifier of an app. 

Agora uses App ID to identify each app and provides billing and other statistical data services based on it. After signing up within Agora Console, you can create multiple apps, each with a unique App ID. When initializing a client, you need to pass an App ID as an argument. Clients created by different App IDs cannot communicate with each other. 

<div class="alert warning">For situations requiring high security, such as in a production environment, you must use a token for user authentication; otherwise, your environment is open to anyone who has your App ID.</div>

<div class="alert info">References: <li><a href="#console">Agora Console</a></li><li><a href="https://docs.agora.io/en/Agora%20Platform/token#getappid">Get an App ID</a></li><li><a href="https://docs.agora.io/en/Agora%20Platform/token#appcertificate">Enable the App Certificate</a></li><li><a href="https://docs.agora.io/en/Agora%20Platform/token#temptoken">Get a temporary token</a></li><li><a href="https://docs.agora.io/en/Interactive%20Broadcast/token_server_cpp">Get a token</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>