## Overview

Agora Cloud Recording is an add-on service to record and save voice calls, video calls, and interactive streaming on your cloud storage. Compared with Agora On-premise Recording, Agora Cloud Recording is more efficient and convenient as it does not require deploying Linux servers.

### Compatibility

Agora Cloud Recording is compatible with the following SDKs:

- Agora Native SDK v1.7.0 or later.
- Agora Web SDK v1.12 or later.

## 2022.11.20

This release adds the following improvements:

- Improves player compatibility for MPD files generated in individual recording `standard` mode, see [Recording configuration](https://docs.agora.io/en/cloud-recording/reference/rest-api/start#recording-configuration).
- Optimizes the Agora Format Converter Script for individual recording, see [Merge audio and video files](https://docs.agora.io/en/cloud-recording/develop/merge-files).

## 2022.10.20

This release supports the postpone transcoding feature globally. You need to set the scene field to `2` (postpone transcoding) when calling the `acquire`. After setting this scene, the recording service transcodes the recorded file within 24 hours after recording to generate an MP4 file, and upload the MP4 file to the third-party cloud storage you specify. Please note that the `region` of the third-party cloud storage must be consistent with the `region` set when calling `acquire`. For details, see [Individual recording](https://docs.agora.io/en/cloud-recording/develop/individual-mode).

## 2022.8.12
This release adds support for Amazon S3 in some regions. See [Cloud storage configuration](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#cloud-storage-configuration).

## 2022.5.20

This release adds the following new feature and API changes:

**Mobile web page mode for web page recording**

This release adds mobile web page mode for web page recording. The API changes are as follows:

- Adds the `mobile` field in `extensionServiceConfig`. After setting `mobile` to `true`, the recording service uses the mobile web page mode to record the current web page.
- The value range of the `videoWidth` and `videoHeight` fields in `extensionServiceConfig` is changed to [240, 1920].

**Transcoder script for high availability mechanism**

In composite recording mode, Agora provides a Transcoder script for merging the old M3U8 file with the new M3U8 file generated after the service enables the high availability mechanism into an MP4 file. For details, see [Manage Recorded Files](https://docs.agora.io/en/cloud-recording/cloud_recording_manage_files?platform=RESTful#when-a-server-is-disconnected-or-the-process-killed).

## 2022.1.20
#### New features

**Individual Audio Non-transcoding Recording**

In order to meet the diverse recording needs of users, this release adds the [`streamMode`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#recording-configuration) parameter in the `start` method to support [Individual Audio Non-transcoding Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_individual_nontranscoding?platform=RESTful). 

**Postpone Audio Mixing**
For voice chat scenarios, this release adds the [`appsCollection`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#application-configuration) and [`transcodeOptions`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#transcoding-configuration) parameters in the `start` method to support [Postpone Audio Mixing](https://docs.agora.io/en/cloud-recording/cloud_recording_individual_nontranscoding?platform=RESTful#implement-an-postpone-audio-mixing). If you enable this function, the recording service merges and transcodes the recorded files of all user IDs in the specified channel within 24 hours after the recording ends to generate an MP3/M4A/AAC file, and then uploads the recording file to your specified third-party cloud storage.

**A Combined audio and video file after individual recording**

When calling `start`, set the `streamMode` field of the [`recordingConfig`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#recording-configuration) parameter to `standard`, you can get a M3U8 audio index file, a M3U8 video index file and a combined M3U8 audio and video index file. If VP8 encoding is used on the web side, a combined MPD audio and video index file are generated.
You can play the combined audio and video index file directly without using script. Agora recommends that you use this mode.

**Support for the third-party cloud storage service encrypting and labeling recording files**

This release adds the [`extensionParams`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_start?platform=RESTful#cloud-storage-configuration) field to support the third-party cloud storage service to encrypt and tag uploaded recording files. This feature is applicable to Amazon S3 and Alibaba Cloud OSS.
## 2021.12.09

#### New features

This release adds support for Alibaba Cloud (`vendor` is `2`) in the following regions:
- `19`：AP_Southeast_6	
- `20`：CN_Heyuan	
- `21`：CN_Guangzhou		
- `22`：CN_Chengdu

For details, see <a href="https://www.alibabacloud.com/help/doc-detail/31837.html">Alibaba Cloud Documentation</a>.

#### Fixed issues

This release fixed the following issue:

When a composite recording started, the user to be recorded did not send streams. When the user sent streams, the user could not display the customized background image or background color after they stopped sending streams or left the channel.


## 2021.10.29

#### Compatibility

**Support for AES-GCM2 encryption**

For scenarios requiring high security, to guarantee the confidentiality, integrity, and authenticity of the data and to improve the computational efficiency of the data encryption, this release adds the following options in `recordingConfig`:

- `AES_128_GCM2` and `AES_256_GCM2` encryption modes in `decryptionMode` of `recordingConfig`. The new GCM encryption modes use a more secure KDF (Key Derivation Function) and support setting the key and salt.
- The `salt` parameter in `recordingConfig` to add the salt for the `AES_128_GCM2` and `AES_256_GCM2` encryption modes.

#### New features

**Push media stream to the CDN during a web page recording**

Adds support for converting the content and audio of a web page into a media stream and pushing it to the CDN during the web page recording. See the [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#start-start-cloud-recording), [`update`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#update-update-the-cloud-recording) and [`query`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#query-query-the-recording-status) methods of the Agora Cloud Recording RESTful API for details.

**Third-party cloud storage**

Adds support for [Google Cloud](https://cloud.google.com/), [Huawei Cloud](https://www.huaweicloud.com/intl/en-us/) and [Baidu AI Cloud](https://intl.cloud.baidu.com/) as third-party storage platforms.

#### Improvements

**Capture screenshots**

This release increases the range of the captureInterval of snapshotConfig (in seconds) to [1,3600] from [5,3600] when using the Cloud Recording RESTful API to take screenshots of a video stream.

**Output video resolution**

This release increases the upper limit of the output video resolution generated by the web page recording from 1280 x 720 to 1920 x 1080. That is, the range of the `videoWidth` and `videoHeight` parameters of the web page recording in `extensionServiceConfig` is changed to [480, 1920].

**The estimated maximum number of subscribed users**

To support a larger estimated maximum number of subscribed users, this release adds the following enumeration values of `subscribeUidGroup` in `recordingConfig`:

- `4`: 17 to 32 user IDs
- `5`: 32 to 49 user IDs

## 2021.09.06

#### Compatibility changes

The new server version requirements for transcoding recorded files are as follows:

- CentOS 7.0 and later x64
- Ubuntu 14.04 and later x64
- Debian 8.0 and later

#### New features

**Web page load timeout detection**

In order to ensure the validity and completeness of page recording, this version supports page load timeout detection function. See [Web Page Load Timeout Detection](https://docs.agora.io/en/cloud-recording/cloud_recording_webpage_load_timeout?platform=RESTful).

**Pause the page recording**

This release adds the `onhold` parameter to the [`start`](/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#start-start-cloud-recording) and [`update`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#update-update-the-cloud-recording) methods, which is used to pause the recording when the web page recording starts or is in progress.

**Capture screenshots and recording in a recording process**

This release adds support for recording and taking screenshots in a recording process. Only the recording fee is charged. See [Capture Screenshots](/en/cloud-recording/cloud_recording_screen_capture?platform=RESTful).

#### Improvements 

- [`The web_recorder_stopped`](/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name71a71-web_recorder_stopped) callback adds error codes and error messages to indicate the reason for the abnormal stop of the web page recording. You can take corresponding measures based on the information.
- The [`update`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#update-update-the-cloud-recording) method adds the `webRecordingConfig` parameter, which is used to update related parameters during a web page recording.

## 2021.07.30
This release includes the following new feature and API changes:

**Screenshot event notification**

This release adds the [`recorder_snapshot_file`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#45-recorder_snapshot_file) callback，which indicates that the screenshot is captured successfully, and returns the name of the screenshot file.

**New regions for Amazon S3 cloud storage**

This release adds support for Amazon S3 in the following regions:

- `20`: AP_NORTHEAST_3
- `21`: EU_NORTH_1
- `22`: ME_SOUTH_1
- `23`: US_GOV_EAST_1

## 2021.07.07

#### New features

This release adds `maxVideoDuration` to the [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestartastart-cloud-recording) method to set the maximum duration of the MP4 slice file generated by the web page recording.

#### Improvements

When the page status is a `404` or `5XX` error, the page recording service automatically exits to avoid continuing to record the error page.

#### Fixed issues

This release fixes an issue where audio was occasionally lost during a web page recording.

## 2021.06.10

This version was released on June 10, 2021.

#### New features

**Network Geofencing**

This release adds the `region` parameter to the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-nameacquireaget-a-resource-id) method so you can geofence your cloud recording service. If you specify a region, the cloud recording server connects only to the Agora servers within that region. The following regions are supported:

- Mainland China
- Asia, excluding Mainland China
- North America
- Europe

**Third-party cloud storage**

This release adds support for Microsoft Azure as a third-party storage solution.

#### Improvements

This release optimizes the encoding settings for the web page recording, which reduce the bit rate without losing video quality.

#### Fixed issues

Fixed security issues caused by vulnerabilities in Chrome V8.

#### API changes

- Adds the `region` parameter in the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-nameacquireaget-a-resource-id) method.
- Adds `recorderStartTime` in the [`web_recorder_started`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name70a70-web_recorder_started) callback.
- Adds the [`web_recorder_reload`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name73a73-web_recorder_reload) callback.

## 2021.04.29

This version was released on April 29, 2021.

**New features**

#### MP4 format in composite recording mode

From this release, you can get MP4 files after a composite recording. Set `avFileType` as `["hls","mp4"]` when you call the start method, and the recording service generates MP4 files once a recording starts.

#### AES-GCM encryption

For scenarios requiring high security, to guarantee the confidentiality, integrity, and authenticity of the data and to improve the computational efficiency of the data encryption, this release adds the following options in `decryptionMode`:

- 128-bit AES encryption, GCM mode.
- 256-bit AES encryption, GCM mode.

Once you enable the built-in encryption, all users in the same channel must use the same encryption mode and key.

**Improvement**

From this release, the recording service automatically detects and resolves the occasional audio loss issue during a web page recording, which causes the recorded page to refresh. If necessary, you need to guarantee that the status of your web application remains the same before and after a refresh.

**API changes**

- Adds enumerators `5` and `6` for `decryptionMode` in the [`start`](./cloud_recording_api_rest?platform=RESTful#start) method.
- Adds the `fileList` field in the [`uploaded`](./cloud_recording_callback_rest?platform=RESTful#31) and [`backuped`](./cloud_recording_callback_rest?platform=RESTful#32) callbacks.

## 2021.03.31

This version was released on March 31, 2021.

**New feature**

#### Background images

In composite recording mode, you can set the background image for both the video canvas and an individual user region. You can update the background image during a recording session. See [Set the background color or background image](./cloud_recording_layout?platform=RESTful#background) for details.

**Improvement**

- Adds a retry logic for Kingsoft Cloud, in which the recording service retries if it fails to upload recorded files to Kingsoft Cloud.

**Fixed issues**

- Occasional file loss when uploading slice files to Tencent Cloud Object Storage (COS).
- In a web page recording, the recording service could not render emoji.
- When recording a static web page, the recording occasionally failed when the value of `videoFps` was too high.

**API changes**

- Adds the `backgroundImage`, `defaultUserBackgroundImage` and `backgroundConfig` fields in the `transcodingConfig` parameter of the [`start`](./cloud_recording_api_rest?platform=RESTful#start) method.
- Adds the `backgroundImage`, `defaultUserBackgroundImage` and `backgroundConfig` fields in the `clientRequest` parameter of the [`updateLayout`](./cloud_recording_api_rest?platform=RESTful#updateLayout) method.
- Adds the `fileList` field in the [`web_recorder_stopped`](./cloud_recording_callback_rest?platform=RESTful#71) callback.

## 2021.02.05
This release raises the maximum resolution of video sources for [web page recording](https://docs.agora.io/en/cloud-recording/cloud_recording_webpage_mode?platform=RESTful). The recorded web page can now contain video that has a resolution of up to of 1920 × 1080. 

## 2020.12.10
This release includes the following new feature and API changes:

#### New feature

Adds [web page recording](https://docs.agora.io/en/cloud-recording/cloud_recording_webpage_mode) mode. In this mode, the content and audio of a specified web page are recorded in a single file.

#### API changes

- Adds `web` as a value for `mode` in the request URL for web page recording.
- Adds `scene` as a new parameter in the `acquire `method for setting the application of the cloud recording resources.
- Adds `"web_recorder_service"` as an extension service in the `extensionServiceConfig` parameter of the [`start`](/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) method.
- Adds the following callbacks, which report the status of web page recording:
  - [`web_recorder_started`](/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#70)
  - [`web_recorder_stopped`](/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#71)
  - [`web_recorder_capability_limit`](/en/cloud-recording/cloud_recording_callback_rest?platform=RESTful#72)
  
## 2020.09.16

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

#### Flexible user ID subscription

This release provides a more flexible user ID subscription feature, enabling you to set up a whitelist or blacklist for audio and video subscriptions. You can also update the subscription lists during the cloud recording. For details, see [Set up subscription lists](https://docs.agora.io/en/cloud-recording/cloud_recording_subscription).

#### Callback for high availability

This release adds the [`session_failover`](/en/cloud-recording/cloud_recording_callback_rest#12) event, which occurs when the high availability mechanism is enabled and reports the new recording user ID.

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

The RESTful API adds individual recording mode, which supports recording the audio and video of each user ID separately. See [Individual Recording](/en/cloud_recording/cloud_recording_individual_mode) for details. Meanwhile, Agora provides the Audio & Video File Merging script, which you can use to merge the audio and video files generated in individual mode. See [Merge Audio and Video Files](/en/cloud_recording/cloud_recording_merge_files) for details.

#### 2. Record specified user IDs

The RESTful API adds the `subscribeAudioUids` and `subscribeVideoUids` parameters, which allow you to record only specified user IDs.

#### 3. Customize the directory of the recorded files

The RESTful API adds the `fileNamePrefix` parameter, which allows you to specify the directory where you want to store the recorded files in the third-party cloud storage.

#### 4. Timestamp when the stream state changes

The RESTful API callback service adds the `recorder_audio_stream_state_changed` and `recorder_video_stream_state_changed` events to report the time when the state of the audio or video stream changes, as well as the corresponding user ID.

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