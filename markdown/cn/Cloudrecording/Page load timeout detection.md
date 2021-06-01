## 功能描述

页面录制场景下，网络异常等偶然因素可能会造成如下问题：

- 页面加载时间较长且加载时长不固定，无法获知真正开始有效录制的时间点，可能会丢录重要内容。
- 页面加载不成功，由于没有出错上报机制，浏览器端不会重新加载页面，从而导致白屏或页面内容与预期不一致等问题。

为了解决上述问题，云端录制服务支持**页面加载超时检测**。在页面录制过程中，你可以自行调用接口通知浏览器页面加载完成，实现以下功能：

- 若在设定的时间内，浏览器收到页面加载完成的通知，则开始页面录制，并以事件消息的方式及时通知开发者，保证录制内容的完整性。
- 若在设定的时间内，浏览器未收到页面加载完成的通知，则浏览器自动重新加载页面，尝试恢复，尽可能避免出现白屏。

## 实现方法

你需要通过两个步骤实现页面加载超时检测功能：

1. 调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) 方法时通过 `readyTimeout` 参数设置页面加载超时的时间。
2. 自行判断页面是否加载完成，页面加载完成时调用浏览器原生方法通知浏览器。

- - 如果是在设定的超时时间内加载完成，页面录制自动开始。
  - 如果在设定的超时时间没有加载完成，浏览器重新加载页面；如果再次没有在超时时间内加载完成，录制服务自动退出。

### 设置页面加载超时时间

你需要在调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) 方法时通过 `readyTimeout` 参数设置页面加载超时的时间。参数设置如下：

`readyTimeout`：（选填）Number 类型，设置页面加载超时时间，单位为秒。

- 设置为 0 或不设置，表示不检测页面加载状态。
- 设置为大于等于 1 的整数，表示页面加载超时时间。
- 设置为小于 0 或非整数，表示设置错误并收到错误码 `2`。

### 设置页面加载完成通知接口

你需要在录制页面中调用 `notifyReady()` 接口，来通知浏览器页面加载成功。

示例代码如下：

```
<script>
function notifyReady() {
    if (typeof window.navigator.notifyReady === 'function')
        window.navigator.notifyReady();
}
</script>
```

### 回调通知

- 页面加载成功
  在设置的 `readyTimeout` 时间内，浏览器收到页面加载完成的通知，则表示页面加载成功，在[`web_recorder_started`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name70a70-web_recorder_started) 回调中收到 `pageLoadSuccessTime` 字段。
- 页面加载失败
  在设置的 `readyTimeout` 时间内，浏览器未收到页面加载完成的通知，则浏览器重新加载页面；如果仍然超时，则表示页面加载失败，在 `web_recorder_reload` 回调中收到 reason 字段为 `page_load_timeout，同时录制服务自动退出并收到 `[web_recorder_stopped](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#a-name71a71-web_recorder_stopped) 回调。