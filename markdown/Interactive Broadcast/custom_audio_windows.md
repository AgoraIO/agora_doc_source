---
title: 自定义音频采集和渲染
platform: Windows
updatedAt: 2021-01-13 09:15:33
---
## 功能介绍

实时音视频传输过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。在以下场景中，你可能会发现默认的音视频模块无法满足开发需求：

- app 中已有自己的音频或视频模块
- 希望使用非 Camera 采集的视频源，如录屏数据
- 需要使用自定义的美颜库或有前处理库
- 某些视频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

基于此，Agora Native SDK 支持使用自定义的音视频源或渲染器，实现相关场景。本文介绍如何实现自定义音频采集和渲染。

## 实现方法

开始自定义采集和渲染前，请确保你已在项目中实现基本的通话或者直播功能，详见[一对一通话](start_call_windows)或[互动直播](start_live_windows)。

### 自定义音频采集

参考如下步骤，在你的项目中实现自定义音频采集功能：

1. `joinChannel` 前，通过调用 `setExternalAudioSource` 指定外部音频采集设备。
2. 指定外部采集设备后，开发者自行管理音频数据采集和处理。
3. 完成音频数据处理后，再通过 `pushAudioFrame` 发送给 SDK 进行后续操作。

**API 时序图**

参考下图时序在你的项目中实现自定义音频采集。

