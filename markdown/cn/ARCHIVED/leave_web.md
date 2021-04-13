---
title: 离开频道
platform: Web
updatedAt: 2019-10-29 12:00:19
---
# 离开频道
使用 `client.leave` 方法让用户离开当前通话或直播（频道）。

```javascript
client.leave(function () {
  console.log("Leave channel successfully");
}, function (err) {
  console.log("Leave channel failed");
});
```