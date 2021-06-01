## Introduction

In web page recording scenarios, accidental factors such as network abnormalities may cause the following problems:

- The web page takes a long time to load and the load time is not fixed. It is impossible to know the time when the effective recording starts, and important content may be lost.
- The web page load is unsuccessful. Because there is no error reporting mechanism, the browser will not reload the page, resulting in a white screen or the page content inconsistent with expectations.

In order to solve the above problems, the cloud recording service supports **web page loading timeout detection**. During the web page recording process, you need to call the native interface of browser to notify the browser that the web page has been loaded to achieve the following functions:

- If within the set time, the browser receives a notification that the web page is loaded, it will start recording the web page and notify the developer in time as an event message to ensure the integrity of the recorded content.
- If the browser does not receive a notification that the web page is loaded within the set time, the browser will automatically reload the web page and try to restore it, avoiding a white screen as much as possible.

## Implementation

You need to implement the web page load timeout detection function in two steps:

1. When calling the [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) method, set the web page load timeout time through the `readyTimeout` parameter.
2. Judge by yourself whether the web page is loaded, and call the native interface of browser to notify the browser when the web page is loaded.

- 
   - If the loading is completed within the set timeout period, the web page recording starts automatically.
   - If the loading is not completed within the set timeout period, the browser reloads the web page; if the loading is not completed within the timeout period again, the recording service automatically exists.

### Set the web page load timeout period

You need to set the web page load timeout period through the `readyTimeout` parameter when calling the [`start](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api)` method. The parameter settings are as follows:

`readyTimeout`: (optional) Number, set the web page loading timeout period, in seconds.

- Set to 0 or not set, indicating that the web page loading status will not be detected.
- Set to an integer greater than or equal to 1, indicating the web page load timeout period.
- If set to less than 0 or non-integer, it means the setting is wrong and error code `2` is received.

### Set the web page loading completion notification interface

You need to call the `notifyReady()` interface on the recording web page to notify the browser that the web page is loaded successfully.

The sample code is as follows:

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
Within the set `readyTimeout` time, if the browser receives a notification that the web page has been loaded, it means that the page has been loaded successfully, and the [pageLoadSuccessTime` field is received in the ``web_recorder_started`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name70a70-web_recorder_started) callback.
- The web page failed to load
Within the set `readyTimeout time`, if the browser does not receive a notification that the web page is loaded, the browser reloads the page; if it still times out, it means that the web page has failed to load. The reason field received in the `web_recorder_reload` callback is `page_load_timeout`, and the recording service automatically exits and receives the[web_recorder_stopped](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name71a71-web_recorder_stopped) callback.