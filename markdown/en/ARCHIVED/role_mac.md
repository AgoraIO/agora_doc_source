---
title: Switch the Client Role
platform: macOS
updatedAt: 2020-04-20 12:14:34
---
# Switch Client Role
A live broadcast channel consists of two user roles: 

- Host (Broadcaster): A host receives and publishes the voice/video streams, and interacts with other hosts using voice and video.
- Audience: An audience receives the voice and video streams of the hosts.

You can call the `setClientRole` method to set the user role.


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

> You can call the `setClientRole` method before joining a live broadcast channel or during a live broadcast:
> 
>  - Before joining the channel: Set the client role as the host or audience.
>  -  During a live broadcast: Switch the user role from an audience to the host or vice versa.

If two users join a live broadcast channel as hosts:

1. User A calls the `setClientRole` method to set the user role as the host, and calls the `joinChannelByToken` method to join a channel.

   ```objective-c
   //Objective-C
   //Set the user role as the host.
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //Create and join a channel.
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
   }
   ```

   ```swift
   //Swift
   //Set the user role as the host.
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //Create and join a channel.
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
   ```
	 
2. User B calls the `setClientRole` method to set the user role as the host, and calls the `joinChannelByToken` method to join a channel.

   ```objective-c
   //Objective-C
   //Set the user role as the host.
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //Create and join a channel.
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join the "demoChannel1" channel.
     }];
   }
   ```

   ```swift
   //Swift
   //Set the user role as the host.
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //Create and join a channel.
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join "demoChannel1" channel.
     }
   }
   ```

User A joins the channel as a host and user B joins as an audience. If user B wants to switch to a host:

1. User A calls the `setClientRole` method to set the user role as the host, and calls the `joinChannelByToken` method to join a channel.

   ```objective-c
   //Objective-C
   //Set the user role as the host.
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   
   //Create and join a channel.
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
   }
   ```

   ```swift
   //Swift
   //Set the user role as the host.
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   
   //Create and join a channel.
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join channel "demoChannel1"
     }
   }
   ```

2. User B calls the `joinChannelByToken` method to join the channel as an audience, and calls the `setClientRole` method to switch the user role to the host.

   ```objective-c
//Objective-C
//Create and join a channel.
   - (void)joinChannel {
     [self.agoraKit joinChannelByToken:nil channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
       // Join channel "demoChannel1"
     }];
		 
   //Set the user role as the host.
   - (void)setClientRole() {
     [self.agoraKit setClientRole:AgoraClientRoleBroadcaster]
   })
   ```
	 
   ```swift
 //Swift
//Create and join a channel.
   func joinChannel() {
     agoraKit.joinChannel(by Token: nil, channelId: "demoChannel1", info:nil, uid:0){[weak self] (sid, uid, elapsed) -> Void in
         // Join the "demoChannel1" channel.
     }
   }
	 
   //Set the client role as the host.
   func setClientRole() {
     agoraKit.setClientRole(.broadcaster)
   }
   ```
