---
title: 错误码和警告码
platform: Android
updatedAt: 2021-01-25 03:09:37
---

# 错误代码和警告代码

Agora SDK 在调用 API 或运行时，可能会返回错误或警告代码:

- **错误代码** 意味着 SDK 遭遇不可恢复的错误，需要应用程序干预，例如打开摄像头失败会返回错误，应用程序需要提示用户不能使用摄像头。

- **警告代码** 意味着 SDK 遇到问题，但有可能恢复，警告代码仅起告知作用，一般情况下应用程序可以忽略警告代码。

如果 API 调用失败，SDK 也可能会返回一个负数，该负数也是一个错误码，对应着错误代码和警告代码里的正整数。例如返回的错误码为 -2，则对应错误代码和警告代码里的 2: ERR_INVALID_ARGUMENT 。

## 错误代码

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>错误代码</strong></td>
<td><strong>值</strong></td>
<td><strong>描述</strong></td>
</tr>
<tr><td>ERR_OK</td>
<td>0</td>
<td>没有错误</td>
</tr>
<tr><td>ERR_FAILED</td>
<td>1</td>
<td>一般性的错误（没有明确归类的错误原因）</td>
</tr>
<tr><td>ERR_INVALID_ARGUMENT</td>
<td>2</td>
<td>API 调用了无效的参数。例如指定的频道名含有非法字符</td>
</tr>
<tr><td>ERR_NOT_READY</td>
<td>3</td>
<td><p>RTC 初始化失败。处理方法：</p>
<div><ul>
<li>检查音频设备状态</li>
<li>检查程序集完整性</li>
<li>尝试重新初始化 RTC</li>
</ul>
</div>
</td>
</tr>
<tr><td>ERR_NOT_SUPPORTED</td>
<td>4</td>
<td>RTC 当前状态禁止此操作，因此不能进行此操作</td>
</tr>
<tr><td>ERR_REFUSED</td>
<td>5</td>
<td>调用被拒绝。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_BUFFER_TOO_SMALL</td>
<td>6</td>
<td>传入的缓冲区大小不足以存放返回的数据</td>
</tr>
<tr><td>ERR_NOT_INITIALIZED</td>
<td>7</td>
<td>SDK 尚未初始化，就调用其 API。请确认在调用 API 之前已创建 RtcEngine 对象并完成初始化</td>
</tr>
<tr><td>ERR_NO_PERMISSION</td>
<td>9</td>
<td>没有操作权限，仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_TIMEDOUT</td>
<td>10</td>
<td>API 调用超时。有些 API 调用需要 SDK 返回结果，如果 SDK 处理事件过程，会出现此错误</td>
</tr>
<tr><td>ERR_CANCELED</td>
<td>11</td>
<td>请求被取消。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_TOO_OFTEN</td>
<td>12</td>
<td>调用频率太高。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_BIND_SOCKET</td>
<td>13</td>
<td>SDK 内部绑定到网络 Socket 失败。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_NET_DOWN</td>
<td>14</td>
<td>网络不可用。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_NET_NOBUFS</td>
<td>15</td>
<td>没有网络缓冲区可用。仅供 SDK 内部使用，不通过 API 或者回调事件返回给应用程序</td>
</tr>
<tr><td>ERR_JOIN_CHANNEL_REJECTED</td>
<td>17</td>
<td><p>加入频道被拒绝。一般有以下原因：</p>
<div><ul>
<li>用户已进入频道，再次调用加入频道的 API，例如 <code>joinChannel</code>，会返回此错误。停止调用该 API 即可</li>
<li>用户在做 Echo 测试时尝试加入频道。等待 Echo test 结束后再加入频道即可</li>
</ul>
</div>
</td>
</tr>
<tr><td>ERR_LEAVE_CHANNEL_REJECTED</td>
<td>18</td>
<td><p>离开频道失败。一般有以下原因：</p>
<div><ul>
<li>用户已离开频道，再次调用退出频道的 API，例如 <code>leaveChannel</code>，会返回此错误。停止调用该 API 即可</li>
<li>用户尚未加入频道，就调用退出频道的 API。这种情况下无需额外操作</li>
</ul>
</div>
</td>
</tr>
<tr><td>ERR_ALREADY_IN_USE</td>
<td>19</td>
<td>资源已被占用，不能重复使用</td>
</tr>
<tr><td>ERR_ABORTED</td>
<td>20</td>
<td>SDK 放弃请求，可能由于请求次数太多。仅供 SDK 内部使用，不通过 API 或者回调时间返回给应用程序</td>
</tr>
<tr><td>ERR_INIT_NET_ENGINE</td>
<td>21</td>
<td>Windows 下特定的防火墙设置导致 SDK 初始化失败然后崩溃</td>
</tr>
<tr><td>ERR_INVALID_VENDOR_KEY</td>
<td>101</td>
<td>不是有效的 App ID。请更换有效的 App ID 重新加入频道</td>
</tr>
<tr><td>ERR_INVALID_CHANNEL_NAME</td>
<td>102</td>
<td>不是有效的频道名。请更换有效的频道名重新加入频道</td>
</tr>
<tr><td>ERR_CHANNEL_KEY_EXPIRED</td>
<td>109</td>
<td><p>当前使用的 Token 过期，不再有效。一般有以下原因：</p>
<div><ul>
<li>Token 授权时间戳无效：Token 授权时间戳为 Token 生成时的时间戳，自 1970 年 1 月 1 日开始到当前时间的描述。授权该 Token 在生成后的 24 小时内可以访问 Agora 服务。如果 24 小时内没有访问，则该 Token 无法再使用。需要重新在服务端申请生成 Token</li>
<li>Token 服务到期时间戳已过期：用户设置的服务到期时间戳小于当前时间戳，无法继续使用 Agora 服务（比如正在进行的通话会被强制终止）；设置服务到期时间并不意味着 Token 失效，而仅仅用于限制用户使用当前服务的时间。需要重新在服务端申请生成 Token</li>
</ul>
</div>
</td>
</tr>
<tr><td>ERR_INVALID_CHANNEL_KEY</td>
<td>110</td>
<td><p>生成的 Token 无效，一般有以下原因：</p>
<div><ul>
<li>用户在 Dashboard 上启用了 App Certificate，但仍旧在代码里仅使用了 App ID。当启用了 App Certificate，必须使用 Token</li>
<li>字段 uid为生成 Token 的必须字段，用户在调用<code>joinChannel</code> 加入频道时必须设置相同的 uid</li>
</ul>
</div>
</td>
</tr>
<tr><td>ERR_CONNECTION_INTERRUPTED</td>
<td>111</td>
<td>网络连接中断。仅适用于 Agora Web SDK</td>
</tr>
<tr><td>ERR_CONNECTION_LOST</td>
<td>112</td>
<td>网络连接丢失。仅适用于 Agora Web SDK</td>
</tr>
<tr><td>ERR_NOT_IN_CHANNEL</td>
<td>113</td>
<td>用户不在频道内</td>
</tr>
<tr><td>ERR_SIZE_TOO_LARGE</td>
<td>114</td>
<td>数据太大</td>
</tr>
<tr><td>ERR_BITRATE_LIMIT</td>
<td>115</td>
<td>码率受限</td>
</tr>
<tr><td>ERR_TOO_MANY_DATA_STREAMS</td>
<td>116</td>
<td>数据流/通道过多</td>
</tr>
<tr><td>ERR_STREAM_MESSAGE_TIMEOUT</td>
<td>117</td>
<td>数据流发送超时</td>
</tr>
<tr><td>ERR_SET_CLIENT_ROLE_NOT_AUTHORIZED</td>
<td>119</td>
<td>切换角色失败。请尝试重新加入频道</td>
</tr>
<tr><td>ERR_DECRYPTION_FAILED</td>
<td>120</td>
<td>解密失败，可能是用户加入频道用了不同的密码。请检查加入频道时的设置，或尝试重新加入频道</td>
</tr>
<tr><td>ERR_CLIENT_IS_BANNED_BY_SERVER</td>
<td>123</td>
<td>此用户被服务器禁止</td>
</tr>
<tr><td>ERR_WATERMARK_PARAM</td>
<td>124</td>
<td>水印文件参数错误</td>
</tr>
<tr><td>ERR_WATERMARK_PATH</td>
<td>125</td>
<td>水印文件路径错误</td>
</tr>
<tr><td>ERR_WATERMARK_PNG</td>
<td>126</td>
<td>水印文件格式错误</td>
</tr>
<tr><td>ERR_WATERMARKR_INFO</td>
<td>127</td>
<td>水印文件信息错误</td>
</tr>
<tr><td>ERR_WATERMARK_ARGB</td>
<td>128</td>
<td>水印文件数据格式错误</td>
</tr>
<tr><td>ERR_WATERMARK_READ</td>
<td>129</td>
<td>水印文件读取错误</td>
</tr>
<tr><td>ERR_LOAD_MEDIA_ENGINE</td>
<td>1001</td>
<td>加载媒体引擎失败</td>
</tr>
<tr><td>ERR_START_CALL</td>
<td>1002</td>
<td>启动媒体引擎开始通话失败。请尝试重新进入频道</td>
</tr>
<tr><td>ERR_START_CAMERA</td>
<td>1003</td>
<td>启动摄像头失败，请检查摄像头是否被其他应用占用，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_START_VIDEO_RENDER</td>
<td>1004</td>
<td>启动视频渲染模块失败</td>
</tr>
<tr><td>ERR_ADM_GENERAL_ERROR</td>
<td>1005</td>
<td>音频设备模块：音频初始化失败。请检查音频设备是否被其他应用占用，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_JAVA_RESOURCE</td>
<td>1006</td>
<td>音频设备模块：使用 java 资源出现错误</td>
</tr>
<tr><td>ERR_ADM_SAMPLE_RATE</td>
<td>1007</td>
<td>音频设备模块：设置的采样频率出现错误</td>
</tr>
<tr><td>ERR_ADM_INIT_PLAYOUT</td>
<td>1008</td>
<td>音频设备模块：初始化播放设备出现错误。请检查播放设备是否被其他应用占用，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_START_PLAYOUT</td>
<td>1009</td>
<td>音频设备模块：启动播放设备出现错误。请检查播放设备是否正常，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_STOP_PLAYOUT</td>
<td>1010</td>
<td>音频设备模块：停止播放设备出现错误</td>
</tr>
<tr><td>ERR_ADM_INIT_RECORDING</td>
<td>1011</td>
<td>音频设备模块：初始化录音设备时出现错误。请检查录音设备是否正常，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_START_RECORDING</td>
<td>1012</td>
<td>音频设备模块：启动录音设备出现错误。请检查录音设备是否正常，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_STOP_RECORDING</td>
<td>1013</td>
<td>音频设备模块：停止录音设备出现错误</td>
</tr>
<tr><td>ERR_ADM_RUNTIME_PLAYOUT_ERROR</td>
<td>1015</td>
<td>音频设备模块：运行时播放出现错误。请检查录音设备是否正常，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_RUNTIME_RECORDING_ERROR</td>
<td>1017</td>
<td>音频设备模块：运行时录音错误。请检查录音设备是否正常，或者尝试重新进入频道</td>
</tr>
<tr><td>ERR_ADM_RECORD_AUDIO_FAILED</td>
<td>1018</td>
<td>音频设备模块：录音失败</td>
</tr>
<tr><td>ERR_ADM_INIT_LOOPBACK</td>
<td>1022</td>
<td>音频设备模块：初始化 Loopback 设备错误</td>
</tr>
<tr><td>ERR_ADM_START_LOOPBACK</td>
<td>1023</td>
<td>音频设备模块：启动 Loopback 设备错误</td>
</tr>
<tr><td>ERR_ADM_NO_PERMISSION</td>
<td>1027</td>
<td>音频设备模块：没有录音权限。请检查是否已经打开权限允许录音</td>
</tr>
<tr><td>ERR_ADM_NO_RECORDING_DEVICE</td>
<td>1359</td>
<td>音频设备模块：无录制设备。请检查是否有可用的录放音设备或者录放音设备是否已经被其他应用占用</td>
</tr>
<tr><td>ERR_ADM_NO_PLAYOUT_DEVICE</td>
<td>1360</td>
<td>音频设备模块：无播放设备</td>
</tr>
<tr><td>ERR_VDM_CAMERA_NOT_AUTHORIZED</td>
<td>1501</td>
<td>视频设备模块：没有摄像头使用权限。请检查是否已经打开摄像头权限</td>
</tr>
<tr><td>ERR_VCM_UNKNOWN_ERROR</td>
<td>1600</td>
<td>视频设备模块：未知错误</td>
</tr>
<tr><td>ERR_VCM_ENCODER_INIT_ERROR</td>
<td>1601</td>
<td>视频设备模块：视频 Codec 初始化错误。该错误为严重错误，请尝试重新加入频道</td>
</tr>
<tr><td>ERR_VCM_ENCODER_ENCODE_ERROR</td>
<td>1602</td>
<td>视频设备模块：视频 Codec 错误。该错误为严重错误，请尝试重新加入频道</td>
</tr>
<tr><td>ERR_VCM_ENCODER_SET_ERROR</td>
<td>1603</td>
<td>视频设备模块：视频 Codec 设置错误</td>
</tr>
</tbody>
</table>