![](https://web-cdn.agora.io/docs-files/1569382218472)

**示例代码**

参考下文代码在你的项目中实现自定义音频采集。

```cpp
// cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);
AParameter apm(*lpAgoraEngine);

// 准备工作，需要实现音频采集模块，以及音频数据队列（用来存放采集出来的数据/或者将要播放的数据）
CAudioPlayPackageQueue	*CAudioPlayPackageQueue::m_lpAudioPackageQueue = NULL;

CAudioPlayPackageQueue::CAudioPlayPackageQueue()
{
  m_bufQueue.Create(32, 8192);
  m_nPackageSize = 8192;
}

CAudioPlayPackageQueue::~CAudioPlayPackageQueue()
{
  m_bufQueue.FreeAllBusyBlock();
  m_bufQueue.Close();
}

CAudioPlayPackageQueue *CAudioPlayPackageQueue::GetInstance()
{
  if (m_lpAudioPackageQueue == NULL)
    m_lpAudioPackageQueue = new CAudioPlayPackageQueue();

  return m_lpAudioPackageQueue;
}

void CAudioPlayPackageQueue::CloseInstance()
{
  if (m_lpAudioPackageQueue == NULL)
    return;

  delete m_lpAudioPackageQueue;
  m_lpAudioPackageQueue = NULL;
}

void CAudioPlayPackageQueue::SetAudioPackageSize(SIZE_T nPackageSize)
{
  _ASSERT(nPackageSize > 0 && nPackageSize <= m_bufQueue.GetBytesPreUnit());

  if (nPackageSize == 0 || nPackageSize > m_bufQueue.GetBytesPreUnit())
    return;

  m_nPackageSize = nPackageSize;
}

void CAudioPlayPackageQueue::SetAudioFormat(const WAVEFORMATEX *lpWaveInfo)
{
  memcpy_s(&m_waveFormat, sizeof(WAVEFORMATEX), lpWaveInfo, sizeof(WAVEFORMATEX));
}

void CAudioPlayPackageQueue::GetAudioFormat(WAVEFORMATEX *lpWaveInfo)
{
  memcpy_s(lpWaveInfo, sizeof(WAVEFORMATEX), &m_waveFormat, sizeof(WAVEFORMATEX));
}

BOOL CAudioPlayPackageQueue::PushAudioPackage(LPCVOID lpAudioPackage, SIZE_T nPackageSize)
{
  if (m_bufQueue.GetFreeCount() == 0)
    m_bufQueue.FreeBusyHead(NULL, 0);

  LPVOID lpBuffer = m_bufQueue.AllocBuffer(FALSE);
  if (lpBuffer == NULL)
    return FALSE;

  _ASSERT(m_bufQueue.GetBytesPreUnit() >= nPackageSize);

  memcpy_s(lpBuffer, m_bufQueue.GetBytesPreUnit(), lpAudioPackage, nPackageSize);

  return TRUE;
}

BOOL CAudioPlayPackageQueue::PopAudioPackage(LPVOID lpAudioPackage, SIZE_T *nPackageSize)
{
  _ASSERT(nPackageSize != NULL);

  if (nPackageSize == NULL)
    return FALSE;

  if (m_bufQueue.GetFreeCount() == 0)
    return FALSE;

  if (*nPackageSize < m_nPackageSize) {
    *nPackageSize = m_nPackageSize;
    return FALSE;
  }

  *nPackageSize = m_nPackageSize;
  m_bufQueue.FreeBusyHead(lpAudioPackage, m_nPackageSize);

  return TRUE;
}

// 实现语音观测器，为采集外部音频源做准备
CExternalAudioFrameObserver::CExternalAudioFrameObserver()
{
}

CExternalAudioFrameObserver::~CExternalAudioFrameObserver()
{
}

bool CExternalAudioFrameObserver::onRecordAudioFrame(AudioFrame& audioFrame)
{
  SIZE_T nSize = audioFrame.channels*audioFrame.samples * 2;
  CAudioCapturePackageQueue::GetInstance()->PopAudioPackage(audioFrame.buffer, &nSize);

  return true;
}

bool CExternalAudioFrameObserver::onPlaybackAudioFrame(AudioFrame& audioFrame)
{
  SIZE_T nSize = audioFrame.channels*audioFrame.samples * 2;
  CAudioPlayPackageQueue::GetInstance()->PushAudioPackage(audioFrame.buffer, nSize);

  return true;
}

bool CExternalAudioFrameObserver::onMixedAudioFrame(AudioFrame& audioFrame)
{
  return true;
}

bool CExternalAudioFrameObserver::onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame)
{
  return true;
}

// 启用外部音频数据源模式，注册音频观测器，我们使用观测器将外部的数据源传递给引擎以及把引擎返回的数据给到应用
int nRet = rep.setExternalAudioSource(true, nSampleRate, nChannels);

agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
mediaEngine.queryInterface(lpAgoraEngine, agora::AGORA_IID_MEDIA_ENGINE);

mediaEngine->registerAudioFrameObserver(lpExternalAudioFrameObserver);

// 开始往引擎推送数据以及从引擎获取数据，通常需要自己维护一个线程循环

CAudioCapturePackageQueue *lpBufferQueue = CAudioCapturePackageQueue::GetInstance();

IAudioFrameObserver::AudioFrame frame;
frame.bytesPerSample = gWaveFormatEx.wBitsPerSample / 8;
frame.channels = gWaveFormatEx.nChannels;
frame.renderTimeMs = 10;
frame.samples = gWaveFormatEx.nSamplesPerSec / 100;
frame.samplesPerSec = gWaveFormatEx.nSamplesPerSec;
frame.type = IAudioFrameObserver::AUDIO_FRAME_TYPE::FRAME_TYPE_PCM16;

  do {
    if (::WaitForSingleObject(lpParam->hExitEvent, 0) == WAIT_OBJECT_0)
    break;

    nAudioBufferSize = 8192;

    if (!lpBufferQueue->PopAudioPackage(lpAudioData, &nAudioBufferSize)) {
      continue;
    }

    frame.buffer = lpAudioData;

    mediaEngine->pushAudioFrame(MEDIA_SOURCE_TYPE::AUDIO_RECORDING_SOURCE, &frame, true);
  } while (TRUE);

// 停止外部音频数据源模式
int nRet = rep.setExternalAudioSource(false, nSampleRate, nChannels);

mediaEngine->registerAudioFrameObserver(NULL);
```

**API 参考**

- [`setExternalAudioSource`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a1dfb925d8ba1a60ca1d9ca04a4d7d65f)
- [`pushAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a2d3bb76cbc7008960166bb292a193616)

### 自定义音频渲染

参考如下步骤，在你的项目中实现自定义音频渲染功能：

1. `joinChannel` 前，通过调用 `setExternalAudioSink` 开启并设置外部音频渲染。
2. 成功加入频道后，调用 `pullAudioFrame` 拉取远端发送的音频数据。
3. 开发者自行渲染并播放拉取到的音频数据。

**API 时序图**

参考下图时序在你的项目中实现自定义音频渲染。

![](https://web-cdn.agora.io/docs-files/1569383001360)

**API 参考**

- [`setExternalAudioSink`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a790b4896f2769c1edebbb49d8912e38b)
- [`pullAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#aaf43fc265eb4707bb59f1bf0cbe01940)

## 注意事项
* 回调函数里处理音频数据要尽量高效，且保证算法稳定，避免影响整个客户端或产生崩溃。
* 需要设置 `RAW_AUDIO_FRAME_OF_MODE_READ_WRITE` 才可以读写和操作数据。
* 自定义音频采集和渲染场景中，需要开发者具有采集或渲染音频数据的能力：

	- 自定义音频采集场景中，你需要自行管理音频数据的采集和处理。
	- 自定义音频渲染场景中，你需要自行管理音频数据的处理和播放。
