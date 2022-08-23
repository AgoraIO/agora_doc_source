This page introduces using channel management RESTful APIs to ban user privileges, including overall principles, scenario recommendations, and best practices for handling exceptions. 

<div class="alert info">For API reference, see <a href="./rtc_channel_management_restfulapi?platform=RESTful#%E5%B0%81%E7%A6%81%E7%94%A8%E6%88%B7%E6%9D%83%E9%99%90">Banning user privileges</a>.</div>

## Overall principles
Take the following principles into consideration when using the RESTful APIs:
1. Prevent your main business processes from strong reliance on the RESTful APIs.
2. Integrate the RESTful APIs prudently to avoid the impact of API request failure on your main business processes.

## Recommended scenarios
Using the RESTful APIs to ban user privileges is recommended for the following scenarios.

### Ban an illegal user by User ID

#### Methods
Ban the user's privilege to join channels by user ID. To do this, set `privileges` as `join_channel`, provide `uid`, leave `cname` and `ip` empty, and set `time` as `0`.

#### Use case
When you find illegal users and you cannot completely ban them with your signaling system, you can call the RESTful APIs to prevent them from entering any channel.

#### Consideration
When you cannot completely ban illegal users with your signaling system, the RESTful APIs can be an alternative method. However, you need to consider demands for lifting the ban. Generally, you should not integrate the logic of lifting bans into your main business processes; otherwise, failure to lift bans can impact your business processes.
- The correct way to lift a ban is to do so when the banned user makes a request to join a channel.
- Automatically lifting a ban when the banned user joins a channel is not recommended, because the user cannot join any channels if the API call to lift the ban fails.


### Ban a user's privilege to publish video or audio streams

#### Methods
Ban the user's privilege to publish video or audio streams by user ID. To do this, set `privileges` as `publish_audio` or `publish_video`, provide `uid`, leave `cname` and `ip` empty, and set `time` as any value than `0`.

#### Use case
When you find a user who has switched roles to audience member or who does not have the required privilege and yet can still publish video or audio streams, you can call the RESTful APIs to prevent them from publishing the streams.

#### Consideration
- It can be risky to use the RESTful APIs to ban the user's privilege to publish video or audio streams. Use it as an alternative when your signaling system fails to notify the user to switch roles to audience member and this causes impact on your business processes.
- Consider the impact of delay or failure of API calls on publishing the streams when the user wants to switch roles to host and you need to lift the ban.
- Set the duration of the ban to be as short as possible..

<a name="kick_user" />

### Kick a user from a channel

#### Methods
Kick a user from a channel by user ID and channel name. Kicking users means they are forced to leave the channel without being banned. They can still rejoin the channel. To do this, set `privileges` as `join_channel`, provide `uid` and `cname`, leave `ip` empty, and set `time` as `0`.

#### Use case
- A broadcaster has two devices, A and B. After logging in and starting live-streaming on device A, the broadcaster cannot find device A and uses device B to continue live streaming. This results in the two devices publishing streams in the same channel at the same time with the same user ID, which causes exceptions. In this case, you can use this method to kick the broadcaster from the channel by user ID. This logs both devices from the channel, and the broadcaster only needs to rejoin the channel on device B.
- Your signaling system fails to notify users to leave the channel, and you can use this method to kick users from the channel.

#### Consideration
- Kicking users by setting `time` as `0` is a secured way of using the RESTful APIs. 
- If the SDK disconnects from the edge node service at the time the API request for kicking users reaches the edge node service, the API request fails. You can call the RESTful APIs again when the SDK reconnects with the edge node service.


### Dismiss the channel

#### Methods
When you want to dismiss the channel, you can kick all users from the channel by channel name. To do this, set `privileges` as `join_channel`, provide `cname`, leave `uid` and `ip` empty, and set `time` as `0`.

#### Use case
Use this method to dismiss the channel by kicking all users quickly. If you are certain that the channel is not going to be reused for a specific amount of time,
<div class="alert note">Using <code>cname</code> to kick users from a channel is the same as destroying the channel. Make sure this this serves your business purposes.</div>

#### Consideration
In this scenario, first use your signaling system to notify the SDK to call `leave channel` after the channel needs to be dismissed. Use this method as an alternative when your signaling system cannot meet your requirements. Avoid relying too heavily on the RESTful API requests; otherwise, API request failures can significantly impact your business processes.
- If the channel is not going to be reused, you can set a reasonable duration for the ban to prevent users from rejoining this channel after it is dismissed.
- If the channel is going to be reused on a specific date, ensure the ban is lifted before that date. Avoid setting a long ban duration or lifting the ban until the channel is reused. If the API request fails, users cannot join the channel.
- If the channel is going to be reused, but the date is not known, Agora recommends that you set `time` as `1`, or use [Kick users from a channel](#kick_user) instead.


### Ban illegal users by IP address

#### Methods
Ban users' privilege to join the channel by IP. To do this, set `privileges` as `join_channel`, provide `ip`, leave `cname` and `uid` empty, and set `time` as any value than `0`.

#### Use case
If your business process is attacked and you identify the illegal IP, you can ban the IP with `ip`.

#### Consideration
Using IP to ban users can impact innocent users in some cases, such as when multiple users share the same IP.


## Unsuitable scenarios
Using the RESTful APIs to ban user privileges is not recommended for the following scenarios.
### Using RESTful APIs to control privilege by role
Agora does not recommend that you ban a user's privilege to publish streams when they switch their role to audience member and lift the ban when they switch their role to host. Because RTC services rely on the RESTful APIs, if the API requests for listing bans fail, the user cannot publish streams.

### Using RESTful APIs to manage user privileges to join the channel
Agora does not recommend that you ban the user's privilege to join the channel when the user leaves the channel and lift the ban when the user rejoins the channel. Because RTC services rely on the RESTful APIs, if the API requests for listing bans fail, the user cannot rejoin the channel. Agora recommends that you use [Kick users from a channel](#kick_user).


## Best practices for handling API call exceptions

### Timeout settings
To respond to unstable internet connection, Agora recommends that you set the request timeout for client as 20 seconds or more (and not less than 5 seconds). For the retry requests, set the timeout as long as necessary to increase the request success rate under an unstable internet connection.

### Retry request settings
You can decide whether you need retry requests and the maximum time of retry requests based on your business logic.

If the request returns an error code greater than or equal to `500` or the request times out, you can retry the RESTful API request with incremental intervals between retry requests.

