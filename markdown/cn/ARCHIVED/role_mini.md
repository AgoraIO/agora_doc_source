---
title: 切换用户角色
platform: 微信小程序
updatedAt: 2018-11-02 12:18:44
---
使用 `setRole` 方法设置用户角色。

```
client.setRole(role);
```

> 该方法必须在 [加入频道](./join_live_mini) 前调用才能生效。如果用户已经在频道中，则需要先退出频道，使用该方法设置好用户角色后，再次加入频道。
