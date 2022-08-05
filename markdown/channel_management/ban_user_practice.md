This page introduces the instructions on how to use channel management RESTful APIs to ban user privileges (hereinafter referred to as RESTful APIs), including overall principles, recommended scenarios, unrecommended scenarios, and best practices of handling exceptions in calling APIs. 

<div class="alert info">For API reference, see <a href="./rtc_channel_management_restfulapi?platform=RESTful#%E5%B0%81%E7%A6%81%E7%94%A8%E6%88%B7%E6%9D%83%E9%99%90">Banning user privileges</a>.</div>

## Overall principles
Take the following principles into consideration when using the RESTful APIs:
1. Prevent your main business processes from strong reliance on the RESTful APIs.
2. Integrate the RESTful APIs prudently to avoid impact of API request failure on your main business processes.

## Recommended scenarios

### Ban illegal users by UID

#### Methods
Ban the user's privilege to join channels by UID. To do this, set `privileges` as `join_channel`, provide `uid`, leave `cname` and `ip` empty, and set `time` as `0`.

#### Use case
When you find illegal users and you cannot completely ban them with your signaling system, you can call the RESTful APIs to prevent them from entering any channel.

#### Consideration
When you cannot completely ban illegal users with your signaling system, the RESTful APIs can be an alternative method. However, you need to consider demands for lifting the ban. Generally, you should not integrate the logic of lifting bans into your main business processes, otherwise, failure to lift bans might impact your business.
- Correct way of lifting bans: lifting the ban when the banned user requests.
- Incorrect way of lifting bans: automatically lifting the ban when the banned user joins a channel. In this case, the user cannot join any channel if the API call to lifting the ban fails.


### Ban users' privilege to publish video or audio streams

#### Methods
Ban users' privilege to publish video or audio streams by UID. To do this, set `privileges` as `publish_audio` or `publish_video`, provide `uid`, leave `cname` and `ip` empty, and set `time` as any value than `0`.

#### Use case
When you find any user who have switched to an audience or who doesn't have the required privilege still can publish video or audio streams, you can call the RESTful APIs to prevent them from publishing the streams.

#### Consideration
- It can be risky to use the RESTful APIs to ban the user's privilege to publish video or audio streams. Use it as an alternative when your signaling system fail to notify the user to switch to an audience and it causes impact on your business processes.
- Consider the impact of delay or failure of API calls on publishing the streams when the user wants to switch to a host and you need to lift the ban.
- Set the ban time duration as short as possible.

<a name="kick_user" />

### Kick users from a channel

#### Methods
Kick users from a channel by UID and channel name. Kicking users means they are forced to leave the channel without being banned. They can still rejoin the channel. To do this, set `privileges` as `join_channel`, provide `uid` and `cname`, leave `ip` empty, and set `time` as `0`.

#### Use case
- A broadcaster have two devices, A and B. After logging in on device A, the broadcaster cannot find where device A is and uses device B to continue live streaming. Therefore, the two devices publish streams at the same time with the same UID, which causes exceptions. In this case, you can use this method to kick the broadcaster from the channel by UID. Device A won't reconnect to the channel, and the broadcaster only need to rejoin the channel on device B.
- Your signaling system fails to notify make users to leave the channel, and you can use this method to kick users from the channel.

#### Consideration
- Kicking users by setting `time` as `0` is a secured way of using the RESTful APIs. 
- If the SDK disconnects from the edge node service at the time the API request for kicking users reaches the edge node service, the API request fails. You can call the RESTful APIs again when the SDK reconnects with the edge node service.


### Dismiss the channel

#### Methods
When you want to dismiss the channel, you can kick all users from the channel by channel name. To do this, set `privileges` as `join_channel`, provide `cname`, leave `uid` and `ip` empty, and set `time` as `0`.

#### Use case
Use this method to dismiss the channel by kicking all users quickly. If the channel surely won't be reused for a specific time, you can also set `time` as `1` or larger.
<div class="alert note">Use <code>cname</code> as a kicking rule equals to destroying the channel. Ensure this serves your business purposes.</div>

#### Consideration
In this scenario, first use your signaling system to notify the SDK to call `leave channel` after the channel needs to be dismissed. Use this method as an alternative when your signaling system cannot meet your requirements. Avoid highly reliance on the RESTful API requests, otherwise, API request failures will have great impact on your business processes.
- If the channel won't be reused, you can set a reasonable ban time to prevent users from joining this channel after it's dismissed.
- If the channel will be reused on a specific date, ensure the ban is lifted before that date. Avoid setting a long ban time and lifting the ban until the channel is reused. Once the API request fails, users cannot join the channel.
- If the channel will be reused on a unknown date, it's recommended that you set `time` as `1`, or [Kick users from a channel](#kick_user) instead.


### Ban illegal IP

#### Methods
Ban users' privilege to join the channel by IP. To do this, set `privileges` as `join_channel`, provide `ip`, leave `cname` and `uid` empty, and set `time` as any value than `0`.

#### Use case
When your business process receives attacks and you identify the illegal IP, you can ban the IP with `ip`.

#### Consideration
Using IP as a kicking rule might impact innocent users in some cases such as multiple users share the same IP.


## Unrecommended scenarios

### Use RESTful APIs to control the host positions
Unrecommended practice: Ban the user's privilege to publish streams when the user switch to an audience, and lift the ban when the user switches to a host.

Reason: RTC services rely on the RESTful APIs. If the API requests for listing bans fails, the user cannot publish streams.

### Use RESTful APIs to manage user privileges to join the channel
Unrecommended practice: Ban the user's privilege to join the channel when the user leaves the channel, and lift the ban when the user rejoins the channel.

Reason: RTC services rely on the RESTful APIs. If the API requests for listing bans fails, the user cannot rejoin the channel. It's recommend use kicking user from the channel in this case.


## Best practice for handling API call exceptions

### Timeout settings
To respond to unstable internet connection, it's recommended you set the request timeout for client as 20s or larger (no smaller than 5s). For the retry requests, set the timeout as long as necessary to increase the request success rate under unstable internet connection.

### Retry request settings
You can decide whether you need retry requests and maximum time of retry requests based on your business logic.

If the request returns an error code equaled or larger than `500` or the request times out, you can retry the RESTful API request with incremental intervals between retry requests.

