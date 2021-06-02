---
title: Agora Cloud Recording Changelog
platform: Linux
updatedAt: 2021-03-31 09:24:37
---
## Overview

Agora Cloud Recording is an add-on service to record and save voice calls, video calls, and interactive streaming on your cloud storage. Compared with Agora On-premise Recording, Agora Cloud Recording is more efficient and convenient as it does not require deploying Linux servers.

### Compatibility

Agora Cloud Recording is compatible with the following SDKs:

- Agora Native SDK v1.7.0 or later.
- Agora Web SDK v1.12 or later.

## 2020.09.11

This release improved the stability and performance of the recording service, and fixed the following issues:

- Failure to subscribe to a low-quality stream.
- Occasional failure to record a whole call.

## 2020.07.21

This release adds the following new feature and API changes:

**New feature**

#### ApsaraVideo for VoD
In composite recording mode, you can now upload recorded files to [ApsaraVideo for VoD](https://www.alibabacloud.com/help/doc-detail/51236.htm) for further processing.

**API changes**
- [`start`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/start) adds the `extensionServiceConfig` parameter for specifying the configurations of ApsaraVideo for VoD. 
- Adds the [`vod_started`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#60) and the [`vod_triggered`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#61) callbacks, which report the status of uploading recorded files to ApsaraVideo for VoD.


## 2020.06.12

**New features**

#### Flexible UID subscription

This release provides a more flexible UID subscription feature, enabling you to set up a whitelist or blacklist for audio and video subscriptions. You can also update the subscription lists during the cloud recording. For details, see [Set up subscription lists](https://docs.agora.io/en/cloud-recording/cloud_recording_subscription).

#### Callback for high availability

This release adds the [`session_failover`](/en/cloud-recording/cloud_recording_callback_rest#12) event, which occurs when the high availability mechanism is enabled and reports the new recording UID.

**API changes**

- In [`start`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/start) adds the `unSubscribeVideoUids` and `unSubscribeAudioUids` parameters for setting up subscription blacklists. 
- Adds [`update`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/update) for updating the subscription lists during the cloud recording.
- Adds the `session_failover` event.

## 2020.05.09
This release adds support for Kingsoft Cloud.

## 2020.04.17
Cloud Recording now supports taking screenshots of the video streams in individual recording mode. See [Capture Screenshots](/en/cloud-recording/cloud_recording_screen_capture) for details.

## 2019.12.16

This release improved the availability of the cloud recording service. When a server is disconnected or when the process is killed, the cloud recording automatically switches to a new server to resume the service. See [Fault processing when a cloud recording server is disconnected or the process killed](/en/faq/high-availability) for more information.

**API Changes**

In the [`acquire`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/acquire) method, adds the `resourceExpiredHour` parameter for setting the time limit for all cloud recording method calls.

Adds the [`session_exit`](/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name11a11-session_exit) event, which reports the exit status of the cloud recording service.


## 2019.11.15

You can now use the `query` method to get the names of the recorded files immediately after the recording starts.

## 2019.10.24

This release supports Tencent Cloud as one of the third-party cloud storages.

## 2019.10.08

**New features**

#### 1. Individual recording

The RESTful API adds individual recording mode, which supports recording the audio and video of each UID separately. See [Individual Recording](/en/cloud_recording/cloud_recording_individual_mode) for details. Meanwhile, Agora provides the Audio & Video File Merging script, which you can use to merge the audio and video files generated in individual mode. See [Merge Audio and Video Files](/en/cloud_recording/cloud_recording_merge_files) for details.

#### 2. Record specified UIDs

The RESTful API adds the `subscribeAudioUids` and `subscribeVideoUids` parameters, which allow you to record only specified UIDs.

#### 3. Customize the directory of the recorded files

The RESTful API adds the `fileNamePrefix` parameter, which allows you to specify the directory where you want to store the recorded files in the third-party cloud storage.

#### 4. Timestamp when the stream state changes

The RESTful API callback service adds the `recorder_audio_stream_state_changed` and `recorder_video_stream_state_changed` events to report the time when the state of the audio or video stream changes, as well as the corresponding UID.

#### 5. Format Converter script

Agora provides the Format Converter script, which you can use to convert between multiple file formats, such as TS, MP3, and MP4. See [Convert File Format](/en/cloud_recording/cloud_recording_convert_format) for details.

#### 6. Synchronized playback

You can achieve synchronized playback between the recorded files and other stream files, such as online whiteboards, courseware, and messages, by using the timestamp when the recording starts. You can get the timestamp by using the RESTful API callback service, or by parsing the M3U8 file. See [Synchronized Playback](/en/cloud_recording/cloud_recording_playback) for details.

**Improvement**

When an error occurs, you receive the error message in the HTTP response body, instead of just the error code. See [Agora Cloud Recording RESTful API](/en/cloud-recording/cloud_recording_api_rest#errors) for detailed information about the error codes.

**Fixed issue**

When uploading fails after you use the wrong `bucket` and `key` values of the third-party cloud storage, Agora Cloud Recording returns an error instead of uploading the recorded files to Agora Cloud Backup.


## 2019.07.22

**New features**

#### Customized video layout

The RESTful API adds a customized layout for the recording video. See [Set Video Layout](/en/cloud-recording/cloud_recording_layout#custom) for details.

You can set the `mixedVideoLayout` parameter as `3` and set the regions for each user in the `layoutConfig` parameter when starting a recording.

You can update the layout anytime during the recording by the `updateLayout` method.

#### Customized background color

The RESTful API adds the `backgroundColor` parameter to support customized background colors for the video layout. 

#### Timestamps

To get the accurate starting time of a recording, the RESTful API provides the Unix timestamp of when the first slicing starts in the response of the `query` method.  The RESTful API callback service adds the `recorder_slice_start` event to report the time when the first slicing starts and the time when the last recording fails.

**Improvement**

Optimizes the verification of whether `resourceId` corresponds with `uid` and `cname` when calling the RESTful API.

**Fixed issue**

Fixed minor issues in the default video layout (floating layout).

## 2019.07.02

- Changes the default background color in the composite layout to black.
- Reduces video freeze under poor network conditions.

## 2019.06.13

This release supports RESTful APIs. With the RESTful APIs, you can use Agora Cloud Recording through HTTP requests without integrating the SDK.

See the following documents for details:

- [RESTful API Quickstart](./cloud_recording_rest): Start cloud recording with RESTful APIs.
- [RESTful API Reference](./cloud_recording_api_rest): Details of the RESTful API methods.
- [RESTful API Callback Service](./cloud_recording_callback_rest): Enable the callback service to receive notifications of Agora Cloud Recording. 

## 2019.04.30

This is the first release of Agora Cloud Recording with the following functions:

- High-quality voice and video recordings.
- Mixed-stream voice and video recordings of all users in a channel.
- Three composite video layouts: float (default), best fit, and vertical.
- Third-party cloud storage. Agora Cloud Recording supports Amazon S3, Alibaba Cloud, and Qiniu Cloud.
- Provides C++ and Java SDK packages.