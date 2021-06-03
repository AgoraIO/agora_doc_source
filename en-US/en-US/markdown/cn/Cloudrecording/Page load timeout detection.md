## Introduction

During web page recording,  poor network performance may cause the following issues:

- The web page takes a long time to load, and the load time is not fixed. It is impossible to know the time when the effective recording starts, and important content may be lost.
- The web page fails to load. Because there is no error reporting mechanism, the browser does not reload the page, resulting in a white screen or page content inconsistent with expectations.

In order to solve these issues, the cloud recording service supports **web page loading timeout detection**. During the web page recording process, you need to call the native interface of the browser to notify the browser that the web page has been loaded to achieve the following functions:

- If the browser receives a notification that the web page is loaded before the timeout limit. The browser  starts recording the web page and notifies the developer in time as an event message to ensure the integrity of the recorded content.
- If the browser does not receive a notification that the web page is loaded before the timeout limit,  the browser automatically reloads the web page and tries to restore it and avoid a white screen.

## Implementation

You need to implement the web page load timeout detection function in two steps:

1. When calling the [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) method, set the web page load timeout limit through the `readyTimeout` parameter.
2. Judge for yourself whether the web page is loaded, and call the native interface of the browser to notify the browser when the web page is loaded.

- 
   - If the web page loads before the set timeout limit, the web page recording starts automatically.
   - If the web page lfails to load completely before the set timeout limit, the browser reloads the web page; if the web page fails to load before the timeout limit for a second time , the recording service automatically exits.

### Set the web page load timeout limit

You need to set the web page load timeout limit through the `readyTimeout` parameter when calling the [`start](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api)` method. The parameter settings are as follows:

`readyTimeout`: (optional) Number, set the web page loading timeout limit, in seconds.

- Set to 0 or not set, which means the web page loading status is not detected.
- Set to an integer greater than or equal to 1, which sets the web page load timeout limit.
- Set to less than 0 or a non-integer, which means the setting is incorrect, and error code `2` is received.

### Set the web page loading completion notification interface

You need to call the `notifyReady()` interface on the recording web page to notify the browser that the web page has been loaded successfully.

Sample code:

```
<script>
function notifyReady() {
    if (typeof window.navigator.notifyReady === 'function')
        window.navigator.notifyReady();
}
</script>
```

### RESTful API callback service

- The web page loads successfully
Before the set `readyTimeout` time limit, if the browser receives a notification that the web page has been loaded, it means that the page has been loaded successfully, and the [pageLoadSuccessTime` field is received in the ``web_recorder_started`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name70a70-web_recorder_started) callback.
- The web page fails to load
When the set `readyTimeout` time limit is exceeded, if the browser has not received a notification that the web page is loaded, the browser reloads the page; if it times out for a second time, it means the web page has failed to load. The reason field received in the `web_recorder_reload` callback is `page_load_timeout`, and the recording service automatically exits and receives the[web_recorder_stopped](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name71a71-web_recorder_stopped) callback.