## 警告代码

<table>
<colgroup>
<col/>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td><strong>警告代码</strong></td>
<td><strong>值</strong></td>
<td><strong>描述</strong></td>
</tr>
<tr><td>WARN_INVALID_VIEW</td>
<td>8</td>
<td>指定的view无效，使用视频功能时需要指定 view，如果 view>尚未指定，则用户看不到视频画面，并返回该警告</td>
</tr>
<tr><td>WARN_INIT_VIDEO</td>
<td>16</td>
<td>初始化视频功能失败。用户无法看到视频画面，但不影响语音通信。有可能是因视频资源被占用导致的</td>
</tr>
<tr><td>WARN_NO_AVAILABLE_CHANNEL</td>
<td>103</td>
<td>没有可用的频道资源。可能是因为服务端没法分配频道资源。如出现警告，一般无法进行通话</td>
</tr>
<tr><td>WARN_LOOKUP_CHANNEL_TIMEOUT</td>
<td>104</td>
<td>查找频道超时。在加入频道时 SDK 先要查找指定的频道，出现该警告一般是因为网络太差，连接不到服务器。网络条件改善时，可自动恢复通话</td>
</tr>
<tr><td>WARN_LOOKUP_CHANNEL_REJECTED</td>
<td>105</td>
<td>查找频道请求被服务器拒绝。服务器可能没有办法处理这个请求或请求是非法的。一般不会出现该警告。如果出现请尝试退出后重新进入频道</td>
</tr>
<tr><td>WARN_OPEN_CHANNEL_TIMEOUT</td>
<td>106</td>
<td>打开频道超时。查找到指定频道后，SDK 接着打开该频道，超时一般是因为网络太差，连接不到服务器。网络条件改善时，可自动恢复通话</td>
</tr>
<tr><td>WARN_OPEN_CHANNEL_REJECTED</td>
<td>107</td>
<td>打开频道请求被服务器拒绝。服务器可能没有办法处理该请求或该请求是非法的。一般不会出现干警告。如果出现请尝试退出后重新进入频道</td>
</tr>
<tr><td>WARN_SET_CLIENT_ROLE_TIMEOUT</td>
<td>118</td>
<td>直播模式下设置用户模式超时。出现该警告无法自动恢复通话</td>
</tr>
<tr><td>WARN_SET_CLIENT_ROLE_NOT_AUTHORIZED</td>
<td>119</td>
<td>直播模式下用户模式未授权。出现该警告无法自动恢复通话</td>
</tr>
<tr><td>WARN_OPEN_CHANNEL_INVALID_TICKET</td>
<td>121</td>
<td>App ID 或动态密钥非法，打开频道失败。请检查 App ID 或动态密钥是否有效，如果无效，请重新获取或生成后，重新进入频道</td>
</tr>
<tr><td>WARN_OPEN_CHANNEL_TRY_NEXT_VOS</td>
<td>122</td>
<td>该警告表示正在换一个服务器重新登录。登录成功后可自动恢复通话</td>
</tr>
<tr><td>WARN_AUDIO_MIXING_OPEN_ERROR</td>
<td>701</td>
<td>打开伴奏出错。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_RUNTIME_PLAYOUT_WARNING</td>
<td>1014</td>
<td>音频设备模块：运行时播放设备出现警告。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_RUNTIME_RECORDING_WARNING</td>
<td>1016</td>
<td>音频设备模块：运行时录音设备出现警告。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_RECORD_AUDIO_SILENCE</td>
<td>1019</td>
<td>音频设备模块：没有采集到有效的声音数据。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_RECORD_AUDIO_LOWLEVEL</td>
<td>1031</td>
<td>音频设备模块：录到的声音太低。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_PLAYOUT_AUDIO_LOWLEVEL</td>
<td>1032</td>
<td>音频设备模块：播放的声音太低。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_RECORD_IS_OCCUPIED</td>
<td>1033</td>
<td>音频设备模块：录制设备被占用。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_APM_HOWLING</td>
<td>1051</td>
<td>音频设备模块：录音声音异常。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_GLITCH_STATE</td>
<td>1052</td>
<td>音频设备模块：音频播放会卡顿。该警告不影响正常通话</td>
</tr>
<tr><td>WARN_ADM_IMPROPER_SETTINGS</td>
<td>1053</td>
<td>音频设备模块：音频底层设置被修改。该警告不影响正常通话</td>
</tr>
</tbody>
</table>
