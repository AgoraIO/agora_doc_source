---
title: What causes the 101 error in Cloud Recording SDK?
platform: ["RESTful"]
updatedAt: 2020-07-09 11:38:55
Products: ["cloud-recording"]
---
The `"ErrorUint32":101` error in the log file is usually caused by a token error, such as in the following situations:

- A wrong token.
- An expired token.
- The Native/Web SDK uses a token while the cloud recording does not use a token.
- The cloud recording uses a token while the Native/Web SDK does not use a token.