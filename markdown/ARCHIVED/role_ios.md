---
title: 切换用户角色
platform: iOS
updatedAt: 2020-04-20 12:14:02
---
# 切换用户角色
直播频道分主播和观众两种用户角色。在将频道场景为直播后，调用 `setClientRole` 方法，并根据需要将用户设置为主播或观众。两者的区别在于：

- 主播：可以收听和发布音视频消息。根据应用程序的实现，还可以与观众互动、指定观众连麦。同一直播频道内，主播只能听到和看到自己以及连麦主播的音视频。
- 观众：只能收听主播的音视频消息。根据应用程序的实现，还可以发布实时文字消息，与主播互动。同一直播频道内，所有观众都能听到和看到主播以及连麦主播的音视频。

```objective-c
//Objective-C
- (void)setClientRole() {
  [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
}
```

```swift
//Swift
func setClientRole() {
  agoraKit.setClientRole(.broadcaster)
}
```

该方法在加入频道前后都可以调用：
- 加入直播频道前，调用该方法将用户设置为主播或观众。
- 直播过程中，调用该方法将用户角色由观众切换为主播（上麦），或由主播切换为观众。

以用户 A、B 为例。如果用户 A、B 均以主播身份加入频道：

1. 用户 A 调用 `setClientRole`，将角色设置为主播，然后调用 `joinChannelByToken` 加入频道。

   ```objective-c
   //Objective-C
   //设置用户角色为主播
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //创建并加入频道
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
   }
   ```

   ```swift
   //Swift
   //设置用户角色为主播
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //创建并加入频道
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
   ```

2. 用户 B 调用 `setClientRole`，将角色设置为主播，然后调用 `joinChannelByToken` 加入频道。A 和 B 现在可以连麦了！

   ```objective-c
   //Objective-C
   //设置用户角色为主播
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //创建并加入频道
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
   }
   ```

   ```swift
   //Swift
   //设置用户角色为主播
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //创建并加入频道
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
   ```

如果 A 以主播身份加入频道，B 以默认的观众身份加入频道，一段时间后  B 想要连麦：

1. 用户 A 调用 `setClientRole`，将角色设置为主播，然后调用 `joinChannelByToken` 加入频道。

   ```objective-c
   //Objective-C
   //设置用户角色为主播
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //创建并加入频道
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
   }
   ```

   ```swift
   //Swift
   //设置用户角色为主播
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //创建并加入频道
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
   ```

2. 用户 B 调用 `joinChannelByToken`，以默认的观众身份加入频道；然后调用 `setClientRole` 将用户角色切换为主播后进行连麦。

   ```objective-c
//Objective-C
//创建并加入频道
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
		 
   //设置用户角色为主播
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   ```
	 
	 ```swift
//Swift
 //创建并加入频道
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
	 
   //设置用户角色为主播
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   ```
