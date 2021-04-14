---
title: Set Video Layout
platform: Linux
updatedAt: 2021-03-31 09:09:25
---
## Overview

In composite recording mode, Agora Cloud Recording provides the following predefined layout types:

- [Floating Layout](#float): (Default) The stream of the first user in the channel occupies the full canvas. The streams of other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports one full-size region and up to four rows of small regions on top with four regions per row, comprising 17 regions.
- [Best Fit Layout](#bestfit): This is a grid layout. The number of columns and rows and the grid size vary depending on the number of users in the channel. This layout supports up to 17 streams.
- [Vertical Layout](#vertical): One large region is displayed on the left edge of the canvas, and several smaller regions are displayed along the right edge of the canvas. The space on the right supports up to 2 columns of small regions with 8 regions per column. This layout supports up to 17 streams.

## Implementation

You can select from the predefined layout types by setting relevant parameters when you start cloud recording.

- If you use the [Agora Cloud Recording SDK](./cloud_recording_quickstart?platform=CPP), set the `layout` parameter in [`TranscodingConfig`](./cloud_recording_api#TranscodingConfig) when calling the [`StartCloudRecording`](./cloud_recording_api#StartCloudRecording) method.
- If you use the [Agora Cloud Recording Demo](./cloud_recording_demo?platform=CPP), set the `—mixedVideoLayoutType` parameter.

## Predefined Layout Types

This section describes the predefined layout types in details.

These layout types support a maximum of 17 streams.

- If there are more than 17 users in the channel, only the videos of the first 17 users are visible.
- If a user sends only an audio stream, the user occupies a region.
- The numbers in the following figures indicate the order of the users joining the channel. If user 1 leaves the channel, user 2 takes over user 1's region, and so on.

### <a name="float"></a>Floating Layout

This is the default layout, where small regions are on top of a full-size region. The stream of the first user in the channel occupies the full canvas. The streams of other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports up to 4 rows of regions on top with 4 regions per row.

- If a user sends only an audio stream, the user's region is transparent.
- If the aspect ratio of a user's video does not match that of the user's region, the video is letterboxed to fit within the region.
- The width and height of each small region are 23.5% of those of the canvas. The gaps between two horizontally or vertically adjacent regions are 1.2 % of the width and height of the canvas respectively. The gap between the bottom row and the border-bottom is 1.2 % of the height of the canvas, and the left-hand/right-hand margin is also 1.2 % of the width of the canvas.

See the following pictures for the layouts with different number of users in the channel.

#### 1 User

![img](https://confluence.agora.io/download/thumbnails/321323097/image2019-5-16_15-10-7.png?version=1&modificationDate=1557990615369&api=v2)

#### 2 to 5 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2019-5-16_15-10-37.png?version=1&modificationDate=1557990645667&api=v2)

#### 6 to 9 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2019-5-16_15-11-1.png?version=1&modificationDate=1557990670140&api=v2)

#### 10 to 13 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2019-5-16_15-11-22.png?version=1&modificationDate=1557990690258&api=v2)

#### 14 to 17 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2019-5-16_15-8-44.png?version=1&modificationDate=1557990532458&api=v2)

### <a name="bestfit"></a>Best Fit Layout

This is a grid layout. In this layout, the grid size varies depending on the number of users in the channel.

- The region which is not occupied by any user shows the background color.
- If a user sends only an audio stream, the user's region shows the background color.
- If the aspect ratio of a user's video does not match that of the user's region, the video is cropped to fit within the region.

See the following pictures for the layouts with different number of users in the channel.

#### 1 to 4 Users

![](https://web-cdn.agora.io/docs-files/1558062852403)

![](https://web-cdn.agora.io/docs-files/1558063212804)

![img](https://confluence.agora.io/download/thumbnails/321323097/image2018-3-2_15-13-11.png?version=1&modificationDate=1519974797896&api=v2)

![](https://web-cdn.agora.io/docs-files/1558063229612)

#### 5 to 9 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2018-3-2_15-17-58.png?version=1&modificationDate=1519975084235&api=v2)

#### 10 to 16 Users

![img](https://confluence.agora.io/download/thumbnails/321323097/image2018-3-2_15-22-34.png?version=1&modificationDate=1519975360819&api=v2)

#### 17 Users

The best fit layout for 17 users in a channel is unique.

As shown in the following figure, the regions are displayed across the middle of the canvas with bands on the left and right of the canvas. The width and height of each region are 20% of those of the canvas respectively, while the width of the two bands is 10% of that of the canvas. The 17th region is placed in the middle of the bottom row.

![img](https://confluence.agora.io/download/thumbnails/321323097/image2018-3-2_16-56-35.png?version=1&modificationDate=1519981001505&api=v2)

### <a name="vertical"></a>Vertical Layout

In this layout, one large region is displayed on the left edge of the screen, and several smaller regions are displayed along the right edge of the screen.

Therefore, when you start cloud recording, you must specify a uid, whose region is displayed on the left edge of the screen in a large size.  If you use the [Agora Cloud Recording SDK](./cloud_recording_quickstart?platform=CPP), set the `max_resolution_uid` parameter in [`TranscodingConfig`](./cloud_recording_api#TranscodingConfig)  when calling the [`StartCloudRecording`](./cloud_recording_api#StartCloudRecording) method; and if you use the [Agora Cloud Recording Demo](./cloud_recording_demo?platform=CPP), set the `—maxResolutionUid` parameter.

This layout supports up to two columns of small regions on the right edge with eight regions per column. 

- In the following figures, "Large" refers to the large region, displaying the video of the specified user. If you do not specify a user or the specified user does not join the channel, the "Large" region shows the background color.
- The small regions are tiled in the order of the users joining the channel. If user small 1 leaves the channel, user small 2 takes over user small 1's region, and so on.
- The region which is not occupied by any user shows the background color.
- If a user sends only an audio stream, the user's region shows the background color.
- If the aspect ratio of a user's video does not match that of the user's region, the video is letterboxed to fit within the region.

#### 1 to 5 Users

The regions of users small 1 to small 4 are tiled along the right edge of the canvas. The width and height of the small region are one-fifth and one-fourth of those of the canvas respectively.

![](https://web-cdn.agora.io/docs-files/1558060680455)

#### 6 to 7 Users

The regions of users small 1 to small 6 are tiled along the right edge of the canvas. The width and height of the small region are one-seventh and one-sixth of those of the canvas respectively.

![](https://web-cdn.agora.io/docs-files/1558060697541)

#### 8 to 9 Users

The regions of users small 1 to small 8 are tiled along the right edge of the canvas. The width and height of the small region are one-ninth and one-eighth of those of the canvas respectively.

![](https://web-cdn.agora.io/docs-files/1558060714296)

#### 10 to 17 Users

The regions of users small 1 to small 16 are tiled along the right edge of the canvas. The width and height of the small region are one-tenth and one-eighth of those of the canvas respectively.

![](https://web-cdn.agora.io/docs-files/1558060732460)