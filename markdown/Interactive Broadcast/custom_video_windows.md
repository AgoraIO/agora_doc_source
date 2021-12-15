---
title: 自定义视频采集和渲染
platform: Windows
updatedAt: 2021-01-12 10:03:39
---

## 功能介绍

实时通信过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。如果想要在客户端实现自定义音视频采集和渲染，则可以使用自定义的音视频源或渲染器，来进行实现。

**自定义采集和渲染**主要适用于以下场景：

- 当 SDK 内置的音视频源不能满足开发者需求时，比如需要使用自定义的美颜库或前处理库
- 开发者的 App 中已有自己的音频或视频模块，为了复用代码，也可以自定义音视频源
- 开发者希望使用非 Camera 采集的视频源，如录屏数据
- 有些系统独占的视频采集设备，为避免与其他业务产生冲突，需要灵活的设备管理策略

## 实现方法

在开始自定义采集和渲染前，请确保你已完成环境准备、安装包获取等步骤，详见 [集成客户端](./windows_video)。

### 使用外部音频数据源

```cpp
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

### 使用外部视频数据源

在 Windows 平台上实现外部视频源，需要使用私有接口 [`setParameters`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_parameter.html#adde9cb68e2ef2216d7fd1976fd5f1d75) 。具体的用法和实现详见示例代码。

```cpp
// 准备工作，需要实现视频采集模块，以及视频数据队列（用来存放采集出来的数据/或者将要渲染的数据）
CVideoPackageQueue *CVideoPackageQueue::m_lpVideoPackageQueue = NULL;

CVideoPackageQueue::CVideoPackageQueue()
{
	m_nPackageSize = 0;
	m_nBufferSize = 0x800000;
	m_bufQueue.Create(32, 0x800000);
}

CVideoPackageQueue::~CVideoPackageQueue()
{
	m_bufQueue.FreeAllBusyBlock();
	m_bufQueue.Close();
}

CVideoPackageQueue *CVideoPackageQueue::GetInstance()
{
	if (m_lpVideoPackageQueue == NULL)
		m_lpVideoPackageQueue = new CVideoPackageQueue();

	return m_lpVideoPackageQueue;
}

void CVideoPackageQueue::CloseInstance()
{
	if (m_lpVideoPackageQueue == NULL)
		return;

	delete m_lpVideoPackageQueue;
	m_lpVideoPackageQueue = NULL;
}

void CVideoPackageQueue::SetVideoFormat(const BITMAPINFOHEADER *lpInfoHeader)
{
  memcpy_s(&m_bmiHeader, sizeof(BITMAPINFOHEADER), lpInfoHeader, sizeof(BITMAPINFOHEADER));

  m_nPackageSize = m_bmiHeader.biWidth*m_bmiHeader.biWidth * 3 / 2;
  _ASSERT(m_nPackageSize <= m_nBufferSize);
}

void CVideoPackageQueue::GetVideoFormat(BITMAPINFOHEADER *lpInfoHeader)
{
  memcpy_s(lpInfoHeader, sizeof(BITMAPINFOHEADER), &m_bmiHeader, sizeof(BITMAPINFOHEADER));
}

BOOL CVideoPackageQueue::PushVideoPackage(LPCVOID lpVideoPackage, SIZE_T nPackageLen)
{
  if (m_bufQueue.GetFreeCount() == 0)
    m_bufQueue.FreeBusyHead(NULL, 0);

  LPVOID lpBuffer = m_bufQueue.AllocBuffer(FALSE);
  if (lpBuffer == NULL)
    return FALSE;

  _ASSERT(m_bufQueue.GetBytesPreUnit() >= nPackageLen);

  memcpy_s(lpBuffer, m_bufQueue.GetBytesPreUnit(), lpVideoPackage, nPackageLen);

  return TRUE;
}

BOOL CVideoPackageQueue::PopVideoPackage(LPVOID lpVideoPackage, SIZE_T *nPackageSize)
{
  _ASSERT(nPackageSize != NULL);

  if (nPackageSize == 0)
    return FALSE;

  if (m_bufQueue.GetBusyCount() == 0)
    return FALSE;

  if (*nPackageSize < m_nPackageSize) {
    *nPackageSize = m_nPackageSize;
    return FALSE;
  }

  *nPackageSize = m_nPackageSize;
  m_bufQueue.FreeBusyHead(lpVideoPackage, m_nPackageSize);

  return TRUE;
}

// 实现视频观测器，为采集外部视频源做准备
CExternalVideoFrameObserver::CExternalVideoFrameObserver()
{
  m_lpImageBuffer = new BYTE[0x800000];
}

CExternalVideoFrameObserver::~CExternalVideoFrameObserver()
{
  delete[] m_lpImageBuffer;
}

bool CExternalVideoFrameObserver::onCaptureVideoFrame(VideoFrame& videoFrame)
{
  SIZE_T nBufferSize = 0x800000;

  BOOL bSuccess = CVideoPackageQueue::GetInstance()->PopVideoPackage(m_lpImageBuffer, &nBufferSize);
  if (!bSuccess)
    return false;

  m_lpY = m_lpImageBuffer;
  m_lpU = m_lpImageBuffer + videoFrame.height*videoFrame.width;
  m_lpV = m_lpImageBuffer + 5 * videoFrame.height*videoFrame.width / 4;

  memcpy_s(videoFrame.yBuffer, videoFrame.height*videoFrame.width, m_lpY, videoFrame.height*videoFrame.width);
  videoFrame.yStride = videoFrame.width;

  memcpy_s(videoFrame.uBuffer, videoFrame.height*videoFrame.width / 4, m_lpU, videoFrame.height*videoFrame.width / 4);
  videoFrame.uStride = videoFrame.width/2;

  memcpy_s(videoFrame.vBuffer, videoFrame.height*videoFrame.width / 4, m_lpV, videoFrame.height*videoFrame.width / 4);
  videoFrame.vStride = videoFrame.width/2;

  videoFrame.type = FRAME_TYPE_YUV420;
  videoFrame.rotation = 0;

  return true;
}

bool CExternalVideoFrameObserver::onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame)
{
  return true;
}

// 启用外部视频数据源模式，注册视频观测器，我们使用观测器将外部的数据源传递给引擎以及把引擎返回的数据给到应用
agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
mediaEngine.queryInterface(lpAgoraEngine, agora::AGORA_IID_MEDIA_ENGINE);

int mRet = apm->setParameters("{\"che.video.local.camera_index\":1024}");
nRet = mediaEngine->registerVideoFrameObserver(lpVideoFrameObserver);

// 开始往引擎推送数据以及从引擎获取数据，通常需要自己维护一个线程循环
lpPackageQueue->PushVideoPackage(m_lpYUVBuffer, nYUVSize); // push to Agora SDK

// 停止外部视频数据源模式
nRet = apm->setParameters("{\"che.video.local.camera_index\":0}");

mediaEngine->registerVideoFrameObserver(NULL);


```

## 注意事项

- 回调函数里处理音视频数据要尽量高效，且保证算法稳定，避免影响整个客户端或产生崩溃。
- 音频部分需要设置 `RAW_AUDIO_FRAME_OF_MODE_READ_WRITE` 才可以读写和操作数据。
- 自定义渲染实现，也是使用裸数据接口，不调用 `setupRemoteVideo` 就可以不使用 SDK 渲染。自定义渲染要注意 Windows 平台的兼容性。
- 客户端自定义采集和渲染属于较复杂的功能，开发者自身需要具备音视频相关知识，能够自己独立开发完成采集与渲染。
