~ff4a0190-9f46-11ec-814c-17df6c7c3801~

<a name="implementation"></a>
### Enabling Cloud Proxy Force UDP and Force TCP Modes from the SDKs

#### Prerequisites

Before enabling the cloud proxy modes in the SDK, ensure you meet the following prerequisites:

1. Your end users have configured their firewalls to trust the Cloud Proxy Allowed IP List (see <a href="#enable">Allowed IP List on Agora Console</a>).
2. You have enabled Cloud Proxy Force UDP and Force TCP modes, either throughn the [Agora Console](https://console.agora.io/) (for capacity Tier 1) or by contacting [Agora Customer Support](mailto:support@agora.io). The status on the Console indicates **Enabled**.
3. You have integrated the SDK and prepared the development environment. For details, see [QuickStart Guide](./start_call_android).

#### Implementation

To enable Force UDP or Force TCP cloud proxy mode, do the following:

1. Before connecting to a channel, call `agora::base::IAgoraParameters::setParameters`:

   ```c++
   // TODO: Wait for dev to support Force UDP and Force TCP options
   setParameters("{\"rtc.enable_proxy\":true}");
   ```

2. Test the audio and video call functionality.

To disable Force UDP or Force TCP cloud proxy mode, call `agora::base::IAgoraParameters::setParameters`:

   ```c++
   setParameters("{\"rtc.enable_proxy\":false}");
   ```

#### Considerations

- Agora recommends that you enable cloud proxy before connecting to the channel or after disconnecting from the channel.
- Force UDP cloud proxy mode does not support pushing streams to the CDN or relaying streams across channels.
